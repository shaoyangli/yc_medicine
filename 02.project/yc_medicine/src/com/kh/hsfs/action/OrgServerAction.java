package com.kh.hsfs.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.kh.hsfs.dao.OrgServerDao;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.hsfs.model.HsfsOrgServFile;
import com.kh.hsfs.model.HsfsOrgServInfo;
import com.kh.util.FileConvert;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

public class OrgServerAction extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {
	private String year;
	private OrgServerDao orgServerDao;
	private List serverType;// 服务类型集合
	private List checkIndexs;//
	private String typeCode;

	private String orgCode;// 机构编码
	private String orgName;
	private String serviceType;// 考核服务类型
	private String checkIndex;// 考核指标编码
	private String serverDate;// 服务时间
	private String buryear;// 年度
	private String serInfo;// 服务说明
	private String param;

	private File file;
	private String fileFileName;
	private String fileFileContentType;

	private int isSuccess;

	private HttpServletRequest request;
	private HttpServletResponse response;

	private HsfsOrgServInfo orgServInfo;// 医疗机构服务记录基本信息
	private HsfsOrgServFile orgServFile = new HsfsOrgServFile();// 医疗机构服务上传文件的信息

	private PageUtil pages;
	private int currPage;// 当前页
	private int totalPages;// 总页数

	private List<Integer> deleteList;
	private List<HsfsOrgServFile> list;
	private int id;// 服务无记录的主键
	private String fileUrl;
	private int fileId;
	private String userName;
	private String filename;// 下载用户要看到的文件的名字
	private int saveResult;// 保存结果
	private int checkFileResult;// 检查文件是否存在 0表示存在 1表示不存在
	private String delids;
	private String message;
	private String count = "";

	/*
	 * 初始化服务类型
	 */
	public String findServiceType() throws Exception {
		String sql = "select code,name from hsfs_servtype_setting t where buryear = '"
				+ year + "'";
		serverType = orgServerDao.getBysql(sql);
		return "findServiceType";
	}

	/*
	 * 初始化考核指标
	 */
	public String findCheckIndex() throws Exception {
		String sql = "select check_code,check_index from hsfs_check_setting where item_code = '"
				+ typeCode + "' and buryear = '" + year + "'";
		checkIndexs = orgServerDao.getBysql(sql);
		return "findCheckIndex";
	}

	/*
	 * 保存机构服务记录 此方法要完成两步操作 1.要对记录的基本信息的保存 2.该记录的主键关联到文件表里
	 */
	public String saveOrgService() throws Exception {
		isSuccess = orgServerDao.saveOrgServ(orgServInfo, count);// 保存服务记录的基本信息
		return "removeOrgService";
	}

	/*
	 * 查询医疗机构服务记录
	 */
	public String findOrgService() throws Exception {
		String sql = "select id,(select org_name from hsfs_org_base_info where org_code = t.org_code) orgname,"
				+ "(select NAME from hsfs_servtype_setting where code = t.serv_type and buryear = "
				+ year
				+ ") servtype,"
				+ "(select check_index from hsfs_check_setting where item_code = t.serv_type and check_code = t.check_code and buryear = "
				+ year
				+ ") check_index,"
				+ "nvl(t.serv_info,' ') serv_info,t.serv_date,t.state from hsfs_org_serv_info t,hsfs_org_base_info k where t.org_code = k.org_code and k.org_areaid like '"
				+ param + "%' and t.buryear = " + year;
		if (!serviceType.equals("0")) {
			sql += " and t.serv_type = " + serviceType;
		}
		if (!checkIndex.equals("0")) {
			sql += " and t.check_code = " + checkIndex;
		}
		if(!orgCode.equals("") && orgCode != null && !orgCode.equals("null")) {
			sql += " and t.org_code = '" + orgCode + "' ";
		}
		sql += " order by  k.org_areaid asc ,t.serv_date desc,id desc";
		//System.out.println(sql);
		int row = 10;// 每页显示记录数
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		pages = orgServerDao.findOrgServ(currPage, row, sql);

		return "findOrgService";
	}

	/**
	 *删除之前要做判断是否属于当前登录机构上传的记录以及 该条记录是否被提交.满足条件 才可以删除
	 */
	public String beforedel() throws Exception {
		// 5.7 gcl 判断是否有申请过的 不能删除
		String orgCode = ((HsfsOrgBaseInfo) ServletActionContext.getRequest()
				.getSession().getAttribute("org")).getOrgCode();
		String sql = "select (select check_index from hsfs_check_setting where  CHECK_CODE=t.check_code and item_code=t.SERV_TYPE ) check_index "
				+ "from hsfs_org_serv_info t where state=1 and ID in ("
				+ delids + ")";
		String sql1 = "select (select check_index from hsfs_check_setting where  CHECK_CODE=t.check_code and item_code=t.SERV_TYPE ) check_index"
				+ " from hsfs_org_serv_info t where ID in ("
				+ delids
				+ ") and org_code !=" + orgCode;
		List list = orgServerDao.getBysql(sql);
		List list1 = orgServerDao.getBysql2(sql1);
		serInfo = "";
		param = "";
		if (list.size() > 0) {
			for (int j = 0; j < list.size(); j++) {
				serInfo += ((List) list.get(j)).get(0).toString() + ",";
			}
		}
		for (int i = 0; i < list1.size(); i++) {
			param += list1.get(i).toString() + ",";
		}
		return "removeOrgService";
	}

	/*
	 * 删除服务记录
	 */
	public String removeOrgService() throws Exception {
		for (int i : deleteList) {
			orgServerDao.removeOrgService(i);
		}
		return "removeOrgService";
	}

	/*
	 * 查询单个服务记录对应的上传文件
	 */
	public String findSingleOrgServce() throws Exception {
		list = orgServerDao.findOrgServFiles(id);
		// 得到第一个文件的路径,并转化文件
		orgServFile = list.get(0);
		// fileUrl = orgServFile.getFilePath();
		// String url =
		// request.getSession().getServletContext().getRealPath("/");
		// File file = new File(url + fileUrl);
		// if (file.exists()) {
		// boolean trunresult = turnType(fileUrl, url);// 转化文件类型
		// if (trunresult) {
		// int index = fileUrl.lastIndexOf(".");
		// fileUrl = fileUrl.substring(0, index) + ".swf";
		// orgServFile.setFilePath(fileUrl);
		// }
		// } else {
		// orgServFile.setFilePath("upload/error.swf");
		// }

		return "findSingleOrgServce";
	}

	/*
	 * 切换文件列表显示内容查询
	 */
	public String findOrgServiceFile() throws Exception {
		orgServFile = orgServerDao.findNextOrgServFile(fileId);
		System.out.println(orgServFile.getFileName());
		String filePath = orgServFile.getFilePath();
		String url = request.getSession().getServletContext().getRealPath("/");
		File file = new File(url + filePath);
		if (file.exists()) {
			if (turnType(filePath, url)) {
				int index = filePath.lastIndexOf(".");
				fileUrl = filePath.substring(0, index) + ".swf";
				orgServFile.setFilePath(fileUrl);
			} else {
				orgServFile.setFilePath("upload/error.swf");
			}
		}
		// 转化不成功显示错误信息
		else {
			orgServFile.setFilePath("upload/error.swf");
		}
		return "findOrgServiceFile";
	}

	/*
	 * 验证文件是否存在
	 */

	public String checkFileExist() throws Exception {
		orgServFile = orgServerDao.findNextOrgServFile(fileId);
		String filePath = orgServFile.getFilePath();
		String url = request.getSession().getServletContext().getRealPath("/");
		File file = new File(url + filePath);
		if (file.exists()) {
			checkFileResult = 0;// 文件存在赋值0
		} else {
			checkFileResult = 1;// 不存在赋值1
		}
		return "checkFileExist";
	}

	/*
	 * 文件下载
	 */

	// @JSON(serialize = false)
	// public InputStream getDownloadFile() throws Exception {
	// orgServFile = orgServerDao.findNextOrgServFile(fileId);
	//
	// // 用户要看到的文件名字
	// String url = request.getSession().getServletContext().getRealPath("/");
	// String path = url + orgServFile.getFilePath();
	// File file = new File(path);
	// if (file.exists()) {
	// try {
	// filename = new String(
	// orgServFile.getFileName().getBytes("gbk"), "8859_1");// 处理下载时候中文乱码的问题
	// response.setContentLength((int) file.length());// 下载进度条显示
	// ServletActionContext.getServletContext().getResourceAsStream(
	// orgServFile.getFilePath());
	// return ServletActionContext.getServletContext()
	// .getResourceAsStream(orgServFile.getFilePath());
	//
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// return null;
	// } else {
	// // response.sendRedirect("hsfs/org/orgServerMore.jsp");
	// return null;
	// }
	//
	// }
	public String downFile() throws Exception {
		orgServFile = orgServerDao.findNextOrgServFile(fileId);
		String url = request.getSession().getServletContext().getRealPath("/");
		String path = url + orgServFile.getFilePath();
		File downloadFile = new File(path);
		String filesname = orgServFile.getFileName();

		BufferedInputStream br = new BufferedInputStream(new FileInputStream(
				downloadFile));
		byte[] buf = new byte[4096];
		int len = 0;
		HttpServletResponse response = ServletActionContext.getResponse();
		response.reset();
		// response.setContentType("application/x-msdownload");
		response.setCharacterEncoding("gbk");
		response.setHeader("Content-Disposition", "attachment;filename="
				+ new String(filesname.getBytes("gb2312"), "ISO8859-1"));
		response.setContentLength((int) downloadFile.length());// 下载显示进度条
		OutputStream out = response.getOutputStream();
		while ((len = br.read(buf)) > 0)
			out.write(buf, 0, len);
		br.close();
		out.close();
		response.flushBuffer();
		return null; // 成功
	}

	/*
	 * 文件类型转化方法
	 */
	private boolean turnType(String fileString, String fileTomcat) {
		FileConvert file = new FileConvert();
		return file.convert(fileString, fileTomcat);
	}

	/*
	 * 上传文件
	 */

	public String uploadFile() throws Exception {
		isSuccess = saveFiles();
		return "uploadFile";
	}

	public String removeFujian() throws Exception {
		isSuccess = orgServerDao.removeFujian(id);
		return "removeOrgService";
	}

	private int saveFiles() {
		String url = request.getSession().getServletContext().getRealPath("/")
				+ "upload";
		// 1.先完成文件的上传
		File f = file;
		if (f.length() / (1024 * 1024) > 50) {
			
			message = "上传文件大于50M";
			return 1;
		} else {
			try {
				InputStream is = new FileInputStream(f);
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
				String nowTime = df.format(new Date());// 构造成当前时间
				int index = fileFileName.lastIndexOf(".");// 源文件到倒数第一个"."在哪里
				String ext = fileFileName.substring(index + 1);// 取得后缀，及"."后面的字符
				String newFileName = nowTime + "." + ext;
				File newFile = new File(url, newFileName);
				OutputStream os = new FileOutputStream(newFile);
				byte[] buffer = new byte[1000];

				int length = 0;

				while (-1 != (length = is.read(buffer))) {
					os.write(buffer, 0, length);

				}
				is.close();
				os.close();
				String filename = fileFileName.substring(0, index);
				if (filename.getBytes().length > 60) { // gcl 5.9 截取长度
					filename = OrgServerAction.bSubstring(filename, 60);
				}
				HsfsOrgServFile ff = new HsfsOrgServFile();
				ff.setFileName(filename + "." + ext);
				ff.setFileType(ext);
				ff.setFilePath("upload/" + newFileName);

				int t = orgServerDao.SaveOrgServFile(ff);
				if (t > 0) {
					id = t;
					return 0;
				} else {
					message = "附件上传失败";
					return 1;
				}
			} catch (Exception e) {
				e.printStackTrace();
				message = "附件上传失败...";
				return 1;
			}
		}

	}

	public static String bSubstring(String s, int length) throws Exception {
		byte[] bytes = s.getBytes("Unicode");
		int n = 0; // 暗示当前的字节数
		int i = 2; // 要进取的字节数，年夜第3个字节起头
		for (; i < bytes.length && n < length; i++) {
			// 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
			if (i % 2 == 1) {
				n++; // 在UCS2第二个字节时n加1
			}

			else

			{

				// 当UCS2编码的第一个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
				if (bytes[i] != 0) {
					n++;
				}
			}
		}
		// 如不美观i为奇数时，措置成偶数
		if (i % 2 == 1) {
			// 该UCS2字符是汉字时，去失踪这个截一半的汉字
			if (bytes[i - 1] != 0)
				i = i - 1;
			// 该UCS2字符是字母或数字，则保留该字符
			else
				i = i + 1;
		}
		return new String(bytes, 0, i, "Unicode");
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public OrgServerDao getOrgServerDao() {
		return orgServerDao;
	}

	public void setOrgServerDao(OrgServerDao orgServerDao) {
		this.orgServerDao = orgServerDao;
	}

	public List getServerType() {
		return serverType;
	}

	public void setServerType(List serverType) {
		this.serverType = serverType;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public List getCheckIndexs() {
		return checkIndexs;
	}

	public String getDelids() {
		return delids;
	}

	public void setDelids(String delids) {
		this.delids = delids;
	}

	public void setCheckIndexs(List checkIndexs) {
		this.checkIndexs = checkIndexs;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getCheckIndex() {
		return checkIndex;
	}

	public void setCheckIndex(String checkIndex) {
		this.checkIndex = checkIndex;
	}

	public String getServerDate() {
		return serverDate;
	}

	public void setServerDate(String serverDate) {
		this.serverDate = serverDate;
	}

	public String getBuryear() {
		return buryear;
	}

	public void setBuryear(String buryear) {
		this.buryear = buryear;
	}

	public String getSerInfo() {
		return serInfo;
	}

	public void setSerInfo(String serInfo) {
		this.serInfo = serInfo;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileFileContentType() {
		return fileFileContentType;
	}

	public void setFileFileContentType(String fileFileContentType) {
		this.fileFileContentType = fileFileContentType;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	public HsfsOrgServInfo getOrgServInfo() {
		return orgServInfo;
	}

	public void setOrgServInfo(HsfsOrgServInfo orgServInfo) {
		this.orgServInfo = orgServInfo;
	}

	public HsfsOrgServFile getOrgServFile() {
		return orgServFile;
	}

	public void setOrgServFile(HsfsOrgServFile orgServFile) {
		this.orgServFile = orgServFile;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public PageUtil getPages() {
		return pages;
	}

	public void setPages(PageUtil pages) {
		this.pages = pages;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public List<Integer> getDeleteList() {
		return deleteList;
	}

	public void setDeleteList(List<Integer> deleteList) {
		this.deleteList = deleteList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<HsfsOrgServFile> getList() {
		return list;
	}

	public void setList(List<HsfsOrgServFile> list) {
		this.list = list;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public int getSaveResult() {
		return saveResult;
	}

	public void setSaveResult(int saveResult) {
		this.saveResult = saveResult;
	}

	public int getCheckFileResult() {
		return checkFileResult;
	}

	public void setCheckFileResult(int checkFileResult) {
		this.checkFileResult = checkFileResult;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
}

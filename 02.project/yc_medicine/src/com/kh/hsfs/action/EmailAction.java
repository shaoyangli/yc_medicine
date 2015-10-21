package com.kh.hsfs.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.kh.hsfs.dao.EmailService;
import com.kh.hsfs.model.HsfsEmail;
import com.kh.hsfs.model.HsfsEmailFile;
import com.kh.hsfs.model.HsfsOrgBaseInfo;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.util.PageUtil;
import com.kh.util.RetrunAreaId;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class EmailAction extends ActionSupport {
	private HsfsEmail email;
	private HsfsEmailFile efile;
	private List<HsfsEmailFile> files;
	private EmailService es;
	private int checkType;
	private int isSuccess;
	private int currPage;
	private int totalPages;
	private int id;
	private int flag;
	private String[] info;//
	private String count = "";//

	private PageUtil result;

	private ArrayList<Map<String, Object>> menuNodes = new ArrayList<Map<String, Object>>();
	private HttpSession session = ServletActionContext.getRequest()
			.getSession();

	private File file;
	private String fileFileName;
	private String fileFileContentType;

	private String message;

	/*
	 * ��ѯ�����ռ���
	 */
	public String findAllNodes() throws Exception {
		Map<String, Object> application = ActionContext.getContext()
				.getApplication();
		String area = (String) application.get("Address");
		List<String[]> list = es.FindNodes("hsfs_findznodes", checkType, area);
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				String[] str = list.get(i);
				map.put("id", str[0]);
				map.put("pId", str[1]);
				map.put("name", str[2]);
				map.put("open", false);
				if (Integer.parseInt(str[3]) == 0) {
					map.put("nocheck", true);
				}
				menuNodes.add(map);
			}
		}

		return "r";
	}

	/**
	 * ��ѯ���н����ʼ� (Ҫƥ�� ��¼���� ,����,ȫ��411481000000,�������������ѯ)
	 */

	public String findEmails() throws Exception {
		HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
		HsfsOrgBaseInfo org = (HsfsOrgBaseInfo) session.getAttribute("org");
		String loginid = user.getUserLoginId();// ��¼����
		String orgCode = user.getOrgCode();// ��ǰ��¼�û�������
		String areaid = org.getOrgAreaId();
		// String xian = areaid.substring(0, 6) + "000000";

		List<String> areaids = RetrunAreaId.returnAreaid(org);
		String temp = "";
		for (String area : areaids) {
			temp += " or receiveid like '%," + area + ",%' ";
		}

		String sql = "select id,title,senddate,sendperson,sendorgname,(case when readedid like '%,"
				+ loginid
				+ ",%' then 1 else 0 end ) readed,isf from hsfs_email where (receiveid like '%,"
				+ loginid
				+ ",%' or receiveid like '%,"
				+ orgCode
				+ ",%'"
				+ temp
				+ ") and deledId not like '%,"
				+ loginid
				+ ",%' order by senddate desc,id desc";
		int row = 10;// ÿҳ��¼��
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		result = es.findBySqlPage(currPage, row, sql);
		return "r";
	}

	/**
	 * �鿴�û��ѷ����ʼ��б�
	 */
	public String findSendedEmails() throws Exception {
		HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
		String loginid = user.getUserLoginId();
		// String sql =
		// "select id,title,senddate,rname from hsfs_email where sendid = '"
		// + loginid
		// + "' and deledId not like '%,"
		// + loginid
		// + ",%'  order by senddate desc,id desc";
		String sql1 = "select id,title,senddate,rname from hsfs_email where sendid = '"
				+ loginid + "'and flag = 0 order by senddate desc,id desc";
		int row = 10;// ÿҳ��¼��
		if (currPage > totalPages) {
			currPage = totalPages;
		}
		result = es.findBySqlPage(currPage, row, sql1);
		return "r";
	}

	// /**
	// * �ʼ����� 1�ʼ��ı���2
	// */
	public String sendEmail() throws Exception {
		if (!count.equals("")) {
			email.setIsf(1);// �и����ı�ʶ
		}
		isSuccess = es.sendEmail(email, count);
		return "r";
	}

	/**
	 * ��һ���ʼ�
	 * 
	 * @return
	 */
	public String findOneEmail() throws Exception {
		email = es.findOneEmail(id);
		// ���ڸ����Ļ�
		if (email.getIsf() == 1) {
			files = es.findFiles(id);
		}
		return "findOneEmail";
	}

	/**
	 * ����Ѷ��ʼ�
	 */
	public String markReaded() throws Exception {
		isSuccess = es.markEmail(id);
		return "r";
	}

	/**
	 * ɾ��һ���ʼ�,��ʵ��ûɾ��,ֻ���ֶ�������һ�������ı�ʶ
	 */
	public String removeEmail() throws Exception {
		HsfsUserInfo user = (HsfsUserInfo) session.getAttribute("user");
		String loginid = user.getUserLoginId();
		info = count.split(",");
		for (int i = 0; i < info.length; i++) {
			es.removeEmail(Integer.parseInt(info[i]), loginid);
		}
		return "r";
	}

	/**
	 *������ ɾ���ѷ����ʼ�
	 */
	public String removeFromSended() throws Exception {
		info = count.split(",");
		for (int i = 0; i < info.length; i++) {
			es.removeFromSendBOx(Integer.parseInt(info[i]));
		}
		return "r";
	}

	/**
	 * ����Ƿ����µ��ʼ�
	 * 
	 * @return
	 */
	public String checkNewEmail() throws Exception {
		isSuccess = es.checkNewEmail();
		return "r";
	}

	/*
	 * �˷�����ɸ������ϴ�
	 */
	public String uploadFile() throws Exception {
		isSuccess = saveFiles();
		return "uploadFile";
	}

	public String removeFujian() throws Exception {
		isSuccess = es.removeFujian(id);
		return "r";
	}

	private int saveFiles() {
		String url = session.getServletContext().getRealPath("/") + "upload";
		// 1.������ļ����ϴ�
		File f = file;
		if (f.length() / (1024 * 1024) > 50) {
			message = "�ϴ��ļ�����50M";
			return 1;
		} else {
			try {
				InputStream is = new FileInputStream(f);
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// �������ڸ�ʽ
				String nowTime = df.format(new Date());// ����ɵ�ǰʱ��
				int index = fileFileName.lastIndexOf(".");// Դ�ļ��������һ��"."������
				String ext = fileFileName.substring(index + 1);// ȡ�ú�׺����"."������ַ�
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
				if (filename.getBytes().length > 60) { // gcl 5.9 ��ȡ����
					filename = OrgServerAction.bSubstring(filename, 60);
				}
				HsfsEmailFile emf = new HsfsEmailFile();
				emf.setFileName(filename + "." + ext);
				emf.setFileType(ext);
				//emf.setEmailId(id);
				emf.setFilePath("upload/" + newFileName);

				int t = es.saveFile(emf);
				if (t > 0) {
					id = t;
					return 0;
				} else {
					message = "�����ϴ�ʧ��";
					return 1;
				}
			} catch (Exception e) {
				e.printStackTrace();
				message = "�����ϴ�ʧ��...";
				return 1;
			}
		}

	}

	/*
	 * ��֤�ļ��Ƿ����
	 */

	public String checkFileExist() throws Exception {
		efile = es.findOneFile(id);
		String filePath = efile.getFilePath();
		String url = session.getServletContext().getRealPath("/");
		File file = new File(url + filePath);
		if (file.exists()) {
			isSuccess = 0;// �ļ����ڸ�ֵ0
		} else {
			isSuccess = 1;// �����ڸ�ֵ1
		}
		return "r";
	}

	// �ļ�����
	public String downFile() throws Exception {
		efile = es.findOneFile(id);
		String url = session.getServletContext().getRealPath("/");
		String path = url + efile.getFilePath();
		File downloadFile = new File(path);
		String filesname = efile.getFileName();

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
		response.setContentLength((int) downloadFile.length());// ������ʾ�����
		OutputStream out = response.getOutputStream();
		while ((len = br.read(buf)) > 0)
			out.write(buf, 0, len);
		br.close();
		out.close();
		response.flushBuffer();
		return null; // �ɹ�
	}

	public HsfsEmail getEmail() {

		return email;
	}

	public void setEmail(HsfsEmail email) {
		this.email = email;
	}

	public EmailService getEs() {
		return es;
	}

	public void setEs(EmailService es) {
		this.es = es;
	}

	public ArrayList<Map<String, Object>> getMenuNodes() {
		return menuNodes;
	}

	public void setMenuNodes(ArrayList<Map<String, Object>> menuNodes) {
		this.menuNodes = menuNodes;
	}

	public int getCheckType() {
		return checkType;
	}

	public void setCheckType(int checkType) {
		this.checkType = checkType;
	}

	public int getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
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

	public PageUtil getResult() {
		return result;
	}

	public void setResult(PageUtil result) {
		this.result = result;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public HsfsEmailFile getEfile() {
		return efile;
	}

	public void setEfile(HsfsEmailFile efile) {
		this.efile = efile;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<HsfsEmailFile> getFiles() {
		return files;
	}

	public void setFiles(List<HsfsEmailFile> files) {
		this.files = files;
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

	public void setFile(File file) {
		this.file = file;
	}

}

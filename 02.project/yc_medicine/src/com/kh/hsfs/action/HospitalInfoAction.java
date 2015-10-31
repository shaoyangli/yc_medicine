package com.kh.hsfs.action;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.HsfsUserInfo;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-7-28
 * Time: 下午10:17
 * 住院信息管理
 */
public class HospitalInfoAction extends ActionSupport {
    private HospitalInfoDao hospitalInfoDao;
    private List list;
    private HospitalInfo hobi;
    private int isSuccess;
    private int id; //住院记录id
    private int mid; //给药信息id
    private String name;
    private PageUtil findOrgResult;
    private int currPage;// 当前页
    private int totalPages;// 总页数
    private String param;// 接收查询条件传递过来的值
    /*
     * 添加住院信息
     */
    public String saveHosp() throws Exception {
        try {
            HttpSession session = ServletActionContext.getRequest()
                    .getSession();
            HsfsUserInfo userinfo = (HsfsUserInfo)session.getAttribute("user");
            hobi.setOperator(Integer.toString(userinfo.getUserCode()));
            isSuccess = hospitalInfoDao.saveHosp(hobi);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "saveHosp";

    }

    /**
     * 查询所有住院记录
     */
    public String findAllHosp() throws Exception {
        HttpSession session = ServletActionContext.getRequest()
                .getSession();
        HsfsUserInfo userinfo = (HsfsUserInfo)session.getAttribute("user");
        String sql ="";
        //管理员查询全部
        if( userinfo.getPowerRole() == 1 ){
            sql = "select * from hospitalinfo order by id";
        }else {     //非管理员仅仅查询自己保存的记录
            sql = "select * from hospitalinfo h where h.operator = " + userinfo.getUserCode()  + " order by id";
        }

        list = hospitalInfoDao.getByJdbcSQL(sql);
        return "findAllHosp";
    }

    /**
     * 条件查询住院记录
     */
    public String findHospList() throws Exception {
        HttpSession session = ServletActionContext.getRequest()
                .getSession();
        HsfsUserInfo userinfo = (HsfsUserInfo)session.getAttribute("user");
        String sql = "select * from hospitalinfo where 1=1";
        if (!"".equals(name)) {
            sql += " and name like '%" + name + "%'";
        }
        //管理员查询全部
        if( userinfo.getPowerRole() == 1 ){
            sql += " order by id";
        } else {
            sql += " and  operator = " + userinfo.getUserCode()  + " order by id";
        }

        int row = 10;// 每页记录数
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        findOrgResult = hospitalInfoDao.findBySqlPage(currPage, row, sql);
        return "findHospList";
    }

    public String findHosp() throws Exception {
        hobi = hospitalInfoDao.findHospById(id);
        return "findHosp";
    }

    /**
     * 删除住院记录
     */
    public String removeHosp() throws Exception {
        isSuccess = hospitalInfoDao.removeById(id);
        return "removeHosp";
    }

    public HospitalInfoDao getHospitalInfoDao() {
        return hospitalInfoDao;
    }

    public void setHospitalInfoDao(HospitalInfoDao hospitalInfoDao) {
        this.hospitalInfoDao = hospitalInfoDao;
    }

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public HospitalInfo getHobi() {
        return hobi;
    }

    public void setHobi(HospitalInfo hobi) {
        this.hobi = hobi;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIsSuccess() {
        return isSuccess;
    }

    public void setIsSuccess(int isSuccess) {
        this.isSuccess = isSuccess;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public PageUtil getFindOrgResult() {
        return findOrgResult;
    }

    public void setFindOrgResult(PageUtil findOrgResult) {
        this.findOrgResult = findOrgResult;
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

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }
}

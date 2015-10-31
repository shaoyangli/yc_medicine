package com.kh.hsfs.action;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailCsaDao;
import com.kh.hsfs.dao.MedicineCsaDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.MeddetailCsa;
import com.kh.hsfs.model.MedicineCsa;
import com.kh.util.MedicineUtil;
import com.kh.util.PageUtil;
import com.opensymphony.xwork2.ActionSupport;

import java.util.ArrayList;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-27
 * Time: 下午8:42
 * To change this template use File | Settings | File Templates.
 */
public class MedicineCsaAction extends ActionSupport {
    private HospitalInfoDao hospitalInfoDao;
    private HospitalInfo hobi;

    private MedicineCsaDao medicineCsaDao;
    private MeddetailCsaDao meddetailCsaDao;
    private MeddetailCsa meddetailCsa;
    private MedicineCsa medicineCsa;

    private int isSuccess;
    private int id; //给药信息id
    private int hid; //住院记录id

    private PageUtil findOrgResult;
    private int currPage;// 当前页
    private int totalPages;// 总页数
    private String param;// 接收查询条件传递过来的值
    private String date1;
    private String date2;

    //页面跳转
    public String toMedicineCsaList() throws Exception {
        hobi = hospitalInfoDao.findHospById(hid);
        return "toMedicineCsaList";
    }

    //删除Csa给药记录      TODO未删除给药明细
    public String removeCsa() throws Exception{
        medicineCsa = medicineCsaDao.findCsaById(id);
        String sql = "select * from meddetail_csa t where 1=1 and t.mid="+medicineCsa.getId();
        List list = meddetailCsaDao.getByJdbcSQL(sql);
        int result = -1;
        for(Object o : list){
            List list1 = (ArrayList)o;
            String metailId = list1.get(0).toString();
            result = meddetailCsaDao.removeById(Integer.parseInt(metailId));
            if(result==0){
               break;
            }
        }
        //删除明细失败
        if(result == 0){
            isSuccess= 0;
        }else{  //删除明细成功，删除主记录
            isSuccess = medicineCsaDao.removeById(id);
        }
        return "removeCsa";
    }

    //查询给药信息列表
    public String findCsaList() throws Exception{
        String sql = "select * from medicine_csa t where 1=1 and t.hid="+hid;
        if (!"".equals(date1)) {
            sql += " and t.date >="+date1;
        }
        if (!"".equals(date2)) {
            sql += " and t.date <="+date2;
        }
        sql += " order by t.id";
        int row = 10;// 每页记录数
        if (currPage > totalPages) {
            currPage = totalPages;
        }
        findOrgResult = medicineCsaDao.findBySqlPage(currPage, row, sql);
        return "findCsaList";
    }

    /*
     * 添加或者修改CSA给药信息  todo
     */
    public String saveMedCsa() throws Exception {
        try {
            isSuccess = medicineCsaDao.saveCsa(medicineCsa);
            id=medicineCsa.getId();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "saveMedCsa";

    }

    //跳转给药信息修改页面
    public String toUpdateCsa() throws Exception
    {
        //todo
        if(hid>0){
            hobi = hospitalInfoDao.findHospById(hid);
        }
        if(id>0){
            medicineCsa = medicineCsaDao.findCsaById(id);
        }
        return "toUpdateCsa";
    }

    //预测血药浓度
    public String ycxynd() throws Exception {
        String cvsText =MedicineUtil.get_ParaCsa( id,hid,meddetailCsaDao,hospitalInfoDao,medicineCsa);
        MedicineUtil.Write_file(cvsText,"YCCsA/YCCsA.csv");
        MedicineUtil.Count("YCCsA","yccsa.ctl");
        medicineCsa =MedicineUtil.Read_File(medicineCsa,"YCCsA/YCCsA.g77/yccsa.fit");
        isSuccess = 1;
        param = medicineCsa.getYcxy();
        return "ycxynd";
    }

    //预测给药剂量范围
    public String ycgyjlfw() throws Exception {
        String cvsText = "";
        int i = 0;
        while ("".equals(medicineCsa.getZdyl())) {
            if(Integer.parseInt(medicineCsa.getAmt())<=0){
                break;
            }
            cvsText =MedicineUtil.get_ParaCsa( id,hid,meddetailCsaDao,hospitalInfoDao,medicineCsa);
            MedicineUtil.Write_file(cvsText,"YCCsA/YCCsA.csv");
            MedicineUtil.Count("YCCsA","yccsa.ctl");
            medicineCsa = MedicineUtil.Read_File(medicineCsa,"YCCsA/YCCsA.g77/yccsa.fit");
            if (!"".equals(medicineCsa.getYcxy())) { //预测血药浓度不为""
                if (!"".equals(medicineCsa.getZxyl())) //最小给药量不为null
                {
                    medicineCsa = MedicineUtil.Count_max(medicineCsa); //计算最大给药量
                } else {
                    medicineCsa = MedicineUtil.Count_min(medicineCsa); //计算最小给药量
                }
            }
        }
        if(Integer.parseInt(medicineCsa.getAmt())<=0){
            param="error";
            return "ycgyjlfw";
        }
        isSuccess = 1;
        param = medicineCsa.getYcxy() + "," + medicineCsa.getAmt() + "," + medicineCsa.getZdyl() + "," + medicineCsa.getZxyl();
        return "ycgyjlfw";
    }


    public String SaveCsaDetail() throws Exception {
        if(id>0){
            MedicineUtil.save_ParaCsa( id,hid,meddetailCsaDao,hospitalInfoDao,medicineCsa);
            isSuccess = 1;
        }else{
            isSuccess = 3;
        }
        return "SaveCsaDetail";
    }

    public MedicineCsaDao getMedicineCsaDao() {
        return medicineCsaDao;
    }

    public void setMedicineCsaDao(MedicineCsaDao medicineCsaDao) {
        this.medicineCsaDao = medicineCsaDao;
    }

    public MeddetailCsaDao getMeddetailCsaDao() {
        return meddetailCsaDao;
    }

    public void setMeddetailCsaDao(MeddetailCsaDao meddetailCsaDao) {
        this.meddetailCsaDao = meddetailCsaDao;
    }

    public MeddetailCsa getMeddetailCsa() {
        return meddetailCsa;
    }

    public void setMeddetailCsa(MeddetailCsa meddetailCsa) {
        this.meddetailCsa = meddetailCsa;
    }

    public MedicineCsa getMedicineCsa() {
        return medicineCsa;
    }

    public void setMedicineCsa(MedicineCsa medicineCsa) {
        this.medicineCsa = medicineCsa;
    }

    public int getIsSuccess() {
        return isSuccess;
    }

    public void setIsSuccess(int success) {
        isSuccess = success;
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

    public String getDate1() {
        return date1;
    }

    public void setDate1(String date1) {
        this.date1 = date1;
    }

    public String getDate2() {
        return date2;
    }

    public void setDate2(String date2) {
        this.date2 = date2;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHid() {
        return hid;
    }

    public void setHid(int hid) {
        this.hid = hid;
    }

    public HospitalInfoDao getHospitalInfoDao() {
        return hospitalInfoDao;
    }

    public void setHospitalInfoDao(HospitalInfoDao hospitalInfoDao) {
        this.hospitalInfoDao = hospitalInfoDao;
    }

    public HospitalInfo getHobi() {
        return hobi;
    }

    public void setHobi(HospitalInfo hobi) {
        this.hobi = hobi;
    }
}

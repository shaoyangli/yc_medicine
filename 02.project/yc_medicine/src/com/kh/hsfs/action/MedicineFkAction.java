package com.kh.hsfs.action;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailFkDao;
import com.kh.hsfs.dao.MedicineFkDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.MeddetailFk;
import com.kh.hsfs.model.MedicineFk;
import com.kh.util.MedicineUtilFk;
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
public class MedicineFkAction extends ActionSupport {
    private HospitalInfoDao hospitalInfoDao;
    private HospitalInfo hobi;

    private MedicineFkDao medicineFkDao;
    private MeddetailFkDao meddetailFkDao;
    private MeddetailFk meddetailFk;
    private MedicineFk medicineFk;

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
    public String toMedicineFkList() throws Exception {
        hobi = hospitalInfoDao.findHospById(hid);
        return "toMedicineFkList";
    }

    //删除Fk给药记录      TODO未删除给药明细
    public String removeFk() throws Exception{
        medicineFk = medicineFkDao.findFkById(id);
        String sql = "select * from meddetail_fk t where 1=1 and t.mid="+medicineFk.getId();
        List list = meddetailFkDao.getByJdbcSQL(sql);
        int result = -1;
        for(Object o : list){
            List list1 = (ArrayList)o;
            String metailId = list1.get(0).toString();
            result = meddetailFkDao.removeById(Integer.parseInt(metailId));
            if(result==0){
                break;
            }
        }
        //删除明细失败
        if(result == 0){
            isSuccess= 0;
        }else{  //删除明细成功，删除主记录
            isSuccess = medicineFkDao.removeById(id);
        }
        return "removeFk";
    }

    //查询给药信息列表
    public String findFkList() throws Exception{
        String sql = "select * from medicine_Fk t where 1=1 and t.hid="+hid;
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
        findOrgResult = medicineFkDao.findBySqlPage(currPage, row, sql);
        return "findFkList";
    }

    /*
     * 添加或者修改Fk给药信息  todo
     */
    public String saveMedFk() throws Exception {
        try {
            isSuccess = medicineFkDao.saveFk(medicineFk);
            id=medicineFk.getId();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "saveMedFk";

    }

    //跳转给药信息修改页面
    public String toUpdateFk() throws Exception
    {
        //todo
        if(hid>0){
            hobi = hospitalInfoDao.findHospById(hid);
        }
        if(id>0){
            medicineFk = medicineFkDao.findFkById(id);
        }
        return "toUpdateFk";
    }

    //预测血药浓度
    public String ycxynd() throws Exception {
        String cvsText =MedicineUtilFk.get_ParaFk( id,hid,meddetailFkDao,hospitalInfoDao,medicineFk);
        MedicineUtilFk.Write_file(cvsText,"YCFk/YCFk.csv");
        MedicineUtilFk.Count("YCFk","ycFk.ctl");
        medicineFk =MedicineUtilFk.Read_File(medicineFk,"YCFk/YCFk.g77/ycFk.fit");
        isSuccess = 1;
        param = medicineFk.getYcxy();
        return "ycxynd";
    }

    //预测给药剂量范围
    public String ycgyjlfw() throws Exception {
        String cvsText = "";
        int i = 0;
        while ("".equals(medicineFk.getZdyl())) {
            System.out.println(++i);
            if(Integer.parseInt(medicineFk.getAmt())<=0){
                break;
            }
            cvsText =MedicineUtilFk.get_ParaFk( id,hid,meddetailFkDao,hospitalInfoDao,medicineFk);
            MedicineUtilFk.Write_file(cvsText,"YCFk/YCFk.csv");
            MedicineUtilFk.Count("YCFk","ycFk.ctl");
            medicineFk = MedicineUtilFk.Read_File(medicineFk,"YCFk/YCFk.g77/ycFk.fit");
            if (!"".equals(medicineFk.getYcxy())) { //预测血药浓度不为""
                if (!"".equals(medicineFk.getZxyl())) //最小给药量不为null
                {
                    medicineFk = MedicineUtilFk.Count_max(medicineFk); //计算最大给药量
                } else {
                    medicineFk = MedicineUtilFk.Count_min(medicineFk); //计算最小给药量
                }
            }
        }
        if(Integer.parseInt(medicineFk.getAmt())<=0){
            param="error";
            return "ycgyjlfw";
        }
        isSuccess = 1;
        param = medicineFk.getYcxy() + "," + medicineFk.getAmt() + "," + medicineFk.getZdyl() + "," + medicineFk.getZxyl();
        return "ycgyjlfw";
    }


    public String SaveFkDetail() throws Exception {
        if(id>0){
            MedicineUtilFk.save_ParaFk( id,hid,meddetailFkDao,hospitalInfoDao,medicineFk);
            isSuccess = 1;
        }else{
            isSuccess = 3;
        }
        return "SaveFkDetail";
    }

    public MedicineFkDao getMedicineFkDao() {
        return medicineFkDao;
    }

    public void setMedicineFkDao(MedicineFkDao medicineFkDao) {
        this.medicineFkDao = medicineFkDao;
    }

    public MeddetailFkDao getMeddetailFkDao() {
        return meddetailFkDao;
    }

    public void setMeddetailFkDao(MeddetailFkDao meddetailFkDao) {
        this.meddetailFkDao = meddetailFkDao;
    }

    public MeddetailFk getMeddetailFk() {
        return meddetailFk;
    }

    public void setMeddetailFk(MeddetailFk meddetailFk) {
        this.meddetailFk = meddetailFk;
    }

    public MedicineFk getMedicineFk() {
        return medicineFk;
    }

    public void setMedicineFk(MedicineFk medicineFk) {
        this.medicineFk = medicineFk;
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

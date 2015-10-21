package com.kh.hsfs.action;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailVpaDao;
import com.kh.hsfs.dao.MedicineVpaDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.MeddetailVpa;
import com.kh.hsfs.model.MedicineVpa;
import com.kh.util.MedicineUtilVpa;
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
public class MedicineVpaAction extends ActionSupport {
    private HospitalInfoDao hospitalInfoDao;
    private HospitalInfo hobi;

    private MedicineVpaDao medicineVpaDao;
    private MeddetailVpaDao meddetailVpaDao;
    private MeddetailVpa meddetailVpa;
    private MedicineVpa medicineVpa;

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
    public String toMedicineVpaList() throws Exception {
        hobi = hospitalInfoDao.findHospById(hid);
        return "toMedicineVpaList";
    }

    //删除Vpa给药记录      TODO未删除给药明细
    public String removeVpa() throws Exception{
        medicineVpa = medicineVpaDao.findVpaById(id);
        String sql = "select * from meddetail_vpa t where 1=1 and t.mid="+medicineVpa.getId();
        List list = meddetailVpaDao.getByJdbcSQL(sql);
        int result = -1;
        for(Object o : list){
            List list1 = (ArrayList)o;
            String metailId = list1.get(0).toString();
            result = meddetailVpaDao.removeById(Integer.parseInt(metailId));
            if(result==0){
                break;
            }
        }
        //删除明细失败
        if(result == 0){
            isSuccess= 0;
        }else{  //删除明细成功，删除主记录
            isSuccess = medicineVpaDao.removeById(id);
        }
        return "removeVpa";
    }

    //查询给药信息列表
    public String findVpaList() throws Exception{
        String sql = "select * from medicine_Vpa t where 1=1 and t.hid="+hid;
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
        findOrgResult = medicineVpaDao.findBySqlPage(currPage, row, sql);
        return "findVpaList";
    }

    /*
     * 添加或者修改Vpa给药信息  todo
     */
    public String saveMedVpa() throws Exception {
        try {
            isSuccess = medicineVpaDao.saveVpa(medicineVpa);
            id=medicineVpa.getId();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "saveMedVpa";

    }

    //跳转给药信息修改页面
    public String toUpdateVpa() throws Exception
    {
        //todo
        if(hid>0){
            hobi = hospitalInfoDao.findHospById(hid);
        }
        if(id>0){
            medicineVpa = medicineVpaDao.findVpaById(id);
        }
        return "toUpdateVpa";
    }

    //预测血药浓度
    public String ycxynd() throws Exception {
        String cvsText =MedicineUtilVpa.get_ParaVpa( id,hid,meddetailVpaDao,hospitalInfoDao,medicineVpa);
        MedicineUtilVpa.Write_file(cvsText,"YCVpa/YCVpa.csv");
        MedicineUtilVpa.Count("YCVpa","ycVpa.ctl");
        medicineVpa =MedicineUtilVpa.Read_File(medicineVpa,"YCVpa/YCVpa.g77/ycVpa.fit");
        isSuccess = 1;
        param = medicineVpa.getYcxy();
        return "ycxynd";
    }

    //预测给药剂量范围
    public String ycgyjlfw() throws Exception {
        String cvsText = "";
        int i = 0;
        while ("".equals(medicineVpa.getZdyl())) {
            System.out.println(++i);
            if(Integer.parseInt(medicineVpa.getAmt())<=0){
                break;
            }
            cvsText =MedicineUtilVpa.get_ParaVpa( id,hid,meddetailVpaDao,hospitalInfoDao,medicineVpa);
            MedicineUtilVpa.Write_file(cvsText,"YCVpa/YCVpa.csv");
            MedicineUtilVpa.Count("YCVpa","ycVpa.ctl");
            medicineVpa = MedicineUtilVpa.Read_File(medicineVpa,"YCVpa/YCVpa.g77/ycVpa.fit");
            if (!"".equals(medicineVpa.getYcxy())) { //预测血药浓度不为""
                if (!"".equals(medicineVpa.getZxyl())) //最小给药量不为null
                {
                    medicineVpa = MedicineUtilVpa.Count_max(medicineVpa); //计算最大给药量
                } else {
                    medicineVpa = MedicineUtilVpa.Count_min(medicineVpa); //计算最小给药量
                }
            }
        }
        if(Integer.parseInt(medicineVpa.getAmt())<=0){
            param="error";
            return "ycgyjlfw";
        }
        isSuccess = 1;
        param = medicineVpa.getYcxy() + "," + medicineVpa.getAmt() + "," + medicineVpa.getZdyl() + "," + medicineVpa.getZxyl();
        return "ycgyjlfw";
    }


    public String SaveVpaDetail() throws Exception {
        if(id>0){
            MedicineUtilVpa.save_ParaVpa( id,hid,meddetailVpaDao,hospitalInfoDao,medicineVpa);
            isSuccess = 1;
        }else{
            isSuccess = 3;
        }
        return "SaveVpaDetail";
    }

    public MedicineVpaDao getMedicineVpaDao() {
        return medicineVpaDao;
    }

    public void setMedicineVpaDao(MedicineVpaDao medicineVpaDao) {
        this.medicineVpaDao = medicineVpaDao;
    }

    public MeddetailVpaDao getMeddetailVpaDao() {
        return meddetailVpaDao;
    }

    public void setMeddetailVpaDao(MeddetailVpaDao meddetailVpaDao) {
        this.meddetailVpaDao = meddetailVpaDao;
    }

    public MeddetailVpa getMeddetailVpa() {
        return meddetailVpa;
    }

    public void setMeddetailVpa(MeddetailVpa meddetailVpa) {
        this.meddetailVpa = meddetailVpa;
    }

    public MedicineVpa getMedicineVpa() {
        return medicineVpa;
    }

    public void setMedicineVpa(MedicineVpa medicineVpa) {
        this.medicineVpa = medicineVpa;
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

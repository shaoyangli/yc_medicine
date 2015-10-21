package com.kh.hsfs.action;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailWfDao;
import com.kh.hsfs.dao.MedicineWfDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.MeddetailWf;
import com.kh.hsfs.model.MedicineWf;
import com.kh.util.MedicineUtilWf;
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
public class MedicineWfAction extends ActionSupport {
    private HospitalInfoDao hospitalInfoDao;
    private HospitalInfo hobi;

    private MedicineWfDao medicineWfDao;
    private MeddetailWfDao meddetailWfDao;
    private MeddetailWf meddetailWf;
    private MedicineWf medicineWf;

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
    public String toMedicineWfList() throws Exception {
        hobi = hospitalInfoDao.findHospById(hid);
        return "toMedicineWfList";
    }

    //删除Wf给药记录      TODO未删除给药明细
    public String removeWf() throws Exception{
        medicineWf = medicineWfDao.findWfById(id);
        String sql = "select * from meddetail_wf t where 1=1 and t.mid="+medicineWf.getId();
        List list = meddetailWfDao.getByJdbcSQL(sql);
        int result = -1;
        for(Object o : list){
            List list1 = (ArrayList)o;
            String metailId = list1.get(0).toString();
            result = meddetailWfDao.removeById(Integer.parseInt(metailId));
            if(result==0){
                break;
            }
        }
        //删除明细失败
        if(result == 0){
            isSuccess= 0;
        }else{  //删除明细成功，删除主记录
            isSuccess = medicineWfDao.removeById(id);
        }
        return "removeWf";
    }

    //查询给药信息列表
    public String findWfList() throws Exception{
        String sql = "select * from medicine_Wf t where 1=1 and t.hid="+hid;
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
        findOrgResult = medicineWfDao.findBySqlPage(currPage, row, sql);
        return "findWfList";
    }

    /*
     * 添加或者修改Wf给药信息  todo
     */
    public String saveMedWf() throws Exception {
        try {
            isSuccess = medicineWfDao.saveWf(medicineWf);
            id=medicineWf.getId();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "saveMedWf";

    }

    //跳转给药信息修改页面
    public String toUpdateWf() throws Exception
    {
        //todo
        if(hid>0){
            hobi = hospitalInfoDao.findHospById(hid);
        }
        if(id>0){
            medicineWf = medicineWfDao.findWfById(id);
        }
        return "toUpdateWf";
    }

    //预测血药浓度
    public String ycxynd() throws Exception {
        String cvsText =MedicineUtilWf.get_ParaWf( id,hid,meddetailWfDao,hospitalInfoDao,medicineWf);
        MedicineUtilWf.Write_file(cvsText,"YCWf/YCstablewarfarin.csv");
        MedicineUtilWf.Count("YCWf","YCWf.ctl");
        medicineWf =MedicineUtilWf.Read_File(medicineWf,"YCWf/YCWf.g77/ycwf.fit");
        isSuccess = 1;
        param = medicineWf.getYcxy();
        return "ycxynd";
    }

    //预测给药剂量范围
    public String ycgyjlfw() throws Exception {
        String cvsText = "";
        int i = 0;
        while ("".equals(medicineWf.getZdyl())) {
            System.out.println(++i);
            if(Integer.parseInt(medicineWf.getDose())<=0){
                break;
            }
            cvsText =MedicineUtilWf.get_ParaWf( id,hid,meddetailWfDao,hospitalInfoDao,medicineWf);
            MedicineUtilWf.Write_file(cvsText,"YCWf/YCstablewarfarin.csv");
            MedicineUtilWf.Count("YCWf","ycWf.ctl");
            medicineWf = MedicineUtilWf.Read_File(medicineWf,"YCWf/YCWf.g77/ycwf.fit");
            if (!"".equals(medicineWf.getYcxy())) { //预测血药浓度不为""
                if (!"".equals(medicineWf.getZxyl())) //最小给药量不为null
                {
                    medicineWf = MedicineUtilWf.Count_max(medicineWf); //计算最大给药量
                } else {
                    medicineWf = MedicineUtilWf.Count_min(medicineWf); //计算最小给药量
                }
            }
        }
        if(Integer.parseInt(medicineWf.getDose())<=0){
            param="error";
            return "ycgyjlfw";
        }
        isSuccess = 1;
        param = medicineWf.getYcxy() + "," + medicineWf.getDose() + "," + medicineWf.getZdyl() + "," + medicineWf.getZxyl();
        return "ycgyjlfw";
    }


    public String SaveWfDetail() throws Exception {
        if(id>0){
            MedicineUtilWf.save_ParaWf( id,hid,meddetailWfDao,hospitalInfoDao,medicineWf);
            isSuccess = 1;
        }else{
            isSuccess = 3;
        }
        return "SaveWfDetail";
    }

    public MedicineWfDao getMedicineWfDao() {
        return medicineWfDao;
    }

    public void setMedicineWfDao(MedicineWfDao medicineWfDao) {
        this.medicineWfDao = medicineWfDao;
    }

    public MeddetailWfDao getMeddetailWfDao() {
        return meddetailWfDao;
    }

    public void setMeddetailWfDao(MeddetailWfDao meddetailWfDao) {
        this.meddetailWfDao = meddetailWfDao;
    }

    public MeddetailWf getMeddetailWf() {
        return meddetailWf;
    }

    public void setMeddetailWf(MeddetailWf meddetailWf) {
        this.meddetailWf = meddetailWf;
    }

    public MedicineWf getMedicineWf() {
        return medicineWf;
    }

    public void setMedicineWf(MedicineWf medicineWf) {
        this.medicineWf = medicineWf;
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

package com.kh.hsfs.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-9-21
 * Time: 下午7:43
 * To change this template use File | Settings | File Templates.
 */
public class MedicineWf implements java.io.Serializable {
    private int id;        //给药记录id
    private int hid;       //住院id
    private String dose;    //给药剂量
    private String dv;      //上次给药后检测浓度
    private String adm;     //是否合用胺碘酮
    private String cyp;     //CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”
    private String vkorc;   //VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”；

    private String jg;     //剂量调整间隔
    private String xysx;  //预测血液浓度上限
    private String xyxx;  //预测血液浓度下限
    private String zxyl;  //最小用药量
    private String zdyl;  //最大用药量
    private String ycxy;  //预测血液浓度
    private String jyyl;   //医生建议用药


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

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }

    public String getAdm() {
        return adm;
    }

    public void setAdm(String adm) {
        this.adm = adm;
    }

    public String getCyp() {
        return cyp;
    }

    public void setCyp(String cyp) {
        this.cyp = cyp;
    }

    public String getVkorc() {
        return vkorc;
    }

    public void setVkorc(String vkorc) {
        this.vkorc = vkorc;
    }

    public String getDv() {
        return dv;
    }

    public void setDv(String dv) {
        this.dv = dv;
    }

    public String getJyyl() {
        return jyyl;
    }

    public void setJyyl(String jyyl) {
        this.jyyl = jyyl;
    }

    public String getJg() {
        return jg;
    }

    public void setJg(String jg) {
        this.jg = jg;
    }

    public String getXysx() {
        return xysx;
    }

    public void setXysx(String xysx) {
        this.xysx = xysx;
    }

    public String getXyxx() {
        return xyxx;
    }

    public void setXyxx(String xyxx) {
        this.xyxx = xyxx;
    }

    public String getZxyl() {
        return zxyl;
    }

    public void setZxyl(String zxyl) {
        this.zxyl = zxyl;
    }

    public String getZdyl() {
        return zdyl;
    }

    public void setZdyl(String zdyl) {
        this.zdyl = zdyl;
    }

    public String getYcxy() {
        return ycxy;
    }

    public void setYcxy(String ycxy) {
        this.ycxy = ycxy;
    }
}

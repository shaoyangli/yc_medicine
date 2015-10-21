package com.kh.hsfs.model;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-8-6
 * Time: 10:32
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailWf implements java.io.Serializable {
    private int id;        //给药记录id
    private int hid;        //住院id
    private int mid;
    private String dv;
    private String dose;
    private String mdv;
    private String age;
    private String wt;
    private String adm;     //是否合用胺碘酮
    private String cyp;     //CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”
    private String vkorc;   //VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”；
    private String sex;
    private String ht;

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

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }

    public String getDv() {
        return dv;
    }

    public void setDv(String dv) {
        this.dv = dv;
    }

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }

    public String getMdv() {
        return mdv;
    }

    public void setMdv(String mdv) {
        this.mdv = mdv;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getWt() {
        return wt;
    }

    public void setWt(String wt) {
        this.wt = wt;
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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getHt() {
        return ht;
    }

    public void setHt(String ht) {
        this.ht = ht;
    }
}

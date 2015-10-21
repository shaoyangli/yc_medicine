package com.kh.hsfs.model;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-8-6
 * Time: 10:32
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailFk implements java.io.Serializable {
    private int id;        //给药记录id
    private int hid;        //住院id
    private int mid;
    private String dat2;     //给药日期
    private String time;     //给药时间
    private String amt;
    private String cmt;
    private String rate;
    private String dv;
    private String mdv;
    private String wt;
    private String age;
    private String hgb;
    private String inhi;
    private String pod;
    private String sex;
    private String ht;
    private String rbc;
    private String htc;
    private String tbil;
    private String alt;
    private String ast;


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

    public String getDat2() {
        return dat2;
    }

    public void setDat2(String dat2) {
        this.dat2 = dat2;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAmt() {
        return amt;
    }

    public void setAmt(String amt) {
        this.amt = amt;
    }

    public String getCmt() {
        return cmt;
    }

    public void setCmt(String cmt) {
        this.cmt = cmt;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getDv() {
        return dv;
    }

    public void setDv(String dv) {
        this.dv = dv;
    }

    public String getMdv() {
        return mdv;
    }

    public void setMdv(String mdv) {
        this.mdv = mdv;
    }

    public String getWt() {
        return wt;
    }

    public void setWt(String wt) {
        this.wt = wt;
    }

    public String getHtc() {
        return htc;
    }

    public void setHtc(String htc) {
        this.htc = htc;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
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

    public String getRbc() {
        return rbc;
    }

    public void setRbc(String rbc) {
        this.rbc = rbc;
    }

    public String getTbil() {
        return tbil;
    }

    public void setTbil(String tbil) {
        this.tbil = tbil;
    }

    public String getAlt() {
        return alt;
    }

    public void setAlt(String alt) {
        this.alt = alt;
    }

    public String getAst() {
        return ast;
    }

    public void setAst(String ast) {
        this.ast = ast;
    }

    public String getInhi() {
        return inhi;
    }

    public void setInhi(String inhi) {
        this.inhi = inhi;
    }

    public String getHgb() {
        return hgb;
    }

    public void setHgb(String hgb) {
        this.hgb = hgb;
    }

    public String getPod() {
        return pod;
    }

    public void setPod(String pod) {
        this.pod = pod;
    }
}

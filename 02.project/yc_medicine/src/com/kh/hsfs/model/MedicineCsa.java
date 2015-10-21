package com.kh.hsfs.model;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-8-6
 * Time: 下午10:32
 * To change this template use File | Settings | File Templates.
 */
public class MedicineCsa implements java.io.Serializable {
    private int id;        //给药记录id
    private int hid;       //住院id
    private String date;    //给药日期
    private String time;    //给药时间
    private String amt;    //给药剂量
    private String time2;    //给药时间
    private String amt2;    //给药剂量
    private String cmt;    //给药方式
    private String rate;   //给药频次
    private String rate1;  //给药时间平均量
    private String dv;    //上次给药后检测浓度
    private String htc;
    private String atf;
    private String dt;
    private String tg;
    private String rbc;
    private String tbil;
    private String alt;
    private String ast;

    private String jg;     //剂量调整间隔
    private String xysx;  //预测血液浓度上限
    private String xyxx;  //预测血液浓度下限
    private String cxrq;    //抽血日期
    private String cxsj;    //抽血时间
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
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


    public String getHtc() {
        return htc;
    }

    public void setHtc(String htc) {
        this.htc = htc;
    }

    public String getAtf() {
        return atf;
    }

    public void setAtf(String atf) {
        this.atf = atf;
    }

    public String getDt() {
        return dt;
    }

    public void setDt(String dt) {
        this.dt = dt;
    }

    public String getTg() {
        return tg;
    }

    public void setTg(String tg) {
        this.tg = tg;
    }

    public String getAmt2() {
        return amt2;
    }

    public void setAmt2(String amt2) {
        this.amt2 = amt2;
    }

    public String getTime2() {
        return time2;
    }

    public void setTime2(String time2) {
        this.time2 = time2;
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

    public String getJyyl() {
        return jyyl;
    }

    public void setJyyl(String jyyl) {
        this.jyyl = jyyl;
    }

    public String getCxrq() {
        return cxrq;
    }

    public void setCxrq(String cxrq) {
        this.cxrq = cxrq;
    }

    public String getCxsj() {
        return cxsj;
    }

    public void setCxsj(String cxsj) {
        this.cxsj = cxsj;
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

    public String getRate1() {
        return rate1;
    }

    public void setRate1(String rate1) {
        this.rate1 = rate1;
    }
}

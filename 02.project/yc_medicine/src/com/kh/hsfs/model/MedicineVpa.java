package com.kh.hsfs.model;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-9-21
 * Time: 下午7:43
 * To change this template use File | Settings | File Templates.
 */
public class MedicineVpa implements Serializable {
    private int id;        //给药记录id
    private int hid;       //住院id
    private String date;    //给药日期
    private String time;    //给药时间
    private String time2;    //给药时间2
    private String time3;    //给药时间3
    private String amt;    //给药剂量
    private String amt2;    //给药剂量2
    private String amt3;    //给药剂量3

    private String rate;   //给药频率QD(一天一次)，BID一天两次 TID一天三次
    private String tamt;   //每日总剂量
    private String form;   //药物剂型，1=溶液剂，2=片剂，3=缓释剂；
    private String dv;     //上次给药后检测浓度
    private String lmsq;   //是否合用拉莫三嗪，合用输入”1”，未合用输入“0”；
    private String lxxp;   //是否合用氯硝西泮，合用输入”1”，未合用输入“0”；
    private String kmxp;   //是否合用卡马西平，合用输入”1”，未合用输入“0”；
    private String tt;     //是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”；
    private String bbbt;   //是否合用苯巴比妥，合用输入”1”，未合用输入“0”；
    private String kpl;    //是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”
    private String okxp;   //是否合用奥卡西平，合用输入”1”，未合用输入“0”；
    private String pht;    //是否合用苯妥英，合用输入”1”，未合用输入“0”；

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

    public String getTime2() {
        return time2;
    }

    public void setTime2(String time2) {
        this.time2 = time2;
    }

    public String getTime3() {
        return time3;
    }

    public void setTime3(String time3) {
        this.time3 = time3;
    }

    public String getAmt2() {
        return amt2;
    }

    public void setAmt2(String amt2) {
        this.amt2 = amt2;
    }

    public String getAmt3() {
        return amt3;
    }

    public void setAmt3(String amt3) {
        this.amt3 = amt3;
    }

    public String getTamt() {
        return tamt;
    }

    public void setTamt(String tamt) {
        this.tamt = tamt;
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public String getLmsq() {
        return lmsq;
    }

    public void setLmsq(String lmsq) {
        this.lmsq = lmsq;
    }

    public String getLxxp() {
        return lxxp;
    }

    public void setLxxp(String lxxp) {
        this.lxxp = lxxp;
    }

    public String getKmxp() {
        return kmxp;
    }

    public void setKmxp(String kmxp) {
        this.kmxp = kmxp;
    }

    public String getTt() {
        return tt;
    }

    public void setTt(String tt) {
        this.tt = tt;
    }

    public String getBbbt() {
        return bbbt;
    }

    public void setBbbt(String bbbt) {
        this.bbbt = bbbt;
    }

    public String getKpl() {
        return kpl;
    }

    public void setKpl(String kpl) {
        this.kpl = kpl;
    }

    public String getOkxp() {
        return okxp;
    }

    public void setOkxp(String okxp) {
        this.okxp = okxp;
    }

    public String getPht() {
        return pht;
    }

    public void setPht(String pht) {
        this.pht = pht;
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

}

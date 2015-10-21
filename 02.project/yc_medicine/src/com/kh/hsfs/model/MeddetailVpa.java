package com.kh.hsfs.model;

/**
 * Created with IntelliJ IDEA.
 * User: lsy
 * Date: 15-8-6
 * Time: 10:32
 * To change this template use File | Settings | File Templates.
 */
public class MeddetailVpa implements java.io.Serializable {
    private int id;        //给药记录id
    private int hid;       //住院id
    private int mid;
    private String sex;
    private String form;   //药物剂型，1=溶液剂，2=片剂，3=缓释剂；
    private String age;
    private String wt;
    private String bsa;    //患者表面积
    private String amt;    //给药剂量
    private String date;    //给药日期
    private String time;    //给药时间
    private String dv;     //上次给药后检测浓度
    private String mdv;
    private String tamt;   //每日总剂量
    private String lmsq;   //是否合用拉莫三嗪，合用输入”1”，未合用输入“0”；
    private String lxxp;   //是否合用氯硝西泮，合用输入”1”，未合用输入“0”；
    private String kmxp;   //是否合用卡马西平，合用输入”1”，未合用输入“0”；
    private String tt;     //是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”；
    private String bbbt;   //是否用合苯巴比妥，合用输入”1”，未合用输入“0”；
    private String kpl;    //是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”
    private String okxp;   //是否合用奥卡西平，合用输入”1”，未合用输入“0”；
    private String pht;    //是否合用苯妥英，合用输入”1”，未合用输入“0”；

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

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
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

    public String getBsa() {
        return bsa;
    }

    public void setBsa(String bsa) {
        this.bsa = bsa;
    }

    public String getAmt() {
        return amt;
    }

    public void setAmt(String amt) {
        this.amt = amt;
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

    public String getTamt() {
        return tamt;
    }

    public void setTamt(String tamt) {
        this.tamt = tamt;
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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}

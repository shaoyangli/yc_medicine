package com.kh.util;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailVpaDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.MeddetailVpa;
import com.kh.hsfs.model.MedicineVpa;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-28
 * Time: 下午4:58
 * To change this template use File | Settings | File Templates.
 */
public class MedicineUtilVpa {
    private static String key = "0";

    //根据前端信息得到要写入的数据
    public static String save_ParaVpa(int mid, int id, MeddetailVpaDao meddetailVpaDao, HospitalInfoDao hospitalInfoDao, MedicineVpa vpa) throws Exception {
        //1.保存给药明细，需要先删除已存在的mid给药明细
        if (mid > 0 && id > 0) {
            String sql = " select * from meddetail_vpa t where t.hid=" + id + " and t.mid=" + mid;
            List list = meddetailVpaDao.getByJdbcSQL(sql);
            for (Object o : list) {
                List tlist = (List) o;
                String result = (String) tlist.get(0);
                if (result != null && !"".equals(result)) {
                    meddetailVpaDao.removeById(Integer.parseInt(result));
                } else {
                    throw new Exception("查询异常");
                }
            }
        }
        //2.查询该住院id对应的所有的给药明细并加到cvsText中
        String cvsText = "#ID,SEX,FORM,AGE,WT,BSA,AMT,DATE,TIME,DV,TAMT,MDV,LMSQ,LXXP,KMXP,TT,BBBT,KPL,OKXP,PHT";
        MeddetailVpa mdvpa;
        String sql1 = "select * from meddetail_vpa t where t.hid=" + id + " and t.mid <>" + mid + " order by t.date,t.id ";
        List medlist = meddetailVpaDao.getByJdbcSQL(sql1);
        for (Object o : medlist) {
            List tlist = (List) o;
            String result = (String) tlist.get(0);
            if (result != null && !"".equals(result)) {
                mdvpa = meddetailVpaDao.findVpaById(Integer.parseInt(result));
                cvsText = cvsText + "\r\n" + mdvpa.getMid() + "," + mdvpa.getSex() + "," + mdvpa.getForm() + "," + mdvpa.getAge()
                        + "," + mdvpa.getWt() + "," + mdvpa.getBsa() + "," + mdvpa.getAmt() + "," + mdvpa.getDate() + "," + mdvpa.getTime()
                        + "," + mdvpa.getDv() + "," + mdvpa.getTamt() + "," + mdvpa.getMdv() + "," + mdvpa.getLmsq() + "," + mdvpa.getLxxp()
                        + "," + mdvpa.getKmxp() + "," + mdvpa.getTt() + "," + mdvpa.getBbbt() + "," + mdvpa.getKpl() + "," + mdvpa.getOkxp()
                        + "," + mdvpa.getPht();
            } else {
                throw new Exception("查询异常");
            }
        }

        HospitalInfo hosp = hospitalInfoDao.findHospById(id);

        String sex = hosp.getSex(); //性别
        String form = vpa.getForm(); //药物剂型  1=溶液剂，2=片剂，3=缓释剂
        String age = hosp.getAge(); //年龄
        String wt = hosp.getWeight();  //体重
        String bsa = hosp.getSurface_area(); //体表面积
        String amt = vpa.getAmt(); //给药剂量

        String dat1 = vpa.getDate(); //给药时间
        String t = vpa.getTime();  //给药时间

        String dv = vpa.getDv();//上次给药后检测血药浓度
        String tamt = vpa.getTamt();
        String mdv = "1";
        String mdv2 = "";
        String lmsq = vpa.getLmsq();
        String lxxp = vpa.getLxxp();
        String kmxp = vpa.getKmxp();
        String vpaTt = vpa.getTt();
        String bbbt = vpa.getBbbt();
        String kpl = vpa.getKpl();
        String okxp = vpa.getOkxp();
        String pht = vpa.getPht();

        String rate = vpa.getRate(); //给药频率QD(一天一次)，BID一天两次 TID一天三次

        if ("1".equals(rate))  //QD(一天一次)
        {
            String t3 = vpa.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = vpa.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);
            tamt=amt;

            //准备写入信息
            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat2 + "," + t + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt, dat2, t, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, "", dat3, t3, dv, tamt, mdv2, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat3 + "," + t + "," + "" + "," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt, dat3, t, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, "", dat3, t3, dv, tamt, mdv2, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
            }
        } else if ("2".equals(rate)) {     //BID一天两次
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(t);
            matcher.find();
            String num = matcher.group();
            int tt = Integer.parseInt(num) + 12;
            String t2 = String.valueOf(tt) + t.substring((num.length()), 3);
            String t3 = vpa.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = vpa.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);

            //一天两次并且每天第二次的给药时间和给药剂量另外给time2和amt2，如果为null则用time和amt
            String time2 = vpa.getTime2();
            String amt2 = vpa.getAmt2();
            if ("".equals(time2)) {
                time2 = t2;
            }
            if ("".equals(amt2)) {
                amt2 = amt;
                tamt = (Integer.parseInt(amt)*2)+"";
            }else{
                tamt = Integer.parseInt(amt) + Integer.parseInt(amt2) +"";
            }

            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat2 + "," + t + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt, dat2, t, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt2 + "," + dat2 + "," + time2 + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt2, dat2, time2, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, "", dat3, t3, dv, tamt, mdv2, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat3 + "," + t + "," + "" + "," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt, dat3, t, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, "", dat3, t3, dv, tamt, mdv2, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
            }
        } else if ("3".equals(rate)) {  //TID一天三次
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(t);
            matcher.find();
            String num = matcher.group();
            int tt = Integer.parseInt(num) + 8;
            if(tt>24){
                tt=24;
            }
            String t2 = String.valueOf(tt) + t.substring((num.length()), 3); //第二次给药的时间(time2=null)
            int tt1 = Integer.parseInt(num) +16;
            if(tt1>24){
                tt1=24;
            }
            String t4 = String.valueOf(tt1) + t.substring((num.length()), 3);  //第三次给药的时间(time3=null)
            String t3 = vpa.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = vpa.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);

            //一天三次并且每天第二、三次的给药时间和给药剂量另外给time2、3和amt2、3，如果为null则用time和amt
            String time2 = vpa.getTime2();
            String amt2 = vpa.getAmt2();
            if ("".equals(time2)) {
                time2 = t2;
            }
            if ("".equals(amt2)) {
                amt2 = amt;
            }

            String time3 = vpa.getTime3();
            String amt3 = vpa.getAmt3();
            if ("".equals(time3)) {
                time3 = t4;
            }
            if ("".equals(amt3)) {
                amt3 = amt;
                tamt = (Integer.parseInt(amt)*3)+"";
            }else{
                tamt = Integer.parseInt(amt) + Integer.parseInt(amt2) + Integer.parseInt(amt3) + "";
            }
            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat2 + "," + t + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt, dat2, t, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt2 + "," + dat2 + "," + time2 + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt2, dat2, time2, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt3 + "," + dat2 + "," + time3 + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt3, dat2, time3, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, "", dat3, t3, dv, tamt, mdv2, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat3 + "," + t + "," + "" + "," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, amt, dat3, t, "", tamt, mdv, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
                savedetail(meddetailVpaDao, id, mid, sex, form, age, wt, bsa, "", dat3, t3, dv, tamt, mdv2, lmsq, lxxp, kmxp, vpaTt, bbbt, kpl, okxp, pht);
            }
        }
        return cvsText;
    }


    //根据前端信息得到要写入的数据
    public static String get_ParaVpa(int mid, int id, MeddetailVpaDao meddetailVpaDao, HospitalInfoDao hospitalInfoDao, MedicineVpa vpa) throws Exception {
        //2.查询该住院id对应的所有的给药明细并加到cvsText中 （如果mid大于0需要排除掉当前mid对应的明细避免重复计算，如果mid小于0说明记录、明细还没保存）
        String cvsText = "#ID,SEX,FORM,AGE,WT,BSA,AMT,DATE,TIME,DV,TAMT,MDV,LMSQ,LXXP,KMXP,TT,BBBT,KPL,OKXP,PHT";
        MeddetailVpa mdvpa;
        String sql1 = "select * from meddetail_vpa t where t.hid=" + id + " and t.mid <>" + mid + " order by t.date,t.id ";
        List medlist = meddetailVpaDao.getByJdbcSQL(sql1);
        for (Object o : medlist) {
            List tlist = (List) o;
            String result = (String) tlist.get(0);
            if (result != null && !"".equals(result)) {
                mdvpa = meddetailVpaDao.findVpaById(Integer.parseInt(result));
                cvsText = cvsText + "\r\n" + mdvpa.getMid() + "," + mdvpa.getSex() + "," + mdvpa.getForm() + "," + mdvpa.getAge()
                        + "," + mdvpa.getWt() + "," + mdvpa.getBsa() + "," + mdvpa.getAmt() + "," + mdvpa.getDate() + "," + mdvpa.getTime()
                        + "," + mdvpa.getDv() + "," + mdvpa.getTamt() + "," + mdvpa.getMdv() + "," + mdvpa.getLmsq() + "," + mdvpa.getLxxp()
                        + "," + mdvpa.getKmxp() + "," + mdvpa.getTt() + "," + mdvpa.getBbbt() + "," + mdvpa.getKpl() + "," + mdvpa.getOkxp()
                        + "," + mdvpa.getPht();
            } else {
                throw new Exception("查询异常");
            }
        }

        HospitalInfo hosp = hospitalInfoDao.findHospById(id);

        String sex = hosp.getSex(); //性别
        String form = vpa.getForm(); //药物剂型  1=溶液剂，2=片剂，3=缓释剂
        String age = hosp.getAge(); //年龄
        String wt = hosp.getWeight();  //体重
        String bsa = hosp.getSurface_area(); //体表面积
        String amt = vpa.getAmt(); //给药剂量

        String dat1 = vpa.getDate(); //给药时间
        String t = vpa.getTime();  //给药时间

        String dv = vpa.getDv();//上次给药后检测血药浓度
        String tamt = vpa.getTamt();
        String mdv = "1";
        String mdv2 = "";
        String lmsq = vpa.getLmsq();
        String lxxp = vpa.getLxxp();
        String kmxp = vpa.getKmxp();
        String vpaTt = vpa.getTt();
        String bbbt = vpa.getBbbt();
        String kpl = vpa.getKpl();
        String okxp = vpa.getOkxp();
        String pht = vpa.getPht();

        String rate = vpa.getRate(); //给药频率QD(一天一次)，BID一天两次 TID一天三次

        if ("1".equals(rate))  //QD(一天一次)
        {
            String t3 = vpa.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = vpa.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);
            tamt=amt;

            //准备写入信息
            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat2 + "," + t + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat3 + "," + t + "," + "" + "," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
            }
        } else if ("2".equals(rate)) {     //BID一天两次
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(t);
            matcher.find();
            String num = matcher.group();
            int tt = Integer.parseInt(num) + 12;
            if(tt>24){
                tt=24;
            }
            String t2 = String.valueOf(tt) + t.substring((num.length()), 3);
            String t3 = vpa.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = vpa.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);

            //一天两次并且每天第二次的给药时间和给药剂量另外给time2和amt2，如果为null则用time和amt
            String time2 = vpa.getTime2();
            String amt2 = vpa.getAmt2();
            if ("".equals(time2)) {
                time2 = t2;
            }
            if ("".equals(amt2)) {
                amt2 = amt;
                tamt = (Integer.parseInt(amt)*2)+"";
            }else{
                tamt = Integer.parseInt(amt) + Integer.parseInt(amt2) +"";
            }

            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat2 + "," + t + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt2 + "," + dat2 + "," + time2 + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat3 + "," + t + "," + "" + "," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
            }
        } else if ("3".equals(rate)) {  //TID一天三次
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(t);
            matcher.find();
            String num = matcher.group();
            int tt = Integer.parseInt(num) + 8;
            if(tt>24){
                tt=24;
            }
            String t2 = String.valueOf(tt) + t.substring((num.length()), 3); //第二次给药的时间(time2=null)
            int tt1 = Integer.parseInt(num) +16;
            if(tt1>24){
                tt1=24;
            }
            String t4 = String.valueOf(tt1) + t.substring((num.length()), 3);  //第三次给药的时间(time3=null)
            String t3 = vpa.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = vpa.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);

            //一天三次并且每天第二、三次的给药时间和给药剂量另外给time2、3和amt2、3，如果为null则用time和amt
            String time2 = vpa.getTime2();
            String amt2 = vpa.getAmt2();
            if ("".equals(time2)) {
                time2 = t2;
            }
            if ("".equals(amt2)) {
                amt2 = amt;
            }
            String time3 = vpa.getTime3();
            String amt3 = vpa.getAmt3();
            if ("".equals(time3)) {
                time3 = t4;
            }
            if ("".equals(amt3)) {
                amt3 = amt;
                tamt = (Integer.parseInt(amt)*3)+"";
            }else{
                tamt = Integer.parseInt(amt) + Integer.parseInt(amt2) + Integer.parseInt(amt3) + "";
            }
            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat2 + "," + t + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt2 + "," + dat2 + "," + time2 + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt3 + "," + dat2 + "," + time3 + ",," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + amt + "," + dat3 + "," + t + "," + "" + "," + tamt + "," + mdv + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht;
                cvsText = cvsText + "\r\n" + mid + "," + sex + "," + form + "," + age + "," + wt + "," + bsa + "," + "" + "," + dat3 + "," + t3 + "," + dv + "," + tamt + "," + mdv2 + "," + lmsq + "," + lxxp + "," + kmxp + "," + vpaTt + "," + bbbt + "," + kpl + "," + okxp + "," + pht + "\r\n";
            }
        }
        return cvsText;
    }

    //写入csv
    public static void Write_file(String cvsText, String site) throws Exception {

        //写入文件
        //string dir = "C:/nm6.g77/YCCsA/YCCsA.csv";
        String dir = "D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/sdfyy/" + site;  //YCCsA/YCCsA.csv
        FileOutputStream out = null;
        OutputStreamWriter osw = null;
        BufferedWriter bw = null;
        try {
            File file = new File(dir);
            out = new FileOutputStream(file);
            osw = new OutputStreamWriter(out, "UTF8");
            bw = new BufferedWriter(osw);
            bw.write(cvsText);
            bw.close();
            osw.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        } finally {
            bw.close();
            osw.close();
            out.close();
        }
    }

    //计算
    public static void Count(String site, String ctlfile) throws Exception {
        //打开dos调用路径
        Runtime run = Runtime.getRuntime();
        String result = "";
        try {
            String command1 = "cmd /c  D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/wfn614/bin/wfn.bat ";
            String command2 = " && cd /D D: ";
            String command3 = " && cd D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/sdfyy/" + site;//YCCsA
            String command4 = " && nmgo " + ctlfile;               // yccsa.ctl
//            System.out.println(command1+ command2 + command3 + command4);
            Process process = run.exec(command1 + command2 + command3 + command4);
            InputStream in = process.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(in));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
                result = result + line;
            }
            in.close();
        } catch (Exception e) {
            throw new Exception(e);
        }
    }


    //读取fit文件
    public static MedicineVpa Read_File(MedicineVpa vpa, String site) throws Exception {
        String dir = "D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/sdfyy/" + site;//YCCsA/YCCsA.g77/ycvpa.fit
        File file = new File(dir);
        String TextBox1 = "";
        String result = "";
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            String input = null;
            // 一次读入一行，直到读入null为文件结束
            while ((input = reader.readLine()) != null) {
                input = input.replaceAll("<br>", "\r\n");
                TextBox1 = input;  //读取最后一行
            }
            reader.close();

            String[] sArray = TextBox1.split("  ");//将读取的行内数据按空格分开，分别存入数组
            String str = sArray[5];  //取到结果值
            if(str.indexOf(" -")>0){
               sArray = str.split(" -");
               str = sArray[0];
            }
            String[] s2 = str.split("E\\+");//分别读取结果值和幂次方值
            double pre_result = Double.parseDouble(s2[0]) * Math.pow(10, Double.parseDouble(s2[1]));//计算出结果值
            if (String.valueOf(pre_result).length() >= 6) {
                result = String.valueOf(pre_result).substring(0, 6);
            } else {
                result = String.valueOf(pre_result);
            }
            vpa.setYcxy(result);
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                    throw new Exception(e1);
                }
            }
        }
        return vpa;
    }

    /**
     * 计算最大给药量
     */
    public static MedicineVpa Count_max(MedicineVpa vpa) {
        //计算值大于期望最大值，则得到最大给药量
        if (Double.parseDouble(vpa.getYcxy()) > Double.parseDouble(vpa.getXysx())) {
            int new_amt = Integer.parseInt(vpa.getAmt()) - Integer.parseInt(vpa.getJg());
            vpa.setZdyl(String.valueOf(new_amt));
            vpa.setAmt(String.valueOf(new_amt));
            //一天给两次药，并且剂量不同的处理
            if (!"".equals(vpa.getAmt2())) {
                int new_amt2 = Integer.parseInt(vpa.getAmt2()) - Integer.parseInt(vpa.getJg());
                vpa.setAmt2(String.valueOf(new_amt2));
            }
            if (!"".equals(vpa.getAmt3())) {
                int new_amt3 = Integer.parseInt(vpa.getAmt3()) - Integer.parseInt(vpa.getJg());
                vpa.setAmt3(String.valueOf(new_amt3));
            }
        } else        //否则加间隔继续计算
        {
            int new_amt = Integer.parseInt(vpa.getAmt()) + Integer.parseInt(vpa.getJg());
            vpa.setAmt(String.valueOf(new_amt));
            //一天给两次药，并且剂量不同的处理
            if (!"".equals(vpa.getAmt2())) {
                int new_amt2 = Integer.parseInt(vpa.getAmt2()) + Integer.parseInt(vpa.getJg());
                vpa.setAmt2(String.valueOf(new_amt2));
            }
            if (!"".equals(vpa.getAmt3())) {
                int new_amt3 = Integer.parseInt(vpa.getAmt3()) + Integer.parseInt(vpa.getJg());
                vpa.setAmt3(String.valueOf(new_amt3));
            }
        }
        return vpa;
    }


    public static MedicineVpa Count_min(MedicineVpa vpa) {
        //如果预测值小于最小期望值，则在原给药剂量基础上增加一个“剂量调整间隔”的量
        if (Double.parseDouble(vpa.getYcxy()) <= Double.parseDouble(vpa.getXyxx())) {
            int new_amt = Integer.parseInt(vpa.getAmt()) + Integer.parseInt(vpa.getJg());
            vpa.setAmt(String.valueOf(new_amt)); //修改给药剂量
            //一天给两次药，并且剂量不同的处理
            if (!"".equals(vpa.getAmt2())) {
                int new_amt2 = Integer.parseInt(vpa.getAmt2()) + Integer.parseInt(vpa.getJg());
                vpa.setAmt2(String.valueOf(new_amt2));
            }
            if (!"".equals(vpa.getAmt3())) {
                int new_amt3 = Integer.parseInt(vpa.getAmt3()) + Integer.parseInt(vpa.getJg());
                vpa.setAmt3(String.valueOf(new_amt3));
            }
            key = "1";//状态记录，状态1：给药预测值低于最小剂量。
        } else if (Double.parseDouble(vpa.getYcxy()) > Double.parseDouble(vpa.getXyxx()))//如果预测值大于最小期望值
        {
            if ("1".equals(key))//如果由状态1过来的，则此给药剂量为最小给药量
            {
                vpa.setZxyl(String.valueOf(vpa.getAmt()));
                key = "0";
                int new_amt = Integer.parseInt(vpa.getAmt()) + Integer.parseInt(vpa.getJg());
                vpa.setAmt(String.valueOf(new_amt));
                //一天给两次药，并且剂量不同的处理
                if (!"".equals(vpa.getAmt2())) {
                    int new_amt2 = Integer.parseInt(vpa.getAmt2()) + Integer.parseInt(vpa.getJg());
                    vpa.setAmt2(String.valueOf(new_amt2));
                }
                if (!"".equals(vpa.getAmt3())) {
                    int new_amt3 = Integer.parseInt(vpa.getAmt3()) + Integer.parseInt(vpa.getJg());
                    vpa.setAmt3(String.valueOf(new_amt3));
                }
            } else//如果预测值大于最小期望值
            {
                int new_amt = Integer.parseInt(vpa.getAmt()) - Integer.parseInt(vpa.getJg());
                vpa.setAmt(String.valueOf(new_amt));
                //一天给两次药，并且剂量不同的处理
                if (!"".equals(vpa.getAmt2())) {
                    int new_amt2 = Integer.parseInt(vpa.getAmt2()) - Integer.parseInt(vpa.getJg());
                    vpa.setAmt2(String.valueOf(new_amt2));
                }
                if (!"".equals(vpa.getAmt3())) {
                    int new_amt3 = Integer.parseInt(vpa.getAmt3()) - Integer.parseInt(vpa.getJg());
                    vpa.setAmt3(String.valueOf(new_amt3));
                }
                key = "2";
            }
        }
        return vpa;
    }

    //计算日期差
    public static int daysBetween(String d1, String d2) {
        Calendar calendar1 = Calendar.getInstance();
        Calendar calendar2 = Calendar.getInstance();
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

            calendar1.setTime(format.parse(d1));
            calendar2.setTime(format.parse(d2));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return (int) ((calendar2.getTimeInMillis() - calendar1.getTimeInMillis()) / 1000 / 60 / 60 / 24);//获取天数的差值。
    }

    //日期+num=新日期
    public static String getDateAfter(String date, int day) {
        Calendar now = Calendar.getInstance();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            now.setTime(format.parse(date));
            now.set(Calendar.DATE, now.get(Calendar.DATE) + day);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return format.format(now.getTime());
    }

    //时间比较
    public static int compare_date(String date1, String date2) {
        DateFormat df = new SimpleDateFormat("HH:mm");
        try {
            java.util.Date d1 = df.parse(date1);
            java.util.Date d2 = df.parse(date2);
            if (d1.getTime() > d2.getTime()) {

                return 1;
            } else if (d1.getTime() < d2.getTime()) {

                return -1;
            } else {
                return 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void savedetail(MeddetailVpaDao meddetailVpaDao, int id, int mid, String sex, String form, String age,
                                  String wt, String bsa, String amt, String dat2, String t, String dv, String tamt, String mdv, String lmsq,
                                  String lxxp, String kmxp, String vpaTt, String bbbt, String kpl ,String okxp, String pht) {
        MeddetailVpa mdvpa = new MeddetailVpa();
        mdvpa.setHid(id);
        mdvpa.setMid(mid);
        mdvpa.setSex(sex);
        mdvpa.setForm(form);
        mdvpa.setAge(age);
        mdvpa.setWt(wt);
        mdvpa.setBsa(bsa);
        mdvpa.setAmt(amt);
        mdvpa.setDate(dat2);
        mdvpa.setTime(t);
        mdvpa.setDv(dv);
        mdvpa.setTamt(tamt);
        mdvpa.setMdv(mdv);
        mdvpa.setLmsq(lmsq);
        mdvpa.setLxxp(lxxp);
        mdvpa.setKmxp(sex);
        mdvpa.setTt(vpaTt);
        mdvpa.setBbbt(bbbt);
        mdvpa.setKpl(kpl);
        mdvpa.setOkxp(okxp);
        mdvpa.setPht(pht);
        meddetailVpaDao.saveVpa(mdvpa);
    }
}

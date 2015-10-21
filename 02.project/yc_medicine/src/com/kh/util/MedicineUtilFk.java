package com.kh.util;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailFkDao;
import com.kh.hsfs.model.HospitalInfo;
import com.kh.hsfs.model.MeddetailFk;
import com.kh.hsfs.model.MedicineFk;

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
 * To change this template use File | Settings | File Templates.
 */
public class MedicineUtilFk {
    private static String key = "0";

    //根据前端信息得到要写入的数据
    public static String save_ParaFk(int mid, int id, MeddetailFkDao meddetailFkDao, HospitalInfoDao hospitalInfoDao, MedicineFk fk) throws Exception {
        //1.保存给药明细，需要先删除已存在的mid给药明细
        if (mid > 0 && id > 0) {
            String sql = " select * from meddetail_fk t where t.hid=" + id + " and t.mid=" + mid;
            List list = meddetailFkDao.getByJdbcSQL(sql);
            for (Object o : list) {
                List tlist = (List) o;
                String result = (String) tlist.get(0);
                if (result != null && !"".equals(result)) {
                    meddetailFkDao.removeById(Integer.parseInt(result));
                } else {
                    throw new Exception("查询异常");
                }
            }
        }
        //2.查询该住院id对应的所有的给药明细并加到cvsText中
        String cvsText = "#ID,DAT2,TIME,AMT,CMT,RATE,DV,MDV,AGE,HGB,INHI,POD,Sex,Height,WT,RBC,HCT,TBIL,ALT,AST";
        MeddetailFk mdfk;
        String sql1 = "select * from meddetail_fk t where t.hid=" + id + " and t.mid <>" + mid + " order by t.dat2,t.id ";
        List medlist = meddetailFkDao.getByJdbcSQL(sql1);
        for (Object o : medlist) {
            List tlist = (List) o;
            String result = (String) tlist.get(0);
            if (result != null && !"".equals(result)) {
                mdfk = meddetailFkDao.findFkById(Integer.parseInt(result));
                cvsText = cvsText + "\r\n" + mdfk.getMid() + "," + mdfk.getDat2() + "," + mdfk.getTime() + "," + mdfk.getAmt()
                        + "," + mdfk.getCmt() + "," + mdfk.getRate() + "," + mdfk.getDv() + "," + mdfk.getMdv() + "," + mdfk.getAge()
                        + "," + mdfk.getHgb() + "," + mdfk.getInhi() + "," + mdfk.getPod() + "," + mdfk.getSex() + "," + mdfk.getHt() + "," + mdfk.getWt()
                        + "," + mdfk.getRbc() + "," + mdfk.getHtc() + "," + mdfk.getTbil() + "," + mdfk.getAlt() + "," + mdfk.getAst();
            } else {
                throw new Exception("查询异常");
            }
        }

        String dat1 = fk.getDate(); //给药时间
        String t = fk.getTime();  //给药时间
        String amt = fk.getAmt(); //给药剂量
        String cmt = fk.getCmt(); //给药方式
        String ratemj = fk.getRate(); //给药频率枚举
        String rate = "";  //给药频率
        if (ratemj.equals("3")) //"24H滴注"
        {
            double ra = (Double.parseDouble(amt) / 24);//如为24小时滴注，则rate值为给药量除以24
            rate = new Double(ra).toString();
        } else {
            rate = "";
        }


        HospitalInfo hosp = hospitalInfoDao.findHospById(id);
        String wt = hosp.getWeight();  //体重
        String ht = hosp.getHeight();  //身高
        String age = hosp.getAge(); //年龄
        String sex = hosp.getSex(); //性别

        String htc = fk.getHtc(); //红细胞比积
        String hgb = fk.getHgb();//hgb
        String inhi = fk.getInhi(); //inhi
        String pod = fk.getPod(); //pod
        String rbc = fk.getRbc(); //
        String tbil = fk.getTbil();//
        String alt = fk.getAlt();//
        String ast = fk.getAst(); //
        String dv = fk.getDv();//上次给药后检测血药浓度
        String mdv = "1";
        String mdv2 = "";

        if ("2".equals(ratemj))  //如为Q12H给药，则每天需写入两条用药信息，如9：00，21：00
        {
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(t);
            matcher.find();
            String num = matcher.group();
            int tt = Integer.parseInt(num) + 12;
            if(tt>24){
                tt=24;
            }
            String t2 = String.valueOf(tt) + t.substring((num.length()), 3);
            String t3 = fk.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = fk.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);

            //一天两次并且每天第二次的给药时间和给药剂量另外给time2和amt2，如果为null则用time和amt
            String time2 = fk.getTime2();
            String amt2 = fk.getAmt2();
            if ("".equals(time2)) {
                time2 = t2;
            }
            if ("".equals(amt2)) {
                amt2 = amt;
            }

            //准备写入信息
            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + dat2 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                savedetail(meddetailFkDao, id, mid, dat2, t, amt, cmt, rate, "", mdv, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
                cvsText = cvsText + "\r\n" + mid + "," + dat2 + "," + time2 + "," + amt2 + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                savedetail(meddetailFkDao, id, mid, dat2, time2, amt2, cmt, rate, "", mdv, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
                savedetail(meddetailFkDao, id, mid, dat3, t3, "", "2", "", dv, mdv2, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);

            } else {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                savedetail(meddetailFkDao, id, mid, dat3, t, amt, cmt, rate, "", mdv, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
                savedetail(meddetailFkDao, id, mid, dat3, t3, "", "2", "", dv, mdv2, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);

            }
        } else if ("3".equals(ratemj) || "1".equals(ratemj)) {     //24H滴注||QD
            String t3 = fk.getCxsj();  //抽血时间
            String dat2 = dat1;
            String dat3 = fk.getCxrq(); //抽血日期

            int d = daysBetween(dat2, dat3);
            for (int i = 1; i <= d; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + dat2 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                savedetail(meddetailFkDao, id, mid, dat2, t, amt, cmt, rate, "", mdv, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0) {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
                savedetail(meddetailFkDao, id, mid, dat3, t3, "", "2", "", dv, mdv2, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                savedetail(meddetailFkDao, id, mid, dat3, t, amt, cmt, rate, "", mdv, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
                savedetail(meddetailFkDao, id, mid, dat3, t3, "", "2", "", dv, mdv2, wt, htc, hgb, inhi, pod, age, sex, ht, rbc, tbil, alt, ast);
            }
        }
        return cvsText;
    }


    //根据前端信息得到要写入的数据
    public static String get_ParaFk(int mid, int id, MeddetailFkDao meddetailFkDao, HospitalInfoDao hospitalInfoDao, MedicineFk fk) throws Exception {
        //2.查询该住院id对应的所有的给药明细并加到cvsText中 （如果mid大于0需要排除掉当前mid对应的明细避免重复计算，如果mid小于0说明记录、明细还没保存）
        String cvsText = "#ID,DAT2,TIME,AMT,CMT,RATE,DV,MDV,AGE,HGB,INHI,POD,Sex,Height,WT,RBC,HCT,TBIL,ALT,AST";
        MeddetailFk mdfk;
        String sql1 = "select * from meddetail_fk t where t.hid=" + id + " and t.mid <>" + mid + " order by t.dat2,t.id ";
        List medlist = meddetailFkDao.getByJdbcSQL(sql1);
        for (Object o : medlist) {
            List tlist = (List) o;
            String result = (String) tlist.get(0);
            if (result != null && !"".equals(result)) {
                mdfk = meddetailFkDao.findFkById(Integer.parseInt(result));
                cvsText = cvsText + "\r\n" + mdfk.getMid() + "," + mdfk.getDat2() + "," + mdfk.getTime() + "," + mdfk.getAmt()
                        + "," + mdfk.getCmt() + "," + mdfk.getRate() + "," + mdfk.getDv() + "," + mdfk.getMdv() + "," + mdfk.getAge()
                        + "," + mdfk.getHgb() + "," + mdfk.getInhi() + "," + mdfk.getPod() + "," + mdfk.getSex() + "," + mdfk.getHt() + "," + mdfk.getWt()
                        + "," + mdfk.getRbc() + "," + mdfk.getHtc() + "," + mdfk.getTbil() + "," + mdfk.getAlt() + "," + mdfk.getAst();
            } else {
                throw new Exception("查询异常");
            }
        }

        String dat1 = fk.getDate(); //给药时间
        String t = fk.getTime();  //给药时间
        String amt = fk.getAmt(); //给药剂量
        String cmt = fk.getCmt(); //给药方式
        String ratemj = fk.getRate(); //给药频率枚举
        String rate = "";  //给药频率
        if (ratemj.equals("3")) //"24H滴注"
        {
            double ra = (Double.parseDouble(amt) / 24);//如为24小时滴注，则rate值为给药量除以24
            rate = new Double(ra).toString();
        } else {
            rate = "";
        }


        HospitalInfo hosp = hospitalInfoDao.findHospById(id);
        String wt = hosp.getWeight();  //体重
        String ht = hosp.getHeight();  //身高
        String age = hosp.getAge(); //年龄
        String sex = hosp.getSex(); //性别

        String htc = fk.getHtc(); //红细胞比积
        String hgb = fk.getHgb();//hgb
        String inhi = fk.getInhi(); //inhi
        String pod = fk.getPod(); //pod
        String rbc = fk.getRbc(); //
        String tbil = fk.getTbil();//
        String alt = fk.getAlt();//
        String ast = fk.getAst(); //
        String dv = fk.getDv();//上次给药后检测血药浓度
        String mdv = "1";
        String mdv2 = "";

        if ("2".equals(ratemj))  //如为Q12H给药，则每天需写入两条用药信息，如9：00，21：00
        {
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(t);
            matcher.find();
            String num = matcher.group();
            int tt = Integer.parseInt(num) + 12;
            if(tt>24){
                tt=24;
            }
            String t2 = String.valueOf(tt) + t.substring((num.length()), 3);
            String t3 = fk.getCxsj();  //抽血时间
            String dat2 = dat1; //给药日期
            String dat3 = fk.getCxrq(); //抽血日期
            int day = daysBetween(dat2, dat3);

            //一天两次并且每天第二次的给药时间和给药剂量另外给time2和amt2，如果为null则用time和amt
            String time2 = fk.getTime2();
            String amt2 = fk.getAmt2();
            if ("".equals(time2)) {
                time2 = t2;
            }
            if ("".equals(amt2)) {
                amt2 = amt;
            }

            //准备写入信息
            for (int i = 1; i <= day; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + dat2 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                cvsText = cvsText + "\r\n" + mid + "," + dat2 + "," + time2 + "," + amt2 + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0)//判断抽血时间点在给药时间点的前后
            {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";

            }
        } else if ("3".equals(ratemj) || "1".equals(ratemj)) {     //24H滴注||QD
            String t3 = fk.getCxsj();  //抽血时间
            String dat2 = dat1;
            String dat3 = fk.getCxrq(); //抽血日期

            int d = daysBetween(dat2, dat3);
            for (int i = 1; i <= d; i++) {
                cvsText = cvsText + "\r\n" + mid + "," + dat2 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                dat2 = getDateAfter(dat2, 1);
            }

            if ("".equals(dv)) {
                mdv2 = "1";
            } else {
                mdv2 = "0";
            }
            if (compare_date(t3, t) <= 0) {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
            } else {
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t + "," + amt + "," + cmt + "," + rate + ",," + mdv + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast;
                cvsText = cvsText + "\r\n" + mid + "," + dat3 + "," + t3 + ",,2,," + dv + "," + mdv2 + "," + age + "," + hgb + "," + inhi + "," + pod + "," + sex + "," + ht + "," + wt + "," + rbc + "," + htc + "," + tbil + "," + alt + "," + ast + "\r\n";
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
//                System.out.println(line);
                result = result + line;
            }
            in.close();
        } catch (Exception e) {
            throw new Exception(e);
        }
    }


    //读取fit文件
    public static MedicineFk Read_File(MedicineFk fk, String site) throws Exception {
        String dir = "D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/sdfyy/" + site;//YCCsA/YCCsA.g77/ycfk.fit
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
            String str = sArray[11];  //取到结果值
            String[] s2 = str.split("E\\+");//分别读取结果值和幂次方值
            double pre_result = Double.parseDouble(s2[0]) * Math.pow(10, Double.parseDouble(s2[1]));//计算出结果值
            if (String.valueOf(pre_result).length() >= 6) {
                result = String.valueOf(pre_result).substring(0, 6);
            } else {
                result = String.valueOf(pre_result);
            }
            fk.setYcxy(result);
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
        return fk;
    }

    /**
     *计算最大给药量
     */
    public static MedicineFk Count_max(MedicineFk fk) {
        //计算值大于期望最大值，则得到最大给药量
        if (Double.parseDouble(fk.getYcxy()) > Double.parseDouble(fk.getXysx())) {
            int new_amt = Integer.parseInt(fk.getAmt()) - Integer.parseInt(fk.getJg());
            fk.setZdyl(String.valueOf(new_amt));
            fk.setAmt(String.valueOf(new_amt));
            //一天给两次药，并且剂量不同的处理
            if (!"".equals(fk.getAmt2())) {
                int new_amt2 = Integer.parseInt(fk.getAmt2()) - Integer.parseInt(fk.getJg());
                fk.setAmt2(String.valueOf(new_amt2));
            }
        } else        //否则加间隔继续计算
        {
            int new_amt = Integer.parseInt(fk.getAmt()) + Integer.parseInt(fk.getJg());
            fk.setAmt(String.valueOf(new_amt));
            //一天给两次药，并且剂量不同的处理
            if (!"".equals(fk.getAmt2())) {
                int new_amt2 = Integer.parseInt(fk.getAmt2()) + Integer.parseInt(fk.getJg());
                fk.setAmt2(String.valueOf(new_amt2));
            }
        }
        return fk;
    }


    public static MedicineFk Count_min(MedicineFk fk) {
        //如果预测值小于最小期望值，则在原给药剂量基础上增加一个“剂量调整间隔”的量
        if (Double.parseDouble(fk.getYcxy()) <= Double.parseDouble(fk.getXyxx()))
        {
            int new_amt = Integer.parseInt(fk.getAmt()) + Integer.parseInt(fk.getJg());
            fk.setAmt(String.valueOf(new_amt)); //修改给药剂量
            //一天给两次药，并且剂量不同的处理
            if (!"".equals(fk.getAmt2())) {
                int new_amt2 = Integer.parseInt(fk.getAmt2()) + Integer.parseInt(fk.getJg());
                fk.setAmt2(String.valueOf(new_amt2));
            }
            key = "1";//状态记录，状态1：给药预测值低于最小剂量。
        } else if (Double.parseDouble(fk.getYcxy()) > Double.parseDouble(fk.getXyxx()))//如果预测值大于最小期望值
        {
            if ("1".equals(key))//如果由状态1过来的，则此给药剂量为最小给药量
            {
                fk.setZxyl(String.valueOf(fk.getAmt()));
                key = "0";
                int new_amt = Integer.parseInt(fk.getAmt()) + Integer.parseInt(fk.getJg());
                fk.setAmt(String.valueOf(new_amt));
                //一天给两次药，并且剂量不同的处理
                if (!"".equals(fk.getAmt2())) {
                    int new_amt2 = Integer.parseInt(fk.getAmt2()) + Integer.parseInt(fk.getJg());
                    fk.setAmt2(String.valueOf(new_amt2));
                }
            } else//如果预测值大于最小期望值
            {
                int new_amt = Integer.parseInt(fk.getAmt()) - Integer.parseInt(fk.getJg());
                fk.setAmt(String.valueOf(new_amt));
                //一天给两次药，并且剂量不同的处理
                if (!"".equals(fk.getAmt2())) {
                    int new_amt2 = Integer.parseInt(fk.getAmt2()) - Integer.parseInt(fk.getJg());
                    fk.setAmt2(String.valueOf(new_amt2));
                }
                key = "2";
            }
        }
        return fk;
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

    public static void savedetail(MeddetailFkDao meddetailFkDao, int id, int mid, String dat2, String t, String amt, String cmt, String rate, String dv,
                                  String mdv, String wt, String htc, String hgb, String inhi, String pod, String age, String sex, String ht, String rbc, String tbil, String alt, String ast) {
        MeddetailFk mdfk = new MeddetailFk();
        mdfk.setHid(id);
        mdfk.setMid(mid);
        mdfk.setDat2(dat2);
        mdfk.setTime(t);
        mdfk.setAmt(amt);
        mdfk.setCmt(cmt);
        mdfk.setRate(rate);
        mdfk.setDv(dv);
        mdfk.setMdv(mdv);
        mdfk.setWt(wt);
        mdfk.setAge(age);
        mdfk.setHgb(hgb);
        mdfk.setInhi(inhi);
        mdfk.setPod(pod);
        mdfk.setSex(sex);
        mdfk.setHt(ht);
        mdfk.setRbc(rbc);
        mdfk.setHtc(htc);
        mdfk.setTbil(tbil);
        mdfk.setAlt(alt);
        mdfk.setAst(ast);
        meddetailFkDao.saveFk(mdfk);
    }


}

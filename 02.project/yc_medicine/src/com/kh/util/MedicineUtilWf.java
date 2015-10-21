package com.kh.util;

import com.kh.hsfs.dao.HospitalInfoDao;
import com.kh.hsfs.dao.MeddetailWfDao;
import com.kh.hsfs.dao.MeddetailWfDao;
import com.kh.hsfs.model.*;

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
public class MedicineUtilWf {
    private static String key = "0";

    //根据前端信息得到要写入的数据
    public static String save_ParaWf(int mid, int id, MeddetailWfDao meddetailWfDao, HospitalInfoDao hospitalInfoDao, MedicineWf wf) throws Exception {
        //1.保存给药明细，需要先删除已存在的mid给药明细
        if (mid > 0 && id > 0) {
            String sql = " select * from meddetail_wf t where t.hid=" + id + " and t.mid=" + mid;
            List list = meddetailWfDao.getByJdbcSQL(sql);
            for (Object o : list) {
                List tlist = (List) o;
                String result = (String) tlist.get(0);
                if (result != null && !"".equals(result)) {
                    meddetailWfDao.removeById(Integer.parseInt(result));
                } else {
                    throw new Exception("查询异常");
                }
            }
        }
        //2.查询该住院id对应的所有的给药明细并加到cvsText中
        String cvsText = "#ID,DV,Dose,MDV,AGE,WT,Adm,CYP,VKORC,sex,Height";
        MeddetailWf mdwf;
        String sql1 = "select * from meddetail_wf t where t.hid=" + id + " and t.mid <>" + mid + " order by t.id ";
        List medlist = meddetailWfDao.getByJdbcSQL(sql1);
        for (Object o : medlist) {
            List tlist = (List) o;
            String result = (String) tlist.get(0);
            if (result != null && !"".equals(result)) {
                mdwf = meddetailWfDao.findWfById(Integer.parseInt(result));
                cvsText = cvsText + "\r\n" + mdwf.getMid() + "," + mdwf.getDv() + "," + mdwf.getDose() + "," + mdwf.getMdv()
                        + "," + mdwf.getAge() + "," + mdwf.getWt() + "," + mdwf.getAdm() + "," + mdwf.getCyp()
                        + "," + mdwf.getVkorc() + "," + mdwf.getSex() + "," + mdwf.getHt();
            } else {
                throw new Exception("查询异常");
            }
        }


        HospitalInfo hosp = hospitalInfoDao.findHospById(id);
        String wt = hosp.getWeight();  //体重
        String ht = hosp.getHeight();  //身高
        String age = hosp.getAge(); //年龄
        String sex = hosp.getSex(); //性别

        String dv = wf.getDv(); //上次给药后检测血药浓度
        String dose = wf.getDose(); //给药剂量
        String adm = wf.getAdm(); //红细胞比积
        String cyp = wf.getCyp();//合用抗真菌药物
        String vkorc = wf.getVkorc(); //环孢素治疗时间


        String mdv = "1";
//        String mdv2 = "";
        if ("".equals(dv)) {
            mdv = "1";
        } else {
            mdv = "0";
        }

        cvsText = cvsText + "\r\n" + mid + "," + dv + "," + dose + "," + mdv + "," + age + "," + wt + "," + adm + "," + cyp + "," + vkorc + "," + sex + "," + ht+ "\r\n";
        savedetail(meddetailWfDao, id, mid, dv, dose, mdv, age, wt, adm, cyp, vkorc, sex, ht);

//        if ("".equals(dv)) {
//            mdv2 = "1";
//        } else {
//            mdv2 = "0";
//        }
//        cvsText = cvsText + "\r\n" + mid + "," + dv + "," + "" + "," + mdv2 + "," + age + "," + wt + "," + adm + "," + cyp + "," + vkorc + "," + sex + "," + ht + "\r\n";
//        savedetail(meddetailWfDao, id, mid, dv, "", mdv2, age, wt, adm, cyp, vkorc, sex, ht);
        return cvsText;
    }


    //根据前端信息得到要写入的数据
    public static String get_ParaWf(int mid, int id, MeddetailWfDao meddetailWfDao, HospitalInfoDao hospitalInfoDao, MedicineWf wf) throws Exception {
        //2.查询该住院id对应的所有的给药明细并加到cvsText中 （如果mid大于0需要排除掉当前mid对应的明细避免重复计算，如果mid小于0说明记录、明细还没保存）
        String cvsText = "#ID,DV,Dose,MDV,AGE,WT,Adm,CYP,VKORC,sex,Height";
        MeddetailWf mdwf;
        String sql1 = "select * from meddetail_wf t where t.hid=" + id;
        if (mid > 0) {
            sql1 = sql1 + " and mid <>" + mid;
        }
        sql1 = sql1 + " order by t.id ";
        List medlist = meddetailWfDao.getByJdbcSQL(sql1);
        for (Object o : medlist) {
            List tlist = (List) o;
            String result = (String) tlist.get(0);
            if (result != null && !"".equals(result)) {
                mdwf = meddetailWfDao.findWfById(Integer.parseInt(result));
                cvsText = cvsText + "\r\n" + mdwf.getMid() + "," + mdwf.getDv() + "," + mdwf.getDose() + "," + mdwf.getMdv()
                        + "," + mdwf.getAge() + "," + mdwf.getWt() + "," + mdwf.getAdm() + "," + mdwf.getCyp()
                        + "," + mdwf.getVkorc() + "," + mdwf.getSex() + "," + mdwf.getHt();
            } else {
                throw new Exception("查询异常");
            }
        }

        HospitalInfo hosp = hospitalInfoDao.findHospById(id);
        String wt = hosp.getWeight();  //体重
        String ht = hosp.getHeight();  //身高
        String age = hosp.getAge(); //年龄
        String sex = hosp.getSex(); //性别

        String dv = wf.getDv(); //上次给药后检测血药浓度
        String dose = wf.getDose(); //给药剂量
        String adm = wf.getAdm(); //红细胞比积
        String cyp = wf.getCyp();//合用抗真菌药物
        String vkorc = wf.getVkorc(); //环孢素治疗时间                                                                                             s


        String mdv = "1";
//        String mdv2 = "";
        if ("".equals(dv)) {
            mdv = "1";
        } else {
            mdv = "0";
        }

        cvsText = cvsText + "\r\n" + mid + "," + dv + "," + dose + "," + mdv + "," + age + "," + wt + "," + adm + "," + cyp + "," + vkorc + "," + sex + "," + ht+ "\r\n";

//        if ("".equals(dv)) {
//            mdv2 = "1";
//        } else {
//            mdv2 = "0";
//        }
//        cvsText = cvsText + "\r\n" + mid + "," + dv + "," + "" + "," + mdv2 + "," + age + "," + wt + "," + adm + "," + cyp + "," + vkorc + "," + sex + "," + ht + "\r\n";
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
            String command4 = " && nmgo " + ctlfile;               // ycwf.ctl
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
    public static MedicineWf Read_File(MedicineWf wf, String site) throws Exception {
        String dir = "D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/sdfyy/" + site;//YCCsA/YCCsA.g77/ycwf.fit
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

            if(s2.length==1){
               s2 = str.split("E\\-");
            }
            double pre_result = Double.parseDouble(s2[0]) * Math.pow(10, Double.parseDouble(s2[1]));//计算出结果值

            if (String.valueOf(pre_result).length() >= 6) {
                result = String.valueOf(pre_result).substring(0, 6);
            } else {
                result = String.valueOf(pre_result);
            }
            wf.setYcxy(result);
        } catch (Exception e) {
            e.printStackTrace();
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
        return wf;
    }

    /**
     * 计算最大给药量
     */
    public static MedicineWf Count_max(MedicineWf wf) {
        //计算值大于期望最大值，则得到最大给药量
        if (Double.parseDouble(wf.getYcxy()) > Double.parseDouble(wf.getXysx())) {
            int new_amt = Integer.parseInt(wf.getDose()) - Integer.parseInt(wf.getJg());
            wf.setZdyl(String.valueOf(new_amt));
            wf.setDose(String.valueOf(new_amt));
        } else        //否则加间隔继续计算
        {
            int new_amt = Integer.parseInt(wf.getDose()) + Integer.parseInt(wf.getJg());
            wf.setDose(String.valueOf(new_amt));
        }
        return wf;
    }


    public static MedicineWf Count_min(MedicineWf wf) {
        //如果预测值小于最小期望值，则在原给药剂量基础上增加一个“剂量调整间隔”的量
        if (Double.parseDouble(wf.getYcxy()) <= Double.parseDouble(wf.getXyxx())) {
            int new_amt = Integer.parseInt(wf.getDose()) + Integer.parseInt(wf.getJg());
            wf.setDose(String.valueOf(new_amt)); //修改给药剂量
            key = "1";//状态记录，状态1：给药预测值低于最小剂量。
        } else if (Double.parseDouble(wf.getYcxy()) > Double.parseDouble(wf.getXyxx()))//如果预测值大于最小期望值
        {
            if ("1".equals(key))//如果由状态1过来的，则此给药剂量为最小给药量
            {
                wf.setZxyl(String.valueOf(wf.getDose()));
                key = "0";
                int new_amt = Integer.parseInt(wf.getDose()) + Integer.parseInt(wf.getJg());
                wf.setDose(String.valueOf(new_amt));

            } else//如果预测值大于最小期望值
            {
                int new_amt = Integer.parseInt(wf.getDose()) - Integer.parseInt(wf.getJg());
                wf.setDose(String.valueOf(new_amt));
                key = "2";
            }
        }
        return wf;
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

    /**
     * 保存给药明细
     *
     * @param meddetailWfDao
     * @param id
     * @param mid
     */
    public static void savedetail(MeddetailWfDao meddetailWfDao, int id, int mid, String dv, String dose, String mdv,
                                  String age, String wt, String adm, String cyp, String vkorc, String sex, String ht) {
        MeddetailWf mdwf = new MeddetailWf();
        mdwf.setHid(id);
        mdwf.setMid(mid);
        mdwf.setDv(dv);
        mdwf.setDose(dose);
        mdwf.setMdv(mdv);
        mdwf.setAge(age);
        mdwf.setWt(wt);
        mdwf.setAdm(adm);
        mdwf.setCyp(cyp);
        mdwf.setVkorc(vkorc);
        mdwf.setSex(sex);
        mdwf.setHt(ht);
        meddetailWfDao.saveWf(mdwf);
    }

}

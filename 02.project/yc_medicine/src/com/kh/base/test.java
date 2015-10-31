package com.kh.base;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-8
 * Time: 下午5:42
 * To change this template use File | Settings | File Templates.
 */
public class test {
    public static void main(String[] args) {
//        Pattern pattern = Pattern.compile("\\d+");
//        Matcher matcher = pattern.matcher("9:00");
//        matcher.find();
////        matcher.start();   //返回0
////        matcher.end();   //返回3,原因相信大家也清楚了,因为matches()需要匹配所有字符串
//        System.out.println(matcher.group());    //返回2223
//          System.out.println(daysBetween("2015-08-10","2015-08-15"));
//        System.out.println(getDateAfter("2015-02-10", 10));
//        System.out.println(compare_date("12:00","12:00"));
//        System.out.println(Count());
//         double pre_result = Double.parseDouble("4.7985") * Math.pow(10, Double.parseDouble("01"));//计算出结果值
//         String result = String.valueOf(pre_result).substring(0, 6);
//         System.out.println(result);
//        try{
//            write();
//        }catch (Exception e){
//           e.printStackTrace();
//        }
//          String a="";
//          System.out.println(Integer.parseInt(a));
        String  a = "2"+2;
        String  b = "2"+2;
        String  c = "22";
        String  d = "2";
        String  e = d + 2;
        System.out.println(a);
        System.out.println(b);
        System.out.println(a == b);

    }

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

    public static String Count() {
        //打开dos调用路径
        Runtime run = Runtime.getRuntime();
        String result = "";
        try {
            String command1="cmd /c  D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/wfn614/bin/wfn.bat ";
            String command2=" && cd /D D: ";
            String command3=" && cd D:/sdfyy.cn/aspx/yjk/YjkWeb3/nm6.g77/sdfyy/YCCsA ";
            String command4=" && nmgo yccsa.ctl";
            Process process = run.exec(command1+command2+command3+command4);
            InputStream in = process.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(in));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
                result = result + line;
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void write() throws  Exception{
        String dir = "D:/123.txt";
        File file = new File(dir);
        FileOutputStream out = new FileOutputStream(file,true);
        OutputStreamWriter osw = new OutputStreamWriter(out, "UTF8");
        BufferedWriter bw = new BufferedWriter(osw);
        try {
            bw.write("789");
            bw.close();
            osw.close();
            out.close();
        } catch (Exception e) {
            throw new Exception(e);
        } finally {
            bw.close();
            osw.close();
            out.close();
        }
    }
}

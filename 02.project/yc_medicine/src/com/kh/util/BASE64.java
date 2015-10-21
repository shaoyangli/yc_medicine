package com.kh.util;

import java.text.SimpleDateFormat;
import java.util.Date;
//
//import sun.misc.BASE64Decoder;
//import sun.misc.BASE64Encoder;

public class BASE64 {
	 /**    
     * BASE64解密   
   * @param key          
     * @return          
     * @throws Exception          
     */              
    public static byte[] decryptBASE64(String key) throws Exception {               
//        return (new BASE64Decoder()).decodeBuffer(key);   
    	return null;
    }               
                  
    /**         
     * BASE64加密   
   * @param key          
     * @return          
     * @throws Exception          
     */              
    public static String encryptBASE64(byte[] key) throws Exception {               
//        return (new BASE64Encoder()).encodeBuffer(key);     
    	return null;
    }       
         
    public static void main(String[] args) throws Exception     { 
    	  SimpleDateFormat df = new SimpleDateFormat("HHmmssyyMMdd");//设置日期格式
          String xtime=df.format(new Date());
        String data = BASE64.encryptBASE64(xtime.getBytes());     
        System.out.println("加密前："+data);     
             
        byte[] byteArray = BASE64.decryptBASE64("MTY0OTQxMTMxMTA1");     
        System.out.println("解密后："+new String(byteArray));   
      
        System.out.println(xtime);
        
        //byte[] byteArray = BASE64.decryptBASE64(authkey);     
        String xauthkey=new String(byteArray);   
        String qian="",hou="";
        hou=xauthkey.substring(0, 6);
        qian=xauthkey.substring(6, 12);
        String time=qian+hou;
        System.out.println(hou+"time"+qian);
       System.out.println(time+"dd"+xtime);
        System.out.println( Long.parseLong(xtime)-Long.parseLong(time));
        System.out.println( Long.parseLong("131105172258")-Long.parseLong("131105172269"));
    } 
}

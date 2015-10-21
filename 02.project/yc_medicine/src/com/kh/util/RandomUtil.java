package com.kh.util;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

public class RandomUtil {

	/**
	 * @param args
	 * @throws java.io.IOException
	 */
	public static void main(String[] args) throws IOException {
		RandomUtil test=new RandomUtil();
		int [] r= 	test.random(0,100,5);
		for (int i=0;i<5;i++){
			System.out.println(r[i]);
		}
	}
	boolean  isDup(int []random,int ran){
	    for (int i = 0; i < random.length; i++) {
	        if(random[i]==ran) return true;
	    }
	    return false;
	}
	public  int[] random(int start,int end,int len){
		
	    int [] rst=new int[len];
	    Arrays.fill(rst,start-1);
	    Random r=new Random();
	    for (int i = 0; i < rst.length; ) {
	        int ran=r.nextInt(end-start+1)+start;
	        if(!isDup(rst, ran)){
	            rst[i++]=ran;
	        }
	     
	    }
	    return rst;
	}
}

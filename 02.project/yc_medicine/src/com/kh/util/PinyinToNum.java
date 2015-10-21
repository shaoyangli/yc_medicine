package com.kh.util;
/**
 * 该方法用于把拼音码转化为数字
 * @author kdj
 *
 */

public class PinyinToNum {
	private static String toNum(String str) {
		if (str == null || str.equals("")) {
			System.out.println("所传字符为空");
			return "";
		}
		else if (str.equals("A") || str.equals("B") || str.equals("C")) {
			return "2";
		}
		else if (str.equals("D") || str.equals("E") || str.equals("F")) {
			return "3";
		}
		else if (str.equals("H") || str.equals("I") || str.equals("G")) {
			return "4";
		}
		else if (str.equals("J") || str.equals("K") || str.equals("L")) {
			return "5";
		}
		else if (str.equals("M") || str.equals("N") || str.equals("O")) {
			return "6";
		}
		else if (str.equals("P") || str.equals("Q") || str.equals("R")
				|| str.equals("S")) {
			return "7";
		}
		else if (str.equals("T") || str.equals("U") || str.equals("V")) {
			return "8";
		}
		else if (str.equals("W") || str.equals("X") || str.equals("Y")
				|| str.equals("Z")) {
			return "9";
		}
		else {
			return "";
		}
	}
	
	public static String SpellToNum(String py) {
		String result = "";
		if(!py.equals("") && null != py) {
			char [] a = py.toCharArray();
			for(int i = 0;i < a.length;i++) {
				String aa = a[i]+ "";
				 result += toNum(aa);
			}
		}
		
		
		return result;
		
	}
	public static void main(String[] args) {
		String py = "陶乐乐";
		String pym = CnToSpell.getFirstSpell(py);
		System.out.println(pym);
		System.out.println(SpellToNum(pym)); 
	}
}

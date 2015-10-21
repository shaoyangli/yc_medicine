package com.kh.hsfs.action;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.json.JSONObject;
/*
 * 天气预报
*/
public class WeatherAction {
	private String result;
	private List list = new ArrayList();;

	public String findWeather() throws Exception {
		HttpURLConnection conn = null;
		String outstr = "";
		try {
			Properties prop = new Properties();
			InputStream inputStream = WeatherAction.class
					.getResourceAsStream("/weather.properties");
			// InputStream inputStream =
			// classLoader.getResourceAsStream("/weather.properties");
			prop.load(inputStream);
			String serviceCode = prop.getProperty("servicecode");
			/*
			 * Properties prop =null; ClassLoader classLoader =
			 * Thread.currentThread().getContextClassLoader(); InputStream
			 * inputStream =
			 * classLoader.getResourceAsStream("weather.properties");
			 * prop.load(inputStream); String serviceCode =
			 * prop.getProperty("servicecode");
			 */
			String strUrl = "http://www.weather.com.cn/data/cityinfo/"
					+ serviceCode + ".html";
			URL url = new URL(strUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			BufferedReader br = new BufferedReader(new InputStreamReader(conn
					.getInputStream(), "UTF-8"));
			String line = "";
			while ((line = br.readLine()) != null) {
				outstr = outstr + line;
			}
			br.close();
		} catch (Exception ex) {
			System.out.println("  网络异常，获取天气错误 ");
		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}
		JSONObject item1 = new JSONObject(outstr);
		// 得到对象中的对象
		JSONObject item = item1.getJSONObject("weatherinfo");
		// 获取对象中的每一个数值
		// String day = item.getString("date_y");
		// 日期
		// String week = item.getString("week");
		// 星期
		String city = item.getString("city");
		// 城市
		String weather = item.getString("weather");
		// 天气信息
		String temp = item.getString("temp1");
		String temp2 = item.getString("temp2");
		// 温度
		// String wind = item.getString("wind1");
		// 风力风向
		String img1 = item.getString("img1");
		// 天气图标
		String img2 = item.getString("img2");
		String ptime = item.getString("ptime");
		// list.add(map);
		// list.add(day);
		// list.add(week);
		list.add(city);
		list.add(weather);
		list.add(temp);
		list.add(temp2);
		// list.add(wind);
		list.add(img1);
		list.add(img2);
		list.add(ptime);
		return "success";
	}

	/*
	 * public static final String serviceCode; static { try { Properties prop =
	 * new Properties(); InputStream inputStream =
	 * WeatherAction.class.getResourceAsStream("/weather.properties");
	 * //InputStream inputStream =
	 * classLoader.getResourceAsStream("/weather.properties");
	 * prop.load(inputStream); serviceCode = prop.getProperty("servicecode"); }
	 * catch (Exception e) { throw new RuntimeException("Description.  Cause: "
	 * + e, e); } }
	 */

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

}

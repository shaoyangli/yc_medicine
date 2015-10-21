package com.kh.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGEncodeParam;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			CopyImageFromURL("f:/a.jpg", "F:/aa.jpg");
//			CopyImageFromURL(
//					"http://www.csdn.net/ui/styles/public_header_footer/logo_csdn.gif",
//					"E:/111/logo_csdn.jpg");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * @param imageURL
	 *            输入图片的URL完整路径，可以是本地文件，也可以是网路上的文件
	 * @param localPath
	 *            保存在本地的路径
	 * @throws Exception
	 */
	public static void CopyImageFromURL(String imageURL, String localPath)
			throws Exception {
		// 取得文件后缀名
		
		String tmpImageURL = imageURL.toLowerCase();
		String regex = "(\\.)(gif|bmp|png|dib|jpg|jpeg|jfif)";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(tmpImageURL);
		if (!matcher.find()) {
			throw new Exception("不支持该格式文件.");
		}
		URL url;
		if (imageURL.toLowerCase().startsWith("http")) {// http url
			url = new URL(imageURL);
		} else {// 文件url
			
			String tmpUrl = imageURL.toLowerCase();
			tmpUrl=tmpUrl.replace("\\\\", "/");
//			System.out.println(tmpUrl);
			String beginer = tmpUrl.split("/")[0];
			if (beginer.matches("[c-o]:")) {// 路径支持到c:d:....o:
				url = new File(imageURL).toURL();
			} else {
				throw new Exception("无法解析文件URL.");
			}
		}
//		System.out.println(imageURL.substring(imageURL.lastIndexOf(".")+1));
		if("png".equals(imageURL.substring(imageURL.lastIndexOf(".")+1))){
			BufferedImage src = ImageIO.read(url);
			writeHighQuality(zoomImage(src), imageURL);
		}
//		System.out.println(url);
		BufferedImage src = ImageIO.read(url);
		int width = src.getWidth(null);
		int height = src.getHeight(null);
		// 保存图像到本地
		int lastSep1 = localPath.lastIndexOf("/");
		int lastSep2 = localPath.lastIndexOf("\\");
		int lastSep = (lastSep1 >= lastSep2 ? lastSep1 : lastSep2);
		String path = localPath.substring(0, lastSep);
		File localDir = new File(path);
		if (!localDir.exists()) {
			localDir.mkdirs();
		}
//		System.out.println(src.getType());
		int type=src.getType();
		if(type==0){
			type=5;
		}
		float times=1f;
		if(width>5000){
			times=0.1f;
		}else if(width>4000){
			times=0.2f;
		}else if(width>3000){
			times=0.3f;
		}else if(width>2000){
			times=0.4f;
		}else if(width>800){
			times=0.5f;
		}
		
		int toWidth = (int) (Float.parseFloat(String.valueOf(width)) * times);
		int toHeight = (int) (Float.parseFloat(String.valueOf(height)) * times);
		BufferedImage outImg = new BufferedImage(toWidth, toHeight, type);
		System.out.println("-----");
		outImg.getGraphics().drawImage(src, 0, 0, toWidth, toHeight, null);
		FileOutputStream out = new FileOutputStream(localPath);
//		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
//		encoder.encode(outImg);

		out.close();
	}
//	public static void setnewfile(String oldfile,String newfile) throws Exception{
////		String newfile=oldfile.substring(0,oldfile.lastIndexOf("."))+"png";
//		URL url;
//		if (oldfile.toLowerCase().startsWith("http")) {// http url
//			url = new URL(oldfile);
//		} else {// 文件url
//			
//			String tmpUrl = oldfile.toLowerCase();
//			tmpUrl=tmpUrl.replace("\\\\", "/");
////			System.out.println(tmpUrl);
//			String beginer = tmpUrl.split("/")[0];
//			if (beginer.matches("[c-o]:")) {// 路径支持到c:d:....o:
//				url = new File(oldfile).toURL();
//			} else {
//				throw new Exception("无法解析文件URL.");
//			}
//		}
////		System.out.println(url);
//		BufferedImage src = ImageIO.read(url);
//		int width = src.getWidth(null);
//		int height = src.getHeight(null);
//		// 保存图像到本地
//		int lastSep1 = newfile.lastIndexOf("/");
//		int lastSep2 = newfile.lastIndexOf("\\");
//		int lastSep = (lastSep1 >= lastSep2 ? lastSep1 : lastSep2);
//		String path = newfile.substring(0, lastSep);
//		File localDir = new File(path);
//		if (!localDir.exists()) {
//			localDir.mkdirs();
//		}
////		System.out.println(src.getType());
//		int type=src.getType();
//		if(type==0){
//			type=5;
//		}
//		float times=1f;
//		if(width>5000){
//			times=0.1f;
//		}else if(width>4000){
//			times=0.2f;
//		}else if(width>3000){
//			times=0.3f;
//		}else if(width>2000){
//			times=0.4f;
//		}else if(width>=800){
//			times=0.5f;
//		}
//		
//		int toWidth = (int) (Float.parseFloat(String.valueOf(width)) * times);
//		int toHeight = (int) (Float.parseFloat(String.valueOf(height)) * times);
//		BufferedImage outImg = new BufferedImage(toWidth, toHeight, type);
//		System.out.println("-----png");
//		outImg.getGraphics().drawImage(src, 0, 0, toWidth, toHeight, null);
//		FileOutputStream out = new FileOutputStream(newfile);
//		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
//		encoder.encode(outImg);
//
//		out.close();
////		return newfile;
//	}
	public static boolean writeHighQuality(BufferedImage im, String newfile) {
		try {
			/* 输出到文件流 */
			FileOutputStream newimage = new FileOutputStream(newfile);
//			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
//			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(im);
//			/* 压缩质量 */
//			jep.setQuality(1f, true);
//			encoder.encode(im, jep);
//			/* 近JPEG编码 */
//			newimage.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	/**
	 * @param im
	 *            原始图像
	 * @param resizeTimes
	 *            倍数,比如0.5就是缩小一半,0.98等等double类型
	 * @return 返回处理后的图像
	 */
	public static BufferedImage zoomImage(BufferedImage im) {
		float times=1f;
		/* 原始图像的宽度和高度 */
		int width = im.getWidth();
		int height = im.getHeight();
		if(width>5000){
			times=0.1f;
		}else if(width>4000){
			times=0.2f;
		}else if(width>3000){
			times=0.3f;
		}else if(width>2000){
			times=0.4f;
		}else if(width>=800){
			times=0.5f;
		}
		

		/* 调整后的图片的宽度和高度 */
		int toWidth = (int) (Float.parseFloat(String.valueOf(width)) * times);
		int toHeight = (int) (Float.parseFloat(String.valueOf(height)) * times);

		/* 新生成结果图片 */
		BufferedImage result = new BufferedImage(toWidth, toHeight,
				BufferedImage.TYPE_INT_RGB);

		result.getGraphics().drawImage(
				im.getScaledInstance(toWidth, toHeight,
						java.awt.Image.SCALE_SMOOTH), 0, 0, null);
		return result;
	}
}

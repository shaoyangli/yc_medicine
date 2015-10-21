package com.kh.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class TestImage {
	public static void reduceImg(String imgsrc, String imgdist, int widthdist,   
	        int heightdist) {   
	    try {   
	        File srcfile = new File(imgsrc);   
	        if (!srcfile.exists()) {   
	            return;   
	        }   
	        Image src = javax.imageio.ImageIO.read(srcfile);   
	  
	        BufferedImage tag= new BufferedImage((int) widthdist, (int) heightdist,   
	                BufferedImage.TYPE_INT_RGB);   
	  
	        tag.getGraphics().drawImage(src.getScaledInstance(widthdist, heightdist,  Image.SCALE_SMOOTH), 0, 0,  null);   
	///         tag.getGraphics().drawImage(src.getScaledInstance(widthdist, heightdist,  Image.SCALE_AREA_AVERAGING), 0, 0,  null);   
	           
	        FileOutputStream out = new FileOutputStream(imgdist);   
//	        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);   
//	        encoder.encode(tag);   
	        out.close();   
	  
	    } catch (IOException ex) {   
	        ex.printStackTrace();   
	    }   
	}
	public static void main(String[] args) {
		//TestImage.reduceImg(imgsrc, imgdist, widthdist, heightdist);
	}
}

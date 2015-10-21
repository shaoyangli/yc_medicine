package com.kh.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.kh.util.ImageUtil;

/**
 * @Descrip: 调用openoffice服务,利用JODConverter.jar(转换器-v2.2.2)将office文档转换为pdf;
 *           然后调用swftools工具将pdf转换为swf 上传文件类型 doc docx,ppt pptx,xls
 *           xlsx,wps,et,dps,pdf,txt,jpg,jpeg,gif,png
 */
public class FileConvert {
	/**
	 * 涉及pdf2swf路径问题
	 */
	private final String CONVERTFILETYPE = "jpg,jpeg,font,gif,png,wav";
	private String swftoolsPath; // swftools工具的安装路径
	private String fileName;
	private String fileType;
	private File pdfFile;
	private File swfFile;
	private File srcFile;
	private static final int BUFFER_SIZE = 16 * 1024;

	/*
	 * 转换成swf
	 */
	private boolean pdf2swf(){
		boolean flag=false;
//		System.out.println(swftoolsPath + fileType + "2swf.exe "
//				+ srcFile + " -o " + swfFile
//				+ " ");
		try {
			Runtime runtime = Runtime.getRuntime();
//			System.out.println("swfFile");
			if (!swfFile.exists()) {
				if (pdfFile.exists()) {
					Process pro=runtime.exec(swftoolsPath + "pdf2swf.exe -qG -s disablelinks -s languagedir=\""+swftoolsPath+"xpdf-chinese-simplified\" "
							+ pdfFile.getPath() + " -o  "+swfFile.getPath()
							+ "  -f -T 9 -t -s storeallcharacters -s poly2bitmap ");
//					System.out.println(swftoolsPath + "pdf2swf.exe -qG -s disablelinks -s languagedir=\""+swftoolsPath+"xpdf-chinese-simplified\" "
//							+ pdfFile.getPath() + " -o  "+swfFile.getPath()
//							+ "  -f -T 9 -t -s storeallcharacters -s poly2bitmap ");
//					BufferedReader bufferedReader = new BufferedReader(
//							new InputStreamReader(pro.getInputStream()));
//					while (bufferedReader.readLine() != null) {
//
//					}
					System.out.println("-------开始转换pdf转swf");
					pro.waitFor();
					if(!fileType.equals("pdf")&&pdfFile.exists()) {
						pdfFile.delete();
					}
					System.out.println("-------2转换成功swf");
					if(!swfFile.exists()){//没转换成功
						flag=false;
					}else{
						flag=true;
					}
//					System.out.println("========");
				} else if (CONVERTFILETYPE.indexOf(fileType) != -1) {
					if("gif".equals(fileType)||"png".equals(fileType)){
						Process pro=runtime.exec(swftoolsPath + fileType + "2swf.exe "
								+ srcFile + " -o " + swfFile
								+ " ");
						pro.waitFor();
					}else{
						Process pro=runtime.exec(swftoolsPath + fileType + "2swf.exe "
								+ srcFile + " -o " + swfFile
								+ " -f -T 9 ");
						System.out.println(swftoolsPath + fileType + "2swf.exe  "
								+ srcFile + " -o " + swfFile
								+ " -f -T 9 ");
						pro.waitFor();
					}
//					System.out.println(swfFile.exists());
					if(!swfFile.exists()){//没转换成功
						flag=false;
					}else{
						flag=true;
					}
//					System.out.println(fileType+"===============");
				}
			} else {
				flag=true;
				System.out.println("****swf已存在不需要转换****");
			}
			
		} catch (Exception e) {
			System.out.println("****pdf转换swf错误****");
		}
        return flag;
	}

	

	/*
	 * 转换主方法
	 */
	public boolean convert(String fileString, String fileTomcat){
		fileString=fileTomcat+fileString;
		String newfile = "";
		fileString = fileString.replace("/", "\\").replace("\\", "\\\\");
		fileName = fileString.substring(0,fileString.lastIndexOf("."));
		swfFile = new File(fileName + ".swf");
		if(swfFile.exists()){
			return true;
		}
		this.swftoolsPath = fileTomcat + "\\flexpaper\\SWFTools\\";
		fileType = fileString.substring(fileString.lastIndexOf(".") + 1).toLowerCase();
		// 设置txt格式的转换命令
		if (fileType.equals("txt")) {
			newfile = fileString.substring(0, fileString.lastIndexOf("."))
					+ ".odt";
		}
		// 设置wps格式的转换命令
		if (fileType.equals("wps")) {
			newfile = fileString.substring(0, fileString.lastIndexOf("."))
					+ ".doc";
		}
		// 设置et格式的转换命令
		if (fileType.equals("et")) {
			newfile = fileString.substring(0, fileString.lastIndexOf("."))
					+ ".xls";
		}
		// 设置et格式的转换命令
		if (fileType.equals("dps")) {
			newfile = fileString.substring(0, fileString.lastIndexOf("."))
					+ ".ppt";
		}
		
        if(!newfile.equals("")){
    		InputStream in = null;
    		OutputStream out = null;
    		try {
    			in = new BufferedInputStream(new FileInputStream(new File(fileString)), BUFFER_SIZE);
    			out = new BufferedOutputStream(new FileOutputStream(new File(newfile)),
    						BUFFER_SIZE);
    			byte[] buffer = new byte[BUFFER_SIZE];
    			int len = 0;
    			while ((len = in.read(buffer)) > 0) {
    				out.write(buffer, 0, len);
    			}
    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			if (null != in) {
    				try {
    					in.close();
    					out.close();
    				} catch (IOException e) {
    					e.printStackTrace();
    				}
    			}
    		}
        }else{
        	newfile=fileString;
        }
     // 设置png格式的转换命令
		if (fileType.equals("png")||fileType.equals("gif")||fileType.equals("jpeg")||fileType.equals("jpg")) {
			newfile = fileString.substring(0, fileString.lastIndexOf("."))
					+ ".jpg";
			fileType="jpeg";
			System.out.println(fileString);
//			System.out.println(newfile);
			try {
				ImageUtil.CopyImageFromURL(fileString, newfile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			System.out.println(fileType);
		}
		srcFile = new File(newfile);
		pdfFile = new File(fileName + ".pdf");
		// 设置jpg图片格式的转换命令
		if (fileType.equals("jpg")) {
			fileType = "jpeg";
		}
//		System.out.println("-----");
		boolean flag=false;
		try {
			if(CONVERTFILETYPE.indexOf(fileType) == -1) {
				if (srcFile.exists()) {
					if (!pdfFile.exists()) {
						// connect to an OpenOffice.org instance running on port 8100
						OpenOfficeConnection connection = new SocketOpenOfficeConnection(
								"127.0.0.1", 8100);
						try {
							connection.connect();
							// 获取转换器
							DocumentConverter converter = new OpenOfficeDocumentConverter(
									connection);
							// 开始转换
							converter.convert(srcFile, pdfFile);
							// 转换成功，关闭连接
							connection.disconnect();
							flag=pdf2swf();
						} catch (java.net.ConnectException e) {
							System.out.println("****openoffice服务未启动！****");
						} catch (com.artofsolving.jodconverter.openoffice.connection.OpenOfficeException e) {
//							e.printStackTrace();
							System.out.println("****swf转换器异常，读取转换文件失败****"+e.getMessage());
						}
					} else {
						System.out.println("****已经转换为pdf，不需要再进行转化****");
						flag=pdf2swf();
					}	
				} else {
					System.out.println("****swf转换器异常，需要转换的文档不存在，无法转换****");
				}
			}else{
				flag=pdf2swf();
			}
		} catch (Exception e) {
			e.printStackTrace();
			flag=false;
		}
		return flag;
	}
	
	public static void main(String[] args){
		String fileString="upload/aa.jpg";
		String fileTomcat="E:/soft/tomcat6.0/webapps/hsfs/";
		FileConvert file=new FileConvert();
		System.out.println(file.convert(fileString,fileTomcat));
	}
	//http://blog.sina.com.cn/s/blog_852ca01901016xax.html

}

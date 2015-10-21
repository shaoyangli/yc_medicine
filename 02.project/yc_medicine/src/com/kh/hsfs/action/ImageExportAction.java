package com.kh.hsfs.action;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.batik.transcoder.Transcoder;
import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.fop.svg.PDFTranscoder;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;

public class ImageExportAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {

    /**
     * 
     */
    private static final long serialVersionUID = 7547110498655678209L;
    private HttpServletRequest request;
    private HttpServletResponse response;
    public String execute() throws Exception   {
    	request.setCharacterEncoding("utf-8");// 设置编码，解决乱码问题
		String type = request.getParameter("type");
		String svg = request.getParameter("svg");
		String filename = request.getParameter("filename");
		filename = filename == null ? "chart" : filename;
		ServletOutputStream out = response.getOutputStream();
		try {
		if (null != type && null != svg) {
			svg = svg.replaceAll(":rect", "rect");
			String ext = "";
			Transcoder t = null;
			if (type.equals("image/png")) {
				ext = "png";
				t = new PNGTranscoder();
			} else if (type.equals("image/jpeg")) {
				ext = "jpg";
				t = new JPEGTranscoder();
			}
			else if (type.equals("application/pdf")) {
				ext = "pdf";
				t = new PDFTranscoder();

			} else if (type.equals("image/svg+xml"))
				ext = "svg";
			response.addHeader("Content-Disposition", "attachment; filename="
					+ filename + "." + ext);
			response.addHeader("Content-Type", type);

			if (null != t) {
				TranscoderInput input = new TranscoderInput(new StringReader(
						svg));
				TranscoderOutput output = new TranscoderOutput(out);

				try {
					t.transcode(input, output);
				} catch (TranscoderException e) {
					System.out
							.print("Problem transcoding stream. See the web logs for more details.");
					e.printStackTrace();
				}
			} else if (ext.equals("svg")) {
				
				OutputStreamWriter writer = new OutputStreamWriter(out);
				writer.append(svg);
				writer.close();
			} else
				out.print("Invalid type: " + type);
		} else {
			response.addHeader("Content-Type", "text/html");
			out
					.println("Usage:\n\tParameter [svg]: The DOM Element to be converted."
							+ "\n\tParameter [type]: The destination MIME type for the elment to be transcoded.");
		}
		}catch(IllegalStateException e){
			System.out.println(e.getMessage());
		
		}finally{
			out.flush();
			out.close();
		}
		
        return SUCCESS;

    }
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}
    
}

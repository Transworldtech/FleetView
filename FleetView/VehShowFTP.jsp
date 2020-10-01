<%@ page language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@page import ="javax.imageio.*" %>
<%@page import =" javax.imageio.ImageIO"%>
<%@page import="java.awt.Image"%>
<%@ page import=" javax.swing.JFrame"%>
<%@ page import="javax.swing.ImageIcon"%>
<%@page import="javax.swing.JLabel"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
String s1=request.getParameter("ftpFile");
System.out.println("********  "+s1);
//System.out.println(s1+"%% "+s1.replace("%"," ")); 
//s1=s1.replace("%"," ");
 File savedFile;
 
//                        String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir"); 
// 					   System.out.println("IIIIIII  "+FileUploadPath);
// 						File uploadDir = new File(FileUploadPath);
// 						System.out.println("IIIIIII  "+uploadDir.toString());
						savedFile = new File("/images1/vehmaintainance/"+s1);
						String url = "";
						System.out.println("******8   "+url);
						//savedFile = new File("/images1/images1/Screenshot.png");
						System.out.println("*****((((  "+savedFile);
						
					if(savedFile.exists())
					{
						//out.println("********   Exist   ");
					}
					else
					{
						//out.println("******** Not Exist   ");
					}
					
		//out.println("*******   "+savedFile);			
%>
<!-- <a href="/images1/images1/DayStop Calc.png 08-Apr-2012 15:52">click here</a>-->
<img  src="<%=savedFile %>" width="700" height="600" style="vertical-align: middle;margin-left: 10em;margin-top: 1em;">
<%
System.out.println("*********8^^^^^^");
%>
</body>
</html>



<%@ include file="Connections/conn.jsp" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 <%@ page import="java.io.*,java.util.*, javax.servlet.*" %>

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5,st15,st16;
%>

<%
   Date date = new Date();

%>

<% 

	int i=1;
  
	String date2="";
	String user=session.getAttribute("mainuser").toString();
	String transporter=session.getAttribute("usertypevalue").toString();
	String vehid=request.getParameter("vehid");
	System.out.println("vehidvehidvehidvehidvehidvehidon insert querry page *********:-"+vehid);
	String VehRegNo=request.getParameter("VehRegNo");
	System.out.println("VehRegNo insert querry page *********:-"+vehid);
	
	
	String Make=request.getParameter("element_3_1");
	System.out.println("Make*************************************************:-"+Make);
	String SerialNumber=request.getParameter("element_3_2");
	System.out.println("Serial_Number*************************************************:-"+SerialNumber);

	String OilGrade=request.getParameter("element_3_3");
	System.out.println("Oil_Grade*************************************************:-"+OilGrade);
	
	String OilCapacity=request.getParameter("element_3_4");
	System.out.println("Oil_Capacity*************************************************:-"+OilCapacity);
	
	String Type=request.getParameter("element_3_5");
	System.out.println("Type*************************************************:-"+Type);
	
	String Ratio=request.getParameter("element_3_6");
	System.out.println("Ratio*************************************************:-"+Ratio);
	
	String NoOfUnits=request.getParameter("element_3_7");
	System.out.println("NoOfUnits*************************************************:-"+NoOfUnits);
	String FlangeSize=request.getParameter("element_3_9");
	System.out.println("FlangeSize*************************************************:-"+FlangeSize);
	String ShaftDetails=request.getParameter("element_3_8");
	System.out.println("ShaftDetails*************************************************:-"+ShaftDetails);
	
 	
	String datenew1="",datenew2="",Date4="",Date1="";
	
	
 	
	 
	 
	 
	 System.out.println("DisplayDate*************DisplayDate*************DisplayDate***************DisplayDate********:-");

Date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

	
	
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st15=con1.createStatement();
st16=con1.createStatement();
ResultSet rst=null;


	
	int cnt=0,cnt1=0;
	int sqlst=0;
	

	
	try{
			
			    String insrtmaster="insert into db_gps.t_pto (Make,Owner,insertDate,Serial_Number, Oil_Grade,Oil_Capacity ,Type,Ratio,No_Of_Outputs,Shaft_Details,flange_Size, Entryby,Vehcode ) values('"+Make+"','"+transporter+"','"+Date4+"','"+SerialNumber+"','"+OilGrade+"','"+OilCapacity+"','"+Type+"','"+Ratio+"','"+NoOfUnits+"','"+ShaftDetails+"','"+FlangeSize+"','"+user+"','"+vehid+"') ";
				System.out.println("ptopooooooo*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
				
				 String insrtmaster1="insert into db_gps.t_ptohistory (Make,Owner,insertDate,Serial_Number, Oil_Grade,Oil_Capacity ,Type,Ratio,No_Of_Outputs,Shaft_Details,flange_Size, Entryby,Vehcode ) values('"+Make+"','"+transporter+"','"+Date4+"','"+SerialNumber+"','"+OilGrade+"','"+OilCapacity+"','"+Type+"','"+Ratio+"','"+NoOfUnits+"','"+ShaftDetails+"','"+FlangeSize+"','"+user+"','"+vehid+"') ";
					System.out.println("ptopooooooo*************************************************:-"+insrtmaster1);
					cnt=st16.executeUpdate(insrtmaster1);
				
				
				}catch(Exception e)
		  {e.printStackTrace();}

	


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 	 if(cnt>=1)
 	 {
 		 //cnt=0;
 	out.println("<script type='text/javascript'>alert('Pto Inserted Successfully');");
 	out.println("location='showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo+"'");
 	out.println("</script>");
 	//out.println("location='showperipheralsDet.jsp'");
 	//response.sendRedirect("alertGoTo.jsp?msg=Opportunity Saved Successfully In System&goto=showperipheralsDet.jsp?VehId="+vehid+"");


 	//response.sendRedirect("AlertGoTo.jsp?msg=Pto Inserted Successfully &goto=showperipheralsDet.jsp?VehId="+vehid+"");
 	
	 	 }else{
 		  out.println("<script type='text/javascript'>alert('Record Already Inserted For This Vehicle');");
 		 out.println("location='showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo+"'");
 		  out.println("</script>");
 		 //response.sendRedirect("AlertGoTo.jsp?msg=Record Already Exit..&goto=showperipheralsDet.jsp?VehId="+vehid+"");
 		//response.sendRedirect("alertGoTo.jsp?msg=Opportunity Saved Successfully In System&goto=showperipheralsDet.jsp?VehId="+vehid+"");
 			
			 
 	 }
	





%>
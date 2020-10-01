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
	String VehRegNo=request.getParameter("VehRegNo");
	
	
	String rid=request.getParameter("rid");
	String Make=request.getParameter("element_3_1");
	System.out.println("Make*************************************************:-"+Make);
	String Model=request.getParameter("element_3_2");
	System.out.println("Model*************************************************:-"+Model);

	String Oil_Grade=request.getParameter("element_3_3");
	System.out.println("Oil_Grade*************************************************:-"+Oil_Grade);
	
	String Oil_Capacity=request.getParameter("element_3_4");
	System.out.println("Oil_Capacity*************************************************:-"+Oil_Capacity);
	
	String Serial_Number=request.getParameter("element_3_5");
	System.out.println("Serial_Number*************************************************:-"+Serial_Number);
	
	String Drive=request.getParameter("element_3_6");
	System.out.println("DriveDrive*************************************************:-"+Drive);
	
	String Type=request.getParameter("element_3_7");
	System.out.println("Type*************************************************:-"+Type);
	String jetting_pressure_rating=request.getParameter("element_3_8");
	System.out.println("jetting_pressure_rating*************:-"+jetting_pressure_rating);
	String power=request.getParameter("element_3_9");
	System.out.println("power*************************************************:-"+power);
	
	String suction_strainer=request.getParameter("element_3_10");
	System.out.println("suction_strainer*************************:-"+suction_strainer);
	
	
	String rotation=request.getParameter("element_3_11");
	
	String piston_size=request.getParameter("element_3_12");
	
	String seal_size=request.getParameter("element_3_13");
	
	String accumulator_make=request.getParameter("element_3_14");
	
	String Model_No=request.getParameter("element_3_15");
	
	String cooler=request.getParameter("element_3_16");
 	
	String datenew1="",datenew2="",Date4="",Date1="";
	
	
	
	String vehid=request.getParameter("vehid");
	
 	
	 
	 
	 
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
			
			    String insrtmaster="Update db_gps.t_jettingpump Set Make='"+Make+"',Owner='"+transporter+"',Model='"+Model+"',insertDate='"+Date4+"',Serial_Number='"+Serial_Number+"', Oil_Grade='"+Oil_Grade+"',Oil_Capacity='"+Oil_Capacity+"' ,Drive='"+Drive+"',jetting_pressure_rating='"+jetting_pressure_rating+"',power='"+power+"',suction_strainer='"+suction_strainer+"',rotation='"+rotation+"',piston_size='"+piston_size+"',seal_size='"+seal_size+"',accumulator_make='"+accumulator_make+"',Model_No='"+Model_No+"',Type='"+Type+"',cooler='"+cooler+"',Entryby='"+user+"' where Rid='"+rid+"' ";
				System.out.println("ptopooooooo*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
				 String insrtmaster1="insert into db_gps.t_jettingpumphistory (Vehcode,Make,Owner,Model,insertDate,Serial_Number, Oil_Grade,Oil_Capacity ,Drive,jetting_pressure_rating,power,suction_strainer,rotation,piston_size,seal_size,accumulator_make,Model_No,Type,cooler,Entryby ) values('"+vehid+"','"+Make+"','"+transporter+"','"+Model+"','"+Date4+"','"+Serial_Number+"','"+Oil_Grade+"','"+Oil_Capacity+"','"+Drive+"','"+jetting_pressure_rating+"','"+power+"','"+suction_strainer+"','"+rotation+"','"+piston_size+"','"+seal_size+"','"+accumulator_make+"','"+Model_No+"','"+Type+"','"+cooler+"','"+user+"') ";
					System.out.println("ptopooooooo*************************************************:-"+insrtmaster1);
					cnt=st16.executeUpdate(insrtmaster1);
				
				
				}catch(Exception e)
		  {e.printStackTrace();}

	


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 	 if(cnt>=1)
 	 {
 		 //cnt=0;
 	out.println("<script type='text/javascript'>alert('Jetting Record Updated Successfully');");
 	out.println("location='showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo+"'");
 	//response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
 	//out.println("location='showperipheralsDet.jsp'");
 	out.println("</script>");
	
 	 }else{
 		  out.println("<script type='text/javascript'>alert('Record Already Present For This Vehicle Id');");
 			//out.println("location='showperipheralsDet.jsp'");
 			//response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
 			out.println("location='showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo+"'");
 			out.println("</script>");
			 
 	 }
	





%>
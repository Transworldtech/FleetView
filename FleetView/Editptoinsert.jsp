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
  	 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%> 	 
  	 
  	 
<%! Connection conn=null;%>
<%! Connection conn1=null;%>
<%! Connection conn2=null;%>
<%! Connection conn3=null;%>
<%! Connection conn4=null;%>

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5,st15,st16;
String VehCode="";
%>


<%

conn = fleetview.ReturnConnection();
conn1 = fleetview.ReturnConnection();
conn2 = fleetview.ReturnConnection();
conn3 = fleetview.ReturnConnection();
conn4 = fleetview.ReturnConnection();
Statement st=null,st1=null,st2=null,st3=null,st4=null;
String sql=null;
ResultSet rst=null,rst1=null,rst2=null,rst3=null,rst4=null;
st=conn.createStatement();
st1=conn1.createStatement();
st2=conn2.createStatement();
st3=conn3.createStatement();
st4=conn4.createStatement();

%>


<%
   Date date = new Date();





%>

<% 

	int i=1;
  
	String date2="";
	String user=session.getAttribute("mainuser").toString();
	String transporter=session.getAttribute("usertypevalue").toString();
	String rid=request.getParameter("rid");
	
	String vehidnew=request.getParameter("vehid");
	String VehRegNo=request.getParameter("vehregno");
	
	
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
	String FlangeSize=request.getParameter("element_3_8");
	System.out.println("FlangeSize*************************************************:-"+FlangeSize);
	String ShaftDetails=request.getParameter("element_3_9");
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



	
	int cnt=0,cnt1=0;
	int sqlst=0;
	

	
	try{
			
			    String insrtmaster="Update  db_gps.t_pto set Make='"+Make+"',Owner='"+transporter+"',insertDate='"+Date4+"',Serial_Number='"+SerialNumber+"', Oil_Grade='"+OilGrade+"',Oil_Capacity='"+OilCapacity+"',Type='"+Type+"',Ratio='"+Ratio+"',No_Of_Outputs='"+NoOfUnits+"',Shaft_Details='"+ShaftDetails+"',flange_Size='"+FlangeSize+"', Entryby='"+user+"' where rid='"+rid+"' ";
				System.out.println("ptopooooooo*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
				
				 String insrtmaster1="insert into db_gps.t_ptohistory (Make,Owner,insertDate,Serial_Number, Oil_Grade,Oil_Capacity ,Type,Ratio,No_Of_Outputs,Shaft_Details,flange_Size, Entryby ) values('"+Make+"','"+transporter+"','"+Date4+"','"+SerialNumber+"','"+OilGrade+"','"+OilCapacity+"','"+Type+"','"+Ratio+"','"+NoOfUnits+"','"+ShaftDetails+"','"+FlangeSize+"','"+user+"') ";
					System.out.println("ptopooooooo*************************************************:-"+insrtmaster1);
					cnt=st16.executeUpdate(insrtmaster1);
					
					
					
				}catch(Exception e)
		  {e.printStackTrace();}

	


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 	 if(cnt>=1)
 	 {
 		 //cnt=0;
 	out.println("<script type='text/javascript'>alert('Pto Updated Successfully');");
 //	response.sendRedirect("showperipheralsDet.jsp?VehId="+vehidnew+"&VehRegNo="+VehRegNo);
 out.println("location='showperipheralsDet.jsp?VehId="+vehidnew+"&VehRegNo="+VehRegNo+"'");
 	out.println("</script>");
	
 	 }else{
 		  out.println("<script type='text/javascript'>alert('Record Already Present For This Vehicle Id');");
 		// response.sendRedirect("showperipheralsDet.jsp?VehId="+vehidnew+"&VehRegNo="+VehRegNo);
 		out.println("location='showperipheralsDet.jsp?VehId="+vehidnew+"&VehRegNo="+VehRegNo+"'");
 		 out.println("</script>");
			 
 	 }
	





%>
</jsp:useBean>
<%@ include file="Connections/conn.jsp" %>

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
String datenew1="",datenew2="",datenew3="",date2="";
%>

<%
   Date date = new Date();
String transporter=session.getAttribute("usertypevalue").toString();

datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
%>

<% 

	
	String user=session.getAttribute("mainuser").toString();

	
	//String transporter=request.getParameter("element_3_1");
	System.out.println("transporter**********update page***************************************:-"+transporter);
	String fueltype=request.getParameter("element_3_2");
	System.out.println("Vendor*********************update page****************************:-"+fueltype);
 	String rid=request.getParameter("rid1");
 	System.out.println("rid***************************update page**********************:-"+rid);
	String fuelrate=request.getParameter("element_3_3");
	System.out.println("cardtype*************************************************:-"+fuelrate);
	
String	Date1=request.getParameter("fueldate");
	 Date1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  	System.out.println("Date11111111*************************************************:-"+Date1);
// 	String currency=request.getParameter("currency");
// 	System.out.println("currency*************************************************:-"+currency);
	
 	String EntryBy=request.getParameter("entryby");
 	System.out.println("EntryByEntryByEntryByEntryBy*************************************************:-"+EntryBy);
 	
	
 	
 
	 
	
		
		date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fueldate")));
		System.out.println("date2date2date2date2date2date2date2date2"+date2);
	
	
	
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
			
			    String insrtmaster="Update db_gps.t_Defaultfuelratemaster SET fuel='"+fueltype+"',rate='"+fuelrate+"' , transporter='"+transporter+"', declare_date='"+date2+"' where rid='"+rid+"' limit 1";
				System.out.println("fulmaster*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
	}catch(Exception e)
	  {e.printStackTrace();}
				
 				String insrtmaster1="insert into db_gps.t_fuelratemasterhistory (Entryby,fuel,rate,transporter,insertDate,declare_date) values('"+EntryBy+"','"+fueltype+"','"+fuelrate+"','"+transporter+"','"+Date1+"','"+date2+"') ";
 				System.out.println("fulmaster*************************************************:-"+insrtmaster1);
 				cnt=st16.executeUpdate(insrtmaster1);
		
				
		
	%>
	
		
	<% 
	


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 	 if(cnt>=1)
 	 {
 		 //cnt=0;
 	out.println("<script type='text/javascript'>alert('Fuel Rate Inserted Sucessfully..');");
 	out.println("location='FuelMasterReport.jsp'");
 	out.println("</script>");
	
 	 }else{
 		  out.println("<script type='text/javascript'>alert('Fuel Rate Not Inserted..');");
 			out.println("location='FuelMasterReport.jsp'");
 			out.println("</script>");
			 
 	 }
	




%>
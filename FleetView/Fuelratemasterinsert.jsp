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
try {
	int i=1;
  
	String date2="";
	String user=session.getAttribute("mainuser").toString();
	String transporter=session.getAttribute("usertypevalue").toString();

	System.out.println("transporter*************************************************:-"+transporter);
	String fueltype=request.getParameter("element_3_2");
	System.out.println("Vendor*************************************************:-"+fueltype);
 	String rid=request.getParameter("rid");
 	System.out.println("rid*************************************************:-"+rid);
	String fuelrate=request.getParameter("element_3_3");
	System.out.println("cardtype*************************************************:-"+fuelrate);
 	
	String datenew1="",datenew2="",Date4="",Date1="";
	
	//String mine=request.getParameter("fueldate");
// 	 String MyDate = request.getParameter("DayCal");
	
	
// 	String MyDate = request.getParameter("fueldate");
	
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fueldate")));
	System.out.println("date2date2date2date2date2date2date2date2"+date2);
// 	try {


// 		String MyDate = request.getParameter("fueldate");
// 		SimpleDateFormat convertDate = new SimpleDateFormat("yyyy-MM-dd");
// 		Date anniversaryDate = convertDate.parse(MyDate);
// 		System.out.println(anniversaryDate);
// 		}

// 		catch(Exception e) {
// 		e.printStackTrace();
// 		System.err.println(e.getMessage());
// 		}
	

	
	 
// 	 Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//  		Format fmt1 = new SimpleDateFormat("yyyy-MM-dd");
//  		SimpleDateFormat sdfIn = new SimpleDateFormat("dd-MMM-yyyy");
//  		 SimpleDateFormat sdfOut = new SimpleDateFormat("yyyy-MM-dd");
 	
	 
	 
	 
	 System.out.println("DisplayDate*************DisplayDate*************DisplayDate***************DisplayDate********:-");

Date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
// 	Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Date));
// 	String currency=request.getParameter("currency");
// 	System.out.println("currency*************************************************:-"+currency);
	
// 	String entryby=request.getParameter("entryby");
// 	System.out.println("entryby*************************************************:-"+entryby);
	
	
	
	
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
			
			    String insrtmaster="insert into db_gps.t_Defaultfuelratemaster (Entryby,fuel,rate,transporter,insertDate, declare_date) values('"+user+"','"+fueltype+"','"+fuelrate+"','"+transporter+"','"+Date4+"','"+date2+"') ";
				System.out.println("fulmaster*************************************************:-"+insrtmaster);
				cnt=st15.executeUpdate(insrtmaster);
				
				
				String insrtmaster1="insert into db_gps.t_fuelratemasterhistory (Entryby,fuel,rate,transporter,insertDate,declare_date) values('"+user+"','"+fueltype+"','"+fuelrate+"','"+transporter+"','"+Date4+"','"+date2+"') ";
				System.out.println("fulmaster*************************************************:-"+insrtmaster1);
				cnt=st16.executeUpdate(insrtmaster1);
				
				}catch(Exception e)
		  {e.printStackTrace();}
		
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
	
} catch(Exception e) { 
	out.print("NotDone");
	}


	finally
	{
		//st.close();
		//st1.close();
		//con1.close();
	}

%>
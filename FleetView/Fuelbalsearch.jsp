<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%-- <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%> --%>
   <%@ page import="java.sql.*" %>

  	<%-- <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%> --%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {
	//out.println("here********************************************************************");
	String owner=session.getAttribute("usertypevalue").toString();
	//out.println("here"+owner);
	String user=session.getAttribute("mainuser").toString();
	//out.println("here"+user);
	//String routeid=request.getParameter("routid");
	String fuelbalance=request.getParameter("fuelbalance");
	String test[]=fuelbalance.split(",");
	//out.println("here"+test.toString());
	String totalfuelbalence=request.getParameter("totalfuelbalence");
	//out.println("here"+fuelplan);
	//String StartCode=request.getParameter("StartPlace");
	//out.println("here"+StartCode);
	//String EndCode=request.getParameter("EndPlace");
	//out.println("EndCode"+EndCode);
	
	//String Totaldistance=request.getParameter("Kmval");
	//double Totaldistancem=Double.parseDouble(Totaldistance);
	//System.out.println("fulmaster**Totaldistance***Totaldistancem********************************************"+Totaldistancem);
	//System.out.println("fulmaster**Totaldistance***********************************************"+Totaldistance);
	//double que=Double.parseDouble(Quantity);
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String insertdate = fmt.format(new java.util.Date());
		//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",body="",prevoiusdistance="0";
boolean flag=false;
String sql3="";
String Rname="",nodays="";
int nday;
Double fuelbalance1=0.0,totalfuelbalence1=0.0,reslt=0.0,finalreslt=0.0;
String fmt1 = "yyyy-MM-dd";
String fmt2 = "dd-MMM-yyyy";
//String dt = "2016-04-22";
java.text.DateFormat df = new java.text.SimpleDateFormat(fmt1);
java.text.DateFormat df1 = new java.text.SimpleDateFormat(fmt2);
java.util.Calendar cal = java.util.Calendar.getInstance();

try{
	//out.println("test.length:-"+test.length);
	for(int i=0;i<test.length;i++){
		
	totalfuelbalence1=Double.parseDouble(totalfuelbalence);
	//out.println("totalfuelbalence1:-"+totalfuelbalence1);
	fuelbalance1=Double.parseDouble(test[i]);
	//out.println("fuelbalance1:-"+fuelbalance1);
	
	reslt=totalfuelbalence1-fuelbalance1;
	finalreslt+=reslt;
	//out.println("reslt:-"+reslt);
	}
	out.println(finalreslt);
	
}catch(Exception e){
	e.printStackTrace();
}


} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		//st.close();
		//st1.close();
		con1.close();
	}

%>
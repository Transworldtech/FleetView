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
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {

	String routeid=session.getAttribute("routeid").toString();
			//request.getParameter("routid");
	
	//System.out.println("routeid**************************************************************************************:-"+routeid);
	String routename=request.getParameter("routname");
	//System.out.println("routename**************************************************************************************:-"+routename);
	String rlocation=request.getParameter("element_3_3");
	//System.out.println("rlocation**************************************************************************************:-"+rlocation);
	String StartPlace=request.getParameter("StartPlace");
	//System.out.println("StartPlace**************************************************************************************:-"+StartPlace);
	String EndPlace=request.getParameter("EndPlace");
	//System.out.println("EndPlace**************************************************************************************:-"+EndPlace);
	String RouteCode=request.getParameter("RouteCode");
	//System.out.println("RouteCode**************************************************************************************:-"+RouteCode);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",body="";
boolean flag=false;
String sql3="";
try{
String fulmaster="update db_gps.t_castrolroutetest set FuelIssuePlan=?,totalfuel=? where StartPlace=? and EndPlace=? and RouteCode=? ";
System.out.println("fulmaster*************************************************:-"+fulmaster);
PreparedStatement ps=con1.prepareStatement(fulmaster);
System.out.println("fulmaster*************************************************:-"+fulmaster);
ps.setString(1, rlocation);
ps.setString(2, "10");
ps.setString(3, StartPlace);
ps.setString(4, EndPlace);
ps.setString(5, RouteCode);

ps.executeUpdate();

//if(rlocation.equals("Geofence")){
	response.sendRedirect("Geofencewiseset.jsp");	
//}else if(rlocation.equals("Distance")){
	
//}else if(rlocation.equals("Daywise")){
	
//}else{
	
//}
 
//System.out.println("fulmaster**************************************************************************************:-");
 //return;

}catch(Exception e)
{e.printStackTrace();}

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		st1.close();
		con1.close();
	}

%>
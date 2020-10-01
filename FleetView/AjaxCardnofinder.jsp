<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%-- <%@ include file="header.jsp" %> --%>
<%@ include file="Connections/conn.jsp" %>
<%@page import="com.fleetview.beans.AdhocAjaxRequest"%>
<%!
Connection con1;
%>

<%
try {
    
    
    Class.forName(MM_dbConn_DRIVER);
//	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    Statement stmt1=con1.createStatement();
    Statement stmt2=con1.createStatement();
    //ResultSet rs2=null;
    //ResultSet rs3=null;
    String sql=""; String sql1="";
    String owner=session.getAttribute("usertypevalue").toString();
    String user=session.getAttribute("mainuser").toString();
    //AdhocAjaxRequest ar=new AdhocAjaxRequest();
    //String buffer=ar.accept(owner,fuelserch);
    String Drivername=request.getParameter("driverinfo");
	String Driverinfo[]=Drivername.split("-");
	
    String TripID ="",TripIDnew="";
	
	String buffer="",cardno="",cardvendor="";
	
	try{
		String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='"+Driverinfo[1]+"' ";
		PreparedStatement ps9=con1.prepareStatement(record9);
		ResultSet rs9=ps9.executeQuery();
	    if(rs9.next()){
	    	cardno=rs9.getString("cardno");
	    	cardvendor=rs9.getString("companyname");
	     }
		 
	}catch(Exception e){
		e.printStackTrace();
	}
	   out.println(cardno);

	   buffer=null;

} 
catch(Exception e)
	{
		out.println(e);
	}

finally
{
con1.close();
}
%>
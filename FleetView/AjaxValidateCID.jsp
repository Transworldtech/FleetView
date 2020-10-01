<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	String txtBCleanerId=request.getParameter("txtCleanerId");
	String transporter=request.getParameter("transporter");
	System.out.println(" transporter "+transporter);

	//out.print("txtBCleanerId "+txtBCleanerId);
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement();
	
	String str=" select Cleanerid from db_gps.t_cleaners where  Status='Active' and Cleanerid='"+txtBCleanerId+"'" ;
	//Owner='"+transporter+"' and
	System.out.println(" Ajax db query "+str);
	ResultSet rst=stmt1.executeQuery(str);
	if(rst.next())
	{
		String Cleanerid1=rst.getString("Cleanerid");
		out.println("true");
	}
	else
	{
		out.println("false");
	}
	
%>

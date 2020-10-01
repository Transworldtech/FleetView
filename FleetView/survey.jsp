<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con;
Statement st,st1;
%>
<%
try{
	
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	
String user = session.getAttribute("mainuser").toString();
String typevalue = session.getAttribute("usertypevaluemain").toString();
String firstname = session.getAttribute("fname").toString();
String lastname = session.getAttribute("lname").toString();
String userip = request.getRemoteAddr();
String reportno = request.getParameter("reportno");
String reportname = request.getParameter("reportname");
String typeofuser = session.getAttribute("TypeofUserMain").toString();

String sql = "insert into db_gps.t_surveydetails (username,firstname,lastname,typevalue,typeofuser,UserIp,reportno,reportname) values "+
                     " ('"+user+"','"+firstname+"','"+lastname+"','"+typevalue+"','"+typeofuser+"','"+userip+"','"+reportno+"','"+reportname+"') ";
st.executeUpdate(sql);

response.sendRedirect("http://www.surveymonkey.com/s/7PNB3Q2");
}catch(Exception e)
{
	out.print("Exception "+e);
}finally
{
	con.close();
}
%>

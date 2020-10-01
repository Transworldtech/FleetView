<%@page import="java.util.Date"%><%@ include file="Connections/conn.jsp" %>
<%@ page buffer="16kb" %>
<%!
Connection con1;
%>
<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();
String user=session.getValue("user").toString();
System.out.println("user-->"+user);
/*****GETTING PARAMETER FROM ENTRY FORM PAGE****/
String studentid=request.getParameter("studentid");
String fullname=request.getParameter("fullname");
String calender=request.getParameter("calender");
String standerd=request.getParameter("class1");
String gender=request.getParameter("gender");
String parent=request.getParameter("parent");
String contact=request.getParameter("contact");
String relation=request.getParameter("relation");
String school=request.getParameter("school");
String address=request.getParameter("address");
String studentname="";
String sql="select * from t_studentdetails where CardID='"+studentid+"'";
ResultSet rs1=stmt1.executeQuery(sql);
if(rs1.next())
{
	studentname=rs1.getString("StudentName");
	response.sendRedirect("StudentDetailsEntry.jsp?studname='"+studentname+"'&studid='"+studentid+"'");
}
else{
	String sql1="insert into t_studentdetails(CardID,StudentName,gender,School,DOB,Standard,Address,Parent,Contact,Relation,entby) values ('"+studentid+"','"+fullname+"','"+gender+"','"+school+"','"+calender+"','"+standerd+"','"+address+"','"+parent+"','"+contact+"','"+relation+"','"+user+"')";
	stmt2.executeUpdate(sql1);
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stmt2.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	String maxrow="";
	String sqlcard="select StudentID from t_studentdetails where CardID='"+studentid+"'";
	ResultSet rscard=stmt1.executeQuery(sqlcard);
	if(rscard.next()){
		maxrow=rscard.getString("StudentID");
		System.out.println(maxrow);
	}
	
	String sql111="insert into t_studentdetailshistory(CardID,StudentName,gender,School,DOB,Standard,Address,Parent,Contact,Relation,entby,StudentID) values ('"+studentid+"','"+fullname+"','"+gender+"','"+school+"','"+calender+"','"+standerd+"','"+address+"','"+parent+"','"+contact+"','"+relation+"','"+user+"','"+maxrow+"')";
	stmt2.executeUpdate(sql111);
	String abcd1=sql111.replace("'","#");
	abcd1=abcd1.replace(",","$");
	stmt2.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
	
	response.sendRedirect("StudentDetailsEntry.jsp?inserted=yes");
	return; 
}



} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
} 
%>
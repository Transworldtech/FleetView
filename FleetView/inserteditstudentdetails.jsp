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
String standerd=request.getParameter("class");
String gender=request.getParameter("gender");
String parent=request.getParameter("parent");
String contact=request.getParameter("contact");
String relation=request.getParameter("relation");
String school=request.getParameter("school");
String address=request.getParameter("address");
String srno=request.getParameter("srno");
String studentname="";

	//String sql1="insert into t_studentdetails(StudentID,StudentName,gender,School,DOB,Standard,Address,Parent,Contact,Relation,entby) values ('"+studentid+"','"+fullname+"','"+gender+"','"+school+"','"+calender+"','"+standerd+"','"+address+"','"+parent+"','"+contact+"','"+relation+"','"+user+"')";
	String sql1="";
	sql1="update t_studentdetails set StudentName='"+fullname+"',gender='"+gender+"',School='"+school+"',DOB='"+calender+"',Standard='"+standerd+"',Address='"+address+"',Parent='"+parent+"',Contact='"+contact+"',Relation='"+relation+"',CardID='"+studentid+"' where StudentID='"+srno+"'";
	stmt2.executeUpdate(sql1);
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stmt2.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	
	String sql111="insert into t_studentdetailshistory(CardID,StudentID,StudentName,gender,School,DOB,Standard,Address,Parent,Contact,Relation,entby) values ('"+studentid+"','"+srno+"','"+fullname+"','"+gender+"','"+school+"','"+calender+"','"+standerd+"','"+address+"','"+parent+"','"+contact+"','"+relation+"','"+user+"')";
	stmt2.executeUpdate(sql111);
	String abcd1=sql111.replace("'","#");
	abcd1=abcd1.replace(",","$");
	stmt2.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
	
	response.sendRedirect("editstudentdetails.jsp?CardID="+studentid+"");
	return; 
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
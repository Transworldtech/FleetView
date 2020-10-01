<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%-- <%@ include file="header.jsp" %> --%>
<%@ include file="Connections/conn.jsp" %>
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
    Statement stmt3=con1.createStatement();
    ResultSet rs2=null,rs3=null;
    String sql=""; 
    String oldmanagername = request.getParameter("oldRSMname");
    String usertypevalue=session.getAttribute("usertypevalue").toString();
	String newmanager ="";
	System.out.println("oldmanager   "+oldmanagername);
	String buffer="";
	buffer="<div style='height: 150px; width: 235px; overflow: auto;'><table border='0' align='center'  style='height:150px;  width: 300px; display:block; background-color: rgb(229, 237, 246);'>";
	
	%>
	
	<%
	int count=0;
	String FirstName="",LastName="",Name="";
	sql="select UserName,Email,FirstName,LastName from db_gps.t_userdetails where UserName like '%"+oldmanagername+"%' order by UserName asc";
	//sql="select UserName,Email from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+oldmanagername+"%' order by UserName asc";
	//sql="select username,firstname,lastname from db_gps.t_userdetails where Transporter in('castrol South','Castrol north','Castrol West','Castrol East','Castrol ILS') and username in (select username from db_gps.t_security where activestatus='Yes') and UserName like '%"+oldmanagername+"%' order by UserName asc";
	System.out.println("sql ghghghhghg:-"+sql);
	//String sql2="select count(*) from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+oldmanagername+"%' order by UserName asc";
	//String sql2="select count(*) from db_gps.t_userdetails where Transporter in('castrol South','Castrol north','Castrol West','Castrol East','Castrol ILS') and username in (select username from db_gps.t_security where activestatus='Yes') and UserName like '%"+oldmanagername+"%' order by UserName asc";
	String sql2="select count(*) from db_gps.t_userdetails where UserName like '%"+oldmanagername+"%' order by UserName asc";
	rs3=stmt3.executeQuery(sql2);
	if(rs3.next())
	{
		count=rs3.getInt(1);
	}
    rs2=stmt2.executeQuery(sql);
    if (count==0) {
	    System.out.println("No records found");
	    buffer +="<tr><td align='left'><a href='#' >No Records found</a></td></tr>";
	    rs2.beforeFirst();
	} else {
	   while(rs2.next())
   	   {
		   newmanager=rs2.getString("UserName");
		   FirstName=rs2.getString("FirstName");
		   LastName=rs2.getString("LastName");
		   Name=FirstName+" "+LastName;
		   newmanager=newmanager.replaceAll(" ", "");
		   //newmanager=newmanager.trim();
		   %>
		   
		   <%
      		//buffer +="<tr><td><a href='#' onClick=setname1('"+newmanager+"'); >"+newmanager+"</a></td></tr>";
		   buffer+="<tr><td><a href='#' onClick='setname2(\""+newmanager+"\")'  style='color: black;'>"+Name+" "+newmanager.replaceAll("(?i)"+oldmanagername,"<font color=blue><u>"+oldmanagername.toUpperCase()+"</u></font>")+".</a></td></tr></td>";
	  }
	 }%>
   <%  
   buffer +="</table></div>";
   System.out.println("buffer:-"+buffer);
     out.println(buffer);
%>

<%

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
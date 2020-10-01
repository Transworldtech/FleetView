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
    String oldusername = request.getParameter("oldusername");
    String usertypevalue=session.getAttribute("usertypevalue").toString();
	String newuser ="";
	System.out.println("olduser   "+oldusername);
	String buffer="";
	int i=1;
	String FirstName="",LastName="",Name="";
	buffer="<div style='height: 150px; width: 235px; overflow: auto;'><table border='0' align='center'  style='height:150px;  width: 345px; display:block;  background-color: rgb(229, 237, 246);'>";
	
	%>
	
	<%
 //sql="select UserName,Email from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+oldusername+"%' limit 20";
	int count=0;
	//sql="select UserName,Email from db_gps.t_userdetails where Transporter like '%"+usertypevalue+"%' and UserName like '%"+oldusername+"%' order by UserName asc";
	sql="select username,firstname,lastname,FirstName,LastName from db_gps.t_userdetails where Transporter in('castrol South','Castrol north','Castrol West','Castrol East','Castrol ILS') and username in (select username from db_gps.t_security where activestatus='Yes') and UserName like '%"+oldusername+"%' order by UserName asc";
	System.out.println("sql:---"+sql);
	String sql2="select count(*) from db_gps.t_userdetails where Transporter in('castrol South','Castrol north','Castrol West','Castrol East','Castrol ILS') and username in (select username from db_gps.t_security where activestatus='Yes') and UserName like '%"+oldusername+"%' order by UserName asc";
	rs3=stmt3.executeQuery(sql2);
	if(rs3.next())
	{
		count=rs3.getInt(1);
	}
	//sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+oldusername+"' order by VehicleRegNumber asc";
	   rs2=stmt2.executeQuery(sql);
	    if (count==0) {
		    System.out.println("No records found");
		    buffer +="<tr><td align='left'><a href='#' >No Records found</a></td></tr>";
		    rs2.beforeFirst();
		} else { 
	   while(rs2.next())
   	   {
		   newuser=rs2.getString("UserName");
		   FirstName=rs2.getString("FirstName");
		   LastName=rs2.getString("LastName");
		   Name=FirstName+" "+LastName;
		   
		   System.out.println("befor trim new user:---"+newuser);
		   newuser=newuser.trim();
		   System.out.println("new user:---"+newuser);
		   %>
		   
		   <%
      		/* buffer +="<tr><td><a href='#' onClick=setname('"+newuser+"'); >"+newuser+"</a></td></tr>"; */ 
      		
      		//buffer+="<tr><td><div align='left'><a style='color: black;' href='#' onclick='setname(\""+newuser+"\");'>"+newuser.replaceAll("(?i)"+newuser,"<font color=blue ><u>"+newuser.toUpperCase()+"</u></font>")+"</a></div></td></tr>"; 
      		buffer+="<tr><td><a href='#' onClick='setname(\""+newuser+"\")'  style='color: black;'>"+Name+" "+newuser.replaceAll("(?i)"+oldusername,"<font color=blue><u>"+oldusername.toUpperCase()+"</u></font>")+".</a></td></tr></td>";

      		//i++;
	 }
	   i++;
	 }
	 %>
   <%  
   buffer +="</table></div>";
   System.out.println("buffer:-"+buffer);
     out.println(buffer);
     //out.println(buffer+"</select>");

    // buffer=null;

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
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%! 
Connection con1;
%>


<% 

try
{
String RegNo=request.getParameter("TripID");

 Class.forName(MM_dbConn_DRIVER);
 con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	    Statement stmt1=con1.createStatement();

String sql4="";
Statement stmt3 = con1.createStatement();
ResultSet rs4 = null;
sql4="select Distinct(GPName) from db_gps.t_group where GPName not like '%del'  and transporter='"+RegNo+"'";

rs4 = stmt3.executeQuery(sql4);
%>
<table>
<select id="group" name="group" > 
<option value="Select">Select</option>        
  <% 
  
      while(rs4.next())
  {  %>
	
	<option value="<%= rs4.getString("GPName")%>"><%=rs4.getString("GPName") %></option>
	<% } %>
    </select></table>       

<%}
catch(Exception e)
{
out.println(e);
}


%>


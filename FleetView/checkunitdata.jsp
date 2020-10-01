<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<title>Search the Unit Data</title>
</head>
<body>
<%!
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME="root";
String MM_dbConn_PASSWORD="flashkit";
String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
String MM_dbConn_STRING1="jdbc:mysql://localhost/db_AVLALLDATA";

Connection conn,conn1;
Statement st, st1;
String sql, unitid,thedate,thedate1,thedate2;
int limit;
%>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn1.createStatement();
	%>
	<table border="0" width="100%" align="center">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" bgcolor="#FFCC00">Please select the date and enter the Unit id to check its data. </td></tr>
	<tr>
	<td bgcolor="#FFCCCC">
	<input type="text" id="data" name="data" value=""  size="12" readonly/>
	</td><td bgcolor="#FFCCCC">
  	<input type="button" name="The Date" value="From Date" id="trigger">
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#FFCCCC">Unit ID :</td>
	<td bgcolor="#FFCCCC">
	<input type="text" name="unitid" id="unitid"></input> 
	</td>
	<td bgcolor="#FFCCCC">Limit : </td>
	<td bgcolor="#FFCCCC">
	<input type="radio" name="limit" value="xx" checked> <input type="text" name="lim" value="10" size="5"> </input><br>
<input type="radio" name="limit" value="All" > ALl
	</td>
	<td bgcolor="#FFCCCC">
	<input type="submit" name="submit" value="submit">
	</td>
	</tr>
	</form>
	<tr>
	<td colspan="7">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate2=thedate1.replace("-","_");
		String lim1=request.getParameter("limit");
		String limit;
		if(lim1.equals("xx"))
		{
			limit=" limit "+request.getParameter("lim");
		}
		else
		{
			limit="";
		}
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr>
		<td colspan="8" bgcolor="#FFCC00" align="center">The Data of unit <%=unitid %> on <%=thedate %>
		<div align="right"><a href="excelcheckunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></div> </td>
		</tr>
		
		<%
		
		sql="select * from allconnectedunits where unitid='"+unitid+"' order by concat(TheDate,TheTime) desc limit 1";
		ResultSet rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			%>
		<tr>
		<td colspan="8" bgcolor="#CCFFCC" align="center">The current location of unit <%=unitid %> is  <B><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate"))+" "+rst1.getString("TheTime") +"   "+rst1.getString("Location")%></B></td>
		</tr>
			<%
		}
		%>
		<tr>
		<td bgcolor="#CCCCFF" align="center">Sr.</td>
		<td bgcolor="#CCCCFF" align="center">StoredTime</td>
		<td bgcolor="#CCCCFF" align="center">Vehicle No</td>
		<td bgcolor="#CCCCFF" align="center">Vehicle Code</td>
		<td bgcolor="#CCCCFF" align="center">Transporter</td>
		<td bgcolor="#CCCCFF" align="center">MailBody</td>
		<td bgcolor="#CCCCFF" align="center">Unprocessed Stamps</td>
		<td bgcolor="#CCCCFF" align="center">Unit Type</td>
		</tr>
		<%
		sql="select * from t_mails"+thedate2+" where Unitid='"+unitid+"' order by storedtime desc "+limit;
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td bgcolor="#FFFFCC" align="center"><%=i %></td>
			<td bgcolor="#FFFFCC" align="center"><%=rst.getTime("StoredTime") %></td>
			<td bgcolor="#FFFFCC" align="left"><%=rst.getString("VehRegNo") %></td>
			<td bgcolor="#FFFFCC" align="right"><%=rst.getString("Vehid") %></td>
			<td bgcolor="#FFFFCC" align="left"><%=rst.getString("Transporter") %></td>
			<td bgcolor="#FFFFCC" align="left"><%=rst.getString("Body") %></td>
			<td bgcolor="#FFFFCC" align="left"><%=rst.getString("UnProcessedStamps") %></td>
			<td bgcolor="#FFFFCC" align="center"><%=rst.getString("MailFrom") %></td>
			</tr>
		<%
		i++;
		}
		%>
		  </table>
		<%
	}%>
	</td>
	</tr>
	</table>
	<%
	
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	conn.close();
	conn1.close();
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

</body>
</html>
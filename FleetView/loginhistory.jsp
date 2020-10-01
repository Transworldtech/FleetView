<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>

<%@ include file="header.jsp" %>
<%! Connection con;
Statement s;
String sql,transporterlist;
String  difDate2,thedate, user="All", todate,usr="All",datenew1,datenew2;
%>
<%
try{
String ddx=request.getQueryString();
if(null==ddx)
{
	thedate=todate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
else
{
	thedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
	datenew1=request.getParameter("data");
	datenew2=request.getParameter("data1");
}

	transporterlist="('t'";
	Class.forName(MM_dbConn_DRIVER); 
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	s = con.createStatement();
	
%>
<table border="1" bgcolor="white" width="100%">
<tr><td>
<form name="loginhistory" action="" method="get">
<table class="stats">
<tr><td class="hed"><div align="left">From Date : <input type="text" id="data" name="data" class="formElement"  size="20" value="<%=datenew1%>" readonly/>
<!--<img src="images/calendar.png" id="trigger"></div>-->

 <script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script></td>
<td class="hed">To Date : <input type="text" id="data1" name="data1" class="formElement"  size="20" value="<%=datenew2%>" readonly/>
<!--<img src="images/calendar.png" id="trigger1" >-->
  
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",   // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
</td>
<td class="hed">User : <select name="user" id="user" class="formElement">
<option value="All">ALL</option>
<%
String sql1="select distinct(VehRegNo) as Username from t_group where GPName='Castrol' and VehRegNo not like '% del' order by VehRegNo";
ResultSet rst1=s.executeQuery(sql1);
while(rst1.next())
{
transporterlist+=",'"+rst1.getString("Username")+"'";
%>
<option value='<%=rst1.getString("Username")%>'><%=rst1.getString("Username")%></option>
<%
}

%>
</select>
<%
transporterlist+=")";
	
%>
</td>
<td class="hed"><input type="submit" name="Submit" value="Submit" class="formElement"></td>
</tr>
</table>
 </form>
<table class="stats">
<%
String dd=request.getQueryString();
if(null==dd){

String users="('u'";
sql1="select * from t_security where TypeValue in "+transporterlist+" and ActiveStatus='Yes'";
ResultSet rstx=s.executeQuery(sql1);
while(rstx.next())
{
	users+=",'"+rstx.getString("Username")+"'";
}
users+=")";
sql="select * from t_loguseractivity where RecordDate='"+thedate+"' and Comments in "+users+" order by concat(RecordDate, RecordTime) desc, Comments asc";
}
else
{
user=request.getParameter("user");
if(user.equals("All"))
{
	String users="('u'";
	sql1="select * from t_security where TypeValue in "+transporterlist+" and ActiveStatus='Yes'";
	ResultSet rstx=s.executeQuery(sql1);
	while(rstx.next())
	{
		users+=",'"+rstx.getString("Username")+"'";
	}
	users+=")";
sql="select * from t_loguseractivity where RecordDate >='"+thedate+"' and RecordDate<='"+todate+"' and Comments in "+users+" order by concat(RecordDate, RecordTime) desc";
}

else{
	String users="('u'";
	sql1="select * from t_security where TypeValue = '"+user+"' and ActiveStatus='Yes'";
	ResultSet rstx=s.executeQuery(sql1);
	while(rstx.next())
	{
		users+=",'"+rstx.getString("Username")+"'";
	}
	users+=")";
	
sql="select * from t_loguseractivity where RecordDate >='"+thedate+"' and RecordDate<='"+todate+"' and Comments='"+user+"' order by concat(RecordDate, RecordTime) desc";
}
}
ResultSet rst=s.executeQuery(sql);
%>
<th colspan="5">The log Report for <%=user%> For the Period <%=datenew1%> To <%=datenew2%>.</th>
<tr><td class="hed">Login ID</td><td class="hed">Login Date</td><td class="hed">Login Time</td><td class="hed">Logout Date</td><td class="hed">Logout Time</td></tr>

<%

while(rst.next())
{
	%>
	<tr><td class="bodyText"><b><div align="left"><%=rst.getString("Comments")%></div></b></td>
<td class="bodyText" style="text-align: left">
<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("RecordDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%> </td>
<td class="bodyText" style="text-align: right"><%=rst.getString("RecordTime")%></td>
<td class="bodyText"  style="text-align: left"><%
if(rst.getString("LogOutDate").equals("-"))
{
	%><%=rst.getString("LogOutDate")%><%
}
else
{
	java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("LogOutDate"));
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter2.format(ShowDate2);
 out.print(showdate2);
}

%></td>
<td class="bodyText"  style="text-align: right"><%=rst.getString("LogOutTime")%></td>
</tr><%

}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
con.close();
}

%>
</table>
</td></tr>
</table>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>



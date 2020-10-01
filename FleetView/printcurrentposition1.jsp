<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn;
Statement st,st1,stx;
ResultSet rst;
String user,VehList1,aa,regno,sq;


%>
<table border="1" width="90%" align="center">
<tr><td>
<table class="" bgcolor="white" border="0.50" width="100%">
<th colspan="3" align="center"><font class="bodyText" size="3"><b>Current Position Of Vehicles</b></font> <div class="bodyText" align="right">


Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th>
<tr><td colspan="3"><table border="0">
<tr bgcolor="#F0E68C">
<td><b class="bodyText">Color Code Indications :</b></td ><td bgcolor="#CCFFCC" ><b>Moving</b></td><td bgcolor="#FFFFCC" ><b>Stop</b></td><td bgcolor="#DCDCDC" ><b>Disconnected</b></td><td bgcolor="#FFFFFF" ><b>Not Active</b></td>
</tr>

</table></td></tr>
<tr bgcolor="#DCDCDC"><td class="hed" align="center"><font class="bodyText" size="3"><b>Vehicle Reg.No.</b></font></td><td class="hed" align="center"><font class="bodyText" size="3"><b>Updated</b></font></td><td class="hed" align="center"><font class="bodyText" size="3"><b>Location</b></font></td>
<%

if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
	%>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen1</b></font></td>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen2</b></font></td>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen3</b></font></td>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen4</b></font></td>
	<%
}
%>

</tr>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	VehList1=(String)session.getValue("VehList");
String sql="select * from t_onlinedata where vehiclecode in " + VehList1 +" order by concat(TheDate,TheTime) desc";
rst=st.executeQuery(sql);
while(rst.next())
{
int col=rst.getInt("TheSpeed");
%>
<%

java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);

java.util.Date ddd= new java.util.Date();
long dt1=ShowDate1.getTime();
long dt2=ddd.getTime();
long days=((dt2-dt1)/
(60 * 60 * 1000L* 24));

%>
<tr <% if(col >0) { if(days >7 ){%>bgcolor="#DCDCDC" <% }else {%>bgcolor="#CCFFCC" <% }} else { if(days >7 ){%>bgcolor="#DCDCDC" <% }else { %>bgcolor="#FFFFCC" <% } }  %>>

<td class="bodyText"><%=rst.getString("VehicleRegNo")%></td>
<td class="bodyText">

<%
out.print(showdate1);
%>
<%=rst.getString("TheTime")%></td>
<td class="bodyText"><div align="left">
<%=rst.getString("Location")%><% if(days >7) out.print("<font color='red' size='2'> Device Disconnected</font>"); %>

</div></td>
<%
if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
sq="select * from t_veh"+rst.getString("VehicleCode")+" where TheFiledTextFileName = 'SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
ResultSet rsx=stx.executeQuery(sq);
if(rsx.next())
{
%>
<td class="hed" align="center"><%
try{
if(rsx.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%
try{

if(rsx.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");

 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");
	
 %></td>

<%
}
else
{
%>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>

<%
}
}
%>
</tr>

<%
}
/************************ code to show the vehicles which are not updated ********/

StringTokenizer stk= new StringTokenizer(VehList1,",");
	while(stk.hasMoreTokens())
	{
	aa=stk.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	if(!aa.equals("0")){

	String sql01="SELECT *  FROM t_onlinedata where vehiclecode='" + aa +"' order by vehiclecode";
	ResultSet rst01=st.executeQuery(sql01);
	if(rst01.next())
	{
		
	}
	else
	{	String sql02="select * from t_veh"+aa+" order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
		ResultSet rst02=st.executeQuery(sql02);
		if(rst02.next())
		{
		String sql03="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst03=st1.executeQuery(sql03);
		if(rst03.next())
		{
		regno=rst03.getString("VehicleRegNumber");
		}
	 	%>
	<tr bgcolor="#DCDCDC"><td class="bodyText"><%=regno%></td><td class="bodyText"><%java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd").parse(rst02.getString("TheFieldDataDate"));
Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate3 = formatter3.format(ShowDate3);
out.print(showdate3);
%> <%=rst02.getString("TheFieldDataTime")%></td><td class="bodyText"><%=rst02.getString("TheFieldSubject")%><font color="red">Device Disconected</font></td>
<%
if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
sq="select * from t_veh"+aa+" where TheFiledTextFileName = 'SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
ResultSet rsx1=stx.executeQuery(sq);
if(rsx1.next())
{
%>
<td class="hed" align="center"><%
try{
if(rsx1.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx1.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%
try{

if(rsx1.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx1.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");
	
 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");
	

 %></td>
<%
}
else
{
%>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<%
}
}
%>


</tr>
	<%
		}//end of if rst01.
	else
	{
	String sql04="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst04=st.executeQuery(sql04);
		if(rst04.next())
		{
		String dx=rst04.getString("InstalledDate");
		if(null==dx)
		{
			dx="2008-01-01";
		}
	%>
		<tr><td class="bodyText"><%=rst04.getString("VehicleRegNumber")%></td><td class="bodyText"><%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(dx);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter2.format(ShowDate2);
out.print(showdate2);
%> 10:00:00</td><td class="bodyText"><div align="left">Device Installed But Not Active</div></td>
<%
if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
%>
<td class="hed" align="center">xxxx</td>
<td class="hed" align="center">xxxx</td>
<td class="hed" align="center">xxxx</td>
<td class="hed" align="center">xxxx</td>
<%
}
%>
</tr>
<%
		}

	

	}//end of else rst01.
	
	}
	}
	}
/****************** End of Code to show vehicles which are not updates **************/




}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();
}
%>
</table>
</td></tr>
<tr><td align="center"><input type="button" name="Print" value="Print" class="formElement" onclick="javascript:window.print()"></td></tr>
</table>


<!-- footer start here -->
<table border="1" width="90%" align="center">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

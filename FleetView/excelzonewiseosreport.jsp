<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"zonewise_os_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>


Zone-wise Over Speed Report.


<%!
String VehicleCode, fromdate, todate, desc,fff,ttt;
Connection conn;
Statement st1,st2,st3;
ResultSet rst1, rst2, rst3;
int dist, fuel;
boolean flag=true;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1=conn.createStatement();
	
VehicleCode=session.getAttribute("hvid").toString();
fff=session.getAttribute("fff").toString();
ttt=session.getAttribute("ttt").toString();	
fromdate=session.getAttribute("hdate1").toString();
	
todate=session.getAttribute("hdate2").toString();
	
String sql1="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	rst2=st1.executeQuery(sql1);
	if(rst2.next())
	{
		desc=rst2.getString("Desc");
	}
	String sql="select * from t_veh"+VehicleCode+" where TheFieldDataDate>='"+fromdate+"' and TheFieldDataTime >='"+fff+"' and TheFieldDataDate<='"+todate+"' and TheFieldDataTime<='"+ttt+"' and TheFiledTextFileName like '%OS%' and (ZoneDesc <>'-' || Speed >= 60) order by concat(TheFieldDataDate,TheFieldDataTime) asc";

rst1=st1.executeQuery(sql);
%>
<table>
<tr><td class="bodyText" bgcolor="#DCDCFF">Color Code Indications :</td>
<td class="bodyText" bgcolor="#DCDCDC">Black Zone</td>
<td class="bodyText" bgcolor="#FAAFBE">Red And Yellow Zone</td>
<td class="bodyText" bgcolor="#B1FB17">Green Zone</td>
</tr>
</table>
<table border="0" width="100%" bgcolor="white">
<tr bgcolor="#DCDCFF"><td class="bodyText"><center><font size="2"><b>Date Time</b></font></center></td><td class="bodyText"><center><font size="2"><b>Speed</b></font></center></td><td class="bodyText"><center><font size="2"><b>Duration In Sec.</b></font></center></td><td class="bodyText"><center><font size="2"><b>Location</b></font></center></td>
</tr>
<%

while(rst1.next())
{
	%>
<tr  <%
if(Integer.parseInt(rst1.getString("Speed")) >30 && Integer.parseInt(rst1.getString("Speed"))<=40 && rst1.getString("ZoneDesc").equals("Black"))
{ 
out.print("bgcolor='#DCDCDC'");
} 
	
if(Integer.parseInt(rst1.getString("Speed")) >40 && Integer.parseInt(rst1.getString("Speed"))<=60 && (rst1.getString("ZoneDesc").equals("Red") || rst1.getString("ZoneDesc").equals("Yellow")))
{ 
out.print("bgcolor='#FAAFBE'");
} 

if(Integer.parseInt(rst1.getString("Speed")) >= 60)
{ 
out.print("bgcolor='#B1FB17'");
} 
%>


>
<td class="bodyText">
<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1+" ");
%>
<%=rst1.getString("TheFieldDataTime")%></td>
<td class="bodyText"><%=rst1.getString("Speed")%></td>
<td class="bodyText"><%=rst1.getString("Distance") %>
</td>
<td class="bodyText"><div align="left">
<%=rst1.getString("TheFieldSubject") %>
</td>
</tr>
<%
} 
%>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}
%>

 

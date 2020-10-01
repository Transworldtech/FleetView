<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=showdatex+"fuel_report.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime,vehcode;
Connection conn;
Statement st;
String sql;
boolean flag=true;
%>
<%
//VehicleCode=request.getParameter("vehcode");
VehicleCode=(String)session.getValue("VehList");
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	
%>
<table border="1" width="100%" bgcolor="white">  
<tr align="center"><td>
<form name="customdetail" method="get" action="" onsubmit="return Validate();">
 <font size="2" ><div class="bobyText"><b>Fuel report<b></div></font></center>
<div class="bodyText" align="right">Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %>
</div></td></tr>
<tr><td>
<%

if(!(null==request.getQueryString()))
{
	vehcode=request.getParameter("vehcode");
	fromdate=request.getParameter("data");
	todate=request.getParameter("data1");
	fromtime=request.getParameter("fromtime");
	totime=request.getParameter("totime");
	sql="select * from t_vehicledetails where vehiclecode='"+vehcode+"'";
	//out.print(sql);
	ResultSet rstx=st.executeQuery(sql);
	if(rstx.next())
	{
		vehregno=rstx.getString("VehicleRegNumber");
	}
/* all code comes here */
%>
<table class="stats">
<tr><td colspan="6" class="hed"> Detail Report for Vehicle <%=vehregno%> from Date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %> <%=fromtime%> to Date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%> <%=totime%></td></tr>
<tr>
<td class="hed">Sr.</td>
<td class="hed">Date-Time</td>
<td class="hed">Speed</td>
<td class="hed">Distance</td>
<td class="hed">Location</td>
<td class="hed">Fuel In Liter</td>
</tr>
<%

sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',+TheFieldDataTime) <='"+todate+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON','FT') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
//out.print(sql);
ResultSet rst1=st.executeQuery(sql);
int i=1;
int dist=0;
while(rst1.next())
{
if(i==1)
	{
		dist=rst1.getInt("Distance");
	}
%>
			<tr>
				<td class="bodyText"><%=i%></td>
				<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></td>
				<td class="bodyText"><%=rst1.getInt("Speed")%></td>
				<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
				<td class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject")%></div></td>
				<td class="bodyText"><%=((rst1.getInt("Sen1")*153)/1000)%></td>
			</tr>
			<%
	i++;
}
%>
</table>
<%
/* code end here*/
}

%>
</td></tr>

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
</form>
<%@ include file="footernew.jsp" %>

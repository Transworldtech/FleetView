<%@ include file="headernew.jsp" %>

<%!
Connection conn,conn1,conn2;
Statement st,st1,st2,st3,strip,st4;
String sql,sql1;
%>

<%
String fromdate, todate,transporter,datenew1,datenew2,fromdatetime,todatetime,vehcode,vehregno;
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	conn2 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();


vehcode=request.getParameter("vehid");
vehregno=request.getParameter("vehregno");
fromdatetime=request.getParameter("fromdate");
todatetime=request.getParameter("todate");
System.out.println(vehcode);
System.out.println(vehregno);
System.out.println(fromdatetime);
System.out.println(todatetime);

%>

<%

if(!(null==request.getParameter("fromdate")))
{
/* all code comes here */
%>
<table width="100%" align="center">
<tr>
<td align="center"><font size="3"><b> Unit ON/OFF Detail Report for Vehicle <%=vehregno%> from <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime))  %> to <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime))%></b></font>
<div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('print_unitdetailsReport.jsp?vehcode=<%=vehcode%>&data=<%=fromdatetime%>&data1=<%=todatetime%>&vehregno=<%=vehregno %>');" title="Print Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="excel_unitdetailsReport.jsp?vehcode=<%=vehcode%>&data=<%=fromdatetime%>&data1=<%=todatetime%>&vehregno=<%=vehregno %>" title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>
		&nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
	</div>
</td></tr>
</table>

<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>From - Date</th>
<th>To - Date</th>
<th>Location From</th>
<th>Location To</th>
<th>Distance Covered</th>
</tr>
<%
long mils2=0;
sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdatetime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+todatetime+"' order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
//System.out.println("sqlunitdetails---->"+sql);
ResultSet rst=st.executeQuery(sql);
int i=1;int k=1;
while(rst.next())
{
	if(rst.getString("TheFiledTextFileName").equals("OF"))
	{
		String loc1,lat1,long1,fdate,ftime,loc2,lat2,long2;
		int ds1,ds2;
		java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));
		loc1=rst.getString("TheFieldSubject");
		lat1=rst.getString("LatinDec");
		long1=rst.getString("LonginDec");
		ds1=rst.getInt("Distance");
		fdate=rst.getString("TheFieldDataDate");
		ftime=rst.getString("TheFieldDataTime");
		long mils1=dt1.getTime();
		if(mils1>mils2)
		{
		String sql11="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fdate+" "+ftime+"' and TheFiledTextFileName NOT IN ('OF','VD') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc limit 1";
		ResultSet rst11=st1.executeQuery(sql11);
		if(rst11.next())
		{
			//if(!(rst.getString("TheFiledTextFileName").equalsIgnoreCase("VD")) || (!(rst.getString("TheFiledTextFileName").equalsIgnoreCase("OF"))))
			
			//if((!(rstunit.getString("TheFiledTextFileName").equalsIgnoreCase("VD"))) || (!(rstunit.getString("TheFiledTextFileName").equalsIgnoreCase("OF"))))
			
					
					java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst11.getString("TheFieldDataDate")+" "+rst11.getString("TheFieldDataTime"));
					//System.out.println(dt1);
					//System.out.println(dt2);
					loc2=rst11.getString("TheFieldSubject");
					lat2=rst11.getString("LatinDec");
					long2=rst11.getString("LonginDec");
					ds2=rst11.getInt("Distance");
					long hrs=00,mins=00;
					
					 mils2=dt2.getTime();
					//System.out.println(mils1);
					//System.out.println(mils2);
					long mils3=mils2-mils1;
					mils3=mils3/1000/60;
					//System.out.println("HIiiiiiiiiiiii"+mils3);
					if(mils3 > 20)
						{
					%>
					<tr>
				<td class="bodyText"><div align="right"><%=k%></div></td>
				<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></div></td>
				<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
				<td class="bodyText"><div align="left"><%=loc1%></div></td>
				<td class="bodyText"><div align="left"><%=loc2%></div></td>
				<td class="bodyText"><div align="right"><%=ds2-ds1%></div></td>
				<%
				k++;
						}
					//rst.afterLast();
			
		}
		}
		}
	
%>

</tr>

<%
i++;
}
}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</table>
<%@ include file="footernew.jsp" %>

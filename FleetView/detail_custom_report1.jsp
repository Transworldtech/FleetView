<%@ include file="header.jsp" %>
<script language="javascript">
function Validate()
{ 
    
	if(document.getElementById("data").value=="") 
	{
		alert("Please Select The from date.");
		return false;
	}
	if(document.getElementById("data1").value =="")
  	{
		alert("please select To Date");
		return false;
  	}  		
		return datevalidate();
	return true;
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	}
	else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
		alert("From date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==dy1 && year==dy2) if(dm1>dm2)
	{
		alert("From date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}
</script>
<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime;
Connection conn;
Statement st;
String sql;
boolean flag=true;
%>
<%
VehicleCode=request.getParameter("vehcode");
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");
			
	}
%>
<table border="1" width="100%" bgcolor="white">  
<tr align="center"><td>
<form name="customdetail" method="get" action="" onsubmit="return Validate();">
 <font size="2" ><div class="bobyText"><b> Detail report  for the vehicle <%=vehregno%><b></div></font></center>
<div class="bodyText" align="right">Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %>
</div></td></tr>
<tr>
	<%
	fromdate=request.getParameter("data");
	todate=request.getParameter("data1");	
	fromtime=request.getParameter("ftime1");
	totime=request.getParameter("ftime2");
	//out.print(fromtime+"  "+totime);
	%>
	<td><div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('print_detail_custom_report.jsp?vehcode=<%=VehicleCode%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>');" title="Print Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="excel_details_custom_report.jsp?vehcode=<%=VehicleCode%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>" title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>
	</div></td>
	</tr>
	</table>
</td></tr>
<tr><td>
<%

if(!(null==fromdate))
{
/* all code comes here */
%>
<table class="stats">
<tr><td colspan="5" class="hed"> Detail Report for Vehicle <%=vehregno%> from Date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %> <%=fromtime%> to Date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%> <%=totime%></td></tr>
<tr>
<td class="hed">Sr.</td>
<td class="hed">Date-Time</td>
<td class="hed">Speed</td>
<td class="hed">Distance</td>
<td class="hed">Location</td>
</tr>
<%

sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',+TheFieldDataTime) <='"+todate+" "+totime+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,' ',TheFieldDataTime)  asc";
//out.print(sql);
ResultSet rst1=st.executeQuery(sql);
int i=1;
int dist=0;

while(rst1.next())
{
	if(i==1)
	{
		dist=rst1.getInt("Distance");
		//out.print(dist);
	}
	
	if(Integer.parseInt(rst1.getString("Speed"))==0)
	{
	if(flag)
	{
	flag=false;
	%>
<tr>
<td class="bodyText"><%=i%></td>
<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></td>
<td class="bodyText"><%="Stop"%></td>
<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a>
</div></td>
</tr>
<%
i++;
}
}
else
{
flag=true;
%>
<tr>
<td class="bodyText"><%=i%></td>
<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></td>
<td class="bodyText"><%=rst1.getInt("Speed")%></td>
<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a>
</div></td>
</tr>
<%
i++;
}
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
<tr><td>
<!-- footer starts here-->
<table border="1" width="100%" bgcolor="white">
<tr ><td class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</td></tr>
</table>
</form>

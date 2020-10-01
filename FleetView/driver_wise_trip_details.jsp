<%@ include file="header.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<script language="javascript">
function validate()
  {
  	if(document.getElementById("data").value=="")
  	{
  	
  		alert("Please select the from date");
  		return false;
  	}
  if(document.getElementById("data1").value=="")
  	{
  	
  		alert("Please select the to date");
  		return false;
  	}
  	return datevalidate();
  	
  }
  function datevalidate()
{	var date1=document.getElementById("data").value;
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
Connection conn,conn1;
Statement st, st1, st2;
String sql, sql1, sql2,data1,data2,drivername,drivercode,showdate1,showdate,namecode;

%>
<%
try{
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn1.createStatement();
	st2=conn1.createStatement();




%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!-- code start here -->
<table border="0" width="100%" bgcolor="white">
<tr>
<form action="" method="get" onsubmit="return validate();">
<td class="bodyText"><B>Driver Name/Code</B></td>
<td class="bodyText">
<select name="driver" class="formElement">
<%
sql="select distinct(DriverName) as DriverName, DriverId from t_drivers order by DriverName asc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
%>
<option value="<%=rst.getString("DriverName")%>,<%=rst.getString("DriverId")%>"><%=rst.getString("DriverName")%> (<%=rst.getString("DriverId")%>)</option>
<%
}
%>
</select>
</td>
<td class="bodyText"><B>From Date</B></td>
<td class="bodyText"><input type="text" id="data" name="data" class="formElement" value=""  size="15" readonly/>
  <a href="#" title="Click Select From Date"><img src="images/calendar.png" id="trigger" border="0"></a>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script></td>
<td class="bodyText"><B>To Date</B></td>
<td class="bodyText">
<input type="text" id="data1" name="data1" class="formElement"  value="" size="15" readonly/>
  <a href="#" title="Click Select To Date"><img src="images/calendar.png" id="trigger1" border="0"></a>
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td>
<td class="bodyText"><input type="Submit" name="Submit" value="Submit" class="formElement"></td>
</form>
</tr>
</table>
<%
String dd=request.getQueryString();
if(dd==null)
{
%>
<table class="stats">
<tr><td>
<center class='bodyText'><b>Please select the dates to display the Driver wise trip report</b></center>
</td><tr>
</table>
<%
}
else
{
data1=request.getParameter("data");
data2=request.getParameter("data1");
drivername=request.getParameter("driver");
namecode=request.getParameter("driver");
StringTokenizer stk = new StringTokenizer(drivername,",");
drivername=stk.nextToken();
drivercode=stk.nextToken();
%>
<table class="stats">
<tr><th colspan="4"><b>Trip report for Driver <%=drivername%> (<%=drivercode%>) from date <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>. <div align="right">
<a href="#" onclick="javascript:window.open('print_driver_wise_trip_details.jsp?data=<%=data1%>&data1=<%=data2%>&driver=<%=namecode%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_driver_wise_trip_report.jsp?data=<%=data1%>&data1=<%=data2%>&driver=<%=namecode%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div> </b></th></tr>
<tr>
<td class="hed">SR.</td>
<td class="hed">Trip Id</td>
<td class="hed">Start Date</td>
<td class="hed">Origin</td>
<td class="hed">Destination</td>
</tr>
<%
sql="select Distinct(Jcode) as Jcode,Transporter from t_driver_ds where DCode='"+drivercode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode<>'-'";
ResultSet rst1=st1.executeQuery(sql);
int i=1;
while(rst1.next())
{
%>
<tr>
<td class="bodyText"><div align="right"><%=i%></div></td>
<td class="bodyText"><div align="right"><%=rst1.getString("Jcode")%></div></td>
<%
sql="select * from t_alljddata where TripId='"+rst1.getString("Jcode")+"'";
ResultSet rst2= st.executeQuery(sql);
if(rst2.next())
{
%>
<td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst2.getDate("StartDate"))%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("EndPlace")%></div></td>
<%
}
else
{
%>
<td class="bodyText"><div align="right">-</div></td>
<td class="bodyText"><div align="right">-</div></td>
<td class="bodyText"><div align="right">-</div></td>
<%
}
%>
</tr>
<%
i++;
}

%>
</table>

<%
}
}
catch(Exception e)
{
	out.print("Exception -->" +e);
}
finally
{
	conn.close();
	conn1.close();
}
%>
<!-- code end here -->
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

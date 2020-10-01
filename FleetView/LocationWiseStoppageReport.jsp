<%@ include file="headernew.jsp"%>

<%!Connection conn, conn1, conn2;
	Statement st, st1, st2, st3, strip, st4, st5;
	String fromdate, todate, sql, sql1, transporter, datenew1, datenew2,
			fromdatetime, todatetime, loctype;
	String LocationType;%>


<%@page import="javax.management.Query"%><script language="javascript">
  function validate()
  {
		var sortby=document.getElementById("sortby").value;
		//alert(sortby);
		if(sortby.equalsIgnoreCase("Select"))
		{
			alert("Please select the category type");
			return false;
		}

			  
	  var myDate = new Date(document.getElementById("data1").value);
	  
  if(document.getElementById("data1").value=="")
  {
  
  alert("Please select the from date");
  return false;
  }
  if(document.getElementById("data2").value=="")
  {
    alert("Please select the to date");
  return false;
  }
  return true;
  //return datevalidate();
  
  }
  function datevalidate()
{ var date1=document.getElementById("data1").value;
var date2=document.getElementById("data2").value;
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
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}

if(dm1==month){
if(dd1>day || dd2>day)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
}
if(dy1>dy2)
{
alert("From date year is should not be greater than to date year");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}

else if(year==dy1 && year==dy2) if(dm1>dm2)
{
alert("From date month is should not be greater than to date month");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
if(dm1==dm2) {
if(dd1 > dd2)
{
alert("From date is should not be greater than to date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
}
return true;
}

  </script>
<script type="text/javascript">

function toggleDetails(id, show)
{
var popup = document.getElementById("popup"+id);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();

} else {
popup.style.visibility = "hidden";
}
}

function callfun()
{
	var aa=document.locationwisestop.location.value;
	if(!(aa=="Select"))
	{	
		document.locationwisestop.submit();
	}
}
</script>
<style>
.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden; . popupnew { background-color : #98AFC7;
	position: absolute;
	visibility: visible;
}
</style>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!/*Connection conn,conn1,conn2;
	 Statement st,st1,st2,st3,strip,st4;
	 String fromdate, todate,sql,sql1,transporter,datenew1,datenew2,fromdatetime,todatetime;*/%>
<%
	Connection conn, conn1;
	Statement st, st1, st2, st3, st11, stt1, stt2, st12, st13, st14, st15;
	String fromdate="", todate="", sql, sql1, sql2, sql3, transporter, datenew1, datenew2, fromdatetime, todatetime, vendor1, category1, startp, endp, ven, startp1, endp1, vendername, categoryname, startplacename, endplacename, statusname, vehino, vehicleno, vehiclecode, Sqlv = "";
%>
<%
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,
			MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,
			MM_dbConn_USERNAME, MM_dbConn_PASSWORD);

	//conn = fleetview.ReturnConnection();
	//conn1 = fleetview.ReturnConnection1();
	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn1.createStatement();
	st11 = conn.createStatement();
	stt1 = conn.createStatement(); //  *********************************
	stt2 = conn.createStatement();
	st12 = conn.createStatement();
	st13 = conn.createStatement();
	st14 = conn.createStatement();
	st15 = conn.createStatement();
	if (!(null == request.getQueryString())) {
		fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("data1")));
		todate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(request.getParameter("data2")));
		transporter = request.getParameter("transporter");
		datenew1 = request.getParameter("data1");
		datenew2 = request.getParameter("data2");

	} else {
		datenew1 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
		datenew2 = datenew1;

	}
%>
<form name="locationwisestop" action="" method="get"
	onsubmit="return validate();">
<table border="0" width="100%" align="center" class="stats">
	<tr>
		<td align="center"><font size="2"><B>Location Wise
		Stoppage Report</B></font></td>
	</tr>
	<tr>
		<td>
		<table border="0" width="700" align="center" class="sortable_entry">
			<tr>
				<td><b>From </b>&nbsp;&nbsp; <input type="text" id="data1"
					name="data1" value="<%=datenew1%>" size="15" readonly /></td>
				<td align="left"><!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
				<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>

				<td><b>To</b> &nbsp;&nbsp; <input type="text" id="data2"
					name="data2" value="<%=datenew2%>" size="15" readonly /></td>
				<td align="left"><!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
				<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script></td>
&nbsp;&nbsp;&nbsp;&nbsp;
				<td><b>Status :
		<select name="location" style="">
		     <option value="All" >All</option>
			<option value="Customer" >Customer</option>
			<option value="Plant" >Plant</option>
			<option value="Tollnaka" >TollNaka</option>
		</b> </select>
		
</td>
				<td><input type="hidden" name="transporter" id="transporter"
					value="<%=session.getAttribute("usertypevalue").toString()%>">
				&nbsp;&nbsp;<input type="submit" name="submit" id="submit"
					value="submit"></td>
		</table>
	</tr>
	
	
		<%
			LocationType=request.getParameter("location");
				String sqlstop = "";
				try {
					
					if (LocationType.equals("All")) {
						sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
								+ "	count(distinct( tripid) ) AS Trips, concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
								+ "	FROM t_RoundTripStop WHERE LocationType in('Customer','Plant','Toll Naka') and fromdate >= '"
								+ fromdate
								+ " 00:00:00' AND todate <= '"
								+ todate
								+ " 23:59:59' and Transporter='"+session.getAttribute("usertypevalue").toString()+"'group by Location order by Location asc";
					}
					if (LocationType.equals("Customer")) {
						sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
								+ "	count(distinct( tripid) ) AS Trips, concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
								+ "	FROM t_RoundTripStop WHERE LocationType='Customer' and fromdate >= '"
								+ fromdate
								+ " 00:00:00' AND todate <= '"
								+ todate
								+ " 23:59:59' and Transporter='"+session.getAttribute("usertypevalue").toString()+"'  group by Location order by Location asc";
					}

					 if (LocationType.equals("Plant")) {
						sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
								+ "	count(distinct( tripid) ) AS Trips,concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
								+ "	FROM t_RoundTripStop WHERE LocationType='Plant' and fromdate >= '"
								+ fromdate
								+ " 00:00:00' AND todate <= '"
								+ todate
								+ " 23:59:59' and Transporter='"+session.getAttribute("usertypevalue").toString()+"' group by Location order by Location asc";
					}if (LocationType.equals("Tollnaka")) {
						sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
								+ "	count(distinct( tripid) ) AS Trips, concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
								+ "	FROM t_RoundTripStop WHERE LocationType='Toll Naka' and fromdate >= '"
								+ fromdate
								+ " 00:00:00' AND todate <= '"
								+ todate
								+ " 23:59:59'  and Transporter='"+session.getAttribute("usertypevalue").toString()+"'group by Location order by Location asc";
					}
					int i = 0;
					System.out.println("Query---->" + sqlstop);
					ResultSet rststop = st.executeQuery(sqlstop);
					%>
					<table border="0" width="100%" align="center" class="stats">
					<tr><td align="center">
					<font  size="3"><B>
					Report for <%=LocationType %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
					</font>
						<div align="right">
						<a href="#" onclick="javascript:window.open('print_Locationwisereport.jsp?data1=<%=fromdate%>&data2=<%=todate%>&LocationType=<%=LocationType%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>
					
					 <a href="excel_Locationwisereport.jsp?data1=<%=fromdate%>&data2=<%=todate%>&LocationType=<%=LocationType%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
					</div> </td>
					</tr>
					</table>
					<table border="1" class="sortable" width="100%">
					<tr>
					
					<th>Sr.No</th>
					<th>Location</th>
					<th>No of Trips</th>
					<th>Min Time</th>
					<th>Max Time</th>
					<th>Average Time</th>
					</tr>
					
					<%
					
					while (rststop.next()) {
						i++;
				%>

			<tr>
				<td><%=i%></td>

	
				<td><%=rststop.getString("Location")%></td>

				<td align="right"><%=rststop.getString("Trips")%></td>

				<td align="right"><%=rststop.getString("Min")%></td>

				<td align="right"><%=rststop.getString("Max")%></td>
					<%System.out.println("Avg---->" + rststop.getString("Avg")); %>
				<td align="right"><%=rststop.getString("Avg")%></td>
			
	<%
		}
%>
</tr>
	</table>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

	</td>
	</tr>
	</form>
</table>
<%@ include file="footernew.jsp"%>
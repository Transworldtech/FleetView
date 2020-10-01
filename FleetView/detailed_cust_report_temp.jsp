<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
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
String datenew1,datenew2;
Connection conn;
Statement st;
String sql;
boolean flag=true;
%>
<%
VehicleCode=request.getParameter("vehcode");
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");
			
	}
%>
<table border="0" width="100%" bgcolor="white">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3">Report No:1.12</font></div>-->
 <font size="3"><div ><b>Custom Detail Report<b></div></font></center>
<div class="bodyText" align="right">

</div>
</td>
</tr>
<tr>
<td>
<form name="customdetail" method="get" action="" >
	<input type="hidden" name="vehcode" value="<%=VehicleCode%>">
	<table border="0" width="100%" align="right">  
 	<tr>
 	<td align="left">
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>" readonly/>
		</td>
		<td>
		<select name="ftime1" id="ftime1">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<24;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		</select>
		<select name="ftime2" id="ftime2">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<60;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		
		</select>
  		</td>
	<td align="left">
		<input type="button" name="From Date" value="From Date" id="trigger">
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
	<td align="left">
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12" readonly/>
		</td>
		<td>
		<select name="ttime1" id="ttime1" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
		<select name="ttime2" id="ttime2" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<59;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="59" selected>59</option>
		</select>		
		</td><td align="left">
  		<input type="button" name="To Date" value="To Date" id="trigger1">
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
		</script>
	</td>
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit">
	</div></td>
	<%
	if(!(null==request.getParameter("data")))
			{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
	fromtime=request.getParameter("ftime1")+":"+request.getParameter("ftime2")+":00";
	totime=request.getParameter("ttime1")+":"+request.getParameter("ttime2")+":00";
	//out.print(fromtime+"  "+totime);
			}
	%>
	</tr>
	</table>
</td></tr>
<tr><td>
<%

if(!(null==request.getParameter("data")))
{
/* all code comes here */
%>
<table width="100%" align="center">
<tr>
<td align="center"><font size="3"><b> Detail Report for Vehicle <%=vehregno%> from Date <%=datenew1 %> <%=fromtime%> to Date <%=datenew2%> <%=totime%></b></font>
<div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('print_detail_custom_report.jsp?vehcode=<%=VehicleCode%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>');" title="Print Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="excel_details_custom_report.jsp?vehcode=<%=VehicleCode%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>" title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>
		&nbsp;&nbsp;&nbsp;<%=fleetview.PrintDate() %>
	</div>
</td></tr>
</table>
<table width="100%" align="center" class="sortable" border="1">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed</th>
<th>Distance</th>
<th>Location</th>
<th>Stamp</th>
<th> Fuel Level</th>
<th>Sensor 3</th>
</tr>
<%

sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',+TheFieldDataTime) <='"+todate+" "+totime+"' order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
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
		if(rst1.getInt("Speed")==0)
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
					<td class="bodyText"><div align="left"><%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
					<td class="bodyText"><%=rst1.getString("TheFiledTextFileName")%> </td>
					<td class="bodyText"> <%=rst1.getString("FuelLevel") %></td>
					<td class="bodyText"> <%=rst1.getString("Sen3")%> </td>		

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
				<td class="bodyText"><div align="left"><%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
				<td class="bodyText"><%=rst1.getString("TheFiledTextFileName")%> </td>
					<td class="bodyText"> <%=rst1.getString("FuelLevel") %></td>
					<td class="bodyText"> <%=rst1.getString("Sen3")%> </td>		
				</div></td>
			</tr>
			<%
			i++;
		}
	
}
if(rst1.last())
{
%>
	<tr>
		<td class="bodyText"><%=i%></td>
		<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></td>
		<td class="bodyText"><%=rst1.getInt("Speed")%></td>
		<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
		<td class="bodyText"><div align="left"><%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
		<td class="bodyText"><%=rst1.getString("TheFiledTextFileName")%> </td>
					<td class="bodyText"> <%=rst1.getString("FuelLevel") %></td>
					<td class="bodyText"> <%=rst1.getString("Sen3")%> </td>		
		</div></td>
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
<% fleetview.closeConnection(); %>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>

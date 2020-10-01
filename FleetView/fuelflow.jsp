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

<tr>
<td>
	<table border="0" width="100%" align="center">  
 	<tr>
 	<td>
<b>Vehicle :</b> <select name="vehcode" id="vehcode">
<%
	sql="select * from t_vehicledetails where vehicleCode in"+VehicleCode+" order by vehiclecode";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
%>
<option value="<%=rst.getString("VehicleCode") %>"><%=rst.getString("VehicleRegNumber") %></option>
<%
}
%>
</select> 	
 	</td>
	<td align="left">
		<input type="text" id="data" name="data"   size="10" readonly/>
		</td>
		<td>
		<select name="ftime1" id="ftime1" >
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
		<select name="ftime2" id="ftime2" >
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
		<input type="button" name="From Date" value="From Date" id="trigger" >
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
		</script>
	</td>
	<td align="left">
		<input type="text" id="data1" name="data1"  size="10" readonly/>
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
			for(int i=10;i<24;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		</select>
		<select name="ttime2" id="ttime2" ">
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
		</td><td align="left">
  		<input type="button" name="To Date" value="To Date" id="trigger1"">
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
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit">
	</div></td>
	<%
	vehcode=request.getParameter("vehcode");
	fromdate=request.getParameter("data");
	todate=request.getParameter("data1");	
	fromtime=request.getParameter("ftime1")+":"+request.getParameter("ftime2")+":00";
	totime=request.getParameter("ttime1")+":"+request.getParameter("ttime2")+":00";
	//out.print(fromtime+"  "+totime);
	%>
	<td><div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('print_detail_custom_report.jsp?vehcode=<%=VehicleCode%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>');" title="Print Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="excelfuelflow.jsp?vehcode=<%=vehcode%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>" title="Export to Excel">
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
	vehcode=request.getParameter("vehcode");
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
				<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a>
				</div></td>
				<td class="bodyText"><%=((rst1.getInt("Sen1")*153)/1000)%></td>
			
			</tr>
			<%
	i++;}
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

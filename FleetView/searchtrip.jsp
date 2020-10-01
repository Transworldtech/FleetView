<%@ include file="header.jsp" %>
<%!
Connection conn, conn1;
Statement st, st1, st2, st3,stx;
String sql, sql1;
double ra, rd, os, ra1, rd1,os1, rating,dist;
%>
<script language="javascript">
function validate(form)
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
  	  
  	if(document.searchform.trans[1].checked == true )
  	{
  		if(document.getElementById("transname").value=="Select")
  	 {
  	 	alert("Please Select the Transporter");
  	 	return false;
  	 }
  	}
	if(document.searchform.origin[1].checked == true )
  	{
  		if(document.getElementById("originname").value=="Select")
  	 {
  	 	alert("Please Select the Origin");
  	 	return false;
  	 }
  	} 
  	if(document.searchform.destination[1].checked == true )
  	{
  		if(document.getElementById("destinationname").value=="Select")
  	 {
  	 	alert("Please Select the Destination");
  	 	return false;
  	 }
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
	else if(year==dy1 && year==dy2){
	  if(dm1>month || dm2>month)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;

			return false;
	
		}
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
		alert("From date month is should not be greater than to date month 5");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}

  </script>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!-- code start-->
<%!
String data1,data2,trans1,trans2,origin1,origin2,destination1,destination2;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();

%>
<table class="stats" width="100%" align="center">
<tr>
<td>
<%
/************ Code Start for the form to search the trip *******************/
%>
<form name="searchform" action="" method="get" onsubmit="return validate(this);">
<table border="1" width="70%" align="center">
<tr>
<td colspan="2" align="center"><font color="brown" size="2">Custom Trip Report</font></td>
</tr><tr>
<td>
<font color="brown" size="2">
Date Range
</font>
</td>
<td>
<div align="left">
<input type="text" id="data" name="data" class="formElement"  size="10" readonly/>
<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>

&nbsp;&nbsp;&nbsp;
<input type="text" id="data1" name="data1" class="formElement"  size="10" readonly/>
<input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</div>
</td>
</tr><tr>
<td>
<font color="brown" size="2">
Transporter
</font>
</td>
<td>
<div align="left">
<font color="brown" size="2">
All <input type="radio" name="trans" id="trans" value="All" checked> &nbsp;&nbsp;&nbsp; Select Tranporter<input type="radio" name="trans" value="Select">
<select name="transname" id="transname" class="formElement">
<option value="Select">Select</option>
<%
sql="select distinct(vehregno) from t_group where Gpname='Castrol' order by vehregno ";
ResultSet rst=st.executeQuery(sql);

while(rst.next())
{
%>
<option value="<%=rst.getString("vehregno")%>"><%=rst.getString("vehregno")%></option>
<%
}
%>
 </select>
</font>
</div>
</td>
</tr><tr>
<td><font color="brown" size="2">
Origin
</font>
</td>
<td >
<div align="left">
<font color="brown" size="2">
All <input type="radio" name="origin" value="All" checked> &nbsp;&nbsp;&nbsp; Select Origin.<input type="radio" name="origin" value="Select">
<select name="originname" id="originname" class="formElement">
<option value="Select">Select</option>
<%
sql="select Distinct(WareHouse),WareHouseCode from t_warehousedata where Owner='Castrol' order by WareHouse";
ResultSet rst1=st1.executeQuery(sql);
while(rst1.next())
{
%>
<option value="<%=rst1.getString("WareHouseCode")%>"><%=rst1.getString("WareHouse")%></option>
<%
}
%>
</select>
</font>
</div>
</td>
</tr><tr>
<td>
<font color="brown" size="2">
Destination
</font>

</td>
<td>
<div align="left">
<font color="brown" size="2">
All <input type="radio" name="destination" value="All" checked> &nbsp;&nbsp;&nbsp; Select Destination.<input type="radio" name="destination" value="Select">
<select name="destinationname" id="destinationname" class="formElement">
<option value="Select">Select</option>
<%
sql="select Distinct(WareHouse),WareHouseCode from t_warehousedata where Owner='Castrol' order by WareHouse";
ResultSet rst2=st1.executeQuery(sql);
while(rst2.next())
{
%>
<option value="<%=rst2.getString("WareHouseCode")%>"><%=rst2.getString("WareHouse")%></option>
<%
}
%>
</select>
</font>
</div>
</td>
</tr><tr>
<td colspan="2" align="center">
<input type="submit" name="submit" value="Submit" class="formElement">
</td>
</tr>
</table>
</form>
<%
/************ Code End for the form to search the trip *******************/
%>
</td>
</tr>
<tr>
<td>
<%
/************ The Search Result Comes here *******************/
 data1=request.getParameter("data");
 	if(!(null==data1))
 	{
		data2=request.getParameter("data1");
		trans1=request.getParameter("trans");
		trans2=request.getParameter("transname");
		String distrans="";
		if(trans1.equals("All"))
		{
		distrans=" All Transporter";
		}
		else
		{
			distrans=trans2;
		}
		origin1=request.getParameter("origin");
		origin2=request.getParameter("originname");
		String disorigin="";
		if(origin1.equals("All"))
		{
		disorigin=" ";
		}
		else
		{
			disorigin=" Started from "+origin2;
		}
		destination1=request.getParameter("destination");
		destination2=request.getParameter("destinationname");
		String disdest="";
		if(destination1.equals("All"))
		{
		disdest=" ";
		}
		else
		{
			disdest=" End at "+destination2;
		}
		//out.print(data1+"  "+data2+"  "+trans1+" "+trans2+"  "+origin1+"  "+origin2+"  "+destination1+"  "+destination2);
		%>
		<div align="center"><font color="brown" size="2"><%=session.getAttribute("usertypevalue").toString()%> trip Report for <%=distrans%> <%=disorigin%> <%=disdest%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%></font></div>
		<div align="right">
		<a href="#" onclick="javascript:window.open('printsearchtrip.jsp');" title="Print Current Position Report">
		<img src="images/print.jpg" width="15px" height="15px">
		</a>&nbsp; &nbsp; 
		<a href="excelsearchtrip.jsp"  title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>		
		<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>		
		<%  
		String heading=session.getAttribute("usertypevalue").toString()+" trip Report for "+distrans+" "+disorigin+" "+disdest+" from "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))+" to "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));		
		session.setAttribute("heading",heading);		
		%>		
		<table class="sortable" border="1" align="center" width="100%"
		<tr>
		<td><b>Sr.</b></td>
		<td><b>Trip Id</b></td>
		<td><b>Vehicle</b></td>
		<td><b>Driver</b></td>
		<td><b>Transporter</b></td>
		<td><b>Origin</b></td>
		<td><b>Destination</b></td>
		<td><b>Distance</b></td>
		<td><b>Time Taken</b></td>
		<td><b>OS</b></td>
		<td><b>RA</b></td>
		<td><b>RD</b></td>
		<td><b>CD</b></td>
		<td><b>ST</b></td>
		<td><b>ND</b></td>
		<td><b>Rating</b></td>
		</tr>
	<%
	if(trans1.equals("All") && origin1.equals("All") && destination1.equals("All"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName  from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol'";
	}
	if(trans1.equals("Select") && origin1.equals("All") && destination1.equals("All"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol'";
	}
	if(trans1.equals("Select") && origin1.equals("Select") && destination1.equals("All"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol' and OwnerName='"+trans2+"' and StartCode like '%"+origin2+"%'";
	}	
	if(trans1.equals("Select") && origin1.equals("Select") && destination1.equals("Select"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol' and OwnerName='"+trans2+"' and StartCode like '%"+origin2+"%' and EndCode like '%"+destination2+"%'";
	}
	if(trans1.equals("Select") && origin1.equals("All") && destination1.equals("Select"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol' and OwnerName='"+trans2+"' and EndCode like '%"+destination2+"%'";
	}
	if(trans1.equals("All") && origin1.equals("Select") && destination1.equals("Select"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol' and StartCode like '%"+origin2+"%' and EndCode like '%"+destination2+"%'";
	}
	if(trans1.equals("All") && origin1.equals("Select") && destination1.equals("All"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol' and StartCode like '%"+origin2+"%'";
	}	
	if(trans1.equals("All") && origin1.equals("All") && destination1.equals("Select"))
	{
		sql="select distinct(tripid),StartPlace,EndPlace,kmTravelled,startDate,EndDate,VehId,VehRegNo,DriverName,DriverId,OwnerName from t_completedjourney where StartDate >='"+data1 +" 00:00:00' and StartDate <='"+data2 +" 00:00:00' and GPName='Castrol' and EndCode like '%"+destination2+"%'";
	}
	//out.print(sql);
	
	session.setAttribute("sql",sql);
	int i=1;
	ResultSet rstx3=stx.executeQuery(sql);
	while(rstx3.next())
	{
	sql="select * from t_completedjourney where tripid='"+rstx3.getString("tripId")+"'";
	ResultSet rst3=st.executeQuery(sql);
	while(rst3.next())
	{
	ra=0.0;
	rd=0.0;
	os=0.0;
	ra1=0.0;
	rd1=0.0;
	os1=0.0;
	dist=0.0;
	rating=0.0;
		%>
	<tr>
		<td><%=i%></td>
		<td><a href="detail_trip_report.jsp?tripid=<%=rst3.getString("TripId")%>&vehcode=<%=rst3.getString("VehId")%>&sdate=<%=rst3.getString("startDate")%>&vehregno=<%=rst3.getString("VehRegNo")%>&ownername=<%=rst3.getString("ownername")%>&startplace=<%=rst3.getString("StartPlace")%>&endplace=<%=rst3.getString("EndPlace")%>&enddate=<%=rst3.getString("EndDate")%>&pg=cm"><%=rst3.getString("TripId")%></a></td>
		<td><div align="left"><%=rst3.getString("VehRegNo")%></div></td>
		<td><div align="left"><%=rst3.getString("DriverName")%> ( <%=rst3.getString("DriverId")%> )</div></td>
		<td><div align="left"><%=rst3.getString("OwnerName")%></div></td>
		<td><div align="left"><%=rst3.getString("StartPlace")%></div></td>
		<td><div align="left"><%=rst3.getString("EndPlace")%></div></td>
		<td><div align="right"><%=rst3.getString("kmTravelled")%><% dist=rst3.getInt("kmTravelled"); %></div></td>
		<td>
		<%
		java.util.Date dt1=rst3.getDate("StartDate");		
		java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst3.getString("EndDate"));		
		long mils1,mils2,mils3;
		mils3=0;
		mils1=0;
		mils2=0;		
		mils1=dt1.getTime();
		mils2=dt2.getTime();
		mils3=((mils2-mils1)/1000/60/60);
		out.print(" "+mils3+" Hrs.");
		%>		
		</td>
		<td>
		<%
			sql="select count(*) as OScount,sum(duration) as duration from t_veh"+rst3.getString("vehid")+"_overspeed where fromdate >='"+rst3.getString("startdate")+"' and concat(fromdate,' ',fromtime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst4=st2.executeQuery(sql);
			if(rst4.next())
			{
			out.print(rst4.getInt("OSCount"));
			os=rst4.getDouble("Duration");
			}
		%>		
		
		</td>
		<td>
		<%
			sql="select count(*) as RAcount from t_veh"+rst3.getString("vehid")+"_ra where TheDate >='"+rst3.getString("startdate")+"' and concat(TheDate,' ',TheTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst5=st2.executeQuery(sql);
			if(rst5.next())
			{
			out.print(rst5.getInt("RAcount"));
			ra=rst5.getInt("RAcount");
			}
		%>			
		
		</td>
		<td>
		<%
			sql="select count(*) as RDcount from t_veh"+rst3.getString("vehid")+"_rd where TheDate >='"+rst3.getString("startdate")+"' and concat(TheDate,' ',TheTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst6=st2.executeQuery(sql);
			if(rst6.next())
			{
			out.print(rst6.getInt("RDcount"));
			rd=rst6.getInt("RDcount");
			}
		%>			
		</td>
		<td>
		<%
			sql="select count(*) as CRcount from t_veh"+rst3.getString("vehid")+"_cr where FromDate >='"+rst3.getString("startdate")+"' and concat(FromDate,' ',FromTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst7=st2.executeQuery(sql);
			if(rst7.next())
			{
			out.print(rst7.getInt("CRcount"));
			}
		%>			
		</td>
		<td>
		<%
			sql="select count(*) as STcount from t_veh"+rst3.getString("vehid")+"_stsp where FromDate >='"+rst3.getString("startdate")+"' and concat(FromDate,' ',FromTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst8=st2.executeQuery(sql);
			if(rst8.next())
			{
			out.print(rst8.getInt("STcount"));
			
			}
		%>			
		</td>
		<td>
		<%
			sql="select count(*) as NDcount from t_veh"+rst3.getString("vehid")+"_nd where FromDate >='"+rst3.getString("startdate")+"' and concat(FromDate,' ',FromTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst9=st2.executeQuery(sql);
			if(rst9.next())
			{
			if(rst9.getInt("NDcount") > 0)
			{
				out.print("Yes");
			}
			else
			{
				out.print("No");
			}
			}
		%>				
		
		</td>
		<td>
		<%
		try{
		if(dist <= -0)
		{
			ra1=0.0;
			rd1=0.0;
			os1=0.0;
		}
		else
		{
		ra1=(ra/dist)/100;
		rd1=(rd/dist)/100;
		os1=((os/10)/dist)*100;
		}
		String pp=""+(os1+ra1+rd1);
		if(pp.length() >5)
		{
			out.print(pp.substring(0,pp.indexOf(".")+2));
		}
		else
		{
			out.print(pp);
		}		
		}catch(Exception ee)
		{
			out.print("0");
		}
		%>
		</td>
	</tr>		
		<%
		i++;
	}	
	}
	%>		
	</table>		
		<%
		

	}
/************ The Search Result End here  *******************/
%>

</td>
</tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{
	conn.close();
	conn1.close();
}
%>
<!-- code end -->
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
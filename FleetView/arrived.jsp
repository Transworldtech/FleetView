<%@ include file="headernew.jsp" %>
<%!
Connection conn, conn1;
Statement st,st1;
String sql,datenew1,datenew2,thedate,sdate,edate,vehlist,location,locationcode,mainuser,locationlist;
%>
<%
if(session.getAttribute("vehlistnew").toString().equals("-"))
{
	out.print("<table class='stats'><tr><td class='hed'>Please select the location first.</td></tr></table>");
}
else
{

try{
	
	location=session.getAttribute("Location").toString();
	locationcode=session.getAttribute("LocationCode").toString();
	vehlist=session.getAttribute("vehlistnew").toString();
	mainuser=session.getAttribute("usertypevaluemain").toString();
	locationlist=session.getAttribute("locationlist").toString();
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	String aa=request.getParameter("data");
	if(null==aa)
	{
	sql="SELECT SUBDATE(now(), INTERVAL 1 MONTH) as TheDate";	
	ResultSet rstdate=st.executeQuery(sql);
	if(rstdate.next())
	{
		thedate=rstdate.getDate("TheDate").toString();
		edate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(rstdate.getDate("TheDate"));
		datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	}
	}
	else
	{
		datenew1=request.getParameter("data");
		datenew2=request.getParameter("data1");
		thedate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
		edate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
	}
%>
			<table width="100%" align="center"border="0" >
			<tr><td>
			<!-- if date range is not requred please remove this code start from this comment to -->
			
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
  				return true;
  				//return datevalidate();
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
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
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
			if(dm1==dm2) 
			{
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
			<table border="0" width="100%" class="sortable_entry">
			<tr><td align="center" colspan="3"><!-- <div align="left"><font size="3">Report No:3.3</font></div>-->
			
			<font size="3"><b><div align="center">Vehicle Arrived Report</div></b></font>
			</td></tr>
			<form action="" method="get" onsubmit="return validate();">
			<tr>
			<td align="right">
			  <input type="text" id="data" name="data" value="<%=datenew1 %>"  size="15" readonly/>
  			</td>
  			<td align="left">
				<input type="button" name="From Date" value="From Date" id="trigger" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",      // the date format
      			button      : "trigger"       // ID of the button
    			}
  				);	
				</script>
			</td>
			<td align="right">
			  	<input type="text" id="data1" name="data1" value="<%=datenew2 %>"   size="15" readonly/></td><td align="left">
  			  	<input type="button" name="To Date" value="To Date" id="trigger1" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
			<td>
				<input type="submit" name="submit" id="submit" value="submit" >
			</td>
		</tr>
		</form>
		</table>
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
			<tr>
			<td  class="sorttable_nosort">
				
			</td>
			</tr>
			</table>
			<%

	if(location.equals("All"))
	{
	sql="select * from t_completedjourney where GPName='Castrol' and StartDate >='"+thedate+"' and StartDate <='"+edate+"' order by StartDate asc";
	
	}
	else
	{
		sql="select * from t_completedjourney where Endcode in "+locationlist+" and GPName='"+mainuser+"'  and StartDate >='"+thedate+"'  and StartDate <='"+edate+"' order by StartDate asc";
	}
	//out.print(sql);
	ResultSet rst=st.executeQuery(sql);
	%>
	<table border="0" width="100%" bgcolor="white">
	<tr><td align="center"><font size="3" color="blue"><B>
	Vehicle Arrived
	<%
	if(session.getAttribute("Location").toString().equals("All"))
	{
	}
	else
	{
		out.print(" at "+session.getAttribute("Location").toString() +" From "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate))+" to "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate)) );
	}
	%>
	</B></font>
	<div align="right">
				<a href="#" onclick="javascript:window.open('printarrived.jsp?data=<%=thedate %>&data1=<%=edate %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelarrived.jsp?data=<%=thedate %>&data1=<%=edate %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
	
	</td></tr>
	<tr><td>
	<table class="sortable" border="1" width="100%">
	
	<tr>
	<th>Sr</th>
	<th>Trip ID</th>
	<th>Veh.</th>
	<th>Owner Name</th>
	<th>Start Date</th>
	<th>End Date</th>
	<th>Origin</th>
	<th>Destination</th>
	<th>Distance</th>
	<th>Avg. Speed</th>
	<th>Duration</th>
	<th>Driver Name</th>
	<th>Driver Code</th>

</tr>
<%
int i=1;
while(rst.next())
{
%>
<tr>
<td style="text-align: right"><%=i %></td>
<td class="bodyText"><div align="right">
<a href="startedtrip.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("VehId")%>&sdate=<%=rst.getString("StartDate")%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=rst.getString("OwnerName")%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("endplace")%>&enddate=<%=rst.getString("EndDate")%>&pg=cm"><%=rst.getString("TripID")%> </a>
</div></td>
<td class="bodyText"><div align="left"><%=rst.getString("VehRegNo")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("OwnerName")%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(sd1);
 out.print(sh1);%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sh2 = fmt2.format(sd2);
 out.print(sh2);%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("KmTravelled")%></div></td>
<td class="bodyText"><div align="right"><%


String ss=rst.getString("AvgRunningSpeed");
if(ss.length() >4)
{
out.print(ss.substring(0,4));
}
else
{
out.print(ss);
}
%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("RunningDuration")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("DriverName")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("DriverId")%></div></td>
</tr>


<%
i++;
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
</td></tr>
</table>
<%
}
%>
	<%@ include file="footernew.jsp" %>
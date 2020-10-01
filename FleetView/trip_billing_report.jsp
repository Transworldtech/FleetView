<%@ include file="header.jsp" %>
<script language="javascript">
  function validate()
  {
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
  	return datevalidate();
  	
  }
  function datevalidate()
{	var date1=document.getElementById("data1").value;
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
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3;
String fromdate, todate,sql,sql1,transporter,mainuser,trans,trans1,trans2;
%>
<%
mainuser=session.getAttribute("usertypevaluemain").toString();

try{

		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn1.createStatement();
		st3=conn1.createStatement();
		if(!(null==request.getQueryString()))
		{
			fromdate=request.getParameter("data1");
			todate=request.getParameter("data2");
			trans1=request.getParameter("trans");
			trans2=trans1;
			if(trans1.equals("All"))
			{
				trans1=" All Transporters ";
				sql="select Distinct(VehRegNo) as trans from t_group where GPName='"+session.getAttribute("usertypevaluemain").toString()+"' order by trans ";
				ResultSet rsttrans1=st.executeQuery(sql);
				trans="(";
				while(rsttrans1.next())
				{
				trans=trans+"'"+rsttrans1.getString("trans")+"',";
				}
				trans=trans.substring(0,trans.length()-1);
				trans=trans+")";
			}
			else
			{
				
				trans="('"+trans1+"')";
			}
		}
		else
		{
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			todate=fromdate;
		}
		
}
catch(Exception e)
{
	out.print("Exception -->"+e);
}
%>
<table border="1" bgcolor="white" width="100%">
		<tr>
			<td>
				<table border="1" class="stats">
					<tr>
						<td>
								<table border="0" width="100%" align="center">
								<form name="dateform" action="" method="get" onsubmit="return validate();">
									<tr>
										<td>
												<input type="text" id="data1" name="data1" class="formElement" value="<%=fromdate%>"  size="15" readonly/>
  										</td>
  										<td align="left">
												<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">
												<script type="text/javascript">
  													Calendar.setup(
    													{
      													inputField  : "data1",         // ID of the input field
      													ifFormat    : "%Y-%m-%d",     // the date format
      													button      : "trigger"       // ID of the button
    													}
  													);
												</script>
										</td>
										<td>
											<input type="text" id="data2" name="data2" class="formElement"  value="<%=todate%>" size="15" readonly/></td><td align="left">
  											<input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">
											<script type="text/javascript">
  												Calendar.setup(
    												{
      												inputField  : "data2",         // ID of the input field
      												ifFormat    : "%Y-%m-%d",    // the date format
      												button      : "trigger1"       // ID of the button
    												}
  												);
											</script>
										</td>
										<td>
											<%
											sql="select Distinct(VehRegNo) as trans from t_group where GPName='"+session.getAttribute("usertypevaluemain").toString()+"' order by VehRegNo ";
											//out.print(sql);
											ResultSet rsttrans=st.executeQuery(sql);
											%>
											Transporter : <select name="trans" id="trans" class="formElement">
											<option value="All">All</option>
											<%
											while(rsttrans.next())
											{
												%>
												<option value="<%=rsttrans.getString("trans")%>"><%=rsttrans.getString("trans")%></option>
												<%
											}
											%>
											</select>
										</td>
										<td>
											<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
											<input type="submit" name="submit" id="submit" value="submit" class="formElement">
										</td>
									</tr>
									<tr>
										<td colspan="6">
											<center class='bodyText'><b>Please select the dates to display the report</b></center>
										</td>
									</tr>
							</form>
							</table>

						</td>
					</tr>
					<tr>
						<td>
							<%
							if(!(null==request.getQueryString()))
							{
								try
									{
									%>
									<table border="0" width="100%" >
										<tr>
											<td colspan="11">
												<font color="brown" size="2">Trip Billing Report for <%=trans1%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
												<div align="right"><a href="#" onclick="javascript:window.open('print_trip_bill_report.jsp?data1=<%=fromdate%>&data2=<%=todate%>&trans=<%=trans2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_trip_bill_report.jsp?data1=<%=fromdate%>&data2=<%=todate%>&trans=<%=trans2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
		 										<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>		
											</td>
										</tr>	
									</table>
									<table border="0" class="sortable" width="100%">
										<tr>
											<td class="hed">Sr.</td>
											<td class="hed">Trip ID</td>
											<td class="hed">Driver</td>
											<td class="hed">Vehicle-No.</td>
											<td class="hed">Transporter</td>
											<td class="hed">Start Date</td>
											<td class="hed">Origin</td>
											<td class="hed">End Date</td>
											<td class="hed">Destination</td>
											<td class="hed">Dist. Km</td>
											<td class="hed">Run. Time</td>
											<td class="hed">Loading Delay Hrs.</td>
											<td class="hed">Un Loading Delay Hrs.</td>
										</tr>
											<%
											sql="select * from t_completedjourney where JDCode <>'-' and GPName='"+mainuser+"' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and OwnerName in "+trans+" and DATE(StartDate) <> DATE(EndDate) and KmTravelled > 1";
											//out.print(sql);
											ResultSet rst=st.executeQuery(sql);
											int i=1;
											while(rst.next())
											{
												%>
										<tr>
											<td class="bodyText"><%=i%></td>
											<td><%=rst.getString("TripId")%></td>
											<td><div align="left"><%=rst.getString("DriverName")%><%="("+rst.getString("DriverID")+")"%></div></td>
											<td><div align="left"><%=rst.getString("VehRegNo")%></div></td>
											<td><div align="left"><%=rst.getString("OwnerName")%></div></td>
											<td><%
												try
												{	
													out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"))));
												}catch(Exception ee)
												{
													out.print(rst.getString("StartDate"));
												}
												%>
											</td>
											<td><div align="left"><%=rst.getString("StartPlace")%></div></td>
											<td>
												<%
												try
													{	
														out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));
													}catch(Exception ee)
													{
														out.print(rst.getString("EndDate"));
													}
												%>	
											</td>
											<td><div align="left"><%=rst.getString("EndPlace")%></div></td>
											<td><div align="right"><%=rst.getString("KmTravelled")%></div></td>
											<td><div align="left"><%=rst.getString("TripDuration")%></div></td>
											<td><div align="right"><%=rst.getString("WaitingBefor")%></div></td>
											<td><div align="right"><%=rst.getString("WaitingAfter")%></div></td>
										</tr>
										<%
										i++;
										}
										%>		
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
								}
								%>
						</td>
					</tr>
			</table>
	</td>
</tr>
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
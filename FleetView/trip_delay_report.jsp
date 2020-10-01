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
String fromdate, todate,sql,sql1,transporter,mainuser;
%>
<%
mainuser=session.getAttribute("usertypevaluemain").toString();
if(!(null==request.getQueryString()))
{
	fromdate=request.getParameter("data1");
	todate=request.getParameter("data2");
}
else
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
todate=fromdate;
}

%>
<table border="1" bgcolor="white" width="100%">
<tr><td>
<table class="stats">
<tr><td>
<table class="stats">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td>
<input type="text" id="data1" name="data1" class="formElement" value="<%=fromdate%>"  size="15" readonly/>
  </td><td align="left">
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
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<input type="submit" name="submit" id="submit" value="submit" class="formElement"></td>
</tr>
<tr><td colspan="5"><center class='bodyText'><b>Please select the dates to display the report</b></center></td></tr>
</form>
</table>

</td></tr>
<tr><td>
<%
if(!(null==request.getQueryString()))
{
	try
	{
		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn1.createStatement();
		st3=conn1.createStatement();
	%>
	<table border="0" width="100%">
	<tr><td colspan="11"><font color="brown" size="2">Trips Delay Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
		<div align="right">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>		
		</td></tr>	
	</table>
		<table border="1" class="sortable" width="100%">
		
		<tr>
		<td>Sr.</td>
		<td>Trip ID</td>
		<td>Driver</td>
		<td>Veh.</td>
		<td>Transporter.</td>
		<td>Start Date</td>
		<td>Origin</td>
		<td>End Date</td>
		<td>Destination</td>
		<td>Waiting before trip</td>
		<td>Waiting After trip</td>
		</tr>
	<%
	sql="select * from t_completedjourney where JDCode <>'-' and GPName='"+mainuser+"' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and DATE(StartDate) <> DATE(EndDate)";
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
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
	
	}
	catch(Exception ee)
	{
		out.print(rst.getString("StartDate"));
	}
	%></td>
	<td><div align="left"><%=rst.getString("StartPlace")%></div></td>
	<td>
<%
		try
		{	
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));
	
	}
	catch(Exception ee)
	{
		out.print(rst.getString("EndDate"));
	}
	%>	
	</td>
	<td><div align="left"><%=rst.getString("EndPlace")%></div></td>
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
</td></tr>
</table>
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

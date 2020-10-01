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
	else if(dm1>month || dm2>month)
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
	
	else if(dm1>dm2)
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
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!-- code start Here -->
<table class="stats">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td>
<input type="text" id="data" name="data" class="formElement" value=""  size="15" readonly/>
  </td><td align="left">
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
</td>
<td>

<input type="text" id="data1" name="data1" class="formElement"  value="" size="15" readonly/></td><td align="left">
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
</td>
<td><input type="submit" name="submit" id="submit" value="submit" class="formElement"></td>
</tr>
</form>
</table>
<%
String dd=request.getQueryString();
if(dd==null)
{
%>
<table class="stats">
<tr><td>
<center class='bodyText'><b>Please select the dates to display the Driver Rating report</b></center>
</td><tr>
</table>
<%
}
else
{
%>

<%!
Connection conn, conn1;
Statement st, st1, st2,st3,st4;
String user,sql,sql1,sql2;
String data1, data2,showdate1,showdate,DriverName,Owner;
int OScount, RAcount, RDcount,Distance,nontripdistance;
double Rating;
 %>
<%
data1=request.getParameter("data");
data2=request.getParameter("data1");
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st4=conn1.createStatement();





%>
<table class="stats">
<tr><th colspan="8">Transporter Rating Report for <%=session.getAttribute("usertypevalue").toString()%> From date <%
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
<a href="#" onclick="javascript:window.open('printdriverratingbydate.jsp?data=<%=data1%>&data1=<%=data2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldriverratingbydate.jsp?data=<%=data1%>&data1=<%=data2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
<tr>
<td class="hed">Transporter</td>
<td class="hed">Trips</td>
<td class="hed">OS Count</td>
<td class="hed">RA Count</td>
<td class="hed">RD Count</td>
<td class="hed"><%=session.getAttribute("usertypevalue").toString()%> Trip Distance</td>
<td class="hed">Non <%=session.getAttribute("usertypevalue").toString()%> Trip Distance</td>
<td class="hed">Rating</td>
</tr>
<%
sql="select distinct(Transporter), avg(Rating) as Rating, sum(Distance) as Distance from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode <>'-' group by Transporter order by Rating desc";
ResultSet rst=st2.executeQuery(sql);
while(rst.next())
{
%>
<tr>
<td class="bodyText"><div align="left"><%=rst.getString("Transporter")%></div></td>
<%
sql="select sum(Distance) as Distance from t_driver_ds where Transporter='"+rst.getString("Transporter")+"' and Jcode='-' and TheDate >='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rst1=st3.executeQuery(sql);
if(rst1.next())
{
nontripdistance=rst1.getInt("Distance");
}
sql="select sum(OSCount) as OSCount, sum(RACount) as RACount, sum(RDCount) as RDCount from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and Jcode <>'-' and Transporter='"+rst.getString("Transporter")+"'";
ResultSet rst2=st4.executeQuery(sql);
if(rst2.next())
{
	OScount=rst2.getInt("OSCount");
	RAcount=rst2.getInt("RACount");
	RDcount=rst2.getInt("RDCount");
}
%>
<td class="bodyText"><div align="right"></div></td>
<td class="bodyText"><div align="right"><%=OScount%></div></td>
<td class="bodyText"><div align="right"><%=RAcount%></div></td>
<td class="bodyText"><div align="right"><%=RDcount%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("Distance")%></div></td>
<td class="bodyText"><div align="right"><%=nontripdistance%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("Rating")%></div></td>
</tr>
<%
}
%>
</table>
<%
}catch(Exception e)
{
	out.print("Exception -->"+ e);
}
finally
{
	conn.close();
	conn1.close();
}
}
%>
<!-- code end here -->
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

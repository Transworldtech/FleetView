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
<%
String ddx=request.getQueryString();
if(ddx==null)
{
	data1=data2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
}
else
{
	data1=request.getParameter("data");
	data2=request.getParameter("data1");
}
%>
<table border="1" width="100%" bgcolor="white" class="stats">
<tr><td>
<!-- code start Here -->
<table class="stats">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td>
<input type="text" id="data" name="data" class="formElement" value="<%=data1%>"  size="15" readonly/>
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

<input type="text" id="data1" name="data1" class="formElement"  value="<%=data2%>" size="15" readonly/></td><td align="left">
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
int OScount, RAcount, RDcount,Distance;
double Rating;
int OS1,RA1,RD1,CD1,DT1,ST1,RU1,ND1;
 %>
<%
OS1=0;
RA1=0;
RD1=0;
CD1=0;
DT1=0;
ST1=0;
RU1=0;
ND1=0;
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
<tr><th >Driver Wise Exceprion Report for <%=session.getAttribute("usertypevalue").toString()%> From date <%
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
<a href="#" onclick="javascript:window.open('printdriverwiseexceptions.jsp?data=<%=data1%>&data1=<%=data2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldriverwiseexceptions.jsp?data=<%=data1%>&data1=<%=data2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
 </table>
<table  class="sortable" width="100%" border="0" bgcolor="">
<tr>
<td class="hed">Sr.</td>
<td class="hed">Driver Name</td>
<td class="hed">Driver Code</td>
<td class="hed">Transporter</td>
<td class="hed">OS</td>
<td class="hed">RA</td>
<td class="hed">RD</td>
<td class="hed">CD</td>
<td class="hed">DT</td>
<td class="hed">STOPS</td>
<td class="hed">RUN Hrs.</td>
<td class="hed">ND</td>
</tr>
<%
sql="select dcode, sum(Distance) as dist from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' group by dcode";
ResultSet rstdcode=st3.executeQuery(sql);
String dcodes="(";
while(rstdcode.next())
{
	dcodes=dcodes+"'"+rstdcode.getString("dcode")+"',";
}
dcodes=dcodes.substring(0,dcodes.length()-1)+")";
//out.print(dcodes);
sql="select Distinct(DriverID),DriverName,Owner as OwnerName from t_drivers where GPName='Castrol' and DriverName <>'-' and DriverID in"+dcodes+" order by DriverName";
ResultSet rst=st.executeQuery(sql);
int i=1;
while(rst.next())
{
%>
<tr>
<td><%=i%></td>
<td><div align='left'><a href="driver_exceptions.jsp?data1=<%=data1%>&data2=<%=data2%>&dcode=<%=rst.getString("DriverID")%>&dname=<%=rst.getString("DriverName")%>&transporter=<%=rst.getString("OwnerName")%>"><%=rst.getString("DriverName")%></a></div></td>
<td><div align='right'><%=rst.getString("DriverID")%></div></td>
<td><div align='left'><%=rst.getString("OwnerName")%></div></td>
<td><div align="right">
<%
sql="select count(*) as os from t_driver_overspeed where Dcode='"+rst.getString("DriverID")+"' and FromDate >='"+data1+"' and FromDate <='"+data2+"'";
ResultSet rstos=st2.executeQuery(sql);
if(rstos.next())
{
	out.print(rstos.getInt("OS"));
	OS1=OS1+rstos.getInt("OS");
}
%>
</div>
</td>
<td><div align="right">
<%
sql="select count(*) as RA from t_driver_ra where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rstra=st2.executeQuery(sql);
if(rstra.next())
{
	out.print(rstra.getInt("RA"));
	RA1=RA1+rstra.getInt("RA");
}
%></div>
</td>
<td><div align="right">
<%
sql="select count(*) as RD from t_driver_rd where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rstrd=st2.executeQuery(sql);
if(rstrd.next())
{
	out.print(rstrd.getInt("RD"));
	RD1=RD1+rstrd.getInt("RD");
}
%></div>
</td>
<td><div align="right">
<%
sql="select count(*) as CR from t_driver_cr where Dcode='"+rst.getString("DriverID")+"' and FromDate >='"+data1+"' and FromDate <='"+data2+"'";
ResultSet rstcr=st2.executeQuery(sql);
if(rstcr.next())
{
	out.print(rstcr.getInt("CR"));
	CD1=CD1+rstcr.getInt("CR");
}
%></div>
</td>
<td><div align="right">
<%
sql="select sum(Distance) as DS from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rstds=st2.executeQuery(sql);
if(rstds.next())
{
	out.print(rstds.getInt("DS"));
	DT1=DT1+rstds.getInt("DS");
}
%></div>
</td>
<td><div align="right">
<%
sql="select count(*) as ST from t_driver_stsp where Dcode='"+rst.getString("DriverID")+"' and FromDate >='"+data1+"' and FromDate <='"+data2+"'";
ResultSet rstst=st2.executeQuery(sql);
if(rstst.next())
{
	out.print(rstst.getInt("ST"));
	ST1=ST1+rstst.getInt("ST");
}
%>
</div>
</td>
<td><div align="right">
<%
sql="select sum(HOUR(RDuration)*60 + MINUTE(RDuration)+SECOND(RDuration)/60)/60 as HR from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rsthr=st2.executeQuery(sql);
if(rsthr.next())
{
	out.print(rsthr.getInt("HR"));
	RU1=RU1+rsthr.getInt("HR");
}
%>
</div>
</td>
<td>
<%
sql="select count(*) ND from t_driver_ds where Dcode='"+rst.getString("DriverID")+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' and ND='Yes'";
ResultSet rstnd=st2.executeQuery(sql);
if(rstnd.next())
{
	if(rstnd.getInt("ND") > 0)
	{
		out.print("Yes");
		ND1++;
	}
	else
	{
		out.print("No");
	}
}
%>

</td>
</tr>
<%
i++;
}
%>
<tr class="sortbottom">
<td colspan="4" class="hed">Total </td>
<td class="hed"><%=OS1%></td>
<td class="hed"><%=RA1%></td>
<td class="hed"><%=RD1%></td>
<td class="hed"><%=CD1%></td>
<td class="hed"><%=DT1%></td>
<td class="hed"><%=ST1%></td>
<td class="hed"><%=RU1%></td>
<td class="hed"><%=ND1%></td>
</tr>
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
</table>
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

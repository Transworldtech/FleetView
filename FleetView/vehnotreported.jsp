<%@ include file="header.jsp" %>
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
  <%!
	String date1,date2,thedate,thedatenew;  
  Connection conn;
  Statement st,st1,st2;
  String sql,sql1,t1,t2;
  int days,datalost;
  %>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td>
<table border="0" width="100%" align="center">
<tr><td align="center"><font color="brown" size="3">Vehicle Not Reported</font></td></tr>
<tr><td>
<table class="stats">
<form action="" method="get" name="dateform"  onsubmit="return validate();">
<tr>
<td><input type="text" id="data" name="data" class="formElement"  size="10" readonly/>
<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script></td>
<td>

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
</td>
<td>
<input type="submit" name="submit" id="submit" value="submit" class="formElement">
</td>
<td><font color="brown" size="2">Note: Please Select the date range.</font></td>
</tr>
<form>

<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
String thedate=request.getParameter("data1");
if(!(null==thedate))
{
date1=request.getParameter("data");
date2=request.getParameter("data1");
%>
<tr><td colspan="4" align="center"><font color="brown" size="2">Data Analysis Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("data")))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("data1")))%></font></td></tr>
<tr><td colspan="4">
<table class="sortable" width="100%" align="center" border="1">
<tr><td><font color="black" size="2">Sr.</font></td><td><font color="black" size="2">Vehicle Reg. No</font></td><td><font color="black" size="2">Full Data Days</font></td><td><font color="black" size="2">Data Gap Days</font></td></tr>
<%
sql="select * from t_vehicledetails where ownername='"+session.getAttribute("usertypevalue").toString()+"'";
//out.print(sql);
ResultSet rst=st.executeQuery(sql);
int i=1;
while(rst.next())
{
thedate=date1;
%>
<tr>
<td><%=i%></td>
<td><%=rst.getString("VehicleRegNumber")%></td>
<td>
<%
sql="select (TO_DAYS('"+date2+"')-TO_DAYS('"+date1+"')) as days";
ResultSet rst2=st1.executeQuery(sql);
if(rst2.next())
{
	days=rst2.getInt("days");
}
datalost=0;
for(int j=0;j<=days;j++)
{
if(j==0)
{
	thedatenew=thedate;
	java.util.Date dt= new SimpleDateFormat("yyyy-MM-dd").parse(thedatenew);
}
else
{
	java.util.Date dt= new SimpleDateFormat("yyyy-MM-dd").parse(thedatenew);
	long mils=dt.getTime();
	mils=mils+1000*60*60*24;
	dt.setTime(mils);
	thedatenew=new SimpleDateFormat("yyyy-MM-dd").format(dt);
}
//out.print(thedatenew);
sql="select * from t_timeslots";
ResultSet rst1=st1.executeQuery(sql);

while(rst1.next())
{

	t1=rst1.getString("Slot1");
	rst1.next();
		
		if(rst1.next())
		{
			t2=rst1.getString("Slot1");
			
			rst1.previous();
		}
		if(t1.equals("23:00:00"))
		{
			t2="23:59:59";
		}
		if(!(t2.equals(t1)))
		{
		sql="select count(*) as cnt from t_veh"+rst.getString("VehicleCode")+" where TheFieldDataDate='"+thedatenew+"' and TheFieldDataTime >='"+t1+"' and TheFieldDataTime <='"+t2+"'";
		ResultSet rst3=st2.executeQuery(sql);
		if(rst3.next())
		{
			if(rst3.getInt("cnt")==0)
			{
				datalost=datalost+1;
				rst1.last();
			}
		}
		}
}

}
out.print(days+1-datalost);
%>
</td>
<td>
<%=datalost%>
</td>
</tr>
<%
i++;
}
%>
</table>
</td></tr>
<%
}
}catch(Exception e)
{
	out.print("Exception-->"+e);
}
finally
{
	conn.close();
}
%>
</table>
</td></tr>
</table>

</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
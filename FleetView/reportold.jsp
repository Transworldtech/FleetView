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
		alert("Form date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(dm1>dm2)
	{
		alert("Form date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("Form date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}

  </script>
<!-- header end here-->




<%
String userID1 = "";
if (! session.isNew()) 
userID1 = (String) session.getAttribute("user");
if (null == userID1) 
	{
		response.sendRedirect("index.jsp");
	}
else
	{
%>

 <table border="1" width="100%" bgcolor="white">
<tr>
<%! int cntos=0,cntra=0,cntrda=0,cntdt=0,cntst=0,cntrh=0,cntcd=0,cntnd; 
%>
<%
cntos=0;
cntra=0;
cntrda=0;
cntdt=0;
cntst=0;
cntrh=0;
cntcd=0;
cntnd=0;

%><td valign="top" id="img" width="15%">
<table width="100%" border="0" class="stats">
	<tr><td><a href="last24hours.jsp">Report For Last 24 Hours.</a></td></tr>
	<tr><td><a href="last48hours.jsp">Report For Last 48 Hours.</a></td></tr>
	<tr><td><a href="last7days.jsp">Report For Last 7 Days.</a></td></tr>
	<tr><td><a href="last15days.jsp">Report For Last 15 Days.</a></td></tr>
	<tr><td><a href="reportbyplace.jsp">Vehicle Near To Place</a></td></tr>
</table>
</td><%!

Connection conn,MM_connUser,conn1;
Statement st1,st,st2,st3,st4;
%>


<td valign="top">
<table border="0"   class="stats"><tr bgcolor="lightgreen"><td align="center" colspan="5"  class="hed"><font color="red" size="2" ><center>Custom Reports</center></font></td></tr>
<form action="" method="get" onsubmit="return validate();">
<tr bgcolor="#87CEFA"><td align="right">

  <input type="text" id="data" name="data" class="formElement"  size="10" readonly/>
  </td><td align="left">
<input type="button" name="From Date" value="Form Date" id="trigger" class="formElement">
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
<td align="right">

  <input type="text" id="data1" name="data1" class="formElement"  size="10" readonly/></td><td align="left">
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
</td><td><input type="submit" name="submit" id="submit" value="submit" class="formElement"></td></tr>
</form>
<tr><td colspan="5" class="hed">
<%
String dd=request.getQueryString();
if(dd==null)
{
out.println("<center >Please select the dates to display the report.</center>");
}
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);

session.setAttribute("ShowDate",showdate);
session.setAttribute("ShowDate1",showdate1);

session.setAttribute("data1",data1);
session.setAttribute("data2",data2);
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
//database connectivity to get the transporter wise report.
try{
	Class.forName(MM_dbConn_DRIVER); 
	MM_connUser = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	


%>
<!--html code to display the report as per the selected dates. -->
<table border="0" width="100%" class="stats" >
<tr ><td background="images/background1.bmp"><a href="index1.jsp">Show Pie Chart</a></td><td background="images/background1.bmp"><a href="graph.jsp">Show Bar Chart</a></td><td background="images/background1.bmp"><a href="report.jsp?data=<%=session.getAttribute("data1")%>&data1=<%=session.getAttribute("data2")%>">Report</a></td></tr>
<tr><td colspan="3" align="center" bgcolor="yellow" class="hed"><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> Logistics For the Period :<%= session.getAttribute("ShowDate").toString() %> to <%=session.getAttribute("ShowDate1").toString() %></b></center></td></tr>
</table>

<table border="1" width="100%" bgcolor="#F5F5F5" class="stats">
<tr><td colspan="3" class="hed"><DIV align="left">Parameters considered for the report</div></td></tr>
<tr><td class="bodyText"><div align="left">1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %>
</div></td><td class="bodyText"><div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></div></td><td class="bodyText" ><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></div></td></tr>
<tr>
<td class="bodyText"><div align="left">4. Night Driving :Beyond <%=session.getAttribute("ndri").toString() %> 
</div>
</td><td class="bodyText"><div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %></div></td>
<td  class="bodyText"><div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %></div></td></tr>
</table>

<p></p>
<table border="1" width="100%" bgcolor="#F5F5F5" class="stats">
<tr ><td align="center" class="hed"><B>Vehicle Reg no.</B></td><td align="center" class="hed"><B>Location at EOD </B></td><td align="center" class="hed"><B>OS</B></td><td class="hed" align="center"><B>RA</B></td><td align="center" class="hed"><B>RD</B></td><td class="hed" align="center"><B>CD</B></td><td align="center" class="hed"><B>DT</B></td><td align="center" class="hed"><B>No.of Stops</B></td><td align="center" class="hed"><B>Run Hrs.</B></td><td align="center" class="hed"><B>ND</B></td></tr>
<!-- Get The Data From the Database and show it -->

<%	
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_veh"+aa+"_ds";
	if(!aa.equals("0")){

String sql3="select * from t_vehicledetails where VehicleCode='"+aa+"'";
String sql4="select Location from "+tbname+" where VehCode='"+aa+"' and TheDate<='"+data2+"' order by TheDate desc";
String sql5="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount),SUM(RDuration) from "+tbname+" where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";
String sql6="select ND from "+tbname+" where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";
	st3=MM_connUser.createStatement();
	st4=conn1.createStatement();
	ResultSet rst3=st3.executeQuery(sql3);
	if(rst3.next())
	{
		%>
		<tr ><td class="bodyText" align="center"><% String str=rst3.getString(2); if(str.equals(""))out.print("No Data"); 			else out.print("<a href='customreport.jsp?vid="+aa+"&vehno="+str+"' >"+str+"</a>"); %>  </td>
		<%
	}
	else
	{		
		out.print("<tr><td class='bodyText' align='center'>&nbsp;</td>");
	}
	ResultSet rst4=st4.executeQuery(sql4);
	if(rst4.next())
	{
		%>
		<td class="bodyText"><div align="left"><% String loc=rst4.getString("Location"); if(loc.equals("-")) out.print("No Data");
else 
{
out.print(loc); } %></div></td>
		<%
	}
	else
	{
		out.print("<td class='bodyText'><div align='left'>No Data</div></td>");
	}
	ResultSet rst5=st4.executeQuery(sql5);
	if(rst5.next())
	{
		%>
<td class="bodyText" align="center"><% String os=rst5.getString(1); if(os==null) out.print("0"); else{cntos+=Integer.parseInt(os); out.print(os); }%></td>
<td class="bodyText" align="center"><% String os1=rst5.getString(2); if(os1==null) out.print("0"); else{cntra+=Integer.parseInt(os1); out.print(os1);} %></td>
<td class="bodyText" align="center"><% String os2=rst5.getString(3); if(os2==null) out.print("0"); else{cntrda+=Integer.parseInt(os2); out.print(os2);} %></td>
<td class="bodyText" align="center"><% String os3=rst5.getString(4); if(os3==null) out.print("0"); else{cntcd+=Integer.parseInt(os3); out.print(os3);} %></td>
<td class="bodyText" align="center"><% String os4=rst5.getString(5); if(os4==null) out.print("0"); else{cntdt+=Integer.parseInt(os4); out.print(os4); } %></td>
<td class="bodyText" align="center"><% String os5=rst5.getString(6); if(os5==null) out.print("0"); else{cntst+=Integer.parseInt(os5); out.print(os5);} %></td>
<td class="bodyText" align="center"><% String os6=rst5.getString(7); if(os6==null) out.print("0"); else{cntrh+=Integer.parseInt(os6); out.print(os6);} %></td>
		<%
	}
	else
	{
		out.print("<td class='bodyText' align='center'>0</td><td class='bodyText' align='center'>0</td><td class='bodyText' align='center'>0</td><td class='bodyText' align='center'>0</td><td class='bodyText' align='center'>0</td><td class='bodyText' align='center'>0</td><td class='bodyText' align='center'>0</td>");
	}
	ResultSet rst6=st4.executeQuery(sql6);
	boolean flag=false;	
	while(rst6.next())
	{
		if(rst6.getString(1).equals("Yes"))
		{
			flag=true;
			cntnd++;
		}
	}
	if(flag){		
		%>
		<td class="bodyText" align="center">Yes</td>
		<%
	}
	else
	{
		%>
		<td class="bodyText" align="center">No</td>
		<%
	}
	
	
	}
	}
	
	}catch(Exception e)
	{
		System.out.println("Exception" +e);
	}
	finally
{
	conn.close();
	MM_connUser.close();
	conn1.close();
}
%>
<tr ><td colspan="2" class="hed">Total</td>
<td class="hed"><%=cntos %></td>
<td class="hed"><%=cntra %></td>
<td class="hed"><%=cntrda %></td>
<td class="hed"><%=cntcd %></td>
<td class="hed"><%=cntdt %></td>
<td class="hed"><%=cntst %></td>
<td class="hed"><%=cntrh %></td>
<td class="hed"><%=cntnd %></td>
</tr>

<tr><td colspan="10" align="center"><a href="printreport.jsp" TARGET="_NEW">Print Report</a> </td></tr>
</table>
<%

}
String datanames[] = {"Over Speed", "Rapid Acceleration", "Rapid Deceleration", "Continuous Driving","Night Driving"};//,"Stoppages", "Distance Travled", "RunHours"};
int per=cntos+cntra+cntrda+cntcd+cntnd;//+cntst+cntdt+cntrh;

double datavalues[] = {cntos, cntra, cntrda, cntcd, cntnd};//, cntst, cntdt,cntrh};
double datavalues1[] = {cntos, cntra, cntrda, cntcd, cntnd};
for(int i=0; i<datavalues.length; i++){
if(datavalues[i]>0)
{
	datavalues[i]=datavalues[i]/per*100;
}
	
}
session.setAttribute("datanames",datanames);
session.setAttribute("datavalues",datavalues);
session.setAttribute("datavalues1",datavalues1);

%>

</td></tr>
</table>
</td></tr></table>


<%
}

%>

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
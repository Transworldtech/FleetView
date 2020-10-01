<%@ include file="header.jsp" %>
<%!
String fidDate1,difDate2,user,usertypevalue,ftime,ttime,fromdate,fromtime,todate,totime,fff,ttt,vehregnumber,location;
Connection conn12;
Statement st,st1,st2,st3,st4,st5,st6,st7,st8,st9,st10;
String sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,sql9,sql10;
ResultSet rst,rst1,rst2,rst3,rst4,rst5,rst6,rst7,rst8,rst9,rst10;
int cntos=0,cntra=0,cntrda=0,cntdt=0,cntst=0,cntrh=0,cntcd=0,cntnd=0,cntsp,i,stcount;
%>

<%
java.util.Date defoultdate = new java.util.Date();
Format formatter13 = new SimpleDateFormat("yyyy-MM-dd");
fidDate1 = formatter13.format(defoultdate);
difDate2 = formatter13.format(defoultdate);

try{
	Class.forName(MM_dbConn_DRIVER);
	conn12 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st=conn12.createStatement();
	st1=conn12.createStatement();
	st2=conn12.createStatement();
	st3=conn12.createStatement();
	st4=conn12.createStatement();
	st5=conn12.createStatement();
	st6=conn12.createStatement();
	st7=conn12.createStatement();
	st8=conn12.createStatement();
	st9=conn12.createStatement();
	st10=conn12.createStatement();
		
}catch(Exception e)
{
	System.out.println("Exception "+e);
}

%>
<table border="1" width="100%" bgcolor="white">
<tr><td width="15%" valign="top"><table width="100%" border="0" class="stats">
	<tr><td><a href="last24hours.jsp">Report For Last 24 Hours.</a></td></tr>
	<tr><td><a href="last48hours.jsp">Report For Last 48 Hours.</a></td></tr>
	<tr><td><a href="last7days.jsp">Report For Last 7 Days.</a></td></tr>
	<tr><td><a href="last15days.jsp">Report For Last 15 Days.</a></td></tr>
	<tr><td><a href="reportbyplace.jsp">Vehicle Near To Depo.</a></td></tr>
</table>
</td>
<td valign="top">
<table border="0"   class="stats"><tr bgcolor="lightgreen"><td align="center" colspan="5"  class="hed"><font color="red" size="2" ><center>Custom Reports</center></font></td></tr>
<form action="" method="get" onsubmit="return validate();">
<tr bgcolor="#87CEFA"><td class="bodyText" ALIGN=MIDDLE>
<b>From Date & Time </b>
  <input type="text" id="data" name="data" class="formElement"  size="10" value="<%=fidDate1%>" readonly/><select name="fromHour" class="formElement">
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

for(i=10; i<=23; i++)
{
%>
<option value="<%=i%>"><%=i%></option>
<%
}

%>
</select>
<select name="fromMinute" class="formElement">
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

for(i=10; i<=59; i++)
{
%>
<option value="<%=i%>"><%=i%></option>
<%
}

%>
</select>
<select name="fromSecond" class="formElement">
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

for(i=10; i<=59; i++)
{
%>
<option value="<%=i%>"><%=i%></option>
<%
}

%></select>
<img src="images/calendar.png" id="trigger">

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
<td class="bodyText">
<b>To Date & Time </b>
  <input type="text" id="data1" name="data1" class="formElement"  size="10" value="<%=fidDate1%>" readonly/>
<select name="toHour" class="formElement">
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

for(i=10; i<=22; i++)
{
%>
<option value="<%=i%>" ><%=i%></option>
<%
}

%>
<option value="23" "selected">23</option>
</select>
<select name="toMinute" class="formElement">
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

for(i=10; i<=58; i++)
{
%>
<option value="<%=i%>" ><%=i%></option>
<%
}

%>
<option value="59" "selected">59</option>
</select>
<select name="toSecond" class="formElement">
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

for(i=10; i<=58; i++)
{
%>
<option value="<%=i%>"><%=i%></option>
<%
}

%>
<option value="59" "selected">59</option>
</select>
<img src="images/calendar.png" id="trigger1" >
  
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td><td><input type="submit" name="submit" id="submit" value="submit" class="formElement">
</td></tr>
</form>
<tr><td colspan="5" class="hed">
<%
String dd=request.getQueryString();
if(dd==null)
{
out.println("<center >Please select the dates to display the report.</center>");
}else
{
%>
<table class="stats">
<tr><td>
<%
String data1=request.getParameter("data");String data2=request.getParameter("data1");
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
ftime=request.getParameter("fromHour")+":"+request.getParameter("fromMinute")+":"+request.getParameter("fromSecond");
ttime=request.getParameter("toHour")+":"+request.getParameter("toMinute")+":"+request.getParameter("toSecond");

session.setAttribute("ShowDate",showdate);
session.setAttribute("ShowDate1",showdate1);
session.setAttribute("ShowTime",ftime);
session.setAttribute("ShowTime1",ttime);
session.setAttribute("data1",data1);
session.setAttribute("data2",data2);

user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();

//database connectivity to get the transporter wise report.
%>
<!--html code to display the report as per the selected dates. -->
<table border="0" width="100%" class="stats" >
<tr ><td background="images/background1.bmp"><a href="index1.jsp">Show Pie Chart</a></td><td background="images/background1.bmp"><a href="graph.jsp">Show Bar Chart</a></td><td background="images/background1.bmp"><a href="report.jsp?data=<%=session.getAttribute("data1")%>&data1=<%=session.getAttribute("data2")%>">Report</a></td></tr>
<tr><td colspan="3" align="center" bgcolor="yellow" class="hed"><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period :<%= session.getAttribute("ShowDate").toString() %> <%= session.getAttribute("ShowTime").toString() %> to <%=session.getAttribute("ShowDate1").toString() %>  <%= session.getAttribute("ShowTime1").toString() %></b></center></td></tr>
</table>
</td></tr>
<tr><td>
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
</td></tr>
<tr><td>
<table border="1" width="100%" bgcolor="#F5F5F5" class="stats">

<tr ><td align="center" class="hed"><B>Vehicle Reg no.</B></td><td align="center" class="hed"><B>Location at EOD </B></td><td align="center" class="hed"><B>OS</B></td><td class="hed" align="center"><B>RA</B></td><td align="center" class="hed"><B>RD</B></td><td class="hed" align="center"><B>CD</B></td><td align="center" class="hed"><B>DT</B></td><td align="center" class="hed"><B>No.of Stops</B></td><td align="center" class="hed"><B>Run Hrs.</B></td><td align="center" class="hed"><B>ND</B></td></tr>
<%	
	try{
	fromdate=request.getParameter("data");	
	todate=request.getParameter("data1");	
	fromtime=request.getParameter("fromHour")+":"+request.getParameter("fromMinute")+":"+request.getParameter("fromSecond");
	totime=request.getParameter("toHour")+":"+request.getParameter("toMinute")+":"+request.getParameter("toSecond");
	fff=fromdate+fromtime;
	ttt=todate+totime;
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_veh"+aa;
	if(!aa.equals("0")){
	cntos=0;
	cntra=0;
	cntrda=0;
	cntdt=0;
	cntst=0;
	cntrh=0;
	cntcd=0;
	cntnd=0;
	cntsp=0;
	stcount=0;
	%>
</tr>
<tr><td class="bodyText" align="left">
<%
/***************Query to get Vehicle reg number Location EOD and Lat Long ********/
sql5="";
sql5="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+aa+"'";
 
rst5=st5.executeQuery(sql5);
if(rst5.next())
{
	String str=rst5.getString("VehicleRegNumber");
	vehregnumber="<a href='customreport.jsp?vid="+aa+"&vehno="+str+"' >"+str+"</a>";
}


out.print(vehregnumber);
rst5.close();

 %></td>
<td class="bodyText">
<%
sql6="";
sql6="select * from "+tbname+" where TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime >='"+fromtime+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime <='"+totime+"' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
rst6=st6.executeQuery(sql6);
if(rst6.next())
{
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
%><a href="shownewmap.jsp?lat=<%=rst6.getString("LatitudeDir")%>&long=<%=rst6.getString("LongitudeDir")%>&discription=<%=rst6.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst6.getString("LatitudeDir")%>&long=<%=rst6.getString("LongitudeDir")%>&discription=<%=rst6.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst6.getString("TheFieldSubject")%></a>
<%
}
else
{
%><a href="shownewmap.jsp?lat=<%=rst6.getString("LatinDec")%>&long=<%=rst6.getString("LonginDec")%>&discription=<%=rst6.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst6.getString("LatinDec")%>&long=<%=rst6.getString("LonginDec")%>&discription=<%=rst6.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst6.getString("TheFieldSubject")%></a>
<%
}

}
else
{
out.print("No Data");
}
%>
</td>
<td class="bodyText">
<%
/**************Query For Geting Over Speed Count *******************/
sql="";
sql="select TheFieldDataDate from "+tbname+" where TheFiledTextFileName='OS' and TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime >='"+fromtime+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime <='"+totime+"'";
rst=st.executeQuery(sql);
while(rst.next())
{
cntos++;
}
%>
<%

out.print(cntos);

rst.close();
/*******************************************************************/
%>

</td>
<td class="bodyText">
<%
/**************Query For Geting Rapid Accelaration Count *******************/
sql1="";
sql1="select TheFieldDataDate from "+tbname+" where TheFiledTextFileName='AC' and TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime >='"+fromtime+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime <='"+totime+"'";
rst1=st1.executeQuery(sql1);
while(rst1.next())
{
cntra++;
}
out.print(cntra);
rst1.close();
/**********************************************************************/
%>
</td>
<td class="bodyText">
<%/**************Query For Geting Rapid Dcelaration Count *******************/
sql2="";
sql2="select TheFieldDataDate from "+tbname+" where TheFiledTextFileName='DC' and TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime >='"+fromtime+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime <='"+totime+"'";
rst2=st2.executeQuery(sql2);
while(rst2.next())
{
cntrda++;
}
out.print(cntrda);
rst2.close();
/*****************************************************************/
%>
</td>
<td class="bodyText">
</td>
<td class="bodyText">
<%
/**************Query For Geting Distance *******************/
sql3="";
sql3="select Distance from "+tbname+" where TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime >='"+fromtime+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime <='"+totime+"' and TheFiledTextFileName ='SI'";
rst3=st3.executeQuery(sql3);
int dist=0;
boolean flag=true;
cntdt=0;
while(rst3.next())
{
if(flag)
{
	dist=rst3.getInt("Distance");
	flag=false;
}
cntdt=rst3.getInt("Distance");
}
cntdt=cntdt-dist;

out.print(cntdt);
rst3.close();
/**************************************************************/
%>
</td>



</tr>



<%


	}//end if.
	}//end while.
}//end try.
catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn12.close();
}
%>

</table>


</td></tr>
</table>

<%
}//end else.
%>
</td>
</table>


</td>

</tr>
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

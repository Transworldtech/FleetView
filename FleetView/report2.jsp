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
<%! 
int i,cntos,cntac,cntdc,dtcount,mindist,maxdist,cntsi,speed,cntrh,cntcr1,cntcr,cntsp,Dist,Dist1,Dist2;
int cntos1,cntra1,cntrda1,cntcd1,cntdt1,cntst1,cntrh1,cntnd1;
Connection conn;
Statement st,st1,st2;
String data1,data2,fromtime1,fromtime2,totime1,totime2,user,usertypevalue,rfff,rttt,fidDate1;
String sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,aa,tbname,stamp,loc,lat,lon;
int hh,mm;
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr><!-- <td width="15%" valign="top">

<table width="100%" border="0" class="stats">
	<tr><td><a href="last24hours.jsp">Report For Last 24 Hours.</a></td></tr>
	<tr><td><a href="last48hours.jsp">Report For Last 48 Hours.</a></td></tr>
	<tr><td><a href="last7days.jsp">Report For Last 7 Days.</a></td></tr>
	<tr><td><a href="last15days.jsp">Report For Last 15 Days.</a></td></tr>
	<tr><td><a href="reportbyplace.jsp">Vehicle Near To Depo.</a></td></tr>
</table>

</td>
-->
<%
java.util.Date defoultdate = new java.util.Date();
Format formatter0 = new SimpleDateFormat("yyyy-MM-dd");
fidDate1 = formatter0.format(defoultdate);
hh=defoultdate.getHours();
mm=defoultdate.getMinutes();
%>

<td valign="top"> 
<table border="0" class="stats"><tr><td colspan="3" class="hed"><font color="red" size="2" ><center>Custom Report</center></font></td></tr>
<form action="" method="get" onsubmit="return validate();">
<tr><td class="bodyText">

From Date :<input type="text" id="data" name="data" class="formElement"  size="10" value="<%=fidDate1%>" readonly/>
    <img src="images/calendar.png" id="trigger" ><script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td align="right" class="bodyText">

  To Date :  <input type="text" id="data1" name="data1" size="10" class="formElement" value="<%=fidDate1%>" readonly/>
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
</td><td><input type="submit" name="submit" id="submit" value="submit" class="formElement"></td></tr>
</form>

<tr><td class="hed" colspan="3">
<%
String dd=request.getQueryString();
if(dd==null)
{
out.println("<center >Please select the Time to display the report.</center>");
}
else{
cntos1=0;
cntra1=0;
cntrda1=0;
cntcd1=0;
cntst1=0;
cntrh1=0;
cntnd1=0;
data1=request.getParameter("data");
data2=request.getParameter("data1");
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

user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();

try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
%>
<table border="0" width="100%" class="stats" >
<tr ><td background="images/background1.bmp"><a href="index1.jsp">Show Pie Chart</a></td><td background="images/background1.bmp"><a href="graph.jsp">Show Bar Chart</a></td><td background="images/background1.bmp"><a href="report.jsp?data=<%=session.getAttribute("data1")%>&data1=<%=session.getAttribute("data2")%>">Report</a></td></tr>
<tr><td colspan="3" align="center" bgcolor="yellow" class="hed"><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period :<%= session.getAttribute("ShowDate").toString() %> to <%=session.getAttribute("ShowDate1").toString() %></b></center></td></tr>
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
<table border="1" width="100%" bgcolor="#F5F5F5" class="stats">

<tr ><td align="center" class="hed"><B>Vehicle Reg no.</B></td><td align="center" class="hed"><B>Location at EOD </B></td><td align="center" class="hed"><B>OS</B></td><td class="hed" align="center"><B>RA</B></td><td align="center" class="hed"><B>RD</B></td><td class="hed" align="center"><B>CD</B></td><td align="center" class="hed"><B>DT</B></td><td align="center" class="hed"><B>No.of Stops</B></td><td align="center" class="hed"><B>Run Hrs.</B></td><td align="center" class="hed"><B>ND</B></td></tr>

<%
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_veh"+aa;
	if(!aa.equals("0")){
	
	sql="select * from t_vehicledetails where VehicleCode='"+aa+"'";
	
	sql1="select * from "+tbname+" where TheFieldDataDate>='"+data1+"'  and TheFieldDataDate<='"+data2+"'";
ResultSet rst1=st.executeQuery(sql1);
cntos=0;
cntac=0;
cntdc=0;
dtcount=0;
mindist=0;
maxdist=0;
cntsi=0;
speed=0;
cntrh=0;
cntcr1=0;
cntcr=0;
cntsp=0;
Dist=0;
Dist1=0;
Dist2=0;
while(rst1.next())
{
stamp=rst1.getString("TheFiledTextFileName");
if(stamp.equals("SI"))
{
if(dtcount==0)
{
mindist=rst1.getInt("Distance");
dtcount=1;
}
else
	maxdist=rst1.getInt("Distance");
}//end if

if(stamp.equals("OS"))
{
cntos++;
}//end if
if(stamp.equals("AC"))
{
cntac++;
}//end if
if(stamp.equals("DC"))
{
cntdc++;
}//end if
loc=rst1.getString("TheFieldSubject");
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
lat=rst1.getString("LatitudeDir");
lon=rst1.getString("LongitudeDir");
}// end if.
else
{
lat=rst1.getString("LatinDec");
lon=rst1.getString("LonginDec");
}//end else.
if(stamp.equals("SI") && rst1.getInt("Speed") >0)
{
cntsi++;
speed=speed+rst1.getInt("Speed");
}
}//end while rst1.

%>
<tr><td class="bodyText">
<% ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
	String str=rst.getString(2); 
	out.print("<a href='customreport.jsp?vid="+aa+"&vehno="+str+"' >"+str+"</a>");
	}//enfd if.
%>
</td>
<td class="bodyText">
<div align="left">
<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a></div>
</td>
<td class="bodyText">
<%=cntos%>
<%
cntos1=cntos1+cntos;
%>
</td>
<td class="bodyText">
<%=cntac%>
<%
cntra1=cntra1+cntac;
%>
</td>
<td class="bodyText">
<%=cntdc%>
<%
cntrda1=cntrda1+cntdc;
%>
</td>
<td class="bodyText">
<% 
sql2="select TheFieldDataDate,TheFieldDataTime, Distance from "+tbname+" where TheFieldDataDate>='"+data1+"' and TheFieldDataDate<='"+data2+"' and TheFiledTextFileName='ST' order by TheFieldDataDate,TheFieldDataTime asc";
ResultSet rst2=st.executeQuery(sql2);

while(rst2.next())
{
sql3="select TheFieldDataDate,TheFieldDataTime ,Distance from "+tbname+" where TheFieldDataDate<='"+rst2.getString("TheFieldDataDate")+"' and TheFieldDataTime<='"+rst2.getString("TheFieldDataTime")+"' and TheFiledTextFileName='SP' order by TheFieldDataDate,TheFieldDataTime asc limit 1";

ResultSet rst3=st1.executeQuery(sql3);
while(rst3.next())
{
int speed1=speed;
int dist=rst3.getInt("Distance")-rst2.getInt("Distance");
if(speed1 >0 && cntsi >0)
{
speed1=speed1/cntsi;
cntcr1=dist/speed1;
if(cntcr1>5)
{
	cntcr++;
}//end if
}//end if

}//end while rst3.
}//end while rst2.
out.print(cntcr);
cntcd1=cntcd1+cntcr;
%>
</td>
<td class="bodyText">
<%=(maxdist-mindist)%>
<%
cntdt1=cntdt1+(maxdist-mindist);
%>
</td>
<td class="bodyText">
<%
sql4="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from "+tbname+" where TheFieldDataDate >='"+data1+"' and TheFieldDataDate <='"+data2+"' and TheFiledTextFileName='SP' order by TheFieldDataDate,TheFieldDataTime asc";
ResultSet rst4=st.executeQuery(sql4);
while(rst4.next())
{
sql5="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from "+tbname+" where TheFieldDataDate >='"+rst4.getString("TheFieldDataDate")+"' and TheFieldDataTime >='"+rst4.getString("TheFieldDataTime")+"' and TheFieldDataDate <='"+data2+"' and TheFiledTextFileName='ST' order by TheFieldDataDate,TheFieldDataTime asc limit 1";
ResultSet rst5=st1.executeQuery(sql5);
if(rst5.next())
{
//out.print(rst5.getInt("time2")-rst5.getInt("time1"));
if((rst5.getInt("time2")-rst4.getInt("time1")) > Integer.parseInt(session.getAttribute("stop11").toString()))
{
	cntsp++;
}

}//end if rst5
}//end while rst4

out.print(cntsp);
cntst1=cntst1+cntsp;
%>
</td>
<td class="bodyText">
<%
if(speed >0 && cntsi >0)
{
speed=speed/cntsi;
cntrh=(maxdist-mindist)/speed;
out.print(cntrh);
cntrh1=cntrh1+cntrh;
}
else
{
out.print("0");
}
%>
</td>
<td class="bodyText">
<%
sql6="select distinct(TheFieldDataDate) from "+tbname+" where TheFieldDataDate >='"+data1+"' and TheFieldDataDate <='"+data2+"'";
ResultSet rst6=st.executeQuery(sql6);
while(rst6.next())
{
sql7="select MAX(Distance)-MIN(Distance) as Dist1 from "+tbname+" where TheFieldDataDate='"+rst6.getString("TheFieldDataDate")+"' and TheFieldDataTime BETWEEN '"+session.getAttribute("stoptime").toString()+"' and '23:59:59' and TheFiledTextFileName='SI'";

sql8="select MAX(Distance)-MIN(Distance) as Dist2 from "+tbname+" where TheFieldDataDate='"+rst6.getString("TheFieldDataDate")+"' and TheFieldDataTime BETWEEN '00:00:00' and '"+session.getAttribute("starttime").toString()+"' and TheFiledTextFileName='SI'";

ResultSet rst7=st1.executeQuery(sql7);
ResultSet rst8=st2.executeQuery(sql8);

if(rst7.next())
{
	Dist1=rst7.getInt("Dist1");
}
if(rst8.next())
{
	Dist2=rst8.getInt("Dist2");
}
Dist=Dist1+Dist2;
}//end while
if(Dist >5)
{
out.print("Yes");
cntnd1=cntnd1+1;
}
else
{
out.print("No");
}
%>
</td>
</tr>
<%
	}//end if.
	}//end while.

%>
<tr ><td colspan="2" class="hed">Total</td>
<td class="hed"><%=cntos1 %></td>
<td class="hed"><%=cntra1 %></td>
<td class="hed"><%=cntrda1 %></td>
<td class="hed"><%=cntcd1 %></td>
<td class="hed"><%=cntdt1 %></td>
<td class="hed"><%=cntst1 %></td>
<td class="hed"><%=cntrh1 %></td>
<td class="hed"><%=cntnd1 %></td>
</tr>

<tr><td colspan="5" align="center"><a href="#" onclick='javascript:window.print();'>Print Report</a></td><td colspan="5" align="center"><a href="exporttoexcel1.jsp" >Export To Excel</a></td></tr>
</table>
<%

String datanames[] = {"Over Speed", "Rapid Acceleration", "Rapid Deceleration", "Continuous Driving","Night Driving"};//,"Stoppages", "Distance Travled", "RunHours"};
int per=cntos1+cntra1+cntrda1+cntcd1+cntnd1;//+cntst+cntdt+cntrh;

double datavalues[] = {cntos1, cntra1, cntrda1, cntcd1, cntnd1};//, cntst, cntdt,cntrh};
double datavalues1[] = {cntos1, cntra1, cntrda1, cntcd1, cntnd1};
for(int i=0; i<datavalues.length; i++){
if(datavalues[i]>0)
{
	datavalues[i]=datavalues[i]/per*100;
}
	
}
session.setAttribute("datanames",datanames);
session.setAttribute("datavalues",datavalues);
session.setAttribute("datavalues1",datavalues1);



}//end try
catch(Exception e)
{
out.println("Exception  "+e);

}//catch end.
finally
{

}//finally end.

}//end of else



%>
</td></tr>

</table>


</td>


</tr>
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

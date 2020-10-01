<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
 
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn=null,conn1=null;
Statement st,st1,st2;
String sql,sql1,startdate,vehid,tripid,enddate,sql2;
String sdate,edate,vehcode,stime,etime,transporter,vehregno;
long time1,time2,time3,time4,timex;
String startx,stopx,stlocation;
int startdist,stopdist;
%>
<script type="text/javascript">
var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};
 
</script>
<%
transporter=request.getParameter("transporter");
vehregno=request.getParameter("vehregno");
edate=request.getParameter("date");
etime=request.getParameter("time");
stime=request.getParameter("time");
vehcode=request.getParameter("vehcode");
vehid=request.getParameter("vehcode");
java.util.Date NewDate = new SimpleDateFormat("yyyy-MM-dd").parse(edate);
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format formatter5 = new SimpleDateFormat("yyyy-MM-dd");
String sdate = formatter5.format(NewDate);
startdate=sdate+stime;
enddate=edate+etime;

%>
<table width="100%" align="center" border="1" bgcolor="white">
<tr><td>
<div align="left"><a href="javascript:history.go(-1);">Back</a></div>
<div class="bodyText" align="right">Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %>
<%
try{
//Class.forName(MM_dbConn_DRIVER);
	conn = fleetview.ReturnConnection();
	st = conn.createStatement();
	conn1 = fleetview.ReturnConnection1();
	st2 = conn1.createStatement();
	st1 = conn.createStatement();
/**************** code for Over Speed ********************/
%>
<table class="stats">
<tr><td colspan="4" class="bodyText"><b>Last 24 hours exception report for the vehicle <%=vehregno%>, Transporter is <%=transporter%></b></td></tr>
<tr><th colspan="4">Over Speed</th></tr>
<tr>
<td class="hed">Date-Time</td>
<td class="hed">Speed</td>
<td class="hed">Distance</td>
<td class="hed">Location</td>
</tr>
<%
sql1="SELECT * FROM t_veh"+vehid+" where concat(TheFieldDataDate,TheFieldDataTime) >='"+ startdate+"' and concat(TheFieldDataDate,TheFieldDataTime) <='"+ enddate+"' and TheFiledTextFileName='OS' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst1=st.executeQuery(sql1);
while(rst1.next())
{
	%>
<tr>
<td class="bodyText">
<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%>
<%=rst1.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst1.getString("Speed") %></td>
	
	<td class="bodyText"><%=rst1.getString("Distance") %></td>
	<td class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject") %></div></td>
</tr>
	<%
	

}
%>
</table>
<%

/*************** end of code for Over Speed **************/

/**************** Rapid Acceleration *********************/

%>
<table class="stats" border="1" width="100%">
<tr><th colspan="4">Rapid Acceleration</th></tr>
<tr>
<td class="hed">Date-Time</td>
<td class="hed">From Speed</td>
<td class="hed">To Speed</td>
<td class="hed">Location</td>
</tr>
<%
sql1="SELECT * FROM t_veh"+vehid+" where  concat(TheFieldDataDate,TheFieldDataTime)>='"+ startdate+"' and concat(TheFieldDataDate,TheFieldDataTime)<='"+ enddate+"' and TheFiledTextFileName='AC' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst2=st.executeQuery(sql1);
while(rst2.next())
{
if(rst2.getInt("Distance")>5)
{
	%>
<tr>
<td class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst2.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%>
	<%=rst2.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst2.getString("Distance") %></td>
	<td class="bodyText"><%=rst2.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><%=rst2.getString("TheFieldSubject") %></div></td>
</tr>
	<%
	
}
}
%>
</table>
<%

/**************** End Rapid Acceleration *********************/
/**************** Rapid Deceleraion *************************/

%>
<table class="stats" width="100%" border="1">
<tr><th colspan="4">Rapid Deceleration</th></tr>
<tr>
<td class="hed">Date-Time</td>
<td class="hed">From Speed</td>
<td class="hed">To Speed</td>
<td class="hed">Location</td>
</tr>
<%
sql1="SELECT * FROM t_veh"+vehid+" where concat(TheFieldDataDate,TheFieldDataTime)>='"+ startdate+"' and concat(TheFieldDataDate,TheFieldDataTime)<='"+ enddate+"' and TheFiledTextFileName='DC' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst3=st.executeQuery(sql1);
while(rst3.next())
{
if(rst3.getInt("Distance")<120)
{
	%>
<tr>
<td class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst3.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%>
	<%=rst3.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst3.getString("Distance") %></td>
	<td class="bodyText"><%=rst3.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><%=rst3.getString("TheFieldSubject") %></div></td>
</tr>
	<%
	
}
}
%>
</table>
<%


/***************** End of Rapid Deceleration ****************/

/******************code for stops***************/
%>
<table class="stats" border="1" widht="100%">
<tr><th colspan="4">Stops</th></tr>
<tr><td class="hed">Start Date-Time</td><td class="hed">End Date-Time</td><td class="hed">Duration</td><td class="hed">Location</td></tr>

<%
sql1="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehid+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,TheFieldDataTime) >='"+startdate+"' and  concat(TheFieldDataDate,TheFieldDataTime) <='"+enddate+"'  order by concat(TheFieldDataDate,TheFieldDataTime) asc";
ResultSet rst4= st.executeQuery(sql1);

while(rst4.next())
{
	sql2="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehid+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,TheFieldDataTime) >='"+startdate+"' and TheFieldDataDate='"+rst4.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst4.getString("time1"))+" and abs(LatinDec - "+rst4.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1"; 
	ResultSet rst5= st1.executeQuery(sql2);
	if(rst5.next())
	{
	if(rst5.getDouble("time2")-rst4.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
		{
			double duration=(Double.parseDouble(rst5.getString("time2"))-Double.parseDouble(rst4.getString("time1")));
			int hrs=(int)duration/60;
			int min=(int)duration%60;
			
%>
<tr>
<td class="bodyText"><div align="left">
<%
java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd").parse(rst4.getString(1));
Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate3 = formatter3.format(ShowDate3);
 out.print(showdate3);
%>
<%=rst4.getString(2) %>
</div></td>
<td class="bodyText"><div align="left">
<%
java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-dd").parse(rst5.getString(1));
Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate4 = formatter4.format(ShowDate4);
 out.print(showdate4);
%> <%=rst5.getString(2) %>
</div></td>
<td class="bodyText"><div align="left">
<%=hrs +"hrs "+min+" min" %>
</div></td>
<td class="bodyText"><div align="left">
<%=rst4.getString("TheFieldSubject")%>
</div></td>
</tr>

<%
		}

	}
}
/******************code for stops***************/
%>
</table>
<table class="stats">
<tr><th colspan="4">Night Driving</th></tr>
<tr><td class="hed">Start Date-Time</td><td class="hed">End Date-Time</td><td class="hed">Distance</td><td class="hed">Location</td></tr>
<%
/*
/*****************code for Night Driving *******/

sql="select * from t_veh"+vehid+"_nd where concat(FromDate,FromTime) >='"+startdate+"' and concat(FromDate,FromTime)<='"+enddate+"' order by concat(FromDate,FromTime) asc";
ResultSet rst6=st2.executeQuery(sql);
while(rst6.next())
{
%>
<tr><td class="bodyText"><%
java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rst6.getString("FromDate")+"  "+rst6.getString("FromTime"));
Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String showdate4 = formatter4.format(ShowDate4);
 out.print(showdate4);
%>
</td><td class="bodyText">
<%


java.util.Date ShowDate6 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst6.getString("ToDate")+"  "+rst6.getString("ToTime"));
Format formatter6 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String showdate6 = formatter6.format(ShowDate6);
 out.print(showdate6);


%>


</td><td class="bodyText">
<%=rst6.getString("Distance")%>
</td><td class="bodyText">
<%
sql="select * from t_veh"+vehid+" where concat(TheFieldDataDate,TheFieldDataTime)='"+rst6.getString("FromDate")+rst6.getString("FromTime")+"'";

ResultSet rst7=st1.executeQuery(sql);
if(rst7.next())
{
out.print("<div align='left'>"+rst7.getString("TheFieldSubject")+"</div>");
}
%>
</td></tr>

<%

}
/***************** End of code for Night Driving *******/
%>
</table>
</td></tr>
<tr><td>
<div align="center"><input type="button" Name="Print Report" value="Print Report" onclick="javascript:window.print();" class="formElement"></div>
</td></tr>
</table>
<%
}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();
conn1.close();
try
{fleetview.closeConnection1();}
catch(Exception e)
{}

try
{fleetview.closeConnection();}
catch(Exception e)
{}
}
%>
<!-- footer start here -->
<!-- <table border="1" width="100%"> -->
<!-- <tr ><td bgcolor="white" class="copyright" width="100%"> -->
<!-- <center>Copyright &copy; 2008 by Transworld  -->
<!--                           Compressor Technologies Ltd. All Rights Reserved.</center> -->
<!-- </td></tr> -->
<!-- </table> -->
<P></P>
</body>
</html>
</jsp:useBean>
  <%@ include file="footernew.jsp" %>
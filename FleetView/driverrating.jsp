<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<!-- code start-->
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
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%! 
Connection conn=null,conn1=null;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
Statement st,st1,st2;
String trans;
%>

<table class="stats">
<tr><th> <font size="3">Driver Rating report for the Date:  <%
java.util.Date NewDate =new java.util.Date();

long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);

Format NewFormatter = new SimpleDateFormat("dd-MMM-yyyy");
Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
data1 = NewFormatter.format(NewDate);
data2 = NewFormatter1.format(NewDate);
out.print(data1);
%> 
<div align="right">
<a href="#" onclick="javascript:window.open('printdriverrating.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldriverrating.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div>

</font></th></tr>
<tr>
<td>
<table class="sortable">
<tr>
<td class="hed">Driver Name</td>
<td class="hed">Driver ID</td>
<td class="hed">Transporter</td>
<td class="hed">Start Date</td>
<td class="hed">Origin</td>
<td class="hed">Destination</td>
<td class="hed">OS Count</td>
<td class="hed">RA Count</td>
<td class="hed">DC Count</td>
<td class="hed">Distance</td>
<td class="hed">Rating</td>
</tr>

<%
try{
	//Class.forName(MM_dbConn_DRIVER);
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st1=conn1.createStatement();
	st2=conn1.createStatement();
	st=conn.createStatement();
	sql="select distinct(vehregno) from t_group where GPName='Castrol'";
	ResultSet rsttrns=st.executeQuery(sql);
	trans="(";
	while(rsttrns.next())
	{
		trans=trans+"'"+rsttrns.getString("VehRegNo")+"',";
	}
	trans=trans.substring(0,trans.length()-1);
	trans=trans+")";
	//out.print(trans);
sql="select * from t_driver_ds where TheDate='"+data2+"' and Distance between 100 and 250 and nd<>'Yes' and Jcode <>'-' and transporter in "+trans+" order by Rating, Distance desc limit 20";
ResultSet rst=st1.executeQuery(sql);
//System.out.println("sql1-->"+sql);
%>
<tr><th colspan="11"><font size="3">Top 20 Drivers Distance 100-250 km.</font></th></tr>
<%
while(rst.next())
{
jcode=rst.getString("JCode");
%>
<tr>
<td class="bodyText"><div align="left" >
<%
sql1="select DriverName from t_startedjourney where DriverCode='"+rst.getString("Dcode")+"' limit 1";
ResultSet rst1=st.executeQuery(sql1);
if(rst1.next())
{
	out.print(rst1.getString("DriverName"));
}

%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("Dcode")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("Transporter")%></div></td>
<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"' and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs1=st.executeQuery(sql);
//System.out.println("sql2-->"+sql);
if(rs1.next())
{

	
	java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("StartDate"));
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate1 = formatter1.format(ShowDate1);
	startdate=showdate1;
	origin=rs1.getString("StartPlace");
	destination=rs1.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText"><div align="left"><%=startdate%></div></td>
<td class="bodyText"><div align="left"><%=origin%></div></td>
<td class="bodyText"><div align="left"><%=destination%></div></td>

<td class="bodyText"><div align="right"><%=rst.getString("OSCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("RACount")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("RDCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst.getString("Distance")%></div></td>
<td class="bodyText"><div align="right">
<%
String ss=""+rst.getDouble("Rating");

if(ss.length() > 4)
{
	out.print(ss.substring(0,4));
}
else
{
	out.print(ss);
}
%></div></td>

</tr>

<%
}
%>

<tr><th colspan="11"><font size="3">Bottom 20 Drivers Distance 100-250 km.</font></th></tr>
<%
String sql2="select * from t_driver_ds where TheDate='"+data2+"' and Distance between 100 and 250 and Jcode <>'-'  and transporter in "+trans+" order by Rating desc, Distance Asc limit 20";
ResultSet rst2=st2.executeQuery(sql2);
//System.out.println("sql2-->"+sql2);
while(rst2.next())
{
	
jcode=rst2.getString("JCode");
%>
<tr>
<td class="bodyText"><div align="left">
<%
sql1="select * from t_startedjourney where DriverCode='"+rst2.getString("Dcode")+"' limit 1";
ResultSet rst3=st.executeQuery(sql1);
if(rst3.next())
{
	out.print(rst3.getString("DriverName"));
}

%>
</div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("Dcode")%></div></td>
<td class="bodyText"><div align="left"><%=rst2.getString("Transporter")%></div></td>

<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"'  and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs2=st.executeQuery(sql);
if(rs2.next())
{
	java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rs2.getString("StartDate"));
	Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate2 = formatter2.format(ShowDate2);
	startdate=showdate2;
	origin=rs2.getString("StartPlace");
	destination=rs2.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText"><div align="left"><%=startdate%></div></td>
<td class="bodyText"><div align="left"><%=origin%></div></td>
<td class="bodyText"><div align="left"><%=destination%></div></td>


<td class="bodyText"><div align="right"><%=rst2.getString("OSCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("RACount")%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("RDCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst2.getString("Distance")%></div></td>
<td class="bodyText"><div align="right">
<%
String sss=""+rst2.getDouble("Rating");

if(sss.length() > 4)
{
	out.print(sss.substring(0,4));
}
else
{
	out.print(sss);
}
%></div></td>

</tr>

<%
}

sql="select * from t_driver_ds where TheDate='"+data2+"' and Distance > 250  and Distance < 500 and nd<>'Yes' and Jcode <>'-' and transporter in "+trans+" order by Rating, Distance desc limit 20";
ResultSet rst3=st1.executeQuery(sql);

%>
<tr><th colspan="11"><font size="3">Top 20 Drivers Distance > 250 km.</font></th></tr>
<%
while(rst3.next())
{
jcode=rst3.getString("JCode");
%>
<tr>
<td class="bodyText"><div align="left">
<%
sql1="select * from t_startedjourney where DriverCode='"+rst3.getString("Dcode")+"' limit 1";
ResultSet rst4=st.executeQuery(sql1);
if(rst4.next())
{
	out.print(rst4.getString("DriverName"));
}

%>
</div></td>
<td class="bodyText"><div align="right"><%=rst3.getString("Dcode")%></div></td>
<td class="bodyText"><div align="left"><%=rst3.getString("Transporter")%></div></td>

<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"' and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs3=st.executeQuery(sql);
if(rs3.next())
{
	java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd").parse(rs3.getString("StartDate"));
	Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate3 = formatter3.format(ShowDate3);
	startdate=showdate3;
	origin=rs3.getString("StartPlace");
	destination=rs3.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText"><div align="left"><%=startdate%></div></td>
<td class="bodyText"><div align="left"><%=origin%></div></td>
<td class="bodyText"><div align="left"><%=destination%></div></td>


<td class="bodyText"><div align="right"><%=rst3.getString("OSCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst3.getString("RACount")%></div></td>
<td class="bodyText"><div align="right"><%=rst3.getString("RDCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst3.getString("Distance")%></div></td>
<td class="bodyText"><div align="right">
<%
String ssss=""+rst3.getDouble("Rating");

if(ssss.length() > 4)
{
	out.print(ssss.substring(0,4));
}
else
{
	out.print(ssss);
}
%></div></td>

</tr>
<%
}

%>
<tr><th colspan="11"><font size="3">Bottom 20 Drivers Distance > 250 km.</font></th></tr>
<%
sql="select * from t_driver_ds where TheDate='"+data2+"' and Distance > 250 and Distance < 500  and Jcode <>'-' and transporter in "+trans+"  order by Rating desc, Distance Asc limit 20";


ResultSet rst5=st1.executeQuery(sql);
//System.out.println("sql4 "+sql);
while(rst5.next())
{
jcode=rst5.getString("JCode");
%>
<tr>
<td class="bodyText"><div align="left">
<%
sql1="select * from t_startedjourney where DriverCode='"+rst5.getString("Dcode")+"' limit 1";
ResultSet rst6=st.executeQuery(sql1);
if(rst6.next())
{
	out.print(rst6.getString("DriverName"));
}

%>
</div></td>
<td class="bodyText"><div align="right"><%=rst5.getString("Dcode")%></div></td>
<td class="bodyText"><div align="left"><%=rst5.getString("Transporter")%></div></td>

<%
if(!jcode.equals("-"))
{
sql="select * from t_startedjourney where TripId='"+jcode+"' and (TO_DAYS(CURDATE())-TO_DAYS(StartDate)) < 10";
ResultSet rs4=st.executeQuery(sql);
if(rs4.next())
{
	java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-dd").parse(rs4.getString("StartDate"));
	Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate4 = formatter4.format(ShowDate4);
	startdate=showdate4;
	origin=rs4.getString("StartPlace");
	destination=rs4.getString("EndPlace");
}

else
{
	startdate="-";
	origin="-";
	destination="-";
}
}
%>
<td class="bodyText"><div align="left"><%=startdate%></div></td>
<td class="bodyText"><div align="left"><%=origin%></div></td>
<td class="bodyText"><div align="left"><%=destination%></div></td>


<td class="bodyText"><div align="right"><%=rst5.getString("OSCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst5.getString("RACount")%></div></td>
<td class="bodyText"><div align="right"><%=rst5.getString("RDCount")%></div></td>
<td class="bodyText"><div align="right"><%=rst5.getString("Distance")%></div></td>
<td class="bodyText"><div align="right">
<%
String sssss=""+rst5.getDouble("Rating");

if(sssss.length() > 4)
{
	out.print(sssss.substring(0,4));
}
else
{
	out.print(sssss);
}
%>
</div></td>
</tr>
<%
}

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



</table>
</td>

</tr>
</table>


</td></tr>
</table>
<!-- code end-->
<!-- footer start here -->

<P></P>
</body>
</html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
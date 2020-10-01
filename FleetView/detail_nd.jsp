<%@ include file="headernew.jsp" %>
<%//System.out.println("---------check1111111 "); %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<script language="javascript">

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

<%//System.out.println("-check "); %>
<%!
Connection conn=null, con1=null;
Statement st,st1, stmt1;
String date1, date2, vehcode, vehregno,tbname,sql;
%>

<%try{
   // date1=session.getAttribute("data1").toString();
	//date2=session.getAttribute("data2").toString();
	date1=request.getParameter("data1");
	date2=request.getParameter("data2");
	
	
	vehcode=request.getParameter("vid");
	System.out.println("veshcode:-"+vehcode);
	vehregno=request.getParameter("vehno");
	 tbname="t_veh"+vehcode+"_nd";
	 System.out.print("tname is:-"+tbname);
}
catch(Exception e){
	e.printStackTrace();
}
	//out.print(tbname);
%>
<table border="0" width="100%" class="stats">
<tr><td colspan="2" align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<!-- <div align="left"><font size="3">
	Report No:3.12
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:4.12
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:5.12
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:6.12
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:9.0")){
	%>
	<!--<div align="left"><font size="3">
	Report No:9.12
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
%>
<%
try{
	
%>
</td></tr>
</td></tr>
<tr><td align="center"><font size="3">
 <b>NIGHT DRIVING REPORT for Vehicle <%=vehregno %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>
</b></font>
<div align="right">
<a href="#" onclick="javascript:window.open('Print_detail_nd.jsp?vid=<%=vehcode %>&vehno=<%=vehregno%>&data=<%=date1%>&data1=<%=date2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
<a href="Export_detail_nd.jsp?vid=<%=vehcode %>&vehno=<%=vehregno%>&data=<%=date1%>&data1=<%=date2%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

<%=fleetview.PrintDate() %>
</div>
</td></tr>
<%}
catch(Exception e){
	e.printStackTrace();
}
%>
<tr><td>
<table class="sortable">
<tr>
<th>Sr</th>
<th>Start Date-Time</th>
<th> <b>Start Location - Click To View On Map.</b></th>
<th>End Date-Time</th>
<th> <b>End Location - Click To View On Map.</b></th>
<th>Distance</th>
<th>Duration</th>
<th>ND Intimated</th>
</tr>
<%
	
try{	
	
	//System.out.print(date1+"  "+ date2+"  "+ vehcode+"  "+ vehregno);
	//Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection1();
	con1 = fleetview.ReturnConnection();
	st=conn.createStatement();
	stmt1=con1.createStatement();
	int i=1;
	String nextdate="";
	String nd = "SELECT DATE_ADD('"+date2+"', INTERVAL 5 HOUR) as fiveHoursAfterDateTime";
	ResultSet rsnd = st.executeQuery(nd);
	if(rsnd.next())
	{
		nextdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsnd.getString("fiveHoursAfterDateTime")));
	}
     // sql="select * from db_gpsExceptions."+tbname+" where concat(Fromdate,' ',Fromtime) >= '"+date1+"' and concat(Fromdate,' ',Fromtime) <= '"+date2+"' order by fromdate asc,fromtime asc";
     sql="SELECT "+
	 	" nd.FromDate, nd.FromTime, veh.fromlocation, veh.LatinDec as fromlat,veh.LonginDec as fromlon ,nd.ToDate ,nd.ToTime , vehto.tolocation, vehto.LatinDec as tolat, vehto.LonginDec as tolon, "+
		" 0 , 0 , 0 , 0, nd.Duration, veh.ZoneColor, nd.Distance, nd.NDPreAuthorised  "+
		" FROM (  "+
		" SELECT  "+
		"  	FromDate, FromTime, ToDate, ToTime, Duration,Distance,NDPreAuthorised "+
		" FROM "+ 
	 	" 	db_gpsExceptions.t_veh"+vehcode+"_nd "+ 
		" WHERE "+ 
		" 	CONCAT( Fromdate,' ',FromTime ) >= '"+date1+"' "+
		" AND CONCAT( Fromdate,' ',FromTime ) <= '"+date2+"' "+
		" )nd "+
		" LEFT OUTER JOIN ( "+ 
		" SELECT "+ 
		" 		TheFieldSubject as fromlocation ,  LatinDec, LonginDec, TheFieldDataDate,  TheFieldDataTime,ZoneDesc AS ZoneColor,TheFieldDataDateTime "+ 
		" FROM "+ 
		" 	db_gps.t_veh"+vehcode+" "+ 
		" WHERE "+ 
		" 	 TheFieldDataDateTime >= '"+date1+"' "+ 
		" AND  TheFieldDataDateTime <= '"+nextdate+"' "+ 
		" )veh "+ 
		" ON ( veh.TheFieldDataDate = nd.Fromdate "+ 
		" AND veh.TheFieldDataTime = nd.FromTime ) "+
		" "+ 
		" LEFT OUTER JOIN  ( "+ 
		" SELECT "+ 
		" 		TheFieldSubject as tolocation ,  LatinDec, LonginDec, TheFieldDataDate,  TheFieldDataTime,ZoneDesc AS ZoneColor,TheFieldDataDateTime "+ 
		" FROM "+ 
		" 	db_gps.t_veh"+vehcode+" "+ 
		" WHERE "+ 
		" 	 TheFieldDataDateTime >= '"+date1+"' "+ 
		" AND  TheFieldDataDateTime <= '"+nextdate+"'  "+
		" )vehto "+ 
		" ON ( vehto.TheFieldDataDate = nd.Todate "+ 
		" AND vehto.TheFieldDataTime = nd.ToTime ) "+
		" GROUP BY "+ 
		" 	CONCAT( Fromdate,' ',FromTime ) "+
		" ORDER BY CONCAT( Fromdate,' ',FromTime )";

	
     System.out.println("SqlND===>"+sql);
    		  
    		  ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
		<tr>
	<td style="text-align: right"><%=i %></td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate")) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("FromTime")))%></td>
	<td><div align="left"><%="<a href=\"shownewmap.jsp?lat="+rst.getString("fromlat")+"&long="+rst.getString("fromlon")+"&discription="+rst.getString("fromlocation")+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+rst.getString("fromlat")+"&long="+rst.getString("fromlon")+"&discription="+rst.getString("fromlocation")+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+rst.getString("fromlocation")+"</a>" %></div></td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate")) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("ToTime"))) %></td>
	<td><div align="left"><%="<a href=\"shownewmap.jsp?lat="+rst.getString("tolat")+"&long="+rst.getString("tolon")+"&discription="+rst.getString("tolocation")+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+rst.getString("tolat")+"&long="+rst.getString("tolon")+"&discription="+rst.getString("tolocation")+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+rst.getString("tolocation")+"</a>" %></div></td>
	<td><div align="right"><%=rst.getString("Distance") %></div></td>
	<td><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("Duration"))) %></div></td>
	<td><div align="right"><%=rst.getString("NDPreAuthorised") %></div></td>
	</tr>
<%
	i++;
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e){}
	try
	{
	con1.close();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection1();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection();
	}
	catch(Exception e){}
}

%>
</table>
</td></tr></table>

</jsp:useBean>
<%@ include file="footerprintnew.jsp"%>

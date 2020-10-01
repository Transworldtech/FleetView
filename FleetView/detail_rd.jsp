 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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
<%!
Connection conn=null, con1=null;
Statement st,st1, stmt1;
String date1, date2, vehcode, vehregno,tbname,sql;
%>
<%
date1= (null != request.getParameter("dd")) ? request.getParameter("dd"):session.getAttribute("data1").toString();
	date2= (null != request.getParameter("dd")) ? request.getParameter("dd"):session.getAttribute("data2").toString();
	vehcode=request.getParameter("vid");
	vehregno=request.getParameter("vehno");
	 tbname="t_veh"+vehcode+"_rd";
	 session.setAttribute("data1",date1);
		session.setAttribute("data2",date2);
	//out.print(tbname);
%>
<table border="0" width="100%" class="stats">
<tr><td align="center">
<%
if (session.getAttribute("reportno").toString().equals(
"Report No:1.0")) {
%>
	<!-- <div align="left"><font size="3">
	Report No:1.9
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Rapid Deceleration Report</b></font>
<%
}
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:3.10
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Rapid Deceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:4.10
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Rapid Deceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:5.10
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Rapid Deceleration Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<!--<div align="left"><font size="3">
	Report No:6.10
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Rapid Deceleration Report</b></font>
	<%
}
%>

</td></tr>

<tr><td align="center"><font size="3">
 <b>Rapid Deceleration Report for Vehicle <%=vehregno %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>
</b></font>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('print_detail_rd.jsp?vid=<%=vehcode %>&vehno=<%=vehregno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Exportdetail_rd.jsp?vid=<%=vehcode %>&vehno=<%=vehregno%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %>
</div>
</td></tr>
<tr><td>
<table class="sortable">
<tr>
<th>Sr. </th>
<th>Date </th>
<th>Time </th>
<th>From Speed</th>
<th>To Speed</th>
<th>Location</th>
</tr>

<%
	
try{	
	
	
	
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	//Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection();
	con1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	stmt1=con1.createStatement();
	int i=1;

       sql="select * from "+tbname+" where TheDate  >= '"+date1+"' AND TheDate<= '"+date2+"' ORDER BY TheDate";
	//out.print(sql+"<br>");
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
	<tr>
	<td style="text-align: right"><%=i %></td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate")) %></td>
	<td style="text-align: right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("TheTime")))  %></td>
	<td><div align="right"><%=rst.getString("FromSpeed") %></div></td>
	<td><div align="right"><%=rst.getString("ToSpeed") %></div></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vehcode,rst.getString("TheDate"),rst.getString("TheTime")) %></div></td>
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
	catch(Exception e)
	{}
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

<%

%>
</jsp:useBean>
 <%@ include file="footernew.jsp" %>
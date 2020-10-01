<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

String data1,data2,vid,tripid,vehno,sdate,edate,showdate,showdate1,time1,time2;
	
sdate=request.getParameter("sdate");
edate=request.getParameter("edate");
tripid=request.getParameter("tripid");
vid=request.getParameter("vid");
//System.out.println("Vid:::"+vid);
//vehno=request.getParameter("vehno");
//System.out.println("Vregno:::"+vehno);
	String tbname="t_veh"+vid+"_rd";
	//System.out.println(tbname);
	
	Connection conn1=null;
Connection conn=null;
	
	try{
	conn1 = fleetview.ReturnConnection1();
	Statement st1=conn1.createStatement();
	String sql1="select StartDate,EndDate from db_gps.t_completedjourney where TripID="+tripid;
	//System.out.println(sql);
	ResultSet rst1=st1.executeQuery(sql1);
	int i=1;
	while(rst1.next())
	{
		sdate=rst1.getString(1);
		edate=rst1.getString(2);
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
	finally
	{
		try{
			conn1.close();
		}
		catch(Exception e)
		{
			
		}
		try{
			fleetview.closeConnection1();
			
		}
		catch(Exception e)
		{
			
		}
	}
	
//	sdate=2010-01-27&edate=2010-01-28%2014:42:16&vehno=RJ%2014%202G%205076&vcode=1820
%>
<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></div>
<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=RD_Rating.rptdesign&sdate=<%=sdate%>&edate=<%=edate%>&vid=<%=vid%>&tripid=<%=tripid%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> -->
</iframe> 

</div>

<%if(false){ %>
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
<table border="0" width="100%">
<tr><td>
<table border="0" width="100%" class="stats">
<tr><td colspan="2" align="center">


</td></tr>
<tr bgcolor=""><td align="center"colspan="2"><font size="3"><b>RAPID DECELERATION for Trip <%=tripid%></b></font>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printrapiddeacc1.jsp?data1=<%=sdate%>&data2=<%=edate%>&vcode=<%=vid%>&tripid=<%=tripid%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excelrapiddecacc1.jsp?data1=<%=sdate%>&data2=<%=edate%>&vcode=<%=vid%>&tripid=<%=tripid%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %>
</div>
	 </td></tr>
</table>
<P></P>
<table border="1" width="100%" class="sortable">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed From</th>
<th>Speed To</th>
<th>Location</th>
</tr>

<%

	try{
	
	conn = fleetview.ReturnConnection1();
	Statement st=conn.createStatement();
	String sql="select * from "+tbname+" where concat(TheDate,' ',TheTime)>='"+sdate+"' and concat(TheDate,' ',TheTime)<='"+edate+"'";
	//System.out.print(sql);
	int i=1;
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		%>
	<tr>
	<td style="text-align: right"><%=i %></td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2)))+"<br> "+rst.getString(3) %></td>
	<td style="text-align: right"><%=rst.getString(4) %></td>
	<td style="text-align: right"><%=rst.getString(5) %></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString(2),rst.getString(3)) %></div></td>
	</tr>
		<%
		i++;
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
	finally
	{	
		try{
			conn.close();
		}
		catch(Exception e)
		{
			
		}
		try{
			fleetview.closeConnection1();
			
		}
		catch(Exception e)
		{
			
		}
	}
}
 %>

</table>
</td></tr></table>

<%

%>
</jsp:useBean>
<%-- <%@ include file="footernew.jsp"%> --%>
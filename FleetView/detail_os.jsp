<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.OverSpeedDetailsData"
		import="com.transworld.fleetview.framework.Utilities" %>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	
	<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

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

Connection con=null ;

Statement st4;
%>
<% 
try
{
	//Class.forName(MM_dbConn_DRIVER);
con = fleetview.ReturnConnection();	
st4=con.createStatement();
}catch(Exception e){}
	 %>
<%


	final String vehicleRegistrationNumber = request.getParameter("vehno");
	final String vehicleCode = request.getParameter("vid");
	final String data1 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data1").toString();
	final String data2 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data2").toString();
%>
<table border="0" width="100%">
	<tr>
		<td>
		<table width="100%" align="center" class="stats">
			<tr>
				<td align="center">
<%
					if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
					{
%>
						<!-- <div align="left"><font size="3"> Report No:3.8 </font></div>-->
						<font size="3" face="Arial"><b>Overspeed Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
					{
%>
						<!-- <div align="left"><font size="3"> Report No:4.8 </font></div>-->
						<font size="3" face="Arial"><b>Overspeed Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
					{
%>
						<!-- <div align="left"><font size="3"> Report No:5.8 </font></div>-->
					<font size="3" face="Arial"><b>Overspeed Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
					{
%>
						<!-- <div align="left"><font size="3"> Report No:6.8 </font></div>-->
						<font size="3" face="Arial"><b>Overspeed Report</b></font> <%
					}
%>
				</td>
			</tr>
			<tr>
				<td align="center"><b><font size="3" face="Arial">OVERSPEED
				ANALYSIS REPORT for Vehicle <%=vehicleRegistrationNumber %> From Date :<%
				java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
				Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
				String fromdt = formatter.format(date);
				out.print(fromdt); %> To Date :<%
				java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
				String todt = formatter1.format(date3);
				out.print(todt);%> </font></b>
				<div class="bodyText" align="right"><a href="#"
					onclick="javascript:window.open('print_detail_os.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>');"
					title="Print Report"><img src="images/print.jpg" width="15px"
					height="15px"></a>&nbsp; &nbsp; <a
					href="Export_detail_os.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>"
					title="Export to Excel"><img src="images/excel.jpg"
					width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp; <%=Utilities.printDate() %>
				</div>
				</td>
			</tr>
		</table>
		<P></P>
		
		
		<table border="1" width="100%" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>From-Date-Time</b></th>
				<th>To Date-Time</th>
				<th><b>Speed</b></th>
				<th><b>Duration in Sec.</b></th>
				<th><b>Location - Click To View On Map.</b></th>
				<th><b>Zone</b></th>
				
			</tr>
			<tr>
			<%
		
			try{
				int os=1;
				String bgcolor="",zonecolor="",fromdate="",zoneval="",todate="";
			//String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vehicleCode+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vehicleCode+"  WHERE  TheFiledTextFileName= 'OS' GROUP BY TheFieldDataDate, TheFieldDataTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(FromDate,' ',FromTime) >='"+data1+" 00:00:00' and concat(FromDate,' ',FromTime) <='"+data2+" 23:59:59' ORDER BY concat(os.FromDate,os.FromTime)";
			String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vehicleCode+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vehicleCode+"  WHERE  TheFiledTextFileName= 'OS' and TheFieldDataDateTime >= '"+data1+" 00:00:00' and TheFieldDataDateTime <= '"+data2+" 23:59:59' GROUP BY TheFieldDataDateTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(os.FromDate,' ',os.FromTime) >='"+data1+" 00:00:00' and concat(os.FromDate,' ',os.FromTime) <='"+data2+" 23:59:59' ORDER BY concat(os.FromDate,os.FromTime)";
			System.out.println("Join query is"+sqloscalc);
			ResultSet rsoscalc=st4.executeQuery(sqloscalc);
			while(rsoscalc.next())
			{
				fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsoscalc.getString("FromDate")));
				todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsoscalc.getString("ToDate")));

				zonecolor=rsoscalc.getString("Zone");
				if(zonecolor.equalsIgnoreCase("Red") || zonecolor=="Red")
				{
					bgcolor="background-color:#FC545F";
					zoneval="R";
				}
				else if(zonecolor.equalsIgnoreCase("Green") || zonecolor=="Green")
				{
					bgcolor="background-color:#B3FAB3";
					zoneval="G";

				}
				else if(zonecolor.equalsIgnoreCase("Yellow") || zonecolor=="Yellow")
				{
					bgcolor="background-color:#FDFD82";
					zoneval="Y";

				}
				else{
					bgcolor="background-color:#FFFFFF";
					zoneval="0";

					
				}
					 %>
			
			
			            <td style="text-align:right;<%=bgcolor%>"><%=os%></td>
						<td style="text-align:left;<%=bgcolor%>"><%=fromdate%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsoscalc.getString("FromTime")))%></td>
							<td style="text-align:left;<%=bgcolor%>"><%=todate%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsoscalc.getString("ToTime")))%></td>
						
						<td style="text-align:right;<%=bgcolor%>"><%=rsoscalc.getString("Speed")%></td>
						<td style="text-align:right;<%=bgcolor%>"><%=rsoscalc.getString("Duration")%></td>
						<td style="text-align:left;<%=bgcolor%>">
						<%
						
						if(null!= rsoscalc.getString("TheFieldSubject") && !"null".equalsIgnoreCase(rsoscalc.getString("TheFieldSubject"))) 
						{
						
						%>
						<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=rsoscalc.getString("LatinDec")%>&long=<%=rsoscalc.getString("LonginDec")%>&discription=<%=rsoscalc.getString("TheFieldSubject")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=os%>,false);">
		
					<%=rsoscalc.getString("TheFieldSubject")%></a>
					
					<%}else{ %>
						<%="NA" %>
						<%} %>
						</td>
						
						<td style="text-align:left;<%=bgcolor%>">
						<%=zoneval%></td>
			
			
			</tr>
			
			<%
			os++;
			}}catch(Exception e)
			{
				e.printStackTrace();
				
			}
			finally
			{
				con.close();
							try
				{
								fleetview.closeConnection();
								}
				catch(Exception e)
				{}
			}
			
			%>
			
		</table>

		</td>
	</tr>
	
	
	
	
	
	
</table>
</jsp:useBean>

<%@ include file="footernew.jsp" %>
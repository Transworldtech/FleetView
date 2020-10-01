<%@page import="com.transworld.fleetview.framework.DisconnectionReport"
	import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
	import="com.transworld.fleetview.framework.DisconnectionReportViewData"
	import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="powerOnOffReport.ImplementationOfDisconnection"
	import="powerOnOffReport.DisconnectionData"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<%-- <jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean> --%>

<%-- <jsp:useBean id="disconnectionViewDataProvider"
	type="com.transworld.fleetview.framework.DisconnectionReportViewDataHelper"
	scope="application"></jsp:useBean> --%>

<%@ include file="headernew.jsp"%>
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

		function dateformat(days)
		{
			if(days=='Jan')
				return(1);
			else
				if(days=='Feb')
					return(2);
				else
					if(days=='Mar')
						return(3);
					else
						if(days=='Apr')
							return(4);
						else
							if(days=='May')
								return(5);
							else
								if(days=='Jun')
									return(6);
								else
									if(days=='Jul')
										return(7);
									else
										if(days=='Aug')
											return(8);
										else
											if(days=='Sep')
												return(9);
											else
												if(days=='Oct')
													return(10);
												else
													if(days=='Nov')
														return(11);
													else
														if(days=='Dec')
															return(12);
		}
 		  		  
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;

			dd11=date1.substring(0,2);
			dd22=date2.substring(0,2);

			mm1=date1.substring(3,6);
			mm2=date2.substring(3,6);

			mm11=dateformat(mm1);
			mm22=dateformat(mm2);
			
			yy11=date1.substring(7,11);
			yy22=date2.substring(7,11);
			
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			
			if(yy11>year || yy22>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
	  			if(mm11>month || mm22>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(mm11==month && mm22==month)
			{
				if(dd11>day || dd22>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}

			
			if(yy11 > yy22)
			{
				alert("From date year should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
				 if(mm11>mm22)
			{
				alert("From date month should not be greater than to date month");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			if(mm11==month && mm22==month) 
			{
				if(yy11==yy22)
				{
				if(dd11 > dd22)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
				}
			}
			else
				if(yy11<yy22)
				{
					return true;
				}
			else
				if(dd11 > dd22)
			{
					if(mm11<mm22)
					{
						return true;
					}
					
				alert("From date should not be greater than to date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			
			return true;
		}
  		 
function birt(){
  			
  			//alert("Hi");
  			var user= document.getElementById("user").value;
  			var userid= document.getElementById("userid").value;
  			//var date1= document.getElementById("date3").value;
  			var date1= document.getElementById("data").value;
  			//var date2= document.getElementById("date4").value;
  			var date2= document.getElementById("data1").value;
  			
  			var sort= document.getElementById("sort").value;
  			date1=date1+" 00:00:00";
  			date2=date2+" 23:59:59";
  			
  		//	alert(vehicle);
  		//	alert(date1);
  		//	alert(date2);

  			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=SensorDetailReport.rptdesign&vehicle="+vehicle+"&date1="+date1+"&date2="+date2+"&__showtitle=false";
  			document.getElementById("myIframe").src="http://myfleetview.com:8080/birt/frameset?__report=disconnection_report.rptdesign&user="+user+"&userid="+userid+"&fromDateTime="+date1+"&toDateTime="+date2+"&sort="+sort+"&__showtitle=false";
//  			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
  			document.getElementById("reportData").style.display="";
  			document.getElementById("footer").style.display="none";
  		}
  		 
  		 
 </script>
<%!String data1, data2, showdate, showdate1;
	int total = 0;
	String VehicleRegNo = "";%>


<%
Connection conn1 = null;

Statement st = null;

try{
	
	String prevDayDate = null;
	String repDate = null;
	String ownerName = null;

	int distanceDifference = 0;

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();

	
%>


<%
	String fromDate = "", toDate = "";

	String dd = request.getQueryString();
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		cal.add(Calendar.DATE, -1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	} else {

		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));

	} //end of else
	String user = session.getAttribute("usertypevalue").toString();
	
	String UserID=session.getAttribute("UserID").toString();
	
	
%>
<input type="hidden" id="user" name="user" value="<%=user %>"></input>
<input type="hidden" id="userid" name="userid" value="<%=UserID %>"></input>


<!-- <form name="dateform" action="" method="get"
	onsubmit="return validate();"> -->
<table border="0" width="100%" align="center" class="sortable_entry">
	<tr>

		<td><b><font size="2">From : </font></b>&nbsp;&nbsp; <input
			type="text" id="data" name="data"
			value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate))%>" size="15" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td><b><font size="2">To : </font></b>&nbsp;&nbsp; <input
			type="text" id="data1" name="data1"
			value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>" size="15" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		
		<td>
           <b><font size="2">Sort By:</font></b>
           <select name="sort" id="sort" style="width: 130px; height:20px; border: 1px solid black; font: normal 13px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" >
                               <%if(request.getParameter("sort")!=null){ %>
                               <option><%=request.getParameter("sort")%></option>
                               <%}%>
                               <option value="Sr.">Sr.</option>
                              <option value="Transporter">Transporter</option>
                              <option value="VehRegNo">Vehicle</option>
                  	            <option value="disconnectionCount">Count</option>
                  	            <option value="sumOfDistance">KmDuringDisconn</option>
                  	            
         </select>  
           </td>
		
		
		<td align="left"><input type="submit" name="submit" id="submit" onclick="birt()"
			value="submit"></td>
	</tr>
</table>
<div id="reportData" style="display:none;">
<iframe id="myIframe" width="100%" height="850px" src=""> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> -->
</iframe> 

 </div>


<!-- </form> -->
<%
	if (!(null == request.getQueryString())) {
		String data = "", data1 = "", vehicleCode = "", vehicleRegistrationNumber = "",sumOfDist="",intripCount="";
		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));
%>
<table border="0" width="100%" class="stats">
	<tr>
		<td colspan="5">
		<table border="0" width="100%">
			<tr>
				<th colspan="3" align="center"><font size="3">Fleet
				Disconnection Report for <%=user%> from <%=request.getParameter("data")%>
				to <%=request.getParameter("data1")%>. </font>
				<div align="right"><a href="#"
					onclick="javascript:window.open('DisconnectedPrint_report.jsp?user=<%=user%>&data=<%=fromDate%>&data1=<%=toDate%>');"
					title="Print Report"><img src="images/print.jpg" width="15px"
					height="15px"></a>&nbsp; &nbsp; <a
					href="exceldisconnected_rep.jsp?user=<%=user%>&data=<%=fromDate%>&data1=<%=toDate%>"
					title="Export to Excel"> <img src="images/excel.jpg"
					width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 		String sdt = fmt.format(new java.util.Date());
 		out.print(sdt);
 		String fromtime, totime;
 %>
				</div>
				</th>
			</tr>
		</table>
		<table border="1" width="60%" class="sortable" align="center">
			<tr>
				<th>Sr.</th>
				<th>Transporter</th>
				<th>Vehicle</th>
				<th>Count</th>
				<th>Km. during disconn</th>

			</tr>
<%
				String unitId = "";
					String unitType = "";
					String dt1 = "", dt2 = "", chdt1 = "", chdt2 = "";
					boolean notify;
					String fromDateTime = fromDate + " " + "00:00:00";
					String toDateTime = toDate + " " + "23:59:59";
					System.out.println("user=" + user);
					int disconnectionCount = 0;
					String commaSeparatedVehicleList = session.getAttribute(
							"VehList").toString();
					String sql = "SELECT distinct(VehRegNo),Transporter,vehicleCode, count(*) as disconnectionCount, sum(Distance) as sumOfDistance FROM  db_gps.t_disconnectionData WHERE vehicleCode in "
							+ commaSeparatedVehicleList
							+ " and OffTimeTo>='"
							+ fromDateTime
							+ "' and OffTimeTo<='"
							+ toDateTime
							+ "' and Duration >= '0:30'" 
							+ " and Reason = 'Disconnection' and ignoredstamp='No' group by VehRegNo";
					System.out.println("sql=" + sql);
					ResultSet rs1 = st.executeQuery(sql);
					int i = 0;
					while (rs1.next()) {
						i = i + 1;
						vehicleCode = rs1.getString("vehicleCode");
						vehicleRegistrationNumber = rs1.getString("VehRegNo");
						disconnectionCount = rs1.getInt("disconnectionCount");
						sumOfDist = rs1.getString("sumOfDistance");
%>
			<tr>
				<td style="text-align: right"><%=i%></td>
				<td style="text-align: left"><%=rs1.getString("Transporter")%></td>
				<td style="text-align: left"><%=vehicleRegistrationNumber%></td>
				<td style="text-align: right">&nbsp;&nbsp;&nbsp; <%
 	if (disconnectionCount > 0) {
 %> 
 		<a href="disconnectedDetailsReport.jsp?vehicleCode=<%=vehicleCode%>&VehicleRegNo=<%=vehicleRegistrationNumber%>&fromDateTime=<%=fromDateTime%>&toDateTime=<%=toDateTime%>&ownerName=<%=rs1.getString("Transporter")%>"><%=disconnectionCount%></a></td>
<%
					} else {
%>
		<%=disconnectionCount%>
<%
					}
%>
			<td style="text-align: right"><%=sumOfDist%></td>
			</tr>
<%
				}
%>
		</table>
		</td>
	</tr>
</table>
<%
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	st.close();
	conn1.close();
	try
	{
	fleetview.closeConnection();
	}catch(Exception e)
	{
	}
}
%>
<%@ include file="footernew.jsp"%>
</jsp:useBean>
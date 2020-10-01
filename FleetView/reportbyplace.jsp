<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.WarehouseList"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.OnlineDataList"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
  	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%><html>
<head>
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



function validate(){
	var place =document.form1.placename.value;
	if(place=="")
	{
		 alert("Please select the Type");
	         return false;   
	}
}
function getLocation(wtype)
{
//alert(wtype);

	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  // code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else if (window.ActiveXObject)
	  {
	  // code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	else
	  {
	  alert("Your browser does not support XMLHTTP!");
	  }
	xmlhttp.onreadystatechange=function()
	{
	if(xmlhttp.readyState==4)
	  {
	  //alert(xmlhttp.responseText);
	  document.getElementById("placename").innerHTML=xmlhttp.responseText;
	  }
	}
	xmlhttp.open("GET","AjxLocationData.jsp?wtype="+wtype,true);
	xmlhttp.send(null);
	
}





</script></head>
<%!Connection conn, conn1;
	Statement st1=null;
%>
<%
	String user, place1 = null, Dist = null, Pname, sql1, vehlist;
	double Distance;
	double Lat1, Lon1, Lat2, Lon2;
%>
<%
	user = session.getAttribute("usertypevalue").toString();
	vehlist = session.getAttribute("VehList").toString();
	String wType=request.getParameter("wType");
	System.out.println("wType>>>> " +wType);
	try {
		
		conn = fleetview.ReturnConnection();
		//conn1 = fleetview.ReturnConnection1();
		st1=conn.createStatement();
%>

<body>
				<form name="form1" method="get" action="" onsubmit="return validate();">

<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">
		<!-- <div align="left"><font size="3">Report No:2.0</font></div>-->
		<font size="3"><b>Vehicles In Geofenced Location</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" class="stats">
			<tr>
				<td>
				<table border="0" width="80%" class="sortable_entry">
					<tr><td><font face="Arial" size="2"><b>Type :</b></font>
						 <select name="wType" id="wType" class="element select medium" onchange="getLocation(this.value);">
						 	<option value="Select">Select</option>
						 
							<option value="All">All</option>
							<%
							String sql2="select distinct(WType) from db_gps.t_warehousedata where WType<>'-' and WType<>''";
							ResultSet rstype=st1.executeQuery(sql2);
												
							while(rstype.next())
											{
												%>
													<option value="<%=rstype.getString("WType")%>"><%=rstype.getString("WType")%></option>					
												<%
											}
							%>
							
							
						</select>
						</td>
						<td><font face="Arial" size="2"><b>Location :</b></font> 
							<%
								List<WarehouseList> list = null;
									int numRecords = 0;
									try {
										list = vehicleDao.getWarehouseList(session.getAttribute(
										"usertypevalue").toString());
										
										numRecords = list.size();
									} catch (Exception e) {
										e.printStackTrace();
									}

									
							%>
							<select	name="placename" id="placename" class="element select medium" style="width: 120px;">
							

						</select></td>
						
						
						<td><font face="Arial" size="2"><b>Distance :</b></font>
						 <select name="distance" id="distance" class="element select medium">
							<option value="200m"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("0.2"))
						out.print("selected='yes'");
				}%>>200
							m.</option>
							<option value="1"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("1"))
						out.print("selected='yes'");
				}%>>1
							km.</option>

							<option value="5"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("5"))
						out.print("selected='yes'");
				}%>>5
							km.</option>
							<option value="10"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("10"))
						out.print("selected='yes'");
				}%>>10
							km.</option>
							<option value="15"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("15"))
						out.print("selected='yes'");
				}%>>15
							km.</option>
							<option value="20"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("20"))
						out.print("selected='yes'");
				}%>>20
							km.</option>
							<option value="25"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("25"))
						out.print("selected='yes'");
				}%>>25
							km.</option>
							<option value="30"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("30"))
						out.print("selected='yes'");
				}%>>30
							km.</option>
							<option value="35"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("35"))
						out.print("selected='yes'");
				}%>>35
							km.</option>
							<option value="40"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("40"))
						out.print("selected='yes'");
				}%>>40
							km.</option>
							<option value="45"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("45"))
						out.print("selected='yes'");
				}%>>45
							km.</option>
							<option value="50"
								<%if (request.getQueryString() != null) {
					if (request.getParameter("distance").equals("50"))
						out.print("selected='yes'");
				}%>>50
							km.</option>
						</select></td>&nbsp;
						<td class="hed">
						<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black"></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>
				<%
					String dd = request.getQueryString();
						if (dd == null) {
							out
									.println("<font face='arial' size='3'> <center>Please Select the Location and Distance.</center></font>");
						} else {
							session.setAttribute("placename", request
									.getParameter("placename"));
							session.setAttribute("distance", request
									.getParameter("distance"));
							StringTokenizer sk = new StringTokenizer(request
									.getParameter("placename"), ",");
							
							if("200m".equalsIgnoreCase(request
									.getParameter("distance"))){
								Distance = 0.2;
							}
							else{
								Distance = Double.parseDouble(request
										.getParameter("distance"));
							}
							Lat1 = Double.parseDouble(sk.nextToken());
							Lon1 = Double.parseDouble(sk.nextToken());
							Pname = sk.nextToken();
							session.setAttribute("Pname", Pname);
				%>
				<table width="100%" align="center" border="0">
					<tr>
						<td align="center"><font size="3"><B>The Vehicle
						 <%=" " + request.getParameter("distance")
									+ " "%>km. Around the
						Place <%=" " + Pname%> </B></font>
						<div align="right"><a href="#"
							onclick="javascript:window.open('printreportbyplace.jsp');"><img
							src="images/print.jpg" width="15px" height="15px"></a>&nbsp;
						&nbsp; <a href="excelreportbyplace.jsp" title="Export to Excel"><img
							src="images/excel.jpg" width="15px" height="15px"></a> <b>
						<%=Utilities.printDate()%> </b></div>
						</td>
					</tr>
				</table>
				<table class="sortable" border="1">
					<tr>
						<th>Sr.</th>
						<th class="hed">Veh.</th>
						<th class="hed">Updated.</th>
						<th class="hed">Transporter</th>
						<th class="hed">Date</th>
						<th class="hed">Time</th>
						<th class="hed">Distance In Km.</th>
						<th class="hed">Location</th>
					</tr>
					<%
						List<OnlineDataList> dataList = null;
								int recordCount = 0;
								try {
									dataList = vehicleDao.getOnlineDataList(session
											.getAttribute("VehList").toString());
									recordCount = dataList.size();
								} catch (Exception e) {
									e.printStackTrace();
								}
								int i=1;
								for (int counter = 0; counter < recordCount; counter++) {
									OnlineDataList currentRecord = dataList.get(counter);

									Lat2 = Double.valueOf(currentRecord
											.getLatitudePosition());
									Lon2 = Double.valueOf(currentRecord
											.getLongitudePosition());
									double dist2 = Utilities.PointToPointDistance(Lat1,
											Lon1, Lat2, Lon2);
									double dist1 = dist2;
									//out.println(dist2);
									if (dist2 <= Distance) {
					%>
					<tr>
						<td>
						<div align="right"><%=i%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=currentRecord
											.getVehicleRegistrationNumber()%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord.getTheDate()))%>  <%=currentRecord.getTheTime()%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=currentRecord.getTransporter()%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord.getTheDate()))%></div>
						</td>
						<td class="bodyText">
						<div align="right"><%=currentRecord.getTheTime()%></div>
						</td>
						<td class="bodyText">
						<div align="right"><%=dist2%></div>
						</td>
						<td class="bodyText">
						<div align="left"><a
						href="shownewmap.jsp?lat=<%=currentRecord.getLatitudePosition()%>&long=<%=currentRecord.getLongitudePosition()%>
						&discription=<%=currentRecord.getLocation()%> 
						onclick=popWin=open('shownewmap.jsp?lat=<%=currentRecord.getLatitudePosition()%>
						&long=<%=currentRecord.getLongitudePosition()%>
						&discription=<%=currentRecord.getLocation()%>', 'myWin','width=500, height=500'); popWin.focus(); return false;">
					<%=currentRecord.getLocation()%></a>
						</div>
						</td>
					</tr>
					<%
					i++;
						}
					}
					%>
				</table>

				<%
				}
				%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%
	} catch (Exception e) {
		out.print("Exception " + e);
	}
	finally
	{
		try
		{
		fleetview.closeConnection();
		}catch(Exception e)
		{
		}	
		
	}
%>
</jsp:useBean>	 
<%@ include file="footernew.jsp"%>


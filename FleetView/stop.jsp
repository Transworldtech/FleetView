<%@ include file="Connections/conn.jsp" %>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
import="com.transworld.fleetview.framework.GetTripDetails"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.Utilities"%>
	
	<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<script src="js/searchhi.js" type="text/javascript"></script>
	
<script language="javascript">
function reload(){
	var tr=document.getElementById("tabl");
	var tripid=document.getElementById("tripid").value;
	var startDate=document.getElementById("startDate").value;
	var endDate=document.getElementById("endDate").value;
	var startPlace=document.getElementById("startPlace").value;
	var endPlace=document.getElementById("endPlace").value;
	opener.location.href=opener.location.href;
}
function localityChange(frm,id)
{
	var count = document.stop.cnt.value;
	var locality = document.getElementById("locality"+id);
	//alert(locality.value);
	if(locality.value=='select')
	{
		alert("Please Select Locality");
		return false;
	}
	
	if(locality.value=='Other')
	{
	//	var tr=document.getElementById("tabl");
		var tripid=document.getElementById("tripId").value;
		var startDate=document.getElementById("startDate").value;
		var endDate=document.getElementById("endDate").value;
		var startPlace=document.getElementById("startPlace").value;
		var endPlace=document.getElementById("endPlace").value;
		
		popitup("addNewLocality.jsp?tripid="+tripid+"&startDate="+startDate+"&endDate="+endDate+"&startPlace="+startPlace+"&endPlace="+endPlace);
		//popitup("addNewLocality.jsp?ins=new&startPlace="+startPlace+"&endPlace="+endPlace);
	//	tr.style.display='';
	}
	
}

function popitup(url) {
	newwindow=window.open(url,'name','height=200,width=300,top=100,left=400,resizeable=0,scrollbars=0');
	if (window.focus) {newwindow.focus()}
	return false;
}

function functoggle(frm,id)
{
	var localitytype = document.getElementById("localitytype"+id);
	//alert(locality.value);
	if(localitytype.value=='select')
	{
		alert("Please Select Locality Type");
		return false;
	}
	
	
}

function validaterdb()
{
	//alert("hi");
	
	var count=document.stop.cnt.value;
	var flag=true;
	//alert(count);
	for(i=1;i<count;i++)
	{
		//alert("i="+i);
		locality=document.getElementById("locality"+i).value;
		stopreason=document.getElementById("stopreason"+i).value;
	//	alert(locality);
		if(locality=='select')
		{
			alert("Please select locality for all records");
			flag=false;
			break;
		}	
		else if(stopreason==""){
			//alert(stopreason);
			alert("Please enter reason for stoppage for all records");
			flag=false;
			break;
		}
	}

	if(flag==false)
	{
		return false;
	}
	
	return true;
}
</script>
	<%
	Connection con=null;
	Statement stmt=null;
	 String tripID, vehicleID,param;
	//param=request.getParameter("msg").toString();
	// System.out.println(param);
	tripID = request.getParameter("tripid");
	String startDate=request.getParameter("startDate").toString();
	 String endDate=request.getParameter("endDate").toString();
	 String startPlace=request.getParameter("startPlace").toString();
	 System.out.println("startPlace111===>"+startPlace);
	 String endPlace=request.getParameter("endPlace").toString();
	 String transporter = request.getParameter("transporter");
	 out.println(transporter);
	 String gpName=session.getAttribute("usertypevaluemain").toString();
	 
	List<GetTripDetails> tripDetailsData = null;
	try {
		tripDetailsData = vehicleDao.getTripDetails(tripID);
	} catch (Exception e) {
		e.printStackTrace();
	}
	vehicleID=tripDetailsData.get(0).getVehicleCode();
	%>
<!-- herer end here-->
	<table border="0" width="100%" align="center" bgcolor="white">
		<tr>
			<!--<td>
			<div align="left"><font size="3">Report No:0.0</font></div>
		</td>-->
		</tr>
		<tr>
			<td><div align="center"><font  size="3"><B>Stops Report.</B></font></div>
				
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="hidden" name="tripid" id="tripId" value="<%=tripID%>"></input>
					<input type="hidden" name="startDate" id="startDate" value="<%=startDate %>"></input>
					<input type="hidden" name="endDate" id="endDate" value="<%=endDate %>"></input>
					<input type="hidden" name="startPlace" id="startPlace" value="<%=request.getParameter("startPlace").toString()%>"></input>
					<input type="hidden" name="endPlace" id="endPlace" value="<%=request.getParameter("endPlace").toString() %>"></input>
					<input type="hidden" name="trans" value="<%=transporter%>"></input>
			<form name="stop" method="post" action="stopinsert.jsp" onSubmit="return validaterdb();">
			<%
			String msg="";
			try{
				msg=request.getParameter("msg");
			System.out.println(msg);
			}
			catch(Exception ee){
				ee.printStackTrace();
			}
			if(null==msg||("null").equalsIgnoreCase(msg)||"".equalsIgnoreCase(msg)){
				
			}
			else if("inserted".equalsIgnoreCase(msg)){
				System.out.println(msg);
				%>
				<table align="center">
				<tr><td align="center" ><font color="maroon">Inserted Successfully</font></td></tr>
				</table>
				<%
			}
			%>
				<table  width="100%" border="0" class="sortable" >
				
					<tr>
						<th>Sr.</th>
						<th>FromDateTime</th>
						<th>ToDateTime</th>
						<th>Duration</th>
						<th>Location</th>
						<th>Locality Type</th>
						<th>Locality</th>
						<th>Reason for stoppage</th>
						<th>Remark</th>
					</tr>	
					<%
					
				List<ContinuousDrivingDetailsData> Stopsdata = null;
					int numRecords = 0;
					int cnt=0;
					int i=1;
				try {
					Stopsdata = vehicleDao.getContinuousDrivingDetailsData(
							vehicleID,
							startDate, endDate, "Stops");
					numRecords = Stopsdata.size();
				} catch (Exception e) {
					e.printStackTrace();
				}
				for (int counter = 0; counter < numRecords; counter++) {
					final ContinuousDrivingDetailsData currentRecord = Stopsdata
							.get(counter);
					
					java.util.Date startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentRecord.getStartDate()+" "+currentRecord.getStartTime());
					java.util.Date endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentRecord.getEndDate()+" "+currentRecord.getEndTime());
					
					long startTimeLong = startTime.getTime();
					long endTimeLong = endTime.getTime();
					
					long timeDifferenceInMilliseconds = endTimeLong - startTimeLong;
					long timeInSecs = timeDifferenceInMilliseconds/1000; 	//convert milliseconds to seconds
					long hrs = timeInSecs/60/60;
					long min = (timeInSecs/60) - (hrs*60);
					//System.out.println(hrs);
					
					if(hrs>=2){
					//	System.out.println("long start-----"+startTimeLong+" ----long end----- "+endTimeLong+" ---"+hrs+":"+min);
					cnt=i;
			%>
				<tr>
						<td style="text-align: left"><%=i%><input type="hidden" name="tripid<%=i %>" value="<%=request.getParameter("tripid")%>"></input>
						<input type="hidden" name="startPlace<%=i %>" value="<%=startPlace %>"></input>
						<input type="hidden" name="endPlace<%=i %>" value="<%=endPlace %>"></input>
						<input type="hidden" name="trans" value="<%=transporter%>"></input>
						<input type="hidden" name="gpname" value="<%=gpName%>"></input>
						</td>
						<td style="text-align: left" id=startdate<%=i%>><input type="hidden" name="startdate<%=i %>" value="<%=currentRecord.getStartDate()+" "+currentRecord.getStartTime()%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(currentRecord.getStartDate()))%> <%=currentRecord.getStartTime()%>
						</td>
						<td style="text-align: left" id=enddate<%=i %>><input type="hidden" name="enddate<%=i %>" value="<%=currentRecord.getEndDate()+" "+currentRecord.getEndTime()%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(currentRecord.getEndDate()))%> <%=currentRecord.getEndTime()%>
						</td>
						<td style="text-align: right" id=duration<%=i %>><input type="hidden" name="duration<%=i %>" value="<%=currentRecord.getDuration()%>"><%=currentRecord.getDuration()%></td>
						<td style="text-align: left" id=loc<%=i%>><input type="hidden" name="loc<%=i %>" value="<%=currentRecord.getStopReportLocation()%>">
						<%=currentRecord.getStopReportLocation()%>
						<!--<a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=< %=currentRecord.getStartLocationLatitude()%>&long=< %=currentRecord.getStartLocationLongitude()%>&discription=< %=currentRecord.getStartLocation()%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(< %=i%>,false);">
						< %=currentRecord.getStopReportLocation()%></a>--></td>
						<td>
							<div align="left"><select name="localitytype<%=i%>" id="localitytype<%=i%>" class="formElement" onchange="functoggle(this)">
								<option value="select">Select</option>
			             		<option value="Hotel">Hotel</option>
				                <option value="Parking">Parking</option>
				                <option value="Petrol Pump">Petrol Pump</option>
				                <option value="Garage">Garage</option>
				                <option value="Home">Home</option>
				                <option value="Home">Octroi Naka</option>
				                <option value="Other">Other</option>
		             		</select>
		             		</div>
						</td>
						<td>
							<div align="left"><select name="locality<%=i%>" id="locality<%=i%>" class="formElement" onchange="localityChange(this,<%=i %>)">
			             				<option value="select">Select</option>
			             		<%
			             		try{           
			             			Class.forName(MM_dbConn_DRIVER);
			             			con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			             			stmt=con.createStatement();
			             			String sql="SELECT * FROM t_routewiseLocalityName WHERE startPlace='"+startPlace+"' and endPlace='"+endPlace+"' ";
			             			//System.out.println(sql);
			             			ResultSet rsLoc=stmt.executeQuery(sql);
			             			while(rsLoc.next())
			             			{
			             		%>
			             				<option value="<%=rsLoc.getString("locality") %>"><%=rsLoc.getString("locality") %></option>
			             		<%
			             			}
			             		}
			             		catch(Exception e){
			             			e.printStackTrace();
			             		}
			             		finally{
			             			stmt.close();
			             			con.close();
			             		}
			             		%>
				                		<option value="Other">Other</option>
				                
		             		</select>
		             		</div>
						</td>
						
						<td><input type="text" id="stopreason<%=i %>" name="stopreason<%=i %>" class="formElement"/></td>
						<td><textarea id="comment<%=i %>" name="comment<%=i %>" rows="3" class="formElement"></textarea></td>
				</tr>
				
					
			<%
			i++;
					}
				}
			%>	<tr>
				<td colspan="9" align="center"><input type="submit" name="submit" value="Submit" 
						onClick="submit()"><input type="hidden" name="cnt" value="<%=cnt%>"></input>
						<input type="hidden" name="startDate" value="<%=startDate%>"></input>
						<input type="hidden" name="endDate" value="<%=endDate%>"></input>
				</td>
				</tr>
				</table>
				</form>
			</td>
		</tr>
	</table>	
<%@ include file="footernew.jsp" %>
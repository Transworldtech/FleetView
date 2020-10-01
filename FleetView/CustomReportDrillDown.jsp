 <%@ include file="headernew.jsp"%>


<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

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
<script type="text/javascript">
 
function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)  
{  
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;
    
    document.tripwise.action ="excel.jsp";
    document.forms["tripwise"].submit();
} 





</script>

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!

String vid="", sql="",sql1="",sql2="", transporter="", vehregno="", thedate1="", thedate2="",usertype="";
String showdate="",dateformat="";
Connection con=null ;
int ab=0;

%>

<%
try
{
//	Class.forName(MM_dbConn_DRIVER);
	con = fleetview.ReturnConnection();
	Statement st4=con.createStatement();
	 Statement st5=con.createStatement();
	 Statement st12=con.createStatement();
	 Statement st41=con.createStatement();
	 Statement st42=con.createStatement();
	
	dateformat = session.getAttribute("dateformat").toString();
	usertype=session.getAttribute("usertypevalue").toString();
	System.out.println("Transporter name"+usertype);
	vid=request.getParameter("vehcode");
	System.out.println("vid:-----"+vid);
	java.util.Date NewDate= new java.util.Date();
	long dateMillis= NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate2=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	dayInMillis = 14000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	List<GetVehicleDetails> currRecord=null;
	String datat=request.getParameter("data");
	String datat1=request.getParameter("data1");
	int numRecords11 = 0;
	try {
		currRecord = vehicleDao.getVehicleDetails(vid);
		
		numRecords11 = currRecord.size();
	} catch (Exception e) {
		e.printStackTrace();
	}
	for (int counter = 0; counter < numRecords11; counter++)
	{
		vehregno=currRecord.get(counter).getVehicleRegistrationNumber();
		transporter=currRecord.get(counter).getOwnerNAme();
	}
	try
	{
		String sql11="select * from t_vehicledetails where VehicleCode='"+vid+"'";
		ResultSet rst=st12.executeQuery(sql11);
		if(rst.next())
		{
			vehregno=rst.getString("VehicleRegNumber");		
			transporter=rst.getString("OwnerName");
			
		}	
	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>>>>>.Exception:"+e);
	}
	int discounter=0;
    if(request.getParameter("counterv")!=null)
    {
	  String str=request.getParameter("counterv");
	  //System.out.println("\n\n\nstr---->>>>>-->>"+str);
      discounter=Integer.parseInt(str);
      //System.out.println("\n\n\n---->>>>>-->>"+discounter);
    }
%>
<%	   String exportFileName="TripwiseExceptionReport.xls";
%>
<form id="tripwise" name="tripwise" action="" method="post">
<div id="table1">
<table width="100%" align="center" class="stats" >
			<tr>
			<td align="center">
			<!-- <div align="left"><font size="3" >Report No: 1.9</font></div>-->
			</td>
			</tr>
			<tr>
			<td>
			<%-- <div align="center"><font  size="3" face="Arial"><b>Exception Report For Vehicle <%=vehregno%> For The Period:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat))%> 00:00:00 to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat1))%> 23:59:59 </b></font></div>
				<div align="right"> --%>
<!--  				<a href="#" onclick="javascript:window.open('print_CustomDrill.jsp?vid=<%=vid %>&datat=<%=datat %>&datat1=<%=datat1 %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a> --> &nbsp; &nbsp; 
				<%-- <a href="excel_CustomDrill.jsp?vid=<%=vid %>&datat=<%=datat %>&datat1=<%=datat1 %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> --%>
				<%-- <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
				<font size="2"> Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) %></font> --%>
				<%-- <%=Utilities.printDate()%> --%>
				<!-- </div> -->
				<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     <div align="center"><font  size="3" face="Arial"><b>Exception Report For Vehicle <%=vehregno%> For The Period:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat))%> 00:00:00 to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat1))%> 23:59:59 </b></font></div>
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=Utilities.printDate()%>
                           </div>
			</td>
			</tr>
			</table>
			
<table border="0" align="center" width="100%" class="stats">
			<tr>
		<td align="center"><font size="3"><b>Over Speed</b></font></td>
	</tr>
	
	
	
	
	<tr>
	     <%System.out.println("vid:--"+vid);
	     System.out.println("usertype:--"+usertype);
	     System.out.println("vehregno:--"+vehregno);
	     System.out.println("datat:--"+datat);
	     System.out.println("datat1:--"+datat1);%>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
		 <% try
		{
			String role=session.getAttribute("userrole").toString();
			
			System.out.println("role is :-"+role);
			if(role.equalsIgnoreCase("Castrolsuperadmin"))
			  {  %>
				<div align="left"><a href="#" onclick="javascript:window.open('OverrideReport.jsp?vid=<%=vid %>&Transporter=<%=usertype%>&tripid=-&vehRegNo=<%=vehregno%>&SD=<%=datat %>&ED=<%=datat1 %>')">
   Violation Override</a> </div>
				
			  <% }
			
	     }
		catch(Exception e)
		{
			System.out.println(">>>>>>>>>>>>>>>>.Exception:"+e);
		} %> 
		<%-- <div align="left"><a href="#" onclick="javascript:window.open('OverrideReport.jsp?vid=<%=vid %>&Transporter=<%=usertype%>&tripid=-&vehRegNo=<%=vehregno%>&SD=<%=datat %>&ED=<%=datat1 %>')">
   Violation Override</a> </div> --%>
			<tr>
			
			
				<th><b> Sr. </b></th>
				<th><b>From-Date-Time</b></th>
				<th><b>Speed</b></th>
				<th><b>Duration in Sec.</b></th>
				<th><b>Location - Click To View On Map.</b></th>
				<th><b>Zone</b></th>
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
				
			</tr>
			<tr>
			<%
		
			try{
				int os=1;
				String bgcolor="",zonecolor="",fromdate="",zoneval="";
			//String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vid+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vid+"  WHERE  TheFiledTextFileName= 'OS' GROUP BY TheFieldDataDate, TheFieldDataTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(FromDate,' ',FromTime) >='"+datat+" 00:00:00' and concat(FromDate,' ',FromTime) <='"+datat1+" 23:59:59' ORDER BY concat(os.FromDate,os.FromTime)";
			String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vid+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vid+"  WHERE  TheFiledTextFileName= 'OS' and TheFieldDataDateTime >= '"+datat+" 00:00:00' and TheFieldDataDateTime <= '"+datat1+" 23:59:59' GROUP BY TheFieldDataDateTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(os.FromDate,' ',os.FromTime) >='"+datat+" 00:00:00' and concat(os.FromDate,' ',os.FromTime) <='"+datat1+" 23:59:59' ORDER BY concat(os.FromDate,os.FromTime)";
			System.out.println("Join query is"+sqloscalc);
			ResultSet rsoscalc=st4.executeQuery(sqloscalc);
			while(rsoscalc.next())
			{
				fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsoscalc.getString("FromDate")));
				
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
						<td style="text-align:right;<%=bgcolor%>"><%=fromdate%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsoscalc.getString("FromTime"))) %></td>
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
			
			<%
			String sqlostodate="select DATE_ADD('"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"', INTERVAL '"+rsoscalc.getString("Duration")+"' second) datetim";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"' and snapdatetime<=DATE_ADD('"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"', INTERVAL '"+rsoscalc.getString("Duration")+"' second)  and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;<%=bgcolor%>"><a href="CameraImageReport.jsp?data=<%=rsoscalc.getString("FromDate") %> <%=rsoscalc.getString("FromTime") %>&data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{%>
			<td style="text-align:right;<%=bgcolor%>">0</a></td>
			<%}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"' and snapdatetime<=DATE_ADD('"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"', INTERVAL '"+rsoscalc.getString("Duration")+"' second) and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;<%=bgcolor%>"><a href="CameraImageReport.jsp?data=<%=rsoscalc.getString("FromDate") %> <%=rsoscalc.getString("FromTime") %>&data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{%>
			<td style="text-align:right;<%=bgcolor%>">0</a></td>
			<%}
			}
			
			%>
			</tr>
			
			<%
			os++;
			}}catch(Exception e)
			{
				e.printStackTrace();
				
			}
			
			%>
			
		</table>

		</td>
	</tr>
	
	
	
	<tr>
		<td align="center"><font size="3"><b>Rapid
		Acceleration</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Location - Click To View On Map.</b></th>
				<th><b>Cabin Images</b></th>
						<th><b>Road Images</b></th>
			</tr>
			<%
						List<RapidAccelerationDetailsData> data = null;
						int numRecords1 = 0;
						try {
							data = vehicleDao.getRapidAccelerationDetailsData(vid, datat+" 00:00:00", datat1+" 23:59:59", "RapidAcceleration");
							numRecords1 = data.size();
						} catch (Exception e) {
							e.printStackTrace();
						}
						for (int counter = 0; counter < numRecords1; counter++)
						{
							final RapidAccelerationDetailsData currentRecord1 = data.get(counter);
							%>
			<tr>
				<td><%=counter+1 %></td>
				<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord1.getDate()))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse( currentRecord1.getTime()))%></td>
				</div><td>
				<div align="right"><%=currentRecord1.getFromSpeed()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord1.getToSpeed()%></div>
				</td>
				<td>
				<div align="left">
				<%
	if (null != currentRecord1.getLocation()
					&& !"null".equalsIgnoreCase(currentRecord1
							.getLocation())
					&& null != currentRecord1.getLatitude()) {
								String lat1=currentRecord1.getLatitude();
								String lon1=currentRecord1.getLongitude();
								String disc=currentRecord1.getLocation();
%>							 

								<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
 	} else if (null != currentRecord1.getLocation()
 					&& !"null".equalsIgnoreCase(currentRecord1
 							.getLocation())) {
 				out.println(currentRecord1.getLocation());
 			}
 %>
				</div>
				</td>
				<%
			String sqlostodate="select DATE_ADD('"+currentRecord1.getDate()+" "+currentRecord1.getTime()+"', INTERVAL 2 second) datetim,DATE_SUB('"+currentRecord1.getDate()+" "+currentRecord1.getTime()+"', INTERVAL 2 second) datetim1";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
			 }
						%>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><font size="3"><b>Rapid
		Deceleration</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Location - Click To View On Map.</b></th>
				<th><b>Cabin Images</b></th>
						<th><b>Road Images</b></th>
			</tr>
			<%
		
		List<RapidAccelerationDetailsData> data1 = null;
		int numRecords2 = 0;
		try {
			data1 = vehicleDao.getRapidAccelerationDetailsData(vid,datat+" 00:00:00", datat1+" 23:59:59", "RapidDecceleration");
			numRecords2 = data1.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords2; counter++)
		{
			final RapidAccelerationDetailsData currentRecord2 = data1.get(counter);
			%>
			<tr>
				<td><%=counter+1 %></td>
				<td><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord2.getDate()))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord2.getTime()))%></td>
				</div><td>
				<div align="right"><%=currentRecord2.getFromSpeed()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord2.getToSpeed()%></div>
				</td>
				<td>
				<div align="left">
				<%
if (null != currentRecord2.getLocation()
	&& !"null".equalsIgnoreCase(currentRecord2
			.getLocation())
	&& null != currentRecord2.getLatitude()) {
								String lat1=currentRecord2.getLatitude();
								String lon1=currentRecord2.getLongitude();
								String disc=currentRecord2.getLocation();
%>							 

								<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
} else if (null != currentRecord2.getLocation()
		&& !"null".equalsIgnoreCase(currentRecord2
				.getLocation())) {
	out.println(currentRecord2.getLocation());
}
%>
				</div>
				</td>
				<%
			String sqlostodate="select DATE_ADD('"+currentRecord2.getDate()+" "+currentRecord2.getTime()+"', INTERVAL 2 second) datetim,DATE_SUB('"+currentRecord2.getDate()+" "+currentRecord2.getTime()+"', INTERVAL 2 second) datetim1";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
			 }
						%>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><font size="3"><b>Stops</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Duration</b></th>
				<th><b>Location - Click To View On Map.</b></th>
			</tr>
			<%				
		List<ContinuousDrivingDetailsData> data3 = null;
		int numRecords3 = 0;
		try {
			data3 = vehicleDao.getContinuousDrivingDetailsData(
					vid, datat+" 00:00:00", datat1+" 23:59:59", "Stops");
			numRecords3 = data3.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords3; counter++) {
			final ContinuousDrivingDetailsData currentRecord3 = data3
					.get(counter);
		
		%>
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getStartDate()))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord3.getStartTime()))%></div>
				</td>
				<td>
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getEndDate()))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord3.getEndTime()))%></div>
				</td>
				<td>
				<div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord3.getDuration()))%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord3.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord3
											.getStartLocation())
									&& null != currentRecord3.getStartLocationLatitude()) {
						String lat1=currentRecord3.getStartLocationLatitude();
						String lon1=currentRecord3.getStartLocationLongitude();
						String disc=currentRecord3.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord3.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord3
											.getStartLocation())) {
								out.println(currentRecord3.getStartLocation());
							}
				%>
				</div>
				</td>
			</tr>
			<%		
		}
		%>
		</table>
		</td>
	</tr>



	<tr>
		<td align="center"><font size="3"><b>Night Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Trip ID</b></th>
				<th><b>Reason</b></th>
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
				
			</tr>
			<%
		    List<ContinuousDrivingDetailsData> data4 = null;
			int numRecords4 = 0;
			try {
				data4 = vehicleDao.getContinuousDrivingDetailsData(
						vid, datat+" 00:00:00", datat1+" 23:59:59", "NightDriving");
				numRecords4 = data4.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords4; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord4 = data4
				.get(counter);
%>
			
<%
String sd=currentRecord4.getStartDate();
String st=currentRecord4.getStartTime();


String ed=currentRecord4.getEndDate();
String et=currentRecord4.getEndTime();
%>					
			
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord4
															.getStartDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord4.getStartTime()))%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord4.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getStartLocation())
									&& null != currentRecord4.getStartLocationLatitude()) {
						String lat1=currentRecord4.getStartLocationLatitude();
						String lon1=currentRecord4.getStartLocationLongitude();
						String disc=currentRecord4.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord4.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getStartLocation())) {
								out.println(currentRecord4.getStartLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord4
															.getEndDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord4.getEndTime()))%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord4.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getEndLocation())
									&& null != currentRecord4.getEndLocationLatitude()) {
						String lat1=currentRecord4.getEndLocationLatitude();
						String lon1=currentRecord4.getEndLocationLongitude();
						String disc=currentRecord4.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord4.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getEndLocation())) {
								out.println(currentRecord4.getEndLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="right"><%=currentRecord4.getDistancetravelled()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord4.getDuration()%></div>
				</td>
			
			<%
				String TripID="";
				String tripid="select JCode from db_gpsExceptions.t_veh"+vid+"_nd where concat(FromDate,' ',FromTime) between '"+currentRecord4.getStartDate()+" "+currentRecord4.getStartTime()+"' and  '"+currentRecord4.getEndDate()+" "+currentRecord4.getEndTime()+"'";
				ResultSet rs=st4.executeQuery(tripid);
				if(rs.next())
				{
					TripID=rs.getString("JCode");
					System.out.println("------------"+TripID);
				}
				
				%>
				
				<td>
				<div align="left"><%=TripID%></div> 
			   </td>
			
			
			<td>
			<%
			String reason="";
			    try{
			   String sqlreason="select reason from db_gpsExceptions.t_ndpostintimation where VehRegNo='"+vehregno+"' and NdStartDateTime='"+sd+" "+st+"' and NdEndDateTime='"+ed+" "+et+"'";
			   ResultSet rsreason=st5.executeQuery(sqlreason);
			   if(rsreason.next())
			   {
				   reason=rsreason.getString("reason");
				   
			   }
			    }catch(Exception e)
			    {
			    	System.out.println(">>>>>>>>e:"+e);
			    }
			
			if(reason.equals("-") || reason.equals(""))
			{
				%>
			<%="<a href=\"veh_report_ndfeedback.jsp?vehregno="+vehregno+"&vid="+vid+"&tripid="+TripID+"&startdatetime="+sd+" "+st+"&enddatetime="+ed+" "+et+"\"onclick=\"popWin=window.open('veh_report_ndfeedback.jsp?vehregno="+vehregno+"&vid="+vid+"&tripid="+TripID+"&startdatetime="+sd+" "+st+"&enddatetime="+ed+" "+et+"','ND Reason','width=400,height=350');popWin.focus();return false\">Add Reason</a>"%>
			<%
			}
			else
			{
				if(reason.length()>10)
				{
					%>
					<%="<a href=\"veh_showreason.jsp?reason="+reason+"\"onclick=\"popWin=window.open('veh_showreason.jsp?reason="+reason+"','ND Reason','width=400,height=300');popWin.focus();return false\">Show Reason</a>"%>
				<%}
				else
				{
				%>
				<%=reason %>
			<%}} %>  
			</td>
				<%
			String sqlostodate="select concat('"+currentRecord4.getStartDate()+"',' ','"+currentRecord4.getStartTime()+"') datetim,concat('"+currentRecord4.getEndDate()+"',' ','"+currentRecord4.getEndTime()+"') datetim1";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+currentRecord4.getStartDate()+" "+currentRecord4.getStartTime()+"' and snapdatetime<='"+currentRecord4.getEndDate()+" "+currentRecord4.getEndTime()+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim")+"' and snapdatetime<='"+rsostodate.getString("datetim1")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>	
			</tr>
			<%
			}
		    %>
		</table>
		</td>
	</tr>
	
	
	
	<tr>
		<td align="center"><font size="3"><b>Continuous
		Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
			</tr>
			<%
		    List<ContinuousDrivingDetailsData> data5 = null;
			int numRecords5 = 0;
			try {
				data5 = vehicleDao.getContinuousDrivingDetailsData(
						vid, datat+" 00:00:00", datat1+" 23:59:59", "ContinuousDriving");
				numRecords5 = data5.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords5; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord5 = data5
				.get(counter);
%>
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getStartDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord5.getStartTime()))%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())
									&& null != currentRecord5.getStartLocationLatitude()) {
						String lat1=currentRecord5.getStartLocationLatitude();
						String lon1=currentRecord5.getStartLocationLongitude();
						String disc=currentRecord5.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())) {
								out.println(currentRecord5.getStartLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getEndDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord5.getEndTime()))%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())
									&& null != currentRecord5.getEndLocationLatitude()) {
						String lat1=currentRecord5.getEndLocationLatitude();
						String lon1=currentRecord5.getEndLocationLongitude();
						String disc=currentRecord5.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())) {
								out.println(currentRecord5.getEndLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="right"><%=currentRecord5.getDistancetravelled()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord5.getDuration()%></div>
				</td>
				<%
			String sqlostodate="select concat('"+currentRecord5.getStartDate()+"',' ','"+currentRecord5.getStartTime()+"') datetim,concat('"+currentRecord5.getEndDate()+"',' ','"+currentRecord5.getEndTime()+"') datetim1";
			//out.println("Join query is"+sqlostodate);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqlostodate);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+currentRecord5.getStartDate()+" "+currentRecord5.getStartTime()+"' and snapdatetime<='"+currentRecord5.getEndDate()+" "+currentRecord5.getEndTime()+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim")+"' and snapdatetime<='"+rsostodate.getString("datetim1")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount1);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
			}
		    %>
		    
		</table>
		</td>
	</tr>
	<tr><td align="center"><font size="3"><b>Disconnection </b></font></td></tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>

		<th>Sr.</th>
	    <th>OFF Date-Time</th>
	    <th>From Location</th>
		<th>ON Date-Time</th>
		<th>To Location</th>
		<th>Distance</th>
		<th>Duration (hh:mm:ss)</th>
		<th>Trip ID</th>
		
	</tr>
		   <%
			int i=0;
			String fromDate1="",toDate1="";
			String fromLocation="",toLocation="",distance="",duration="",tripid="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;
            
			//String sql12="SELECT * FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vid+"' AND  OffTimeFrom>='"+datat+" 00:00:00' and OffTimeFrom<='"+datat1+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		//	String sql12="Select * from db_gps.t_disconnectionData where vehicleCode='"+vehicleCode+"' AND  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeTo >='"+data1+" 00:00:00'";
			String sql12="SELECT TripId,OffTimeFrom,FromLocation,FromLatitude,FromLongitude,OffTimeTo,ToLocation,ToLatitude,ToLongitude,Distance,CONCAT('duration',CAST(duration AS CHAR)) as duration FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vid+"' AND  OffTimeFrom>='"+datat+" 00:00:00' and OffTimeFrom<='"+datat1+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
	        System.out.println("\n\n-->>sqlllllllll----....>>>>"+sql12);		
	        ResultSet rsSql=st12.executeQuery(sql12);
			
			while(rsSql.next())
			{
				
				System.out.println("\n\n\nvishal rst--->>>"+rsSql);
				//System.out.println("\n\n\nvishal rst--->>>"+rsSql.next());
				i++;
				fromDate1 = rsSql.getString("OffTimeFrom");
				fromLocation = rsSql.getString("FromLocation");
				fromLatitude = rsSql.getDouble("FromLatitude");
				fromLongitude = rsSql.getDouble("FromLongitude");
				toDate1 = rsSql.getString("OffTimeTo");
				toLocation = rsSql.getString("ToLocation");
				toLatitude = rsSql.getDouble("ToLatitude");
				toLongitude = rsSql.getDouble("ToLongitude");
				distance = rsSql.getString("Distance");
				duration = rsSql.getString("Duration");
				String duration1=duration.toString();
				if(discounter>0)
				{	
					String tripidv = request.getParameter("tripid");			
					tripid=tripidv;	
				}
				else
				{
				  tripid = rsSql.getString("TripId");
				}
				//int length=duration.length();
				String disconnectDuration="";
				
				duration1=duration.replace("duration", "");
				System.out.println("NEW duration---------------"+duration1);
				disconnectDuration=duration1;
				/* if(duration.charAt(length-2)==':') //if duration is 1:6 then display as 1:06
				{
					disconnectDuration=duration.replace(":",":0");
				}
				else
				{
					disconnectDuration=duration;
				} */
				
%>

	<tr>
		<td style="text-align: right"><%=i%></td>
	<!--<td style="text-align: left"><%=transporter%></td>
		<td style="text-align: left"><%=vehregno%></td> -->
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1))%></td>
		<td style="text-align: left"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=fromLatitude%>&long=<%=fromLongitude%>&discription=<%=fromLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=fromLocation%>
		</a></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1))%></td>
		<td style="text-align: left"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=toLatitude%>&long=<%=toLongitude%>&discription=<%=toLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=toLocation%>
		</a></td>
		<td style="text-align: right"><%=distance%></td>
		<td style="text-align: center"><%=disconnectDuration%></td>
		<td style="text-align: right"><%=tripid%></td>

	</tr>
<%		   }
			%>

</table>
</td>
</tr>
</table>
</div>
</form>
<%
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
finally
{
	
	try
	{
		con.close();
	}catch(Exception e)
	{
	}
	
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


<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%!Connection conn, conn1;
	Statement st0, st, st1, st2, st3, st4, st11,stlast,st5,st6,st7,stRSM,stRSM1,stRSM2;%>
<%
String uservalue=session.getAttribute("usertypevalue").toString();
	String user, sql = "",first="",fulltank="No",last="", sql1 = null, sql2 = null, sql3 = null, transporter = null, ndcnt = null;
	String fidDate = null, data1 = null, data2 = null, showdate = null, showdate1 = null, trips = null, counDriveYesNo = null, ntDriveYesNo = null;
	String ownerNm = "", DriverName = "";
	double Accelaration1 = 0.00, Decelaration1 = 0.00, OverSpeed1 = 0.00;
	int odofirst = 0, odolast = 0, Odometer = 0;
	double gpsfirst = 0,gpslast = 0,gpsavg=0;
	double gpsfirst1 = 0,gpslast1 = 0,gpsdiff1=0;
	String odoLastDateTime="",odoFirstDateTime="";

	float totalfuel=0,odoavg=0;

	String StartDate = "", EndDate = "", EndTime = "", StartTime = "", fromdate = "", todate = "", thedate = "", thedate1 = "";
	String fromdate1 = "", todate1 = "";
	if (!(null == request.getParameter("data"))) {
		fromdate1 = request.getParameter("data");
		fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(fromdate1));
		todate1 = request.getParameter("data1");
		todate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(todate1));
		//out.print(fromdate);
	} else {
		fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new java.util.Date());
		todate = fromdate;
		fromdate1 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
		todate1 = fromdate1;
		//out.print(todate);
	}
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
}




function gotoPrint(divName)  
{  
	 
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  
		  
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

/*function gotoExcel(elemId,frmFldId)  
{  
	      
	     
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;
        
          
          document.MonthlyOdometerReport.action ="excel.jsp";
          document.forms["MonthlyOdometerReport"].submit();
} 
*/
</script>
<script language="javascript">


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
 		</script>
 		
 	<script type="text/javascript">
function hide()
{
	
	var j=null;
	document.getElementById("tdx").style.display="none";
	document.getElementById("tds").style.display="";
	document.getElementById("1").style.display="none";
	document.getElementById("2").style.display="none";
	document.getElementById("3").style.display="none";
	document.getElementById("4").style.display="none";	
	
/*
	document.getElementById("").style.display="none";
	document.getElementById("3").style.display="none";
	document.getElementById("3").style.display="none";
	*/
	var cnt=document.getElementById("cnt").value;
	var tdx=document.getElementById("tdx").value;
	//alert(cnt+"________"+tdx+"____________________");

	
	if(tdx=="Hide Avg")
	{
		try
		{
		for(j=1;j<=cnt;j++)
		{	
				//alert(">>");
				var fullcount=document.getElementById("fullcount"+j).value;
				var fullcounta=document.getElementById("fullcounta"+j).value;
				if(fullcount>1 || fullcounta>0)
				{
					//alert("1");
			 tda=document.getElementById("tda"+j);
			tda.style.display='none';
			tdb=document.getElementById("tdb"+j);
			tdb.style.display='none';
			tdc=document.getElementById("tdc"+j);
			tdc.style.display='none';
				}else {
					//alert("2");
				//	document.MonthlyOdometerReport.tdp+j.style.display('none');
				    tdp=document.getElementById("tdp"+j);
					tdp.style.display="none";
					tdq=document.getElementById("tdq"+j);
					tdq.style.display="none";
					tdr=document.getElementById("tdr"+j);
					tdr.style.display="none";
					}
				//document.getElementById("manager").style.display="none";
				//alert(cnt+"________"+tdx+"____________________");
				tdm=document.getElementById("manager"+j);
				tdm.style.display="none";
		}
		}
		catch(e)
		{
			alert(e);
		}
	}
}

function show()
{
	var j=null;
	document.getElementById("tds").style.display="none";
	document.getElementById("tdx").style.display="";
	
	//document.getElementById("tdx").style.display="";
	//document.getElementById("tds").style.display="none";
	document.getElementById("1").style.display="";
	document.getElementById("2").style.display="";
	document.getElementById("3").style.display="";
	document.getElementById("4").style.display="";
		
	var cnt=document.getElementById("cnt").value;
	var tds=document.getElementById("tds").value;
	
	if(tds=="Show Avg")
	{
		

		
		try
		{
		for(j=1;j<=cnt;j++)
		{	
			
				var fullcount=document.getElementById("fullcount"+j).value;
				var fullcounta=document.getElementById("fullcounta"+j).value;
				if(fullcount>1 || fullcounta>0)
				{
					//alert(">>"); 
			 tda=document.getElementById("tda"+j);
			tda.style.display="";
			tdb=document.getElementById("tdb"+j);
			tdb.style.display="";
			tdc=document.getElementById("tdc"+j);
			tdc.style.display="";
				}else {
					//alert(">>>");
				    tdp=document.getElementById("tdp"+j);
					tdp.style.display="";
					tdq=document.getElementById("tdq"+j);
					tdq.style.display="";
					tdr=document.getElementById("tdr"+j);
					tdr.style.display="";
					}
				//document.getElementById("manager").style.display="";
				//alert(cnt+"________"+tds+"____________________");
			tdm=document.getElementById("manager"+j);
			tdm.style.display="";
		}
		}
		catch(e)
		{
			alert(e);
		}
	}
}
</script>
<script>

function ShowHide(date1,date2) {
	var showhide;
	
	if(document.getElementById("tds").style.display=="") {
			showhide=document.MonthlyOdometerReport.tds.value;
		}else {
			showhide=document.MonthlyOdometerReport.tdx.value;

			}
	//alert("_____"+showhide+"_____");
	var d1=document.MonthlyOdometerReport.date1.value;
	var d2=document.MonthlyOdometerReport.date2.value;
	//alert("+++++"+d1+"++++"+d2+"+++++++++");
	
		window.location.href="odometerexcel.jsp?newvalue="+showhide+"&data="+d1+"&data1="+d2;
		//alert(">>");
	
}
</script>
 		
 		
 				<form action="" method="get" onsubmit="return validate();">
 				<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  
 		<table border="0" width=600 align="center" class="stats">
		<tr>
			<td colspan="5" align="center">
			<!-- <div align="left"><font size="3">Report No:5.5</font></div>-->
			<font size="3"><b>Odometer Report</b></font></td>
		</tr>
		</table>
		<table border="0" width=600 align="center" class="sortable_entry">

		<tr>
			<td align="right"><b>From </b>&nbsp;&nbsp; <input type="text"
				id="data" name="data" value="<%=fromdate1 %>" size="15" readonly /></td>
			<td align="left"><!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script></td>
			<td align="right"><b>To </b>&nbsp;&nbsp; <input type="text"
				id="data1" name="data1" value="<%=todate1 %>" size="15" readonly /></td>
			<td align="left"><!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
			<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>
			<td><input type="submit" name="submit" id="submit"
				value="submit"></td>
		</tr>
		
	</table>
</form>
			
				<%
					String dd = request.getQueryString();
					if (dd == null) {
						out.println("<center ><font size='2'>Please select the dates to display the report.</font></center>");
	                    } else {
						data1 = request.getParameter("data");
						data2 = request.getParameter("data1");

						user = session.getAttribute("usertypevaluemain").toString();
						final String typeOfUser = session.getAttribute("TypeofUser")
								.toString();
						//System.out.println(typeOfUser);
				%>
				
				<form id="MonthlyOdometerReport" name="MonthlyOdometerReport" action="" method="post" >
			    <div id="table1">
				<table class="stats" border="0" width="100%" bgcolor="white">
				<tr>
					<th colspan="13"><font size="3">Odometer Report for <%=uservalue%>
					transporters from <%
						java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy")
									.parse(data1);
							Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
							showdate = formatter2.format(ShowDate);
							out.print(showdate);
					%> to <%
						java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy")
									.parse(data2);
							Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
							showdate1 = formatter1.format(ShowDate1);
							out.print(showdate1);
							
					String exportFileName=session.getAttribute("user").toString()+"_MonthlyOdometerReport.xls";
					%>. </font>
					<div align="right">
					<div align="right"><!--<a href="#" onclick="javascript:window.open('printtrip_report.jsp?userval=< %=user%>&data=< %=data1%>&data1=< %=data2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>-->&nbsp;
					&nbsp; 
					<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
					<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
					
					<input type="hidden" name="date1" id="date1" value="<%=data1%>" />
					<input type="hidden" name="date2" id="date2" value="<%=data2%>" />
					 
					
					<input type="button" value="Hide Avg" onclick="hide();" class="formElement" id="tdx" name="tdx" style="border: thin;border-style: solid;display: none;">&nbsp;&nbsp;
					<input type="button" value="Show Avg" onclick="show();" class="formElement" id="tds" name="tds" style="border: thin;border-style: solid;">		
      
					<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
					<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
							      
					<a href="#" style="font-weight: bold; color: black; " onclick="ShowHide('date1','date2')">
					<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>Date
					: <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 		String sdt = fmt.format(new java.util.Date());
 		out.print(sdt);
 %>
					</div>
					</div>
					</th>
					</tr></table>
					<table width="100%" border="1" align="center" class="sortable">
					<tr>

						<!--<td class="hed"><div class="bodyText"><b>Driver</b></div></td>-->
						<td class="hed">
						<div class="bodyText"><b>Sr No.</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Vehicle</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>User</b></div>
						</td>
                        <td class="hed">
						<div class="bodyText"><b>Transporter</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>RSM Name</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Odo Count</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Odo Km.</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>GPS Km</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Difference</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Fuel Added</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Total GPS Km</b></div>
						</td>
						
						
						<td class="hed" id="1" style="width: 30px;display: none;">
						<div class="bodyText"><b>Full tank >1</b></div>
						</td>
						<td class="hed" id="2" style="width: 30px;display: none;">
						<div class="bodyText"><b>Odo Avg</b></div>
						</td>
						<td class="hed" id="3" style="width: 30px;display: none;">
						<div class="bodyText"><b>gps Avg</b></div>
						</td>
						<td class="hed" id="4" style="width: 30px;display: none;">
						<div class="bodyText"><b>Manager</b></div>
						</td>
						
					</tr>
					<%System.out.println("hiiiiihihihi---->");
						int i = 1;
					int count=0;
					int totalCount=0;
							String vehregno = "";
							String trans = "";
							String sql11 = "";
							String employeeName="";
							String employeeCode="";
							String vehicleCode="";
							String totalfuel1="",RSMName="-",Manager="-";
							DecimalFormat df = new DecimalFormat("#.##");
							NumberFormat nf = NumberFormat.getNumberInstance();
							nf.setMaximumFractionDigits(2) ;
							try {

								Class.forName(MM_dbConn_DRIVER);
								conn = DriverManager.getConnection(MM_dbConn_STRING,
										MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
								
								conn1 = fleetview.ReturnConnection1();

								st = conn.createStatement();
								st0 = conn.createStatement();
								st11 = conn.createStatement();
								st1 = conn.createStatement();
								st4 = conn.createStatement();
								st5 = conn.createStatement();
								st6 = conn.createStatement();
								st7 = conn.createStatement();
								stRSM = conn.createStatement();
								stRSM1 = conn.createStatement();
								stRSM2 = conn.createStatement();
								int ododiff = 0;
								double gpsdiff =0,totaldistanceBetweenSelectedDates=0;
								boolean flagFirst=true;
								boolean flag=true;
								System.out.println("hiiiiihihihi---->11112");
							/*	if ("GROUP".equalsIgnoreCase(typeOfUser)) {
									sql11 = "select DISTINCT(VehCode),transporter,VehRegNo from t_group where GPName='"
											+ session.getAttribute("usertypevalue")
													.toString() + "'  and VehCode in "+session.getAttribute("VehList").toString()+"";

								}

								else { */
									sql11 = "select DISTINCT(VehicleCode),VehicleRegNumber from db_gps.t_vehicledetails where  VehicleCode in "+session.getAttribute("VehList").toString()+"";
							
							//	}
								System.out.println("hiiiiihihihi----query>"+sql11);
								ResultSet rst11 = st11.executeQuery(sql11);
								while (rst11.next()) {
									//System.out.println("hiiiiihihihi---->332");
								/*	if ("GROUP".equalsIgnoreCase(typeOfUser)) {
										//System.out.println("inside if>>>> ");
										trans = rst11.getString("VehRegNo");
										vehregno = rst11.getString("transporter");
										//System.out.println(trans+"--"+vehregno);
										vehicleCode = rst11.getString("VehCode");
									} else {*/
										//System.out.println("inside else >>>>>");
										vehregno = rst11.getString("VehicleRegNumber");
										trans = session.getAttribute("usertypevalue").toString();
										vehicleCode = rst11.getString("VehicleCode");
									//}
									totalfuel=0;
									ododiff = 0;
									gpsdiff = 0;
									gpsdiff1 = 0;
									odofirst = 0;
									gpsfirst = 0;
									gpsfirst1 = 0;
									odolast = 0;
									gpslast = 0;
									gpslast1 = 0;
									odoavg=0;
									gpsavg=0;
									totalfuel1="";
									odoFirstDateTime="";
									odoLastDateTime="";
									employeeName="";
									employeeCode="";
									flagFirst=true;
									flag=true;
									count=0;
									totaldistanceBetweenSelectedDates=0;
									String query="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
									ResultSet rs=st.executeQuery(query);
									if(rs.next()){
										employeeName=rs.getString("Empname");
										//employeeCode=rs.getString("Empcode");
									}
									
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime,count(*) AS entries from t_fuelinfo where VehNo='"
										+ vehregno
										+ "' and TheDateTime  between '"
										+ fromdate
										+ " 00:00:00' and '"
										+ todate
										+ " 23:59:59' order by thedatetime";
									ResultSet rstlast = st.executeQuery(sql);
									if(rstlast.next()){
										count = rstlast.getInt("entries");
										totalCount=totalCount+count;
									}
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime from t_fuelinfo where VehNo='"
											+ vehregno
											+ "' and TheDateTime  >= '"+ fromdate+ " 00:00:00' and '"+ todate+ " 23:59:59' AND Odometer IS NOT NULL AND Odometer <> '' AND Odometer <> ' '  AND Odometer <> '-' order by thedatetime ASC LIMIT 1";
									//System.out.println("Query---->" + sql);
									ResultSet rst = st0.executeQuery(sql);
									if(rst.next()){
										odofirst = rst.getInt("Odometer");
										odoFirstDateTime=rst.getString("TheDateTime");
										//System.out.println("odoFirstDateTime=" + odoFirstDateTime+"----odofirst"+odofirst);
										flagFirst=false;
									}
									/*******************************************************/
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime from t_fuelinfo where VehNo='"
										+ vehregno
										+ "' and TheDateTime  >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59' AND Odometer IS NOT NULL AND Odometer <> ''   AND Odometer <> ' ' AND Odometer <> '-'  order by thedatetime DESC LIMIT 1";
									ResultSet rst1 = st0.executeQuery(sql);
								
									if(rst1.next()){
										odolast = rst1.getInt("Odometer");
										odoLastDateTime=rst1.getString("TheDateTime");
										//System.out.println("odoLastDateTime=" + odoLastDateTime+"----odolast"+odolast);
										flagFirst=false;
										
										String sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+odoFirstDateTime+"' AND '"+odoLastDateTime+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"ASC LIMIT 1";
									//	System.out.println("first rec gps==>"+sqlGps);
										ResultSet rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpsfirst = rstgps1.getDouble("Distance");
										}
										
										sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+odoFirstDateTime+"' AND '"+odoLastDateTime+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"DESC LIMIT 1";
									//	System.out.println("last rec gps==>"+sqlGps);
										rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpslast = rstgps1.getDouble("Distance");
										}
									}
									
									ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(vehicleCode,fromdate,todate);
									if(rstcounts.next())
									{
										totaldistanceBetweenSelectedDates = rstcounts.getDouble(5);
									}
									
			////////////////////////////////////////////////////////////////////////////////////////////////////						
									if(count>1){
									ododiff = odolast - odofirst;
									gpsdiff = gpslast - gpsfirst;
									}
									else{
										ododiff =0;
										gpsdiff=0;
									}
									//System.out.println("diff===>" + ododiff);
									if(ododiff==0){
										gpsdiff=0;
									}
								//	System.out.println("\n\n The vehicle code is:"+vehicleCode);
									String eny="select FirstName,LastName from db_gps.t_userdetails where HODID <>'-' AND SrNo=(select HODID from db_gps.t_userdetails where HODID <>'-' AND SrNo=(select HODID from db_gps.t_userdetails where HODID <>'-' AND Vehid='"+vehicleCode+"' limit 1))";									
									ResultSet rste=st1.executeQuery(eny);
								//	System.out.println("\n\n username query-->>"+eny);
									if(rste.next())
									{
									//	System.out.println("\n\n in if");
										String First=rste.getString("FirstName");
										String Last=rste.getString("LastName");
										String FullName = First+" "+Last;
										RSMName=FullName;
										//System.out.println("\n\n name of Hod's HOD id-->>"+FullName);
										
										
										
									}else
										{
										RSMName="-";
										}
									
							//***********************************************for manager		
									String eny1="select FirstName,LastName from db_gps.t_userdetails where HODID <>'-' AND SrNo=(select HODID from db_gps.t_userdetails where HODID <>'-' AND Vehid='"+vehicleCode+"' limit 1)";									
									ResultSet rste1=st1.executeQuery(eny1);
								//	System.out.println("\n\n username query1-->>"+eny1);
									if(rste1.next())
									{
										//System.out.println("\n\n in if2");
										String First=rste1.getString("FirstName");
										String Last=rste1.getString("LastName");
										String FullName = First+" "+Last;
										Manager=FullName;
									//	System.out.println("\n\n name of manager-->>"+Manager);
										
										
										
									}else
										{
										Manager="-";
									//	System.out.println("The name of manager is :"+Manager);
										}
									
									
									
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++						
									
									String fuelInfoQuery="SELECT Litres FROM db_gps.t_fuelinfo WHERE vehno='"+vehregno+"' and" +
									"   TheDateTime >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59'" +
									"	ORDER BY Thedatetime desc";
								//	System.out.println("\n\n fuel query-->>"+fuelInfoQuery);
									ResultSet rstfuel=st1.executeQuery(fuelInfoQuery);
									while(rstfuel.next())
									{
										String fueltot=rstfuel.getString("Litres");
										if(fueltot.equals(""))
										{}else
										{
										totalfuel=totalfuel+Float.parseFloat(fueltot);
									 //   System.out.println("total fuel decimal-->>"+totalfuel);
										totalfuel1=nf.format(totalfuel);
										//System.out.println("after total fuel decimal-->>"+totalfuel1);

										
										
										}
								
									}
									
									// for full tank logic
									
									int fullcount=0;
									int fullcounta=0;
									float lastfuel=0,prvfuel=0,lastOdo=0,prvOdo=0,infuel=0;
									float lastfuel1=0,prvfuel1=0,lastOdo1=0,prvOdo1=0;
									float finalfuel=0,finalOdo=0;
									fulltank="No";
									String lastfull="",lastodo="",prvfull="",prvodo="",timefrom="",timeto="",infuelstr="";
									
								//	System.out.println("\n\n full count-->>"+fullcount);
									String fulltankquery="select *  from db_gps.t_fuelinfo where vehno='"+vehregno+"' and FullTank='Yes' AND TheDateTime >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59' order by TheDateTime desc";
								//	System.out.println("\n\n full count query-->>"+fulltankquery);
									ResultSet fullrs=st5.executeQuery(fulltankquery);
								    if(fullrs.next())
									{
										fullcount++;
										lastfull=fullrs.getString("Litres");
										lastodo=fullrs.getString("Odometer");
										timefrom=fullrs.getString("TheDateTime");
										if(timefrom==null || timefrom.equals("") || timefrom.equals(" "))
										{
											timefrom=todate+" 23:59:59";
										}
										
										if(lastfull.equals(""))
										{}else
											{										
											lastfuel=Float.parseFloat(lastfull);
											}
										 if(lastodo.equals("") || lastodo.equals("-"))
										{}else
											{										
											lastOdo=Float.parseFloat(lastodo);
											}
							
										
										
									
										//System.out.println("last liters-->>"+lastfull);
										//System.out.println("last Odo-->>"+lastodo);
									}
									while(fullrs.next())
									{
										fullcount++;
										prvfull=fullrs.getString("Litres");
										prvodo=fullrs.getString("Odometer");
									//	System.out.println("prv liters-->>"+fullrs.getString("Litres"));
									//	System.out.println("prv Odo-->>"+fullrs.getString("Odometer"));
							            timeto=fullrs.getString("TheDateTime");
							            if(timeto==null || timeto.equals("") || timeto.equals(" "))
										{
							            	timeto=fromdate+" 00:00:00";
										}
							            if(prvfull.equals(""))
										{}else
											{										
										        prvfuel=Float.parseFloat(prvfull);
											}
										 if(prvodo.equals(""))
										{}else
											{										
												prvOdo=Float.parseFloat(prvodo);
											}
							
									
										//System.out.println("prv liters-->>"+prvfull);
										//System.out.println("prv Odo-->>"+prvodo);
							
									
										
									}
									if(fullcount==1)
									{
									   String fulltankquery1="select * from db_gps.t_fuelinfo where vehno='"+vehregno+"' and FullTank='Yes' AND TheDateTime < '"+ fromdate+ " 00:00:00' order by TheDateTime desc";
									//   System.out.println("\n\n full count query back-->>"+fulltankquery1);
									   ResultSet fullrs1=st6.executeQuery(fulltankquery1);
									   try
										{
									   if(fullrs1.next())
									   {
										fullcounta++;
										
										prvfull=fullrs1.getString("Litres");
										prvodo=fullrs1.getString("Odometer");
										 timeto=fullrs1.getString("TheDateTime");
											//System.out.println("prv liters-->>"+fullrs1.getString("Litres"));
											//System.out.println("prv Odo-->>"+prvodo);
										
										 if(prvfull=="" || (prvfull== null) || prvfull==" " || prvfull.equals("") || prvfull.equals("null") || prvfull.equals(" "))
										{}else 
											{	
										//	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$->>"+prvfull);
										//	System.out.print("<<->>"+prvfull);
										        prvfuel=Float.parseFloat(prvfull);
											}
										 if(prvodo.equals(""))
										{}else
											{										
												prvOdo=Float.parseFloat(prvodo);
											}
							
										   
										
									
									
										
									   }
									   else
										   fullcounta=0;
										}
										catch(Exception e)
										{
											e.printStackTrace();
										}
									 }
									   
								
									
									
								//	System.out.println("\n\n full count-->>"+fullcount);
								//	System.out.println("\n\n full count back-->>"+fullcounta);
									if(fullcount>1 || fullcounta>0)
									{
										fulltank="Yes";
									// now calculate fuel consume....
									 String infuelquery="select * from db_gps.t_fuelinfo where vehno='"+vehregno+"'  AND TheDateTime > '"+timeto+"' and TheDateTime  < '"+timefrom+"' order by TheDateTime desc";
								//	 System.out.println("in No full query-->>"+infuelquery);
									 ResultSet infl=st7.executeQuery(infuelquery);	
										while(infl.next())
										{
											
											infuelstr=infl.getString("Litres");
											if(infuelstr.equals(""))
											{}else
																	
											   infuel=infuel+Float.parseFloat(infuelstr);
											
										}
										
										prvfuel=prvfuel+infuel;
										
										  finalfuel=prvfuel;
									
										
										  finalOdo=lastOdo-prvOdo;
										
									//	System.out.println("\n\n fuel consume-->>"+finalfuel);
									//	System.out.println("\n\n odometer count -->>"+finalOdo);
									
										
										// calculate gps km ..
										
										
										String sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+timeto+"' AND '"+timefrom+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"ASC LIMIT 1";
									//	System.out.println("first rec gps query==>"+sqlGps);
										ResultSet rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpsfirst1 = rstgps1.getDouble("Distance");
										}
										
										sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+timeto+"' AND '"+timefrom+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"DESC LIMIT 1";
									//	System.out.println("last rec gps query==>"+sqlGps);
										rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpslast1 = rstgps1.getDouble("Distance");
										}
										
										if(gpslast1>gpsfirst1)
										{
											gpsdiff1=gpslast1-gpsfirst1;
										//	System.out.println("gps in if diff==>"+gpsdiff1);
										}
										else
										{
											gpsdiff1=gpsfirst1-gpslast1;
										//	System.out.println("gps diff in else==>"+gpsdiff1);
										}
										
										if(finalfuel>0)
										{
											odoavg=(finalOdo/finalfuel);
											gpsavg=(gpsdiff1/finalfuel);
										//	System.out.println("avg odo==>"+odoavg);
										//	System.out.println("gps avg==>"+gpsavg);
										}
										
										
									}
									
									
									
					%>
					<tr>

						<td class="bodyText">
						<div align="right"><%=i++%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=vehregno%></div>
						</td>
						
						<td class="bodyText" >
						<div align="left"><%=employeeName%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=trans%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=RSMName%></div>
						</td>
						<%						if(count!=0)
						{ 
%>
						<td class="bodyText">
					<!--  	<div align="right"><a href="odometerEntries.jsp?vehcode=<%=vehicleCode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&ownername=<%=trans%>&vehregnumber=<%=vehregno%>&employeeName=<%=employeeName%>"><%=count%></a></div>
						-->
						<div align="right"><a
							href="detail_odomter_transporter.jsp?data1=<%=fromdate%>&data2=<%=todate%>&Oname=<%=trans%>&odometer=<%=ododiff%>&vehregno=<%=vehregno%>&vehicleCode=<%=vehicleCode%>&employeeName=<%=employeeName%>"><%=count%></a></div>
					
						</td>
						<%}
						else{ 
%>
						<td class="bodyText"><div align="right"><%=count%></div></td>
<%
						} 
%>
<%
				if(ododiff!=0){
%>
						<td class="bodyText">
						<div align="right"><a
							href="detail_odomter_transporter.jsp?data1=<%=fromdate%>&data2=<%=todate%>&Oname=<%=trans%>&odometer=<%=ododiff%>&vehregno=<%=vehregno%>&vehicleCode=<%=vehicleCode%>&employeeName=<%=employeeName%>"><%=ododiff%></a></div>
						</td>
<%
				}
				else{
%>
					<td class="bodyText">
						<div align="right"><%=ododiff%></div>
						</td>
<%
				}
%>
						<td class="bodyText">
						<div align="right"><%=Double.valueOf(gpsdiff).intValue()%></div>
						</td>
						<td class="bodyText">
						<%
						int odomdiff=ododiff;
						int gps1diff = Double.valueOf(gpsdiff).intValue();
						int diff=0;
						diff= odomdiff - gps1diff;
						String diffstr= "";
						diffstr = ""+diff;
						if(diffstr.startsWith("-")){
							diffstr = diffstr.replace("-","");
						}
						%>
						<div align="right"><%=diffstr%></div>
						</td>
						<%						if(totalfuel!=0)
						{ //custfuelfillreport.jsp?vehicleRegistrationNumber=MH+11+Y+5465&data=03-Jan-2012&data1=03-Feb-2012&submit=submit
                          String datefrom=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
                          String dateto=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
%>
						<td class="bodyText">
						<div align="right"><a href="custfuelfillreport.jsp?vehicleRegistrationNumber=<%=vehregno%>&data=<%=datefrom%>&data1=<%=dateto%>"><%=totalfuel1%></a></div>
						</td>
						<%}
						else{ 
%>
						<td class="bodyText"><div align="right">0.00</div></td>
<%
						} 
%>
						
						<td class="bodyText">
						<div align="right"><%=Double.valueOf(totaldistanceBetweenSelectedDates).intValue()%></div>
						</td>
						
						<input type ="hidden" name="fullcount" id ="fullcount<%=i-1 %>" value="<%=fullcount%>"></input>
					<input type ="hidden" name="fullcounta" id ="fullcounta<%=i-1 %>" value="<%=fullcounta%>"></input>
						
						<%
						
						if(fullcount>1 || fullcounta>0)
						{
							String odoavgdis="",gpsavgdis="";
							
							odoavgdis=df.format(odoavg);
							gpsavgdis=df.format(gpsavg);
						
						%><%//System.out.println("tda is :"+(i-1)); %>
						<td class="bodyText" id="tda<%=i-1%>" style="display: none;">
						<div align ="right"></div><a href="fuelfulltankreport.jsp?vehcode=<%=vehicleCode%>&fromdate=<%=timeto%>&todate=<%=timefrom%>&ownername=<%=trans%>&vehregnumber=<%=vehregno%>&firstodo=<%=prvOdo%>&lastodo=<%=lastOdo%>&firstgps=<%=gpsfirst1%>&lastgps=<%=gpslast1%>&firstfuel=<%=prvfuel%>&lastfuel=<%=lastfuel%>&betweenfuel=<%=infuel%>&finalgps=<%=gpsdiff1%>&finalfuel=<%=finalfuel%>&finalodo=<%=finalOdo%>&odoavg=<%=odoavg%>&gpsavg=<%=gpsavg%>"><%=fulltank%></a>
						
						</td>
						<td class="bodyText" id="tdb<%=i-1%>" style="display: none;">
						<div align="right"><%=odoavgdis%></div>
						</td>
						<td class="bodyText" id="tdc<%=i-1%>" style="display: none;">
						<div align="right"><%=gpsavgdis%></div>
						</td>
						<%}
						else
						{%>
						<%//System.out.println("tdp is :"+(i-1)); %>
						<td class="bodyText" id="tdp<%=i-1%>" style="width: 30px;display: none;">
						<div align="left"><%=fulltank%></div>
						</td>
						<td class="bodyText" id="tdq<%=i-1%>" style="width: 30px;display: none;">
						<div align="left">NA</div>
						</td>
						<td class="bodyText" id="tdr<%=i-1%>" style="width: 30px;display: none;">
						<div align="left">NA</div>
						</td>						
						<%} %>
						
						
						<td class="bodyText" id="manager<%=i-1%>" style="width: 30px;display: none;">
						<div align="left"><%=Manager%></div>
						
					</tr>
					
					
					<%
				//	System.out.println("fullcount is :"+fullcount);
				//	System.out.println("fullcounta is :"+fullcounta);
						} //end of rst while

								//}//group

								
							} catch (Exception e) {
								System.out.println("Exception-->" + e);
							}
							finally{
								try{
									st.close();
									st0.close();
									st1.close();
									st11.close();
									conn.close();
								}
								catch(Exception e){
									e.printStackTrace();
								}
								try{
									conn1.close();
								}
								catch(Exception ee){
									ee.printStackTrace();
								}
							}
							%>	<input type="hidden" name= "cnt" id="cnt" value=<%=i-1%>></input>	<%
							System.out.println("i is "+(i-1));
							
							%>
							</table>
				</div>
				</form>
							<%
						}
					%>
					
				
				<!-- footer start here -->
				<table border="1" width="100%">
					<tr>
						<td bgcolor="white" class="copyright" width="100%">
						<center>Copyright &copy; 2008 by Transworld Compressor
						Technologies Ltd. All Rights Reserved.</center>
						</td>
					</tr>
				</table>
				<P></P>
				
				
				

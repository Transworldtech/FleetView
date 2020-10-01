
<!-- Displayed Header -->
<%@ include file="headernew.jsp"%>

<!-- Database Connection -->
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,	MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	    fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 	%>
 	<!--Global variable declaration  -->
 	<%!
 	
Connection conn=null,conn1=null;
Statement st,st1,st2,st3,st11,st111,st45;
String sql,sql1,sql2, data,data1,trips,ndcount1="",datan,datan1;
String g="",s="",y="",p="",newdata="",newdata1="";
int kmcountall,kmcount,tripcount,drivercount,tripcountall,drivercountall,vehcount,vehcountall,oscount,oscount1,oscountall,oscountall1,racount,racountall,rdcount,rdcountall,cdcount,cdcountall,ndcount,ndcountall,countlatency,latency,durationall,duration,RHcount,RHcountall,stop,stopall,BriefGoalsall,AdhJRMall,DeBriefGoalall,Geocountall;
String startplace,StartCode;
double ratingcount,ratingcountall;
double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
double ss,aa,rr,rt;
NumberFormat nf = DecimalFormat.getNumberInstance();
String geofence ="-";
String BriefGoals="-";
String AdhJRM="-";
String DeBriefGoal="-";
int Geocount=0;

%>
<%
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("transportername"+usertypevalue);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
	if(!(null==request.getQueryString()))
	{
		data=request.getParameter("data");
		data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
		 g=data.concat(" ");
		 s=g.concat("00:00:00");
		System.out.println("values of data appendeddata*****"+s);
		
		data1=request.getParameter("data1");
		data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
        y=data1.concat(" ");
	     p=y.concat("23:59:59");
		System.out.println("values of appendeddata11111@@@@@@"+p);
	}
	else
	{
		data=data1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}
%>
<input type="hidden" id="owner" name="owner" value="<%=usertypevalue%>"></input>
<table class="stats">
<tr><td><font size="3"><b>Key Performance Indicator Report</b></font></td></tr>
<tr><td><div align="center">
</table>

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
					{
						try{
					/* var result1;
					result1=reslt;
					result1=result1.replace(/^\s+|\s+$/g,'');
					if(result1=="Updated") */
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
  			 	return true;
  		  }
 			
 			function birt(){
 	  			
 	  			//alert("Hi");
 	  			
 	  			//var date1= document.getElementById("date3").value;
 	  			//alert(document.getElementById("data").value);
 	  			//alert(document.getElementById("data1").value);
 	  			var a=validate();
			//alert("GetValidate------->"+a);
			if(a==true)
				{
 	  		
 	  			var fromDateTime1= document.getElementById("data").value;
 	  			
 	  			//alert("datebefore"+fromDateTime);
 	  			
 	  			var newdate = fromDateTime1.split("-").reverse().join("-"); 
 	  			var date = fromDateTime1.split("-");
 	  			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
 	  			for(var j=0;j<months.length;j++){
 	  			    if(date[1]==months[j]){
 	  			         date[1]=months.indexOf(months[j])+1;
 	  			     }                      
 	  			} 
 	  			if(date[1]<10){
 	  			    date[1]='0'+date[1];
 	  			}                        
 	  			var fromDateTime = date[2]+"-"+date[1]+"-"+date[0];
 	  			//alert("datebefore"+fromDateTime);
 	  			
 	  			//data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDateTime));
 	  			//var fromDateTime= document.getElementById("datann").value;
 	  			
 	  			/* var fromDateTime= data; */
 	  			//alert("dateafter----==>>"+fromDateTime);
 	  			//var date2= document.getElementById("date4").value;
 	  			var toDateTime1= document.getElementById("data1").value;
 	  			//alert("dateafter--->"+toDateTime);
 	  			var newdate1 = toDateTime1.split("-").reverse().join("-"); 
 	  			var date1 = toDateTime1.split("-");
 	  			var months1 = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
 	  			for(var j=0;j<months1.length;j++){
 	  			    if(date1[1]==months1[j]){
 	  			         date1[1]=months1.indexOf(months1[j])+1;
 	  			     }                      
 	  			} 
 	  			if(date1[1]<10){
 	  			    date1[1]='0'+date1[1];
 	  			}                        
 	  			var toDateTime = date1[2]+"-"+date1[1]+"-"+date1[0];
 	  			//alert("date"+toDateTime);
 	  			var owner=document.getElementById("owner").value;
 	  			//alert("own"+owner);
 	  			
 	  			
 	  			
 	  			
 	  		//	alert(vehicle);
 	  		//	alert(fromDateTime);
 	  		//	alert(toDateTime);
 	  		//	alert(owner);
 	  		//	alert(location1);
 	  		//	alert(routeid1);
 	  		//	alert(status);
 	  		//	alert(warehousecode1);
 	  			
 	  		//	alert(vehicle);
 	  		//	alert(date1);
 	  		//	alert(date2);

 	  			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=SensorDetailReport.rptdesign&vehicle="+vehicle+"&date1="+date1+"&date2="+date2+"&__showtitle=false";
 	  			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=geofence_report.rptdesign&vehicle="+vehicle+"&fromDateTime="+fromDateTime+"&toDateTime="+toDateTime+"&owner="+owner+"&location1="+location1+"&status="+status+"&routeid1="+routeid1+"&warehousecode1="+warehousecode1+"&trans="+trans+"&sort="+sort+"&__showtitle=false";
// 	  			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
 	  			document.getElementById("myIframe").src="http://myfleetview.com:8080/birttest/frameset?__report=KPIReport.rptdesign&dt="+fromDateTime+"&dt1="+toDateTime+"&OwnerName="+owner+"&GPName="+owner+"&date="+fromDateTime1+"&date1="+toDateTime1+"&__showtitle=false";
 	  			document.getElementById("reportData").style.display="";
 	  			document.getElementById("footer").style.display="none";
 	  		//	alert("after frame");
 	  			return true;
				}
			else
				{
					return false;
				}
 	  		}
 			
 			<%!
 			String datex1, datex2, dat1, dat2;
 		%>
 		<%
 		String owner=session.getAttribute("usertypevalue").toString();
 			String ddx = request.getQueryString();
 				
 				if (ddx == null) {
 					datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
 							.format(new java.util.Date());
 					dat1 = dat2 = new SimpleDateFormat("yyyy-MM-dd")
 							.format(new java.util.Date());
 				
 					Calendar c = Calendar.getInstance();   // this takes current date
 				    c.set(Calendar.DAY_OF_MONTH, 1);
 				    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
 				    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
 				
 				
 				} else {
 					dat1 = new SimpleDateFormat("yyyy-MM-dd")
 							.format(new SimpleDateFormat("dd-MMM-yyyy")
 									.parse(request.getParameter("data")));
 					dat2 = new SimpleDateFormat("yyyy-MM-dd")
 							.format(new SimpleDateFormat("dd-MMM-yyyy")
 									.parse(request.getParameter("data1")));

 					datex1 = request.getParameter("data");
 					datex2 = request.getParameter("data1");
 				}

 		System.out.println(" datex1 "+datex1+" datex2 "+datex2);
 		String dt = new SimpleDateFormat("yyyy-MM-dd")
 		.format(new SimpleDateFormat("dd-MMM-yyyy")
 				.parse(datex1));
 		
 		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
 		.format(new SimpleDateFormat("dd-MMM-yyyy")
 				.parse(datex2));
 		 	
 		%>

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
			var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
			dy1=date1.substring(0,2);
			dy2=date2.substring(0,2);
			dm1=date1.substring(3,6);
			dm2=date2.substring(3,6);

			dm11=dateformat(dm1);
			dm22=dateformat(dm2);	
			dd1=date1.substring(7,11);
			dd2=date2.substring(7,11);
			var date=new Date();
			var month=date.getMonth()+1;
			//var month1=date2.getMonth();
			var day=date.getDate();
			var year=date.getFullYear();
			
			//alert("dy1="+dy1+" dy2="+dy2+" dm1="+dm1+" dm2="+dm1+" dm11="+dm11+" dm22="+dm22+" dd1="+dd1+" dd2="+dd1+" month="+month+" day="+day+" year="+year);
			
			
			if(dd1>dd2)
			{  
				
				
				
				alert("From date should not be greater than to date");
				//document.getElementById("data").value="";
				//document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
				
			}
			
			else if(year==dd1 && year==dd2) 
				if(dm11>dm22)
			{
				
				alert("From date should not be greater than to date");
				//document.getElementById("data").value="";
				//document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dd1==dd2){
				if(dm11>dm22)
				{
								alert("From date should not be greater than to date");
								//document.getElementById("data").value="";
								//document.getElementById("data1").value="";
								document.getElementById("data").focus;
								return false;
				}
				}
			
			 if(dm1==dm2 && dd1==dd2) {
			if(dy1 > dy2)
			{
				alert("From date should not be greater than to date");
				//document.getElementById("data").value="";
				//document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			return true;
		}

  	</script>
  	<div style="margin-left: 25%;">
  	<table border="0"  width=600  align="center">
			<!-- <form action="" method="get" onsubmit="return validate();"> -->
			<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  
			<br></br>
			<tr>
			<td>
			<%
			if(!(null==request.getQueryString()))
			{
				data=request.getParameter("data");
				data1=request.getParameter("data1");
			}
			else
			{
				
			data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data));
			//out.println("data:-"+data);
			data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));
			//out.println("data1:-"+data1);
				
			}
			%><b>From&nbsp;&nbsp;</b>
			  <input type="text" id="data" name="data"  value="<%=data%>" size="10" readonly/>
			  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
<!--  			<td align="left">-->
<!--				<input type="button" name="From Date" value="From Date" id="trigger" >-->
<!--				-->
<!--			</td>-->
			<td><b>To&nbsp;&nbsp;</b>
			  	<input type="text" id="data1" name="data1"   value="<%=data1%>" size="10" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
<!--			  	<td align="left">-->
<!--  			  	<input type="button" name="To Date" value="To Date" id="trigger1" >-->
<!--				-->
<!--			</td>-->
			<td>
				<input type="submit" name="submit" id="submit" onclick="birt();" value="submit" >
			</td>
		</tr>
		<!-- </form> -->
		</table>
		</div>
		<!-- if date range is not requred please remove this code start from this comment to -->

<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=KPIReport.rptdesign&dt=<%=dat1%>&dt1=<%=dat2%>&OwnerName=<%=owner%>&GPName=<%=owner%>&date=<%=datex2%>&date1=<%=datex2%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 

 </div>
  <%
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
	%>
	
<div id="reportData" style="display:none;">
<iframe id="myIframe" width="100%" height="850px" src=""> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> -->
</iframe> 

</div>
<%
		}
%>
<br></br>
<%
try{
	

	//Class.forName(MM_dbConn_DRIVER);
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn.createStatement();
	st11=conn.createStatement();
	st111=conn.createStatement();
	st45=conn.createStatement();
if(!(null==request.getQueryString()))
{
%>
<%-- <table border="0" width="100%" align="center" class="sortable">
<tr><td>
<font size="2"><b>Key Performance Indicator Report from <%=data%> to <%=data1%></b></font>
              <!--code for export to excel and print  -->
<div align="right">
				<a href="#" onclick="javascript:window.open('print_KPIReport.jsp?data=<%=data%>&data1=<%=data1%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="Excel_KPIReport.jsp?data=<%=data%>&data1=<%=data1%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
</td></tr>
</table>

	

	

	

	
	
	<table width="100%" border="1" align="center" class="sortable">
		<!-- Get The Data From the Database and show it -->
		<tr>
			<th rowspan="2"> Sr.</th>
			<th rowspan="2"> Origin</th>
			<th rowspan="2"> Loaded Trips</th>
			<th rowspan="2"> Completed Trips</th>
			<th rowspan="2"> Brief Trips</th>		
			<th rowspan="2"> Not Brief Trips</th>
			<th rowspan="2"> DeBrief Trips</th>		
			<th rowspan="2"> Not DeBrief Trips</th>
			<th rowspan="2"> Km. Travelled</th>
			<th rowspan="2"> Drivers</th>
			<th rowspan="2"> Veh.</th>
			<th colspan="4"> Process Violations</th>
			<th colspan="2"> Policy Violations</th>
			<th rowspan="2"> Rating</th>
			<th rowspan="2"> RH Violation</th>
			<th rowspan="2"> Stops</th>
			<th rowspan="2"> Goals To Be Achieved</th>
			<th rowspan="2"> Geofence</th>
			
			<th rowspan="2"> Adherance to JRM</th>
			<th rowspan="2"> Goals achieved</th>
			
		</tr>
		<tr>
			<th></th>
			<th></th>
				<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th> OS Dur<br>(Sec)</br></th>
			<th>OS Count</th>
			<th> RA</th>
			<th> RD</th>
			<th> CD</th>
			<th> ND</th>
			
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			
			</tr> --%>
			<%
					datan=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
					datan1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
					
			%>
			<input type="hidden" id="datann" name="datann" value="<%=datan%>"></input>
           <input type="hidden" id="datann1" name="datann1" value=<%=datan1%>"></input>
			
			<% 
					
			int i=1;			
			kmcountall=0;
			tripcountall=0;
			drivercountall=0;
			ratingcountall=0.0;
			vehcountall=0;
			oscountall=0;
			oscountall1=0;
			racountall=0;
			rdcountall=0;
			cdcountall=0;
			ndcountall=0;
			countlatency=0;
			durationall=0;
			stopall=0;
			BriefGoalsall=0;
			AdhJRMall=0;
			DeBriefGoalall=0;
			Geocountall=0;
			Geocount=0;
			int j=0;
			kmcount=0;
			tripcount=0;
			drivercount=0;
			ratingcount=0.0;
			vehcount=0;
			oscount=0;
			oscount1=0;
			racount=0;
			rdcount=0;
			cdcount=0;
			ndcount=0;
			RHcount=0;
			latency=0;
			duration=0;
			stop=0;
			startplace="-";
			StartCode="-";
			int BriTripCount=0,DeBriTripCount=0,Loadedtrips=0,LoadedtripsAll=0;
			int BriTripCountAll=0,DeBriTripCountAll=0;
			String trips="";
			
			    ndcount1=request.getParameter("ndcount");
			    try{
		 	sql="select  sum(a.KmTravelled) as KmTravelled,sum(a.OSDuration) as OS,sum(a.OSCount) as oscount,sum(a.RACount) as RA,sum(a.RDCount) as RD,count(distinct(a.TripID)) as Trips,count(distinct(a.DriverID)) as Driver,count(distinct(a.VehRegNo)) as VehRegNo,a.StartPlace as startlocation, a.StartCode as startlocationcode,sum(a.NDCount) as ND,sum(a.runhrvio)as rhvio,sum(a.stoppagecount) as stops,sum(a.crcount) as cd,count(b.goalstobeachieved) as goals,count(c.adhjrm) as jrm,count(c.GoalsAchived) as goalachieved from db_gps.t_completedjourney as a left outer join db_gps.t_briefing as b on a.tripid=b.tripid left outer join db_gps.t_debriefing as c on b.tripid=c.tripid where a.StartDate>='"+s+"' and a.StartDate<='"+p+"' and (a.OwnerName LIKE '"+usertypevalue+"' OR a.GPName LIKE '"+usertypevalue+"') Group by a.StartPlace";
				ResultSet rstkm=st1.executeQuery(sql);
				System.out.println("nddddddddddddddd" +sql);
			    while(rstkm.next())
				{
					
				//String sql31="select a.tripid as tripid from db_gps.t_briefing a inner join db_gps.t_completedjourney b on a.tripid=b.tripid and  a.Driverid=b.DriverID where b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					
					BriTripCount=0;
					DeBriTripCount=0;
					startplace=rstkm.getString("startlocation");//StartPlace
					kmcount=rstkm.getInt("KmTravelled");
					kmcountall=kmcountall+kmcount;
					oscount=rstkm.getInt("OS");
					oscountall=oscountall+oscount;
					racount=rstkm.getInt("RA");
					racountall=racountall+racount;
					rdcount=rstkm.getInt("RD");
					rdcountall=rdcountall+rdcount;
					duration=rstkm.getInt("OS");
					durationall+=rstkm.getInt("OS");
					drivercount=rstkm.getInt("Driver");
					drivercountall=drivercountall+drivercount;
					tripcount=rstkm.getInt("Trips");
					tripcountall=tripcountall+tripcount;
					vehcount=rstkm.getInt("VehRegNo");
					vehcountall=vehcountall+vehcount;
					cdcount=rstkm.getInt("CD");
					cdcountall = cdcountall+cdcount;
					ndcount = rstkm.getInt("ND");
					ndcountall += rstkm.getInt("ND");
					RHcount = rstkm.getInt("rhvio");
					System.out.println("rh violation"+RHcount);
					RHcountall=RHcountall+RHcount;
					System.out.println("rh violation allllll"+RHcountall);
					stop=rstkm.getInt("stops");
					oscount1=rstkm.getInt("oscount");
					oscountall1=oscountall1+oscount1;
					System.out.println("stop violation"+stop);
					stopall+= rstkm.getInt("stops");
					System.out.println("stop violation allll"+stopall);
					BriefGoals=rstkm.getString("goals");
					BriefGoalsall+= rstkm.getInt("goals");
					AdhJRM=rstkm.getString("jrm");
					AdhJRMall+= rstkm.getInt("jrm");
					DeBriefGoal=rstkm.getString("goalachieved");
					DeBriefGoalall+= rstkm.getInt("goalachieved");
					
					String sql99= "Select count(*) As count from db_gps.t_startedjourney where  ConsideredLatLon='shiptocode' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and StartPlace='"+startplace+"'";
			        System.out.println("query for geofence count is"+sql99);
			        ResultSet rs=st45.executeQuery(sql99);
			       // 
			       // Geocount=0;
			        while(rs.next())
			        {
			           Geocount=rs.getInt("count");
			           System.out.println("VALUE OF GEOFENCE COUNT IS"+Geocount);
			           Geocountall=Geocountall+Geocount;
			           System.out.println("VALUE OF GEOFENCE COUNTAll IS"+Geocountall);
			        }
					String sql31="SELECT count(distinct(tripid)) AS tripid FROM db_gps.t_startedjourney WHERE  StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and StartPlace='"+startplace+"'";
					System.out.println(">>>>>>KETKIGAWANDE" +sql31);
					ResultSet rst31=st3.executeQuery(sql31);
					if(rst31.next())
					{Loadedtrips=rst31.getInt("tripid");
					}
			      
					try{
// 					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_briefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and  a.Driverid=b.DriverCode and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_briefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					//String sql3="select count(tripid) as tripid from db_gps.t_briefing where tripid in ("+trips+")";
					System.out.println(">>>>>>KETKI>>>>>>>" +sql3);
					ResultSet rst3=st3.executeQuery(sql3);
					if(rst3.next())
					{BriTripCount=rst3.getInt("tripid");	
					
					}
					}catch(Exception e)
					{
						System.out.println("exception1===>"+e.getMessage());
					}
					
					try{
// 					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_debriefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and  a.Driverid=b.DriverCode and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_debriefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					//String sql3="select count(tripid) as tripid from db_gps.t_debriefing where tripid in ("+trips+")";
					System.out.println(">>>>>>GAWANDE>>>>>>>>>>>" +sql3);
					ResultSet rst3=st3.executeQuery(sql3);
					if(rst3.next())
					{DeBriTripCount=rst3.getInt("tripid");	
					
					}
					}catch(Exception e)
					{
						System.out.println("exception2===>"+e.getMessage());
					}
					LoadedtripsAll=LoadedtripsAll+Loadedtrips;
					DeBriTripCountAll=DeBriTripCountAll+DeBriTripCount;
					BriTripCountAll=BriTripCountAll+BriTripCount;
					System.out.println("@@@@@" +DeBriTripCount);
					System.out.println("@@@@@" +BriTripCount);
					
			%>
					<tr>
			<td style="text-align: right"><%=i%></tdf>
			<td><div align="left">
			
			<a href="#" onclick="javascript:window.open('KPI_report.jsp?startplace=<%=startplace.replace("&","and1")%>&date1=<%=data %>&date2=<%=data1 %>');"><%=startplace%></a>
<%-- 			<a href="#" onclick="javascript:window.open('KPI_report.jsp?startplace=<%=startplace%>&date1=<%=data %>&date2=<%=data1 %>');"><%=startplace%></a> --%>
			</div></td>
			<td><div align="right"><%out.print(Loadedtrips);%></div></td>
			<td><div align="right"><%out.print(tripcount);%></div></td>
			<td><div align="right"><%out.print(BriTripCount);%></div></td>
			<td><div align="right"><%out.print(Loadedtrips-BriTripCount);%></div></td>			
			<td><div align="right"><%out.print(DeBriTripCount);%></div></td>
			<td><div align="right"><%out.print(Loadedtrips-DeBriTripCount);%></div></td>					
			<td><div align="right"><%out.print(kmcount);%></div></td>
			<td><div align="right"><%out.print(drivercount);%></div></td>
			<td><div align="right"><%out.print(vehcount);%>	</div></td>
			<td><div align="right"><%out.print(oscount);%></div></td>
			<td><div align="right"><%out.print(oscount1);%></div></td>
			<td><div align="right"><%out.print(racount);%></div></td>
			<td><div align="right"><%out.print(rdcount);%></div></td>
			
			
			
			<td ><div align="right">
			<%
			System.out.println("Value of startplace is "+startplace);
			sql1="select sum(CRCount) as CD from t_completedjourney where startPlace='"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') limit 1";
			ResultSet rstcd=st11.executeQuery(sql1);
 		//	System.out.println("queryyyyyyyy2222"+sql1);
			if(rstcd.next())
			{
				cdcount=rstcd.getInt("CD");
// 				if(cdcount >0)
// 				{
				
				out.print(cdcount);
				cdcountall=cdcountall+cdcount;
			//	System.out.println("Value of startplace is "+cdcountall);
// 				}
// 				else
// 				{
// 				out.print("No");
// 				}
			}			
			%>
			</div></td>
			<td><div align="right">
			<%
			
			/*sql2="select count(NDCount) as ND from t_completedjourney where startPlace='"+startplace+"' and NDCount>0 and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') limit 1";
			ResultSet rstnd=st111.executeQuery(sql2);
			System.out.println("sssssssssssss222222" +sql2);
			if(rstnd.next())
			{
				ndcount=rstnd.getInt("ND");
				if(ndcount >0)
				{
			       ndcountall++;*/
				%>
				<%=ndcount %>
				<%
			//	out.print("Yes");
			/*	}
				else
				{
				out.print("0");
				}
			}		*/	
			%>
			<!-- </div></td>
			
			<td>
			<div align="right"> -->
			<%
				Accelaration1=0;
				Decelaration1=0;
				OverSpeed1=0;
			if(racount > 0 && kmcount > 0)
			{
				Accelaration1=((double)racount/(double)kmcount)*100;
			}
			if(rdcount > 0 && kmcount > 0)
			{
				Decelaration1=((double)rdcount/(double)kmcount)*100;
			}
			if(duration > 0 && kmcount> 0)
			{
				OverSpeed1 =(((double)duration/10)/(double)kmcount)*100;
			}
			ratingcount=Accelaration1+Decelaration1+OverSpeed1;
			ratingcountall=ratingcountall+ratingcount;
			
			if(kmcount > 0)
			{
			out.print(nf.format(ratingcount));	
			}
			else
			{
				out.print("NA");
			}
			
			%>
			<%-- </div></td>
			
			<td><div align="right"><%out.print(RHcount);%></div></td>
			<td><div align="right"><%out.print(stop);%></div></td>
			
			<td><div align="right"><%out.print(BriefGoals);%></div></td>
			<td><div align="right"><%out.print(Geocount);%></div></td>
			<td><div align="right"><%out.print(AdhJRM);%></div></td>
			<td><div align="right"><%out.print(DeBriefGoal);%></div></td>
			</tr> --%>
			<%
			i++;
			}
			}catch(Exception e)
			    {System.out.println("exception3===>"+e.getMessage());
			    	
			    }    
			%>	
			<%-- <tr>
			<td class="hed" colspan="2">Total</td>
			<td class="hed"><div align="right"><%=LoadedtripsAll%></div></td>
			<td class="hed"><div align="right"><%=tripcountall%></div></td>
			<td class="hed"><div align="right"><%=BriTripCountAll%></div></td>
			<td class="hed"><div align="right"><%=LoadedtripsAll-BriTripCountAll%></div></td>
			<td class="hed"><div align="right"><%=DeBriTripCountAll%></div></td>
			<td class="hed"><div align="right"><%=LoadedtripsAll-DeBriTripCountAll%></div></td>
			
			<td class="hed"><div align="right"><%=kmcountall%></div></td>
			<td class="hed"><div align="right"><%=drivercountall%></div></td>
			<td class="hed"><div align="right"><%=vehcountall%></div></td>
			<td class="hed"><div align="right"><%=oscountall%></div></td>
			<td class="hed"><div align="right"><%=oscountall1%></div></td>
			<td class="hed"><div align="right"><%=racountall%></div></td>
			<td class="hed"><div align="right"><%=rdcountall%></div></td>
			<td class="hed"><div align="right"><%=cdcountall%></div></td>
			<td class="hed"><div align="right"><%=ndcountall%></div></td>
			
			 --%>
			<%
				/*if(ndcountall > 0)
				{*/
					%>
<!--					<td class="hed"><div align="right">Yes</div></td>-->
					<%
				/*}
				else`
				{*/
					%>
<!--					<td class="hed"><div align="right">No</div></td>-->
					<%
				//}
			%>
				<!-- 	<td class="hed"><div align="right"> -->
			<%
				
			if(racountall > 0 && kmcountall > 0)
			{
				aa=((double)racountall/(double)kmcountall)*100;
			}	
			if(rdcountall > 0 && kmcountall > 0)
			{
				rr=((double)rdcountall/(double)kmcountall)*100;
			}		
			if(durationall > 0 && kmcountall> 0)
			{
				ss =(((double)durationall/10)/(double)kmcountall)*100;
			}
			rt=aa+rr+ss;
			if(kmcountall > 0)
			{
			out.print(nf.format(rt));
			}
			else
			{
				out.print("NA");
			}
			%><%-- </div></td>
			
			<td class="hed"><div align="right"><%=RHcountall%></div></td>
			<td class="hed"><div align="right"><%=stopall%></div></td>
			<td class="hed"><div align="right"><%=BriefGoalsall%></div></td>
			<td class="hed"><div align="right"><%=Geocountall%></div></td>
			<td class="hed"><div align="right"><%=AdhJRMall%></div></td>
			<td class="hed"><div align="right"><%=DeBriefGoalall%></div></td>
			
			</tr>

	</table> --%>
	<%
}
}catch(Exception ee)
{
	System.out.println("exception4===>"+ee.getMessage());
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{}
	try
	{fleetview.closeConnection();}
	catch(Exception e)
	{}

	
}

%>

	</div>
	</form>

</jsp:useBean>
<!-- footer -->
<%-- <%@ include file="footernew.jsp"%>
 --%>
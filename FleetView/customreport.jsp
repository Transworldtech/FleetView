<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.ExceptionAnalysisReportData"
		import="com.transworld.fleetview.framework.Utilities" %>


<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%><jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

	
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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
};


function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}
function gotoExcel(elemId,frmFldId)
{  	
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.Total_os.action ="excel.jsp";
          document.forms["Total_os"].submit();
}  
function showhide1()
{
	  //alert("In Fun");
	  var counter=document.getElementById("countermore").value;
	  //alert(counter);
	  var tdx=document.getElementById("tdx").value;
	  var ta,tb,tc,td,te,tf,tg,th,ti,tj,tk,tl,taa,tbb,tcc;
	  if(tdx=="More Info")
	  {
	    taa=document.getElementById("taa");
		taa.style.display="";
		tbb=document.getElementById("tbb");
		tbb.style.display="";
		tcc=document.getElementById("tcc");
		tcc.style.display="";
	    for(i=1;i<=counter;i++)
		{	
		    document.getElementById("ta"+i).style.display="";
		    document.getElementById("tb"+i).style.display="";
		    document.getElementById("tc"+i).style.display="";
		    document.getElementById("type").value="More Info";
			document.getElementById("tdx").value="Hide Info";
		}
	  }
	  else
	  {
		  //alert("in else");
		    taa=document.getElementById("taa");
			taa.style.display="none";
			tbb=document.getElementById("tbb");
			tbb.style.display="none";
			tcc=document.getElementById("tcc");
			tcc.style.display="none";
		    for(i=1;i<=counter;i++)
			{	
			    document.getElementById("ta"+i).style.display="none";
			    document.getElementById("tb"+i).style.display="none";
			    document.getElementById("tc"+i).style.display="none";
				document.getElementById("tdx").value="More Info";
				 document.getElementById("type").value="Hide Info";
			}
		  
	  }
}
</script>
<%!Connection conn=null, conn1=null;
	Statement st1, st2, st, st3, st4, st5, st15,stmain11,st21,stt,st7;
%>	
<%
	String data1=session.getAttribute("data1").toString();
	String data2=session.getAttribute("data2").toString();
	final String vid=request.getParameter("vid").toString();
	final String user=session.getAttribute("user").toString();
	final String vehno=request.getParameter("vehno").toString();
	session.setAttribute("vid",vid);
	session.setAttribute("vehno",vehno);
	System.out.println("\n\non report");
	final NumberFormat nf=NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String exportFileName="customreport.xls";
	double cntrh=0.0, cntavgos=0, cntavgra=0, cntavgrd=0, cntosdur=0,timevikram=0.0;
	int i=1,cntndk=0,counter1=0;
	int cntndpost=0;
	String time1 ="00:00:00";
	String time2="23:59:59";
	String vehregno="",transporter="";
%>

<%
try{
	try
	{
		conn = fleetview.ReturnConnection();
		conn1 = fleetview.ReturnConnection1();
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn1.createStatement();
		st3=conn1.createStatement();
		st4=conn1.createStatement();
		st5=conn.createStatement();
		st21=conn.createStatement();
		st15=conn1.createStatement();
		stmain11 = conn1.createStatement();
		stt = conn1.createStatement();
		st7 = conn1.createStatement();
	}
	catch(Exception e)
	{
		System.out.println(">>>>>>>>>>>>>>>>.Exception:"+e);
	}
	try
	{
		String sql="select * from t_vehicledetails where VehicleCode='"+vid+"'";
		ResultSet rst=st.executeQuery(sql);
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
%>


<form id="Total_os" name="Total_os" action="" method="post">

<table border="0" width="100%" class="stats">
	<tr>
		<td>
		

		<div id="mytable">
		<body>
<table border="0" width="100%" >
	<tr>
		<td>
		<table border="0" width="100%" class="stats">
			<tr>
				<td colspan="2" align="center">
				<input type="hidden" name="type" id="type" value="More Info"/>
<%
					if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
					{
%>
						<!-- <div align="left"><font size="3"> Report No:3.1 </font></div>-->
						<font size="3" face="Arial"><b>Date Wise Exceptions</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
					{
%>
						<!--<div align="left"><font size="3"> Report No:4.1 </font></div>-->
						<font size="3" face="Arial"><b>Date Wise Exceptions</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
					{
%>
						<!--<div align="left"><font size="3"> Report No:5.1 </font></div>-->
						<font size="3" face="Arial"><b>Date Wise Exceptions</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
					{
%>
						<!--<div align="left"><font size="3"> Report No:6.1 </font></div>-->
						<font size="3" face="Arial"><b>Date Wise Exceptions</b></font> <%
					}
%>
				</td>
			</tr>
			<%
			String type=request.getParameter("type");
			System.out.println(">>>>>>>>>>type:"+type);
			%>
			<tr>
				<td align="center"><font size="3" face="Arial"><b> Exception
				Analysis Report For AVL Mobile Eye 2000 For <%=user.toUpperCase() %>
				Logistics - <%=vehno %> For The Period : <%=session.getAttribute("ShowDate").toString()%>
				to <%=session.getAttribute("ShowDate1").toString()%></b></font>
				<div class="bodyText" align="right">&nbsp;&nbsp;&nbsp; <input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> 
					<!--  <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a>-->
					<a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a><%=Utilities.printDate() %>
				</div>
				</td>
			</tr>
		</table>
		<P></P>

<%
System.out.println("\nstep 2");
	int totalOverSpeedCount=0, totalRapidAccelerationCount=0,cntft=0,nd_pri=0,cntdisconn=0,disk=0,cntfa=0;
	int totalRapidDecelerationCount=0, totalContinuousDrivingHours=0;
	int totalNightDrivingCounts=0, totalStops=0;
	Double totalFuelCount=0.00,totalDistanceTravelled=0.0,totalFuelAverage=0.0;
	List<ExceptionAnalysisReportData> data = null;
	int numRecords = 0;
	double cntrating=0,tot_dur=0.0,totstopdur=0.0;
	try {
		data = vehicleDao.getExceptionAnalysisData(vid,data1,data2);
		System.out.println("\nstep 3--->>data"+data.isEmpty());
		    numRecords = data.size();
		} catch (Exception e) {
				e.printStackTrace();
		}
		
%>
           <div align="left"> <b><font color="blue">Note:'Yes' in Average Speed Considered Column indicates Average speed is considered in calculation of Run hrs</font> </b>		<input type="button" value="More Info" onclick="showhide1();" class="formElement" id="tdx" name="tdx" style="border: thin;border-style: solid;"></div>&nbsp;&nbsp;

		<table bgcolor="#F5F5F5" width="100%" class="sortable" border="1">
			<tr>
				<th>Sr.</th>
				<th>Date</th>
				<th>Location</th>	
				<th>OS</th>
				<th>OS Dur</th>
				<th>RA</th>
				<th>RD</th>
				<th>CD</th>
				<th>DT</th>
				<th colspan="1">Rating</th>
				<th id="taa" style="display: none;">Avg OS Dur/100km</th>
				<th id="tbb" style="display: none;">Avg RA/100km</th>
				<th id="tcc" style="display: none;">Avg RD/100km</th>
				<th>FT</th>
				<th>FA</th>
				<th>FC</th>
				<th>AVG</th>
				<th>Stops</th>
				<th>Run Hrs.</th>
				<th>AVG Speed</th>
				<th>ND</th>
				<th>ND Dur(Hrs)</th>
				<th>ND Km</th>
				<th>ND Int</th>
				<th>ND Reason</th>
				<th>DayStop <br>(Hrs)</th>
				<th>DC</th>
				<th>DC Km</th>
				
				
			</tr>
			<%
	try{System.out.println("\nstep 4:-->>"+numRecords);
		for (int counter = 0; counter < numRecords; counter++)
			{System.out.println("\n\non dATA");
				final ExceptionAnalysisReportData currentRecord = data.get(counter);
%>
				<tr>
					<td style="text-align: right"><%=counter+1 %></td>
					<td style="text-align: right;">
					  <%=new SimpleDateFormat("dd-MMM-yyyy")
					  		.format((new SimpleDateFormat("yyyy-MM-dd"))
							  .parse(currentRecord.getDate())) %>
					</td>
					<td>
					 <div align="left">
<%
						boolean showAnchorForLocation= false;
						try{
							double latitude = Double.parseDouble(currentRecord.getLatitude());
							double longitude = Double.parseDouble(currentRecord.getLongitude());
							showAnchorForLocation = true;
						} catch(Exception e)
						{
							
						}

						if(showAnchorForLocation && !("No Data".equalsIgnoreCase(currentRecord.getLocation()))){							
								String lat1=currentRecord.getLatitude();
								String lon1=currentRecord.getLongitude();
								String disc=currentRecord.getLocation();
%>							 

								<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
	
						} else {
							out.println(currentRecord.getLocation());
						}
%>
					 </div>
					</td>
					<td>
					 <div align="right">
<%			
						boolean showAnchorForOverSpeed = false;
						try{
							int overSpeedCount = Integer.parseInt(currentRecord.getOverSpeedCount());
							totalOverSpeedCount += overSpeedCount;
							if(overSpeedCount>0) {
								showAnchorForOverSpeed = true;
							}
						   }catch(Exception e){					
						   }
						if (showAnchorForOverSpeed) {
							
						 out.print("<a href='CustomReportDrillDown.jsp?data="+currentRecord.getDate()+"&data1="+currentRecord.getDate()+"&vehcode="+vid+"'>"+currentRecord.getOverSpeedCount()+"</a>");
						 
						
						} else {
								out.print(currentRecord.getOverSpeedCount());
							    }
%>
					 </div>
				    </td>
				    <%
		double osavg =0.0;
		double osduration=0.0;
		String sqlos="SELECT sum(Duration)as duration FROM t_veh"+vid+"_overspeed  where concat(FromDate,' ',FromTime) >='"+currentRecord.getDate()+" 00:00:00' and ToDate <='"+currentRecord.getDate()+" 23:59:59' order by concat(FromDate,' ',FromTime)";
		System.out.println("sqlos--->"+sqlos);
		ResultSet rstos=st4.executeQuery(sqlos);
		if(rstos.next())
		{
			osduration=rstos.getDouble("Duration");
			System.out.println(" OS Duration--->"+osduration);
		}
		cntosdur= cntosdur + osduration;
		%>
					<td>
					<div align="right"><%=osduration%></div></td>
					<td>
 	              	 <div align="right">
<%
						boolean showAnchorForRapidAcceleration = false;
                        int rapidAcceleration=0;
						try{
							 rapidAcceleration = Integer.parseInt(currentRecord.getRapidAcceleration());
							totalRapidAccelerationCount += rapidAcceleration;
							if(rapidAcceleration>0) {
								showAnchorForRapidAcceleration = true;
							}
						} catch (Exception e) {					
						}
						
						if (showAnchorForRapidAcceleration) {
						out.print("<a href='CustomReportDrillDown.jsp?data="+currentRecord.getDate()+"&data1="+currentRecord.getDate()+"&vehcode="+vid+"'>"+currentRecord.getRapidAcceleration()+"</a>");
							} else {
								out.print(currentRecord.getRapidAcceleration());
							}
%>
					 </div>
					</td>
					<td>
				  	 <div align="right">
<%       int rapidDeceleration=0;
						boolean showAnchorForRapidDeceleration = false;
						try{
							 rapidDeceleration = Integer.parseInt(currentRecord.getRapidDeaccelaration());
							totalRapidDecelerationCount += rapidDeceleration;
							if(rapidDeceleration>0) {
								showAnchorForRapidDeceleration = true;
							}
						} catch (Exception e) {					
						}
						
						if (showAnchorForRapidDeceleration) {
							out.print("<a href='CustomReportDrillDown.jsp?data="+currentRecord.getDate()+"&data1="+currentRecord.getDate()+"&vehcode="+vid+"'>"+currentRecord.getRapidDeaccelaration()+"</a>");
						} else {
							out.print(currentRecord.getRapidDeaccelaration());
						}
%>
 					 </div>
				    </td>
					<td>
 				  	 <div align="right">
<%
						boolean showAnchorForContinuousDriving = false;
						try{
							int continuousDriving = Integer.parseInt(currentRecord.getContinuousDriving());
							totalContinuousDrivingHours += continuousDriving;
							if(continuousDriving>0) {
								showAnchorForContinuousDriving = true;
							}
						} catch (Exception e) {					
						}
						
						if (showAnchorForContinuousDriving) {		
							 out.print("<a href='CustomReportDrillDown.jsp?data="+currentRecord.getDate()+"&data1="+currentRecord.getDate()+"&vehcode="+vid+"'>"+currentRecord.getContinuousDriving()+"</a>");	
						} else {
							out.print(currentRecord.getContinuousDriving());
						}
%>
				     </div>
				    </td>
				    
				    
					
					<td>
				 	  <div align="right">
<%		double distanceTravelled=0.0;
						try{
							 distanceTravelled = Double.parseDouble(currentRecord.getDistanceTravelled());
							totalDistanceTravelled += distanceTravelled;
						} catch (Exception e) {
						}				
						out.print(currentRecord.getDistanceTravelled());
%>
				 	 </div>
					</td>
					<td>
					<div align="right">
					<%
					NumberFormat nfrating=NumberFormat.getInstance();
					nfrating.setMaximumFractionDigits(2);
					nfrating.setMinimumFractionDigits(2);			
		double rating=0.0;
	  	if(distanceTravelled>0.0)
	  	{
	  	double RD=((rapidDeceleration/distanceTravelled)*100);
	  	double RA=((rapidAcceleration/distanceTravelled)*100);	
	  	double OS=((osduration/10/distanceTravelled)*100);
	  	rating=RA+RD+OS;
	  	
	  	out.print(nfrating.format(rating));
	  	}
	  	else{
	  		out.print(0.0);
	  	}
	  	cntrating=rating+cntrating;
	  	%>
					</div>
					</td>
					
					<td  id="ta<%=i %>" style="display: none;" >
					<div align="right">
					<%
			System.out.println("IN OS Avg");
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			//int osduration=fleetview.getOSDurationforDateRange(aa,data1,data2);
			
				if(osduration> 0.0 && distanceTravelled >0.0)
				{
					System.out.println("distance --->"+distanceTravelled);
					osavg=(osduration*10)/distanceTravelled;
					System.out.println("OS avg--->"+osavg);
					out.print(nfos.format(osavg));
					//out.print(osavg);
					//out.print(osavg);
				}
				else{
					osavg=0.0;
					out.print(nfos.format(osavg));
					//out.print(osavg);
				}
				cntavgos+=osavg;
			
			
			%>
					</div>
					</td>
					<td  id="tb<%=i %>" style="display: none;">
					<div align="right">
					<% 
		NumberFormat nfra=NumberFormat.getInstance();
		nfra.setMaximumFractionDigits(2);
		nfra.setMinimumFractionDigits(2);
		double raavg =0.0;
		if(rapidAcceleration>0 && distanceTravelled>0.0 )
		{
			System.out.println("RA --->"+rapidAcceleration);
			raavg= (rapidAcceleration/distanceTravelled)*100;
			System.out.println("RA avg--->"+raavg);
			out.print(nfra.format(raavg));
			//out.print(raavg);
		}
		else  //if(dt==0.0 && ra>0 ||ra==0) 
		{ 
			raavg= 0.0;
			out.print(nfra.format(raavg));
		}
		cntavgra+=raavg;
		%>
					</div>
					</td>
					<td id="tc<%=i %>" style="display: none;">
					<div align="right">
					<% 
		NumberFormat nfrd=NumberFormat.getInstance();
		nfrd.setMaximumFractionDigits(2);
		nfrd.setMinimumFractionDigits(2);
		double rdavg =0.0;
		
		if(rapidDeceleration>0 && distanceTravelled>0.0)
		{
			System.out.println("RD -->"+rapidDeceleration);
			rdavg= (rapidDeceleration/distanceTravelled)*100;
			System.out.println("RD avg--->"+rdavg);
			out.print(nfrd.format(rdavg));
			//out.print(rdavg);
			
		}
		else //if(dt==0.0 && rd>0 ||rd==0 )
		{
			rdavg= 0.0;
			out.print(nfrd.format(rdavg));
			//cntavgrd+=rdavg;
		}
		cntavgrd+=rdavg;
		%>
					</div>
					</td>
					
					<td>
					<div align="right">
					<%
		int ft=0;
		try{
			String sql4="select count(*) as fcnt from t_vehft where vehcode like '"+vid+"' and Thedate='"+currentRecord.getDate()+"'  order by concat(TheDate,TheTime) desc";
			ResultSet rs4= st2.executeQuery(sql4);
			if(rs4.next())
			{  
				ft=rs4.getInt("fcnt");
			}
			}catch (Exception e) {
				System.out.print("Exception--->"+e);
			}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> 
					<%=ft%>  <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>


					<td >
					<div align="right">
					<%
		int fa=0;
		try{
			String sql4="select count(*) as fcnt from t_vehfa where vehcode like '"+vid+"' and Thedate ='"+currentRecord.getDate()+"' order by concat(TheDate,TheTime) desc";
			ResultSet rs4= st2.executeQuery(sql4);
			if(rs4.next())
			{  
				fa=rs4.getInt("fcnt");
			}
			else{
				out.print(0);
			}
			}catch (Exception e) {
				System.out.print("Exception--->"+e);
			}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
		if(fa >0)
		{
			%> <%=fa%>  <%				
		}
		else
		{
			out.print(0);
		}
		%>
					</div>
					</td>
					
					<td>
					 <div align="right">
<%
						String fuelInfo = "";
						try{
							double fuelCount = Double.parseDouble(currentRecord.getFuelCount());
							totalFuelCount += fuelCount;
							fuelInfo = nf.format(fuelCount);
						} catch (Exception e) {					
						}
						out.print(fuelInfo);
%>
				  	 </div>
					</td>
					<td>
					 <div align="right">
<%
						String averageFuelInfo = "";
						try{
							double averageFuel = Double.parseDouble(currentRecord.getAverageFuel());
							averageFuelInfo = nf.format(averageFuel);
						} catch (Exception e) {							
						}						
						out.print(averageFuelInfo);
%>
				  	 </div>
					</td>
					<td>
					 <div align="right">
<%
						boolean showAnchorForStops = false;
						try{
							int numberOfStops = Integer.parseInt(currentRecord.getStops());
							totalStops += numberOfStops;
							if(numberOfStops>0) {
								showAnchorForStops = true;
							}
						} catch (Exception e) {					
						}
						
						if (showAnchorForStops) {
							 out.print("<a href='CustomReportDrillDown.jsp?data="+currentRecord.getDate()+"&data1="+currentRecord.getDate()+"&vehcode="+vid+"'>"+currentRecord.getStops()+"</a>");
						} else {
							out.print(currentRecord.getStops());
						}
%>
					 </div>
					</td>
					<%
					double runhrs=0.0;
					ResultSet rst=null;
					try
					{
						String sql="select RDurationinHrs  from db_gpsExceptions.t_veh"+vid+"_ds  where  TheDate='"+currentRecord.getDate()+"' ";
						rst=st1.executeQuery(sql);
						if(rst.next())
						{
							runhrs=rst.getDouble(1);
							cntrh=cntrh+runhrs;
						}
						else
						{
							
						}

					}catch (Exception e) {
						System.out.println("Exception-->"+e);
						//return rst ;
					}
					
					%>
					<td>
				  	 <div align="right"><%= runhrs%>
				  	 </div>
				  	 </td>
				  	 		<td>
					<div align="left">
					<%
		 
		try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+vid+"' and TheDate ='"+currentRecord.getDate()+"' and AvgSpeedConsidered='Yes' ";
						System.out.println("avgspeed==>"+avgspeed);
						ResultSet rstavg=st3.executeQuery(avgspeed);
						if(rstavg.next())
						{
							/*System.out.println("in avg speed");
							avgsped=rst1.getString("AvgSpeedConsidered");
							if(avgsped.equalsIgnoreCase("Yes"))
							{
								System.out.println("in Yes");*/
								out.print("Yes");
						}
							else{
								System.out.println("in NO");
								out.print("No");
							}
						//}
						//else{
							//out.print("No");
						// }
						}catch(Exception ea){
							System.out.println("Avg speed exception"+ea);
						}
						//System.out.println("out of avgspeed");
		//cntdisconn=cntdisconn+rstdisconn.getInt("cnt"); 
		%>
					</div>
					</td>
					
				<!--  	<td>
				  	 <div align="left">-->
<%
						/*boolean showAnchorForNightDriving = false;
						if("Yes".equalsIgnoreCase(currentRecord.getNightDrivingStatus())){
							showAnchorForNightDriving = true;
							totalNightDrivingCounts++;
						}
						
						if (showAnchorForNightDriving) {
						out.print("<a href='CustomReportDrillDown.jsp?data="+currentRecord.getDate()+"&data1="+currentRecord.getDate()+"&vehcode="+vid+"'>"+currentRecord.getNightDrivingStatus()+"</a>");
						} else {
							out.print(0);				
						}*/
						
%>
				<!--  	 </div>
					</td>-->
					<td style="text-align: right;">
					<%
					//String time1 ="00:00:00";
					//String time2="23:59:59";
			int cntnd11=fleetview.NightDrivingFormExceptionsForDateRange(vid,currentRecord.getDate(),currentRecord.getDate());
			if(cntnd11>0)
		{
				totalNightDrivingCounts +=cntnd11;
			%> <a href="CustomReportDrillDown.jsp?data=<%=currentRecord.getDate() %>&data1=<%=currentRecord.getDate() %>&vehcode=<%=vid%>">
					<%=cntnd11%> </a> <%
		}
		else
		{
			out.print(0);
		}
		%>
					</td>
					<td>
					<div align="right">
<%
				
					int count1=0;
					String Time="00:00:00";
					try
					{
						String sql1="select Sec_To_Time(SUM(Time_To_Sec(Duration))),SUM(Time_To_Sec(Duration)) from t_veh"+vid+"_nd where  FromDate='"+currentRecord.getDate()+"' order by fromdate asc";
						System.out.println(">>>>>>>>>>>>>>>>sql1:"+sql1);
						ResultSet rst11=stmain11.executeQuery(sql1);
						if(rst11.next())
						{
							
								//count=rst11.getInt("cnt");
								Time=rst11.getString(1);
							    System.out.println(">>>>>>>>>>>>>>>>Time:"+Time);
							    tot_dur=tot_dur+rst11.getDouble(2);
							    System.out.println(">>>>>>>>>>>>>>>>tot_dur:"+tot_dur);
						}
					}catch (Exception e) {
						System.out.println("Exception-->"+e);
						
					}
					if(Time==null||Time==" ")
					{
						Time="00:00:00";
					}
					try
					{
						StringTokenizer str=new StringTokenizer(Time,":");
	                     while(str.hasMoreTokens())
	                     {
	                    	 String test=str.nextToken();
	                    	 String test1=str.nextToken();
	                    	 Time=test+"."+test1;
	                    	 String test2=str.nextToken();
	                     }
	                     timevikram=timevikram+Double.valueOf(Time.trim()).doubleValue();


					}
					catch(Exception e)
					{
						System.out.println(">>>>>>>exception:"+e);
					}
					
					%>
					<%=Time %>
					</div>
					</td>
					<% 			
		          int cntnd12=fleetview.NightDrivingFormExceptionsForDateRange1(vid,currentRecord.getDate(),currentRecord.getDate());
		%>
		    <td style="text-align: right;">
		    <%
		   if(cntnd12>0)
		  {
			cntndk+=cntnd12;
		  %>			
			<%=cntnd12 %>
		  <%
		  }else
		  {
			out.print(0);
		  }
		%>
				
					</td>
                    <td style="text-align: right;">
					<%
					
					int count=0;
					try
					{
						String sql1="select count(*) as cnt from t_veh"+vid+"_nd where  NDPreAuthorised='Yes' and FromDate='"+currentRecord.getDate()+"' order by fromdate asc";
						ResultSet rst11=stmain11.executeQuery(sql1);
						if(rst11.next())
						{
							if(rst11.getInt("cnt")>0)
							{
								count=rst11.getInt("cnt");
								nd_pri=nd_pri+count;
							}
						}
					}catch (Exception e) {
						//System.out.println("Exception-->"+e);
						
					}
					
					%>
					<%=count %>
					</td>
					
					
					<td>
                                <div align="right">
                                <% 
                                try{
                                        
                                //      String sqlpost="select count(*) as Reason from db_gpsExceptions.t_ndpostintimation where NdStartDateTime >='"+data1+" "+time1+"' and NdEndDateTime <='"+data2+" "+time2+"' and VehRegNo='"+vehregno+"' ";
                   
                                        String sqlpost="select count(*) as Reason from db_gpsExceptions.t_ndpostintimation where NdStartDateTime between '"+currentRecord.getDate()+" "+time1+"' and '"+currentRecord.getDate()+" "+time2+"' and VehRegNo='"+vehregno+"'";
                                
                                ResultSet rsndpost=st7.executeQuery(sqlpost);
                    
                    if(rsndpost.next())
                        {
                                if(rsndpost.getInt("Reason")>0)
                                {
                                        %>
                                                
                        <!--    <a href="detail_nd.jsp?vid=< %=aa%>&vehno=< %=vehregno%>&data1=< %=data1+' '+time1 %>&data2=< %=data2+' '+time2 %>&pageType=NightDriving"> < %=rsndpost.getInt("Reason")%> </a> -->
                            
                            
                         <!--     <a href="reason_details.jsp?vid=<%=vid%>&vehno=<%=vehregno%>&data1=<%=currentRecord.getDate()+' '+time1 %>&data2=<%=currentRecord.getDate()+' '+time2 %>" ></a> --> <%=rsndpost.getInt("Reason")%> 
                                        <%
                                }
                                else{
                                        out.print(0);
                                }
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rsndpost.getInt("Reason");
                                }catch(Exception ee)
                                {
                                 System.out.println("Exception in ND post intimation"+ee);
                                }
                                
                                %>
                         </div>
                                </td>
					<td>
					<div align="right">
					<%
		double stopdur=0.0;
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from t_veh"+vid+"_ds where VehCode='"+vid+"' and TheDate ='"+currentRecord.getDate()+"' order by TheDate desc";
		ResultSet rststop=st3.executeQuery(sqlstop);
		
		if(rststop.next())
		{
			stopdur=rststop.getDouble("stopduration");
			totstopdur=totstopdur+rststop.getDouble("stopduration");
			%> <%=stopdur%> <%
		}
		else
		{
			out.print("0");
			
		}
		
		%>
					</div>
					</td>
					<%
					
			try{
		
		String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+vid+"' and  OffTimeFrom >='"+currentRecord.getDate()+" 00:00:00' and  OffTimeFrom <='"+currentRecord.getDate()+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		System.out.println("sqldisconn==>"+sqldisconn);
		ResultSet rstdisconn=st5.executeQuery(sqldisconn);
		%>
		<td>
					<div align="right">
		<%
		if(rstdisconn.next())
		{
			if(rstdisconn.getInt("cnt")>0)
			{
				%>
				<a href="CustomReportDrillDown.jsp?data=<%=currentRecord.getDate() %>&data1=<%=currentRecord.getDate() %>&vehcode=<%=vid%>"> <%=rstdisconn.getInt("cnt")%> </a>
				<%
			}
			else{
				out.print(0);
			}
			
		}
		else
		{
			out.print(0);
		}
		
		cntdisconn=cntdisconn+rstdisconn.getInt("cnt");
		%>
		</div>
		
		</td>
		<%

		// count total km of diss
		sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+vid+"' and  OffTimeTo <='"+currentRecord.getDate()+" 23:59:59' and  OffTimeFrom >='"+currentRecord.getDate()+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		
		ResultSet rstdis=st5.executeQuery(sqldisconn);
		int diskm=0;
		while(rstdis.next())
		{
		  diskm=diskm+rstdis.getInt("Distance");
		}
		%>
		<td>
					<div align="right">
		<%
		
		if(diskm>0)
		{
			disk+=diskm;
			%>
			<%=diskm %>
		<%
		}
		else
		{
			out.print(0);
		}
		
		//... end of total km
		
		%>
		</div>
		</td>
		<%
			}
					catch(Exception e)
					{
						System.out.println(">>>>>>>>>>>>>>>>>Exception:"+e);
					}
		%>

					<%
					i++;
					counter1=counter1+i;
					System.out.println("value of i"+i);	
					
					%>
				</tr>
			<%
	  		 }
			 if(totalFuelCount>0){
		     	totalFuelAverage=totalDistanceTravelled/totalFuelCount;
			 }
		}catch(Exception e)
		{
				e.printStackTrace();				
		}
%>
			<tr class="sortbottom">
				<td class="hed" colspan="3">Total</td>
				<td class="hed">
				 <div align="right"><%=totalOverSpeedCount%></div>
				</td>
				<td class="hed">
				 <div align="right"><%=cntosdur%></div>
				</td>
				
				<td class="hed">
				 <div align="right"><%=totalRapidAccelerationCount%></div>
				</td>
				<td class="hed">
				 <div align="right"><%=totalRapidDecelerationCount%></div>
				</td>
				<td class="hed">
				 <div align="right"><%=totalContinuousDrivingHours%></div>
				</td>
				<td class="hed">
				 <div align="right"><%=totalDistanceTravelled%></div>
				</td>
				<td class="hed">
				<div align="right"><%=nf.format(cntrating) %></div>
				</td>
				<td class="hed" id="ta<%=i %>" style="display: none;">
				<div align="right"><%=nf.format(cntavgos) %></div>
				</td>
				<td class="hed" id="tb<%=i %>" style="display: none;">
				<div align="right"><%=nf.format(cntavgra) %></div>
				</td>
				<td class="hed" id="tc<%=i %>" style="display: none;">
				<div align="right"><%=nf.format(cntavgrd) %></div>
				</td>
				<td class="hed" >
				<div align="right"><%=cntft %></div>
				</td>
				<td class="hed" >
				<div align="right"><%=cntfa %></div>
				</td>
				<td class="hed">
				 <div align="right"><%=totalFuelCount%></div>
				</td> 
				
				<td class="hed">
				 <div align="right">		
					 <%=nf.format(totalFuelAverage) %></div>
				</td>
				
				<td class="hed">
		 		 <div align="right"><%=totalStops%></div>  
				</td>
				<td class="hed">
					<div align="right"><%=nf.format(cntrh) %></div>
					</td>
					<td class="hed">
					<div align="right"><b>-</b></div>
					</td>
					<td class="hed">
					<div align="right"><%=totalNightDrivingCounts %></div>
					</td>
					<td class="hed">
					<%
					String tt="";
					try
					{
						
						String Sqltt="Select Sec_To_Time('"+tot_dur+"')";
						ResultSet rst=stt.executeQuery(Sqltt);
						System.out.println(">>>>>>>>>>>>>Sqltt:"+Sqltt);
						if(rst.next())
						{
						  tt=rst.getString(1);
						}
						else
						{
							
						}
					}
					catch(Exception e)
					{
						System.out.println(">>>>>>>>>>>>>>>Exception:"+e);
					}
					try
					{
						StringTokenizer str=new StringTokenizer(tt,":");
	                     while(str.hasMoreTokens())
	                     {
	                    	 String test=str.nextToken();
	                    	 String test1=str.nextToken();
	                    	 tt=test+"."+test1;
	                    	 String test2=str.nextToken();
	                     }

					}
					catch(Exception e)
					{
						System.out.println(">>>>>>>exception:"+e);
					}
					%>
					<div align="right"><%=tt %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntndk %></div>
					</td>	
					<td class="hed">
					<div align="right"><%=nd_pri %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntndpost %></div>
					</td>	
					<td class="hed">
					<div align="right"><%=nf.format(totstopdur) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf.format(cntdisconn)%></div>
					</td>
					<td class="hed">
					<div align="right"><%=disk %></div>
					
					<% System.out.println(">>>>>>>>>>>>>>>>>disk:"+disk); %>
					</td>
					
				<%i++; %>
			</tr>
		</table>
		</td>
	</tr>
</table>
			<input type="hidden" name="countermore" id="countermore" value="<%=i %>"/>

</body>
</div>
</td>
</tr>
</table>
</form>
<%
}
catch(Exception e)
{
	System.out.println(">>>>>>>exception:"+e);
}
finally
{
	try
	{
	fleetview.closeConnection1();
	}catch(Exception e)
	{}
	try
	{
	fleetview.closeConnection();
	}catch(Exception e)
	{
	}
	
}
%>
</jsp:useBean>
        <%@ include file="footernew.jsp" %>
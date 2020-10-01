
<!-- Displayed Header -->
<%@ include file="headernew.jsp"%>

<!-- Database Connection -->
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,	MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
 	%>
 	<!-- Declaration of Global Variable -->
 	<%!Connection conn=null, conn1=null;
	Statement st, st1, st2, st3,st12,st13,st14,st15;
	String sql, data, data1, trips,sql2,sql3,d1,da2;
	String startplace;
	String s="",g="",p="",y="";

	NumberFormat nf = DecimalFormat.getNumberInstance();%>
	
<%

nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
         d1=request.getParameter("date1");
         System.out.println("value of d1"+d1);
         da2=request.getParameter("date2");
         System.out.println("value of d2"+da2);
         
		data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date1")));
		System.out.println("value of data"+data);
// 		String g=data.concat(" ");
// 		 s=g.concat("00:00:00");
// 		System.out.println("values of data appendeddata*****"+s);
		
		data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date2")));
		System.out.println("value of data1"+data1);
		startplace=request.getParameter("startplace");
		
		System.out.println("startpalce value"+startplace);
		
// 		if(startplace.contains("Bhiwandi")||(startplace.contains("GETL (Kandla-M&EL)")))
// 		{
// // 			System.out.println("heeeeeeeeeeeee");
// 		}
// 		else
// 		{
// // 		System.out.println("helloooooooooo");	
// 		startplace=startplace.replace("and","&");
// 		}

// 		System.out.println("startpalce value after"+startplace);
         if(startplace.contains("and1"))
         {
        	 startplace=startplace.replace("and1","&");
         }
         if(startplace.contains("&"))
         {
        	 startplace=startplace.replace("&","%26");
         }
		String usertypevalues=session.getAttribute("usertypevalue").toString();
		System.out.println("transporter name===>"+usertypevalues);
        
		
%>

<!-- JavaScript for export to excel and export to PDF -->
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
	<table border="0" width="100%" align="center" bgcolor="white">
<tr><td>
<table border="0" width="100%" align="center" bgcolor="white">

<tr><td>

<%
try{
	
	//Class.forName(MM_dbConn_DRIVER);
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	st12=conn.createStatement();
	st13=conn.createStatement();
	st14=conn.createStatement();
	st15=conn.createStatement();
	
	
if(!(null==request.getQueryString()))
{
%>

<%-- <table border="0" width="100%" align="center" class="stats">
<tr><td>
<%

%>
<font size="3">Key Performance Indicator Report for <b><%=startplace%></b> from <b><%=data%></b> to <b><%=data1%></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_KPI_report.jsp?date1=<%=data%>&date2=<%=data1%>&startplace=<%=startplace.replace("&","and")%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="Excel_KPI_report.jsp?date1=<%=data%>&date2=<%=data1%>&startplace=<%=startplace.replace("&","and")%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
</div>
</td></tr>
</table> --%>
	<%-- <table width="100%" border="1" align="center" class="sortable">
	
		<tr>
			
			<th rowspan="2"> Sr.</th>
			<th rowspan="2"> Trip ID</th>
			<th rowspan="2"> Vehicle Reg. No.</th>
			<th rowspan="2"> Transporter</th>
			<th rowspan="2"> Driver ID</th>
			<th rowspan="2"> Driver Name</th>
			<th rowspan="2"> Start Place</th>
			<th rowspan="2"> Start Date</th>
			<th rowspan="2"> End Place</th>
			<th rowspan="2"> End Date</th>
			<th rowspan="2"> Km Travelled</th>
			<th colspan="4"> Process Violations</th>
			<th colspan="2"> Policy Violations</th>
			<th rowspan="2"> Rating</th>
			<th rowspan="1"> Trip Status</th>
			<th rowspan="1"> Brief/ Debrief Status</th>
			<th rowspan="2">RH Violation</th>
			<th rowspan="2">Stops</th>
			<th rowspan="2">Total Days</th>
		    <th rowspan="2">Goals To Be Achieved</th>
			<th rowspan="2">Adherance to JRM</th>
			<th rowspan="2">Goals achieved</th>
			<th rowspan="1">Geofence</th>
			<th rowspan="1">Journey planning</th>
			<th rowspan="1">Driver FTPR</th>
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
			<th> OS Count</th>
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
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			
			</tr>
			
		<%
					data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
		            System.out.println("******data values"+data);
		             g=data.concat(" ");
		   		    s=g.concat("00:00:00");
		   		    System.out.println("values of data appendeddata*****"+s);
		
					data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
					System.out.println("@@@@@@@ values of data1@@@"+data1);
					y=data1.concat(" ");
				     p=y.concat("23:59:59");
					System.out.println("values of appendeddata11111@@@@@@"+p);
					
			double ratingcount,ratingcountall;
			double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
			double ss,aa,rr,rt;
			int i=1;			
			int kmcountall=0;
			int tripcountall=0;
			int drivercountall=0;
			 ratingcountall=0.0;
			int vehcountall=0;
			int oscountall=0;
			int oscountall1=0;
			int racountall=0;
			int rdcountall=0;
			int cdcountall=0;
			int ndcountall=0;
			int countlatency=0;
			int RHcountall=0;
			
			int daysall=0;
			int durationall=0,ndcount1=0;
			int j=0,nd=0,ndall=0;
			aa=0.0;
			ss=0.0;
			rr=0.0;
			rt=0.0;
			String vehcount="-",TripStatus="",Geo="",jrmplan="",driver="";
			String tripcount="-";
			String drivercount="-";
			String cdcount="-";
			String ndcount="-";
			String geofence ="-";
			String BriefGoals="-";
			String AdhJRM="-";
			String DeBriefGoal="-";
			String briefid1="-";
			String debriefid1="-";
			 String BriStatus="",DeBriStatus="";
			 
			
			String drivername="-",startplace1="-",endplace="-",startdate="-",enddate="-",OwnerName="-",ndcount3="",enddate1="-";
			ratingcount=0.0;
			int kmcount=0;
			int oscount=0;
			int oscount1=0;
			int racount=0;
			int rdcount=0;
			int Vehid=0;
			int latency=0;
			int duration=0;
			int RHcount=0;
			int stop=0;
			int stopall=0;
			int noofdays=0;
			
			
			
			
			 
			// ndcount3=request.getParameter("ndcount");
			// String ndcount2=Integer.pa(ndcount3);
			// System.out.println("nddddddddddddddd" +ndcount1);
			%>
			
			<%
			
			System.out.println("startplace before firing query"+startplace);
			
			//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,Ndcount from t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') group by TripID";
// 			sql="select a.OwnerName,a.Vehid,a.DriverName,a.StartDate,a.StartPlace,b.RunHrVio,b.Stoppagecount,b.EndDate,a.EndPlace,b.KmTravelled,b.OSDuration,b.RACount,b.RDCount,a.TripID,a.DriverCode,a.VehRegNo,a.StartPlace,a.StartDate,a.EndPlace,b.CRCount,b.Ndcount,DateDIFF(b.EndDate,b.StartDate) as days,a.ConsideredLatLon from db_gps.t_startedjourney a left outer join  db_gps.t_completedjourney b ON b.tripid = a.tripid where a.StartPlace = '"+startplace+"' and a.StartDate>='"+data+"' and a.StartDate<='"+data1+"' and (a.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR a.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') group by a.TripID";
			sql="select a.OwnerName,a.Vehid,a.DriverName,a.StartDate,a.StartPlace,b.OScount,b.RunHrVio,b.Stoppagecount,b.EndDate,a.EndPlace,b.KmTravelled,b.OSDuration,b.RACount,b.RDCount,a.TripID,a.DriverCode,a.VehRegNo,a.StartPlace,a.StartDate,a.EndPlace,b.CRCount,b.Ndcount,b.DriverID,DateDIFF(b.EndDate,b.StartDate) as days, a.ConsideredLatLon,c.briefid,c.GoalsToBeAchieved,c.Briefid,d. debriefid,d.AdhJRM,d.GoalsAchived from db_gps.t_startedjourney a left outer join db_gps.t_completedjourney b on a.tripid=b.tripid left outer join db_gps.t_briefing c on a.tripid=c.tripid left outer join db_gps.t_debriefing as d on a.tripid=d.tripid  where a.StartPlace = '"+startplace+"' and b.StartDate>='"+s+"' and b.StartDate<='"+p+"' and (a.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR a.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') group by Tripid"; 			
			//out.println(sql);	
			ResultSet rstkm=st1.executeQuery(sql);
			System.out.println("sssssssssssss2222223333" +sql);
				while(rstkm.next())
				{
					vehcount=rstkm.getString("VehRegNo");
					OwnerName=rstkm.getString("OwnerName");
					Vehid=rstkm.getInt("Vehid");
					tripcount = rstkm.getString("TripID");
					drivercount=rstkm.getString("DriverCode");
					drivername=rstkm.getString("DriverName");
					startplace1=rstkm.getString("StartPlace");
					endplace=rstkm.getString("EndPlace");
					startdate=rstkm.getString("StartDate");
					enddate1=rstkm.getString("EndDate");
					
				//	System.out.println("Sdate===>"+startdate);
					try{
						
					if(rstkm.getString("EndDate").equalsIgnoreCase("Null"))
					{enddate="-";
						
					}
					else{
					enddate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstkm.getString("EndDate")));
					}
					}catch(Exception e)
					{
						enddate="-";
						
						
					}
					
				//	System.out.println("EndDate===>"+enddate);
					kmcount=rstkm.getInt("KmTravelled");
					kmcountall=kmcountall+kmcount;
					oscount1=rstkm.getInt("OScount");
					oscountall1=oscountall1+oscount1;
					oscount=rstkm.getInt("OSDuration");
					oscountall=oscountall+oscount;
					racount=rstkm.getInt("RACount");
					racountall=racountall+racount;
					rdcount=rstkm.getInt("RDCount");
					rdcountall=rdcountall+rdcount;
					duration=rstkm.getInt("OSDuration");
					durationall+=rstkm.getInt("OSDuration");
					nd=rstkm.getInt("NDCount");
					ndall+=rstkm.getInt("NDCount");
					RHcount=rstkm.getInt("RunHrVio");
					RHcountall=RHcountall+RHcount;
					stop=rstkm.getInt("Stoppagecount");
					stopall=stopall+stop;
					noofdays=rstkm.getInt("days")+1;
					daysall=daysall+noofdays;
					geofence=rstkm.getString("ConsideredLatLon");
					BriefGoals=rstkm.getString("GoalsToBeAchieved");
					AdhJRM=rstkm.getString("AdhJRM");
					DeBriefGoal=rstkm.getString("GoalsAchived");
					
					if(AdhJRM!=null)
					{
						
						
					}else{
						
						AdhJRM="-";
						
					}
					
					
					if(BriefGoals!=null)
					{
						
						
					}else{
						
						BriefGoals="-";	
						
					}
					
					if(DeBriefGoal!=null)
					{
						
						
					}else{
						
						DeBriefGoal="-";
						
					}
					
					briefid1=rstkm.getString("Briefid");
					debriefid1=rstkm.getString("debriefid");
					/*#################################change#############################*/
			        String fromdate="",todate="";
					String ftime1="00";
					String ftime2="00";
					String ttime1="00";
					String ttime2="00";
					String sdate,edate;
			      
			    
			    try
			    {
			    	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdate));
			    }
			    catch(Exception e)
			    {
			    	try
			    	{
			    	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate));
			    	}
			    	catch(Exception c)
			    	{
			    	 fromdate=startdate;	
			    	}
			    }
				
			  	 try
			  	 {
			  		//retrieve time in hrs and mins
			  		 java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdate);
			  	 	ftime1=""+dt.getHours();
			  	 	ftime2=""+dt.getMinutes();
			  	 }
			  	catch(Exception e)
			  	{
			  		ftime1="00";
			  		ftime1="00";
			  	}
				try
				{
					todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate));	
				}
			  	 catch(Exception e)
			  	 {
			  		
			  		 try
			  		 {
			  		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate));
			  		 }
			  		 catch(Exception x)
			  		 {
			  			 try
			  			 {
			  			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enddate));
			  			 }
			  			 catch(Exception ex)
			  			 {
			  				todate = enddate;
			  			 }
			  		 }
			  		 
			    }
			  		 
			  
			  try
			  {
					//retrieve time in hrs and mins
				  	java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate);
					ttime1=""+edt.getHours();
			  	 	ttime2=""+edt.getMinutes();
			  }
			  catch(Exception e)
			  	{
			  		ttime1="23";
			  	 	ttime2="59";
			  	}
			  
			  if(geofence.equalsIgnoreCase("shiptocode"))
				{
					Geo="Yes";
				}
				else
				{
						Geo="No";
					
				}
			  
			  
			  try{
				  System.out.println("BRIEFID"+briefid1);
				  System.out.println("DEBRIEFID"+debriefid1);
				  System.out.println("TRIPID"+tripcount);
				 
				  
// 			  if(!(briefid1.equalsIgnoreCase("null"))&&(!briefid1.equalsIgnoreCase("-"))&&(!(briefid1== null)))
	          if(!(briefid1==null)) 
			  {
// 				  System.out.println("in brief block IF BLOCK");
				  BriStatus="Briefed";
				  
			  }else
			  {
				  System.out.println("in brief block ELSE block");
				  BriStatus="Not Briefed";
			  }
// 			  if(!(debriefid1.equalsIgnoreCase("null"))&& (!debriefid1.equalsIgnoreCase("-"))&&(!(debriefid1== null)))
	          if(!(debriefid1==null)) 
			  {
// 				  
                System.out.println("deBriefid" +debriefid1); 
// 				  BriStatus=BriStatus+"& Debriefed";
//                  System.out.println("in debrief block IF BLOCK");
				  DeBriStatus="Debriefed";
// 				  System.out.println("deBriefid" +debriefid1); 
// 				   System.out.println("VALUE OF DEBRIEF ID IN IF BLOCK"+DeBriStatus)
			  }else
			  {

// 				  System.out.println("in debrief block ELSE block");
				  DeBriStatus="Not Debriefed";
			  }
			  
							
				
			  }catch(Exception e33)
			  {
				  
				  System.out.println("Exception"+e33.getMessage());
				  e33.printStackTrace();
			  }
			  
			  
			  
			  
			  	 /*#################################change#############################*/  
			%>	
			
			<tr>
			<td style="text-align: right"><%=i%></td>
			<td style="text-align: right">
			<%
							String briefid = "",rid = "",plannedstatus = "No";
							boolean flag = false;
							String sql1 = "select * from db_gps.t_briefing where tripid = '"+tripcount+"'";
// 							System.out.println("query1===>"+sql1);
							ResultSet rs1 = st.executeQuery(sql1);
							if(rs1.next())
							{
								briefid = rs1.getString("Briefid");
							}

							sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+tripcount+"' and briefid = '"+briefid+"' and driverid = '"+drivercount+"'  order by advancedtrackid asc ,row asc limit 1 ";
// 							System.out.println("query2==>"+sql1);
							rs1 = st.executeQuery(sql1);
							if(rs1.next())
							{
								rid = rs1.getString("advancedrouteid");
								plannedstatus = "Yes";
								flag = true;
							}
							%>
			<a href="#" onclick="javascript:window.open('ActAndPlanJrnyCompOnMap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&data=<%=fromdate%>&data1=<%=todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1%>&ttime2=<%=ttime2 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=drivercount%>');">	           
			<%=tripcount %></a>
			
			<!--<a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=< %=tripcount%>&vehcode=< %=Vehid%>&sdate=< %=startdate%>&vehregno=< %=vehcount%>&ownername=< %=OwnerName%>&startplace=< %=startplace1%>&endplace=< %=endplace%>&enddate=< %=enddate%>&pg=cm');">	
			<%//=tripcount %></a>-->
			
			</td>
			<td>
			<div align="left">
			<%=vehcount %>
			</div></td>
			<td>
			<div align="left">
			<%=OwnerName %>
			</div></td>
			<td>
			<div align="right">
			<%=drivercount %>
			</div></td>
			<td>
			<div align="left">
			<%=drivername %>
			</div></td>
			<td>
			<div align="left">
			<%=startplace1 %>
			</div></td>
			<td>
			<div align="right">
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
			</div></td>
			<td>
			<div align="left">
			<%=endplace %>
			</div></td>
			<td>
			<div align="right">
			<%=enddate %>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(kmcount);
			%>
			</div></td>
			<td><div align="right">
			<%
			if(oscount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_osduration.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=rstkm.getString("StartDate")%>&edate=<%=rstkm.getString("EndDate")%>');">
			<%
				out.print(oscount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(oscount);
			}
			%>
			</div></td>
			<td>
			<div align="right">
			<%=oscount1 %>
			</div></td>
			<td><div align="right">
			<%
			if(racount > 0)
			{
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapidacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=rstkm.getString("StartDate") %>&edate=<%=rstkm.getString("EndDate") %>');">
			<%
			out.print(racount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(racount);
			}
			%>
			</div></td>
			<td><div align="right">
			<%
			if(rdcount > 0)
			{
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapiddeacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=rstkm.getString("StartDate") %>&edate=<%=rstkm.getString("EndDate") %>');">
			<%
				out.print(rdcount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(rdcount);
			}
			%>
			</div></td>
			<td><div align="left">
			<%
			try{
			if(rstkm.getString("CRCount").equalsIgnoreCase("null")){
				out.print("-");
			}else{
				cdcount=rstkm.getString("CRCount");
				if(cdcount.equals("Yes"))
				{
				cdcountall++; 
				out.print("Yes");
				}
				else
				{
				out.print("No");
				}}
			}catch(Exception e)
			{
				out.print("-");
			}
			%>
			</div></td>
			<td><div align="right">
			<%
				//ndcount=rstkm.getString("NDCount");
		//	int ndcount1=Integer.parseInt(ndcount);
			if(nd>0)
				{
				//ndcountall++;
				%>
            	<%=nd%>
				<%
				//out.print("Yes");
				}
				else
				{
				out.print("0");
				}
			 
				
			%>
			</div></td>
			<td>
			<div align="right">
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
				
			%>		</div>			
			</td>
						<%
			TripStatus="Running";
			sql="select TripID from db_gps.t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and driverid='"+drivercount+"' and  TripID='"+tripcount+"' limit 1 ";
// 			System.out.println("query3==>"+sql);	
			ResultSet rstkm1=st12.executeQuery(sql);
			//System.out.println("!!!!" +sql);
				if(rstkm1.next())
				{
					TripStatus="Closed";
				}
				
				
				
			
// 				BriStatus="Not Briefed";
// // 				sql="select TripID,brifstatus,Debrifstatus  from t_briefing where  Driverid='"+drivercount+"' and tripid='"+tripcount+"' ORDER BY updateddt DESC limit 1 ";
				
// 				ResultSet rstkm13=st13.executeQuery(sql);
// 				System.out.println("query4==>"+sql);
// 				//System.out.println("!!!!" +sql);
// 				if(rstkm13.next())
// 					{
// 					if(rstkm13.getString("Debrifstatus").equalsIgnoreCase("not debrifed")||rstkm13.getString("Debrifstatus").equalsIgnoreCase("not debriefed"))
// 					{
// 						BriStatus="Not Debriefed";
// 					}
// 					else if(rstkm13.getString("Debrifstatus").equalsIgnoreCase("debrifed")||rstkm13.getString("Debrifstatus").equalsIgnoreCase("debriefed"))
// 					{
// 						BriStatus="Debriefed";
// 					}			
// 					}
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				try{
				    sql2="select * from db_gps.t_jrnyplanning where TripID='"+tripcount+"'";
				    ResultSet rst=st14.executeQuery(sql2);
// 					 System.out.println("query5==>"+sql2);
					 if(rst.next())
					 {
						 jrmplan="Yes";
					 }
					 else
					 {
						 jrmplan="No";
					 }
				}catch(Exception e)
				{
					System.out.println("exception in query===>"+e.getMessage());
				}
				
				
				try{
				    sql3 ="select ReasoneForRejection from db_gps.t_reasonOfRejectionForDriver where DriverId = '"+rstkm.getString("DriverID")+"' and UpdatedDateTime >= '"+startdate+
							   "'  and UpdatedDateTime <= '"+rstkm.getString("EndDate")+"' and transporter = '"+usertypevalues+"' and status = 'Yes'";;
				    ResultSet rst1=st15.executeQuery(sql3);
// 					 System.out.println("query6==>"+sql3);
					 if(rst1.next())
					 {
						 driver="NO";
					 }
					 else
					 {
						 driver="YES";
					 }
				}catch(Exception e)
				{
					System.out.println("exception in queryyyyyyyyyyyyy===>"+e.getMessage());
				}
					
			%>
			
			
			
			<td><div align="left"><%=TripStatus%></div></td>
			<td><div align="left"><%=BriStatus%></div></td>
			<td><div align="left"><%=BriStatus%>&<%=DeBriStatus%></div></td>
			<td><div align="right"><%=RHcount%></div></td>
			<td><div align="right"><%=stop%></div></td>
			<td><div align="right"><%=noofdays%></div></td>
			<td><div align="left"><%=BriefGoals%></div></td>
			<td><div align="left"><%=AdhJRM%></div></td>
			<td><div align="left"><%=DeBriefGoal%></div></td>
			<td><div align="left"><%=Geo%></div></td>
			<td><div align="left"><%=jrmplan%></div></td>
			<td><div align="left"><%=driver%></div></td>
			
			
			
			</tr>
			<%
			i++;
			}
			%>	
			<tr>
			<td class="hed" colspan="10">Total :-</td>
			<td class="hed"><div align="right"><%=kmcountall%></div></td>
			<td class="hed"><div align="right"><%=oscountall%></div></td>
			<td class="hed"><div align="right"><%=oscountall1%></div></td>
			<td class="hed"><div align="right"><%=racountall%></div></td>
			<td class="hed"><div align="right"><%=rdcountall%></div></td>
			<td class="hed"><div align="right"><%=cdcountall%></div></td>
			
			<%
			if(ndall > 0)
			{
				%>
				<td class="hed"><div align="right"><%=ndall %></div></td>
				<%
			}
			else
			{
				%>
				<td class="hed"><div align="right">0</div></td>
				<%
			}
			
			
			%>
			  
			   
				<td class="hed"><div align="right">
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
			%></div></td>
			<td class="hed">
			</td>
			<td class="hed"> 
			</td>
            
			  
			  <td class="hed"><div align="right"><%=RHcountall%></div></td>
			  <td class="hed"><div align="right"><%=stopall%></div></td>
			  <td class="hed"><div align="right"><%=daysall%></div></td>
			  <td class="hed"><div align="center">-</div></td>
			  <td class="hed"><div align="center">-</div></td>
			 <td class="hed"><div align="center">-</div></td>
			 <td class="hed"><div align="center">-</div></td>
 --%>			 <td class="hed"><div align="center">-</div></td>
			 <td class="hed"><div align="center">-</div></td>
			   
			</tr>
			</table>

<%
}
}catch(Exception ee)
{
 out.print("Exception---->"+ee);
}
finally
{
	conn.close();
	try
	{
	fleetview.closeConnection();}
	catch(Exception e)
	{}
}

%>

	</td></tr>
</table>
<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=KPIReport_drill.rptdesign&dt=<%=d1%>&dt1=<%=da2%>&OwnerName=<%=usertypevalues%>&GPName=<%=usertypevalues%>&date=<%=data%>&date1=<%=data1%>&startloc=<%=startplace%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 

 </div>
<%-- </td></tr>
<tr><td><%@ include file="footernew.jsp"%></td></tr>
</table> --%>
</jsp:useBean>



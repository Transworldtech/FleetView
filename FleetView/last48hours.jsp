 <%@ include file="headernew.jsp" %> 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
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

function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.last48hours.action ="excel.jsp";
          document.forms["last48hours"].submit();
} 


</script>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<form id="last48hours" name="last48hours" action="" method="post" >
<div id="table1">
<table border="0" width="100%">
     <tr>
        <td>
        <%!
        Connection conn, conn1;
        Statement st1,st2,st,st3,st4,st5;
        int cntos,cntra,cntrda,cntdt,cntst,cntcd,cntnd,cntfc,cntdisconn,cntft=0,cntfa=0;
        double cntrh,cntavgos,cntavgra,cntavgrd,cntosdur;
        double stopdur,totstopdur,cntrating;
        Double cntavg=0.00;
        String vehregno="-",transporter="-";
        %>
        <%
        cntdisconn=0;
        cntrating=0;
        cntos=0;
        cntra=0;
        cntrda=0;
        cntdt=0;
        cntst=0;
        cntrh=0.0;
        cntcd=0;
        cntnd=0;
        cntfc=0;
        cntosdur=0;
        stopdur=0.0;
        totstopdur=0.0;
        cntavgos=0.0;
        cntavgra=0.0;
        cntavgrd =0.0; //code to get system date as data2 and yesterdays date as a data1.
        cntft=0;
        cntfa=0;
        cntavg=0.0;
     

        //code to get system date as data2 and yesterdays date as a data1.

        java.util.Date NewDate =new java.util.Date();
        long dateMillis = NewDate.getTime();
        long dayInMillis = 1000 * 60 * 60 *24;
        dateMillis = dateMillis - dayInMillis;
        NewDate.setTime(dateMillis);
        Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
        Format NewFormatter1 = new SimpleDateFormat("dd-MMM-yyyy");

        String data2 = NewFormatter.format(NewDate);
        String data4 = NewFormatter1.format(NewDate);
        long dayInMills1=1000*60*60*24;
        NewDate.setTime(dateMillis-dayInMills1);
        String data1 = NewFormatter.format(NewDate);
        String data3 = NewFormatter1.format(NewDate);
        session.setAttribute("data1",data1);
        session.setAttribute("data2",data2);
        session.setAttribute("data3",data3);
        session.setAttribute("data4",data4);
        String user,usertypevalue;
        user=session.getAttribute("user").toString();
        usertypevalue=session.getAttribute("usertypevalue").toString();
        //database connectivity to get the transporter wise report.
        try
        {
	        conn = fleetview.ReturnConnection();
	        conn1 = fleetview.ReturnConnection1();
	        st=conn.createStatement();
	        st=conn.createStatement();
	        st2=conn1.createStatement();
	        st3=conn1.createStatement();
	        st4=conn1.createStatement();
	        st5=conn.createStatement();
	        //st15=conn1.createStatement();
	        session.setAttribute("reportno","Report No:4.0");
	        session.setAttribute("reportname","Last 2 Days Exception Report For Full Fleet");
            %>

            <%

            String exportFileName=session.getAttribute("user").toString()+"_last_2_Days_report.xls";  

            %>

           <table border="0" width="100%" align="center" class="stats">
               <tr align="center">
                   <td colspan="14" align="center">
                       <!-- <div align="left"><font size="3">Report No:4.0</font></div>-->
                       <font size="3"><b>Last 2 Days Exception Report For Full Fleet</b></font>
                   </td>
               </tr>
     
               <tr align="center">
                   <td colspan="10" align="center">
                       <font size="3"><b>Exception Report For <%=usertypevalue %> For the Period : <%
                       java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
                       Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
                       String showdate = formatter.format(ShowDate);
                       out.print(showdate);
                       %> 00:00:00 AM to <%
                       Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
                       String showdate1 = formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
                       out.print(showdate1);
                       session.setAttribute("ShowDate",showdate+" 00:00:00");
                       session.setAttribute("ShowDate1",showdate1+" 23:59:00");
 
                       String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());

                       %> 23:59:00 PM</b>
                       </font>
                   </td>
       
                   <td>
                       <div class="bodyText" align="right">
       
                       <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                       <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
       
                       <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                       <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
            
                       <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                       <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                       <%=fleetview.PrintDate() %></div>
                  </td>
               </tr>
           </table>

           <p></p>
           <table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
               <tr>
                  <th colspan="15" class="sorttable_nosort" align="center">Parameters considered for the Report
                  </th>
               </tr>
               <tr>
                  <td class="bodyText" colspan="5">
                      <div align="left">1. OverSpeed : <%=session.getAttribute("overspeed").toString() %></div>
                  </td>
                  <td class="bodyText" colspan="5">
                      <div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></div>
                  </td>
                  <td class="bodyText" colspan="5" >
                     <div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></div>
                  </td>
               </tr>
               <tr>
                  <td class="bodyText" colspan="5">
                      <div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %> </div>
                  </td>
                  <td class="bodyText" colspan="5">
                      <div align="left">5. Continuous Driving :<%=session.getAttribute("cdri").toString() %></div>
                  </td>
                  <td class="bodyText" colspan="5">
                      <div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %></div>
                  </td>
              </tr>
           </table>
           <p></p>
           <br>
              <b><font color="blue">Note:'Yes' in Average Speed Considered Column indicates Average speed is considered in calculation of Run hrs</font> </b>
           
			<p></p>
			<table border="1" width="100%" class="sortable">
				<tr>
					<th>Sr.</th>
					<th>Vehicle Reg no.</th>
					<th>Transporter</th>
					<th>Date</th>
					<th>Location</th>
					<th>OS</th>
					<th>OS Dur</th>
					<th>RA</th>
					<th>RD</th>
					<th>CD</th>
					<th>DT</th>
					<th colspan="1">Rating</th>
					<th>Avg OS Dur/100km</th>
					<th>Avg RA/100km</th>
					<th>Avg RD/100km</th>
					<th>FT</th>
					<th>FA</th>
					<th>FC</th>
					<th>AVG</th>
					<th>Stops</th>
					<th>Run Hrs.</th>
					<th>ND</th>
					<th>DayStop(Hrs)</th>
					<th>Disconnection</th>
					<th colspan="2">Average speed Considered</th>

				</tr>
				<!-- Get The Data From the Database and show it -->

				<%	
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	int i=1;
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_veh"+aa+"_ds";
	if(!aa.equals("0"))
	{
	String sql="select * from t_vehicledetails where vehicleCode='"+aa+"'";
	ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			vehregno=rst.getString("VehicleRegNumber");
			transporter=rst.getString("OwnerName");
		}
		if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
			%>
				<tr>
					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left"><%=transporter%></td>
					<td style="text-align: left">Blocked</td>
					<td style="text-align: left">Access denied for <%=transporter%></td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
				</tr>
				<%
			i++;	
		}
		else
		{
			String dttime="",location="",loc="";
			sql="select * from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
			ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
			
			 loc=rst1.getString("Location");
			 if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
			{
				 dttime=loc.substring(0,19);
				 location=loc.substring(19);
			}
			else{
				
				location=loc;
				dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
				/*System.out.println("location"+location);
				String sqldate="Select * from db_gps.t_veh"+aa+" where thefielddatadate='"+data2+"' order by thefielddatatime desc limit 1";
				ResultSet rstdate=st2.executeQuery(sqldate);
				if(rstdate.next())
				{
					dttime=rstdate.getString("thefielddatadatetime");
					System.out.println("dttime"+dttime);
				}
				else{
					dttime=data2;
					System.out.println("dttime"+dttime);
				}*/
				
			}
		%>
				<tr>

					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><a
						href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
					<td style="text-align: left"><%=transporter %></td>
					<td style="text-align: left"><%=dttime %></td>
					<td>
					<div align="left">
					<%
	
		
		if(location.equalsIgnoreCase("No data"))
		{
			out.print(location);
		}
		else
		{
			out.print(fleetview.ShowOnMapOnlyByLocation(location,aa,rst1.getString("TheDate")));
		}
	
		%>
					</div>
					</td>
					<%
		ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
					<td>
					<div align="right">
					<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			%> <a href="detail_os.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=os%>
					</a> <%				
		}
		else
		{
			out.print(os);
		}
		%>
					</div>
					</td>
					<%
		double osavg =0.0;
		double osduration=0.0;
		String sqlos="SELECT sum(Duration)as duration FROM t_veh"+aa+"_overspeed  where concat(FromDate,' ',FromTime) >='"+data1+" 00:00:00' and ToDate <='"+data2+" 23:59:59' order by concat(FromDate,' ',FromTime)";
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
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{ 
			%> <a
						href="detail_ra.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&pageType=RapidAcceleration">
					<%=ra%> </a> <%
		}
		else
		{
			out.print(ra);
		}
		
		%>
					</div>
					</td>
					<td>
					<div align="right">
					<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			%> <a
						href="detail_rd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&pageType=RapidDecceleration">
					<%=rd%> </a> <%
		}
		else
		{
			out.print(rd);
		}
		
		%>
					</div>
					</td>
					<td>
					<div align="right">
					<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%> <a
						href="detail_cd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&pageType=ContinuousDriving">
					<%=cd%> </a> <%
		}
		else
		{
			out.print(cd);
		}
		
		%>
					</div>
					</td>
					<td>
					<div align="right">
					<%
		double dt=rstcounts.getDouble(5);
		cntdt+=dt;
		out.print(dt);
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
	  	if(dt>0.0)
	  	{
	  	double RD=((rd/dt)*100);
	  	double RA=((ra/dt)*100);	
	  	double OS=((osduration/10/dt)*100);
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

					<td>
					<div align="right">
					<%
			System.out.println("IN OS Avg");
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			//int osduration=fleetview.getOSDurationforDateRange(aa,data1,data2);
			
				if(osduration> 0.0 && dt >0.0)
				{
					System.out.println("distance --->"+dt);
					osavg=(osduration*10)/dt;
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
					<td>
					<div align="right">
					<% 
		NumberFormat nfra=NumberFormat.getInstance();
		nfra.setMaximumFractionDigits(2);
		nfra.setMinimumFractionDigits(2);
		double raavg =0.0;
		if(ra>0 && dt>0.0 )
		{
			System.out.println("RA --->"+ra);
			raavg= (ra/dt)*100;
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
					<td>
					<div align="right">
					<% 
		NumberFormat nfrd=NumberFormat.getInstance();
		nfrd.setMaximumFractionDigits(2);
		nfrd.setMinimumFractionDigits(2);
		double rdavg =0.0;
		
		if(rd>0 && dt>0.0)
		{
			System.out.println("RD -->"+rd);
			rdavg= (rd/dt)*100;
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
			String sql4="select count(*) as fcnt from t_vehft where vehcode like '"+aa+"' and Thedate>='"+data1+"' and TheDate <='"+data2+"' order by concat(TheDate,TheTime) desc";
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
			%> <a
						href="showfuelalert.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>


					<td>
					<div align="right">
					<%
		int fa=0;
		try{
			String sql4="select count(*) as fcnt from t_vehfa where vehcode like '"+aa+"' and Thedate>='"+data1+"' and TheDate <='"+data2+"' order by concat(TheDate,TheTime) desc";
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
		//cntfa+=fa;
		if(fa >0)
		{
			%> <a
						href="showfueladd.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=fa%> </a> <%				
		}
		else
		{
			out.print(0);
		}
		%>
					</div>
					</td>

					<%
		if(fleetview.getUnitDescription(aa).equals("FUELFLOW"))
		{
			%>
					<td>
					<div align="right">
					<%
				
				int fcval=fleetview.getFuelConsumptionForDateRange(aa,data1,data2);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td>
					<div align="right">
					<%
			NumberFormat nf=NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			Double favgval=fleetview.getFuelAVGForDateRange(aa,data1,data2);
			cntavg=cntavg+favgval;
			out.print(nf.format(favgval));
			
			
			
			%>
					</div>
					</td>
					<%
		}
		else
		{
			%>
					<td>
					<div align="right">-</div>
					</td>
					<td>
					<div align="right">-</div>
					</td>
					<%
		}
		%>
					<td>
					<div align="right">
					<%
			System.out.println("IN stop");
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			%> <a href="detail_stops.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=stsp%>
					</a> <%
		}
		else
		{
			out.print(stsp);
		}
		
		%>
					</div>
					</td>

					<td>
					<div align="right">
					<%
		double d=0.0;
		System.out.println("Runhrs");
		d=rstcounts.getDouble(7);
		cntrh+=d;
		out.print(d);
		%>
					</div>
					</td>
					<td style="text-align: left">
					<%
	
					String time1 ="00:00:00";
					String time2="23:59:59";
			int cntnd1=fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
		if(cntnd1>0)
		{
			cntnd+=cntnd1;
			%> <a
						href="detail_nd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&data1=<%=data1+' '+time1 %>&data2=<%=data2+' '+time2 %>&pageType=NightDriving">
					<%=cntnd1%> </a> <%
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
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
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

					<td>
					<div align="right">
					<%
		try{
			
			//String time1 ="00:00:00";
			//String time2="23:59:59";
		String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeTo >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		System.out.println("sqldisconn==>"+sqldisconn);
		ResultSet rstdisconn=st5.executeQuery(sqldisconn);
		if(rstdisconn.next())
		{
			if(rstdisconn.getInt("cnt")>0)
			{
				%>
			<a href="disconnectedDetailsReport.jsp?vehicleCode=<%=aa%>&VehicleRegNo=<%=vehregno%>&ownerName=<%=transporter%>&fromDateTime=<%=data1+" "+time1%>&toDateTime=<%=data2+" "+time2%>"> <%=rstdisconn.getInt("cnt")%> </a> 
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
		}catch(Exception ee)
		{
			System.out.println("Exception disconnection "+ee);
		}
		System.out.println("out of Disconnection");
		%>
					</div>
					</td>
					<td>
					<div align="left">
					<%
		 
					try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
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
						System.out.println("out of avgspeed");
		//cntdisconn=cntdisconn+rstdisconn.getInt("cnt"); 
		%>
					</div>
					</td>
				</tr>
				<%
		i++;
				System.out.println("value of i"+i);	
		}
		System.out.println("While");	
		}
		else
		{
			%>
				<tr>
					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left">No DATA</td>
					<td style="text-align: left">No DATA</td>
					<td>
					<div align="left">No Data</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td style="text-align: left">No</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="left">No</div>
					</td>
				</tr>
				<%
			i++;
		}
	}
	}
	}
	

NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
%>
				<tr class="sortbottom">
					<td colspan="5" class="hed">Total</td>
					<td class="hed">
					<div align="right"><%=cntos %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntosdur %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntra %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntrda %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntcd %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntdt %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntrating) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavgos) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavgra) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavgrd) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntft %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntfa %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntfc %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavg) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntst %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntrh) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntnd %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(totstopdur) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntdisconn)%></div>
					</td>
					<td class="hed">
					<div align="right">-</div>
					</td>
				</tr>
			</table>
			<%

}catch(Exception e)
{
	System.out.println("Exception" +e);
}
finally
{
		try
		{
			conn.close();
		}catch(Exception e)
		{}
		try
		{
			conn1.close();
		}catch(Exception e)
		{}
		try
		{
			fleetview.closeConnection1();
		}catch(Exception e)
		{}
		try
		{
			fleetview.closeConnection();
		}catch(Exception e)
		{}
		
	
}
%>
			</td>
		</tr>
	</table>
	</div>
	<%
//fleetview.closeConnection1();
//fleetview.closeConnection();
%>
</form>
</jsp:useBean>

<%@ include file="footernew.jsp"%>

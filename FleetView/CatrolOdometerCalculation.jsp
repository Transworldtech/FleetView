<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.VehiclewiseTrips"
		import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
		import="com.transworld.fleetview.framework.OdometerReport"
		import="com.transworld.fleetview.framework.DataFromVehCodeTable"  %>
		
		
<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>
		

<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body bgcolor="lightyellow">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
          <td width="98%" class="featureboxbg">
			<%@ include file="headernew.jsp" %> 
			 </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<%
			String data="",data1="",vehicleCode="",vehicleRegistrationNumber="";		
			%>
			<%
			
			NumberFormat nf = DecimalFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2); 
				
			%>
			<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort"><font color="block" size="2" >Odometer Reading Report</font></td>
			</tr>
			<tr><td>
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
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dy1=date1.substring(0,4);
			dy2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dy1>dy2)
			{
				alert("From date year is should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2) if(dm1>dm2)
			{
				alert("From date month is should not be greater than to date month 5");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dm1==dm2) 
			{
				if(dd1 > dd2)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			return true;
		}

  	</script>
  	<form action="" method="get" onsubmit="return validate();">
			<table border="0" width="100%">
			
			<tr bgcolor="#87CEFA">
			<td><b>Vehicle :</b> 
				<select name="vehicle" id="vehicle">
				<%
				List<VehicleRegistrationNumberList> list=null;
				int numRecords = 0;
				try{
				
					list = vehicleDao.getVehicleRegistrationNumberList(session.getAttribute("VehList").toString());
					 numRecords = list.size();
					 
				} catch(Exception e){
					e.printStackTrace();
				}
				
				
				
				try{
						String dd=request.getQueryString();
						if(!(null==dd))
						{
							data=request.getParameter("data");
							data1=request.getParameter("data1");
							
						}
						else
						{
							data=data1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
						}
						for(int counter=0;counter<numRecords;counter++)
						{
							VehicleRegistrationNumberList vehicleRecord=list.get(counter);
						%>
						<option value="<%=vehicleRecord.getVehicleCode()%>,<%=vehicleRecord.getVehicleRegistrationNumber()%>"><%=vehicleRecord.getVehicleRegistrationNumber()%></option>						
						<%
						}		
					}catch(Exception e)
					{
							e.printStackTrace();					
							}				
				%>			
				</select>
			</td>
			<td align="right"><b>From&nbsp;&nbsp;</b>
			  <input type="text" id="data" name="data"  value="<%=data%>" size="20" readonly/>
  			<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
			<td align="right"><b>To&nbsp;&nbsp;</b>
			  	<input type="text" id="data1" name="data1"  value="<%=data1%>" size="20" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",    // the date format
      			button      : "data1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
			<td>
				<input type="submit" name="Submit" id="submit" value="Submit">
			</td>
		</tr>
		
		</table>
		</form>
		
		</td></tr>
		<%
		
		try
			{
			if(!(null==request.getQueryString()))
			{	
				String ss=request.getParameter("vehicle");
			//	System.out.println("ss"+ss);
				StringTokenizer stk = new StringTokenizer(ss,",");
				vehicleCode=stk.nextToken();
				vehicleRegistrationNumber=stk.nextToken();	
				
				List<OdometerReport> vehicleList=null;
				List<DataFromVehCodeTable> vehCodeList=null;
				int recordCount = 0;
				String startTime="00:00:00";
				String endTime="23:59:59";
				try{
				
					vehicleList = vehicleDao.getOdometerDetails(vehicleCode,data,startTime,data1,endTime);
					recordCount = vehicleList.size();
				//	System.out.println("recordCount="+recordCount);
					 
				} catch(Exception e){
				//	System.out.println("++++++*********+++++++");
					e.printStackTrace();
				}
		%>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Odometer Report for Vehicle <%=vehicleRegistrationNumber%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('printvehiclewisetrips.jsp?data=<%=data%>&data1=<%=data1%>&vehicle=<%=ss%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelvehiclewisetrips.jsp?data=<%=data%>&data1=<%=data1%>&vehicle=<%=ss%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
				
				<th> <b>Driver</b></th>
				<th> <b>Date-Time</b></th>
				<th><b>Odometer Distance</b></th>
				<th><b>GPS Distance</b></th>	
				<th> <b>Ent By</b></th>
			</tr>		
			<%
			int i=1;
			int vehcodeRecord=0;
			if(recordCount>0){
				for(int counter=0;counter<recordCount;counter++){
					double odo=0.0;
					double gpsveh=0;
					
					double odo1=0.0;
					double gpsveh1=0;
					
					double odoDiff=0.0;
					double gpsDiff=0;
					
					String fuelDateTime="";
					String fieldDate="";
					String fieldTime="";
					
					String fuelDateTime1="";
					String fieldDate1="";
					String fieldTime1="";
					
					final OdometerReport currentRecord= vehicleList.get(counter);
					
					if((!(null==currentRecord.getOdometerReading()) || !("null".equalsIgnoreCase(currentRecord.getOdometerReading()))) && !("-".equalsIgnoreCase(currentRecord.getOdometerReading())) && !("".equalsIgnoreCase(currentRecord.getOdometerReading())))
					{
						//System.out.println("not null");
						try{
							//System.out.println("in try 1");
							
							
							//System.out.println("1st odo reading");
							odo=Double.parseDouble(currentRecord.getOdometerReading());	//get first record from t_fuelinfo
						//	System.out.println("odo="+odo);
							fuelDateTime=currentRecord.getDateTime();
						//	System.out.println("fuelDateTime="+fuelDateTime);
							
							
							try{
								//get record from vehcode tbl where datetime is > fuel datetime limit 1 
								
								//System.out.println("1st gps reading");
								vehCodeList=vehicleDao.getDataFromVehCodeTable(vehicleCode,fuelDateTime,"firstRecord");
								vehcodeRecord=vehCodeList.size();
							//	System.out.println("vehcodeRecord===>"+vehcodeRecord);
								if(vehcodeRecord>0){
								for(int cnt=0;cnt<vehcodeRecord;cnt++){
									final DataFromVehCodeTable vehrecord = vehCodeList.get(cnt);
								//	System.out.println("get gps data");
									
										fieldDate=vehrecord.getFromDate();
										fieldTime=vehrecord.getFromTime();
										gpsveh=Double.parseDouble(vehrecord.getGPSDistance());
									//	System.out.println("gpsveh="+gpsveh);
									}
								}
							}
							catch(Exception e){
								e.printStackTrace();
							}
							
						//	System.out.println(counter+1);
							for(int count=counter+1;count<recordCount;count++){ 
								
								final OdometerReport nextRecord= vehicleList.get(count);
								//System.out.println("**********88");
							if((!(null==nextRecord.getOdometerReading()) || !("null".equalsIgnoreCase(nextRecord.getOdometerReading()))) && !("-".equalsIgnoreCase(nextRecord.getOdometerReading())) && !("".equalsIgnoreCase(nextRecord.getOdometerReading())))
							{
								//System.out.println("not null 2");
							odo1=Double.parseDouble(nextRecord.getOdometerReading()); //get second record from t_fuelinfo
							//System.out.println("1st odo reading");
							fuelDateTime1=nextRecord.getDateTime();
						//	System.out.println("odo1="+odo1);
							
							try{
								//get record from vehcode tbl where datetime is < fuel datetime limit 1 
								vehCodeList=vehicleDao.getDataFromVehCodeTable(vehicleCode,fuelDateTime1,"secondRecord");
								vehcodeRecord=vehCodeList.size();
							//	System.out.println("vehcodeRecord===>"+vehcodeRecord);
								if(vehcodeRecord>0){
								for(int cnt=0;cnt<vehcodeRecord;cnt++){
									final DataFromVehCodeTable vehrecord = vehCodeList.get(cnt);
										fieldDate1=vehrecord.getFromDate();
										fieldTime1=vehrecord.getFromTime();
										gpsveh1=Double.parseDouble(vehrecord.getGPSDistance());
									//	System.out.println("gpsveh1="+gpsveh1);
									}
								}
							}
							catch(Exception e){
								e.printStackTrace();
							}
							
							break; //if we get a record wich is not null then break else go to next record
								}
							else{
							//	System.out.println("continue");
								
								continue;
							}
							}
							
						}
						catch(Exception e){
							
						}
						if(odo1==0){
							break;
						
						}
						else{
							odoDiff=odo1-odo;
							gpsDiff=gpsveh1-gpsveh;
						//	System.out.println("odoDiff="+odoDiff);
						//	System.out.println("gpsDiff="+gpsDiff);
							%>
							<tr>
							
							<td><%=i++ %></td>
							<td><%=currentRecord.getDriver() %></td>
							<td><%=currentRecord.getDateTime() %></td>
							<td><%=odoDiff %></td>
							<td><%=gpsDiff %></td>
							<td><%=currentRecord.getEnteredBy() %></td>
							</tr>
							<%
						}
						
					}
					
					
				}
		}
			}
			}
		catch(Exception e){
			e.printStackTrace();	
		}
				%>
				
		
			
    </table>
        <%@ include file="footernew.jsp" %>
    </body>
</html>
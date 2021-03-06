<%@ include file="headerprintnew.jsp" %>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.GetVehicleDetails"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.TimeSlotsData"
		import="com.transworld.fleetview.framework.HourlyVehiclewiseDetails"
		import="com.transworld.fleetview.framework.HourlyVehiclewiseAverageDetails"%>


<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<table border="0" width="98%" bgcolor="white" align="center">
<tr>
<td align="center">
			<div align="left"><font size="3" >Report No: 1.11</font></div>
			<font  size="3" ><b>Hourly Run Report</b></font>

</td>
</tr>


<!-- code start here -->
<%! 
String date1="", date2,date3,vehcode,vehregno,time1="",time2="",h1,chdate,t1="",t2="",runtime,stoptime,finaldate="";
int dist,dist1,dist2;
int maxspeed;
double avgspeed;
String startplace,endplace;
int distc;
String lat1="",lon1="",lat2="",lon2="";
Object dateformat;
%>
<%
	dateformat = session.getAttribute("dateformat");
	vehcode=request.getParameter("vehcode");
	h1=request.getParameter("h1");
	if(h1.equals("no"))
	{
	
	java.util.Date NewDate =new java.util.Date();
	Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
	Format NewFormatter2 = new SimpleDateFormat("HH:mm:ss");
	date2 = NewFormatter1.format(NewDate);
	date1=date2;
	time1="00:00:00";
	time2 = NewFormatter2.format(NewDate);
	}
	else
	{
	date1=request.getParameter("calender");
	date2=date1;
	java.util.Date NewDate =new java.util.Date();
	Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
	Format NewFormatter2 = new SimpleDateFormat("HH:mm:ss");
	chdate = NewFormatter1.format(NewDate);
	if(date2.equals(chdate))
	{
		time1="00:00:00";
		time2=NewFormatter2.format(NewDate);	
	}
	else
	{
		time1="00:00:00";
		time2="23:59:59";
	}
	}
	//out.print(date1+"  "+date2);
	//out.print("<br>"+time1+"  "+time2);
try{
	List<GetVehicleDetails> currRecord=null; 
	int numRecords11 = 0;
	try {
		currRecord = vehicleDao.getVehicleDetails(vehcode);
		numRecords11 = currRecord.size();
	} catch (Exception e) {
		e.printStackTrace();
	}
	
		vehregno=currRecord.get(0).getVehicleRegistrationNumber();
		
%>

<table border="0" width="100%" align="center" class="stats">
<tr>
</tr>
<tr >
<td align="center"><font size="3"><b>Hourly Run Report For vehicle <%=vehregno%> For Date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1)) %></b></font></td>
</tr>
</table>
</form>
</td></tr></table>

<table width="100%" border="1" align="center" class="sortable">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Running Time</th>
<th>Stoppage Time</th>
<th>Avg. Speed</th>
<th>Distance Covered</th>
<th>Max. Speed</th>
<th>Starting Point</th>
<th>End Point</th>
</tr>
<%

List<TimeSlotsData> slotList=null;
int recordCount=0;


try{
	slotList = vehicleDao.getTimeSlotsData(time2);
	recordCount = slotList.size();
	//System.out.println("TimeSlotcount---> "+recordCount);
	}
catch(Exception e)
{
	e.printStackTrace();
}

int i=1;
int count=1;
for(int counter=0;counter<recordCount;counter++)
{
	
	
	if(counter==0)
	{
	t1=slotList.get(counter).getTimeSlot1().toString();
	try{
	t2=slotList.get(counter+2).getTimeSlot1().toString();
	}
	catch(Exception e){
		t2="0";
	}
	}
	else
	{
		try{
			counter++;
			t1=slotList.get(counter).getTimeSlot1().toString();
			try{
				t2=slotList.get(counter+2).getTimeSlot1().toString();
				}
				catch(Exception e){
					t2="0";
				}
		}
		catch(Exception e)
		{
			t2="0";
		}
		
	}
	/*System.out.println("counter---> "+counter);
	System.out.println("Time1---> "+t1);
	System.out.println("Time2---> "+t2);*/
	
	//if(count==1){

		List<HourlyVehiclewiseDetails> timeList = null;
		timeList = vehicleDao.getHourlyVehiclewiseDetails(vehcode,date1,date1,t1,t2,"time");
		if(timeList.size()>0){
			finaldate=timeList.get(0).getFromDate();
			t1=timeList.get(0).getFromTime();
			
		}
		count=count+1;
	//}
	//else{
	//	finaldate=date1;
	//}
	if(t1.equals("23:00:00")|| counter==48)
	{
		t2="23:59:59";
	}
	if(!("0".equalsIgnoreCase(t2)))
	{
		if(!(t2.equals(t1)))
		{
			List<HourlyVehiclewiseDetails> hourlyList = null;
			
			int recorCount = 0;
			
			try{
				hourlyList =  vehicleDao.getHourlyVehiclewiseDetails(vehcode,finaldate,date1,t1,t2,"hour");
				recorCount = hourlyList.size();
				//System.out.println("@@@@@@@@@@@HourlyVehiclewiseDetails@@@@@@@@@@@");
				//System.out.println("HourlyListCount---> "+recorCount);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
			startplace="No Data";
			endplace="No Data";
			dist1=0;
			dist2=0;
			dist=0;
			distc=0;
			avgspeed=0;
			maxspeed=0;
			runtime="No Data";
			stoptime="No Data";
			
				
				//System.out.println("hellooooooooooo");
				
					if(recorCount>0){
				HourlyVehiclewiseDetails currentRecord = hourlyList.get(0);
				
				HourlyVehiclewiseDetails lastRecord =  hourlyList.get(recorCount-1);
				
				dist1=Integer.parseInt(currentRecord.getDistance());
				startplace=currentRecord.getLocation().toString();
				lat1=currentRecord.getLatitude().toString();
				lon1=currentRecord.getLongitude().toString();
			/*	System.out.println("dist1--->"+dist1);
				System.out.println("startplace--->"+startplace);
				System.out.println("lat1--->"+lat1);
				System.out.println("lon1--->"+lon1);*/
				
				dist2=Integer.parseInt(lastRecord.getDistance());
				endplace=lastRecord.getLocation().toString();
				lat2=lastRecord.getLatitude().toString();
				lon2=lastRecord.getLongitude().toString();
			/*	System.out.println("dist2--->"+dist2);
				System.out.println("endplace--->"+endplace);
				System.out.println("lat2--->"+lat2);
				System.out.println("lon2--->"+lon2);*/
				
				dist=dist2-dist1;
				//System.out.println("Distance diff---> "+dist);
				if(dist <=0)
				{
					maxspeed=0;
					avgspeed=0;
					runtime="00 Hrs. 00";
					stoptime="01 Hrs. 00";
					//System.out.println("maxspeed--->"+maxspeed);
					//System.out.println("avgspeed--->"+avgspeed);
					//System.out.println("runtime--->"+runtime);
					//System.out.println("stoptime--->"+stoptime);
				}
				else
				{
					List<HourlyVehiclewiseAverageDetails> hourlyAverageList = null;
					int recordCnt=0;
					
					try{
						hourlyAverageList = vehicleDao.getHourlyVehiclewiseAverageDetails(vehcode,finaldate,date1,t1,t2);
						recordCnt = hourlyAverageList.size();
						//System.out.println("@@@@@@@@@@@HourlyVehiclewiseAverageDetails@@@@@@@@@@@");
						//System.out.println("hourlyAvgList---> "+recordCnt);
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
					
					try{
						avgspeed=Double.parseDouble(hourlyAverageList.get(0).getAverageSpeed());
						//System.out.println("----avgspeed--->"+Double.parseDouble(hourlyAverageList.get(0).getAverageSpeed()));
						maxspeed=Integer.parseInt(hourlyAverageList.get(0).getMaximumSpeed());
						
					}
					catch(Exception e){
						//avgspeed=0;
						//maxspeed=0;
					}
					//System.out.println("dist n speed--->"+dist+"--"+Double.parseDouble(hourlyAverageList.get(0).getAverageSpeed()));
					double tt=0;
					if(avgspeed!=0)
					{
						tt=(dist/avgspeed)*60;
					}
						
						int thett=(int)tt;
						int thett1=60-thett;
						
					 /* System.out.println("finalDate===>"+finaldate+"-----"+date1+"--"+t1+"--"+t2+"--"+avgspeed+"--"+maxspeed);
						System.out.println("tt--->"+tt);
						System.out.println("thett--->"+thett);*/
						
						
						if(thett==60)
						{
							runtime="01 Hrs.00";
						}
						else if(thett<10)
						{
							runtime="00 Hrs.0"+thett;
						}
						else{
							runtime="00 Hrs."+thett;
						}
						//runtime=runtime.substring(0,9);
						if(thett1==60)
						{
							stoptime="01 Hrs.00";
						}
						else if(thett1<10)
						{
							stoptime="00 Hrs.0"+thett1;
						}
						else
						{
							stoptime="00 Hrs."+thett1;
						}
						/*System.out.println("maxspeed--->"+maxspeed);
						System.out.println("avgspeed--->"+avgspeed);
						System.out.println("runtime--->"+runtime);3577
						System.out.println("stoptime--->"+stoptime);*/
				}
				}//if end
				
				/*System.out.println("In td block");
				System.out.println("maxspeed--->"+maxspeed);
				System.out.println("avgspeed--->"+avgspeed);
				System.out.println("runtime--->"+runtime);
				System.out.println("stoptime--->"+stoptime);
				System.out.println("dist1--->"+dist1);
				System.out.println("startplace--->"+startplace);
				System.out.println("lat1--->"+lat1);
				System.out.println("lon1--->"+lon1);
				System.out.println("dist2--->"+dist2);
				System.out.println("endplace--->"+endplace);
				System.out.println("lat2--->"+lat2);
				System.out.println("lon2--->"+lon2);
				System.out.println("Distance diff---> "+dist);
				System.out.println("End of td block");*/
				%>
				
				<tr>
					<td style="text-align: right"><%=i %></td>
						<td style="text-align: left">
						<%=new SimpleDateFormat(dateformat.toString()+" HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(finaldate+" "+t1))%>
						</td>
						<td style="text-align: left">
						<%
						
						%>
						
						<%=runtime%></td>
						<td style="text-align: left"><%=stoptime%></td>
						<td><div align="right"><%=(int)avgspeed%></div></td>
						<td><div align="right">
						<%
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{ %>
							<%=(int)Utilities.KM_TO_MILES1(dist)%>
						<%
							}else{
						%>
							<%= dist%>
						<%	} %>
						</div></td>
						<td><div align="right"><%=maxspeed%></div></td>
						<td><div align="left">
						<%
						if(startplace.equals("No Data"))
						{
						out.print(startplace);
						}
						else
						{
							out.print(startplace);
							//out.print(fleetview.showNewMap(lat1,lon1,startplace));
						}
						%></div></td>
						<td><div align="left">
							<%
						if(endplace.equals("No Data"))
						{
						out.print(endplace);
						}
						else
						{
							out.print(endplace);
							//out.print(fleetview.showNewMap(lat2,lon2,endplace));
						}
						%>
						</div>
						</td>
					</tr>
				<%
		}
		i++;
	}
	else{}
	
}
%>
</table>
<table class="stats">
<tr>
<td><center><font size="1">Note:- The data is displayed from one record previous to selected date 
for distance accuracy purpose.</font></center></td>
</tr>
</table>

<%




}catch(Exception e)
{
	//System.out.println("fff-fff");
	e.printStackTrace();
}

%>

<!-- code end here -->


			
<%@ include file="footernew.jsp" %>

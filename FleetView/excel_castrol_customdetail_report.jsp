<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"customdetail_report.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ page import="com.transworld.fleetview.framework.VehicleDao"
		 import="com.transworld.fleetview.framework.ZoneIdentificationForLocation" %>
<%@ include file="../Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<jsp:useBean
	id="vehicleDao" type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String datenew1,datenew2;
Connection conn;
Statement st,sttemp;
String sql;
boolean flag=true;
%>
<%
String targetvalue1=session.getAttribute("usertypevalue").toString();
targetvalue1=session.getAttribute("usertypevaluemain").toString();
String dateformat="dd-MMM-yyyy";
dateformat=session.getAttribute("dateformat").toString();

ArrayList<String> target1=(ArrayList<String>)session.getAttribute("TargetList");
String empnamee="";


List<ZoneIdentificationForLocation> zoneColor = null;
int numRecords = 0;
String bgColor="";

String VehicleCode = request.getParameter("vehcode");
String vehicleRegistrationNo = request.getParameter("vehicleRegistrationNo");
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");


try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sttemp=conn.createStatement();
	
%>
<table border="0" width="100%" bgcolor="white">  
<tr align="center">
<td>
<div align="left"><font size="3">Report No:1.12</font></div>
 <font size="3"><div ><b>Custom Detail Report<b></div></font></center>
<div class="bodyText" align="right">

</div>
</td>
</tr>

<tr><td>
<%
	if(!(null==request.getParameter("data")))
			{
	fromdate=request.getParameter("data");
	todate=request.getParameter("data1");	
	fromtime =request.getParameter("fromtime");
	totime =request.getParameter("totime");
	//out.print(fromtime+"  "+totime);
			}
	%>
<%

if(!(null==request.getParameter("data")))
{
	/* all code comes here */
	%>
	<table width="100%" align="center">
	<tr>
	<td align="center" colspan="7"><font size="3"><b> Detail Report for Vehicle <%=vehicleRegistrationNo%> from <%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdate+" "+fromtime)) %>  to <%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todate+" "+totime))%> </b></font>

	</td></tr>
	</table>

	<table width="100%" align="center" class="sortable" border="1">
	<tr>
	<th>Sr.</th>
	<th>Date-Time</th>
	<th>Speed</th>
	<th>Distance</th>
	<th align="left">Location</th>

	<%
	String sqlchecksensorveh="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
	ResultSet rsttemp=sttemp.executeQuery(sqlchecksensorveh);
	if(rsttemp.next())
	{
		%>
		<th>Sen1</th>
		<th>Sen2</th>
		<th>Sen3</th>
		<th>Sen4</th>
		<% 
	}
	%>
	</tr>
	<%
	String sqlnew="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+fromdate+" "+fromtime+"' order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc limit 1";
	ResultSet rstnew=st.executeQuery(sqlnew);
	if(rstnew.next())
	{
		fromdate=rstnew.getString("TheFieldDataDate");
		fromtime=rstnew.getString("TheFieldDataTime");
		//System.out.println("fromdate---->"+fromdate+"fromtime-->"+fromtime);
		
	}

	sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+todate+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
	//System.out.println(sql);
	ResultSet rst1=st.executeQuery(sql);
	int i=1;
	int x=0;
	int dist=0;

	if(rst1.first())
	{
		try{
			zoneColor = vehicleDao.getZoneColor(rst1.getString("LatinDec"),rst1.getString("LonginDec"));
			numRecords = zoneColor.size();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		String firstRec="",secRec="";
		String firstColor="",secondColor;
		String colorOS="";	
		double distance = 0;
		if(numRecords>0){
			int track1=Integer.parseInt(zoneColor.get(0).getTrackID());
			int track2=Integer.parseInt(zoneColor.get(1).getTrackID());
			double firstDistance  = Double.parseDouble(zoneColor.get(0).getDistance());
			double secondDistance  = Double.parseDouble(zoneColor.get(1).getDistance());
			
			firstColor=zoneColor.get(0).getZoneColor();
			secondColor=zoneColor.get(1).getZoneColor();
			if(firstColor.equalsIgnoreCase(secondColor))
			{
				colorOS=secondColor;
				distance = secondDistance;
			}
			else{
				if(track1>track2){
					colorOS = secondColor;
					distance = secondDistance;
				}
				else{
					colorOS = firstColor;
					distance = firstDistance;
				}
			}
		}
		if(distance<1){
			if("Green".equalsIgnoreCase(colorOS)){
			//System.out.println("GREEN");
			bgColor = "background-color:#00C000";
			}
			else if("Red".equalsIgnoreCase(colorOS)){
			//System.out.println("RED");
			bgColor= "background-color:#FF0000";
			}
			else if("Yellow".equalsIgnoreCase(colorOS)){
			//System.out.println("YELLOW");
				bgColor="background-color:#FFFF00";
			}
			else{
				bgColor="";
			}
		}
		else{
			bgColor="";
		}
		
		if(i==1)
		{
			dist=rst1.getInt("Distance");
			//System.out.println("dist::>>"+dist);
		}
	%>
		<tr>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
			<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
			<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			 %>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
			
			<%
		}else
		{
			%>
			<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
			
			<%
		}
		
		if(target1.contains(targetvalue1))
					{
							String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
							</div></td>
							<%
					}
					else
					{
						%>
			
			
			<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %>
			</div></td>
			<%
					}
			
	String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
	ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
	if(rsttemp1.next())
	{
		
		if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
			<%		
		}
		else
		{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
		<%
		}
		if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
			<%		
		}
		else
		{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
		<%
		}
		if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
			<%		
		}
		else
		{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
		<%
		}
		if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
			<%		
		}
		else
		{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
		<%
		}
		%>
		<% 
	}
	%>
		</tr>
	<%
	i++;

	}

	while(rst1.next())
	{
		try{
			zoneColor = vehicleDao.getZoneColor(rst1.getString("LatinDec"),rst1.getString("LonginDec"));
			numRecords = zoneColor.size();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		String firstRec="",secRec="";
		String firstColor="",secondColor;
		String colorOS="";	
		double distance=0;
		if(numRecords>0){
			int track1=Integer.parseInt(zoneColor.get(0).getTrackID());
			int track2=Integer.parseInt(zoneColor.get(1).getTrackID());
			double firstDistance  = Double.parseDouble(zoneColor.get(0).getDistance());
			double secondDistance  = Double.parseDouble(zoneColor.get(1).getDistance());
			firstColor=zoneColor.get(0).getZoneColor();
			secondColor=zoneColor.get(1).getZoneColor();
			if(firstColor.equalsIgnoreCase(secondColor))
			{
				colorOS=secondColor;
				distance = secondDistance;
			}
			else{
				if(track1>track2){
					colorOS = secondColor;
					distance = secondDistance;
				}
				else{
					colorOS = firstColor;
					distance = firstDistance;
				}
			}
		}
		
		if(distance<1){
			if("Green".equalsIgnoreCase(colorOS)){
				//System.out.println("GREEN");
				bgColor = "background-color:#00C000";
			}
			else if("Red".equalsIgnoreCase(colorOS)){
				//System.out.println("RED");
				bgColor= "background-color:#FF0000";
			}
			else if("Yellow".equalsIgnoreCase(colorOS)){
				//System.out.println("YELLOW");
				bgColor="background-color:#FFFF00";
			}
			else{
				bgColor="";
			}
		}
		else{
			bgColor="";
		}
		
		if(rst1.getString("TheFiledTextFileName").equals("SI"))
		{
			
			if(rst1.getInt("Speed")==0)
			{
				
				if(flag)
				{
					//System.out.println("HIIIIIIIII");
					flag=false;
					x=1;
					%>
					<tr>
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
						<td style="<%=bgColor%>" class="bodyText" ><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
					<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			 %>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
			
			<%
		}else
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
			
			<%
		}
						
						if(target1.contains(targetvalue1))
						{
							String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject") %></a>
							</div></td>
							<%
						}
						else
						{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %>
						</div></td>
						<%
						}
						%>
						<%
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
						
					</tr>
					<%
					i++;
				}
			}
			
			else
			{//SI wid  sp>0
				if(x==1)
				{
					flag=true;
					%>
					<tr>
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="Start"%></div></td>
						<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			 %>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
			
			<%
		}else
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
			
			<%
		}
						if(target1.contains(targetvalue1))
						{
							String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject") %>
							</div></td>
							<%
						}
						else
						{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %>
						</div></td>
						<%
						}
						%>
						<%
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
					</tr>
					<%
					i++;
					x++;
				}
				
				flag=true;	
				%>
				<tr>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=i%></div></td>
					<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
					
					<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			 %>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
			
			<%
		}else
		{
			%>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
			
			<%
		}
						if(target1.contains(targetvalue1))
						{
							String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
							%>
							<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject")%>
							</div></td>
							<%
						}
						else
						{
						%>
					
					<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject")%>
					</div></td>
					<%
						}
					%>
					<%
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
				</tr>
				<%
				i++;
			}
		}//ens of SI check
		else
	    {
			if(rst1.getString("TheFiledTextFileName").equals("OF"))
	    
			{
				String long1,long2,long3,lat1,lat2,lat3,loc1,loc2,loc3;
				int ds1,ds2,ds3;
				java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
				loc1=rst1.getString("TheFieldSubject");
				lat1=rst1.getString("LatinDec");
				long1=rst1.getString("LonginDec");
				ds1=rst1.getInt("Distance");
				if(rst1.next())
				{
					if(rst1.getString("TheFiledTextFileName").equals("ON")||rst1.getString("TheFiledTextFileName").equals("SI"))
					{
						if(rst1.getString("TheFiledTextFileName").equals("SI"))
						{
							java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
							loc2=rst1.getString("TheFieldSubject");
							lat2=rst1.getString("LatinDec");
							long2=rst1.getString("LonginDec");
							ds2=rst1.getInt("Distance");
							long hrs=00,mins=00;
							long mils1=dt1.getTime();
							long mils2=dt2.getTime();
							long mils3=mils2-mils1;
							mils3=mils3/1000/60;
							
							if(mils3 > 20)
							{
								%>
								<tr>
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt1)%></div></td>
							<%
							if(mils3>=60)
							{
								hrs=mils3/60;
								mins=mils3%60;
								%>
								<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
								<%								
							}
							
							else
							{
								
								%>
							<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
							<%
							}
							if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
							{
							 %>
							
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds1-dist)%></div></td>
							<% }
							else
							{
								%>
								<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds1-dist%></div></td>
								<%
							}
								if(target1.contains(targetvalue1))
								{
							String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc1 %>
							</div></td>
							<%
								
							}
							else
								{
								%>
										
										
										<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc1 %>
										</div></td>
										<%
								}
										%>
										<%
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
										</tr>
										<%		
						i++;
						%>
						
						<tr>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
													<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
													<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
													<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
													{
													 %>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
													<% }
													else
													{
													%>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds2-dist%></div></td>
													<%
													}
													if(target1.contains(targetvalue1))
													{
													String d3=empnamee+"<br>"+loc2;
												%>
												<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc2 %>
												</div></td>
												<%
												}
												else
													{
													%>
															
															<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc2 %>
															</div></td>
															<%
													}
															%>
															<%
				String sqlchecksensorveh11="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp11=sttemp.executeQuery(sqlchecksensorveh11);
				if(rsttemp11.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
														</tr>	
														<%		
						i++;
						%>
						
						
						<tr>
													<td  style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
													<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
													<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="START"%></div></td>
													<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
													{
													 %>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
													<% }
													else
													{
													%>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds2-dist%></div></td>
													<%
													}
													if(target1.contains(targetvalue1))
													{
												String d3=empnamee+"<br>"+loc2;
												%>
												<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc2 %>
												</div></td>
												<%
												}
												else
													{
													%>
															
															<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc2 %>
															</div></td>
															<%
													}
															%>
															<%
				String sqlchecksensorveh111="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp111=sttemp.executeQuery(sqlchecksensorveh111);
				if(rsttemp111.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
														</tr>	
														<%		
						i++;
						flag=true;
						%>
						
						
						<tr>
								<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=i%></div></td>
								<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
								<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
								<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
													{
													 %>
													<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
													<% }
													else
													{
													%>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds2-dist%></div></td>
													<%
													}
								if(target1.contains(targetvalue1))
								{
							String d2=empnamee+"<br>"+loc2;
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc2 %>
							</div></td>
							<%
							}
							else
								{
								%>
										
										<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc2 %>
										</div></td>
										<%
								}
										%>
										<%
				String sqlchecksensorveh1111="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1111=sttemp.executeQuery(sqlchecksensorveh1111);
				if(rsttemp1111.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
									</tr>	
									<%
									i++;
							}
						}//end of SI check after OF stamp
						
						else if(rst1.getString("TheFiledTextFileName").equals("ON"))
						{
							java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
							loc2=rst1.getString("TheFieldSubject");
							lat2=rst1.getString("LatinDec");
							long2=rst1.getString("LonginDec");
							ds2=rst1.getInt("Distance");
							long hrs=00,mins=00;
							long mils1=dt1.getTime();
							long mils2=dt2.getTime();
							long mils3=mils2-mils1;
							mils3=mils3/1000/60;
							
							if(mils3 > 20)
							{
								if(rst1.next())
								{
									if(rst1.getString("TheFiledTextFileName").equals("SI"))
									{
										loc3=rst1.getString("TheFieldSubject");
										//System.out.println("Stamp::>>"+rst1.getString("TheFiledTextFileName"));
										lat3=rst1.getString("LatinDec");
										long3=rst1.getString("LonginDec");
										ds3=rst1.getInt("Distance");
										
										%>
										<tr>
									<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
									<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt1)%></div></td>
									<%
									if(mils3>=60)
									{
										hrs=mils3/60;
										mins=mils3%60;
										%>
										<td style="<%=bgColor%>"  class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
										<%								
									}
									
									else
									{
										
										%>
									<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
									<%
									}
									%>
									
									
									<%
							
							if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
							{
							 %>
							
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds1-dist)%></div></td>
							<% }
							else
							{
								%>
								<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds1-dist%></div></td>
								<%
							}
										if(target1.contains(targetvalue1))
										{
									String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
									%>
									<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc1 %>
									</div></td>
									<%
										
									}
									else
										{
										%>
												
												
												<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc1 %>
												</div></td>
												<%
										}
												%>
												<%
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
												</tr>
												<%		
										i++;
												%>
												<tr>
													<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
													<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
													<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
													<%
							
							if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
							{
							 %>
							
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds3-dist)%></div></td>
							<% }
							else
							{
								%>
								<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=ds3-dist%></div></td>
								<%
							}
													if(target1.contains(targetvalue1))
													{
												String d3=empnamee+"<br>"+loc3;
												%>
												<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc3 %>
												</div></td>
												<%
												}
												else
													{
													%>
															
															<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc3 %>
															</div></td>
															<%
													}
															%>
															<%
				String sqlchecksensorveh2="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp2=sttemp.executeQuery(sqlchecksensorveh2);
				if(rsttemp2.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
														</tr>	
														<%
														i++;
														if(rst1.getInt("Speed")==0)
														{%>
															<tr>
															<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
															<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
															<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
																		<%
							
							if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
							{
							 %>
							
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds3-dist)%></div></td>
							<% }
							else
							{
								%>
								<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds3-dist%></div></td>
								<%
							}
															if(target1.contains(targetvalue1))
															{
																String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
																%>
																<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=loc3 %>
																</div></td>
																<%
															}
															else
															{
															%>
															<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=loc3%>
															</div></td>
															<%
															}
															%>
															<%
				String sqlchecksensorveh3="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp3=sttemp.executeQuery(sqlchecksensorveh3);
				if(rsttemp3.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
	}
												
		%>
														</tr>
														<%
														i++;
														}
								
									}
								}
							}
						}//end of ON stamp after OF stamp
					}//end of SI or ON stamp check
				}
			}//end of OF stamp check
			//flag=true;
	    }
	}//end of while loop

					
						

			
	if(rst1.last())
	{
		
		try{
			zoneColor = vehicleDao.getZoneColor(rst1.getString("LatinDec"),rst1.getString("LonginDec"));
			numRecords = zoneColor.size();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		String firstRec="",secRec="";
		String firstColor="",secondColor;
		String colorOS="";	
		double distance=0;
		if(numRecords>0){
			int track1=Integer.parseInt(zoneColor.get(0).getTrackID());
			int track2=Integer.parseInt(zoneColor.get(1).getTrackID());
			double firstDistance  = Double.parseDouble(zoneColor.get(0).getDistance());
			double secondDistance  = Double.parseDouble(zoneColor.get(1).getDistance());
			
			firstColor=zoneColor.get(0).getZoneColor();
			secondColor=zoneColor.get(1).getZoneColor();
			if(firstColor.equalsIgnoreCase(secondColor))
			{
				colorOS=secondColor;
				distance=secondDistance;
			}
			else{
				if(track1>track2){
					colorOS = secondColor;
					distance = secondDistance;
				}
				else{
					colorOS = firstColor;
					distance = firstDistance;
				}
			}
		}
		if(distance<1){
			if("Green".equalsIgnoreCase(colorOS)){
				//System.out.println("GREEN");
				bgColor = "background-color:#00C000";
			}
			else if("Red".equalsIgnoreCase(colorOS)){
				//System.out.println("RED");
				bgColor= "background-color:#FF0000";
			}
			else if("Yellow".equalsIgnoreCase(colorOS)){
				//System.out.println("YELLOW");
				bgColor="background-color:#FFFF00";
			}
			else{
				bgColor="";
			}
		}
		else{
			bgColor="";
		}
		
	%>
		<tr>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
			<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
			<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
			<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
			{
				 %>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
			<%}else
			{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
			<%}
					if(target1.contains(targetvalue1))
					{
							String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
							%>
							<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject") %>
							</div></td>
							<%
					}
					else
					{
						%>
			
			
			<td style="<%=bgColor%>"  class="bodyText"><div align="left">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %>
			</div></td>
			<%
					}
					
					String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
					ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
					if(rsttemp1.next())
					{
						
						if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
						{
							%>
							<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
						<%
						}
						if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
						{
							%>
							<td  style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
						<%
						}
						if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
						{
							%>
							<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
						<%
						}
						if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
						{
							%>
							<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
						<%
						}
						%>
						<% 
	}
			%>
		</tr>
	<%
	i++;

	}
	%>
	</table>
	<%
	/* code end here*/
}

%>
</td></tr>
<tr>
<td><center><font size="1">Note:- The data is displayed from one record previous to selected date 
for distance accuracy purpose.</font></center></td>
</tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
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
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
<% //fleetview.closeConnection(); %>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>

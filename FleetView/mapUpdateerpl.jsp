<%@page import="java.util.Date"%>

<%@ include file="Connections/conn.jsp" %>
<% 
try{
	Class.forName(MM_dbConn_DRIVER);
	}
catch(ClassNotFoundException e)
	{
	out.println(e.toString());
	} 
Connection con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt=con.createStatement();
Statement stmt1=con.createStatement();
Statement st=con.createStatement();
Statement st123=con.createStatement();
%>
<%
try
{

	//String mapid=request.getParameter("id");
	//System.out.println("getting mapid..."  +mapid);
	String Status=request.getParameter("status");
	System.out.println("getting status..."  +Status);
	String vehicleList=session.getAttribute("VehList").toString();
	System.out.println("getting status..."  +vehicleList);
	String typeValue=session.getAttribute("usertypevalue").toString();
	int e=1,w=1,n=1,s=1;
	int i=1;
	double speed=0;
	final int disConnected = Integer.parseInt(session.getAttribute("desconnected").toString());
	String Currdate="No Trip Data";
	//System.out.println("Date is"+Currdate);
	double lastDayKm=0,distanceTraveledTillNow=0,distanceTraveledToday=0; 
	String vehicleUpdate="<table width='100%' class='sortable'>";
	String vehicleUpdate1="<table width='100%' class='sortable'>";
	String vehicleUpdate2="<table width='100%' class='sortable'>";
	String vehicleUpdate3="<table width='100%' class='sortable'>";
	String vehicleUpdate4="<table width='100%' class='sortable'>";
	String markerlist="@",ignition="",devstatus="";
	String test="test", lat="-",lon="-",vehregno="-",speed1="",thedate="-",thetime="-",drivemob="",UnitID="",installeddate="",senserpm="",datetime="-",sql1="",location="",stamp="",bgcolor="",vehcode = "",tripid = "-";
	int valrpm=0;
	String origin = "-",dest = "-",drivid = "-",drivname = "-",TimeDiff="",startcode="",endcode="";
	vehicleUpdate+="<tr><th>No</th><th>Veh.NO</th><th>Updated DateTime</th><th>Speed</th></tr>";
	vehicleUpdate1+="<tr><td><div align=^center^><font size='2'>EAST</font></div></td></tr><tr><th>No</th><th>Veh.NO</th><th>Updated DateTime</th><th>Speed</th></tr>";
	vehicleUpdate2+="<tr><td><font size='2'>WEST</font></td></tr><tr><th>No</th><th>Veh.NO</th><th>Updated DateTime</th><th>Speed</th></tr>";
	vehicleUpdate3+="<tr><td><font size='2'>NORTH</font></td></tr><tr><th>No</th><th>Veh.NO</th><th>Updated DateTime</th><th>Speed</th></tr>";
	vehicleUpdate4+="<tr><td><font size='2'>SOUTH</font></td></tr><tr><th>No</th><th>Veh.NO</th><th>Updated DateTime</th><th>Speed</th></tr>";
	
	String sqlonline = "SELECT d.TransporterName, CASE WHEN e.MessageId IS NOT NULL THEN 'Blocked' ELSE '' END AS Blocked, " +
	"	d.VehicleRegNo, d.VehicleCode, b.TheDate,b.TimeDiff, b.TheTime, b.Location AS CurrentLocation, d.UnitId, b.Status," +
	"	b.Ignition, b.TheSpeed AS Speed, " +
	"	CASE WHEN d.Status IS NULL THEN ''" +
	"	WHEN d.Status = 'Missing' THEN 'Device Missing'" +
	"	WHEN d.Status = 'DeActivated' THEN 'Device Deactivated'" +
	"	WHEN d.Status = 'Removed' THEN 'Device Removed'" +
	"	WHEN (b.VehicleCode IS NULL AND InstalledDate IS NOT NULL) THEN 'Device Installed But Inactive'" +		
	"	ELSE '' END AS DeviceStatus,b.LatitudePosition, b.LongitudePosition,b.TheID,b.LastDayKm,b.TheDistance " +
	"FROM (SELECT DISTINCT(VehicleCode),OwnerName AS TransporterName,Status,InstalledDate,Description,InstalledPlace," +
	"				VehicleRegNumber  AS VehicleRegNo, UnitID AS UnitId" +
	"		FROM t_vehicledetails WHERE " +
	"          VehicleCode IN " + vehicleList + " " +
	") d INNER JOIN t_onlinedata b ON (d.`VehicleCode` = b.`VehicleCode` AND b.UnitId IS NOT NULL And b.TheDate IS NOT NULL) "+
	"LEFT OUTER JOIN t_usermessage e ON (d.TransporterName = e.UserTypeValue AND e.MessageId = 4) "+ 
	" ORDER BY concat(b.TheDate,' ',b.TheTime) DESC ";
	ResultSet rsonline = stmt.executeQuery(sqlonline);
	while(rsonline.next())
	{
		vehregno=rsonline.getString("VehicleRegNo");
		vehcode = rsonline.getString("VehicleCode");
		speed=rsonline.getDouble("Speed");
		speed1=Double.toString(speed);
		thedate=rsonline.getString("TheDate");
		thetime=rsonline.getString("TheTime");
	//	if(thedate.equalsIgnoreCase(null) || thedate.equalsIgnoreCase("null") || thetime.equalsIgnoreCase("null") || thetime.equalsIgnoreCase(null))
	//	{
	//		thedate="";
	//		thetime="";
	//	}
		
		lat = rsonline.getString("LatitudePosition");
		lon = rsonline.getString("LongitudePosition");
		location = rsonline.getString("CurrentLocation");
		stamp = rsonline.getString("TheID");
		lastDayKm=rsonline.getDouble("LastDayKm");
		distanceTraveledTillNow=rsonline.getDouble("TheDistance");
		ignition = rsonline.getString("Ignition");
		devstatus=rsonline.getString("DeviceStatus");
		TimeDiff=rsonline.getString("TimeDiff");
		distanceTraveledToday=distanceTraveledTillNow-lastDayKm;
		
		bgcolor="background-color:#FFFFFF";
		String cIconSatus="";
		cIconSatus = "white";
		String sqltrip = "select tripid,StartPlace,EndPlace,DriverCode,DriverName,StartCode,Endcode from db_gps.t_startedjourney where jstatus = 'Running' and vehid = '"+vehcode+"' order by startdate desc,starttime desc limit 1";
		//	System.out.println("***     "+sqltrip);
			ResultSet rstrip = stmt1.executeQuery(sqltrip);
			if(rstrip.next())
			{
				tripid = rstrip.getString("tripid");
				origin = rstrip.getString("StartPlace");
				dest = rstrip.getString("EndPlace");
				drivid = rstrip.getString("DriverCode");
				drivname = rstrip.getString("DriverName");
				startcode=rstrip.getString("StartCode");
				endcode=rstrip.getString("Endcode");
				try{
					String sqlmob="select DrivMobNo  from db_gps.t_briefing where DrivMobNo <> '-' and	DrivMobNo <> 'null'  and  Driverid='"+drivid+"'	order by brifdate desc limit 1";
					ResultSet rsmob = st123.executeQuery(sqlmob);
					if(rsmob.next())
					{
						drivemob=rsmob.getString("DrivMobNo");

					}
					else
					{
						drivemob="NA";
					}

					}catch(Exception ex)
					{
						System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@ex "  +ex);
					}
					
					java.util.Date ShowDate1 = new java.util.Date();
					try {
						final String showDate1String = thedate+" "+thetime;
						if(showDate1String.trim().isEmpty()) 
						{
						}
						else
						{
							ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(showDate1String);
						}
					} catch (Exception ex)
					{
						System.out.println("------------1111111111111>  "+ex);
					}

					java.util.Date ddd= new java.util.Date();
					long dt1=ShowDate1.getTime();
					long dt2=ddd.getTime();
					long mins=((dt2-dt1)/60000);// in mins
					int mins2=disConnected;

					if(devstatus.equalsIgnoreCase("Device Installed But Inactive"))
					{
						bgcolor="";//Device Installed But Inactive
						cIconSatus="white";
					}
				
					else if(speed > 0 && "OFF".equalsIgnoreCase(ignition))
					{
						bgcolor="background-color:#FF6600";//red color
						cIconSatus="Red";
					}
					else if(speed >0) 
					{ 
						if(mins >mins2 )
						{
							bgcolor="background-color:#DCDCDC";//shows disconnected
							cIconSatus="Gray";
						}
							else 
						{
								bgcolor="background-color:#CCFFCC";//moving
								cIconSatus="Green";
								
						}
					}
					
					else //if speed =0
					{
						if(mins >mins2 )
						{
							bgcolor="background-color:#DCDCDC";//disconnected
							cIconSatus="Gray";
						}
						
						else
						{
							String sqlrpm="Select * from db_gps.t_vehicledetails where VehicleCode='"+vehcode+"'";
							ResultSet rsrpm=st.executeQuery(sqlrpm);
							if(rsrpm.next())
							{
								senserpm=rsrpm.getString("Sen3");
								installeddate=rsrpm.getString("InstalledDate");
								UnitID=rsrpm.getString("UnitID");
							}
							
							String sqlrpmval="Select * from db_gps.t_onlinedata where VehicleCode='"+vehcode+"'";
							ResultSet rsrpmval=st.executeQuery(sqlrpmval);
							if(rsrpmval.next())
							{
								try{
								valrpm=rsrpmval.getInt("Sen3");
								}catch(Exception ex)
								{
									valrpm=0;
								}
							}
							if(senserpm.equalsIgnoreCase("RPM"))
							{
								if(valrpm > 0) 
								{
									bgcolor="background-color:#D4C0F0";//stop but engine start
									cIconSatus="Violet";
								}
								
								else
								{
									bgcolor="background-color:#FFFFCC";//stop
									cIconSatus="Yellow";
								}
							}
							  else
								 {
							       bgcolor="background-color:#FFFFCC";//stop
							       cIconSatus="Yellow";
								
							}
						} 
					}
				
					
					try{
						System.out.println("datetime-------->" +thedate);
						
						System.out.println("datetime-------->" +thetime);
						datetime=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate+" "+thetime));
						System.out.println("datetime-------->" +datetime);
						
					}catch(Exception ex)
					{
						System.out.println("---------------->  "+ex);
						datetime="-";
						
					}
					
					if(datetime.equalsIgnoreCase("null") || datetime.equalsIgnoreCase(null) || datetime.equalsIgnoreCase(""))
					{
						datetime="-";
					}
						
					System.out.println("timeeeeeeeeee-------->before  " +TimeDiff);
					if(TimeDiff.equalsIgnoreCase("-") || TimeDiff.equalsIgnoreCase("null") || TimeDiff.equalsIgnoreCase(null))
					{
						TimeDiff="0";
					}
					if((Integer.parseInt(TimeDiff.substring(0,1))>4))
					{
						System.out.println("timeeeeeeeeee-------->after  " +TimeDiff);
						bgcolor="background-color:#F5DEB3";//Stopage greater than 4
					       cIconSatus="Brown";
					}
					
					String Startzone="",Endzone="";
					String sqlstart="select StartLocationZone,EndLocationZone from db_gps.t_castrolroutes  where  startcode='"+startcode+"' and endcode='"+endcode+"' and Owner='ExpressRdys_All'  ";
					ResultSet rsstart=st123.executeQuery(sqlstart);
					System.out.println("querry zones-------->  "  +sqlstart);
					if(rsstart.next())
					{
						
						Startzone=rsstart.getString("StartLocationZone");
						Endzone=rsstart.getString("EndLocationZone");	
					
					
					/*	String Startzone1="",Endzone1="";
					String sqlstart1="select StartLocationZone,EndLocationZone from db_gps.t_castrolroutes  where  startcode='"+startcode+"' and Owner='ExpressRdys_All' and (StartLocationZone='West' or EndLocationZone='West') ";
					ResultSet rsstart1=st123.executeQuery(sqlstart1);
					System.out.println("querry zones-------->  "  +sqlstart1);
					if(rsstart1.next())
					{
						
						Startzone1=rsstart1.getString("StartLocationZone");
						Endzone1=rsstart1.getString("EndLocationZone");	
					}
					
					String Startzone2="",Endzone2="";
					String sqlstart2="select StartLocationZone,EndLocationZone from db_gps.t_castrolroutes  where  startcode='"+startcode+"' and Owner='ExpressRdys_All' and (StartLocationZone='North' or EndLocationZone='North') ";
					ResultSet rsstart2=st123.executeQuery(sqlstart2);
					System.out.println("querry zones-------->  "  +sqlstart2);
					if(rsstart2.next())
					{
						
						Startzone2=rsstart2.getString("StartLocationZone");
						Endzone2=rsstart2.getString("EndLocationZone");	
					}
					*/
					/*String Startzone3="",Endzone3="";
					String sqlstart3="select StartLocationZone,EndLocationZone from db_gps.t_castrolroutes  where  startcode='"+startcode+"' and Owner='ExpressRdys_All' and (StartLocationZone='South' or EndLocationZone='South') ";
					ResultSet rsstart3=st123.executeQuery(sqlstart3);
					System.out.println("querry zones-------->  "  +sqlstart3);
					if(rsstart3.next())
					{
						
						Startzone3=rsstart3.getString("StartLocationZone");
						Endzone3=rsstart3.getString("EndLocationZone");	
					}*/
					
					int i2=7;
					String zone = "";
					String East="East",West="West",North="North",South="South";
					
		
					if("All".equalsIgnoreCase(Status)){
						if(bgcolor=="")
						{
							vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'>"+vehregno+"</td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
							zone = "";
						}
						else
						{
							if(Startzone.equalsIgnoreCase("East") && Endzone.equalsIgnoreCase("North"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+n+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="East,North";
								e++;
								n++;
							}
							else if(Startzone.equalsIgnoreCase("East") && Endzone.equalsIgnoreCase("South"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="East,South";
								e++;
								s++;
								
							}
							else if(Startzone.equalsIgnoreCase("East") && Endzone.equalsIgnoreCase("West"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="East,West";
								e++;
								w++;
							}
							else if(Startzone.equalsIgnoreCase("East") && Endzone.equalsIgnoreCase("East"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",1,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="East";
								e++;
							}
							else if(Startzone.equalsIgnoreCase("North") && Endzone.equalsIgnoreCase("West"))
							{
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+n+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="North,West";
								n++;
								w++;
							}
							else if(Startzone.equalsIgnoreCase("North") && Endzone.equalsIgnoreCase("East"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+n+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="East,North";
								e++;
								n++;
							}
							else if(Startzone.equalsIgnoreCase("North") && Endzone.equalsIgnoreCase("South"))
							{
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+n+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="South,North";
								s++;
								n++;
							}
							else if(Startzone.equalsIgnoreCase("North") && Endzone.equalsIgnoreCase("North"))
							{
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",3,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="North";
							}
							else if(Startzone.equalsIgnoreCase("South") && Endzone.equalsIgnoreCase("North"))
							{
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+n+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="South,North";
								s++;
								n++;
							}
							else if(Startzone.equalsIgnoreCase("South") && Endzone.equalsIgnoreCase("East"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="East,South";
								e++;
								s++;
							}
							else if(Startzone.equalsIgnoreCase("South") && Endzone.equalsIgnoreCase("West"))
							{
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="South,West";
								s++;
								w++;
							}
							else if(Startzone.equalsIgnoreCase("South") && Endzone.equalsIgnoreCase("South"))
							{
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",4,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="South";
								s++;
							}
							else if(Startzone.equalsIgnoreCase("West") && Endzone.equalsIgnoreCase("South"))
							{
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+s+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,4)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="West,South";
								w++;
								s++;
							}
							else if(Startzone.equalsIgnoreCase("West") && Endzone.equalsIgnoreCase("North"))
							{
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+n+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,3)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="West,North";
								w++;
								n++;
							}
							else if(Startzone.equalsIgnoreCase("West") && Endzone.equalsIgnoreCase("East"))
							{
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+e+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,1)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="West,East";
								e++;
								w++;
							}
							else if(Startzone.equalsIgnoreCase("West") && Endzone.equalsIgnoreCase("West"))
							{
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+w+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+",2,2)'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone="West";
								w++;
							}
							
						/*if(Startzone.equalsIgnoreCase("East") || Endzone.equalsIgnoreCase("East"))
							{
								int i1=1,start = 1,end = 1;							
								vehicleUpdate1+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+","+i1+","+Startzone+","+Endzone+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone=zone+"East,";
							}
							 if(Startzone1.equalsIgnoreCase("West") || Endzone1.equalsIgnoreCase("West"))
							{
								int i1=2;
								vehicleUpdate2+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:try{myclick("+i+","+lat+","+lon+","+i1+","+Startzone1+","+Endzone1+")}catch(e){alert(e);}'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone=zone+"West,";
							}
							 if(Startzone2.equalsIgnoreCase("North") || Endzone2.equalsIgnoreCase("North"))
							{
								int i1=3;
								vehicleUpdate3+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+","+i1+","+Startzone2+","+Endzone2+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone=zone+"North,";
							}
							 if(Startzone3.equalsIgnoreCase("South") || Endzone3.equalsIgnoreCase("South"))
							{
								int i1=4;
								vehicleUpdate4+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+","+i1+","+Startzone3+","+Endzone3+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
								zone=zone+"South,";
							}*/
					}
						markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"~"+zone+"$";
					}
					}
									
			}	
	}
	out.print(vehicleUpdate+vehicleUpdate1+vehicleUpdate2+vehicleUpdate3+vehicleUpdate4+"</table>"+"</table>"+"</table>"+"</table>"+"</table>"+markerlist+"@"+i);
	System.out.print(vehicleUpdate+"</table>"+markerlist+"@"+i);
	
}
catch(Exception e)
{
	out.print("Exception -->"+e);
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!ex  "  +e);
}
 %>

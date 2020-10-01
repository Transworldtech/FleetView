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
	
	String Status=request.getParameter("status");
	System.out.println("getting status..."  +Status);
	String vehicleList=session.getAttribute("VehList").toString();
	String typeValue=session.getAttribute("usertypevalue").toString();
	
	int i=1;
	double speed=0;
	final int disConnected = Integer.parseInt(session.getAttribute("desconnected").toString());
	String Currdate="No Trip Data";
	//System.out.println("Date is"+Currdate);
	double lastDayKm=0,distanceTraveledTillNow=0,distanceTraveledToday=0; 
	String vehicleUpdate="<table width='100%' class='sortable'>";
	String markerlist="@",ignition="",devstatus="";
	String lat="-",lon="-",vehregno="-",thedate="-",thetime="-",TimeDiff="",drivemob="",senserpm="",datetime="-",sql1="",location="",stamp="",bgcolor="",vehcode = "",tripid = "-";
	int valrpm=0;
	String origin = "-",dest = "-",drivid = "-",drivname = "-";
	vehicleUpdate+="<tr><th>No</th><th>Veh.NO</th><th>Updated DateTime</th><th>Speed</th></tr>";
	
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
	") d LEFT OUTER JOIN t_onlinedata b ON (d.`VehicleCode` = b.`VehicleCode` AND b.UnitId IS NOT NULL) "+
	"LEFT OUTER JOIN t_usermessage e ON (d.TransporterName = e.UserTypeValue AND e.MessageId = 4) "+ 
	" ORDER BY concat(b.TheDate,' ',b.TheTime) DESC  ";
	ResultSet rsonline = stmt.executeQuery(sqlonline);
	System.out.println("online querry "+sqlonline);
	while(rsonline.next())
	{
		vehregno=rsonline.getString("VehicleRegNo");
		vehcode = rsonline.getString("VehicleCode");
		speed=rsonline.getDouble("Speed");
		thedate=rsonline.getString("TheDate");
		thetime=rsonline.getString("TheTime");
		//out.print("thedate-------->  " +thedate+"time->"+thetime);
		lat = rsonline.getString("LatitudePosition");
		lon = rsonline.getString("LongitudePosition");
		location = rsonline.getString("CurrentLocation");
		stamp = rsonline.getString("TheID");
		lastDayKm=rsonline.getDouble("LastDayKm");
		distanceTraveledTillNow=rsonline.getDouble("TheDistance");
		ignition = rsonline.getString("Ignition");
		devstatus=rsonline.getString("DeviceStatus");
		TimeDiff=rsonline.getString("TimeDiff");
		int hrs = 0;
		Boolean flagon=false;
		if(TimeDiff!=null)
		{
			
		
		if(TimeDiff.contains("."))
		{
			TimeDiff=TimeDiff.replace(".",":");
		}
		
		System.out.println("timeeeeeeeeee-------->before  " +TimeDiff);
		
		//out.print("Before-------->  " +TimeDiff.length()+"time->"+TimeDiff);

		if(TimeDiff!=null && TimeDiff!="-" && !(TimeDiff.equalsIgnoreCase("0:0")))
		{
			//out.print("timeeeeeeeeee-------->" +TimeDiff.length()+"time->"+TimeDiff);
			if(TimeDiff.length()>2)
			{
			//out.println("timeeeeeeeeee-------->lllllllllllll  " +TimeDiff.length());
				hrs = Integer.parseInt(TimeDiff.substring(0,TimeDiff.lastIndexOf(":")));

			}
		}
		else
		{
			hrs=0;
		}
		}
		if(hrs > 4)
		{
			//System.out.println("timeeeeeeeeee-------->after  " +TimeDiff.substring(0,1));
			
		       flagon=true;
		}
		
		distanceTraveledToday=distanceTraveledTillNow-lastDayKm;
		
		bgcolor="background-color:#FFFFFF";
		String cIconSatus="";
		cIconSatus = "white";
		String sqltrip = "select tripid,StartPlace,EndPlace,DriverCode,DriverName from db_gps.t_startedjourney where jstatus = 'Running' and vehid = '"+vehcode+"' order by startdate desc,starttime desc limit 1";
	//	System.out.println("***     "+sqltrip);
		ResultSet rstrip = stmt1.executeQuery(sqltrip);
		if(rstrip.next())
		{
			tripid = rstrip.getString("tripid");
			origin = rstrip.getString("StartPlace");
			dest = rstrip.getString("EndPlace");
			drivid = rstrip.getString("DriverCode");
			drivname = rstrip.getString("DriverName");
		}
		else
		{
			tripid = "-";
			origin = "-";
			dest = "-";
			drivid = "-";
			drivname = "-";
		}
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

		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		java.util.Date ShowDate1 = new java.util.Date();
		try {
			//out.print("thedate11-------->  " +thedate+"time11->"+thetime);

			if(thedate!=null || thetime!=null)
			{
				
			
			final String showDate1String = thedate+" "+thetime;
			if(showDate1String.trim().isEmpty()) 
			{
			}
			else
			{
				ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(showDate1String);
			}
			}
			//out.print("thedate22-------->  " +thedate+"time22->"+thetime);

		} catch (ParseException e)
		{
			e.printStackTrace();
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
				}
				
				String sqlrpmval="Select * from db_gps.t_onlinedata where VehicleCode='"+vehcode+"'";
				ResultSet rsrpmval=st.executeQuery(sqlrpmval);
				if(rsrpmval.next())
				{
					try{
					valrpm=rsrpmval.getInt("Sen3");
					}catch(Exception e)
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
					else{
						if(flagon==true)
						{
							bgcolor="background-color:#F5DEB3";//Stopage greater than 4
						       cIconSatus="Brown";
						}
						else{
						bgcolor="background-color:#FFFFCC";//stop
						cIconSatus="Yellow";
						}
					}
				}
				else{
					
					
					if(flagon==true)
					{
						   bgcolor="background-color:#F5DEB3";//Stopage greater than 4
					       cIconSatus="Brown";
					}
					else{
					
				bgcolor="background-color:#FFFFCC";//stop
				cIconSatus="Yellow";
				
				}
				}
			} 
			
		}
	
		
		try{
			if(thedate!=null || thetime!=null)
			{
			datetime=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate+" "+thetime));
		}
		}catch(Exception e)
		{
			System.out.println(e);
			datetime="-";
		}
		
		
		if("All".equalsIgnoreCase(Status)){
			
			if(bgcolor=="")
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'>"+vehregno+"</td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";
				
			}
			else
			{
		vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
		markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";
		}
		}
		else if(("disconnected".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("Gray"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		else if(("moving".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("Green"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		else if(("stop".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("Yellow"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		else if(("Ignition".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("Red"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		else if(("Stopengine".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("Violet"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		else if(("Inactive".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("White"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'>"+vehregno+"</td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		else if(("Stop>4".equalsIgnoreCase(Status)))
		{
			if(cIconSatus.equalsIgnoreCase("Brown"))
			{
				vehicleUpdate+="<tr><td style='"+bgcolor+"'>"+i+"</td><td style='"+bgcolor+"'><a href='javascript:myclick("+i+","+lat+","+lon+")'>"+vehregno+"</a></td><td style='"+bgcolor+"'>"+datetime+"</td><td style='"+bgcolor+"'>"+speed+"</td></tr>";
				markerlist+=lat+"~"+lon+"~"+i+++"~"+vehregno+"~"+speed+"~"+datetime+"~"+location+"~"+distanceTraveledToday+"~"+tripid+"~"+origin+"~"+dest+"~"+drivid+"~"+drivname+"~"+cIconSatus+"~"+Currdate+"~"+drivemob+"$";				
			}
		}
		}
	out.print(vehicleUpdate+"</table>"+markerlist+"@"+i);
	System.out.print(vehicleUpdate+"</table>"+markerlist+"@"+i);
}
catch(Exception e)
{
	out.print("Exception -->"+e);
	e.printStackTrace();
}
 %>

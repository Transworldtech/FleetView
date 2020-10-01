
<%@ include file="Connections/conn.jsp"%>
<%@ page import="com.fleetview.beans.classes"%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.fleetview.beans.ZoneColorIdentificationImpl"%>
	
	
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
	<%-- <% 
	public String formatSeconds ( int timeInSeconds )
	{
	    int hours = timeInSeconds / 3600;
	    int secondsLeft = timeInSeconds - hours * 3600;
	    int minutes = secondsLeft / 60;
	    int seconds = secondsLeft - minutes * 60;

	    String formattedTime = "";
	    if (hours < 10)
	        formattedTime += "0";
	    formattedTime += hours + ":";

	    if (minutes < 10)
	        formattedTime += "0";
	    formattedTime += minutes + ":";

	    if (seconds < 10)
	        formattedTime += "0";
	    formattedTime += seconds ;

	    return formattedTime;
	}
	
	
	
	%> --%>
<%

Connection conn, conn1;
String date1,date2,mode,rvehid,hvrno,fff,ttt,mydate1,mydate2;
ResultSet rs=null;
%>
<%
classes fleetview=new classes();

try{
	Class.forName(MM_dbConn_DRIVER); 
	
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=conn1.createStatement();
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stGPS=conn.createStatement();
	Statement st1=conn.createStatement();
	
	fff=session.getAttribute("fff").toString();
	ttt=session.getAttribute("ttt").toString();
	date1=session.getAttribute("hdate1").toString();
	date2=session.getAttribute("hdate2").toString();
	System.out.println(fff);
	date1 = date1+" "+fff;
	date2 = date2+" "+ttt;
	System.out.println("Date= "+date1+ "date2= "+date2);
	//mode=session.getAttribute("mode").toString();
	rvehid=session.getAttribute("hvid").toString();
	hvrno=session.getAttribute("hvrno").toString();
	
	String bgColor="background-color:#FFFFFF",routeID="";
	int i=1;
	ZoneColorIdentificationImpl zoneColor = new ZoneColorIdentificationImpl();
	routeID = zoneColor.getRouteId(rvehid);
	int j=0;
	
	String parameter=request.getParameter("para");
	String msg="",sql1="";
	if(parameter!=null && parameter.equalsIgnoreCase("OS"))
	{
		/* sql1="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime," +
			" veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, veh.Distance, os.Speed, veh.ZoneColor" +
			" FROM db_gpsExceptions.t_veh"+rvehid+"_overspeed os " +
			" LEFT OUTER JOIN (" +
			" SELECT TheFieldDataDate, TheFieldDataTime,Distance," +
			" MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec," +
			" MAX(TheFieldSubject) AS TheFieldSubject, ZoneDesc AS ZoneColor" +
			" FROM  db_gps.t_veh"+rvehid +
			" WHERE  TheFiledTextFileName= 'OS'" +
			" GROUP BY TheFieldDataDate, TheFieldDataTime" +
			") veh ON (veh.TheFieldDataDate = os.FromDate" +
			" AND veh.TheFieldDataTime = os.FromTime)" +
			" WHERE 1=1 " +
			" AND concat(os.fromdate,' ',os.fromtime)>='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1))+ "'" +
			" AND concat(os.ToDate,' ',os.ToTime)<='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2))+ "'" +
			" ORDER BY concat(os.FromDate,os.FromTime)";*/
			
			sql1="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime," +
			" veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, veh.Distance, os.Speed, veh.ZoneColor" +
			" FROM db_gpsExceptions.t_veh"+rvehid+"_overspeed os " +
			" LEFT OUTER JOIN (" +
			" SELECT TheFieldDataDate, TheFieldDataTime,Distance," +
			" MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec," +
			" MAX(TheFieldSubject) AS TheFieldSubject, ZoneDesc AS ZoneColor" +
			" FROM  db_gps.t_veh"+rvehid +
			" WHERE  TheFiledTextFileName= 'OS' " +
			"  and  TheFieldDataDateTime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1))+"' "+
			" and TheFieldDataDateTime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2))+"' "+
			" GROUP BY TheFieldDataDateTime" +
			" ) veh ON (veh.TheFieldDataDate = os.FromDate" +
			" AND veh.TheFieldDataTime = os.FromTime)" +
			" WHERE 1=1 " +
			" AND concat(os.fromdate,' ',os.fromtime)>='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1))+ "'" +
			" AND concat(os.ToDate,' ',os.ToTime)<='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2))+ "'" +
			" ORDER BY concat(os.FromDate,os.FromTime)";
			 
			 //"SELECT * FROM t_veh"+rvehid+"_overspeed where concat(FromDate,' ',FromTime)>='"+date1+"' and  concat(ToDate,' ',ToTime)<='"+date2+"' order by FromDate desc,FromTime desc";
		System.out.println("71 "+sql1);
			 rs=st.executeQuery(sql1);
		 msg="Over Speed ";
	}
	else if(parameter!=null && parameter.equalsIgnoreCase("RA"))
	{
		sql1="SELECT "+
		" ra.Thedate, ra.TheTime, ra.FromSpeed, ra.ToSpeed , " +
		"	       veh.TheFieldSubject ,veh.LatinDec, veh.LonginDec, veh.ZoneColor,veh.Distance " +
		" FROM "+
		"(SELECT Thedate, TheTime, FromSpeed, ToSpeed"+
		"		  FROM db_gpsExceptions.t_veh"+rvehid+"_ra" +
		"			 WHERE"+
		"		   concat(TheDate,' ',TheTime)  >= '"+date1+"'" +
		"			 AND" +
		"		   concat(TheDate,' ',TheTime)<= '"+date2+"') ra"+
		" LEFT OUTER JOIN " +
		"   (SELECT LatinDec, LonginDec,Distance, TheFieldSubject,TheFieldDataDate,TheFieldDataTime,ZoneDesc AS ZoneColor " +
		" FROM db_gps.t_veh"+rvehid+"" +
		"	WHERE" +
		"   	TheFieldDataDateTime >= '"+date1+"' " +
		"	AND" +
		"		 TheFieldDataDateTime<= '"+date2+"')veh "+
		" ON(veh.TheFieldDataDate = ra.TheDate AND veh.TheFieldDataTime = ra.TheTime) " +
		" GROUP BY " +
		"	CONCAT( ra.Thedate , ra.TheTime )" +
		"ORDER BY CONCAT( ra.Thedate , ra.TheTime )";
			//"SELECT * FROM t_veh"+rvehid+"_ra where concat(TheDate,' ',TheTime)>='"+date1+"' and  concat(TheDate,' ',TheTime)<='"+date2+"' order by TheDate desc,TheTime desc";
		System.out.println("99 "+sql1);
		rs=st.executeQuery(sql1);
		msg="Rapid Acceleration ";
	}
	else if(parameter!=null && parameter.equalsIgnoreCase("RDA"))
	{
		sql1="SELECT "+
		" rd.Thedate, rd.TheTime, rd.FromSpeed, rd.ToSpeed , " +
		"	       veh.TheFieldSubject , veh.LatinDec, veh.LonginDec, veh.ZoneColor,veh.Distance " +
		" FROM "+
		"(SELECT Thedate, TheTime, FromSpeed, ToSpeed"+
		"		  FROM db_gpsExceptions.t_veh"+rvehid+"_rd " +
		"			 WHERE"+
		"		   concat(TheDate,' ',TheTime)  >= '"+date1+"'" +
		"			 AND" +
		"		   concat(TheDate,' ',TheTime)<= '"+date2+"') rd "+
		" LEFT OUTER JOIN " +
		"   (SELECT LatinDec, LonginDec,Distance, TheFieldSubject, TheFieldDataDate, TheFieldDataTime, ZoneDesc AS ZoneColor " +
		" FROM db_gps.t_veh"+rvehid+"" +
		"	WHERE " +
		"   	TheFieldDataDateTime >= '"+date1+"' " +
		"	AND " +
		"		 TheFieldDataDateTime<= '"+date2+"')veh "+
		" ON(veh.TheFieldDataDate = rd.TheDate AND veh.TheFieldDataTime = rd.TheTime) " +
		" GROUP BY " +
		"	CONCAT( rd.Thedate , rd.TheTime )" +
		"ORDER BY CONCAT( rd.Thedate , rd.TheTime )";
			//"SELECT * FROM t_veh"+ rvehid+"_rd where concat(TheDate,' ',TheTime)>='"+ date1+"' and  concat(TheDate,' ',TheTime)<='"+ date2+"' order by TheDate desc,TheTime desc";
		 //out.print(sql1);
		 System.out.println("128 "+sql1);
	    rs=st.executeQuery(sql1);
	   
		msg="Rapid Decelaration ";	
	}
	else if(parameter!=null && parameter.equalsIgnoreCase("Disconn"))
	{
		//System.out.println("Hi!!!!");
		/* sql1="Select "+
		     "VehRegNo, OffTimeFrom, OffTimeTo, FromLatitude, FromLongitude, FromLocation, Duration, Distance "+
		     "FROM "+
		     "db_gps.t_disconnectionData "+
		     "WHERE "+
		     "OffTimeFrom >= '"+date1+"'  "+
		     "AND OffTimeFrom<='"+date2+"'  and Reason = 'Disconnection' "+
		     "AND vehicleCode = '"+rvehid+"' "+
		     "ORDER BY OffTimeFrom"; */
		   
		 
		     sql1="Select VehRegNo, OffTimeFrom, OffTimeTo, FromLatitude, FromLongitude, FromLocation, time_to_sec(Duration) Duration, Distance FROM db_gps.t_disconnectionData WHERE OffTimeFrom between '"+date1+"' and '"+date2+"'  and Reason = 'Disconnection' AND vehicleCode ='"+rvehid+"' and ignoredstamp='No' and Duration >= '0:30:00' ORDER BY OffTimeFrom";
		     
		     //sql1="Select VehRegNo, OffTimeFrom, OffTimeTo, FromLatitude, FromLongitude, FromLocation, Duration, Distance FROM db_gps.t_disconnectionData WHERE OffTimeFrom >= '"+date1+"' and '"+date2+"'  and Reason = 'Disconnection' AND vehicleCode ='"+rvehid+"' and ignoredstamp='No' and Duration >= '0:30:00' ORDER BY OffTimeFrom";
			//out.print(sql1);
	//	System.out.println("146 "+sql1);
	System.out.println("sql1violation disconnection==>"+sql1);
		rs=st1.executeQuery(sql1);
		msg="Disconnection ";
	}
	%>
	<% 
	mydate1= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));
	mydate2= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2));
	String dd,aa; 
	String output="";
	output="<table border='1' width='100%' class='stats'><tr><td class='hed'>"+msg+" Report For "+hvrno+" From "+mydate1+" to "+mydate2+" </td></tr><tr><td><table border='1' width='100%' class='stats'><tr><td><table width='100%' border='1'  class='sortable'><tr>";
	if( msg.equalsIgnoreCase("Over Speed "))
	{
		output+="<th>Sr.No.</th><th>Date </th><th>Time</th><th>Speed</th><th>Duration(Sec)</th>";
	}
	else 
		if(msg.equalsIgnoreCase("Disconnection "))
		{
			output+="<th>Sr.No.</th><th>From Date Time</th><th>To Date Time</th><th>Duration</th><th>Distance</th>";
		}
	   else
	    {
		    output+="<th>Sr.No.</th><th>Date </th><th>Time</th><th>From Speed</th><th>To Speed</th>";
	    }//else end
		output+="<th>Location</th></tr>";
	
try{
	while(rs.next())
	{
		 double lat1=0;
		 double lon1=0;
		 String disc="";
		
		output+="<tr>";
		if(msg.equalsIgnoreCase("Over Speed "))
		{
				java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("FromDate"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
				String showdate1 = formatter1.format(ShowDate1);
				
				String fromtime = rs.getString("FromTime");
				String speed    = rs.getString("Speed");
				String dura = rs.getString("Duration");
				//String duration=dura.formatSeconds(dura);
				int sec = Integer.parseInt(dura);//
				java.util.Date	d = new java.util.Date(sec * 1000L);
						SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss"); // HH for 0-23
						df.setTimeZone(TimeZone.getTimeZone("GMT"));
						String duration = df.format(d);
				/* {
				    int hours = timeInSeconds / 3600;
				    int secondsLeft = timeInSeconds - hours * 3600;
				    int minutes = secondsLeft / 60;
				    int seconds = secondsLeft - minutes * 60;

				    String formattedTime = "";
				    if (hours < 10)
				        formattedTime += "0";
				    formattedTime += hours + ":";

				    if (minutes < 10)
				        formattedTime += "0";
				    formattedTime += minutes + ":";

				    if (seconds < 10)
				        formattedTime += "0";
				    formattedTime += seconds ;

				    return formattedTime;
				} */
					 lat1=rs.getDouble("LatinDec");
					 lon1=rs.getDouble("LonginDec");
					 disc=rs.getString("TheFieldSubject");
				
				
				try{
					if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
					{
							
					}
					else{// zone color not to be shown. logic/ condition to be finalised as to whom this should be shown
					//bgColor = zoneColor.getZoneColor(routeID,Double.parseDouble(lat1),Double.parseDouble(lon1));
					}}
				catch(Exception e){
					e.printStackTrace();
				}
				
				
			//	System.out.println("bgcolor==>"+bgColor);
				output+="<td class='bodyText' style='"+bgColor+"; text-align: left '>"+i+"</td>"+
					    "<td class='bodyText' style='"+bgColor+"; text-align: left '>"+showdate1+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(fromtime))+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+speed+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+duration+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: left'><div align='left'><a href='javascript:zoomtoloc("+j+","+lat1+","+lon1+")'>"+disc+"</a></div></td>";
			//	System.out.println("output==>"+output);		
			j++;
		}
		else 
			if(msg.equalsIgnoreCase("Disconnection "))
			{
				String disconnectionFromdatetime = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("OffTimeFrom")));
				String disconnectionTodatetime = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("OffTimeTo")));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				
				String dura = rs.getString("Duration");
				
				int seconds = Integer.parseInt(dura);
				int hr = seconds/3600;
				  int rem = seconds%3600;
				  int mn = rem/60;
				  int sec = rem%60;
				  String hrStr = (hr<10 ? "0" : "")+hr;
				  String mnStr = (mn<10 ? "0" : "")+mn;
				  String secStr = (sec<10 ? "0" : "")+sec; 
				  System.out.println(hrStr+":"+mnStr+":"+secStr);
						String duration = hrStr+":"+mnStr+":"+secStr;
				int distance = rs.getInt("Distance");
				
					 lat1=rs.getDouble("FromLatitude");
					 lon1=rs.getDouble("FromLongitude");
					 disc=rs.getString("FromLocation");
				
				
				try{
					if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
					{
							
					}
					else{
					//bgColor = zoneColor.getZoneColor(routeID,Double.parseDouble(lat1),Double.parseDouble(lon1));
					}}
				catch(Exception e){
					e.printStackTrace();
				}
				
				
			//	System.out.println("bgcolor==>"+bgColor);
				output+="<td class='bodyText' style='"+bgColor+"; text-align: left '>"+i+"</td>"+
					    "<td class='bodyText' style='"+bgColor+"; text-align: left '>"+disconnectionFromdatetime+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+disconnectionTodatetime+"</td>"+
						//"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+speed+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+duration+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+distance+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: left'><div align='left'><a href='javascript:zoomtoloc("+j+","+lat1+","+lon1+")'>"+disc+"</a></div></td>";
				//System.out.println("output==>"+output);	
				j++;
			}
		else
		{
				java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("TheDate"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
				String showdate1 = formatter1.format(ShowDate1);
			
				String fromtime = rs.getString("TheTime");
				String speed    = rs.getString("FromSpeed");
				String duration = rs.getString("ToSpeed");
			
				
	 				lat1=rs.getDouble("LatinDec");
	 				lon1=rs.getDouble("LonginDec");
	 				disc=rs.getString("TheFieldSubject");
				
				try{
					if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
					{
							
					}
					else{
					//bgColor = zoneColor.getZoneColor(routeID,Double.parseDouble(lat1),Double.parseDouble(lon1));
					}}
				catch(Exception e){
					e.printStackTrace();
				}
				//System.out.println("bgcolor==>"+bgColor);
				output+="<td class='bodyText' style='"+bgColor+"; text-align: left'>"+i+"</td>"+
					    "<td class='bodyText' style='"+bgColor+"; text-align: left'>"+showdate1+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(fromtime))+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+speed+"</td>"+
						"<td class='bodyText' style='"+bgColor+"; text-align: right'>"+duration+"</td>";
						if(msg.equalsIgnoreCase("Rapid Acceleration ")){
							output+="<td align='left' style='"+bgColor+"' class='bodyText'><div align='left'><a href='javascript:zoomtoloc("+j+","+lat1+","+lon1+")'>"+disc+"</a></div></td></tr>";
						}
						else{
							output+="<td align='left' style='"+bgColor+"' class='bodyText'><div align='left'><a href='javascript:zoomtoloc("+j+","+lat1+","+lon1+")'>"+disc+"</a></div></td></tr>";
						}
						
				//System.out.println("output==>"+output);	
				j++;
			}//else end
		i++;	
	}

		output+="</table></td></tr></table>";
		System.out.println(output);
	}catch(Exception e){
	//System.out.print("Exception"+e);
	e.printStackTrace();
	}
	
	out.print(output+"$");
	
	
}// outer try end
catch(Exception e)
{
	//System.out.print("Exception"+e);
	e.printStackTrace();
}
finally
{
	//conn1.close();
	try
	{
	fleetview.closeConnection1();
	}
	catch(Exception e)
	{}
	try
	{
	fleetview.closeConnection();
	}
	catch(Exception e){}
}
%>


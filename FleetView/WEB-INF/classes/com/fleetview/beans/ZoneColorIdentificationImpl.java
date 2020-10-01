package com.fleetview.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class ZoneColorIdentificationImpl {

	static Connection connGPS = null, connAVLALLDATA;
	static Statement stGPS = null,stGPS3 = null,stGPS1=null, stGPS2=null;
	NumberFormat nf = DecimalFormat.getNumberInstance();
	

	public String getZoneColor(String routeId,double currentLatitude,double currentLongitude) throws SQLException{
		try{
			Class.forName("org.gjt.mm.mysql.Driver");
			connGPS = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","java","transjava!1");
			nf.setMaximumFractionDigits(1);
			nf.setMinimumFractionDigits(1);	
			nf.setGroupingUsed(false);
		}
		catch(Exception e){
			e.printStackTrace();
		}

		stGPS=connGPS.createStatement();

		double measurefirstRecordDistance = 0 , measuresecondRecordDistance=0, firstRecordDist=0,secondRecordDist=0,calDist=0,difference=0;
		double  firstRecordLat=0,secondRecordLat=0, firstRecordLon=0,secondRecordLon=0;
		@SuppressWarnings("unused")
		String firstRecordZone = "", secondRecordZone="",bgColor="";
		String sql = "SELECT * FROM db_gps.jrmallroute where routeid = '"+routeId+"' ORDER BY trackid";
		ResultSet rs = stGPS.executeQuery(sql);
		while(rs.next())
		{
			measurefirstRecordDistance = 0 ; measuresecondRecordDistance = 0; firstRecordDist = 0; secondRecordDist = 0;calDist = 0;
			firstRecordZone = ""; secondRecordZone="";
			firstRecordDist = Double.parseDouble(rs.getString("apdist"));
			firstRecordLat = rs.getDouble("latvalue");
			firstRecordLon = rs.getDouble("lonvalue");
			firstRecordZone = rs.getString("zone");
			if(rs.next())
			{
				secondRecordDist = Double.parseDouble(rs.getString("apdist"));
				secondRecordLat = rs.getDouble("latvalue");
				secondRecordLon = rs.getDouble("lonvalue");
				measurefirstRecordDistance = getDistanceBetweenLatLon(currentLatitude,currentLongitude,firstRecordLat,firstRecordLon);
				//System.out.println("measurefirstRecordDistance=======>"+measurefirstRecordDistance);
				measuresecondRecordDistance = getDistanceBetweenLatLon(currentLatitude,currentLongitude,secondRecordLat,secondRecordLon);
				//System.out.println("measuresecondRecordDistance=======>"+measuresecondRecordDistance);

				calDist = measurefirstRecordDistance + firstRecordDist;

				if((calDist >= firstRecordDist) && (calDist < secondRecordDist))
				{
					difference = secondRecordDist - firstRecordDist;
					//difference =  getDistanceBetweenLatLon(firstRecordLat,firstRecordLon,secondRecordLat,secondRecordLon);
					//	System.out.println("firstRecordDist===>"+firstRecordDist+"--------------mdist1===>"+measurefirstRecordDistance);
					//	System.out.println("secondRecordDist===>"+secondRecordDist+"--------------mdist2===>"+measuresecondRecordDistance);
					//	System.out.println("dbdist3===>"+calDist);
					//	System.out.println("difference===>"+difference);

					if(measuresecondRecordDistance <= difference)
					{
						try{
							stGPS.close();
							connGPS.close();
						}
						catch (Exception e) {
							e.printStackTrace();
						}
						
						if("Green".equalsIgnoreCase(firstRecordZone)){
							bgColor = "background-color:#00C000";
						}
						else if("Red".equalsIgnoreCase(firstRecordZone)){
							bgColor= "background-color:#FF0000";
						}
						else if("Yellow".equalsIgnoreCase(firstRecordZone)){
							bgColor="background-color:#FFFF00";
						}
						else{
							bgColor="";
						}
						return bgColor;
					}
				}
			}
			rs.previous();
		}
		try{
			stGPS.close();
			connGPS.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	private double getDistanceBetweenLatLon(double currentLatitude,
			double currentLongitude, double firstRecordLat,
			double firstRecordLon) {
		double LDiff = 0;
		/*	double earthRadius = 3958.75;
		double dLat = Math.toRadians(firstRecordLat - currentLatitude);//(28.55332-28.55332);
		double dLng = Math.toRadians(firstRecordLon - currentLongitude);//(77.07488-77.07488);
		double a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(Math.toRadians(currentLatitude)) * Math.cos(Math.toRadians(firstRecordLat)) * Math.sin(dLng/2) * Math.sin(dLng/2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		double dista = earthRadius * c;
		//System.out.println("Distance calculated>>>>>>>>>>>>>>"+new Float(dista).floatValue());
		LDiff=dista*1609.344;
		//System.out.println(LDiff);
		LDiff = (LDiff/1000);*/
		double x = (69.1 * (firstRecordLat - currentLatitude));
		double y = (53.0 * (firstRecordLon - currentLongitude));

		LDiff = (1.6 * (Math.sqrt(x * x + y * y)));
		return LDiff;
	}

	public String getRouteId(String vehiclecode){
		String routeId="";
		try{
			Class.forName("org.gjt.mm.mysql.Driver");
			connGPS = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","java","transjava!1");
			stGPS=connGPS.createStatement();


			String sqlroute = "SELECT * FROM db_gps.t_jrmroutedata where vehiclecode='"+vehiclecode+"'";
			ResultSet rsroute = stGPS.executeQuery(sqlroute);
			if(rsroute.next())
			{
				routeId = rsroute.getString("routeid");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return routeId;

	}
}

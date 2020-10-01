package com.fleetview.beans;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import powerOnOffReport.DisconnectionData;
import powerOnOffReport.ImplementationOfDisconnection;

public class DisconnectionCount {
	
	static Connection conn1 = null;
	static Connection conn2=null;
	static Connection conn3 = null;
	static Connection conn4 = null;
	static Connection conn5 = null;
	static Statement st = null;
	
	
	static String tripStartDateTime = null;
	static String tripEndDateTime = null;
	static int disconnectionCount = 0;
	@SuppressWarnings("unused")
	private static int count=0;
	
	public int CalulateDrivingHours(String vehicleCode,String startDate,String endDate,String tripId){
		try {
			GetConnection();
			disconnectionCount=0;
			@SuppressWarnings("unused")
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try{
			tripStartDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startDate));
			tripEndDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate));
			}
			catch (Exception e) {
				// TODO: handle exception
			}
			disconnectionCount=0;
		//	String sql="SELECT * FROM db_gps.t_disconnectionData WHERE vehicleCode = '"+vehicleCode+"' AND OffTimeFrom BETWEEN '"+tripStartDateTime+"' AND '"+tripEndDateTime+"'";
			String sql="SELECT count(*) as count FROM db_gps.t_disconnectionData WHERE TripId like '%"+tripId+"%' and reason='Disconnection' and ignoredstamp='No' and Duration>='0:30'";
				System.out.println(sql);
			ResultSet rs=st.executeQuery(sql);
			if(rs.next())
			{
				disconnectionCount = rs.getInt("count");
			}
			//disconnectionCount= getDisconnectionData(ownerName,vehicleCode, tripStartDateTime,endDate, vehicleRegistrationNumber, unitId, unitType);

			CloseConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return disconnectionCount;

	}
	
		public static void GetConnection() {
		try {
			String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
			String MM_dbConn_USERNAME = "fleetview";
			String MM_dbConn_PASSWORD = "1@flv";
			String MM_dbConn_GPS = "jdbc:mysql://localhost/db_gps";
			Class.forName(MM_dbConn_DRIVER);
			conn1 = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
			
			st =  conn1.createStatement();
			
			//System.out.println("In Open Connection");
		} catch (Exception e) {
			//System.out.print("GetConnection Exception ---->" + e);
			e.printStackTrace();
		}
	}

	public static void CloseConnection() {
		try {
			st.close();
			
			conn1.close();
			
		} catch (Exception e) {
			//System.out.print("CloseConnection Exception---->" + e);
			e.printStackTrace();
		}

	}

	
	
	
}

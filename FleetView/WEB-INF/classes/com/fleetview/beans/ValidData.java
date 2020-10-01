package com.fleetview.beans;

public class ValidData {
	
	
	
	
	private int SrNo;
	private String TripID;
	private String Date;
	private String Time;
	private String VehNo;
	private String Transport;
	private String TripFrom;	
	private String TripTo;
	private String DriverID1;
	private String DriverName1;	
	private String DriverID2;	
	private String DriverName2;
	private String ETA;
	private double Weight;
	private String Vendor;
	private String triptype;
	private int advance;
	private int frieght;
	private String ReportDateTime;
	private String LoadDelayReason;
	private String Comment;
	
	
	public String getETA() {
		return ETA;
	}
	public void setETA(String eTA) {
		ETA = eTA;
	}
	public int getSrNo() {
		return SrNo;
	}
	public void setSrNo(int srNo) {
		SrNo = srNo;
	}
	public String getTripID() {
		return TripID;
	}
	public void setTripID(String tripID) {
		TripID = tripID;
	}
	public String getDate() {
		return Date;
	}
	public String getTime() {
		return Time;
	}
	public void setTime(String time) {
		Time = time;
	}
	public void setDate(String date) {
		Date = date;
	}
	public String getVehNo() {
		return VehNo;
	}
	public void setVehNo(String vehNo) {
		VehNo = vehNo;
	}
	public String getTransport() {
		return Transport;
	}
	public void setTransport(String transport) {
		Transport = transport;
	}
	public String getTripFrom() {
		return TripFrom;
	}
	public void setTripFrom(String tripFrom) {
		TripFrom = tripFrom;
	}
	public String getTripTo() {
		return TripTo;
	}
	public void setTripTo(String tripTo) {
		TripTo = tripTo;
	}
	public String getDriverID1() {
		return DriverID1;
	}
	public void setDriverID1(String driverID1) {
		DriverID1 = driverID1;
	}
	public String getDriverName1() {
		return DriverName1;
	}
	public void setDriverName1(String driverName1) {
		DriverName1 = driverName1;
	}
	public String getDriverID2() {
		return DriverID2;
	}
	public void setDriverID2(String driverID2) {
		DriverID2 = driverID2;
	}
	public String getDriverName2() {
		return DriverName2;
	}
	public void setDriverName2(String driverName2) {
		DriverName2 = driverName2;
	}
	public void setWeight(double weight) {
		Weight = weight;
	}
	public double getWeight() {
		return Weight;
	}
	public void setVendor(String vendor) {
		Vendor = vendor;
	}
	public String getVendor() {
		return Vendor;
	}
	public void setTriptype(String triptype) {
		this.triptype = triptype;
	}
	public String getTriptype() {
		return triptype;
	}
	public void setAdvance(int advance) {
		this.advance = advance;
	}
	public int getAdvance() {
		return advance;
	}
	public void setFrieght(int frieght) {
		this.frieght = frieght;
	}
	public int getFrieght() {
		return frieght;
	}	
	
	public void setFxkm(int fxkm) {
		this.fxkm = fxkm;
	}
	public int getFxkm() {
		return fxkm;
	}

	public void setFxtime(String fxtime) {
		this.fxtime = fxtime;
	}
	public String getFxtime() {
		return fxtime;
	}

	public String getReportDateTime() {
		return ReportDateTime;
	}
	public void setReportDateTime(String ReportDateTime) {
		this.ReportDateTime= ReportDateTime;
	}
	
	public String getLoadDelayReason() {
		return LoadDelayReason;
	}
	public void setLoadDelayReason(String LoadDelayReason) {
		this.LoadDelayReason= LoadDelayReason;
	}
	
	public String getComment() {
		return Comment;
	}
	public void setComment(String Comment) {
		this.Comment= Comment;
	}
	
	
	private int fxkm;
	private  String fxtime;
	
	

}

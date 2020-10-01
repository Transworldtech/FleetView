package com.fleetview.beans;


public class InvalidTripClosureData {
	
	private int SrNo;
	private String TripID;
	private String VehNo;
	private String TripEndDate;
	private String UnloadDate;
	private String UnloadDelayReason;
	private String Remark;
	private String Date;
	private String Time;
	
	public int getSrNo() {
		return SrNo;
	}
	public void setSrNo(int  srNo) {
		 SrNo = srNo;
	}
	public String getTripID() {
		return TripID;
	}
	public void setTripID(String tripID) {
		TripID = tripID;
	}
	
	public String getVehNo() {
		return VehNo;
	}
	public void setVehNo(String vehno) {
		VehNo = vehno;
	}
	
	public String getTripEndDate() {
		return TripEndDate;
	}
	
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
	public String getTime() {
		return Time;
	}
	public void setTime(String time) {
		Time = time;
	}
	public void setTripEndDate(String date) {
		TripEndDate = date;
	}

	public String getUnloadDate() {
		return UnloadDate;
	}
	public void setUnloadDate(String unloaddate) {
		UnloadDate = unloaddate;
	}
	public String getUnloadDelayReason() {
		return UnloadDelayReason;
		
	}
	public void setUnloadDelayReason(String unloadreason) {
		UnloadDelayReason = unloadreason;
	}
	
	public String getRemark() {
		return Remark;
	}
	public void setRemark(String reason) {
		Remark = reason;
	}
}	


<%@page import="com.fleetview.beans.Connectionclass"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.text.SimpleDateFormat" %> 

<%
String tripinfo=request.getParameter("TripID");

//System.out.print(tripinfo);
String tripid=null,user=null;
String data=null;
String [] temp = null;
temp = tripinfo.split("-");

for (int i = 0 ; i < temp.length ; i++) {
		tripid=temp[0];
		user=temp[1];
}

String tripdate=null;
String ETA=null;
//System.out.print(tripid);
//System.out.print(user);
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{
	
	con=Connectionclass.getConnection();
	stmt=con.createStatement();
	String sql="Select TripID,VehRegNo,StartPlace,EndPlace,StartDate,StartTime,ETA,DriverCode,DriverName,OwnerName from t_startedjourney where TripId='"+tripid+"' and EndedBy='"+user+"'";
	rs=stmt.executeQuery(sql);
	while(rs.next())
	{
		tripdate=rs.getString(5);
		tripdate=new SimpleDateFormat("dd-MMM-yy").format(new SimpleDateFormat("yyyy-MM-dd").parse(tripdate));
		if(rs.getString(7)!=null)
		{
			
			ETA=new SimpleDateFormat("dd-MMM-yy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(7)));
		}
		
		data=rs.getString(1)+"/"+rs.getString(2)+"/"+rs.getString(3)+"/"+rs.getString(4)+"/"+tripdate+"/"+rs.getString(6)+"/"+ETA+"/"+rs.getString(8)+"/"+rs.getString(9)+"/"+rs.getString(10)+"/";
	}
	
	//System.out.println(data);
	out.println(data);
}catch(Exception e)
{
	e.printStackTrace();
	}

%>

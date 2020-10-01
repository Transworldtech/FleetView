<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="moreservlets.listeners.*" errorPage="" %>
<%! 
Connection conn;
String sql,vehcode;
Statement st, st1, st2;
%>
<%
try{
Class.forName("org.gjt.mm.mysql.Driver");
conn= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
	java.util.Date now = new java.util.Date();
    	String logoutdate=""+(now.getYear()+1900)+"-"+(1+now.getMonth())+"-"+now.getDate();
    	String logouttime=""+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
	long tt=now.getTime()-1200000;
	java.util.Date now1 = new java.util.Date(tt);
	String logouttime1=""+now1.getHours()+":"+now1.getMinutes()+":"+now1.getSeconds();
out.print(logouttime+", "+logouttime1+"<BR>");
sql="select distinct(Comments), RecordDate, RecordTime, LogOutTime, LogOutDate  from t_loguseractivity where RecordDate >='"+logoutdate+"' and RecordTime >='"+logouttime1+"' and LogOutDate='-' order by RecordTime desc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	out.print(rst.getString(1) +"  "+rst.getString(2) +"  "+rst.getString(3) +"  "+rst.getString(4) +"  "+rst.getString(5) +"<br>");
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}
%>

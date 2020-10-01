<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="filedownload.*" errorPage="" %>
<html>
<%
try{
	
	Class.forName("org.gjt.mm.mysql.Driver"); 
	Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost/db_gpsExceptions","root","");
	Statement ststop1=con1.createStatement();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","");
	Statement ststop2=con.createStatement();
	String sqlstop1="select FromDate, FromTime from t_veh127_stsp where FromDate >='2008-03-01' and FromDate <='2008-03-10'";
	ResultSet rststop1=ststop1.executeQuery(sqlstop1);
	int k=0;
	while(rststop1.next())
	{
		String sqlstop2="SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFiledTextFileName,TheFieldDataDate,TheFieldDataTime,Speed,Distance  FROM t_veh127 where TheFieldDataDate='"+ rststop1.getString("FromDate")+"' and  TheFieldDataTime='"+rststop1.getString("FromTime") +"' and LatinDec>0 order by TheFieldDataTime desc";
	ResultSet rststop3=ststop2.executeQuery(sqlstop2);
	while(rststop3.next())
	{
		out.print(rststop3.getString("LatinDec")+"  "+rststop3.getString("lat1")+"  "+rststop3.getString("LonginDec")+"  "+rststop3.getString("lon1")+"<BR>");
	k++;
	}
}
	out.print("<br>"+i);
}catch(Exception e)
{
	out.print("Exception "+e);
}
%>
</html>

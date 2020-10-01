
<%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
	
	
	System.out.println(" INSIDE TRANSPORTER LIMIT>>>>>>>");
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stmt2=con1.createStatement();

ResultSet rs1=null, rs2=null;
String sql1="",sql2="";
int limit=0;
String transporter=request.getParameter("transporter");
String mobno="-",simno="-", holdby="", recby="",recbycust="",recbytech="";
sql1="select VehicleLimit from db_gps.t_transporter where TypeValue='"+transporter+"' ";
rs1=stmt1.executeQuery(sql1);
System.out.println("sql1>>>>>>>"+sql1);


if(rs1.next())
{
	limit=rs1.getInt(1);
	System.out.println("LIMIT>>>>>"+limit);
}
int count=0;
String str="select count(*) as count from db_gps.t_vehicledetails where status <> 'Deleted' and OwnerName='"+transporter+"'";
rs2=stmt2.executeQuery(str);

System.out.println("str>>>>>>>"+str);


if(rs2.next())
{
	count=rs2.getInt("count");
	System.out.println(">>>COUNT>>>>"+count);
}
if(count!=0 && limit!=0 && count==limit)
{   System.out.println(">>########>>inside if loop>>>");	
	
//out.println(">>akshay>>@@###@@@###@@###>>>"+"#");
out.println("No"+"#");


}else if(count!=0 && limit!=0 && count>limit){
	out.println("Yes1"+"#");
}else{
	out.println("Yes"+"#");
}
int ST=0,TX=0,RA=0,RD=0,OS=0;
String sqlDefault1="select ST,TX,AccelerationSpeedVarLimit,DecelerationSpeedVarLimit,Overspeedlimit from db_gps.t_defaultvals where OwnerName='Default'";
ResultSet rsDefault1=stmt2.executeQuery(sqlDefault1);
System.out.println("sqlDefault1>>>>>>>"+sqlDefault1);
if(rsDefault1.next()){
	ST=rsDefault1.getInt("ST");
	TX=rsDefault1.getInt("TX");
	RA=rsDefault1.getInt("AccelerationSpeedVarLimit");
	RD=rsDefault1.getInt("DecelerationSpeedVarLimit");
	OS=rsDefault1.getInt("Overspeedlimit");
}

String sqlDefault="select ST,TX,AccelerationSpeedVarLimit,DecelerationSpeedVarLimit,Overspeedlimit from db_gps.t_defaultvals where OwnerName='"+transporter+"'";
ResultSet rsDefault=stmt2.executeQuery(sqlDefault);

System.out.println("sqlDefault>>>>11111>>>"+sqlDefault);

if(rsDefault.next()){
	ST=rsDefault.getInt("ST");
	TX=rsDefault.getInt("TX");
	RA=rsDefault.getInt("AccelerationSpeedVarLimit");
	RD=rsDefault.getInt("DecelerationSpeedVarLimit");
	OS=rsDefault.getInt("Overspeedlimit");
}
out.println(ST+"#"+TX+"#"+RA+"#"+RD+"#"+OS+"#");
}catch(Exception e)
		{
			e.printStackTrace();
		}
%>

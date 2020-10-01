
<%@page import="java.util.Date"%><%@ include file="Connections/conn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Close Satatus</title>
</head>
<body>
<%!
Connection con;
Statement st,st1,st3;
%>
<%
try{

	
	String vehregno="",  transporter="", sertype="",SrviceName="", serdate="",email="",emailto="",delby="";
	String serkm="", nxtserdate="", nextserkm="",days="",status="",alertdate="";
	String AlertKm="",AlertafterKm="";
	 
	java.util.Date dt=new java.util.Date();

String dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
String vehid="",vehcode="",servicetype="",servicedate="";
String user=session.getValue("user").toString();
vehid=request.getParameter("VehicleRegNo");
vehcode=request.getParameter("vid");
servicetype=request.getParameter("servicetype");
servicedate=request.getParameter("servicedate");
String servicedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(servicedate));
System.out.println("servicedate1==>"+servicedate1);
System.out.println("vehcode=>"+vehcode);
Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con.createStatement();
st1=con.createStatement();
st3=con.createStatement();


String dqlhs="select * from t_lastservice where Vehid='"+vehcode+"' and servicedate='"+servicedate1+"' and ServiceType='"+servicetype+"'"; 
ResultSet rs=st1.executeQuery(dqlhs);
System.out.println("dqlhs==>"+dqlhs);
if(rs.next())
{
    System.out.println("in ifffffff");
	transporter=rs.getString("Transporter");
	serdate=rs.getString("ServiceDate");
	sertype=rs.getString("ServiceType");	
    SrviceName=rs.getString("SrviceName");  
    nxtserdate=rs.getString("NextServiceDate");
    serkm=rs.getString("ServiceKm");
    nextserkm=rs.getString("NextServiceAfterKm");
    AlertKm=rs.getString("AlertKm");
    AlertafterKm=rs.getString("AlertAfterKm");
    days=rs.getString("AlertBeforeDays");
    alertdate=rs.getString("AlertDate");
    status=rs.getString("AlertStatus");
    email=rs.getString("EmailTo");
   }

if(null==serkm||"null".equalsIgnoreCase(serkm)||serkm.equalsIgnoreCase(""))
{
	serkm="0";
}if((null==nextserkm) ||"null".equalsIgnoreCase(nextserkm) ||nextserkm.equalsIgnoreCase("")){nextserkm="0";}
if((null==AlertKm) || "null".equalsIgnoreCase(AlertKm) ||AlertKm.equalsIgnoreCase(""))
{AlertKm="0";}if((null==days)||"null".equalsIgnoreCase(days) ||days.equalsIgnoreCase("")){days="0";}
if((null==alertdate)||"null".equalsIgnoreCase(alertdate) ||alertdate.equalsIgnoreCase("")){alertdate="0000:00:00";}
if((null==AlertafterKm)||"null".equalsIgnoreCase(AlertafterKm) ||AlertafterKm.equalsIgnoreCase("")){AlertafterKm="0";}
if((null==nxtserdate)||"null".equalsIgnoreCase(nxtserdate) ||nxtserdate.equalsIgnoreCase("")){nxtserdate="0000:00:00";}
if((null==email)|| "null".equalsIgnoreCase(email)||email.equalsIgnoreCase("")){email="-";}
if((null==serdate)||"null".equalsIgnoreCase(serdate) ||serdate.equalsIgnoreCase("")){serdate="0000:00:00";}
if((null==SrviceName)||"null".equalsIgnoreCase(SrviceName) ||SrviceName.equalsIgnoreCase("")){SrviceName="-";}
if((null==sertype)||"null".equalsIgnoreCase(sertype) ||sertype.equalsIgnoreCase("")){sertype="-";}

System.out.println("insert query executed");
String delinst="insert into t_lastservicehistry(Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceDate,NextServiceAfterKm,AlertBeforedays,Alertdate,AlertKm,AlertAfterKm,AlertStatus,EmailTo,DeleteDate,DeletedBy)values('"+vehcode+"','"+vehid+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nxtserdate+"','"+nextserkm+"','"+days+"','"+alertdate+"','"+AlertKm+"','"+AlertafterKm+"','"+status+"','"+email+"','"+dt1+"','"+user+"')";
st3.executeUpdate(delinst);
out.println("delinst==>"+delinst);




String dsql="";
dsql="delete from t_lastservice  where Vehid='"+vehcode+"' and VehRegNo='"+vehid+"' and ServiceType='"+servicetype+"' and ServiceDate='"+servicedate1+"' ";
int i=st.executeUpdate(dsql);
System.out.println(dsql);
if(i>0)
	{
	out.println("sql for delete"+dsql);
	}
out.println("\n updated");
response.sendRedirect("VehicleMentananceReport.jsp");
}catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>
</html>
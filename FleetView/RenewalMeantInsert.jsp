<%@page import="java.util.Date"%><%@ include file="Connections/conn.jsp" %>
<%@ page buffer="16kb" %>
<%!
Connection con1;
%>
<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stquery=con1.createStatement();
Statement del=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql;
String user="",vehregno="", vehid="", transporter="", sertype="",SrviceName="", serdate="",email="",emailto="";
String serkm="", nxtserdate="", nextserkm="",days="";

String vendor="",amount="",recieptno="",docid="";

int AlertKm=0,AlertafterKm=0;
Date Alertdate =new Date();
String todaysdate=new SimpleDateFormat("yyyy-MM-dd").format(Alertdate);
user=session.getValue("user").toString();
//email=session.getValue("user").toString();
System.out.println("todaysdate--->"+todaysdate);
System.out.println("user-->"+user);
/*****GETTING PARAMETER FROM ENTRY FORM PAGE****/
String servicedaterp=request.getParameter("servicedaterp");
String servicetyperp=request.getParameter("servicetyperp");



 vehid=request.getParameter("vehicle_code");
 transporter=request.getParameter("transporter_1");
// System.out.println("<><><><transporter>>>>"+transporter);

 vendor=request.getParameter("vendorname");
 //System.out.println("<><><>< vendor>>>>"+ vendor);
 
 amount=request.getParameter("amount");
 //System.out.println("<><><><amount>>>>"+amount);
 
 recieptno=request.getParameter("recieptno");
 //System.out.println("<><><><recieptno>>>>"+recieptno);
 
 
 
 docid=request.getParameter("docid");
 //System.out.println("<><><>< docid>>>>"+docid);
 
 
sertype=request.getParameter("sertype");
vehregno=request.getParameter("vehicle");
serdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("calender1")));
serkm=request.getParameter("serkm");


String cal=request.getParameter("calender");
//System.out.println("------------clender-----"+cal);

if(cal==""||cal==null||cal=="-"||cal.equals("")||cal.equals("null")||cal.equals("-"))
{
	nxtserdate="-";
}

else
{
nxtserdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(cal));
//System.out.println("-------nxtserdate-----"+nxtserdate);
}

//nxtserdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("calender")));
nextserkm=request.getParameter("nxtserkm");
emailto=request.getParameter("emailto");
days=request.getParameter("days");


String user1=session.getAttribute("mainuser").toString();

System.out.println("<><><><user1>>>>"+user1);

java.util.Date dte = new java.util.Date();
System.out.println("3");
Format formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss ");
String today=formatter.format(dte);

System.out.println("<><><><today>>>>"+today);


//email=email+","+emailto;
email=emailto;
if(sertype.equalsIgnoreCase("preventive") || sertype.equalsIgnoreCase("oil"))
{
AlertKm= Integer.valueOf(serkm)+Integer.valueOf(nextserkm);
AlertafterKm=AlertKm-100;
}
//sql="select VehicleCode,OwnerName from t_vehicledetails where VehicleRegNumber ='"+vehregno+"'";
//rs1=stmt1.executeQuery(sql);
//if(rs1.next())
//{
	//vehid=rs1.getString("VehicleCode");
	//transporter=rs1.getString("OwnerName");
//}


if(!(sertype.equalsIgnoreCase("preventive")))
{
	sql="select Date('"+nxtserdate+"' - INTERVAL "+days+" Day) As Date";
	rs2=stmt1.executeQuery(sql);
	if(rs2.next())
	{
		Alertdate=rs2.getDate("Date");
	}
	if(sertype.equalsIgnoreCase("oil"))
	{
		SrviceName="Engine Oil Change/Hub Greasing";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceDate,NextServiceAfterKm,AlertBeforedays,Alertdate,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nxtserdate+"','"+nextserkm+"','"+days+"','"+Alertdate+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
		
		
		
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceDate,NextServiceAfterKm,AlertBeforedays,Alertdate,AlertKm,AlertAfterKm,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nxtserdate+"','"+nextserkm+"','"+days+"','"+Alertdate+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
		
	
	}
	if(sertype.equalsIgnoreCase("puc"))
	{
		SrviceName="PUC Renewal";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
  		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
	
		
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
	
	
	}
	if(sertype.equalsIgnoreCase("insurance"))
	{
		SrviceName="Vehicle Insurance Renewal";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
	
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
		
	
	
	}
	if(sertype.equalsIgnoreCase("tax"))
	{
		SrviceName="Tax";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
		
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
	
	
	
	
	}
	if(sertype.equalsIgnoreCase("fitness"))
	{
		SrviceName="Vehicle Fitness";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
	
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
	
	
	
	
	
	}
	if(sertype.equalsIgnoreCase("npermit"))
	{
		SrviceName="National Permit";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
	
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
	
	
	
	
	
	}
	
	
	if(sertype.equalsIgnoreCase("permit"))
	{
		SrviceName="Permit Five Years";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
	
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
	}
	
	
	
	if(sertype.equalsIgnoreCase("sparepart"))
	{
		SrviceName="Spare Part Repairing";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
		System.out.println(sql);
		stmt1.executeUpdate(sql);
	
	
		sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);
}
	
	
	
	
	
}
else
{
	SrviceName="Preventive Maintenance";
	sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceAfterKm,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID) "+
 	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nextserkm+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
	System.out.println(sql);
	stmt1.executeUpdate(sql);


	sql="INSERT INTO db_gps.t_lastservicehistry (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceAfterKm,AlertKm,AlertAfterKm,EmailTo,UpdatedDateTime,UpdatedBy,Status,VendorName,Amount,RecieptNo,DocID) "+
    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nextserkm+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"', '"+today+"','"+user1+"','Renewal','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"')";
System.out.println(sql);
stmt1.executeUpdate(sql);



}
System.out.println("renewal sql==>"+sql);



String sqldel="update  t_lastservice set AlertStatus='closed' where VehRegNo='"+vehregno+"' and servicedate='"+servicedaterp+"' and servicetype='"+servicetyperp+"'";
del.executeUpdate(sqldel);
System.out.println("renewal updare==>"+sqldel);
String abcd=sql.replace("'","#");
abcd=abcd.replace(",","$");
stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");

System.out.println("servicedaterp before format==>"+servicedaterp);
servicedaterp=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(servicedaterp));
System.out.println("servicedaterp after format==>"+servicedaterp);
//response.sendRedirect("VehicleMentanancerenewal.jsp?inserted=yes&servicedate="+servicedaterp+"&servicetype="+servicetyperp+"&vehid="+vehid+"&vehregno="+vehregno+" ");

response.sendRedirect("VehicleMentananceReport.jsp?inserted3=yes");
return; 
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
} 
%>
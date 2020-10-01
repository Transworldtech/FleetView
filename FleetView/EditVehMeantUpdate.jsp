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
String user="",vehregno="", vehid="", transporter="", sertype="",SrviceName="", serdate="",email="",emailto="",servicename1="";
String serkm="", nxtserdate="", nextserkm="",days="",vendor="",amnt="",recieptnumber="",documentid="";
int AlertKm=0,AlertafterKm=0;
Date Alertdate =new Date();
System.out.println("------Alertdate---------->>>>"+Alertdate);

String todaysdate=new SimpleDateFormat("yyyy-MM-dd").format(Alertdate);

System.out.println("------Alertdate in chaned format---------->>>>"+todaysdate);

user=session.getValue("user").toString();
//email=session.getValue("user").toString();
System.out.println("todaysdate--->"+todaysdate);
System.out.println("user-->"+user);
/*****GETTING PARAMETER FROM ENTRY FORM PAGE****/
String servicedaterp=request.getParameter("service_date");
//System.out.println("-----servicedate-------->"+servicedaterp);

String srvkm=request.getParameter("service_km");
//System.out.println("-----Maintenance Km-------->"+srvkm);


String srvnxtkm=request.getParameter("service_nxtsrv");
//System.out.println("----- Next Maintenance After------->"+srvnxtkm);


String servicedaterp1=request.getParameter("service_date1");
//System.out.println("-----:------->"+servicedaterp1);

String servicetyperp=request.getParameter("servicetyper");
//System.out.println("----- ------------>"+servicetyperp);

 servicename1=request.getParameter("service_name");
 //System.out.println("----- ------------>"+servicename1); 
 
 
String nxtservicedate2=request.getParameter("nextservicedate1");
//System.out.println("----- nextservicedate1------------>"+nxtservicedate2);

String nxtservicedate12=request.getParameter("nextservicedate2");
//System.out.println("----- Next Maintenance Date------------>"+nxtservicedate12);




String alertdate2=request.getParameter("alertdate1");
//System.out.println("----- alertdate1------------>"+alertdate2);

String entereddate2=request.getParameter("entereddate1");
//System.out.println("----- entereddate1------------>"+entereddate2);

String vehcode=request.getParameter("vehicle_code");
//System.out.println("----- vehicle_code------------>"+vehcode);

String servicedater2=request.getParameter("service_date22");
System.out.println("<><><><service dater 2----->"+servicedater2);

//String vendorname=request.getParameter("vendorname");
//System.out.println("----- vendorname------------>"+vendorname);

//String amount=request.getParameter("amount");
//System.out.println("----- amount------------>"+amount);

//String recieptno=request.getParameter("recieptno");
//System.out.println("-----recieptno------------>"+recieptno);

//String docid=request.getParameter("docid");
//System.out.println("----docid------------>"+docid);

String nxtservicedate22="-";
if(nxtservicedate2==null ||  nxtservicedate2==""||nxtservicedate2=="-"||nxtservicedate2.equals("null")||nxtservicedate2.equals("")||nxtservicedate2.equals("-"))
{
	nxtservicedate22="-";
	}
else
{

 nxtservicedate22=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(nxtservicedate2));
}
//Date servicedaterp =new Date();
//String servicedaterp22=new SimpleDateFormat("yyyy-MM-dd").format(servicedaterp);



System.out.println("<><><><servicename1>>>>"+servicename1);
System.out.println("<><><><vehcode>>>>"+vehcode);
System.out.println("<><><><nxtservicedate1>>>"+nxtservicedate2);
System.out.println("<><><><nxtservicedate12>>>"+nxtservicedate12);
System.out.println("<><><><alertdate2>>>>"+alertdate2);
System.out.println("<><><><entereddate2>>>"+entereddate2);
System.out.println("<><><><nxtservicedate22>>>"+nxtservicedate22);




sertype=request.getParameter("sertype");
System.out.println("<><><><13123213"+sertype);
System.out.println("<><><><servicedater2>>>"+servicedater2);
//System.out.println("<><><><2servicedaterp22>>>>"+servicedaterp2);
System.out.println("<><><><2servicedaterp1>>>>"+servicedaterp1);
System.out.println("<><><><servicedaterp>>>>"+servicedaterp);



//System.out.println("<><><><3servicedaterp1>>>>>"+servicedaterp1);
vehregno=request.getParameter("vehicle");

String cal1=request.getParameter("calender1");
System.out.println("------------clender1-----"+cal1);

serdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(cal1));
System.out.println("-------serdate-----"+serdate);

serkm=request.getParameter("serkm");


String cal=request.getParameter("calender");
System.out.println("------------clender-----"+cal);

if(cal==""||cal==null||cal=="-"||cal.equals("")||cal.equals("null")||cal.equals("-"))
{
	nxtserdate="-";
}
else
{
nxtserdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(cal));
System.out.println("-------nxtserdate-----"+nxtserdate);
}

nextserkm=request.getParameter("nxtserkm");
emailto=request.getParameter("emailto");
days=request.getParameter("days");
vendor=request.getParameter("vendorname");
System.out.println("vendorname----------->"+vendor);

amnt=request.getParameter("amount");
recieptnumber=request.getParameter("recieptno");
documentid=request.getParameter("docid");


System.out.println("<><><><serkm>>>>"+serkm);

System.out.println("<><><><nextserkm>>>"+nextserkm);

System.out.println("<><><><serdate>>>>"+serdate);
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
	sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"',ServiceKm ='"+serkm+"', NextServiceAfterKm='"+nextserkm+"', NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"' , EmailTo='"+email+"', EntDate='"+todaysdate+"',EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and  SrviceName= '"+servicename1+"' and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"' and NextServiceDate='"+nxtservicedate22+"'  ";
	System.out.println(sql);
		
		System.out.println(sql);
	//	sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceDate,NextServiceAfterKm,AlertBeforedays,Alertdate,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy) "+
		//    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nxtserdate+"','"+nextserkm+"','"+days+"','"+Alertdate+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	if(sertype.equalsIgnoreCase("puc"))
	{
		SrviceName="PUC Renewal";
		
		sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"',ServiceKm ='"+serkm+"', NextServiceAfterKm='0', NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"' , EmailTo='"+email+"', EntDate='"+todaysdate+"',EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and  SrviceName= '"+servicename1+"' and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'  and NextServiceDate='"+nxtservicedate22+"'   ";
		System.out.println(sql);  
	
		
		
		
		//sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
  		  //  "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	if(sertype.equalsIgnoreCase("insurance"))
	{
		SrviceName="Vehicle Insurance Renewal";
		
		sql="update t_lastservice set ServiceDate='"+serdate+"' , ServiceType='"+sertype+"', SrviceName='"+SrviceName+"', ServiceKm ='"+serkm+"', NextServiceAfterKm='0', NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"' ,  EmailTo='"+email+"', EntDate='"+todaysdate+"', EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and    SrviceName= '"+servicename1+"' and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'  and NextServiceDate='"+nxtservicedate22+"'  ";
		System.out.println(sql);
	//	sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
		//    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	if(sertype.equalsIgnoreCase("tax"))
	{
		SrviceName="Tax";
   
		sql="update t_lastservice set ServiceDate='"+serdate+"', ServiceType='"+sertype+"', SrviceName='"+SrviceName+"', ServiceKm ='"+serkm+"', NextServiceAfterKm='0', NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"', EmailTo='"+email+"', EntDate='"+todaysdate+"', EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and   SrviceName= '"+servicename1+"'  and  EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'   and NextServiceDate='"+nxtservicedate22+"'  ";
		System.out.println(sql);
		//sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
		  //  "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	if(sertype.equalsIgnoreCase("fitness"))
	{
		SrviceName="Vehicle Fitness";

		sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"', ServiceKm ='"+serkm+"', NextServiceAfterKm='0', NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"', EmailTo='"+email+"', EntDate='"+todaysdate+"', EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and  SrviceName= '"+servicename1+"'  and  EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'  and NextServiceDate='"+nxtservicedate22+"'  ";
		System.out.println(sql);
			//sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
		    //"VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	if(sertype.equalsIgnoreCase("npermit"))
	{
		SrviceName="National Permit";
		
		sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"',ServiceKm ='"+serkm+"', NextServiceAfterKm='0',NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"', EmailTo='"+email+"', EntDate='"+todaysdate+"',EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and SrviceName= '"+servicename1+"'  and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'  and NextServiceDate='"+nxtservicedate22+"'  ";
		System.out.println(sql);
//		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
	//	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	
	if(sertype.equalsIgnoreCase("permit"))
	{
		SrviceName="Permit Five Years";
		
		sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"',ServiceKm ='"+serkm+"', NextServiceAfterKm='0',  NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"', EmailTo='"+email+"', EntDate='"+todaysdate+"',EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and SrviceName= '"+servicename1+"'  and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'  and NextServiceDate='"+nxtservicedate22+"'  ";
		System.out.println(sql);
//		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
	//	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	
	if(sertype.equalsIgnoreCase("sparepart"))
	{
		SrviceName="Spare Part Repairing";
		
		sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"',ServiceKm ='"+serkm+"', NextServiceAfterKm='0',  NextServiceDate='"+nxtserdate+"', AlertBeforedays='"+days+"', Alertdate='"+Alertdate+"', EmailTo='"+email+"', EntDate='"+todaysdate+"',EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where  Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and SrviceName= '"+servicename1+"'  and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"'  and NextServiceDate='"+nxtservicedate22+"'  ";
		System.out.println(sql);
//		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy) "+
	//	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"')";
	}
	
	
	
	
	
}
else
{
	SrviceName="Preventive Maintenance";
	sql="update t_lastservice set ServiceDate='"+serdate+"',ServiceType='"+sertype+"',SrviceName='"+SrviceName+"',ServiceKm='"+serkm+"',NextServiceAfterKm='"+nextserkm+"',AlertKm='"+AlertKm+"', AlertAfterKm='"+AlertafterKm+"', EmailTo='"+email+"', EntDate='"+todaysdate+"',EntBy='"+user+"',VendorName='"+vendor+"',Amount='"+amnt+"',RecieptNo='"+recieptnumber+"',DocID='"+documentid+"' where Vehid='"+vehcode+"' and VehRegNo='"+vehregno+"' and   SrviceName= '"+servicename1+"' and EntDate='"+entereddate2+"' and  ServiceDate='"+servicedaterp1+"' ";
	
	System.out.println(sql);
//	sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceAfterKm,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy) "+
 //	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nextserkm+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"')";
}
System.out.println("edit sql==>"+sql);
stmt1.executeUpdate(sql);
String abcd=sql.replace("'","#");
abcd=abcd.replace(",","$");
stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");

/*servicedaterp=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(servicedaterp));
System.out.println("servicedaterp after format==>"+servicedaterp);
response.sendRedirect("VehicleMentananceEdit.jsp?inserted=yes&servicedate="+servicedaterp+"&servicetype="+servicetyperp+"&vehid="+vehid+"&vehregno="+vehregno+" ");*/
response.sendRedirect("VehicleMentananceReport.jsp?inserted=yes");
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
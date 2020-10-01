<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Connections/conndriver.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection con ;
String tripid = request.getParameter("tripid");
String OldTripId = request.getParameter("OldbrifId1");
String frompage = request.getParameter("frompage");
String briefdate = request.getParameter("briefdate");
String debrifdate = request.getParameter("debrifdate");
String brifId = request.getParameter("brifId");

String html1="";
String Email=session.getAttribute("email").toString();
String RejectedBy=session.getAttribute("mainuser").toString();




try{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
	Statement stmt6=con.createStatement();
	
	Statement stmt3=con.createStatement();
	Statement stmt2=con.createStatement();
	Statement st1=con.createStatement();
	
String sql1 ="",sql2 ="",sql3 ="",sql4 ="",sql5 ="",sql6=""; 
//sql1 = "select * from db_gps.t_completedjourney where tripid='"+tripid+"'";
//ResultSet rs1 =stmt.executeQuery(sql1);

//if(rs1.next())
//{
//	response.sendRedirect("enterTripid.jsp?&msg=alreadypresent&rdpassport="+frompage+"&briefdate="+briefdate+"&debrifdate="+debrifdate);
//}else{

	String TBriefid="",Ttripid="",TDriverid="",TDriverName="";	
sql2 = "select * from db_gps.t_briefing where tripid='"+tripid+"'";
ResultSet rs2 =stmt2.executeQuery(sql2);
if(rs2.next()){
	TBriefid=rs2.getString("Briefid");
	Ttripid=rs2.getString("tripid");
	TDriverid=rs2.getString("Driverid");
	TDriverName=rs2.getString("DriverName");
		response.sendRedirect("enterTripid.jsp?&msg=alreadypresent&rdpassport="+frompage+"&briefdate="+briefdate+"&debrifdate="+debrifdate+"&Briefid="+TBriefid+"&tripid="+Ttripid+"&Driverid="+TDriverid+"&DriverName="+TDriverName);
}else 
{
	sql3 = "select * from db_gps.t_debriefing where tripid='"+tripid+"'";
	ResultSet rs3 =stmt3.executeQuery(sql3);
	if(rs3.next()){
		
		TBriefid=rs2.getString("Briefid");
		Ttripid=rs2.getString("tripid");
		TDriverid=rs2.getString("Driverid");
		TDriverName=rs2.getString("DriverName");
		
			//response.sendRedirect("enterTripid.jsp?msg=alreadypresent&rdpassport="+frompage+"&briefdate="+briefdate+"&debrifdate="+debrifdate);
		response.sendRedirect("enterTripid.jsp?&msg=alreadypresent&rdpassport="+frompage+"&briefdate="+briefdate+"&debrifdate="+debrifdate+"&Briefid="+TBriefid+"&tripid="+Ttripid+"&Driverid="+TDriverid+"&DriverName="+TDriverName);
	}
	else
	{String DriveId="",DriverName="",BriefId="",subject="",toid="",tobcc="",tocc="",entrydatetime="",mailstatus="Pending",TrainerName="";
		String startplace="",endplace="",VehRegNo="",Transporter="";
		sql6 = "select * from db_gps.t_briefing where  brifdate = '"+briefdate+"' and  Briefid='"+brifId+"'";
		ResultSet rs6 =stmt6.executeQuery(sql6);
		if(rs6.next()){
			DriveId=rs6.getString("Driverid");
			DriverName=rs6.getString("DriverName");
			BriefId=rs6.getString("Briefid");					
			TrainerName=rs6.getString("TrainerName");		
			startplace=rs6.getString("startplace");
			endplace=rs6.getString("endplace");
			VehRegNo=rs6.getString("VehRegNo");
			Transporter=rs6.getString("Transporter");		
			
				
		}

		int r1=0,r2=0,r3=0,r4=0,r5=0,r6=0;	
		sql4 = "update db_gps.t_briefing set tripid='"+tripid+"' ,tripidenteredBy='"+session.getAttribute("user").toString()+"' where brifdate = '"+briefdate+"'and  Briefid='"+brifId+"' ";
		r1=stmt1.executeUpdate(sql4);
		
		sql5 = "update db_gps.t_debriefing set tripid='"+tripid+"' ,tripidenteredBy='"+session.getAttribute("user").toString()+"' where Debriefdate = '"+debrifdate+"' and  Briefid='"+brifId+"'";
		r2=stmt1.executeUpdate(sql5);
		sql4 = "update db_gps.t_intermediatejrmroute set Tripid='"+tripid+"'where briefid = '"+brifId+"'";
		r3=stmt1.executeUpdate(sql4);
		
		sql5 = "update db_gps.t_jrnyplanning set Tripid='"+tripid+"'where brifid = '"+brifId+"'";
		r4=stmt1.executeUpdate(sql5);
		
		sql4="INSERT INTO db_gps.t_tripidhistory (oldTripId,newTripId,driverId,EntryBy,briefid) VALUES ('"+OldTripId+"', '"+tripid+"', '"+DriveId+"', '"+RejectedBy+"','"+brifId+"')";
		r5=stmt1.executeUpdate(sql4);
		if(!(TrainerName.equalsIgnoreCase(RejectedBy)))
		{
		try{
		String bDate="";
		bDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(briefdate));
			
			
	html1 = "<html><body><font face=Arial>Dear Sir/Mam, <br><br>You have failed to correct the trip id in your briefing entry within specified time.<br>"+
	"It is corrected by another user.<br> Details are given below. <br> Please make sure that correct trip has been entered in briefing record.<br>"+
	"Details :<br><br><table align=left border=1 cellpadding=0 cellspacing=0>"+
	"<tr><td> Brief-Id </td><td> "+brifId+"</td><td>Briefing Date / Time </td><td>"+bDate+"</td></tr>"+
	"<tr><td> Driver Id </td><td> "+DriveId+"</td><td> Driver Name </td><td>"+DriverName+"</td></tr>"+
	"<tr><td> Transporter </td><td>"+Transporter+"</td><td> Vehicle Reg. No </td><td> "+VehRegNo+"</td></tr>"+
	"<tr><td> Origin </td><td>"+startplace+"</td><td> Destination </td><td> "+endplace+"</td></tr>"+
	"<tr><td> Briefed By </td><td> "+TrainerName+"</td><td> Corrected By </td><td> "+RejectedBy+"</td></tr>"+
	"<tr><td> Old Trip Id </td><td>"+OldTripId+"</td><td> New Trip Id </td><td> "+tripid+"</td></tr>"+
	"</table><br><br><br><br><br><br><br><br><br><br>If any further assistance require,please contact below"+
	"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</font></body></html>";

subject = "Trip id correction failure - Trip ID:"+OldTripId+" Origin:"+startplace+" Destination:"+endplace;

	toid= TrainerName;
	tocc="anthony@getl.co.in,"+RejectedBy;
	tobcc= "fleetviewReports@mobile-eye.in,r_maner@transworld-compressor.com,a_laddha@myfleetview.com";
	entrydatetime = new SimpleDateFormat("yyyy-MM-dd hh:mm").format(new java.util.Date());
	
	
	
	int r=0;
	sql5= "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,Tocc,Tobcc,EntryDateTime,MailStatus,SenderName) values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+tocc+"','"+tobcc+"','"+entrydatetime+"','"+mailstatus+"','"+RejectedBy+"')";
	r=st1.executeUpdate(sql5);
	}
	catch(Exception e)
	{e.printStackTrace();
	}	
		
		}
		
		response.sendRedirect("enterTripid.jsp?msg=inserted&rdpassport="+frompage+"&briefdate="+briefdate+"&debrifdate="+debrifdate);
	}
	}
//}
}
catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>
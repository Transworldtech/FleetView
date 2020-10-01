
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1;
%>
<%  
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;

String DriveId=request.getParameter("DriveId");
String DriverName=request.getParameter("DName");
String transporter=request.getParameter("trans");
System.out.println("ttttttttttttt>>>>>>>>>>>>"+transporter);
//String debriefid=request.getParameter("debriefid");

String EmailId=request.getParameter("EmailId");

String veh = request.getParameter("VehRegNo");
StringTokenizer stk = new StringTokenizer(veh,",");
String vehicleRegNumber=stk.nextToken();
System.out.println("55555555555mmmmmmmmmmmmmmFFFFFF"+vehicleRegNumber);
String subject = "",html1 = "",toid ="",tocc ="",entrydatetime ="",mailstatus = "Pending";
//String debriefid=request.getParameter("debriefid");


String sql5 ="";

int fg=0;

	
String DriRej=request.getParameter("ChkAdh");
String VehRej=request.getParameter("ChkAdhJ");
String reasonDr=request.getParameter("reason1");
String reasonVh=request.getParameter("reason2");
String Email=session.getAttribute("email").toString();
String RejectedBy=session.getAttribute("mainuser").toString();
System.out.println(DriRej+" ` "+VehRej+" ` "+reasonDr+" ` "+reasonVh);
String buffer;

if(DriRej=="Yes"|| DriRej.equals("Yes"))
{

String sql1="insert into db_gps.t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,CommentForRejection,status,transporter,DriverName,RejectedBy) values ('"+DriveId+"','Driver Rejection','"+reasonDr+"','"+DriRej+"','"+transporter+"','"+DriverName+"','"+RejectedBy+"') ";

//sql="update db_gps.t_reasonOfRejectionForDriverset AdhJRM='"+ChkAdh+"',AdhJRMReason='"+reason1+"', AdhJourney='"+ChkAdhJ+"', AdhJourneyReason='"+reason2+"' where Driverid='"+DriveId+"' and  BriefId='"+DriverName+"'";
//System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql1);
if(ins>=1){
		buffer="Updated";
		System.out.println("Updates : "+sql1);
		//out.print(buffer);
fg=1;
//buffer=null;
}

html1 = "<html><body>Dear Sir/Mam, <br><br>Trainer "+RejectedBy+" Reject To This Driver For Trip<br>Driver ID:- "+DriveId
+" <br>Driver Name:- "+DriverName+" <br>Tansporter:- "+transporter+" <br> Reject Reason :- "+reasonDr+"<br>Rejected By:- "+RejectedBy+"<br><br>If any further assistance require,please contact below"+
"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</body></html>";

		subject = "Driver Reject For Trip ";
         
		 toid= EmailId;
		tocc = "fleetviewReports@mobile-eye.in";
			
			entrydatetime = new SimpleDateFormat("yyyy-MM-dd hh:mm").format(new java.util.Date());
			
			System.out.println("**** mailllll_updatteeeeeeee  ");
			try{
			
			sql5= "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+Email+"','"+entrydatetime+"','"+mailstatus+"','"+RejectedBy+"')";
			System.out.println("**** mailllll_updatteeeeeeee  " +sql5);
			System.out.println("111111111111111 " );
			//String abcd444=sql5.replace("'","#");	
	 		 //abcd444=abcd444.replace(",","$");								
	 		//stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			
			st1.executeUpdate(sql5);
			System.out.println("2222222222" );
			System.out.println("**** mailllll  "+sql5);
			}
			catch(Exception e)
			{e.printStackTrace();}
			




}



if(VehRej=="Yes"|| VehRej.equals("Yes"))
{
	String sql2="insert into db_gps.t_reasonOfRejectionForDriver (DriverId,VehRegNo,ReasoneForRejection,CommentForRejection,status,transporter,DriverName,RejectedBy) values (0,'"+vehicleRegNumber+"','Vehicle Rejection','"+reasonVh+"','"+VehRej+"','"+transporter+"','"+DriverName+"','"+RejectedBy+"')";
	System.out.println("Updates 2: "+sql2);
	//sql="update db_gps.t_reasonOfRejectionForDriverset AdhJRM='"+ChkAdh+"',AdhJRMReason='"+reason1+"', AdhJourney='"+ChkAdhJ+"', AdhJourneyReason='"+reason2+"' where Driverid='"+DriveId+"' and  BriefId='"+DriverName+"'";
	//System.out.println("$$$$$$"+sql);
	try{
	int ins1=0;	/*****************************/
	ins1=st1.executeUpdate(sql2);
	if(ins1>=1){
			buffer="Updated";
			System.out.println("Updates 2: "+sql2);
			//out.print(buffer);
	//buffer=null;
	fg=1;
	}
	}catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	
	

	/* html1 = "<html><body>First Time Pass Rate (FTPR)  status. <br><br>Trainer "+RejectedBy+" Reject To This Vehicle For Trip<br>Vehicle No:- "+vehicleRegNumber
	+" <br>Transporter:- "+transporter+" <br>FTPR Reject Reason :- "+reasonVh+"<br>Rejected By:- "+RejectedBy+"<br><br>If any further assistance require,please contact below"+
	"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</body></html>"; */

	html1 = "<html><body>First Time Pass Rate (FTPR)  status. <br><br>Trainer "+RejectedBy+" Reject To This Vehicle For Trip<br>Vehicle No:- "+vehicleRegNumber
	+" <br>Transporter:- "+transporter+" <br>FTPR Reject Reason :- "+reasonVh+"<br>Rejected By:- "+RejectedBy+"<br><br>Thanks and Regards<br>Transworld Team</body></html>";
	
	
			//subject = "Vehicle Reject For Trip ";
			subject = "Vehicle FTPR Reject For Trip";
			
			 toid= EmailId;
			tocc = "fleetviewReports@mobile-eye.in";
				
				entrydatetime = new SimpleDateFormat("yyyy-MM-dd hh:mm").format(new java.util.Date());
				
				System.out.println("**** mailllll_updatteeeeeeee  ");
				try{
				
				sql5= "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,EntryDateTime,MailStatus,SenderName) values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+entrydatetime+"','"+mailstatus+"','"+RejectedBy+"')";
				System.out.println("**** mailllll_updatteeeeeeee  " +sql5);
				System.out.println("111111111111111 " );
				//String abcd444=sql5.replace("'","#");	
		 		 //abcd444=abcd444.replace(",","$");								
		 		//stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
				
				st1.executeUpdate(sql5);
				System.out.println("2222222222" );
				System.out.println("**** mailllll  "+sql5);
				}
				catch(Exception e)
				{e.printStackTrace();}
				

	
}

if(fg==1)
{
	buffer="Updated";
	System.out.println("Resu;ltttt");
	out.print(buffer);
	
}


} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 

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
String BrifId=request.getParameter("BrifId");
String TripId=request.getParameter("TripId");
String tr=request.getParameter("tr");
String Trainer=session.getAttribute("mainuser").toString();
String EmailId=request.getParameter("EmailId");
String StPlc=request.getParameter("StPlc");
String EdPlc=request.getParameter("EdPlc");

String subject = "",html1 = "",toid ="",tocc ="",entrydatetime ="",mailstatus = "Pending";
//String debriefid=request.getParameter("debriefid");


final String userTypeValue = session.getAttribute("usertypevalue").toString();
final String typeOfUser = session.getAttribute("TypeofUser").toString();
String DBtocc="";
String sql5="SELECT * FROM db_gps.t_briefingmail where transporter='"+userTypeValue+"'";
ResultSet rs5=st.executeQuery(sql5); 
if(rs5.next())
{	DBtocc=rs5.getString("tocc");
}



 sql5 ="";


//String debriefid=request.getParameter("debriefid");





String buffer;


sql="update db_gps.t_briefing set ApproveT='Refresher Training Required',TReason='"+tr+"',ApproveBy='"+Trainer+"' where Driverid='"+DriveId+"' and  BriefId='"+BrifId+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
if(ins>=1){
		buffer="Updated";
		System.out.println("Updates : "+sql);
	


		


		
		
	
		
		

		
	//	html1 = "<html><body>Dear Sir/Mam, <br><br>Trainer "+Trainer+" Approve To This Driver For Trip<br>Driver ID:- "+DriveId
	//	+" <br>Brief ID:- "+BrifId+" <br>Trip ID :- "+TripId+"<br> Approve Caution:-Refresher Training Required<br>Approve Reason:-"+tr+"<br>Approve By:- "+Trainer+"<br><br>If any further assistance require,please contact below"+
	//	"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</body></html>";
//
	

	html1 = "<html><body>Dear Sir/Mam,<br><br> Warm Greetings!!! <br><br>DMC Person : "+Trainer+" Approved the Driver for Trip, which is not inline with Policy.<br> Details are as below : <br><br>"
				+"Approve Caution:- Refresher Training Required<br>Approve Reason:-"+tr+"<br>Approve By:- "+Trainer+"<br>"		
				+"<br>Driver ID:- "+DriveId+"<br>Brief ID:- "+BrifId+" <br>Trip ID :- "+TripId+"<br>Origin :- "+StPlc+"<br>Destination :- "+EdPlc
				+"<br><br><b>Note: </b>This is Beta Version, if any issue in this regard, pls let us know."
				+"<br><br>If any further assistance require,please contact below"+
				"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</body></html>";

				subject = "Approval For Refresher Training Required";

				 toid= EmailId;
				tocc = "fleetviewReports@mobile-eye.in,"+DBtocc;
					
					entrydatetime = new SimpleDateFormat("yyyy-MM-dd hh:mm").format(new java.util.Date());
					
					System.out.println("**** mailllll_updatteeeeeeee  ");
					try{
					
					sql5= "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+tocc+"','"+entrydatetime+"','"+mailstatus+"','"+Trainer+"')";
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
					
					out.print("Updated~");	
				
              
}

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		st1.close();
		con1.close();
	}

%>
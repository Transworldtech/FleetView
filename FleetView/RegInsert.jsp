<%@ include file="Connections/conn.jsp" %>
<%@page import="java.sql.DriverManager"	%>
<%@page import="java.util.Date"	%>
<%@page import="java.sql.SQLException"	%>
<%@page import="java.sql.Statement"	%>
<%@page import="java.text.DateFormat"	%>
<%@page import="java.text.SimpleDateFormat"	%>
<%@page import="java.sql.Connection"	%>
<%@page import="java.sql.ResultSet"	%>
<%!
	Connection con1;
	
%>
<%! 

static Statement  stmail;
static Statement  stEmailDetails;
static Connection conn1=null;

	
	
	
	String SystemName="", Website="", Logo1="", Logo2="", Signature="", fromLabel="",replyToMailid="", Disclaimer="";
	
	
	public void GetConnection()
	{
		try
		{
			
			Class.forName("org.gjt.mm.mysql.Driver");
			conn1= (Connection) DriverManager.getConnection("jdbc:mysql://103.8.126.138/db_gps","fleetview","1@flv");
			//conn1= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
			//conn1= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
			stmail=conn1.createStatement();	
			stEmailDetails=conn1.createStatement();
			System.out.println("====Got Connection=====");
		}
		catch (Exception e) 
		{
			System.out.println("Exception GetConn-------->>"+e);
		}
	}

	// Standard email function for sending mail pass the parameter as it is 
	//======Send MAil========================================================================================
	public  boolean sendmail(String str, String toID, String ccID, String Customer,String heading,  String date1, String date2, int displayedReportNo, String ReportName,  String FileName,String AttachFilePath)
	{
		
		GetConnection();
		
	try
	{
		
		String getEmailDetails="select * from t_EmailReportSettings	where System='myfleetview' ";
		ResultSet rs=stEmailDetails.executeQuery(getEmailDetails);
		
		while(rs.next())
		{
			 SystemName=rs.getString("System");
			 Website=rs.getString("Website");
			 Logo1=rs.getString("Logo1");
			 Logo2=rs.getString("Logo2");
			 Signature=rs.getString("Signature");
			 fromLabel=rs.getString("fromLabel");
			 replyToMailid=rs.getString("replyToMailid");
			 Disclaimer=rs.getString("Disclaimer");
			
		}
		
	}catch(Exception e)
	{
		System.out.println("Exception "+e.getMessage());
	}
		
		boolean flag = false;
		try
	        {		java.util.Date date = new java.util.Date();
					
			        DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
	
			        
	        		//Subject
			  		String subject =ReportName+" "+ Customer+" "+df.format(date); 
			 		System.out.println(" subject name "+subject);
			  		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			        Calendar cal = Calendar.getInstance();
			        String DateTime = dateFormat.format(cal.getTime());
			        
			        //System.out.println("The html data ==>"+str);
			        
			        //Mail Format
			        String html = "<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
	 						"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
	 						"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
	 						"<img src="+Logo1+" style=^height: 80px; width: 100px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
	 						"<img src="+Logo2+"  style=^height: 80px; width: 400px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
	 						"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
	 						" <u><a href=http://"+Website+"></u>"+Website+"</a>  "+ df.format(new Date()) +"  <br>"+"\n  "+ heading  +" "+ date1 +" "+date2+"</font><br><table><tr><td align = center style = ^margin-left:20px;^>";
			        
			        html = html + str;
			        //html = html + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>"+Signature+"</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr><td><font size=^3^ face=^Arial^>Email: avlsupport@mobile-eye.in</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Thanks and Regards</font></td></tr><tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
			        html = html + "<tr><td align = left><table align= left> <td align=left><font size=^2^ face=^arial^>"+FileName+"</font></td>   <br></br> <tr><td><font size=^3^ face=^Arial^>"+Signature+"</font></td>   </tr> <tr>  <td><font size=^3^ face=^Arial^> "+Disclaimer+"</font></td> </tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
			        System.out.println("The html data ==>"+html);
			        String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath)values('TWSupports','Custom Report ','"+html+"','"+subject+"','"+toID+"','"+ccID+"','"+DateTime+"','Pending','Transworld', '"+FileName+"'  , '"+AttachFilePath+"')";
			        //System.out.println("Query ==>"+q2);
			        stmail.executeUpdate(q2);
		            System.out.println("the record has been successfully inserted into table"); 	             
		            flag = true;
			 	    //System.out.println("YOUR STRING:- "+html);
			 	  
	       }  
	       catch(Exception e)
	       {
	    	   e.printStackTrace();
	       }
		
		return flag;
	}
	

%>
<%
		
		java.util.Date tdydte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Format df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
		String brfdate=formatter.format(tdydte);
		String brfdate2=df.format(tdydte);
		
		System.out.println("brfdate "+brfdate+" brfdate2 "+brfdate2);
		
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();      
		Statement stquery=con1.createStatement();
		Statement st1=con1.createStatement();
		Statement stmt11=con1.createStatement();    
		Statement stmt4=con1.createStatement();   
		Statement stmt5=con1.createStatement(); 
		Statement st=con1.createStatement();
		Statement stReportNo=con1.createStatement();
		Statement stReportNo2=con1.createStatement();
		Statement stcode=con1.createStatement();
		
		String startplace=request.getParameter("startplace");
		System.out.println("Start Place"+startplace);
		String  endplace1=request.getParameter("endplace");
		System.out.println("End Place"+endplace1);
		
		String userid=session.getAttribute("user").toString();
		System.out.println("userid "+userid);
		String veh = request.getParameter("VehRegNo");
		
		String vehT = request.getParameter("VehType");
		System.out.println("44444444444444444>>>>>>>>"+vehT);

		StringTokenizer stk = new StringTokenizer(veh,",");
		String vehicleRegNumber=stk.nextToken();
		System.out.println("5555555555555555555555577777777"+vehicleRegNumber);
	
		
		String transporter=request.getParameter("transporter");
		String MobNo=request.getParameter("Mob");
		String MobNo1=request.getParameter("Mob1");

		String CleanerId=request.getParameter("CleanerId");
		String CleanerName=request.getParameter("CleanerName");

		String tripid=request.getParameter("TripId");
		tripid=tripid.replaceAll("'"," ");
		tripid=tripid.replaceAll(" ","");		
		tripid=tripid.trim();
		
		String driverid=request.getParameter("DriverId");
		System.out.println("ffffffffffffffffffffff" +driverid);
		String drivername=request.getParameter("DriverName"); 
		String mode=request.getParameter("mode");
		String pdate=request.getParameter("data");
		
		String ApproveBy=request.getParameter("ApproveBy");
		String ApproveByMailID=request.getParameter("ApproveByMailID");

		String ReportName="";
		int displayedReportNo=0;
		String heading="";
		
		 boolean flag=false;
	
		String  NonCVeh=request.getParameter("NonCVeh");
		System.out.println(" NonCVeh "+NonCVeh);
		
     int fdname=0;
     if(MobNo1=="")
     {
    	 MobNo1=MobNo;
     }

	
	System.out.println("ccccccccccccccccccccccccccccccccccc=====" +fdname);
	
	
	try{
		
		String sql31="select Briefid as fdname from t_briefing where driverid='"+driverid+"' and tripid='"+tripid+"'";
			System.out.println(sql31);
		ResultSet rs21=stmt11.executeQuery(sql31);
		if(rs21.next()){
			
		
				response.sendRedirect("driver_debrifing_Reg_alert1.jsp?TripId="+tripid+"&driverid="+driverid);
				System.out.println("RRRRRRRRRRRRRRRRRRRR");
		}			
				else
				{
				
					String scode="-",ecode="-";			
					String sqlst="select startcode,endcode from db_gps.t_castrolroutes where Startplace='"+startplace+"' and Endplace='"+endplace1+"' and lasttripdate>curdate() - INTERVAL 90 DAY  limit 1";
					ResultSet rsst=stcode.executeQuery(sqlst);
					if(rsst.next()){
						scode=rsst.getString("startcode");
						ecode=rsst.getString("endcode");
					}
		

		String sql1="insert into t_briefing (DriverName,Driverid,VehRegNo,tripid,brifstatus,Debrifstatus,startplace,endplace,mode,probenddate,Transporter,TrainerName,brifdate,MobNo,Status,VehType,CleanerId,CleanerName,ApproveBy,ApproveByMailID,startcode,endcode)values('"+drivername+"','"+driverid+"','"+vehicleRegNumber+"','"+tripid+"','briefed','not debriefed','"+startplace+"','"+endplace1+"','"+mode+"','"+pdate+"','"+transporter+"','"+userid+"','"+brfdate+"','"+MobNo1+"','open','"+vehT+"','"+CleanerId+"','"+CleanerName+"','"+ApproveBy+"','"+ApproveByMailID+"','"+scode+"','"+ecode+"')";
		/*Query to insert query in db_gps.t_sqlquery table*/
		System.out.println("ccccccccccccccccccccccccccccccccccc=====44" +sql1);
		String abcd1=sql1.replace("'","#");
		abcd1=abcd1.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
		int ins=0;	/*****************************/
		ins=stmt1.executeUpdate(sql1);
		System.out.println("ccccccccccccccccccccccccccccccccccc=====44" +fdname);
		String sql5="insert into db_gps.t_BrifTimeStamp (BrifId,RegisterOn)values('"+brfdate+"')";


		
		try{		
			// For gettinng report no and name
			int ReportNo=362;
			String sqlreportno = "Select * from db_gps.t_reportnumber where ReportNo='"+ReportNo+"'  " ;
			System.out.println("sqlreportno  "+sqlreportno);
			ResultSet rsReportNo = stReportNo.executeQuery(sqlreportno);
			if(rsReportNo.next())
			{
				displayedReportNo=rsReportNo.getInt("ReportNo");
				ReportName=rsReportNo.getString("ReportName");
			}
			heading=ReportName+" "+displayedReportNo;
			}catch(Exception e)
			{
				System.out.println("Exception while getting report details "+e.getMessage());
			}
	
	
			
	if(NonCVeh.equals("Yes"))
	{	
		System.out.println("email "+ApproveByMailID+","+userid);	
		
		//String To=ApproveByMailID+","+userid;
		String To="a_dhage@transworld-compressor.com";
		String Cc="a_dhage@transworld-compressor.com";
		String Customer=transporter;
		
			
		String html1 = "</br><html><body><font face=Arial><table border=^1^>"+
		"<tr><td valign = ^top^><font size = ^2^>Briefing Date</font></td> <td valign = ^top^ colspan=^4^><font size = ^2^>"+brfdate2+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^>Driver Id </font></td><td valign = ^top^><font size = ^2^> "+driverid+"</font><td></td></td><td valign = ^top^><font size = ^2^> Origin </font></td><td valign = ^top^><font size = ^2^>"+startplace+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^>  Driver Name </font></td><td valign = ^top^><font size = ^2^>"+drivername+"</font></td><td></td><td valign = ^top^><font size = ^2^> Destination </font></td><td valign = ^top^><font size = ^2^> "+endplace1+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Trip Id </font></td><td align = ^right^><font size = ^2^>"+tripid+"</font></td  valign = ^top^><td></td><td valign = ^top^><font size = ^2^> Approve By </font></td><td valign = ^top^><font size = ^2^> "+ApproveBy+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Vehicle Reg. No </font></td><td valign = ^top^><font size = ^2^>"+vehicleRegNumber+"</font></td><td></td><td valign = ^top^><font size = ^2^> Cleaner Passport ID </font></td><td valign = ^top^><font size = ^2^>"+CleanerId+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Transporter  </font></td><td valign = ^top^><font size = ^2^>"+transporter+"</td><td></td><td valign = ^top^><font size = ^2^> Cleaner Name </font></td><td>"+CleanerName+"</td></tr></table>"+
		"</html>";

	/*	
		String html1 = "<html><body><font face=Arial><table>"+
		"<tr><td valign = ^top^><font size = ^2^>Briefing Date</font></td><tdvalign = ^top^><font size = ^2^>"+brfdate+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^>Driver Id </font></td><tdvalign = ^top^><font size = ^2^> "+driverid+"</font></td><td> Origin </td> <td valign = ^top^><font size = ^2^>"+startplace+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Driver Name </font></td><td valign = ^top^><font size = ^2^>"+drivername+"</font></td><td valign = ^top^><font size = ^2^> Destination </font></td><td valign = ^top^><font size = ^2^> "+endplace1+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Transporter </font></td><td valign = ^top^><font size = ^2^>"+transporter+"</font></td><td> Approve By </td><td valign = ^top^><font size = ^2^> "+ApproveBy+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Trip Id </font></td><td valign = ^top^><font size = ^2^>"+tripid+"</font></td><td valign = ^top^><font size = ^2^> Cleaner Passport ID </font></td><td valign = ^top^><font size = ^2^>"+CleanerId+"</font></td></tr>"+
		"<tr><td valign = ^top^><font size = ^2^> Vehicle Reg. No  </font></td><td valign = ^top^><font size = ^2^>"+vehicleRegNumber+"</td><td> Cleaner Name </td><td>"+CleanerName+"</td></tr></table>"+
		"</html>";
	*/	
		String str=html1;	
		
		//EmailTemplate template1=new EmailTemplate();
		flag=sendmail(str,To, Cc,Customer,heading, "","",displayedReportNo,ReportName,"","");
		if(flag==true)
		{
			System.out.println("Mail Send successful");
		}
		else
		{	                           
			System.out.println("Mail Send unsuccessful");
		}
		
	}

	if(ins>=1){
		
		
		String sql3 = "insert into db_gps.t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,status) values ('"+driverid+"','Driver Rejection','No')";
		System.out.println(sql3);
		int i=0;
		i=stmt4.executeUpdate(sql3);
		if(i>=1)
		{
			System.out.println("Pass1");	
			}else
			{
			System.out.println("Pass2");
			}
		
			
		String sql6 = "insert into db_gps.t_reasonOfRejectionForDriver (DriverId,VehRegNo,ReasoneForRejection,status) values (0,'"+veh+"','Vehicle Rejection','No')";
		System.out.println(sql6);
		int i2=0;
		i2=stmt5.executeUpdate(sql6);
		if(i2>=1)
		{
			System.out.println("Pass1");
		}else
			{
			System.out.println("Pass2");

			}
		
		
		
		
		
		
		
		String sql2="select Briefid as fdname from t_briefing where driverid='"+driverid+"' and TrainerName='"+userid+"' order by brifdate desc limit 1 ";
//		System.out.println(sql2);



		ResultSet rs2=stmt1.executeQuery(sql2);
		System.out.println("ccccccccccccccccccccccccccccccccccc=====555" +sql2);
		if(rs2.next()){
			fdname=rs2.getInt("fdname");
			System.out.println("ccccccccccccccccccccccccccccccccccc=====555==" +fdname);
			
			String startcode="", endcode="";
			 String sql8="select startCode,endcode from db_gps.t_castrolroutes where StartPlace='"+startplace+"' and EndPlace='"+endplace1+"'" ;
			ResultSet rs8=st.executeQuery(sql8);
			System.out.println("sql 8"+sql8);
			while(rs8.next())
			{
				startcode=rs8.getString("StartCode");
				endcode=rs8.getString("EndCode");
			
			}
			System.out.println("Start Code "+startcode);
			
			
	/* String sql9="select EndCode from db_gps.t_castrolroutes where EndPlace='"+endplace1+"'";
				ResultSet rs9=st.executeQuery(sql9);
				System.out.println("sql 9"+sql9);
				while(rs9.next())
				{
					endcode=rs9.getString("EndCode");
				}*/
				System.out.println("End Code "+endcode);
			
			
			response.sendRedirect("briefing_page.jsp?inserted=successfull&driverid="+driverid+"&drivername="+drivername+"&TripId="+tripid+"&BrifDate="+brfdate+"&transporter="+transporter+"&briefId="+fdname+"&startP="+startplace+"&endP11="+endplace1+"&startcode="+startcode+"&endcode="+endcode+"&mobno="+MobNo+"&VehType="+vehT+"&CleanerId="+CleanerId+"&CleanerName="+CleanerName+"");
			
			
		}
	}
		else{
		
		}
	
	String sql7="insert into db_gps.t_briftimestamp (BrifId,RegisterOn)values('"+fdname+"','"+brfdate+"')";
System.out.println(">>>>>>>>55555"+sql7);
	st1.executeUpdate(sql7);
	System.out.println(">>>>>>>>6666666"+sql7);

	
	
	
	
	}

		
	}
catch(Exception e)
{
	response.sendRedirect("alert.jsp?fromPage=Brief");
	e.printStackTrace();
}
try{
	
}
catch(Exception e)
{
	out.println("Exception----->" +e);	
}
finally
{
	con1.close();
}

	
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
stReportNo2=con1.createStatement();
ResultSet rst=null;
String sql="";
//boolean flag=false;
int element=99;

String DriveId=request.getParameter("DriveId");
String DriverName=request.getParameter("DName");
//String transporter=request.getParameter("trans");
System.out.println("ttttttttttttt>>>>>>>>>>>>"+transporter);
//String debriefid=request.getParameter("debriefid");

String EmailId=request.getParameter("EmailId");

//String veh = request.getParameter("VehRegNo");
//StringTokenizer stk = new StringTokenizer(veh,",");
//String vehicleRegNumber=stk.nextToken();
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

out.print(" reasonDr "+reasonDr+" reasonVh "+reasonVh);

//"resources"
String resources=request.getParameter("resources");
String resources2=request.getParameter("resources2");

out.print(" resources "+resources+" resources2 "+resources2);

reasonDr=resources;
reasonVh=resources2;

String buffer;
if(DriRej=="Yes"|| DriRej.equals("Yes"))
{

String sql1="insert into db_gps.t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,CommentForRejection,status,transporter,DriverName,RejectedBy) values ('"+DriveId+"','Driver Rejection','"+reasonDr+"','"+DriRej+"','"+transporter+"','"+DriverName+"','"+RejectedBy+"') ";
System.out.println("$$$$$$"+sql1);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql1);
if(ins>=1){
		buffer="Updated";
		System.out.println("Updates : "+sql1);
		//out.print(buffer);
fg=1;
//buffer=null;
}



html1= " <br><table width = ^100%^ align = ^left^ border=^0^>" + 
"<tr><td  valign = ^top^><font size = ^2^>Trainer :</font></td><td valign = ^top^ ><font size = ^2^>" + RejectedBy + "</font></td></tr>" + 
"<tr><td  valign = ^top^><font size = ^2^>Driver ID :</font></td><td valign = ^top^ ><font size = ^2^>" + driverid + "</font></td></tr>" + 
"<tr><td  valign = ^top^><font size = ^2^>Driver Name  : </font></td><td valign = ^top^ ><font size = ^2^>" + drivername+ "</font></td></tr></tr>" + 
"<tr><td  valign = ^top^><font size = ^2^>Tansporter :</font></td><td valign = ^top^ ><font size = ^2^>" + transporter + "</font></td></tr></font></td></tr></tr>" + 
"<tr><td  valign = ^top^><font size = ^2^>FTPR Reject Reason :</font></td><td valign = ^top^ ><font size = ^2^> Driver Rejection </font></td></tr></font></td></tr></tr>" + 
"<tr><td  valign = ^top^><font size = ^2^>Rejected By :</font></td><td valign = ^top^ ><font size = ^2^>" + RejectedBy + "</font></td></tr>" + 
"</table></font><br><br></table>";


		String str=html1;
		System.out.println(" msg 1 "+str);
		subject = "Driver Reject For Trip ";
	
		toid= EmailId;
		tocc = "fleetviewReports@mobile-eye.in";

		
		try{		
			// For gettinng report no and name
			int ReportNo=412;
			String sqlreportno = "Select * from db_gps.t_reportnumber where ReportNo='"+ReportNo+"'  " ;
			System.out.println("sqlreportno  "+sqlreportno);
			ResultSet rsReportNo = stReportNo2.executeQuery(sqlreportno);
			if(rsReportNo.next())
			{
				displayedReportNo=rsReportNo.getInt("ReportNo");
				ReportName=rsReportNo.getString("ReportName");
			}
			heading=ReportName+" "+displayedReportNo;
			}catch(Exception e)
			{
				System.out.println("Exception while getting report details "+e.getMessage());
			}
		
		
		flag=sendmail(str,toid, tocc,transporter,heading,"","",displayedReportNo,ReportName,"","");
		if(flag==true)
		{
			System.out.println("Mail Send successful");
		}
		else
		{	                           
			System.out.println("Mail Send unsuccessful");
		}		

/*

html1 = "<html><body>Dear Sir/Mam, <br><br>Trainer "+RejectedBy+" Reject To This Driver For Trip<br>Driver ID:- "+DriveId
+" <br>Driver Name:- "+DriverName+" <br>Tansporter:- "+transporter+" <br>Reject Reason :- "+reasonDr+"<br>Rejected By:- "+RejectedBy+"<br><br>If any further assistance require,please contact below"+
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
*/			




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
	
	
	html1= " <br><table width = ^100%^ align = ^left^ border=^0^>" + 
	  "<tr><td  valign = ^top^><font size = ^2^>Trainer :</font></td><td valign = ^top^ ><font size = ^2^>" + RejectedBy + "</font></td></tr>" + 
	  "<tr><td  valign = ^top^><font size = ^2^>Vehicle No :</font></td><td valign = ^top^ ><font size = ^2^>" + vehicleRegNumber + "</font></td></tr>" + 
	  "<tr><td  valign = ^top^><font size = ^2^>Tansporter :</font></td><td valign = ^top^ ><font size = ^2^>" + transporter + "</font></td></tr></font></td></tr></tr>" + 
	  "<tr><td  valign = ^top^><font size = ^2^>FTPR Reject Reason :</font></td><td valign = ^top^ ><font size = ^2^> Vehicle Rejection </font></td></tr></font></td></tr></tr>" + 
	  "<tr><td  valign = ^top^><font size = ^2^>Rejected By :</font></td><td valign = ^top^ ><font size = ^2^>" + RejectedBy + "</font></td></tr>" + 
	  "</table></font><br><br></table>";


			String str=html1;
			System.out.println(" msg 2 "+str);
		
			toid= EmailId;
			tocc = "fleetviewReports@mobile-eye.in";
	
			
			try{		
				// For gettinng report no and name
				int ReportNo=417;
				String sqlreportno = "Select * from db_gps.t_reportnumber where ReportNo='"+ReportNo+"'  " ;
				System.out.println("sqlreportno  "+sqlreportno);
				ResultSet rsReportNo = stReportNo2.executeQuery(sqlreportno);
				if(rsReportNo.next())
				{
					displayedReportNo=rsReportNo.getInt("ReportNo");
					ReportName=rsReportNo.getString("ReportName");
				}
				heading=ReportName+" "+displayedReportNo;
				}catch(Exception e)
				{
					System.out.println("Exception while getting report details "+e.getMessage());
				}
			
			
			flag=sendmail(str,toid, tocc,transporter,heading,"","",displayedReportNo,ReportName,"","");
			if(flag==true)
			{
				System.out.println("Mail Send successful");
			}
			else
			{	                           
				System.out.println("Mail Send unsuccessful");
			}
	
	
/*
	html1 = "<html><body>Dear Sir/Mam, <br><br>Trainer "+RejectedBy+" Reject To This Vehicle For Trip<br>Vehicle No:- "+vehicleRegNumber
	+" <br>Transporter:- "+transporter+" <br>Reject Reason :- "+reasonVh+"<br>Rejected By:- "+RejectedBy+"<br><br>If any further assistance require,please contact below"+
	"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</body></html>";

			subject = "Vehicle Reject For Trip ";

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
*/				

	
}

if(fg==1)
{
	buffer="Updated";
	System.out.println("Resu;ltttt");
	
	
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

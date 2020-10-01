<%@ include file="Connections/conn.jsp" %>
<%@page import="java.util.Date"	%>
<%!
	Connection con1;
%>

<%! 

static Statement  stmail;
static Statement  stEmailDetails;
static Connection conn1=null;



String ReportName="";
int displayedReportNo=0;
String heading="";
	
	
	
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
try{
		java.util.Date tdydte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String debrfdate=formatter.format(tdydte);
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		Statement stmt2=con1.createStatement();   
		Statement stmt3=con1.createStatement();
		Statement stmt311=con1.createStatement();  
		Statement stmt4=con1.createStatement();   
		Statement stmt5=con1.createStatement();   
		Statement stquery=con1.createStatement();
		
		Statement st41=con1.createStatement();
		Statement st411=con1.createStatement();
		
		Statement st=con1.createStatement();
		Statement st1=con1.createStatement();
		Statement stReportNo2=con1.createStatement();
		
		String CleanerName=request.getParameter("CleanerName");
		String CleanerId=request.getParameter("CleanerId");
		
		String startplace=request.getParameter("startplace");
		String  endplace=request.getParameter("endplace");
		
		String reason1=request.getParameter("dest1");
		
		String reason2=request.getParameter("dest2");
		
		String Dreason=reason1;
		String Vreason=reason2;
		
		System.out.print(" Reason1 "+reason1+" Reason2 "+reason2);
		String DriRej=request.getParameter("ChkAdh");
		String VehRej=request.getParameter("ChkAdhJ");
		
		String userid=session.getAttribute("user").toString();
		String veh = request.getParameter("VehRegNo");
		String DrvStatus="",VehStatus="";		
		String transporter=request.getParameter("transporter");		
		String tripid=request.getParameter("TripIdN");
		System.out.println(">>>>"+tripid);
		String driverid=request.getParameter("DriverId");
		String drivername=request.getParameter("DriverName"); 
		String mode=request.getParameter("mode");
		String pdate=request.getParameter("data");
		
		
		System.out.println(DriRej+" ` "+VehRej);

		

		
		String resources=request.getParameter("resources");
		String resources2=request.getParameter("resources2");
		
		String reasonDr=resources;
		String reasonVh=resources2;
		String buffer;
		
		 boolean flag=false;
		 
		 String Email=session.getAttribute("email").toString();
		 String RejectedBy=session.getAttribute("mainuser").toString();
		 
		 String subject = "",html1 = "",toid ="",tocc ="",entrydatetime ="",mailstatus = "Pending";
		 String EmailId=request.getParameter("EmailId");
		 int fg=0;
	//	String Briefid=request.getParameter("Briefid");
		//System.out.println("@@#@#!@#"+Briefid);
	
		
		
     int fdname=0;

	
	System.out.println(driverid+ "ccccccccccccccccccccccccccccccccccc=====" +fdname);
	
		
	
	
	try{
		
		
		
		/*
		String sql41 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver where DriverId ='"+driverid+"' and ReasoneForRejection='"+Dreason+"' order by UpdatedDateTime DESC limit 1";
		ResultSet rs41 = st41.executeQuery(sql41);
		System.out.println("5555555555555555555555577777777"+sql41);
		if(rs41.next())
		{
		if(rs41.getString("status").equalsIgnoreCase("Yes"))
			{
			DrvStatus="Rejected";
			response.sendRedirect("driver_debrifing_Reg_alert.jsp?veh=-&driverid="+driverid);
			}
		else if(rs41.getString("status").equalsIgnoreCase("No"))
			{
			DrvStatus="Pass";
			
			

			
			}
		}
		*/
		
		
		if(DriRej=="Yes"|| DriRej.equals("Yes"))
		{

		String sqlreason="insert into db_gps.t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,CommentForRejection,status,transporter,DriverName,RejectedBy) values ('"+driverid+"','"+Dreason+"','"+reasonDr+"','"+DriRej+"','"+transporter+"','"+drivername+"','"+RejectedBy+"') ";
		System.out.println("$$$$$$"+sqlreason);
		int ins1=0;	/*****************************/
		ins1=st.executeUpdate(sqlreason);
		if(ins1>=1){
				buffer="Updated";
				System.out.println("Updates : "+sqlreason);
				//out.print(buffer);
		fg=1;
		//buffer=null;
		}



		html1= " <br><table width = ^100%^ align = ^left^ border=^0^>" + 
		"<tr><td  valign = ^top^><font size = ^2^>Trainer :</font></td><td valign = ^top^ ><font size = ^2^>" + RejectedBy + "</font></td></tr>" + 
		"<tr><td  valign = ^top^><font size = ^2^>Driver ID :</font></td><td valign = ^top^ ><font size = ^2^>" + driverid + "</font></td></tr>" + 
		"<tr><td  valign = ^top^><font size = ^2^>Driver Name  : </font></td><td valign = ^top^ ><font size = ^2^>" + drivername+ "</font></td></tr></tr>" + 
		"<tr><td  valign = ^top^><font size = ^2^>Tansporter :</font></td><td valign = ^top^ ><font size = ^2^>" + transporter + "</font></td></tr></font></td></tr></tr>" + 
		"<tr><td  valign = ^top^><font size = ^2^>FTPR Reject Reason :</font></td><td valign = ^top^ ><font size = ^2^>" + Dreason + "</font></td></tr></font></td></tr></tr>" + 
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
			String sql2="insert into db_gps.t_reasonOfRejectionForDriver (DriverId,VehRegNo,ReasoneForRejection,CommentForRejection,status,transporter,DriverName,RejectedBy) values (0,'"+veh+"','"+Vreason+"','"+reasonVh+"','"+VehRej+"','"+transporter+"','"+drivername+"','"+RejectedBy+"')";
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
			  "<tr><td  valign = ^top^><font size = ^2^>Vehicle No :</font></td><td valign = ^top^ ><font size = ^2^>" + veh + "</font></td></tr>" + 
			  "<tr><td  valign = ^top^><font size = ^2^>Tansporter :</font></td><td valign = ^top^ ><font size = ^2^>" + transporter + "</font></td></tr></font></td></tr></tr>" + 
			  "<tr><td  valign = ^top^><font size = ^2^>FTPR Reject Reason :</font></td><td valign = ^top^ ><font size = ^2^>" + Vreason + "</font></td></tr></font></td></tr></tr>" + 
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
		

/*
		String sql411 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver where VehRegNo='"+veh+"' and ReasoneForRejection='"+Vreason+"' order by UpdatedDateTime DESC limit 1";
		System.out.println("rejection query "+sql411);
		ResultSet rs411 = st411.executeQuery(sql411);
		//System.out.println("5555555555555555555555577777777"+sql411);
		if(rs411.next())
		{
		if(rs411.getString("status").equalsIgnoreCase("Yes"))
			{
			
			VehStatus="Rejected";
			System.out.println("VehStatus "+VehStatus);
			
			response.sendRedirect("driver_debrifing_Reg_alert.jsp?veh="+veh+"&driverid=-");
			}
		else if(rs411.getString("status").equalsIgnoreCase("No"))
			{
			VehStatus="Pass";
			}
		
		
		}
*/	
		
		
		if(VehStatus.equalsIgnoreCase("Rejected")||DrvStatus.equalsIgnoreCase("Rejected"))
		{			
		
		}else{
			
			String Briefid="";
			String sql11="update t_briefing set debrifingstatus='Open' where driverid='"+driverid+"' and tripid ='"+tripid+"'";
			System.out.println("555551111111111111111111"+sql11);
			int ins11=0;	
			ins11=stmt2.executeUpdate(sql11);
			System.out.println(ins11+" no.of records are updated");
			String sql211="select Briefid from t_briefing where driverid='"+driverid+"' and tripid ='"+tripid+"'"; 
			System.out.println(" sql211 " +sql211);
			ResultSet rs211=stmt311.executeQuery(sql211);
			System.out.println("sql211"+sql211);
			if(rs211.next())
			{
				Briefid=rs211.getString("Briefid");				
			}
			System.out.println("ccccccccccccccccccccccccccccccccccc=====552==" +sql11);
			if(ins11>=1){
			int ins=0;
		
			String sql1="insert into t_debriefing (DriverName,Driverid,tripid,Transporter,TrainerName,Status,Briefid,Debriefdate,CleanerId,CleanerName)values('"+drivername+"','"+driverid+"','"+tripid+"','"+transporter+"','"+userid+"','Open','"+Briefid+"','"+debrfdate+"','"+CleanerId+"','"+CleanerName+"')";
			/*****************************/
		ins=stmt1.executeUpdate(sql1);
		System.out.println("ccccccccccccccccccccccccccccccccccc=====44 ins" +ins);
		
		
		if(ins>=1){
/*			
		String sql3 = "insert into db_gps.t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,status) values ('"+driverid+"','"+Dreason+"','No')";
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
		
				
		String sql5 = "insert into db_gps.t_reasonOfRejectionForDriver (DriverId,VehRegNo,ReasoneForRejection,status) values (0,'"+veh+"','"+Vreason+"','No')";
		System.out.println(sql5);
		int i2=0;
		i2=stmt5.executeUpdate(sql5);
		if(i2>=1)
		{
			System.out.println("Pass1");
		}else
			{
			System.out.println("Pass2");

			}
*/		
	//String sql2="select deBriefid as fdname from t_debriefing where driverid='"+driverid+"' and TrainerName='"+userid+"' order by brifdate desc limit 1 ";
			
	
		String sql2="select deBriefid as fdname from t_debriefing where driverid='"+driverid+"' and TrainerName='"+userid+"' order by Debriefdate desc limit 1"; 

		//System.out.println("222222"+sql2);



		ResultSet rs2=stmt3.executeQuery(sql2);
	//	System.out.println("ccccccccccccccccccccccccccccccccccc=====551" +tripid);
		if(rs2.next()){
			fdname=rs2.getInt("fdname");
		
			response.sendRedirect("driver_debriefing_Update.jsp?inserted=successfull&driverid="+driverid+"&drivername="+drivername+"&TripId="+tripid+"&Debriefdate="+debrfdate+"&transporter="+transporter+"&debriefid="+fdname+"&veh="+veh+"&PDate="+pdate+"");
			//System.out.println("ccccccccccccccccccccccccccccccccccc=====552==" +fdname);
			
			
		}
			
			
			
				
			
			
			
		}
	}
		else{
			
			response.sendRedirect("driver_debrifing_Reg2_alert.jsp?tripid="+tripid+"&DriverId="+driverid+"");
			
		
		}
	}//else
	}//try
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

	
}
catch(Exception e)
{
	out.println("Exception----->" +e);	
}
finally
{
	con1.close();
}
%>
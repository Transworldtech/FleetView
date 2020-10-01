<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.fleetview.beans.EmailTemplate" %>
<%@ include file="Connections/conn.jsp" %>
<%! 
Connection con1, con2;
%>
<html>
<body>
<%
try
{ 
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	Statement stmt=con2.createStatement(),stmt1=con2.createStatement(), stmt2=con2.createStatement(),stmtinsert=con2.createStatement();
	Statement stmt3 = con2.createStatement();
	Statement strepre,stadmin;
	strepre=con2.createStatement();
    stadmin=con2.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null;
	String sql="", sql1="", sql2="", sql3="";
	String tm="";
	int vcode=0;
	int vcode1;
   int i=0;
   int maxid = 0;
   byte decision, numValue;
   char charValue;
   Random rgen = new Random();
   String password = "",vehicleaddedlist = "";
	 java.util.Date td =new java.util.Date();
	 
	 String reportno=request.getParameter("reportno");
	 String reportname=request.getParameter("reportname1");
	 String heading=reportname+" "+reportno;
	String ownername = session.getAttribute("usertypevalue").toString();
	String user = session.getAttribute("mainuser").toString();
	String username = session.getAttribute("fname").toString()+" "+session.getAttribute("lname").toString();
	System.out.println("****   "+user);
	System.out.println("******  "+username);
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	String sdt = fmt.format(td);
	String usrname = request.getParameter("usrname");
	usrname = usrname.trim();
	System.out.println("******  "+usrname);
	String fname = request.getParameter("fname");
	fname = fname.trim();
	String lname = request.getParameter("lname");
	lname = lname.trim();
	String phno = request.getParameter("phno");
	String loc = request.getParameter("loc");
	String desg = request.getParameter("desg");
	String allocdate = request.getParameter("allocdate");
	String expdate = request.getParameter("expdate");
	String[] vehicles = request.getParameterValues("assigned1");
	String typeofuser = request.getParameter("trk");
	 
	String UserType = request.getParameter("UserType");
	if(UserType.equalsIgnoreCase("IAL"))
	{
		typeofuser = "EndUser";
	}
	
	System.out.println("*******    "+typeofuser);
	String Msg = "";
	String vehid = "";
	String alloc1 = "",exp1 = "";
	alloc1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(allocdate));
	exp1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(expdate));
	
	sql ="select * from db_gps.t_security where username = '"+usrname+"' and ActiveStatus <> 'No' ";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next())
	{
		response.sendRedirect("AlertGoTo.jsp?msg=Username already exist!!&goto=createnewuser.jsp");
	}
	else
	{
		sql1 = "select * from db_gps.t_userdetails where firstname = '"+fname+"' and lastname = '"+lname+"' ";
		rs1 = stmt1.executeQuery(sql1);
		if(rs.next())
		{
			response.sendRedirect("AlertGoTo.jsp?msg=FirstName and LastName already exist!!&goto=createnewuser.jsp");
		}
		else
		{
			StringBuilder sb = new StringBuilder();
			while(sb.length() < 9)
			{
				decision = (byte)rgen.nextInt(2);				numValue = (byte)rgen.nextInt(10);
				charValue = (char)(rgen.nextInt(25) + 65);
				sb.append( (decision%2 == 0) ? ( charValue + "" ) : ( numValue + "") );
			}
			//System.out.println("********   "+sb.toString());
			password = sb.toString();
	
			System.out.println("PASSWORD===>"+password);
			sql2 = "select max(userid) as maxid from db_gps.t_security ";
			
			rs2 = stmt2.executeQuery(sql2);
			//System.out.println("********   "+sql2);
			
			if(rs2.next())
			{
				maxid = rs2.getInt("maxid");
			}
			maxid = maxid + 1;
			System.out.println("********maxid   "+maxid);
			
			sql2 = "insert into db_gps.t_security (UserId,UserName,FullName,Password,TypeofUser,TypeValue,CreationDate,ExpiryDate) "+
						" value ('"+maxid+"','"+usrname+"','"+fname+" "+lname+"','"+password+"','"+typeofuser+"','"
						+fname+" "+lname+"','"+alloc1+"','"+exp1+"')";
			stmt2.executeUpdate(sql2);
			//System.out.println("********   "+sql2);
			/*String abcd444=sql2.replace("'","#");	
	 		 abcd444=abcd444.replace(",","$");								
	 		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			*/
	 		 sql2 = "insert into db_gps.t_userdetails (UserName,Transporter,Usertype,FirstName,LastName,MobNo,Email,Designation,Location) "
	 		          +"values ('"+usrname+"','"+ownername+"','"+typeofuser+"','"+fname+"','"+lname+"','"+phno+"','"+usrname+"','"+desg+"','"+loc+"')";
            stmt2.executeUpdate(sql2);
            System.out.println("********   "+sql2);
		/*	abcd444=sql2.replace("'","#");	
	 		 abcd444=abcd444.replace(",","$");								
	 	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	 		*///System.out.println("8888888888    "+vehicles.length);
	 		for(i = 0;i<vehicles.length;i++)
	 		{
	 			sql2 = "select * from db_gps.t_vehicledetails where VehicleRegNumber = '"+vehicles[i].trim()+"' ";
	 			rs2 = stmt2.executeQuery(sql2);
	 			//System.out.println("****   "+sql2);
	 			if(rs2.next())
	 			{
	 				if(vehicleaddedlist == "" || vehicleaddedlist.equals(""))
	 				{
	 					vehicleaddedlist = vehicles[i].trim();
	 				}
	 				else
	 				{
	 					vehicleaddedlist = vehicleaddedlist+","+vehicles[i].trim();
	 				}
	 				vehid = rs2.getString("vehiclecode");
	 				
	 				sql3 = "insert into db_gps.t_group (GPName,VehRegNo,transporter,Vehcode,SepReport,Active,EntryBy) "
	 						 +" value ('"+fname+" "+lname+"','"+rs2.getString("OwnerName")+"','"+vehicles[i].trim()+"','"+vehid+"','Yes','Yes','"+user+"')";
	 				System.out.println("****   "+sql3);
	 				stmt3.executeUpdate(sql3);
	 				/*
	 				abcd444=sql3.replace("'","#");	
	 		 		 abcd444=abcd444.replace(",","$");								
	 		 		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	 		 			*/
	 			}
	 			
	 		}
	 		
	 		if(UserType.equalsIgnoreCase("IAL"))
	 		{
	 			System.out.println("-------------------------------------------------------------------------------------------------------------------------------------");
		 		String subject = "",html1 = "",toid ="",tocc ="",entrydatetime ="",mailstatus = "Pending";
		 		
		 		subject = "FleetView UserId created ";
		 		html1 = "<html><tr align=left><font size=2><br><body><br> User ID created successfully. Please See Details Below, <br><br>UserName:- "+usrname
				   +"<br>Password:- "+password+" <br>Allocation Date:- "+allocdate+"<br>Expiry Date:- "+expdate+" <br><br>If any further assistance require,Please contact below"+
				   "</font></body></html>";
				
				   //String reportno1="";
				   
		 		toid =user;//mainuser
		 		tocc = "fleetviewReports@mobile-eye.in";
		 		//tocc = "s_amol@transworld-compressor.com";
		 		String reportno1="<font size=2 >24</font>";
				 String reportname1= "<font size=2>Create New User</size>";	
				 String heading1=reportname1+": "+reportno;
		 		entrydatetime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		 		
		 		//sql2 = "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,EntryDateTime,MailStatus,SenderName) "
		 					//+" values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+entrydatetime+"','"+mailstatus+"','"+user+"')";
		 		//stmt2.executeUpdate(sql2);
		 		
		 		
				//System.out.println("IN IF=---->"+sql2);
				
		 					//String toid="w_tamboli@transworld-compressor.com";
		 				     //String ccid="s_amol@transworld-compressor.com";
		 				      //String html1=htmlString.toString();
		 				      //html1=html1.replaceAll("'"," ");
		 				      //String subject="Dot Project Pending Work Status Alert";
		 				      //String html="<tr align=left>Following is the Status Report for Dot Project</tr><br><br>"+html1;
		 				      
		 				      String data1=html1.toString();
		 				      data1=data1.replaceAll("'"," ");
		 				      EmailTemplate template = new EmailTemplate();
		 				     //sendmail(String str, String toID, String ccID, String Customer,String heading,  String date1, String date2, String displayedReportNo, String ReportName,  String FileName,String AttachFilePath)
		 				      boolean flag = template.sendmail(html1, toid, tocc,"", heading1,"", "", "", subject, "", ""); 
	 		
	 			
	 			
	 			
	 		}
	 		else
	 		{
	 		
	 			System.out.println("<----------------------------IN ELSE------------------------->");
	 		
	 		String subject = "",html1 = "",toid ="",tocc ="",entrydatetime ="",mailstatus = "Pending";
	 		
	 		subject = "User Name and Password for FleetView ";
	 		html1 = "<html><tr align=left><font size=2><br><body><br>Welcome to FleetView. You can login to your account using following details,<br><br>User Name:- "+usrname
	 				   +" <br>Password:- "+password+" <br><br>Note:- Please change your password after first login.<br><br>If any further assistance require,Please contact below"+
	 				   " </font></body></html>";
	 		
	 	 	toid =usrname;//UserName/Email Id
	 		tocc =" ";
	 		 String reportno1="<font size=2 >24</font>";
			 String reportname1= "<font size=2>Create New User</size>";	
			 String heading1=reportname1+": "+reportno1;
		 	entrydatetime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			System.out.println("HTML1111"+html1);		
	 		
	 		/* sql2 = "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) "
	 					+" values (.'Transworld','"+html1+"','"+subject+"','"+toid+"','"+tocc+"','"+entrydatetime+"','"+mailstatus+"','"+user+"')";
	 		stmt2.executeUpdate(sql2);
	 		System.out.println("****   "+sql2); */
	 		
	 		String data1=html1.toString();
		      data1=data1.replaceAll("'"," ");
		      EmailTemplate template = new EmailTemplate();
		      boolean flag = template.sendmail(html1, toid, tocc,"", heading1," ", "", "", subject, "", ""); 
	 	/*	abcd444=sql2.replace("'","#");	
	 		 abcd444=abcd444.replace(",","$");					*/			
	 	//	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	 		
	 		subject = "FleetView UserId Created ";
	 		html1 = "<html><tr align=left><font size=2><br><body>Dear "+username+" <br><br> User ID created successfully. Please See Details Below, <br><br>UserName:- "+usrname
	 				   +"<br>Allocation Date:- "+allocdate+"<br>Expiry Date:- "+expdate+" <br></font></body></html>";
	 				   
	 		toid= user;//mainuser
	 		tocc = "fleetviewReports@mobile-eye.in";
	 		//tocc = "s_amol@transworld-compressor.com";
	 		String reportno11="<font size=2 >24</font>";
			 String reportname11= "<font size=2>Create New User</size>";	
			 String heading11=reportname11+": "+reportno11;
	 		entrydatetime = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	 		
	 		/* sql3 = "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) "
	 					+" values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+tocc+"','"+entrydatetime+"','"+mailstatus+"','"+user+"')";
	 		stmt2.executeUpdate(sql3);
	 		System.out.println("****   "+sql3); */
	 		String data2=html1.toString();
		      data2=data2.replaceAll("'"," ");
		      EmailTemplate template1 = new EmailTemplate();
		      boolean flag1 = template.sendmail(html1, toid, tocc,"",heading11,"", "", "",subject, "", ""); 
	 		/*abcd444=sql2.replace("'","#");	
	 		 abcd444=abcd444.replace(",","$");								
	 		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");*/
	 		}		
	 		response.sendRedirect("AlertGoTo.jsp?msg=User created Successfully&goto=createnewuser.jsp");
	}
	}
	
	//RequestDispatcher rd=request.getRequestDispatcher("createnewuser.jsp");
	
	//request.setAttribute("Msg", Msg);
	//rd.forward(request, response);
	//Msg="";
	
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	con1.close();
	con2.close();
	 
}
	%>
	</body>
	</html>
	
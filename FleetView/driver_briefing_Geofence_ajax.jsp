<%@ include file="Connections/conn.jsp" %>
<%
	Connection con1=null;
	try
	{
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement st=con1.createStatement();
		Statement st1=con1.createStatement();
		Statement stmtinsert=con1.createStatement();
		ResultSet rst=null;

		String DriveId=request.getParameter("driverid");
		String EmailId=request.getParameter("email");
		String StPlc=request.getParameter("start");
		String EdPlc=request.getParameter("end");
		String message = request.getParameter("message");
		String TripId = request.getParameter("tripid");
		String driverName = request.getParameter("drivername");
		String VehRegNo = request.getParameter("RegNo");
		
		final String userTypeValue = session.getAttribute("usertypevalue").toString();
		final String typeOfUser = session.getAttribute("TypeofUser").toString();
		String Trainer=session.getAttribute("mainuser").toString();

		String subject = "",html1 = "",toid ="",tocc ="",entrydatetime ="",mailstatus = "Pending";
		//String debriefid=request.getParameter("debriefid");
		String DBtocc="";
		String sql5="SELECT * FROM db_gps.t_briefingmail where transporter='"+userTypeValue+"'";
		ResultSet rs5=st.executeQuery(sql5); 
		if(rs5.next())
		{
			DBtocc=rs5.getString("tocc");
		}
		 sql5 ="";

		String buffer="";
		subject= "The Destination "+EdPlc+" is not Geofence ";
			html1 = "<html><body>Dear Sir/Madam,<br><br> Warm Greetings!!! <br><br>DMC Person : "+Trainer+"<br><br>  The Destination location <b>"+EdPlc+"</b> entered is not Geofence.<br> Details are as below : <br><br>"
						+"<br>Driver ID:- "+DriveId+"<br> Driver Name :- "+driverName+"<br>Vehicle Reg. No. :- "+VehRegNo+"<br>Trip ID :- "+TripId+"<br>Origin :- "+StPlc+"<br>Destination :- "+EdPlc
						+"<br><br><b>Message :- </b><br><br>"+message
						+"<br><br><b>Note: </b>This is Beta Version, if any issue in this regard, pls let us know."
						+"<br><br>If any further assistance require,please contact below"
						+"<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br>Thanks and Regards<br>Transworld Team</body></html>";


		 toid= EmailId;
		tocc = "fleetviewReports@mobile-eye.in,"+DBtocc;

			entrydatetime = new SimpleDateFormat("yyyy-MM-dd hh:mm").format(new java.util.Date());

			System.out.println("**** mailllll_updatteeeeeeee  ");
			try{

			sql5= "insert into db_gps.t_allpendingmailtable (MailName,Mailbody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('Transworld','"+html1+"','"+subject+"','"+toid+"','"+tocc+"','"+entrydatetime+"','"+mailstatus+"','"+Trainer+"')";
			
			st1.executeUpdate(sql5);
			out.write("Updated");
		
			}
			catch(Exception e)
			{
				e.printStackTrace();
				out.write("NotDone");
			}
			
				

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		// st.close();
		con1.close();
	}

%>
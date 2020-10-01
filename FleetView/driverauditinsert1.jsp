<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	
	
	int drivers = 0,quarterdrivers = 0,absentdrivers = 0,trainingoverdue = 0,medicaloverdue =0,driverrejected =0,cleanerabsent =0;
	String driverpresent = "No",decletter = "NO",DUR = "NO";
	double Toverduescore = 0,Moverdue = 0,Drejectscore = 0,Acleanerscore = 0,DSectionScore = 0;
	int DPSscore = 0,decletterscore = 0,DURSscore =0,tottrips = 0,drivblacklist = 0;
	double Mcheckscore = 0,Basicscore = 0,cap1score = 0,cap2score =0,cap3score = 0,rcapscore = 0;
	int  YearDue1 =0,QuarterDue1 = 0, QuarterCompleted1 =0,Overdue1 =0,YearCompleted1 =0;
	int YearDue2 = 0,QuarterDue2 = 0, QuarterCompleted2 =0,Overdue2 =0,YearCompleted2 =0;
	int YearDue3 = 0,QuarterDue3 = 0, QuarterCompleted3 =0,Overdue3=0,YearCompleted3=0;
	int YearDue4 = 0,QuarterDue4 = 0, QuarterCompleted4 =0,Overdue4=0,YearCompleted4 =0;
	int YearDue5 = 0,QuarterDue5 = 0, QuarterCompleted5 =0,Overdue5 =0,YearCompleted5 =0;
	int YearDue6 = 0,QuarterDue6 = 0, QuarterCompleted6 =0,Overdue6 =0,YearCompleted6 =0;
	int MToverDue = 0,MMoverdue = 0,DriverReject = 0,Cleanerabsent = 0,DPS = 0,DecLetter = 0,MDUR = 0;
	int MDsectionscore = 0,MMcheck = 0,MBasic = 0,Mcap1 = 0,Mcap2 = 0,Mcap3 = 0,MRcap = 0;
	String transporter = session.getAttribute("usertypevalue").toString();
	String quarter = "0",audityear = "0";
	quarter = request.getParameter("Q1");
	audityear = request.getParameter("Y1");
	trainingoverdue = Integer.parseInt(request.getParameter("v1"));
	medicaloverdue = Integer.parseInt(request.getParameter("v2"));
	driverpresent = request.getParameter("v3");
	decletter = request.getParameter("v4");
	DUR = request.getParameter("v5");
	YearDue1 = Integer.parseInt(request.getParameter("v6"));
	QuarterDue1 = Integer.parseInt(request.getParameter("v7"));
	QuarterCompleted1 = Integer.parseInt(request.getParameter("v8"));
	Overdue1 = Integer.parseInt(request.getParameter("v9"));
	YearCompleted1 = Integer.parseInt(request.getParameter("v10"));
	YearDue2 = Integer.parseInt(request.getParameter("v11"));
	QuarterDue2 = Integer.parseInt(request.getParameter("v12"));
	QuarterCompleted2 = Integer.parseInt(request.getParameter("v13"));
	Overdue2 = Integer.parseInt(request.getParameter("v14"));
	YearCompleted2 = Integer.parseInt(request.getParameter("v15"));
	YearDue3 = Integer.parseInt(request.getParameter("v16"));
	QuarterDue3 = Integer.parseInt(request.getParameter("v17"));
	QuarterCompleted3 = Integer.parseInt(request.getParameter("v18"));
	Overdue3 = Integer.parseInt(request.getParameter("v19"));
	YearCompleted3 = Integer.parseInt(request.getParameter("v20"));
	YearDue4 = Integer.parseInt(request.getParameter("v21"));
	QuarterDue4 = Integer.parseInt(request.getParameter("v22"));
	QuarterCompleted4 = Integer.parseInt(request.getParameter("v23"));
	Overdue4= Integer.parseInt(request.getParameter("v24"));
	YearCompleted4 = Integer.parseInt(request.getParameter("v25"));
	YearDue5 = Integer.parseInt(request.getParameter("v26"));
	QuarterDue5 = Integer.parseInt(request.getParameter("v27"));
	QuarterCompleted5 = Integer.parseInt(request.getParameter("v28"));
	Overdue5 = Integer.parseInt(request.getParameter("v29"));
	YearCompleted5 = Integer.parseInt(request.getParameter("v30"));
	YearDue6 = Integer.parseInt(request.getParameter("v31"));
	QuarterDue6 = Integer.parseInt(request.getParameter("v32"));
	QuarterCompleted6 = Integer.parseInt(request.getParameter("v33"));
	Overdue6 = Integer.parseInt(request.getParameter("v34"));
	YearCompleted6 = Integer.parseInt(request.getParameter("v35"));
	Toverduescore=1;Moverdue = 1;Drejectscore = 1;
	drivblacklist = Integer.parseInt(request.getParameter("v36"));
	String sql = "SELECT * FROM db_gps.t_DriverIncentive where activestatus = 'Yes' and Module = 'Driver'";
	ResultSet rspoints = st.executeQuery(sql);
	while(rspoints.next())
	{
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("TrainingOverdue"))
		{
			MToverDue = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("MedicalOverdue"))
		{
			MMoverdue = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverRejected"))
		{
			DriverReject = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("CleanerAbsent"))
		{
			Cleanerabsent = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverPresentSheet"))
		{
			DPS = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DeclarationLetter"))
		{
			DecLetter = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverUpdatedRegister"))
		{
			MDUR = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverSectionScore"))
		{
			MDsectionscore = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("MedicalCheck"))
		{
			MMcheck = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Basic"))
		{
			MBasic = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Capsule1"))
		{
			Mcap1 = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Capsule2"))
		{
			Mcap2 = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Capsule3"))
		{
			Mcap3 = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("RefresherCapsule"))
		{
			MRcap = rspoints.getInt("Points");
		}
	}
	
	NumberFormat nfrating=NumberFormat.getInstance();
	nfrating.setMaximumFractionDigits(2);
	nfrating.setMinimumFractionDigits(2);			
	
	sql = "select * from db_gps.t_driveraudit where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		drivers = rs.getInt("Drivers");tottrips = rs.getInt("Trips"); quarterdrivers= rs.getInt("Qdrivers");absentdrivers = rs.getInt("Abdriver"); 
		driverrejected = rs.getInt("RejectedDriver");cleanerabsent = rs.getInt("Abcleaner");
		 if(tottrips > 0)
		  {
			  Acleanerscore = ((tottrips - cleanerabsent)/(double)tottrips)*Cleanerabsent;
		  }
		 System.out.println("Acleanerscore   "+Acleanerscore);
		 if(driverpresent.equalsIgnoreCase("Yes"))
		 {
			 DPSscore = DPS;
		 }
		 System.out.println("DPSscore   "+DPSscore);
		 if(decletter.equalsIgnoreCase("Yes"))
		 {
			 decletterscore = DecLetter;
		 }
		 System.out.println("decletterscore   "+decletterscore);
		 if(DUR.equalsIgnoreCase("Yes"))
		 {
			 DURSscore = MDUR;
		 }
		 System.out.println("DURSscore   "+DURSscore);
		 if(QuarterDue1 > 0)
			{
				Mcheckscore = (QuarterCompleted1/(double)QuarterDue1)*MMcheck;
				 System.out.println("Mcheckscore   "+Mcheckscore);
				Mcheckscore = Double.parseDouble(nfrating.format(Mcheckscore));
			}
		 else
		 {
			 Mcheckscore = MMcheck;
		 }
		 System.out.println("Mcheckscore   "+Mcheckscore);
		 System.out.println("MMcheck   "+MMcheck);
		 System.out.println("QuarterCompleted1   "+QuarterCompleted1);
		 System.out.println("QuarterDue1   "+QuarterDue1);
		 if(QuarterDue2 > 0)
			{
				Basicscore = (QuarterCompleted2/(double)QuarterDue2)*MBasic;
				Basicscore = Double.parseDouble(nfrating.format(Basicscore));
			}
		 else
		 {
			 Basicscore = MBasic;
		 }
		 System.out.println("Basicscore   "+Basicscore);
		 if(QuarterDue3 > 0)
			{
				cap1score = (QuarterCompleted3/(double)QuarterDue3)*Mcap1;
				cap1score = Double.parseDouble(nfrating.format(cap1score));
			}
		 else
		 {
			 cap1score = Mcap1;
		 }
		 System.out.println("cap1score   "+cap1score);
		 if(QuarterDue4 > 0)
			{
				cap2score = (QuarterCompleted4/(double)QuarterDue4)*Mcap2;
				cap2score = Double.parseDouble(nfrating.format(cap2score));
			}
		 else
		 {
			 cap2score = Mcap2;
		 }
		 System.out.println("cap2score   "+cap2score);
		 if(QuarterDue5 > 0)
			{
				cap3score = (QuarterCompleted5/(double)QuarterDue5)*Mcap3;
				cap3score = Double.parseDouble(nfrating.format(cap3score));
			}
		 else
		 {
			 cap3score = Mcap3;
		 }
		 System.out.println("cap3score   "+cap3score);
		 if(QuarterDue6 > 0)
			{
				rcapscore = (QuarterCompleted6/(double)QuarterDue6)*MRcap;
				rcapscore = Double.parseDouble(nfrating.format(rcapscore));
			}
		 else
		 {
			 rcapscore = MRcap;
		 }
		 System.out.println("rcapscore   "+rcapscore);
		 DSectionScore = Toverduescore+Moverdue+Drejectscore+Acleanerscore+DPSscore+decletterscore+DURSscore+Mcheckscore+Basicscore+cap1score+cap2score+cap3score+rcapscore;
		 DSectionScore = Double.parseDouble(nfrating.format(DSectionScore));
		 System.out.println("section score   "+DSectionScore);
		 
		 String sql1 = "update db_gps.t_driveraudit set Toverdue='"+trainingoverdue+"',Moverdue='"+medicaloverdue+
		  "',DPRS='"+driverpresent+"',Decletter='"+decletter+"',DURS='"+DUR+"',ToverdueScore='"+Toverduescore+
		  "',MoverdueScore='"+Moverdue+"',DRejectScore='"+Drejectscore+"',AbclenerScore='"+Acleanerscore+"',DPRSScore='"+DPSscore+"',DecLetterScore='"+decletterscore+
		  "',DURSScore='"+DURSscore+"',DSectionScore='"+DSectionScore+"',Trips='"+tottrips+"',DriverBalcklist='"+drivblacklist+
		  "',YearDue1='"+YearDue1+"',QuarterDue1='"+QuarterDue1+"',QuarterCompleted1='"+QuarterCompleted1+"',Overdue1='"+Overdue1+"',YearCompleted1='"+YearCompleted1+
		  "',YearDue2='"+YearDue2+"',QuarterDue2='"+QuarterDue2+"',QuarterCompleted2='"+QuarterCompleted2+"',Overdue2='"+Overdue1+"',YearCompleted2='"+YearCompleted2+
		  "',YearDue3='"+YearDue3+"',QuarterDue3='"+QuarterDue3+"',QuarterCompleted3='"+QuarterCompleted3+"',Overdue3='"+Overdue1+"',YearCompleted3='"+YearCompleted3+
		  "',YearDue4='"+YearDue4+"',QuarterDue4='"+QuarterDue4+"',QuarterCompleted4='"+QuarterCompleted4+"',Overdue4='"+Overdue1+"',YearCompleted4='"+YearCompleted4+
		  "',YearDue5='"+YearDue5+"',QuarterDue5='"+QuarterDue5+"',QuarterCompleted5='"+QuarterCompleted5+"',Overdue5='"+Overdue1+"',YearCompleted5='"+YearCompleted5+
		  "',YearDue6='"+YearDue6+"',QuarterDue6='"+QuarterDue6+"',QuarterCompleted6='"+QuarterCompleted6+"',Overdue6='"+Overdue1+"',YearCompleted6='"+YearCompleted6+
		  "',MCheckScore='"+Mcheckscore+"',BasicScore='"+Basicscore+"',Cap1Score='"+cap1score+"',Caps2Score='"+cap2score+"',Cap3Score='"+cap3score+"',RcapScore='"+rcapscore+
		  "' where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
		st1.executeUpdate(sql1);
		 
	}
	System.out.println("successful");
	out.print("Successful");
	
	
}
catch(Exception e)
{
	e.printStackTrace();
	con1.close();
}

%>
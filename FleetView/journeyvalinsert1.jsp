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
	
	int totroutes = 0,JRMroute = 0,tottrips = 0,AdhJRM = 0,DVI0trip =0,Vioinst =0,JRMReview = 0,requestDMC = 0;
	double avgDDVI =0,JRMAdh = 0,zerodvi = 0,sectionscore = 0;
	int JRMD = 0,DevApprovalS = 0,VioMonitor = 0;
	String quarter = "0",audityear = "0",JRMDS = "NO",DevAppr = "NO",VioMonitorS = "NO",transporter = "";
	int MJRMAdh = 0,ZeroDVI = 0,JRMDoc = 0,DevApproval = 0,MJSectionScore = 0,MVioMonitor = 0;
	JRMReview = Integer.parseInt(request.getParameter("j1"));
	requestDMC = Integer.parseInt(request.getParameter("j2"));
	JRMDS = request.getParameter("j3");
	DevAppr = request.getParameter("j4");
	VioMonitorS = request.getParameter("j5");
	quarter = request.getParameter("Q1");
	audityear = request.getParameter("Y1");
	transporter = request.getParameter("T1");
	
	NumberFormat nfrating=NumberFormat.getInstance();
	nfrating.setMaximumFractionDigits(2);
	nfrating.setMinimumFractionDigits(2);			
	
	String sql = "SELECT * FROM db_gps.t_DriverIncentive where activestatus = 'Yes' and Module = 'Journey'";
	ResultSet rspoints = st.executeQuery(sql);
	while(rspoints.next())
	{
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("JRMAdherence"))
		{
			MJRMAdh = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("ZeroDVI"))
		{
			ZeroDVI = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("JRMDocument"))
		{
			JRMDoc = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DevApprovalSheet"))
		{
			DevApproval = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("ViolationMonitorSheet"))
		{
			MVioMonitor = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("JSectionScore"))
		{
			MJSectionScore = rspoints.getInt("Points");
		}
	}
	
	 sql = "select * from db_gps.t_journeyevaluate where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		totroutes = rs.getInt("Routes");JRMroute =  rs.getInt("JRMroute");tottrips =  rs.getInt("Trips");AdhJRM =  rs.getInt("AdhToJRM");DVI0trip =  rs.getInt("ZeroDVITrips");Vioinst =  rs.getInt("VioInstances");
		avgDDVI = rs.getDouble("AvgDDVI");
	
		 if(tottrips > 0)
		  {
			 JRMAdh = (AdhJRM/(double)tottrips)*MJRMAdh;
			 JRMAdh = Double.parseDouble(nfrating.format(JRMAdh));
		  }
		
		 if(tottrips > 0)
		  {
			  zerodvi = (DVI0trip/(double)tottrips)*ZeroDVI;
			  zerodvi = Double.parseDouble(nfrating.format(zerodvi));
		  }
		 
		 if(JRMDS.equalsIgnoreCase("Yes"))
		 {
			 JRMD = JRMDoc;
		 }
		 if(DevAppr.equalsIgnoreCase("Yes"))
		 {
			 DevApprovalS = DevApproval;
		 }
		 if(VioMonitorS.equalsIgnoreCase("Yes"))
		 {
			 VioMonitor = MVioMonitor;
		 }
		 
		  sectionscore = JRMAdh+zerodvi+JRMD+DevApprovalS+VioMonitor;
		  sectionscore = Double.parseDouble(nfrating.format(sectionscore));
		  
		  System.out.println("sectionscore   "+sectionscore);
		  
		  String sql1 = "update db_gps.t_journeyevaluate set JRMReview='"+JRMReview+"',requestDMC='"+requestDMC+"',JRMDS='"+JRMDS+"',DevAppr='"+DevAppr+
		  "',VioMonitorS='"+VioMonitorS+"',AdhToJRMScore='"+JRMAdh+"',ZeroDVIScore='"+zerodvi+"',JRMDScore='"+JRMD+"',DevApprScore='"+DevApprovalS+
		  "',VioMonitorScore='"+VioMonitor+"',JSectionScore='"+sectionscore+ "' where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
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
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
	
	int NoDamage = 0,DamageGoods = 0,tottrips = 0,Stoppage = 0,VioAlert =0,VioClosed =0,QIncident =0,PolicyDocScore = 0;
	double sectionscore = 0,StopScore = 0,LAClosureScore = 0,NoDamageScore =0;
	String quarter = "0",audityear = "0",PolicyDoc = "No",transporter ="";
	int LoadSecure = 0,UnwarrantedStops = 0,LAClosure = 0,PolicyDocument = 0,Psectionscore =0;
	NoDamage = Integer.parseInt(request.getParameter("p1"));
	DamageGoods = Integer.parseInt(request.getParameter("p2"));
	QIncident = Integer.parseInt(request.getParameter("p3"));
	PolicyDoc = request.getParameter("p4");
	quarter = request.getParameter("Q1");
	audityear = request.getParameter("Y1");
	transporter = request.getParameter("T1");
	
	NumberFormat nfrating=NumberFormat.getInstance();
	nfrating.setMaximumFractionDigits(2);
	nfrating.setMinimumFractionDigits(2);			
	
	String sql = "SELECT * FROM db_gps.t_DriverIncentive where activestatus = 'Yes' and Module = 'Process'";
	ResultSet rspoints = st.executeQuery(sql);
	while(rspoints.next())
	{
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("LoadSecuring"))
		{
			LoadSecure = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("UnwarrentedStops"))
		{
			UnwarrantedStops = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("LeadingAlertClosure"))
		{
			LAClosure = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("PolicyDocument"))
		{
			PolicyDocument = rspoints.getInt("Points");
		}
		if(rspoints.getString("ScoreCategory").equalsIgnoreCase("PSectionScore"))
		{
			Psectionscore = rspoints.getInt("Points");
		}
	}
	
	 sql = "select * from db_gps.t_processevaluate where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
		ResultSet rs = st.executeQuery(sql);
		if(rs.next())
		{
			tottrips = rs.getInt("Trips");Stoppage = rs.getInt("Stoppage");VioAlert = rs.getInt("VioAlert");VioClosed = rs.getInt("VioClosed");
			
			 if(tottrips > 0)
			  {
				 NoDamageScore = (NoDamage/(double)tottrips)*LoadSecure;
				 String NoDamageScore1 = NoDamageScore+"";
				  System.out.println("NoDamageScore1  "+NoDamageScore1);
				 if(NoDamageScore1.contains("."))
				 {
					String token1 = NoDamageScore1.substring(0,NoDamageScore1.indexOf("."));
					String token2 = NoDamageScore1.substring(NoDamageScore1.indexOf(".")+1,NoDamageScore1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						NoDamageScore = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
				// NoDamageScore = Double.parseDouble(nfrating.format(NoDamageScore));
				 System.out.println("NoDamageScore  "+NoDamageScore);
			 }
			 if(tottrips > 0)
			  {
				  StopScore = ((tottrips-Stoppage)/(double)tottrips)*UnwarrantedStops;
				  String StopScore1 = StopScore+"";
				  if(StopScore1.contains("."))
					 {
						String token1 = StopScore1.substring(0,StopScore1.indexOf("."));
						String token2 = StopScore1.substring(StopScore1.indexOf(".")+1,StopScore1.length());
					//	System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token2);
						if(token2.length() > 2)
						{
						//	 System.out.println("token[0]  "+token1);
						//	 System.out.println("token[1]  "+token1);
							 StopScore = Double.parseDouble(token1+"."+token2.substring(0,2));
						}
					 }
				  //StopScore = Double.parseDouble(nfrating.format(StopScore));
			  }
			  if(VioAlert > 0)
			  {
				  LAClosureScore = (VioClosed/(double)VioAlert)*LAClosure;
				  String LAClosureScore1 = LAClosureScore+"";
				  System.out.println("LAClosureScore1  "+LAClosureScore1);
				  if(LAClosureScore1.contains("."))
					 {
						String token1 = LAClosureScore1.substring(0,LAClosureScore1.indexOf("."));
						String token2 = LAClosureScore1.substring(LAClosureScore1.indexOf(".")+1,LAClosureScore1.length());
						//System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token2);
						if(token2.length() > 2)
						{
							// System.out.println("token[0]  "+token1);
							// System.out.println("token[1]  "+token1);
							 LAClosureScore = Double.parseDouble(token1+"."+token2.substring(0,2));
						}
					 }
				 // LAClosureScore = Double.parseDouble(nfrating.format(LAClosureScore));
			  }
			  if(PolicyDoc.equalsIgnoreCase("Yes"))
				 {
					 PolicyDocScore = PolicyDocument;
				 }
			  
			  sectionscore = NoDamageScore+StopScore+LAClosureScore+PolicyDocScore;
			  String sectionscore1 = sectionscore+"";
			  if(sectionscore1.contains("."))
				 {
					String token1 = sectionscore1.substring(0,sectionscore1.indexOf("."));
					String token2 = sectionscore1.substring(sectionscore1.indexOf(".")+1,sectionscore1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						 sectionscore = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
				
			 // sectionscore = Double.parseDouble(nfrating.format(sectionscore));
			  
			  String sql1 = "update db_gps.t_processevaluate set NoDamageTrips = '"+NoDamage+"',DamageGoods='"+DamageGoods+"',QIncident='"+QIncident+"',PolicyDoc='"+PolicyDoc+"',NoDamageScore='"+NoDamageScore+"',StopScore='"+StopScore+"',LAClosureScore='"+LAClosureScore+
			  "',PolicyDocScore='"+PolicyDocScore+"',PSectionScore='"+sectionscore+"'  where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
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
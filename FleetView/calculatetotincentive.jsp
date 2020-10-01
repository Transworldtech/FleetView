<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
try
{
	System.out.println("bcnxgvhjdbdmfbhv   ");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	
	String type = request.getParameter("type");
	System.out.println("type   "+type);
	String quarter = request.getParameter("Q1");
	System.out.println("bcnxgvhjdbdmfbhv   " + quarter);
	String year = request.getParameter("Y1");
	String transporter = request.getParameter("T1");
	if(type.equals("1"))
	{
		int tottrips = 0,vioinstance = 0,jpadhscore = 0,avgdviscore = 0,VFTPRscore = 0,closurescore = 0,violationscore = 0,FTPTrips = 0;
		double jpadhvalue = 0,avgdvi = 0,VFTPRvalue = 0,selfauditvalue = 0,closurevalue = 0,viovalue = 0,totincentive = 0,auditscore = 0,selfauditscore = 0;
		int totvehicle = 0,drivblacklist = 0,abcleaner = 0,maxauditscore = 0;
		String sql = "select Trips,VioInstances,AvgDDVI from db_gps.t_journeyevaluate where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
		ResultSet rs = st.executeQuery(sql);
		if(rs.next())
		{
			tottrips = rs.getInt("Trips");vioinstance= rs.getInt("VioInstances");avgdvi = rs.getDouble("AvgDDVI");
		}
		sql = "select FTPTrips,Vehciles from db_gps.t_vehicleaudit where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
		 rs = st.executeQuery(sql);
		if(rs.next())
		{
			FTPTrips = rs.getInt("FTPTrips");totvehicle = rs.getInt("Vehciles");
		}
		sql = "select Auditscore from db_gps.t_auditsummary where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
		 rs = st.executeQuery(sql);
		if(rs.next())
		{
			auditscore = rs.getDouble("Auditscore");
			selfauditvalue =  rs.getDouble("Auditscore");
		}
		 sql = "select Points from db_gps.t_DriverIncentive where MinValue='100' AND ScoreCategory='SelfAudit' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
		 rs = st.executeQuery(sql);
		// System.out.println(sql);
		 if(rs.next())
		 {
			 maxauditscore = rs.getInt("Points");
		 }
		
		sql = "select LAClosureScore from db_gps.t_processevaluate where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
		 rs = st.executeQuery(sql);
		if(rs.next())
		{
			closurevalue = rs.getDouble("LAClosureScore") * 10;
			 String VioClosure1 = closurevalue+"";
			 // System.out.println("VFTPRateScore1  "+VFTPRateScore1);
			 if(VioClosure1.contains("."))
			 {
				String token1 = VioClosure1.substring(0,VioClosure1.indexOf("."));
				String token2 = VioClosure1.substring(VioClosure1.indexOf(".")+1,VioClosure1.length());
				//System.out.println("token[0]  "+token1);
				// System.out.println("token[1]  "+token2);
				if(token2.length() > 2)
				{
					// System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token1);
					closurevalue = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
		}
		sql = "select DriverBalcklist,Abcleaner from db_gps.t_driveraudit where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
		 rs = st.executeQuery(sql);
		if(rs.next())
		{
			drivblacklist = rs.getInt("DriverBalcklist");abcleaner = rs.getInt("Abcleaner");
		}
		
		if(tottrips>0)
		{
		jpadhvalue  =(1-(vioinstance/(double)tottrips))*100;
		String jpadhvalue1 = jpadhvalue+"";
		//  System.out.println("CLIvalue  "+jpadhvalue1);
		//  System.out.println("avgdvi  "+avgdvi);
		 if(jpadhvalue1.contains("."))
		 {
			String token1 = jpadhvalue1.substring(0,jpadhvalue1.indexOf("."));
			String token2 = jpadhvalue1.substring(jpadhvalue1.indexOf(".")+1,jpadhvalue1.length());
			if(token2.length() > 2)
			{
				jpadhvalue = Double.parseDouble(token1+"."+token2.substring(0,2));
			}
		 }
		}
		
		 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+jpadhvalue+"' AND MaxValue>='"+jpadhvalue+"' AND ScoreCategory='JrnyProcAdh' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
		 rs = st.executeQuery(sql);
		// System.out.println(sql);
		 if(rs.next())
		 {
			 jpadhscore = rs.getInt("Points");
		 }
		 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+avgdvi+"' AND MaxValue>='"+avgdvi+"' AND ScoreCategory='DriverDVI' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
		 rs = st.executeQuery(sql);
		// System.out.println(sql);
		 if(rs.next())
		 {
			 avgdviscore = rs.getInt("Points");
		 }
		 
		 if(tottrips > 0)
		 {
		 VFTPRvalue = (FTPTrips/(double)tottrips)*100;
		   String VFTPRate1 = VFTPRvalue+"";
			 if(VFTPRate1.contains("."))
			 {
				String token1 = VFTPRate1.substring(0,VFTPRate1.indexOf("."));
				String token2 = VFTPRate1.substring(VFTPRate1.indexOf(".")+1,VFTPRate1.length());
				if(token2.length() > 2)
				{
					VFTPRvalue = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
		 }
			 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+VFTPRvalue+"' AND MaxValue>='"+VFTPRvalue+"' AND ScoreCategory='VFTPRR' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
			 rs = st.executeQuery(sql);
			// System.out.println(sql);
			 if(rs.next())
			 {
				 VFTPRscore = rs.getInt("Points");
			 }
			 
			
			 
			/* sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+selfauditvalue+"' AND MaxValue>='"+selfauditvalue+"' AND ScoreCategory='SelfAudit' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
			 rs = st.executeQuery(sql);
			// System.out.println(sql);
			 if(rs.next())
			 {
				 selfauditscore = rs.getInt("Points");
			 }*/
			 selfauditscore = (auditscore/(double)100)*maxauditscore;
			 String selfauditvalue1 = selfauditscore+"";
			 if(selfauditvalue1.contains("."))
			 {
				String token1 = selfauditvalue1.substring(0,selfauditvalue1.indexOf("."));
				String token2 = selfauditvalue1.substring(selfauditvalue1.indexOf(".")+1,selfauditvalue1.length());
				if(token2.length() > 2)
				{
					selfauditscore = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+closurevalue+"' AND MaxValue>='"+closurevalue+"' AND ScoreCategory='ClosureLeading' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
			 rs = st.executeQuery(sql);
			// System.out.println(sql);
			 if(rs.next())
			 {
				 closurescore = rs.getInt("Points");
			 }
			 
			 if(totvehicle > 0)
			 {
			 viovalue = (drivblacklist + abcleaner)/(double)totvehicle;
			 String viovalue1 = viovalue+"";
			 if(viovalue1.contains("."))
			 {
				String token1 = viovalue1.substring(0,viovalue1.indexOf("."));
				String token2 = viovalue1.substring(viovalue1.indexOf(".")+1,viovalue1.length());
				if(token2.length() > 2)
				{
					viovalue = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			 }
			 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+viovalue+"' AND MaxValue>='"+viovalue+"' AND ScoreCategory='Violation' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
			 rs = st.executeQuery(sql);
			// System.out.println(sql);
			 if(rs.next())
			 {
				 violationscore = rs.getInt("Points");
			 }
			 System.out.println("jpadhscore    "+jpadhscore);
			 System.out.println("avgdviscore    "+avgdviscore);
			 System.out.println("VFTPRscore    "+VFTPRscore);
			 System.out.println("selfauditscore    "+selfauditscore);
			 System.out.println("closurescore    "+closurescore);
			 System.out.println("violationscore    "+violationscore);
			 totincentive = (jpadhscore+avgdviscore+VFTPRscore+selfauditscore+closurescore) - violationscore;
			 String totincentive1 = totincentive+"";
			 if(totincentive1.contains("."))
			 {
				String token1 = totincentive1.substring(0,totincentive1.indexOf("."));
				String token2 = totincentive1.substring(totincentive1.indexOf(".")+1,totincentive1.length());
				if(token2.length() > 2)
				{
					totincentive = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			 System.out.println("mnbvj    "+totincentive);
		  String buffer =type+"~"+jpadhvalue+"~"+jpadhscore+"~"+avgdvi+"~"+avgdviscore+"~"+VFTPRvalue+"~"+VFTPRscore+"~"+selfauditvalue+"~"+selfauditscore+"~"+closurevalue+"~"+closurescore+"~"+viovalue+"~"+violationscore+"~"+totincentive;		
		  out.print(buffer);
	}
	else
		if(type.equals("2"))
		{
			int tottrips = 0,vioinstance = 0,jpadhscore = 0,avgdviscore = 0,VFTPRscore = 0,closurescore = 0,violationscore = 0,FTPTrips = 0;
			double jpadhvalue = 0,avgdvi = 0,VFTPRvalue = 0,selfauditvalue = 0,closurevalue = 0,viovalue = 0,totincentive = 0,auditscore = 0,selfauditscore = 0;
			int totvehicle = 0,drivblacklist = 0,abcleaner = 0,maxauditscore = 0;
			
			String sql = "select FTPTrips,Vehciles,Trips from db_gps.t_vehicleaudit where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
			ResultSet rs = st.executeQuery(sql);
			if(rs.next())
			{
				FTPTrips = rs.getInt("FTPTrips");totvehicle = rs.getInt("Vehciles");tottrips = rs.getInt("Trips");
			}
			 if(tottrips > 0)
			 {
				 VFTPRvalue = (FTPTrips/(double)tottrips)*100;
			  	 String VFTPRate1 = VFTPRvalue+"";
				 if(VFTPRate1.contains("."))
				 {
					String token1 = VFTPRate1.substring(0,VFTPRate1.indexOf("."));
					String token2 = VFTPRate1.substring(VFTPRate1.indexOf(".")+1,VFTPRate1.length());
					if(token2.length() > 2)
					{
						VFTPRvalue = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
			 }
				 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+VFTPRvalue+"' AND MaxValue>='"+VFTPRvalue+"' AND ScoreCategory='VFTPRR' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
				 rs = st.executeQuery(sql);
				// System.out.println(sql);
				 if(rs.next())
				 {
					 VFTPRscore = rs.getInt("Points");
				 }
				 
				 sql = "select * from db_gps.t_auditsummary where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
				 rs = st.executeQuery(sql);
				 if(rs.next())
				 {
					 jpadhscore = rs.getInt("JPAdhScore");avgdviscore =  rs.getInt("AvgDVIScore");selfauditscore =  rs.getDouble("AuditPoints");closurescore =  rs.getInt("VioClosureScore");violationscore =  rs.getInt("ViolationScore");
				 }
			
				 totincentive = (jpadhscore+avgdviscore+VFTPRscore+selfauditscore+closurescore) - violationscore;
				 String totincentive1 = totincentive+"";
				 if(totincentive1.contains("."))
				 {
					String token1 = totincentive1.substring(0,totincentive1.indexOf("."));
					String token2 = totincentive1.substring(totincentive1.indexOf(".")+1,totincentive1.length());
					if(token2.length() > 2)
					{
						totincentive = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
				 sql = "update db_gps.t_auditsummary set VFTPR='"+VFTPRvalue+"',VFTPRScore='"+VFTPRscore+"',TotalIncentive='"+totincentive+"'  where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
				 st.executeUpdate(sql);
				 
				 String buffer =type+"~"+VFTPRvalue+"~"+VFTPRscore+"~"+totincentive;		
				 out.print(buffer);
		}
		else
			if(type.equals("3"))
			{
				int tottrips = 0,vioinstance = 0,jpadhscore = 0,avgdviscore = 0,VFTPRscore = 0,closurescore = 0,violationscore = 0,FTPTrips = 0;
				double jpadhvalue = 0,avgdvi = 0,VFTPRvalue = 0,selfauditvalue = 0,closurevalue = 0,viovalue = 0,totincentive = 0,auditscore = 0,selfauditscore = 0;
				int totvehicle = 0,drivblacklist = 0,abcleaner = 0,maxauditscore = 0;
				
				String sql = "select Vehciles from db_gps.t_vehicleaudit where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
				ResultSet rs = st.executeQuery(sql);
				if(rs.next())
				{
					totvehicle = rs.getInt("Vehciles");
				}
				
				sql = "select DriverBalcklist,Abcleaner from db_gps.t_driveraudit where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
				 rs = st.executeQuery(sql);
				if(rs.next())
				{
					drivblacklist = rs.getInt("DriverBalcklist");abcleaner = rs.getInt("Abcleaner");
				}
				 if(totvehicle > 0)
				 {
				 viovalue = (drivblacklist + abcleaner)/(double)totvehicle;
				 String viovalue1 = viovalue+"";
				 if(viovalue1.contains("."))
				 {
					String token1 = viovalue1.substring(0,viovalue1.indexOf("."));
					String token2 = viovalue1.substring(viovalue1.indexOf(".")+1,viovalue1.length());
					if(token2.length() > 2)
					{
						viovalue = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
				 }
				 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+viovalue+"' AND MaxValue>='"+viovalue+"' AND ScoreCategory='Violation' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
				 rs = st.executeQuery(sql);
				 if(rs.next())
				 {
					 violationscore = rs.getInt("Points");
				 }
				
				 sql = "select * from db_gps.t_auditsummary where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
				 rs = st.executeQuery(sql);
				 if(rs.next())
				 {
					 jpadhscore = rs.getInt("JPAdhScore");avgdviscore =  rs.getInt("AvgDVIScore");selfauditscore =  rs.getDouble("AuditPoints");closurescore =  rs.getInt("VioClosureScore");VFTPRscore =  rs.getInt("VFTPRScore");
				 }
				 
				 totincentive = (jpadhscore+avgdviscore+VFTPRscore+selfauditscore+closurescore) - violationscore;
				 String totincentive1 = totincentive+"";
				 if(totincentive1.contains("."))
				 {
					String token1 = totincentive1.substring(0,totincentive1.indexOf("."));
					String token2 = totincentive1.substring(totincentive1.indexOf(".")+1,totincentive1.length());
					if(token2.length() > 2)
					{
						totincentive = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
				 sql = "update db_gps.t_auditsummary set Violation='"+viovalue+"',ViolationScore='"+violationscore+"',TotalIncentive='"+totincentive+"'  where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
				 st.executeUpdate(sql);
				 String buffer =type+"~"+viovalue+"~"+violationscore+"~"+totincentive;		
				 out.print(buffer);
			}
			else
				if(type.equals("6"))
				{
					int tottrips = 0,vioinstance = 0,jpadhscore = 0,avgdviscore = 0,VFTPRscore = 0,closurescore = 0,violationscore = 0,FTPTrips = 0;
					double jpadhvalue = 0,avgdvi = 0,VFTPRvalue = 0,selfauditvalue = 0,closurevalue = 0,viovalue = 0,totincentive = 0,auditscore = 0,selfauditscore = 0;
					int totvehicle = 0,drivblacklist = 0,abcleaner = 0,maxauditscore = 0;
					String sql = "select * from db_gps.t_auditsummary where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
					ResultSet rs = st.executeQuery(sql);
					 if(rs.next())
					 {
						 jpadhscore = rs.getInt("JPAdhScore");avgdviscore =  rs.getInt("AvgDVIScore");selfauditvalue =  rs.getDouble("Auditscore"); closurescore =  rs.getInt("VioClosureScore");VFTPRscore =  rs.getInt("VFTPRScore");violationscore =  rs.getInt("ViolationScore");
					 }
					System.out.println("selfauditvalue  "+selfauditvalue);
					 sql = "select Points from db_gps.t_DriverIncentive where MinValue='100' AND ScoreCategory='SelfAudit' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
					 rs = st.executeQuery(sql);
					// System.out.println(sql);
					 if(rs.next())
					 {
						 maxauditscore = rs.getInt("Points");
					 }
					 
					 selfauditscore = (selfauditvalue/(double)100)*maxauditscore;
					 String selfauditvalue1 = selfauditscore+"";
					 if(selfauditvalue1.contains("."))
					 {
						String token1 = selfauditvalue1.substring(0,selfauditvalue1.indexOf("."));
						String token2 = selfauditvalue1.substring(selfauditvalue1.indexOf(".")+1,selfauditvalue1.length());
						if(token2.length() > 2)
						{
							selfauditscore = Double.parseDouble(token1+"."+token2.substring(0,2));
						}
					 }
					 
					 /*sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+selfauditvalue+"' AND MaxValue>='"+selfauditvalue+"' AND ScoreCategory='SelfAudit' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
					 rs = st.executeQuery(sql);
					// System.out.println(sql);
					 if(rs.next())
					 {
						 selfauditscore = rs.getInt("Points");
					 }*/
					 System.out.println("jpadhscore    "+jpadhscore);
					 System.out.println("avgdviscore    "+avgdviscore);
					 System.out.println("VFTPRscore    "+VFTPRscore);
					 System.out.println("selfauditscore    "+selfauditscore);
					 System.out.println("closurescore    "+closurescore);
					 System.out.println("violationscore    "+violationscore);
					 totincentive = (jpadhscore+avgdviscore+VFTPRscore+selfauditscore+closurescore) - violationscore;
					 System.out.println("totincentive    "+totincentive);
					 String totincentive1 = totincentive+"";
					 if(totincentive1.contains("."))
					 {
						String token1 = totincentive1.substring(0,totincentive1.indexOf("."));
						String token2 = totincentive1.substring(totincentive1.indexOf(".")+1,totincentive1.length());
						if(token2.length() > 2)
						{
							totincentive = Double.parseDouble(token1+"."+token2.substring(0,2));
						}
					 }
					 sql = "update db_gps.t_auditsummary set 	AuditPoints='"+selfauditscore+"',TotalIncentive='"+totincentive+"'  where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
					 st.executeUpdate(sql);
					 String buffer =type+"~"+selfauditvalue+"~"+selfauditscore+"~"+totincentive;		
					 out.print(buffer);
				}
				else
					if(type.equals("5"))
					{
						int tottrips = 0,vioinstance = 0,jpadhscore = 0,avgdviscore = 0,VFTPRscore = 0,closurescore = 0,violationscore = 0,FTPTrips = 0;
						double jpadhvalue = 0,avgdvi = 0,VFTPRvalue = 0,selfauditvalue = 0,closurevalue = 0,viovalue = 0,totincentive = 0,auditscore = 0,selfauditscore = 0;
						int totvehicle = 0,drivblacklist = 0,abcleaner = 0,maxauditscore = 0;
						String sql = "select LAClosureScore from db_gps.t_processevaluate where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
						ResultSet rs = st.executeQuery(sql);
						if(rs.next())
						{
							closurevalue = rs.getDouble("LAClosureScore") * 10;
						}
						
						 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+closurevalue+"' AND MaxValue>='"+closurevalue+"' AND ScoreCategory='ClosureLeading' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
						 rs = st.executeQuery(sql);
						// System.out.println(sql);
						 if(rs.next())
						 {
							 closurescore = rs.getInt("Points");
						 }
						 
						 sql = "select * from db_gps.t_auditsummary where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
						 rs = st.executeQuery(sql);
						 if(rs.next())
						 {
							 jpadhscore = rs.getInt("JPAdhScore");avgdviscore =  rs.getInt("AvgDVIScore");selfauditscore =  rs.getDouble("AuditPoints");violationscore =  rs.getInt("ViolationScore");VFTPRscore =  rs.getInt("VFTPRScore");
						 }
						 
						 totincentive = (jpadhscore+avgdviscore+VFTPRscore+selfauditscore+closurescore) - violationscore;
						 String totincentive1 = totincentive+"";
						 if(totincentive1.contains("."))
						 {
							String token1 = totincentive1.substring(0,totincentive1.indexOf("."));
							String token2 = totincentive1.substring(totincentive1.indexOf(".")+1,totincentive1.length());
							if(token2.length() > 2)
							{
								totincentive = Double.parseDouble(token1+"."+token2.substring(0,2));
							}
						 }
						 sql = "update db_gps.t_auditsummary set VioClosure='"+closurevalue+"',VioClosureScore='"+closurescore+"',TotalIncentive='"+totincentive+"'  where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
						 st.executeUpdate(sql);
						 String buffer =type+"~"+closurevalue+"~"+closurescore+"~"+totincentive;		
						 out.print(buffer);
					}
					else
						if(type.equals("4"))
						{
							int tottrips = 0,vioinstance = 0,jpadhscore = 0,avgdviscore = 0,VFTPRscore = 0,closurescore = 0,violationscore = 0,FTPTrips = 0;
							double jpadhvalue = 0,avgdvi = 0,VFTPRvalue = 0,selfauditvalue = 0,closurevalue = 0,viovalue = 0,totincentive = 0,auditscore = 0,selfauditscore = 0;
							int totvehicle = 0,drivblacklist = 0,abcleaner = 0,maxauditscore = 0;
							String sql = "select Trips,VioInstances,AvgDDVI from db_gps.t_journeyevaluate where  Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
							ResultSet rs = st.executeQuery(sql);
							if(rs.next())
							{
								tottrips = rs.getInt("Trips");vioinstance= rs.getInt("VioInstances");avgdvi = rs.getDouble("AvgDDVI");
							}
							
							if(tottrips > 0)
							 {
							jpadhvalue  =(1-(vioinstance/(double)tottrips))*100;
							String jpadhvalue1 = jpadhvalue+"";
							//  System.out.println("CLIvalue  "+jpadhvalue1);
							//  System.out.println("avgdvi  "+avgdvi);
							 if(jpadhvalue1.contains("."))
							 {
								String token1 = jpadhvalue1.substring(0,jpadhvalue1.indexOf("."));
								String token2 = jpadhvalue1.substring(jpadhvalue1.indexOf(".")+1,jpadhvalue1.length());
								if(token2.length() > 2)
								{
									jpadhvalue = Double.parseDouble(token1+"."+token2.substring(0,2));
								}
							 }
							 }
							 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+jpadhvalue+"' AND MaxValue>='"+jpadhvalue+"' AND ScoreCategory='JrnyProcAdh' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
							 rs = st.executeQuery(sql);
							// System.out.println(sql);
							 if(rs.next())
							 {
								 jpadhscore = rs.getInt("Points");
							 }
							 sql = "select Points from db_gps.t_DriverIncentive where MinValue<='"+avgdvi+"' AND MaxValue>='"+avgdvi+"' AND ScoreCategory='DriverDVI' AND GPName='Castrol' and Module = 'TotalIncentive' and activestatus = 'Yes' ";
							 rs = st.executeQuery(sql);
							// System.out.println(sql);
							 if(rs.next())
							 {
								 avgdviscore = rs.getInt("Points");
							 }
							 
							 sql = "select * from db_gps.t_auditsummary where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
							 rs = st.executeQuery(sql);
							 if(rs.next())
							 {
								 closurescore =  rs.getInt("VioClosureScore");selfauditscore =  rs.getDouble("AuditPoints");violationscore =  rs.getInt("ViolationScore");VFTPRscore =  rs.getInt("VFTPRScore");
							 }
							 
							 totincentive = (jpadhscore+avgdviscore+VFTPRscore+selfauditscore+closurescore) - violationscore;
							 String totincentive1 = totincentive+"";
							 if(totincentive1.contains("."))
							 {
								String token1 = totincentive1.substring(0,totincentive1.indexOf("."));
								String token2 = totincentive1.substring(totincentive1.indexOf(".")+1,totincentive1.length());
								if(token2.length() > 2)
								{
									totincentive = Double.parseDouble(token1+"."+token2.substring(0,2));
								}
							 }
							 sql = "update db_gps.t_auditsummary set JPAdh='"+jpadhvalue+"',JPAdhScore='"+jpadhscore+"',AvgDDVI='"+avgdvi+"',AvgDVIScore='"+avgdviscore+"',TotalIncentive='"+totincentive+"'  where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
							 st.executeUpdate(sql);
							 String buffer =type+"~"+jpadhvalue+"~"+jpadhscore+"~"+avgdvi+"~"+avgdviscore+"~"+totincentive;		
							 out.print(buffer);
						}
	
	
}
catch(Exception e)
{
	e.printStackTrace();
	con1.close();
}

%>
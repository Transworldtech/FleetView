
<%@page import="javax.xml.datatype.Duration"%><%@ include file="Connections/conn.jsp" %>
<%@ page import="java.util.*" %>

<%!
Connection con1;
Statement st,st1,st2;
%>
<% 
try 
{
	System.out.println("sql1 *************************   ");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con1.createStatement();
	st1=con1.createStatement();
	st2=con1.createStatement();
	ResultSet rst=null;
	String sql="",sql1="";
	
	String tripid = request.getParameter("tripid");
	String briefid = request.getParameter("briefid");
	String driverid = request.getParameter("driverid");
	String day = request.getParameter("day");
	double duration = Double.parseDouble(request.getParameter("stdur"));
	String event = request.getParameter("event");
	String tid1 = request.getParameter("tid");
	String reason = request.getParameter("reason");
	int routeid  = Integer.parseInt(request.getParameter("rid"));
	String buffer = "",querystring1 = "";
	int tid = 1;
	if(tid1 == null)
	{
		tid = 1;
	}
	else
	{
		tid = Integer.parseInt(tid1);
	}
	
	if(day.equalsIgnoreCase("All"))
	{
		querystring1 = "";
	}
	else
	{
		querystring1 = " and Day = "+day;
	}
	
	String stdur = "";
	System.out.println("*****     "+duration);
	int Duration  = (int)duration;
	Duration = Duration * 60;
	System.out.println("*****     "+duration);
	sql = "select  SEC_TO_TIME("+Duration+") as stdur";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		stdur = rst.getString("stdur");
	}
	
	System.out.println("*****     "+stdur);
	//stdur = stdur+":00";
	String ndstarttime = "23:00:00";
	String ndendtime = "05:00:00",runhrs = "00:00:00",runhrs1 = "00:00:00";
	

	int preid = 1,cd = 1,nd = 0,row = 1,currkm = 0,prekm = 0,drivkm = 0,day1 = 1,totkm = 0,cdstart = 1,cdend = 1;
	String runhr = "00:00:00",currevent = "",currtime = "",currlegtime = "",startdate = "",drivstart = "",stdur1 = "",drivstop = "",legdur = "",stopend = "";
	String drivdur = "-",currstartloc = "",currlat = "",currlon = "",currstate = "",currjrmcommnet = "",currjrmtype = "",currzone = "",cdendstop = "",currday = "";
	String prevcddrivtime = "",prevcdstoptime = "";
	int daystarttid = 1;

	
	sql = "select * from db_gps.t_intermediatejrmroute where tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and advancedtrackid = '"+tid+"' and row = '1' and  advancedrouteid = '"+routeid+"'";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		preid = rst.getInt("preid");
		cdstart = rst.getInt("cdstart");
		cdend = rst.getInt("cdend");
		nd = rst.getInt("prend");
		runhrs = rst.getString("prerunhr");
		currkm = rst.getInt("CumDist");
		currevent = rst.getString("event");
		currtime = rst.getString("CumTime");
		currstartloc = rst.getString("Placename");
		currlat = rst.getString("latitude");
		currlon = rst.getString("longitude");
		currstate = rst.getString("Statename");
		currjrmcommnet = rst.getString("jrmcomment");
		currjrmtype = rst.getString("jrmtype");
		currzone = rst.getString("zone");
		currlegtime = rst.getString("LegTime");
		currday = rst.getString("day");
		//drivstate = rst.getString("Statename");		
	}
	
	sql = "select advancedtrackid from db_gps.t_intermediatejrmroute where tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and  advancedrouteid = '"+routeid+"' and day = '"+currday+"' order by advancedtrackid limit 1";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		daystarttid = rst.getInt("advancedtrackid");
	}
	
	//System.out.println("")
	
	if(preid == cdstart)
	{
		prevcddrivtime = "00:00:00";
		prevcdstoptime = "00:00:00";
	}
	else
	{
	sql = "select SEC_TO_TIME(sum(Time_To_Sec(drivingtime))) as drivtime,SEC_TO_TIME(sum(Time_To_Sec(stoptime))) as stoptime from db_gps.t_intermediatejrmroute where tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and advancedtrackid >=  "+cdstart+" and  advancedtrackid < "+preid+" and drivingtime <> '-' and  advancedrouteid = '"+routeid+"'";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		prevcddrivtime = rst.getString("drivtime");
		prevcdstoptime = rst.getString("stoptime");
	}
	}
	
	if(preid == daystarttid)
	{
		runhrs = "00:00:00";
	}
	else
	{
		sql = "select SEC_TO_TIME(sum(Time_To_Sec(drivingtime))) as drivtime  from db_gps.t_intermediatejrmroute where tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and  advancedtrackid < "+preid+" and drivingtime <> '-' and  advancedrouteid = '"+routeid+"' and day = '"+currday+"'";
		rst = st.executeQuery(sql);
		if(rst.next())
		{
			runhrs = rst.getString("drivtime");
		}
		
	}
	
	
	sql = "select sum(LegDist) as totdist from db_gps.t_jrmrouteadvanceddetails where advancedrouteid = '"+routeid+"' ";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		totkm = rst.getInt("totdist");
	}
	
	sql = "select * from db_gps.t_intermediatejrmroute where tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and  advancedrouteid = '"+routeid+"' order by advancedtrackid,row limit 1";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		startdate = rst.getString("CumTime");
	}
	
	sql = "select * from db_gps.t_intermediatejrmroute where tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and  advancedrouteid = '"+routeid+"' and advancedtrackid = '"+preid+"'  and Event in ('Driving','Deviation Start') ";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		drivstart = rst.getString("CumTime");
		row=  rst.getInt("Row");
		stdur1 = rst.getString("stoptime");
		prekm = rst.getInt("CumDist");
	}
	
	
	int sec =0,sec1 = 0,diffsec = 0;
	String flag ="0";
	sql1 = "select TIME_TO_SEC('"+stdur+"') as sec";
	ResultSet rs = st1.executeQuery(sql1);
	if(rs.next())
	{
		sec = rs.getInt("sec");
	}
	
	int min = sec/60;
	if(min < 15)
	{
		flag = "1";
	}
	
	if(flag.equals("1"))
	{
		out.print("1");
	}
	else
	{
		if(currevent.equalsIgnoreCase("Rest") || currevent.equalsIgnoreCase("Night Halt") || currevent.equalsIgnoreCase("Duty Stop"))
		{
		       sql = "select SUBTIME('"+currtime+"','"+stdur1+"') as stopdate";
		       rst = st.executeQuery(sql);
		       if(rst.next())
		       {
		    	   drivstop = rst.getString("stopdate");
		       }
		       
		       sql = "select SUBTIME('"+currlegtime+"','"+stdur1+"') as stopdate";
		       rst = st.executeQuery(sql);
		       if(rst.next())
		       {
		    	   legdur = rst.getString("stopdate");
		       }
		}
		else
		{
			drivstop = currtime;
			legdur = currlegtime;
		}
		
		sql = "SELECT TIMEDIFF('"+drivstop+"','"+drivstart+"') as duration";
		 rst = st.executeQuery(sql);
	       if(rst.next())
	       {
	    	   drivdur = rst.getString("duration");
	       }				     
	   	cd = 1;
		nd = 0;
	       drivkm = currkm - prekm;	
	       sql1 = "select ADDTIME('"+drivstop+"','"+stdur+"') as enddate";
	       rst = st.executeQuery(sql1);
	    //   
			if(rst.next())
			{
				stopend = rst.getString("enddate");
			} 		
		//	System.out.println("runhrs before "+runhrs+"   drivdur  "+drivdur);
			sql1 = "select ADDTIME('"+drivdur+"','"+runhrs+"') as enddate";
		       rst = st.executeQuery(sql1);
		    //   
				if(rst.next())
				{
					runhrs = rst.getString("enddate");
				}
				
				String rundiff = "";		
				 int runhrhrs = 0;
				sql1 = "select Hour('"+runhrs+"') as hrs";
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					runhrhrs = rs.getInt("hrs");
				}
				
				sql1 = "select TIMEDIFF('10:00:00','"+runhrs+"') as tdiff";
				rs = st1.executeQuery(sql1);
			//	System.out.println("**c    "+sql1);
				if(rs.next())
				{
					rundiff = rs.getString("tdiff");
				}
				
				 int runhrsec = 0,runhrmin  = 0;
				sql1 = "select TIME_TO_SEC('"+rundiff+"') as sec";
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					runhrsec = rs.getInt("sec");
				}
				runhrmin = runhrsec/60;
				
			//	System.out.println("runhrs after "+runhrs);
			int kmtogo = 0;
			kmtogo = totkm - currkm;
			String date4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(drivstop));		
			java.util.Date nddate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date4+" "+ndstarttime);
			Calendar cal = Calendar.getInstance();
			cal.setTime(nddate1);
			cal.add(Calendar.DATE,1);
			String tomorrowdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
			java.util.Date nddate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tomorrowdate+" "+ndendtime);
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopend);
		//	System.out.println(" nddate1      "+nddate1+"  ***   nddate2  "+nddate2+"    dt  "+dt);
		//	System.out.println("***********************************************************************************************");
			System.out.println(dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2)));
			 sec = 0;
		
			String nightdrivingstart =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate1);
			sql1 = "select TIME_TO_SEC(TIMEDIFF('"+nightdrivingstart+"','"+stopend+"')) as sec";
			 rs = st1.executeQuery(sql1);
			if(rs.next())
			{
				sec = rs.getInt("sec");
			}
			
			min = 0;
			min = sec/60;
			System.out.println("**  nightdrivingstart  "+nightdrivingstart+"     date2   "+stopend);
			System.out.println("**  min  "+min+"     sec   "+sec);
			int ndoccured = 0;
			
			if((dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2))) || (min > 0 && min < 15) || ((reason.equalsIgnoreCase("Night Halt") || ((runhrhrs >= 10) || (runhrhrs < 10 && min <15))) && event.equalsIgnoreCase("Stop")))
			{
				stopend = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate2);
				nd = 0;
				cd = 1;
				//runhrs = "00:00:00";
				//runhrs1 = "02:00:00";
				reason = "Night Halt";
				ndoccured = 1;
			}
			sql1 = "SELECT TIMEDIFF('"+stopend+"','"+drivstop+"') as duration";
			//	System.out.println("****     "+sql1);
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					stdur = rs.getString("duration");
				}
				
				
				
				  sql1 = "select ADDTIME('"+legdur+"','"+stdur+"') as enddate";
			       rst = st.executeQuery(sql1);
			    //   System.out.println("sql1");
					if(rst.next())
					{
						legdur = rst.getString("enddate");
					}
					
					sql1 = "select DATEDIFF('"+drivstop+"','"+startdate+"') as days";
					rst = st1.executeQuery(sql1);
					if(rst.next())
					{
						 day1 = rst.getInt("days")+1;
					}
					
					 sql = "Update db_gps.t_intermediatejrmroute set drivingkm = '"+drivkm+"',drivingtime='"+drivdur+"',stoptime='"+stdur+"',stopreason='"+reason+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
					    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+preid+"' and row = '"+row+"'";
				       st.executeUpdate(sql);
				       
				       
				       
				       sql = "Update db_gps.t_intermediatejrmroute set drivingkm = '0',drivingtime='-',stoptime='-',calculateddate = '"+stopend+"',LegTime='"+legdur+"',CumTime = '"+stopend+"',Event='"+reason+"',day = '"+day1+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
					    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+tid+"' and row = '1'";
				       st.executeUpdate(sql);
				       
				       
				       sql1 = "Update db_gps.t_jrnyplanning set start = '"+drivstart+"',End = '"+drivstop+"',Duration = '"+drivdur+"',Destination='"+currstartloc+"',LegDistance = '"+drivkm+"',TripDist = '"+currkm+"',Kmtogo='"+kmtogo
						 +"',StopDuration='"+stdur+"',StopReason='"+reason+"'  where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid = '"+preid+"' and Event = 'Driving'";
				       st1.executeUpdate(sql1);
				       
				       
				       sql1 = "select DATEDIFF('"+stopend+"','"+startdate+"') as days";
						rst = st1.executeQuery(sql1);
						if(rst.next())
						{
							 day1 = rst.getInt("days")+1;
						}
						
						
							System.out.println("ruhrs   "+runhrs);
							sql1 = "select ADDTIME('"+drivdur+"','"+prevcddrivtime+"') as enddate";
						       rst = st.executeQuery(sql1);
						    //   System.out.println("sql1");
								if(rst.next())
								{
									prevcddrivtime = rst.getString("enddate");
								}
							
								sql1 = "select ADDTIME('"+stdur+"','"+prevcdstoptime+"') as enddate";
							       rst = st.executeQuery(sql1);
							    //   System.out.println("sql1");
									if(rst.next())
									{
										prevcdstoptime = rst.getString("enddate");
									}
									
								
						 sql1 = "select * from  db_gps.t_intermediatejrmroute where Tripid = '"+tripid+"' and briefid = '"+briefid
						    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+tid+"' and row = '2'";
					        rs = st1.executeQuery(sql1);
					       if(rs.next())
					       {  
					    	   sql = "Update db_gps.t_intermediatejrmroute set calculateddate = '"+stopend+"',CumTime = '"+stopend+"',day = '"+day1+"',preid = '"+tid+"',prerunhr='"+runhrs+"',prend = '"+nd+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
							    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+tid+"' and row = '2'";
						       st.executeUpdate(sql);
					       }
					       else
					       {
					    	   sql = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend,cdend) "+
					           " values ('"+routeid+"','"+tid+"','00:00:00','"+stopend+"','0','"+currkm+"','"+currlat+"','"+currlon+"','"+currstartloc+"','"+currstate+"','"+currjrmcommnet+"','"+
					           currjrmtype+"','"+currzone+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','"+stopend+"','2','"+day1+"','Driving','"+tid+"','"+runhrs+"','"+cdstart+"','"+nd+"','"+cdend+"')";
					    	   st.executeUpdate(sql);
					    	 //  System.out.println(sql);
					       }
					       
					       sql = "select * from db_gps.t_jrnyplanning where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid = '"+tid+"' and Event = 'Driving'";
						      rst = st.executeQuery(sql);
						      if(rst.next())
						      {
						    	  sql1 = "Update db_gps.t_jrnyplanning set Day = '"+day1+"',Event = 'Driving',Start = '"+stopend+"',Origin='"+currstartloc+"'  where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid = '"+tid+"' and Event = 'Driving'";
							       st1.executeUpdate(sql1);
						      }
						      else
						      {
					       sql1 = "insert into db_gps.t_jrnyplanning (Tripid,Day,Event,Start,Origin,trackid,brifid,driverid) values ('"+tripid+"','"+day1+"','Driving','"+stopend+"','"+currstartloc+"','"+tid+"','"+briefid+"','"+driverid+"')"; 
							st1.executeUpdate(sql1);
						      }
					       
					       sql = "select * from db_gps.t_intermediatejrmroute where Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid > "+tid+" and advancedtrackid < "+cdend+" ";
					       rst = st.executeQuery(sql) ;
					       while(rst.next())
					       {
					    	   String ttime = "";
					    	   sql1 = "select ADDTIME('"+rst.getString("cumtime")+"','"+stdur+"') as enddate";
						       rs = st1.executeQuery(sql1);
						      // System.out.println("sql1");
								if(rs.next())
								{
									ttime = rs.getString("enddate");
								}	
								 sql1 = "Update db_gps.t_intermediatejrmroute set CumTime = '"+ttime+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
								    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+rst.getString("advancedtrackid")+"'  and row = '"+rst.getString("row")+"' ";
							       st1.executeUpdate(sql1);									
					       }
					       
					       
					       
					       sql = "delete from db_gps.t_intermediatejrmroute where Tripid = '"+tripid+"' and briefid = '"+briefid
								    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid > "+tid+" ";
					       st.executeUpdate(sql);
					       
					       sql = "delete from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid > "+tid+" ";
					       st.executeUpdate(sql);
					       
					       System.out.println("runhrs    "+runhrs);
					       System.out.println("prevcddrivtime    "+prevcddrivtime);
					       System.out.println("prevcdstoptime    "+prevcdstoptime);			       
					       preid = tid;
					       String date1 = stopend,drivtime = "04:00:00",date2 = stopend,prerunhrs=runhrs,precd="",prend = "";
					       
					       sql = "select SUBTIME('04:00:00','"+prevcddrivtime+"') as drivtime";
					       rst = st.executeQuery(sql);
					       if(rst.next())
					       {
					    	   drivtime =rst.getString("drivtime");
					       }
					       
					         int sec2 = 0,min2 = 0; 
					       
					       sql = "select Time_To_Sec('"+prevcdstoptime+"') as sec";
					       rst = st.executeQuery(sql);
					       if(rst.next())
					       {
					    	   sec2 = rst.getInt("sec");
					       }
					       
					       min2 = sec2/60;
					       
					       sql = "select Time_To_Sec('"+drivtime+"') as sec";
					       rst = st.executeQuery(sql);
					       if(rst.next())
					       {
					    	   sec = rst.getInt("sec");
					       }
					       min = sec/60;
					       
					       if(min < 10 || min2 >= 60)
					       {
					    	   drivtime = "04:00:00";
					    	   cdstart = preid;
					    	   prevcddrivtime = "00:00:00";
					    	   prevcdstoptime = "00:00:00";
					    	   if(reason.equalsIgnoreCase("Night Halt"))
					    	   {
					    		   runhrs = "00:00:00";
					    	   }
					       }
					       
					     
					       
					       System.out.println("drivtime    "+drivtime+"   runhrs   "+runhrs);	
					       
					       sql1 = "select ADDTIME('"+date1+"','"+drivtime+"') as enddate";
							 rs = st1.executeQuery(sql1);
							if(rs.next())
							{
								date2 = rs.getString("enddate");
							}	
							precd = "1";
							prend = "0";
							System.out.println("date2    "+date2+"   prerunhrs   "+prerunhrs);
							date4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));		
							nddate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date4+" "+ndstarttime);
							cal = Calendar.getInstance();
							cal.setTime(nddate1);
							cal.add(Calendar.DATE,1);
							 tomorrowdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
							nddate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tomorrowdate+" "+ndendtime);
							 dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2);
						//	System.out.println(" nddate1      "+nddate1+"  ***   nddate2  "+nddate2+"    dt  "+dt);
						 sql1 = "select TIME_TO_SEC(TIMEDIFF('"+nightdrivingstart+"','"+date2+"')) as sec";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											sec = rs.getInt("sec");
										}
										min = 0;
										min = sec/60;
							if((dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2))) || (min > 0 && min < 15))
							{
								date2 = date4+" "+ndstarttime;
								nd = 1;
								cd = 1;
							}
							System.out.println(" date1      "+date1+"  ***   date2  "+date2);
							row = 2;
							String currentdate = date1;
							int k = 1;
//**********************************************************************Default Calculation************************************************************************************
							
							
							sql = "select *,addtime('"+startdate+"',timediff(Cumtime,'00:00:00') ) ctime  from db_gps.t_jrmrouteadvanceddetails where advancedrouteid = '"+routeid+"'  and advancedtrackid > "+preid+" order by advancedtrackid ";
							rst = st.executeQuery(sql);
							while(rst.next())
							{
								sql1 = "select ADDTIME('"+currentdate+"','"+rst.getString("LegTime")+"') as enddate";
								 rs = st1.executeQuery(sql1);
								if(rs.next())
								{
									currentdate = rs.getString("enddate");
								}	
								java.util.Date data1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentdate);
								java.util.Date data2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2);
								java.util.Date nextdate = null;
								if(rst.isLast())
								{
									//System.out.println("Is last");
									date2 = currentdate;
									data2 = data1;
									nextdate = data1;
								}
								else
								{
									rst.next();
									//System.out.println(rst.getString("LegTime"));
										sql1 = "select ADDTIME('"+currentdate+"','"+rst.getString("LegTime")+"') as enddate";
										 rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											nextdate =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("enddate"));
										}	
										//nextdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("ctime"));		
									rst.previous();
								}
								
								if(rst.isLast())
								{
									date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
									 drivtime = "";
									//System.out.println("date2 " +date2+"   date1  "+date1);
									sql1 = "SELECT TIMEDIFF('"+date2+"','"+date1+"') as duration";
									rs = st1.executeQuery(sql1);
									if(rs.next())
									{
										drivtime = rs.getString("duration");
									}
									date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
									//System.out.println("*****    "+date1);
									sql1 = "select DATEDIFF('"+date1+"','"+startdate+"') as days";
									 rs = st1.executeQuery(sql1);
									if(rs.next())
									{
										 day1 = rs.getInt("days")+1;
									}
									String dur = "-";
									String Reason = "Journey End";
									
									int drikm = 0;
									
									 sql1 = " select sum(LegDist) as drikm from db_gps.t_jrmrouteadvanceddetails where advancedtrackid > '"+preid+"' and advancedtrackid <= '"+rst.getInt("advancedtrackid")+"' and advancedrouteid = "+routeid+"";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											drikm = rs.getInt("drikm");
										}
										 kmtogo = 0;
										kmtogo = totkm - rst.getInt("CumDist");
									
									sql1= "Update db_gps.t_intermediatejrmroute set drivingkm = '"+drikm+"',drivingtime='"+drivtime+"',stoptime='-',stopreason='"+Reason+"',cdend = '"+rst.getInt("advancedtrackid")+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
								    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+preid+"' and row = '"+row+"'";
							st1.executeUpdate(sql1);
									
									sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend,cdend) "+
							           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','"+rst.getString("LegTime")+"','"+date1+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
							           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','-','1','"+day1+"','"+Reason+"','"+preid+"','"+prerunhrs+"','"+cdstart+"','"+prend+"','"+rst.getInt("advancedtrackid")+"')";		
									//System.out.println("NO ND" + sql1);
									st1.executeUpdate(sql1);
									
									sql1 = "Update db_gps.t_intermediatejrmroute set cdend = '"+rst.getInt("advancedtrackid")+"' where Tripid = '"+tripid+"' and briefid = '"+briefid
						    		 +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid > "+cdstart+" and advancedtrackid < "+rst.getInt("advancedtrackid")+"";
							
						    st1.executeUpdate(sql1);
									
									sql1 = "Update db_gps.t_jrnyplanning set End = '"+date1+"',Duration = '"+drivtime+"',Destination='"+rst.getString("Placename")+"',LegDistance = '"+drikm+"',TripDist = '"+rst.getInt("CumDist")+"',Kmtogo='"+kmtogo
									 +"',StopDuration='-',StopReason='"+Reason+"'  where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid = '"+preid+"' and Event = 'Driving'";
							st1.executeUpdate(sql1);
									
								}
								else
									if((data2.equals(data1)) || (data2.after(data1) && data2.before(nextdate)))
									{	
										System.out.println("NOhcgvnxbgf ND" + rst.getInt("advancedtrackid"));
										data2 = data1;
										date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
										 drivtime = "";
										System.out.println("date2 " +date2+"   date1  "+date1);
										sql1 = "SELECT TIMEDIFF('"+date2+"','"+date1+"') as duration";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											drivtime = rs.getString("duration");
										}

										//System.out.println("****7777777777dfdxc77runhrs*    "+runhrs);
										sql1 = "SELECT ADDTIME('"+runhrs+"','"+drivtime+"') as duration";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											runhrs = rs.getString("duration");
										}
										
									//	System.out.println("****777777777777runhrs*    "+runhrs);
										date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
										//System.out.println("*****    "+date1);
										sql1 = "select DATEDIFF('"+date1+"','"+startdate+"') as days";
										 rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											 day1 = rs.getInt("days")+1;
										}
										String dur = "";
										String Reason = "";
										
										int hrs = 0;min = 0;
										sql1 = "select Hour('"+runhrs+"') as hrs";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											hrs = rs.getInt("hrs");
										}
										
										 rundiff = "";					
										sql1 = "select TIMEDIFF('10:00:00','"+runhrs+"') as tdiff";
										rs = st1.executeQuery(sql1);
									//	System.out.println("**c    "+sql1);
										if(rs.next())
										{
											rundiff = rs.getString("tdiff");
										}
										
										 sec = 0;
										sql1 = "select TIME_TO_SEC('"+rundiff+"') as sec";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											sec = rs.getInt("sec");
										}
										
									//	System.out.println("***   sec  "+sec);
										min = sec/60;
										//System.out.println("***   min  "+min+"  hrs  "+hrs);
										//System.out.println("***   nd  "+nd+"  cd  "+cd);
										//System.out.println((hrs >= 10) || (hrs < 10 && min <15));
										if((hrs >= 10) || (hrs < 10 && min <15))
										{
											dur = "06:00:00";
											nd = 0;
											cd = 1;
											String dur1 = "";
											String ddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2));
											String ddate1 = ddate+" 23:00:00";
											sql1 = "SELECT TIMEDIFF('"+ddate1+"','"+date2+"') as duration";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												dur1 = rs.getString("duration");
											}
											
											sql1 = "SELECT ADDTIME('"+dur1+"','"+dur+"') as duration";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												dur = rs.getString("duration");
											}
											Reason = "Night Halt";
											runhrs = "00:00:00";
											runhrs1 = "02:00:00";
										}
										else
										if(nd == 1)
										{
											dur = "06:00:00";
											nd = 0;
											cd = 1;
											String dur1 = "";
											String ddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2));
											String ddate1 = ddate+" 23:00:00";
											sql1 = "SELECT TIMEDIFF('"+ddate1+"','"+date2+"') as duration";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												dur1 = rs.getString("duration");
											}
											
											sql1 = "SELECT ADDTIME('"+dur1+"','"+dur+"') as duration";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												dur = rs.getString("duration");
											}
											
											Reason = "Night Halt";
										}
										else
											if(cd == 1 || cd==2)
											{
												if(prevcdstoptime.equals("00:00:00"))
												{
													dur = "01:00:00";	
													
												}
												else
												{
													sql1 = "select SUBTIME('01:00:00','"+prevcdstoptime+"') as enddate";
													rs = st1.executeQuery(sql1);
													if(rs.next())
													{
														dur = rs.getString("enddate");
													}
													 sec2 = 0;min2 = 0;
													sql1 = "select TIME_TO_SEC('"+dur+"') as enddate";
													rs = st1.executeQuery(sql1);
													if(rs.next())
													{
														sec2 = rs.getInt("enddate");
													}
													min2 = sec2/60;
													if(min2 < 15)
													{
														dur = "00:15:00";
													}
													
													prevcdstoptime = "00:00:00";
												}
												
												cd = 1;
												nd = 0;
												Reason = "Rest";
											}
											else
												if(cd == 3)
												{
													dur = "00:45:00";
													cd = 1;
													nd = 0;
													Reason = "Rest";
												}
										
										
										sql1 = "select ADDTIME('"+date2+"','"+dur+"') as enddate";
										 rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											date2 = rs.getString("enddate");
										}				
										
										
										
										 date4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));		
										 nddate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date4+" "+ndstarttime);
										 cal = Calendar.getInstance();
										cal.setTime(nddate1);
										cal.add(Calendar.DATE,1);
										 tomorrowdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
										 nddate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tomorrowdate+" "+ndendtime);
										 dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2);
									//	System.out.println(" nddate1      "+nddate1+"  ***   nddate2  "+nddate2+"    dt  "+dt);
									//	System.out.println("***********************************************************************************************");
										//System.out.println(dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2)));
										
										sec = 0;
										 nightdrivingstart =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate1);
										sql1 = "select TIME_TO_SEC(TIMEDIFF('"+nightdrivingstart+"','"+date2+"')) as sec";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											sec = rs.getInt("sec");
										}
										min = 0;
										min = sec/60;
									//	System.out.println("**  nightdrivingstart  "+nightdrivingstart+"     date2   "+date2);
									//	System.out.println("**  min  "+min+"     sec   "+sec);
										
										if((dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2))) || (min > 0 && min < 15))
										{
											date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate2);
											nd = 0;
											cd = 1;
											runhrs = "00:00:00";
											runhrs1 = "02:00:00";
											Reason = "Night Halt";
										}
										
										System.out.println("     date2   "+date2);
										
										
										String stopdur = "",stopdur1 = "";
										sql1 = "SELECT TIMEDIFF('"+date2+"','"+date1+"') as duration";
									//	System.out.println("****     "+sql1);
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											stopdur = rs.getString("duration");
										}
										//System.out.println("****     "+stopdur);
										//System.out.println("****     "+rst.getString("LegTime"));
										sql1 = "SELECT ADDTIME('"+stopdur+"','"+rst.getString("LegTime")+"') as duration";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											stopdur1 = rs.getString("duration");
										}
										
										int drikm = 0;
										
									   sql1 = " select sum(LegDist) as drikm from db_gps.t_jrmrouteadvanceddetails where advancedtrackid > '"+preid+"' and advancedtrackid <= '"+rst.getInt("advancedtrackid")+"'  and advancedrouteid = "+routeid+"";
										rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											drikm = rs.getInt("drikm");
										}
									   
										 kmtogo = 0;
										kmtogo = totkm - rst.getInt("CumDist");
										
									sql1= "Update db_gps.t_intermediatejrmroute set drivingkm = '"+drikm+"',drivingtime='"+drivtime+"',stoptime='"+stopdur+"',stopreason='"+Reason+"',cdend='"+rst.getInt("advancedtrackid")+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
										    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+preid+"' and row = '"+row+"'";
									st1.executeUpdate(sql1);
										
										sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend,cdend) "+
								           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','"+stopdur1+"','"+date2+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
								           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','"+date2+"','1','"+day1+"','"+Reason+"','"+preid+"','"+prerunhrs+"','"+cdstart+"','"+prend+"','"+rst.getInt("advancedtrackid")+"')";
										//System.out.println("NO ND" + sql1);
										st1.executeUpdate(sql1);
										
										sql1 = "Update db_gps.t_intermediatejrmroute set cdend = '"+rst.getInt("advancedtrackid")+"' where Tripid = '"+tripid+"' and briefid = '"+briefid
									    		 +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid > "+cdstart+" and advancedtrackid < "+rst.getInt("advancedtrackid")+"";
										
									    st1.executeUpdate(sql1);
									    		 
										sql1 = "Update db_gps.t_jrnyplanning set End = '"+date1+"',Duration = '"+drivtime+"',Destination='"+rst.getString("Placename")+"',LegDistance = '"+drikm+"',TripDist = '"+rst.getInt("CumDist")+"',Kmtogo='"+kmtogo
												 +"',StopDuration='"+stopdur+"',StopReason='"+Reason+"'  where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid = '"+preid+"' and Event = 'Driving'";
										st1.executeUpdate(sql1);
										
										/*sql1 = "insert into db_gps.t_jrnyplanning (Tripid,Day,Event,Start,End,Duration,Origin,Destination,LegDistance,TripDist,Kmtogo,trackid,brifid,driverid) values ('"+tripid+"','"+day+"','"+Reason+"','"+date1+"','"+date2+"','"+stopdur+"','"+
													rst.getString("Placename")+"','"+rst.getString("Placename")+"','0','"+rst.getInt("CumDist")+"','"+kmtogo+"','"+rst.getInt("advancedtrackid")+"','"+briefid+"','"+driverid+"')"; 
										st1.executeUpdate(sql1);	*/
										
										if(rst.isLast())
										{
											//System.out.println("****     last record");
										}
										else
										{
										date1 = date2;
										//System.out.println("****  drivstartdate  "+date1);
										sql1 = "select DATEDIFF('"+date1+"','"+startdate+"') as days";
										 rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											 day1 = rs.getInt("days")+1;
										}
										
										if(cd == 1 || cd == 2)
										{
											drivtime = "04:00:00";
											sql1 = "SELECT ADDTIME('"+runhrs+"','"+drivtime+"') as duration";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												runhrs1 = rs.getString("duration");
											}
											
											 hrs = 0;
											 min = 0;
											sql1 = "select Hour('"+runhrs1+"') as hrs";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												hrs = rs.getInt("hrs");
											}
										//	System.out.println("**c    "+hrs);
											if(hrs >= 10)
											{
												sql1 = "select TIMEDIFF('10:00:00','"+runhrs+"') as tdiff";
												rs = st1.executeQuery(sql1);
												//System.out.println("**c    "+sql1);
												if(rs.next())
												{
													drivtime = rs.getString("tdiff");
												}
												//System.out.println("**c    "+drivtime);
											}
											else
											{
												drivtime = "04:00:00";
											}
											
										}
										else
										{
											drivtime = "00:30:00";
											
											sql1 = "SELECT ADDTIME('"+runhrs+"','"+drivtime+"') as duration";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												runhrs1 = rs.getString("duration");
											}
											
											hrs = 0;
											min = 0;
											sql1 = "select Hour('"+runhrs1+"') as hrs";
											rs = st1.executeQuery(sql1);
											if(rs.next())
											{
												hrs = rs.getInt("hrs");
											}
										//	System.out.println("**c    "+hrs);
											if(hrs >= 10)
											{
												sql1 = "select TIMEDIFF('10:00:00','"+runhrs+"') as tdiff";
												rs = st1.executeQuery(sql1);
											//	System.out.println("**c    "+sql1);
												if(rs.next())
												{
													drivtime = rs.getString("tdiff");
												}
												//System.out.println("**c    "+drivtime);
												
											}
											else
											{
												drivtime = "00:30:00";
											}
										//	System.out.println("**c    "+hrs);
											
										}
										
										
										sql1 = "select ADDTIME('"+date1+"','"+drivtime+"') as enddate";
										 rs = st1.executeQuery(sql1);
											//System.out.println("**c    "+sql1);
										if(rs.next())
										{
											date2 = rs.getString("enddate");
										}	
										//System.out.println("**drivenddate      "+date2);
										 date4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));		
										 nddate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date4+" "+ndstarttime);
										 cal = Calendar.getInstance();
										cal.setTime(nddate1);
										cal.add(Calendar.DATE,1);
										 tomorrowdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
										 nddate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tomorrowdate+" "+ndendtime);
										 dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2);
									//	System.out.println(" ************nddate1      "+nddate1+"  ***   nddate2  "+nddate2+"    dt  "+dt);
										if(dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2)))
										{
											date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate1);
											nd = 1;
											cd = 1;
											runhrs = "00:00:00";
											runhrs1 = "02:00:00";
										}
										
										
									//	System.out.println("date2   "+date2);
										prerunhrs= runhrs;
										precd = cd+"";
										prend = nd+"";
									//	System.out.println("**drivenddate after nd detection     "+date2);
										preid = rst.getInt("advancedtrackid");
										
										cdstart = preid;
										
										System.out.println("cdstart    "+cdstart);
										row = 2;
										
										sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend) "+
								           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','00:00:00','"+date1+"','0','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
								           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','"+date1+"','"+row+"','"+day1+"','Driving','"+preid+"','"+prerunhrs+"','"+cdstart+"','"+prend+"')";
										//System.out.println("NO ND" + sql1);
										st1.executeUpdate(sql1);	
										
										sql1 = "insert into db_gps.t_jrnyplanning (Tripid,Day,Event,Start,Origin,trackid,brifid,driverid) values ('"+tripid+"','"+day1+"','Driving','"+date1+"','"+rst.getString("Placename")+"','"+rst.getInt("advancedtrackid")+"','"+briefid+"','"+driverid+"')"; 
										st1.executeUpdate(sql1);	
										
									//	System.out.println("**end   date1    "+date1);
									//	System.out.println("**end  date2    "+date2);
										
										currentdate = date1;
										}
									}
									else
									{
										sql1 = "select DATEDIFF('"+currentdate+"','"+startdate+"') as days";
										 rs = st1.executeQuery(sql1);
										if(rs.next())
										{
											 day1 = rs.getInt("days")+1;
										}
										
										//System.out.println("NO ND "+rst.getInt("LegTime"));
										
										sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend) "+
								           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','"+rst.getString("LegTime")+"','"+currentdate+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
								           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','-','1','"+day1+"','Driving','"+preid+"','"+prerunhrs+"','"+cdstart+"','"+prend+"')";
									
										//System.out.println("NO ND" + sql1);
										st1.executeUpdate(sql1);
										//currentdate = currentdate;
									}
							}
							
					out.print("successful");       
	}
}
catch(Exception e)
{
	System.out.println("Exception    "+e);
}
finally
{
	st.close();
	con1.close();
}

%>
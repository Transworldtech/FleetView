<%@ include file="Connections/conn.jsp" %>
<%@ page import="java.util.*" %>

<%!
Connection con1;
Statement st,st1,st2;
%>
<% 
try 
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con1.createStatement();
	st1=con1.createStatement();
	st2=con1.createStatement();
	ResultSet rst=null;
	String sql="",sql1="";
	
	String tripid = request.getParameter("tripid");
	String briefid = request.getParameter("briefid");
	String driverid=  request.getParameter("driverid");
	String startdate = request.getParameter("date1");
	int routeid = Integer.parseInt(request.getParameter("routeid"));
	//System.out.println("tripid   "+tripid+"    briefid    "+briefid+"   driverid   "+driverid+"    startdate   "+startdate+"  routeid  "+routeid);
	// routeid = 1;
	// System.out.println("NO ND  startdate " +startdate);
	startdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(startdate));
	//startdate = "2012-10-24 16:48:14";
	String currentdate =startdate,date1=startdate,date2=startdate;
	String prend = "",precd = "",prerunhrs = "";
	//tripid = "DDDD747474725";briefid = "67481";driverid=  "91038476";	
	String totdur = "00:00:00",startlocation = "";
	int preid = 1,row = 1,hrs = 0,min = 0;
	String ndstarttime = "23:00:00";
	String ndendtime = "05:00:00",runhrs = "00:00:00",runhrs1 = "00:00:00";
	int k=1,day=0,nd=0,cd=1;
	sql = "delete from db_gps.t_intermediatejrmroute where Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' ";
	st.executeUpdate(sql);
	
	sql = "delete from db_gps.t_jrnyplanning where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' ";
	st.executeUpdate(sql);
	
//	System.out.println("NO ND  " +sql);
	int totkm = 0;
	
	sql = "select sum(LegDist) as totdist from db_gps.t_jrmrouteadvanceddetails where advancedrouteid = '"+routeid+"' ";
	rst = st.executeQuery(sql);
	if(rst.next())
	{
		totkm = rst.getInt("totdist");
	}
//	System.out.println("totkm  " +totkm);
	sql = "select *,addtime('"+startdate+"',timediff(Cumtime,'00:00:00') ) ctime  from db_gps.t_jrmrouteadvanceddetails where advancedrouteid = '"+routeid+"' order by advancedtrackid ";
	rst = st.executeQuery(sql);
	while(rst.next())
	{
		sql1 = "select ADDTIME('"+currentdate+"','"+rst.getString("LegTime")+"') as enddate";
		ResultSet rs = st1.executeQuery(sql1);
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
		
		//System.out.println("start data1  " +data1);
		//System.out.println("satrt data2  " +data2);
	//	System.out.println("start nextdate  " +nextdate);
	//	System.out.println("stop condition 1   "+(data2.equals(data1)));
	//	System.out.println("stop condition 2   "+(data2.after(data1) && data2.before(nextdate)));
	//	System.out.println("stop condition 1   "+(date2.equals(currentdate)));
	//	System.out.println("trackid   "+rst.getString("advancedtrackid"));
		if(k==1)
		{
		//	System.out.println("NO ND  1st record");
			date1 = rst.getString("ctime");
		//	System.out.println("NO ND  " + date1);
			sql1 = "select DATEDIFF('"+date1+"','"+startdate+"') as days";
			 rs = st1.executeQuery(sql1);
			if(rs.next())
			{
				 day = rs.getInt("days")+1;
			}
			sql1 = "select ADDTIME('"+date1+"','04:00:00') as enddate";
			 rs = st1.executeQuery(sql1);
			if(rs.next())
			{
				date2 = rs.getString("enddate");
			}		
			
			prerunhrs = "00:00:00";
			precd = "1";
			prend = "0";
			runhrs = "00:00:00";
			runhrs1 = "00:00:00";
			
			String date4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));		
			java.util.Date nddate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date4+" "+ndstarttime);
			Calendar cal = Calendar.getInstance();
			cal.setTime(nddate1);
			cal.add(Calendar.DATE,1);
			String tomorrowdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
			java.util.Date nddate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tomorrowdate+" "+ndendtime);
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2);
		//	System.out.println(" nddate1      "+nddate1+"  ***   nddate2  "+nddate2+"    dt  "+dt);
		  		int sec = 0;
				String nightdrivingstart =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate1);
				sql1 = "select TIME_TO_SEC(TIMEDIFF('"+nightdrivingstart+"','"+date2+"')) as sec";
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					sec = rs.getInt("sec");
				}
				min = 0;
				min = sec/60;
				
			if((dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2))))
			{
				date2 = date4+" "+ndstarttime;
				nd = 1;
				cd = 1;
				//runhrs = "00:00:00";
				//runhrs1 = "00:00:00";
			}	
			
			
			preid = rst.getInt("advancedtrackid");
			row = 1;
		//	System.out.println("NO ND" + date2);
		//	System.out.println("NO ND" + date1);
		//	System.out.println("NO ND" + rst.getInt("advancedtrackid"));
			sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend) "+
			           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','00:00:00','"+date1+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
			           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','"+date1+"','1','"+day+"','Driving','"+preid+"','"+prerunhrs+"','"+preid+"','"+prend+"')";
		//	System.out.println("NO ND" + sql1);
			st1.executeUpdate(sql1);	
			
			sql1 = "insert into db_gps.t_jrnyplanning (Tripid,Day,Event,Start,Origin,trackid,brifid,driverid) values ('"+tripid+"','"+day+"','Driving','"+date1+"','"+rst.getString("Placename")+"','"+rst.getInt("advancedtrackid")+"','"+briefid+"','"+driverid+"')"; 
			st1.executeUpdate(sql1);	
			currentdate = date1;
			k++;
		}
		else
			if(rst.isLast())
			{
				date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
				String drivtime = "";
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
					 day = rs.getInt("days")+1;
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
					int kmtogo = 0;
					kmtogo = totkm - rst.getInt("CumDist");
				
				sql1= "Update db_gps.t_intermediatejrmroute set drivingkm = '"+drikm+"',drivingtime='"+drivtime+"',stoptime='-',stopreason='"+Reason+"',cdend = '"+rst.getInt("advancedtrackid")+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
			    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+preid+"' and row = '"+row+"'";
		st1.executeUpdate(sql1);
				
				sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend,cdend) "+
		           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','"+rst.getString("LegTime")+"','"+date1+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
		           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','-','1','"+day+"','"+Reason+"','"+preid+"','"+prerunhrs+"','"+preid+"','"+prend+"','"+rst.getInt("advancedtrackid")+"')";		
				//System.out.println("NO ND" + sql1);
				st1.executeUpdate(sql1);
				
				sql1 = "Update db_gps.t_intermediatejrmroute set cdend = '"+rst.getInt("advancedtrackid")+"' where Tripid = '"+tripid+"' and briefid = '"+briefid
	    		 +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid > "+preid+" and advancedtrackid < "+rst.getInt("advancedtrackid")+"";
		
	    st1.executeUpdate(sql1);
				
				sql1 = "Update db_gps.t_jrnyplanning set End = '"+date1+"',Duration = '"+drivtime+"',Destination='"+rst.getString("Placename")+"',LegDistance = '"+drikm+"',TripDist = '"+rst.getInt("CumDist")+"',Kmtogo='"+kmtogo
				 +"',StopDuration='-',StopReason='"+Reason+"'  where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and trackid = '"+preid+"' and Event = 'Driving'";
		st1.executeUpdate(sql1);
				
			}
			else
			if((data2.equals(data1)) || (data2.after(data1) && data2.before(nextdate)))
			{	
				//System.out.println("NOhcgvnxbgf ND" + rst.getInt("advancedtrackid"));
				data2 = data1;
				date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
				String drivtime = "";
				System.out.println("date2 " +date2+"   date1  "+date1);
				sql1 = "SELECT TIMEDIFF('"+date2+"','"+date1+"') as duration";
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					drivtime = rs.getString("duration");
				}

				System.out.println("****7777777777dfdxc77runhrs*    "+runhrs);
				sql1 = "SELECT ADDTIME('"+runhrs+"','"+drivtime+"') as duration";
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					runhrs = rs.getString("duration");
				}
				
				System.out.println("****777777777777runhrs*    "+runhrs);
				date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(data2);
				//System.out.println("*****    "+date1);
				sql1 = "select DATEDIFF('"+date1+"','"+startdate+"') as days";
				 rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					 day = rs.getInt("days")+1;
				}
				String dur = "";
				String Reason = "";
				
				hrs = 0;min = 0;
				sql1 = "select Hour('"+runhrs+"') as hrs";
				rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					hrs = rs.getInt("hrs");
				}
				
				String rundiff = "";					
				sql1 = "select TIMEDIFF('10:00:00','"+runhrs+"') as tdiff";
				rs = st1.executeQuery(sql1);
			//	System.out.println("**c    "+sql1);
				if(rs.next())
				{
					rundiff = rs.getString("tdiff");
				}
				
				int sec = 0;
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
			//	System.out.println((hrs >= 10) || (hrs < 10 && min <15));
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
					runhrs = "00:00:00";
					runhrs1 = "02:00:00";
				}
				else
					if(cd == 1 || cd==2)
					{
						dur = "01:00:00";
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
				
			//	System.out.println("***   date2  "+date2);
				
				String date4 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));		
				java.util.Date nddate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date4+" "+ndstarttime);
				Calendar cal = Calendar.getInstance();
				cal.setTime(nddate1);
				cal.add(Calendar.DATE,1);
				String tomorrowdate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
				java.util.Date nddate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(tomorrowdate+" "+ndendtime);
				java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2);
			//	System.out.println(" nddate1      "+nddate1+"  ***   nddate2  "+nddate2+"    dt  "+dt);
			//	System.out.println("***********************************************************************************************");
			//	System.out.println(dt==nddate1 || (dt.after(nddate1) && dt.before(nddate2)));
				
				sec = 0;
				String nightdrivingstart =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nddate1);
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
				
			//	System.out.println("     date2   "+date2);
				
				
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
			   
				int kmtogo = 0;
				kmtogo = totkm - rst.getInt("CumDist");
				
			sql1= "Update db_gps.t_intermediatejrmroute set drivingkm = '"+drikm+"',drivingtime='"+drivtime+"',stoptime='"+stopdur+"',stopreason='"+Reason+"',cdend='"+rst.getInt("advancedtrackid")+"'  where  Tripid = '"+tripid+"' and briefid = '"+briefid
				    +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid = '"+preid+"' and row = '"+row+"'";
			st1.executeUpdate(sql1);
				
				sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend,cdend) "+
		           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','"+stopdur1+"','"+date2+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
		           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','"+date2+"','1','"+day+"','"+Reason+"','"+preid+"','"+prerunhrs+"','"+preid+"','"+prend+"','"+rst.getInt("advancedtrackid")+"')";
				//System.out.println("NO ND" + sql1);
				st1.executeUpdate(sql1);
				
				sql1 = "Update db_gps.t_intermediatejrmroute set cdend = '"+rst.getInt("advancedtrackid")+"' where Tripid = '"+tripid+"' and briefid = '"+briefid
			    		 +"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and advancedtrackid > "+preid+" and advancedtrackid < "+rst.getInt("advancedtrackid")+"";
				
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
					 day = rs.getInt("days")+1;
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
				//	runhrs = "00:00:00";
				//	runhrs1 = "02:00:00";
				}
				
				
			//	System.out.println("date2   "+date2);
				prerunhrs= runhrs;
				precd = cd+"";
				prend = nd+"";
			//	System.out.println("**drivenddate after nd detection     "+date2);
				preid = rst.getInt("advancedtrackid");
				row = 2;
				
				sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend) "+
		           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','00:00:00','"+date1+"','0','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
		           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','"+date1+"','"+row+"','"+day+"','Driving','"+preid+"','"+prerunhrs+"','"+preid+"','"+prend+"')";
				//System.out.println("NO ND" + sql1);
				st1.executeUpdate(sql1);	
				
				sql1 = "insert into db_gps.t_jrnyplanning (Tripid,Day,Event,Start,Origin,trackid,brifid,driverid) values ('"+tripid+"','"+day+"','Driving','"+date1+"','"+rst.getString("Placename")+"','"+rst.getInt("advancedtrackid")+"','"+briefid+"','"+driverid+"')"; 
				st1.executeUpdate(sql1);	
				
				//System.out.println("**end   date1    "+date1);
				//System.out.println("**end  date2    "+date2);
				
				currentdate = date1;
				}
			}
			else
			{
				sql1 = "select DATEDIFF('"+currentdate+"','"+startdate+"') as days";
				 rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					 day = rs.getInt("days")+1;
				}
				
				//System.out.println("NO ND "+rst.getInt("LegTime"));
				
				sql1 = "insert into db_gps.t_intermediatejrmroute  (advancedrouteid,advancedtrackid,LegTime,CumTime,LegDist,CumDist,latitude,longitude,Placename,Statename,jrmcomment,jrmtype,zone,Tripid,briefid,driverid,drivingkm,drivingtime,stoptime,stopreason,calculateddate,Row,Day,Event,preid,prerunhr,cdstart,prend) "+
		           " values ('"+routeid+"','"+rst.getInt("advancedtrackid")+"','"+rst.getString("LegTime")+"','"+currentdate+"','"+rst.getInt("LegDist")+"','"+rst.getInt("CumDist")+"','"+rst.getString("latitude")+"','"+rst.getString("longitude")+"','"+rst.getString("Placename")+"','"+rst.getString("Statename")+"','"+rst.getString("jrmcomment")+"','"+
		           rst.getString("jrmtype")+"','"+rst.getString("zone")+"','"+tripid+"','"+briefid+"','"+driverid+"','0','-','-','Reason','-','1','"+day+"','Driving','"+preid+"','"+prerunhrs+"','"+preid+"','"+prend+"')";
			
				//System.out.println("NO ND" + sql1);
				st1.executeUpdate(sql1);
				//currentdate = currentdate;
			}
	}
	
	//System.out.println("jhsdb         "+startdate);
	String senddate = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdate));
	
	response.sendRedirect("journeyplanning.jsp?driverid="+driverid+"&briefid="+briefid+"&date1="+senddate);
	
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
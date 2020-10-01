<%@ include file="Connections/conndriver.jsp" %>
<%!
Connection con1;
%>
<% 
String rid=request.getParameter("rid");
String comment=request.getParameter("debriefingcomment");
String deBrifTrinerName = request.getParameter("deBrifTrinerName");
String specialinst=""; 
String gpsData = request.getParameter("gpsData");
String transitDelay = request.getParameter("tranDelay");
String shortages = request.getParameter("shortages");
String routeDeviation = request.getParameter("rtDeviation");
String shortageComnt = "";
String rootDeviationComnt = "";
String getTransdelComnt="";
String gpsdataComnt = "";
String driverId = (String) request.getParameter("drvrid");
String driverName = (String) request.getParameter("drvrname");
String briefId = "";
String deBrifMobNo = (String) request.getParameter("deBrifMobNo");
String debrifdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

try {
    
    try
		{
				specialinst=session.getAttribute("getspclinst").toString();
   	     	specialinst=specialinst.replace("'", "");
		}
		catch(Exception e)
		{
			specialinst="NA";
		}
    
		try
		{
			shortageComnt=session.getAttribute("getshortages").toString();
       	shortageComnt = shortageComnt.replace("'", "");
       
		}
		catch(Exception e)
		{
			shortageComnt="NA";
		}

    
		try
		{
			rootDeviationComnt=session.getAttribute("getrtDeviation").toString();
        	rootDeviationComnt = rootDeviationComnt.replace("'", "");
    
		}
		catch(Exception e)
		{
			rootDeviationComnt="NA";
		}

    
       
		try
		{
			gpsdataComnt=session.getAttribute("getGpsdata").toString();
   		gpsdataComnt = gpsdataComnt.replace("'", "");
    
		}
		catch(Exception e)
		{
			gpsdataComnt="NA";
		}

		try
		{
			getTransdelComnt=session.getAttribute("getTransdel").toString();
   		getTransdelComnt = getTransdelComnt.replace("'", "");
	    
		}
		catch(Exception e)
		{
			getTransdelComnt="NA";
		}

    
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		Statement stquery=con1.createStatement();
		String sqlChkData = "select * from t_driverbriefingquest where DriverId = '"+driverId+"' and BriefingStatus = 'Incomplete' ";
		ResultSet rs1 = stmt1.executeQuery(sqlChkData);
		if(rs1.next()){
    	String sql1="update t_driverbriefingquest set DebriefingComment='"+comment+"', BriefingStatus='Completed' , DebriefingTrainer ='"+deBrifTrinerName+"' , DeBriefSpInst ='"+specialinst+"', GPSDataDeBr = '"+gpsData+"' , TrasitDelay = '"+transitDelay+"', Shortages = '"+shortages+"', RouteDeviation = '"+routeDeviation+"',ShortageComnt = '"+shortageComnt+"', RouteDeviationComnt ='"+rootDeviationComnt+"', gpsDataComnt = '"+gpsdataComnt+"', gpsDataComnt = '"+gpsdataComnt+"', TransDelayCom='"+getTransdelComnt+"',DeBriefDate='"+debrifdate+"'  where SrNo='"+rid+"' ";
    	
    	/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql1.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		/*****************************/
		stmt1.executeUpdate(sql1);

		}
		else
		{
		    java.util.Date tdydte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			String tdydte1=formatter.format(tdydte); 
        
			String sqlIns="Insert into t_driverbriefingquest ( EntDateTime, DriverId,DriverName,DrvMobNo, DebriefingComment, BriefingStatus, DebriefingTrainer, DeBriefSpInst,GPSDataDeBr, TrasitDelay, Shortages, RouteDeviation, ShortageComnt, RouteDeviationComnt, gpsDataComnt,TransDelayCom,DeBriefDate) values ('"+tdydte1+"','"+driverId+"','"+driverName+"','"+deBrifMobNo+"','"+comment+"', 'Completed', '"+deBrifTrinerName+"', '"+specialinst+"', '"+gpsData+"', '"+transitDelay+"', '"+shortages+"', '"+routeDeviation+"', '"+shortageComnt+"', '"+rootDeviationComnt+"', '"+gpsdataComnt+"','"+getTransdelComnt+"','"+debrifdate+"')";
			/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd1=sqlIns.replace("'","#");
			abcd1=abcd1.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
			/*****************************/
			stmt1.executeUpdate(sqlIns);
		}

	//String sql1="update t_driverbriefingquest set DebriefingComment='"+comment+"', BriefingStatus='Completed' , DebriefingTrainer ='"+deBrifTrinerName+"' , DeBriefSpInst ='"+specialinst+"', GPSDataDeBr = '"+gpsData+"'  where SrNo='"+rid+"' "; 
 	String sql2 = "select * from t_driverbriefingquest where DriverId = "+driverId+" and BriefingStatus = 'Completed' order by EntDateTime desc limit 0,1 ";
 	rs1 = stmt1.executeQuery(sql2);
	if(rs1.next()){
 	briefId = rs1.getString("SrNo");
 
}



 con1.close();

response.sendRedirect("driver_debriefing.jsp?inserted=successfull&briefId="+briefId+"");
return;

} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
 con1.close();
}
%>

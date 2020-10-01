<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();
Statement stquery=con1.createStatement();
ResultSet rs1=null;
String sql1="";

String vehfam="", vehfamobs="", routefam="", routefamobs="", menphycond="", menphycondobs="", jrmbrief="", jrmbriefobs="", drivresp="", specialinst="";

String drivname="", drivid="",drLicnRd="" , drvLicnNoCmnt = "",GpsDataCmnt="";

String trinerName="", drvMobNo="", drvLicnNo="";

vehfam=request.getParameter("vehfam");
//vehfamobs=request.getParameter("vehfamobs");
routefam=request.getParameter("routefam");
//routefamobs=request.getParameter("routefamobs");
menphycond=request.getParameter("mentphycond");
//menphycondobs=request.getParameter("mentphycondobs");
jrmbrief=request.getParameter("jrmbrief");
//jrmbriefobs=request.getParameter("jrmbriefobs");
//drivresp=request.getParameter("drivresobs");
//specialinst=request.getParameter("specinst");
drLicnRd = request.getParameter("drLicnRd");

drivname=request.getParameter("drvrname");
drivid=request.getParameter("drvrid");

trinerName=request.getParameter("trinerName");
drvMobNo=request.getParameter("drvMobNo");
drvLicnNo=request.getParameter("drvLicNo");
String msg = "";String briefId = "";String gpsData="";
String sql2 = "";
ResultSet rs = null;

try
{
	vehfamobs=session.getAttribute("getvehfamobs").toString();
        vehfamobs = vehfamobs.replace("'", "");
}
catch(Exception e)
{
	vehfamobs="NA";
}

try
{
	routefamobs=session.getAttribute("getroutefamobs").toString();
   routefamobs = routefamobs.replace("'", "");
}
catch(Exception e)
{
	routefamobs="NA";
}

try
{
	menphycondobs=session.getAttribute("getmentphycondcmnt").toString();
        menphycondobs = menphycondobs.replace("'", "");
}
catch(Exception e)
{
	menphycondobs="NA";
}

try
{
	jrmbriefobs=session.getAttribute("getjrmbrief").toString();
        jrmbriefobs = jrmbriefobs.replace("'", "");
}
catch(Exception e)
{
	jrmbriefobs="NA";
}

try
{
	drivresp=session.getAttribute("getdrivresp").toString();
   drivresp = drivresp.replace("'", "");
}
catch(Exception e)
{
	drivresp="NA";
}

try
{
	specialinst=session.getAttribute("getspclinst").toString();
   specialinst= specialinst.replace("'", "");
       
}
catch(Exception e)
{
	specialinst="NA";
}


try
{
	drvLicnNoCmnt=session.getAttribute("getdrLicnRd").toString();
   drvLicnNoCmnt= drvLicnNoCmnt.replace("'", "");
       
}
catch(Exception e)
{
	drvLicnNoCmnt="NA";
        
}

try
{
	GpsDataCmnt=session.getAttribute("getGpsdata").toString();
   GpsDataCmnt= GpsDataCmnt.replace("'", "");
       
}
catch(Exception e)
{
	GpsDataCmnt="NA";
        
}

       
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String tdydte1=formatter.format(tdydte);
     

sql1="insert into t_driverbriefingquest (EntDateTime, DriverId, VehFamiliare, DriverName, VehFamiliareObs, RouteFamiliare, RouteFamiliareObs, MentalPhysCond, MentalPhysCondObs, JRMBriefed, JRMBriefedObs, DriverRespObs, SpecialInst,DrvLicNo, DrvMobNo,BriefingTrainer,GPSDataBr,drvLicCmnt,GpsDataComntbrief) values ('"+tdydte1+"', '"+drivid+"', '"+vehfam+"', '"+drivname+"', '"+vehfamobs+"', '"+routefam+"', '"+routefamobs+"', '"+menphycond+"', '"+menphycondobs+"', '"+jrmbrief+"', '"+jrmbriefobs+"', '"+drivresp+"', '"+specialinst+"','"+drvLicnNo+"','"+drvMobNo+"','"+trinerName+"','"+gpsData+"','"+drvLicnNoCmnt+"','"+GpsDataCmnt+"')";
/*Query to insert query in db_gps.t_sqlquery table*/
String abcd=sql1.replace("'","#");
abcd=abcd.replace(",","$");
stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
/*****************************/
stmt1.executeUpdate(sql1);


 sql2 = "select * from t_driverbriefingquest where DriverId = "+drivid+" and BriefingStatus = 'incomplete' ";
 /*Query to insert query in db_gps.t_sqlquery table*/
 String abcd1=sql2.replace("'","#");
 abcd1=abcd1.replace(",","$");
 stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
 /*****************************/
 
 rs = stmt1.executeQuery(sql2);
if(rs.next()){
 briefId = rs.getString("SrNo");
}


/* ****************Putting sessions to nil**************************************** */

session.setAttribute("getvehfamobs","");
session.setAttribute("getroutefamobs","");
session.setAttribute("getmentphycondcmnt","");
session.setAttribute("getjrmbrief","");
session.setAttribute("getdrivresp","");
session.setAttribute("getspclinst","");
session.setAttribute("getdrLicnRd","");

/* ******************************************************************************* */
 con1.close();

response.sendRedirect("driver_briefing.jsp?briefId="+briefId+"&inserted=successfull;");
return;

} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
 con1.close();
}
%>

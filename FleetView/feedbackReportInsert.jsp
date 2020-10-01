   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ include file="Connections/conn.jsp" %>
<html><body>
<%!
Connection con1;
%>
<%
String showMsg="";
Statement st=null;
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con1.createStatement();
	
}
catch(Exception e)
{
	System.out.println("Exception DB Connection---->>"+e);
}
%>
<%
String incidentId=request.getParameter("incidentId");

String drvid=request.getParameter("element_1");//Driver ID
System.out.println("Driver ID--"+drvid);

String condofveh=request.getParameter("element_14_1");//Condition of Vehicle
String driver=request.getParameter("element_14_2");//driver
String journey=request.getParameter("element_14_3");//journeuy
String process=request.getParameter("element_14_4");//process
String all4=request.getParameter("element_14_5");//all4
String other1=request.getParameter("element_14_6");//other
System.out.println("\nCondition of Vehicle-->"+condofveh+"\ndriver-->"+driver+"\njourneuy-->"+journey+"\nprocess-->"+process+"\nall4-->"+all4+"\nother1-->"+other1);

String drvtrain=request.getParameter("element_15_1");//drv train
String drvmedical=request.getParameter("element_15_2");//Driver medical verification
String drvcounseling=request.getParameter("element_15_3");//Driver counseling
String workhrs=request.getParameter("element_15_4");//Working hours
String restloc=request.getParameter("element_15_5");//Resting locations
String mentalstress=request.getParameter("element_15_6");//Mental stress
String phystress=request.getParameter("element_15_7");//Physical stress
String other2=request.getParameter("element_15_8");//Other
System.out.println("\ndrv train-->"+drvtrain+"\nDriver medical verification-->"+drvmedical+"\nDriver counseling-->"+drvcounseling+"\nWorking hours-->"+workhrs+"\nResting locations-->"+restloc+"\nMental stress-->"+mentalstress+"\nPhysical stress-->"+phystress+"\nother2-->"+other2);

String concernDrvMgmt=request.getParameter("element_4").replace("'", "");//Is there any concern in our driver Management?
System.out.println("\nIs there any concern in our driver Management-->"+concernDrvMgmt);
		
String maintainance=request.getParameter("element_16_1");//Maintenance
String loadfactor=request.getParameter("element_16_2");//Load Factor
String other3=request.getParameter("element_16_3");//Other
System.out.println("\nMaintenance-->"+maintainance+"\nLoad Factor-->"+loadfactor+"\nother3-->"+other3);

String concernVehMgmt=request.getParameter("element_5").replace("'", "");//How Do We address our Concern for Vehicle Management?
System.out.println("\nConcern for Vehicle Management-->"+concernVehMgmt);
		
String drvhrs=request.getParameter("element_17_1");//Driving hours
String drvrestrict=request.getParameter("element_17_2");//Driving restriction
String recomendRoute=request.getParameter("element_17_3");//Recommended routes
String speed=request.getParameter("element_17_4");//Speed
String other4=request.getParameter("element_17_5");//other
System.out.println("\nDriving hours-->"+drvhrs+"\nDriving restriction-->"+drvrestrict+"\nRecommended routes-->"+recomendRoute+"\nspeed-->"+speed+"\nother4-->"+other4);

String concernJourneyMgmt=request.getParameter("element_6").replace("'", "");//How Do We address our Concern for Journey Management *
System.out.println("\nConcern for Journey Management--->"+concernJourneyMgmt);

String authorityHarassment=request.getParameter("element_18_1");//Harassment by authorities
String rdRage=request.getParameter("element_18_2");//Road rage
String hugeTraffic=request.getParameter("element_18_3");//Huge traffic
String disRule=request.getParameter("element_18_4");//Disobedience to rules
String other5=request.getParameter("element_18_5");//Other:
System.out.println("\nHarassment by authorities-->"+authorityHarassment+"\nRoad rage-->"+rdRage+"\nHuge traffic-->"+hugeTraffic+"\nDisobedience to rules-->"+disRule+"\nother5-->"+other5);
	
String concernEnv=request.getParameter("element_7").replace("'", "");//How Do We address our Concern for Environment? * 
String cleanerTrck=request.getParameter("element_8").replace("'", "");//Do We require Cleaner in the Truck? * 
String castrolDisturbingPolicies=request.getParameter("element_9").replace("'", "");//What are the Castrol Policies which are most disturbing and troubling? *
String changeInCastrolPolicies=request.getParameter("element_10").replace("'", "");//What are the changes you would like to see in Castrol Policies? *
String nameEmail=request.getParameter("element_11").replace("'", "");//Name & Email Address Trainer/Counselor *
System.out.println("\n\n\n"+concernEnv+"************"+cleanerTrck+"************"+castrolDisturbingPolicies+"************"+changeInCastrolPolicies+"************"+nameEmail);
%>
<%
try
{
	String sql1="insert into db_gps.t_incidentFeedback "+ 
	"(incidentId,VehCondn,Driver,Journey,Process,  AllFour,OtherCauses,Maintenance,LdFactor,VehMgmtOthers, "+
		"VehicleMgmtSuggestions,DrvTraining,DrvMedicalVerification,DrvCounselling,WorkHours,  RestLoc,MentalStress,PhyStress,DrvMgmtOthers,DrvMgmtSuggestions, "+
		"DrivingHours,DrvRestrictions,RecommRoutes,speed,JrnyMgmtOthers, "+
		"JrnyMgmtSuggestions,Harassment,RoadRage,HugeTraffic,DisobedienceOfRules,  EnvMgmtOthers,EnvMgmtSuggestions,NeedCleaner,MngWithoutCleaner,DisturbingPolicies, "+
		"ChangePolicies,ExtraMgmtSuggestions,Driverid,EntBy) "+
	"values "+
	"('"+incidentId+"','"+condofveh+"','"+driver+"','"+journey+"','"+process+"'  ,'"+all4+"','"+other1+"','"+maintainance+"','"+loadfactor+"','"+other3+"', "+
	"'"+concernVehMgmt+"','"+drvtrain+"','"+drvmedical+"','"+drvcounseling+"','"+workhrs+"',  '"+restloc+"','"+mentalstress+"','"+phystress+"','"+other2+"','"+concernDrvMgmt+"', "+
	"'"+drvhrs+"','"+drvrestrict+"','"+recomendRoute+"','"+speed+"', "+
	"'"+other4+"','"+concernJourneyMgmt+"','"+authorityHarassment+"','"+rdRage+"','"+hugeTraffic+"',  '"+disRule+"','"+other5+"','"+concernEnv+"','"+cleanerTrck+"','-',  "+
	"'"+castrolDisturbingPolicies+"','"+changeInCastrolPolicies+"','"+nameEmail+"','"+drvid+"','"+session.getAttribute("mainuser").toString()+"') ";
	
	System.out.println(sql1);
	st.executeUpdate(sql1);
	%>
	<script type="text/javascript">
	alert("Thank You for your Feedback! \nResponse Recorded Successfully");
	</script>
	<%
}
catch(Exception e)
{
	System.out.println("DB Insert Exception Incident Feedback------>>"+e);
	%>
	<script type="text/javascript">
	alert("Please Try Again!");
	</script>
	<%
}
%>
<%
con1.close();
%>
</body>
<script type="text/javascript">
window.close();
</script>
</html>

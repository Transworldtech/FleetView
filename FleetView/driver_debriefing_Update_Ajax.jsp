
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;

String DriveId=request.getParameter("DriveId");
System.out.println("Driver Id"+DriveId);
String TripId=request.getParameter("TripId");
System.out.println("TripId"+TripId);

//String debriefid=request.getParameter("debriefid");


String ChkAdh=request.getParameter("ChkAdh");
System.out.println("ChkAdh"+ChkAdh);
String ChkAdhJ=request.getParameter("ChkAdhJ");
System.out.println("ChkAdhj"+ChkAdhJ);
String reason1=request.getParameter("reason1");
System.out.println("Reason 1"+reason1);
String reason2=request.getParameter("reason2");
System.out.println("Reason 2"+reason2);

String NearMiss=request.getParameter("NearMiss");
System.out.println("NearMiss"+NearMiss);
String NearMissD=request.getParameter("NearMissD");
System.out.println("NearMissD"+NearMissD);
String RouteCause=request.getParameter("RouteCause");
System.out.println("RouteCause"+RouteCause);
String prevention=request.getParameter("prevention");
System.out.println("prevention"+prevention);
String jrmFeedBack=request.getParameter("jrmFeedBack");
System.out.println("jrmFeedBack"+jrmFeedBack);


System.out.println(ChkAdh+" ` "+ChkAdhJ+" ` "+reason1+" ` "+reason2);
String buffer;

sql="update db_gps.t_debriefing set AdhJRM='"+ChkAdh+"',AdhJRMReason='"+reason1+"', AdhJourney='"+ChkAdhJ+"', AdhJourneyReason='"+reason2+"',  NearMiss='"+NearMiss+"', NMDescription='"+NearMissD+"', RouteCause='"+RouteCause+"', PreventionAction='"+prevention+"', jrmFeedBack='"+jrmFeedBack+"'  where Driverid='"+DriveId+"' and  tripid='"+TripId+"'   ";
System.out.println("updated query in ajax"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
System.out.println(ins+" no. of records updated");
if(ins>=1){
		buffer="Updated";
		System.out.println("Updates : "+sql);
		out.print(buffer);

//buffer=null;
}

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
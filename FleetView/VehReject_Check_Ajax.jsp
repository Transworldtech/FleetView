
<%@ include file="Connections/conn.jsp"

 %>
 <%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.DebriefSubmitData"
	import="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	import="com.transworld.fleetview.framework.DebriefSubmitViewData"
	import="com.transworld.fleetview.framework.ReasonOfRejection"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberForTransporter"
	import="com.fleetview.beans.DisconnectionCount"
	import="com.transworld.fleetview.framework.PeripheralOfUnitDuringTrip" 
		import="io.util.*" 
		import="java.util.Date"
	%>

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
String buffer;
String buffer1;
String VehT="",cnt1="";


String veh = request.getParameter("VehRegNo");
String DriverId=request.getParameter("Did");
Calendar now = Calendar.getInstance();

StringTokenizer stk = new StringTokenizer(veh,",");
String VehRegNo=stk.nextToken();
System.out.println("5555555555555555555555577777777"+VehRegNo);

String sql5="select Vehbodytype from db_gps.t_vehicledetails where VehicleRegNumber='"+VehRegNo+"'";

ResultSet rs5=st.executeQuery(sql5);
System.out.println("vehhhhhhhhhhhhtyyyyyyyyyyyy"+sql5);
if(rs5.next())
{
	VehT=rs5.getString("Vehbodytype");
}


java.util.Date sysdate = new Date();

java.util.Date sysdate1 = new Date();
//java.util.Date Lastexpdate = new SimpleDateFormat("dd-MMM-yyyy").parse(sysdate);
Calendar cal = Calendar.getInstance();
cal.setTime(sysdate);
cal.add(Calendar.MONTH,-3);
sysdate = cal.getTime();
System.out.println("Expdate11  =  "+sysdate+"  expireddate11 "+sysdate1);

















String sql6="select count(a.TripID) as cnt from db_gps.t_completedjourney a,db_gps.t_vehicledetails b where a.DriverID='"+DriverId+"' and a.Vehid=b.VehicleCode and b.Vehbodytype='"+VehT+"'between '"+sysdate+"' and '"+sysdate1+"' ";
ResultSet rs6=st.executeQuery(sql6);
System.out.println("VeeeeeeeeeetttttyyyyyCCCCCCcunnnnnt"+sql6);

while(rs6.next())
{
	cnt1=rs6.getString("cnt");
}



String sql4 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver where VehRegNo='"+VehRegNo+"' order by UpdatedDateTime DESC limit 1";
ResultSet rs4 = st.executeQuery(sql4);
System.out.println("5555555555555555555555577777777"+sql4);
int i=0;
if(rs4.next())
{
	
	if("Yes".equalsIgnoreCase(rs4.getString("status")))
		{
			buffer="Yes,"+rs4.getString("VehRegNo")+","+VehT+","+cnt1;
			System.out.println("Updates : "+buffer);
			out.print(buffer);	
		}
		else{
			buffer="No,"+VehRegNo+","+VehT+","+cnt1;
			buffer1="Updated";
	System.out.println("Updates : "+buffer);
	out.print(buffer);}	
}else{
			buffer="No,"+VehRegNo+","+VehT+","+cnt1;
	System.out.println("Updates : "+buffer);
	out.print(buffer);}	






} catch(Exception e) { 
	out.print("No");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
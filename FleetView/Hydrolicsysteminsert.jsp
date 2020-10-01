<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null;
Statement st = null,stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,st15=null,st16=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
int count=0;
%>
<%
 int i=1;


con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt = con1.createStatement();
stmt1 = con1.createStatement();
stmt2 = con1.createStatement();
stmt3 = con1.createStatement();
stmt4 = con1.createStatement();
st15 = con1.createStatement();
st16 = con1.createStatement();

int cnt=0,cnt1=0;
int sqlst=0;

String VehRegNo=request.getParameter("VehRegNo");
String vehid=request.getParameter("vehid");
System.out.println("vehidddddd"+vehid);

String user=session.getAttribute("mainuser").toString();
String transporter=session.getAttribute("usertypevalue").toString();

String value0=request.getParameter("element_3_1"); 
String value1=request.getParameter("element_3_2");
String value2=request.getParameter("element_3_3"); 
String value3=request.getParameter("element_3_4"); 
String value4=request.getParameter("element_3_5");
String value5=request.getParameter("element_3_6"); 
String value6=request.getParameter("element_3_7"); 
String value7=request.getParameter("element_3_8");
String value8=request.getParameter("element_3_9"); 
String value9=request.getParameter("element_3_10");
String value10=request.getParameter("element_3_11"); 
String value11=request.getParameter("element_3_12");
String value12=request.getParameter("element_3_13"); 
String value13=request.getParameter("element_3_14");
String value14=request.getParameter("element_3_15");
String value15=request.getParameter("element_3_16");
String value16=request.getParameter("element_3_17"); 
String value17=request.getParameter("element_3_18");
String value18=request.getParameter("element_3_19");
String value19=request.getParameter("element_3_20"); 
String value20=request.getParameter("element_3_21");
String value21=request.getParameter("element_3_22");
  

try{
String sqlinsert="insert into db_gps.t_hydrolicsystem (VehCode,Owner,Entryby,Type,Capacity,Pressure,Drive,Tank_Capacity,Oil_Grade,Make_Vendor,Hyd_Cylinders_Numbers,Door_Cylinder_size,Door_Cylinder_Nos,Door_Clamp_Size,Door_Clamp_Nos,Boom_Fwd_Rev_Size,Boom_Fwd_Rev_Nos,Boom_Up_Down_Size,Boom_Up_Down_Nos,Directional_Control_Valve_Make,Pressure_Relief_Valve_Make,Speed_Control_Valve_Make,Pilot_Valve_Make,Tipping_Cyclinder_Make,Filters_Specification) values('"+vehid+"','"+transporter+"','"+user+"','"+value0+"','"+value1+"','"+value2+"','"+value3+"','"+value4+"','"+value5+"','"+value6+"','"+value7+"','"+value8+"','"+value9+"','"+value10+"','"+value11+"','"+value12+"','"+value13+"','"+value14+"','"+value15+"','"+value16+"','"+value17+"','"+value18+"','"+value19+"','"+value20+"','"+value21+"')";  
System.out.println("sqlinsert"+sqlinsert);
cnt=st15.executeUpdate(sqlinsert);



String sqlinsert1="insert into db_gps.t_hydrolicsystemhistory (VehCode,Owner,Entryby,Type,Capacity,Pressure,Drive,Tank_Capacity,Oil_Grade,Make_Vendor,Hyd_Cylinders_Numbers,Door_Cylinder_size,Door_Cylinder_Nos,Door_Clamp_Size,Door_Clamp_Nos,Boom_Fwd_Rev_Size,Boom_Fwd_Rev_Nos,Boom_Up_Down_Size,Boom_Up_Down_Nos,Directional_Control_Valve_Make,Pressure_Relief_Valve_Make,Speed_Control_Valve_Make,Pilot_Valve_Make,Tipping_Cyclinder_Make,Filters_Specification) values('"+vehid+"','"+transporter+"','"+user+"','"+value0+"','"+value1+"','"+value2+"','"+value3+"','"+value4+"','"+value5+"','"+value6+"','"+value7+"','"+value8+"','"+value9+"','"+value10+"','"+value11+"','"+value12+"','"+value13+"','"+value14+"','"+value15+"','"+value16+"','"+value17+"','"+value18+"','"+value19+"','"+value20+"','"+value21+"')";  
System.out.println("sqlinsert"+sqlinsert1);
cnt=st16.executeUpdate(sqlinsert1);
}



catch(Exception e){
    e.printStackTrace();
    //out.println("Exception occure while insert data:-"+e);
}
if(cnt>=1)
 {
	 //cnt=0;
out.println("<script type='text/javascript'>alert('Hydraulic Record Inserted Successfully');");
//out.println("location='showperipheralsDet.jsp'");
 //response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);\
 
 String VehRegNo1=request.getParameter("VehRegNo").toString();
 out.println("location='showperipheralsDet.jsp?VehId="+vehid+"'");
out.println("</script>");

 }else{
	  out.println("<script type='text/javascript'>alert('Record Already Inserted For This Vehicle');");
	//	out.println("location='showperipheralsDet.jsp'");
	 //response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
	 out.println("location='showperipheralsDet.jsp?VehId="+vehid+"'");
		out.println("</script>");
		 
 }
%>
<table border="0" width="400" align="center" class="sortable_entry">
<tr>
<td>
<!--1,1-->
</td>
</tr>
</table>
</jsp:useBean>
<%-- <%@ include file="footernew.jsp" %> --%>
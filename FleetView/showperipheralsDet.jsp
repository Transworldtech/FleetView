<%@page import="org.springframework.mock.staticmock.AbstractMethodMockingControl.Expectations"%>
<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%@ page language="java" import="java.sql.*" import="java.util.*"
import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/view.css" media="all" />
<link rel="stylesheet" type="text/css" href="css/mystyle.css" media="all" />
<title>Vehicle Master Report Details</title>

</head>
<body id="main_body" >
<%! Connection conn=null;%>
<%! Connection conn1=null;%>
<%! Connection conn2=null;%>
<%! Connection conn3=null;%>
<%! Connection conn4=null;
Connection conn5=null;
%>
<%	


String Vehid=request.getParameter("VehId");
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehId:---->VehId:---->VehId:---->VehId:---->"+Vehid);
//String VehRegNo=request.getParameter("VehRegNo");
//session.setAttribute("vehcode", Vehid);



String VehCode="", Make="",Serial_Number="",Oil_Grade="",Oil_Capacity="",Type="",Ratio="",No_Of_Outputs="",Shaft_Details="",flange_Size="",Rid="";
String Make1="", Model1="",Drive="",Oil_Grade1="",Oil_Capacity1="",Serial_Number1="",jetting_pressure_rating="",Type1="",suction_strainer="",power="",piston_size="",seal_size="",rotation="",accumulator_make="",Model_No="",cooler="",Rid1="";
String Make2="",Model2="",owner2="",Type2="",Type5="",Drive2="",vaccum_pressure_rating="",Oil_Grade2="",Oil_Capacity2="",Serial_Number2="",power_rpm="",pump_rotation="",installation="",no_of_NRV="",no_of_VRV="",no_four_way_valve="",cooling_system="",capacity2="",Rid2="",weight="";
String Rid3="",Type3="",Capacity3="",Pressure3="",Drive5="",Drive3="",Tank_Capacity="",Oil_Grade3="",Make_Vendor="",Hyd_Cylinders_Numbers="",Door_Cylinder_size="",Door_Cylinder_Nos="",Door_Clamp_Size="",Door_Clamp_Nos="",Boom_Fwd_Rev_Size="",Boom_Fwd_Rev_Nos="",Boom_Up_Down_Size="",Boom_Up_Down_Nos="",Directional_Control_Valve_Make="",Pressure_Relief_Valve_Make="",Speed_Control_Valve_Make="",Pilot_Valve_Make="",Tipping_Cyclinder_Make="",Filters_Specification="";
String Rid4="",pto="",acceleration="",control_panel_location="",jetting_pressure_gauge="",suction_pressure_gauge="",hyd_pressure_gauge="";



	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection();
	conn2 = fleetview.ReturnConnection();
	conn3 = fleetview.ReturnConnection();
	conn4 = fleetview.ReturnConnection();
	conn5 = fleetview.ReturnConnection();
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
	String sql=null;
	ResultSet rst=null,rst1=null,rst2=null,rst3=null,rst4=null,rsveh=null;
	st=conn.createStatement();
	st1=conn1.createStatement();
	st2=conn2.createStatement();
	st3=conn3.createStatement();
	st4=conn4.createStatement();
	st5=conn5.createStatement();

%>

<%


	
	String Vehid1=request.getParameter("VehId");
	
	//String abc="Select VehRegn  from db_gps.t_VehMst where VehId =9641";
	//rst = st.executeQuery(abc);
String vehcode="select VehRegn from db_gps.t_VehMst where VehId='"+Vehid1+"'";


rsveh=st.executeQuery(vehcode);
rsveh.previous();
while(rsveh.next())
{
	VehRegNo=rsveh.getString("VehRegn");
}

%>

<script type="text/javascript">


</script>



<img id="top" src="newimages/top.png" alt="">
	
	<div id="form_container">
	
		<h1 align="center"><b>Peripherals Details For <%=VehRegNo %></b></h1>
		<br>
		<form id="vehMasterRepDetails" class="appnitro"  method="post" >
 
<!-- <div align="center"><font face="Arial" size="2"><a href="Peripheralsreport.jsp"  style=font-weight: bold; color: blue;  >See All Report</a></font></td></div> -->
 

<%



try{
String abc="Select * from db_gps.t_pto where Vehcode='"+Vehid1+"' order by insertDate asc ";
rst = st.executeQuery(abc);
System.out.println("abccccccccc"+abc);
while(rst.next())
{
	Rid=rst.getString("Rid");
	System.out.println("typeeee"+Rid);
	Make=rst.getString("Make");
	System.out.println("typeeee"+Make);
    Serial_Number=rst.getString("Serial_Number");
	System.out.println("fleetview"+Serial_Number);
	 Oil_Grade=rst.getString("Oil_Grade");
	System.out.println("Oil_Grade"+Oil_Grade);
	 Oil_Capacity=rst.getString("Oil_Capacity");
	System.out.println("Oil_Capacity"+Oil_Capacity);
	 Type=rst.getString("Type");
	System.out.println("Type"+Type);
	
	 Ratio=rst.getString("Ratio");
	System.out.println("Ratio"+Ratio);
	 No_Of_Outputs=rst.getString("No_Of_Outputs");
	System.out.println("No_Of_Outputs"+No_Of_Outputs);
	 Shaft_Details=rst.getString("Shaft_Details");
	System.out.println("Shaft_Details"+Shaft_Details);
	 flange_Size=rst.getString("flange_Size");
	System.out.println("flange_Size"+flange_Size);

	
	VehCode=rst.getString("VehCode");
}

}
catch(Exception e)
{
	out.println("P 111111111111 "+e);
}

 try{
	

 String xyz="Select * from db_gps.t_jettingpump  where Vehcode='"+Vehid1+"'  order by insertDate asc ";
 rst1 = st1.executeQuery(xyz);
 System.out.println("xyzxyzxyzxyzxyz111111"+xyz);
 while(rst1.next())
 {
	 Rid1=rst1.getString("Rid");
 	Make1=rst1.getString("Make");
 	System.out.println("make111------"+Make);
 	Model1=rst1.getString("Model");
 	System.out.println("Model-------"+Model1);
 	Serial_Number1=rst1.getString("Serial_Number");
 	System.out.println("fleetview------"+Serial_Number1);
 	 Oil_Grade1=rst1.getString("Oil_Grade");
 	System.out.println("Oil_Grade-----"+Oil_Grade);
 	 Oil_Capacity1=rst1.getString("Oil_Capacity");
 	System.out.println("Oil_Capacity------"+Oil_Capacity);
 	 Drive=rst1.getString("Drive");
 	System.out.println("Drive------"+Drive);
 	jetting_pressure_rating=rst1.getString("jetting_pressure_rating");
 	 System.out.println("jetting_pressure_rating-------"+jetting_pressure_rating);
 	power=rst1.getString("power");
 		System.out.println("power-------"+power);
 		suction_strainer=rst1.getString("suction_strainer");
 		System.out.println("suction_strainer------"+suction_strainer);
 	rotation=rst1.getString("rotation");
 	System.out.println("rotation--------"+rotation);
 	piston_size=rst1.getString("piston_size");
 	System.out.println("piston_size--------"+piston_size);
 	seal_size=rst1.getString("seal_size");
 	System.out.println("seal_size----------"+seal_size);
 	accumulator_make=rst1.getString("accumulator_make");
 	System.out.println("accumulator_make--------"+accumulator_make);
 	Model_No=rst1.getString("Model_No");
 	System.out.println("Model_No---------"+Model_No);
 	cooler=rst1.getString("cooler");
 	System.out.println("cooler---------"+cooler);
 	
 	Type1=rst1.getString("Type");
 	
 	}

 }

 catch(Exception e)
 {
 	out.println("P 222222222 "+e);
 }

%>




<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>PTO Details</u></font>
<br></br>

<div align="left"><font face="Arial" size="2"><a href="PTO.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Add New</a></font></td></div>
<%-- <div align="center"><font face="Arial" size="2"><a href="Editpto.jsp?mid=<%=rst1.getString("Rid")%>&cid=<%=rst1.getString("Make")%>&cname=<%=rst1.getString("Serial_Number")%>" style="font-weight: bold; color: blue; " >Edit PTO</a></font></td></div> --%>
<div align="left"><font face="Arial" size="2"><a href="Editpto.jsp?rid=Add New<%=Rid%>&VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>&make=<%=Make%>&serialnumber=<%=Serial_Number%>&oilgrade=<%=Oil_Grade %>&oilcapacity=<%=Oil_Capacity%>&type=<%=Type %>&ratio=<%= Ratio%>&noofunits=<%=No_Of_Outputs %>&shaftdetails=<%=Shaft_Details %>&flangesize=<%= flange_Size%>" style="font-weight: bold; color: blue; " >Edit PTO</a></font></td></div>
<div align="right"><font face="Arial" size="2"><a href="EditDpto.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Custom Field</a></font></td></div>
<table border="1" width="100%">

<tr bordercolor="black">
 <th style="background-color: #C6DEFF;" align="center">Make</th>
 <th style="background-color: #C6DEFF;" align="center">Serial Number</th>
  <th style="background-color: #C6DEFF;" align="center">Oil Grade</th>
   <th style="background-color: #C6DEFF;" align="center">Oil Capacity</th>
    <th style="background-color: #C6DEFF;" align="center">Type</th>
     <th style="background-color: #C6DEFF;" align="center">Ratio</th>
     </tr>
     
     <tr>
     <td width="16%"><%=Make %></td>
     <td width="16%"><%=Serial_Number %></td>
     <td width="16%"><%=Oil_Grade %></td>
     <td width="16%"><%=Oil_Capacity %></td>
     <td width="16%"><%=Type %></td>
     <td width="16%"><%= Ratio%></td>
     </tr>



</table>
</div>
<br>

<table border="1" width="50%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">No. Of Unit</th>
 <th style="background-color: #C6DEFF;" align="center">Shaft Detail</th>
  <th style="background-color: #C6DEFF;" align="center">Flange Size</th>
  
     </tr>
     
     <tr>
     <td width="16%"><%= No_Of_Outputs%></td>
     <td width="16%"><%=Shaft_Details %></td>
     <td width="16%"><%=flange_Size %></td>
     
     </tr>

</table>
<%
 

%>
<br>
<br>
<br>


<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Jetting Details</u></font>
<br></br>

<div align="left"><font face="Arial" size="2"><a href="Jetting.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>" style="font-weight: bold; color: blue; " >Add New</a></font></td></div>
<div align="left"><font face="Arial" size="2"><a href="Editjettingpum.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>&rid=<%=Rid1 %>&make1=<%=Make1 %>&model=<%= Model1 %>&oilgrade1=<%=Oil_Grade1%>&oilcapacity1=<%=Oil_Capacity1 %>&serialnumber1=<%=Serial_Number1 %>&drive=<%=Drive %>&type1=<%= Type1%>&jettingpressurepump1=<%= jetting_pressure_rating%>&power=<%=power %>&suctionstrainer1=<%=suction_strainer %>&rotation=<%=rotation %>&pistonsize=<%=piston_size %>&sealsize=<%=seal_size %>&accumulatormake=<%= accumulator_make%>&modelno=<%=Model_No %>&cooler=<%=cooler %>" style="font-weight: bold; color: blue; " >Edit JettingPump</a></font></td></div>
<div align="right"><font face="Arial" size="2"><a href="EditDJetting.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Custom Field</a></font></td></div>

<table border="1" width="100%">
<tr bordercolor="black">
 <th style="background-color: #C6DEFF;" align="center">Make</th>
<th style="background-color: #C6DEFF;" align="center">Model</th>
   <th style="background-color: #C6DEFF;" align="center">Serial Number</th>
    <th style="background-color: #C6DEFF;" align="center">Oil Grade</th>
     <th style="background-color: #C6DEFF;" align="center">Oil Capacity</th>
     </tr>
     
     <tr>
     <td width="16%"><%= Make1%></td>
     <td width="16%"><%=Model1%></td>
     <td width="16%"><%= Serial_Number1%></td>
     <td width="16%"><%= Oil_Grade1%></td>
     <td width="16%"><%= Oil_Capacity1%></td>
     </tr>



</table>
</div>
<br>

<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Drive</th>
 <th style="background-color: #C6DEFF;" align="center">Jetting Pressure Rating</th>
  <th style="background-color: #C6DEFF;" align="center">Power</th>
   <th style="background-color: #C6DEFF;" align="center">Suction Strainer</th>
    <th style="background-color: #C6DEFF;" align="center">Rotation</th>
     <th style="background-color: #C6DEFF;" align="center">Piston Size</th>
     </tr>
     
     <tr>
     <td width="16%"><%= Drive%></td>
     <td width="16%"><%=jetting_pressure_rating %></td>
     <td width="16%"><%=power %></td>
     <td width="16%"><%=suction_strainer %></td>
     <td width="16%"><%=rotation %></td>
     <td width="16%"><%=piston_size%></td>
     </tr>

</table>
<br>


<table border="1" width="80%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Seal Size</th>
 <th style="background-color: #C6DEFF;" align="center">Accumulator Make</th>
  <th style="background-color: #C6DEFF;" align="center">Model No.</th>
   <th style="background-color: #C6DEFF;" align="center">Type</th>
    <th style="background-color: #C6DEFF;" align="center">Cooler</th>
</tr>
     
     <tr>
     <td width="16%"><%=seal_size%></td>
     <td width="16%"><%=accumulator_make%></td>
     <td width="16%"><%=Model_No %></td>
     <td width="16%"><%=Type1 %></td>
     <td width="16%"><%=cooler %></td>
      </tr>


</table>
<% try{
	

 String aaa="Select * from db_gps.t_vaccumpump  where Vehcode='"+Vehid1+"' order by insertDate asc ";
 rst2 = st2.executeQuery(aaa);
 System.out.println("aaaaaaaaaaaaaaa1"+aaa);
 while(rst2.next())
 {
	 Rid2=rst2.getString("Rid");
 	Make2=rst2.getString("Make");
 	System.out.println("make111------"+Make2);
 	owner2=rst2.getString("Owner");
 	System.out.println("make111------"+owner2);
 	Model2=rst2.getString("Model");
 	System.out.println("Model-------"+Model2);
 	Type5=rst2.getString("Type");
 	System.out.println("fleetview------"+Type5);
 	
 	capacity2=rst2.getString("Capacity");
 	System.out.println("fleetview------"+capacity2);
 	Serial_Number2=rst2.getString("Serial_Number");
 	System.out.println("fleetview------"+Serial_Number2);
 	
 	
 	
 	
 	Oil_Grade2=rst2.getString("oil_grade");
 	System.out.println("Oil_Grade-----"+Oil_Grade);
 	 Oil_Capacity2=rst2.getString("oil_capacity");
 	System.out.println("Oil_Capacity------"+Oil_Capacity);
 	 Drive5=rst2.getString("drive");
 	System.out.println("Drive------"+Drive);
 	
 	
 	
 	vaccum_pressure_rating=rst2.getString("vaccum_pressure_rating");
 	 System.out.println("jetting_pressure_rating-------"+jetting_pressure_rating);
 	power_rpm=rst2.getString("power_rpm");
 	System.out.println("power-------"+power);
 		
 	installation=rst2.getString("installation");
 	System.out.println("power-------"+installation);
 	
 	
 	pump_rotation=rst2.getString("pump_rotation");
 	System.out.println("rotation--------"+rotation);
 	
 	
 	weight=rst2.getString("weight");
 	System.out.println("piston_size--------"+piston_size);
 	
 	no_four_way_valve=rst2.getString("no_four_way_valve");
 	System.out.println("seal_size----------"+no_four_way_valve);
 	
 	no_of_NRV=rst2.getString("no_of_NRV");
 	System.out.println("accumulator_make--------"+no_of_NRV);
 	
 	no_of_VRV=rst2.getString("no_of_VRV");
 	System.out.println("Model_No---------"+Model_No);
 	
 	cooling_system=rst2.getString("cooling_system");
 	System.out.println("cooler---------"+cooler);
 
 	}

 }

 catch(Exception e)
 {
 	out.println("P 3333333"+e);
 }

%>
<br>
<br>

<div width="100%" align="left"  >
<font size="3"style="margin-left: 0.4em;"><u>Vacuum Details</u></font>
<br></br>

<div align="left"><font face="Arial" size="2"><a href="Vacuum.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>" style="font-weight: bold; color: blue; " >Add New</a></font></td></div>
<div align="left"><font face="Arial" size="2"><a href="EditVaccumpump.jsp?Rid2=<%=Rid2 %>&VehRegNo=<%=VehRegNo%>&VehId=<%=request.getParameter("VehId")%>&capacity=<%=capacity2 %>&weight=<%=weight%>&no_four_way_valve=<%=no_four_way_valve %>&no_of_NRV=<%=no_of_NRV %>&installation=<%=installation %>&no_of_VRV=<%=no_of_VRV %>&make1=<%=Make2 %>&model=<%= Model2 %>&oilgrade1=<%=Oil_Grade2%>&oilcapacity1=<%=Oil_Capacity2 %>&serialnumber1=<%=Serial_Number2 %>&drive=<%=Drive5 %>&type1=<%= Type5%>&jettingpressurepump1=<%=vaccum_pressure_rating%>&power=<%=power_rpm %>&rotation=<%=pump_rotation %>&cooler=<%=cooling_system %>" style="font-weight: bold; color: blue; " >Edit VacuumPump</a></font></td></div>
<div align="right"><font face="Arial" size="2"><a href="EditDvaccum.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Custom Field</a></font></td></div>

<table border="1" width="100%">
<tr bordercolor="black">
 <th style="background-color: #C6DEFF;" align="center">Make</th>
 <th style="background-color: #C6DEFF;" align="center">Model</th>
  <th style="background-color: #C6DEFF;" align="center">Type</th>
   <th style="background-color: #C6DEFF;" align="center">Serial Number</th>
    <th style="background-color: #C6DEFF;" align="center">Oil Grade</th>
     <th style="background-color: #C6DEFF;" align="center">Oil Capacity</th>
     </tr>
     
     <tr>
     <td width="16%"><%=Make2%></td>
      <td width="16%"><%=Model2%></td>
      <td width="16%"><%=Type5%></td>
     <td width="16%"><%=Serial_Number2%></td>
     <td width="16%"><%=Oil_Grade2%></td>
     <td width="16%"><%=Oil_Capacity2%></td>
     </tr>



</table>
</div>
<br>

<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Capacity</th>
 <th style="background-color: #C6DEFF;" align="center">Drive</th>
 <th style="background-color: #C6DEFF;" align="center">Vacuum Pressure Rating</th>
  <th style="background-color: #C6DEFF;" align="center">Power & Rpm</th>
   <th style="background-color: #C6DEFF;" align="center">Installation</th>
    
     </tr>
     
     <tr>
     <td width="16%"><%=capacity2%></td>
     <td width="16%"><%=Drive5%></td>
     <td width="16%"><%=vaccum_pressure_rating %></td>
     <td width="16%"><%=power_rpm %></td>
     <td width="16%"><%=installation %></td>
    
     </tr>

</table>
<br>


<table border="1" width="80%">

<tr>
<th style="background-color: #C6DEFF;" align="center">Rotation</th>
     <th style="background-color: #C6DEFF;" align="center">Weight</th>
 <th style="background-color: #C6DEFF;" align="center">No. Of Four Way Valve</th>
 <th style="background-color: #C6DEFF;" align="center">No. Of NVR</th>
  <th style="background-color: #C6DEFF;" align="center">No. Of VRV</th>
  <th style="background-color: #C6DEFF;" align="center">Cooler</th>
    
     </tr>
     
     <tr>
      <td width="16%"><%=pump_rotation %></td>
     <td width="16%"><%=weight%></td>
     <td width="16%"><%=no_four_way_valve%></td>
     <td width="16%"><%=no_of_NRV%></td>
     <td width="16%"><%=no_of_VRV %></td>
     <td width="16%"><%=cooling_system %></td>
   
    
     </tr>


</table>

<br>
<br>
<% try{
	

 String aaa1="Select * from db_gps.t_hydrolicsystem  where Vehcode='"+Vehid1+"'order by insertDate asc ";
 rst3 = st3.executeQuery(aaa1);
 System.out.println("aaaaaaaaaaaaaaa2222222"+aaa1);
 while(rst3.next())
 {
	 Rid3=rst3.getString("Rid");
	 Type3=rst3.getString("Type");
 	System.out.println("make111------"+Make2);
 	Capacity3=rst3.getString("Capacity");
 	System.out.println("make111------"+owner2);
 	Pressure3=rst3.getString("Pressure");
 	System.out.println("Model-------"+Model2);
 	Drive3=rst3.getString("Drive");
 	System.out.println("fleetview------"+Type2);
 	Tank_Capacity=rst3.getString("Tank_Capacity");
 	System.out.println("fleetview------"+Tank_Capacity);
 	Oil_Grade3=rst3.getString("Oil_Grade");
 	System.out.println("fleetview------"+Oil_Grade);
    Make_Vendor=rst3.getString("Make_Vendor");
 	System.out.println("Make_Vendor-----"+Make_Vendor);
 	Hyd_Cylinders_Numbers=rst3.getString("Hyd_Cylinders_Numbers");
 	System.out.println("Hyd_Cylinders_Numbers------"+Hyd_Cylinders_Numbers);
 	 Drive2=rst3.getString("drive");
 	System.out.println("Drive------"+Drive);
 	Door_Cylinder_size=rst3.getString("Door_Cylinder_size");
 	 System.out.println("Door_Cylinder_size-------"+Door_Cylinder_size);
 	Door_Cylinder_Nos=rst3.getString("Door_Cylinder_Nos");
 	System.out.println("Door_Cylinder_Nos-------"+Door_Cylinder_Nos);
 	Door_Clamp_Size=rst3.getString("Door_Clamp_Size");
 	System.out.println("Door_Clamp_Size-------"+Door_Clamp_Size);
 	Door_Clamp_Nos=rst3.getString("Door_Clamp_Nos");
 	System.out.println("Door_Clamp_Nos-------"+Door_Clamp_Nos);
    Boom_Fwd_Rev_Size=rst3.getString("Boom_Fwd_Rev_Size");
 	System.out.println("rotation--------"+Boom_Fwd_Rev_Size);
    Boom_Fwd_Rev_Nos=rst3.getString("Boom_Fwd_Rev_Nos");
 	System.out.println("Boom_Fwd_Rev_Nos--------"+Boom_Fwd_Rev_Nos);
 	Boom_Up_Down_Size=rst3.getString("Boom_Up_Down_Size");
 	System.out.println("Boom_Up_Down_Size----------"+Boom_Up_Down_Size);
 	Boom_Up_Down_Nos=rst3.getString("Boom_Up_Down_Nos");
 	System.out.println("Boom_Up_Down_Nos----------"+Boom_Up_Down_Nos);
 	Directional_Control_Valve_Make=rst3.getString("Directional_Control_Valve_Make");
 	System.out.println("Directional_Control_Valve_Make----------"+Directional_Control_Valve_Make);
    Pressure_Relief_Valve_Make=rst3.getString("Pressure_Relief_Valve_Make");
 	System.out.println("Pressure_Relief_Valve_Make--------"+Pressure_Relief_Valve_Make);
 	Speed_Control_Valve_Make=rst3.getString("Speed_Control_Valve_Make");
 	System.out.println("Speed_Control_Valve_Make---------"+Speed_Control_Valve_Make);
 	Pilot_Valve_Make=rst3.getString("Pilot_Valve_Make");
 	System.out.println("Pilot_Valve_Make---------"+Pilot_Valve_Make);
 	Tipping_Cyclinder_Make=rst3.getString("Tipping_Cyclinder_Make");
 	System.out.println("Tipping_Cyclinder_Make---------"+Tipping_Cyclinder_Make);
 	Filters_Specification=rst3.getString("Filters_Specification");
 	System.out.println("Filters_Specification---------"+Filters_Specification);
 }
}

 catch(Exception e)
 {
 	out.println("P 44444444"+e);
 }

%>
<br>
<br>


<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Hydraulic System Details</u></font>
<br></br>

<div align="left"><font face="Arial" size="2"><a href="Hydrolicsystem.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>" style="font-weight: bold; color: blue; " >Add New</a></font></td></div>
<div align="left"><font face="Arial" size="2"><a href="EditHydrolicsystem.jsp?VehId=<%=request.getParameter("VehId")%>&Vehregno=<%=VehRegNo%>&Type=<%=Type3%>&Capacity=<%=Capacity3 %>&Pressure=<%=Pressure3 %>&Drive3=<%=Drive3 %>&Tank_Capacity=<%=Tank_Capacity %>&Oil_Grade3=<%=Oil_Grade3 %>&Make_Vendor=<%= Make_Vendor%>&Hyd_Cylinders_Numbers=<%=Hyd_Cylinders_Numbers%>&Drive2=<%=Drive2 %>&Door_Cylinder_size=<%=Door_Cylinder_size %>&Door_Cylinder_Nos=<%=Door_Cylinder_Nos %>&Door_Clamp_Size=<%= Door_Clamp_Size%>&Door_Clamp_Nos=<%=Door_Clamp_Nos%>&Boom_Fwd_Rev_Size=<%=Boom_Fwd_Rev_Size %>&Boom_Fwd_Rev_Nos=<%=Boom_Fwd_Rev_Nos %>&Boom_Up_Down_Size=<%=Boom_Up_Down_Size %>&Boom_Up_Down_Nos=<%=Boom_Up_Down_Nos %>&Directional_Control_Valve=<%=Directional_Control_Valve_Make%>&Pressure_Relief_Valve=<%=Pressure_Relief_Valve_Make %>&Speed_Control_Valve=<%=Speed_Control_Valve_Make %>&Pilot_Valve_Make=<%=Pilot_Valve_Make %>&Tipping_Cyclinder_Make=<%=Tipping_Cyclinder_Make %>&Filters_Specification=<%=Filters_Specification %>" style="font-weight: bold; color: blue; " >Edit HydraulicSystem</a></font></td></div>
<div align="right"><font face="Arial" size="2"><a href="EditDHydrolic.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Custom Field</a></font></td></div>

<table border="1" width="100%">
<tr bordercolor="black">
 <th style="background-color: #C6DEFF;" align="center">Type</th>
 <th style="background-color: #C6DEFF;" align="center">Capacity</th>
  <th style="background-color: #C6DEFF;" align="center">Pressure</th>
   <th style="background-color: #C6DEFF;" align="center">Drive</th>
    <th style="background-color: #C6DEFF;" align="center">Tank Capacity</th>
     <th style="background-color: #C6DEFF;" align="center">Oil Grade</th>
     </tr>
     
     <tr>
     <td width="16%"><%= Type3%></td>
     <td width="16%"><%=Capacity3%></td>
     <td width="16%"><%= Pressure3%></td>
     <td width="16%"><%= Drive3%></td>
     <td width="16%"><%= Tank_Capacity%></td>
     <td width="16%"><%= Oil_Grade3%></td>
     </tr>



</table>
</div>
<br>

<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Make Vendor</th>
 <th style="background-color: #C6DEFF;" align="center">Hyd. Cylinder Number</th>
  <th style="background-color: #C6DEFF;" align="center">Door Cylinder Size</th>
    <th style="background-color: #C6DEFF;" align="center">Door Cylinder Nos</th>
     <th style="background-color: #C6DEFF;" align="center">Door Clamp Size</th>
     </tr>
     
     <tr>
     <td width="16%"><%= Make_Vendor%></td>
     <td width="16%"><%=Hyd_Cylinders_Numbers %></td>
      <td width="16%"><%=Door_Cylinder_size %></td>
     <td width="16%"><%=Door_Cylinder_Nos %></td>
     <td width="16%"><%=Door_Clamp_Size%></td>
     </tr>

</table>
<br>

 	
  
<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Door Clamp Nos</th>
 <th style="background-color: #C6DEFF;" align="center">Boom Fwd. Rev. Size</th>
  <th style="background-color: #C6DEFF;" align="center">Boom Fwd. Rev. Nos</th>
   <th style="background-color: #C6DEFF;" align="center">Boom Up Down Size</th>
    <th style="background-color: #C6DEFF;" align="center">Boom Up Down Nos</th>
    
     </tr>
     
     <tr>
     <td width="16%"><%= Door_Clamp_Nos%></td>
     <td width="16%"><%= Boom_Fwd_Rev_Size%></td>
     <td width="16%"><%=Boom_Fwd_Rev_Nos %></td>
     <td width="16%"><%=Boom_Up_Down_Size %></td>
   <td width="16%"><%=Boom_Up_Down_Nos %></td>
    
     </tr>
     </table>
<br>
<table border="1" width="100%">

<tr>
 <th style="background-color: #C6DEFF;" align="center">Directional Control</th>
 <th style="background-color: #C6DEFF;" align="center">Pressure Relief Valve</th>
  <th style="background-color: #C6DEFF;" align="center">Speed Control Valve</th>
   <th style="background-color: #C6DEFF;" align="center">Pilot Valve</th>
    <th style="background-color: #C6DEFF;" align="center">Tipping Cylinder</th>
    <th style="background-color: #C6DEFF;" align="center">Filter Specification</th>
    
     </tr>
     
     <tr>
     <td width="16%"><%= Directional_Control_Valve_Make%></td>
     <td width="16%"><%= Pressure_Relief_Valve_Make%></td>
     <td width="16%"><%=Speed_Control_Valve_Make %></td>
     <td width="16%"><%=Pilot_Valve_Make %></td>
   <td width="16%"><%=Tipping_Cyclinder_Make %></td>
   <td width="16%"><%=Filters_Specification %></td>
    
     </tr>


</table>

 
 
 	
 
<br>
<br>
<% try{
	

 String aaa2="Select * from db_gps.t_controlsystem where Vehcode='"+Vehid1+"' order by insertDate asc ";
 rst4 = st4.executeQuery(aaa2);
 System.out.println("aaaaaaaaaaaaaaa3333333"+aaa2);
 while(rst4.next())
 {
	 Rid4=rst4.getString("Rid");
	
 	
 	pto=rst4.getString("pto");
 	System.out.println("pto-------"+pto);
 	acceleration=rst4.getString("acceleration");
 	System.out.println("fleetview------"+acceleration);
 	control_panel_location=rst4.getString("control_panel_location");
 	System.out.println("control_panel_location------"+control_panel_location);
 	jetting_pressure_gauge=rst4.getString("jetting_pressure_gauge");
 	System.out.println("jetting_pressure_gauge------"+jetting_pressure_gauge);
 
 	suction_pressure_gauge=rst4.getString("suction_pressure_gauge");
 	System.out.println("suction_pressure_gauge------"+suction_pressure_gauge);
 	hyd_pressure_gauge=rst4.getString("hyd_pressure_gauge");
 	System.out.println("hyd_pressure_gauge------"+hyd_pressure_gauge);
 	
 }
}

 catch(Exception e)
 {
 	out.println("P 555555555"+e);
 }

%>
 	

<div width="100%" align="left"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
<font size="3"style="margin-left: 0.4em;"><u>Control System Details</u></font>
<br></br>

<div align="left"><font face="Arial" size="2"><a href="controlsystem.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Add New</a></font></td></div>
<div align="left"><font face="Arial" size="2"><a href="Editcontrolsystem.jsp?rid=<%=Rid4%>&VehRegNo=<%=VehRegNo%>&VehId=<%=request.getParameter("VehId")%>&pto=<%=pto%>&acceleration=<%=acceleration%>&control_panel_location=<%=control_panel_location%>&jetting_pressure_gauge=<%=jetting_pressure_gauge%>&suction_pressure_gauge=<%=suction_pressure_gauge%>&hyd_pressure_gauge=<%=hyd_pressure_gauge%>" style="font-weight: bold; color: blue; " >Edit ControlSystem</a></font></td></div>
<div align="right"><font face="Arial" size="2"><a href="EditDcontrol.jsp?VehId=<%=request.getParameter("VehId")%>&VehRegNo=<%=VehRegNo%>"  style=font-weight: bold; color: blue;  >Custom Field</a></font></td></div>

<table border="1" width="100%">

<tr bordercolor="black">
 <th style="background-color: #C6DEFF;" align="center">PTO</th>
 <th style="background-color: #C6DEFF;" align="center">Acceleration</th>
  <th style="background-color: #C6DEFF;" align="center">Control Panel Location </th>
   <th style="background-color: #C6DEFF;" align="center">Jetting Pressure Gauge </th>
    <th style="background-color: #C6DEFF;" align="center">Suction Pressure Gauge </th>
     <th style="background-color: #C6DEFF;" align="center">Hyd. Pressure Gauge </th>
     </tr>
     
     <tr>
     <td width="16%"><%=pto%></td>
     <td width="16%"><%=acceleration %></td>
     <td width="16%"><%=control_panel_location %></td>
     <td width="16%"><%=jetting_pressure_gauge %></td>
     <td width="16%"><%=suction_pressure_gauge%></td>
     <td width="16%"><%=hyd_pressure_gauge%></td>
     </tr>



</table>
</div>
<br>
<br>
<br>
<br>




</form>





</div>
	<img id="bottom" src="newimages/bottom.png" alt="">
	

				
  

</body>

				

</html>
</jsp:useBean>

<html>

       <table border="0" width="100%" align="center" style="padding-bottom: 56px" >
<tr><td  bgcolor="#0B2161" >
<ui><li><center><font color="white" >Copyright &copy; 2008-2016 by Transworld Technologies Ltd. All Rights Reserved.</font></center></li></ui>
</td></tr>
</table>

    </body>
</html>
<%--  <%@ include file="footernew.jsp"%> --%>
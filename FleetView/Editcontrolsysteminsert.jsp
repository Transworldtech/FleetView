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
Statement st = null,stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt13=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
int count=0;
%>
<%
int cnt=0,cnt1=0;
int sqlst=0;


con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt = con1.createStatement();
stmt1 = con1.createStatement();
stmt2 = con1.createStatement();
stmt3 = con1.createStatement();
stmt4 = con1.createStatement();
stmt13 = con1.createStatement();


String VehRegNo=request.getParameter("VehRegNo");

String user=session.getAttribute("mainuser").toString();
String transporter=session.getAttribute("usertypevalue").toString();
String vehid=request.getParameter("vehid");
System.out.println("vehidvehidvehidvehidvehidvehidon insert querry page *********:-"+vehid);
String rid=request.getParameter("rid");
String pto=request.getParameter("element_3_1");
String accel=request.getParameter("element_3_2"); 
String control=request.getParameter("element_3_3");
String value2=request.getParameter("element_3_4"); 
String value3=request.getParameter("element_3_5"); 
String value4=request.getParameter("element_3_6");
    
try{ 

String sqlinsert="Update db_gps.t_controlsystem Set pto='"+pto+"',acceleration='"+accel+"',control_panel_location='"+control+"',jetting_pressure_gauge='"+value2+"',suction_pressure_gauge='"+value3+"',hyd_pressure_gauge='"+value4+"' where Vehcode='"+vehid+"' ";
System.out.println("updateeeee control"+sqlinsert);
count=stmt.executeUpdate(sqlinsert);
 
 
 
 String sqlinsert1="insert into db_gps.t_controlsystemhistory(Vehcode,Entryby,Owner,pto,acceleration,control_panel_location,jetting_pressure_gauge,suction_pressure_gauge,hyd_pressure_gauge) values('"+vehid+"','"+user+"','"+transporter+"','"+pto+"','"+accel+"','"+control+"','"+value2+"','"+value3+"','"+value4+"')";  
 System.out.println("updateeeee sqlinsert1 insert"+sqlinsert1);
 count=stmt13.executeUpdate(sqlinsert1);
 }

catch(Exception e){
    e.printStackTrace();
   // out.println("Exception occure while insert data:-"+e);
}



if(cnt>=1)
 {
	 //cnt=0;
out.println("<script type='text/javascript'>alert('Control Sysytem Inserted Sucessfully');");
//out.println("location='showperipheralsDet.jsp'");
//response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
out.println("location='showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo+"'");
out.println("</script>");

 }else{
	  out.println("<script type='text/javascript'>alert('Control System Record Updated Successfully');");
		//out.println("location='showperipheralsDet.jsp'");
		//response.sendRedirect("showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo);
		out.println("location='showperipheralsDet.jsp?VehId="+vehid+"&VehRegNo="+VehRegNo+"'");
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
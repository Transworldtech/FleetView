<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="filedownload.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/dbConn.jsp" %>
<html>
<head>
<title>Vehicle Tracking System </title>
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<link href="css/css.css" rel="StyleSheet" type="text/css">
<!--<link href="includes/style.css" rel="StyleSheet" type="text/css">-->
<style type="text/css">
.mydiv {

    cursor: w-resize;

}
</style>
    <link href="common/genomics.css" rel="StyleSheet" type="text/css">
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxTTqMIRQ21fn-o-nkKg4U0LEGP8lhRIBOAyyGRyRnBcijckOQcuKa_Eqw" type="text/javascript"></script>
</head>
<body onunload="GUnload()"  bgcolor="#FFE4E1">

<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA" class="solid">
<tr ><td valign="top"><table border="0" width="100%" bgcolor="#F8F8FF"><tr><td valign="top" rowspan="2" width="12%">
<a href="images/logo.jpg"><img src="images/logo.jpg" width="100px" height="100px" border="0"/></a></td><td colspan="2"><img src="images/ind11.jpg"><img src="images/move.gif" border="0" width="20%"><img src="images/Img6.gif" width="15%">
</td></tr>
<tr><td colspan="2"><table border="0" width="100%" align="right" background="images/background1.bmp"><tr><td align="center" ><a href="onlinedata.jsp">HOME</a></td><td align="center"><a href="aboutus.jsp">ABOUT US</a></td><td align="center"><a href="contactus.jsp">CONTACT US</a></td>
<%

String userID = "";
if (! session.isNew()) 
userID = (String) session.getAttribute("user");
if (null == userID || userID=="") 
	{
		%>
		<td align="center">
<a href="index.html">LOGIN</a></td>
		<%
	}
else
	{
		%>
		<td align="center"><a href="#">WELCOME :<font color="red"><%=userID %></b></font></a></td><td align="center"><a href="logout.jsp">LOGOUT</a></td>
		<%
	}
%>
</tr>


</table></td><tr>
</table>
</td></tr>
</table>

<%
String date1,date2,mode,rvehid,hvrno;
%>
<%

date1=session.getAttribute("hdate1").toString();
date2=session.getAttribute("hdate2").toString();
mode=session.getAttribute("mode").toString();
rvehid=session.getAttribute("hvid").toString();
hvrno=session.getAttribute("hvrno").toString();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();
%>
<%! String dd,aa; %>

<table border="1" width="100%">
<tr><td>
<table border="0" width="100%" background="images/background1.bmp"><tr><td align="center"><a href="MainformMap2.jsp<%=ll %>">Map</a></td><td align="center"><a href="historyreport.jsp">Report</a></td><td align="center"><a href="historypiechart.jsp">Pie Chart</a></td><td align="center"><a href="historybarchart.jsp">Bar Chart</a></td></tr></table>
</td></tr>
<tr><td>
<form action="" method="get">
<table border="1" width="100%" class="stats">
<tr><td class="hed">Journy Report For <%=hvrno %> From date <%=date1 %> to <%=date2 %>    Time Intervale: <select name="time" class="bodyText">
<option value="24">24 Hours</option>
<option value="12">12 Hours</option>
<option value="6">6 Hours</option>
<option value="3">3 Hours</option>
<option value="1">1 Hours</option>
</select>
<input type="submit" name="GO" value="GO"></td></tr></table></form>
</td></tr>

<tr><td>

<table width="100%" border="1" class="stats">
<tr><td class="hed">Start Date & Time</td><td class="hed">End Date & Time</td><td class="hed">Start Location</td><td class="hed">End Location</td><td class="hed">Average Speed</td><td class="hed">Distance Traveled</td><td class="hed">OS</td><td class="hed">RA</td><td class="hed">RD</td></tr>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","");
	Connection conn1 = DriverManager.getConnection("jdbc:mysql://localhost/db_gpsExceptions","root","");

Statement st1=conn.createStatement();


String sql="SELECT * FROM t_veh"+ rvehid+" where TheFieldDataDate>='"+ date1+"' and  TheFieldDataDate<='"+ date2 +"'/* and TheFiledTextFileName='ON' */order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst1=st1.executeQuery(sql);
while(rst1.next())
{
	%>
<tr>
	<td><%=rst1.getString("TheFieldDataDate") %></td>
	<td><%=rst1.getString("TheFieldDataTime") %></td>
	<td><%=rst1.getString("Speed") %></td>
	<td><%=rst1.getString("TheFiledTextFileName") %></td>
	<td><%=rst1.getString("Distance") %></td>
	<td><%=rst1.getString("TheFieldSubject") %></td>
</tr>
	<%
	

}
}catch(Exception e){
System.out.print("Exception"+e);
}
%>



</table>




</td></tr>


</table>



<table border="1" width="100%">
<tr ><td bgcolor="#ccc" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

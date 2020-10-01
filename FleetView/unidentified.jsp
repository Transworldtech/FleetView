<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/conn.jsp" %>
<%@ include file="Manu.html" %>
<html>
<head>
<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>


<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>

</head>
<body bgcolor="#FFE4E1" onLoad="JavaScript:initRotator(),loadSearchHighlight();">

<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA" class="solid">
<tr >
<td valign="top">
<table border="0" width="100%" bgcolor="#F8F8FF">
<tr>
<td rowspan="2" align="center" width="13%">
<a href="images/logo.jpg" >
<img src="images/logo.jpg"  border="0">
</a>
</td>
<td  align="left">
<img src="images/ind11.jpg" width="30%" height="100%">
<img src="images/foodlandveh.png" border="0"  width="15%" >
<img src="images/Img6.gif" width="10%" height="30%">
<%@ include file="imgrotate.html" %>
</td>
</tr>

<tr><td colspan="2"><table border="0" width="100%" align="right" background="images/background1.bmp"><tr>
		<td align="right"><font COLOR="#696969" face="Tahoma"><b>WELCOME :</b></font><font color="red"><%=session.getAttribute("dispalyname").toString() %></b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp" title="Logout">LOGOUT</a></td>
</tr>
</table></td><tr>
</table>
</td></tr>
</table>
<!-- code start here -->
<table border="1" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr><th colspan="5">Unit List</th></tr>
<tr>
<td class="hed">Sr.No</td>
<td class="hed">Unit Id</td>
<td class="hed">Date</td>
<td class="hed">Time </td>
<td class="hed">Location</td>
</tr>
<%!
Connection conn;
Statement st;
String sql,sql1,today;
int sr;
%>
<%
sr=1;
java.util.Date NewDate= new java.util.Date();
Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
today= NewFormatter1.format(NewDate);
try{
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();

	//sql="select * from allconnectedunits where VehNo='-' and TheDate='"+today+"' order by concat(TheDate,TheTime) desc";
	sql="select * from allconnectedunits where VehNo='-'  and UnitId <> '-' order by concat(TheDate,TheTime) desc";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
<tr>
<td class="bodyText"><div align="right"><%=sr%></div></td>
<td class="bodyText"><div align="right">
<a href="ShowCustomReportonTWMap.jsp?tripid=<%=rst.getString("UnitID")%>&vehcode=0&data=<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%>&data1=<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%>&ftime1=00&ftime2=00&ttime1=23&ttime2=59" title="Click to see 24 Hour History"><%=rst.getString("UnitID")%></a>
<!--<a href="unidentified_history.jsp?unitid=< %=rst.getString("UnitID")%>&data=< %=rst.getString("TheDate")%>" title="Click to see 24 Hour History">< %=rst.getString("UnitID")%></a>-->
</div></td>
<td class="bodyText"><%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
out.print(showdate);
%></td>
<td class="bodyText"><%=rst.getString("TheTime")%></td>
<td class="bodyText"><div align="left">
<a href="shownewmap.jsp?lat=<%=rst.getString("Latindec")%>&long=<%=rst.getString("LonginDec")%>&discription=<%=rst.getString("Location")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst.getString("Latindec")%>&long=<%=rst.getString("LonginDec")%>&discription=<%=rst.getString("Location")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("Location")%></a>
</div></td>
</tr>
	<%
sr++;
	}
}catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{
	try
	{
		conn.close();	
	}catch(Exception e)
	{}
	
}
%>
</table>



</td></tr>
</table>
<!-- end code -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

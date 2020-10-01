<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<%@ include file="Connections/conn.jsp" %>
<%@ include file="Manu.html" %>
<title>Vehicle Tracking System</title>
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<script type="text/javascript" src="js/ajax-dynamic-content.js"></script>
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-tooltip.js"></script>	
	<link rel="stylesheet" href="css/ajax-tooltip.css" media="screen" type="text/css">
	<link rel="stylesheet" href="css/ajax-tooltip-demo.css" media="screen" type="text/css">
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
</head>
<body bgcolor="lightyellow" onLoad="JavaScript:loadSearchHighlight();">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2">
          <img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop">         
          <img src="images/spacer.gif" width="2" height="0" alt=" " />
          </td>
          <td width="1%" height="2">
           <img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
          </tr> 
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
          <td width="98%" class="featureboxbg">
		<table border="0" width="100%" align="center" bgcolor="white">
<tr>
<td>
<table border="0" width="100%" align="center" bgcolor="white">
<tr>
<td>
<table border="0" align="left">
<tr>
<td>

<img src="images/cargologo.gif"  border="0" >
</a>
</td>
<td><font size="4" color="brown" face="verdana"><i><b>CRANE OVERLOAD MANAGEMENT SYSTEM</i></td>
<td>
<img src="images/ind11.jpg" width="300" height="70">
</td>
<td colspan="3"><img src="logo.jpg"></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<!-- menu comes here --->
<table border="0" align="right">
<tr>
	<%
			String userID = "";
			userID = session.getAttribute("user").toString();
			if (null == userID || userID=="") 
			{
			%>
				<td><a href="http://www.twtech1.com/" title="About Us" ><img src="images/aboutus.jpeg" border="0"></a></td>
				<td><a href="http://www.mobile-eye.in/contact.html" title="Contact Us"><img src="images/contactus.jpeg" border="0"></a></td>
				<td><a href="http://www.blog.transworld-compressor.com" title="Blog"><img src="images/blog.jpeg" border="0"></a></td>
				<td><a href="index.jsp" title="Login"><img src="images/login.jpeg" border="0"></a></td>
			<%
			}
			else
			{
				%>
				<td> <a href="slimain.jsp" title="Home"><img src="images/home.jpg" border="0">  </a> </td>
				<td background="images/orangebarsmall.jpg" width="100" height="20" align="left"><font color="Black" size="1"><b></>WelCome  :</font><font color="green" size="1"><b><%=session.getAttribute("dispalyname").toString() %></font></td>
		   		<td> <a href="changepass1.jsp" title="Change Password"><img src="images/changepass.jpeg" border="0"></a> </td>
		  		<td> <a href="logout.jsp" title="Logout"><img src="images/logout.jpeg" border="0"> </a> </td>
		  		
			<%
			}
		%>
 </tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table> 

			<!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
       <tr>
       <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
          <%!
          Connection conn;
          %>
          <%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement sessionst = conn.createStatement();
	Statement stquery=conn.createStatement();
	String sessionusername=session.getAttribute("user").toString().toUpperCase();
	String sessionsessionid=session.getId().toString();
	String sessionupdated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String sessionsql="update t_sessions set Updated='"+sessionupdated+"' where SessionId='"+sessionsessionid+"'";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sessionsql.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	
	sessionst.executeUpdate(sessionsql);
	String sessionlogout="select LoginStatus from t_sessions where Sessionid='"+sessionsessionid+"'";
	ResultSet logout=sessionst.executeQuery(sessionlogout);
	if(logout.next())
	{
		if(logout.getString("LoginStatus").equals("No"))
		{
			%>
			<form name="f1" action="serverMSG.jsp" method="get">
			</form>
			<script>
					document.f1.submit();
			</script>			
			<%
		}
	}

	//out.print(sessionsql);
}catch(Exception es)
{
	out.print("Session exception--->"+es);
}finally
{
	conn.close();
}
%>
			<!-- body part come here -->
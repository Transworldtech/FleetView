<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>*Vehicle Tracking System*</title>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-19595446-2']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
<script src="js/calender.js" type="text/javascript"></script>

<%@ include file="Connections/conn.jsp" %>
<%
String useType11=session.getAttribute("TypeofUser").toString();
String targetvalue=session.getAttribute("usertypevaluemain").toString();
String userid=session.getAttribute("user").toString();
//System.out.println(userid);
String targetvalue1=session.getAttribute("usertypevalue").toString();
//System.out.println("Targetvalue1::>>>"+targetvalue1);
ArrayList<String> target=(ArrayList<String>)session.getAttribute("TargetList");
if(target.contains(targetvalue))
{
	%>
	<%@ include file="Menu.html" %>
	 <%
}              
else 
	if(target.contains(targetvalue1))
	{
		%>
		<%@ include file="Menu.html" %>
		<%
	}
else
{
%>
	<%
}
%>
</head>
<body bgcolor="#FFE4E1" onLoad="JavaScript:initRotator(),loadSearchHighlight();" id="mainbody" >

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
<table border="0" align="center">
<tr>
<td>
<a href="images/logo.jpg" >
<img src="images/logo.jpg"  border="0" width="75" height="70">
</a>
</td>
<td>
<img src="images/ind11.jpg" width="300" height="70">
</td>
<td>
<%@ include file="imgrotate.html" %>
</td>
<td>
<!-- *********************The image given below is excluded************************** --->
<!-- <img src="images/your_ad_here.jpg" width="300" height="70"> -->
<!-- **********************end of changes done*********************************** --->
</td>
</tr>
</table>

</td>
</tr>
<tr>
<td>
<!-- menu comes here --->
<table border="0" align="left">
<tr><td>*</td>
</tr>
<tr>
	<%
			String userID = "";
			userID = session.getAttribute("user").toString();
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

Connection sessionconn;
Statement sessionst;
%>
          <%
try
{
	Class.forName(MM_dbConn_DRIVER);
	sessionconn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	sessionst = sessionconn.createStatement();
	Statement stqueryy=sessionconn.createStatement();
	String sessionusername=session.getAttribute("user").toString().toUpperCase();
	String sessionsessionid=session.getId().toString();
	String sessionupdated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String sessionsql="update t_sessions set Updated='"+sessionupdated+"' where SessionId='"+sessionsessionid+"'";
	
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
}
finally
{
 sessionst.close();
 sessionconn.close();
}
%>
			<!-- body part come here -->

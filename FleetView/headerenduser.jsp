<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>*Vehicle Tracking System*</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<script type="text/javascript">
var plstart = new Date();
window.onload=function() {
var plend = new Date();
var plload = plend.getTime() - plstart.getTime();

// determine the thresholds

if(plload<2000)
lc = "Very Fast";
else if (plload<5000)
lc = "Fast";
else if (plload<10000)
lc = "Medium";
else if (plload<30000)
lc = "Sluggish";
else if (plload<45000)
lc = "Slow";
else
lc="Very Slow";
var fn = document.location.pathname;
if( document.location.search)
fn += document.location.search;

try
{
pageTracker._trackEvent("Page Load",lc +
" Loading Pages", fn, Math.round(plload/1000));
}
catch(err)
{

}
}
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
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<script language="JavaScript1.2">
function regcomplaint(PageName)
{
	try{
		 //alert(e);
		// var PageName = document.getElementById("PageName").value;
		// PageName = "bcndsjh";
	window.open('RegisterComplaint.jsp?PageName='+PageName,'Win','width=730,height=400,top=200,left=200,scrollbars=yes');
	 
	 }catch(e)
	 {
		 alert(e);
	 }
}
</script>

<%@ include file="Connections/conn.jsp" %>
<%
Connection sessionconn=null;
Statement sessionst1=null;
Statement sessionst=null; 
String PageName=this.getClass().getName();
String reportno = "";

PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
System.out.println(PageName);
PageName=PageName.replace("_",".");
PageName=PageName.replace(".005f","_");
System.out.println(PageName);
try{
	Class.forName(MM_dbConn_DRIVER);
	sessionconn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	//sessionst = sessionconn.createStatement();
	sessionst1 = sessionconn.createStatement();
	Statement stqueryy=sessionconn.createStatement();
	Statement strno = sessionconn.createStatement();
String useType11=session.getAttribute("TypeofUser").toString();
String targetvalue=session.getAttribute("usertypevaluemain").toString();
String userid=session.getAttribute("user").toString();

//System.out.println(userid);
String sql = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName+"'";
ResultSet rs = strno.executeQuery(sql);
if(rs.next())
{
	reportno = rs.getString("ReportNo");
}
System.out.println(reportno);
%>
</head>
<body  onLoad="JavaScript:initRotator(),loadSearchHighlight();" id="mainbody" >
<table border="0" width="100%" align="center">
<tr>
<td>

<div id="header"><div id="logo"><img src="images/TW-MobileEyeLogo1.PNG" alt="Google Apps" height="70" width="100"></div>
<script src="js/dw_rotator.js" type="text/javascript"></script>
<script type="text/javascript">
function initRotator() {
    // arguments: image name, rotation speed, (optional) path to images
    var rotator1 = new dw_Rotator('img1', 1000, "images/");
    // add the images to rotate into that image object  
    rotator1.addImages("l1.jpg","l2.jpg", "l3.jpg", "l4.jpg", "l5.jpg", "l6.jpg", "l7.jpg","l8.jpg","demo.png","foodland.png","FirstFlight.bmp","ndtv.png","darcl.png","DHL.jpg","rpa.jpg","casby.jpg","safeNsecure.png");
    //rotator1.rotate(); // sometimes may want to call rotate here
    dw_Rotator.start();
}
</script>
<div id="logo1"><img name="img1" src="images/l1.jpg" width="100" height="70" alt="Customer Logo" ></div></div>

<!-- menu comes here --->
<div id="navigation"><ul><div id="navigationBlank" style="visibility: visible;">
<%
			String userID = "";
			userID = session.getAttribute("user").toString();
			%>

			
			<li class=""> <a href="opentrips.jsp" title="Open Trips">Open Trips</a></li>
			
			
			<%
			
			sessionst=sessionconn.createStatement();
			String sessionusername=session.getAttribute("user").toString().toUpperCase();
			String sessionsessionid=session.getId().toString();
			String sessionupdated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
			String sessionsql="update t_sessions set Updated='"+sessionupdated+"' where SessionId='"+sessionsessionid+"'";
			
			/*Query to insert query in db_gps.t_sqlquery table*/
			/*String abcd=sessionsql.replace("'","#");
			abcd=abcd.replace(",","$");
			stqueryy.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");*/
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
			</div>
			<div id="navigationRight">
			<li class=""> <a href="logout.jsp" title="Logout">Log Out</a> </li>
			
		</div></ul>
	</div>
	</td>
	</tr>
	<tr>
		<td>
		<div>
		<input type="hidden" name="PageName" id="PageName" value="<%=PageName %>"/>
		 <a href="#" onclick="regcomplaint('<%=PageName %>')" title="Register Complaint">Register Complaint</a>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="black"> Report No.: <%=reportno %></font>
		</div>
		</td>
		</tr>
		</table>	
	</table>
	</body>
	</html>

			
	
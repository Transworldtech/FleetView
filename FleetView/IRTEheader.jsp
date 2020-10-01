<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">

<%@ include file="Connections/conn.jsp" %>

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
<div id="logo1"><img name="img1" src="images/l1.jpg" width="100" height="70" alt="Customer Logo" ></div></div>
<div id="navigation"><ul><div id="navigationBlank" style="visibility: visible;">
	<li class=""><a href="changepasswordforIRTE.jsp?parameter=tech" title="changepass">Change Pass.</a></li>
	
</div>
<div id="navigationRight">
			<li class=""> <a href="logout.jsp" title="Logout">Log Out</a> </li>
		</div>
</td>
</tr>
<tr>
		<td>
		<div>
		
		<%!
          Connection sessionconn;
          %>
		<%
		
		try{
			Class.forName(MM_dbConn_DRIVER);
			sessionconn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			Statement sessionst = sessionconn.createStatement();
			Statement stquery = sessionconn.createStatement();
			String sessionusername=session.getAttribute("user").toString().toUpperCase();
			String sessionsessionid=session.getId().toString();
			String sessionupdated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		String reportno="";
		
		String PageName=this.getClass().getName();

		PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
		System.out.println(PageName);
		
		
		String sql = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName+"'";
		ResultSet rs = stquery.executeQuery(sql);
		if(rs.next())
		{
			reportno = rs.getString("ReportNo");
		}
		System.out.println(reportno);
		
		
		
		%>
		
		
		
		
		
		
		
		
		
		
		
		<input type="hidden" name="PageName" id="PageName" value="<%=PageName %>"/>
		 <a href="#" onclick="regcomplaint('<%=PageName %>')" title="Register Complaint">Register Complaint</a>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="black"> Report No.: <%=reportno %></font>
		</div>
		</td>
		</tr>

</table> 

			<!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
     
        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
          
          <%

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
	sessionconn.close();
}
%>
			<!-- body part come here -->

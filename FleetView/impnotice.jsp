<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System </title>

<link href="common/genomics.css" rel="StyleSheet" type="text/css"></link>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> </link>
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css"></link>
<link rel="stylesheet" type="text/css" href="css/update.css"></link>
</head>
<body>
<table border="0" width="100%" align="center" bgcolor="#FFFAFA">
<tr>
<td>

<table border="0" width="100%" bgcolor="#F8F8FF">
<tr>
<td rowspan="2" align="center" width="13%">
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

function insrtop(opt,user,pass)
{
	//alert("opt "+opt+"   user  "+user+"  pass  "+pass);
	window.location.href="impnoticeinsert.jsp?opt="+opt+"&user="+user+"&Password="+pass;
}

function opemmap(user,pass)
{
	var url = "SampletransworldmapView.jsp";
	testwindow = window.open(url,'_blank');
	testwindow.focus();
}
</script>
<div id="logo1"><img name="img1" src="images/l1.jpg" width="100" height="70" alt="Customer Logo" ></div></div>

<div id="navigation"><ul><div id="navigationBlank" style="visibility: visible;">

<li></li>

</div>
</td>
</tr>


</table>

</td>
</tr>
<tr></tr>
</table>

<script src="elabel.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="common/genomics.css" rel="StyleSheet" type="text/css">

<%@ include file="Connections/helpconn.jsp" %>
<body  onLoad="JavaScript:initRotator(),loadSearchHighlight();" id="mainbody" >

<%
try
{
	System.out.println("\nnotice-->>");
	 ResultSet rs2=null, rs3=null;
	 Statement st = null;
	  String sql2="", sql3="";
	 st = getDattabase.createStatement();
	 String logininfo = "";
	 String user=request.getParameter("user");
	  String user2=request.getParameter("user").toString().toUpperCase();;
	 String pass=request.getParameter("Password");
	 String page1 = request.getParameter("page");
	 String msg = "";
	 String sessionid=session.getId().toString();
 	System.out.println("\nsessionid-->>"+sessionid);
 	session.setAttribute("usertest",user);
	 %>
	 <input type="hidden" name="user" value="<%=user %>"></input>
	 <input type="hidden" name="Password" value="<%=pass %>"></input>
	 <%
	 String checkuserlogin="select * from db_gps.t_sessions where SessionId='"+sessionid+"' AND ActiveStatus='Yes' AND UserName <> '"+user2+"'";
 	System.out.println("\n\n checkuserlogin--->>"+checkuserlogin);
 	ResultSet checkloginrs=getStatement.executeQuery(checkuserlogin);
 	if(checkloginrs.next())
	{
 		System.out.println("\n\n already login!!!!!!!!!!!!");
		%>
		<table align="center" width="80%" bgcolor="white" border="0">
			<tr><td align="center"></td></tr>
		<tr><td align="center"></td></tr>
			<tr><td align="center"></td></tr>
		<tr><td align="center"></td></tr>
			<tr><td align="center"></td></tr>
		<tr><td align="center"></td></tr>
			<tr><td align="center"></td></tr>
		<tr><td align="center"></td></tr>
		<tr><td><font color="red" size="3"><center><b><i>Sorry !! Somebody has already logged in to myfleetview.com using this system. Please logout if you want to login again.</i></b></center></font>
		
				
		<tr><td align="center"><a href="index.jsp">Back To Home Page</a></td></tr>
		<tr><td align="center"></td></tr>
		<tr><td align="center"></td></tr>
		</table>
		
		<%
	}
 	else
 	{
 		String todaysdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    	String todaysdate1 = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
 		
    	sql3="SELECT * FROM db_gps.t_security where Username='"+ user +"' and Password='"+pass+"' and ( ActiveStatus = 'NO' or CreationDate > '"+todaysdate+"' or ExpiryDate < '"+todaysdate1+"')";
    	rs3=getStatement.executeQuery(sql3);
    	if(rs3.next())
    	{
    		logininfo=rs3.getString("ActiveStatus");	
    	 %>
    		<br> <br>
    		<center>
    		<font> <B> <I> This Login Id is blocked. Please login with your new Id which has already been mailed to you. If you haven't got any mail regarding new ID, please send one email from your official Id contating your Old Login Id for FleetView to Ajay Laddha at a_laddha@myfleetview.com. You can also contact him on +9120-41214444 Or +919321424980</I> </B> </font> 
    	<br> <br>
    		<a href="index.jsp"> Log Out</a> 
    <%	}
    	else
    	{
    		
    		String sql1 = "SELECT * FROM t_security where Username='"+ user +"' and Password='"+pass+"'";
            //System.out.println(sql1);
    	    ResultSet rs1 = getStatement.executeQuery(sql1);
    	    
            if(rs1.next())
            {
    	
	 String sql = "select * from db_gps.t_captureopt where optionentered in ('opt1','opt2') and username = '"+user+"' ";
	 System.out.println("***  "+sql);
	rs2 = st.executeQuery(sql);
	if(rs2.next())
	{
		if(page1==null || page1.equalsIgnoreCase("null"))
		{
			msg = "2";
		}
		else
			if(page1 == "userinfo" ||  page1.equalsIgnoreCase("userinfo"))
		{
			msg = "1";
		}
		
	}
	else
	{
		msg = "1";
	}
	
	if(msg == "2" || msg.equals("2"))
	{
		response.sendRedirect("userinfo.jsp?user="+user+"&Password="+pass);
	}
	else
	{
	 %>
	 <h2 style="text-align: center;">IMPORTANT NOTIFICATION REGARDING GOOGLE MAP</h3>
	 <div style="text-align: justify;margin-left: 5em;margin-right: 5em;">
	 <font size = "2" face = "Arial">Customers maybe aware that Transworld so far was one of the few (or only?) service providers who do not use either pirated software or map data. 
	 So far, Transworld was absorbing the costs associated with the Google Maps server and data. We have now been advised by Google that their charges for map data will be revised 
	 by upto 300% of the present levels.  We have always had our own map servers and data - since Google Maps were better updated and ergonomic, we paid for and used Google. <br><br> 
We have made arrangements to use our own map servers and data - remember, one of our specific abilities is in the GIS (Geographical Information Systems) domain. Transworld also 
owns various map data and will also use freely available data from various government / online / open sources. Going forward, customers have two options:
<br><br><b>OPTION 1</b><br>Do nothing - you will be migrated to Transworld's map servers and data at no additional cost at this time. We do not intend to charge any additional 
fee for the same for the duration of your contract period. Please note that the look and feel of our map servers and data may not be as ergonomic or as detailed as Google Maps. As we 
go along, we may add enhancements or other capabilities on a paid basis - however, we promise that as long as your present existing contracts with us remain valid and duly paid up, we 
will not charge you anything for the basic use of maps for viewing locations and data as you do presently. Use of Transworld's maps, map data and your data on Transworld's maps 
and servers will always be subject to Transworld's terms of use.
<br><br><b>OPTION 2</b><br>
Choose to continue to use Google Maps - for this you will need to pay $12 per annum, per vehicle UPFRONT. For example, if you have 100 vehicles online, you will need to remit the
 equivalent of US$1200 +Taxes on or before 08 September 2012 to Transworld. You are also welcome to independently negotiate your own agreement with Google - once completed, 
 you can give us the access details and we will incorporate them into your account at a small integration charge of 10% of the amount you pay Google. Use of Google Maps, data and 
 your data on Google Maps will always be subject to Googles terms of use, in addition to Transworld's terms of use.<br><br>
 If you need more information or have any questions about this issue, you are welcome to send an email or call customer support. This is an important notification and in the event 
 that you wish to exercise your option to continue with Google Maps, you must remit payment <u>on or before 08 September 2012.</u><br><br>
Transworld reserves the right to accept or decline your offer to pay under this option in case total number of paid subscriptions do not hit a number deemed minimum viable by 
Transworld. Nothing however stops you from independently negotiating your own agreement with Google.<br><br>
By hitting the CONFIRM button, you acknowledge that you have read and understood the notification.</font>
<br><br><br>
<div style="text-align: center;">
<input type="submit" value="CONFIRM - Migrate me." onclick="insrtop('opt1','<%=user %>','<%=pass %>')"></input>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value="I want to use Google Maps,Please send me proforma invoice." onclick="insrtop('opt2','<%=user %>','<%=pass %>')"></input>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="View Sample Transworld Map" onclick="opemmap('<%=user %>','<%=pass %>');"></input>
</div>
	 </div>
	 <br></br>
	 <br></br>
	 <br></br>
	 <%
	}
            } 
            else
            {
    		response.sendRedirect("index.jsp?err=err");
            }
 	}
 	}
}
catch(Exception e)
{
    System.out.println(e);
}
finally
{
	try
	{
		getStatement.close();
		
	}catch(Exception e)
	{
		
	}
	try
	{
		getDattabase.close();
	}catch(Exception e)
	{
		
	}
	
}
%>




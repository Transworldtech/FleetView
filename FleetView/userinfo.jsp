<%@page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>

<script language="javascript">
  function validate()
  {
    
	var fnam=document.userinfo.fname.value;
        var lnam=document.userinfo.lname.value;
        var mob=document.userinfo.mobno.value;
        var emai=document.userinfo.email.value;
        var desi=document.userinfo.desig.value;
        var loca=document.userinfo.loc.value;

        if(fnam=="") 
        {
 		alert("Please enter your First Name");
		return false;
 	}
	
	 if(lnam=="") 
        {
 		alert("Please enter your Last Name");
		return false;
 	}

 	/*if(mob.length<10 || mob.length>10)
 	{
        	alert("Please enter proper 10 digit Mobile No");
		return false;
		
	}*/
	if(isNaN(mob))
	{
		alert("Please enter proper Mobile No");
		return false;
	}


	 if(emai=="") 
        {
 		alert("Please enter your Email Id");
		return false;
 	}
	else
	{
	        //emai=document.getElementById("email").value;
		var sss=validateEmail(emai);
		if(!sss)
			{
				alert("Please enter valid Email Id");
				return false;
			} 
	} 
     return true;
  }

function validateEmail(email)
{
     var splitted = email.match("^(.+)@(.+)$");
    if(splitted == null) return false;
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
	    var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
	    if(splitted[2].match(regexp_ip) == null) return false;
      }// if
      return true;
    }
return false;
}

function openpopup(PageName)
{
	 try{
		 //alert(e);
	 testwindow=window.open("RegisterComplaint.jsp?PageName="+PageName,"Register Complaint","width=700,height=400,scrollbars=yes");
	 testwindow.moveTo(200,200);
	 }catch(e)
	 {
		 alert(e);
	 }
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

function sendMail(emailid, otp,username)
{
	//alert("in function ");	
	//alert(emailid);
	//alert(otp);
//user="a_kalaskar@transworld-compressor.com";
//pass="1234";
	var ajaxRequest;
	//alert("1");
	try
	{
     // Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
		//alert("2");
	}  
	catch (e)
	{
     // Internet Explorer Browsers
     	try
        {
          ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
     	} 
        catch (e)
        {
	    	try
             {
	        	ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
	    	 } 
             catch (e)
             {
	           // Something went wrong
                alert("Your browser broke!");
		   		return false;
         	}
     	}
  	}
	//alert("3");
	/* ajaxRequest.onreadystatechange = function()
	{
    	if(ajaxRequest.readyState == 4)
    	{
          	var reslt=ajaxRequest.responseText;
          	alert(reslt);
          	alert("result is before :- "+reslt);
          	reslt=reslt.replace(/^\s+|\s+$/g,"");
			alert("result is after :- "+reslt);
          	if(reslt=="Success")
          	{
          		alert("Email has been sent successfully.");
          	}	
          	alert("the result is:- "+reslt);
		} 
	}
	
	alert("5");
	ajaxRequest.open("get","passwordsendmail.jsp?EmailId="+EmailId+"&Password="+OTP,true);
	ajaxRequest.send(); */
	
	ajaxRequest.onreadystatechange=function()
	  {
	  if (ajaxRequest.readyState==4 && ajaxRequest.status==200)
	    {
		  var reslt=ajaxRequest.responseText;
		  
        	alert("Email Sent Sucessfully on These Mail-Id:- "+emailid);
	    }
	  }
	ajaxRequest.open("GET","passwordsendmail.jsp?EmailId="+emailid+"&Password="+otp+"&UserName="+username,true);
	ajaxRequest.send();
	
}

</script>

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
<form name="userinfo" method="get" action="userinfoinsrt.jsp" onSubmit="return validate();" >

<%
try
{

        
        ResultSet rs2=null, rs3=null,rs5=null,rs12=null,rs13=null,rs14=null;
        String sql2="", sql3="",sql5="",sql14="";
        String fnamelist="", lastnamelist="", mobnolist="", emaillist="", desiglist="", loclist="", logininfo="",VideoLink="",UserTypeValue="",TypeValue="";
        String firstname="",lastname="",RecordDate="",RecordTime="",recorddate="",recordtime="",EmailId="",UserName="";
        int Datedifference=0,NoOfDays=0;
	    String newuser=request.getParameter("newuser");
		 
	    Statement stlink=getDattabase.createStatement();
	    Statement st = getDattabase.createStatement();
        String user=request.getParameter("user");
        String user2=request.getParameter("user").toString().toUpperCase();;
        String pass=request.getParameter("Password");
        String sessionid=session.getId().toString();
    	System.out.println("\nsessionid-->>"+sessionid);
    	String option = "",reportno="";
    	
    	String PageName=this.getClass().getName();
    	PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
    	System.out.println(PageName);
    	PageName=PageName.replace("_",".");
    	PageName=PageName.replace(".005f","_");
    	System.out.println(PageName);
    	
    	
    	
    	String sql = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName+"'";
    	PreparedStatement stpre=getDattabase.prepareStatement(sql);
    	ResultSet rs = stpre.executeQuery();
    	if(rs.next())
    	{
    		reportno = rs.getString("ReportNo");
    	}
    	
    	//String checkuserlogin="select * from db_gps.t_sessions where SessionId='"+sessionid+"' AND ActiveStatus='Yes' AND UserName <> '"+user2+"'";
    	String checkuserlogin="select * from db_gps.t_sessions where SessionId=? AND ActiveStatus='Yes' AND UserName <> ?";
    	System.out.println("\n\n checkuserlogin--->>"+checkuserlogin);
    	PreparedStatement stpre1=getDattabase.prepareStatement(checkuserlogin);
    	stpre1.setString(1,sessionid);
    	stpre1.setString(2,user2);
    	ResultSet checkloginrs=stpre1.executeQuery();
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
			
					
			<tr><td align="center"><a href="index.html">Back To Home Page</a></td></tr>
			<tr><td align="center"></td></tr>
			<tr><td align="center"></td></tr>
			</table>
    		
    		<%
    		
    	}
    	else
    	{
    		
    	
    	String todaysdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    	String todaysdate1 = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        //out.print(pass); 

	//sql3="SELECT * FROM t_security where Username='"+ user +"' and Password='"+pass+"'";
	//sql3="SELECT * FROM db_gps.t_security where Username='"+ user +"' and Password='"+pass+"' and ( ActiveStatus = 'NO' or CreationDate > '"+todaysdate+"' or ExpiryDate < '"+todaysdate1+"') ";
	sql3="SELECT * FROM db_gps.t_security where Username=? and Password=? and  ActiveStatus = 'NO' and ExpiryDate < ? ";
	PreparedStatement stpre2=getDattabase.prepareStatement(sql3);
	stpre2.setString(1,user);
	stpre2.setString(2,pass);
	//stpre2.setString(3,todaysdate);
	stpre2.setString(3,todaysdate1);
	System.out.println("sql3 in if loop:-"+sql3);
	rs3=stpre2.executeQuery();
	if(rs3.next())
	{
		logininfo=rs3.getString("ActiveStatus");
		TypeValue=rs3.getString("TypeValue");
	 %>
		<br> <br>
		<center>
<!-- 		<font> <B> <I> This Login Id is blocked. Please login with your new Id which has already been mailed to you. If you haven't got any mail regarding new ID, please send one email from your official Id contating your Old Login Id for FleetView to Ajay Laddha at a_laddha@myfleetview.com. You can also contact him on +9120-41214444 Or +919321424980</I> </B> </font>  -->
		<font><B><I>This Login Id is blocked. Please contact our support team for further resolution.avlsupport@mobile-eye.in Phone : +9120-41214444 +919762007124 +919762007125  +919766652984        </I> </B> </font>
	<br> <br>
	
	<% 
		java.util.Date now = new java.util.Date();
			String sss=new SimpleDateFormat("yyyy-MM-dd").format(now);
			String tt= new SimpleDateFormat("HH:mm:ss").format(now);
			String sql11="insert into db_gps.t_blockuserloginattempts(RecordDate,RecordTime,Comments,TypeValue,UserIp,SessionID) values('"+sss+"','"+tt+"','"+user+"','"+TypeValue+"','"+request.getRemoteAddr()+"','"+sessionid+"')";
			int eee=getStatement.executeUpdate(sql11);
			System.out.println("Block user info stored--->"+eee); 
			%>
		<a href="index.html"> Log Out</a> 
<%	}
	else
	{
	
		System.out.println("in else............");
		//sql5="select * from db_gps.t_usermessage where MessageId in ('4','5','6')";
		sql5="select * from db_gps.t_security a inner join db_gps.t_usermessage b on a.TypeValue=b.UserTypeValue where a.Username='"+ user +"' and a.Password='"+pass+"' and b.MessageID in ('4','5','6')";
		System.out.println("sql5 is:-"+sql5);
		rs5=getStatement.executeQuery(sql5);
		if(rs5.next())
		{
			System.out.println("in sql5............");
			UserTypeValue=rs5.getString("UserTypeValue");    		
		 %>
			<br> <br>
			<center>
	<!-- 		<font> <B> <I> This Login Id is blocked. Please login with your new Id which has already been mailed to you. If you haven't got any mail regarding new ID, please send one email from your official Id contating your Old Login Id for FleetView to Ajay Laddha at a_laddha@myfleetview.com. You can also contact him on +9120-41214444 Or +919321424980</I> </B> </font>  -->
			<font><B><I>This Login Id is blocked. Please contact our support team for further resolution.avlsupport@mobile-eye.in Phone : +9120-41214444 +919762007124 +919762007125  +919766652984        </I> </B> </font>
		<br> <br>
		<% 
		java.util.Date now = new java.util.Date();
			String sss=new SimpleDateFormat("yyyy-MM-dd").format(now);
			String tt= new SimpleDateFormat("HH:mm:ss").format(now);
			String sql11="insert into db_gps.t_blockuserloginattempts(RecordDate,RecordTime,Comments,TypeValue,UserIp,SessionID) values('"+sss+"','"+tt+"','"+user+"','"+UserTypeValue+"','"+request.getRemoteAddr()+"','"+sessionid+"')";
			int eee=getStatement.executeUpdate(sql11);
			System.out.println("Block user info stored--->"+eee); 
			%>
				
		<a href="index.html"> Log Out</a> 
	<%	}

		else
		{
			System.out.println("In 2 nd else");
	        //String sql1 = "SELECT * FROM t_security where Username='"+ user +"' and Password='"+pass+"'";
	        
			String sql13="select NoOfDays from db_gps.t_lastloginblockaccess";
			System.out.println("sql13:-->"+sql13);
        	rs13=getStatement.executeQuery(sql13);
        	if(rs13.next()){
        		 NoOfDays=rs13.getInt("NoOfDays");
        		 System.out.println("No of days:-"+NoOfDays);
        	}
	        
	        //String sql12="select RecordDate,RecordTime from db_gps.t_loguseractivity where Comments='"+ user +"'";
	       // String sql12="select RecordDate,RecordTime from db_gps.t_loguseractivity where Comments='"+ user +"' order by RecordDate desc limit 1";
	        //String sql12="select RecordDate,RecordTime from db_gps.t_loguseractivity where Comments= '"+ user +"' and RecordDate=CURDATE() - INTERVAL 1 DAY limit 1";
	        String sql12="select datediff(curdate(),RecordDate) as Datedifference,recorddate,recordtime from db_gps.t_loguseractivity where Comments='"+ user +"' order by  RecordDate desc limit 1";
	        System.out.println("sql12:-->"+sql12);
	        rs12=getStatement.executeQuery(sql12);
	        if(rs12.next())
	        {
	        	//query
	        	 Datedifference=rs12.getInt("Datedifference");
	        	 recorddate=rs12.getString("recorddate");
	        	 recordtime=rs12.getString("recordtime");
	        	 System.out.println("Datedifference:-->"+Datedifference);
	        	 System.out.println("recorddate:-->"+recorddate);
	        	 System.out.println("recordtime:-->"+recordtime);
	        	 /* RecordDate=rs12.getString("RecordDate");
	        	 RecordTime=rs12.getString("RecordTime"); */
	        	 /* java.util.Date now = new java.util.Date();
	 			String sdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now);
	 		   	String newRecordDate=RecordDate + " " +RecordTime ;
	        	String day= sdate;
	        	String sysdate=new SimpleDateFormat("yyyy-MM-dd").format(now);
	        	java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd").parse(sysdate);
	            java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd").parse(RecordDate);
	            long currdate=dt.getTime();
	            long recorddate=dt2.getTime(); */
	                       
	        }
	              
	        if(Datedifference>NoOfDays)
            {
            	System.out.println("come on......");
            	sql14="select * from t_userdetails where UserName='"+user+"' limit 1";
    	 		rs14=getStatement.executeQuery(sql14);
    	 		if(rs14.next())
    	 		{
    	 			EmailId=rs14.getString("Email");
    	 			UserName=rs14.getString("UserName");
    	 		}
    	 		String OTP=RandomStringUtils.randomAlphanumeric(8);
				System.out.println(OTP);
            	out.println("You are not Logged In from last 30 days,you required to reset your password.");%>
            	<a href="javascript:flase" onclick="sendMail('<%=EmailId%>','<%=OTP%>','<%=UserName%>');"> Click Here </a>
            	
            <%	out.println("For receive email for password.");%>
            		<br><br>
            <a href="index.html"> Log Out </a>
            <br>
            <p><font size="2"> Note: User is required to be an register email id. If it is not, you will not receive any email for password.<br><br>Please contact support :<br>avlsupport@mobile-eye.in<br>Ph : +91 20 41303040, 4121444</font></p>
            <% } 
	        
	        else {
	        	
	        
	        String sql1 = "SELECT * FROM t_security where Username=? and Password=?";
	        System.out.println(sql1);
		    stpre2=getDattabase.prepareStatement(sql1);
		    stpre2.setString(1,user);
		    stpre2.setString(2,pass);
	        ResultSet rs1 = stpre2.executeQuery();
		    
	        if(rs1.next())
	        {
	           System.out.println("Hii");
			   session.setAttribute("user",user);
			   session.setAttribute("pass",pass);
			   String user1=request.getParameter("user");
			   session.setAttribute("mainuser",user);
			   System.out.println("189 "+user);
			   System.out.println("190 "+pass);
			   System.out.println("mainuser "+pass);
	session.setAttribute("TYPEVALUEUSER",rs1.getString("TypeValue").trim());
	 		   sql2="select * from t_userdetails where UserName='"+user+"' limit 1";
	 		//out.print(sql2);
	                rs2=getStatement.executeQuery(sql2);
	                if(rs2.next() && newuser==null)
			{ 
			
			%>
				<center>
				<table border="0" width="50%" class="stats">
				  <tr>
	<!--				<td> <font> If your name is in the list, please click on that. If not, click  <a href="userinfo.jsp?user=< %=user %>&Password=< %=pass %>&newuser=yes">Here </a></font> </td>-->
				  </tr>
				</table>
	<!--		<div align="right" style="margin-right: 1em;">-->
	<!--		<font size="2" face="Arial">Important Notification Regarding Google Map.... <a href="impnotice.jsp?user=< %=user %>&Password=< %=pass %>&page=userinfo"> click here </a> to view the details</font>-->
	<!--		</div>-->
	<!-- ************************************************************************************************************************************** -->	 
	 			
						
				

				
	           <%	}
	              
	 	         else
			{ 
			    System.out.println("Hii");
			   %>
	                        <center>
	  			<table border="0" width="100%" class="stats">
				  <tr>
					<td align="center"> <font> Please fill up this form</font> </td>
				  </tr>
	 			</table>

	          <table border="0" width="100%">
	  <tr>
	      <td>
	             <div align="left"> <a href="javascript:history.go(-1)"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a> </div>
	     </td> 
	  </tr>
	</table>   		<center>
	 			<table border="1"  class="sortable_entry">
				  <tr>
					<td colspan="2" align="center"> <font > <div align="center" size="2"><b>Your Details</b></div></font> </td>
				  </tr>
				  <tr>
					<td> <div align="right"><font color="red"> * </font> <b>First Name :</b></div></td>
					<td> <input type="text" name="fname" /> </td>
				  </tr>
				  <tr>
					<td> <div align="right"> <font color="red"> * </font> <b>Last Name :</b></div></td>
					<td> <input type="text" name="lname" /> </td>
				  </tr>
				  <tr>
					<td> <div align="right"> <b>Mobile No. :</b></div></td>
					<td> <input type="text" name="mobno"  /> </td>
				  </tr>
				  <tr>
					<td><div align="right">  <font color="red"> * </font> <b>Email :</b></div></td>
					<td> <input type="text" name="email" /> </td>
				  </tr>
				  <tr>
					<td> <div align="right"> <b>Designation :</b></div></td>
					<td> <input type="text" name="desig" /> </td>
				  </tr>
				  <tr>
					<td><div align="right">  <b>Location :</b> </div></td>
					<td> <input type="text" name="loc"  /> </td>
				  </tr>
				  <tr>
	            			<td colspan="2" align="center"> <div align="center"><input type="submit" name="submit" value="Submit"> </div> </td>
				  </tr>
	 			
		<%	}
	                rs2.first();
			rs2.previous();
			int i=0; 
	                if(newuser==null)
	                {
	 		   while(rs2.next())
			   {
				i++;
				fnamelist=rs2.getString("FirstName");
				lastnamelist=rs2.getString("LastName");
				mobnolist=rs2.getString("MobNo");
				emaillist=rs2.getString("Email");
				desiglist=rs2.getString("Designation");
				loclist=rs2.getString("Location");
				session.setAttribute("rfname",fnamelist);
				session.setAttribute("rlname",lastnamelist);
				session.setAttribute("phno",mobnolist);
				session.setAttribute("email",emaillist);
				
				session.setAttribute("fname",fnamelist);
				session.setAttribute("lname",lastnamelist);
			//	session.setAttribute("phno",mobnolist);
			//	session.setAttribute("email",emaillist);
				
			System.out.println(firstname+""+lastname);
			System.out.println(session.getAttribute("rfname")+" <><><><><><> "+session.getAttribute("rlname"));
			System.out.println("--------------------------------------------------------------------------------------------------------");
			
		 	 sql = "select * from db_gps.t_captureopt where username = '"+user+"' ";
			 rs = st.executeQuery(sql);
			if(rs.next())
			{
				option = rs.getString("optionentered");
			}
			%>
	 		
				
				<div>
	<font size="2"> 
				<!-- Dear Customer, your use of this website and data constitutes your acceptance of our <a href="http://myfleetview.com/FleetViewTest/termsofuse.jsp" target="_BLANK">terms of use. </a> -->
				Dear Customer, your use of this website and data constitutes your acceptance of our <a href="#" onclick="javascript:window.open('http://myfleetview.com/FleetView/termsofuse.jsp','','menubar=1,resizable=1,width=1200,height=500,location=no'); " >terms of use. </a>
	<!-- 		Dear Customer, your use of this website and data constitutes your acceptance of our terms of use. </a> -->
			
			</font>
			</div>

		<div>

			<a href="sessionvalidate.jsp?phno=<%=mobnolist %>&email=<%=emaillist %>&fname=<%=fnamelist %>&lname=<%=lastnamelist %>"> I AGREE </a>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="logout.jsp"> LOG ME OUT </a>
			</div>

			<%			
			  }   
	 	       }	
	               %>
	 			</table>
	 			</center>
	 			 </center>
	 			
	 			<IFRAME src='http://myfleetview.com/index.php?option=com_content&amp;view=article&amp;id=1&amp;itemId=115' scrolling=auto	 id='banner1' width='1350' height='500'
						style='padding-top: 1; padding-left: 1;' frameborder='0'></IFRAME>
	 			 			
	 			
	 			<!-- 
	 			<table border="0" width="100%">
	 			<tr>
	 			<td>
	 			<div align="left" style="margin-left: 2em; border-style: ridge;width: 38em; border-color: green;">
	 			<table border="1" class="sortable" style="margin-left: 0.2em;">
	 			<div align="left" style="margin: 0.4em;"><font color="red" size="3" face="cooperblack"><b>New Addition - Vehicle Master </b></font><br></br><br></br><font  color="darkgreen" size="4">You can add your vehicle details in Fleetview now.<br>Please use following links.
	 			</font><br></br><br></br>
	 			<font size="4"><b>Master Entry: </b></font><font  color="darkgreen" size="4">Data Entry --> <!-- Vehicle Master</font><br>
	 			<font size="4"><b>View Report: </b></font><font  color="darkgreen" size="4">Report --> <!-- Vehicle divMaster Report</font><br>
	 			<br>
	 			</br>
	 			<br></br><font size="4" face="cooperblack" color="red"><b>Upcoming </b></font><br></br><br><font  color="darkgreen" size="4"><b>Upload vehicle documents like RCBook, photo,
	 			insurance papers etc.</b></font></div>
	 			</table>
	 			<br></br>
	 			</div>
	 			<br>
	 			<br>
	 			<br>
	 			<br>
	 			</td>
	 			
	 			<td align="right" style="margin-left: 0.4em;">
	 			<div align="left" style="margin-right: 2em; border-style: ridge;width: 50em;border-color: green;">
	 			<table align="center" width="80%" style="margin: 0.4em;">
	 			<tr>
	 			<td align="justify"><font color="red" size="3" face="cooperblack"><b>TRANSWORLD</b></font> <font   color="darkgreen" size="3">Congratulates <b>Mr. Raja Saraogi</b> of <b>Coastal Roadways Ltd</b>. 
	for the remarkable achievement of being awarded  the  </font><font  size="3"><b>Best Primary 
	Transporter 2011</b></font><font  color="darkgreen" size="3">  award  from <b>BPCL</b> for the <u>Second consecutive year</u>.</font>
	</td>
	 			</tr>
	 			</table>
	 			
	 			<table>
	 			<tr>
	 			<td><img src="images/RajaSaraogi.png"  alt="RajaSaraogi"></img></td>
	 			<td>
	 			<table  align="center" width="100%">-->
	 			<!--<tr><td colspan="3"><img src="images/RajaSaraogi.jpeg"></img></td></tr>-->
	 			<!-- <tr><td class="bodyText"><font  color="darkgreen" size="3">Award</td><td class="bodyText"><font color="darkgreen" size="3">:</font></td><td class="bodyText"><font  color="darkgreen" size="3">Best Primary Transporter 2011</font></td></tr>
	 			<tr><td class="bodyText"><font  color="darkgreen" size="3">Function</font></td><td class="bodyText"><font color="darkgreen" size="3">:</font></td><td class="bodyText"><font color="darkgreen" size="3">BPCL Annual C&F Meet</font></td></tr>
	 			<tr><td class="bodyText"><font  color="darkgreen" size="3">Date</font></td><td class="bodyText"><font color="darkgreen" size="3">:</font></td><td class="bodyText"><font   color="darkgreen" size="3">9th February 2012</font></td></tr>
	 			<tr><td class="bodyText"><font  color="darkgreen" size="3">Venue</font></td><td class="bodyText"><font color="darkgreen" size="3">:</font></td><td class="bodyText"><font  color="darkgreen" size="3">Hotel Pride, New Town, Kolkata</font></td></tr>
	 			<tr><td class="bodyText"><font  color="darkgreen" size="3">Client</font></td><td class="bodyText"><font color="darkgreen" size="3">:</font></td><td class="bodyText"><font  color="darkgreen" size="3">Bharat Petroleum Corp Ltd., Lubes</font></td></tr>
	 			<tr><td class="bodyText"><font  color="darkgreen" size="3">Winner</font></td><td class="bodyText"><font color="darkgreen" size="3">:</font></td><td class="bodyText"><font  color="darkgreen" size="3">Coastal Roadways Limited</font></td></tr>
	 			</table>
	 			</td>
	 			</tr>
	 			</table>
	 			</div>
	 			</td>
	 			</tr>
	 			</table>
	 			<br>
	 			<br>
	 			<br>
	 			<br>
	 			<br>
	 			<br>-->
	 			<%
	if(user.toUpperCase().equals("N_DOSHI"))
	{
		%>
		<a href="http://myfleetview.com/Skyone/imagereport.jsp">Click Here For Mobile Application</a>
		<% 
	}
	%>
	   
	           				
	<%       } 
	        else
	        {
			response.sendRedirect("index.html");
	        }

		}//inner else
		}//1st else
		
		
	}//outer else
    	}//main else
       
       
} catch(Exception e)
  {
      out.print(e);
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
<%-- <%@ include file="footernew.jsp" %></body></html> --%>
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
<link href="common/genomics.css" rel="StyleSheet" type="text/css"></link>

<%@ include file="Connections/helpconn.jsp" %>
<body  onLoad="JavaScript:initRotator(),loadSearchHighlight();" id="mainbody" >
<form name="userinfo" method="get" action="userinfoinsrt.jsp" onSubmit="return validate();" >
<%
try
{

        
        ResultSet rs2=null, rs3=null;
        String sql2="", sql3="";
        String fnamelist="", lastnamelist="", mobnolist="", emaillist="", desiglist="", loclist="", logininfo="",VideoLink="";
        String firstname="",lastname="";
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
    	ResultSet rs = getStatement.executeQuery(sql);
    	if(rs.next())
    	{
    		reportno = rs.getString("ReportNo");
    	}
    	
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
        //out.print(pass); 

	//sql3="SELECT * FROM t_security where Username='"+ user +"' and Password='"+pass+"'";
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
	

	    //System.out.println("Hii");
        String sql1 = "SELECT * FROM t_security where Username='"+ user +"' and Password='"+pass+"'";
        //System.out.println(sql1);
	    ResultSet rs1 = getStatement.executeQuery(sql1);
	    
        if(rs1.next())
        {
           //System.out.println("Hii");
		   session.setAttribute("user",user);
		   session.setAttribute("pass",pass);
		   String user1=request.getParameter("user");
		   session.setAttribute("mainuser",user);
		   //System.out.println("189 "+user);
		  // System.out.println("190 "+pass);
		   //System.out.println("mainuser "+pass);
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
 			
 			<br>
 			
 		<div align="left">
		
		<a href="#" onclick="regcomplaint('<%=PageName %>')" title="Register Complaint">Register Complaint</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="black"> Report No.: <%=reportno %></font>
		</div>
<!--		<div align="right" style="margin-right: 1em;">-->
<!--		<font size="2" face="Arial">Important Notification Regarding Google Map.... <a href="impnotice.jsp?user=< %=user %>&Password=< %=pass %>&page=userinfo"> click here </a> to view the details</font>-->
<!--		</div>-->
 			
 		<br>
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
			<%
			if(option=="opt1" || option.equalsIgnoreCase("opt1"))
			{
				%>
<!--				<font size="2" face="Arial">You have selected the 1st option i.e. to migrate to Transworld's map servers and data at no additional cost</font>-->
				<%
			}
			else
				if(option=="opt2" || option.equalsIgnoreCase("opt2"))
				{
					%>
<!--					<font size="2" face="Arial">You have selected the 1st option i.e. to use Google Maps - for this you will need to pay $12 per annum, per vehicle UPFRONT</font>-->
					<%
				}
			%>
			<br>
<!--		<a href="sessionvalidate.jsp?phno=< %=mobnolist %>&email=< %=emaillist %>&fname=< %=fnamelist %>&lname=< %=lastnamelist %>"> CLICK HERE TO CONTINUE.. </a>-->
<!--		<a href="http://182.18.129.62/CMS/"> CLICK HERE TO CONTINUE.. </a>-->
		</div>

		<%		
		response.sendRedirect("http://myfleetview.com/CMS/");
		  }   
 	       }	
               %>
 			</table>
 			</center>
 			<br>
 				<br>
 			 </table>
<%
        } 
        else
        {
		response.sendRedirect("index.jsp?err=err");
        }
        }
        }
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
	</br>
	</br>
	</center>
	</br>
	</br>
	</center>
	</br>
	</br>
	</center>
	</br>
	</br>
	</form>
	</body>
	</html>
	
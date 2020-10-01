<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import=" java.text.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type"
content="text/html; charset=iso-8859-1">
<meta name="generator" content="Bluefish 1.0.7">
<title>- - Vehicle Tracking System - -</title>
<script language="javaScript">
function validate()
{
	if(document.loginform.user.value=="")
	{
		alert("Please Enter User Name");
		return false;
	}
	if(document.loginform.Password.value=="")
	{
		alert("Please Enter Password");
		return false;
	}
	return showmsg();
	return true;
}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0">
<p>
<table width="100%" border="0" >
<tr>
<td align="center"> <a href="images/logo.jpg" target="new" > <img src="images/logo.jpg" border="0"></a></td>
<td><!--<a href="http://www.MyFleetView.com" target="new" > <img src="images/Vehicle_Trac_04175.gif" border="0"> <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="468" height=60" id="flashVars" align="middle"><param name="allowScriptAccess" value="sameDomain" /><param name="allowFullScreen" value="false" /><param name="FlashVars" value="u=ahNhbmltYXRpb25vbmxpbmVtYWlucg8LEgdXQV9GaWxlGPSNBww" /><param name="movie" value="http://www.animationonline.com/a.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" />	<embed src="http://www.animationonline.com/a.swf" quality="high" bgcolor="#ffffff" width="468" height=60" FlashVars="u=ahNhbmltYXRpb25vbmxpbmVtYWlucg8LEgdXQV9GaWxlGPSNBww" name="AnimationEngineMain" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></object>-->
<!-- **************************Changes done***************************** -->
<!-- ***************************Following images are added in the header************************* -->

<img src="images/ind11.jpg" width="50%" height="80%">
<img src="images/move.gif" border="0"  width="15%" >
<%@ include file="imgrotate.html" %>
<!-- ******************End of the changes************************************ -->
</a>
</td>
<!-- ***********************Image given below is excluded****************************** -->
<!-- 
<td><img src="images/your_ad_here.jpg"></td> -->
<!-- *******************End of the changes************************************** -->
</tr>
</table>
<div align="right">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
    	<td colspan="5" width="100%" bgcolor="#000080">
    		<div align="right">
    			<table border="0" cellpadding="0"cellspacing="0" width="100%">
    				<tr>
    				<td><marquee ><font color="white" face="arial">Transworld Compressor Technologies Ltd.</font></marquee>
								</td>
    					<td width="50%">
                		<p align="right">
                			<strong>
                			<a href="http://www.twtech1.com/" ><font color="#FFFFFF" size="1" face="arial">ABOUT US&nbsp;&nbsp;&nbsp;&nbsp;</font></a>                		  
								<a href="contactus.html" ><font color="#FFFFFF" size="1" face="arial">&nbsp;&nbsp;&nbsp;&nbsp;CONTACT US&nbsp;&nbsp;&nbsp;&nbsp;</font></a>
								<a href="http://blog.Transworld-Compressor.com" ><font color="#FFFFFF" size="1" face="arial">&nbsp;&nbsp;&nbsp;&nbsp;Blog&nbsp;&nbsp;&nbsp;&nbsp;</font></a>
                		   </strong>
  			
                		</p>
                </td>
            </tr>
        </table>
        </div></td>
    </tr>
    <tr>
        <td valign="top" width="155">
        
	<table border="0" width="100%" align="center" bgcolor="#f5f5f5">
	
	<tr><td bgcolor="#E6E6E0">
	<div style="visibility:visible;width:200px;margin:auto"><embed src="http://flash.picturetrail.com/pflicks/3/spflick.swf" quality="high" FlashVars="ql=2&src1=http://pic80.picturetrail.com/VOL1979/12459689/flicks/1/7238798" wmode="transparent" bgcolor="#000000" width="200" height="135" name="radial" align="middle" allowScriptAccess="sameDomain" style="height:135px;width:200px" type="application/x-shockwave-flash"></embed>
</div>	
	</td></tr>
	<tr>
	<td><font size="1" face="arial" color="darkred">Welcome to <a href="http://www.MyFleetView.com" target="new"><font face="arial">www.MyFleetView.com</font></a></font></td>	
	</tr>
	<tr>
	<td><font size="0.2" face="arial">Feel free to play with the map</font></td>	
	</tr>
	<tr>
	<td><font size="0.2" face="arial"><u>To view your Vehicle please login</u></font></td>	
	</tr>
	<!--
	<tr>
	<td><font size="0.2" face="arial" color="lightblack"><a href="Mobile_Eye_AVL_usm_VER_1.05.pdf">Click to download Product Brochure</a></font></td>	
	</tr>
	-->
	<%@ include file="Connections/helpconn.jsp" %>
	
	<%
try{
	
String sql="select * from t_helpline";
ResultSet rst=getStatement.executeQuery(sql);
if(rst.next()){
%>
	<tr><td align="center"><font size="0.5" face="arial" color="darkred">	Helpline	</font></td>	</tr>
	<tr><td><font size="0.5" face="arial" color="#C94093"> Phone :	<%=rst.getString("PhoneNumber") %> </font></td></tr>
	<tr><td><font size="0.5" face="arial" color="#C94093"> Mobile :	<%=rst.getString("MobileNumber") %> </font></td></tr>
	<tr><td><font size="0.5" face="arial" color="#C94093"> Contact :	<%=rst.getString("ContactName") %> </font></td></tr>
	<tr><td><font size="0.5" face="arial" color="#C94093"> Email:	<a href="mailto:<%=rst.getString("Email") %>"><%=rst.getString("Email") %></a> </font></td></tr>
	<tr><td><font size="0.5" face="arial" color="#C94093"> Contact Time:	<%=rst.getString("ContactTime") %> </font></td></tr>
	<%
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	getStatement.close();
	getDattabase.close();
}
%>
	</table>
<form name="loginform" action="userinfo.jsp" method="post" onSubmit="return validate();">
<table border="0" bgcolor="#660000" width="100%" class="f12">

<tr> 
<%
String err=request.getParameter("err");
if(null==err)
{
}
else
{
if(err.equals("err2"))
{
out.print("<center><font color='red' size='1'>Session expired, please login again.</font>");
}
else
{
out.print("<center><font color='red' size='1'>Please enter correct User Name And Password</font>");

}
}
%>
            <td align="left" valign="middle"><font color="white" face="arial"> User Id:</font></td> 
            <td><input name="user" type="text" class="formElement" size="25"></td> 
          </tr> 
          <tr> 
            <td align="left" valign="middle" ><font color="white" face="arial"> Password:</font></td> 
            <td><input name="Password" type="Password" class="formElement" size="20"></td> 
          </tr> 
		  	<tr> 
            
            <td colspan="2" align="center"><font color="red" size="0.2">I agree to the terms of use.</font></td> 
          </tr>
          <tr> 
            
            <td colspan="2" align="center"><input type="submit" name="submit"  value="Submit" class="formElement"></td> 
          </tr> 

</table>
</form>
<table><tr><td><script language="javascript" type="text/javascript" src="http://www.newsfeedmaker.com/feed.php?code=eb109842"></script></td></tr></table>
        </td>
        <td width="1" background="line.gif">&nbsp;</td>
        <td valign="top">
      	<a href="http://maps.google.com" target="new"><img src="images/map.jpg"></a><br></br>
      	<font size="2" face="arial" color="#053A7D">Embrace Life - watch this fantastic video</font>
      	<object width="873" height="525">
      	<param name="movie" value="http://www.youtube.com/v/zmGzStrFsOc&hl=en_US&fs=1&rel=0&color1=0x2b405b&color2=0x6b8ab6&border=1"></param>
      	<param name="allowFullScreen" value="true"></param>
      	<param name="allowscriptaccess" value="always"></param>
      	<embed src="http://www.youtube.com/v/zmGzStrFsOc&hl=en_US&fs=1&rel=0&color1=0x2b405b&color2=0x6b8ab6&border=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="510" height="410"></embed>
      	</object>
		
        </td>
        <td width="1" background="line.gif">&nbsp;</td>
        <td valign="top" width="155">
        <script language="javascript" type="text/javascript" src="http://www.newsfeedmaker.com/feed.php?code=c271256f"></script>

        <img src="spacer.gif" width="125" height="1"> 
        </td>
    </tr>
</table>
</div>
 <%
 String file = "count.txt";
 String cntfpath = application.getRealPath("/")+file;
 RandomAccessFile ffile=new RandomAccessFile(cntfpath,"rw");
 ffile.seek(0);
 int count=Integer.parseInt(ffile.readLine());
 ffile.seek(0);
 ffile.writeBytes(Integer.toString(count+1));
 ffile.close();

%>
<div style="font-size: 0.8em; text-align: center; margin-top: 1.0em; margin-bottom: 1.0em;">
Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</div>
</body>
</html>

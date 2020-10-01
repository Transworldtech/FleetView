<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="filedownload.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/dbConn.jsp" %>
<html>
<head>
<title>Vehicle Tracking System </title>
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<link href="css/css.css" rel="StyleSheet" type="text/css">
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

  </head>
  <body onunload="GUnload()"  bgcolor="#FFE4E1">

<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA" class="solid">
<tr ><td valign="top"><table border="0" width="100%" bgcolor="#F8F8FF"><tr><td valign="top" rowspan="2" width="12%">
<a href="images/logo.jpg"><img src="images/logo.jpg" width="100px" height="100px" border="0"/></a></td><td colspan="2"><img src="images/ind11.jpg">
</td></tr>
<tr><td colspan="2"><table border="0" width="100%" align="right" background="images/background1.bmp"><tr><td align="center" ><a href="onlinedata.jsp">HOME</a></td><td align="center"><a href="http://www.twtech1.com/">ABOUT US</a></td><td align="center"><a href="http://www.mobile-eye.in/contact.html">CONTACT US</a></td>
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
<script language="JavaScript" src="graphs.js"></script>
</head>

<form name="f1" action="javascript:createGraph()" method="post">
<table border="0" cellspacing="0" cellpadding="2" width="100%"><tr valign="top" bgcolor="#E0F0FF">
<td align="left">
  <table border="0" cellspacing="0" cellpadding="1"><tr>
  <td align="right">Graph Type:</td>
  <td> 
<select name="graphType" style="width:100px">
  <option value="hBar" >horizontal
  <option value="vBar" selected>vertical
  </select></td>
  </tr><tr>
  <td align="right">Show Values:</td>
  <td><select name="graphShowValues" style="width:100px">
  <option value="0">% only
  <option value="1" selected>abs. and %
  <option value="2">abs. only
  <option value="3">none
  </select></td>
  </tr><tr>

  <td><input type="hidden" name="graphValues" maxlength="200" style="width:220px" value="123,456,789,987,654,321"></td>
  </tr><tr>
 
  <td><input type="hidden" name="graphLabels" maxlength="200" style="width:220px" value="Horses,Dogs,Cats,Birds,Pigs,Cows"></td>
  </tr><tr>
  
  <td><input type="hidden" name="graphBarWidth" maxlength="3" style="width:30px" value="20"></td>
  </tr><tr>
  
  <td><input type="hidden" name="graphBarLength" maxlength="3" style="width:30px" value="1.0"></td>
  </tr><tr>

  <td><input type="hidden" name="graphLabelSize" maxlength="2" style="width:30px" value="12"></td>
  </tr><tr>

  <td><input type="hidden" name="graphValuesSize" maxlength="2" style="width:30px" value="12"></td>
  </tr><tr>

  <td><input type="hidden" name="graphPercSize" maxlength="2" style="width:30px" value="12"></td>
  </tr><tr>

  <td><input type="hidden" name="graphPadding" maxlength="2" style="width:30px" value="10"></td>
  </tr><tr>
  <td colspan="2">&nbsp;</td>
  </tr><tr>
  <td colspan="2" align="left">
  <input type="reset" value="Reset" style="width:120px; font-weight:bold" onClick="setTimeout('document.f1.submit()', 100)">
  &nbsp; <input type="submit" value="Create Graph" style="width:120px; font-weight:bold"></td>
  </tr></table>
</td>
<td align="right">
  <table border="0" cellspacing="0" cellpadding="1"><tr>

  <td><input type="hidden" name="graphBGColor" size="14" maxlength="14" value="#ABCDEF"></td>
  </tr><tr>

  <td><input type="hidden" name="graphBorder" size="14" maxlength="30" value="1px solid blue"></td>
  </tr><tr>

  <td><input type="hidden" name="graphBarColor" size="14" maxlength="14" value="#A0C0F0"></td>
  </tr><tr>

  <td><input type="hidden" name="graphBarBGColor" size="14" maxlength="14" value="#E0F0FF"></td>
  </tr><tr>

  <td><input type="hidden" name="graphBarBorder" size="14" maxlength="30" value="2px outset white"></td>
  </tr><tr>

  <td><input type="hidden" name="graphLabelColor" size="14" maxlength="14" value="#000000"></td>
  </tr><tr>

  <td><input type="hidden" name="graphLabelBGColor" size="14" maxlength="14" value="#C0E0FF"></td>
  </tr><tr>

  <td><input type="hidden" name="graphLabelBorder" size="14" maxlength="30" value="2px groove white"></td>
  </tr><tr>

  <td><input type="hidden" name="graphValuesColor" size="14" maxlength="14" value="#000000"></td>
  </tr><tr>

  <td><input type="hidden" name="graphValuesBGColor" size="14" maxlength="14" value="#FFFFFF"></td>
  </tr><tr>

  <td><input type="hidden" name="graphValuesBorder" size="14" maxlength="30" value="2px groove white"></td>
  </tr></table>
</td>
</tr></table><br>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr valign="top">
<td>
<h4>Graph</h4>
<div id="divGraph"></div>
</td>
<td width="10">&nbsp;</td>
<td>

</td>
</tr></table>
</form>
<%@ include file="footernew.jsp" %>

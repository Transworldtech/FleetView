<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/dbConn.jsp" %>
<html>
<head>
<title>Vehicle Tracking System </title>
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<link href="css/css.css" rel="StyleSheet" type="text/css">
<!--<link href="includes/style.css" rel="StyleSheet" type="text/css">-->
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script language="javascript">
function validate()
  {
  	if(document.getElementById("data").value=="")
  	{
  	
  		alert("Please select the from date");
  		return false;
  	}
  if(document.getElementById("data1").value=="")
  	{
  	
  		alert("Please select the to date");
  		return false;
  	}
  	var val=datevalidate();
if(val)
{
	alert("call to ajax function");
	return val;
}
  return val;
  }
  function datevalidate()
{	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}

	else if(dm1==dm2)
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	
	if(dy1>dy2)
	{
		alert("Form date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(dm1>dm2)
	{
		alert("Form date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(dm1==dm2) if(dd1>dd2)
	{
		alert("Form date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}

	return true;
}

  </script>


</head>
<body onunload="GUnload()"  bgcolor="#FFE4E1">

<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA" class="solid">
<tr ><td valign="top"><table border="0" width="100%" bgcolor="#F8F8FF"><tr><td valign="top" rowspan="2" width="12%">
<a href="images/logo.jpg"><img src="images/logo.jpg" width="100px" height="100px" border="0"/></a></td><td colspan="2"><!--<marquee class="smhead">
<i > Vehicle Tracking Solutions Powered by Transworld - Mobile Eye 
www.TWTech1.com</i>
</marquee>--><img src="images/ind11.jpg"><img src="images/move.gif" border="0" width="20%"><img src="images/Img6.gif" width="15%">
</td></tr>
<tr><td colspan="2"><table border="0" width="100%" align="right" background="images/background1.bmp"><tr><td align="center" ><a href="onlinedata.jsp">HOME</a></td><td align="center"><a href="aboutus.jsp">ABOUT US</a></td><td align="center"><a href="contactus.jsp">CONTACT US</a></td>
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

<!-- header end here-->
<table border="1" width="100%">
<tr><td>
<table border="0"   class="stats">
<tr bgcolor="lightgreen"><td align="center" colspan="5"  class="hed"><font color="red" size="2" ><center>Journy Report</center></font></td></tr>

<tr bgcolor="#87CEFA">
<td class="bodyText">
Vehicle Number:<select name="vehcode" class="formElement">
<%
String user=session.getAttribute("user").toString();
out.print(user);
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","");
	Statement st=conn.createStatement();
	String sql="select VehicleCode, VehicleRegNumber from t_vehicledetails where OwnerName='"+user+"'";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
%>
<option value="<%=rst.getString("VehicleCode") %>"><%=rst.getString("VehicleRegNumber") %></option>
<%
}

}catch(Exception e)
{
	out.print("Exception  "+e);
}

%>
</select>
</td>
<td align="right">
  <input type="text" id="data" name="data" class="formElement"  size="10" readonly/>
  
<input type="button" name="From Date" value="From Date" id="trigger" class="bodyText" >
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td align="right">

  <input type="text" id="data1" name="data1" class="formElement"  size="10" readonly/>
  <input type="button" name="To Date" value="To Date" id="trigger1" class="bodyText" >
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td>
<td class="bodyText">
Time Interval
<select name="time" class="formElement">
<option value="30">30 MIN</option>
<option value="60">1 Hr.</option>
<option value="120">2 Hr.</option>
<option value="180">3 Hr.</option>
<option value="240">4 Hr.</option>
<option value="300">5 Hr.</option></select>
</td>
<td><input type="button" name="submit" value="submit" class="bodyText" onclick="validate();"></td></tr></table>

</td></tr></table>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

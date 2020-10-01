<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
function formValidation()
{	
	
}


</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
%>
<%@ include file="headernew.jsp"%> 
<%

String vehiclenumber="",Drivername="",cardnumber="",km="",kmpl="",Diselqnty="",defaultfuelrate="",fuelamnt="",reason="";
vehiclenumber=request.getParameter("element_3_1");
System.out.println("vehiclenumber in confirmation page empname========   "+vehiclenumber);
Drivername=request.getParameter("element_3_3");
cardnumber=request.getParameter("element_3_6");
km = request.getParameter("element_3_7");
kmpl = request.getParameter("element_3_8");
Diselqnty = request.getParameter("element_3_9");
defaultfuelrate = request.getParameter("element_3_10");
fuelamnt = request.getParameter("element_3_11");
reason = request.getParameter("element_3_12");


%>
<form name="userform" action="AddiExcepfinalinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Confirmation Additional Ad-hoc Request</b></font> </label></td></tr></tbody></table></div>
<table border="2" width="400" align="center" style="border-spacing: 7px;" class="sortable_entry_new">
<tr>
<td> <font color="black"><b> Vehicle Number: </b></font> </td>
       <td><b><%=vehiclenumber %></b></td>
</tr>
<tr>
<td> <font color="black"><b> Driver Name: </b></font> </td>
       <td><b><%=Drivername %></b></td>
</tr>
<tr>
<td> <font color="black"><b> Card Number: </b></font> </td>
       <td><b><%=cardnumber %></b></td>
</tr>
<tr>
<td> <font color="black"><b> Km : </b></font> </td>
       <td><b><%=km %></b></td>
</tr>
<tr>
<td> <font color="black"><b> KMPL: </b></font> </td>
       <td><b><%=kmpl %></b></td>
</tr>
<tr>
<td> <font color="black"><b> Disel Quantity: </b></font> </td>
       <td><b><%=Diselqnty %></b></td>
</tr>
<tr>
<td> <font color="black"><b> Default Disel Rate: </b></font> </td>
       <td><b><%=defaultfuelrate %></b></td>
</tr>


<tr>
<td> <font color="black"><b> Fuel Amount: </b></font> </td>
       <td><b><%=fuelamnt %></b></td>
</tr>
<tr>
<td> <font color="black"><b> Reason: </b></font> </td>
       <td><b><%=reason %></b></td>
</tr>
<input type="hidden" name="vehiclenumber" value="<%=vehiclenumber %>" />
  		 <input type="hidden" name="Drivername" value="<%=Drivername %>" />	
 		 <input type="hidden" name="cardnumber" value="<%=cardnumber %>" />		
 		 <input type="hidden" name="km" value="<%=km %>" />
 		 <input type="hidden" name="kmpl" value="<%=kmpl %>" />
 		 <input type="hidden" name="Diselqnty" value="<%=Diselqnty%>" />
 		 <input type="hidden" name="defaultfuelrate" value="<%=defaultfuelrate%>" />
 		 <input type="hidden" name="fuelamnt" value="<%=fuelamnt%>" />
 		 <input type="hidden" name="reason" value="<%=reason%>" />
 		 
</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
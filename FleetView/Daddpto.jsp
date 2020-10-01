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

<%
int count=0;

%>
<script>
function formValidation()
{
alert("Count"+count);
	
	return false;
	
	
	
}



</script>
<%
Connection con1 = null;
Statement stdynamicdrop = null,st4=null;
String datenew1="",datenew2="",datenew3="",owner="";
ResultSet rst2=null;
// datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
// datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
st4=con1.createStatement();



String VehId=request.getParameter("VehId");
System.out.println("VehIDDDDDDDD"+VehId);
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehRegNo"+VehRegNo);

//String owner=session.getAttribute("usertypevalue").toString();

%>

<%@ include file="headernew.jsp"%> 

<%	
String user=session.getAttribute("mainuser").toString();
String transporter=session.getAttribute("usertypevalue").toString();
//int i=0;
%>


<form name="userform" action="Daddptoinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>PTO User Field</b></font> </label></td></tr></tbody>
<div align="center">


<%-- <a href="Dpto.jsp?VehId=<%=VehId%>&VehRegNo=<%=VehRegNo%>"><font color="Red" size="2">Click to Add User Defined Field</font></a></td> --%>

<table border="0" width="200" align="center" class="sortable_entry_new">
<div align="right">

 <a href="EditDpto.jsp?VehId=<%=VehId%>&VehRegNo=<%=VehRegNo%>"><font color="Blue" size="2">Go Back</font></a>



</div>
<%

%>
<%


String abc="select field from db_gps.t_custpto where Owner='"+transporter+"' ";

String[] arr=null;
rst2=st4.executeQuery(abc);



while(rst2.next())
{
	 String em=rst2.getString("field");
	 arr=em.split(",");
	 
	 
	 for (int i =0; i < arr.length; i++)
	 {
 	     	out.println("<br>");
 	     	out.println("<br>");

 	     	out.println("\n");
	     	String abcnew=arr[i]   +"     <input type='text'  class='element text medium' id='id_" + count + "' name='name_" + count + "' >";
	     	out.println("<br>");
	     	out.println("<br>");
	     	out.println(""+abcnew); 
	   	    count++;
	 
	 
	 }
}
%>


</table>

<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></div>
<div align="center">
</div>

<input type="hidden" name="dy1" id="dy1" value="<%=count%>">
<input type="hidden" name="VehId" id="VehId" value="<%=VehId%>">
<input type="hidden" name="VehRegNo" id="VehRegNo" value="<%=VehRegNo%>">
<!-- <input type="submit" name="Submit" value="Submit" > -->
</div>

</form>


</div>



 </table></div>


</jsp:useBean>
<%@ include file="footernew.jsp" %>

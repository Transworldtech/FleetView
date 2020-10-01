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
var displaylabel="";
var displaycount="";
var count3="";
// Mandatorytransworld
// alphatransworld
// charactertransworld
// numbertransworld
// emailtransworld

if(displaylabel == ""){
return true;
}

else{
var displaylabelres = displaylabel.split(",");
var res1=displaycount.split(",");
var res2=count3.split(",");
var i;
var j;

for(j=0; j < res2.length-1; j++){
 document.getElementById("element_error_"+ res2[j]).style.display='none';
 }
 
for (i = 0; i < displaylabelres.length-1; i++) {
    var element_error_="element_error_"+i;
    var number=i;
    document.getElementById("element_error_"+ res1[i]).style.display="";
    document.getElementById("element_error_"+ res1[i]).innerHTML=displaylabelres[i];
} 

 return false;
}
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
//String routeid=request.getParameter("routeid");
String routeid=session.getAttribute("routeid").toString();
String owner=session.getAttribute("usertypevalue").toString();
%>
<%@ include file="headernew.jsp"%> 
<form name="userform" action="Geofencewisesetinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<input type="hidden" id="routid" name="routid" value="<%=routeid%>" />
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Geofence Setting</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Location</b> </label><select id="element_3_1" name="element_3_1"  class="element select medium" >
<option value="select" selected="selected">select</option> 
<%String loc="select distinct(WareHouse),WareHouseCode from db_gps.t_warehousedata where Owner=? and Status=? "; 
        PreparedStatement ps=con1.prepareStatement(loc);
		ps.setString(1, owner);
		ps.setString(2, "Active");
		ResultSet rs=ps.executeQuery();
		while(rs.next()){
%>
<option value="<%=rs.getString("WareHouse")%>"><%=rs.getString("WareHouse")%></option>
<%} %>
</select><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Quantity :</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value=""/></textarea><br><br><!--1,2--></td>
<td><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Add" /><!-- <input id="addbtn" name="Add"  class="button_text" type="button"  value="Add" /> --><!--1,3--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label></textarea><br><br><br><!--2,1--></td>
<td><!--2,2--></td>
<td><!--2,3--></td>
</tr>

</table>
</form>

<table width="100%" border="2" align="center" style="text-align: center; font-family: Verdana, Arial, Helvetica, sans-serif;	font-weight: normal; font-size: 11px; color: blue; width: 60%; margin-left: 250px; background-color: #e3e9ff; border: 0px; border-collapse: inherit; border-spacing: 0px; border-color: grey" class="">
					<tr>
						<td class="">
						<div class=""><b>Sr No.</b></div>
						</td>
						<td class="">
						<div class=""><b>GeofenceName</b></div>
						</td>
						<td class="">
						<div class=""><b>Quantity</b></div>
						</td>
						<td class="">
						<div class=""><b>Balance</b></div>
						</td>
						</tr>
						
						<%
						int i=1,Balance=0;
						String disp="select * from db_gps.t_geofencefuelplan where owner=? ";
		                PreparedStatement ps1=con1.prepareStatement(disp);
		                ps1.setString(1, owner);
		                ResultSet rsd=ps1.executeQuery();
		                while(rsd.next())
		                {
						%>
						<tr>
						<td class="">
						<div align=""><%=i%></div>
						</td>
						<td class="">
						<div align=""><%=rsd.getString("geofencename")%></div>
						</td>
						<td class="">
						<div align=""><%=rsd.getString("quantity")%></div>
						</td>
						<td class="">
						<div align=""><%=Balance%></div>
						</td>
						</tr>
						<%i++;}%>
						
						</table>
						<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="button"  value="Submit" /></textarea><br><br><br></div>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
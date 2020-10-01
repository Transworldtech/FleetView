<%@ include file="headerpopup.jsp"%>
<%@page import="java.util.Date"%>
<%!
Connection conn,con;
Statement s,s1,s2,s3,sevent,st3,st4;
String routeid;
%>
<html>
<head>

	<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<!-- <link rel="stylesheet" href="calendar/main.css"> -->

<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script>
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>


<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}

</style>
<style>
#ctrip {visibility:hidden;}

</style>
<script>

</script>


</head>
<body style="margin: 20px;text-align: center;">
<%
try
{

Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 s = con.createStatement();
 s1 = con.createStatement();
 s2 = con.createStatement();
 s3 = con.createStatement();
 st3 = con.createStatement();
 st4 = con.createStatement();
 sevent= con.createStatement();
String driverid = "";
String drivername = "";
String tripid = "",startplace = "",endplace = "",vehregno = "",transporter = "";
routeid = "";
String date23 = "";

%>
		<%	
			%>

<form name="jrnyplan" id="jrnyplan" >

<h1  align="center"><font>Journey Plan</font></h1>
<div align="center">
<table width="100%" border="0">
<tr>
<td width="60%">
<table border="0"  width="100%">
<tr align="left">
<td  valign="top" width="20%"><font color="black">  <b> Trip ID:</b> <%=tripid %></font></td>
<td valign="top"><font color="black"><b>Driver ID: </b> <%=driverid %></font>
<input type="hidden" name="driverid" value="<%=driverid %>" id="driverid"> 
<%-- <input type="hidden" name="briefid"  id = "briefid" value="<%=briefid %>"> --%>
<input type="hidden" name="tripid"  id = "tripid" value="<%=tripid %>"></td>
<input type="hidden" name="date23"  id ="date23" value="<%=date23%>"></td>
<td valign="top"><font color="black"><b>Driver Name:</b> <%=drivername %> </font></td>
<td valign="top"><font color="black"><b>Transporter: </b> <%=transporter %></font></td>
</tr>
<tr align="left">
<td valign="top"  width="20%"><font color="black"><b>Origin:</b> <%=startplace %></font></td>
<td valign="top" ><font color="black"><b>Destination:</b> <%=endplace %></font></td>

<td valign="top" ><font color="black"><b>Vehicle:</b> <%=vehregno %></font></td>
<td valign="top"><font color="black" id="dist"><b>Distance:</b> 120</font></td>
</tr>
</table>
</td>

<td width="50%" align="center">

</td>
</tr>
</table>
</div> 

<%
if(routeid.equals("") || routeid.equals("null") || routeid.equals(" "))
		{
				%>
			 <div align="center"><font size="3">No System Route Available - Create Plan Manually </font></div>
			 <div align="left">
			 <table border="0" width="100%">
			 <tr>
			 <td style="width: 100px"><b>&nbsp;&nbsp;From Date/Time: </b></td>
			  <td>
			 <div align="left"><font color="black"> &nbsp;&nbsp;
			<input type="text" id="MdateF" name="Mdate1"  value=""  class="datetimepicker" style="width: 150px;" readonly/></font></div>
			 </td>
			 <td style="width: 100px"><b>&nbsp;&nbsp;To Date/Time: </b></td>
			  <td>
			 <div align="left"><font color="black"> &nbsp;&nbsp;
			<input type="text" id="MdateT" name="Mdate1"  value=""  class="datetimepicker" style="width: 150px;"    readonly/></font></div>
			 </td>
			 <td style="width: 50px"><b>
			 &nbsp;&nbsp; Day: 
			 </b>
			 </td>
			 <td>
			 
			 <select id="Day" name="Day">	
			 <option value="1">Day 1</option>
			 <option value="2">Day 2</option>
			 <option value="3">Day 3</option>
			 <option value="4">Day 4</option>
			 <option value="5">Day 5</option>
			 <option value="6">Day 6</option>
			 <option value="7">Day 7</option>
			 <option value="8">Day 8</option>
			 <option value="9">Day 9</option>
			 <option value="10">Day 10</option>		 
			 </select>		 
			 </td>
 <td><b>
			 &nbsp;&nbsp; Stop Type: 
			 </b> 
			 </td>
			 <td>
			 <select id="StopReason" name="StopReason">	
			 <option value="Meals">Meals</option>
			 <option value="Rest">Rest</option>
			 <option value="Night halt">Night halt</option>
			 <option value="Destination">Destination</option>
			 </select>		 
			 </td>
			 <td><b>&nbsp;&nbsp; Location</b></td>
			 <td>
			 <input id="loc" name="loc" value=""> 
			 </td>
			 <td>
			 <%-- <input type="button" class="button_text" style="border-style: outset; border-color: black"  value="Submit" onclick="javaprg:try{showtableman('<%=tripid %>','<%=driverid %>','<%=briefid %>','<%=vehregno %>');}catch(e){alert(e);}" /> --%>
			 </td>
			 </tr>			 
			 </table>
			 </div>
  		 	 <div id="mTrip" align="center">
  		 	 
  		 	 <table border='1' width='100%' class='sortable' style='width:100%;' align='left'><tr><th></th><th>SrNo.</th><th>Day</th><th>From DT</th><th>To DT</th><th>Duration</th><th>Stop Reason</th> <th>Location</th><th>Entry By</th></tr>
  		 	 <%
  		 	SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
  		 	SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  		 	SimpleDateFormat df2 = new SimpleDateFormat("HH:mm");
  		 	SimpleDateFormat df3 = new SimpleDateFormat("HH:mm:ss");

  	int i1=1; 	 
	String SqlRoute="select * from t_jrnyplanning where Tripid='"+tripid+"' and driverid='"+driverid+"' order by Start,UpdatedDateTime ";
	System.out.println("route name=====>"+SqlRoute);
	ResultSet rsRoute=st3.executeQuery(SqlRoute); 
	while(rsRoute.next())
	{
	%>
	
		
		<%
		i1++;
	}
	%>
	</table>
  	 </div>
  			  <%
		}
}
catch(Exception e)
{
	System.out.println("Exception--->   "+e);
}
%>
<br>
<br>
</body>

</html>

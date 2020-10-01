<%@ include file="headerpopup.jsp"%>
<%@page import="java.util.Date"%>

<%!
Connection conn,con;
Statement s,s1,s2,s3,sevent;
String routeid;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>
<!--<style>-->
<!--.popup {-->
<!--background-color: #98AFC7;-->
<!--position: absolute;-->
<!--visibility: hidden;-->
<!---->
<!--.popupnew {-->
<!--background-color: #98AFC7;-->
<!--position: absolute;-->
<!--visibility: visible;-->
<!--}-->
<!---->
<!--</style>-->
<!--<style>-->
<!--#ctrip {visibility:hidden;}-->
<!---->
<!--</style>-->
<script>

function toggleDetails1(id,show,row,event)
{
	//try
	//{
	var temp="";
	
		temp = "popupp"+id;

	//alert(temp);
var popup = document.getElementById(temp);
	if (show) {
//		alert("in if  "+popup.Value);
	popup.style.visibility = "visible";

	popup.setfocus();

	} else {
		if(event == "No")
		{
			document.getElementById("Reason"+id).innerHTML = "Reason";
		}
		else
		{
				document.getElementById("Reason"+id).innerHTML = event;
		}
				popup.style.visibility = "hidden";
		        }
}

function savedata1(id,tid,row,rid,dkm,ddur,stdur)
{
	try
{
     var event = document.getElementById("event"+id).innerHTML;
     var stopdur = "";
	 if(event == "Stop" || event == "Edit")
	 {
	       stopdur = document.getElementById("stdur"+id).value;
	       if(stopdur == "")
	       {
		       alert("Please Enter the stop Duration");
		       return false;
	       }

			//var time = stopdur.split(":");
			//if(time.length > 2 && time.length < 2)
		//	{
		//		alert("Please Enter the valid time");
		//	       return false;
		//	}
		//	else
				if(isNaN(stopdur))
				{
					alert("Please Enter the valid time");
				       return false;
				}   

			if(document.getElementById("Reason"+id).innerHTML == "Reason")   
			{
				alert("Please Enter the Stop Reason");
			       return false;
			}
	}
	else
		if(event == "Driving")
	{
		
	}

document.getElementById("save1"+id).style.display = "none";

var tripid = document.getElementById("tripid").value;
var briefid = document.getElementById("briefid").value;
var driverid = document.getElementById("driverid").value;
var day = document.getElementById("day").value;
var routeid = document.getElementById("routeid").value;
var reason = document.getElementById("Reason"+id).innerHTML;
	//alert("ajax");
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			try
			{
			var reslt=ajaxRequest.responseText;
			//alert(reslt);
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert(reslt);
			if(reslt == "1")
			{
				alert("Stop duration should not be less than 15 min");
			}else
			{
				alert("Successful Saved");
				opener.Reload();
				window.location.reload();
			//document.getElementById("detail").innerHTML = reslt;
			}
			}
			catch(e)
			{
				alert(e);
			}
		}
	}
	
	var queryString ="?tripid="+tripid+"&briefid="+briefid+"&driverid="+driverid+"&day="+day+"&rid="+routeid+"&stdur="+stopdur+"&event="+event+"&tid="+tid+"&reason="+reason;                                                      
	ajaxRequest.open("POST", "calculatejourney1.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
	catch(e)
	{
		alert(e);
	}
	
}

function toggleDetails(id,show,row,event,drikm,dritime,sttime)
{
	//try
	//{
	var temp="";
	temp = "popup"+id;	
	if(sttime == "-")
	{
		sttime = "";
	}
	//alert(temp);
var popup = document.getElementById(temp);
	if (show) {
//		alert("in if  "+popup.Value);
	popup.style.visibility = "visible";
	popup.setfocus();
	
	} else {
		
			if(event == "Stop" || event == "Edit")
			{
				document.getElementById("event"+id).innerHTML = event;
                document.getElementById("divstdur"+id).innerHTML = "<input type='text' id='stdur"+id+"' style=' width: 40px;' ></input> mins";
				
			}
				else
					if(event == "Driving")
					{
						document.getElementById("event"+id).innerHTML = event;
						document.getElementById("divstdur"+id).innerHTML = sttime;
					}
					else
					{
						document.getElementById("divstdur"+id).innerHTML = sttime;
					}
	popup.style.visibility = "hidden";

	 }
	/*}
	catch(e)
	{
       alert(e);
	}*/
}

</script>
</head>
<body>


<%
try
{

Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 s = con.createStatement();
 s1 = con.createStatement();
 s2 = con.createStatement();
 s3 = con.createStatement();
 sevent= con.createStatement();
String tripid = request.getParameter("tripid");
String briefid = request.getParameter("briefid");
String driverid=  request.getParameter("driverid");
String day1 = request.getParameter("day");
String routeid = request.getParameter("rid");
String querystring1 = "",vehregno = "";
if(day1.equalsIgnoreCase("All"))
{
	querystring1 = "";
}
else
{
	querystring1 = " and Day = "+day1;

	
}

String sql1 = "select VehRegNo from db_gps.t_briefing where Briefid = '"+briefid+"' and tripid ='"+tripid+"' and Driverid = '"+driverid+"'";
ResultSet rs = s1.executeQuery(sql1);
if(rs.next())
{
	vehregno = rs.getString("VehRegNo");
}

%>
<h1  align="center"><font size="3">Detail Journey for Tripid: <%=tripid %>, DriverID: <%=driverid %>, VehicleRegNo: <%=vehregno %></font></h1>
<br>
<input type="hidden" id="tripid" name ="tripid" value = "<%=tripid %>">
<input type="hidden" id="briefid" name ="briefid" value = "<%=briefid %>">
<input type="hidden" id="driverid" name ="driverid" value = "<%=driverid %>">
<input type="hidden" id="day" name ="day" value = "<%=day1 %>">
<input type="hidden" id="routeid" name ="routeid" value = "<%=routeid %>">

<div id = "detail">
<table border="1"  class="sortable" align="center">
		<tr>
		<th>Loc ID</th>
		<th>Location</th>
		<th>DT</th>
		<th>Zone Distance</th>
		<th>Event</th>
		<th>Leg Distance</th>
		<th>Driving Time (HH:mm)</th>
		<th>Stop time (HH:mm)</th>
		<th>Stop Reason</th>
		<th>Date Time</th>	
		<th>Duration</th>
		<th>JRM Comment</th>
		<th>JRM Type</th>
		<th>Day</th>
		<th>Action</th>
		</tr>
<%
int i = 1;
String sql = "select * from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' "+querystring1+"  order by CumTime,row";
System.out.println("sql    "+sql);
ResultSet rs1 = s.executeQuery(sql);
while(rs1.next())
{
	
	 int day =0,dt = 0,legdt = 0;		
		String caldate = "",event = "",drivkm = "",drivtime = "",stoptime = "",reason = "",cumtime = "",duration = "",jrmcomment = "",jrmtype = "",show = "none";
		String showentry = "none";
		int drivkm1 = 0;
		String bgcolor = "#FFFFFF",bgcolor1 = "#FFFFFF";
		if(rs1.getString("zone").equalsIgnoreCase("red"))
		{
			bgcolor = "#FF9E9E";
		}
		else
			if(rs1.getString("zone").equalsIgnoreCase("yellow"))
			{
				bgcolor = "#FFF2A1";
			}
			else
				if(rs1.getString("zone").equalsIgnoreCase("green"))
				{
					bgcolor = "#C6FFB5";
				}
		
		if(rs1.getString("Event").equalsIgnoreCase("Rest") || rs1.getString("Event").equalsIgnoreCase("Night Halt"))
		{
			bgcolor1 = "#FFFFCC";
			bgcolor = "#FFFFCC";
		}
		
		if(rs1.getString("drivingtime").equals("-"))
		{
			showentry = "none";
			drivkm  = "";
			drivtime = "";stoptime = "";
		}
		else
		{
			showentry = "";
			drivkm1 =  rs1.getInt("drivingkm")/1000;
			drivkm = drivkm1+"";
			drivtime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("drivingtime")));
			//System.out.println("****    "+rs1.getString("stoptime"));
			if(rs1.getString("stoptime").equals("-"))
			{
				//System.out.println("****   blank "+rs1.getString("stoptime"));
				stoptime = rs1.getString("stoptime");
			}
			else
			{
				//System.out.println("****   available "+rs1.getString("stoptime"));	
			 stoptime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("stoptime")));
			// System.out.println("****   available "+rs1.getString("stoptime"));	
			}
		}
		if(rs1.getString("calculateddate").equals("-"))
		{
			caldate = "-";
		}
		else
		{
			caldate = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("calculateddate")));
		}
		%>
		<tr id="tr<%=i %>">
		<td align="right" style="background-color: <%=bgcolor1 %>"><div align="right"><%=rs1.getString("advancedtrackid") %></div></td>
		<td align="left" style="background-color: <%=bgcolor %>"><div align="left">
		<a href="shownewmap.jsp?lat=<%=rs1.getString("latitude") %>&long=<%=rs1.getString("longitude")%>&discription=<%=rs1.getString("Placename") %>" onclick="popWin=open('shownewmap.jsp?lat=<%=rs1.getString("latitude") %>&long=<%=rs1.getString("longitude")%>&discription=<%=rs1.getString("Placename") %>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rs1.getString("Placename") %></a>
		</div></td>
		<td align="right" style="background-color: <%=bgcolor1 %>"><div align="right" id="dist<%=i %>"><%=rs1.getInt("CumDist")/1000 %></div></td>
		<td align="right" style="background-color: <%=bgcolor1 %>"><div align="right" id="ldist<%=i %>"><%=rs1.getInt("LegDist")/1000 %></div></td>
		<td align="left" style="background-color: <%=bgcolor1 %>"><div align="left">
		<a href="javascript:toggleDetails(<%=i%>,true,1,'No','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');" title="Click to Plan" id="event<%=i %>"><%=rs1.getString("Event") %></a>
		<div class="popup" id="popup<%=i%>">
			<table border="1" style="background-color: #9db5e5;" cellpadding="1px" cellspacing="1px">
			<%
			//System.out.println("Event   "+rs1.getString("Event"));
			if(rs1.getString("Event").equalsIgnoreCase("Driving"))
			{
				if(rs1.getString("drivingtime").equals("-"))
				{
					%>
					<tr>  
			<td  align="left"> <a href="javascript:try{toggleDetails(<%=i%>,false,1,'Driving','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');}catch(e){}">Driving</a>
			</td>
	   	</tr>
					<tr>
				<td  align="left"> <a href="javascript:toggleDetails(<%=i%>,false,1,'Stop','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');">Stop</a>
				</td>
				</tr>
				<tr>
			<td  align="left"> <a href="javascript:toggleDetails(<%=i%>,false,1,'No','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');">Close </a>
			</td>
	   	</tr>
					<%
				}
			}
			else
				if(rs1.getString("Event").equalsIgnoreCase("Rest") || rs1.getString("Event").equalsIgnoreCase("Night Halt") || rs1.getString("Event").equalsIgnoreCase("Duty Stop"))
			{
				%>
				<tr>
				<td  align="left"> <a href="javascript:toggleDetails(<%=i%>,false,1,'Edit','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');">Edit</a>
				</td>
				</tr>
				<tr>
			<td  align="left"> <a href="javascript:toggleDetails(<%=i%>,false,1,'No','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');">Close </a>
			</td>
	   	</tr>
				<%
			}
			%>
			

		</table>
		</div>
		</div>
     </td>
    	<td align="right" style="background-color: <%=bgcolor1 %>;width: 40px;"><div align="right" id = "divdrikm<%=i %>"><%=drivkm %></div></td>
<!--	    	<b><input type="text" id="drikm< %=i %>"  style="display:< %=showentry %>; width: 50px;" value = "< %=drivkm %>" ></input></b>-->
    	<td align="right" style="background-color: <%=bgcolor1 %>;width: 40px;"><div align="right" id = "divdridur<%=i %>"><%=drivtime %></div></td>
<!--	    	<b><input type="text" id="dridur< %=i %>" style="display:< %=showentry %>; width: 50px;" value = "< %=drivtime%>"></input></b>-->
    	<td align="right" style="background-color: <%=bgcolor1 %>;width: 80px;"><div align="right" id = "divstdur<%=i %>"><%=stoptime %></div></td>
<!--	    	<b><input type="text" id="stdur< %=i %>" style="display:< %=showentry %>; width: 50px;" value = "< %=stoptime %>"></input></b>-->
    	<td align="left" style="background-color: <%=bgcolor1 %>"><div align="left">
		<a href="javascript:toggleDetails1(<%=i%>,true,1,'No');" title="Reason" id="Reason<%=i %>"><%=rs1.getString("stopreason") %></a>
		<div class="popup" id="popupp<%=i%>">
			<table border="1" style="background-color: #9db5e5;" cellpadding="1px" cellspacing="1px">
	   	<tr>
   	<td  align="left"> <a href="javascript:toggleDetails1(<%=i%>,false,1,'Duty Stop');">Duty Stop</a>
			</td>
	   	</tr>
	   	<tr>
		<td  align="left"> <a href="javascript:toggleDetails1(<%=i%>,false,1,'Rest');">Rest</a>
			</td>
   	</tr>
   	<tr>
			<td  align="left"> <a href="javascript:toggleDetails1(<%=i%>,false,1,'Night Halt');">Night Halt</a>
		</td>
   	</tr>
<!--   	<tr>-->
<!--		<td  align="left"> <a href="javascript:toggleDetails1(< %=i%>,false,1,'Deviation Stop');">Deviation Stop</a>-->
<!--		</td>-->
<!--	   	</tr>-->
	   	<tr>
			<td  align="left"> <a href="javascript:toggleDetails1(<%=i%>,false,1,'No');">Close </a>
			</td>
			</tr>
	   	</table>
	   	</div>
	   	</div>
	   	</td>
<!--		   		<td align="right" style="background-color: < %=bgcolor1 %>"><div align="right" id="caldate< %=i %>">< %=caldate %></div></td>-->
		<td align="right" style="background-color: <%=bgcolor1 %>"><div align="right" id="time<%=i %>">
		<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("CumTime"))) %></div></td>
		<td align="right" style="background-color: <%=bgcolor1 %>"><div align="right" id="dur<%=i %>"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("LegTime")))%></div></td>
		<td align="left" style="background-color: <%=bgcolor1 %>"><div align="left"><%=rs1.getString("jrmcomment") %></div></td>
		<td align="left" style="background-color: <%=bgcolor1 %>"><div align="left"><%=rs1.getString("jrmtype") %></div></td>
		<td align="left" style="background-color: <%=bgcolor1 %>"><div align="right" id="day<%=i %>"><%=rs1.getString("Day") %></div></td>
		<td align="right" style="background-color: <%=bgcolor1 %>">
		<a title="Save"  id="save1<%=i %>" style="display: ;"  onclick="javascript:try{ savedata1(<%=i %>,<%=rs1.getString("advancedtrackid") %>,<%=rs1.getString("Row") %>,'<%=routeid %>','<%=drivkm %>','<%=drivtime %>','<%=stoptime %>');}catch(e){}">
		<img src="newimages/save.png" border="0"></a></td>			
		</tr>
		<%
		i++;
	
		
}
%>
</table>
</div>
<%
}
catch(Exception e)
{
	System.out.println("Exception--->   "+e);
}
%>

</body>
</html>
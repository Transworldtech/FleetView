<%@ include file="header.jsp" %>
<head>
<title>Vehicle Tracking System </title>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
 <script language="javascript">

  function radio(form)  {  
  var checked1 = false;
     var buttons = form.elements.rvehid;
if(buttons.length>1)
{
for (var i=buttons.length-1; i > -1; i--) {
     if(buttons[i].checked)
            {	
                    checked1 = true; 
                    break;   
             }  
     } 
}
else
{
	if(buttons.checked)
	{
		checked1=true;
	}
}
if(!checked1) {  
    		 alert("you have to choose a vehicle to show his details");
    		 return false;
    		 }  
     return true;
}
   
function radio1()
{
	
	for (var i=0; i < document.form1.mode.length; i++)
   	{
   		if (document.form1.mode[i].checked)
      		{
      			var rad_val = document.form1.mode[i].value;

			if(rad_val=="history")
			{
				
			if(document.getElementById("calender").value=="")
  			{
  		  		alert("Please select the from date");
  				return false;
  			}
			if(document.getElementById("calender1").value=="")
  			{
  		  		alert("Please select the to date");
  				return false;
  			}
				
		}	
	}
	
   }
	return datevalidate();
	
}
   
function datevalidate()
{	
	var date1=document.getElementById("calender").value;
	var date2=document.getElementById("calender1").value;
	dt1=getDateObject(date1,"-");
	dt2=getDateObject(date2,"-");

	if(dt1>dt2)
	{
		alert("date 1 is greater than date 2");
		document.getElementById("calender").value="";
		document.getElementById("calender1").value="";
		return false;
	}
	return true;
}
function getDateObject(dateString,dateSeperator)
{
	//This function return a date object after accepting 
	//a date string ans dateseparator as arguments
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;

	//extract day portion
	curPos=dateString.indexOf(sepChar);
	cYear=dateString.substring(0,curPos);
	
	//extract month portion				
	endPos=dateString.indexOf(sepChar,curPos+1);			
cMonth=dateString.substring(curPos+1,endPos);

	//extract year portion				
	curPos=endPos;
	endPos=curPos+5;			
	cDate=curValue.substring(curPos+1,endPos);
	
	//Create Date Object
	dtObject=new Date(cYear,cMonth,cDate);	
	return dtObject;
}

</script>
<title>::-Transworld Fleetview --::</title>

<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {color: #FFFFFF}
.mydiv {

    cursor: w-resize;



}
</style>

<%
String userID1 = "";
if (! session.isNew()) 
userID1 = (String) session.getAttribute("user");
if (null == userID1) 
	{
		response.sendRedirect("index.jsp");
		return;
	}
else
	{

%>
<%
java.util.Date defoultdate = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
fidDate1 = formatter.format(defoultdate);
difDate2 = formatter.format(defoultdate);
%>



 
<form action="MainformMap2.jsp" method="post"  onsubmit="return radio(this);" name="form1">

<input type="hidden" name="fromtime1" value="00">
<input type="hidden" name="fromtime2" value="00">
<input type="hidden" name="totime1" value="23">
<input type="hidden" name="totime2" value="59">

<table border="1" width="100%">
<tr><td>

<table border="0" width="100%" bgcolor="white">

<tr>
<td><input type=radio name=mode value=history checked>History</td> 
<!--<td><input type=radio name=mode value=current>Current</td> -->
<td>

  <input type="text" id="calender" name="calender" size="15" class="formElement" value="<%=fidDate1%>" readonly/>
  </td>
<td>

<input type="button" name="trigger" id="trigger" value="From Date" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td >

  <input type="text" id="calender1" name="calender1" size="15" class="formElement" value="<%=fidDate1%>" readonly/></td>
<td>
	
<input type="button" name="trigger1" id="trigger1" value="To Date" class="formElement">

<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td>
<td>

<input type="submit" name="submit" value="submit" onclick="return radio1();" class="formElement">
</td>
<td><img src="Transworld.gif" alt="Transworld"/></td>
</tr>

</table>

</td></tr></table>



<table border="1" width="100%" bgcolor="white">
<tr>
<td width="20%">
<div id="side_bar"  style="overflow:auto;height:550px;" align="left" ></div></td>
<td>
<div id="map" style="width:840px; height:550px"></div>
</td>
</tr>
</table>
<%!
Connection con,MM_connUser11;
String fidDate1, difDate2,aa;
double lat, lat1, lon, lon1;
String VehDetails="";
String VehDetails1="",transporterold;
%>

   <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>


    <script type="text/javascript">
    //<![CDATA[


    if (GBrowserIsCompatible()) {
      var side_bar_html = "";
	var combo="<select name='select1' id='select1' class='bodyText'>";
	var combo1="</select>";
var side_bar_html1 = "";
	var gmarkers = [];
      var htmls = [];
      var i = 0;
      var lastvehcode=200;	
	var days = 0;
	var difference = 0;
	var markertoshow=[];
	var j = 0;
	var lableshow=[];
	var k=0;
	var lineshow=[];
	var l=0;
      // A function to create the marker and set up the event window
      function createMarker(point,name,html,vehcode,lat,lon,dt) {
	//alert(vehcode);
	var cIcon = new GIcon();
	Christmas=new Date(dt);
	today = new Date();
	difference =  today - Christmas ;
	days = Math.round(difference/(1000*60*60*24));
	if(days >=7)
	{
	html="<div class='bodyText'><font color='red'>Device Disconnected</font></div>"+html;
	cIcon.image = 'images/t6.png';
	}
	else
	{
	cIcon.image = 'images/t5.png';
	}
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6,11);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	
	
       	var marker = new GMarker(point, markerOptions);
	
	//var marker = new GMarker(point);
        GEvent.addListener(marker, "mouseover", function() {
	lastvehcode=vehcode;
	//map.setCenter(new GLatLng(lat,lon),9);

          marker.openInfoWindowHtml(html);
        });
	GEvent.addListener(marker, "click", function() {
	lastvehcode=vehcode;
	map.setCenter(new GLatLng(lat,lon),9);

          marker.openInfoWindowHtml(html);
        });
        gmarkers[i] = marker;
        htmls[i] = html;
        side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" onMouseOver="javascript:myclick(' + i + ','+lat+','+lon+')" onclick="javascript:openwindow('+vehcode+');" title="Click to See the Last 24 Hours History Report">' + name + '</a><br>';
	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
	i++;
        return marker;
      }
function openwindow(vehcode)
{
	

 	var str="showhistory.jsp?vehcode="+vehcode;
	//alert(str);
	window.open(str,"myWin","width=800,height=620");
	
}
function createMarker1(point,name,html,imgname,lat,lon){
	
	var cIcon = new GIcon();
	<% 
	if(session.getAttribute("usertypevalue").toString().equals("FirstFlight"))
		{
		%>
			cIcon.image = 'images/fff.png';
			cIcon.iconSize = new GSize(12,12);
		
		<%
		}
	else
		{		
		%>
			cIcon.image = 'images/t55.png';
			cIcon.iconSize = new GSize(9,9);


		<%
		}
	%>
	
	//cIcon.shadow = 'images/mm_20_shadow.png';
	
	//cIcon.shadowSize = new GSize(5, 5);
	cIcon.iconAnchor = new GPoint(0,5);
	cIcon.infoWindowAnchor = new GPoint(1, 1);
	markerOptions = { icon:cIcon};
	var marker = new GMarker(point, markerOptions);
	//var marker = new GMarker(point);
         GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html);
        });
      GEvent.addListener(marker, "mouseover", function() {
	//map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html);
        });
	markertoshow[j] = marker;
	j++;
	return marker;
      }


      function myclick(i,lat, lon) {
	map.setCenter(new GLatLng(lat,lon));
        gmarkers[i].openInfoWindowHtml(htmls[i]);
      }
var map = new GMap2(document.getElementById("map"));

	<%
	if(session.getAttribute("usertypevalue").toString().equals("makson"))
	{
		%> map.setCenter(new GLatLng(18.4796,73.9160),12); <%
	}
	else{
	%>
	map.setCenter(new GLatLng(18.80,80.1),5);
	<% 
	}
	%>
	map.setCenter(new GLatLng(<%=session.getAttribute("difoultlat").toString()%>,<%=session.getAttribute("difoultlon").toString()%>),<%=session.getAttribute("difoultzoom").toString()%>);
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());
      
function min()
	{
		map.setCenter(new GLatLng(18.80,80.1),5);
	}

<%

	String vehid="";
	String vehregno="";
	String thedate="";
	String thetime="";
	String location="";
	String transporter="";
	String LatitudePosition="";
	String LongitudePosition="";

try{
	Class.forName(MM_dbConn_DRIVER);
	}
catch(ClassNotFoundException e)
	{
	out.println(e.toString());
	}
	
	try{
	String VehList1=(String)session.getValue("VehList");
	
	
	//out.println(d);
	String Muser = request.getParameter("user");
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement s = con.createStatement();
	Statement s1 = con.createStatement();
/*********************************************************************/
	
	String LatitudePosition1,LongitudePosition1, name1, discription1,imgname1;
	String user1=session.getAttribute("usertypevalue").toString();
	String sql13="select * from t_waypoints where OwnerName='"+user1+"'";
	ResultSet rst13=s.executeQuery(sql13);
	while(rst13.next())
	{
	LatitudePosition1=rst13.getString("Lon");
	LongitudePosition1=rst13.getString("Lat");
	name1=rst13.getString("Name");
	discription1=rst13.getString("Discription");
	imgname1=rst13.getString("Category");

	%>
	var point1 = new GLatLng(<%= LongitudePosition1%>,<%= LatitudePosition1%>);
	var label=new ELabel(point1,"<div class='bodyText'><%=name1%></div>","elabelstyle", new GSize(5,20), 80);
	lableshow[k]=label;
	k++;
	map.addOverlay(label);
var marker = createMarker1(point1,"<%= name1%>","<div class='bodyText'><%= discription1%></div>","<%=imgname1%>",<%= LongitudePosition1%>,<%= LatitudePosition1%>);
	map.addOverlay(marker);
	
	<%
	}


/*********************************************************************/

/*************************code to drow the route for army************/
if(session.getAttribute("usertypevalue").toString().equals("IArmy"))
{
//String sql55="select * from way where OwnerName='iarmy' and RouteId='1'";
String sql55="select Lat, Lat+0.0001 as lat1, Lon,Lon+0.0001 as lon1 from way where OwnerName='iarmy' and RouteId='1'";

ResultSet rst55=s.executeQuery(sql55);
if(rst55.next())
{
        lat = rst55.getDouble("Lat"); 
	lon = rst55.getDouble("Lon"); 
}
while(rst55.next())
{
	lat1 = rst55.getDouble("Lat"); 
	lon1 = rst55.getDouble("Lon"); 
	%> 
var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#cccc00",  6);
map.addOverlay(polyline);

<%
lat=lat1;
lon=lon1;
}

}
/***************************end of the code*************************/


	String sql3 = "SELECT VehicleCode,VehicleRegNo,TheDate,TheTime,Location,Transporter,LatitudePosition,LongitudePosition   FROM t_onlinedata where vehiclecode in " + VehList1 +" order by Transporter asc";
	int cnt=0;
	ResultSet rs3 = s.executeQuery(sql3);
	while(rs3.next())
	{
	vehid= rs3.getString("VehicleCode");
	vehregno = rs3.getString("VehicleRegNo"); 
	thedate= rs3.getString("TheDate");
	thetime = rs3.getString("TheTime"); 
	location= rs3.getString("Location"); 
	transporter = rs3.getString("Transporter"); 
	if(cnt==0)
	{
	transporterold ="old"; 
	cnt++;
	}
	LatitudePosition=rs3.getString("LatitudePosition");

	LongitudePosition=rs3.getString("LongitudePosition");

	VehDetails=vehregno; //+ " " + thedate + " " + thetime + " " + location ;
	VehDetails1=  "<div class='bodyText'>"+ vehregno + " " + thedate + "  " + thetime + "<br>" + location +"<br><a href='#' onclick='min();'>[Back]</a></div>";
	
java.util.Date ShowDatex = new SimpleDateFormat("yyyy-MM-dd").parse(thedate);
Format formatterx = new SimpleDateFormat("MMMM d, yyyy");
String showdatex = formatterx.format(ShowDatex);
	

	%>
	
	side_bar_html +='<% if(!transporter.equals(transporterold)) { out.print("<font color=red size=2 >"+transporter+"</font><br>"); transporterold=transporter; }%><input type="radio" id="rvehid" name="rvehid" value="<%= vehid%>" >';
	
	var point1 = new GLatLng(<%= LatitudePosition%>,<%= LongitudePosition%>);

	var marker = createMarker(point1,"<%= VehDetails%>","<div class='bodyText'><%= VehDetails1%></div>",<%= vehid%>,<%= LatitudePosition%>,<%= LongitudePosition%>,"<%=showdatex%>");
      map.addOverlay(marker);

	
	
	<%}
	rs3.close();
/************************ code to show the vehicles which are not updated ********/
if(session.getAttribute("usertypevalue").toString().equals("Om"))
		{
			
		}
		else
		{
StringTokenizer stk= new StringTokenizer(VehList1,",");
	while(stk.hasMoreTokens())
	{
	aa=stk.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	if(!aa.equals("0")){

	String sql01="SELECT * FROM t_onlinedata where vehiclecode='" + aa +"' order by vehiclecode desc";
	ResultSet rst01=s.executeQuery(sql01);
	if(rst01.next())
	{
		
	}
	else
	{	String sql02="select * from t_veh"+aa+" order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
		ResultSet rst02=s.executeQuery(sql02);
		if(rst02.next())
		{
		vehid= aa;
		thedate= rst02.getString("TheFieldDataDate");
		if(null==thedate)
		{
			thedate="2008-01-01";
		}
		thetime = rst02.getString("TheFieldDataTime"); 
		if(null==thetime)
		{
			thetime="10:00:00";
		}
		location= rst02.getString("TheFieldSubject"); 
		if(null==location)
		{
			location="Transworld pune";
		}
		if(session.getAttribute("usertypevalue").toString().equals("Om"))
		{
			LatitudePosition=rst02.getString("LatitudeDir");
			LongitudePosition=rst02.getString("LongitudeDir");
		}
		else
		{
			LatitudePosition=rst02.getString("LatinDec");
			LongitudePosition=rst02.getString("LonginDec");
		}
		String sql03="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst03=s1.executeQuery(sql03);
		if(rst03.next())
		{
		vehregno = rst03.getString("VehicleRegNumber"); 
		transporter = rst03.getString("OwnerName");
		}
	 	VehDetails=vehregno;
	VehDetails1=  "<div class='bodyText'>"+ vehregno + " " + thedate + "  " + thetime + "<br>" + location +"<br><a href='#' onclick='min();'>[Back]</a></div>";

java.util.Date ShowDatex1 = new SimpleDateFormat("yyyy-MM-dd").parse(thedate);
Format formatterx1 = new SimpleDateFormat("MMMM d, yyyy");
String showdatex1 = formatterx1.format(ShowDatex1);


			%>
	
	side_bar_html += '<input type="radio" id="rvehid" name="rvehid" value="<%= vehid%>" >';
	
	var point1 = new GLatLng(<%= LatitudePosition%>,<%= LongitudePosition%>);

	var marker = createMarker(point1,"<%= VehDetails%>","<div class='bodyText'><%= VehDetails1%></div>",<%= vehid%>,<%= LatitudePosition%>,<%= LongitudePosition%>,"<%=""+thedate %>");
      map.addOverlay(marker);

	
	
	<%
		}//end of if rst02.

	else
	{
	String sql04="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst04=s1.executeQuery(sql04);
		if(rst04.next())
		{
		vehid= aa;
		thedate=rst04.getString("InstalledDate");
		if(null==thedate)
		{
			thedate="2008-01-01";
		}
		thetime = "10:00:00"; 
		location=rst04.getString("InstalledPlace"); 
		if(null==location)
		{
			location="Transworld Pune";
		}
		LatitudePosition="18.5357";
		LongitudePosition="73.8523";
		vehregno = rst04.getString("VehicleRegNumber"); 
		transporter = rst04.getString("OwnerName");
		}

	VehDetails=vehregno;
	VehDetails1=  "<div class='bodyText'>"+ vehregno + " " + thedate + "  " + thetime + "<br><font color='green'> Installed at " + location +" but Not Active</font><br><a href='#' onclick='min();'>[Back]</a></div>";

java.util.Date ShowDatex2 = new SimpleDateFormat("yyyy-MM-dd").parse(thedate);
Format formatterx2 = new SimpleDateFormat("MMMM d, yyyy");
String showdatex2 = formatterx2.format(ShowDatex2);


	%>
	
	side_bar_html += '<input type="radio" id="rvehid" name="rvehid" value="<%= vehid%>" >';
	
	var point1 = new GLatLng(<%= LatitudePosition%>,<%= LongitudePosition%>);

	var marker = createMarker(point1,"<%= VehDetails%>","<div class='bodyText'><%= VehDetails1%></div>",<%= vehid%>,<%= LatitudePosition%>,<%= LongitudePosition%>,"<%=thedate %>");
      map.addOverlay(marker);
<%

	}//end of else rst04.
	}//end of main else.
	}//end of 0 condition if.
	}//end of main while.
	}
/****************** End of Code to show vehicles which are not updates **************/


	s.close();
	con.close();
	
	}
	catch (Exception e)
	{
		
	%> alert("<%=e%>"); <%
	out.println(e);
	}
	

%>



       // put the assembled side_bar_html contents into the side_bar div
          document.getElementById("side_bar").innerHTML = side_bar_html;
          document.getElementById("combo").innerHTML=combo+combo1;
    }

    else {
      alert("Sorry, the Google Maps API is not compatible with this browser");
    }

    // This Javascript is based on code provided by the
    // Blackpool Community Church Javascript Team
    // http://www.commchurch.freeserve.co.uk/   
    // http://econym.googlepages.com/index.htm



   

    //]]>
    </script>
</form>




<%
}
%>
<%
String usertypevalue=session.getAttribute("usertypevalue").toString();
try{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	MM_connUser11 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	String sql11="select * from t_defaultvals where OwnerName='"+usertypevalue+"'";
Statement st11=MM_connUser11.createStatement();
ResultSet rst1=st11.executeQuery(sql11);

if(rst1.next())
{	
	sql11="select * from t_defaultvals where OwnerName='"+usertypevalue+"'";
}
else
{
	sql11="select * from t_defaultvals where OwnerName='Default'";
	
}
ResultSet rst11=st11.executeQuery(sql11);
if(rst11.next())
{
session.setAttribute("overspeed",rst11.getString(2)+" kmph/"+rst11.getString(3)+" Secs");
session.setAttribute("racc",rst11.getString(14)+" kmph/Secs"); 
session.setAttribute("rdcc",rst11.getString(13)+" kmph/Sces");
session.setAttribute("ndri","Beyond "+rst11.getString(10)+" To "+rst11.getString(11));
session.setAttribute("stoptime",rst11.getString(10));
session.setAttribute("starttime",rst11.getString(11));
session.setAttribute("cdri","> "+rst11.getString(12)+" Mins With Stoppages < "+rst11.getString(20));
session.setAttribute("stop","> "+rst11.getString(21)+"Mins");
session.setAttribute("stop11",rst11.getString(21));
}
}catch(Exception e)
{
	System.out.print("Exception"+e);
	out.print("EXCEPTION"+e);
}
finally
{
	MM_connUser11.close();
	con.close();
}
	
%>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

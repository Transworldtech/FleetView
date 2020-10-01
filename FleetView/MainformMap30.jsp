<%@ include file="header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6">
</script>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
<style type="text/css">
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
		response.sendRedirect("index.html");
	}
else
	{

%>
<%! 
Connection con,con1;
double latx, latx1, lonx, lonx1;
String fidDate1,fidDate2,fromtime1,fromtime2,totime1,totime2,fff,ttt;
int i;
%>
<%
fromtime1=request.getParameter("fromtime1");
fromtime2=request.getParameter("fromtime2");
totime1=request.getParameter("totime1");
totime2=request.getParameter("totime2");
fidDate1=request.getParameter("calender");
fidDate2=request.getParameter("calender1");
session.setAttribute("fromtime1",fromtime1);
session.setAttribute("fromtime2",fromtime2);
session.setAttribute("totime1",totime1);
session.setAttribute("totime2",totime2);
fff=fromtime1+":"+fromtime2+":00";
ttt=totime1+":"+totime2+":00";
session.setAttribute("fff",fff);
session.setAttribute("ttt",ttt);
%>
<div id="hh"></div>

<!-- Code added by Atul date 11th may 2008 -->
<%
if(request.getParameter("mode").equals("history"))
{
%>
<form action="MainformMap2.jsp" method="post" name="form1">
<table border="1" width="100%">
<tr><td><table border="0" width="100%" bgcolor="white">
<tr>
<td class="bodyText">
<input type="hidden" name="mode" value='<%=request.getParameter("mode")%>'>
<input type="hidden" name="rvehid" value='<%=request.getParameter("rvehid")%>'>
From Date :  <input type="text" id="calender" name="calender" size="10" class="formElement" value="<%=fidDate1%>" readonly/>
HH :<select name="fromtime1" class="formElement">
<option value="00">00</option>
<option value="01">01</option>
<option value="02">02</option>
<option value="03">03</option>
<option value="04">04</option>
<option value="05">05</option>
<option value="06">06</option>
<option value="07">07</option>
<option value="08">08</option>
<option value="09">09</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
</select> 
MM :<select name="fromtime2" class="formElement">
<option value="00">00</option>
<option value="01">01</option>
<option value="02">02</option>
<option value="03">03</option>
<option value="04">04</option>
<option value="05">05</option>
<option value="06">06</option>
<option value="07">07</option>
<option value="08">08</option>
<option value="09">09</option>
<%
for(i=10;i<=59;i++)
{
%>
<option value='<%=i%>'><%=i%></option>
<%
}
%>
</select>
  <img src="images/calendar.png" id="trigger" >
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
<td class="bodyText">

To Date :  <input type="text" id="calender1" name="calender1" size="10" class="formElement" value="<%=fidDate2%>" readonly/>
HH :<select name="totime1" class="formElement">
<option value="00">00</option>
<option value="01">01</option>
<option value="02">02</option>
<option value="03">03</option>
<option value="04">04</option>
<option value="05">05</option>
<option value="06">06</option>
<option value="07">07</option>
<option value="08">08</option>
<option value="09">09</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23" "Selected">23</option>
</select>
 
MM :<select name="totime2" class="formElement">
<option value="00">00</option>
<option value="01">01</option>
<option value="02">02</option>
<option value="03">03</option>
<option value="04">04</option>
<option value="05">05</option>
<option value="06">06</option>
<option value="07">07</option>
<option value="08">08</option>
<option value="09">09</option>
<%
for(i=10;i<=58;i++)
{
%>
<option value='<%=i%>'><%=i%></option>
<%
}
%>
<option value="59" "Selected">59</option>
</select>
<img src="images/calendar.png" id="trigger1" >
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
<!--<input type="image" src="images/show.bmp" value="submit" onclick="return radio1();"> -->
<input type="submit" name="submit" value="submit" class="formElement">
</td>
</tr>
</table>
</td></tr></table>
</form>
<%
}
%>
<!-- Code added by Atul date 11th may 2008 -->
<table border="1" width="100%" bgcolor="#F0F8FF" >
<tr>
<td id="img" width="20%" valign="top">
<%
if(request.getParameter("mode").equals("history"))
{
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("calender"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("calender1"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);

session.setAttribute("HisShowDate",showdate);
session.setAttribute("HisShowDate1",showdate1);

%>

<table width="100%" border="1" class="stats" valign="top">
<tr><td colspan="3" class="bodyText"><font color="red">Journey From <%=session.getAttribute("HisShowDate").toString()%> <%=fromtime1%>:<%=fromtime2%> To <%=session.getAttribute("HisShowDate1").toString()%> <%=totime1%>:<%=totime2%></font></td></tr>
<tr><td class="hed" colspan="3"><img src="images/mm_20_green.png" align="left"> Last Location</td></tr>
<tr><td class="hed"><img src="images/mm_20_red.png" align="left"> Over Speed </td><td><div id="os"></div></td><td><a href="hos.jsp">[Details]</a></td></tr>
<tr><td class="hed"><img src="images/mm_20_blue.png" align="left"> Rapid Accelaration </td><td><div id="ra"></div></td><td><a href="hra.jsp">[Details]</a></td></tr>
<tr><td class="hed"><img src="images/mm_20_yellow.png" align="left"> Rapid Decelaration </td><td><div id="rda"></div></td><td><a href="hrda.jsp">[Details]</a> </td></tr>
<tr><td class="hed"><img src="images/mm_20_white.png" align="left"> Stop Location </td><td><div id="st"></div></td><td><a href="hrst.jsp">[Details]</a></td></tr>
</table>
<%
}
%>

<div id="side_bar"  style="overflow:auto; height:380px;" align="left" ></div>
</td>

<td >




<div id="myMap" style="position:relative; width:770px; height:535px;"></div>


</td></tr></table>
    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>


    <script type="text/javascript">
    //<![CDATA[
var ffv = 0;
var ffn = "Firefox/"
var ffp = navigator.userAgent.indexOf(ffn);
if (ffp != -1) ffv = parseFloat(navigator.userAgent.substring(ffp + ffn.length));
// If we're using Firefox 1.5 or above override the Virtual Earth drawing functions to use SVG
if (ffv >= 1.5) {
  Msn.Drawing.Graphic.CreateGraphic=function(f,b) { return new Msn.Drawing.SVGGraphic(f,b) }
}
map = new VEMap('myMap');
    	map.LoadMap(new VELatLong(22.51255695405145, 79.36523437500001),5);
      var side_bar_html = "";
      var side_bar_html1 = "";	
      var gmarkers = [];
      var htmls = [];
      var i = 0;
      var lastvehcode=200;

    function createMarker(name, dis,lat,lon,stamp)
{	
    var marker = new VEShape(VEShapeType.Pushpin,new VELatLong(lat,lon)); 

if(stamp=="OS")
	{
	marker.SetCustomIcon("<div class='pinStyle1'></div>");
	}
	if(stamp=="ST")
	{
	marker.SetCustomIcon("<div class='pinStyle4'></div>");
	}
	if(stamp=="AC")
	{
	marker.SetCustomIcon("<div class='pinStyle5'></div>");
	}
	if(stamp=="DC")
	{
	marker.SetCustomIcon("<div class='pinStyle2'></div>");
	}
	if(stamp=="SI")
	{
	marker.SetCustomIcon("<div class='pinStyle3'></div>");
	}
    
    marker.SetTitle(name);
    marker.SetDescription(dis);
    gmarkers[i] = marker;
      	htmls[i] = dis;
       	side_bar_html += '<a href="javascript:myclick(' + i + ')" class="bodyText"onMouseOver="javascript:myclick(' + i + ')" onMouseOut="javascript:myclick1(' + i + ')">' + dis + '</a><br>';
	i++;
        return marker;

}
function myclick(i) {

    	map.ShowInfoBox(gmarkers[i]);
	
      }
function myclick1(i) {

    	map.HideInfoBox();
      }

<%
	String fromdate1 = request.getParameter("calender");
	String todate1 = request.getParameter("calender1");
	String CurorHist = request.getParameter("mode");
	String vehid1=request.getParameter("rvehid");

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st3=con1.createStatement();
	//out.println(d);
	String lat="0.0";
	String lon="0.0";
	String vehcode1 = "1";
	String vehid="0";
	String vehregno="0";
	String thedate="";
	String thetime="";
	String location="";
	String transporter="";
	String lat1="0.0";
	String lon1="0.0";
	String mode1="current";
	String fdate1="00-00-00";
	String tdate1="00-00-00";
	int i=0;
	
	
	
	//String Muser = request.getParameter("user");
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement s = con.createStatement();

if (request.getParameter("rvehid") !=null) {vehcode1 = (String)request.getParameter("rvehid");}
	vehid=vehcode1;
	if (request.getParameter("mode") !=null) {mode1 = (String)request.getParameter("mode");}
	if (request.getParameter("calender") !=null) {fdate1 = (String)request.getParameter("calender");}
	if (request.getParameter("calender1") !=null) {tdate1 = (String)request.getParameter("calender1");}



	

	
	String sql3 = "SELECT VehicleCode,VehicleRegNo,TheDate,TheTime,Location,Transporter,LatitudePosition,LatitudePosition+0.0001 as lat1,LongitudePosition,LongitudePosition+0.0001 as lon1  FROM t_onlinedata where vehiclecode ='" + vehcode1 + "'" ;
	
	ResultSet rs3 = s.executeQuery(sql3);
	while(rs3.next())
	{
	vehid= vehcode1;
	vehregno = rs3.getString("VehicleRegNo"); 
	thedate= rs3.getString("TheDate");
	thetime = rs3.getString("TheTime"); 
	location= rs3.getString("Location"); 
	transporter = rs3.getString("Transporter"); 
	lat = rs3.getString("LatitudePosition"); 
	lon = rs3.getString("LongitudePosition"); 
	lat1 = rs3.getString("lat1"); 
	lon1 = rs3.getString("lon1"); 
	
	}
	rs3.close();


if (mode1.equals("current"))
	{
%>
	map.SetCenterAndZoom(new VELatLong(<%= lat%>,<%= lon%>),9, VEMapStyle.Road);
        side_bar_html +='<br><font size="2" face="arial" color="red" ><b>Reg. No        :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= vehregno%> </b></font>';
      side_bar_html +='<br><font size="2" face="arial" color="red" ><b>Transporter    :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= transporter%></b></font><br><br> ';

      	var marker = createMarker("<%= vehregno%>","Last Location  <%= location%><br><%=thedate%><%= thetime%>","<%= lat%>","<%= lon%>","SI");
      map.AddShape(marker);
	document.getElementById("side_bar").innerHTML = side_bar_html;		


<%

}
else
{

if(session.getAttribute("usertypevalue").toString().equals("Om"))
{

	
	session.setAttribute("hdate1",fromdate1);
	session.setAttribute("hdate2",todate1);
	session.setAttribute("mode",CurorHist);
	session.setAttribute("hvid",vehcode1);
	session.setAttribute("hvrno",vehregno);
//String sql10 = "SELECT LatitudeDir,LatitudeDir+0.0001 as lat1,LongitudeDir,LongitudeDir+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatitudeDir>0 order by TheFieldDataDate desc,TheFieldDataTime desc";

String sql10 = "SELECT LatitudeDir,LatitudeDir+0.0001 as lat1,LongitudeDir,LongitudeDir+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatitudeDir>0 order by TheFieldDataDate desc,TheFieldDataTime desc";
	ResultSet rs10 = s.executeQuery(sql10);


	i = -1;
	
	 lat="19";
	 lon="80";
	 location="No Data";
	 thedate="0000-00-00";
	 thetime="00:00:00";
if(rs10.next())
{
        lat = rs10.getString("LatitudeDir"); 
	lon = rs10.getString("LongitudeDir"); 
	location= rs10.getString("TheFieldSubject");
	thedate= rs10.getString("TheFieldDataDate");
	thetime = rs10.getString("TheFieldDataTime"); 


}

%>
side_bar_html +='<div class="bodyText">Journey From Date :<%=session.getAttribute("HisShowDate").toString()%> To Date :<%=session.getAttribute("HisShowDate1").toString()%></div><br><font size="2" face="arial" color="red" ><b>Reg. No        :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= vehregno%> </b></font>';
side_bar_html +='<font size="2" face="arial" color="red" ><b>Transporter         :</b></font><font size="2" face="arial" color="#B22222" ><b><%= transporter%></b></font><br>';


      var marker = createMarker("<%= vehregno%>","Last Location  <%= thedate%> <%= thetime%> <%= location%>","<%= lat%>","<%= lon%>","SI");

	side_bar_html +='<br><font size="2" color="red" face="arial"><b>Summary</b></font><br>';
      	map.AddShape(marker);
	var points = [
	<%
	while(rs10.next())
	{
	i=i+1;
	lat1 = rs10.getString("lat1"); 
	lon1 = rs10.getString("lon1");
if(Double.parseDouble(lat)-Double.parseDouble(lat1) >0.00005 || Double.parseDouble(lon)-Double.parseDouble(lon1) >0.00005 ||Double.parseDouble(lat1)-Double.parseDouble(lat) >0.00005 || Double.parseDouble(lon1)-Double.parseDouble(lon) >0.00005  ){
%> 	new VELatLong('<%=lat%>','<%=lon%>'),	
	
	
<%
}
lat=lat1;
lon=lon1;
}
%>
	new VELatLong('<%=lat1%>','<%=lon1%>')];
	var color = new VEColor(0,255,0,1);
	var width = 7;
	var id = 'abc';
	var poly = new VEPolyline(id, points, color, width);
	map.AddPolyline(poly);
	map.SetMapView(points);
<%
rs10.close();
//String sql6 = "SELECT Min(Distance) as startdist,Max(Distance) as enddist   FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatitudeDir>0 and TheFiledTextFileName in('SI')";

String sql6 = "SELECT Min(Distance) as startdist,Max(Distance) as enddist   FROM t_veh"+ vehcode1 +" where TheFieldDataDate >='"+ fdate1+"' and TheFieldDataTime >='"+fff+"' and  TheFieldDataDate <='"+ tdate1 +"' and TheFieldDataTime <='"+ttt+"' and LatitudeDir>0 and TheFiledTextFileName in('SI')";
	ResultSet rs6 = s.executeQuery(sql6);
	
if(rs6.next())
{

int Startdist=rs6.getInt("startdist");
int Enddist=rs6.getInt("enddist");
int Totdist=Enddist-Startdist;


%>


side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Distance Travelled  :</b></font>  <font color="#B22222" face="arial" size="1"><b><%= Totdist%>  kms</b></font>';


<%


}
rs6.close();



//String sql7 = "SELECT count(*) as oscount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatitudeDir>0 and TheFiledTextFileName in('OS')";
String sql7 = "SELECT count(*) as oscount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime >='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime <='"+ttt+"' and LatitudeDir>0 and TheFiledTextFileName in('OS')";
	ResultSet rs7 = s.executeQuery(sql7);
int OSCount=0;	
if(rs7.next())
{

OSCount=rs7.getInt("oscount");
session.setAttribute("oscount",""+OSCount);

}
rs7.close();
%>

//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Over Speed Count  :</b></font> <font color="#B22222" face="arial" size="1"><b> <%= OSCount%> </b></font>';
document.getElementById("os").innerHTML=<%= OSCount%>;
<%

//String sql8 = "SELECT count(*) as account  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatitudeDir>0 and TheFiledTextFileName in('AC') and distance>5";

String sql8 = "SELECT count(*) as account  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatitudeDir>0 and TheFiledTextFileName in('AC') and distance>5";
	ResultSet rs8 = s.executeQuery(sql8);
int ACCount=0;	
if(rs8.next())
{

ACCount=rs8.getInt("account");

session.setAttribute("account",""+ACCount);


}
rs8.close();
%>
//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Rapid Acceleration Count  :</b></font> <font color="#B22222" face="arial" size="1"><b> <%= ACCount%> </b></font> ';
document.getElementById("ra").innerHTML=<%= ACCount%>;
<%

//String sql9 = "SELECT count(*) as dccount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatitudeDir>0 and TheFiledTextFileName in('DC') and speed< 120";

String sql9 = "SELECT count(*) as dccount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime >='"+fff+"' and  TheFieldDataDate <='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatitudeDir>0 and TheFiledTextFileName in('DC') and speed< 120";
	ResultSet rs9 = s.executeQuery(sql9);
int DCCount=0;	
if(rs9.next())
{

DCCount=rs9.getInt("dccount");
session.setAttribute("dccount",""+DCCount);
}
rs9.close();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
%>
//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Rapid Decelaration Count  : </b></font> <font color="#B22222" face="arial" size="1"><b><%= DCCount%></b></font>';
document.getElementById("rda").innerHTML=<%= DCCount%>;

var hh="<table border='1' width='100%'><tr><td><table border='0' width='100%' background='images/background1.bmp'><tr><td align='center'><a href='MainformMap2.jsp<%=ll %>'>Map</a></td><td align='center'><a href='historypiechart.jsp'>Pie Chart</a></td><td align='center'><a href='historybarchart.jsp'>Bar Chart</a></td><td align='center'><a href='tempraturereport.jsp'>Detail Report</a></td></tr></table></td></tr></table>";

 document.getElementById("hh").innerHTML = hh;


<%

//String sql5 = "SELECT LatitudeDir,LatitudeDir+0.0001 as lat1,LongitudeDir,LongitudeDir+0.0001 as lon1,TheFieldSubject,TheFiledTextFileName,TheFieldDataDate,TheFieldDataTime,Speed,Distance  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatitudeDir>0 and TheFiledTextFileName  in ('AC','DC','OS') order by TheFieldDataDate desc,TheFieldDataTime desc";


String sql5 = "SELECT LatitudeDir,LatitudeDir+0.0001 as lat1,LongitudeDir,LongitudeDir+0.0001 as lon1,TheFieldSubject,TheFiledTextFileName,TheFieldDataDate,TheFieldDataTime,Speed,Distance  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatitudeDir>0 and TheFiledTextFileName  in ('AC','DC','OS') order by TheFieldDataDate desc,TheFieldDataTime desc";
	ResultSet rs5 = s.executeQuery(sql5);
	i = 0;
	
	while(rs5.next())
	{
	lat = rs5.getString("LatitudeDir"); 
	lon = rs5.getString("LongitudeDir"); 
	location= rs5.getString("TheFieldSubject");
	String Stamp=rs5.getString("TheFiledTextFileName");
	String label1="aa";
	String html1="-";
	int show=1;
	if (Stamp.equals("OS"))
	{

	label1="OS "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed " +rs5.getString("Speed")+" Duration " + rs5.getString("Distance") + " Sec." ;
	}
	if (Stamp.equals("AC"))
	{
	if (rs5.getInt("Distance")>5)
	{
	label1="AC "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed from " +rs5.getString("Distance")+" To " + rs5.getString("Speed")  ;
	}
	else
	{
	show=0;
	}
	}
	
if (Stamp.equals("DC"))
	{
	if (rs5.getInt("Distance")<120)
	{
	label1="DC "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed from " +rs5.getString("Distance")+" To " + rs5.getString("Speed")  ;
	}
	else
	{
	show=0;
	}
	}
if (Stamp.equals("ST"))
	{
	label1="Start at "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")  ;
	}
	
if (Stamp.equals("SP"))
	{
	label1="Stop at "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")  ;
	}


	html1=label1;


	

	if (show==1)
	{
	
%> 
       var marker = createMarker("<%="-"%>","<%= html1%>","<%= lat%>","<%= lon%>","<%=Stamp%>");
	
       map.AddShape(marker);
	map.SetCenterAndZoom(new VELatLong("<%= lat%>","<%= lon%>"),9);
<%
	}


	}

rs5.close();
%>
/*****Code to Show the Stops*****/
<%! 
String sql1001, sql2001;
ResultSet rst1001, rst2001,rst001;
Statement st001,st1001;
int stcount21;
%>
<%
stcount21=0;
try{
Class.forName(MM_dbConn_DRIVER);
Connection conn001 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st001=conn001.createStatement();
st1001=conn001.createStatement();


//String sql001="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode1+" where TheFiledTextFileName='SP' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataDate <='"+tdate1+"' order by TheFieldDataDate, TheFieldDataTime asc";

String sql001="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode1+" where TheFiledTextFileName='SP' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataTime>='"+fff+"' and TheFieldDataDate <='"+tdate1+"' and TheFieldDataTime<='"+ttt+"' order by TheFieldDataDate, TheFieldDataTime asc";
rst001= st001.executeQuery(sql001);
while(rst001.next())
{

//sql1001="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode1+" where TheFiledTextFileName='ST' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataDate <='"+tdate1+"' and TheFieldDataDate='"+rst001.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst001.getString("time1"))+"and abs(LatitudeDir - "+rst001.getString("LatitudeDir")+") <=0.5 order by TheFieldDataDate, TheFieldDataTime asc limit 1"; 


sql1001="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode1+" where TheFiledTextFileName='ST' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataTime>='"+fff+"' and TheFieldDataDate <='"+tdate1+"' and TheFieldDataTime<='"+ttt+"' and TheFieldDataDate='"+rst001.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst001.getString("time1"))+"and abs(LatitudeDir - "+rst001.getString("LatitudeDir")+") <=0.5 order by TheFieldDataDate, TheFieldDataTime asc limit 1"; 
rst1001= st1001.executeQuery(sql1001);
if(rst1001.next())
{
if(rst1001.getDouble("time2")-rst001.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
{
double duration=(Double.parseDouble(rst1001.getString("time2"))-Double.parseDouble(rst001.getString("time1")));
int hrs=(int)duration/60;
int min=(int)duration%60;
String html2="ST "+rst001.getString("TheFieldDataDate")+"  "+rst001.getString("TheFieldDataTime")+"<br> "+hrs+"hrs"+min+"min  "+rst001.getString("TheFieldSubject");
stcount21++;


%> 
            var point1 = new GLatLng(<%=rst001.getString("LatitudeDir")%>,<%=rst001.getString("LongitudeDir")%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>","<%="ST"%>",<%=rst001.getString("LatitudeDir")%>,<%=rst001.getString("LongitudeDir")%>);
      map.addOverlay(marker);

	
<%
}
}
}
%>
//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Stop Count  : </b></font> <font color="#B22222" face="arial" size="1"><b><%= stcount21%> </b></font><br><br>';
document.getElementById("st").innerHTML=<%= stcount21%>;
<%

conn001.close();
}catch(Exception e)
{
	out.print("Exception "+e);
}


/*****Code to Show the Stops*****/

/*******
try{
Statement ststop1=con1.createStatement();
Statement ststop2=con.createStatement();
//String sqlstop1="select * from t_veh"+vehcode1+"_stsp where FromDate >='"+ fdate1+"' and FromDate <='"+ tdate1+"'";

String sqlstop1="select * from t_veh"+vehcode1+"_stsp where FromDate >='"+ fdate1+"' and FromTime>='"+fff+"' and FromDate <='"+ tdate1+"' and FromTime<='"+ttt+"'";
	
	ResultSet rststop1=ststop1.executeQuery(sqlstop1);
	int k=0;
while(rststop1.next())
	{

		String html2="ST "+rststop1.getString("FromDate")+"  "+rststop1.getString("FromTime")+"<br> "+rststop1.getString("Duration")+"  "+rststop1.getString("Location");
		String sqlstop2="select LatitudeDir, LongitudeDir from t_veh"+ vehcode1 +" where TheFieldDataDate ='"+rststop1.getString("FromDate")+"' and  TheFieldDataTime='"+ rststop1.getString("FromTime") +"' and LatitudeDir >0 ";
	ResultSet rststop2=ststop2.executeQuery(sqlstop2);
	while(rststop2.next())
	{
		%> 
            var point1 = new GLatLng(<%=rststop2.getString("LatitudeDir")%>,<%=rststop2.getString("LongitudeDir")%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>","<%="ST"%>",<%=rststop2.getString("LatitudeDir")%>,<%=rststop2.getString("LongitudeDir")%>);
      map.addOverlay(marker);

	
<%
	}
	
	}

}catch(Exception e)
{
%>

alert("<%=e%>");
<%

}
*********/

}
else
{

	
	session.setAttribute("hdate1",fromdate1);
	session.setAttribute("hdate2",todate1);
	session.setAttribute("mode",CurorHist);
	session.setAttribute("hvid",vehcode1);
	session.setAttribute("hvrno",vehregno);
//String sql10 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatinDec>0 order by TheFieldDataDate desc,TheFieldDataTime desc";


String sql10 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode1+" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatinDec>0 order by TheFieldDataDate desc,TheFieldDataTime desc";
	ResultSet rs10 = s.executeQuery(sql10);


	i = -1;
	
	 lat="19";
	 lon="80";
	 location="No Data";
	 thedate="0000-00-00";
	 thetime="00:00:00";
if(rs10.next())
{
        lat = rs10.getString("LatinDec"); 
	lon = rs10.getString("LonginDec"); 
	location= rs10.getString("TheFieldSubject");
	thedate= rs10.getString("TheFieldDataDate");
	thetime = rs10.getString("TheFieldDataTime"); 


}

%>
var map = new GMap2(document.getElementById("map"));
      map.addControl(new GLargeMapControl());
      map.addControl(new GMapTypeControl());
map.setCenter(new GLatLng(<%= lat%>,<%= lon%>),9);

      var point1 = new GLatLng(<%= lat%>,<%= lon%>);

side_bar_html +='<font size="2" face="arial" color="red" ><b>Reg. No        :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= vehregno%> </b></font>';
side_bar_html +='<font size="2" face="arial" color="red" ><b>Transporter         :</b></font><font size="2" face="arial" color="#B22222" ><b><%= transporter%></b></font><br>';


      var marker = createMarker(point1,"<div class='bodyText'>Last Location  <%= thedate%> <%= thetime%> <%= location%></div>","<div class='bodyText'><%= vehregno%><br><%= thedate%> <%= thetime%><br> <%= location%></div>","SI",<%= lat%>,<%= lon%>);

	side_bar_html +='<br><font size="2" color="red" face="arial"><b>Summary</b></font><br>';
      map.addOverlay(marker);

<%
	//while(true)
	//{
	//lat = rs10.getString("LatinDec"); 
	//lon = rs10.getString("LonginDec"); 
	//location= rs10.getString("TheFieldSubject");
	while(rs10.next())
	{
	i=i+1;
	lat1 = rs10.getString("lat1"); 
	lon1 = rs10.getString("lon1");
	
	//}
	//else
	//{
	//break;
	//}
if(Double.parseDouble(lat)-Double.parseDouble(lat1) >0.00005 || Double.parseDouble(lon)-Double.parseDouble(lon1) >0.00005 ||Double.parseDouble(lat1)-Double.parseDouble(lat) >0.00005 || Double.parseDouble(lon1)-Double.parseDouble(lon) >0.00005  ){
	   %> 
var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
map.addOverlay(polyline);

<%
}
lat=lat1;
lon=lon1;
}
rs10.close();







String sql6 = "SELECT Min(Distance) as startdist,Max(Distance) as enddist   FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime >='"+fff+"'  and  TheFieldDataDate <='"+ tdate1 +"' and TheFieldDataTime <='"+ttt+"' and LatinDec >0 and TheFiledTextFileName in('SI')";


//String sql6 = "SELECT Min(Distance) as startdist,Max(Distance) as enddist   FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatinDec>0 and TheFiledTextFileName in('SI')";
	ResultSet rs6 = s.executeQuery(sql6);
	
if(rs6.next())
{

int Startdist=rs6.getInt("startdist");
int Enddist=rs6.getInt("enddist");
int Totdist=Enddist-Startdist;


%>


side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Distance Travelled  :</b></font>  <font color="#B22222" face="arial" size="1"><b><%= Totdist%>  kms</b></font>';


<%


}
rs6.close();


//String sql7 = "SELECT count(*) as oscount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatinDec>0 and TheFiledTextFileName in('OS')";

String sql7 = "SELECT count(*) as oscount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTIme>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatinDec>0 and TheFiledTextFileName in('OS')";
	ResultSet rs7 = s.executeQuery(sql7);
int OSCount=0;	
if(rs7.next())
{

OSCount=rs7.getInt("oscount");
session.setAttribute("oscount",""+OSCount);



}
rs7.close();
%>

//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Over Speed Count  :</b></font> <font color="#B22222" face="arial" size="1"><b> <%= OSCount%> </b></font>';
document.getElementById("os").innerHTML=<%= OSCount%>;
<%

//String sql8 = "SELECT count(*) as account  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatinDec>0 and TheFiledTextFileName in('AC') and distance>5";

String sql8 = "SELECT count(*) as account  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatinDec>0 and TheFiledTextFileName in('AC') and distance>5";

	ResultSet rs8 = s.executeQuery(sql8);
int ACCount=0;	
if(rs8.next())
{

ACCount=rs8.getInt("account");

session.setAttribute("account",""+ACCount);


}
rs8.close();
%>
//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Rapid Acceleration Count  :</b></font> <font color="#B22222" face="arial" size="1"><b> <%= ACCount%></b></font> ';
document.getElementById("ra").innerHTML=<%= ACCount%>;
<%

//String sql9 = "SELECT count(*) as dccount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatinDec>0 and TheFiledTextFileName in('DC') and speed< 120";


String sql9 = "SELECT count(*) as dccount  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime<='"+ttt+"' and LatinDec>0 and TheFiledTextFileName in('DC') and speed< 120";
	ResultSet rs9 = s.executeQuery(sql9);
int DCCount=0;	
if(rs9.next())
{

DCCount=rs9.getInt("dccount");
session.setAttribute("dccount",""+DCCount);
}
rs9.close();

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();

%>
//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Rapid Decceleration Count  : </b></font> <font color="#B22222" face="arial" size="1"><b><%= DCCount%> </b></font>';
document.getElementById("rda").innerHTML=<%= DCCount%>;

var hh="<table border='1' width='100%'><tr><td><table border='0' width='100%' background='images/background1.bmp'><tr><td align='center'><a href='MainformMap2.jsp<%=ll %>'>Map</a></td><td align='center'><a href='historypiechart.jsp'>Pie Chart</a></td><td align='center'><a href='historybarchart.jsp'>Bar Chart</a></td><td align='center'><a href='tempraturereport.jsp'>Detail Report</a></td></tr></table></td></tr></table>";

 document.getElementById("hh").innerHTML = hh;


/*****Code to Show the Stops*****/
<%! 
String sql100, sql200;
ResultSet rst100, rst200,rst00;
Statement st00,st100;
int stcount2;
%>
<%
stcount2=0;
try{
Class.forName(MM_dbConn_DRIVER);
Connection conn00 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st00=conn00.createStatement();
st100=conn00.createStatement();
//String sql00="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode1+" where TheFiledTextFileName='SP' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataDate <='"+tdate1+"' order by TheFieldDataDate, TheFieldDataTime asc";

String sql00="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode1+" where TheFiledTextFileName='SP' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataTime>='"+fff+"' and TheFieldDataDate <='"+tdate1+"' and TheFieldDataTime<='"+ttt+"' order by TheFieldDataDate, TheFieldDataTime asc";
rst00= st00.executeQuery(sql00);
while(rst00.next())
{
//sql100="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode1+" where TheFiledTextFileName='ST' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataDate <='"+tdate1+"' and TheFieldDataDate='"+rst00.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst00.getString("time1"))+"and abs(LatinDec - "+rst00.getString("LatinDec")+") <=0.5 order by TheFieldDataDate, TheFieldDataTime asc limit 1"; 

sql100="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode1+" where TheFiledTextFileName='ST' and TheFieldDataDate >='"+fdate1+"' and TheFieldDataTime >='"+fff+"' and TheFieldDataDate <='"+tdate1+"' and TheFieldDataTime<='"+ttt+"' and TheFieldDataDate='"+rst00.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst00.getString("time1"))+"and abs(LatinDec - "+rst00.getString("LatinDec")+") <=0.5 order by TheFieldDataDate, TheFieldDataTime asc limit 1"; 

rst100= st100.executeQuery(sql100);
if(rst100.next())
{
if(rst100.getDouble("time2")-rst00.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
{
double duration=(Double.parseDouble(rst100.getString("time2"))-Double.parseDouble(rst00.getString("time1")));
int hrs=(int)duration/60;
int min=(int)duration%60;
String html2="ST "+rst00.getString("TheFieldDataDate")+"  "+rst00.getString("TheFieldDataTime")+"<br> "+hrs+"hrs"+min+"min  "+rst00.getString("TheFieldSubject");
stcount2++;


%> 
            var point1 = new GLatLng(<%=rst00.getString("LatinDec")%>,<%=rst00.getString("LonginDec")%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>","<%="ST"%>",<%=rst00.getString("LatinDec")%>,<%=rst00.getString("LonginDec")%>);
      map.addOverlay(marker);

	
<%
}
}
}
%>
//side_bar_html +='<br><font color="red" face="arial" size="1"><b>Total Stop Count  : </b></font> <font color="#B22222" face="arial" size="1"><b><%= stcount2%> </b></font><br><br>';
document.getElementById("st").innerHTML=<%= stcount2%>;
<%

conn00.close();
}catch(Exception e)
{
	out.print("Exception "+e);
}
%>

/*****Code to Show the Stops*****/




<%
//String sql5 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFiledTextFileName,TheFieldDataDate,TheFieldDataTime,Speed,Distance  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and  TheFieldDataDate<='"+ tdate1 +"' and LatinDec>0 and TheFiledTextFileName  in ('AC','DC','OS') order by TheFieldDataDate desc,TheFieldDataTime desc";

String sql5 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFiledTextFileName,TheFieldDataDate,TheFieldDataTime,Speed,Distance  FROM t_veh"+ vehcode1 +" where TheFieldDataDate>='"+ fdate1+"' and TheFieldDataTime>='"+fff+"' and  TheFieldDataDate<='"+ tdate1 +"' and TheFieldDataTime <='"+ttt+"' and LatinDec>0 and TheFiledTextFileName  in ('AC','DC','OS') order by TheFieldDataDate desc,TheFieldDataTime desc";
	ResultSet rs5 = s.executeQuery(sql5);
	i = 0;
	
	while(rs5.next())
	{
	lat = rs5.getString("LatinDec"); 
	lon = rs5.getString("LonginDec"); 
	location= rs5.getString("TheFieldSubject");
	String Stamp=rs5.getString("TheFiledTextFileName");
	String label1="aa";
	String html1="-";
	int show=1;
	if (Stamp.equals("OS"))
	{

	label1="OS "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed " +rs5.getString("Speed")+" Duration " + rs5.getString("Distance") + " Sec." ;
	}
	if (Stamp.equals("AC"))
	{
	if (rs5.getInt("Distance")>5)
	{
	label1="AC "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed from " +rs5.getString("Distance")+" To " + rs5.getString("Speed")  ;
	}
	else
	{
	show=0;
	}
	}
	
if (Stamp.equals("DC"))
	{
	if (rs5.getInt("Distance")<120)
	{
	label1="DC "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")+  " Speed from " +rs5.getString("Distance")+" To " + rs5.getString("Speed")  ;
	}
	else
	{
	show=0;
	}
	}
if (Stamp.equals("ST"))
	{
	label1="Start at "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")  ;
	}
	
if (Stamp.equals("SP"))
	{
	label1="Stop at "+rs5.getString("TheFieldDataDate")+" " +rs5.getString("TheFieldDataTime")  ;
	}


	html1=label1;


	

	if (show==1)
	{
	
	   %> 
            var point1 = new GLatLng(<%= lat%>,<%= lon%>);
	var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","<%=Stamp%>",<%= lat%>,<%= lon%>);
      map.addOverlay(marker);

	
<%
}
}
rs5.close();


}


}
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
	var label=new ELabel(point1,"<div class='bodyText'><%=name1%></div>","elabelstyle", new GSize(-5,20), 80);
	map.addOverlay(label);var marker = createMarker1(point1,"<div class='bodyText'><%= name1%></div>","<div class='bodyText'><%= discription1%></div>","<%=imgname1%>",<%= LongitudePosition1%>,<%= LatitudePosition1%>);
	map.addOverlay(marker);
	
	<%
	}


/*********************************************************************/
 
/*************************code to drow the route for army************/
if(session.getAttribute("usertypevalue").toString().equals("IArmy"))
{
String sql55="select * from way where OwnerName='iarmy' and RouteId='1'";
//String sql55="select Lat, Lat+0.0001 as lat1, Lon,Lon+0.0001 as lon1 from way where OwnerName='iarmy' and RouteId='1'";

ResultSet rst55=s.executeQuery(sql55);
if(rst55.next())
{
        latx = rst55.getDouble("Lat"); 
	lonx = rst55.getDouble("Lon"); 
}
while(rst55.next())
{	latx1 = rst55.getDouble("Lat"); 
	lonx1 = rst55.getDouble("Lon"); 
	%> 
var polyline = new GPolyline([new GLatLng(<%= latx%>,<%= lonx%>),new GLatLng(<%= latx1%>,<%= lonx1%>)], "#cccc00",  10);
map.addOverlay(polyline);

<%
latx=latx1;
lonx=lonx1;
}

}
/***************************end of the code*************************/
	


	s.close();
	con.close();
	con1.close();







%>


	
              // put the assembled side_bar_html contents into the side_bar div
          document.getElementById("side_bar").innerHTML = side_bar_html;
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
<% 
}
 %>

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

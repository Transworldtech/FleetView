
<%@ include file="header.jsp" %>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<script language="javaScript">
function ajaxFunction(xx)
{

var ajaxRequest;  // The variable that makes Ajax possible!
	try
	{
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
	
// Create a function that will receive data sent from the server
ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
                {
                	var reslt=ajaxRequest.responseText;
			document.getElementById("reportdiv").innerHTML=reslt;
		}
	}
if(xx==1)
{
ajaxRequest.open("POST", "tripos.jsp", true);
}
if(xx==2)
{
ajaxRequest.open("POST", "tripac.jsp", true);
}
if(xx==3)
{
ajaxRequest.open("POST", "tripdc.jsp", true);
}
if(xx==4)
{
ajaxRequest.open("POST", "tripst.jsp", true);
}
ajaxRequest.send(null); 
}
 


</script>

<%!
Connection conn;
Statement st,st1;
String sql,tripid,vehcode,sdate,Stamp,label1,sql1,sql2,osstr,acstr,dcstr,ststr,pg,colorcode,nstd,nspd,thedate1;
String lat, lon,location,thedate,thetime,lat1,lon1,vehregno,ownername,lastlocation,startplace,endplace,enddate,sdate1,enddate1;
int oscount,account,dccount,stcount,dist,dist1,distance;
double latx,lonx,latx1,lonx1;
String ColorCode,ColorCode1,ftime,totime;
%>
<%
dist=0;
dist1=0;
distance=0;
oscount=0;
account=0;
dccount=0;
stcount=0;
pg=request.getParameter("pg");
ftime=request.getParameter("ftime");
totime=request.getParameter("totime");
session.setAttribute("pg",pg);
sdate=request.getParameter("sdate");
enddate=request.getParameter("enddate");
startplace=request.getParameter("startplace");
session.setAttribute("tripstartplace",startplace);
endplace=request.getParameter("endplace");
session.setAttribute("tripendplace",endplace);
tripid=request.getParameter("tripid");
vehcode=request.getParameter("vehcode");
vehregno=request.getParameter("vehregno");
session.setAttribute("tripvehregno",vehregno);
ownername=request.getParameter("ownername");
session.setAttribute("tripownername",ownername);
session.setAttribute("tripid",tripid);
session.setAttribute("tripenddate",enddate);
session.setAttribute("tripstartdate",sdate);


%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<table class="stats">
<tr>

<td>
<div id="map" style="width: 550px; height: 570px"></div>
</td>
<td valign="top">
<table class="stats">
<tr><td>

<div class="bodyText" align="right"><a href="#" onclick="javascript:window.open('detailjourney.jsp');" title="Print Detail Journey Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldetailjourney.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></td></tr>
<tr><td><div class="bodyText"  align='left'><B>The Trip Report For Vehicle <%=vehregno %> <Font  color="green">Start Date <%
java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd").parse(sdate);
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(sd1);
 out.print(sh1);%>  <%=ftime%></font>
<%
if(pg.equals("cm"))
{
java.util.Date ed1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate);
Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String eh1 = fmt2.format(ed1);
 out.print(" End Date :" +eh1 );
%><%=totime %>
<%
}
%>  <font color="red">EndDate  : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %> <%=totime %></font> , Trip Id: <%=tripid%>, Owner Name : <%=ownername%>, Start Place : <%=startplace%>, End Place : <%=endplace%></B></div>
<div id="mydiv" name="mydiv"  align='left'></div></td></tr>
<tr><td><div id="mydiv1" name="mydiv1" class="bodyText"></div>
<div id="reportdiv" name="reportdiv" style="overflow:auto;height:300px;"></div>
</td></tr>
</table>



</td>

</tr>
</table>
</td></tr>
</table>
<script type="text/javascript">
    //<![CDATA[
   if (GBrowserIsCompatible()) 
	{
      	var map = new GMap2(document.getElementById("map"));
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());
      map.setCenter(new GLatLng(18.80,80.1),5);
function createMarker1(point,html,lat,lon,stamp){
	
	var cIcon = new GIcon();
	if(stamp=="OS")
	{
	cIcon.image = 'images/mm_20_red.png';
	}
	if(stamp=="ST")
	{
	cIcon.image = 'images/mm_20_white.png';
	}
	if(stamp=="AC")
	{
	cIcon.image = 'images/mm_20_blue.png';
	}
	if(stamp=="DC")
	{
	cIcon.image = 'images/mm_20_yellow.png';
	}
	if(stamp=="SI")
	{
	cIcon.image = 'images/mm_20_green.png';
	}
	cIcon.shadow = 'images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(22, 20);
	cIcon.iconAnchor = new GPoint(6, 20);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	
	var marker = new GMarker(point, markerOptions);
	//var marker = new GMarker(point);
         GEvent.addListener(marker, "click", function() {
	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html1);
        });
      GEvent.addListener(marker, "mouseover", function() {
	//map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html);
        });
	return marker;
      }
<%
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();





sql = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime,Distance,Speed ,TheFiledTextFileName FROM t_veh"+ vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+sdate+" "+ftime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+" "+totime+"' and LonginDec>0 and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc";
ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
        lat = rst.getString("LatinDec"); 
	lon = rst.getString("LonginDec"); 
	location= rst.getString("TheFieldSubject");
	thedate= rst.getString("TheFieldDataDate");
	thedate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate));
	thetime = rst.getString("TheFieldDataTime"); 
	dist=rst.getInt("Distance");
	if(dist==0)
	{
		lastlocation="There is No Data available due to GPS Unit Failure";
	}
	else
	{
	lastlocation=" Last Location :"+thedate1+" "+thetime+" "+location;
	}
%>

var point1 = new GLatLng(<%= lat%>,<%= lon%>);
map.setCenter(point1,6);
var marker = createMarker1(point1,"<div class='bodyText' align='left'><b ><%=vehregno%></b><br><%=thedate%> <%=thetime%><br>Last Location  <%= location%></div>",<%= lat%>,<%= lon%>,'SI');
map.addOverlay(marker);
<% }
while(rst.next())
	{
	dist1=rst.getInt("Distance");
	lat1 = rst.getString("LatinDec"); 
	lon1 = rst.getString("LonginDec"); 
	if(Double.parseDouble(lat)-Double.parseDouble(lat1) >0.00005 || Double.parseDouble(lon)-Double.parseDouble(lon1) >0.00005 ||Double.parseDouble(lat1)-Double.parseDouble(lat) >0.00005 || Double.parseDouble(lon1)-Double.parseDouble(lon) >0.00005  )
{
boolean flag=true;
if(rst.getTime("TheFieldDataTime").compareTo(java.sql.Time.valueOf("05:30:00")) < 1 && rst.getTime("TheFieldDataTime").compareTo(java.sql.Time.valueOf("22:30:00")) < 1 )
{
	colorcode="#000000";

}
else
{
colorcode="#736AFF";
//colorcode="#827839";
}
%>
var polyline = new GPolyline([new GLatLng('<%= lat%>','<%= lon%>'),new GLatLng('<%= lat1%>','<%= lon1%>')], '<%=colorcode%>',  4);
map.addOverlay(polyline);

<%
}
lat = lat1; 
lon =lon1;

}//while

sql2 = "SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+sdate+" "+ftime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+" "+totime+"' and LonginDec>0 and TheFiledTextFileName in ('AC','DC','OS') order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc";
ResultSet rst1=st.executeQuery(sql2);
while(rst1.next())
{
lat=rst1.getString("LatinDec");
lon=rst1.getString("LonginDec");
Stamp=rst1.getString("TheFiledTextFileName");

if (Stamp.equals("OS"))
{

label1="OS "+rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime")+" Speed " +rst1.getString("Speed")+" Duration " + rst1.getString("Distance") + " Sec.";
oscount++;
%>
var point1 = new GLatLng(<%= lat%>,<%= lon%>);
var marker = createMarker1(point1,"<div class='bodyText' align='left'><%=label1%></div>",'<%= lat%>','<%= lon%>','<%=Stamp%>');
map.addOverlay(marker);
<%
}
if (Stamp.equals("AC"))
{
	if (rst1.getInt("Distance")>5)
	{
	label1="AC "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed from " +rst1.getString("Distance")+" To " + rst1.getString("Speed")  ;
	account++;
	%>
var point1 = new GLatLng(<%= lat%>,<%= lon%>);
var marker = createMarker1(point1,"<div class='bodyText' align='left'><%=label1%></div>",'<%= lat%>','<%= lon%>','<%=Stamp%>');
map.addOverlay(marker);
<%
	}
}
	
if (Stamp.equals("DC"))
{
	if (rst1.getInt("Distance")<120)
	{
	label1="DC "+rst1.getString("TheFieldDataDate")+" " +rst1.getString("TheFieldDataTime")+  " Speed from " +rst1.getString("Distance")+" To " + rst1.getString("Speed")  ;
	dccount++;
%>
var point1 = new GLatLng(<%= lat%>,<%= lon%>);
var marker = createMarker1(point1,"<div class='bodyText' align='left'><%=label1%></div>",'<%= lat%>','<%= lon%>','<%=Stamp%>');
map.addOverlay(marker);
<%
	}
}
	
}//while

/******************code for stops***************/

sql1="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and TheFieldDataDate >='"+sdate+" "+ftime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+totime+"' order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
ResultSet rst2= st.executeQuery(sql1);
while(rst2.next())
{
sql2="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+sdate+" "+ftime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+totime+"' and TheFieldDataDate='"+rst2.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst2.getString("time1"))+" and abs(LatinDec - "+rst2.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc limit 1"; 
ResultSet rst3= st1.executeQuery(sql2);
if(rst3.next())
{
if(rst3.getDouble("time2")-rst2.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
{
double duration=(Double.parseDouble(rst3.getString("time2"))-Double.parseDouble(rst2.getString("time1")));
int hrs=(int)duration/60;
int min=(int)duration%60;
String html2="ST "+rst2.getString("TheFieldDataDate")+"  "+rst2.getString("TheFieldDataTime")+"<br> "+hrs+"hrs "+min+"min  "+rst2.getString("TheFieldSubject");
stcount++;
%> 

var point1 = new GLatLng(<%=rst2.getString("LatinDec")%>,<%=rst2.getString("LonginDec")%>);
	var marker = createMarker1(point1,"<div class='bodyText' align='left'><%= html2%></div>",'<%=rst2.getString("LatinDec")%>','<%=rst2.getString("LonginDec")%>','ST');
      map.addOverlay(marker);

<%
}
}
}
/******************code for stops***************/

}catch(Exception e)
{
%> alert("<%=e %>"); <%
}
finally
{
	conn.close();
}
distance=dist-dist1;
if(oscount > 0)
{
osstr="<a href='javascript:ajaxFunction(1);'>"+oscount+"</a>";
}
else
{
osstr=""+oscount;
}
if(account > 0)
{
acstr="<a href='javascript:ajaxFunction(2);'>"+account+"</a>";
}
else
{
acstr=""+account;
}
if(dccount > 0)
{
dcstr="<a href='javascript:ajaxFunction(3);'>"+dccount+"</a>";
}
else
{
dcstr=""+dccount;
}
if(stcount > 0)
{
String pg="tripst";
ststr="<a href='javascript:ajaxFunction(4);'>"+stcount+"</a>";
}
else
{
ststr=""+stcount;
}


String str ="<table class='stats'><tr><td class='bodyText'><div align='left'><img src='images/mm_20_red.png' >Total Over Speed Count :  "+osstr+"</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_blue.png' >Total Rapid Acceleration :  "+acstr+"</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_yellow.png' >Total Rapid Deceleration : "+dcstr+"</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/mm_20_white.png'>Total Stops : "+ststr+"<div></td></tr><tr><td class='bodyText'><div align='left'>Distance Travelled : "+distance+" Km</div></td></tr><tr><td class='bodyText'><div align='left'><img src='images/nd.png' width='30px' height='20px'>Night Driving : <div></td></tr></table>";
%>
}
document.getElementById("mydiv").innerHTML="<%=str%>";
<%if(dist==0)
{%>
document.getElementById("mydiv1").innerHTML="<b><blink><font size='3' color='red'>There is No Data available due to GPS Unit Failure(i.e. Device Disconnection). So it will not be shown on Map</font></font></b>";

<%}
else
{%>
document.getElementById("mydiv1").innerHTML="<b><%=lastlocation%></b>";
<%}%>
 //]]>
</script>
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
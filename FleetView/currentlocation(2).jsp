 <%@ include file="headernew.jsp" %>
<%
if(session.getAttribute("vehlistnew").toString().equals("-"))
{
	out.print("<table class='stats'><tr><td class='hed'>Please select the location first.</td></tr></table>");
}
else
{
%>
<script language ="javascript">

function newwindow(webadd)
{
	window.open(webadd,'jav','width=450,height=450,resizable=yes');
} 

</script>
<style>
<!-- 
    SPAN.searchword { background-color:red; }
    // -->
  </style>
   <script language="JavaScript">
<!--
    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;
    }
    // -->
  </script>

<form method="get" name="searchhi">

<table border="0" width="100%" bgcolor="white" >
<tr>
			<td align="center">
		<!-- <div align="left"><font size="3" >Report No: 3.2</font></div>-->
			<font  size="3" ><b>Vehicle In Place Report</b></font></td>
</tr>


</table> 
<table border=0 width="100%" bgcolor="white">
 <tr>
    <td>
       <div align="right"> <input type="text" name="h" class="formElement"/>
           &nbsp;&nbsp;  <input type="submit" value="Search!" class="formElement"/> </div>
    </td>
 </tr>
</table>
 
</form>
<%!
Connection conn;
Statement st,st1;
ResultSet rst;
String user,VehList1,aa,regno;


%>
<table border="0" width="100%" bgcolor="white" >

<tr><td width="90%" valign="top">
<table border="0" width="100%">

<tr>
<td align="center" colspan="5"><font class="bodyText" size="3"><b>Vehicle <% if(session.getAttribute("Location").toString().equals("All")) { out.print("List"); } else {%>at <%=session.getAttribute("Location").toString()%> <= 10 Km. <% } %></b></font></td></tr><tr><td colspan="5" class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printcurrentposition.jsp');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excelcorrentposition.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></td>
</tr>
<tr bgcolor="#F0E68C">
<td><b class="bodyText">Color Code Indications :</b></td ><td bgcolor="#CCFFCC" ><b>Moving</b></td><td bgcolor="#FFFFCC" ><b>Stop</b></td><td bgcolor="#DCDCDC" ><b>Disconnected</b></td><td bgcolor="#FFFFFF" ><b>Not Active</b></td>
</tr>
</table>
<table  width="100%" class="" border="0">
<tr bgcolor="#DCDCDC">
<td class="hed" align="center" ><font class="bodyText" size="3"><b>Sr.</b></font></td>
<td class="hed" align="center" ><font class="bodyText" size="3"><b>Vehicle Reg.No.</b></font></td>
<td class="hed" align="center" ><font class="bodyText" size="3"><b>Transporter</b></font></td>
<td class="hed" align="center" ><font class="bodyText" size="3"><b>Updated</b></font></td>
<td class="hed" align="center" ><font class="bodyText" size="3"><b>Location</b></font></td>
</tr>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	VehList1=(String)session.getValue("vehlistnew");
	String sql="select * from t_onlinedata where vehiclecode in " + VehList1 +" order by concat(TheDate,TheTime) desc";
rst=st.executeQuery(sql);
int i=1;
while(rst.next())
{
int col=rst.getInt("TheSpeed");
%>
<%

java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);

java.util.Date ddd= new java.util.Date();
long dt1=ShowDate1.getTime();
long dt2=ddd.getTime();
long days=((dt2-dt1)/
(60 * 60 * 1000L* 24));

%>
<tr <% if(col >0) { if(days >7 ){%>bgcolor="#DCDCDC" <% }else {%>bgcolor="#CCFFCC" <% }} else { if(days >7 ){%>bgcolor="#DCDCDC" <% }else { %>bgcolor="#FFFFCC" <% } }  %>>
<td><%=i %></td>
<td class="bodyText"><%=rst.getString("VehicleRegNo")%></td>
<td class="bodyText"><%=rst.getString("Transporter")%></td>
<td class="bodyText">

<%
out.print(showdate1);
%>
<%=rst.getString("TheTime")%></td><div align="center">

<td class="bodyText"><div align="left">
<a href="shownewmap.jsp?lat=<%=rst.getString("LatitudePosition")%>&long=<%=rst.getString("LongitudePosition")%>&discription=<%=rst.getString("Location")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst.getString("LatitudePosition")%>&long=<%=rst.getString("LongitudePosition")%>&discription=<%=rst.getString("Location")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("Location")%><% if(days >7) out.print("<font color='red' size='2'> Device Disconnected</font>"); %></a>

</div></td>

</tr>

<%
i++;
}
}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();

}
%>

</table>
</td>
   <td width="20%" valign="top"> 


      <table width="100%" border="0">
        <tr>
          <td> <div align="center">
             <font color="maroon" class="bodyText"> <b>   Transworld Updates / Advertisements </b> </font></div>
          </td>
        </tr>
       </table>

       <table width="50" border="0">
         <tr>
           <td width="40%" bgcolor="#202714" valign="top" height="16">
             <p align="center">

              <iframe id="datamain" src="news1.jsp" width="160" height="184" scrolling="no" target="_self" name="I1" style="border: 1px solid #354422"></iframe>

           </td>
         </tr>
     
         <table border=0 width="100%">
           <br>
           <center><hr width="100%" color="black"> </center>
         <tr>  
           <td><div align="center"> 
           
             <font color="maroon" class="bodyText"><b><u>Websites you can Use</u> </font> </div>
          </td>   
        </tr>
    
        <tr> 
          <td> <div align="center">
              <a href="http://www.eyefortransport.com" onClick="newwindow('http://www.eyefortransport.com');return false" target="_parent">  Eye for Transport </a> <div align="center">
          </td>
       </tr>
    
       <tr>   
          <td> <div align="center">
              <a href="http://www.bp.com" onClick="newwindow('http://www.bp.com');return false" target="_parent"> About BP </a> <div align="center">
         </td>
      </tr>
    
      <tr>
        <td> <div align="center">
             <a href="http://www.reliancepetroleum.com.au/" onClick="newwindow('http://www.reliancepetroleum.com.au/');return false" target="_parent"> Reliance Petroleum </a> 
        </td>
      </tr>

      <tr>
         <td>  <br>
           <center> <hr width="100%" color="black"> </center>
            <div align="center">
                   <br>
           <link rel="stylesheet" type="text/css" media="screen" href="http://img.weather.weatherbug.com/Style/stickers/v2/Stickers_160x600.css" /> 
           <div class="wXbody">
	       <div class="headerlogo">
	       <a href="http://weather.weatherbug.com/default.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/OK/Indiahoma-weather.html?zcode=z5545&units=1'"><img src="http://img.weather.weatherbug.com/images/stickers/v2/160x600/top-wxbug-logo.jpg" border="0" alt="WeatherBug" /></a></div>
	
	       <iframe id="WeatherBugSticker_160x600_v2" src="http://weather.weatherbug.com/desktop-weather/web-widgets/getSticker.html?ZipCode=73552&ZCode=z5545&Size=160x600&StationID=VABB&units=1&Version=2" width="146" height="296" frameborder="0" scrolling="no" allowtransparency="yes"></iframe>
	
	       <div class="wXlinks">
	       <span class="link"><a href="http://weather.weatherbug.com/weather-forecast.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/OK/Indiahoma-weather/local-forecast/7-day-forecast.html?zcode=z5545&units=1'">Forecast</a></span><br /><br />
           <span class="link"><a href="http://weather.weatherbug.com/doppler-radar.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/OK/Indiahoma-weather/local-radar/doppler-radar.html?zcode=z5545&units=1'">Radar</a></span><br /><br />
		   <span class="link"><a href="http://community-weather.weatherbug.com/community/weather-photos/photo-gallery.html" target="_blank" onclick="Javascript:this.href='http://community-weather.weatherbug.com/community/weather-photos/photo-gallery.html?zcode=z5545&units=1&zip=73552'">Photos</a></span>
	       </div>
	       <div class="wXlinks2">
	       <span class="link"><a href="http://weather.weatherbug.com/weather-cams.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/OK/Indiahoma-weather/weather-cams/local-cams.html?zcode=z5545&units=1'">Cameras</a></span><br /><br />
		   <span class="link"><a href="http://weather.weatherbug.com/weather-news/weather-reports.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/weather-news/weather-reports.html?zcode=z5545&units=1&zip=73552'">News</a></span><br /><br />
		   <span class="link"><a href="http://weather.weatherbug.com/travel-forecast/travel-forecast.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/travel-forecast/travel-forecast.html?zcode=z5545&units=1&zip=73552'">Travel</a></span>
	       </div>
           <div class="footer">
           <a href="http://weather.weatherbug.com/default.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/OK/Indiahoma-weather.html?zcode=z5545&units=1'"><img src="http://img.weather.weatherbug.com/images/stickers/v2/160x600/local.jpg" border="0" alt="WeatherBug" /></a><br />
           <a href="http://weather.weatherbug.com/default.html" target="_blank" onclick="Javascript:this.href='http://weather.weatherbug.com/OK/Indiahoma-weather.html?zcode=z5545&units=1'"><img src="http://img.weather.weatherbug.com/images/stickers/v2/160x600/bt-wxbug-logo.jpg" border="0" id="logo" alt="WeatherBug" /></a><br />
           <div class="footertext">Your weather just got better.</div>
           </div> 
          
          </div> 
        </td>
    </tr>
    </table>
   </table>




<%
}
%>
<%@ include file="footernew.jsp" %>
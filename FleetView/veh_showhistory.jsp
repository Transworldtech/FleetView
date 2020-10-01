 <%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<!-- you can use tables or divs for the overall layout -->
<table border="1" bgcolor="white" align="center">
<tr>
<td colspan="2">
<table width="100%" align="center" >
			<tr>
			<td align="center">
			<!-- <div align="left"><font size="3" >Report No: 1.10</font></div>-->
			<font  size="3" ><b>Journey On Map</b></font></td>
			</tr>
			</table>
</td>
</tr>
<tr>
<td width="20%" valign="top">
<table width="100%" border="1" valign="top">
<tr><th colspan="1"></th></tr>
<tr><td class="hed" colspan="1"><img src="images/mm_20_green.png" align="left"> Last Location</td></tr>
<tr><td class="hed"><img src="images/mm_20_red.png" align="left"> Over Speed </td></tr>
<tr><td class="hed"><img src="images/mm_20_blue.png" align="left"> Rapid Accelaration </td></tr>
<tr><td class="hed"><img src="images/mm_20_yellow.png" align="left"> Rapid Decelaration </td></tr>
<tr><td class="hed"><img src="images/mm_20_black.png" align="left"> Start Location </td></tr>
<tr><td class="hed"><img src="images/mm_20_white.png" align="left"> Stop Location </td></tr>
</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; height:390px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
	
<td  valign="top">

       <div id="map" style="width: 800px; height: 550px"></div>
</td>
      </tr>  
</table>
    



    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>


    <script type="text/javascript">
    //<![CDATA[
<%! 
Connection conn;
Statement st,st1,st2,st3,st4;
String sql,sql1,sql2,sql3,sql4,data1,data2,vehcode,location,Stamp,label1,html1,html2,d1,d2,t1,t2;
String thedate="",thedate1="",thetime="",thetime1="",vehregno="",ownername="",lastlocation="",startplace,endplace,enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
double lat, lat1, lon, lon1;
int show,dist;
%>
<%
try
{
	vehcode=request.getParameter("vehcode");
	java.util.Date NewDate =new java.util.Date();
	Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Format NewFormatter2 = new SimpleDateFormat("yyyy-MM-dd");
	data2 = NewFormatter1.format(NewDate);
	d2=NewFormatter2.format(NewDate);
	long dateMillis = NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	data1 = NewFormatter1.format(NewDate);
	d1=NewFormatter2.format(NewDate);
	session.setAttribute("hvid",vehcode);
	session.setAttribute("fff",data1);
	session.setAttribute("ttt",data2);
	session.setAttribute("hdate1",d1);
	session.setAttribute("hdate2",d2);
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn.createStatement();

}catch(Exception e)
{
	out.print("Exception -->"+e);
}

%>
   		var side_bar_html = "";
     	var side_bar_html1 = "";
      	var str;	
      	var gmarkers = [];
      	var htmls = [];
      	var i = 0;

      	var degreesPerRadian = 180.0 / Math.PI;
      	var arrowIcon = new GIcon();
        arrowIcon.iconSize = new GSize(12,12);
        arrowIcon.shadowSize = new GSize(1,1);
        arrowIcon.iconAnchor = new GPoint(6,6);
        arrowIcon.infoWindowAnchor = new GPoint(0,0);
        
      	var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),8);
		map.addControl(new GMapTypeControl(1));
		map.enableScrollWheelZoom();
		map.addControl(new GSmallMapControl());
		map.addControl(new GScaleControl());
	function createMarker(point,name,html,stamp,lat,lon) {
		var cIcon = new GIcon();
		if(stamp=="OS")
		{
			cIcon.image = 'images/mm_20_red.png';
		}
		if(stamp=="ST" || stamp=="SP")
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
		if(stamp=="SI"||stamp=="OF")
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
        		GEvent.addListener(marker, "mouseover", function() {
       			 marker.openInfoWindowHtml(html);
        		});
			gmarkers[i] = marker;
        	htmls[i] = html;
        	side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
        	i++;
     		map.setCenter(new GLatLng(lat,lon));
        	return marker;
      }
    //********************marker for start position**************
    function createMarker2(point,name,html,lat,lon){
				var cIcon = new GIcon();
				//we have to insert black img  here..... coz it is overlapping
					cIcon.image = 'images/mm_20_black.png';
				
				cIcon.shadow = 'images/mm_20_shadow.png';
				cIcon.iconSize = new GSize (20,25);
				cIcon.shadowSize = new GSize(22, 20);
				cIcon.iconAnchor = new GPoint(6, 20);
				cIcon.infoWindowAnchor = new GPoint(5, 1);
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
		      	gmarkers[i] = marker;
	        	htmls[i] = html;
	        	side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
	        	i++;
	     		map.setCenter(new GLatLng(lat,lon));
	        	return marker;
		      }
    
    //**************************************************************
    

      function myclick(i,lat,lon) {
		map.setCenter(new GLatLng(lat,lon));
        gmarkers[i].openInfoWindowHtml(htmls[i]);
      }
      function bearing( from, to ) {
	    	 
	        // See T. Vincenty, Survey Review, 23, No 176, p 88-93,1975.
	        // Convert to radians.
	        var lat1 = from.latRadians();
	        var lon1 = from.lngRadians();
	        var lat2 = to.latRadians();
	        var lon2 = to.lngRadians();

	        // Compute the angle.
	        var angle = - Math.atan2( Math.sin( lon1 - lon2 ) * Math.cos( lat2 ), Math.cos( lat1 ) * Math.sin( lat2 ) - Math.sin( lat1 ) * Math.cos( lat2 ) * Math.cos( lon1 - lon2 ) );
	        if ( angle < 0.0 )
		 	angle  += Math.PI * 2.0;
	       
	        // And convert result to degrees.
	        angle = angle * degreesPerRadian;
	        angle = angle.toFixed(1);

	        return angle;
	      }
		function arrowHead(px1,px2) {
	    	  
	    	  var p1=px1;
	          var p2=px2;
	       //   alert(p1);
	        //  alert(p2);
	          var dir = bearing(p2,p1);
	          // == round it to a multiple of 3 and cast out 120s
	          var dir = Math.round(dir/3) * 3;
	          
	          while (dir >= 120) {dir -= 120;}
	          // == use the corresponding triangle marker 
	          
	          arrowIcon.image = "http://www.google.com/intl/en_ALL/mapfiles/dir_"+dir+".png";
	          map.addOverlay(new GMarker(p1, arrowIcon));
	      }

<%
try
{ String stamp;
	sql="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
	ResultSet rstx=st.executeQuery(sql);
	if(rstx.next())
	{
	Format NewFormatter3 = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
	%>
	side_bar_html +="<div class='bodyText'><b>Vehicle Reg.No.:<font color='red'> <%=rstx.getString("VehicleRegNumber")%></font> <br>Transporter : <font color='red'><%=rstx.getString("OwnerName")%></font><br>Journey From <font color='red'><%
	java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data1);
	String showdate1 = NewFormatter3.format(ShowDate1);
	out.print(showdate1); %> </font>to <font color='red'><%
	java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data2);
	String showdate2 = NewFormatter3.format(ShowDate2);
	out.print(showdate2); %> </font></b>";
	<%
	}
		//sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName ='SI' and speed >0";
	sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist,TheFiledTextFileName as stamp from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName IN ('SI','OF')";
	
	//System.out.println("sql====>"+sql);
	ResultSet rst2=st3.executeQuery(sql);
	if(rst2.next())
	{
		dist=rst2.getInt("enddist")-rst2.getInt("startdist");
		stamp=rst2.getString("stamp");
		if(dist > 0)
		{
		%>
			side_bar_html +="<div class='bodyText'><b>Total Distance Travelled: </b><font color='red' size='2'><%=dist%></font> km.</div>";
		<%
		}
		else
		{
		%>
		side_bar_html +="<div class='bodyText' size='3' align='center'><font color='red'>No Records.</font></div>";
		<%
		}
	}

	/***********COde for find lasst location***************/
	int record=1;
	String sql11="select * from t_veh"+ vehcode +" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName IN('SI','OF') order by concat(TheFieldDataDate,TheFieldDataTime) desc";
	
	//System.out.println("sql1====>"+sql1);
	ResultSet rst11=st.executeQuery(sql11);
	if(rst11.next())
	{
		lat=rst11.getDouble("LatinDec");
		lon=rst11.getDouble("LonginDec");
		location=rst11.getString("TheFieldSubject");
		html1="<b>Last location:</b><br>"+location;
		%>
		var point1 = new GLatLng(<%= lat%>,<%= lon%>);
		var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","SI",<%= lat%>,<%= lon%>);
     	map.addOverlay(marker);
		<%
	}
	
	//code to draw line
	sql1="select * from t_veh"+ vehcode +" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName = 'SI' and speed>0 order by concat(TheFieldDataDate,TheFieldDataTime) desc";
	
	//System.out.println("sql1====>"+sql1);
	ResultSet rst=st.executeQuery(sql1);
	while(rst.next())
	{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
		record++;
		lat1=rst.getDouble("LatinDec");
		lon1=rst.getDouble("LonginDec");
		thedate1= rst.getString("TheFieldDataDate");
		thetime1 = rst.getString("TheFieldDataTime"); 
		location1= rst.getString("TheFieldSubject");
		thedateStart= rst.getString("TheFieldDataDate");
		thetimeStart = rst.getString("TheFieldDataTime");
		
	//code to drow the line.
	if(lat-lat1 >0.00005 || lon-lon1 >0.00005 ||lat1-lat >0.00005 || lon1-lon >0.00005  )
	{
	%> 
		var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
		map.addOverlay(polyline);
		arrowHead(new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>));
	<%
	}
	lat = lat1; 
	lon =lon1;
	thedateStart=thedate1;
	thetimeStart=thetime1;
	locationStart= location1;
	
	html2="<b>Start location:</b><br>"+locationStart;
	
	}//while to drow the line.
	
	//code to draw the first loc
	String sql12="select * from t_veh"+ vehcode +" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName IN('SI','OF') order by concat(TheFieldDataDate,TheFieldDataTime) asc";
	
	//System.out.println("sql1====>"+sql1);
	ResultSet rst12=st.executeQuery(sql12);
	if(rst12.next()){
		lat=rst12.getDouble("LatinDec");
		lon=rst12.getDouble("LonginDec");
		location=rst12.getString("TheFieldSubject");
		html2="<b>Start location:</b><br>"+location;
	%>
	//var marker1 = createMarker2(new GLatLng(< %= lat%>,< %= lon%>),"<div class='bodyText' align='left'><b >< %=vehregno%></b><br>< %=thedateStart%> < %=thetimeStart%><br>Start Location  < %= locationStart%></div>",< %= lat%>,< %=lon%>);
	var marker1 = createMarker2(new GLatLng(<%= lat%>,<%= lon%>),"<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
	map.addOverlay(marker1);
	<%}
	
//code for OS, RA, RD.

	ResultSet rstos=fleetview.getOSforDateRange(data1,data2,vehcode);
	while(rstos.next())
	{
		label1="OS "+new SimpleDateFormat("dd-MMM-yyyy").format(rstos.getDate("TheFieldDataDate"))+" "+rstos.getString("TheFieldDataTime")+" Speed " +rstos.getString("Speed")+" Duration " + rstos.getString("Distance") + " Sec.";
		%> 
      	var point1 = new GLatLng(<%= rstos.getDouble("LatinDec")%>,<%= rstos.getDouble("LonginDec")%>);
		var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","OS",<%= rstos.getDouble("LatinDec")%>,<%= rstos.getDouble("LonginDec")%>);
     	map.addOverlay(marker);
		<%
		
	}
	ResultSet rstac=fleetview.getACforDateRange(data1,data2,vehcode);
	while(rstac.next())
	{
		label1="AC "+new SimpleDateFormat("dd-MMM-yyyy").format(rstac.getDate("TheFieldDataDate"))+" "+rstac.getString("TheFieldDataTime")+" Speed from" +rstac.getString("Distance")+" to " + rstac.getString("Speed") ;
		%> 
      	var point1 = new GLatLng(<%= rstac.getDouble("LatinDec")%>,<%= rstac.getDouble("LonginDec")%>);
		var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","AC",<%= rstac.getDouble("LatinDec")%>,<%= rstac.getDouble("LonginDec")%>);
     	map.addOverlay(marker);
		<%
		
	}
	
	ResultSet rstdc=fleetview.getDCforDateRange(data1,data2,vehcode);
	while(rstdc.next())
	{
		label1="DC "+new SimpleDateFormat("dd-MMM-yyyy").format(rstdc.getDate("TheFieldDataDate"))+" "+rstdc.getString("TheFieldDataTime")+" Speed from" +rstdc.getString("Distance")+" to " + rstdc.getString("Speed") ;
		%> 
      	var point1 = new GLatLng(<%= rstdc.getDouble("LatinDec")%>,<%= rstdc.getDouble("LonginDec")%>);
		var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","DC",<%= rstdc.getDouble("LatinDec")%>,<%= rstdc.getDouble("LonginDec")%>);
     	map.addOverlay(marker);
		<%
		
	}
	
	/******************code for stops***************/
	String stopdatetime="-",startdatetime="-";
		sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
		ResultSet rstst=st.executeQuery(sql);
		boolean flag=true;
		int i=1;
		while(rstst.next())
		{
			if(rstst.getInt("Speed")==0)
			{
				if(flag)
				{
					stopdatetime=rstst.getString("TheFieldDataDate")+" "+rstst.getString("TheFieldDataTime");
					flag=false;
				}
			}
			else
			{
				flag=true;
				startdatetime=rstst.getString("TheFieldDataDate")+" "+rstst.getString("TheFieldDataTime");
				if(!(stopdatetime.equals("-")))
				{
					java.util.Date spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopdatetime);
					java.util.Date stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdatetime);
					
					long mils=(stdate.getTime()-spdate.getTime());
					long mins=mils/1000/60;
					if(mins >= Integer.parseInt(session.getAttribute("stop11").toString()))
					{
						String hrs=""+mins/60;
						String min="00";
						try{
						 min=""+mins%60;
						}catch(Exception ee)
						{
							min="00";
						}
						label1="ST "+new SimpleDateFormat("dd-MMM-yyyy").format(rstst.getDate("TheFieldDataDate"))+"  "+rstst.getString("TheFieldDataTime")+"<br> "+hrs+"hrs "+min+"min  "+rstst.getString("TheFieldSubject");
						%> 

							var point1 = new GLatLng(<%=rstst.getDouble("LatinDec")%>,<%=rstst.getDouble("LonginDec")%>);
							var marker = createMarker(point1,"<div class='bodyText' align='left'><%= label1%></div>","<div class='bodyText' align='left'><%=label1%></div>",'ST','<%=rstst.getDouble("LatinDec")%>','<%=rstst.getDouble("LonginDec")%>');
						    map.addOverlay(marker);

						<%
						stopdatetime="-";
						
					}
				}
			}
		}


}catch(Exception ex)
{
	%> alert("Exception --><%=ex%>"); <%
}
finally
{
	conn.close();
}
%>
document.getElementById("side_bar").innerHTML = side_bar_html;
     //]]>
    </script>
<% fleetview.closeConnection(); %>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>

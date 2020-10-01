 <%@ include file="headernew.jsp" %>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<script type="text/javascript">
<%!
Connection conn=null;
Statement st=null;
Statement st1=null;
Statement st2=null;
Statement st3=null;
ResultSet rst=null;
ResultSet rst1=null;
ResultSet rst2=null;
ResultSet rst3=null;
String routename="";
String type="";
double lat=0.0,lon=0.0;
%>
<%
try{	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	
	
}
catch(Exception e)
{
	%>
	alert("error 1");
	
	<%
	//System.out.println("hi");
}

%>
	function loadmap()
	{
		//alert("map called");
		var route=document.getElementById("owner").value;
		//var type=document.getElementById("type").value;
		//var waypt=document.getElementById("");
		//alert("Route"+route);
		//alert("type"+type);
		map = new GMap2(document.getElementById("map"));
		
		map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
		map.addControl(new GSmallMapControl());
		map.addControl(new GScaleControl());
//alert("hi");
		if(route==" JohndereToPune")
		{
			//alert("KML load JohndereToPune");
		var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
		map.addOverlay(gx);
	
		

		}
		if(route==" PalaspeToJNPT")
				{
			//alert("KML load PalaspeToJNPT");
		var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
		map.addOverlay(gx2);
	
		
				}
		if(route=="shed-asud")
		{
			//alert("KML LOad shed-asud");
		var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
		map.addOverlay(gx4);
		
		}
		if(route=="SilvasaToBhilad")
		{
			//alert("Kml Load SilvasaToBhilad");
		var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
		map.addOverlay(gx6);
		}
	
<%
		try{
		 		
				
				String waypt="",phno="";
				String name="",TypeName="",phname="";
				int TheId=0;
				String sqlnew="";
				 type=request.getParameter("type");
				 routename=request.getParameter("owner");
				if(type.equals("All"))
						{
					 sqlnew="select type,latvalue,lonvalue,waypt,phno from jrmallroute where rname like '%"+routename+"' and type not in('')";
						}
				else
				{
				 sqlnew="select Distinct(type),latvalue,lonvalue,waypt,phno from jrmallroute where rname like '%"+routename+"' and type like '%"+type+"'";
				}
				ResultSet rs=st.executeQuery(sqlnew);
				
				//System.out.println("Sql"+sqlnew);
				int k=1;
				while(rs.next())
				{
							
					lat=rs.getDouble("latvalue");
					lon=rs.getDouble("lonvalue");
					waypt=rs.getString("waypt");
					//phno=rs.getString("phno");
					name=rs.getString("type");
					//System.out.println("phno"+phno+"t");
					
					
				//	phname="<img src='http://myfleetview.com/FleetView/images/"+phno+".JPG'></img>";
				//	System.out.println("While called");
					%>
					
					var point1 = new GLatLng(<%= lat%>,<%= lon%>);
					//var marker22=createMarker1(point1,"< %= name%>","<div class='bodyText'>< %= phname%></div>");
					var marker22=createMarker1(point1,"<%=name%>","<div class='bodyText'><%= waypt%></div>");
					
					map.addOverlay(marker22);
				
		 			<%
		 			k++;
				}
				
				
				String sqlph="select phno,waypt,latvalue,lonvalue from jrmallroute where rname='"+routename+"' and phno not in('-')";
				ResultSet rstph=st3.executeQuery(sqlph);
				String waypt2="",phno2="";
				double lat2=0.0,lon2=0.0;
				while(rstph.next())
				{
					
					phno2=rstph.getString("phno");
					waypt2=rstph.getString("waypt");
					lat2=rstph.getDouble("latvalue");
					lon2=rstph.getDouble("lonvalue");
					phname="<img src='http://myfleetview.com/FleetView/images/"+phno2+".JPG'></img>";
					
				
				
				%>
				var point2 = new GLatLng(<%= lat2%>,<%=lon2%>);
				var markerph=createMarker2(point2,"<%=waypt2%>","<%= phname%>");
				map.addOverlay(markerph);
				<%
				}
				%>
				map.setCenter(new GLatLng(<%=lat2%>,<%=lon2%>),12);
				<%
				
		    }
			
			catch(Exception e)
			{
				System.out.println("exce"+e);
			}
			
			%>
			
			
			
		
	}
	

	function formsubmit()
	{
		//alert("submit");
		var aa=document.addgrpform.owner.value;
		if(!(aa=="Select"))
		{	
			document.addgrpform.submit();
			//document.addgrpform.owner[0].value = aa;
			//document.addgrpform.owner[0].selected = true;
			//alert(document.addgrpform.owner[0].value);
		}
		

	}

	function formsubmit1()
	{
		//alert("submit1");
		var bb=document.addgrpform.type.value;
		if(!(bb=="Select"))
		{	
			document.addgrpform.submit();
			//document.addgrpform.type[0].value = "Select";
			//document.addgrpform.type[0].selected = true;
			//alert(document.addgrpform.vehcles.value)f;
		}
		

	}

	
	function createMarker2(point,typename,phname) 
	{
		//alert("point="+point+"lat="+lat+"lon="+lon+"typename="+typename+"theid="+theid);
	//  alert("name1"+name1);
		
		var cIcon = new GIcon();


//alert(" Road");
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Cinema.JPG';

		
		cIcon.iconSize = new GSize(20,30);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		var marker = new GMarker(point, markerOptions);
		//var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker, "click", function() {
			 marker.openInfoWindowHtml(typename+phname);
			 
			});
		return marker
		
	  }


	function createMarker1(point,name1,typename) 
	{
		//alert("point="+point+"lat="+lat+"lon="+lon+"typename="+typename+"theid="+theid);
	//  alert("name1"+name1);
		
		var cIcon = new GIcon();


if((name1=="Road") || (name1==" Road"))
{
	//alert(" Road");
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Green.jpg';
}

else if((name1=="Bus Stop")||(name1==" Bus Stop"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Bus1.JPG';
}
else if((name1=="Petrol Pump") || (name1==" Petrol Pump"))
{
	//alert("In pet pump");
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/petrolpump.JPG';
}
else if((name1=="Parking")|| (name1==" Parking"))
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/Red.jpg';
}
else if((name1=="Bridge")|| (name1==" Bridge"))
{
	cIcon.image = 'http://myfleetview.com/JRMImages/FleetView/Tops.jpg';
}
else if((name1=="Bank")|| (name1==" Bank"))
{
	cIcon.image = 'http://myfleetview.com/JRMImages/FleetView/bank.JPG';
}
else if((name1=="Hospital")|| (name1==" Hospital"))
{
	cIcon.image = 'http://myfleetview.com/JRMImages/FleetView/Hospital1.JPG';
}


else if((name1=="Hotel") || (name1==" Hotel"))
{
	cIcon.image = 'http://myfleetview.com/JRMImages/FleetView/Hotel.JPG';
}

else
{
	cIcon.image = 'http://myfleetview.com/FleetView/JRMImages/untitled.JPG';
}
		
		cIcon.iconSize = new GSize(20,30);
		cIcon.iconAnchor = new GPoint(6, 20);
		cIcon.infoWindowAnchor = new GPoint(5, 1);
		markerOptions = { icon:cIcon};
		var marker = new GMarker(point, markerOptions);
		//var marker = new GMarker(point, markerOptions);
		GEvent.addListener(marker, "click", function() {
			 marker.openInfoWindowHtml(name1+"  "+typename);
			 
			});
		return marker
		
	  }
	</script>
	<html>
	<head>
	</head>
	<body>    <!-- <body onload="loadmap()"> -->
	
	<form name="addgrpform"  method="get" action="">
		<br>
	<h3 align="center"><font color="maroon"> JRM Routes</h3>
	<table border="1" align="center">
	
	<%
	
	
%>

	 <tr >
       <td> <font color="maroon"> Route Name: </font> </td>
       <td colspan="3">
       
      	 <select name="owner" id="owner" onChange="formsubmit(this)"> 
         
            <%
            	//System.out.println("routename--->"+routename);
 				if(!(null==routename))
 				{
 	  %>
 		       
 					<option value="<%=routename%>" selected="selected"><%=routename%></option>
 	 <%
 				}
 				else
 				{
 					%>
 					<option value="Select">Select</option>
 					<%
 				}
 	 %>
        <%
        String sql33="SELECT distinct(rname)FROM `jrmallroute`";
        // out.print(sql3); 
        rst1=st1.executeQuery(sql33);
        while(rst1.next())
   	   { %>
      		<option value="<%=rst1.getString("rname") %>" > <%=rst1.getString("rname") %> </option>
	<% } %>
		</select> 
		
   	   </td>
 </tr>
 <tr>
    	      <td> <font color="maroon" > Select Type </font> </td>
     		 <td>  <select name="type" id="type"  onChange="formsubmit1(this)"> 
     		 
     		 
     		 <%
     		//System.out.println("type--->"+type);
     		 if(!(null==type))
 				{
 	  %>
 		       
 					<option value="<%=type %>" selected="selected"><%=type %></option>
 	 <%
 				}
 				else
 				{
 					%>
 					<option value="Select">Select</option>
 					
 					<%
 				}
 	 %>
 	  <option>All</option>
 	 	 <%  
     		 
     		// System.out.println("routename"+routename);
     		 String sql34="SELECT distinct(type) FROM `jrmallroute` where rname like '%"+routename+"' and type not in(' ') order by type Asc";
    // System.out.println(sql34); 
     rst2=st2.executeQuery(sql34);
%>
     		 	 <%  while(rst2.next())  
       		 { 
       		 %>
           		  <option value="<%=rst2.getString("type") %>">  <%=rst2.getString("type") %> </option>
   	     <%  }
     		 	 
     		 	 
     		 %>
     	     
     		
     		     		 
     		 </select>
     		 </td>
	       
     		 
     		 </tr>
     		 
    	 		<tr>
    	 		<td colspan="2"  align="center" >
    	 		<input type="button" name="Submit"  value="Submit" onclick="loadmap();"></input>
    	 		</td></tr>   		 
	</table>
	<table>
	<tr><td align="center">
	<div id=map style="width: 1000px; height: 800px"></div>
	</td></tr>
	</table>
	</form>
	
	
	</body>
	
	</html>
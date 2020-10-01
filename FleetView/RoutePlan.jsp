<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
 <link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link> 
<link href="css/css.css" rel="StyleSheet" type="text/css"></link> 
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
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
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<!-- <link rel="stylesheet" type="text/css" href="css/form.css" media="all"> -->
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
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
<script>
 function Displayer(n)
 {var check = document.getElementById('Section' + n);
 if(check.style.display == 'none')
 {check.style.display='inline';}
 else{check.style.display='none';}
 }
 
 function showtablegeo(routeid)
 {
	 var location=document.getElementById("element_3_1").value;
	  //location=encodeURIComponent(location);
	 var km=document.getElementById("element_3_2").value;
	 try
		{
	//alert("ajax 222");
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
				document.getElementById("thisdiv").innerHTML = reslt;
				window.location.reload();
				document.getElementById("element_3_2").value='';
				document.getElementById("element_3_1").value='';
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?routeid="+routeid+"&element_3_1="+location+"&element_3_2="+km;
		//alert(queryString);
		ajaxRequest.open("POST", "Geofencewisesetinsert.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
 }
 
 
 function showtablekm(routeid,Km)
 {
	 var distance=document.getElementById("element_3_7").value;
	 //var km=document.getElementById("element_3_2").value;
	 try
		{
	//alert("ajax 222");
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
				if(reslt=="1")
					{
				      document.getElementById("thisdistancediverror").style.display="";
					}
				else if(reslt=="2"){
					document.getElementById("thisdistancediverrorprev").style.display="";
				}else{
				
				        document.getElementById("thisdistancediv").innerHTML = reslt;
					}
				window.location.reload();
				document.getElementById("element_3_7").value='';
				//document.getElementById("element_3_1").value='';
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?routeid="+routeid+"&distance="+distance+"&Kmval="+Km;
		//alert(queryString);
		ajaxRequest.open("POST", "distancewisesetinsert.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
 }
 
 function showtableday(routeid,StartCode,EndCode)
 {
	 var Day=document.getElementById("element_3_5").value;
	 //var Quantity=document.getElementById("element_3_6").value;
	 try
		{
	//alert("ajax 222");
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
				document.getElementById("thisdaydiv").innerHTML = reslt;
				window.location.reload();
				document.getElementById("element_3_5").value='';
				//document.getElementById("element_3_6").value='';
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?routeid="+routeid+"&Day="+Day+"&StartPlace="+StartCode+"&EndPlace="+EndCode;
		//alert(queryString);
		ajaxRequest.open("POST", "Daywisesetinsert.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	 
 }
 
 function test(){
	 alert("in skdhfghjdsgfjsd function");
 }
 
 function deletStop(routeid,geofenceid,geofencename,Km)
 {try{//alert("in delete function"+routeid+geofenceid+geofencename+Km+Balance);
 
	  
 	var agree=confirm("Do You Want to Delete this Entry?");
//  	alert("in delete function");
 	if(agree)
     {
 		
            // alert("before delete");
            window.location="RoutePlanDelete.jsp?routeid="+routeid+"&geofenceid="+geofenceid+"&geofencename="+geofencename+"&Km="+Km;
            
     }

 }catch(e)
 {alert(e);
 }
 }
 
 function deletdistance(routeid,distance,rid){
	//alert("here");
	 
	 try{//alert("in delete function"+routeid+geofenceid+geofencename+Km+Balance);
	 
		 var agree=confirm("Do You Want to Delete this Entry?");
        //alert("in delete function");
		 	if(agree)
		     {
		 		
		            // alert("before delete");
		            window.location="DistancePlanDelete.jsp?routeid="+routeid+"&distance="+distance+"&rid="+rid;
		            
		     }

		 }catch(e)
		 {alert(e);
		 }

 }
 
 function deletday(routeid,day)
 {
	 
	 try{//alert("in delete function"+routeid+geofenceid+geofencename+Km+Balance);
	 
		 var agree=confirm("Do You Want to Delete this Entry?");
//		  	alert("in delete function");
		 	if(agree)
		     {
		 		
		            // alert("before delete");
		            window.location="DayPlanDelete.jsp?routeid="+routeid+"&day="+day;
		            
		     }

		 }catch(e)
		 {alert(e);
		 }
	 
 }
 
 
 var v=0;
 function re(count){
		
		alert(v+"---refreshing--"+count);
		
		if(count==1)
		{
			alert("1");
			v=1;
			alert("2");
		}
		v=1;
		if(count==0)
		{
			alert("3");
			if(v==1){
				alert("4");
				
				var test=document.URL +  ' #thisdiv';
				alert("test:-"+test);
				document.getElementById("wait").style.display="";
				//alert("te:-"+$('#mydiv').load(document.URL + ' #mydiv'));
				$('#thisdiv').load(document.URL +  ' #thisdiv');
				alert("5");
				v=0;
				alert("6  "+v);
			}		
		}	
		
		//alert("refreshing1");
		//$("#refreshthis1").load(document.URL +   " #refreshthis1");
	}
 
 function load(){
		re(0);
		setTimeout(re, 3000);	
	}
 
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
Statement stdynamicdrop = null,stmt2=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt2=con1.createStatement();
//String RouteCode=request.getParameter("RouteCode");
//String StartCode1=request.getParameter("StartCode");
///String EndCode1=request.getParameter("EndCode");
String rid=request.getParameter("rid");
String RouteCode=request.getParameter("RouteCode");
%>
<%@ include file="headernew.jsp"%> 

<%	
			String Msg ="0";
			Msg = request.getParameter("Msg");
			if(Msg!=null && Msg.equalsIgnoreCase("1"))
			{
			%>
			<script>
					alert("Deleted Successfully!!!");
			</script>
			<%
			}
			else
				if(Msg!=null && Msg.equalsIgnoreCase("2"))
				{
					%>
					<script>
					   alert("Unable to delete the Entry!!!");
					</script>
					<%
				}
%>
<form name="userform" action="" method="post" onsubmit="return formValidation();">
<br>
<br>
<%
String owner=session.getAttribute("usertypevalue").toString();
String EndPlace="",JRMRouteID="",StartPlace="",startend="",Owner="",vehregno="",StartCode="",EndCode="";
double Km=0.0,tripdays=0.0;

PreparedStatement preparedStatement = null;
//String sql="select * from db_gps.t_castrolroutetest where RouteCode= ? ";
/* String sql="select * from db_gps.t_castrolroutes where RouteCode= ? and StartCode= ? and EndCode=?";
try{
	preparedStatement =con1.prepareStatement(sql);
	preparedStatement.setString(1, RouteCode);
	preparedStatement.setString(2, StartCode1);
	preparedStatement.setString(3, EndCode1);
	ResultSet rs=preparedStatement.executeQuery();
	if(rs.next()){
		JRMRouteID=rs.getString("rid");
		Km=rs.getDouble("FuelApprovedKm");
		StartPlace=rs.getString("StartPlace");
		EndPlace=rs.getString("EndPlace");
		StartCode=rs.getString("StartCode");
		//StartCode=StartCode.trim();
		EndCode=rs.getString("EndCode");
		Owner=rs.getString("Owner");
		tripdays=rs.getDouble("tripdays");
		startend=StartPlace+"-"+EndPlace;
	}
	
	 //vehregno="MH 12 YD 1516";	
}catch(Exception e){
	e.printStackTrace();
} */
String sql="select * from db_gps.routeprofilemaster where rid= ? ";
try{
	preparedStatement =con1.prepareStatement(sql);
	preparedStatement.setString(1, rid);
	//preparedStatement.setString(2, StartCode1);
	//preparedStatement.setString(3, EndCode1);
	ResultSet rs=preparedStatement.executeQuery();
	if(rs.next()){
		JRMRouteID=rs.getString("rid");
		Km=rs.getDouble("stdkm");
		StartPlace=rs.getString("origin");
		EndPlace=rs.getString("destination");
		StartCode=rs.getString("origin");
		//StartCode=StartCode.trim();
		EndCode=rs.getString("destination");
		Owner=rs.getString("owner");
		tripdays=rs.getDouble("transitdays");
		startend=StartPlace+"-"+EndPlace;
	}
	
	 //vehregno="MH 12 YD 1516";	
}catch(Exception e){
	e.printStackTrace();
}
session.setAttribute("routeid", JRMRouteID);
%>

<h1 align="center" style="width: 800px; margin-left: 250;"><font size="3">Fuel Plan Master</font></h1>
<div align="center">
<table width="35%" border="0">
<tr>
<td width="10%">
<table border="0"  width="100%">
<tr align="left">
<td  valign="top" width="0%"><font color="black">  <b> Route ID:</b> <%=JRMRouteID %></font></td>
<td valign="top"><font color="black"><b>Transporter: </b> <%=Owner %></font></td>
<td valign="top"><font color="black" id="dist"><b>Distance:</b> <%=Km %></font></td>
</tr>
<tr align="left">
<td valign="top"  width="0%"><font color="black"><b>Origin:</b> <%=StartPlace %></font></td>
<td valign="top" ><font color="black"><b>Destination:</b> <%=EndPlace %></font></td>

<td valign="top"><font color="black" id="tripdays"><b>TripDays:</b><%=tripdays %> </font></td>

</tr>
</table>
</td>
</tr>
</table>
</div>
<br>
<h1 align="center" style="width: 800px; margin-left: 250;"><font size="3">Daywise Fuel Plan</font></h1>
<div align="center">
<!-- <table align="" class="sortable"  style="width:35%;"> -->
 <table border="0"  stylr="width: 100%; margin-left: 40px;"> 
<tr align="left">
<td  valign="" width="0%" >
<label id="element_1" name="element_1"  class="description" for="element_1"><b>Days</b> </label><select id="element_3_5" name="element_3_5"  style="width: 100px" class="element select medium" >
<option value="select" selected="selected">select</option> 
<%/* String day="select distinct(WareHouse),WareHouseCode from db_gps.t_warehousedata where Owner=? and Status=? "; 
        PreparedStatement ps=con1.prepareStatement(loc);
		ps.setString(1, owner);
		ps.setString(2, "Active");
		ResultSet rs=ps.executeQuery();
		while(rs.next()){ */
			//Double d=new Double(tripdays);
			//int tripdaysize=d.intValue();
			for(int i=0;i< tripdays; i++)
			{%>
				<option value="<%=i+1%>"><%=i+1%></option>
			<% }
%>
<!-- <option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
 --><%/* } */ %>
</select></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td  valign="" width="0%">
<br>
<%-- <label id="element_1" name="element_1"  class="description" for="element_1"><b>Quantity :</b> </label><input id="element_3_6" name="element_3_6"  style="width: 135px;" class="element text medium" type="text"  onkeypress='return (event.charCode >= 0 && event.charCode <= 57) ' value=""/> --%>
<input id="saveForm" name="submit"  class="button_text" type="button"  value="Add" onclick="javaprg:try{showtableday('<%=JRMRouteID %>','<%=StartCode %>','<%=EndCode %>');}catch(e){alert(e);}" /><!-- <input id="addbtn" name="Add"  class="button_text" type="button"  value="Add" /> --><!--1,3-->
</td>
</tr>
</table>
</div>
<div align="center" id="thisdaydiv">
<table class="sortable" border="1" style="width:20%;" >
<tr>
                        <th>
						<b>Days</b>
						</th>
						<th>
						<b>Delete</b>
                        </th>
						</tr>
						<%   int j=1;
	//String Sqlday="select * from db_gps.t_daywisefuelplan where owner=? order by day asc";
	String Sqlday="select * from db_gps.t_daywisefuelplan where owner=? and StartPlace like ? and EndPlace=? and routeid=? order by day asc";
	System.out.println("route name=====>"+Sqlday);
	PreparedStatement ps3=con1.prepareStatement(Sqlday);
	ps3.setString(1, owner);
	ps3.setString(2, "%" + StartCode + "%");
	//ps3.setString(2, StartCode);
	ps3.setString(3, EndCode);
	ps3.setString(4, JRMRouteID);
	ResultSet rsdd=ps3.executeQuery();
	while(rsdd.next())
	{ %>
		<tr>
                 
		<%-- <td align='right'><div align='right'><%=j%></div></td> --%>
		<td align='right'><div align='right'><%=rsdd.getString("day")%></div></td>
		<%-- <td align='right'><div align='right'><%=rsdd.getString("quantity")%></div></td> --%> 
		<%-- <td align='right'><div align='right'><%=Balance%></div></td> --%>
		<td>
          <div  align='center'><a href="" onClick="return deletday('<%=rsdd.getString("routeid")%>','<%=rsdd.getString("day")%>');">Delete</a></div></td></tr> 
				
		
	<% 	//j++;
	}%>
			
</table>
</div>
<br>

<h1 align="center" style="width: 800px; margin-left: 250;"><font size="3">Km Fuel Plan</font></h1>
<div align="center">
<table border="0"  stylr="width: 100%; margin-left: 40px;">
<tr align="left">
<td  valign="" width="0%" >
<label id="element_1" name="element_1"  class="description" for="element_1"><b>Km :</b> </label><input id="element_3_7" name="element_3_7"  style="width: 150px;" class="element text medium" type="text"  onkeypress='return (event.charCode >= 0 && event.charCode <= 57) ' value=""/>
<input id="saveForm" name="submit"  class="button_text" type="button"  value="Add" onclick="javaprg:try{showtablekm('<%=JRMRouteID %>','<%=Km %>');}catch(e){alert(e);}"/>
</td>
</tr>
</table>
</div>
<%
/* String prevoiusdistance="0";
String dis="select distance from db_gps.t_dtwisefuelplan where owner=? "; 
PreparedStatement ps5=con1.prepareStatement(dis);
ps5.setString(1, owner);
ResultSet rs5=ps5.executeQuery();
//while(rs5.absolute(-2)){
while(rs5.next()){
	prevoiusdistance=rs5.getString("distance");
} */
%>
<div align="center" id="thisdistancediverror" style="display:none">
<font size='2' color='red'>Distance should not greater than Total distance</font>
</div>
<div align="center" id="thisdistancediverrorprev" style="display:none">
<font size='2' color='red'>Distance should not greater than previous distance</font>
</div>
<div align="center" id="thisdistancediv">
<table class='sortable' border='1' style='width:25%;' >
<tr>
<th><b>Sr No.</b></th>
<th><b>Distance</b></th>
<th><b>Delete</b></th>
<!-- <th><b>Balance</b></th> -->
</tr> 
<% 
int k=1;
	String Sqldistance="select * from db_gps.t_dtwisefuelplan where owner=? and routeid=? order by ID";
	System.out.println("route name=====>"+Sqldistance);
	PreparedStatement ps6=con1.prepareStatement(Sqldistance);
	ps6.setString(1, owner);
	ps6.setString(2, JRMRouteID);
	ResultSet rsdist=ps6.executeQuery();
	//int countrow=rsd.getRow();
	
	while(rsdist.next())
	{rsdist.getString("distance");%> 
		<tr>
		<td align='right'><div align='right'><%=k%></div></td> 
		<td align='right'><div align='right'><%=rsdist.getString("distrange")%></div></td>
		<td><div  align='center'><a href="" onClick="return deletdistance('<%=rsdist.getString("routeid")%>','<%=rsdist.getString("distance")%>','<%=rsdist.getString("ID")%>');">Delete</a></div></td></tr>
		
	<% 	k++;
	}%>
</table>
</div>
<br>

<!-- <table width="100%" border="1" align="left" style="text-align: center; font-family: Verdana, Arial, Helvetica, sans-serif;	font-weight: normal; font-size: 11px; color: blue; width: 100%; margin-left: 0px; background-color: #e3e9ff; border: 0px; border-collapse: inherit; border-spacing: 0px; border-color: grey" class="" > -->
<h1 align="center" style="width: 800px; margin-left: 250;"><font size="3">Geofence Fuel Plan</font></h1>
<div align="center">
<table border="0"  stylr="width: 100%; margin-left: 40px;">
<tr align="left">
<td  valign="" width="0%" >
<label id="element_1" name="element_1"  class="description" for="element_1"><b>Location</b> </label><select id="element_3_1" name="element_3_1"  class="element select medium" >
<option value="select" selected="selected">select</option> 
<%String loc="select distinct(WareHouse),WareHouseCode from db_gps.t_warehousedata where Owner=? and Status=? "; 
        PreparedStatement ps=con1.prepareStatement(loc);
		ps.setString(1, owner);
		ps.setString(2, "Active");
		ResultSet rs=ps.executeQuery();
		while(rs.next()){
%>
<option value="<%=rs.getString("WareHouse")+"----"+rs.getString("WareHouseCode")%>"><%=rs.getString("WareHouse")%></option>
<%} %>

</select></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td  valign="" width="0%">
<label id="element_1" name="element_1"  class="description" for="element_1"><b>Km :</b> </label><input id="element_3_2" name="element_3_2"  style="width: 135px;" class="element text medium" type="text"  onkeypress='return (event.charCode >= 0 && event.charCode <= 57) ' value=""/>
<input id="saveForm" name="submit"  class="button_text" type="button"  value="Add" onclick="javaprg:try{showtablegeo('<%=JRMRouteID %>');}catch(e){alert(e);}" /><!-- <input id="addbtn" name="Add"  class="button_text" type="button"  value="Add" /> --><!--1,3-->
</td>
</tr>
</table>
</div>

<div align="center" id="thisdiv">
<table class='sortable' border='1' style='width:35%;' >
<tr>
<th><b>Sr No.</b></th>
<th><b>GeofenceName</b></th>
<th><b>Km</b></th>
<th><b>Delete</b></th>
<!-- <th><b>Balance</b></th> -->
</tr> 
     <%   int i=1,Balance=0;
	String SqlRoute="select * from db_gps.t_geofencefuelplan where owner=? and routeid=? order by rid";
	System.out.println("route name=====>"+SqlRoute);
	PreparedStatement ps2=con1.prepareStatement(SqlRoute);
	ps2.setString(1, owner);
	ps2.setString(2, JRMRouteID);
	ResultSet rsd=ps2.executeQuery();
	while(rsd.next())
	{ %>
		<tr>
                 
		<td align='right'><div align='right'><%=i%></div></td>
		<td align='right'><div align='left'><%=rsd.getString("geofencename")%></div></td>
		<td align='right'><div align='right'><%=rsd.getString("Km")%></div></td> 
		<%-- <td align='right'><div align='right'><%=Balance%></div></td> --%>		
		<td>
          <div  align='center'><a href="" onClick="return deletStop('<%=rsd.getString("routeid")%>','<%=rsd.getString("geofenceid")%>','<%=rsd.getString("geofencename")%>','<%=rsd.getInt("Km")%>');">Delete</a></div></td></tr> 
		
		
	<% 	i++;
	}%>
	</table>		

</div>




<input type="hidden" id="EndPlace" name="EndPlace" value="<%=EndPlace%>" />
<input type="hidden" id="RouteCode" name="RouteCode" value="<%=RouteCode%>" />

</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
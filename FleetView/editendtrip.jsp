<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<script language="javascript">
function validate()
{
	var time=document.tripend.endtime1.value;
	var time1=document.tripend.starttime1.value;
	if(time1=="Select")
	{
		alert("Please enter Start Time");
		return false;
	}
		
	
	if(time=="Select")
	{
		alert("Please enter End Time");
		return false;
	}
	return datevaildate();
}

function datevaildate()
{
	var stdate=document.tripend.stdate.value;
	var enddate=document.tripend.calender1.value;

	var sttime=document.tripend.sttime.value;
	var endtime1=document.tripend.endtime1.value;
	var endtime2=document.tripend.endtime2.value;
	

	var dm1,dd1,dy1,dm2,dd2,dy2;
	var stm1, stm2;

	dy1=stdate.substring(0,4);
	dm1=stdate.substring(5,7);
	dd1=stdate.substring(8,10);

	dy2=enddate.substring(0,4);
	dm2=enddate.substring(5,7);
	dd2=enddate.substring(8,10);

	stm1=sttime.substring(0,2);
	stm2=sttime.substring(3,5);
	
	if(dy2<dy1)
	{
		alert("Trip End date cannot be less than Trip Start date (year)");
		return false;
	}
	
	if(dy2==dy1)
	{
		  if(dm2<dm1)
		  {
			alert("Trip End date cannot be less than Trip Start date (month)");
			return false;
                  }
	}

	if(dy2==dy1 && dm2==dm1)
	{
		if(dd2<dd1)
		{
			alert("Trip End date cannot be less than Trip Start date (day)");
			return false;
		}
	}

	if(dy2==dy1 && dm2==dm1 && dd2==dd1)
	{
		if(endtime1<stm1)
		{
			alert("Trip End time cannot be less than Trip Start time. Trip Start Time is "+sttime);
			return false;
		}
	
		if(endtime1==stm1)
		{
			if(endtime2<stm2)
			{
				alert("Trip End time cannot be less than Trip Start time. Trip Start Time is "+sttime);
				return false;
			}
		}
		
	}
	
	return true;
}

function showlocation(dropdown, vehcode, vehno)
{
	var vv=dropdown.selectedIndex;
        var SelValue = dropdown.options[vv].value;
	
	var hrs=document.tripend.endtime1.value;
	var mins=document.tripend.endtime2.value;
	var seldte=document.tripend.calender1.value;
	
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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         //alert(reslt);
                         document.getElementById("loc").innerHTML=reslt;
                         
		     } 
         	  }
             var queryString = "?hrs="+hrs+"&mins="+mins+"&vehcode="+vehcode+"&seldte="+seldte+"&vehno="+vehno;
	     ajaxRequest.open("GET", "Ajaxgetlocation.jsp" + queryString, true);
	     ajaxRequest.send(null); 
}
</script>
<html>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<head>
<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>

</head>

<body background="images/green_grad_bot.jpg" onload="focusChild();">

<form name="tripend" action="" method="post" onSubmit="return validate();">
<%!
Connection con1, con2;
String vehcode="", vehreg="", stplace="", endplace="", stdate="", sttime="", driverid="", drivername="", stcode="", endcode="", gpname="",ownername="";
double stlat=0, stlong=0, endlat=0, endlong=0;
int oscount=0,account=0,dccount=0,distance=0,stopcount=0, stkm=0, endkm=0, totkm=0;
%>

<% 
try {


	Class.forName(MM_dbConn_DRIVER);
	con2 = fleetview.ReturnConnection1();
	con1 = fleetview.ReturnConnection();

Statement stmt1=con1.createStatement(), stmt2=con2.createStatement(), stmt3=con1.createStatement(),stmt4=con1.createStatement(),stmtstrt=con1.createStatement();
Statement stquery=con1.createStatement();
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null, rs16=null, rs17=null,rs18=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql13="", sql14="", sql15="", sql16="", sql17="",sql18="";

String location="", latitu="", longi="";
String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehno");

String trans=request.getParameter("trans"); 
java.util.Date d=new java.util.Date();
String rfname="",rlname="";
String dte=new SimpleDateFormat("yyyy-MM-dd").format(d);
int hours=(d.getHours());
int minutes=(d.getMinutes());
/*
//=============================================================================
try{
	
	sql11="select * from t_defaultvals where OwnerName='"+usertypevalue+"'";

	//sql11="select * from t_defaultvals where OwnerName='Default'";
	
//}System.out.println("sql11-------->"+sql11);
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
session.setAttribute("desconnected",rst11.getString("DisconnectedPeriod"));
session.setAttribute("distformat",rst11.getString("DistFormat"));
session.setAttribute("fuelformat",rst11.getString("FuelFormat"));
System.out.println("rst11.getString(DateFormat)--->" +  rst11.getString("DateFormat"));
session.setAttribute("dateformat",rst11.getString("DateFormat"));

System.out.println("" + session.getAttribute("dateformat"));
}
}catch(Exception e)
{
	out.print("Exception"+e);
}*/
//=================================================================


	String loginuser=session.getValue("user").toString();
	String user=session.getValue("usertypevalue").toString();
	String tripid=request.getParameter("tripid");
	
	/*////////////////////////////////////////////////////////*/
	String strtdate=request.getParameter("calenderStart");
	String strthrs=request.getParameter("starttime1");
	String strtmin=request.getParameter("starttime2");
	String strttime=strthrs+":"+strtmin+":00";	
	/*////////////////////////////////////////////////////////*/
	
	String enddate=request.getParameter("calender1");
	String endhrs=request.getParameter("endtime1");
	String endmin=request.getParameter("endtime2");
	String endtime=endhrs+":"+endmin+":00";	
	
	
	rfname=session.getAttribute("rfname").toString(); //.setAttribute("rfname",fnamelist);
	rlname=session.getAttribute("rlname").toString();
	
	
 	java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
   	Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   	String nwfrmtdte=formatter.format(datefrmdb);

	java.util.Date datefrmdb1=new java.util.Date();
	Format formatter1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   	String nwfrmtdte1=formatter1.format(datefrmdb1);

/*	String sql12="select * from t_completedjourney where TripId='"+tripid+"' ";
	ResultSet rs12=stmt1.executeQuery(sql12);
	if(rs12.next())
	{*/ %>
		<!--<table border="0" width="100%">
			<tr>
				<td align="center"> <font color="maroon"> <B>Trip End information for this Trip has already been entered. </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font color="maroon"> <B> Note: </B> Please refresh 'Current Position' page to reflect the changes. </font> </td>
			</tr>	
			</table>-->
<%//	}
	//else
//	{

%>

<table border="1" width="100%" class="sortable_entry">
     <tr>
			<td colspan="2" align="center"> <font size="3"> <B> Trip End Information of <%=vehno%> </B> </font> </td>
     </tr>	
     <!-- //////////////////////////////////////  Edit Start Date-Time /////////////////////////////////////////////////// 
     <tr>
			<td> <font size="2" color="maroon"> Start Date </font> </td>
			<td> <input type="text" id="calenderStart" name="calenderStart" size="15" value="<%=nwfrmtdte%>" readonly/>
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="button" name="triggerstrt" id="triggerstrt" value="Date">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calenderStart",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "triggerstrt"       // ID of the button
             }
                           );
             </script>
	</td>
     <tr>
	<td> <font color="maroon" size="2"> Start Time </font> </td>
	<td> <font color="maroon" size="2">
	            HH : </font> <select name="starttime1" onChange="showlocation(this, <%//=vehiclecode%>, '<%//=vehno%>');">
                   <option value="Select">Select</option>
                                                        
                  
        	          
        	          
        	    </select> &nbsp;&nbsp;&nbsp;
                 
	</td>
     </tr>	
     </tr>
      /////////////////////////////////////////////////////////////////////////////////////////////////////// -->
     
     	
     <tr>
			<td> <font> End Date </font> </td>
			<td> <input type="text" id="calender1" name="calender1" size="15" value="<%=nwfrmtdte%>" readonly/>
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="button" name="trigger1" id="trigger1" value="Date">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger1"       // ID of the button
             }
                           );
             </script>
	</td>
     <tr>
	<td> <font> End Time </font> </td>
	<td> <font>
	            HH : </font> <select name="endtime1" onChange="showlocation(this, <%=vehiclecode%>, '<%=vehno%>');">
                   <option value="Select">Select</option>
                   <option value="00" <% if(00==hours) { %> Selected <% } %> >00</option>
                   <option value="01" <% if(01==hours) { %> Selected <% } %>>01</option>
                   <option value="02" <% if(02==hours) { %> Selected <% } %>>02</option>
                   <option value="03" <% if(03==hours) { %> Selected <% } %>>03</option>
                   <option value="04" <% if(04==hours) { %> Selected <% } %>>04</option>
                   <option value="05" <% if(05==hours) { %> Selected <% } %>>05</option>
                   <option value="06" <% if(06==hours) { %> Selected <% } %>>06</option>
                   <option value="07" <% if(07==hours) { %> Selected <% } %>>07</option>
                   <option value="08" <% if(8==hours) { %> Selected <% } %>>08</option>
                   <option value="09" <% if(9==hours) { %> Selected <% } %>>09</option>
                   <option value="10" <% if(10==hours) { %> Selected <% } %>>10</option>
                   <option value="11" <% if(11==hours) { %> Selected <% } %>>11</option> 
                   <option value="12" <% if(12==hours) { %> Selected <% } %>>12</option>
                   <option value="13" <% if(13==hours) { %> Selected <% } %>>13</option>
                   <option value="14" <% if(14==hours) { %> Selected <% } %>>14</option>
                   <option value="15" <% if(15==hours) { %> Selected <% } %>>15</option>
                   <option value="16" <% if(16==hours) { %> Selected <% } %>>16</option>
                   <option value="17" <% if(17==hours) { %> Selected <% } %>>17</option>
                   <option value="18" <% if(18==hours) { %> Selected <% } %>>18</option>
                   <option value="19" <% if(19==hours) { %> Selected <% } %>>19</option>
                   <option value="20" <% if(20==hours) { %> Selected <% } %>>20</option>
                   <option value="21" <% if(21==hours) { %> Selected <% } %>>21</option> 
                   <option value="22" <% if(22==hours) { %> Selected <% } %>>22</option>
                   <option value="23" <% if(23==hours) { %> Selected <% } %>>23</option>
            	 </select>  <font>
        		MM :</font> <select name="endtime2" onChange="showlocation(this, <%=vehiclecode%>, <%=vehno%>);">
        			  <option value="00" <% if(minutes == 00) { %> Selected <% } %>>00</option>
        	          <option value="01" <% if(minutes == 01) { %> Selected <% } %>>01</option>
        	          <option value="02" <% if(minutes == 02) { %> Selected <% } %>>02</option>
        	          <option value="03" <% if(minutes == 03) { %> Selected <% } %>>03</option>
        	          <option value="04" <% if(minutes == 04) { %> Selected <% } %>>04</option>
        	          <option value="05" <% if(minutes == 05) { %> Selected <% } %>>05</option>
        	          <option value="06" <% if(minutes == 06) { %> Selected <% } %>>06</option>
        	          <option value="07" <% if(minutes == 07) { %> Selected <% } %>>07</option>
        	          <option value="08" <% if(minutes == 8) { %> Selected <% } %>>08</option>
        	          <option value="09" <% if(minutes == 9) { %> Selected <% } %>>09</option>
        	          <option value="10" <% if(minutes == 10) { %> Selected <% } %>>10</option>
        	          
        	          <option value="11" <% if(minutes == 11) { %> Selected <% } %>>11</option>
        	          <option value="12" <% if(minutes == 12) { %> Selected <% } %>>12</option>
        	          <option value="13" <% if(minutes == 13) { %> Selected <% } %>>13</option>	          
        	          <option value="14" <% if(minutes == 14) { %> Selected <% } %>>14</option>
        	          <option value="15" <% if(minutes == 15) { %> Selected <% } %>>15</option>
        	          <option value="16" <% if(minutes == 16) { %> Selected <% } %>>16</option>
        	          <option value="17" <% if(minutes == 17) { %> Selected <% } %>>17</option>
        	          <option value="18" <% if(minutes == 18) { %> Selected <% } %>>18</option>
        	          <option value="19" <% if(minutes == 19) { %> Selected <% } %>>19</option>
        	          <option value="20" <% if(minutes == 20) { %> Selected <% } %>>20</option>
        	          
        	          
        	          <option value="21" <% if(minutes == 21) { %> Selected <% } %>>21</option>
        	          <option value="22" <% if(minutes == 22) { %> Selected <% } %>>22</option>
        	          <option value="23" <% if(minutes == 23) { %> Selected <% } %>>23</option>
        	          <option value="24" <% if(minutes == 24) { %> Selected <% } %>>24</option>
        	          <option value="25" <% if(minutes == 25) { %> Selected <% } %>>25</option>
        	          <option value="26" <% if(minutes == 26) { %> Selected <% } %>>26</option>
        	          <option value="27" <% if(minutes == 27) { %> Selected <% } %>>27</option>
        	          <option value="28" <% if(minutes == 28) { %> Selected <% } %>>28</option>
        	          <option value="29" <% if(minutes == 29) { %> Selected <% } %>>29</option>
        	          <option value="30" <% if(minutes == 30) { %> Selected <% } %>>30</option>
        	          
        	          
        	          <option value="31" <% if(minutes == 31) { %> Selected <% } %>>31</option>
        	          <option value="32" <% if(minutes == 32) { %> Selected <% } %>>32</option>
        	          <option value="33" <% if(minutes == 33) { %> Selected <% } %>>33</option>
        	          <option value="34" <% if(minutes == 34) { %> Selected <% } %>>34</option>
        	          <option value="35" <% if(minutes == 35) { %> Selected <% } %>>35</option>
        	          <option value="36" <% if(minutes == 36) { %> Selected <% } %>>36</option>
        	          <option value="37" <% if(minutes == 37) { %> Selected <% } %>>37</option>
        	          <option value="38" <% if(minutes == 38) { %> Selected <% } %>>38</option>
        	          <option value="39" <% if(minutes == 39) { %> Selected <% } %>>39</option>
        	          <option value="40" <% if(minutes == 40) { %> Selected <% } %>>40</option>
        	          
        	          
        	          <option value="41" <% if(minutes == 41) { %> Selected <% } %>>41</option>
        	          <option value="42" <% if(minutes == 42) { %> Selected <% } %>>42</option>
        	          <option value="43" <% if(minutes == 43) { %> Selected <% } %>>43</option>
        	          <option value="44" <% if(minutes == 44) { %> Selected <% } %>>44</option>
        	          <option value="45" <% if(minutes == 45) { %> Selected <% } %>>45</option>
        	          <option value="46" <% if(minutes == 46) { %> Selected <% } %>>46</option>
        	          <option value="47" <% if(minutes == 47) { %> Selected <% } %>>47</option>
        	          <option value="48" <% if(minutes == 48) { %> Selected <% } %>>48</option>
        	          <option value="49" <% if(minutes == 49) { %> Selected <% } %>>49</option>
        	          <option value="50" <% if(minutes == 50) { %> Selected <% } %>>50</option>
        	          
        	          
        	          <option value="51" <% if(minutes == 51) { %> Selected <% } %>>51</option>
        	          <option value="52" <% if(minutes == 52) { %> Selected <% } %>>52</option>
        	          <option value="53" <% if(minutes == 53) { %> Selected <% } %>>53</option>
        	          <option value="54" <% if(minutes == 54) { %> Selected <% } %>>54</option>
        	          <option value="55" <% if(minutes == 55) { %> Selected <% } %>>55</option>
        	          <option value="56" <% if(minutes == 56) { %> Selected <% } %>>56</option>
        	          <option value="57" <% if(minutes == 57) { %> Selected <% } %>>57</option>
        	          <option value="58" <% if(minutes == 58) { %> Selected <% } %>>58</option>
        	          <option value="59" <% if(minutes == 59) { %> Selected <% } %>>59</option>
        	          
        	          
        	    </select> &nbsp;&nbsp;&nbsp;
                 
	</td>
     </tr>	
     </tr>
	<td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" /> </td> 
     </tr>
</table>

<%
	sql10="select * from t_onlinedata where VehicleCode='"+vehiclecode+"' ";
	rs10=stmt1.executeQuery(sql10);
	if(rs10.next())
	{
		location=rs10.getString("Location");
		latitu=rs10.getString("LatitudePosition");
		longi=rs10.getString("LongitudePosition"); 
	}
%>

<div id="loc">
<table border="0" width="100%" class="stats">
     <tr>
	<td colspan="2" align="left"> <font size="2"> Location at selected time is: 
	<%=fleetview.showNewMap(latitu,longi,location) %>
	</font> 
	 </td>
     </tr>		
</table>
</div>
<table border="0" width="100%" >
     <tr>
	<td colspan="2" align="center"><a href="javascript:window.close();">Close </a> </td>
     </tr>		
</table>


<%
//System.out.println("1");
/*			
		update/change start date-time
		String sqlstrt="update t_startedjourney SET StartDate='"+strtdate+"',StartTime='"+strttime+"' where TripId='"+tripid+"'";//JDCode='"+tripid+"',VehId='"+vehcode+"', VehRegNo='"+vehreg+"',StartPlace='"+stplace+"',StartDate='"+stdate+"',StartTime='"+sttime+"',EndPlace='"+endplace+"',EndDate='"+enddate+"',EndTime='"+endtime+"',KmTravelled='"+totkm+"',OSCount='"+oscount+"',OSDuration='"+osdur+"',RACount='"+account+"',RDCount='"+dccount+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"' where TripId='"+tripid1+"' and VehId='"+vehcode+"' and StartPlace='"+startplace+"' and StartDate='"+startdate+"' and StartTime='"+starttime+"' and EndPlace='"+endplace+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+jdcode+"'";
		stmtstrt.executeUpdate(sqlstrt);
	
		System.out.println("Updatesql::>>>"+sqlstrt);
		//stmt1.executeQuery(sqlstrt);
		
	*/	
		sql1="select * from t_startedjourney where TripId='"+tripid+"' ";
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			//System.out.println("Trip id---->"+rs1.getString("TripId"));
			vehcode=rs1.getString("Vehid");
			vehreg=rs1.getString("VehRegNo");
			stplace=rs1.getString("StartPlace");
			
			endplace=rs1.getString("EndPlace");
			
			stdate=rs1.getString("StartDate");
			System.out.print("StartDate::>>>"+stdate);
			sttime=rs1.getString("StartTime");
			System.out.print("StartTime::>>>"+sttime);
			
			driverid=rs1.getString("DriverCode");
			drivername=rs1.getString("DriverName");
			stcode=rs1.getString("StartCode");
			endcode=rs1.getString("EndCode");
			gpname=rs1.getString("GPName");
			ownername=rs1.getString("OwnerName");
			/*System.out.println("Trip id---->"+vehcode);
			System.out.println("Veh---->"+vehreg);
			System.out.println("startpl---->"+stplace);
			System.out.println("endpl---->"+endplace);
			System.out.println("stdate---->"+stdate);
			System.out.println("sttime---->"+sttime);
			System.out.println("gpname---->"+gpname);
			System.out.println("owner---->"+ownername);*/
		}
		ResultSet rstoscount=fleetview.getOSforDateRange(stdate+" "+sttime,enddate+" "+endtime,vehcode);
		while(rstoscount.next())
		{
		oscount++;
		}
		ResultSet rstaccount=fleetview.getACforDateRange(stdate+" "+sttime,enddate+" "+endtime,vehcode);
		while(rstaccount.next())
		{
		account++;
		}
		ResultSet rstdccount=fleetview.getDCforDateRange(stdate+" "+sttime,enddate+" "+endtime,vehcode);
		while(rstdccount.next())
		{
		dccount++;
		}
		//out.print(oscount+" "+account+" "+dccount);

			//gpname=rs1.getString("GPName");
		//} 

		//if((sttime==null) || (sttime.equals("")))
		//{
		//	sttime="00:00:00";	
		//}
%>
	<input type="hidden" name="stdate" value="<%=stdate%>" />
	<input type="hidden" name="sttime" value="<%=sttime%>" />
<%
//System.out.println("enddt---->"+enddate);
	if(enddate==null)
	{
	}
	else

	{		
		//boolean flag=false;
		
			

			
		String Stamp="";
		int oscount=0, account=0, dccount=0, ndcount=0, stcount=0;
		double osdur=0;
		sql11="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1 ";
		//System.out.println(sql11);
		//sql11="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,TheFieldDataTime) >=concat('"+stdate+"', '"+sttime+"') and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		 rs11=stmt1.executeQuery(sql11);
		 if(rs11.next())
		 {
			stkm=rs11.getInt("Distance");	
		//	System.out.println("Start Km"+stkm);
		 }
		 
		 sql13="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		// System.out.println(sql13);
		 //sql13="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		 rs13=stmt1.executeQuery(sql13);
		 if(rs13.next())
		 {
			endkm=rs13.getInt("Distance");	
		//	System.out.println("endkm---->"+endkm);
		 }
		 
		 totkm=endkm-stkm;
		// System.out.println("total Km"+totkm);
		 
		 sql14="SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and LonginDec>0 and TheFiledTextFileName in ('AC','DC','OS') order by concat(TheFieldDataDate,TheFieldDataTime) desc";
		// System.out.println(sql14);
		 rs14=stmt1.executeQuery(sql14);
		 while(rs14.next())
		 {
			 Stamp=rs14.getString("TheFiledTextFileName");
			 
			 if (Stamp.equals("OS"))
			 {
				 oscount++;
				 osdur=osdur+rs14.getDouble("Distance");
			 }
			 else if (Stamp.equals("AC"))
			 {
			 	if (rs14.getInt("Distance")>5)
			 	{
			 		account++;
			 	}
			 }
			 else if (Stamp.equals("DC"))
			 {
					if (rs14.getInt("Distance")<120)
					{
						dccount++;	
					}
			 }	
			 /*System.out.println("oscount---->"+oscount);
			 System.out.println("account---->"+account);
			 System.out.println("dccount---->"+dccount);*/
		 }
		 
		/* sql15="select count(*) as cnt from t_veh"+vehcode+"_nd where concat(FromDate,' ',FromTime) between '"+stdate+" "+sttime+"' and '"+enddate+" "+endtime+"'";
		 rs15=stmt2.executeQuery(sql15);
		 if(rs15.next())
		 {
			 ndcount=rs15.getInt("cnt");
		 }*/
		
		 /*************************************code for stops**************************************** */


	 	 sql16="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ enddate+" "+endtime+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		//out.print("sql16="+sql16);
		 rs16= stmt1.executeQuery(sql16);
		// System.out.println(sql16);
		 while(rs16.next())
		 {
		 	
			 sql17="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFieldDataDate='"+rs16.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rs16.getString("time1"))+" and abs(LatinDec - "+rs16.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1";
		 	//out.print(sql17);
		// 	System.out.println(sql17);
		 	
		 	rs17= stmt3.executeQuery(sql17);
		 	if(rs17.next())
		 	{ 
		 		//System.out.println(Integer.parseInt(session.getAttribute("stop11").toString()));
		 		if(rs17.getDouble("time2")-rs16.getDouble("time1") >=30)
		 		{
		 			stcount++;
		 		}
		 	}
		 }	
		 /* ************************************************************************* */
		 
		 /* **********************Calculating Rating********************* */
		//  System.out.println("stcount---->"+stcount);
		 	double rating=0;
		 	if(totkm>0)
		 	{
		 		rating=(account/totkm)*100 + (dccount/totkm)*100 +((osdur/10)/totkm)*100;
		 	}
		 
		 /* ************************************************************************* */
			sql18="select * from t_completedjourney where TripID='"+tripid+"' ";
		 //  System.out.println("Selectsql::>>"+sql18);  
			rs18=stmt4.executeQuery(sql18);
			if(rs18.next())
			{
				String tripid1=rs18.getString("TripId");
				String vehcode=rs18.getString("VehId");
				String vehregno=rs18.getString("VehRegNo");
				String startplace=rs18.getString("StartPlace");
				String startdate=rs18.getString("StartDate");
				String starttime=rs18.getString("StartTime");
				String endplace=rs18.getString("EndPlace");
				String enddate1=rs18.getString("EndDate");
				String endtime1=rs18.getString("EndTime");
				String driverid=rs18.getString("DriverId");
				String drivername=rs18.getString("DriverName");
				String ownername=rs18.getString("OwnerName");
				String gpname=rs18.getString("GPName");
				String jdcode=rs18.getString("JDCode");
				//sql2="update t_completedjourney SET JDCode='"+jdcode+"',VehId='"+vehcode+"', VehRegNo='"+vehregno+"',StartPlace='"+startplace+"',StartDate='"+startdate+"',StartTime='"+starttime+"',EndPlace='"+endplace+"',EndDate='"+enddate1+"',EndTime='"+endtime1+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"' where TripId='"+tripid1+"' and VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+jdcode+"'";
				sql2="update t_completedjourney SET JDCode='"+tripid+"',VehId='"+vehcode+"', VehRegNo='"+vehreg+"',StartPlace='"+stplace+"',StartDate='"+stdate+"',StartTime='"+sttime+"',EndPlace='"+endplace+"',EndDate='"+enddate+"',EndTime='"+endtime+"',KmTravelled='"+totkm+"',OSCount='"+oscount+"',OSDuration='"+osdur+"',RACount='"+account+"',RDCount='"+dccount+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"' where TripId='"+tripid1+"'";
				//out.println("Updatesql::>>>"+sql2);
				
				/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql2.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	
/*****************************/
				stmt1.executeUpdate(sql2);
			}
			else
			{
						
		
			sql2="insert into t_completedjourney (TripId, VehId, VehRegNo, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, JourneyStatus, DriverId, DriverName, OwnerName, GPName, JDCode, RACount, RDCOunt, OSCOunt, NDCount, StopDuration, OSDuration, TripRating) values ('"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stcode+"', '"+stdate+" "+sttime+"', '"+sttime+"', '"+endplace+"', '"+endcode+"', '"+enddate+" "+endtime+"', '"+endtime+"', '"+stkm+"', '"+endkm+"', '"+totkm+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+ownername+"', '"+gpname+"', '"+tripid+"', '"+account+"', '"+dccount+"', '"+oscount+"', '"+ndcount+"', '"+stcount+"', '"+osdur+"', '"+rating+"') ";   
			
		/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			
		/*****************************/
			stmt1.executeUpdate(sql2);
			}  
			  sql3="update t_startedjourney set JStatus='Completed',EndedBy='"+rfname+" "+rlname+"' where TripID='"+tripid+"' ";
			  
			  /*Query to insert query in db_gps.t_sqlquery table*/
				String abcd1=sql3.replace("'","#");
				abcd1=abcd1.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
				
			/*****************************/
			  
			  stmt1.executeUpdate(sql3); 

			 sql4="select * from t_warehousedata where WareHouseCode='"+stcode+"' and Owner='"+user+"' ";
			// System.out.println(sql4);
      			 rs4=stmt1.executeQuery(sql4);
        		 if(rs4.next())
        		 {
        			 System.out.print("::>>>if");
        		 }
			 else
     			{
        		      sql5="select * from t_veh"+vehcode+" where TheFieldDataDate='"+stdate+"' and TheFieldDataTime<='"+sttime+"' and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
				//out.print(sql5);
        		     rs5=stmt1.executeQuery(sql5);
        		//     System.out.println("::>>>"+sql5);
        		      if(rs5.next())
        		      { 
        		  //  	  System.out.println("::>>>if");
        		          stlat=rs5.getDouble("LatinDec");
        		          stlong=rs5.getDouble("LonginDec");

				  sql6="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('-', '"+stplace+"', '"+user+"', '"+user+"', '"+stlat+"', '"+stlat+"', '"+stlat+"', '"+stlong+"', '"+stlong+"', '"+stlong+"', 'WH',  GeomFromText('POINT("+stlat+" "+stlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
              /*Query to insert query in db_gps.t_sqlquery table*/
				String abcd2=sql6.replace("'","#");
				abcd2=abcd2.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
			 /*****************************/

        		         stmt1.executeUpdate(sql6); 
        		      } 
        		}

             
			 sql7="select * from t_warehousedata where WareHouseCode='"+endcode+"' and Owner='"+user+"' ";
    	
        		 rs7=stmt1.executeQuery(sql7);
        		 if(rs7.next())
        		 {
				System.out.print("in if"+sql7);
        		 }
			 else
        		 {
        		      sql8="select * from t_veh"+vehcode+" where TheFieldDataDate='"+enddate+"' and TheFieldDataTime<='"+endtime+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
        		      rs8=stmt1.executeQuery(sql8);
        		      if(rs8.next())
        		      { 
        		          endlat=rs8.getDouble("LatinDec");
        		          endlong=rs8.getDouble("LonginDec"); 
        		         // System.out.println("in else");
				sql9="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('"+endplace+"', '"+endplace+"', '"+user+"', '"+user+"', '"+endlat+"', '"+endlat+"', '"+endlat+"', '"+endlong+"', '"+endlong+"', '"+endlong+"', 'WH', GeomFromText('POINT("+endlat+" "+endlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
				
			/*Query to insert query in db_gps.t_sqlquery table*/
				String abcd3=sql9.replace("'","#");
				abcd3=abcd3.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd3+"')");
				
			/*****************************/

        		    stmt1.executeUpdate(sql9); 
        		    
                  
        		      }
          
        		 }
%>   
		
		
			<table border="0" width="100%">
			<tr>
				<td align="center"> <font> <B>Successfully Done </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font> <B> Note: </B> Please refresh 'Current Position' page to reflect the changes. </font> </td>
			</tr>	
			</table>

<%
		
	//} //close of outer else
} //close of MAIN ELSE


} catch(Exception e) { e.printStackTrace(); }
finally
{
	try
	{
con1.close();
	}
	catch(Exception e)
	{	
	}
	try
	{
	con2.close();
	}
	catch(Exception e){}
	try
	{
fleetview.closeConnection1();
	}
	catch(Exception e){}
	try
	{
fleetview.closeConnection();
	}
	catch(Exception e){}
} 
  
%>

</form>
</body>
</html>
<%

%>
</jsp:useBean>
	

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

	if(time=="Select")
	{
		alert("Please enter Arrival Time");
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
<script>
function showme(udr)
{
	//alert("hi"+udr);
	if(udr=="other")
	{
	//	alert("welcome");
		document.getElementById('udr').style.visibility="visible";
	}
	else
	{
		document.getElementById('udr').style.visibility="hidden";
		//alert("select");
	}
}

</script>
<html>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<head>
<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>

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
String vehcode="", vehreg="", stplace="", endplace="", stdate="",tripcat="", sttime="",rptdatetme="",loadingdelay="",Unloadingdelay="", driverid="", drivername="", stcode="", endcode="", gpname="",ownername="";
double stlat=0, stlong=0, endlat=0, endlong=0;
int oscount=0,account=0,dccount=0,distance=0,stopcount=0, stkm=0, endkm=0, totkm=0;
%>

<% 
try {


	Class.forName(MM_dbConn_DRIVER);
	con2 = fleetview.ReturnConnection1();
	con1 = fleetview.ReturnConnection();

Statement stmt1=con1.createStatement(), stmt2=con2.createStatement(), stmt3=con1.createStatement(),stmt4=con1.createStatement();
Statement stquery=con1.createStatement();

ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null, rs16=null, rs17=null,rs18=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql13="", sql14="", sql15="", sql16="", sql17="",sql18="",Unloadingcomment="";

String location="", latitu="", longi="",weight="",vendor="",delayrsn="";;
String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehno");
java.util.Date d=new java.util.Date();
String rfname="",rlname="";
String dte=new SimpleDateFormat("yyyy-MM-dd").format(d);
int hours=(d.getHours());
int minutes=(d.getMinutes());

	String loginuser=session.getValue("user").toString();
	String user=session.getValue("usertypevalue").toString();
	String tripid=request.getParameter("tripid");
	String enddate=new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("EDate")));
	String endhrs=new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(request.getParameter("ETime")));
	String endmin=new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(request.getParameter("ETime")));
	String unloaddate=request.getParameter("calender11");
	String unloadendhrs=request.getParameter("endtime11");
	String unloadendmin=request.getParameter("endtime12");
	String endtime=endhrs+":"+endmin+":00";	
	String unloadtime=unloadendhrs+":"+unloadendmin+":00";	
	String unloaddttime=unloaddate+" "+unloadendhrs+":"+unloadendmin+":00";
	rfname=session.getAttribute("rfname").toString(); //.setAttribute("rfname",fnamelist);
	rlname=session.getAttribute("rlname").toString();
	Unloadingcomment=request.getParameter("unloadcmnt");
	 delayrsn =request.getParameter("udr1");
	 if(!(null==delayrsn) && delayrsn.equalsIgnoreCase("other"))
	 {
		 delayrsn =request.getParameter("udr");
	 }
	
 	java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
   	Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   	String nwfrmtdte=formatter.format(datefrmdb);

	java.util.Date datefrmdb1=new java.util.Date();
	Format formatter1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   	String nwfrmtdte1=formatter1.format(datefrmdb1);

	String sql12="select * from t_completedjourney where TripId='"+tripid+"' ";
	ResultSet rs12=stmt1.executeQuery(sql12);
	if(rs12.next())
	{ %>
	 <table border="1" width="100%" class="stats" >
     <tr>
			<td colspan="2" align="center"> <font size="3" > <B> Trip End Information of <%=tripid%> </B> </font> </td>
     </tr>		
     </table>
     <table border="0" width="100%" class="sortable_entry" >
     <tr>
			<td> <font size="2" > <div><b>Arrival Date Time </b></div></font> </td>
			<td><font size="2" > Date<input type="text" id="enddte" name="enddte" size="10"  value="<%=enddate%>" readonly/>
			    <font  size="2"> HH:<input type="text" id="endtime1" name="endtime1" size="02" value="<%=endhrs%>" readonly/>
			   <font  size="2">  MM:<input type="text" id="endtime2" name="endtime2" size="02" value="<%=endmin%>" readonly/></td>
			
			
			<!--
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
	<font  size="2">
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            HH : </font> <select name="endtime1" onChange="showlocation(this, < %=vehiclecode%>, '< %=vehno%>');">
                   <option value="Select">Select</option>
                   <option value="00" < % if(00==hours) { %> Selected < % } %> >00</option>
                   <option value="01" < % if(01==hours) { %> Selected < % } %>>01</option>
                   <option value="02" < % if(02==hours) { %> Selected < % } %>>02</option>
                   <option value="03" < % if(03==hours) { %> Selected < % } %>>03</option>
                   <option value="04" < % if(04==hours) { %> Selected < % } %>>04</option>
                   <option value="05" < % if(05==hours) { %> Selected < % } %>>05</option>
                   <option value="06" < % if(06==hours) { %> Selected < % } %>>06</option>
                   <option value="07" < % if(07==hours) { %> Selected < % } %>>07</option>
                   <option value="08" < % if(8==hours) { %> Selected < % } %>>08</option>
                   <option value="09" < % if(9==hours) { %> Selected < % } %>>09</option>
                   <option value="10" < % if(10==hours) { %> Selected < % } %>>10</option>
                   <option value="11" < % if(11==hours) { %> Selected < % } %>>11</option> 
                   <option value="12" < % if(12==hours) { %> Selected < % } %>>12</option>
                   <option value="13" < % if(13==hours) { %> Selected < % } %>>13</option>
                   <option value="14" < % if(14==hours) { %> Selected < % } %>>14</option>
                   <option value="15" < % if(15==hours) { %> Selected < % } %>>15</option>
                   <option value="16" < % if(16==hours) { %> Selected < % } %>>16</option>
                   <option value="17" < % if(17==hours) { %> Selected < % } %>>17</option>
                   <option value="18" < % if(18==hours) { %> Selected < % } %>>18</option>
                   <option value="19" < % if(19==hours) { %> Selected < % } %>>19</option>
                   <option value="20" < % if(20==hours) { %> Selected < % } %>>20</option>
                   <option value="21" < % if(21==hours) { %> Selected < % } %>>21</option> 
                   <option value="22" < % if(22==hours) { %> Selected < % } %>>22</option>
                   <option value="23" < % if(23==hours) { %> Selected < % } %>>23</option>
            	 </select>  <font  size="2">
        		MM :</font> <select name="endtime2" onChange="showlocation(this, < %=vehiclecode%>, < %=vehno%>);">
        			  <option value="00" < % if(minutes > 00 & minutes < 05) { %> Selected < % } % >>00</option>
        	          <option value="10" < % if(minutes > 05 & minutes < 15) { %> Selected < % } % >>10</option>
        	          <option value="20" < % if(minutes > 15 & minutes < 25) { %> Selected < % } % >>20</option>
        	          <option value="30" < % if(minutes > 25 & minutes < 35) { %> Selected < % } % >>30</option>
        	          <option value="40" < % if(minutes > 35 & minutes < 45) { %> Selected < % } % >>40</option> 
        	          <option value="50" < % if(minutes > 45) { %> Selected < % } %>>50</option>
        	          
        	    </select> &nbsp;&nbsp;&nbsp;
                 
	</td>-->
    
     </tr>
     
     <tr>
			<td> <font size="2" > <div><b>Unload Date Time</b></div> </font> </td>
			<td><font size="2" > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date<input type="text" id="calender11" name="calender11" size="10" value="<%=nwfrmtdte%>" readonly/>
             <!-- <input type="button" name="trigger11" id="trigger11" value="Date"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender11",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "calender11"       // ID of the button
             }
                           );
             </script>
	
     
		 <font  size="2">
	            HH:</font> <select name="endtime11" onChange="showlocation(this, <%=vehiclecode%>, '<%=vehno%>');">
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
            	 </select>  <font  size="2">
        		MM:</font> <select name="endtime12" onChange="showlocation(this, <%=vehiclecode%>, <%=vehno%>);">
        			  <option value="00" <% if(minutes > 00 & minutes < 05) { %> Selected <% } %>>00</option>
        	          <option value="10" <% if(minutes > 05 & minutes < 15) { %> Selected <% } %>>10</option>
        	          <option value="20" <% if(minutes > 15 & minutes < 25) { %> Selected <% } %>>20</option>
        	          <option value="30" <% if(minutes > 25 & minutes < 35) { %> Selected <% } %>>30</option>
        	          <option value="40" <% if(minutes > 35 & minutes < 45) { %> Selected <% } %>>40</option> 
        	          <option value="50" <% if(minutes > 45) { %> Selected <% } %>>50</option>
        	          
        	    </select> &nbsp;&nbsp;&nbsp;
</td>
 </tr>
 <%  String sql34="select DelayReason from t_completedjourney where OwnerName='"+user+"'  group by  DelayReason  order By DelayReason Asc";
     // out.print(sql3); 
     ResultSet rs34=stmt1.executeQuery(sql34);
%>
 <tr>
  <td> <font size="2" ><div><b> Unload Delay Reason </b></div></font> </td>
   <td>  <select name="udr1" id="udr1" onchange="showme(this.value)">
     <option value="select">Select</option>
     <%  while(rs34.next())  
       		 { %>
           		  <option value="<%=rs34.getString("DelayReason") %>" > <%=rs34.getString("DelayReason") %> </option>
   	    
   	   
   	     <%  }
     %>
     <option value="other">Other</option>
       </select>
       <input type="text" name="udr" value="" id="udr" style="visibility:hidden" />
     </td>
     </tr>
     <tr>
      <td> <font size="2" > <div><b>Comments</b></div> </font> </td>
      <td colspan="2" align="center"> 	 <textarea name="unloadcmnt" rows="4" cols="35"></textarea> &nbsp;
	        </td>
         </tr>
	<td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" /> </td> 
     </tr>
</table>

<%
	sql10="select * from t_onlinedata where VehicleCode='"+vehiclecode+"' ";
	rs10=stmt1.executeQuery(sql10);
	//System.out.println("location>>>>>>>>"+sql10);
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
	<td colspan="2" align="left"> <font  size="2"> Location at selected time is: 
	<%=fleetview.showNewMap(latitu,longi,location) %>
	</font> 
	 </td>
     </tr>		
</table>
</div>
<table border="0" width="100%">
     <tr>
	<td colspan="2" align="center"><a href="javascript:window.close();">Close </a> </td>
     </tr>		
</table>


<%
	
		sql1="select * from t_startedjourney where TripId='"+tripid+"' ";
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			vehcode=rs1.getString("Vehid");
			vehreg=rs1.getString("VehRegNo");
			stplace=rs1.getString("StartPlace");
			endplace=rs1.getString("EndPlace");
			rptdatetme=rs1.getString("ReportDateTime");
			stdate=rs1.getString("StartDate");
			sttime=rs1.getString("StartTime");
			driverid=rs1.getString("DriverCode");
			drivername=rs1.getString("DriverName");
			stcode=rs1.getString("StartCode");
			endcode=rs1.getString("EndCode");
			gpname=rs1.getString("GPName");
			ownername=rs1.getString("OwnerName");
			tripcat = rs1.getString("TripCategory");
			weight=rs1.getString("Weight");
			vendor=rs1.getString("Vendor");
			
			
			
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

			gpname=rs1.getString("GPName");
		} 

		if((sttime==null) || (sttime.equals("")))
		{
			sttime="00:00:00";	
		}
%>
	<input type="hidden" name="stdate" value="<%=stdate%>" />
	<input type="hidden" name="sttime" value="<%=sttime%>" />
<%
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
		//sql11="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,TheFieldDataTime) >=concat('"+stdate+"', '"+sttime+"') and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		 rs11=stmt1.executeQuery(sql11);
		 if(rs11.next())
		 {
			stkm=rs11.getInt("Distance");	 
		 }
		 
		 sql13="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		 //sql13="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		 rs13=stmt1.executeQuery(sql13);
		 if(rs13.next())
		 {
			endkm=rs13.getInt("Distance");	 
		 }
		 
		 totkm=endkm-stkm;	
		 
		 sql14="SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and LonginDec>0 and TheFiledTextFileName in ('AC','DC','OS') order by concat(TheFieldDataDate,TheFieldDataTime) desc";
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
		 }
		 
		 sql15="select count(*) as cnt from t_veh"+vehcode+"_nd where concat(FromDate,' ',FromTime) between '"+stdate+" "+sttime+"' and '"+enddate+" "+endtime+"'";
		 rs15=stmt2.executeQuery(sql15);
		 if(rs15.next())
		 {
			 ndcount=rs15.getInt("cnt");
		 }
		
		 /*************************************code for stops**************************************** */


	 	 sql16="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ enddate+" "+endtime+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		//out.print("sql16="+sql16);
		 rs16= stmt1.executeQuery(sql16);
		 
		 while(rs16.next())
		 {
		 	sql17="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFieldDataDate='"+rs16.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rs16.getString("time1"))+" and abs(LatinDec - "+rs16.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1";
		 	//out.print(sql17);
		 	rs17= stmt3.executeQuery(sql17);
		 	if(rs17.next())
		 	{
		 		if(rs17.getDouble("time2")-rs16.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
		 		{
		 			stcount++;
		 		}
		 	}
		 }	
		 /* ************************************************************************* */
		 
		 /* **********************Calculating Rating********************* */
		 	double rating=0;
		 	if(totkm>0)
		 	{
		 		rating=(account/totkm)*100 + (dccount/totkm)*100 +((osdur/10)/totkm)*100;
		 	}
		 
		 /* ************************************************************************* */
			/*sql18="select * from t_completedjourney where VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+tripid+"' ";
		    //System.out.println("Selectsql::>>"+sql18);  
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
				String weight1=rs18.getString("Weight");
				String vendor1=rs18.getString("Vendor");
				Unloadingcomment=rs18.getString("Unloadingcomments");
				delayrsn =rs18.getString("DelayReason");
				
				sql2="update t_completedjourney SET JDCode='"+jdcode+"',VehId='"+vehcode+"', VehRegNo='"+vehregno+"',StartPlace='"+startplace+"',StartDate='"+startdate+"',StartTime='"+starttime+"',EndPlace='"+endplace+"',EndDate='"+enddate1+"',EndTime='"+endtime1+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"',OwnerName='"+ownername+"',GPName='"+gpname+"' where TripId='"+tripid1+"' and VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+jdcode+"',Weight='"+weight1+"',Vendor='"+vendor+"',Unloadingcomments='"+Unloadingcomment+"',DelayComments='"+delayrsn+"'";
				/*Query to insert query in db_gps.t_sqlquery table*/
			/*	String abcd=sql2.replace("'","#");
				abcd=abcd.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
				/*****************************/
			/*	stmt4.executeUpdate(sql2);
			}
			else
			{*/
				//sql2="insert into t_completedjourney (TripId,JDCode, VehId, VehRegNo, StartPlace, StartDate, StartTime, EndPlace, EndDate, EndTime, JourneyStatus, DriverId, DriverName, OwnerName, GPName) values ('"+tripid+"','"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stdate+"', '"+sttime+"', '"+endplace+"', '"+enddate+"', '"+endtime+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+user+"', '"+user+"') ";   
	         	  //out.print(sql2);
			   // stmt1.executeUpdate(sql2);
			String sqlloading="select concat('',TIMEDIFF('"+stdate+" "+sttime+"','"+rptdatetme+"')) as loadingDateDiff";
		//	System.out.println(sqlloading);
			ResultSet rstloading=stmt1.executeQuery(sqlloading);
			if(rstloading.next())
			{
				loadingdelay=rstloading.getString("loadingDateDiff");	
			}
			
			
			String sqlUnloading="select concat('',TIMEDIFF('"+unloaddate+" "+unloadtime+"','"+enddate+" "+endtime+"')) as UnloadingDateDiff";
			//stmt1.executeUpdate(sql3);
		//	System.out.println(sqlUnloading);
			ResultSet rstUnloading=stmt1.executeQuery(sqlUnloading);
			if(rstUnloading.next())
			{
				Unloadingdelay=rstUnloading.getString("UnloadingDateDiff");	
			}
			sql2="update t_completedjourney SET  UnloadDateTime='"+unloaddate+" "+unloadtime+"',UnloadingDelay='"+Unloadingdelay+"',Unloadingcomments='"+Unloadingcomment+"',DelayReason='"+delayrsn+"' where TripId='"+tripid+"'";
			//sql2="insert into t_completedjourney (TripId, VehId, VehRegNo, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, JourneyStatus, DriverId, DriverName, OwnerName, GPName, JDCode, RACount, RDCOunt, OSCOunt, NDCount, StopDuration, OSDuration, TripRating,Weight,Vendor,UnloadDateTime,LoadingDelay,UnloadingDelay,Unloadingcomments,DelayReason) values ('"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stcode+"', '"+stdate+" "+sttime+"', '"+sttime+"', '"+endplace+"', '"+endcode+"', '"+enddate+" "+endtime+"', '"+endtime+"', '"+stkm+"', '"+endkm+"', '"+totkm+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+ownername+"', '"+gpname+"', '"+tripid+"', '"+account+"', '"+dccount+"', '"+oscount+"', '"+ndcount+"', '"+stcount+"', '"+osdur+"', '"+rating+"','"+weight+"','"+vendor+"','"+unloaddate+" "+unloadtime+"','"+loadingdelay+"','"+Unloadingdelay+"','"+Unloadingcomment+"','"+delayrsn+"') ";   
			/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			/*****************************/
			stmt1.executeUpdate(sql2);
			//}  
			  sql3="update t_startedjourney set JStatus='Completed',EndedBy='"+rfname+" "+rlname+"' where TripID='"+tripid+"' ";
			  /*Query to insert query in db_gps.t_sqlquery table*/
				String abcdd=sql3.replace("'","#");
				abcdd=abcdd.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcdd+"')");
			/*****************************/
			  stmt1.executeUpdate(sql3); 

			 sql4="select * from t_warehousedata where WareHouseCode='"+stcode+"' and Owner='"+user+"' ";
			//out.print(sql4);
      			 rs4=stmt1.executeQuery(sql4);
        		 if(rs4.next())
        		 {
		
        		 }
			 else
     			{
        		      sql5="select * from t_veh"+vehcode+" where TheFieldDataDate='"+stdate+"' and TheFieldDataTime<='"+sttime+"' and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
				//out.print(sql5);
        		     rs5=stmt1.executeQuery(sql5);
        		      if(rs5.next())
        		      { 
        		          stlat=rs5.getDouble("LatinDec");
        		          stlong=rs5.getDouble("LonginDec");

				  sql6="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('-', '"+stplace+"', '"+user+"', '"+user+"', '"+stlat+"', '"+stlat+"', '"+stlat+"', '"+stlong+"', '"+stlong+"', '"+stlong+"', 'WH',  GeomFromText('POINT("+stlat+" "+stlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
				  /*Query to insert query in db_gps.t_sqlquery table*/
					String abcd1=sql6.replace("'","#");
					abcd1=abcd1.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
				/*****************************/
              
        		         stmt1.executeUpdate(sql6); 
        		      } 
        		}

             
			 sql7="select * from t_warehousedata where WareHouseCode='"+endcode+"' and Owner='"+user+"' ";
    	
        		 rs7=stmt1.executeQuery(sql7);
        		 if(rs7.next())
        		 {
				//out.print("in if");
        		 }
			 else
        		 {
        		      sql8="select * from t_veh"+vehcode+" where TheFieldDataDate='"+enddate+"' and TheFieldDataTime<='"+endtime+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
        		      rs8=stmt1.executeQuery(sql8);
        		      if(rs8.next())
        		      { 
        		          endlat=rs8.getDouble("LatinDec");
        		          endlong=rs8.getDouble("LonginDec"); 
		
				sql9="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('"+endplace+"', '"+endplace+"', '"+user+"', '"+user+"', '"+endlat+"', '"+endlat+"', '"+endlat+"', '"+endlong+"', '"+endlong+"', '"+endlong+"', 'WH', GeomFromText('POINT("+endlat+" "+endlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
				/*Query to insert query in db_gps.t_sqlquery table*/
				String abcd1=sql9.replace("'","#");
				abcd1=abcd1.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
			/*****************************/
        		    stmt1.executeUpdate(sql9); 
                  
        		      }
          
        		 }
%>   
		
		
			<table border="0" width="100%" class="stats">
			<tr>
				<td align="center"> <font > <B>Successfully Done </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font > <B> Note: </B> Please refresh 'My Trips' page to reflect the changes. </font> </td>
			</tr>	
			</table>

<%
		
		 //close of outer else		
	} //close of MAIN ELSE

}

	
catch(Exception e) 
{ 
	out.println("Exception----->" +e); 
}
finally
{
con1.close();
con2.close();
} 
  
%>

</form>
</body>
</html>
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
	

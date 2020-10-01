<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
 
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
div,h1,h2,h3,h4,p,ul,ol,li,form,fieldset,table,td,th {
	margin: 0;
	padding: 0
}

ul {
	list-style: none
}

html {
	font-size: 62.5%;
	height: 100%
}

body {
	font-family: Arial;
	font-size: 1.3em;
	margin: 0;
	min-width: 1000px;
	background: #fff;
	height: 100%
}

div#mainbody {
	padding: .5em 1.5em 0 1.5em
}

h1 {
	font-size: 1.5em
}

h2,.gwtNav2-header {
	font-size: 1.5em
}

h3,.gwtNav3-header {
	font-size: 1.2em
}

h4 {
	font-size: 1.1em
}

.main1 {
	font-size: 1.2em;
	font-weight: bold
}

.clear,.clrflt,.spacer {
	clear: both
}

.divider {
	clear: both;
	width: 100%;
	margin: 15px 0;
	border-bottom: 1px solid #eee
}

.divider2 {
	clear: both;
	width: 100%;
	margin: 15px 0;
	padding: 15px 0;
	border-bottom: 1px solid #ccc
}

.inlinetext {
	display: inline;
	padding-right: 6px
}

.newuser,.adm {
	color: green
}

.err,.sus,.req,.new,a.new:link,a.new:hover,a.new:visited {
	color: #c00
}

sup.new {
	margin-left: 3px
}

.u {
	color: #767676
}

.u a:link,.u a:active,.u a:visited {
	color: #59d
}

a:link,a:visited {
	color: #06c
}

a:hover {
	color: #c60
}

a {
	outline: none
}

a,.nowrap {
	white-space: nowrap
}

a img {
	border: 0
}



a.cancellink {
	text-decoration: none
}

#hidden1,#hidden2,#hidden3,#hidden4,.hidden {
	display: none
}





.rightbar {
	text-align: right
}

.nowrap {
	white-space: nowrap
}

.left-space {
	margin-left: 1em
}

.d {
	margin: 10px 10px 10px 0;
	padding: 10px;
	background-color: #fff4c2;
	border: solid 1px #fc3;
	width: 50%
}


.left_float {
	float: left;
	padding-right: 1em
}

.si {
	margin: 10px 10px 0 0;
	padding: 10px;
	background-color: #eee;
	border: solid 1px #aaa;
	width: 50%
}


div#header {
	min-height: 45px
}

div#logo {
	float: left;
	height: 70px /*tw header:logo height*/
}

div#logo img {
	border: none;
	padding-top: 10px /*tw header: tw logo */
	padding-left: 6px
}

div#logo1 {
	float: right;
	height: 70px /*tw header:logo height*/
}

div#logo1 img {
	border: none;
	padding-top: 10px /*tw header: tw logo */
	padding-right: 6px
}

div#header ul {
	float: right
}

div#header li {
	display: inline;
	padding-left: 6px
}

div#header p,div#header form {
	margin: 0 0 0 133px;
	padding-bottom: 2px
}

div#header form label {
	display: none
}

span#premium {
	color: #c60;
	font: bold .8em Verdana, Arial, Helvetica, sans-serif
}


div#navigation table {
	width: 100%
}

div#navigation ul {
	clear: both;
	/*background:
		url(https://ssl.gstatic.com/apps/cpanel/resources/img/img/navbar_bg.png)
		;*/
	float: left;
	width: 100%
}

div#navigation li {
	float: left;
	border-right: 1px solid #e3e9ff;/*tw header: light blue border of main menu */
	position: inherit; /*tw header: width of main menu */
	display: inline-table;
}

div#navigation li a,.topTab {
	display: block;
	padding: 5px 10px 5px 10px;
	color: #fff; /*tw header: font color of main menu */
	font-weight: bold; /*tw header: font-weight of main menu */
	position: relative;
	text-decoration: none;
	cursor: pointer
}

div#navigation li#services {
	border-right: 0
}

div#navigation li#services a img {
	border: none;
	padding-bottom: 2px;
	padding-left: 3px
}

div#navigationRight {
	float: right;
	visibility: visible
}

.selected,div#navigation li.selected a:hover,div#navigation li.selected:hover
	{
	
	font-weight: bold
}

div#navigation li#services ul#servicelist {
	display: none;
	position: absolute;
	background: #ecf0f6;
	border: 1px solid #fff;
	border-right: 1px solid #899dad;
	border-bottom: 1px solid #899dad;
	width: auto;
	z-index: 1000
}

div#navigation li#services li {
	float: none;
	border: none;
	border-bottom: 1px solid #ecf0f6
}

div#navigation li#services li a {
	display: block;
	background: none;
	padding: 3px 6px 3px 6px;
	color: #333;
	font-weight: normal;
	white-space: nowrap
}

div#navigation li#services li.selected a {
	background: #c9d1db;
	font-weight: bold
}




ul#services li ul {
	margin-left: 25px
}

ul#services li h3 {
	float: left;
	padding-left: 5px
}

ul#services span {
	color: #767676;
	padding-left: .2em
}

ul#services span.err,ul#services span.errormsg {
	color: #c00
}    padding: 4px;

ul#services li .beta,th span.beta {
	color: #c60;
	font: bold .8em Verdana, Arial, Helvetica, sans-serif;
	margin-left: 3px
}

ul#services li p {
	margin-left: 25px
}

.disabled-app,.license-expired-app,.license-expiring-app,.licensed-app,.unlicensed-app,ul#services li .update-data-access-requirements,ul#services li .license-expired-app,ul#services li .license-expiring-app,ul#services li .licensed-app,ul#services li .unlicensed-app
	{
	font-weight: bold;
	margin-right: 4px;
	padding-left: 0
}

.license-expired-app,.license-expiring-app,.unlicensed-app,ul#services li .license-expired-app,ul#services li .license-expiring-app,ul#services li .unlicensed-app,ul#services li .update-data-access-requirements
	{
	color: #dd3e43
}

ul#services li .disabled-app,ul#services li .licensed-app {
	color: #000
}

ul#services li .update-data-access-requirements a {
	font-weight: normal;
	padding-left: 5px
}



ul.features {
	list-style-type: none;
	border-top: 1px solid #c6dff9;
	border-bottom: 1px solid #c6dff9;
	margin: 15px 0;
	padding-bottom: 25px
}

ul.features li {
	padding: 25px 40px 0;
	min-height: 34px
}

ul.features .users {
	background:
		url(https://ssl.gstatic.com/apps/cpanel/resources/img/img/user_pic.gif)
		no-repeat left 25px
}

ul.features .org {
	background:
		url(https://ssl.gstatic.com/apps/cpanel/resources/img/img/org_pic.gif)
		no-repeat left 25px
}

ul.subtabs {
	margin: 16px 0 20px;
	padding: 0 0 2px 5px;
	border-bottom: 1px solid #c6dff9
}



div#disable_add_button {
	background-color: #fff;
	float: left;
	opacity: .3
}

ul#services span.added {
	color: #767676;
	font-weight: bold;
	background:
		url(https://ssl.gstatic.com/apps/cpanel/resources/img/img/nodisplay2.gif)
		no-repeat;
	padding-left: 15px;
	line-height: 2.5em
}


ul.inlinelist2 {
	display: inline
}

ul.palette {
	clear: left;
	width: 50%
}

ul.palette li {
	float: left;
	width: 50%;
	margin-bottom: 15px
}

ul.palette li.custom {
	width: 100%;    padding: 4px;
	margin-left: 25px
}

ul.palette li.custom input {
	float: none
}

ul.palette li input {
	float: left
}

ul.palette div {
	margin-left: 25px;
	padding: 5px 0 5px 0;
	width: 100px;
	text-align: center
}


ul.points {
	list-style: outside;
	margin-left: 2em;
	line-height: 1.5em
}

#footer {
	clear: both;
	margin: 2em 0 0 0;
	padding: 2px 0 0 0;
	text-align: center;
	color: #999;
	border-top: 3px solid #59d
}

#footer p {
	font-size: .9em;
	padding: 2px
}



div#navigationRight li {
	float: right;
	border-left: 1px solid #e3e9ff;
	background-color: #0B216;
	color: #fff;
	position: relative;
	font-size: 1em;
	font-weight: bold
}

div#navigationRight li a {
	color: #fff
}



a.header {
	text-decoration: none !important
}

a.header div.helpPanel-item div.gwt-Label {
	color: #559 !important;
	font-weight: bold;
	font-size: 13px
}



#dropmenudiv{
position:absolute;
border:1px solid black;
border-bottom-width: 0;
font:normal 12px Verdana, Arial, Helvetica, sans-serif;
line-height:18px;
z-index:100;

}

#dropmenudiv a{
width: 100%; /*tw header: dropdown*/
display: block;
text-indent: 3px;
border-bottom: 1px solid black;
padding: 1px 0;
text-decoration: none;
font-weight: bold;
background-color: #9db5e5;
color: #fff

}

#dropmenudiv a:hover{ /*hover background color*/
background-color: #465ea6;

}
table.sort {  /*tw header: sort table*/
	text-align: center;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: normal;
	font-size: 11px;
	color: blue;
	width: 100%;
	background-color: #9db5e5; /*tw header: sort table background*/
	border: 0px;
	border-collapse: inherit;
	border-spacing: 1px;
	border-color: grey
}

table.sort td {
/*	background-color: white;    ----------------HRERE-----------------------------------------*/   
	color: blue;
	padding: 4px;
	text-align: center;
	border: 0px #808080 solid;
	border-spacing: 1px;
}

table.sort th {
	background-color: #8596FA;
	color: white;
	padding: 4px;
	text-align: center;
	border: 0px #808080 solid;
	border-spacing: 14px;
}

table.sort td.hed {  /*tw header: sort table header*/
	background-color: #8596FA; 
	color: white;
	padding: 1px;
	text-align: center;
	border-bottom: 1px #808080 solid;
	font-size: 12px;
	font-weight: bold;
	border-spacing: 1px; 
}

table.sortable_scroll td.hed1 {
	background-color: #EEEEEE;
	color: #696969;
	padding: 1px;
	text-align: center;
	border-bottom: 2px #808080 solid;
	font-size: 12px;
	font-weight: bold;
}

table.sortable_scroll {  /*tw header: sort table*/
	text-align: center;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: normal;
	font-size: 11px;
	color: blue;
	width: 100%;
	background-color: #e3e9ff; /*tw header: sortable_sroll table background*/
	border: 1px;
	border-collapse: inherit;
	border-spacing: 0px;
	width:150px;
	display:block;
	border-width: 0px;
	border-style: solid;
	border-color: fff;
	padding:50px;
	margin-top:25px;
	width:100%;
	height:300px;
	overflow-x: auto;
	overflow-y: auto;
	
	
}

table.sortable_scroll td {
	background-color: white;
	color: blue;
	padding: 5px;
	text-align: center;
	border: 1px #808080 solid;
}

table.sortable_scroll td.hed {  /*tw header: sort table header*/
	background-color: white; 
	color: blue;
	padding: 4px;
	text-align: center;
	border-bottom: 1px #808080 solid;
	font-size: 12px;
	font-weight: bold;
}

table.sortable_scroll td.hed1 {
	background-color: #EEEEEE;
	color: #696969;
	padding: 4px;
	text-align: center;
	border-bottom: 2px #808080 solid;
	font-size: 12px;
	font-weight: bold;
}
table.sortable_entry {  /*tw header: sort table*/
	position: relative;
	text-align: center;
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-weight: normal;
	font-size: 11px;
	color: black;
	width: 60%;
	background-color: #e3e9ff; /*tw header: sortable_sroll table background*/
	border: 0px;
	border-collapse: inherit;
	border-spacing: 0px;
	margin-left: 200px
	
}
table.sortable_entry td {
	background-color: #e3e9ff;
	color: black;
	padding: 0px;
	padding-left:10px;
	text-align: left;
	border: 0px #808080 solid;
}
table.sortable_entry td.hed {  /*tw header: sort table header*/
	background-color: #e3e9ff; 
	color: blue;
	padding: 4px;
	text-align: center;
	border-bottom: 0px #808080 solid;
	font-size: 12px;
	font-weight: bold;
}

table.sortable_entry td.hed1 {
	background-color: #EEEEEE;
	color: #696969;
	padding: 4px;
	text-align: center;
	border-bottom: 0px #808080 solid;
	font-size: 12px;
	font-weight: bold;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vehicle Tracking System</title>
<script type="text/javascript">
function gotoPrint(divName)  
{    
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}


</script>


<script language="javascript">
 			function validate()
  			{
  				if(document.getElementById("data").value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById("data1").value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  				}
  				return datevalidate();
  		  }

		function dateformat(days)
		{
			if(days=='Jan')
				return(1);
			else
				if(days=='Feb')
					return(2);
				else
					if(days=='Mar')
						return(3);
					else
						if(days=='Apr')
							return(4);
						else
							if(days=='May')
								return(5);
							else
								if(days=='Jun')
									return(6);
								else
									if(days=='Jul')
										return(7);
									else
										if(days=='Aug')
											return(8);
										else
											if(days=='Sep')
												return(9);
											else
												if(days=='Oct')
													return(10);
												else
													if(days=='Nov')
														return(11);
													else
														if(days=='Dec')
															return(12);
		}
 		  		  
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;

			dd11=date1.substring(0,2);
			dd22=date2.substring(0,2);

			mm1=date1.substring(3,6);
			mm2=date2.substring(3,6);

			mm11=dateformat(mm1);
			mm22=dateformat(mm2);
			
			yy11=date1.substring(7,11);
			yy22=date2.substring(7,11);
			
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			
			if(yy11>year || yy22>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
	  			if(mm11>month || mm22>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(mm11==month && mm22==month)
			{
				if(dd11>day || dd22>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}

			
			if(yy11 > yy22)
			{
				alert("From date year should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
				 if(mm11>mm22)
			{
				alert("From date month should not be greater than to date month");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			if(mm11==month && mm22==month) 
			{
				if(yy11==yy22)
				{
				if(dd11 > dd22)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
				}
			}
			else
				if(yy11<yy22)
				{
					return true;
				}
			else
				if(dd11 > dd22)
			{
					if(mm11<mm22)
					{
						return true;
					}
					
				alert("From date should not be greater than to date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			
			return true;
		}
 </script>
 <script type="text/javascript">

 function gotoExcel(elemId,frmFldId)  
 { 
 	try
 	{
 	     var obj = document.getElementById(elemId);  
         var oFld = document.getElementById(frmFldId); 
           oFld.value = obj.innerHTML; 
          // alert(oFld.value);    
          document.TripTransit.action ="excel.jsp";
          document.forms["TripTransit"].submit();
          //alert("end"); 
   	}
 	catch(e)
 	{
 		alert(e);
 	}
 }
 
function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}

</script> 


<script language="javascript">
	function validate()
	{
		if(document.getElementById("date1").value=="")
		{
	  		alert("Please select the from date");
			return false;
		}
		if(document.getElementById("date2").value=="")
		{
  		alert("Please select the to date");
			return false;
		}
		return datevalidate();
}
function datevalidate()
{
	var date1=document.getElementById("date1").value;
var date2=document.getElementById("date2").value;
var dm1,dd1,dy1,dm2,dd2,dy2;
dy1=date1.substring(0,4);
dy2=date2.substring(0,4);
dm1=date1.substring(5,7);
dm2=date2.substring(5,7);
dd2=date2.substring(8,10);
dd1=date1.substring(8,10);
var date=new Date();
var month=date.getMonth()+1;
var day=date.getDate();
var year=date.getFullYear();
if(dy1>year || dy2>year)
{
	alert("selected date should not be greater than todays date");
	document.getElementById("date1").value="";
	document.getElementById("date2").value="";
	document.getElementById("data").focus;
	return false;
}
else if(year==dy1 && year==dy2)
{
		if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("date1").value="";
		document.getElementById("date2").focus;
		return false;
	}
}
if(dm1==month)
{
	if(dd1>day || dd2>day)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("date1").value="";
		document.getElementById("date2").value="";
		document.getElementById("date1").focus;
		return false;
	}
}
if(dy1>dy2)
{
	alert("From date year is should not be greater than to date year");
	document.getElementById("data").value="";
	document.getElementById("data1").value="";
	document.getElementById("data").focus;
	return false;
}
else if(year==dy1 && year==dy2) if(dm1>dm2)
{
	alert("From date month is should not be greater than to date month 5");
	document.getElementById("date1").value="";
	document.getElementById("date2").value="";
	document.getElementById("date1").focus;
	return false;
}
if(dm1==dm2) 
{
	if(dd1 > dd2)
	{
		alert("From date should not be greater than to date");
		document.getElementById("date1").value="";
		document.getElementById("date2").value="";
		document.getElementById("date1").focus;
		return false;
	}
}
return true;
}

</script>

</script> 
 
<%!String data1, data2, showdate, showdate1;
	int total = 0;
	String VehicleRegNo = "";
%>

</head>
<body>
<%
String exportFileName=session.getAttribute("user").toString()+"_TripTransit.xls";
//String exportFileName="FileName";
 %>
 <%! 
 String  color;
 %>
 
<%
	String fromDate = "", toDate = "";
	String fromdate1 = "", todate1 = "";

	String dd = request.getQueryString();
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));
		todate1 = data2;

		cal.add(Calendar.DATE, -1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromdate1 = data1;
		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	} else {

		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));
		fromdate1 = request.getParameter("data");

		todate1 = request.getParameter("data1");

	} //end of else
	String user = session.getAttribute("usertypevalue").toString();
%>

<%!
				String date1,date2;
			int   b=0 ; String sql,sql2,sql3,sql4,sql5,sql11,sql12,sql13,sql15,  sqltoken, VehCode = null, WareHouse, TheDateTime = null, TheDateTime1 = null, TheDateTime2 = null,TheDateTime3 = null,  TheDateTime4 = null,TheDateTime5 = null, TheDateTime6 = null,TheDateTime7, WareHouseLat,WareHouseLon, Place;
			String  StoreNm, docInTime, dockInPlace, WareHouseCode2,
				   docRepEst, docRepAct,  docRepPlace,
				   destInAct, destOutEst, destOutPlace, rtrnDocAct,rtrnDocPlace,
				   EntryExitStatus, OriginPlace,WareHouse1 = null, WareHouse2 = null, WareHouse3 = null, WareHouse4, WareHouse5 = null, WareHouse6 = null, WareHouse7 ;
			
			String StringToken[] = new String[100]; // Check this array size
			String destinationExitDate[] = new String[100]; // Check this array size
			Time loading_time,document_time,onward_time,unlaoding_time,return_time;
			int lt_hrs = 0,lt_min = 0,lt_sec=0 , dt_hrs = 0, dt_min = 0, dt_sec = 0, ot_hrs = 0, ot_min = 0 , ot_sec = 0, ut_hrs = 0, ut_min = 0, ut_sec = 0, rt_hrs = 0, rt_min = 0, rt_sec = 0;	
			
			String StoreName, VehRegNo, DockInPlaceName,  DocmntPlaceName,   RtrnDockPlace, Processed;
			
			String DockInAct, DocmntRepEst, DocmntRepAct, StrInEst, StrInAct,StrInPlace, StrOutEst, StrOutAct,StrOutPlace, RtrnDockAct, RtrnDockEst;
			Time DelayDocmntRep, DelayStrIn, DelayStrOut, DelayRtrnDock;
			 	  
			%>
			<%
			String dateformat="dd-MMM-yyy";
			dateformat=session.getAttribute("dateformat").toString();
			
			date1=request.getParameter("date1");
			date2=request.getParameter("date2");
			
			date1=date2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			session.setAttribute("date1",date1);
			session.setAttribute("date2",date2);
			
				%>
<%!
			Connection conn,conn1;
			Statement st,st1,st2,st3,st4;
			String sql1,vehicle;
%>


<%@ include file="headernew.jsp" %>			
 
 <form 	onsubmit="return validate();">
<table border="0" width="100%" class="stats">
			<tr>
				<td colspan="25" align="center">
				<!-- <div align="left"><font size="3">Report No:5.0</font></div>-->
				<font size="3"><b>Trip Transit Report</b></font></td>
			</tr>
</table>			

<table border="1" width="100" align="center" class="stats">

<tr>
<td></td><td></td><td></td><td></td><td><td></td><td></td><td></td><td></td><td><td></td><td></td><td></td><td></td><td>
</td>

	<td><b>From </b> 
	<input type="text" id="data" name="data" value="<%=fromdate1%>" size="15" readonly />
		<script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script>
		</td>

		<td><b>To </b>&nbsp;&nbsp; <input type="text" id="data1"
			name="data1" value="<%=todate1%>" size="15" readonly />
			<script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		
		<td><input type="submit" name="submit" id="submit" value="submit"></td>
		<td>
	</td>

<td></td><td></td><td></td><td></td><td><td></td><td></td><td></td><td></td><td><td></td><td></td><td></td><td></td><td>
	</tr>
</table>
</form>

<form id="TripTransit"  name="TripTransit" action="#" method="post"> 
<div id="table1"  align="center" style="width: 1010px;">
		<table border="0" width="100%" class="stats">
			<tr>
				<th colspan="3" align="center" >
				<font size="2"><B>Trip Transit Report For <%=user%>
				from <%
					java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy")
							.parse(data1);
					Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
					showdate = formatter2.format(ShowDate);
					out.print(showdate);
				%> to <%
					java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy")
							.parse(data2);
					Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
					showdate1 = formatter1.format(ShowDate1);
					out.print(showdate1);
				%>.
				</B></font>
				<div align="right">
				 <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
	       <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
		
		
	<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
    <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none" ></img></a>&nbsp;
    <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new Date()) %></div>
  
  
				</th>
			</tr>
		</table>	
		<table width="100%" border="0" align="center" class="sort">
			
		<tr bgcolor="#F0E68C">
			<td class="sorttable_nosort" width="10%"> <b><span> Color Code Delay </span></b></td>
			<td bgcolor="#CCFFCC" class="sorttable_nosort"><b>Delay < 15 min</b></td>
			<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b>Delay > 15 min and < 30 min   </b></td>
			<td bgcolor="#FF8080" class="sorttable_nosort"><b>Delay > 30 min</b></td>
		</table>	
		<table width="100%" border="0" align="center" class="sort">
		</tr>
			
			<tr>
			<td class="hed"> Sr. No.</td>
			<td class="hed"> Store Name</td>
			<td class="hed"> Vehicle Reg No</td>
			<td class="hed"> Dock In Act</td>
			<td class="hed"> Start Place</td>
			<td class="hed"> Document Recp Est</td>
			<td class="hed"> Document Recp Act</td>
			<td class="hed"> Delay in Document Recp </td>
			<td class="hed"> Place  </td>
			<td class="hed"> Store In Est </td>
			<td class="hed"> Store In Act </td>
			<td class="hed"> Delay In Store Entry</td>
			<td class="hed"> Place </td>
			<td class="hed"> Store Out Est </td>
			<td class="hed"> Store Out Act </td>
			<td class="hed"> Delay In Store Exit</td>
			<td class="hed"> Place </td>
			<td class="hed"> Return to DC Est</td>
			<td class="hed"> Return to DC Act</td>
			<td class="hed"> Delay In Return to DC</td>
			<td class="hed">End Place</td>
			</tr>	
			<%
			 dateformat="dd-MMM-yyy";
			dateformat=session.getAttribute("dateformat").toString();
			if(null==request.getQueryString())
			{
					vehicle="All";
					date2=date1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			
			}
			else
			{
					vehicle=request.getParameter("vehicle");
					date1=request.getParameter("date1");
					date2=request.getParameter("date2");
			}
			try
			{
				Class.forName("org.gjt.mm.mysql.Driver"); 
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				st=conn.createStatement();
				st1=conn.createStatement();
				st2=conn.createStatement();
				st3=conn.createStatement();
			}catch(Exception e)
			{
				out.println(e.getMessage());
			}
									
			%>

			<%
			
			int i=1;
			String  DelayDocmntRepMin="", DelayStrInMin="", DelayStrOutMin="", DelayRtrnDockMin="";
		 try{

			 data1 = fromDate;
			 data2 = toDate;	

				 
				sql="select `SrNo` , `UnitId` ,  `StoreName` , `VehCode` , `VehRegNo` , `DockInAct` , `DockInPlaceName` , `DocmntRepEst` , `DocmntRepAct` , timediff(`DocmntRepAct`, `DocmntRepEst`)  AS DelayDocmntRepMin, `DocmntPlaceName` , `StrInEst` , `StrInAct` , timediff(`StrInAct`, `StrInEst`) as  DelayStrInMin,  `StrInPlace` , `StrOutEst` , `StrOutAct` , timediff(`StrOutAct`,`StrOutEst`) AS DelayStrOutMin, `StrOutPlace` , `RtrnDockAct` , `RtrnDockEst` , timediff(`RtrnDockEst`,`RtrnDockAct`) AS DelayRtrnDockMin , `RtrnDockPlace` , `UpdatedDateTime` , `Processed`   from db_gps.t_bulkTripTransit where Processed='Yes' and  StrOutEst>='"+data1+"' and StrOutAct<='"+data2+"' order by StrOutEst ASC ";
				System.out.println("sql ---"+sql);
				ResultSet rs=st.executeQuery(sql);
				
				while(rs.next())
				{	
					StoreName=rs.getString("StoreName");
					VehRegNo=rs.getString("VehRegNo");
					DockInAct=rs.getString("DockInAct");
					DockInPlaceName=rs.getString("DockInPlaceName");
					DocmntRepEst=rs.getString("DocmntRepEst");
					DocmntRepAct=rs.getString("DocmntRepAct");
					
					//DelayDocmntRep=rs.getTime("DelayDocmntRep");
					
					DocmntPlaceName=rs.getString("DocmntPlaceName");
					StrInEst=rs.getString("StrInEst");
					StrInAct=rs.getString("StrInAct");
					StrInPlace=rs.getString("StrInPlace");
					
					//DelayStrIn=rs.getTime("DelayStrIn");
					
					StrOutEst=rs.getString("StrOutEst");
					StrOutAct=rs.getString("StrOutAct");
					
					//DelayStrOut=rs.getTime("DelayStrOut");
				 	
					StrOutPlace=rs.getString("StrOutPlace");
				 	RtrnDockAct=rs.getString("RtrnDockAct");
				 	RtrnDockEst=rs.getString("RtrnDockEst");
				 	
				 	//DelayRtrnDock=rs.getTime("DelayRtrnDock");
				 	
				 	RtrnDockPlace=rs.getString("RtrnDockPlace");
				 	Processed=rs.getString("Processed");
				 	
				 	
				 	
				 	try
				 	{
			 			DelayDocmntRepMin=rs.getString("DelayDocmntRepMin");
				 	
				 	}catch(Exception e22)
				 	{
				 		
				 	 	DelayDocmntRepMin="00:00:00";
				 	}
				 	
				 	try
				 	{
				 		DelayStrInMin=rs.getString("DelayStrInMin");
				 	}	
				 	catch(Exception e33)
				 	{
				 		DelayStrInMin="00:00:00";
				 	}
				 	
				 	try
				 	{
				 		DelayStrOutMin=rs.getString("DelayStrOutMin");
					 	DelayRtrnDockMin=rs.getString("DelayRtrnDockMin");
				 	}
				 	catch(Exception e33)
				 	{
				 		DelayStrOutMin="00:00:00";
				 	}
				 	
				 	try
				 	{
				 		
					 	DelayRtrnDockMin=rs.getString("DelayRtrnDockMin");
				 	}
				 	catch(Exception e33)
				 	{
				 		DelayRtrnDockMin="00:00:00";
				 	}
				 	
				 	
				 	/*
				 	
				 	if(DelayDocmntRepMin.getHours()<0 && DelayDocmntRepMin.getMinutes()<0 && DelayDocmntRepMin.getSeconds()<0)
				 	{
				 		DelayDocmntRepMin.setHours(00);
				 		DelayDocmntRepMin.setMinutes(00);
				 		DelayDocmntRepMin.setSeconds(00);
				 	}
			
				 	if(DelayStrInMin.getHours()<0 && DelayStrInMin.getMinutes()<0 && DelayStrInMin.getSeconds()<0)
				 	{
				 		DelayStrInMin.setHours(00);
				 		DelayStrInMin.setMinutes(00);
				 		DelayStrInMin.setSeconds(00);
				 	}
				 	
				 	if(DelayStrOutMin.getHours()<0 && DelayStrOutMin.getMinutes()<0 && DelayStrOutMin.getSeconds()<0)
				 	{
				 		DelayStrOutMin.setHours(00);
				 		DelayStrOutMin.setMinutes(00);
				 		DelayStrOutMin.setSeconds(00);
				 	}
				 	if(DelayRtrnDockMin.getHours()<0 && DelayRtrnDockMin.getMinutes()<0 && DelayRtrnDockMin.getSeconds()<0)
				 	{
				 		DelayRtrnDockMin.setHours(00);
				 		DelayRtrnDockMin.setMinutes(00);
				 		DelayRtrnDockMin.setSeconds(00);
				 	}
				 	
				 	*/
				 	
				 	//out.println(i++ +"  "  + diffInMin(DocmntRepAct,DocmntRepEst));
				 	
try{				 	
				 	
				 			
//out.println(" DelayDocmntRepMin "+DelayDocmntRepMin +" DelayStrOutMin "+DelayStrOutMin+" DelayRtrnDockMin "+DelayRtrnDockMin+"<br/>");
	
	if(diffInMin(DocmntRepAct,DocmntRepEst)  < 15 || diffInMin(StrInAct,StrInEst) <15 || diffInMin(StrOutAct,StrOutEst)<15 || diffInMin(RtrnDockEst,RtrnDockAct)<15) 	
	{	 
		color = "#CCFFCC"; // Green
       } 
	 if(diffInMin(DocmntRepAct,DocmntRepEst) > 16 && diffInMin(DocmntRepAct,DocmntRepEst) < 30  ||  diffInMin(StrInAct,StrInEst) >16 && diffInMin(StrInAct,StrInEst) < 30 || diffInMin(StrOutAct,StrOutEst)>16 && diffInMin(StrOutAct,StrOutEst) < 30 || diffInMin(RtrnDockEst,RtrnDockAct)>16 && diffInMin(RtrnDockEst,RtrnDockAct) < 30)
       {
		
		color = "#FFFFCC"; //Orabge  
       }
	if(diffInMin(DocmntRepAct,DocmntRepEst) > 30  || diffInMin(StrInAct,StrInEst) > 30 || diffInMin(StrOutAct,StrOutEst) > 30 || diffInMin(RtrnDockEst,RtrnDockAct) > 30)
       {

		 color = "#FF8080"; // Red
               
       } 
	//class="sortbottom"
				
}catch(Exception e)
{
		out.println("Exception in diffInMin"+e);
}
			
		 %>

			<tr   style="background: <%=color%>;" >
			<td style="text-align: right;" align="right" ><%=i++%></td>
			<td style="text-align: left;" align="left" ><%=StoreName%></td>
			<td style="text-align: right;" align="right" ><%=VehRegNo%></td>
			<td style="text-align: right;" align="right" >
			<% 
			try{
				DockInAct=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DockInAct));
			}catch(Exception e){
				DockInAct=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DockInAct));
			}
			%>
			<%=DockInAct%> </td>
			<td style="text-align: left;" align="left" ><%=DockInPlaceName%></td>
			<td style="text-align: right;" align="right" >
			<% 
			String DocmntRepEst20="";
			try{
				DocmntRepEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DocmntRepEst));
			}catch(Exception e){
				DocmntRepEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DocmntRepEst));
			}
			%>
			<%=DocmntRepEst20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% 
			String DocmntRepAct20="";
			try{
				DocmntRepAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DocmntRepAct));
			}catch(Exception e){
				DocmntRepAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DocmntRepAct));
			}
			%>
			
			<%=DocmntRepAct20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% if(dateDiff(DocmntRepEst, DocmntRepAct).contains("-")) 
			{
				out.println("00:00");
			}
			else
			{
				out.println(dateDiff(DocmntRepEst, DocmntRepAct));
					
			}
			%>
			</td>
			<td style="text-align: left;" align="left" ><%=DocmntPlaceName%></td>
			<td style="text-align: right;" align="right" >
			<% 
			String StrInEst20="";
			try{
				StrInEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrInEst));
			}catch(Exception e){
				StrInEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrInEst));
			}
			%>
			<%=StrInEst20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% 
			String StrInAct20="";
			try{
				StrInAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrInAct));
			}catch(Exception e){
				StrInAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrInAct));
			}
			%>
			<%=StrInAct20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% if(dateDiff(StrInEst, StrInAct).contains("-")) 
			{
				out.println("00:00");
			}
			else
			{
				out.println(dateDiff(StrInEst, StrInAct));
					
			}
			%>
			</td>
			<td style="text-align: left;" align="left" ><%=StrInPlace%></td>
			<td style="text-align: right;" align="right" >
			<% 
			String StrOutEst20="";
			try{
				StrOutEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrOutEst));
			}catch(Exception e){
				StrOutEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrOutEst));
			}
			%>
			<%=StrOutEst20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% 
			String StrOutAct20="";
			try{
				StrOutAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrOutAct));
			}catch(Exception e){
				StrOutAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(StrOutAct));
			}
			%>
			<%=StrOutAct20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% if(dateDiff(StrOutEst, StrOutAct).contains("-")) 
			{
				out.println("00:00");
			}
			else
			{
				out.println(dateDiff(StrOutEst, StrOutAct));
					
			}
			%>
			</td>
			<td style="text-align: left;" align="left" ><%=StrOutPlace%></td>
			<td style="text-align: right;" align="right" >
			<% 
			String RtrnDockEst20="";
			try{
				RtrnDockEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(RtrnDockEst));
			}catch(Exception e){
				RtrnDockEst20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(RtrnDockEst));
			}
			%>
			<%=RtrnDockEst20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% 
			String RtrnDockAct20="";
			try{
				RtrnDockAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(RtrnDockAct));
			}catch(Exception e){
				RtrnDockAct20=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(RtrnDockAct));
			}
			%>
			<%=RtrnDockAct20%>
			</td>
			<td style="text-align: right;" align="right" >
			<% if(dateDiff(RtrnDockEst, RtrnDockAct).contains("-")) 
			{
				out.println("00:00");
			}
			else
			{
				out.println(dateDiff(RtrnDockEst, RtrnDockAct));
					
			}
			%>
			</td>
			<td style="text-align: left;" align="left" ><%=RtrnDockPlace%></td>
			</tr>	
							
			<%
				}
			}catch(Exception e)
			{
				out.println("Exception "+e);
			}
			%>
			
	</table>		

	</div>

    
	</form>	
</body>
</html>
<%! 
	 static String dateDiff(String dateStart,String dateStop) 
	{
			//HH converts hour in 24 hours format (0-23), day calculation
		 		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 				String rtDate=null;
                Date d1 = null;
                Date d2 = null;
 
                try {
                        d1 = format.parse(dateStart);
                        d2 = format.parse(dateStop);
 
                        //in milliseconds
                        long diff = d2.getTime() - d1.getTime();
 
                        long diffSeconds = diff / 1000 % 60;
                        long diffMinutes = diff / (60 * 1000) % 60;
                        long diffHours = diff / (60 * 60 * 1000) % 24;
                        long diffDays = diff / (24 * 60 * 60 * 1000);
 
			
			 //rtDate=diffDays+" Days "+":"+diffHours+" HR " + ":"+diffMinutes+" Min "+":"+diffSeconds+ "Sec";
			 //rtDate.format("yyyy-MM-DD HH:mm:ss", rtDate);
			
			 long diffSeconds1 = diff / 1000 % 60;
             long diffMinutes1 = diff / (60 * 1000) % 60;
             long diffHours1 = diff / (60 * 60 * 1000) % 24;
             int d20=(int)diffHours1;
             int d21=(int)diffMinutes1;
			 rtDate=padStr(d20,"0",2) +":"+padStr(d21,"0",2);			 
		
        } catch (Exception e) 
		{
			e.printStackTrace();
		}
		return rtDate;
		
	}
public static  String padStr(int val, String pad, int len)
	{
	  String str = Integer.toString(val);
	  while (str.length() < len)
	    str = pad + str;
	  return str;
	}
%>
<%!	
	static long diffInMin(String dateStart,String dateStop) 
	{
		//HH converts hour in 24 hours format (0-23), day calculation
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-DD HH:mm:ss");
		String rtDate = null;
		Date d1 = null;
		Date d2 = null;
		long diffInMinute=0;
		try {	
		d1 = format.parse(dateStart);
		d2 = format.parse(dateStop);
		
				int diff = (int) Math.abs(d2.getTime() - d1.getTime());
				diffInMinute = diff / (60 * 1000);
				
						
				//System.out.println(" diffInMinute "+diffInMinute);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return diffInMinute;
		
	}


%>

</jsp:useBean>
<%@ include file="footernew.jsp" %>		 
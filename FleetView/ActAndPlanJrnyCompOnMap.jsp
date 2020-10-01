<%@ include file="headernew.jsp" %>
 <%@ page import="kml.KML1" %>
 <%classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);%>
<%@page import="com.fleetview.beans.classes"%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>View Journey on Map</title>
    <link rel="stylesheet" href="../theme/default/style.css" type="text/css">
    <link rel="stylesheet" href="style.css" type="text/css">
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
    <style type="text/css">
        #map {
            width: 100%;
            height: 800px;
            border: 1px solid black;
            float:left;
        }
        #map2 {
            width: 400px;
            height: 400px;
            border: 1px solid black;
            float:left;
        }
    </style>
  <script src="OpenLayers-2.10/OpenLayers.js"></script>
    <script type="text/javascript" src="OpenLayers-2.10/binaryajax.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/binarywrapper.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/shapefile.js"></script>
<script type="text/javascript" src="OpenLayers-2.10/dbf.js"></script>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
    </head>
    <body>
    <script language="javaScript">
function ajaxFunction(xx)
{
try
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
                	//alert(reslt);
                	var rsnew = reslt.split("$");
                	document.getElementById("side_bar1").innerHTML=rsnew[0];
                	//document.getElementById("side_bar").style.display="none";
		}
	}
if(xx==1)
{
ajaxRequest.open("GET", "ViolationReport.jsp?para=OS", true);
}
if(xx==2)
{
ajaxRequest.open("GET","ViolationReport.jsp?para=RA", true);
}
if(xx==3)
{
ajaxRequest.open("GET", "ViolationReport.jsp?para=RDA", true);
}
if(xx==4)
{
ajaxRequest.open("GET", "ViolationRep_Stop.jsp", true);
}
if(xx==5)
{
ajaxRequest.open("GET","ViolationReport.jsp?para=Disconn",true);
}
if(xx==6)
{
ajaxRequest.open("GET","Plannedreport.jsp?para=Rest",true);
}
if(xx==7)
{
ajaxRequest.open("GET","Plannedreport.jsp?para=NH",true);
}
/*
if(xx==5)
{
ajaxRequest.open("GET", "hrst.jsp", true);
}*/
ajaxRequest.send(null); 
}
catch(e)
{
	alert(e);
}
}
</script>
 <%! Connection conn,conn1,con;
Statement st,st1,st2,st3,st4,st5,stAC,stDisconn,st00;
String htmlvis1,htmlvis2,sql,sql1,sql2,sql3,sql4,sql5,sqlware,data1,data2,vehcode,location,Stamp,label1,html1,html2,html11,html22,d1,d2,t1,t2,time1,time2,fromtime,totime,ftime1,ftime2,ftime3,ttime1,ttime2,ttime3;
String thedate="",thedate1="",startplace1="",endplace1="",thetime="",thetime1="",vehregno="",ownername="",lastlocation="",strtcode="",endcode="",startplace="",endplace="",enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
String mydate1="",mydate2="",porigin = "",pdest = "";
String smap="",smap1="";
String gpname="",transporter="",gpname1="",ownername1="",plannedstatus = "",ConsideredLatLon="",Ship_To="", end_code="";
double lat, lat1, lon, lon1,latw,longw,latw1,longw1,lat11,lon11;
float slatitude=0,slongitude=0,elatitude=0,elongitude=0;
int show,dist,pstop = 0,pnighthalt = 0;
boolean flag1=false,flag2=false;
String tripid = "",briefid = "",driverid = "",routeid = "";
String dates1[] = null,dates2[] = null,dates[] = null;
String day[] = null;
%>
 <%
    try
    {
         con = fleetview.ReturnConnection();
        // System.out.println("con   "+con);
    	st=con.createStatement();
    	st1 = con.createStatement();
    	st4 = con.createStatement();
    	st2 = con.createStatement();
    	st00 = con.createStatement();
    //	System.out.println("st   "+st);
    }
    catch(Exception e)
    {
    	//System.out.println("====>error in connection");
    	e.printStackTrace();
    }
    
    html1 = "";location = "";
    lat = 0.0;lon = 0.0;
    data1 = "";data2 = "";
    tripid = request.getParameter("tripid");
    String unitid = tripid;
    briefid = request.getParameter("brifid");
    driverid=  request.getParameter("driverid");
  //  System.out.println("driverid   "+driverid);
    routeid = request.getParameter("rid");
    String fromPage=request.getParameter("pg");
    vehcode=request.getParameter("vehcode");
 //   System.out.println("tripid   "+tripid);
  //  System.out.println("briefid   "+briefid);
  //  System.out.println("rid   "+routeid);
  //  System.out.println("fromPage   "+fromPage);
  //  System.out.println("vehcode   "+vehcode);
    
    //tripid = "20100395";
    //briefid = "127667";
   // driverid = "91039626";
   // routeid = "27";
	String sql = "",startdate = "",enddate = "",daylist = "",dayquery = "";
	 plannedstatus = request.getParameter("pstatus");
	data1=request.getParameter("data");
	data2=request.getParameter("data1");
	
//	System.out.println("data1--"+data1+" data2--"+data2);
	try{
	data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));
	data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
//	System.out.println("data1-->"+data1+" data2-->"+data2);
	}catch(Exception e)
	{
		//System.out.println("inside catch");
		e.printStackTrace();
		/*data1=data1;
		data2=data2;*/
	}


	mydate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));

	mydate2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));

	ftime1=request.getParameter("ftime1");
	ftime1=String.format("%02d",Integer.parseInt(ftime1));
	ftime2=request.getParameter("ftime2");
	ftime2=String.format("%02d",Integer.parseInt(ftime2));
	ftime3=request.getParameter("ftime3");
	ftime3=String.format("%02d",Integer.parseInt(ftime3));
	
	ttime1=request.getParameter("ttime1");
	ttime1=String.format("%02d",Integer.parseInt(ttime1));
	ttime2=request.getParameter("ttime2");
	ttime2=String.format("%02d",Integer.parseInt(ttime2));
	ttime3=request.getParameter("ttime3");
	ttime3=String.format("%02d",Integer.parseInt(ttime3));

	time1=ftime1+":"+ftime2+":"+ftime3;
	time2=ttime1+":"+ttime2+":"+ttime3;

	// set the values in  session-----------------

	//System.out.println("Setting session variables");
	session.setAttribute("hdate1",data1);
	session.setAttribute("hdate2",data2);
	session.setAttribute("fff",time1);
	session.setAttribute("ttt",time2);
	session.setAttribute("hvid",vehcode);
	session.setAttribute("tripid",tripid);
	session.setAttribute("briefid",briefid);
	session.setAttribute("driverid",driverid);
	session.setAttribute("routeid",routeid);

	//---------------------------------------------

	//time1=request.getParameter("fromtime");
	//System.out.println("time1->" +time1);
	//time2=request.getParameter("totime");
	//System.out.println("time2->" +time2);
	try
	{
	     con = fleetview.ReturnConnection();
		st=con.createStatement();
		
	}
	catch(Exception e)
	{
		//System.out.println("====>error in connection");
		e.printStackTrace();
	}
	String vehreg="";
	String sqlvehreg="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
	ResultSet rstveh=st.executeQuery(sqlvehreg);
	if(rstveh.next())
	{
		vehreg=rstveh.getString("VehicleRegNumber");
		//System.out.println("VehicleRegNumber====>");
	}
	String n="null";

	if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)) && !("drivrating".equalsIgnoreCase(fromPage)))
	{
		String sqltrp="select * from t_startedjourney where TripID='"+tripid+"'";
		ResultSet rstrp=st.executeQuery(sqltrp);
		System.out.println("\n\n started journey query-->>"+sqltrp);
		if(rstrp.next())
		{
			startplace1=rstrp.getString("StartPlace");
		//	System.out.println("\n\n start place-->>"+startplace1);
			endplace1=rstrp.getString("EndPlace");
		//	System.out.println("\n\n end place-->>"+endplace1);
			strtcode=rstrp.getString("StartCode");
			endcode=rstrp.getString("EndCode");
			gpname=rstrp.getString("GPName");
			//System.out.println("\n\n start code-->>"+strtcode);
		//	System.out.println("\n\n end code-->>"+endcode);
			transporter=rstrp.getString("OwnerName");
			System.out.println("\n\n transporter-->>"+transporter);
			ConsideredLatLon =rstrp.getString("ConsideredLatLon");
			 System.out.println("value of ConsideredLatLon---->>"+ConsideredLatLon);
			 Ship_To=rstrp.getString("Ship_To");//EndCode
			 System.out.println("value of Ship_To--> "+Ship_To);
			 end_code=rstrp.getString("EndCode");
			 System.out.println("value of end_code--> "+end_code);
		}
		
		/*sqltrp = "select Placename from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid asc ,row asc limit 1";
		rstrp = st.executeQuery(sqltrp);
		if(rstrp.next())
		{
			porigin = rstrp.getString("Placename");
		}
		sqltrp = "select Placename from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid desc ,row desc limit 1";
		rstrp = st.executeQuery(sqltrp);
		if(rstrp.next())
		{
			pdest = rstrp.getString("Placename");
		}*/
		
		 sqltrp="select * from t_warehousedata where WareHouseCode='"+strtcode+"' AND (Owner='"+transporter+"' or Owner='"+gpname+"')";
		 rstrp=st.executeQuery(sqltrp);
	       System.out.println("\n\nwarehouse strtwali query-->>"+sqltrp);
		 if(rstrp.next())
		 {
			 slatitude=rstrp.getFloat("Latitude");
			 slongitude=rstrp.getFloat("Longitude");
			 if(slatitude==0 && slongitude==0)
			 {
			       flag1=false;
			 }
			 else
				 {
				    flag1=true;
				 }
		//	 System.out.println("\n\n from warehouse lat strt-->>"+slatitude);
		//	 System.out.println("\n\n from warehouse long strt-->>"+slongitude);
		 }
		 else
		 {
			 String sqlc="select * from t_castrolroutes where StartCode='"+strtcode+"' AND Owner='"+gpname+"'";
				ResultSet rec=st.executeQuery(sqlc);
				 System.out.println("\n\ncastrolroutes strtwali query-->>"+sqlc);
				if(rec.next())
				{
					slatitude=rec.getFloat("Startlat");
					 slongitude=rec.getFloat("Startlong");
					 if(slatitude==0 && slongitude==0)
					 {
					       flag1=false;
					 }
					 else
						 {
						    flag1=true;
						 }
				//	 System.out.println("\n\n from castrolroutes lat strt-->>"+slatitude);
				//	 System.out.println("\n\n from castrolroutes long strt-->>"+slongitude);
				}
		 }
		 if(ConsideredLatLon.equalsIgnoreCase("shiptocode"))
		 {
			
			 endcode=Ship_To;
			 System.out.println("value of endcode in if block"+ endcode);
			 System.out.println("value of Ship_To in if block"+ Ship_To);
		 }
		 else
		 {
			 endcode=end_code;
			 System.out.println("value of endcode in else block"+ endcode);
			 System.out.println("value of Ship_To in else block"+ end_code);
		 }	 
		 sqltrp="select * from t_warehousedata where WareHouseCode='"+endcode+"' AND (Owner='"+transporter+"' or Owner='"+gpname+"')";
		  System.out.println("\n\nwarehouse for endcode***********-->>"+sqltrp);
		 rstrp=st.executeQuery(sqltrp);
		 if(rstrp.next())
		 {
			 elatitude=rstrp.getFloat("Latitude");
			 elongitude=rstrp.getFloat("Longitude");
			 if(elatitude==0 && elongitude==0)
			 {
			 flag2=false;
			 }
			 else
				 {flag2=true;}
			 //flag2=true;
			 // System.out.println("\n\n from warehouse lat end-->>"+elatitude);
			 // System.out.println("\n\n from warehouse long end-->>"+elongitude);
		
		 }
		 else
		 {
			 String sqlc="select * from t_castrolroutes where EndCode='"+endcode+"' AND Owner='"+gpname+"'";
				ResultSet rec=st.executeQuery(sqlc);
				 System.out.println("\n\ncastrolroutes for endcode********-->>"+sqlc);
				if(rec.next())
				 {
					 elatitude=rec.getFloat("Endlat");
					 elongitude=rec.getFloat("EndLong");
					 if(elatitude==0 && elongitude==0)
					 {
					 flag2=false;
					 }
					 else
						 {flag2=true;}
					 //flag2=true;
				//	 System.out.println("\n\n from warehouse lat end-->>"+elatitude);
				//	 System.out.println("\n\n from warehouse long end-->>"+elongitude);
				
				
					 // System.out.println("\n\n from castrolroutes lat end-->>"+elatitude);
					 // System.out.println("\n\n from castrolroutes long end-->>"+elongitude);
				}
		 
			 
		 }
		
	}




	%>
	<table border="0" bgcolor="white" align="center" width="100%">
	<tr>
	<td colspan="2">
	<table width="100%" align="center" class="stats" >
				<tr>
				<td align="center">
				<!--<div align="left"><font size="3" >Report No: 1.10</font></div>-->
				<font face="Arial" size="3" ><b>Journey On Map</b></font></td>
				</tr>
				<%
				if("0".equalsIgnoreCase(vehcode))
				{
					
				}//enf if
				else  if(!(tripid.equals("null") && null==tripid))
				{
					
				%>
				<tr>
				<td align="center"><h2><font face="Arial" size="3"><b>The Trip Report for Vehicle Reg. No.<%=vehreg %> From Date <%=mydate1 %> To <%=mydate2 %></b></font></h2></td>
				</tr>
				
				<%
				}//enf if
				
				else
				{
				%>
				<tr>
					<td>
					<form name="customdetail" method="get" action="" >
		
						<table border="0" width="750" align="center">  
	 					<tr>
	 						
	 						<td align="left">
	 						<input type="hidden" id="vehcode" name="vehcode" size="12" value="<%= vehcode%>"/>
	 						<input type="hidden" id ="tripid" name="tripid" size="12" value="<%=tripid%>"/>
	 						<input type="hidden" id ="briefid" name="briefid" size="12" value="<%=briefid%>"/>
	 						<input type="hidden" id ="drivid" name="drivid" size="12" value="<%=driverid%>"/>
	 						<input type="hidden" id ="rid" name="rid" size="12" value="<%=routeid%>"/>
	 										
	 						<b>From&nbsp;&nbsp;</b>
							<input type="text" id="data" name="data" size="12" value="<%= mydate1%>" readonly/>
							
							<script type="text/javascript">
	  				Calendar.setup(
	    			{
	      				inputField  : "data",         // ID of the input field
	      				ifFormat    : "%d-%b-%Y",     // the date format
	      				button      : "trigger"       // ID of the button
	    			}
	  				);
				</script>
							&nbsp;&nbsp;
								<select name="ftime1" id="ftime1">
									<option value="00" <%if(ftime1.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
			<option value="01" <%if(ftime1.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
			<option value="02" <%if(ftime1.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
			<option value="03" <%if(ftime1.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
			<option value="04" <%if(ftime1.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
			<option value="05" <%if(ftime1.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
			<option value="06" <%if(ftime1.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
			<option value="07" <%if(ftime1.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
			<option value="08" <%if(ftime1.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
			<option value="09" <%if(ftime1.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
		
								<%
								int ftt1=Integer.parseInt(ftime1);
								int ftt2=Integer.parseInt(ftime2);
								int ftt3=Integer.parseInt(ftime3);
				for(int i=10;i<24;i++)
				{
				%>
					<option value="<%=i%>" <%if(ftt1==i){%> Selected <%} %>><%=i%></option>
				<%
				}		
			%>
			</select>
			<select name="ftime2" id="ftime2">
			<option value="00"  <%if(ftime2.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
			<option value="01"  <%if(ftime2.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
			<option value="02"  <%if(ftime2.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
			<option value="03"  <%if(ftime2.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
			<option value="04"  <%if(ftime2.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
			<option value="05"  <%if(ftime2.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
			<option value="06"  <%if(ftime2.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
			<option value="07"  <%if(ftime2.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
			<option value="08"  <%if(ftime2.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
			<option value="09"  <%if(ftime2.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
			<%
			
			
				for(int i=10;i<60;i++)
				{
				%>
					<option value="<%=i%>"  <%if(ftt2==i){ %> Selected <%} %>><%=i%></option>
				<%
				}		
			%>
			
			</select>
			
			
			<select name="ftime3" id="ftime3">
			<option value="00"  <%if(ftime3.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
			<option value="01"  <%if(ftime3.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
			<option value="02"  <%if(ftime3.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
			<option value="03"  <%if(ftime3.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
			<option value="04"  <%if(ftime3.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
			<option value="05"  <%if(ftime3.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
			<option value="06"  <%if(ftime3.equalsIgnoreCase("06")){ %> Selected <%} %>>06</option>
			<option value="07"  <%if(ftime3.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
			<option value="08"  <%if(ftime3.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
			<option value="09"  <%if(ftime3.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
			<%
			
			
				for(int i=10;i<60;i++)
				{
				%>
					<option value="<%=i%>"  <%if(ftt3==i){ %> Selected <%} %>><%=i%></option>
				<%
				}		
			%>
			
			</select>
			
			
	<!--		<td align="left">-->
	<!--			<input type="button" name="From Date" value="From Date" id="trigger">-->
	<!--			-->
	<!--		</td>-->
			
			<td align="left"><b>To&nbsp;&nbsp;</b>
			<input type="text" id="data1" name="data1" value="<%=mydate2%>"  size="12" readonly/>
			<script type="text/javascript">
	  Calendar.setup(
	    {
	      inputField  : "data1",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",    // the date format
	      button      : "trigger1"       // ID of the button
	    }
	  );
			</script>
			&nbsp;&nbsp;
			<select name="ttime1" id="ttime1" >
			<option value="00"  <%if(ttime1.equalsIgnoreCase("00")) {%> Selected <%} %>>00</option>
			<option value="01"  <%if(ttime1.equalsIgnoreCase("01")) {%> Selected <%} %>>01</option>
			<option value="02"  <%if(ttime1.equalsIgnoreCase("02")) {%> Selected <%} %>>02</option>
			<option value="03"  <%if(ttime1.equalsIgnoreCase("03")) {%> Selected <%} %>>03</option>
			<option value="04"  <%if(ttime1.equalsIgnoreCase("04")) {%> Selected <%} %>>04</option>
			<option value="05"  <%if(ttime1.equalsIgnoreCase("05")) {%> Selected <%} %>>05</option>
			<option value="06"  <%if(ttime1.equalsIgnoreCase("06")) {%> Selected <%} %>>06</option>
			<option value="07"  <%if(ttime1.equalsIgnoreCase("07")) {%> Selected <%} %>>07</option>
			<option value="08"  <%if(ttime1.equalsIgnoreCase("08")) {%> Selected <%} %>>08</option>
			<option value="09"  <%if(ttime1.equalsIgnoreCase("09")) {%> Selected <%} %>>09</option>
			<%
			int tt1=Integer.parseInt(ttime1);
			int tt2=Integer.parseInt(ttime2);
				for(int i=10;i<24;i++)
				{
				%>
					<option value="<%=i%>" <%if(tt1==i){%> Selected <%} %>><%=i%></option>
				<%
				}		
			%>
	<!--		<option value="23" selected>23</option>-->
			</select>
			<select name="ttime2" id="ttime2" >
		<option value="00" <%if(ttime2.equalsIgnoreCase("00")){ %> Selected <%} %>>00</option>
			<option value="01"  <%if(ttime2.equalsIgnoreCase("01")){ %> Selected <%} %>>01</option>
			<option value="02"  <%if(ttime2.equalsIgnoreCase("02")){ %> Selected <%} %>>02</option>
			<option value="03"  <%if(ttime2.equalsIgnoreCase("03")){ %> Selected <%} %>>03</option>
			<option value="04"  <%if(ttime2.equalsIgnoreCase("04")){ %> Selected <%} %>>04</option>
			<option value="05"  <%if(ttime2.equalsIgnoreCase("05")){ %> Selected <%} %>>05</option>
			<option value="06"  <%if(ttime2.equalsIgnoreCase("06")) {%> Selected <%} %>>06</option>
			<option value="07"  <%if(ttime2.equalsIgnoreCase("07")){ %> Selected <%} %>>07</option>
			<option value="08"  <%if(ttime2.equalsIgnoreCase("08")){ %> Selected <%} %>>08</option>
			<option value="09"  <%if(ttime2.equalsIgnoreCase("09")){ %> Selected <%} %>>09</option>
			<%
				
				for(int i=10;i<60;i++)
				{
				%>
					<option value="<%=i%>" <%if(tt2==i){ %> Selected <%} %>><%=i%></option>
				<%
				}		
			%>
	<!--		<option value="59" selected>59</option>-->
			</select>		
			</td>
	<!--		<td align="left">-->
	<!--		-->
	<!--  		<input type="button" name="To Date" value="To Date" id="trigger1">-->
	<!--		-->
	<!--	</td>-->
		<td><div align="left" > 
			<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
			
			<input type="submit" name="submit" value="Submit">
		</div></td>
		
						</tr>
						</table>
						</form>
					</td>
				
				</tr>
				<%
				}
				%>
				</table>
	</td>
	</tr>
	<tr>
		<td width="20%" valign="top">
			<table width="100%" border="1" class="stats" valign="top">
				<%
			if(plannedstatus.equalsIgnoreCase("Yes"))
			{
				%>
				<tr><td class="hed" colspan="3"><img src="newimages/Green_Line.png" style="height: 3px;width: 100px;" align="left"> <div align="left">&nbsp;&nbsp;Planned Journey</div></td><!--<td colspan="2"><div id="lastloc11"></div></td>--></tr>
				<tr><td class="hed" colspan="3"><img src="newimages/Blue_Line.png" style="height: 3px;width: 100px;" align="left"> <div align="left">&nbsp;&nbsp;Actual Journey</div></td><!--<td colspan="2"><div id="lastloc11"></div></td>--></tr>
				<%
			}
			%>
				<tr><td class="hed" colspan="3"><img src="images/mm_20_green.png" align="left"> <div align="left">&nbsp;&nbsp;Last Location</div></td><!--<td colspan="2"><div id="lastloc11"></div></td>--></tr>
				<tr><td class="hed" colspan="3"><img src="images/mm_20_black.png" align="left"> <div align="left">&nbsp;&nbsp;Start Location </div></td><!--<td><div id="strtloc11"></div></td>--></tr>
			    
			    <%

			    if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)) && !("drivrating".equalsIgnoreCase(fromPage)))
			    {
			    if(flag1==true)
			    {
			    %>
				<tr><td class="hed"><img src="images/mm_20_purple.png" align="left"><div align="left">&nbsp;&nbsp;Trip Origin </div></td><td colspan="2"> <%=startplace1%></td></tr>
				<%}
			    else
			    {%>
			    <tr><td class="hed"><img src="images/mm_20_purple.png" align="left"> <div align="left">&nbsp;&nbsp;Trip Origin</div></td><td colspan="2">Not Geofenced</td></tr>
		    	<%}if(flag2==true)
			    { %>
				<tr><td class="hed"><img src="images/mm_20_brown.png" align="left"><div align="left">&nbsp;&nbsp;Trip Destination </div></td><td colspan="2"> <%=endplace1%></td></tr>
				<%}
			    else
			    {%>
			     <tr><td class="hed"><img src="images/mm_20_brown.png" align="left"> <div align="left">&nbsp;&nbsp;Trip Destination </div></td><td colspan="2">Not Geofenced</td></tr>
				
				<% }
			    }
		    	if(!("0".equalsIgnoreCase(vehcode))){ %>
				<tr><td class="hed"><img src="images/mm_20_red.png" align="left"> <div align="left">&nbsp;&nbsp;Over Speed </div></td><td><div id="os"></div></td><td><a href="javascript:ajaxFunction(1)" >[Details]</a>
				
				<!--<a href="ViolationReport.jsp?para=OS" >[Details]</a>--></td></tr>
				<tr><td class="hed"><img src="images/mm_20_blue.png" align="left"><div align="left">&nbsp;&nbsp;Rapid Accelaration</div> </td><td><div id="ra"></div></td><td><a href="javascript:ajaxFunction(2)">[Details]</a>
				
				<!--<a href="ViolationReport.jsp?para=RA">[Details]</a>--></td></tr>
				<tr><td class="hed"><img src="images/mm_20_yellow.png" align="left"><div align="left">&nbsp;&nbsp;Rapid Decelaration </div></td><td><div id="rda"></div></td><td><a href="javascript:ajaxFunction(3)" >[Details]</a> 
				
				<!--<a href="ViolationReport.jsp?para=RDA" >[Details]</a>--> </td></tr>
				<tr><td class="hed"><img src="images/mm_20_white.png" align="left"><div align="left">&nbsp;&nbsp;Stop Location</div> </td><td><div id="st"></div></td><td><a href='javascript:ajaxFunction(4);'>[Details]</a>
				
				<tr><td class="hed"><img src="images/mm_20_grey.png" align="left"><div align="left">&nbsp;&nbsp;Disconnection Location </div></td><td><div id="Disconn"></div></td><td><a href="javascript:ajaxFunction(5);">[Details]</a></td></tr>
				<%} %>
				<!--<a href="ViolationRep_Stop.jsp" >[Details]</a>-->
				</table>
				<br>
				<table width="100%" border="1" class="stats" valign="top">
				<%
			if(plannedstatus.equalsIgnoreCase("Yes"))
			{
				%>
			<tr><td class="hed"  colspan="3"><img src="newimages/source.png" style="width: 20px;height: 20px;"  align="left"><div align="left">&nbsp;&nbsp;Planned Trip Origin </div></td><!-- <td colspan="2" ><div id="porigin">< %=porigin %></div> </td>--></tr>
			<tr><td class="hed"  colspan="3"><img src="newimages/dest.png" style="width: 20px;height: 20px;" align="left"><div align="left">&nbsp;&nbsp;Planned Trip Destination </div></td><!--<td colspan="2" ><div id="pdest">< %=pdest %></div></td>--></tr>
			<tr><td class="hed"><img src="newimages/tea.png" style="width: 25px;height: 25px;" align="left"><div align="left">&nbsp;&nbsp;Planned Stops</div> </td><td><div id="pst"></div></td><td><a href='javascript:ajaxFunction(6);'>[Details]</a></td></tr>
			<tr><td class="hed"><img src="newimages/moon.png" style="width: 18px;height: 18px;" align="left"><div align="left">&nbsp;&nbsp;Planned Night Halts</div> </td><td><div id="pnh"></div></td><td><a href='javascript:ajaxFunction(7);'>[Details]</a></td></tr>
			<%
			}
			%>
				</table>
			
	           <!-- =========== side_bar with scroll bar ================= -->
	 
					<div id="side_bar"  style="overflow:auto;" align="left" ></div>
	           <!-- ===================================================== -->	
				<div id="side_bar1"  style="overflow:auto; height:390px;" align="left" ></div>
	</td>
		
	<td valign="top" style="width: 80%;">

	 <div id="map" style=" height:600px;position: relative"></div> 
	<!-- <div align="right"><font face="Arial" color="black">Copyright &copy; Transworld 2012. All rights reserved</font></div> -->
	       <!--<div id="map" style="width: 1150px; height: 650px"></div>-->
	</td>
	      </tr>  
	</table>
 </body>
    </html>
 <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    
 <script type="text/javascript">
    //<![CDATA[
    try
    {
    	 <%
    	 try
    	 {
    	 	conn = fleetview.ReturnConnection();
    	 	st=conn.createStatement();
    	 	st1=conn.createStatement();
    	 	st3=conn.createStatement();
    	 	st2=conn.createStatement();
    	 	st5=conn.createStatement();
    	 	stDisconn=conn.createStatement();
    	 	Class.forName(MM_dbConn_DRIVER); 
    	 	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    	 	stAC=conn1.createStatement();
    	 }
    	 catch(Exception e)
    	 {
    	 	out.print("Exception "+e);
    	 }
    	 String wareHouseCode="-",wareHouse="-",owner="-",html1=null,wtype="-",PolygonCoordinates="-";
    	 String rfname=session.getAttribute("rfname").toString(); //user name  //.setAttribute("rfname",fnamelist);
    	 String rlname=session.getAttribute("rlname").toString();
    	 String getCordiantesSql="",getCordiantesSql1="";
    	 ResultSet rs2=null,rs22=null; 
    	 String vehRegNo="";
    	 String strtplace="", endplace="", strtLat="",endLat="",strtLong="",endLong="",strtcode="",endcode="",stCodeList="(",endCodeList="(";
    	 String dcode = "";

    	 if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)) && !("drivrating".equalsIgnoreCase(fromPage)))
    	 {
    	 	String sqltrp="select * from t_startedjourney where TripID='"+tripid+"'";
    	 	ResultSet rstrp=st.executeQuery(sqltrp);
    	 	// System.out.println("started journey querry--------->"  +sqltrp);
    	 	if(rstrp.next())
    	 	{
    	 		strtplace=rstrp.getString("StartPlace");
    	 		endplace=rstrp.getString("EndPlace");
    	 		strtcode=rstrp.getString("StartCode");
    	 		endcode=rstrp.getString("EndCode");
    	 		dcode = rstrp.getString("drivercode");
    	 	}
    	 }


    	 	String fwUser = (String) session.getAttribute("user");
    	 	String savedCoordiantes = "";
    	 	if(fwUser.equalsIgnoreCase("Shramik"))
    	 	{		
    	 				 getCordiantesSql = "Select * from t_warehousedata where Owner='"+ fwUser+"' and MarkerType='Poly'";
    	 				 getCordiantesSql1 = "Select * from t_warehousedata where Owner='"+ fwUser+"'";
    	 			
    	 				//System.out.println("getCordiantesSql"+getCordiantesSql);
    	 				 rs2 = st2.executeQuery(getCordiantesSql);
    	 				 rs22 = st3.executeQuery(getCordiantesSql1);
    	 	}	
    	 %>

    	  function loadKML(url){
  	        try
  	        {
  	  	  map1.addLayer(new OpenLayers.Layer.GML("KML",url, 
  	  	          {
  	  	           format: OpenLayers.Format.KML, 
  	  	           formatOptions: 
  	  	  	       {
  	  	             extractStyles: true 
  	  	           }
  	  	          }));
  	        }
  	        catch(e)
  	        {
  	            alert("%%%%%%%%%%%%%%%"+e);
  	        }
  	    }

    	  function zoomtoloc(i,lat,lon)
    	  {
    	  			try
    	       		{
    	           		//alert("in my zoomtoloc");
    	           	//	alert(lat);
    	           	//	alert(lon);
    	      			    map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
    	        		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	        		        map1.getProjectionObject() // to Spherical Mercator Projection
    	        		      ),25);
    	       		}
    	       		catch(e)
    	       		{
    	           		alert(e);
    	       		} 
    	  }
    	  
    	  function createMarker3(name,html,lat,lon)
  	    {
  		    try
  		    {
  	    	var cIcon;
  	    	var size = new OpenLayers.Size(12,20);
      		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);

      		cIcon= new OpenLayers.Icon('images/mm_20_black.png', size, offset);

      		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
  		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
  		              map1.getProjectionObject() // to Spherical Mercator Projection
  		            ),cIcon);

      		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
      	      		new OpenLayers.LonLat(lon,lat).transform(
      			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      			              map1.getProjectionObject() // to Spherical Mercator Projection
      			            ),
      	      		new OpenLayers.Size(250,100),
      	      		html,
      	      		true);
      	    popup.closeOnMove = true; 
      	      		 map1.addPopup(popup);
      	          });

      		tmarkers[i] = mark;
          	htmls[i] = html;
          	//side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
          	i++;

          	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
        		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
        		        map1.getProjectionObject() // to Spherical Mercator Projection
        		      ),6);

          	return mark;
  		    }
  		    catch(e)
  		    {
  			   // alert(e);
  		    }
  		}

    	  function createMarker_ware(name,html1,lat,lon) 
    	  {
    		  try
    		    {
    	    	var cIcon;
    	    	var size = new OpenLayers.Size(12,20);
      		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);

      		cIcon= new OpenLayers.Icon('images/bp.png', size, offset);

      		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
    		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    		              map1.getProjectionObject() // to Spherical Mercator Projection
    		            ),cIcon);

      		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
      	      		new OpenLayers.LonLat(lon,lat).transform(
      			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      			              map1.getProjectionObject() // to Spherical Mercator Projection
      			            ),
      	      		new OpenLayers.Size(250,100),
      	      		html1,
      	      		true);
      	    popup.closeOnMove = true; 
      	      		 map1.addPopup(popup);
      	          });

      		tmarkers[i] = mark;
          	htmls[i] = html1;
          	//side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
          	i++;

          	

          	return mark;
    		    }
    		    catch(e)
    		    {
    			   // alert(e);
    		    }
    	  }
    		
    	  
    	  function createMarker(name,html,stamp,lat,lon) 
    	  {
    		  try
    		  {
    		  var cIcon ;
    		  var size = new OpenLayers.Size(20,20);
        	  var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
        	  if(stamp=="Rest")
      		{
        		  size = new OpenLayers.Size(25,25);
        		  cIcon= new OpenLayers.Icon('newimages/tea.png', size, offset);
      		}
      		if(stamp=="Night Halt")
      		{
      			size = new OpenLayers.Size(20,20);
      			cIcon= new OpenLayers.Icon('newimages/moon.png', size, offset);
      		}
      		
      		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
    	              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    	              map1.getProjectionObject() // to Spherical Mercator Projection
    	            ),cIcon);

    	mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
          		new OpenLayers.LonLat(lon,lat).transform(
    		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    		              map1.getProjectionObject() // to Spherical Mercator Projection
    		            ),
          		new OpenLayers.Size(250,100),
          		html,
          		true);
        popup.closeOnMove = true; 
          		 map1.addPopup(popup);
              });

    	tmarkers[i] = mark;
    	htmls[i] = html;
    	i++;
    		  }
    		  catch(e)
    		  {
    			 alert(e);
    		  }
    	return mark;
    	  }

    	   function createMarker2(name,html,lat,lon)
   	    {
   		    try
   		    {
   	    	var cIcon;
   	    	var size = new OpenLayers.Size(20,20);
       		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
       		cIcon= new OpenLayers.Icon('newimages/source.png', size, offset);
       		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
   		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
   		              map1.getProjectionObject() // to Spherical Mercator Projection
   		            ),cIcon);

       		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
       	      		new OpenLayers.LonLat(lon,lat).transform(
       			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
       			              map1.getProjectionObject() // to Spherical Mercator Projection
       			            ),
       	      		new OpenLayers.Size(250,100),
       	      		html,
       	      		true);
       	    popup.closeOnMove = true; 
       	      		 map1.addPopup(popup);
       	          });

       		tmarkers[i] = mark;
           	htmls[i] = html;
           	i++;

           	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
         		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
         		        map1.getProjectionObject() // to Spherical Mercator Projection
         		      ),3);

           	return mark;
   		    }
   		    catch(e)
   		    {
   			   // alert(e);
   		    }
   		}

    	   function createMarker1(name,html,lat,lon)
      	    {
      		    try
      		    {
      	    	var cIcon;
      	    	var size = new OpenLayers.Size(20,20);
          		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
          		cIcon= new OpenLayers.Icon('newimages/dest.png', size, offset);
          		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
      		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      		              map1.getProjectionObject() // to Spherical Mercator Projection
      		            ),cIcon);

          		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
          	      		new OpenLayers.LonLat(lon,lat).transform(
          			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
          			              map1.getProjectionObject() // to Spherical Mercator Projection
          			            ),
          	      		new OpenLayers.Size(250,100),
          	      		html,
          	      		true);
          	    popup.closeOnMove = true; 
          	      		 map1.addPopup(popup);
          	          });

          		tmarkers[i] = mark;
              	htmls[i] = html;
              	i++;

              	map1.setCenter(new OpenLayers.LonLat(lon,lat).transform(
            		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
            		        map1.getProjectionObject() // to Spherical Mercator Projection
            		      ),3);

              	return mark;
      		    }
      		    catch(e)
      		    {
      			   // alert(e);
      		    }
      		}

    	   function createMarker4(name,html,stamp,lat,lon) 
    		  {
    			  try
    			  {
    				  //alert("IIIII in marker "+stamp);
    			  var cIcon ;
    			  var size = new OpenLayers.Size(12,20);
    	    	  var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
    	    	  if(stamp=="OS")
    	  		{
    	    		cIcon= new OpenLayers.Icon('images/mm_20_red.png', size, offset);
    	  		}
    	  		if(stamp=="ST" || stamp=="SP")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_white.png', size, offset);
    	  		}
    	  		if(stamp=="AC")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_blue.png', size, offset);
    	  		}
    	  		if(stamp=="DC")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_yellow.png', size, offset);
    	  		}
    	  		if(stamp=="SI"||stamp=="OF")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_green.png', size, offset);
    	  		}
    	  		if(stamp=="Disconn")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_grey.png', size, offset);
    	  		}
    	  		if(stamp=="TripEnd")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_brown.png', size, offset);
    	  		}
    	  		if(stamp=="TripStart")
    	  		{
    	  			cIcon= new OpenLayers.Icon('images/mm_20_purple.png', size, offset);
    	  		}

    	  		var mark = new OpenLayers.Marker(new OpenLayers.LonLat(lon,lat).transform(
    		              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    		              map1.getProjectionObject() // to Spherical Mercator Projection
    		            ),cIcon);

    		mark.events.register('click', mark, function(evt) { popup = new OpenLayers.Popup("olPopup",
    	      		new OpenLayers.LonLat(lon,lat).transform(
    			              new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
    			              map1.getProjectionObject() // to Spherical Mercator Projection
    			            ),
    	      		new OpenLayers.Size(250,100),
    	      		html,
    	      		true);
    	    popup.closeOnMove = true; 
    	      		 map1.addPopup(popup);
    	          });

    		tmarkers[i] = mark;
    		htmls[i] = html;
//    		side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
    		i++;

    			  }
    			  catch(e)
    			  {
    				 // alert(e);
    			  }
    		return mark;
    			 
    		  }


    	   
    	   
    	  	var side_bar_html = "";
    	 	var side_bar_html1 = "";
    	  	var str;	
    	  	var tmarkers = [];
    	  	var tmarkerdis = [];
    	  	var htmls = [];
    	  	var htmldis = [];
    	  	var i = 0;dis=0;
    		var tmarkerstop = [];
    		var htmlstop = [];
    		var stopcnt = 0;
    		var tmarkerOS = [];
    		var htmlOS = [];
    		var OScnt = 0;
    		var tmarkerRA = [];
    		var htmlRA = [];
    		var RAcnt = 0;
    		var tmarkerRD = [];
    		var htmlRD = [];
    		var RDcnt = 0;
    		var tmarkerDisconn = [];
    		var htmlDisconn = [];
    		var Disconncnt = 0;
    		var url = "http://203.199.134.131:8008/mapguide/mapagent/mapagent.fcgi?USERNAME=Administrator&PASSWORD=admin";
			var metersPerUnit = 111319.4908;  //value returned from mapguide
			var inPerUnit = OpenLayers.INCHES_PER_UNIT.m * metersPerUnit;
			OpenLayers.INCHES_PER_UNIT["dd"] = inPerUnit;
			OpenLayers.INCHES_PER_UNIT["degrees"] = inPerUnit;
			OpenLayers.DOTS_PER_INCH = 72;
	  
			var	lo=77.2167510986328;
			var	la=28.5687255859375;
	 		var extent1 = new OpenLayers.Bounds(68.162834117480,6.7542559500000,97.41516105,37.06396505);
	 		var tempScales = [23659291,17074442,11322961,7588641,5059094,3372729,2248486,1498990,999327,666218,444145,296096,197397,131598,87732,58488,38992,25994,17329,11553,7702,5134,3423,2282,1521,1041,676,450,300,0];
	  		var mapOptions1 = 
		  	{
	    	maxExtent: extent1, 
	    	scales:tempScales,
	        units: "dd"
	  		};
	  		map1 = new OpenLayers.Map( 'map', mapOptions1 );
	  		map1.addControl(new OpenLayers.Control.PanZoomBar());
	  		map1.addControl(new OpenLayers.Control.OverviewMap());
	 		map1.addControl(new OpenLayers.Control.KeyboardDefaults());
	 		var params1 = 
		 	{
				mapdefinition: 'Library://TranswoldNew/test.MapDefinition',
			 	basemaplayergroupname: "Base Layer Group"
			}
			var options1 = 
   			{
				singleTile: true, isBaseLayer: true,
			    transitionEffect: "resize",
			    buffer: 1,
			    useOverlay: false,
			    useAsyncOverlay: false
			 }
			  //layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	 		//layer1=new OpenLayers.Layer.OSM("Local Tiles","http://173.234.153.82/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, 'attribution': false, "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	  		<%

//map integrate
String sqlmap="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue")+"'";
//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
ResultSet rsmap=st4.executeQuery(sqlmap);
System.out.println("started journey querry--------->"  +sqlmap);
if(rsmap.next())
{
	smap=rsmap.getString("Map");
	System.out.println("Map"  +smap);
}
%>
<%
if(smap.equals("OSM"))
{
	System.out.println("Hi1");
%>
layer1=new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, attribution : '<a href="http://myfleetview.com/" style="text-decoration:none"><font face="Hemi Head 426" size="03" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="0.5" color="#0853A0">Transworld Technologies Ltd.  </a>', "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	
	<%
	System.out.println("Hi2");
}

	else if(smap.equals("MPG"))
	{
	%>
	
	layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	<%
    }
	
	else if(smap.equals(""))
	{
		System.out.println("No Data");
		String sqlmap1="select * from t_defaultvals where OwnerName='Default'";
		//String sqlmap="select * from t_defaultvals where OwnerName='Castrol'";
		ResultSet rsmap1=st2.executeQuery(sqlmap1);
		System.out.println("started journey querry--------->"  +sqlmap1);
		if(rsmap1.next())
		{
			smap1=rsmap1.getString("Map");
			System.out.println("Map"  +smap1);
		}
		if(smap1.equals("OSM"))
				{
			
			System.out.println("Hi1");
    %>
    layer1=new OpenLayers.Layer.OSM("Local Tiles","http://maps.myfleetview.com/osm/\${z}/\${x}/\${y}.png", {numZoomLevels: 19, attribution : '<a href="http://myfleetview.com/" style="text-decoration:none"><font face="Hemi Head 426" size="03" color="#0853A0">FleetView <br><font face="Hemi Head 426" size="0.5" color="#0853A0">Transworld Technologies Ltd.  </a>', "tileOptions": {"crossOriginKeyword": null}},params1, options1);
	
	<%
		}
		else if(smap1.equals("MPG"))
		{
	System.out.println("Data1");
	%>
	
	layer1 = new OpenLayers.Layer.MapGuide( "INDIA MAP", url, params1, options1 );
	<%
		}
	}
    %>   
	 		
	 		
	 		map1.addLayer(layer1);
		  	  markers1 = new OpenLayers.Layer.Markers( "Markers");
	  		  map1.addLayer(markers1);
	  		loadKML("KMLJRM/TWIndiaBoundry.kml");
	  		  
	  	   <%
	  		String sql11="",sql12 ="";
	  		ResultSet rst12 = null,rst = null,rst11 = null;
	  		String color="ff0BA903"; //green
	  		String color1 = "ffF4070B";//red
	  		//System.out.println("vehcode bvxcndgsjbdxsnm  "+vehcode+"   vehregno   "+vehregno);	
	  		
			
			try
			{    	
			    /*sql1 = "select VehRegNo from db_gps.t_briefing where Briefid = '"+briefid+"' and tripid = '"+tripid+"' and Driverid = '"+driverid+"'";
			    rst = stDisconn.executeQuery(sql1);
			  //  System.out.println("sql last loc====>"+sql1);
			    if(rst.next())
			    {
			    	vehregno = rst.getString("VehRegNo");
			    }
			   // System.out.println("vehregno   "+vehregno);
			    
			    sql1 = "select vehiclecode from db_gps.t_vehicledetails where vehicleregnumber = '"+vehregno+"'";
			    rst = stDisconn.executeQuery(sql1);
			    if(rst.next())
			    {
			    	vehcode =  rst.getString("vehiclecode");
			    }		    	*/
			  //  System.out.println("vehcode   "+vehcode);	
			    
			   
			    		try
			    		{
			    		HashMap<String, String> coordinateMap = null;
						HashMap<String, String> coordinateMapStart = null;
						HashMap<String, String> coordinateMapEnd = null;
						List<HashMap<String, String>> coordinateList = null;
						  
						HashMap<String, String> actualcoordinateMap = null;
						HashMap<String, String> actualcoordinateMapStart = null;
						HashMap<String, String> actualcoordinateMapEnd = null;
						List<HashMap<String, String>> actualcoordinateList = null;    
						coordinateList=new ArrayList<HashMap<String, String>>();
						actualcoordinateList =new ArrayList<HashMap<String, String>>();
						
						if(plannedstatus.equalsIgnoreCase("Yes"))
						{
						sql12 = "select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'   order by advancedtrackid asc ,row asc limit 1";
						rst12=stDisconn.executeQuery(sql12);
					//	System.out.println("sql last loc====>"+sql12);
						if(rst12.next())
						{
							//System.out.println("*****   1st location");
							//mydate1 = rst12.getString("CumTime");
							
						    coordinateMapStart =  new java.util.HashMap<String, String>();
							coordinateMapStart.put("name",rst12.getString("Placename"));
							coordinateMapStart.put("desc", rst12.getString("Placename"));
							coordinateMapStart.put("lat",rst12.getString("latitude")); 
							coordinateMapStart.put("longi",rst12.getString("longitude"));  
						}
						sql1 = "select Placename,latitude,longitude from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'     order by advancedtrackid asc,row asc ";
						rst=stDisconn.executeQuery(sql1);
						while(rst.next())
						{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
							
							coordinateMap =  new java.util.HashMap<String, String>();
						    coordinateMap.put("name",rst.getString("Placename"));
						    coordinateMap.put("desc", rst.getString("Placename"));
						    coordinateMap.put("lat",rst.getString("latitude")); 
						    coordinateMap.put("longi",rst.getString("longitude"));                         
						    coordinateList.add(coordinateMap);
//						      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));
						}
						
						sql11 = "select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'   order by advancedtrackid desc ,row desc limit 1";		
						rst11=stDisconn.executeQuery(sql11);
					//	System.out.println("rst11====>"+sql11);
						if(rst11.next())
						{
							//System.out.println("*****   Last location");
							//System.out.println("1038 Hii");
							mydate2 = rst11.getString("CumTime");
						    coordinateMapEnd =  new java.util.HashMap<String, String>();
						    coordinateMapEnd.put("name",rst11.getString("Placename"));
						    coordinateMapEnd.put("desc", rst11.getString("Placename"));
						    coordinateMapEnd.put("lat",rst11.getString("latitude")); 
						    coordinateMapEnd.put("longi",rst11.getString("longitude"));   
						}	
						}
						boolean flag=true;
						boolean flag0=false;
						//sql1 = "select TheFieldSubject,LatinDec,LonginDec  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'  and TheFieldSubject in (select distinct(TheFieldSubject)  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and  thefielddatadatetime <> 'NULL'  and TheFiledTextFileName  NOT IN('AC','DC','OS')) order by  Thefielddatadatetime";
						//sql1 = "select TheFieldSubject,LatinDec,LonginDec,Speed  from db_gps.t_veh"+vehcode+" where Thefielddatadatetime >= '"+dates1[i]+"' and Thefielddatadatetime <= '"+dates2[i]+"' and TheFiledTextFileName  NOT IN('AC','DC','OS') and  thefielddatadatetime <> 'NULL'   order by  Thefielddatadatetime";
					
						if("0".equalsIgnoreCase(vehcode))
						{
					 		sql1="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"'  and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD')  and  thefielddatadatetime <> 'NULL' order by TheFieldDataDateTime asc";
						}				
						else
						{
							sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"'  and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD')  and  thefielddatadatetime <> 'NULL' order by TheFieldDataDateTime asc";
						}
						
						rst=stDisconn.executeQuery(sql1);
						 System.out.println("sql   "+sql1);
						 while(rst.next())
						 {
							 actualcoordinateMap =  new java.util.HashMap<String, String>();
							 if(rst.getInt("Speed")==0)
							{
								 if(flag)
								{
									actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
									actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
									actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
									actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
									actualcoordinateList.add(actualcoordinateMap);
									 flag=false;
									 flag0=true;
								}
								if(flag0){
									 actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
										actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
										actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
										actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
										actualcoordinateList.add(actualcoordinateMap);
									//	 flag=false;
										 flag0=true;
										}
							}
							 else
							 {
								 flag=true;
								 actualcoordinateMap.put("name",rst.getString("TheFieldSubject"));
								 actualcoordinateMap.put("desc", rst.getString("TheFieldSubject"));
								 actualcoordinateMap.put("lat",rst.getString("LatinDec")); 
								 actualcoordinateMap.put("longi",rst.getString("LonginDec"));   
								 actualcoordinateList.add(actualcoordinateMap);
							 }
							 ///System.out.println("****   ");
							
							
						 }
						 
						 if("0".equalsIgnoreCase(vehcode))
						 {
							 sql1="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD')  and  thefielddatadatetime <> 'NULL'  order by TheFieldDataDateTime asc";
						 }   
						else
						{
							sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD')  and  thefielddatadatetime <> 'NULL'  order by TheFieldDataDateTime asc";
						}	
						 rst=stDisconn.executeQuery(sql1);
						 System.out.println("sql   "+sql1);
						 if(rst.next())
						 {
							 actualcoordinateMapStart =  new java.util.HashMap<String, String>();
							 actualcoordinateMapStart.put("name",rst.getString("TheFieldSubject"));
							 actualcoordinateMapStart.put("desc", rst.getString("TheFieldSubject"));
							 actualcoordinateMapStart.put("lat",rst.getString("LatinDec")); 
							 actualcoordinateMapStart.put("longi",rst.getString("LonginDec"));  
						 }
						 
						 if("0".equalsIgnoreCase(vehcode))
						 {
							 sql1="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD') order by TheFieldDataDateTime desc";
						 }else{
							sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD') order by TheFieldDataDateTime desc";
						 }
						rst=stDisconn.executeQuery(sql1);
						 System.out.println("sql   "+sql1);
						 if(rst.next())
						 {
							 actualcoordinateMapEnd =  new java.util.HashMap<String, String>();
							 actualcoordinateMapEnd.put("name",rst.getString("TheFieldSubject"));
							 actualcoordinateMapEnd.put("desc", rst.getString("TheFieldSubject"));
							 actualcoordinateMapEnd.put("lat",rst.getString("LatinDec")); 
							 actualcoordinateMapEnd.put("longi",rst.getString("LonginDec"));  
						 }
						 
						 if(plannedstatus.equalsIgnoreCase("Yes"))
							{
						String dir=request.getRealPath("/");
						dir=dir+"KML/"+"kml_"+tripid+"_"+briefid+".kml";	
						KML1 kml=new KML1();
						flag1=kml.generateKMLFORLINE(coordinateList,dir,coordinateMapStart,coordinateMapEnd,color);
						%>
						//var date1 = < %=mydate1%>;
						//var date2 = < %=mydate2%>;
						//alert("date1   "+date1);
						//alert("date2   "+date2);
						var filename="<%=tripid%>_<%=briefid%>";
						
						var url="KML/kml_"+filename+".kml?date="+new Date().getTime();
						loadKML(url);	
						<%	
							}
						
						 String kmlfile = "";
							if(tripid == null || tripid.equals("")||tripid.equals("-")||tripid.equalsIgnoreCase("null"))
							{
								
							}
							else
							{
							sql11 = "select kmlfile from db_gps.t_castrolroutes where  startcode ='"+strtcode+"' and endcode ='"+endcode+"'";
							   ResultSet rs11 = st.executeQuery(sql11);
							   System.out.println("castrolroutes querry---------------->"  +sql11);
							   if(rs11.next())
							   {
								   kmlfile = rs11.getString("kmlfile");
							   }
							   System.out.println("kmlfile---------------->"  +kmlfile);
							 //  kmlfile = "yes";
							   
							}
						String dir1 = request.getRealPath("/");
						dir1 = dir1+"KML/"+"actkml_"+tripid+"_"+briefid+".kml";
						KML1 kml1=new KML1();
						flag1 = false;
						try
						{
						flag1=kml1.generateKMLFORLINE(actualcoordinateList,dir1,actualcoordinateMapStart,actualcoordinateMapEnd,color1);
						}
						catch(Exception e)
						{
							System.out.println("Exception-  generating actual KML-->    "+e);
						}
						%>

						 var kmlfile1 = "<%=kmlfile%>";

					      if(kmlfile1 == ""||kmlfile1=="-")
					      { }
					      else
					      {
					   	  	 loadKML("KMLJRM/"+kmlfile1);
					   	  /*loadKML("KMLJRM/FullJRMFilenew.kml");
					   		loadKML("KMLJRM/CastrolNorthernRegion1KmStreach.kml");
							loadKML("KMLJRM/Delhi-Patalganga1Zone.kml");
							loadKML("KMLJRM/Bhivandi-Patalganga-BangloreKmStreach.kml");
							loadKML("KMLJRM/Bhivandi-Patalganga-Banglore-Chennai1Zone.kml");
							loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad1KmStreach.kml");
							loadKML("KMLJRM/Bhivandi-Patalganga-Hydrabad-Chennai1Zone.kml");
							loadKML("KMLJRM/Chennai-Pallakad1Zone.kml");
							loadKML("KMLJRM/Kolkata-Guwahati1KmStreach.kml");
							loadKML("KMLJRM/Kolkata-Kanpur-Lucknow1KmStreach.kml");
							loadKML("KMLJRM/Bhivandi-Dhule1KmStreach.kml");
							loadKML("KMLJRM/Bhivandi-Nagpur1Zone.kml");
							loadKML("KMLJRM/tankerEast.kml");	
							loadKML("KMLJRM/tankerWest.kml");*/
					    	 // loadKML("/usr/share/tomcat6/webapps/images1/kmlfile/"+kmlfile1);
					      }
						var filename1="<%=tripid%>_<%=briefid%>";
						var url1="KML/actkml_"+filename1+".kml?date="+new Date().getTime();
						<%
						try
						{
							if(flag1 == true)
							{
		%>
						loadKML(url1);	
						<%
							}
						}
						catch(Exception e)
						{
							System.out.println("Exception-  loading actual kml-->    "+e);
						}
						 
			    		}
			    		catch(Exception  e)
			    		{
			    			 System.out.println("Exception--->    "+e);
			    		}
					 
			
			
		
			
			}
			catch(Exception e)
			{
			    // System.out.println("Exception ----------->    "+e);
			}
			%>
			/*var size = new OpenLayers.Size(12,18);
			var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
			var iconn = new OpenLayers.Icon('images/mm_20_red.png', size, offset);*/
 	  
		    markers = new OpenLayers.Layer.Markers( "Markers");
			map1.addLayer(markers);
		
	  		map1.setCenter(new OpenLayers.LonLat(77.768553,23.402765).transform(
		    new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		    map1.getProjectionObject() // to Spherical Mercator Projection
		     ),3);

		    map1.events.register('zoomend', map1, function(evt)
            {
        	var zoom = map1.getZoom();
      		//  alert(zoom);
            });

    
    	<%
   		 try
    	{
   			if(plannedstatus.equalsIgnoreCase("Yes"))
			{
    	 	sql12="select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid asc ,row asc limit 1";
    		 // System.out.println("sql start loc====>"+sql12);
			 rst12=st.executeQuery(sql12);
		 	if(rst12.next())
		 	{
			    lat=rst12.getDouble("latitude");
				lon=rst12.getDouble("longitude");
				location=rst12.getString("Placename");
			    porigin = location;
				String dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst12.getString("CumTime")));
				html2="<b>Start location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1;
				%>
				//document.getElementById("strtloc11").innerHTML=< %=location%>;
				
				var marker1 = createMarker2("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
			 	markers.addMarker(marker1);    	   
			 	
				<%
			}
		
		 	pstop = 0;pnighthalt = 0;
			sql12="select Placename,latitude,longitude,CumTime,Event from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and event in ('Night Halt','Rest')  "+dayquery+"  order by advancedtrackid asc,row asc";
  			// 	 System.out.println("sql start loc====>"+sql12);
			rst12=st.executeQuery(sql12);
			while(rst12.next())
			{
			   	String dur = "",datetime = "",datetime1 = "";
				String sql13 = "select stopDuration,End  from db_gps.t_jrnyplanning where Tripid = '"+tripid+"'  and brifid = '"+briefid+"' and driverid = '"+driverid+"'  and Destination = '"+rst12.getString("Placename")+"'";
				ResultSet rs13 = st3.executeQuery(sql13);
				if(rs13.next())
				{
					dur =new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs13.getString("stopDuration")));
					datetime = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs13.getString("End")));
				}
			
				sql13 = "select AddTime('"+rs13.getString("End")+"','"+rs13.getString("stopDuration")+"') as enddate";
				rs13 = st3.executeQuery(sql13);
				if(rs13.next())
				{
					datetime1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs13.getString("enddate")));
				}
				
				if(rst12.getString("Event").equalsIgnoreCase("Rest"))
				{
					pstop = pstop+1;
				}
				else if(rst12.getString("Event").equalsIgnoreCase("Night Halt"))
				{
					pnighthalt = pnighthalt + 1;
				}
				
				label1="<b>"+rst12.getString("Event")+"</b><br><br><b>Date Time : </b>"+vehregno+"<br><b>Stop Date Time : </b>"+datetime+"<br><b>Start Date Time : </b>"+datetime1+"<br><b>Duration : </b>" +dur+ " <br><b>Location : </b>"+rst12.getString("Placename");
				%>  
				var marker = createMarker("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","<%=rst12.getString("Event")%>",<%= rst12.getString("latitude")%>,<%= rst12.getString("longitude")%>);
				markers.addMarker(marker);	
				<%
			
			}
		
			sql12="select Placename,latitude,longitude,CumTime from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid desc ,row desc limit 1";
	 		 // 	 System.out.println("sql start loc====>"+sql12);
			rst12=st.executeQuery(sql12);
			while(rst12.next())
			{
				lat=rst12.getDouble("latitude");
				lon=rst12.getDouble("longitude");
				location=rst12.getString("Placename");
				pdest = location;
				String dt1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst12.getString("CumTime")));
				html2="<b>End location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1;
				%>
				//document.getElementById("strtloc11").innerHTML=< %=location%>;
				var marker1 = createMarker1("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
			 	markers.addMarker(marker1); 	   
				<%			
			}
			
			// System.out.println("porigin  "+porigin);
			// System.out.println("pdest  "+pdest);
			// System.out.println("pstop  "+pstop);
			// System.out.println("pnighthalt  "+pnighthalt);
			
			%>
			try
			{
				
			//document.getElementById("porigin").innerHTML=< %=porigin%>;
			//document.getElementById("pdest").innerHTML=< %=pdest%>;
			document.getElementById("pst").innerHTML=<%=pstop%>;
			document.getElementById("pnh").innerHTML=<%=pnighthalt%>;
			}
			catch(e)
			{
				alert(e);
		}
			<%
			}
			/////////////////////////////////**************************************************///////////////////////////////////////

			  String stamp;
			  if("0".equalsIgnoreCase(vehcode)){
					%>
					side_bar_html +="<div class='bodyText'><b>UnitId:<font color='red'> <%=unitid%></font> <br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(time1))%></font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(time2))%></font></b>";
					<%
				}
				else{
					sql="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
					System.out.println("vehcode   "+vehcode);
					ResultSet rstx=st.executeQuery(sql);
					if(rstx.next())
					{
						
						vehRegNo=rstx.getString("VehicleRegNumber");
					Format NewFormatter3 = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
					if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)))
					{
					%>
						side_bar_html +="<div class='bodyText'><b>Trip ID : <font color='red'><%=tripid%></font></b><br><b>Vehicle Reg.No.:<font color='red'> <%=rstx.getString("VehicleRegNumber")%></font> <br>Transporter : <font color='red'><%=rstx.getString("OwnerName")%></font><br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(time1))%></font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(time2))%></font></b>";
					<%
					}
					else
					{
						%>
						side_bar_html +="<div class='bodyText'><b>Vehicle Reg.No.:<font color='red'> <%=rstx.getString("VehicleRegNumber")%></font> <br>Transporter : <font color='red'><%=rstx.getString("OwnerName")%></font><br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(time1))%></font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(time2))%></font></b>";
						<%
					}
					
				
					session.setAttribute("hvrno",rstx.getString("VehicleRegNumber"));
					}
				}
					//sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName ='SI' and speed >0";
					if("0".equalsIgnoreCase(vehcode)){
						sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist,TheFiledTextFileName as stamp from t_veh"+vehcode+" where unitid= '"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName IN ('SI','OF','ST','SP')";
					}
					else{
						sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist,TheFiledTextFileName as stamp from t_veh"+vehcode+" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName IN ('SI','OF','ST','SP')";
					}

				ResultSet rst2=st3.executeQuery(sql);
				if(rst2.next())
				{
					int startDist=0;
					int endDist=0;
					startDist=rst2.getInt("startdist");
					endDist=rst2.getInt("enddist");
					dist=endDist-startDist;
					stamp=rst2.getString("stamp");
					if(dist > 0)
					{
					%>
						side_bar_html += "<div class='bodyText'><b>Total Distance Travelled: </b><font color='red' size='2'><%=dist%></font> km.</div>";
					<%
					}
					 
					else
					{
					%>
					side_bar_html +="<div class='bodyText' size='3' align='center'><font color='red'></font></div>";
					<%
					}
				}
			  
				int OScount=0,ACcount=0,DCcount=0,STcount=0,DisconnCount=0;
				String file="";
				
			   // boolean flag1;
			   
			    sql12="";
			    Double startdist=0.0,enddist=0.0;
			    if("0".equalsIgnoreCase(vehcode))
			    	sql12="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD') order by TheFieldDataDateTime asc";
			    else
			    	sql12="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD') order by TheFieldDataDateTime asc";
					
				 System.out.println("sql start loc====>"+sql12);
				 rst12=st.executeQuery(sql12);
				if(rst12.next())
				{
					startdist=rst12.getDouble("Distance");
			      
			    //   	System.out.println("MapStart----------"+coordinateMapStart.get("lat")+","+coordinateMapStart.get("longi"));
					
					lat=rst12.getDouble("LatinDec");
					lon=rst12.getDouble("LonginDec");
					
					// System.out.println("\n\n start loc lat-->><"+lat);
					// System.out.println("\n\n start loc lon-->><"+lon);
					
					location=rst12.getString("TheFieldSubject");
					// System.out.println(lat+","+lon);
					
					String dt1 = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst12.getString("TheFieldDataDate")));
					html2="<b>Start location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1+" " +rst12.getString("TheFieldDataTime");
					%>
					//document.getElementById("strtloc11").innerHTML=< %=location%>;
					var marker1 = createMarker3("<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
					 markers.addMarker(marker1);    	   
					<%}
				
				/******************************************************  check start loc is geofenced ************************************************************/
			  
				if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode))  && !("drivrating".equalsIgnoreCase(fromPage)) && ("Castrol".equalsIgnoreCase(gpname)))
				{
					
					// System.out.println("\n\n GPName-->>"+gpname);
					String sqlware="select * from t_warehousedata where WareHouseCode='"+strtcode+"'";
				//	System.out.println("sqlware--"+sqlware);
					ResultSet resw=st5.executeQuery(sqlware);
					if(resw.next())
					{
						latw=resw.getDouble("Latitude");
						longw=resw.getDouble("Longitude");
			
						html11="<b>Geofenced Start location:</b><br>"+location;
			
			%>
			var markerw = createMarker_ware("<%=resw.getString("WareHouse")%>","<div class='bodyText'><%=html2%></div>",<%=latw%>,<%=longw%>);
			 markers.addMarker(markerw);    
			<%		}//warehouse if end
					else
					{
						String sqlc="select * from t_castrolroutes where StartCode='"+strtcode+"'";
						ResultSet rec=st.executeQuery(sqlc);
						if(rec.next())
						{
							html11="<b>Geofenced Start location:</b><br>"+location;
							
						}
					
					%>
					var markerw = createMarker_ware("<%=location%>","<div class='bodyText'><%=html11%></div>",<%=lat%>,<%=lon%>);
					 markers.addMarker(markerw);    
				<%	}
				}//if tripid!=null end
				else
				{
					// System.out.println("Trip Is Null.............");
				}
				
	/*--------------------------------------------change:-TheFiledTextFileName ='SI' removed from query------------------------------------------------------------------------*/
				/*if("0".equalsIgnoreCase(vehcode))
			 sql1="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and  speed >0 and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime asc";
	    else
			sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and speed >0 and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime asc";

		Resultset rst=st.executeQuery(sql1);
		while(rst.next())
		{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
			
			/* coordinateMap =  new java.util.HashMap<String, String>();
	         coordinateMap.put("name",rst.getString("TheFieldSubject"));
	         coordinateMap.put("desc", rst.getString("TheFieldSubject"));
	         coordinateMap.put("lat",rst.getString("LatinDec")); 
	         coordinateMap.put("longi",rst.getString("LonginDec"));                         
	         coordinateList.add(coordinateMap);
	   //      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));
		}*/
		%> 

		<%

		//while to drow the line.
		
		/***********COde for find lasst location***************/
		sql11="";
		/*---------------------------------change:- TheFiledTextFileName IN('SI','OF') removed from query---------------------------*/
		if("0".equalsIgnoreCase(vehcode))
			sql11="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD') order by TheFieldDataDateTime desc";
	    else
			sql11="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS','SI1','AC1','DC1','OS1','OS2','OS3','VC','VD') order by TheFieldDataDateTime desc";
		// System.out.println("sql last loc====>"+sql11);
		rst11=st.executeQuery(sql11);
		if(rst11.next())
		{
			//System.out.println("1038 Hii");
			enddist=rst11.getDouble("Distance");
	       
	     //   System.out.println("MapEnd----------"+coordinateMapEnd.get("lat")+","+coordinateMapEnd.get("longi"));
			
			lat=rst11.getDouble("LatinDec");
			lon=rst11.getDouble("LonginDec");
			// System.out.println("\n lat for last->>"+lat);
			// System.out.println("\n long for last->>"+lon);
			location=rst11.getString("TheFieldSubject");
			
			String dt = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst11.getString("TheFieldDataDate")));
			html1="<b>Last location:</b><br>"+location+"<br><b>Date Time : </b>"+dt+" " +rst11.getString("TheFieldDataTime");
		 
			//System.out.println("1055 Hii");
			%>
			var marker = createMarker4("<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","SI",<%= rst11.getString("LatinDec")%>,<%= rst11.getString("LonginDec")%>);
			 markers.addMarker(marker);    
			// alert("IIIIII");
			<%
			   // System.out.println("1063 Hii");
				}
		
		/****************************************** check last loc is geofence*********************************/
		if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode))  && !("drivrating".equalsIgnoreCase(fromPage)) && ("Castrol".equalsIgnoreCase(gpname)))
		{
			//System.out.println("1069 Hii");
			sqlware="select * from t_warehousedata where WareHouseCode='"+endcode+"' limit 1";
			//System.out.println("sqlware end--"+sqlware);
			ResultSet resw1=st5.executeQuery(sqlware);
			if(resw1.next())
			{
				//System.out.println("1075 Hii");
				latw1=resw1.getDouble("Latitude");
				longw1=resw1.getDouble("Longitude");
				// System.out.println(latw1+","+longw1);
				html22="<b>Geofenced Last location:</b><br>"+location;
			
			%>
			var markerw1 = createMarker_ware("<%=resw1.getString("WareHouse")%>","<div class='bodyText'><%=html22%></div>",<%=latw1%>,<%=longw1%>);
			markers.addMarker(markerw1);   
			<%}
			else
			{
				//System.out.println("1089 Hii");
				String sqlc="select * from t_castrolroutes where EndCode='"+endcode+"'";
				//System.out.println("1091 "+sqlc);
				ResultSet rec=st.executeQuery(sqlc);
				if(rec.next())
				{
					//System.out.println("10 Hii");
					html22="<b>Geofenced Last location:</b><br>"+location;	
			%> 
			var markerw1 = createMarker_ware("<%=location%>","<div class='bodyText'><%=html22%></div>",<%=lat%>,<%=lon%>);
			markers.addMarker(markerw1);   
			<%}
			}
		}
		else
		{
			
		}
		
		/******************************  check start loc of trip is geofenced ************************/
		 if(flag1==true)
			    {
			//System.out.println("\n\n in start trip ");
						htmlvis1="<b>Geofenced Trip Start location:</b><br>"+startplace1;
					//	System.out.println("\n\n vishal start lat-->>"+slatitude);
					//	System.out.println("\n\n vishal start long-->>"+slongitude);
			
			%>
			  var marker = createMarker4("<div class='bodyText' align='left'><%=startplace1%></div>","<div class='bodyText' align='left'><%=htmlvis1%></div>",'TripStart','<%=slatitude%>','<%=slongitude%>');
			  markers.addMarker(marker);
			  <%		
			  }//warehouse if end   
			  
			  
		 /******************************  check end loc of trip is geofenced ************************/
		 if(flag2==true)
			    {
				// System.out.println("\n\n in end trip ");
						htmlvis2="<b>Geofenced Trip End location:</b><br>"+endplace1;
					//	System.out.println("\n lat for trip end->>"+elatitude);
					//	System.out.println("\n long for trip end->>"+elongitude);	
			%>
			var marker = createMarker4("<div class='bodyText' align='left'><%= endplace1%></div>","<div class='bodyText' align='left'><%=htmlvis2%></div>",'TripEnd','<%=elatitude%>','<%=elongitude%>');
			  markers.addMarker(marker);	
			<%		
			}//warehouse if end

		

				
				if(!("0".equalsIgnoreCase(vehcode))){
					// System.out.println("1251 Hii");
					String date1=data1+" "+time1;
					String date2=data2+" "+time2;
					ResultSet rstos=fleetview.getOSforDateRange(date1,date2,vehcode);
					// System.out.println("1251 Hii");
					while(rstos.next())
					{
							label1="<b>OverSpeed</b><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstos.getDate("FromDate"))+" "+rstos.getString("FromTime")+"<br><b>Speed : </b>" +rstos.getString("Speed")+"(kmph)<br><b>Duration : </b>" + rstos.getString("Distance") + " Sec.<br><b>Location : </b>"+rstos.getString("TheFieldSubject");
							%> 
							var marker = createMarker4("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","OS",<%= rstos.getDouble("LatinDec")%>,<%= rstos.getDouble("LonginDec")%>);
							 markers.addMarker(marker);	
							<%
							OScount++;
					}
					// System.out.println("1251 Hii " +OScount);
			%>
					document.getElementById("os").innerHTML=<%= OScount%>;
			<%
			
			ResultSet rstac=fleetview.getACforDateRange(date1,date2,vehcode);
			while(rstac.next())
			{
				label1="<b>Rapid Acceleration</b><br><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstac.getDate("TheFieldDataDate"))+" "+rstac.getString("TheFieldDataTime")+"<br><b> Speed : </b>" +rstac.getString("FromSpeed")+" <b>to</b> " + rstac.getString("ToSpeed")+"(kmph)<br><b>Location : </b>"+rstac.getString("TheFieldSubject");
			%> 
			var marker = createMarker4("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","AC",<%= rstac.getDouble("LatinDec")%>,<%= rstac.getDouble("LonginDec")%>);
			 markers.addMarker(marker);	
			<%
			ACcount++;
			}
			stAC.close();
			%>	
			document.getElementById("ra").innerHTML=<%= ACcount%>;
			<%
			ResultSet rstdc=fleetview.getDCforDateRange(date1,date2,vehcode);
			while(rstdc.next())
			{
				label1="<b>Rapid Deceleration</b><br> <br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstdc.getDate("TheFieldDataDate"))+" "+rstdc.getString("TheFieldDataTime")+"<br><b> Speed : </b>" +rstdc.getString("FromSpeed")+" <b>to</b> " + rstdc.getString("ToSpeed")+"(kmph)<br><b>Location : </b>"+rstdc.getString("TheFieldSubject");
	%> 
			var marker = createMarker4("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","DC",<%= rstdc.getDouble("LatinDec")%>,<%= rstdc.getDouble("LonginDec")%>);
			 markers.addMarker(marker);	
	<%
			DCcount++;
					
			}
	%>
		document.getElementById("rda").innerHTML=<%= DCcount%>;
		
		/******************code for stops***************/
	<%
	// System.out.println("code for stop    ");
	String stopdatetime="-",startdatetime="-";//stopdatetime1="-";
	int minstopdur = 0;
		
	try
	{
		minstopdur = Integer.parseInt(session.getAttribute("stop11").toString());
	}
	catch(Exception  e)
	{
		sql = "select * from db_gps.t_defaultvals where ownername = 'Castrol' ";
		ResultSet rsdefault = st.executeQuery(sql);
		if(rsdefault.next())
		{
			minstopdur = rsdefault.getInt("StoppagesGreaterThanInMins");
		}
	}
	session.setAttribute("stop11",minstopdur);

	double stoplat=0,stoplon=0;
	STcount=0;
	//java.util.Date stopdatetime1=null;
	String stopdatetime1="";
	String sql00="select * from db_gpsExceptions.t_veh"+vehcode+"_stsp where  CONCAT( Fromdate,' ',FromTime ) >='"+date1+" "+time1+"' and CONCAT( Fromdate,' ',FromTime ) <='"+date2+" "+time2+"' order by Fromdate, FromTime asc";

	System.out.println("Query 1:-"+sql00);
 	ResultSet rst00= st00.executeQuery(sql00);
	
	while(rst00.next())
	{
 	
 	//sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+" "+time1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+" "+time2+"' and TheFiledTextFileName in('SI','ST','SP') order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
 //	sql="select * from t_veh"+vehcode+" where TheFieldDataDateTime ='"+rst00.getString("Fromdate")+" "+rst00.getString("FromTime")+"'  and TheFiledTextFileName in('SI','ST','SP') order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
 sql="select * from t_veh"+vehcode+" where TheFieldDataDateTime ='"+rst00.getString("Fromdate")+" "+rst00.getString("FromTime")+"'   ";
				ResultSet rstst=st.executeQuery(sql);
				 System.out.println("sqlstops    "+sql);
				
				boolean flag=true;
				int i=1;
				//while(rstst.next())
				if(rstst.next())
				{
					//if(rstst.getInt("Speed")==0)
					{
						//if(flag)
						{
						//	System.out.println("I m here");
							//stopdatetime=rstst.getString("TheFieldDataDate")+" "+rstst.getString("TheFieldDataTime");
							stopdatetime=rst00.getString("Fromdate")+" "+rst00.getString("FromTime");
							//stopdatetime1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstst.getString("TheFieldDataDate"))+"  "+rstst.getString("TheFieldDataTime"));
							stopdatetime1=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst00.getString("Fromdate")+" "+rst00.getString("FromTime")));
							stoplat=rstst.getDouble("LatinDec");
							stoplon=rstst.getDouble("LonginDec");
							flag=false;
							
						}
					}
					//else
					{
						flag=true;
					//	startdatetime=rstst.getString("TheFieldDataDate")+" "+rstst.getString("TheFieldDataTime");
					System.out.println("herere");
					stopdatetime=rst00.getString("Fromdate")+" "+rst00.getString("FromTime");
					startdatetime=rst00.getString("ToDate")+" "+rst00.getString("ToTime");
					
					//startdatetime=rst00.getString("ToDate")+" "+rst00.getString("ToString");
						if(!(stopdatetime.equals("-")))
						{
							System.out.println("Before date");
							java.util.Date spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopdatetime);
							java.util.Date stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdatetime);
							System.out.println("after date");
							long mils=(stdate.getTime()-spdate.getTime());
							long mins=mils/1000/60;
							System.out.println("Fnnbvfgkj    ");
							String hrs="";
							String min="00";
							if(mins >= minstopdur)
							{
								//System.out.println("Fnnbvfgkj    ");
								 hrs=""+mins/60;
								//String min="00";
								try{
								 min=""+mins%60;
								}catch(Exception ee)
								{
									min="00";
								}
							}
							//	label1="<b>Stop Location</b><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Stop Date Time : </b> "+stopdatetime1+"<br><b>Start Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstst.getDate("TheFieldDataDate"))+"  "+rstst.getString("TheFieldDataTime")+"<br><b>Stoppage duration : </b> "+hrs+"hrs "+min+"min  <br><b>Location : </b>"+rstst.getString("TheFieldSubject");
							label1="<b>Stop Location</b><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Stop Date Time : </b> "+stopdatetime1+"<br><b>Start Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst00.getString("ToDate")+"  "+rst00.getString("ToTime")))+"<br><b>Stoppage duration : </b> "+hrs+"hrs "+min+"min  <br><b>Location : </b>"+rst00.getString("Location");
							//	STcount++;
							System.out.println("1234");
								%> 

									
									var marker = createMarker4("<div class='bodyText' align='left'><%= label1%></div>","<div class='bodyText' align='left'><%=label1%></div>",'ST','<%=stoplat%>','<%=stoplon%>');
									markers.addMarker(marker);	

								<%
								stopdatetime="-";
								stoplat=0;stoplon=0;
							//} //if(mins >= minstopdur)
						}
					}
				}
				STcount++;
				}
			
		%>
		
		document.getElementById("st").innerHTML= <%=STcount%>
		<% 
		try{
		  /*      sql5 = "Select "+
	               "VehRegNo, OffTimeFrom, OffTimeTo, FromLatitude, FromLongitude, FromLocation, Duration, Distance "+
	               "FROM "+
	               "db_gps.t_disconnectionData "+
	               "WHERE "+
	               "OffTimeFrom >= '"+date1+"'  "+
	               "AND OffTimeTo<='"+date2+"' and Reason = 'Disconnection'"+
	               "AND vehicleCode = '"+vehcode+"' "+
	               "ORDER BY OffTimeFrom"; */
	               sql5="select VehRegNo, OffTimeFrom, OffTimeTo, FromLatitude, FromLongitude, FromLocation,time_to_sec(Duration) Duration, Distance  from db_gps.t_disconnectionData where vehicleCode='"+vehcode+"' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30:00' and OffTimeFrom between '"+date1+"' and  '"+date2+"'";
		       // System.out.println(sql5);
		       ResultSet rstdisconn = stDisconn.executeQuery(sql5);
		       
		       while (rstdisconn.next())
		       {
		    	   
		    	   String dura = rstdisconn.getString("Duration");
					
					int sec = Integer.parseInt(dura);//
					java.util.Date	d = new java.util.Date(sec * 1000L);
							SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss"); // HH for 0-23
							df.setTimeZone(TimeZone.getTimeZone("GMT"));
							String duration = df.format(d);
		    	   
		    	   label1="<b>Disconnection Location</b><br> <br><b>VehRegNo : </b>"+vehRegNo+"<br><b>From Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(rstdisconn.getDate("OffTimeFrom"))+"<br><b>To Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(rstdisconn.getDate("OffTimeTo"))+"<br><b> Duration : </b>" +rstdisconn.getString("Duration")+"<br><b> Distance : </b>" +rstdisconn.getInt("Distance")+"<br><b>Location : </b>"+rstdisconn.getString("FromLocation");
		     %> 
					var marker = createMarker4("<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>",'Disconn',<%= rstdisconn.getDouble("FromLatitude")%>,<%= rstdisconn.getDouble("FromLongitude")%>);
					markers.addMarker(marker);	
			<%
		    	   
		    	   DisconnCount++;	
		       }
			
		%>
		document.getElementById("Disconn").innerHTML=<%=DisconnCount%>;
	<%


		
		}
		catch(Exception e)
		{
			e.printStackTrace();
			// System.out.println("Exception ------767687----> "+   e);
		}
				}
			
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
   		 %>

  	  document.getElementById("side_bar").innerHTML = side_bar_html;
     // }

	    //  initialize();
  //	alert(map1.getZoom());
			<%
			/*lon = 77.768553;
			lat = 23.402765;
			location = "vcbnvhcdgcfnbxn";
			String dt = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse("2012-08-22"));
			String html1="<b>Last location:</b><br>"+location+"<br><b>Date Time : </b>"+dt+" 15:19:00";*/
			%>
		//	var point1 = 1;
		//	createMarker(point1,"<div class='bodyText'></%=html1%></div>","<div class='bodyText'></%=html1%></div>","AC",</%=lat%>,</%=lon%>);
    }
    catch(e)
    {
        alert(e);
    }

  


    
    function loadKML(url){
        try
        {
  	  map1.addLayer(new OpenLayers.Layer.GML(url,url, 
  	          {
  	           format: OpenLayers.Format.KML, 
  	           formatOptions: {
  	             extractStyles: true 
  	           }
  	          }));
        }
        catch(e)
        {
           // alert(e);
        }
    }
    
   
    </script>
    
   
    
    <!-- <div id="map" style=" height:600px;position: relative"></div>
	<div align="right"><font face="Arial" color="black">Copyright &copy; 2008-2015 by Transworld Technologies Ltd. All Rights Reserved.</font></div>  -->
	<table border="0" width="100%" align="center" style="padding-bottom: 56px" >
<tr><td  bgcolor="#0B2161" >
<ui><li><center><font color="white" >Copyright &copy; 2008-2015 by Transworld Technologies Ltd. All Rights Reserved.</font></center></li></ui>
</td></tr>
</table>
	<%-- <jsp:include page="footernew.jsp"/> --%>
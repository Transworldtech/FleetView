 <%@ include file="headernew.jsp" %>
 <%@ page import="kml.KML1" %>
<%
classes fleetview=new classes(); 
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

%>

<%@page import="com.fleetview.beans.classes"%>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    </head>
<script language="javascript">

function Validate()
{ 
    
	if(document.getElementById("data").value=="") 
	{
		alert("Please Select The from date.");
		return false;
	}
	if(document.getElementById("data1").value =="")
  	{
		alert("please select To Date");
		return false;
  	}  		
		return datevalidate();
	return true;
	
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}

	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

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
		alert("From date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}
</script>


<script src="http://maps.google.com/maps?file=api&amp;v=3&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<!--<script src="http://maps.google.com/maps?api/js?sensor=false" type="text/javascript"></script>-->
<!-- you can use tables or divs for the overall layout -->
<!-- changes 6th sep 2010-->
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
                	//alert(reslt);
                	var rsnew = reslt.split("$");
                	document.getElementById("side_bar").innerHTML=rsnew[0];
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
/*
if(xx==5)
{
ajaxRequest.open("GET", "hrst.jsp", true);
}*/
ajaxRequest.send(null); 
}
</script>
<!-- end of changes-->
<%! 
Connection conn,conn1,con;
Statement st,st1,st2,st3,st4,st5,stAC,stDisconn;
String htmlvis1,htmlvis2,sql,sql1,sql2,sql3,sql4,sql5,sqlware,data1,data2,vehcode,location,Stamp,label1,html1,html2,html11,html22,d1,d2,t1,t2,time1,time2,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String thedate="",thedate1="",startplace1="",endplace1="",thetime="",thetime1="",vehregno="",ownername="",lastlocation="",strtcode="",endcode="",startplace="",endplace="",enddate,sdate1,enddate1,stopdatetime, startdatetime,latStart="",longStart="",locationStart="",thedateStart="",thetimeStart="",firstlocation="-",location1="-";
String mydate1="",mydate2="";
String gpname="",transporter="",gpname1="",ownername1="";
double lat, lat1, lon, lon1,latw,longw,latw1,longw1,lat11,lon11;
float slatitude=0,slongitude=0,elatitude=0,elongitude=0;
int show,dist;
boolean flag1=false,flag2=false;
%>
<%
//System.out.println("ok i am here---1");
vehcode=request.getParameter("vehcode");
String tripid=request.getParameter("tripid");
String unitid=request.getParameter("tripid"); //unitid passed as tripid in unidentified units
String fromPage=request.getParameter("pg");
//System.out.println("From Page===>"+fromPage);

//System.out.println("ok i am here---->"+tripid);
//System.out.println("ok i am here----2");
data1=request.getParameter("data");
data2=request.getParameter("data1");
//System.out.println("data1--"+data1+" data2--"+data2);
try{
data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));
data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
System.out.println("data1-->"+data1+" data2-->"+data2);
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
ftime2=request.getParameter("ftime2");
ttime1=request.getParameter("ttime1");
ttime2=request.getParameter("ttime2");

time1=ftime1+":"+ftime2+":00";
time2=ttime1+":"+ttime2+":00";

// set the values in  session-----------------


session.setAttribute("hdate1",data1);
session.setAttribute("hdate2",data2);
session.setAttribute("fff",time1);
session.setAttribute("ttt",time2);
session.setAttribute("hvid",vehcode);

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
	System.out.println("====>error in connection");
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
		System.out.println("\n\n start place-->>"+startplace1);
		endplace1=rstrp.getString("EndPlace");
		System.out.println("\n\n end place-->>"+endplace1);
		strtcode=rstrp.getString("StartCode");
		endcode=rstrp.getString("EndCode");
		gpname=rstrp.getString("GPName");
		System.out.println("\n\n start code-->>"+strtcode);
		System.out.println("\n\n end code-->>"+endcode);
		transporter=rstrp.getString("OwnerName");
		
		
		
	}
	
	 sqltrp="select * from t_warehousedata where WareHouseCode='"+strtcode+"' AND Owner='"+transporter+"'";
	 rstrp=st.executeQuery(sqltrp);
	 System.out.println("\n\nwarehouse strt-->>"+sqltrp);
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
		 System.out.println("\n\n from warehouse lat strt-->>"+slatitude);
		 System.out.println("\n\n from warehouse long strt-->>"+slongitude);
	 }
	 else
	 {
		 String sqlc="select * from t_castrolroutes where StartCode='"+strtcode+"' AND Owner='"+gpname+"'";
			ResultSet rec=st.executeQuery(sqlc);
			 System.out.println("\n\ncastrolroutes strt-->>"+sqlc);
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
				 System.out.println("\n\n from castrolroutes lat strt-->>"+slatitude);
				 System.out.println("\n\n from castrolroutes long strt-->>"+slongitude);
			}
	 }
	 sqltrp="select * from t_warehousedata where WareHouseCode='"+endcode+"' AND Owner='"+transporter+"'";
	 System.out.println("\n\nwarehouse end-->>"+sqltrp);
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
		 System.out.println("\n\n from warehouse lat end-->>"+elatitude);
		 System.out.println("\n\n from warehouse long end-->>"+elongitude);
	
	 }
	 else
	 {
		 String sqlc="select * from t_castrolroutes where EndCode='"+endcode+"' AND Owner='"+gpname+"'";
			ResultSet rec=st.executeQuery(sqlc);
			 System.out.println("\n\ncastrolroutes end-->>"+sqlc);
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
			
			
				 System.out.println("\n\n from castrolroutes lat end-->>"+elatitude);
				 System.out.println("\n\n from castrolroutes long end-->>"+elongitude);
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
			<div align="left"><font size="3" >Report No: 1.10</font></div>
			<font  size="3" ><b>Journey On Map</b></font></td>
			</tr>
			<%
			if("0".equalsIgnoreCase(vehcode))
			{
				
			}//enf if
			else  if(!(tripid.equals("null") && null==tripid))
			{
				
			%>
			<tr>
			<td align="center"><h2><b>The Trip Report for Vehicle Reg. No.<%=vehreg %> From Date <%=mydate1 %> To <%=mydate2 %></b></h2></td>
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
 						<input type="hidden" id="vehcode" name="vehcode" size="12" value="<%= vehcode%>"/>
 						<input type="hidden" id ="tripid" name="tripid" size="12" value="<%=tripid%>"/>
 						<td align="left"><b>From&nbsp;&nbsp;</b>
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
			
			<tr><td class="hed" colspan="3"><img src="images/mm_20_green.png" align="left"> <div align="left">Last Location</div></td><!--<td colspan="2"><div id="lastloc11"></div></td>--></tr>
			<tr><td class="hed" colspan="3"><img src="images/mm_20_black.png" align="left"> <div align="left">Start Location </div></td><!--<td><div id="strtloc11"></div></td>--></tr>
		    
		    <%

		    if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)) && !("drivrating".equalsIgnoreCase(fromPage)))
		    {
		    if(flag1==true)
		    {
		    
		    %>
			<tr><td class="hed"><img src="images/mm_20_purple.png" align="left"><div align="left"> Trip Origin </div></td><td colspan="2"> <%=startplace1%></td></tr>
			<%}
		    else
		    {%>
		    <tr><td class="hed"><img src="images/mm_20_purple.png" align="left"> <div align="left">Trip Origin</div></td><td colspan="2">Not Geofenced</td></tr>
	    	<%}if(flag2==true)
		    { %>
			<tr><td class="hed"><img src="images/mm_20_brown.png" align="left"><div align="left"> Trip Destination </div></td><td colspan="2"> <%=endplace1%></td></tr>
			<%}
		    else
		    {%>
		     <tr><td class="hed"><img src="images/mm_20_brown.png" align="left"> <div align="left">Trip Destination </div></td><td colspan="2">Not Geofenced</td></tr>
			
			<% }
		    }
	    	if(!("0".equalsIgnoreCase(vehcode))){ %>
			<tr><td class="hed"><img src="images/mm_20_red.png" align="left"> <div align="left">Over Speed </div></td><td><div id="os"></div></td><td><a href="javascript:ajaxFunction(1)" >[Details]</a>
			
			<!--<a href="ViolationReport.jsp?para=OS" >[Details]</a>--></td></tr>
			<tr><td class="hed"><img src="images/mm_20_blue.png" align="left"><div align="left"> Rapid Accelaration</div> </td><td><div id="ra"></div></td><td><a href="javascript:ajaxFunction(2)">[Details]</a>
			
			<!--<a href="ViolationReport.jsp?para=RA">[Details]</a>--></td></tr>
			<tr><td class="hed"><img src="images/mm_20_yellow.png" align="left"><div align="left"> Rapid Decelaration </div></td><td><div id="rda"></div></td><td><a href="javascript:ajaxFunction(3)" >[Details]</a> 
			
			<!--<a href="ViolationReport.jsp?para=RDA" >[Details]</a>--> </td></tr>
			<tr><td class="hed"><img src="images/mm_20_white.png" align="left"><div align="left"> Stop Location</div> </td><td><div id="st"></div></td><td><a href='javascript:ajaxFunction(4);'>[Details]</a>
			
			<tr><td class="hed"><img src="images/mm_20_grey.png" align="left"><div align="left"> Disconnection Location </div></td><td><div id="Disconn"></div></td><td><a href="javascript:ajaxFunction(5);">[Details]</a>
			<%} %>
			<!--<a href="ViolationRep_Stop.jsp" >[Details]</a>--></td></tr>
			
			
			
		</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
				<div id="side_bar"  style="overflow:auto; height:390px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
	
<td>
<div id="map" style=" height:800px"></div>
       <!--<div id="map" style="width: 1150px; height: 650px"></div>-->
</td>
      </tr>  
</table>
    



    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>


    <script type="text/javascript"><!--
    //<![CDATA[

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

}catch(Exception e)
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


if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)) && !("drivrating".equalsIgnoreCase(fromPage)))
{
	String sqltrp="select * from t_startedjourney where TripID='"+tripid+"'";
	ResultSet rstrp=st.executeQuery(sqltrp);
	if(rstrp.next())
	{
		strtplace=rstrp.getString("StartPlace");
		endplace=rstrp.getString("EndPlace");
		strtcode=rstrp.getString("StartCode");
		endcode=rstrp.getString("EndCode");
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

   		var side_bar_html = "";
     	var side_bar_html1 = "";
      	var str;	
      	var gmarkers = [];
      	var gmarkerdis = [];
      	var htmls = [];
      	var htmldis = [];
      	var i = 0;dis=0;

		var gmarkerstop = [];
		var htmlstop = [];
		var stopcnt = 0;

		var gmarkerOS = [];
		var htmlOS = [];
		var OScnt = 0;

		var gmarkerRA = [];
		var htmlRA = [];
		var RAcnt = 0;

		var gmarkerRD = [];
		var htmlRD = [];
		var RDcnt = 0;

		var gmarkerDisconn = [];
		var htmlDisconn = [];
		var Disconncnt = 0;

      	
      	var degreesPerRadian = 180.0 / Math.PI;
      	var arrowIcon = new GIcon();
        arrowIcon.iconSize = new GSize(12,12);
        arrowIcon.shadowSize = new GSize(1,1);
        arrowIcon.iconAnchor = new GPoint(6,6);
        arrowIcon.infoWindowAnchor = new GPoint(0,0);
        //var dir="/home/shweta/Desktop/11634188xyz.kml";
      	var map = new GMap2(document.getElementById("map"));
      	
      	//var geoXml = new GGeoXml(dir); 
      
      	      	
      	
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
		if(stamp=="Disconn")
		{
			cIcon.image = 'images/mm_20_grey.png';
		}
		if(stamp=="TripEnd")
		{
			//alert("in end trip 1");
			cIcon.image = 'images/mm_20_brown.png';
			//alert("image taken");
		}
		if(stamp=="TripStart")
		{
			//alert("in end trip 1");
			cIcon.image = 'images/mm_20_purple.png';
			//alert("image taken");
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
        	GEvent.addListener(marker, "click", function() {
    		//map.setCenter(new GLatLng(lat,lon),12);
    		marker.openInfoWindowHtml(html);
    		        });	
	       
			gmarkers[i] = marker;
        	htmls[i] = html;

        	if(stamp=="OS")
    		{
        		gmarkerOS[OScnt] = marker;
    			htmlOS[OScnt] = html;
    			OScnt++;
    		}
    		if(stamp=="ST" || stamp=="SP")
    		{
    			gmarkerstop[stopcnt] = marker;
    			htmlstop[stopcnt] = html;
    			stopcnt++;
    			//alert(htmlstop[stopcnt]);
    		}
    		if(stamp=="AC")
    		{
    			gmarkerRA[RAcnt] = marker;
    			htmlRA[RAcnt] = html;
    			RAcnt++;
    		}
    		if(stamp=="DC")
    		{
    			gmarkerRD[RDcnt] = marker;
    			htmlRD[RDcnt] = html;
    			RDcnt++;
    		}
    		if(stamp=="Disconn")
    		{
    			gmarkerDisconn[Disconncnt] = marker;
    			htmlDisconn[Disconncnt] = html;
    			Disconncnt++;
    		}
        	//side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
        	i++;
     		
	       
	        map.setCenter(new GLatLng(lat,lon));
        	return marker;
      }
    //********************marker for start position**************
    function createMarker2(point,name,html,lat,lon){
				var cIcon = new GIcon();
				//we have to insert black img  here..... coz it is overlapping
					cIcon.image = 'images/mm_20_black.png';
				
			//	cIcon.shadow = 'images/mm_20_shadow.png';
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
	        	//side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" onmouseover="javascript:myclick('+i+','+lat+','+lon+');"><div class="bodyText">' + name + '</div></a><br>';
	        	i++;
	     		map.setCenter(new GLatLng(lat,lon));
	        	return marker;
		      }
//////////////////////////////////////////////////////////////
 //********************marker for last position**************
    function createMarker1(point,name,html1,lat,lon) {
    	var cIcon = new GIcon();
    	cIcon.image = 'images/mm_20_green.png';
    	cIcon.shadow = 'images/mm_20_shadow.png';
    	cIcon.iconSize = new GSize(12,20);
    	cIcon.shadowSize = new GSize(22, 20);
    	cIcon.iconAnchor = new GPoint(6, 20);
    	cIcon.infoWindowAnchor = new GPoint(5, 1);
    	markerOptions = { icon:cIcon};
    	var marker = new GMarker(point,markerOptions);
        GEvent.addListener(marker, "click", function() { 
    	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html1);
        }); 
      	//GEvent.addListener(marker, "mouseover", function() { 
    	//map.setCenter(new GLatLng(lat,lon),9);
       // marker.openInfoWindowHtml(html1);
       // }); 
     	//gmarkers[i] = marker;
       // htmls[i] = html1;
        //side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" title="">'+name+'</a><br>';
     	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
    	i++;
        return marker;
    }
    ////////////////////////////////////////////////////////////
    
    function createMarker_ware(point,name,html1,lat,lon) {
    	var cIcon = new GIcon();
    	cIcon.image = 'images/bp.png';
    //	cIcon.shadow = 'images/mm_20_shadow.png';
    	cIcon.iconSize = new GSize(12,20);
    //sssss	cIcon.shadowSize = new GSize(22, 20);
    	cIcon.iconAnchor = new GPoint(6, 20);
    	cIcon.infoWindowAnchor = new GPoint(5, 1);
    	markerOptions = { icon:cIcon};
    	var marker = new GMarker(point,markerOptions);
        GEvent.addListener(marker, "click", function() { 
    	map.setCenter(new GLatLng(lat,lon),9);
        marker.openInfoWindowHtml(html1);
        }); 
        GEvent.addListener(marker, "mouseover", function() {
			//map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html1);
	        });
        return marker;
    }
   
 
    
    //**************************************************************
        
function zoomtoloc(i,lat,lon) 
 {
	 //alert(i+","+lat+","+lon);
	 
	 try{
		 map.setCenter(new GLatLng(lat,lon),15);
			gmarkerstop[i].openInfoWindowHtml(htmlstop[i]);
	/*if(stamp=="OS")
	{
		//cIcon.image = 'images/mm_20_red.png';
	}
	if(stamp=="ST" || stamp=="SP")
	{
		map.setCenter(new GLatLng(lat,lon),15);
		gmarkerstop[i].openInfoWindowHtml(htmlstop);
	}
	if(stamp=="AC")
	{
		//cIcon.image = 'images/mm_20_blue.png';
	}
	if(stamp=="DC")
	{
		//cIcon.image = 'images/mm_20_yellow.png';
	}*/
	 }
	 catch(e){
		// alert(e);
	 }
	   
  }

function zoomtolocOS(i,lat,lon) 
{
	//alert(lat);
	 try{
		 map.setCenter(new GLatLng(lat,lon),15);
			gmarkerOS[i].openInfoWindowHtml(htmlOS[i]);
	 }
	 catch(e){
		// alert(e);
	 }
	   
 }

function zoomtolocDiscon(i,lat,lon) 
{
	//alert(lat);
	 try{
		 map.setCenter(new GLatLng(lat,lon),15);
		 gmarkerDisconn[i].openInfoWindowHtml(htmlDisconn[i]);
	 }
	 catch(e){
		// alert(e);
	 }
	   
 }

function zoomtolocRA(i,lat,lon) 
{
	//alert(lat);
	 try{
		 map.setCenter(new GLatLng(lat,lon),15);
		 gmarkerRA[i].openInfoWindowHtml(htmlRA[i]);
	 }
	 catch(e){
		// alert(e);
	 }
	   
 }

function zoomtolocRD(i,lat,lon) 
{
	//alert(lat);
	 try{
		 map.setCenter(new GLatLng(lat,lon),15);
		 gmarkerRD[i].openInfoWindowHtml(htmlRD[i]);
	 }
	 catch(e){
		// alert(e);
	 }
	   
 }
    

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
{ 
	if(fwUser.equalsIgnoreCase("shramik"))
	{
		  
	        StringBuffer polygonSql = new StringBuffer("");

	        while(rs2.next())
	        {
	                    savedCoordiantes =(String)rs2.getString("PolygonCoordinates");
	                    if(savedCoordiantes !=null && !savedCoordiantes.equals(""))
	                    {
	                                StringTokenizer tokenizer = new StringTokenizer(savedCoordiantes,",");
	                                polygonSql.append(" \n");
	                                polygonSql.append("GEvent.addListener(map, 'tilesloaded', function(overlay,latlng) {");
	                                polygonSql.append("var lonOffset = 0.01;");
	                                polygonSql.append("var polygon = new GPolygon([new GLatLng(");
	                                int cntr=1;
	                                int tokens = tokenizer.countTokens();
	                                while (tokenizer.hasMoreElements())
	                                {
	                                    String object = (String) tokenizer.nextElement();
	                                    if(cntr%2 == 0)
	                                    {
	                                        //System.out.println("CNTR:::"+cntr);
	                                        polygonSql.append(object +")");
	                                        if(cntr != tokens)
	                                            polygonSql.append(", new GLatLng(");
	                                    }
	                                    else
	                                        polygonSql.append(object +",");
	                                    cntr++;
	                                }
	                                polygonSql.append("], '#f33f00', 5, 0, '#ff0000', 0.2)");
	                                polygonSql.append(" \n map.addOverlay(polygon);});");
	                                polygonSql.append(" \n");
	                }
	        }
	        double lat1=0.00,lon1=0.00;
	        String lat11="0.00",lon11="0.00";
	        while(rs22.next())
	    	{
	    		wareHouseCode=rs22.getString("WareHouseCode");
	    		wareHouse=rs22.getString("WareHouse");
	    		owner=rs22.getString("Owner");
	    		lat11=rs22.getString("Latitude");
	    		lon11=rs22.getString("Longitude");
	    		wtype=rs22.getString("WType");
	    		PolygonCoordinates=rs22.getString("PolygonCoordinates");
	    		 if(PolygonCoordinates !=null && !PolygonCoordinates.equals(""))
	             {
	           StringTokenizer tokenizer = new StringTokenizer(PolygonCoordinates,",");                        
	           int cntr=1;
	           int tokens = tokenizer.countTokens();
	           while (tokenizer.hasMoreElements()) 
	            {
	        	   lat11 = (String) tokenizer.nextElement();                                                      
	        	   lon11= (String) tokenizer.nextElement();
		    		break;
	        	 }  
	         }
	    		html1="<b>GeoFence</b><br>wareHouse-"+wareHouse+" owner-"+owner;
	    %>
	    		//side_bar_html += '<input type="radio" id="pra" name="pra" value="< %=wareHouse%>" onclick="get_radio_value(this,\'< %=wareHouseCode%>\',\'< %=wtype%>\')">';
	     		var point = new GLatLng(<%= lat11%>,<%= lon11%>);
	    		var marker = createMarker1(point,"<%=wareHouse%>","<div class='bodyText'><%=html1%></div>",<%= lat11%>,<%= lon11%>);
	    		map.addOverlay(marker);
	    <%
	    	} 
	    %>
	    <%=polygonSql%>
			       
<%
	}

	
	String stamp;
	
	if("0".equalsIgnoreCase(vehcode)){
		%>
		side_bar_html +="<div class='bodyText'><b>UnitId:<font color='red'> <%=unitid%></font> <br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> <%=time1%></font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> <%=time2%></font></b>";
		<%
	}
	else{
		sql="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
		
		ResultSet rstx=st.executeQuery(sql);
		if(rstx.next())
		{
			//System.out.println(sql);
			vehRegNo=rstx.getString("VehicleRegNumber");
		Format NewFormatter3 = new SimpleDateFormat("dd-MMM-yy HH:mm:ss");
		if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode)))
		{
		%>
			side_bar_html +="<div class='bodyText'><b>Trip ID : <font color='red'><%=tripid%></font></b><br><b>Vehicle Reg.No.:<font color='red'> <%=rstx.getString("VehicleRegNumber")%></font> <br>Transporter : <font color='red'><%=rstx.getString("OwnerName")%></font><br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> <%=time1%></font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> <%=time2%></font></b>";
		<%
		}
		else
		{
			%>
			side_bar_html +="<div class='bodyText'><b>Vehicle Reg.No.:<font color='red'> <%=rstx.getString("VehicleRegNumber")%></font> <br>Transporter : <font color='red'><%=rstx.getString("OwnerName")%></font><br>Journey Start date : <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> <%=time1%></font><br>Journey End date :  <font color='red'><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%> <%=time2%></font></b>";
			<%
		}
		
	
		session.setAttribute("hvrno",rstx.getString("VehicleRegNumber"));
		}
	}
		//sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+"' and TheFiledTextFileName ='SI' and speed >0";
		if("0".equalsIgnoreCase(vehcode)){
			sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist,TheFiledTextFileName as stamp from t_veh"+vehcode+" where unitid= '"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName IN ('SI','OF')";
		}
		else{
			sql="SELECT Min(Distance) as startdist,Max(Distance) as enddist,TheFiledTextFileName as stamp from t_veh"+vehcode+" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName IN ('SI','OF')";
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
	
	
	
	//code to draw the first loc
	/*---------------------------------change:- TheFiledTextFileName IN(
		 elatitude=rstrp.getFloat("Latitude");
		 elongitude=rstrp.getFloat("Longitude");
		 if(slatitude==0.0 && slongitude==0.0)
		 {
		 flag2=false;
		 }
		 else
			 {flag2=true;}
		 //flag2=true;
	//	 System.out.println("\n\n from warehouse lat end-->>"+elatitude);
	//	 System.out.println("\n\n from warehouse long end-->>"+elongitude);
	
	 'SI','OF') removed from query---------------------------*/
	int OScount=0,ACcount=0,DCcount=0,STcount=0,DisconnCount=0;
	String file="";
	String color="ffFA8B0C"; //blue
	HashMap<String, String> coordinateMap = null;
    HashMap<String, String> coordinateMapStart = null;
    HashMap<String, String> coordinateMapEnd = null;
    List<HashMap<String, String>> coordinateList = null;
   // boolean flag1;
    coordinateList=new ArrayList<HashMap<String, String>>();
    String sql12="";
    Double startdist=0.0,enddist=0.0;
    if("0".equalsIgnoreCase(vehcode))
    	sql12="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime asc";
    else
    	sql12="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime asc";
		
	System.out.println("sql start loc====>"+sql12);
	ResultSet rst12=st.executeQuery(sql12);
	if(rst12.next())
	{
		startdist=rst12.getDouble("Distance");
        coordinateMapStart =  new java.util.HashMap<String, String>();
        coordinateMapStart.put("name",rst12.getString("TheFieldSubject"));
        coordinateMapStart.put("desc", rst12.getString("TheFieldSubject"));
        coordinateMapStart.put("lat",rst12.getString("LatinDec")); 
        coordinateMapStart.put("longi",rst12.getString("LonginDec"));  
    //   	System.out.println("MapStart----------"+coordinateMapStart.get("lat")+","+coordinateMapStart.get("longi"));
		
		lat=rst12.getDouble("LatinDec");
		lon=rst12.getDouble("LonginDec");
		
		System.out.println("\n\n start loc lat-->><"+lat);
		System.out.println("\n\n start loc lon-->><"+lon);
		
		location=rst12.getString("TheFieldSubject");
		System.out.println(lat+","+lon);
		
		String dt1 = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst12.getString("TheFieldDataDate")));
		html2="<b>Start location:</b><br>"+location+"<br><b>Date Time : </b>"+dt1+" " +rst12.getString("TheFieldDataTime");
	%>
	//document.getElementById("strtloc11").innerHTML=< %=location%>;
	var marker1 = createMarker2(new GLatLng(<%= rst12.getString("LatinDec")%>,<%= rst12.getString("LonginDec")%>),"<div class='bodyText'><%= html2%></div>","<div class='bodyText'><%= html2%></div>",<%= lat%>,<%= lon%>);
	map.addOverlay(marker1);
	<%}
	/******************************  check start loc is geofenced ************************/
			if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode))  && !("drivrating".equalsIgnoreCase(fromPage)) && ("Castrol".equalsIgnoreCase(gpname)))
			{
				
				System.out.println("\n\n GPName-->>"+gpname);
				String sqlware="select * from t_warehousedata where WareHouseCode='"+strtcode+"'";
			//	System.out.println("sqlware--"+sqlware);
				ResultSet resw=st5.executeQuery(sqlware);
				if(resw.next())
				{
					latw=resw.getDouble("Latitude");
					longw=resw.getDouble("Longitude");
		
					html11="<b>Geofenced Start location:</b><br>"+location;
		
		%>
					var pointw = new GLatLng(<%=latw%>,<%=longw%>);
					var markerw = createMarker_ware(pointw,"<%=resw.getString("WareHouse")%>","<div class='bodyText'><%=html2%></div>",<%=latw%>,<%=longw%>);
					map.addOverlay(markerw);
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
				var pointw = new GLatLng(<%=lat%>,<%=lon%>);
				var markerw = createMarker_ware(pointw,"<%=location%>","<div class='bodyText'><%=html11%></div>",<%=lat%>,<%=lon%>);
				map.addOverlay(markerw);
			<%	}
			}//if tripid!=null end
			else
			{
				
			}
	////////////////////////////////////////////////////////////////////////////////////////
	
	//code to draw line
//	int record=1;
	/*---------------------------------change:-TheFiledTextFileName ='SI' removed from query---------------------------*/
	if("0".equalsIgnoreCase(vehcode))
		 sql1="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and  speed >0 and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime asc";
    else
		sql1="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and speed >0 and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime asc";

	ResultSet rst=st.executeQuery(sql1);
	while(rst.next())
	{ /**********record is added for- if no data then it will not come in while loop and willnot get ++ then not to show start point*************/
		
		 coordinateMap =  new java.util.HashMap<String, String>();
         coordinateMap.put("name",rst.getString("TheFieldSubject"));
         coordinateMap.put("desc", rst.getString("TheFieldSubject"));
         coordinateMap.put("lat",rst.getString("LatinDec")); 
         coordinateMap.put("longi",rst.getString("LonginDec"));                         
         coordinateList.add(coordinateMap);
   //      System.out.println("Coordlist----------"+coordinateMap.get("lat")+","+coordinateMap.get("longi"));

	%> 

	<%

	}//while to drow the line.
	
	/***********COde for find lasst location***************/
	
	String sql11="";
	/*---------------------------------change:- TheFiledTextFileName IN('SI','OF') removed from query---------------------------*/
	if("0".equalsIgnoreCase(vehcode))
		sql11="select * from t_veh"+ vehcode +" where unitid='"+unitid+"' and TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime desc";
    else
		sql11="select * from t_veh"+ vehcode +" where TheFieldDataDateTime >='"+data1+" "+time1+"' and TheFieldDataDateTime <='"+data2+" "+time2+"' and TheFiledTextFileName NOT IN('AC','DC','OS') order by TheFieldDataDateTime desc";
	System.out.println("sql last loc====>"+sql11);
	ResultSet rst11=st.executeQuery(sql11);
	if(rst11.next())
	{
		//System.out.println("1038 Hii");
		enddist=rst11.getDouble("Distance");
        coordinateMapEnd =  new java.util.HashMap<String, String>();
        coordinateMapEnd.put("name",rst11.getString("TheFieldSubject"));
        coordinateMapEnd.put("desc", rst11.getString("TheFieldSubject"));
        coordinateMapEnd.put("lat",rst11.getString("LatinDec")); 
        coordinateMapEnd.put("longi",rst11.getString("LonginDec"));   
     //   System.out.println("MapEnd----------"+coordinateMapEnd.get("lat")+","+coordinateMapEnd.get("longi"));
		
		lat=rst11.getDouble("LatinDec");
		lon=rst11.getDouble("LonginDec");
		System.out.println("\n lat for last->>"+lat);
		System.out.println("\n long for last->>"+lon);
		location=rst11.getString("TheFieldSubject");
		
		String dt = new SimpleDateFormat("dd-MM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst11.getString("TheFieldDataDate")));
		html1="<b>Last location:</b><br>"+location+"<br><b>Date Time : </b>"+dt+" " +rst11.getString("TheFieldDataTime");
	 
		//System.out.println("1055 Hii");
		%>
		
		//document.getElementById("lastloc11").innerHTML=< %= location%>;
			var point1 = new GLatLng(<%= rst11.getString("LatinDec")%>,<%= rst11.getString("LonginDec")%>);
			var marker = createMarker(point1,"<div class='bodyText'><%= html1%></div>","<div class='bodyText'><%= html1%></div>","SI",<%= rst11.getString("LatinDec")%>,<%= rst11.getString("LonginDec")%>);
    		map.addOverlay(marker);
   <%
   //System.out.println("1063 Hii");
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
			System.out.println(latw1+","+longw1);
			html22="<b>Geofenced Last location:</b><br>"+location;
		
		%>
		var pointw1 = new GLatLng(<%=latw1%>,<%=longw1%>);
		var markerw1 = createMarker_ware(pointw1,"<%=resw1.getString("WareHouse")%>","<div class='bodyText'><%=html22%></div>",<%=latw1%>,<%=longw1%>);
		map.addOverlay(markerw1);
		
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
		var pointw1 = new GLatLng(<%=lat%>,<%=lon%>);
		var markerw1 = createMarker_ware(pointw1,"<%=location%>","<div class='bodyText'><%=html22%></div>",<%=lat%>,<%=lon%>);
		map.addOverlay(markerw1);
		<%}
		}
	}
	else
	{
		
	}
	
	// .......................
	
	/******************************  check start loc of trip is geofenced ************************/
		//	if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode))  && !("drivrating".equalsIgnoreCase(fromPage)))
		 if(flag1==true)
		    {
		//System.out.println("\n\n in start trip ");
					htmlvis1="<b>Geofenced Trip Start location:</b><br>"+startplace1;
				//	System.out.println("\n\n vishal start lat-->>"+slatitude);
				//	System.out.println("\n\n vishal start long-->>"+slongitude);
		
		%>


                     var point1 = new GLatLng(<%=slatitude%>,<%=slongitude%>);
                     var marker = createMarker(point1,"<div class='bodyText' align='left'><%=startplace1%></div>","<div class='bodyText' align='left'><%=htmlvis1%></div>",'TripStart','<%=slatitude%>','<%=slongitude%>');
                     map.addOverlay(marker);

		
								
		<%		}//warehouse if end
			/*	else
				{
					String sqlc="select * from t_castrolroutes where StartCode='"+strtcode+"'";
					ResultSet rec=st.executeQuery(sqlc);
					if(rec.next())
					{
						html11="<b>Geofenced Start location:</b><br>"+location;
						
					}}
				
				
			}//if tripid!=null end
			*/
			
	////////////////////////////////////////////////////////////////////////////////////////
	
// .......................
	
	/******************************  check end loc of trip is geofenced ************************/
		//	if(!(tripid.equals("null")) && !("0".equalsIgnoreCase(vehcode))  && !("drivrating".equalsIgnoreCase(fromPage)))
		 if(flag2==true)
		    {
			// System.out.println("\n\n in end trip ");
					htmlvis2="<b>Geofenced Trip End location:</b><br>"+endplace1;
				//	System.out.println("\n lat for trip end->>"+elatitude);
				//	System.out.println("\n long for trip end->>"+elongitude);
					
		
		%>

		          var point1 = new GLatLng(<%=elatitude%>,<%=elongitude%>);
		          var marker = createMarker(point1,"<div class='bodyText' align='left'><%= endplace1%></div>","<div class='bodyText' align='left'><%=htmlvis2%></div>",'TripEnd','<%=elatitude%>','<%=elongitude%>');
	               map.addOverlay(marker);

		
					
		<%		}//warehouse if end
			/*	else
				{
					String sqlc="select * from t_castrolroutes where StartCode='"+strtcode+"'";
					ResultSet rec=st.executeQuery(sqlc);
					if(rec.next())
					{
						html11="<b>Geofenced Start location:</b><br>"+location;
						
					}}
				
				
			}//if tripid!=null end
			*/
			
	////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	 
	////////////////////////////////////////////////////////////////////////////////////////
	
   /*-----------------------------generate kml----------------------------*/
	String dir=request.getRealPath("/");
 //   System.out.println("KML path===========>");

	if(tripid==null||tripid.equals("null"))
	{
		tripid=vehcode;
	}
	else if(tripid.equals("''"))
	{
		tripid=vehcode;
	}
	else if("0".equalsIgnoreCase(vehcode)){
		tripid=vehcode;
	}
	
	dir=dir+"KML/"+"kml_"+tripid+".kml";		//for creating kml file on server
//	dir="/home/mahesh/Desktop/kml_"+tripid+".kml";	//to create kml file on localhost

	//System.out.println("dir======>"+dir);
	KML1 kml=new KML1();
	//System.out.println(coordinateList);
	flag1=kml.generateKMLFORLINE(coordinateList,dir,coordinateMapStart,coordinateMapEnd,color);
	//System.out.println("KML===========>"+dir);
   %>
   			//GGeoXml caches KML files at Google's servers for some time. 
   			//You can avoid that by applying some cache-busting dummy parameter to the URL you specify.
   			//so the updated kml file loads on the map 
		//	var geoXml = new GGeoXml("http://myfleetview.com/FleetView/KML/kml_"+tripid+".kml?date="+new Date().getTime());
		
			var filename="<%=tripid%>";
			var frmPage="<%=fromPage%>";
			//alert(frmPage);
			if(frmPage=="debrif" || frmPage=="brief")
			{
				//System.out.println("all jrm load");
			//	alert("all jrm load");
			//	var alljrmroutes = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/AllJRMkml.kml");
			//	map.addOverlay(alljrmroutes);
				var url="http://myfleetview.com/FleetView/KML/kml_"+filename+".kml?date="+new Date().getTime();
				var geoXml = new GGeoXml(url, function() {
					   // alert("Loaded: " + geoXml.hasLoaded());
					  	if (geoXml.loadedCorrectly()) {
					  		geoXml.gotoDefaultViewport(map);
					    }else {
					      // alert("Not Load Properly");
					    }
						});
			/*	var gx = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTJohnDeeretoRamwadi.kml");
				map.addOverlay(gx);
				var gx2 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTPalaspetoJNPT.kml");
				map.addOverlay(gx2);
				var gx4 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTShedungAsudgaon.kml");
				map.addOverlay(gx4);	
				var gx6 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/RTSILVASSAToBhilad.kml");
				map.addOverlay(gx6);
				var gx7 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Kolkata-Guwahati.kml");
				map.addOverlay(gx7);
				var gx8 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Hydrabad.kml");
				map.addOverlay(gx8);
				var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
				map.addOverlay(gx9);
				var gx10 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Mumbai-Chennai.kml");
				map.addOverlay(gx10);
				var gx11 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Banglore.kml");
				map.addOverlay(gx11);
				var gx12 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/PatalgangaSilvasa1.kml");
				map.addOverlay(gx12);
				var gx13 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Baragora-Jamshedpur.kml");
				map.addOverlay(gx13);
				var gx14 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Paharpur-Jungalpur.kml");
				map.addOverlay(gx14);
				var gx15 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/BhivandiToJohndere.kml");
				map.addOverlay(gx15);
				var gx16 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Delhi-Rajpua.kml");
				map.addOverlay(gx16);
				var gx17 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Rajpua-Parwanoo.kml");
				map.addOverlay(gx17);
				var gx18 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Cahndigad-Rajpua.kml");*/
				map.addOverlay(gx18);
				var gx19 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/tankerwest.kml");
				map.addOverlay(gx19);
				var gx20 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/tankerEast.kml");
				map.addOverlay(gx20);
			//var gx9 = new GGeoXml("http://myfleetview.com/FleetView/KMLJRM/Patalganga-Delhi.kml");
//				map.addOverlay(gx9);
				var url="http://myfleetview.com/FleetView-spring/KML/kml_"+filename+".kml?date="+new Date().getTime();
				var geoXml = new GGeoXml(url);
				map.addOverlay(geoXml);
			}
			else{
			//alert(filename);
			/*	var gx = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTJohnDeeretoRamwadi.kml");
				map.addOverlay(gx);
				var gx2 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTPalaspetoJNPT.kml");
				map.addOverlay(gx2);
				var gx4 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTShedungAsudgaon.kml");
				map.addOverlay(gx4);	
				var gx6 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/RTSILVASSAToBhilad.kml");
				map.addOverlay(gx6);
				var gx7 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Kolkata-Guwahati.kml");
				map.addOverlay(gx7);
				var gx8 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Patalganga-Hydrabad.kml");
				map.addOverlay(gx8);
				var gx9 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Patalganga-Delhi.kml");
				map.addOverlay(gx9);
				var gx10 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Mumbai-Chennai.kml");
				map.addOverlay(gx10);
				var gx11 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Patalganga-Banglore.kml");
				map.addOverlay(gx11);
				var gx12 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/PatalgangaSilvasa1.kml");
				map.addOverlay(gx12);
				var gx13 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Baragora-Jamshedpur.kml");
				map.addOverlay(gx13);
				var gx14 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Paharpur-Jungalpur.kml");
				map.addOverlay(gx14);
				var gx15 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/BhivandiToJohndere.kml");
				map.addOverlay(gx15);
				var gx16 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Delhi-Rajpua.kml");
				map.addOverlay(gx16);
				var gx17 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Rajpua-Parwanoo.kml");
				map.addOverlay(gx17);
				var gx18 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/Cahndigad-Rajpua.kml");
				map.addOverlay(gx18);*/
				var gx19 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/tankerwest.kml");
				map.addOverlay(gx19);
				var gx20 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/tankerEast.kml");
				map.addOverlay(gx20);
				var gx21 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/G2012-04-08-11-35-31.kml");
				map.addOverlay(gx21);
				var gx22 = new GGeoXml("http://myfleetview.com/FleetView-spring/KMLJRM/G2012-04-08-13-40-30.kml");
				map.addOverlay(gx22);
				
				
		/*	var url="http://myfleetview.com/FleetView-spring/KML/kml_"+filename+".kml?date="+new Date().getTime();
			var geoXml = new GGeoXml(url, function() {
		   // alert("Loaded: " + geoXml.hasLoaded());
		  	if (geoXml.loadedCorrectly()) {
		  		geoXml.gotoDefaultViewport(map);
		    }else {
		      // alert("Not Load Properly");
		    }
			});
			
			map.addOverlay(geoXml);*/
			//alert("map");	
			}
			
	<%
		if(!("0".equalsIgnoreCase(vehcode))){
			System.out.println("1251 Hii");
			String date1=data1+" "+time1;
			String date2=data2+" "+time2;
			ResultSet rstos=fleetview.getOSforDateRange(date1,date2,vehcode);
			while(rstos.next())
			{
					label1="<b>OverSpeed</b><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstos.getDate("FromDate"))+" "+rstos.getString("FromTime")+"<br><b>Speed : </b>" +rstos.getString("Speed")+"(kmph)<br><b>Duration : </b>" + rstos.getString("Distance") + " Sec.<br><b>Location : </b>"+rstos.getString("TheFieldSubject");
					%> 
			      	var point1 = new GLatLng(<%= rstos.getDouble("LatinDec")%>,<%= rstos.getDouble("LonginDec")%>);
					var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","OS",<%= rstos.getDouble("LatinDec")%>,<%= rstos.getDouble("LonginDec")%>);
			     	map.addOverlay(marker);
					<%
					OScount++;
			}
	%>
			document.getElementById("os").innerHTML=<%= OScount%>;
		
	<%
			//String sqlRA="SELECT * FROM t_veh"+vehcode+"_ra where concat(TheDate,' ',TheTime)>='"+date1+"' and  concat(TheDate,' ',TheTime)<='"+date2+"' order by TheDate desc,TheTime desc";
		//	ResultSet rstac=stAC.executeQuery(sqlRA);
			ResultSet rstac=fleetview.getACforDateRange(date1,date2,vehcode);
			while(rstac.next())
			{
				label1="<b>Rapid Acceleration</b><br><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstac.getDate("TheFieldDataDate"))+" "+rstac.getString("TheFieldDataTime")+"<br><b> Speed : </b>" +rstac.getString("Distance")+" <b>to</b> " + rstac.getString("FromSpeed")+"(kmph)<br><b>Location : </b>"+rstac.getString("TheFieldSubject");
	%> 
			var point1 = new GLatLng(<%= rstac.getDouble("LatinDec")%>,<%= rstac.getDouble("LonginDec")%>);
			var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","AC",<%= rstac.getDouble("LatinDec")%>,<%= rstac.getDouble("LonginDec")%>);
			map.addOverlay(marker);
	<%
			ACcount++;
			}
			stAC.close();
	%>	
			document.getElementById("ra").innerHTML=<%= ACcount%>;
				
	<%
		//	String sqlRD="SELECT * FROM t_veh"+ vehcode+"_rd where concat(TheDate,' ',TheTime)>='"+ date1+"' and  concat(TheDate,' ',TheTime)<='"+ date2+"' order by TheDate desc,TheTime desc";
		//	ResultSet rstdc=stAC.executeQuery(sqlRD);
			ResultSet rstdc=fleetview.getDCforDateRange(date1,date2,vehcode);
			while(rstdc.next())
			{
				label1="<b>Rapid Deceleration</b><br> <br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstdc.getDate("TheFieldDataDate"))+" "+rstdc.getString("TheFieldDataTime")+"<br><b> Speed : </b>" +rstdc.getString("FromSpeed")+" <b>to</b> " + rstdc.getString("ToSpeed")+"(kmph)<br><b>Location : </b>"+rstdc.getString("TheFieldSubject");
	%> 
			var point1 = new GLatLng(<%= rstdc.getDouble("LatinDec")%>,<%= rstdc.getDouble("LonginDec")%>);
			var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>","DC",<%= rstdc.getDouble("LatinDec")%>,<%= rstdc.getDouble("LonginDec")%>);
			map.addOverlay(marker);
	<%
			DCcount++;
					
			}
	%>
		document.getElementById("rda").innerHTML=<%= DCcount%>;
		
		/******************code for stops***************/
	<%
			String stopdatetime="-",startdatetime="-",stopdatetime1="-";
		double stoplat=0,stoplon=0;
					sql="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+data1+" "+time1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+data2+" "+time2+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
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
								stopdatetime1=new SimpleDateFormat("dd-MMM-yyyy").format(rstst.getDate("TheFieldDataDate"))+"  "+rstst.getString("TheFieldDataTime");
								stoplat=rstst.getDouble("LatinDec");
								stoplon=rstst.getDouble("LonginDec");
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
									label1="<b>Stop Location</b><br><br><b>VehRegNo : </b>"+vehRegNo+"<br><b>Stop Date Time : </b> "+stopdatetime1+"<br><b>Start Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy").format(rstst.getDate("TheFieldDataDate"))+"  "+rstst.getString("TheFieldDataTime")+"<br><b>Stoppage duration : </b> "+hrs+"hrs "+min+"min  <br><b>Location : </b>"+rstst.getString("TheFieldSubject");
									STcount++;
									%> 

										var point1 = new GLatLng(<%=stoplat%>,<%=stoplon%>);
										var marker = createMarker(point1,"<div class='bodyText' align='left'><%= label1%></div>","<div class='bodyText' align='left'><%=label1%></div>",'ST','<%=stoplat%>','<%=stoplon%>');
									    map.addOverlay(marker);

									<%
									stopdatetime="-";
									stoplat=0;stoplon=0;
								}
							}
						}
					}
			%>

			document.getElementById("st").innerHTML= <%=STcount%>
			<% 
			try{
		       sql5 = "Select "+
	                  "VehRegNo, OffTimeFrom, OffTimeTo, FromLatitude, FromLongitude, FromLocation, Duration, Distance "+
	                  "FROM "+
	                  "db_gps.t_disconnectionData "+
	                  "WHERE "+
	                  "OffTimeFrom >= '"+date1+"'  "+
	                  "AND OffTimeTo<='"+date2+"' and Reason = 'Disconnection'"+
	                  "AND vehicleCode = '"+vehcode+"' "+
	                  "ORDER BY OffTimeFrom";
		       System.out.println(sql5);
		       ResultSet rstdisconn = stDisconn.executeQuery(sql5);
		       
		       while (rstdisconn.next())
		       {
		    	   label1="<b>Disconnection Location</b><br> <br><b>VehRegNo : </b>"+vehRegNo+"<br><b>From Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(rstdisconn.getDate("OffTimeFrom"))+"<br><b>To Date Time : </b>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(rstdisconn.getDate("OffTimeTo"))+"<br><b> Duration : </b>" +rstdisconn.getString("Duration")+"<br><b> Distance : </b>" +rstdisconn.getInt("Distance")+"<br><b>Location : </b>"+rstdisconn.getString("FromLocation");
		     %> 
					var point1 = new GLatLng(<%= rstdisconn.getDouble("FromLatitude")%>,<%= rstdisconn.getDouble("FromLongitude")%>);
					var marker = createMarker(point1,"<div class='bodyText'><%= label1%></div>","<div class='bodyText'><%= label1%></div>",'Disconn',<%= rstdisconn.getDouble("FromLatitude")%>,<%= rstdisconn.getDouble("FromLongitude")%>);
					map.addOverlay(marker);
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
			}
	}
}

catch(Exception ex)
{
	//System.out.println("Exception--"+ex);
	ex.printStackTrace();%>  <%
}
finally
{
	try
	{
		conn.close();	
	}catch(Exception e)
	{}
	try
	{
		conn1.close();	
	}catch(Exception e)
	{}
	try
	{
		con.close();	
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}


%>
document.getElementById("side_bar").innerHTML = side_bar_html;

     //]]>
    --></script>
    
<%//fleetview.closeConnection();
%>
<%@ include file="footernew.jsp" %>
</html>

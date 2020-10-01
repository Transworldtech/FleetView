
<%@ include file="Connections/conn.jsp"%>
<%@ page import="com.fleetview.beans.classes"%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.fleetview.beans.ZoneColorIdentificationImpl"%>
	
	

<%@page import="java.util.Date"%><jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	<head></head>
	<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
	<script type="text/javascript">
   /*
	window.onload=function()
	{
		window.opener.document.body.disabled=true;
	}
	window.onunload=function()
	{
		window.opener.document.body.disabled=false;
	}*/
	function popupwin(lat,lon)
	{
		testwindow=window.open("shownewmap.jsp?lat="+lat+"&long="+lon+"","myWin","width=700,height=500");
		testwindow.moveTo(500,250);
	}
	
	function Reload1()
	{
		//alert("Hej");  
		//window.opener.document.body.disabled=false;
		opener.Reload();
		window.close();
	}
		
	 function validate()
		  {
		  try
		  {
		     if(document.getElementById("tdm").value=="-")
		    {
		  	   alert("Please select the Vehicle Registeration No.");
			   return false;
		    }
			if(document.getElementById("date").value=="")
			 {
			  	alert("Please select the from date");
				return false;
			 }
			if(document.getElementById("date1").value=="")
			 {
		  	alert("Please select the to date");
				return false;
			 }
			 return datevalidate();
			 try{
			 document.getElementById("div1").style.display="";
			// document.getElementById("tbl").style.display="";
			// document.getElementById("tbl1").style.display="";
			 }catch(e)
			 {alert(e);
			 }
		  }catch(e)
		  {alert(e);
		  }
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
		 try{
	 	var date1=document.getElementById("date").value;
		var date2=document.getElementById("date1").value;
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
			document.getElementById("date").value="";
			document.getElementById("date1").value="";
			document.getElementById("date").focus;
			return false;
		}
		else if(year==yy11 && year==yy22)
		{
  			if(mm11>month || mm22>month)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("date").value="";
				document.getElementById("date1").value="";
				document.getElementById("date").focus;
				return false;
			}
		}
		if(mm11==month && mm22==month)
		{
			if(dd11>day || dd22>day)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("date").value="";
				document.getElementById("date1").value="";
				document.getElementById("date").focus;
				return false;
			}
		}

		if(yy11 > yy22)
		{
			alert("From date year should not be greater than to date year");
			document.getElementById("date").value="";
			document.getElementById("date1").value="";
			document.getElementById("date").focus;
			return false;
		}
		else if(year==yy11 && year==yy22)
		{
			 if(mm11>mm22)
		{
			alert("From date month should not be greater than to date month");
			document.getElementById("date").value="";
			document.getElementById("date1").value="";
			document.getElementById("date").focus;
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
				document.getElementById("date").value="";
				document.getElementById("date1").value="";
				document.getElementById("date").focus;
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
			document.getElementById("date").value="";
			document.getElementById("date1").value="";
			document.getElementById("date").focus;
			return false;
		}
		
		return true;
		 }catch(e)
		 {alert(e);
		 }
	}

	 function get_radio(lat,lon)
	 {
		 try{
	 	//alert("lat "+lat+ "long "+lon);
	 //	document.getElementById("geotype").value="Point";
	 	document.getElementById("lati").value=lat;
	 	document.getElementById("langi").value=lon;
	    // document.getElementById("tra").style.display="";
	    // document.getElementById("trb").style.display="";
	    // document.getElementById("trc").style.display="";
	    // document.getElementById("trd").style.display="";
	    // document.getElementById("tri").style.display="";
	 	testwindow1 = window.open("geoAddForm.jsp?lati="+lat+"&langi="+lon, "AddGeofence", "width=500,height=280");
	    testwindow1.moveTo(500,250);
	    
	    
		 }catch(e)
		 {alert(e);}
	 }
	 function parent_disable()
	 {
	 	if(testwindow1 && !testwindow1.closed)
	 	{
	 		//alert("Hii");
	 		 testwindow1.focus();
	 	}
	 }
	 
	</script>
<%
//System.out.println("Hii..............");
Connection conn;
String vehRegNo,date="",date1="",vehcode1="",user,date2="",date3="",sql2;
ResultSet rs=null;
int i,x,dist;
boolean flag=true;
String vehcode=(String)session.getAttribute("VehList");
System.out.println(vehcode);
vehcode=vehcode.replace(",","','");
vehcode=vehcode.replace("(","");
vehcode=vehcode.replace(")","");
%>
<%
classes fleetview=new classes();

try{
	//System.out.println("Hii");
	Class.forName(MM_dbConn_DRIVER); 
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	Statement st=conn.createStatement();
	Statement st2=conn.createStatement();
	Statement stveh=conn.createStatement();
	String fromdate1="",todate1="",fromdate="",todate="";

	String Vehregno=request.getParameter("VehRegNo");
	/*if(!(null==request.getParameter("date")) && !(null==request.getParameter("date1")))
	{
		fromdate1=request.getParameter("date");
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
		todate1=request.getParameter("date1");
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
		//out.print(fromdate);
	}
	else
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		todate=fromdate;
		fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		todate1=fromdate1;
		//out.print(todate);
	}*/
	//vehcode1=request.getParameter("vehcode");
	fromdate1=request.getParameter("date");
	todate1=request.getParameter("date1");
	if(null==fromdate1||null==todate1||null==Vehregno)
	{
		fromdate1=todate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		Vehregno="-";
	}
	%>
	<body onclick="parent_disable();">
    <table border="0" width="70%" bgcolor="white" align="center">  
<tr align="center">
<td align="center">
<center><font size="3"><div ><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Custom Detail Report<b></div></font></center>
</td>
</tr>
<tr align="center">
<td align="center">
<form name="customdetail" method="get" action="" onsubmit="return validate();">
	<!-- <input type="hidden" name="vehcode" value="< %=VehicleCode%>">-->
	
	<table border="0" align="center" width="100%" style="margin-left: 5%">  
 	<tr>
 	
 	<td>
	   <font size="2"><b>VehRegNo&nbsp;</b></font><select name="VehRegNo" id="tdm">
	             <option value="select" selected>-</option>
	             <%
	             String sqlveh="Select VehicleRegNumber from db_gps.t_vehicledetails where vehiclecode IN ('"+vehcode+"') ORDER BY VehicleRegNumber";  
	            System.out.println(sqlveh);
	            ResultSet rsveh=stveh.executeQuery(sqlveh);
	            while(rsveh.next())
	            {%>
	            <option value="<%=rsveh.getString("VehicleRegNumber") %>"><%=rsveh.getString("VehicleRegNumber") %></option> 
	             <%} %>
	             </select></td>
	             
 	<td align="left"><font size="2"><b>From&nbsp;&nbsp;</b></font>
		<input type="text" id="date" name="date" size="12" value="<%=fromdate1%>" readonly/>
		<script type="text/javascript">
		try{
  Calendar.setup(
    {
      inputField  : "date",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );}catch(e)
  {alert(e);
  }
		</script>
		<!-- &nbsp;&nbsp;
		<select name="ftime1" id="ftime1">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>-->
		<%
		/*	for(int i=10;i<24;i++)
			{*/
			%>
				<!-- <option value="< %=i%>">< %=i%></option>-->
			<%
		//	}		
		%>
		<!-- </select>
		<select name="ftime2" id="ftime2">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>-->
		<%
			/*for(int i=10;i<60;i++)
			{*/
			%>
				<!-- <option value="< %=i%>">< %=i%></option>-->
			<%
			//}		
		%>
		
		<!-- </select>-->
  		</td>
	<td align="left"><font size="2"><b>To&nbsp;&nbsp;</b></font>
		<input type="text" id="date1" name="date1" value="<%=todate1%>"  size="12" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "date1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
		</script>
		<!-- &nbsp;&nbsp;
		<select name="ttime1" id="ttime1" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>-->
		<%
			/*for(int i=10;i<23;i++)
			{*/
			%>
				<!-- <option value="< %=i%>">< %=i%></option>-->
			<%
			//}		
		%>
		<!-- <option value="23" selected>23</option>
		</select>
		<select name="ttime2" id="ttime2" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>-->
		<%
			/*for(int i=10;i<59;i++)
			{*/
			%>
				<!-- <option value="< %=i%>">< %=i%></option>-->
			<%
			//}		
		%>
		<!-- <option value="59" selected>59</option>
		</select>-->		
		</td>

	<td><div align="left" > 
		<input type="submit" name="submit" value="Submit">
		<input type="hidden" name="lati" id="lati" class="formElement" readonly>
        <input type="hidden" name="langi" id="langi" class="formElement" readonly>
	</div></td>
	</tr>
	</table>
	
</td></tr>
<%
Vehregno=request.getParameter("VehRegNo");
System.out.println(Vehregno);
 if(!(null==request.getParameter("date")))
			{
		
		
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date")));
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date1")));	
			
			//ftime1=request.getParameter("ftime1");
			//ftime2=request.getParameter("ftime2");
			//ttime1=request.getParameter("ttime1");
			//ttime2=request.getParameter("ttime2");
		
			//fromtime=request.getParameter("ftime1")+":"+request.getParameter("ftime2")+":00";
			//totime=request.getParameter("ttime1")+":"+request.getParameter("ttime2")+":00";
			
		
	//out.print(fromtime+"  "+totime);
			}%>
<tr align="center">
<td align="center">
<%
if(!(Vehregno.equalsIgnoreCase("-"))||!(Vehregno.equalsIgnoreCase(null)))
{
	System.out.println("Hii");
%>
<div  id="div1">
<table width="100%" align="center" id="tbl" style="margin-left: 3%">
<tr>
<td align="center"><br><font size="3"><b> Detail Report for Vehicle <%=Vehregno%> from <%=fromdate %>  to <%=todate%></b></font>
</td>
</tr>
</table>
<div  style="height: 100%;width: 100%">
<table width="100%" align="center" id="tbl1" border="1" class="sortable" style="margin-left: 3%">
<tr>
<th align="center">Sr.No</th>
<th align="center">Date-Time</th>
<th align="center">Speed</th>
<th align="center">Distance</th>
<th align="center">Location</th>
</tr>
<%
String sql="Select vehiclecode from db_gps.t_vehicledetails where  VehicleRegNumber='"+Vehregno+"'";
System.out.println(sql);
rs=st.executeQuery(sql);
if(rs.next())
{
	vehcode1=rs.getString("VehicleCode");
	System.out.println(vehcode1);
}
System.out.println(vehcode1);
if(vehcode1==null || vehcode1=="")
{
	
}
else{
	System.out.println("vehcode1 "+vehcode1);
	 i=1;
	 x=0;
	 dist=0;
	//fromdate="";fromtime="";
	flag=true;

	 sql2="select * from t_veh"+vehcode1+" where TheFieldDataDateTime >='"+fromdate+" 00:00:00' and TheFieldDataDateTime <='"+todate+" 23:59:59' and TheFiledTextFileName in ('SI','OF','ON') order by TheFieldDataDateTime asc";
	System.out.println(sql2);
    ResultSet rs1=st2.executeQuery(sql2);
    
    if(rs1.first())
	{
		if(i==1)
		{
			dist=rs1.getInt("Distance");
		System.out.println("dist::>>"+dist);
		}
		flag=true;
%>

<tr>
<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div>
</td><td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDateTime")))%></font></div></td>
<td class='bodyText'><div align='right'><font size="2"><%=rs1.getInt("Speed")%></font></div></td>
<td class='bodyText'><div align='right'><font size="2"><%=(rs1.getInt("Distance")-dist)%></font></div></td>	
<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
</tr>
<%
i++;
	}
    while(rs1.next())
	{
		//System.out.println("***in while***");
		//if(i==1)
		//{
		//	dist=rst1.getInt("Distance");
			////System.out.println("dist::>>"+dist);
		//}
		//System.out.println(rst1.getString("TheFieldDataDateTime"));
		if(rs1.getString("TheFiledTextFileName").equals("SI"))
		{
			
			if(rs1.getInt("Speed")==0)
			{
				
				if(flag==true)
				{
					//System.out.println("HIIIIIIIII");
					flag=false;
					x=1;
%>
<tr>
<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div>
</td><td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDateTime")))%></font></div></td>
<td class='bodyText'><div align='right'><font size="2">Stop</font></div></td>
<td class='bodyText'><div align='right'><font size="2"><%=(rs1.getInt("Distance")-dist)%></font></div></td>
<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
</tr>
<%
i++;
				}
			}
			
			else
			{//SI wid  sp>0
				if(x==1)
				{
					flag=true;
%>

<tr>
<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDateTime")))%></font></div></td>
<td class='bodyText'><div align='right'><font size="2">Start</font></div></td>
<td class='bodyText'><div align='right'><font size="2"><%=(rs1.getInt("Distance")-dist)%></font></div></td>
<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
</tr>
<%
i++;
						x++;
					}
					
					flag=true;	
					%>
					<tr>
					<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDateTime")))%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=rs1.getInt("Speed")%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=(rs1.getInt("Distance")-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
					</tr>
						<%
					i++;
				}
			}//ens of SI check
			else
		    {
				if(rs1.getString("TheFiledTextFileName").equals("OF"))
		    
				{
					String long1,long2,long3,lat1,lat2,lat3,loc1,loc2,loc3;
					int ds1,ds2,ds3;
					
					
					System.out.println("date1 "+rs1.getString("TheFieldDataDate")+"date2 "+ rs1.getString("TheFieldDataTime"));
					java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDate")+" "+rs1.getString("TheFieldDataTime"));
					
					loc1=rs1.getString("TheFieldSubject");
					lat1=rs1.getString("LatinDec");
					long1=rs1.getString("LonginDec");
					ds1=rs1.getInt("Distance");
					String speedof = rs1.getString("Speed");
					if(rs1.next())
					{
						if(rs1.getString("TheFiledTextFileName").equals("ON")||rs1.getString("TheFiledTextFileName").equals("SI"))
						{
							if(rs1.getString("TheFiledTextFileName").equals("SI"))
							{
								java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDate")+" "+rs1.getString("TheFieldDataTime"));
								loc2=rs1.getString("TheFieldSubject");
								lat2=rs1.getString("LatinDec");
								long2=rs1.getString("LonginDec");
								ds2=rs1.getInt("Distance");
								String speedsi = rs1.getString("Speed");
								long hrs=00,mins=00;
								long mils1=dt1.getTime();
								long mils2=dt2.getTime();
								long mils3=mils2-mils1;
								mils3=mils3/1000/60;
								
								if(mils3 > 20)
								{
					%>
					
					<tr>
					<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></font></div></td>
					<%
					/*if(mils3>=60)
					{
						hrs=mils3/60;
						mins=mils3%60;*/
					%>
					<!-- <td class='bodyText'><div align='right'>< %=hrs%> Hrs. < %=mins%> Mins. OFF</div></td>-->
					<td class='bodyText'><div align='right'><font size="2"><%=speedof%></font></div></td>
					<%
					/*}
					
					else
					{*/
					%>
					<!-- <td class='bodyText'><div align='right'>< %=hrs%> Hrs. < %=mins%> Mins. OFF</div></td>-->
			   <%//} %>
					<td class='bodyText'><div align='right'><font size="2"><%=(ds1-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=loc1%></font></a></div></td>
					</tr>
					<%i++; 
					%>
					<tr>
					<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=speedsi%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=(ds2-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=loc2%></font></a></div></td>
					</tr>
					<%
					i++;
					%>
					<!-- 
					<tr>
					<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(< %=rs1.getString("LatinDec")%>,< %=rs1.getString("LonginDec")%>)'><font size="2">< %=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2">Start</font></div></td>
					<td class='bodyText'><div align='right'><font size="2">< %=(ds2-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(< %=rs1.getString("LatinDec")%>,< %=rs1.getString("LonginDec")%>)'><font size="2">< %=loc2%></font></a></div></td>
					</tr>-->
					<%
				//	i++;
					flag=true;
					%>
					<tr>
					<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=rs1.getInt("Speed")%></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=(ds2-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=loc2%></font></a></div></td>
					</tr>
					<%
					i++;
								}
							}//end of SI check after OF stamp
							
							else if(rs1.getString("TheFiledTextFileName").equals("ON"))
							{
								java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDate")+" "+rs1.getString("TheFieldDataTime"));
								loc2=rs1.getString("TheFieldSubject");
								lat2=rs1.getString("LatinDec");
								long2=rs1.getString("LonginDec");
								ds2=rs1.getInt("Distance");
								String speedon = rs1.getString("Speed");
								long hrs=00,mins=00;
								long mils1=dt1.getTime();
								long mils2=dt2.getTime();
								long mils3=mils2-mils1;
								mils3=mils3/1000/60;
								
								if(mils3 > 20)
								{
									if(rs1.next())
									{
										if(rs1.getString("TheFiledTextFileName").equals("SI"))
										{
											loc3=rs1.getString("TheFieldSubject");
											////System.out.println("Stamp::>>"+rst1.getString("TheFiledTextFileName"));
											lat3=rs1.getString("LatinDec");
											long3=rs1.getString("LonginDec");
											ds3=rs1.getInt("Distance");
					%>
					
					<tr>
					<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></font></div></td>
					<%
				/*	if(mils3>=60)
					{
						hrs=mils3/60;
						mins=mils3%60;*/
					%>
					<!-- <td class='bodyText'><div align='right'>< %=hrs%> Hrs. < %=mins%> Mins. OFF</div></td>-->
					<td class='bodyText'><div align='right'><font size="2"><%=speedof%></font></div></td>
					<%
				/*	}
					
					else
					{*/
					%>
					<!-- <td class='bodyText'><div align='right'>00 Hrs. < %=mils3%> Mins. OFF</div></td>-->
					<%
					// }
					%>
					<td class='bodyText'><div align='right'><font size="2"><%=(ds1-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
					</tr>
					
					<%
					i++;
					%>
					<tr><td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
					<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=speedon %></font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=(ds2-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=loc3%></font></a></div></td>
					</tr>
					
					<%
					i++;
					if(rs1.getInt("Speed")==0)
					{
						 if(flag==true)
					     {
					         flag=false;	 
					         x=1;
					%>
					
					<tr><td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
				   <td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDateTime")))%></font></div></td>
				    <td class='bodyText'><div align='right'><font size="2">Stop</font></div></td>
					<td class='bodyText'><div align='right'><font size="2"><%=(ds3-dist)%></font></div></td>
					<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
					</tr>
					
					<%
					              i++;
					                 }
					}

                                  }
                             }
                        }
                     }//end of ON stamp after OF stamp
                  }//end of SI or ON stamp check
                 } 
             // rs1.previous();
               }//end of OF stamp check
//flag=true;
             }
            }//end of while loop





             if(rs1.last())
              {
					%>
					
			<tr>
			<td class='bodyText'><div align='right'><input type='radio' value='' id='lalng' class='' name='lalng' onclick='javascript:get_radio(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=i%></font></div></td>
			<td class='bodyText'><div align='left'><font size="2"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("TheFieldDataDateTime")))%></font></div></td>
			<td class='bodyText'><div align='right'><font size="2"><%=rs1.getInt("Speed")%></font></div></td>
	        <td class='bodyText'><div align='right'><font size="2"><%=(rs1.getInt("Distance")-dist)%></font></div></td>
			<td class='bodyText'><div align='left'><a href='javascript:popupwin(<%=rs1.getString("LatinDec")%>,<%=rs1.getString("LonginDec")%>)'><font size="2"><%=rs1.getString("TheFieldSubject")%></font></a></div></td>
			</tr>
			
			<%
			i++;

      		}
			%>
</table>
</div>
</div>
<%
}}
%>
	</td>
</tr>
</table>
</body>
	
	<%

	}catch(Exception e)
	{
		System.out.println(e);
		e.printStackTrace();
		System.out.println("date "+date);
	    System.out.println("date1 "+date1);
	   System.out.println("date2 "+date2);
	  System.out.println("date3 "+date3);
	}finally
	{
		//conn1.close();
		try
		{
		fleetview.closeConnection1();
		}
		catch(Exception e)
		{}
		try
		{
		fleetview.closeConnection();
		}
		catch(Exception e){}
	}
	%>
	
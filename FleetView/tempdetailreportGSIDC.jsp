<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>	
<script type="text/javascript" src="http://www.google.com/jsapi"></script>

<script language="javascript">

function allSelected()
{
	//alert(allval);
if(document.customdetail.extAll.checked)
{
	document.getElementById("tr1").style.display='none';
}
else
{
	document.getElementById("tr1").style.display='';
}
	
}

function popupwin(lat,lon)
{
	 try{
		 	//alert("lat "+lat+ "long "+lon);
		 //	document.getElementById("geotype").value="Point";
		 	//document.getElementById("lati").value=lat;
		 	//document.getElementById("langi").value=lon;
		    // document.getElementById("tra").style.display="";
		    // document.getElementById("trb").style.display="";
		    // document.getElementById("trc").style.display="";
		    // document.getElementById("trd").style.display="";
		    // document.getElementById("tri").style.display="";
		 	testwindow1 = window.open("geoAddForm.jsp?lati="+lat+"&langi="+lon+"&fpage1=detail_custom_report.jsp", "Add Geofence", "width=500,height=280");
		    testwindow1.moveTo(500,250);
		    
			 }catch(e)
			 {alert(e);}
}

function Validate()
{ 
	try
	{
		//alert("date validate");
		var interval=document.getElementById("interval").value;
		 var num=interval.match("^[0-9]*[.][0-9]+$")
		//alert(interval);
    if(isNaN(interval))
   {
	alert("Please the numeric time interval!!");
	return false;
   } 
    else
        if(num!=null)
        {
        	alert("Please the numeric time interval!!");
        	return false;
        }
    var num=interval.match("^[0-9]*[.][0-9]+$")
    
    
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
	catch(e)
	{
		alert(e);
	}
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var hr1=document.getElementById("ftime1").value;
	var min1=document.getElementById("ftime2").value;
	var hr2=document.getElementById("ttime1").value;
	var min2=document.getElementById("ttime2").value;
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
	var hr=date.getHours();
	
	var min=date.getMinutes();
	//alert(hr);
	//alert(min);
	var year=date.getFullYear();
	if(yy11>year  || yy22>year) 
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
					if(days=='May') //timeformat: "%M:%S"
						
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
function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)  
{  

try{
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;
   
    document.sensorrep.action ="excel.jsp";
    document.forms["sensorrep"].submit();
   
}catch(e )
{
	alert(e);
	}

    
} 
</script>
<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
String vehid,ss1,ss2,ss3,dd,vehicle;
String datenew1,datenew2,date3;
static String sensor;
Connection conn;
Statement st,sttemp,st1,stcolor,stfuel;
String sql,sql1;


%>
<%
/*
String PageName=this.getClass().getName().replaceAll("_",".");
System.out.println(PageName);*/

String userTypeValue = session.getAttribute("usertypevalue").toString();
String targetvalue1=session.getAttribute("usertypevaluemain").toString();
String selecteduser= (String)session.getAttribute("selecteduser");
//System.out.println(selecteduser);
String dateformat="dd-MMM-yyyy";
dateformat=session.getAttribute("dateformat").toString();
String geoname="";
ArrayList<String> target1=(ArrayList<String>)session.getAttribute("TargetList");
String empnamee="";
String fromPage=request.getParameter("fromPage");

int interval1=0;
String interval=request.getParameter("interval");
String chbxAll=request.getParameter("extAll");
//System.out.println("558 **********  "+chbxAll);

if(interval!=null)
{
	//System.out.println("562 ^^^^^^^ in if");
 interval1=Integer.parseInt(interval);
}
else
{
	interval1=60;
}
//sensor =request.getParameter("Sen");


if("runAnalysis".equalsIgnoreCase(fromPage)){
//	VehicleCode=request.getParameter("vehcode");
//	datenew1=datenew2=request.getParameter("data");
	
	//System.out.println("if");

	vehicle =request.getParameter("vehreg");
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")));
	ss1 =request.getParameter("ss1");
	ss2 =request.getParameter("ss2");
	ss3 =request.getParameter("ss3");
	VehicleCode =request.getParameter("vehcode");
	sensor =request.getParameter("Sen");
	
}
else{
	//System.out.println("else");
	
	VehicleCode=request.getParameter("vehcode");
	
	date3=datenew1=request.getParameter("data");
	datenew2=request.getParameter("data1");
	ftime1=request.getParameter("ftime1");
	ftime2=request.getParameter("ftime2");
	ttime1=request.getParameter("ttime1");
	ttime2=request.getParameter("ttime2");
	sensor=request.getParameter("Sen");
}


//System.out.println("sensor "+sensor);
//System.out.println("date3 "+date3);
//System.out.println("datenew1 "+datenew1);
//System.out.println("datenew2 "+datenew2);
//System.out.println("ftime1 "+ftime1);
//System.out.println("ftime2 "+ftime2);
//System.out.println("ttime1 "+ttime1);
//System.out.println("ttime2 "+ttime2);

if(null==datenew1 || datenew1.equalsIgnoreCase("null"))
{
	sensor =request.getParameter("Sen");
	
	datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	 ttime1=new SimpleDateFormat("HH").format(new java.util.Date());
     ttime2=new SimpleDateFormat("mm").format(new java.util.Date());
     Calendar cal=Calendar.getInstance();
     cal.add(Calendar.DATE,-1);
     cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
     
     ftime1=new SimpleDateFormat("HH").format(cal.getTime());
     ftime2=new SimpleDateFormat("mm").format(cal.getTime());
   //  System.out.println("VehicleCode "+VehicleCode);
  //   System.out.println("Sensor "+sensor);
     //System.out.println("date3 "+date3);
    // System.out.println("datenew1 "+datenew1);
    // System.out.println("datenew2 "+datenew2);
   //  System.out.println("ftime1 "+ftime1);
   //  System.out.println("ftime2 "+ftime2);
    // System.out.println("ttime1 "+ttime1);
    // System.out.println("ttime2 "+ttime2);
}
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sttemp=conn.createStatement();
	stfuel = conn.createStatement();
	st1=conn.createStatement();
	stcolor=conn.createStatement();
	String arcolor[] = new String [7];
	int j =0;
	
	sql1="select * from db_gps.t_geouserinfo where Transporter ='"+selecteduser+"' and Status='Yes'";
	ResultSet rs=st1.executeQuery(sql1);
	if(rs.next())
	{
		//System.out.println("in geouser");
		geoname="Yes";
	}
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");
		if(target1.contains(targetvalue1))
		{
			empnamee=rst.getString("EmpName");
		}
	}
	
	sql1 = "Select * from db_gps.t_weekcolors";
	 rs=st1.executeQuery(sql1);
	 while(rs.next())
	 {
		 arcolor[j]=rs.getString("colors");
		 j++;
	 }
	
	
%>
<table border="0" width="100%" class="stats">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3">Report No:1.12</font></div>-->
 <font size="3"><div ><b>Sensor Detail Report<b></div></font></center>
<div class="bodyText" align="right">

</div>
</td>
</tr>
</table>
<%
if("runAnalysis".equalsIgnoreCase(fromPage))
	{
		
	}
	else
	{
%>

<form name="customdetail" method="get" action="" onsubmit="return Validate();">
	<input type="hidden" name="vehcode" value="<%=VehicleCode%>">
	
	<input type="hidden" name="Sen" value="<%=sensor%>">
	
	<table border="0" align="center" width="750" align="right" class="sortable_entry">  
 	<tr>
 	<td align="left"><b>From&nbsp;&nbsp;</b>
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>"  class="formElement" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ftime1" id="ftime1"  class="formElement">
			<option value="00" selected>00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<24;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
		%>
		</select>
		<select name="ftime2" id="ftime2"  class="formElement">
			<option value="00" selected>00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<60;i++)
				{
				%>
					<option value="<%=i%>" ><%=i%></option>
				<%
				}		
		%>
		
		</select>
  		</td>
<!--	<td align="left">-->
<!--		<input type="button" name="From Date" value="From Date" id="trigger">-->
<!--		-->
<!--	</td>-->
	<td align="left"><b>To&nbsp;&nbsp;</b>
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12"  class="formElement" readonly/>
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
		<select name="ttime1" id="ttime1"  class="formElement">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
		
		<select name="ttime2" id="ttime2"  class="formElement" >
			<option value="00">00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<59;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
			%>
			<option value="59" selected>59</option>
			
		
		</select>		
		</td>
<!--		<td align="left">-->
<!--  		<input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--		-->
<!--	</td>-->
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit"  class="formElement">
	</div></td>
	</tr>
	</table>
	<table border="0" align="center" width="750" align="right" class="sortable_entry">  
	<tr>
	<td>
	<table border="0" align="center" width="550" align="right" class="sortable_entry">  
	<tr>
	<td align="left" style="width: 60%; display:  " id="tr1">
	<br></br>
	<div class="bodyText" align="left">
    <font size="2" face="Arial">Enter Time interval in minutes:   <input type="text" id="interval" name="interval" value = "<%=interval1 %>"  size="8" style="border-color: activeborder;" value="0"/></font>
    </div>
	</td>
	<td  align="left" style="width: 40%;">
	<br></br>
<!--	<div class="bodyText" align="left">-->
<!--	<font size="2" face="Arial">Show only start/stop &nbsp;&nbsp;&nbsp;-->
<!--	<input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected(this.value);"></input>-->
<!--	</font>-->
<!--	</div>-->
	</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
</td></tr>
	<%
	}
	if("runAnalysis".equalsIgnoreCase(fromPage)){
	//	System.out.println("In if");
		fromdate=todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd")));
		
		
		
	////	if(null==ftime1||"null".equalsIgnoreCase(ftime1))
	//	{
			fromtime = "00:00:00";
			totime="23:59:59";
	//	}
		
		//System.out.println(fromdate+" "+fromtime+"----"+todate+" "+totime);
	}
	else //if(!(null==request.getParameter("data")))
			{
		//System.out.print("in else");
		
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));	
			
			//ftime1=request.getParameter("ftime1");
			//ftime2=request.getParameter("ftime2");
			//ttime1=request.getParameter("ttime1");
			//ttime2=request.getParameter("ttime2");
		
			fromtime=ftime1+":"+ftime2+":00";
			totime=ttime1+":"+ttime2+":00";
			//System.out.print("fromdate "+fromdate);
			//System.out.print("todate "+todate);
			//System.out.print("ftime1 "+ftime1);
			//System.out.print("ttime1 "+ttime1);
			//System.out.print("ftime2 "+ftime2);
			//System.out.print("ttime2 "+ttime2);
			//System.out.print("fromtime "+fromtime);
			//System.out.print("totime "+totime);
		
	//out.print(fromtime+"  "+totime);
			}
	
	
	
	
	
	%>
	 
<tr><td>
<br>

<%
/*if(!(null==request.getParameter("data")) || "runAnalysis".equalsIgnoreCase(fromPage))
*/
/* all code comes here */
%>
<br>

<table style width="100%" align="center">
<tr>
<td align="center"><font size="3" color="blue"><b> Detail Report for <%=vehregno%> from <%=datenew1 %> <%=fromtime%> to <%=datenew2%> <%=totime%></b></font>

<div  class="bodyText" align="left">
<font size="3"><B></B><a href="#" onclick="javascript:window.open('show_custom_detail_rept_onMap.jsp?tripid=null&vehcode=<%=VehicleCode %>&data=<%=fromdate %>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&fromtime=<%=fromtime%>&totime=<%=totime%>');""> <font size="2"> <u>Journey On Map.</u></font></a> </font>
<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"><B></B><a href="#" onclick="javascript:window.open('tankerkml.jsp?tripid=null&vehcode=< %=VehicleCode %>&data=< %=fromdate %>&data1=< %= todate%>&ftime1=< %=ftime1 %>&ftime2=< %=ftime2 %>&ttime1=< %=ttime1 %>&ttime2=< %=ttime2 %>&fromtime=< %=fromtime%>&totime=< %=totime%>');""> <font size="2"> <u>Tanker KML.</u></font></a> </font>-->
<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"><B></B><a href="#" onclick="javascript:window.open('tankerCamerakml.jsp?tripid=null&vehcode=< %=VehicleCode %>&data=< %=fromdate %>&data1=< %= todate%>&ftime1=< %=ftime1 %>&ftime2=< %=ftime2 %>&ttime1=< %=ttime1 %>&ttime2=< %=ttime2 %>&fromtime=< %=fromtime%>&totime=< %=totime%>');""> <font size="2"> <u>Camera/Tanker KML.</u></font></a> </font>-->
<!-- 
 uncomment "Tanker KML" and "Camera/Tanker KML" link while uploading on fleetview -spring
-->
<!--<div class="bodyText" align="right">-->
<!--         <a href="#" onclick="javascript:window.open('RegisterComplaint.jsp?ReportName=< %=PageName %>','Register Complaint,'width=500,height=280');window.moveTo(500,250);">Register Complaint</a>-->
<!--		<a href="#" onclick="javascript:window.open('print_detail_custom_report.jsp?vehcode=< %=VehicleCode%>&data=< %=fromdate%>&data1=< %=todate%>&fromtime=< %=fromtime%>&totime=< %=totime%>&interval=< %=interval1%>&chbx=< %=chbxAll %>');" title="Print Report">-->
<!--		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; -->
<!--		<a href="excel_details_custom_report.jsp?vehcode=< %=VehicleCode%>&data=< %=fromdate%>&data1=< %=todate%>&fromtime=< %=fromtime%>&totime=< %=totime%>&interval=< %=interval1%>&chbx=< %=chbxAll %>" title="Export to Excel">-->
<!--		<img src="images/excel.jpg" width="15px" height="15px">-->
<!--		</a>-->
<!--		&nbsp;&nbsp;&nbsp;< %=fleetview.PrintDate() %>-->
<!--	</div>-->
</td></tr>
<tr>
<td>
<table width="40%">
<tr>
<td><div class="box" style="background-color: #F0E68C; " align="right"><font color="#F0E68C"> Su</font></div></td>
<td> Sunday</td>
<td><div class="box" style="background-color: #FFCC99;" align="right"><font color="#FFCC99"> Mo</font></div></td>
<td> Monday</td>
<td><div class="box" style="background-color: #EEC5C8;" align="right"><font color="#EEC5C8"> Su</font></div></td>
<td> Tuesday</td>
<td><div class="box" style="background-color: #FFFFCC;" align="right"><font color="#FFFFCC"> Su</font></div></td>
<td> Wednesday</td>
<td><div class="box" style="background-color: #D4C0F0;" align="right"><font color="#D4C0F0"> Su</font></div></td>
<td> Thursday</td>
<td><div class="box" style="background-color: #CCFFCC;" align="right"><font color="#CCFFCC"> Su</font></div></td>
<td> Friday</td>
<td><div class="box" style="background-color: #BDEDFF;" align="right"><font color="#BDEDFF"> Su</font></div></td>
<td> Saturday</td>
</tr>
</table>
 

</td>

</tr>




<%


String sqlchecksensorveh="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp=sttemp.executeQuery(sqlchecksensorveh);
if(rsttemp.next())
{
%>

<%
}
%>
	
</table>

<div   class="bodyText" align="center"> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a  href="temperaturegraph.jsp?vehcode=<%=VehicleCode %>&data=<%=datenew1 %>&data1=<%=datenew2 %>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>"><font size="2" face="Arial">Temperature Graph</font></a>

</div>
</form>

<form name="sensorrep" id="sensorrep" method="post">



&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<%
			String exportFileName="Sensor_Detail_Report.xls";   // GIVE YOUR REPORT NAME
		%>
	<table border="0" width="100%" align="center">
		<tr>
		
			<td align="center"><input type="hidden" id="tableHTML" name="tableHTML" value="" />
			<input type="hidden" id="fileName" 	name="fileName" value="<%=exportFileName%>" />
		    <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('table1');"> 
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
			<a	href="#" onclick="gotoExcel('table1','tableHTML')" 	title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		</tr>
	</table>
	

<div id="table1" align="center">
<table style="width: 30%;font:normal 13px Arial,Helvtica,sans-serif;" align="center" class="sortable" border="1">
<tr>
<th style="width: 5%">Sr.</th>
<th style="width: 10%">Date-Time</th>

<%
/*
if(geoname.equalsIgnoreCase("Yes"))
{*/
%>
<!-- <th align="left" colspan="2" style="width: 50%">Location</th>-->
<%
/*}
else
{*/
%>
<!--<th align="left">Location</th>-->
<%
//}




if(userTypeValue.equals("Croda Chemicals (India) Private Limited"))
{
	%>
	        <th>Temp1</th>
			<th>Temp2</th>
			<th>RPM</th>
			<th>SK</th>
	
	<% 
	
}
else{
sqlchecksensorveh="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
rsttemp=sttemp.executeQuery(sqlchecksensorveh);
if(rsttemp.next())
{
	%>
	<th style="width: 10%">Sensor</th>
	
	<% 
}
}
%>


</tr>
<%

boolean flag=true;

String sqlnew="select * from t_veh"+VehicleCode+" where TheFieldDataDateTime <='"+fromdate+" "+fromtime+"' and TheFiledTextFileName in ('SI','OF','ON') order by TheFieldDataDateTime desc limit 1";

ResultSet rstnew=st.executeQuery(sqlnew);
if(rstnew.next())
{
	fromdate=rstnew.getString("TheFieldDataDate");
	fromtime=rstnew.getString("TheFieldDataTime");
//	System.out.println("fromdate---->"+fromdate+"fromtime-->"+fromtime);
	
}

sql="select "+sensor+" as sen,TheFieldDataDate,TheFieldDataTime from t_veh"+VehicleCode+" where TheFieldDataDateTime >='"+fromdate+" "+fromtime+"' and TheFieldDataDateTime <='"+todate+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON')    order by TheFieldDataDateTime desc";
//System.out.println(sql);
ResultSet rst1=st.executeQuery(sql);
int i=1;
int x=0;
int dist=0;

//System.out.println("662 &&&&&&&&&& "+interval); 
//System.out.println("&&&&&&&&&& "+interval.length()); 
java.util.Date date1=new java.util.Date();
java.util.Date date2=new java.util.Date();
long millis=0;
long millis1=0;
long millis2=0;
int num=0;

//System.out.println("670 %%%%%%%%%%% "+interval1);
//System.out.println("671 $$$$$$$$$$ "+flag);
while(rst1.next())
{
//	System.out.println("In while");
	//System.out.println("674 ^^^^^^^^^^");
	
		//System.out.println(" 667 &&&&&&&&& not checked");
	if(i==1)
	{
	//	dist=rst1.getInt("Distance");
	//	System.out.println("dist::>>"+dist);
	}
	flag=true;
	date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
	num=date1.getDay();
	
	//System.out.println("1st record #########        "+colors);
	if(chbxAll==null)
	{
%>
	<tr>
		<td class="bodyText" style="width: 5%;font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num]%>;"><div align="right"><%=i%></div></td>
		<td class="bodyText" style="width: 20%;font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num]%>;"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
<!--		<td class="bodyText" style="width: 10%;background-color: < %=arcolor[num]%>;"><div align="right">&nbsp;&nbsp;< %=rst1.getInt("Speed")%></div></td>-->
	<%//if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	//{
		 %>
<!--		<td class="bodyText" style="width: 10%; background-color: < %=arcolor[num]%>;"><div align="right">< %=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>-->
		
		<%
	/*}else
	{*/
		%>
<!--		<td class="bodyText" style="width: 10%; background-color: < %=arcolor[num]%>;"><div align="right">< %=rst1.getInt("Distance")-dist%></div></td>-->
		
		<%
	//}
	/*
	if(geoname.equalsIgnoreCase("Yes"))
	{
		//System.out.println("in geouser");
	    if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");*/
						%>
					<!--<td class="bodyText" style="width: 40%">
						<div align="left" ><a href="shownewmap.jsp?lat=<  %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<td class="bodytext">
						<div align="left"><a href="javascript:popupwin(< %=rst1.getString("LatinDec")%>,< %=rst1.getString("LonginDec")%>)">Geofence</a></div>
						</td>  -->
						<%
	/*	}
				else
				{*/
					%>
		
		
		<!--<td class="bodyText" style="width: 40%">
		<div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
		</div></td>
		<td class="bodyText">
		<div align="left"><a href="javascript:popupwin(< %=rst1.getString("LatinDec")%>,< %=rst1.getString("LonginDec")%>)">Geofence</a></div>
		</td>-->
		<%
			/*	}
	}
	else
	{*/
		//System.out.println("not in geouser");
		/*if(target1.contains(targetvalue1))
		{
				String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");*/
				%>
<!--				<td class="bodyText" style="background-color: < %=arcolor[num]%>;">-->
<!--				<div align="left"><a href="shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=rst1.getString("TheFieldSubject") %></a>-->
<!--				</div>-->
<!--				</td>-->
				<%
		/*}
		else
		{*/
			%>
<!--             <td class="bodyText" style="background-color: < %=arcolor[num]%>;"><div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>-->
<!--             </div>-->
<!--             </td>-->
<%
	//	}
	//}
		
String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
if(rsttemp1.next())
{
	
	if(rst1.getString("sen").length()< 2 && !(rst1.getString("sen").equals("0")))
	{
		%>
		<td class="bodyText" style="font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num]%>;"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText" style="font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num]%>;"><div align="right"><%=rst1.getString("sen")%></div></td>
	<%
	}
	
	
	
	%>
	<% 
}
%>

<%



%>
	</tr>
<%
i++;
	}
}

while(rst1.next())
{

	//System.out.println("1250 &&&&&&&&& not checked");
flag=true;
date2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
num=date2.getDay();

millis=date1.getTime();
millis1=date2.getTime();
millis2=millis1-millis;
millis2=millis2/1000/60;

 if(millis2>=interval1)
    {
	 //System.out.println("\nSI********************** "+date1+" $$$$$$$$ "+date2);
		//System.out.println("********************** "+millis2+" $$$$$$$$ "+i);
    	date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
      //System.out.println("&&&&&&&&&&&& "+date1);
    	%>
<tr>
	<td class="bodyText" style="width: 5%;font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num]%>;"><div align="right"><%=i%></div></td>
	<td class="bodyText" style="width: 20%;font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num] %>;"><div align="right"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
<!--	<td class="bodyText" style="width: 10%; background-color: < %=arcolor[num] %>;"><div align="right">&nbsp;&nbsp;< %=rst1.getInt("Speed")%></div></td>-->
	
	<%/*if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
{*/
%>
<!--<td class="bodyText" style="width: 10%; background-color: < %=arcolor[num] %>;"><div align="right">< %=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>-->

<%
/*}else
{*/
%>
<!--<td class="bodyText" style="width: 10%; background-color: < %=arcolor[num] %>;"><div align="right">< %=rst1.getInt("Distance")-dist%></div></td>-->

<%
//}
/*	if(geoname.equalsIgnoreCase("Yes"))
	{
		if(target1.contains(targetvalue1))
		{
			String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");*/
			%>
		<!-- <td class="bodyText" style="width: 40%">
			<div align="left"><a href="shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=rst1.getString("TheFieldSubject") %></a>
			</div></td>
			<td class="bodyText">
			<div align="left"><a href="javascript:popupwin(< %=rst1.getString("LatinDec")%>,< %=rst1.getString("LonginDec")%>)">Geofence</a></div>
			</td>-->
			<%
/*	}
		else
		{*/
		%>
	
	<!--  <td class="bodyText" style="width: 40%">
	<div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
	</div></td>
	<td class="bodyText">
	<div align="left"><a href="javascript:popupwin(< %=rst1.getString("LatinDec")%>,< %=rst1.getString("LonginDec")%>)">Geofence</a></div>
	</td>-->
	<%
/*	}
	}
	else
	{*/
		//if(target1.contains(targetvalue1))
	//	{
		//	String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
			%>
<!--			<td class="bodyText" style="background-color: < %=arcolor[num] %>;">-->
<!--			<div align="left"><a href="shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=rst1.getString("TheFieldSubject") %></a>-->
<!--			</div></td>-->
			<%
	//	}
	//	else
	//	{
		%>
	
<!--	<td class="bodyText" style="background-color: < %=arcolor[num] %>;">-->
<!--	<div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>-->
<!--	</div></td>-->
	<%
	//	}
	//}
	%>
	<%
String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"' ";
ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
if(rsttemp1.next())
{
	
	if(rst1.getString("sen").length()< 2 && !(rst1.getString("sen").equals("0")))
	{
		%>
		<td class="bodyText" style="font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num] %>;"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText" style="font:normal 13px Arial,Helvtica,sans-serif; background-color: <%=arcolor[num] %>;"><div align="right"><%=rst1.getString("sen")%></div></td>
	<%
	}
	
	
	
	%>
	<% 
}
%>

<%


i++;

    }
								
%>
</tr>
<%



}//end of while loop

				
					

		
/*if(rst1.last())
{*/
	//if(chbxAll==null)
	//{
		
		//date2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
		//num=date2.getDay();
%>
<!--	<tr>-->
<!--		<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">< %=i%></div></td>-->
<!--		<td class="bodyText" style="width: 20%; background-color: < %=arcolor[num] %>;"><div align="left">< %=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> < %=rst1.getString("TheFieldDataTime")%></div></td>-->
<!--		<td class="bodyText" style="width: 10%; background-color: < %=arcolor[num] %>;"><div align="right">&nbsp;&nbsp;< %=rst1.getInt("Speed")%></div></td>-->
		<%//if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		//{
			 %>
<!--			<td class="bodyText" style="width: 10%;background-color: < %=arcolor[num] %>;"><div align="right">< %=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>-->
		<%//}else
		//{
			%>
<!--			<td class="bodyText" style="width: 10%;background-color: < %=arcolor[num] %>;"><div align="right">< %=rst1.getInt("Distance")-dist%></div></td>-->
		<%//}
		/*if(geoname.equalsIgnoreCase("Yes"))
		{
			if(target1.contains(targetvalue1))
			{
					String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");*/
					%>
					 <!-- <td class="bodyText" style="width: 40%">
					<div align="left"><a href="shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=rst1.getString("TheFieldSubject") %></a>
					</div></td>
					<td class="bodyText">
					<div align="left"><a href="javascript:popupwin(< %=rst1.getString("LatinDec")%>,< %=rst1.getString("LonginDec")%>)">Geofence</a></div>
					</td>-->
					<%
			/*}
			else
			{*/
				%>
	                    <!--    <td class="bodyText" style="width: 40%">
	                       <div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
	                   </div></td>
	                   <td class="bodyText">
	                   <div align="left"><a href="javascript:popupwin(< %=rst1.getString("LatinDec")%>,< %=rst1.getString("LonginDec")%>)">Geofence</a></div>
	                   </td>-->
	                   <%
			/*}

		}
		else
		{*/
				/*if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");*/
						%>
<!--						<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="left"><a href="shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=< %=rst1.getString("LatinDec") %>&long=< %=rst1.getString("LonginDec")%>&discription=< %=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=rst1.getString("TheFieldSubject") %></a>-->
<!--						</div></td>-->
						<%
						/*}
				else
				{*/
					%>
		
		
<!--		<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>-->
<!--		</div></td>-->
		<%
				/*}
	//	}
				
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))	
					{*/
						%>
<!--						<td class="bodyText" style="background-color: < % =arcolor[num] %>;"><div align="right">xxxx</div></td>-->
						<%		
					/*}
					else
					{*/
					%>
<!--					<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">< %=rst1.getString("Sen1")%></div></td>-->
					<%
					/*}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{*/
						%>
<!--						<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">xxxx</div></td>-->
						<%		
					/*}
					else
					{*/
					%>
<!--					<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">< %=rst1.getString("Sen2")%></div></td>-->
					<%
					/*}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{*/
						%>
<!--						<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">xxxx</div></td>-->
						<%		
					/*}
					else
					{*/
					%>
<!--					<td class="bodyText" style="background-color: <  %=arcolor[num] %>;"><div align="right">< %=rst1.getString("Sen3")%></div></td>-->
					<%
					/*}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{*/
						%>
<!--						<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">xxxx</div></td>-->
						<%		
					/*}
					else
					{*/
					%>
<!--					<td class="bodyText" style="background-color: < %=arcolor[num] %>;"><div align="right">< %=rst1.getString("Sen4")%></div></td>-->
					<%
					//}
					%>
					<% 
/*}
				if(isfuel == "Yes" || isfuel.equalsIgnoreCase("Yes"))
				{*/
					%>
<!--					<td class="bodyText" style="background-color: < %=arcolor[num]%>;"><div align="right">< %=rst1.getString("FuelLevel")%></div></td>-->
					<%
			//	}		
		%>
<!--	</tr>-->
<%
/*i++;
}
}*/
%>
</table>
</div>
</form>






<%
/* code end here*/


%>
</td></tr>
<%
//System.out.println("=============="+fromPage);
	if("runAnalysis".equalsIgnoreCase(fromPage))
	{
		//System.out.println(fromPage);
		//System.out.println(ss1);
		//System.out.println(ss3);
		//System.out.println(ss2);
		
%>
<tr><td colspan="5">
			<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['piechart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data = new google.visualization.DataTable();
        			data.addColumn('string', 'Task');
        			data.addColumn('number', 'Hours per Day');
        			data.addRows(3);
        			data.setValue(0, 0, 'Running Time In Min');
        			data.setValue(0, 1, <%=ss1%>);
        			
        			data.setValue(1, 0, 'Day Stops In Min');
        			data.setValue(1, 1, <%=ss3%>);
					data.setValue(2, 0, 'Night Stop In Min');
        			data.setValue(2, 1, <%=ss2%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        			//chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Time Statistics'});
      			}
    			</script>
				 <div id="chart_div" order="1"></div>			
			
			</td></tr>
			<%
	}
			%>

<center><font size="1">Note:- The data is displayed from one record previous to selected date 
for distance accuracy purpose.</font></center></td>

</form>

<%
		


}
catch(Exception e)
{
	//System.out.print("Exception "+e);
}
finally
{
	try
	{
		st.close();
		sttemp.close();
		st1.close();
		conn.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
<% //fleetview.closeConnection(); %>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>

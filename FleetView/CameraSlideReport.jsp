<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
    <title>Camera Report</title>
    <link href="themes/4/js-image-slider.css" rel="stylesheet" type="text/css" />
    <script src="themes/4/js-image-slider.js" type="text/javascript"></script>
    <link href="css/generic.css" rel="stylesheet" type="text/css" />
    
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
    
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script>
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>



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
    
<script type="text/javascript"> 

   


function dateformat(days)
{
	if(days=='Jan')
		return(1);
	else if(days=='Feb')
		return(2);
	else if(days=='Mar')
		return(3);
	else if(days=='Apr')
		return(4);
	else if(days=='May')
		return(5);
	else if(days=='Jun')
		return(6);
	else if(days=='Jul')
		return(7);
	else if(days=='Aug')
		return(8);
	else if(days=='Sep')
		return(9);
	else if(days=='Oct')
		return(10);
	else if(days=='Nov')
		return(11);
	else if(days=='Dec')
		return(12);
 }

function datevalidate()
{
	var date1 = document.getElementById("date1").value;
	var hr1="";
	var min1="";
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	mm1=date1.substring(3,6);
	mm11=dateformat(mm1);
	yy11=date1.substring(7,11);
	hr1 = date1.substring(12,14)
	min1 = date1.substring(15,17)
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var hr=date.getHours();
	var min=date.getMinutes();
	//alert(hr);
	//alert(min);
	var year=date.getFullYear();
	//alert("year1   "+yy11+"   year  "+year);
	if(yy11<year) 
	{
		
		alert("selected date should not be Less than todays date");
		document.getElementById("date1").value="";
		document.getElementById("date1").focus;
		return false;
	}
	else if(year==yy11)
	{
		//alert("month1   "+mm11+"   month  "+month);
			if(mm11<month)
		{
			alert("selected date should not be Less than todays date");
			document.getElementById("date1").value="";
			document.getElementById("date1").focus;
			return false;
		}
			else
				if(mm11==month)
				{
					//alert("day1   "+dd11+"   day  "+day);
					if(dd11<day)
					{
						alert("selected date should not be Less than todays date");
						document.getElementById("date1").value="";
						document.getElementById("date1").focus;
						return false;
					}
					else
						if(dd11==day)
						{
							//alert("hr1   "+hr1+"   hr  "+hr);
							if(hr1<hr)
							{
								alert("selected date should not be Less than todays date");
								document.getElementById("date1").value="";
								document.getElementById("date1").focus;
								return false;
							}
							else
								if(hr1==hr)
								{
									//alert("min1   "+min1+"   min  "+min);
									if(min1<min)
									{
										alert("selected date should not be Less than todays date");
										document.getElementById("date1").value="";
										document.getElementById("date1").focus;
										return false;
									}
								}
					    }
		        }
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
</script>


<script type="text/javascript">
												
</script>

</head>

<%! Connection conn = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5 = null;
	
	String date1 = "";
	String date2 = "";
	String from ="";
	String to ="";
	String fromdate="";
	String todate="";
	
	String time1 = "";
	String time2 = "";
	String time3="";
	String time4="";
	
	String vehno="";
%>

<%
//String statusname="";
	String  default_date_1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date());
	String  hh=new SimpleDateFormat("HH").format(new Date());
	
	int hh1=Integer.parseInt(hh);
	int hh2=hh1-2;
	
	String default_date_3 = new SimpleDateFormat("dd-MMM-yyyy ").format(new Date());
	
	
	String  default_date_5 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date());
	String  mm=new SimpleDateFormat("mm").format(new Date());
	
	int mm1=Integer.parseInt(mm);
	int mm2=mm1;
	
	
	
	
	default_date_3=default_date_3+""+hh2+":"+mm2;
	
	
	String defaultDate2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date());
	System.out.println("The default date is ==>"+default_date_3);
	
	System.out.println("The default_date_1  is ==>"+default_date_1);
	
	
	
	
	date1=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(default_date_3)); 
	date2= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(default_date_1)); 
	
%>	

<%
String vehlist = "";
try{
	
	String frompage = request.getParameter("frompage");
	vehlist = session.getAttribute("VehList").toString();
	//System.out.println("The vehicle list>>>>"+vehlist);

	if(frompage!=null && frompage.equalsIgnoreCase("OS"))
	{
		String thedate = request.getParameter("data");
		String thedate1 = request.getParameter("data1"	);
		date1 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate));
		time1 = new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate));
		date2 = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate1));
		time2 = new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate1));
	}
	else
	{
	 System.out.println("In else date");
		 date1 = request.getParameter("data");
		 date2 = request.getParameter("data1");
		 from= request.getParameter("from");
		// fromdate= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(from));
		// time3= new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(from));
		 
		 
		 to= request.getParameter("to");
		// todate= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(to));
		// time4= new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(to));
		 
	 System.out.println("date1 "+date1);
	 System.out.println("date2 "+date2);
	 System.out.println("From "+from);
	 System.out.println("To "+to);
	// time1 =":00";
	 
	 
	 
	// time2 = ":59";
	}
	
	 Class.forName(MM_dbConn_DRIVER);
	 conn = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	 st = conn.createStatement();
	 st1 = conn.createStatement();
	 st2 = conn.createStatement();
	 st3 = conn.createStatement();
	 st4 = conn.createStatement();
	 st5 = conn.createStatement();
	 
	 //statusname=request.getParameter("status");
	 //System.out.println("statusname "+statusname);
// 	 if(statusname==null)
// 	 {
// 	 	statusname="All";
// 	 }
// 	 System.out.println("statusname "+statusname);
	 System.out.println("  Date1 ==>"+date1+ "Date2 ==>"+date2);

}catch(Exception e){
	System.out.println("Exception "+e);
}
%>
<body>
<%@ include file="headernew.jsp"%>

<div class="div1"><font color="black" size="3" face="Arial"><b>Camera Report</b></h2>
</div>

<div align="center">
<form id="camera_jpg_report" name="camera_jpg_report" action="CameraSlideReport.jsp" method="post" onsubmit="return datevalidate(); ">
<table  style="width: 70%;">
	<tr>
<!-- 		<td style="width: 100px"><b>&nbsp;&nbsp;Range: </b></td> -->
<!-- 		<td> -->
<!-- 			 <div align="left"><font color="black" size="2" face="Arial"> <b>Range:</b>&nbsp;&nbsp; -->
<!-- 			 </font></div> -->
<!-- 			</td> -->
	<td>
			 <div align="center"><font color="black" size="2" face="Arial"> <b>From:</b>&nbsp;&nbsp;
			 <input type="text" id="MdateF" name="from"  value="<%if(date1==null){ %><%=from%><%}else{%><%=new SimpleDateFormat("dd-MMM-yyyy hh:MM").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1))%><%}%>"  class="datetimepicker" style="width: 130px;"    readonly/></font></div>
		</td>  
 		<td style="width: 100px"><b>&nbsp;&nbsp; </b></td> 
  			  <td>
			 <div align="left"><font color="black" size="2" face="Arial"> <b>To:</b>&nbsp;&nbsp;
			 <input type="text" id="MdateT" name="to"  value="<%if(date2==null){ %><%=to%><%}else{%><%=new SimpleDateFormat("dd-MMM-yyyy hh:MM").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2))%><%}%>"  class="datetimepicker" style="width: 130px;"    readonly/></font></div>
		</td> 

	


	<td align =left>
	<div align="left"><font color="black" size="2" face="Arial"> <b>Vehicle:</b>&nbsp;&nbsp;
	<select name="Vehicle1" class="element select medium" style="width: 120px" id="Unit1" >
<%
	String VehNo1="";
	VehNo1 = request.getParameter("Vehicle1");
	System.out.println("Vehicle1 "+VehNo1);

	//  Change here
	///String unit = "Select a.VehicleRegNumber as vehno from db_gps.t_vehicledetails a,db_gps.t_jpgsnap b  where a.unitid = b.unitid and  a.VehicleCode in "+vehlist+" and a.status='-' group by a.VehicleRegNumber order by VehicleRegNumber ";
	String unit = "Select a.VehicleRegNumber as vehno from db_gps.t_vehicledetails a,db_gps.t_jpgsnap b  where a.vehiclecode = b.vehid and  a.VehicleCode in "+vehlist+" and a.status='-' group by a.VehicleRegNumber order by VehicleRegNumber ";
	 
	System.out.println("taking vehicel list   "+unit);
	ResultSet rstunit=st1.executeQuery(unit);
	System.out.println("unit is "+unit);
	while(rstunit.next())
	{	
		vehno = rstunit.getString("vehno") ;
		System.out.println("Query veh no  "+vehno);

		if(null != VehNo1)
			{  System.out.println("in IF veh no  "+vehno);
			%>
			<option value="<%=vehno%>" <% if(VehNo1.equals(vehno)){ %>Selected<% } %>><%=vehno%></option>
			<%
			}else
			{
				%><option  value="<%=vehno%>" ><%=vehno %></option> <%
				VehNo1=vehno;
				System.out.println("in else veh no  "+vehno);
			}
		
	} %>
	</select>
	</font>
	</div>
	</td> 
	
	<td align =left>
	<div align="left"><font color="black" size="2" face="Arial"> <b>Category:</b>&nbsp;&nbsp;
	<select name="cat" class="element select medium" style="width: 80px" id="cat" >
<%
	String category = "";
	String cat11 = "";
	System.out.println("before category");
	category = request.getParameter("cat");
	System.out.println("category "+category);
	System.out.println("after category");
	if(category.equals("Cabin,Road")){
		System.out.println("In if category");
		category="('Cabin','Road')";
	}
	
	
	
	
	
	
	String cat = "";
	String sqlcat = "Select DISTINCT(category) from db_gps.t_jpgsnap where category <> '-'  order by category ASC";
	ResultSet rstcat = st4.executeQuery(sqlcat);
	System.out.println("sql category "+sqlcat);
	while(rstcat.next())
	{	
		cat = rstcat.getString("category") ;
		if(null != category)
			{
			%>
			<option value="<%=cat%>" <% if(category.equals(cat)){ %>Selected<% } %>><%=cat%></option>
			<%
			}else
			{
				%><option  value="<%=cat%>" ><%=cat %></option> <%
				category="Cabin";
			}
			
	} %>
	</select>
	</font>
	</div>
	</td> 
		
		<td align =left>
	<div align="left"><font color="black" size="2" face="Arial"> <b>Type:</b>&nbsp;&nbsp;
	<select name="type" class="element select medium" style="width: 80px" id="type" >
	<%
	
	String type="";
	String typ1="";
	type= request.getParameter("type");
	
	type= request.getParameter("type");
	System.out.println("Type="+type);
	
	
	
	
	String typ = "";
	String typnw="";
	String sqlcat1 = "Select DISTINCT(type) from db_gps.t_jpgsnap order by type ASC";
	ResultSet rstcat1 = st5.executeQuery(sqlcat1);
	System.out.println("sql type "+sqlcat1);
	while(rstcat1.next())
	{	
		typ = rstcat1.getString("type") ;
		if(typ.equals("-")){
			typnw="Other";
		}else
			typnw = rstcat1.getString("type") ;

			
		if(null != type)
			{
			%>
			<option value="<%=typ%>" <% if(type.equals(typ)){ %>Selected<% } %>><%=typnw%></option>
			<%
			}else
			{
				%><option  value="<%=typ%>" ><%=typnw %></option> <%
				type="Incident";
			}
			
	} %>
	</select>
	</font>
	</div>
	</td> 
		
		<td>		
			<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black; vertical-align: "  class="formElement">
		</td>
		</tr>
		</table>	

<% 
String Unitid="All";
 %>
 
 <%
 //System.out.println("The category is11 ==>"+category);
 if(null != category)
 {
	 if(category.equals("Road") || category == "Road" || category.equals("-") || category == "-" )
	 {
	 	category = "('"+category+"')";
	 	cat11 = "Road";
	 }
	 else{
		 category = "('"+category+"')";
		 cat11 = "Cabin";
	 }
 }
 
 if(null != type)
 {
	 if(type.equals("Incident") || type == "Incident")
	 {
	 	type = "('"+type+"')";
	 	typ1 = "Incident";
	 }
	 if(type.equals("-") || type == "-"){
		 type = "('"+type+"')";
		 type= "-";
	 }
	 else{
		 type = "('"+type+"')";
		 typ1 = "Exception";
	 }
 }
 
 
 if(category.contains(")")  || category.contains("("))
	{
		
		category=category.replace(")","");
		category=category.replace("(","");
		category=category.replace("'","");
		
		
	}
 if(type.contains(")")  || type.contains("("))
	{
		
		type=type.replace(")","");
		type=type.replace("(","");
		type=type.replace("'","");
		
		
	}
	
	System.out.println("@@@@@@@@==AFTER>"+type);
	
 
 
 //System.out.println("The category is22 ==>"+category);
 %>
</form>
</div>

<%

 	//if(date1==null || date2==null){
			
 	//	date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(default_date_1));
 	//	date2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(defaultDate2));
 	//}
 	if(date1!=null || date2!=null){
		//System.out.println("in else");
		
	//	date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(date1));
	//	date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(date2));
	}
 	else
 	{

 		date1= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(default_date_3)); 
 		date2= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(default_date_1)); 
	
 	}
%>	

<%
	
			 String condition = "And unitid = (select unitid from db_gps.t_vehicledetails where VehicleRegNumber = '"+VehNo1+"' and status='-' ) ";	

%>		 

<%


	System.out.println("in if part -----------------------------------");	
	String unitt = "";
	String vehid="";
	//category="cabin";
	String sqlunit = "select unitid,vehiclecode from db_gps.t_vehicledetails where VehicleRegNumber = '"+VehNo1+"' and status='-' ";
	System.out.println(" sqlunit "+ sqlunit);
	
	ResultSet rsunit = st2.executeQuery(sqlunit);
    if(rsunit.next())
    {
    	 unitt = rsunit.getString("unitid");		
    	 vehid = rsunit.getString("vehiclecode");
    }
    
    //Get the count of images
int count = 0;
String sqlcnt="";
if(category.equals("Cabin,Road")){
	// sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+date1+" "+time1+"' AND snapdatetime <= '"+date2+" "+time2+"' AND jpgfilename not like  '%pod%' "+condition+" ";
	 sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+date1+" "+time1+"' AND vehid='"+vehid+"' ";
}else{
	if(request.getParameter("data")==null || request.getParameter("data1")==null ){
		
		System.out.println("in Date null");
		//sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" ";
		sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND vehid='"+vehid+"' ";
		
	}else{
		System.out.println("Inelse");
		//sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" ";
		//sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+date1+" "+time1+"' AND snapdatetime <= '"+date2+" "+time2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" ";
		sqlcnt = "Select count(*) as cnt from db_gps.t_jpgsnap where snapdatetime >= '"+date1+" "+time1+"' AND snapdatetime <= '"+date2+" "+time2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND vehid='"+vehid+"' ";
		}
	}

System.out.println("Count of Images "+sqlcnt);
ResultSet rscount = st3.executeQuery(sqlcnt);
if(rscount.next())
{
	count = rscount.getInt("cnt"); //mining job 
} 

System.out.println("count==>"+count);	

%> 

<%if(count > 0) {

%>
<br>
 <div align="center">
 <table  style="width: 70%;">
<tr style="background-color: white;">
<td align = "right" colspan="8" style="background-color: white;"><div align="right" style="background-color: white;"><font size="2" face="Arial" ><a href="CameraImageReport.jsp?data=<%=date1+time1 %>&data1=<%= date2+time2%>&VehNo1=<%= VehNo1%>&category=<%=category %>&type=<%=type %>" target="_blank" >Detailed Report</a></font></div></td>
</tr>
</table>
<table  style="width: 70%;">

<tr>

		<td>
			 <div align="center"><font color="black" size="2" face="Arial"> <b>From:</b>&nbsp;&nbsp;
			 	<% if(request.getParameter("data")==null || request.getParameter("data1")==null){ %>
			 	<%=from%>
			 	<%}else{ %>
			 	<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1+time1))  %></font>
			 	<%} %>
			 </div>
		</td>
		<td>
			 <div align="left"><font color="black" size="2" face="Arial"> <b>To:</b>&nbsp;&nbsp;
			 <% if(request.getParameter("data")==null || request.getParameter("data1")==null){ %>
			 <%=to%>
			 <%}else{ %>
			 <%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2+time2)) %></font>
			 <%} %>
			 </div>
		</td>
		<td align =left>
			<div align="left"><font color="black" size="2" face="Arial"> <b>Vehicle:</b>&nbsp;&nbsp;
			<%= VehNo1 %></font>
			 </div>
		</td>
		<td align =left>
			<div align="left"><font color="black" size="2" face="Arial"> <b>Unit:</b>&nbsp;&nbsp;
			<%=unitt %></font>
			 </div>
		</td>
		<td align =left>
			<div align="left"><font color="black" size="2" face="Arial"> <b>Category:</b>&nbsp;&nbsp;
			<%=cat11 %></font>
			 </div>
			
			<td align =left>
			<div align="left"><font color="black" size="2" face="Arial"> <b>Type:</b>&nbsp;&nbsp;
			<%=type %>
			
			
			
			</font>
			 </div>
		</td>
		<td align =left>
			<div align="left"><font color="black" size="2" face="Arial"> <b>Total:</b>&nbsp;&nbsp;
			<%=count %></font>
			 </div>
		</td>
		

</tr>
</table>
</div>
 <br></br>
 <br></br>
 
    
<div id="container">
    <div id="left">
    <div id="sliderFrame"><h2 style= "font:normal 16px Arial,Helvtica,sans-serif;"><b>Cabin</b>
       
        <div id="slider" style="border:10px solid #000;"> 
         
            <%
            String sql="";
        	if(category.equals("Cabin,Road") || category.equals("Cabin")){
        		//category="Cabin";
        	System.out.println("Hi");
        		// sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND snapdatetime <= '"+date2+time2+"'  AND jpgfilename not like  '%pod%' "+condition+" Order by snapdatetime ASC";	
        	 sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND category in ('Cabin') AND snapdatetime <= '"+date2+time2+"'  AND vehid='"+vehid+"' Order by snapdatetime ASC";
        	}else{
        		
        	if(request.getParameter("data")==null || request.getParameter("data1")==null){
        		System.out.println("in Date null");
        	//	sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" Order by snapdatetime ASC";
        		sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND vehid ='"+vehid+"' Order by snapdatetime ASC";
        		
        	}else{
        		
        	System.out.println("Inbellow else");
        		//sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND snapdatetime <= '"+date2+time2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" Order by snapdatetime ASC";
        	sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND snapdatetime <= '"+date2+time2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND vehid='"+vehid+"' Order by snapdatetime ASC";
        		}
        	
        	}
    		System.out.println("The sql in if==>"+sql);
    		ResultSet rs = st.executeQuery(sql);
    		System.out.println("The sql is  After==>"+sql);
    		while(rs.next()){
    			
    			String  unitid = rs.getString("unitid");
    			String  jpgfilename = rs.getString("jpgfilename");
    			String  snapdatetime = rs.getString("rawfiledatetime");
    			if(category.equals("Cabin,Road") || category.equals("Cabin")){
       			%>
       			
       			<img  src="http://myfleetview.com:8080/images1/ProcessedCameraImages/<%=jpgfilename%>"  />
         <%
    			}else{
    				%>
           			
           			<img  src="NoImage.png"  />
             <%
    			}
    		}
    		
        	%>

        </div>
      
      
       
        <!--Custom navigation buttons on both sides-->
        <div class="group1-Wrapper">
            <a onclick="imageSlider.previous()" class="group1-Prev"></a>
            <a onclick="imageSlider.next()" class="group1-Next"></a>
        </div>
        <!--nav bar-->
        <div style="text-align:center;padding:20px;z-index:20;">
            <a onclick="imageSlider.previous()" class="group2-Prev"></a>
            <a id='auto' onclick="switchAutoAdvance()"></a>
            <a onclick="imageSlider.next()" class="group2-Next"></a>
        </div>
    </div>
    </div>
    <div id="right">
    <div id="sliderFrame"><h2 style= "font:normal 16px Arial,Helvtica,sans-serif;"><b>Road</b>
       
        <div id="slider1" style="border:10px solid #000;">
         
            <%
            String sql1="";
        	if(category.equals("Cabin,Road") || category.equals("Road")){
        		//category="Road";
        	System.out.println("Hi1");
        		// sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND snapdatetime <= '"+date2+time2+"'  AND jpgfilename not like  '%pod%' "+condition+" Order by snapdatetime ASC";	
        	 sql1 = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND category in ('Road') AND snapdatetime <= '"+date2+time2+"'  AND vehid='"+vehid+"' Order by snapdatetime ASC";
        	}else{
        		
        	if(request.getParameter("data")==null || request.getParameter("data1")==null){
        		System.out.println("in Date null1");
        	//	sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" Order by snapdatetime ASC";
        		sql1 = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(from))+"' AND snapdatetime <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(to))+"' AND category in ('"+category+"') and type in ('"+type+"')  AND vehid ='"+vehid+"' Order by snapdatetime ASC";
        		
        	}else{
        		
        	System.out.println("Inbellow else1");
        		//sql = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND snapdatetime <= '"+date2+time2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND jpgfilename not like  '%pod%' "+condition+" Order by snapdatetime ASC";
        	sql1 = "Select unitid,jpgfilename,rawfiledatetime, snapdatetime from db_gps.t_jpgsnap where snapdatetime >= '"+date1+time1+"' AND snapdatetime <= '"+date2+time2+"' AND category in ('"+category+"') and type in ('"+type+"')  AND vehid='"+vehid+"' Order by snapdatetime ASC";
        		}
        	
        	}
    		System.out.println("The sql in if==>"+sql1);
    		ResultSet rs1 = st.executeQuery(sql1);
    		System.out.println("The sql is  After==>"+sql1);
    		while(rs1.next()){
    			
    			String  unitid1 = rs1.getString("unitid");
    			String  jpgfilename1 = rs1.getString("jpgfilename");
    			String  snapdatetime1 = rs1.getString("rawfiledatetime");
    			if(category.equals("Cabin,Road") || category.equals("Road")){
       			%>
       			
       			<img  src="http://myfleetview.com:8080/images1/ProcessedCameraImages/<%=jpgfilename1%>"  />
         <%
    			}else{
    				%>
           			
           			<img  src="NoImage.png"  />
             <%
    			}	
    		}
    		
        	%>

        </div>
      
      
       
        <!--Custom navigation buttons on both sides-->
        <div class="group1-Wrapper">
            <a onclick="imageSlider1.previous()" class="group1-Prev"></a>
            <a onclick="imageSlider1.next()" class="group1-Next"></a>
        </div>
        <!--nav bar-->
        <div style="text-align:center;padding:20px;z-index:20;">
            <a onclick="imageSlider1.previous()" class="group2-Prev"></a>
            <a id='auto1' onclick="switchAutoAdvance1()"></a>
            <a onclick="imageSlider1.next()" class="group2-Next"></a>
        </div>
    </div>
    </div>
  </div>

    
   <%} else{
   
   
	System.out.println("ELSE OF QUERy=>");
   %> 
   
   <div>       
            No data       
    </div>
   
   <%} %>


    <script type="text/javascript">
        //The following script is for the group 2 navigation buttons.
        function switchAutoAdvance() {
            imageSlider.switchAuto();
            switchPlayPauseClass();
        }
        function switchPlayPauseClass() {
            var auto = document.getElementById('auto');
            var isAutoPlay = imageSlider.getAuto();
            auto.className = isAutoPlay ? "group2-Pause" : "group2-Play";
            auto.title = isAutoPlay ? "Pause" : "Play";
        }
        switchPlayPauseClass();
        function switchAutoAdvance1() {
            imageSlider1.switchAuto();
            switchPlayPauseClass1();
        }
        function switchPlayPauseClass1() {
            var auto = document.getElementById('auto1');
            var isAutoPlay = imageSlider1.getAuto();
            auto.className = isAutoPlay ? "group2-Pause" : "group2-Play";
            auto.title = isAutoPlay ? "Pause" : "Play";
        }
        switchPlayPauseClass1();
    </script>

 <br></br> 
 
 
 
 
  
<%@ include file="footernew.jsp" %>    
</body>
</html>
</jsp:useBean>
 

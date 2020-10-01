<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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

<%@ include file="headercallcenter.jsp" %>
<html>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<head>
<title>Vehicle Tracking System </title>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>

<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>

</head>

<body background="images/green_grad_bot.jpg" onload="focusChild();">

<form name="tripend" action="" method="post" onSubmit="return validate();">
<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER5);
con1 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);

Statement stmt1=con1.createStatement();
Statement stquery=con1.createStatement();
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="";

String location="", latitu="", longi="";

String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehno");

java.util.Date d=new java.util.Date();
String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
int hours=(d.getHours());
int minutes=(d.getMinutes());

String loginuser=session.getValue("user").toString();
	String user=session.getValue("usertypevalue").toString();
	String tripid=request.getParameter("tripid");
	
		
	String enddate=request.getParameter("calender1");
	String endhrs=request.getParameter("endtime1");
	String endmin=request.getParameter("endtime2");
	String endtime=endhrs+":"+endmin+":00";	
	
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
		<table border="0" width="100%">
			<tr>
				<td align="center"> <font color="maroon"> <B>Trip End information for this Trip has already been entered. </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font color="maroon"> <B> Note: </B> Please refresh 'Current Position' page to reflect the changes. </font> </td>
			</tr>	
			</table>
<%	}
	else
	{

%>

<table border="1" width="100%" class="stats">
     <tr>
	<td colspan="2" align="center"> <font color="maroon"> <B> Trip End Information of <%=vehno%> </B> </font> </td>
     </tr>		
     <tr>
	<td> <font color="maroon"> Arrival Date </font> </td>
	<td> <input type="text" id="calender1" name="calender1" size="13"  class="formElement" value="<%=nwfrmtdte%>" readonly/>
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="button" name="trigger1" id="trigger1" value="Date"  class="formElement" >
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
	<td> <font color="maroon"> Arrival Time </font> </td>
	<td> <font color="maroon">
	            HH : </font> <select name="endtime1" class="formElement" onChange="showlocation(this, <%=vehiclecode%>, '<%=vehno%>');">
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
            	 </select>  <font color="maroon">
        		MM :</font> <select name="endtime2" onChange="showlocation(this, <%=vehiclecode%>, <%=vehno%>);" class="formElement">
            
	                  <option value="00" <% if(minutes > 00 & minutes < 05) { %> Selected <% } %>>00</option>
        	          <option value="10" <% if(minutes > 05 & minutes < 15) { %> Selected <% } %>>10</option>
        	          <option value="20" <% if(minutes > 15 & minutes < 25) { %> Selected <% } %>>20</option>
        	          <option value="30" <% if(minutes > 25 & minutes < 35) { %> Selected <% } %>>30</option>
        	          <option value="40" <% if(minutes > 35 & minutes < 45) { %> Selected <% } %>>40</option> 
        	          <option value="50" <% if(minutes > 45) { %> Selected <% } %>>50</option>
        	          
        	    </select> &nbsp;&nbsp;&nbsp;
                 
	</td>
     </tr>	
     </tr>
	<td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td> 
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
<table border="0" width="100%">
     <tr>
	<td colspan="2" align="left"> <B> <font color="maroon"> Location at selected time is: </font> 
	<a href="shownewmap.jsp?lat=<%=latitu%>&long=<%=longi%>&discription=<%="<b>" + vehno + "</b><br>"%><%=location%>" onclick="popWin = open('shownewmap.jsp?lat=<%=latitu%>&long=<%=longi%>&discription=<%="<b>" + vehno + "</b><br>"%><%=location%>','myWin','width=500,height=500');popWin.focus();return false"> <%=location%> </a> 


 </b> </td>
     </tr>		
</table>
</div>


<table border="0" width="100%">
     <tr>
	<td colspan="2" align="center"><a href="javascript:window.close();">Close </a> </td>
     </tr>		
</table>


<%
	String vehcode="", vehreg="", stplace="", endplace="", stdate="", sttime="", driverid="", drivername="", stcode="", endcode="";
	double stlat=0, stlong=0, endlat=0, endlong=0;

		sql1="select * from t_startedjourney where TripId='"+tripid+"' ";
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			vehcode=rs1.getString("Vehid");
			vehreg=rs1.getString("VehRegNo");
			stplace=rs1.getString("StartPlace");
			endplace=rs1.getString("EndPlace");			
			stdate=rs1.getString("StartDate");
			sttime=rs1.getString("StartTime");
			driverid=rs1.getString("DriverCode");
			drivername=rs1.getString("DriverName");
			stcode=rs1.getString("StartCode");
			endcode=rs1.getString("EndCode");
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
			sql2="insert into t_completedjourney (TripId, VehId, VehRegNo, StartPlace, StartDate, StartTime, EndPlace, EndDate, EndTime, JourneyStatus, DriverId, DriverName, OwnerName, GPName) values ('"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stdate+"', '"+sttime+"', '"+endplace+"', '"+enddate+"', '"+endtime+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+user+"', '"+user+"') ";   

		/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		/*****************************/
			  stmt1.executeUpdate(sql2);

			  sql3="update t_startedjourney set JStatus='Completed' where TripID='"+tripid+"' ";
			  
			  /*Query to insert query in db_gps.t_sqlquery table*/
				String abcd1=sql3.replace("'","#");
				abcd1=abcd1.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
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
				<td align="center"> <font color="maroon"> <B>Successfully Done </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font color="maroon"> <B> Note: </B> Please refresh 'Current Position' page to reflect the changes. </font> </td>
			</tr>	
			</table>

<%
		
	} //close of outer else
} //close of MAIN ELSE


} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
} 
  
%>

</form>
</body>
</html>

	

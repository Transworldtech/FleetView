<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link> 
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<%@ include file="Connections/conn.jsp" %>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<script type="text/javascript">
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
	      var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.last24hours.action ="excel.jsp";
          document.forms["last24hours"].submit();
}
</script>
<%!
Connection con=null;
Statement st=null;
Statement st1=null;
Statement st2=null;
Statement st6=null;
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Driver Incentive Trip Details</title>


</head>
<%
try{
con = fleetview.ReturnConnection();
st=con.createStatement();
st1=con.createStatement();
st2=con.createStatement();	
st6=con.createStatement();
%>
<body>
<%
String driverid=request.getParameter("driverid");
String category = request.getParameter("category");
String month = request.getParameter("month");
String month1 = request.getParameter("month1");
java.util.Date NewDate =new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000* 60 *60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
Format NewFormatter1 = new SimpleDateFormat("dd-MMM-yyyy");
int monthcount=  0;
String sqlmonth = "SELECT TIMESTAMPDIFF(MONTH, '"+month+"', '"+month1+"') as monthno";
ResultSet rsmonth = st.executeQuery(sqlmonth);
if(rsmonth.next())
{
	monthcount = rsmonth.getInt("monthno")+1;
	System.out.println("Monthcount    "+rsmonth.getInt("monthno"));
}

String exportFileName=session.getAttribute("user").toString()+"_DriverIncentiveForTankerReport.xls";  
%>
<form id="last24hours" name="last24hours" action="" method="post" >

<div align="left">
<table style="width: 750px;" > 
<tr>
<td colspan="2">
             <table border="0" width="90%" align="center" >
	             <tr align="center">
	                <td colspan="14" align="center"><input type="hidden" name="type" id="type" value="More Info"/>
		               <!-- <div align="left"><font size="3">Report No:3.0</font></div>-->
		               <font size="3"><b>Driver Incentive Calculation </b></font>
	               </td>
	             </tr>
                 
                 <tr align="center">
                 <td align="left">
                     
                      <font size="2" color="BLACK"> Disclaimer : The Calculated Amount may change if there is a change in the status or count of Violation</font> 
                    
                       </td> 
         
                   </tr> 
             </table>
</td>
</tr>
<tr >
<td valign="top" width="30%">
<%

	 %>
<table width="30%" class="sortable" style="width: 400px;">
<%
int i71=0;
String sql71="SELECT * FROM db_gps.t_DriverIncentive WHERE GPName = 'Castrol'";
ResultSet rs71 = st6.executeQuery(sql71);
if(rs71.next())
{	%>	
	<tr>
	<th colspan="4">
	Driver Incentive Card Rules For Primary and Secondary
	</th>
	</tr>
	<tr class="cbFormTableRow">
	<th rowspan="2">SrNo</th>
	<th colspan="2">Parameter</th>
	<th  rowspan="2" width="95px">Points</th>
	</tr>
	<tr class="cbFormTableRow">
	
	<th width="250px">Catagory</th>
	<th width="95px">Range</th>
		</tr>	
	<%
rs71.previous();
int MaxDVI=0,MaxJRM=0;
while(rs71.next())
{
if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI") || rs71.getString("ScoreCategory").equalsIgnoreCase("JRM") )
{
	System.out.println(" in if :");
	i71++;
	%>
	<tr class="cbFormTableRow">
	<td><%=i71 %></td>
	<td><div align="left"><%=rs71.getString("ScoreCategory") %></div></td>
	<% if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI"))
	{
		if(rs71.getInt("Points")>MaxDVI)
		{			MaxDVI=rs71.getInt("Points");			
		}
	%>
	<td><%=rs71.getString("MinValue") %>-<%=rs71.getString("MaxValue") %></td>
	<%
	}
	else if (rs71.getString("ScoreCategory").equalsIgnoreCase("JRM"))
	{
		if(rs71.getInt("Points")>MaxJRM)
		{			
			MaxJRM=rs71.getInt("Points");
			System.out.println(" MaxJRM : "+MaxJRM);
		}
		System.out.println(" MaxJRM : "+MaxJRM);
	%>
		<td>NA</td><%	
	}
	else 
	{%>
		<td>NA</td><%	
	}
	%>	
	<td><%=rs71.getString("Points") %></td>
	</tr>	
	<%}

}
%>
<tr>
<td colspan="3">Total</td>
<%
System.out.println("Max DVI : "+MaxDVI+" MaxJRM : "+MaxJRM);
%> 
<td><% out.print(MaxJRM+MaxDVI); %></td>
</tr>


	<tr class="cbFormTableRow">
	<th >SrNo</th>
	<th >Category</th>
	<th  width="95px">Range</th>
	<th  width="95px">Maximum Earning Potential</th>
	
	</tr>

<%
i71=0;
rs71.last();
while(rs71.previous())
{
if(rs71.getString("ScoreCategory").equalsIgnoreCase("MaxIncentiveKM") )
{
	i71++;
	%>
	<tr class="cbFormTableRow">
	<td><%=i71 %></td>
	<td><div align="left"><%=rs71.getString("KmsCategory") %></div></td>
	<td><%=rs71.getString("MinValue") %>-<%
	if(rs71.getString("MaxValue")=="10000"||rs71.getString("MaxValue").equalsIgnoreCase("10000"))
	{out.print("and More");		
	}
	else
	{
		out.print(rs71.getString("MaxValue"));
	}
		%></td>
	
	<td><%=rs71.getString("Points") %></td>
	</tr>	
	<%}

}




}
%>
</table>
</td>
<td  valign="top">
<%
	 %>
	 <table width="30%" class="sortable" style="width: 400px;">
	 <%
	 i71=0;
	 sql71="SELECT * FROM db_gps.t_DriverIncentive WHERE GPName = 'Castrol'";
	 rs71 = st6.executeQuery(sql71);
	 if(rs71.next())
	 {	%>	
	 	<tr>
	 	<th colspan="4">
	 	Driver Incentive Card Rules For Tanker
	 	</th>
	 	</tr>
	 	<tr class="cbFormTableRow">
	 	<th rowspan="2">SrNo</th>
	 	<th colspan="2">Parameter</th>
	 	<th  rowspan="2" width="95px">Points</th>
	 	</tr>
	 	<tr class="cbFormTableRow">
	 	
	 	<th width="250px">Catagory</th>
	 	<th width="95px">Range</th>
	 		</tr>	
	 	<%
	 rs71.previous();
	 int MaxDVI=0,MaxJRM=0;
	 while(rs71.next())
	 {
	 if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI") || rs71.getString("ScoreCategory").equalsIgnoreCase("JRM") )
	 {
	 	System.out.println(" in if :");
	 	i71++;
	 	%>
	 	<tr class="cbFormTableRow">
	 	<td><%=i71 %></td>
	 	<td><div align="left"><%=rs71.getString("ScoreCategory") %></div></td>
	 	<% if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI"))
	 	{
	 		if(rs71.getInt("Points")>MaxDVI)
	 		{			MaxDVI=rs71.getInt("Points");			
	 		}
	 	%>
	 	<td><%=rs71.getString("MinValue") %>-<%=rs71.getString("MaxValue") %></td>
	 	<%
	 	}
	 	else if (rs71.getString("ScoreCategory").equalsIgnoreCase("JRM"))
	 	{
	 		if(rs71.getInt("Points")>MaxJRM)
	 		{			
	 			MaxJRM=rs71.getInt("Points");
	 			System.out.println(" MaxJRM : "+MaxJRM);
	 		}
	 		System.out.println(" MaxJRM : "+MaxJRM);
	 	%>
	 		<td>NA</td><%	
	 	}
	 	else 
	 	{%>
	 		<td>NA</td><%	
	 	}
	 	%>	
	 	<td><%=rs71.getString("Points") %></td>
	 	</tr>	
	 	<%}

	 }
	 %>
	 <tr>
	 <td colspan="3">Total</td>
	 <%
	 System.out.println("Max DVI : "+MaxDVI+" MaxJRM : "+MaxJRM);
	 %> 
	 <td><% out.print(MaxJRM+MaxDVI); %></td>
	 </tr>


	 	<tr class="cbFormTableRow">
	 	<th >SrNo</th>
	 	<th >Category</th>
	 	<th  width="95px">Range</th>
	 	<th  width="95px">Maximum Earning Potential</th>
	 	
	 	</tr>

	 <%
	 i71=0;
	 rs71.last();
	 while(rs71.previous())
	 {
	 if(rs71.getString("ScoreCategory").equalsIgnoreCase("MaxTankerIncentive") )
	 {
	 	i71++;
	 	%>
	 	<tr class="cbFormTableRow">
	 	<td><%=i71 %></td>
	 	<td><div align="left">Maximum earning potential </div></td>
	 	<td>-</td>
	 	
	 	<td><%=rs71.getString("Points") %></td>
	 	</tr>	
	 	<%}

	 }




	 }
	 %>
	
	 </table >

</td>
</tr>

<tr align="center" > 
<td colspan="2" align="center">

<div align="center" style="width: 500px;">

<table border="2"  class="stats">
<tr >

<td colspan="2" align="left"><div align="left">
Points for trip are forfeited : </div></td>
<td colspan="2" align="right"><div align="left">
1. Absence of registered Cleaner</div> </td>
 </tr>
<tr>
<td colspan="2" align="right"></td>
<td colspan="2" align="right"><div align="left">
2. GPS Disconnection </div></td>
</tr>
<tr>
<td colspan="2"></td>
<td colspan="2" align="left"><div align="left">
3. ND, CD, Stoppages, DH </div></td>
	</tr>
	<tr>
	<tr >

<td colspan="2" align="left"><div align="left">
Points for quarter are forfeited : </div></td>
<td colspan="2" align="right"><div align="left">
1. If our driver fails to report an incident</div> </td>
 </tr>
<tr>
<td colspan="2" align="right"></td>
<td colspan="2" align="right"><div align="left">
2. If our driver fails to take steps to avoid an incident </div></td>
</tr>
</table>
</div>
</td>
</tr>

<%
}
catch(Exception e)
{
}
finally
{

	try
	{fleetview.closeConnection();}
	catch(Exception e)
	{}

}
%>
</table>
</div>
</form>

</body>
</html>
</jsp:useBean>

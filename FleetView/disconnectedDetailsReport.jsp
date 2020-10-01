<%@page import="java.sql.*" import="java.sql.DriverManager"
	import="java.sql.ResultSet" import="java.sql.Statement"%>
<%@ include file="headernew.jsp"%>
<html>
<head>

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
	var originalContents = document.body.innerHTML; 
	var input = document.getElementsByTagName("a");
    var count = input.length;
    for(var i =0; i < count; i++)
    {
         document.getElementsByTagName("a")[i].removeAttribute("href");
    }
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.Total_os.action ="excel.jsp";
          document.forms["Total_os"].submit();
     	 document.body.innerHTML = originalContents; 
 }  
</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
	try{
     //System.out.println("Hi!!!");
	String user = session.getAttribute("usertypevalue").toString();
	Connection conn1 = null;
	Statement st = null;
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st =  conn1.createStatement();
	
	String vehicleCode = request.getParameter("vehicleCode");
	String VehicleRegNo = request.getParameter("VehicleRegNo");
	String fromDateTime = request.getParameter("fromDateTime");
	//out.println("fromDateTime:-"+fromDateTime);
	String toDateTime = request.getParameter("toDateTime");
	//out.println("toDateTime:-"+toDateTime);
	String ownerName = request.getParameter("ownerName");
	String  exportFileName=request.getParameter("ownerName").toString()+"_disconnectionDetails.xls";

	int discounter=0;
    if(request.getParameter("counterv")!=null)
    {
	  String str=request.getParameter("counterv");
	  //System.out.println("\n\n\nstr---->>>>>-->>"+str);
      discounter=Integer.parseInt(str);
      //System.out.println("\n\n\n---->>>>>-->>"+discounter);
    }
    
	SimpleDateFormat sd1 = new SimpleDateFormat("dd-MMM-yyyy");
	SimpleDateFormat sd2 = new SimpleDateFormat("dd-MMM-yyyy");
	%>
	
	
<form id="Total_os" name="Total_os" action="" method="post">

<table border="0" width="100%" class="stats">
	<tr>
		<td>
		

		<div id="mytable">
	
	
	
	
	
<table width="100%" border="0" align="center" class="stats">	

	<tr>
		<td colspan="3" align="center"><font size="3" face="Arial"><b>Fleet
		Disconnection Report for <%=user%> &nbsp;Vehicle Registration
		 No.: <%=VehicleRegNo%>&nbsp; From:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime))%>&nbsp;To:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime))%></font> 
		<%-- No.: <%=VehicleRegNo%>&nbsp; From:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(fromDateTime))%>&nbsp;To:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(toDateTime))%></font> --%>
		</b><div align="right">
		<input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a>
        &nbsp;&nbsp;&nbsp;<font size="2"> Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) %></font>
</td></div>
	</tr>
</table>
<table border="1" width="100%" class="sortable">
	<tr>

		<td class="hed">
		<div class="bodyText"><b> Sr. </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> Transporter </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> VehicleRegNumber </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>OFF Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>From Location</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>ON Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>To Location</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Distance</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Duration (hh:mm:ss)</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Trip ID</b></div>
		</td>
	</tr>
	<%
			int i=0;
			String fromDate1="";
			String	toDate1="";
			String fromLocation="",toLocation="",distance="",tripid="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;
            String duration="";
			//String sql12="SELECT * FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vehicleCode+"' AND  OffTimeTo>='"+fromDateTime+"' and OffTimeTo<='"+toDateTime+"' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		 //String sql12="SELECT OffTimeFrom,FromLocation,FromLatitude,FromLatitude,OffTimeTo,ToLocation,ToLocation,ToLongitude,Distance,CONVERT(duration, CHAR) as duration FROM db_gps.t_disconnectionData WHERE vehicleCode= '6903' AND  OffTimeTo>='2015-12-01 00:00:00' and OffTimeTo<='2015-12-11 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
			//String sql12=" SELECT TripId,OffTimeFrom,FromLocation,FromLatitude,FromLongitude,OffTimeTo,ToLocation,ToLatitude,ToLongitude,Distance,CONCAT('duration',CAST(duration AS CHAR)) as duration FROM db_gps.t_disconnectionData WHERE vehicleCode= '6903' AND OffTimeTo>='2015-12-01 00:00:00' and OffTimeTo<='2015-12-11 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
			String sql12="SELECT TripId,OffTimeFrom,FromLocation,FromLatitude,FromLongitude,OffTimeTo,ToLocation,ToLatitude,ToLongitude,Distance,CONCAT('duration',CAST(duration AS CHAR)) as duration FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vehicleCode+"' AND  OffTimeTo>='"+fromDateTime+"' and OffTimeTo<='"+toDateTime+"' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
	     //out.println("\n\n-->>sqlllllllll----....>>>>"+sql12);		
	        ResultSet rsSql=st.executeQuery(sql12);
			if(!rsSql.next()){
				
			}
			else{
				
				rsSql.previous();
			while(rsSql.next())
			{System.out.println("\n\n\nvishal rst--->>>"+rsSql);
			 //out.println("\n\n\nvishal rst--->>>"+rsSql.next());
				i++;
				fromDate1 = rsSql.getString("OffTimeFrom");
				System.out.println("duration==**"+fromDate1);
				fromLocation = rsSql.getString("FromLocation");
				fromLatitude = rsSql.getDouble("FromLatitude");
				System.out.println("fromLatitude==**"+fromLatitude);
				fromLongitude = rsSql.getDouble("FromLongitude");
				System.out.println("fromLongitude==**"+fromLongitude);
				toDate1 = rsSql.getString("OffTimeTo");
				System.out.println("toDate1==**"+toDate1);
				toLocation = rsSql.getString("ToLocation");
				System.out.println("toLocation==**"+toLocation);
				toLatitude = rsSql.getDouble("ToLatitude");
				toLongitude = rsSql.getDouble("ToLongitude");
				distance = rsSql.getString("Distance");
				duration = rsSql.getString("duration");
				System.out.println("distance==**"+distance);
				System.out.println("duration==*****************************************="+duration);
				//duration = rsSql.getTimestamp("Duration");
				String duration1=duration.toString();
				//duration1=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(duration1));
				System.out.println("duration1========="+duration);
				System.out.println("discounter========="+discounter);
				if(discounter>0)
				{	
					String tripidv = request.getParameter("tripid");			
					tripid=tripidv;	
					System.out.println("in if tripid========="+tripid);
				}
				else
				{
				  tripid = rsSql.getString("TripId");
				  System.out.println("in else tripid========="+tripid);
				}
				//int length=duration1.length();
				String disconnectDuration="";
				//disconnectDuration=duration1;
				
				duration1=duration.replace("duration", "");
				System.out.println("NEW duration---------------"+duration1);
				disconnectDuration=duration1;
				System.out.println("NEW disconnectDuration---------------"+disconnectDuration);
				 /* if(duration1.charAt(length-2)==':') //if duration is 1:6 then display as 1:06
				{
					disconnectDuration=duration1.replace(":",":0");
					//disconnectDuration=duration1;
				}
		  else
				{
					//disconnectDuration=duration1;
				}  */
				
%>

	<tr>
		<td style="text-align: right"><%=i%></td>
		<td style="text-align: left"><%=ownerName%></td>
		<td style="text-align: left"><%=VehicleRegNo%></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1))%></td>
		<td style="text-align: left"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=fromLatitude%>&long=<%=fromLongitude%>&discription=<%=fromLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=fromLocation%>
		</a></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1))%></td>
		<td style="text-align: left"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=toLatitude%>&long=<%=toLongitude%>&discription=<%=toLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=toLocation%>
		</a></td>
		<td style="text-align: right"><%=distance%></td>
		<td style="text-align: center"><%=disconnectDuration%></td>
		<td style="text-align: right"><%=tripid%></td>

	</tr>
<%		   }}
			st.close();
			conn1.close();
	}
catch(Exception e)
{
	out.println("Exception---->"+e);
	e.printStackTrace();
}
			
%>
</table>
</div>
</td></tr>
</table>
</form>
</body>
</html>
<%@ include file="footernew.jsp"%>
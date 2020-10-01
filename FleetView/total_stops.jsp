<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<script type="text/javascript">  

var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};


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
          document.Total_stops.action ="excel.jsp";
          document.forms["Total_stops"].submit();

        //  document.roundtripdata.action ="excel.jsp";

}  

</script>


<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Statement st=null;
Connection conn=null;
Connection conn1=null;

String vehregno="";

%>
<%int counter=0;
	//final String vehicleRegistrationNumber = request.getParameter("vehno");
	//final String str_list = request.getParameter("str_os");
	 final String str_list=session.getAttribute("Str_os3").toString();
	 final String str = request.getParameter("count");
	 int num=Integer.parseInt(str);
	 String uname=session.getAttribute("user").toString();
	//System.out.println("\n\n\n\n\n\nlist---->>>"+str_list);
	//System.out.println("\n\n\n");
	final String data1 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data1").toString();
	final String data2 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data2").toString();
			String  exportFileName=session.getAttribute("user").toString()+"_Total_Stops.xls";

			%>

<form id="Total_stops" name="Total_stops" action="excel.jsp"
	method="post" autocomplete="off">

<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a></td>

			</tr>
		</table>

		<div id="mytable">
		<body>
		<table width="100%" align="center">
			<tr>
				<td colspan="6" align="center">
				<%
					if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:3.8 </font></div>-->
				<font size="3"><b>Total Stops Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:4.8 </font></div>-->
				<font size="3"><b>Total Stops Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:5.8 </font></div>-->
				<font size="3"><b>Total Stops Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:6.8 </font></div>-->
				<font size="3"><b>Total Stops Report</b></font> <%
					}
%>
				</td>
			</tr>
			<tr>
				<td colspan="6" align="center"><b><font size="3">For
				<%=uname %> From Date :<%
				java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
				Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
				String fromdt = formatter.format(date);
				out.print(fromdt); %> To Date :<%
				java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
				String todt = formatter1.format(date3);
				out.print(todt);%> </font></b></td>
			</tr>
		</table>
		<P></P>
		<table border="1" width="100%" class="sortable">
			<tr>
				<th>Sr.</th>
				<th>Vehicle Reg. No</th>
				<th>From Date-Time</th>
				<th>To Date-Time</th>
				<th>Location</th>
				<th>Duration</th>
				
			</tr>
			<%	
		
// string tokens...

    conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	Statement stexcep = conn1.createStatement();
	String ss=session.getAttribute("Str_os3").toString();
	//String ss=request.getParameter("str_os");
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	int i=1;
	//int num=num1;
	try
	{
	while(s.hasMoreTokens())
	{
			
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	//System.out.println("\n\n\n\n\n\nlist token---->>>"+aa);
	//System.out.println("\n\n\n");
	tbname="t_veh"+aa+"_ds";
	if(!aa.equals("0"))
	{
	String sql="select * from t_vehicledetails where vehicleCode='"+aa+"'";
	//System.out.println("\n\n\n\nvehical code--->>>>"+aa);
	try
	{
		st=conn.createStatement();

	ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			vehregno=rst.getString("VehicleRegNumber");
//			System.out.println("\n\n\n\nvehical numer--->>>>"+vehregno);
			
		}
	}catch(Exception e)
	{
	//	System.out.println("\n\n\nexception here.....\n\n\n");
		e.printStackTrace();
	}
	}
	String query="SELECT " +
		" 	st.FromDate, st.FromTime, veh.TheFieldSubject, veh.LatinDec,veh.LonginDec ,st.ToDate ,st.ToTime , " +
		"	0 , 0 , 0 , 0, st.Duration, veh.ZoneColor, st.stopReportLocation" +
		"	FROM ( " +
		"	SELECT " +
		"	 	FromDate, FromTime, ToDate, ToTime, Duration,Location as stopReportLocation " +
		"	FROM " +
		" 		db_gpsExceptions.t_veh"+aa+"_stsp " +
		"	WHERE " +
		"		FromDate >= '"+data1+"'" +
		"	AND FromDate <= '"+data2+"'" +
		"	)st" +
		"	LEFT OUTER JOIN ( " +
		"	SELECT " +
		"			TheFieldSubject,  LatinDec, LonginDec, TheFieldDataDate,  TheFieldDataTime,ZoneDesc AS ZoneColor " +
		"	FROM " +
		"		db_gps.t_veh"+aa+" " +
		"	WHERE " +
		"		 TheFieldDataDate >= '"+data1+"' " +
		"	AND  TheFieldDataDate <= '"+data2+"' " +
		"	)veh " +
		"	ON ( veh.TheFieldDataDate = st.ToDate " +
		"	AND veh.TheFieldDataTime = st.ToTime ) " +
		"	GROUP BY " +
		"		CONCAT( Fromdate , FromTime )" +
		"ORDER BY CONCAT( Fromdate , FromTime )";
	
	
		ResultSet rstcounts=stexcep.executeQuery(query);
//System.out.println("\n\n ");
while(rstcounts.next())
{//if(counter>num)
//	counter=0;
//else
//{	
%>
			<tr>
				<td style="text-align: right"><%=++counter%></td>
				<td>
				<div align="right"><%=vehregno %></div>
				</td>
				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format((new SimpleDateFormat("yyyy-MM-dd")).parse(rstcounts.getString("FromDate"))) %>
				<%=rstcounts.getString("FromTime")%></td>
				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format((new SimpleDateFormat("yyyy-MM-dd")).parse(rstcounts.getString("ToDate"))) %>
				<%=rstcounts.getString("ToTime") %></td>
				
				<td>
				<div align="left">
				<% 
							
							  if(null!= rstcounts.getString("TheFieldSubject") && 
									!"null".equalsIgnoreCase(rstcounts.getString("TheFieldSubject")) &&
									null != rstcounts.getString("LatinDec")
									) 
							{
								String lat1=rstcounts.getString("LatinDec");
								String lon1=rstcounts.getString("LonginDec");
								String disc=rstcounts.getString("TheFieldSubject");
								%> <%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>
				<%
							} else if(null!= rstcounts.getString("TheFieldSubject") && 
									!"null".equalsIgnoreCase(rstcounts.getString("TheFieldSubject"))){
								out.println(rstcounts.getString("TheFieldSubject"));
							}
%>
				</div>
				</td>
				<td>
				<div align="right"><%=rstcounts.getString("Duration")%></div>
				</td>
			</tr>
			<%
//counter++;
//}
}	
	}		
		}catch(Exception e)
		{
			e.printStackTrace();
			//out.print("Exception "+e);
		}
	finally
	{
		try
		{
		fleetview.closeConnection1();
		}catch(Exception e)
		{}
		try
		{
		fleetview.closeConnection();
		}catch(Exception e)
		{
		}		
	}
		//session.setAttribute("Str_os3","");
%>
		</table>
		</td>
	</tr>
</table>
</body>
</div>
<%@ include file="footernew.jsp"%></form>
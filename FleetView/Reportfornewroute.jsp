<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
  	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
  	<html><head>
<script>

function gotoExcel (elemId, frmFldId)  
{  
	//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.cleanermgt.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["cleanermgt"].submit();       // CHANGE FORM NAME HERE

} 	



</script>

</head>

<%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
Statement st,st1,st2;
%>

<%
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st1=conn1.createStatement();
st2=conn1.createStatement();
st=conn.createStatement();

String sql="",sql1="";
//String data1=new java.util.Date();
String username=(String)session.getAttribute("usertypevalue");
String Save=request.getParameter("save");
String Parameter=request.getParameter("Parameter");
System.out.println("parameter" +Parameter);
String Parameter1=request.getParameter("Parameter1");
System.out.println("parameter1" +Parameter1);
String Parameter2=request.getParameter("Parameter2");
System.out.println("Parameter2" +Parameter2);

String Parameter4=request.getParameter("Parameter4");
System.out.println("Parameter4" +Parameter4);

String Route=request.getParameter("Route");
System.out.println("Route" +Route);
if(Route!=null)
{
	%>
	<script type="text/javascript">
	alert("Routecode already present");
	window.location="Reportfornewroute.jsp";
	</script>
	<%
}


if(Parameter4!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Added Successfully");
	window.location="Reportfornewroute.jsp";
	</script>
	<%
}
if(Save!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Save Successfully");
	window.location="Reportfornewroute.jsp";
	
	</script>
	<%
}
if(Parameter!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Updated Successfully");
	window.location="Reportfornewroute.jsp";
	</script>
	<%
}
if(Parameter1!=null)
{
	%>
	<script type="text/javascript">
	alert("No changes made");
	window.location="Reportfornewroute.jsp";
	</script>
	<%
}
if(Parameter2!=null)
{
	%>
	<script type="text/javascript">
	alert("Record already exist");
	window.location="Reportfornewroute.jsp";
	</script>
	<%
}
Date dte=new java.util.Date();
String data1=new SimpleDateFormat("dd-MMM-yyyy hh:MM:ss").format(dte);
System.out.println("date new" +data1);
%>


<body>
<td>

			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=data1%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>
	</td>
<form id="cleanermgt" name="cleanermgt" method="post" action="entrynewroute.jsp">
<%
String exportFileName="Route_entry.xls";   // GIVE YOUR REPORT NAME
%>


<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<div style="margin-left: 400px">
		<table border="0" align="center">
		<tr><td align="center"><div align="center"><font face="Arial" size="3"><b>Report For Routes available</b></font></div></td></tr>
</table></div>

<!--<div style="margin-left: 100px;height: 300px;overflow:scroll">-->
<div id='purchase'>
<br></br>
<div class="bodyText" align="left">
		<font face="Arial" size="2"><a href="Addrouteentry.jsp" style="font-weight: bold; color: blue; " >Add New Route</a></font>
		</div>
<!--<a href="#" onClick="window.open ('Addrouteentry.jsp?&limit=10','win1','width=800,height=500,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0,minimizable=no,Dialog=yes')"><font  size="2"><b>ADD</b></font></a> &nbsp;&nbsp;-->
<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->

<table border="1" class="sortable" style="width: 1400px">
<tr>
<th>Sr.</th>
<th>Edit</th>
<th>Origincode</th>
<th>Origin</th>
<th>Destinationcode</th>
<th>Destination</th>
<th>Stdkm</th>
<th>stdtime</th>
<th>Owner</th>
<th>Kmlfile</th>
<th>Routecode</th>
<th>Org zone/branch</th>
<th>Dest Zone/branch</th>
<th>FuelApprovedKm</th>
<th>Tripdays</th>
</tr>
<%
try{
int i=1;
sql="select * from db_gps.t_castrolroutes where Owner='"+username+"'";
ResultSet rs=st.executeQuery(sql);
while(rs.next())
{
%>



<tr>
<td align="right"><div align="right"><%=i%></div></td>
<td style="width: 2%"><a href="editroute.jsp?StartCode=<%=rs.getString("StartCode") %>&StartLocationZone=<%=rs.getString("StartLocationZone") %>&rid=<%=rs.getString("rid") %>&EndLocationZone=<%=rs.getString("EndLocationZone") %>&StartPlace=<%=rs.getString("StartPlace") %>&EndCode=<%=rs.getString("EndCode") %>&EndPlace=<%=rs.getString("EndPlace") %>&kmlfile=<%=rs.getString("kmlfile")%>&routecode=<%=rs.getString("RouteCode") %>&Km=<%=rs.getString("Km") %>&TTime=<%=rs.getString("TTime") %>&Tdays=<%=rs.getString("tripdays") %>&fuelKm=<%=rs.getString("FuelApprovedKm") %>" style="font-weight: bold; color: black; "><img src="images/edittt1.jpeg" width="20px" height="18px" style="border-style: none"></img></a></td>
<td align="left"><div align="right"><%=rs.getString("StartCode") %></div></td>
<td align="left"><div align="left"><%=rs.getString("StartPlace") %></div></td>
<td align="left"><div align="right"><%=rs.getString("EndCode") %></div></td>
<td align="left"><div align="left"><%=rs.getString("EndPlace") %></div></td>
<td align="left"><div align="right"><%=rs.getString("Km") %></div></td>
<td align="left"><div align="right"><%=rs.getString("TTime") %></div></td>
<td align="left"><div align="left"><%=rs.getString("owner") %></div></td>
<td align="left"><div align="left"><a href="JRMRoutecopy1.jsp?kmlfile=<%=rs.getString("kmlfile") %>"><%=rs.getString("kmlfile") %></a></div></td>
<td align="left"><a href="RoutePlan.jsp?RouteCode=<%=rs.getString("RouteCode") %>&StartCode=<%=rs.getString("StartCode")%>&EndCode=<%=rs.getString("EndCode")%>"><div align="right"><%=rs.getString("RouteCode") %></div></a></td>
<td align="left"><div align="left"><%=rs.getString("StartLocationZone") %></div></td>
<td align="left"><div align="left"><%=rs.getString("EndLocationZone") %></div></td>
<td align="left"><div align="left"><%=rs.getString("FuelApprovedKm") %></div></td>
<td align="left"><div align="left"><%=rs.getString("tripdays") %></div></td>



<%
i++;

}}catch(Exception e)
{
	e.printStackTrace();
}
%>

</tr>

</table>

</div>
</div>
</form>



<%}catch(Exception e)
{
e.printStackTrace();
}
%>

</body>

</html>
<%@ include file="footernew.jsp"%>
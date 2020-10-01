<%@ include file="/Connections/conn.jsp" %>
<%-- <%@ include file="headernew.jsp"%> --%>
<jsp:include page="headernew.jsp">
<jsp:param name="reportname" value="my_trips.jsp" />
</jsp:include>     
<%@page import="java.util.Date"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>
<script src="includes/mytripinclude.js" type="text/javascript"></script>
  	<html>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>

<body>
<%!
Connection conn=null,conn1=null;
Statement st,st1,stcom,strch,st2,st3,st11,stt1,stt2,st12,st13,st14,st15,st16,st4,sto,st20,st21,st22,strep;
String fromdate,search="",todate,sql,sql1,sql2,sql3,transporter,pageflag,datenew1,datenew2,fromdatetime,todatetime, vendor1,category1,startp,endp,ven,startp1,endp1,vendername,
categoryname,startplacename,endplacename,statusname,vehino,vehicleno,vehiclecode,Sqlv="",distributorname="";
 String sqlname=null,briefing="",sqlbrif=null,Dbriefing="",etaclose="",reportclose="",tripsrch="",vehsrch="",spsrch="",driv="";
 String	epsrch="",ownsrch="",statuasrch="",statuarsrun="",etaclose1="",sdtime1="",sddate1="",etdate="",repdate="",reportclose1="",STripId="",drivername="";
 String searchstatus1="Set";
 
%><%
//Class.forName(MM_dbConn_DRIVER); 
conn = fleetview.ReturnConnection();
conn1 = fleetview.ReturnConnection1();	
st=conn.createStatement();st1=conn.createStatement();
st2=conn.createStatement();st3=conn1.createStatement();st11=conn.createStatement();
stt1=conn.createStatement();      //  *********************************
stt2=conn.createStatement();st12=conn.createStatement();st13=conn.createStatement();st14=conn.createStatement();
st15=conn.createStatement();st16=conn.createStatement();sto=conn.createStatement();st4=conn.createStatement();
st20=conn.createStatement();st21=conn.createStatement();st22=conn.createStatement();strep=conn.createStatement();
strch=conn.createStatement();stcom=conn.createStatement();
%><%
try{
	search=request.getParameter("searchid");
if(!(null==request.getQueryString()) && (null==search)){
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
transporter=request.getParameter("transporter");
%>
<input type="hidden" id="data11" name="data11" value="<%=fromdate %>"></input>
<input type="hidden" id="data22" name="data22" value="<%=todate %>"></input>
<input type="hidden" id="transporter1" name="transporter1" value="<%=transporter %>"></input>

<%
session.setAttribute("reportno","Report No:9.0");
datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
vendername=request.getParameter("vendor");
categoryname=request.getParameter("category");
startplacename=request.getParameter("startp");
endplacename=request.getParameter("endp");
statusname=request.getParameter("status");
vehino=request.getParameter("vehicle");
pageflag="MyTrip";
if(vehino.length()>0){
	int i=vehino.indexOf(',');
	vehino=vehino.substring(i+1);}}
else{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;statusname="Open";vendername="ALL";categoryname="ALL";
startplacename="ALL";endplacename="ALL";drivername="All";
	}}catch(Exception e)	{
		e.printStackTrace();	}
%>
<%
	String role="";
	String ApprooveBy=session.getAttribute("mainuser").toString();
String sqlapp="select Role from db_gps.t_security where Username='"+ApprooveBy+"' ";
System.out.println("Find Role Query" +sqlapp);
	ResultSet rsapp=st.executeQuery(sqlapp);
	if(rsapp.next())
	{
		role=rsapp.getString("Role");
	}
	System.out.println(" Role " +role);

	%>
<form name="search" id="search" action="" method="get" onsubmit="">
<table border="0" width="100%" align="center" class="stats">
<tr>
	<td>
	<div style="margin-left: 300px">
	<font size="3"><B>My Trips Report</B></font></div></td><td>
 	<font face="Arial"  size="2"><B>Enter Trip Id</B></font>&nbsp;&nbsp;
	<input type="text" class="element text medium" style="width: 100px" name="searchid" id="searchid" value="" />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<input type="submit" id="searchbt" name="searchbt" style="border-style: outset; border-color: black" value="Search"  />
</td>
</tr>
</table>
</form>

<form name="dateform" id="dateform" action="" method="get" onsubmit="return validate();">
<table border="0" width="500" align="center" class="sortable_entry"><tr>
<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data1" name="data1" class="element text medium" style="width: 100px" value="<%=datenew1%>"  size="15" readonly/>
  </td><td align="left">
<script type="text/javascript">
  Calendar.setup(    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }  );
</script></td><td>
<b>To</b> &nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data2" name="data2" class="element text medium" style="width: 100px" value="<%=datenew2%>" size="15" readonly/></td><td align="left">
<script type="text/javascript">
  Calendar.setup(    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }  );
</script></td>
<%
System.out.println("Not in querystring---->?"+statusname);
%>
<td><b>Status/Category</b>
<select id="status" name="status" class="element select medium" style="width: 150px" onChange="statuscloser(this.value)">
<option value="Open" <% if(statusname.equals("Open")){ %>Selected<% } %>>Open</option>
<option value="Closed"  <% if(statusname.equals("Closed")){ %>Selected<% } %> >Closed</option>
<option value="Cancelled"  <% if(statusname.equals("Cancelled")){ %>Selected<% } %> >Canceled</option>
<option value="Vehicle Wise Trips"  <% if(statusname.equals("Vehicle Wise Trips")){ %>Selected<% } %>>Vehicle Wise Trips</option>
<option value="Driver Wise Trips"  <% if(statusname.equals("Driver Wise Trips")){ %>Selected<% } %>>Driver Wise Trips</option>
</select></td><td>
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<input type="hidden"  name="colorvalue" id="colorvalue" value="all"></input>
&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="ubmit" id="submit" style="border-style: outset; border-color: black" value="Submit" onclick="searchclear();"></td>
</table></tr>
<table border="0" width="750" class="sortable_entry">
<tr>
<% if(statusname.equals("Closed")){
%>
<td id="tddrv" style="display:none;"><b>
	Driver</b><select name="Driver" class="element select medium" style="width: 150px" id="Driver" onchange="getvalue()">
	<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	String Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
	System.out.println("DriverName"+Driver);
	ResultSet rstdriver=st1.executeQuery(Driver);
	while(rstdriver.next())
	{	driv=rstdriver.getString("DriverName") ;
	%>
	<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
	<%} %>
	</select></td>
<td id="tdvh" style="display: none;">
	<b>Vehicle <select name="vehicle" id="vehicle" class="element select medium" style="width: 100px" onchange="getvalue()">
	<% 
			sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				out.println(rst.getString("VehicleRegNumber"));
			%>
			<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"><%=rst.getString("VehicleRegNumber")%></option>						
			<%			}				
	%>			
	</select></b></td>
<td id="tdvend" style=""><b>
Customer</b><select name="vendor" class="element select medium" style="width: 100px" id="vendor" onchange="getvalue()">
<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by Vendor";
System.out.println("vendor1"+vendor1);
ResultSet rstvendor=st1.executeQuery(vendor1);
while(rstvendor.next())
{	 ven=rstvendor.getString("Vendor") ;
%>
<option value="<%=ven%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
<%} %>
</select></td>
<td id="tdcat" style=""><b>
Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
<option value="ALL" <% if(categoryname.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
ResultSet rstcategory=st12.executeQuery(category1);
while(rstcategory.next()){
	 String tripcategory=rstcategory.getString("TripCategory") ;
%>
<option value="<%=tripcategory %>" <% if(categoryname.equals(tripcategory)){ %>Selected<% } %>><%=tripcategory %></option>
<%} %>
</select></td>
<td id="tdstpl" style=""><b>
StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by StartPlace ";
ResultSet rststartp=st13.executeQuery(startp1);
while(rststartp.next()){
	 String startp=rststartp.getString("StartPlace") ;
%>
<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %> ><%=startp %></option>
<%} %>
</select></td>
<td id="tdendpl" style=""><b>
EndPlace</b><b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by EndPlace";
ResultSet rstendpp=st14.executeQuery(endp1);
while(rstendpp.next()){
	 endp=rstendpp.getString("EndPlace") ;
%>
<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %> ><%=endp %></option>
<%} 
%>
</select></b></td>
<%}
//********************************************************
else if(statusname.equalsIgnoreCase("Open")){
%>
<td id="tddrv" style="display:none;"><b>
	Driver</b><select name="Driver" class="element select medium" style="width: 100px" id="Driver" onchange="getvalue()">
	<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	String Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
	System.out.println("DriverName"+Driver);
	ResultSet rstdriver=st1.executeQuery(Driver);
	while(rstdriver.next())
	{	driv=rstdriver.getString("DriverName") ;
	%>
	<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
	<%} %>
	</select></td>
<td id="tdvh" style="display: none;">
	<b>Vehicle</b><select name="vehicle" class="element select medium" style="width: 100px" id="vehicle">
	<% 
			sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				out.println(rst.getString("VehicleRegNumber"));
				String veh = rst.getString("VehicleRegNumber");
				
			%>
			<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"><%=rst.getString("VehicleRegNumber")%></option>						
			<%			}		
		%>			
	</select></td>
<td id="tdvend" style="display: none;"><b>
Customer</b>
<select name="vendor" id="vendor" class="element select medium" style="width: 100px" onchange="getvalue()">
<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by Vendor ";
System.out.println("vendor1"+vendor1);
ResultSet rstvendor=st1.executeQuery(vendor1);
while(rstvendor.next()){
	 ven=rstvendor.getString("Vendor") ;
%>
<option value="<%=rstvendor.getString("Vendor")%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
<%} %>
</select></td>
<td id="tdcat" style="display: none;"><b>
Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
<option value="ALL" <% if(statusname.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
ResultSet rstcategory=st12.executeQuery(category1);
while(rstcategory.next()){
	 String tripcategory=rstcategory.getString("TripCategory") ;
%>
<option value="<%=tripcategory %>"><%=tripcategory %></option>
<%} %>
</select></td>
<td id="tdstpl" style="display: none;"><b>
StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by StartPlace";
ResultSet rststartp=st13.executeQuery(startp1);
while(rststartp.next()){
	 String startp=rststartp.getString("StartPlace") ;
%>
<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %>><%=startp %></option>
<%} %>
</select></td>
<td id="tdendpl" style="display: none;"><b>
EndPlace</b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by EndPlace";
ResultSet rstendpp=st14.executeQuery(endp1);
while(rstendpp.next())
{
	 endp=rstendpp.getString("EndPlace") ;
%>
<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %>><%=endp %></option>
<%} %>
</select></td>
<%}
else if(statusname.equalsIgnoreCase("Cancelled")){
	%>
	<td id="tddrv" style="display:none;"><b>
	Driver</b><select name="Driver" class="element select medium" style="width: 100px" id="Driver" onchange="getvalue()">
	<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	String Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
	System.out.println("DriverName"+Driver);
	ResultSet rstdriver=st1.executeQuery(Driver);
	while(rstdriver.next())
	{	driv=rstdriver.getString("DriverName") ;
	%>
	<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
	<%} %>
	</select></td>
	<td id="tdvh" style="display: none;">
		<b>Vehicle</b><select name="vehicle" class="element select medium" style="width: 100px" id="vehicle">
		<% 
		sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
				ResultSet rst=st.executeQuery(sql);
				while(rst.next())
				{
					out.println(rst.getString("VehicleRegNumber"));
					String veh = rst.getString("VehicleRegNumber");
							%>
				<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"><%=rst.getString("VehicleRegNumber")%></option>						
				<%				}		
							%>			
		</select>	</td>
	<td id="tdvend" style="display: none;">	<b>
	Customer</b><select name="vendor" class="element select medium" style="width: 100px" id="vendor" onchange="getvalue()">
	<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	System.out.println("vendor1"+vendor1);
	ResultSet rstvendor=st1.executeQuery(vendor1);
	while(rstvendor.next())	{
		 ven=rstvendor.getString("Vendor") ;
	%>
	<option value="<%=rstvendor.getString("Vendor")%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
	<%} %>	</select>	</td>
	<td id="tdcat" style="display: none;">	<b>
	Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
	<option value="ALL" <% if(statusname.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rstcategory=st12.executeQuery(category1);
	while(rstcategory.next())	{
		 String tripcategory=rstcategory.getString("TripCategory") ;
	%>
	<option value="<%=tripcategory %>"><%=tripcategory %></option>
	<%} %>
	</select>	</td>
	<td id="tdstpl" style="display: none;">	<b>
	StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
	<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rststartp=st13.executeQuery(startp1);
	while(rststartp.next())	{
		 String startp=rststartp.getString("StartPlace") ;
	%>
	<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %>><%=startp %></option>
	<%} %>
	</select>
	</td>
	<td id="tdendpl" style="display: none;">	<b>
	EndPlace</b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
	<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rstendpp=st14.executeQuery(endp1);
	while(rstendpp.next())	{
		 endp=rstendpp.getString("EndPlace") ;
	%>
	<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %>><%=endp %></option>
	<%	} 	%>
	</select>	</td>
	<%}
else if(statusname.equalsIgnoreCase("Vehicle Wise Trips")){
%>
<td id="tddrv" style="display:none;"><b>
	Driver</b><select name="Driver" class="element select medium" style="width: 100px" id="Driver" onchange="getvalue()">
	<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	String Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
	System.out.println("DriverName"+Driver);
	ResultSet rstdriver=st1.executeQuery(Driver);
	while(rstdriver.next())
	{	driv=rstdriver.getString("DriverName") ;
	%>
	<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
	<%} %>
	</select></td>
	<td id="tdvh" style="">
	<b>Vehicle</b><select name="vehicle" class="element select medium" style="width: 100px" id="vehicle" onchange="getvalue()">
	<% 
			sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())			{
				out.println(rst.getString("VehicleRegNumber"));
				String veh=rst.getString("VehicleRegNumber");
			%>
			<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"  <% if(vehino.equals(veh)){ %>Selected<% } %>><%=rst.getString("VehicleRegNumber")%></option>						
			<%			}	%>			
	</select></td>
	<td id="tdvend" style="">
	<b>
	Customer</b><select name="vendor" class="element select medium" style="width: 100px" id="vendor" onchange="getvalue()">
	<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	System.out.println("vendor1"+vendor1);
	ResultSet rstvendor=st1.executeQuery(vendor1);
	while(rstvendor.next())	{
		 ven=rstvendor.getString("Vendor") ;
	%>
	<option value="<%=rstvendor.getString("Vendor")%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
	<%} %>
	</select>	</td>
	<td id="tdcat" style="">	<b>
	Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
	<option value="ALL" <% if(statusname.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rstcategory=st12.executeQuery(category1);
	while(rstcategory.next())	{
		 String tripcategory=rstcategory.getString("TripCategory") ;
	%>
	<option value="<%=tripcategory %>"><%=tripcategory %></option>
	<%} %>
	</select>	</td>
	<td id="tdstpl" style="">	<b>
	StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
	<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rststartp=st13.executeQuery(startp1);
	while(rststartp.next())	{
		 String startp=rststartp.getString("StartPlace") ;
	%>
	<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %>><%=startp %></option>
	<%} %>
	</select>	</td>
	<td id="tdendpl" style="">	<b>
	EndPlace</b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
	<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rstendpp=st14.executeQuery(endp1);
	while(rstendpp.next())	{
		 endp=rstendpp.getString("EndPlace") ;
	%>
	<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %>><%=endp %></option>
	<%	} 	%>
	</select></td><% }
else{

	%>
	<td id="tddrv" style="display:"><b>
	Driver</b><select name="Driver" class="element select medium" style="width: 100px" id="Driver" onchange="getvalue()">
	<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	String Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
	System.out.println("DriverName"+Driver);
	ResultSet rstdriver=st1.executeQuery(Driver);
	while(rstdriver.next())
	{	driv=rstdriver.getString("DriverName") ;
	%>
	<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
	<%} %>
	</select></td>
	<td id="tdvh" style="display: none;">
		<b>Vehicle <select name="vehicle" id="vehicle" class="element select medium" style="width: 100px" onchange="getvalue()">
		<% 
				sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
				ResultSet rst=st.executeQuery(sql);
				while(rst.next())
				{
					out.println(rst.getString("VehicleRegNumber"));
				%>
				<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"><%=rst.getString("VehicleRegNumber")%></option>						
				<%
				}		
					
		%>			
		</select></b></td>
	<td id="tdvend" style=""><b>
	Customer</b><select name="vendor" class="element select medium" style="width: 100px" id="vendor" onchange="getvalue()">
	<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by Vendor";
	System.out.println("vendor1"+vendor1);
	ResultSet rstvendor=st1.executeQuery(vendor1);
	while(rstvendor.next())
	{	 ven=rstvendor.getString("Vendor") ;
	%>
	<option value="<%=ven%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
	<%} %>
	</select></td>
	<td id="tdcat" style=""><b>
	Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
	<option value="ALL" <% if(categoryname.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
	ResultSet rstcategory=st12.executeQuery(category1);
	while(rstcategory.next()){
		 String tripcategory=rstcategory.getString("TripCategory") ;
	%>
	<option value="<%=tripcategory %>" <% if(categoryname.equals(tripcategory)){ %>Selected<% } %>><%=tripcategory %></option>
	<%} %>
	</select></td>
	<td id="tdstpl" style=""><b>
	StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
	<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by StartPlace ";
	ResultSet rststartp=st13.executeQuery(startp1);
	while(rststartp.next()){
		 String startp=rststartp.getString("StartPlace") ;
	%>
	<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %> ><%=startp %></option>
	<%} %>
	</select></td>
	<td id="tdendpl" style=""><b>
	EndPlace</b><b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
	<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
	<%
	endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by EndPlace";
	ResultSet rstendpp=st14.executeQuery(endp1);
	while(rstendpp.next()){
		 endp=rstendpp.getString("EndPlace") ;
	%>
	<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %> ><%=endp %></option>
	<%} 	%>	</select></b></td>
	<%}
	%></table><br><br>	<td>
	
	
	
	
	<%

if(!(search==null)){
	%>
	
		<table>	<tr>
	<td align="center"><div style="margin-left: 400px"><font face="Arial" size="2" color="blue"><b>Detail Report About Trip Id:-<%=search%></b></font></div></td>
	</tr>	</table>
		
		<%
		
		
		String usertypevalue=session.getAttribute("usertypevalue").toString();
		System.out.println(" User Suyog " +usertypevalue);
		
		
		String typeofuser=session.getAttribute("TypeofUser").toString();
		System.out.println(" User Suyog " +typeofuser);

		String SrchTrans="";
		System.out.println(usertypevalue+" User "+typeofuser);
		SrchTrans="('"+usertypevalue+"')";
		
		/* if(typeofuser.equalsIgnoreCase("Group"))
		{
			System.out.println("IN Group ");
			sql="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
			System.out.println("*****8     "+sql);
			ResultSet rstGrp=st2.executeQuery(sql);
			SrchTrans="(";
			int k = 0;
			while(rstGrp.next())
			{
				SrchTrans=SrchTrans+"'"+rstGrp.getString("VehRegno")+"',";
				k++;
			}
			SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";

		}
		else
		{
			System.out.println("IN Else ");
			SrchTrans="('"+usertypevalue+"')";	
		} */
		

		
//String sqlsrch="select * from db_gps.t_startedjourney where OwnerName in "+SrchTrans+" and TripId like '%"+search+"%'";
 String sqlsrch="select * from db_gps.t_startedjourney where (OwnerName in "+SrchTrans+" or GPName in "+SrchTrans+")  and TripId like '%"+search+"%'";
	System.out.println("search is***"+sqlsrch );

		ResultSet rssrch=strch.executeQuery(sqlsrch);
		
if(rssrch.next())
{
	statuasrch=rssrch.getString("JStatus");
     STripId=rssrch.getString("TripId");
     System.out.println("search is***"+statuasrch );
     System.out.println("search is***"+STripId );
     
}
System.out.println("below query search is ma " +search);


System.out.println("below query search is " +STripId);



if(search.equals(STripId))		{
	System.out.println("in if");

	if(statuasrch.equals("Running")){
		
		System.out.println("in if if");


		searchstatus1="Yes";	
	
	}
	else{
		
		System.out.println("in if else else");

		searchstatus1="No";	}		}
	
else{
	
	
	searchstatus1 = "";

%>
	<div align="center">
	
	<table>
	<tr><font size="3"><b>Sorry,the tripid you have searched has no data available</b></font></tr></table></div>
	<%}}else
	{
		searchstatus1 = "";
	}
	
	
	
try{	
	
	if(!(null==request.getQueryString()))
	{
	String sum="";
	 if(vendername =="All" || vendername.equalsIgnoreCase("All"))	
	 {
		 sum=sum+"";	
		 }
	 else 	 {
		 sum= sum+" and Vendor='"+vendername+"'";	 }
		 if(categoryname=="All" || categoryname.equalsIgnoreCase("All"))
		 {
		 sum=sum+"";	
		 }
	 else	 {
		 		 sum=sum+" and TripCategory='"+categoryname+"'";	 }
	 	 if(startplacename=="All" || startplacename.equalsIgnoreCase("All"))	 {
		 sum=sum+"";	 }
	 else	 {
			 sum=sum+" and StartPlace='"+startplacename+"'";	 }
	 	 if(endplacename=="All" || endplacename.equalsIgnoreCase("All"))	 {
		 sum=sum+"";	 }
	 else	 {
		 		 sum=sum+" and EndPlace='"+endplacename+"'";	 }
         System.out.println("Status>>>>>>>>>"+searchstatus1);
		if(statusname.equalsIgnoreCase("Closed") || searchstatus1.equalsIgnoreCase("No") || searchstatus1.equals("No"))		{
	           System.out.println("Status is no>>>>>>>>>"+searchstatus1);

			int hide=0;
			try{
           if(searchstatus1.equalsIgnoreCase("No"))
           {
        	   
           System.out.println("Status is in if>>>>>>>>>");
        	   Sqlv="select tripid,pod,Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,dvcount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays,RunHrVio from db_gps.t_completedjourney where TripId='"+STripId+"'";
        	   
           }
           else{
        	   
               System.out.println("Status is else>>>>>>>>>");

			 Sqlv="select distinct(tripid),pod,Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,dvcount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays,RunHrVio from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"' OR Vendor='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' "+sum+"  order by StartDate ";
           }}catch(Exception e)
           {
        	   e.printStackTrace();
           }
%>

<%
if(searchstatus1.equalsIgnoreCase("No"))
{
}else if(searchstatus1.equalsIgnoreCase("") || searchstatus1=="" || searchstatus1.equals("")){
%>
<table border="0" width="800" align="center">
<tr align="center"><td colspan="24" align="center" width="70%">
<font  size="3" color="blue"><B>My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font>
<div class="bodyText" align="right">
<input type="button" value="More Info" style="border-style: outset; border-color: black" onclick="showhide2();" class="formElement" id="tds" name="tds" >&nbsp;&nbsp;
</div>
<div align="right">
<td width="600"><a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
<a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
 <td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%>
 </td></div></tr>
  </table>
  <%}else{} %>
<table border="1" class="sortable" width="100%">
<tr>
<th>Sr.</th>
<th id="tripcolcls">Trip ID</th><th id="cncolcls">CN</th><th id="podcolcls">POD</th><th id="drivercolcls">Driver</th>
<th id="vehcolcls"><a href="#" onClick="hide('veh');" title="Click to hide Desc,Mode1,Type Cols"><img id="img13" src="images/sub.jpg" width="13px" height="10px" border="0"> </a><br></br>Veh.</th>
<th id="tdd0" style="text-align: left; display: none"> Desc</th><th id="tdm0" style="text-align: left; display: none"> Model</th>
<th id="tdt0" style="text-align: left; display: none">Type</th><th id="ownercolcls">Owner</th>
<th id="tdw0" style="text-align: left; display: none">Weight Kg</th><th id="tdf0" style="text-align: left; display: none">Freight Rs</th>
<th id="tda0" style="text-align: left; display: none">Advance Rs</th><th id="vendorcolcls">Customer</th>
<th id="tricatcolcls">Category</th><th id="spcolcls">Origin</th>
<th id="tdr0" style="text-align: left; display: none">Report DateTIme</th><th id="sdcolcls">Start Date Time</th>
<th id="tdl0" style="text-align: left; display: none">Load Delay (hh:mm:ss)</th><th id="tdldr0" style="text-align: left; display: none">Ld Delay Rsn</th>
<th id="tdlc0" style="text-align: left; display: none">Load Comments</th><th id="epcolcls">Destination</th>
<th id="edcolcls">End Date Time</th><th id="tdu0" style="text-align: left; display: none">Unload Date Time</th>
<th id="tdul0" style="text-align: left; display: none">Unload Delay (hh:mm:ss)</th><th id="tdudr0" style="text-align: left; display: none">Unld Delay Rsn</th>
<th id="tduc0" style="text-align: left; display: none">Unload Comments</th><th id="stkmcolcls">STD KM</th>
<th id="sdtcolcls">STD Time</th><th id="kmtcolcls">KM Traveled</th><th id="trpdcolcls">Trip Days</th><th id="trptcolcls">Trip Time</th>
<th id="rhrcolcls">Run Hrs</th><th id="avcolcls">Avg hrs/day</th><th id="rhrvcolcls">Run Hr Violation</th><th id="oscolcls">OS</th>
<th id="osscolcls">OS(sec)</th><th id="rzonecolcls">OS(sec) in Red Zone</th><th id="yzonecolcls">OS(sec) in Yellow Zone</th>
<th id="gzonecolcls">OS(sec) in Green Zone</th><th id="racolcls">RA</th><th id="rdcolcls">RD</th><th id="dvcolcls">DV</th><th id="cdcolcls">CD</th>
<th id="ndcolcls">ND</th><th id="nddcolcls">ND Distance</th><th id="ndducolcls">ND Duration</th><th id="dccolcls">DC</th>
<th id="dckmcolcls">DC Km</th><th id="ratcolcls">Rating</th><th>Closed By</th><th>Customer Name</th><th>Briefing</th><th>Debriefing</th>
</tr>
<%
System.out.println("Status is Final>>>>>>>>> " +Sqlv);

	ResultSet rstcloser=st15.executeQuery(Sqlv);
int i=0,dist1,dist2;
java.util.Date enddte1,strdte1;
double stdDist=0,stdTme=0,capDist=0;
String SDate,EDate,STime,ETime,tripid,StDate,EdDate;
long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0,etime;
String fromdate="",todate="";
String ftime1="00";
String ftime2="00";
String ftime3="00";
String ttime1="00";
String ttime2="00";
String ttime3="00";
int noofdays=0;
String fromdate1="",todate1="";
String vehdesc="-",vehmodel="-",vehtype="-",tripcat="-",adv="-",freight="-",loadrsn="-",loadcmt="-",endedby="-",weight="-",vendor="-",reptdttme="-",unloadcmt="-",unloadrsn="-";
String sdate,edate,LoadingDelay,UnloadingDelay;
String crcount="";
int KmTravelled=0;
while(rstcloser.next()){
i++;
String tripflag="true";
SDate=rstcloser.getString("StartDate");
EDate=rstcloser.getString("EndDate");
STime=rstcloser.getString("StartTime");
ETime=rstcloser.getString("EndTime");
tripid=rstcloser.getString("TripId");
KmTravelled=rstcloser.getInt("KmTravelled");
noofdays=rstcloser.getInt("noofdays")+1;
LoadingDelay=rstcloser.getString("LoadingDelay");
if(LoadingDelay==null || LoadingDelay.equalsIgnoreCase("null")){	LoadingDelay="-";}
UnloadingDelay=rstcloser.getString("UnloadingDelay");
if(UnloadingDelay==null || UnloadingDelay.equalsIgnoreCase("null")){	UnloadingDelay="-";}
unloadcmt=rstcloser.getString("Unloadingcomments");
if(unloadcmt==null || unloadcmt.equalsIgnoreCase("null")){	unloadcmt="-";}
unloadrsn=rstcloser.getString("DelayReason");
if(unloadrsn==null || unloadrsn.equalsIgnoreCase("null")){	unloadrsn="-";}
if(null==STime || STime.length()>8 || STime.equals("-")){STime="00:00:00";}
if(null==ETime || ETime.equals("-")){
ETime="23:59:59";}
sdate=SDate;
	try	{
	  fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));	
	  fromdate=fromdate+" "+STime;
	}
	catch(Exception e)	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
		fromdate=fromdate+" "+STime;
		}
	try	{
	java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
	 ftime1=""+dt.getHours();
	 ftime2=""+dt.getMinutes();
	 ftime3=""+dt.getSeconds();}
	catch(Exception e)  	{
  		ftime1="00";
  		ftime2="00"; 
  		ftime3="00";}
	 edate=EDate;
	 try	 {
	 	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
	 	todate=todate+" "+ETime;
	 }
	 catch(Exception e)	 {
		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));	 
		 todate=todate+" "+ETime;	 
	 }
	try	{
	java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
	 ttime1=""+edt.getHours();
	 ttime2=""+edt.getMinutes();
	 ttime3=""+edt.getSeconds();}	catch(Exception e)
  	{   ttime1="23";
  	 	ttime2="59";
  	 	ttime3="59";}
	 /*#################################change#############################*/
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00
miliseconds1=fd.getTime();
}catch(Exception e1){try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
miliseconds1=fd.getTime();
}catch(Exception e4){
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
miliseconds1=fd.getTime();
}}try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
miliseconds2=fd1.getTime();
}catch(Exception e2){
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
miliseconds2=fd1.getTime();
}catch(Exception e5){
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
miliseconds2=fd1.getTime();}}
try{
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
    fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
 }catch(Exception e){
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
	fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
}
try{
		todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
		todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}catch(Exception e){
	todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
	todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));}
%><%
String sqlreport="select * from db_gps.t_startedjourney where TripID='"+rstcloser.getString("TripID")+"'";
ResultSet report=strep.executeQuery(sqlreport);
if(report.next()){
	etaclose=report.getString("ETA");
	reportclose=report.getString("ReportDateTime");}
%>
<tr>
<td style="text-align: right"><%=i%></td>
<td><div align="right"  >
<font size="10">
<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=rstcloser.getString("TripId")%></font></a> </font><br />
<div class="popup" id="popup<%=i%>">
<table border="1" bgcolor="white"><tr>
<td><a href="detailed_report.jsp?vehcode=<%=rstcloser.getString("VehId")%>&fromdata=<%=fromdate%>&todata=<%=todate%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
</td></tr><tr>
<td>
<%
String briefid = "",rid = "",plannedstatus = "No";
boolean flag = false;
String sql1 = "select * from db_gps.t_briefing where tripid = '"+rstcloser.getString("TripId")+"'";
ResultSet rs1 = st1.executeQuery(sql1);
if(rs1.next())
{briefid = rs1.getString("Briefid");}
sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rstcloser.getString("TripId")+"' and briefid = '"+briefid+"' and driverid = '"+rstcloser.getString("DriverId")+"'  order by advancedtrackid asc ,row asc limit 1 ";
rs1 = st1.executeQuery(sql1);
if(rs1.next())
{rid = rs1.getString("advancedrouteid");
	plannedstatus = "Yes";
	flag = true;}
%>
<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rstcloser.getString("TripId")%>&vehcode=<%=rstcloser.getString("VehId")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ftime3=<%=ftime3 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&ttime3=<%=ttime3 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=rstcloser.getString("DriverId")%>" onclick="javascript:toggleDetails(<%=i%>,false);">Show Trip On Map</a>
</td></tr><tr><td>
<a href="#" onclick="javascript:window.open('TripwiseException.jsp?startDate=<%=rstcloser.getString("StartDate")%>&endDate=<%=rstcloser.getString("EndDate")%>&trans=<%=request.getParameter("transporter") %>&vehcode=<%=rstcloser.getString("VehId")%>&tripid=<%=rstcloser.getString("Tripid")%>')">TripWise Exception</a>
</td></tr>
<%-- <tr><td>

<a href="#" onclick="javascript:window.open('trippdf.jsp?tripid=<%=rstcloser.getString("Tripid")%>&owner=<%=rstcloser.getString("OwnerName")%>&vid=<%=rstcloser.getString("VehId")%>&vehRegNo=<%=rstcloser.getString("VehRegNo")%>')">Print</a>


</td></tr> --%>
<tr><td>
<a href="#" onclick="javascript:window.open('endtrip.jsp?tripid=<%=rstcloser.getString("Tripid")%>&EDate=<%=EDate%>&ETime=<%=ETime%>&vehcode=<%=rstcloser.getString("VehId")%>','','menubar=1,scrollbars=1,resizeable=0,width=500,height=600');">Change Unload Time</a>
</td></tr>
<%if(role.equalsIgnoreCase("Castrolsuperadmin") || role.equals("Castrolsuperadmin")) {%>
<tr><td>
<a href="#" onclick="javascript:window.open('OverrideReport.jsp?tripid=<%=rstcloser.getString("Tripid")%>&vid=<%=rstcloser.getString("VehId")%>&vehRegNo=<%=rstcloser.getString("VehRegNo")%>&Transporter=<%=rstcloser.getString("OwnerName")%>&SD=<%=rstcloser.getString("StartDate") %>&ED=<%=rstcloser.getString("EndDate") %>&ST=<%=rstcloser.getString("StartTime") %>&ET=<%=rstcloser.getString("EndTime") %>')">
Violation Override</a></td></tr>
<%} %>
<tr><td>

<a href="#" onclick="javascript:window.open('trippdf.jsp?tripid=<%=rstcloser.getString("Tripid")%>&owner=<%=rstcloser.getString("OwnerName")%>&vid=<%=rstcloser.getString("VehId")%>&vehRegNo=<%=rstcloser.getString("VehRegNo")%>')">Print</a>


</td></tr>
<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
</table>
</div> </div></td>
<%
try{
String cnfile11="",cnnumber="";	
String sqlfile1="select cnfilename,cnnumber from db_gps.t_startedjourney where TripID='"+rstcloser.getString("Tripid")+"'";
ResultSet rs551=st4.executeQuery(sqlfile1);
if(rs551.next()){	
cnnumber=rs551.getString("cnnumber");
cnfile11=rs551.getString("cnfilename");}
if(cnfile11.equalsIgnoreCase("-")){
	%>
<td id="cncol<%=i%>"><div align="right"><%=cnnumber%></div></td>
	<%}
else{
		%>
	<td id="cncol<%=i%>">
 	<div align="right"><a href="#" onclick="getFTPImage('<%=rs551.getString("cnfilename")%>')">
					<%=cnnumber%></a></div></td>
		<%}
}catch(Exception e){
	e.printStackTrace();}%><%
try{
String podfile11="",podnumber="";	
String sqlfile11="select podfilename from db_gps.t_completedjourney where TripID='"+rstcloser.getString("Tripid")+"'";
ResultSet rs50=st4.executeQuery(sqlfile11);
if(rs50.next()){
podfile11=rs50.getString("podfilename");}
if(podfile11.equalsIgnoreCase("-") || podfile11.length()==0 || podfile11==null){
	%>
<td id="podcol<%=i%>"><div align="right"><%=rstcloser.getString("pod")%></div></td>
	<%}
else{	%>
	<td id="podcol<%=i%>">
	<div align="right"><a href="#" onclick="getFTPImage('<%=rs50.getString("podfilename")%>')">
					<%=rstcloser.getString("pod")%></a></div></td>
		<%}}catch(Exception e){
	e.printStackTrace();}%>
<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>
<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>
<%
String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"' order by VehicleRegNumber ";
ResultSet rst3=stt2.executeQuery(sql3);
if(rst3.next()){
vehdesc=rst3.getString("VehDesc");
if(vehdesc==null || vehdesc.equalsIgnoreCase("null")){	vehdesc="-";}
vehmodel=rst3.getString("VehModel");
if(vehmodel==null || vehmodel.equalsIgnoreCase("null")){	vehmodel="-";}
vehtype=rst3.getString("VehType1");
if(vehtype==null || vehtype.equalsIgnoreCase("null")){	vehtype="-";}}
else{
	vehdesc="-";
	vehmodel="-";
	vehtype="-";}
%>
<td id="tdd<%=i%>" style="text-align: left;display: none;"><%=vehdesc%></td>
<td id="tdm<%=i%>" style="text-align: left;display: none;"><%=vehmodel%></td>
<td id="tdt<%=i%>" style="text-align: left;display: none;"><%=vehtype%></td>
<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>
<%
String sql="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,Loadreason,Loadcomments,TripCategory,FIxedKM,FIxedTime from t_startedjourney where tripid='"+tripid+"'";
ResultSet rss=st2.executeQuery(sql);
if(rss.next()){
	stdDist=rss.getDouble("FIxedKM");
	stdTme=rss.getDouble("FIxedTime"); 
	endedby=rss.getString("EndedBy");
	 weight=rss.getString("Weight");
	 if(weight==null || weight.equalsIgnoreCase("null"))	 {		 weight="-";	 }
	 vendor=rss.getString("Vendor");
	 	 if(vendor.equalsIgnoreCase("select") || vendor==null || vendor.equalsIgnoreCase("null"))	 {		 vendor="-";	 }
	 tripcat =rss.getString("TripCategory");
	 if(tripcat.equalsIgnoreCase("select") || tripcat==null || tripcat.equalsIgnoreCase("null"))	 {		 tripcat="-";	 }
	 freight =rss.getString("Frieght");
	 if(freight==null || freight.equalsIgnoreCase("null"))	 {		 freight="-";	 }
	 adv =rss.getString("Advance");
	 if(adv==null || adv.equalsIgnoreCase("null"))	 {		 adv="-";	 }
	 try	 {
		 reptdttme=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rss.getString("ReportDateTime")));
		 	 	 }catch(Exception ss)	 {
		 reptdttme=rss.getString("ReportDateTime");	 }
	 if(reptdttme==null || reptdttme.equalsIgnoreCase("null"))	 {		 reptdttme="-";	 }
	 if(loadrsn==null || loadrsn.equalsIgnoreCase("null"))	 {		 loadrsn="-";	 }
	 	 if(loadcmt==null || loadcmt.equalsIgnoreCase("null"))	 {		 loadcmt="-";	 }	}
else{
	 endedby="-";	 weight="-";	 vendor="-";	 reptdttme="-";	 tripcat="-";	 freight="-";	 adv="-";
	 loadcmt="-";	 loadrsn="-";} //out.println("Mila");
%>
 <td id="tdw<%=i%>" style="text-align: left; display: none;"><%=weight%></td>
 <td id="tdf<%=i%>" style="text-align: left; display: none;"><%=freight%></td>
 <td id="tda<%=i%>" style="text-align: left; display: none;"><%=adv%></td>
 <td style="text-align: left;"><%=vendor%></td>
 <td style="text-align: left;"><%=tripcat%></td>
 <td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>
 <td id="tdr<%=i%>" style="text-align: left; display: none;"><%=reptdttme%></td>
<td style="text-align: right">
<% 
try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"))));
}catch(Exception ee){
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+"<br>"+STime);
}
%>
 </td>
 <td id="tdl<%=i%>" style="text-align: right; display: none;"><%=LoadingDelay%></td>
 <td id="tdldr<%=i%>"style="text-align: right; display: none;"><%=loadrsn%></td>
 <td id="tdlc<%=i%>"style="text-align: right; display: none;"><%=loadcmt%></td>
  <td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
<td style="text-align: right"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
}catch(Exception ee){
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
}%>
</td>
<td id="tdu<%=i%>"style="text-align: right; display: none;"><%
try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
}catch(Exception ee){
	out.print("-");}
%>
</td>
<td id="tdul<%=i%>"style="text-align: right; display: none;"><%=UnloadingDelay%></td><td id="tdudr<%=i%>"style="text-align: right; display: none;"><%=unloadrsn%></td>
<td id="tduc<%=i%>"style="text-align: right; display: none;"><%=unloadcmt%></td>
<%
//*********************************************query is changed*****************************************************
DecimalFormat twoDForm1 = new DecimalFormat("##.#");
sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rstcloser.getString("StartPlace")+"' and EndPlace = '"+rstcloser.getString("EndPlace")+"' || StartPlace ='"+rstcloser.getString("EndPlace")+"' and EndPlace = '"+rstcloser.getString("StartPlace")+"'";
ResultSet rstdist=st1.executeQuery(sql);
if(stdDist==0 && stdTme==0){
 if(rstdist.next()) {  	stdDist=rstdist.getDouble("Km");
    	stdTme=rstdist.getDouble("TTime"); }}
if(stdDist==0){
	%>
	<td style="text-align: right" id="stkmcolcls<%=i%>">NA</td>	<td style="text-align: right" id="sdtcolcls<%=i%>">NA</td>
	<%}
else{
	%>
	<td style="text-align: right" id="stkmcolcls<%=i%>"><%=twoDForm1.format(stdDist)%></td>	<td style="text-align: right" id="sdtcolcls<%=i%>"><%=twoDForm1.format(stdTme)%></td>
	<%}
%>
<td style="text-align: right" id="kmtcolcls<%=i%>"><%=KmTravelled%></td>
<%
//***************************************************************************************************************
int dist;
dist=0; dist1=0; dist2=0;
%> 
<td style="text-align: right;" id="trpdcolcls<%=i%>"><%=noofdays %></td>
<td style="text-align: right" id="trptcolcls<%=i%>">
<%
try{
	try{
		enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"));	}
	catch(Exception e)	{
		enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate"));	}
long hrs,mins;
double hrslong=0.00;
java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
long x=enddte11.getMinutes();
long y=strdte11.getMinutes();
long timediff=enddte11.getTime()-strdte11.getTime();//msec
long mins11=timediff/1000/60;
if(mins11>=60){
	hrdiff=mins11/60;//2
	if((y>x)&&(x!=0))	{
	mins=y-x;
	mins=60-mins;
	out.print(hrdiff+":"+mins);	}
	else if((x>y)&&(y!=0))	{
		mins=x-y;
	out.print(hrdiff+":"+mins);
		}else if(x==y)	{
		mins=x-y;
			out.print(hrdiff+":"+mins);	}
		 else if((x==0)&&(y>x)) {
	 mins=60-y;
	 out.print(hrdiff+":"+mins);
 }else if(y==0) {
	 mins=x+y;
	 out.print(hrdiff+":"+mins); }}
else{
	hrdiff=0;	mins=mins11;
	out.print(hrdiff+":"+mins);}
String enddte=enddte1+" "+ETime;
String strtdte=strdte1+" "+STime;
long tmeinmils=enddte1.getTime()-strdte1.getTime();
long hours=tmeinmils/(1000*60*60);
String extractstrtminutes=STime.substring(3,5);
String extractendminutes=ETime.substring(3,5);
int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
if(totmins >= 60){
hrdiff=hrdiff+1;
totmins=totmins-60;}}
catch(Exception e){}
%>
</td>
<%
String date1="",date2="",date311="",date411="";
String Sdate="";
double runhrs=00.00;
double avgrunhrs=00.00;
int k=0;
try{
date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));}
catch(Exception e){
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));}
session.setAttribute("data1",date1);session.setAttribute("data2",date2);
String vehid=rstcloser.getString("Vehid");
String sql5="Select SUM(RDurationinHrs) as runhrs from db_gpsExceptions.t_veh"+vehid+"_ds where TheDate>='"+date1+"' and TheDate<='"+date2+"'";
if(i==52){}
ResultSet rs=st3.executeQuery(sql5);
if(rs.next()){
      if(null==rs.getString("runhrs") || rs.getString("runhrs").equalsIgnoreCase("null"))     {
     	runhrs=00.00;      }
else{
	runhrs=rs.getDouble("runhrs");}}
avgrunhrs=runhrs/noofdays;
int j=0;
sql5="Select RDurationinHrs  from db_gpsExceptions.t_veh"+vehid+"_ds where TheDate>='"+date1+"'and TheDate<='"+date2+"'";
if(i==52){}
rs=st3.executeQuery(sql5);
while(rs.next()){
	if(rs.getDouble("RDurationinHrs")>10.00)	{
		j++;	}}
DecimalFormat twoDForm = new DecimalFormat("00.00");
String date3="",date4="";
try{
	date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
	date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}
catch(Exception e){
	date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")+" "+rstcloser.getString("StartTime")));
	date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")+" "+rstcloser.getString("EndTime")));
}
%>
<td style="text-align: right" id="rhrcolcls<%=i%>"><%=twoDForm.format(runhrs)%></td>
<td style="text-align: right" id="avcolcls<%=i%>"><%=twoDForm.format(avgrunhrs)%></td>
<td style="text-align: right" id="rhrvcolcls<%=i%>"><%=rstcloser.getInt("RunHrVio")%></td>
<td style="text-align: right" id="oscolcls<%=i%>"><%=rstcloser.getInt("OSCount")%></td>
<td style="text-align: right" id="osscolcls<%=i%>"><%=twoDForm.format(rstcloser.getDouble("OSDuration"))%></td>
<td style="text-align: right" id="rzonecolcls<%=i%>"><%=twoDForm.format(rstcloser.getDouble("OSDurationInRedZone"))%></td>
<td style="text-align: right" id="yzonecolcls<%=i%>"><%=twoDForm.format(rstcloser.getDouble("OSDurationInYellowZone"))%></td>
<td style="text-align: right" id="gzonecolcls<%=i%>"><%=twoDForm.format(rstcloser.getDouble("OSDurationInGreenZone"))%></td>
<td style="text-align: right" id="racolcls<%=i%>"><%=rstcloser.getInt("RACount")%></td>
<td style="text-align: right" id="rdcolcls<%=i%>"><%=rstcloser.getInt("RDCount")%></td>
<td style="text-align: right" id="dvcolcls<%=i%>"><%if(rstcloser.getInt("DVCount")>0){%><a href="detail_dv.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("VehRegNo")%>&pageType=RouteDeviation&data1=<%=date3%>&data2=<%=date4%>"><%=rstcloser.getInt("DVCount")%><%}else {%><%=rstcloser.getInt("DVCount")%><%}%></a></td>
<td style="text-align: right" id="cdcolcls<%=i%>">
<%
int cdcnt=0;
String sqlcd="select count(*) cdcount from db_gpsExceptions.t_veh"+vehid+"_cr where concat(FromDate,' ',FromTime) >= '"+date3+"' and concat(ToDate,' ',ToTime)<='"+date4+"'";
ResultSet rscd=st16.executeQuery(sqlcd);
while(rscd.next()){
	cdcnt=rscd.getInt("cdcount");
}
%><%
if(cdcnt>0){
	%>		<a href="detail_cd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("VehRegNo")%>&pageType=ContinuousDriving&data1=<%=date3%>&data2=<%=date4%>"><%=cdcnt%></a>
	 <%}
else{	%>
		<%=cdcnt%>
	<%}%>
</td>
<td style="text-align: right" id="ndcolcls<%=i%>">
<%
if(rstcloser.getInt("NDCount")>0){
	%>	<a
		href="detail_nd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("vehregno")%>&pageType=NightDriving&data1=<%=date3%>&data2=<%=date4%>"">
	<%=rstcloser.getInt("NDCount")%> </a> <%}else{
	%>	<%=rstcloser.getInt("NDCount")%>
	<%}%>
</td>
<%
int d=0;
String ndduration="";
   sql5="select SUM(Distance) as distance,Sum(Time_to_Sec(Duration)) as duration from db_gpsExceptions.t_veh"+vehid+"_nd where concat(FromDate,' ',FromTime) >= '"+date3+"' and concat(FromDate,' ',FromTime)<='"+date4+"'";
   System.out.println(k+"ND Distance>>>>>>     "+sql5);
if(i==68){	System.out.println(k+"ND Distance>>>>>>     "+sql5);}
try{
rs=st3.executeQuery(sql5);
if(rs.next()){
	d=rs.getInt("distance");
	ndduration=rs.getString("duration");
	if(ndduration==null || ndduration.equalsIgnoreCase("null")){
		ndduration="0";}
	else{
		String rundur = "";
		int min = 0,hrs = 0,min1 = 0;
		
		min1 = rs.getInt("duration")/60;
		hrs = min1/60;
		min = min1%60;
		
		if(hrs>9)
		{
			rundur = rundur+hrs;
		}
		else
		{
			rundur = "0"+hrs;
		}
		
		if(min>9)
		{
			rundur = rundur+":"+min;
		}
		else
		{
			rundur = rundur+":0"+min;
		}
		ndduration=rundur;
		System.out.println(k+"ND Distance>>>>>>     "+ndduration);
	}
	
	}}
catch(Exception e){e.printStackTrace();}



%>

<td style="text-align: right" id="nddcolcls<%=i%>"><%=d %></td>
<td style="text-align: right" id="ndducolcls<%=i%>"><%=ndduration%></td>
<td style="text-align: right" id="dccolcls<%=i%>">
<%
int discount=0, diskm=0;
String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rstcloser.getString("vehid")+"' and  OffTimeFrom >='"+rstcloser.getString("Startdate")+"'and  OffTimeTo<='"+rstcloser.getString("Enddate")+"' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30' ";
ResultSet rstdis=st2.executeQuery(sqldis);
if(rstdis.next())
{
	if(rstdis.getInt("cnt")>0)	{
		discount=rstdis.getInt("cnt");
		diskm=rstdis.getInt("distance");
		%>
		<a href="disconnectedDetailsReport.jsp?vehicleCode=<%=rstcloser.getString("vehid")%>&VehicleRegNo=<%=rstcloser.getString("vehregno")%>&ownerName=<%=rstcloser.getString("OwnerName")%>&fromDateTime=<%=rstcloser.getString("Startdate")%>&toDateTime=<%=rstcloser.getString("EndDate")%>&counterv=<%=rstdis.getInt("cnt")%>&tripid=<%=rstcloser.getString("TripId")%>"> <%=discount%> </a>
	<%	}	else{
				out.print("0");	}}
else{	out.print("0");}
%>
</td>
<td style="text-align: right" id="dckmcolcls<%=i%>">
<%
if(discount>0){	%>	<%=diskm %>	<%	}
else{	out.print(0);	}
%>
</td>
<td style="text-align: right" id="ratcolcls<%=i%>"><%=twoDForm.format(rstcloser.getDouble("TripRating"))%></td>
<%
sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
rss=st2.executeQuery(sql);
if(rss.next()){	  endedby=rss.getString("EndedBy");} 
	 %>
	  <td style="text-align: left">  
	 <%
	if(endedby.equals("-") || endedby.equals(""))	{
		out.print("Auto Closed");	}
	else	{		out.print(endedby);	}
	 %>	 </td>
	 <%
	 try	 {
	 String sqlname="select distributername from db_gps.t_startedjourney where TripID='"+rstcloser.getString("Tripid")+"'";
	 ResultSet rstd=st20.executeQuery(sqlname);
	 if(rstd.next())	 {
		 distributorname=rstd.getString("distributername");		 	 }
	 else{
		 distributorname="-";
	 }
	 
		 %>
	 <td style="text-align: left"><diV><%=distributorname %></diV></td>
	 <%
	 sqlbrif="select Briefid from db_gps.t_briefing where tripid='"+rstcloser.getString("Tripid")+"'";
	 ResultSet rsbriefing=st21.executeQuery(sqlbrif);
	 if(rsbriefing.next())	 {
		 briefing=rsbriefing.getString("Briefid");		 	 }
	 else{
		 briefing="-";
	 }
	 %>
	 <td style="text-align: right"><div><%=briefing%></div></td>
<% 
    String sqlnew2="select debriefid from db_gps.t_debriefing where tripid='"+rstcloser.getString("Tripid")+"'";
	ResultSet rsDbriefing=st22.executeQuery(sqlnew2);
	 if(rsDbriefing.next())	 {
		 Dbriefing=rsDbriefing.getString("debriefid");			 }
	 else{
		 Dbriefing="-";
	 }
	 %>
	 <td style="text-align: right"><div><%=Dbriefing%></div></td>
	 <%	 }
	 catch(Exception e)	 {
		 e.printStackTrace();	 }
	 %></tr> <%}%>
	 
	 
 <input type="hidden" name="cntcls" id="cntcls" value="<%=i%>">
 <%  %></table><% }
//if status closed	 
///////////////////OPEN TRIPS//////////////////////



else if(statusname.equalsIgnoreCase("Open") || searchstatus1.equalsIgnoreCase("Yes") || searchstatus1.equals("Yes")){
	System.out.println("searchstatus1>>>>>>>>" +searchstatus1);
	
	
	
	DecimalFormat twoDForm1 = new DecimalFormat("##.#");
double totKm=0,remKm=0;
Statement st4, sttemp,stopen,stveh;
String sql, sql1, sql2,sql3,sqlopen,sqlveh;

ResultSet rs2=null;
String sttdate="",comments="-";
String vehdesc1="-",bgcolor1="",bgcolor2="",temptime="",vehmodel1="-",vehtype1="-",tripcat1="-",adv1="-",freight1="-",endedby1="-",weight1="-",vendor11="-",reptdttme1="-",tripid1="";
String gpname1="",ETA1="",today="",lastweek="", sdate="",edate="",lastmonth="",startDate="",startCode="",startTime="",endCode="",TransTime="",updatedTm="",scheTmDt="",updtetime="",DisDate="",ETADate="";
int km1=0,km2=0,km3=0,km4=0,km5=0,km6=0,km7=0,km8=0,km9=0, kmrun1=0, kmrun2=0, kmrundist=0,todaysdist=0;
long diffDays=0,tTime=0;
java.util.Date dt1 = null;
String ftime1="00";
String ftime2="00";
String ftime3="00";
String ttime1="00";
String ttime2="00";
String ttime3="00";
String dateformat="dd-MMM-yyy";
System.out.println("Hi date a");

		dateformat=session.getAttribute("dateformat").toString();
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String currenttime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
		System.out.println("Hi date m");

	st4=conn.createStatement();
	stveh=conn.createStatement();
	stopen=conn.createStatement();
	String mydate1,mydate2;
	
	System.out.println("Hi date b");
	
	
	System.out.println("Hi date is 1");
	System.out.println("Hi date i");

	
	
	
	
	System.out.println("Hi date bgh");

	
	String myvehlist=request.getParameter("vehicle");
%>

<%
if(searchstatus1.equalsIgnoreCase("Yes") || searchstatus1.equals("Yes"))
{
}
else if(searchstatus1.equalsIgnoreCase("") || searchstatus1=="" || searchstatus1.equals("")){
	
	
	mydate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
	mydate2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
%>
<table border="0" width="100%" align="center"> 
		<tr>		<td bgcolor="#F0E68C" class="sorttable_nosort" width="10%">
			<b>Color Code Indications :&nbsp;&nbsp;<a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=all"><span>Full Fleet</span></a>
			</b>		</td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=BDEDFF">ETA Crossed</a></b></td>
		<td bgcolor="#EEC5C8" class="sorttable_nosort"><b><a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=EEC5C8">Run Average low</a></b></td>
		<td bgcolor="#FFCC99" class="sorttable_nosort" ><b><a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=FFCC99">Average</a></b></td>
		<td bgcolor="#FFFED3" class="sorttable_nosort"><b><a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=FFFED3">Acceptable</a></b></td>
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=CCFFCC">Outstanding</a></b></td>
		<td bgcolor=""        class="sorttable_nosort" ><b><a href="my_trips.jsp?data1=<%=mydate1%>&data2=<%=mydate2%>&status=Open&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&ubmit=Submit&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=myvehlist%>&colorvalue=">Undefined</a></b></td>
		<td align="center" colspan="24" width="40%">
<font  size="3" color="blue"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font> </td>	
			<td id="print" colspan="1" width="100">
<a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a> &nbsp;
</td><td id="excel" colspan="1" width="100">
 <a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>&colorvalue=<%=request.getParameter("colorvalue") %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
 <td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%> 
</td>		</tr>	</table><%}else{} %>

	
		<table border="1" class="sortable" width="100%">	<tr>
	<th  class="hed" id="src1col" valign="top"> Sr No</th>
<th  class="hed" id="vehcol" valign="top"><a href="#" onClick="hide1('veh');" title="Click to hide Desc,Mode1,Type Cols"><img id="img11" src="images/sub.jpg" width="13px" height="10px" border="0"> </a><br></br>Vehicle</th> 
	<th class="hed" id="desccol" valign="top"> Desc</th>	<th class="hed" id="modcol" valign="top"> Model</th>
	<th  class="hed" id="typecol" valign="top">Type</th>	<th class="hed" id="ownercol" valign="top">Owner</th>
	<th class="hed" id="tripcol" valign="top"><a href="#" onClick="hide2('trip');" title="Click to hide Cols"><img id="img12" src="images/sub.jpg" width="13px" height="10px" border="0"> </a><br></br>TripID</th>
	<th class="hed" id="cncol" valign="top">CN</th>	<th class="hed" id="updtetmecol" valign="top">Updated Dat-Time</th>
	<th class="hed" id="curposcol" valign="top">Current Position</th>	<th class="hed" id="drivcol" valign="top">Driver</th>
	<th class="hed" id="stplacecol" valign="top">Start Place</th>	<th class="hed" id="stdatecol" valign="top">Start Date-Time</th>
	<th class="hed" id="endplacecol" valign="top">End Place</th>	<th class="hed" id="etacol" valign="top">ETA</th>
	<th class="hed" id="FixedTimecol" valign="top">FixedTime</th>	<th class="hed" id="FixedKmcol" valign="top">FixedKm</th>
  	<!--<th class="hed" id="kmsruncol" valign="top"> <a href="#" onClick="hide('kmsrun');" title="Click to hide KmsToRun,ETA Cols"> <img src="images/sub.jpg" id="img2" width="13px" height="10px" border="0"></a> <br><B>Kms run</B></th>-->
  	<th class="hed" id="kmsruncol" valign="top">Kms run</th> 	<th class="hed" id="kmstoruncol" valign="top">Kms to run</th> 
 	<th class="hed" id="wtcol" valign="top">Weight Kg</th>	<th class="hed" id="frcol" valign="top" >Freight Rs</th>
	<th class="hed" id="adrscol" valign="top" >Advance Rs</th>	<th class="hed" id="vendorcol" valign="top">Customer</th>
	<th class="hed" id="catcol" valign="top">Category</th>	<th class="hed" id="cmtcol" valign="top">Comments</th>
	</tr>	
		<%
		if(searchstatus1.equalsIgnoreCase("Yes") || searchstatus1.equals("Yes"))
		{
		sql="select * from t_startedjourney where TripId='"+STripId+"'";

		}
		else{
	sql="select * from t_startedjourney where Jstatus in('Running','tobeclosed') and (OwnerName = '"+session.getAttribute("usertypevalue").toString()+"' or GPName = '"+session.getAttribute("usertypevalue").toString()+"' OR Vendor='"+session.getAttribute("usertypevalue").toString()+"') and Vehid in"+session.getAttribute("VehList").toString()+"AND  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by concat(StartDate,' ',StartTime) desc";
		}
    System.out.println("\n\n started journey query-->>"+sql);
		ResultSet rsttrips=st.executeQuery(sql);
	int j=1,k=0;
	while(rsttrips.next())	{
		k++;
		comments=rsttrips.getString("Loadcomments");		  totKm=rsttrips.getDouble("FIxedKM");
	      tTime=rsttrips.getLong("FIxedTime"); 	      gpname1=rsttrips.getString("GPName");
	      ETA1=rsttrips.getString("ETA");	      ETADate=ETA1;
	      if(!(null==ETA1))	      {
	       ETA1=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA1));
	      }
	      String curpos="",  lat="", lon="";
		kmrundist=0;		kmrun1=0;kmrun2=0;
		String vehno=rsttrips.getString("VehRegNo");
		sql="select * from t_onlinedata where VehicleCode='"+rsttrips.getString("VehId")+"'";
		ResultSet rs1=st1.executeQuery(sql);
				try{
			if(rs1.next())			{
				curpos=rs1.getString("Location");
			   temptime=rs1.getString("TheTime");
				updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))+" "+rs1.getString("TheTime");
				lat=rs1.getString("LatitudePosition");
				lon=rs1.getString("LongitudePosition");			}
		  }catch(Exception exc)		  {			exc.printStackTrace();	      }
		
		try{
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDateTime between '"+rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")+"' AND '"+today+" "+currenttime+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime asc limit 1";
				ResultSet rstkmrun1=st1.executeQuery(sql);
				if(rstkmrun1.next())				{
					kmrun1=rstkmrun1.getInt("Distance");				}
		  }catch(Exception e)			{				e.printStackTrace();			}
		  try{
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDateTime between '"+rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")+"' AND '"+today+" "+currenttime+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime desc limit 1";
				ResultSet rstkmrun2=st1.executeQuery(sql);
			if(rstkmrun2.next())			{				kmrun2=rstkmrun2.getInt("Distance");			}
		}catch(Exception e1)		{			e1.printStackTrace();		}
			try{
		long myMilisec;
		sql="select * from db_gps.t_startedjourney where StartDate='"+rsttrips.getDate("StartDate")+"'and StartTime='"+rsttrips.getTime("StartTime")+"' and StartCode='"+rsttrips.getString("StartCode")+"' and EndCode='"+rsttrips.getString("EndCode")+"' and Vehid="+rsttrips.getString("VehId")+"";
		ResultSet rstTotKm=st3.executeQuery(sql);
		if(rstTotKm.next())		{
			sql3="select * from db_gps.t_castrolroutes where StartPlace = '"+rsttrips.getString("StartPlace")+"' and EndPlace = '"+rsttrips.getString("EndPlace")+"' || EndPlace = '"+rsttrips.getString("StartPlace")+"' and StartPlace = '"+rsttrips.getString("EndPlace")+"' limit 1 ";
			ResultSet rst123=st4.executeQuery(sql3);
			if(totKm==0 && tTime==0 )
			if(rst123.next())				{
					totKm=rst123.getDouble("Km");
				    tTime=rst123.getLong("TTime");				}		}
		kmrundist=kmrun2-kmrun1;  //Finding tot run km by vehicle after trip started.
		remKm=totKm-kmrundist;  // Adding todays km also
		myMilisec=(tTime*60*60*1000);
		if(!(null==ETADate))		{
			ETADate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETADate));	 
			 DisDate=ETADate;		}
		else		{
		if(myMilisec!=0)		{
      	java.util.Date resultdate = new java.util.Date();
      	 SimpleDateFormat sdftimemilli = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      	Date startDtTm = sdftimemilli.parse(rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")); 
    		long start=startDtTm.getTime();
		long totdate= start+myMilisec;
		resultdate.setTime(totdate);
        DisDate=new SimpleDateFormat(dateformat+" HH:mm:ss").format(resultdate);		}
		else{			DisDate="NA";		}		}
	}catch(Exception e11)	{
		System.out.println("---I am in exception--kmrundist-");
		e11.printStackTrace();	}
	sdate= rsttrips.getString("Startdate");
	
	String STime=rsttrips.getString("StartTime");
	try	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
		fromdate=fromdate+" "+STime;
		fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate))+" "+STime;
	}
	catch(Exception e)	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
		fromdate=fromdate+" "+STime;
		}
	try	{
	java.util.Date sdt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
	ftime1="00";
	ftime2="00";	
	ftime3="00";
	}
	
	catch(Exception e)  	{
  		ftime1="00";
  		ftime2="00";
  		ftime3="00";	
	}
	 edate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	 try	 {
		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));	 }
	 catch(Exception e)	 {
		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate)); 	 }
try{
	 java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
	 ttime1=""+edt.getHours();
	 ttime2=""+edt.getMinutes();
	 ttime3=""+edt.getSeconds();}
catch(Exception e)	{
		ttime1="23";
	 	ttime2="59";ttime3="59";	}
if(updtetime.equalsIgnoreCase("NA") || DisDate.equalsIgnoreCase("NA"))
{	System.out.println("\n\n in NA");
	bgcolor1="";
	bgcolor2="";}
else{
		try{
		sttdate= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate")));
	}catch(Exception ee)	{
		sttdate= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrips.getString("StartDate")))+" "+rsttrips.getString("StartTime");
	}	
 SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 Date date1 = sdf1.parse(updtetime);
 Date date2 = sdf1.parse(sttdate);
 Date date3 = sdf1.parse(DisDate);
  float timdiff=0,avg;
 long msec = date1.getTime() - date2.getTime();
 timdiff=(float)(msec / 1000 / 60/ 60);
 avg=(kmrundist/timdiff);
if(date1.compareTo(date3)>0){
	System.out.println("\nupdated date  is greater than arrivel date");
	bgcolor1="#BDEDFF";
	bgcolor2="BDEDFF";
}else {
	if(avg<=10){
	System.out.println("\nin less than 10");
	bgcolor1="#EEC5C8";
	bgcolor2="EEC5C8";
}else if(avg>10 && avg<=12){
	bgcolor1="#FFCC99";
	bgcolor2="FFCC99";
}else if(avg>12 && avg<=14.5){
	bgcolor1="#FFFED3";
	bgcolor2="FFFED3";}else if(avg>14.5){
	bgcolor1="#CCFFCC";
	bgcolor2="CCFFCC";
	}}}	
	%>
	<%
	System.out.println("\n\n color value-->>"+request.getParameter("colorvalue"));
	System.out.println("\n\n bgcolor value-->>"+bgcolor2);
	if("all".equals(request.getParameter("colorvalue")) || searchstatus1.equalsIgnoreCase("Yes"))	{
	%>
	<tr>
	<td style="text-align: right;background-color:<%=bgcolor1%>" id="src1col<%=k%>"><%=j%>
		</td>
	<td WIDTH="6%" id="vehcol<%=k%>" style="background-color:<%=bgcolor1%>" ><div align="right"   >
<font>
<a href="javascript:toggleDetails1(<%=j%>,true);" title="Click To See the Reports"><font size="2"><%=rsttrips.getString("VehRegNo")%></font></a> </font><br />
<div class="popup" id="popup1<%=j%>">
<table border="1" bgcolor="white">
<tr>
<td> <a href="detailed_report.jsp?vehcode=<%=rsttrips.getString("VehId")%>&fromdata=<%=fromdate%>&todata=<%=todate%>" onclick="toggleDetails1(<%=j%>,false);">Custom Detail Report </a>
</td>

</tr>
<tr><td><a href="javascript:toggleDetails1(<%=j%>,false);">Close</a></td></tr>
</table></div> </div></td>
<%
try{
sqlveh="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rsttrips.getString("VehRegNo")+"' order by VehicleRegNumber";
ResultSet rstveh=stveh.executeQuery(sqlveh);
System.out.println("veh desc open"+sqlveh);
if(rstveh.next())
{vehdesc1=rstveh.getString("VehDesc");
if(vehdesc1==null || vehdesc1.equalsIgnoreCase("null"))
{	vehdesc1="-";}
vehmodel1=rstveh.getString("VehModel");
if(vehmodel1==null || vehmodel1.equalsIgnoreCase("null"))
{	vehmodel1="-";}
vehtype1=rstveh.getString("VehType1");
if(vehtype1==null || vehtype1.equalsIgnoreCase("null"))
{	vehtype1="-";}}
else{	vehdesc1="-";
	vehmodel1="-";
	vehtype1="-";}}catch(Exception e)	{
		e.printStackTrace();	}
%>
<td style="background-color:<%=bgcolor1%>" id="desccol<%=k%>" ><%=vehdesc1%></td>
<td style="background-color:<%=bgcolor1%>" id="modcol<%=k%>"><%=vehmodel1%></td>
<td style="background-color:<%=bgcolor1%>" id="typecol<%=k%>"><%=vehtype1%></td>
<td style="text-align: left;background-color:<%=bgcolor1%>" id="ownercol<%=k%>"><%=rsttrips.getString("OwnerName")%></td>
<td WIDTH="6%" style="background-color:<%=bgcolor1%>" id="tripcol<%=k%>"><div align="right" >
<font size="2">
<a href="javascript:toggleDetails2(<%=j%>,true);" title="Click To See the Reports"><font size="2"><%=rsttrips.getString("TripId")%></font></a> </font><br />
<div class="popup" id="popup_<%=j%>">
<table border="1" bgcolor="white">
<tr><td>
<%
String briefid = "",rid = "",plannedstatus = "No";
boolean flag = false;
 sql1 = "select * from db_gps.t_briefing where tripid = '"+rsttrips.getString("TripId")+"'";
 rs1 = st1.executeQuery(sql1);
if(rs1.next())
{briefid = rs1.getString("Briefid");}
sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rsttrips.getString("TripId")+"' and briefid = '"+briefid+"' and driverid = '"+rsttrips.getString("DriverCode")+"'  order by advancedtrackid asc ,row asc limit 1 ";
rs1 = st1.executeQuery(sql1);
if(rs1.next())
{rid = rs1.getString("advancedrouteid");
	plannedstatus = "Yes";
	flag = true;}
%>
<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rsttrips.getString("TripId")%>&vehcode=<%=rsttrips.getString("VehId")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ftime3=<%=ftime3 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&ttime3=<%=ttime3 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=rsttrips.getString("DriverCode")%>" onclick="javascript:toggleDetails2(<%=j%>,false);">Show Trip On Map</a>
</td></tr>
<%
			if (gpname1.equalsIgnoreCase("Castrol"))			{
				}
			else{
				String tripflag="true";
				System.out.println("\n\n in castrol");
				String strdate12=rsttrips.getString("StartTime");
				System.out.println("\n\n in NA 1");
					strdate12=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:MM:SS").parse(strdate12));
					System.out.println("\n\n in NA 2");
					String ETA="";
                String NA="NA";
                ETA=DisDate;
                System.out.println("\n\nETA "+ETA);
                System.out.println("\nNA "+NA);
                if(ETA.equalsIgnoreCase(NA))
                {                	System.out.println("\n\n in NA 3");                	ETA=null;                }
                else                {
                	System.out.println("\n\n in NA 4");             
                ETA=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(DisDate));
                }
%>		   				   				<tr>				   			<td>				   									 
				   			<a href="edittrip.jsp?vehno=<%=rsttrips.getString("VehRegNo")%>
				   							&ReportDateTime=<%=rsttrips.getString("ReportDateTime")%>
				   							&strloc=<%=rsttrips.getString("StartPlace")%>
				   
   							&StartTime=<%=strdate12%>
				   							&ETA=<%=ETA%>
				   							&endp=<%=rsttrips.getString("EndPlace")%>
				   							&driverid=<%=rsttrips.getString("DriverCode")%>
				   							&drivern=<%=rsttrips.getString("DriverName")%>
				   							&tripid=<%=rsttrips.getString("Tripid")%>&tripflag=<%=tripflag%>">Edit Trip </a>
							</td>						</tr>						<tr>						<td> 
						<a href="javascript:toggleDetails2(<%=j%>,true);" onclick="javascript:window.open ('CancelTrip.jsp?vehno=<%=rsttrips.getString("VehRegNo")%>&tripid=<%=rsttrips.getString("Tripid")%>','win3','scrollbars=1,resizeable=0,width=300,height=300');";>Cancel Trip</a>
		  				</td>		   				</tr>
<%
				}
%>
<tr><td><a href="javascript: false"  onclick="javascript:window.open('endtrip.jsp?tripid=<%=rsttrips.getString("Tripid")%>&vehcode=<%=rsttrips.getString("VehId")%>&vehno=<%=rsttrips.getString("VehRegNo")%>&pageflag=<%=pageflag%>','','menubar=1,resizable=2,width=900,height=700,location=no');">End Trip</a>
</td></tr>


<%if(role.equalsIgnoreCase("Castrolsuperadmin") || role.equals("Castrolsuperadmin")) {
%>
<tr><td>
<a href="#" onclick="javascript:window.open('OverrideReport.jsp?tripid=<%=rsttrips.getString("Tripid")%>&vid=<%=rsttrips.getString("VehId")%>&vehRegNo=<%=rsttrips.getString("VehRegNo")%>&Transporter=<%=rsttrips.getString("OwnerName")%>&SD=<%=rsttrips.getString("StartDate")%> <%=rsttrips.getString("StartTime")%>&ED=<%=today%> <%=currenttime%>&ST=<%=rsttrips.getString("StartTime") %>&ET=<%=currenttime %>')">
Violation Override</a></td></tr>
<%} %>
<tr><td>
<a href="#" onclick="javascript:window.open('trippdf.jsp?tripid=<%=rsttrips.getString("Tripid")%>&owner=<%=rsttrips.getString("OwnerName")%>&vid=<%=rsttrips.getString("VehId")%>&vehRegNo=<%=rsttrips.getString("VehRegNo")%>')">Print</a>
</td></tr>
<tr><td><a href="javascript:toggleDetails2(<%=j%>,false);">Close</a></td></tr>
</table></div> </div></td>
<%
try{
String cnfile="";	
String sqlfile="select cnfilename from db_gps.t_startedjourney where TripID='"+rsttrips.getString("TripId")+"'";
ResultSet rs55=st4.executeQuery(sqlfile);
if(rs55.next()){
cnfile=rs55.getString("cnfilename");}
if(cnfile.equalsIgnoreCase("-")){
	%>
	<td style="background-color:<%=bgcolor1%>" id="cncol<%=k%>"><%=rsttrips.getString("cnnumber")%></td>
	<%
}else{
		%>
	<td style="background-color:<%=bgcolor1%>" id="cncol<%=k%>">
<a href="#" onclick="getFTPImage('<%=rs55.getString("cnfilename")%>')">
					<%=rsttrips.getString("cnnumber")%></a></td>	
	<%
}}catch(Exception e){
	e.printStackTrace();}
%>
	<td style="background-color:<%=bgcolor1%>"id="updtetmecol<%=j%><%=k%>"><div align="right"><%=updtetime%> </div></td>
	<td WIDTH="8%" style="background-color:<%=bgcolor1%>"id="curposcol<%=j%><%=k%>"><div align="left"> 
	<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>','myWin','width=500,height=500');popWin.focus();return false">
	<%=curpos%> </a></div></td>
	<td style="background-color:<%=bgcolor1%>"id="drivcol<%=j%><%=k%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
	<td style="background-color:<%=bgcolor1%>"id="stplacecol<%=j%><%=k%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
	<td style="text-align: right;background-color:<%=bgcolor1%>"id="stdatecol<%=j%><%=k%>">
	<% try{
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate"))));
	}catch(Exception ee)	{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrips.getString("StartDate")))+"<br>"+rsttrips.getString("StartTime"));
	}
	%></td>
		<td style="background-color:<%=bgcolor1%>"id="endplacecol<%=j%><%=k%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
		<td style="background-color:<%=bgcolor1%>" id="etacol<%=j%><%=k%>"><div align="right"><%=DisDate%> </div></td>
	<%
			if(tTime==0 && totKm==0)		{
			%>
				<td style="text-align: left;background-color:<%=bgcolor1%>" id="FixedTimecol<%=k%>"> <br>NA</td>
				<td style="text-align: left;background-color:<%=bgcolor1%>" id="FixedKmcol<%=k%>"> <br>NA</td>
				<%		}
		else		{
			%>
				<td style="text-align: right;background-color:<%=bgcolor1%>" id="FixedTimecol<%=k%>"> <br> <%=tTime%></td>
			     <% System.out.println("FixedTIme----->"+tTime );%>
            	<td style="text-align: right;background-color:<%=bgcolor1%>" id="FixedKmcol<%=k%>"> <br> <%=twoDForm1.format(totKm) %></td>
				<% System.out.println("FixedKm----->"+totKm );%>
			<%		}
		%>
		<td style="text-align: right;background-color:<%=bgcolor1%>" id="kmsruncol<%=k%>"> <%=kmrundist%></td>  
	<%
		if(tTime==0 && totKm==0)		{
			%>
			<td style="text-align: right;background-color:<%=bgcolor1%>" id="kmstoruncol<%=k%>"><div align="left">NA</div></td>
			<%		}
		else		{
			%>
					<td style="text-align: right;background-color:<%=bgcolor1%>" id="kmstoruncol<%=k%>"><%=twoDForm1.format(remKm)%></td>
			<%		}
		%>
		<%
sqlopen="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,TripCategory from t_startedjourney where tripid='"+rsttrips.getString("Tripid")+"'";
ResultSet rssopen=stopen.executeQuery(sqlopen);
if(rssopen.next()){
	endedby1=rssopen.getString("EndedBy");
	 weight1=rssopen.getString("Weight");
	 if(weight1==null || weight1.equalsIgnoreCase("null"))
	 {		 weight1="-";	 }
	 vendor11=rssopen.getString("Vendor");
	 
	 if(vendor11.equalsIgnoreCase("select") || vendor11==null || vendor11.equalsIgnoreCase("null"))
	 {		 vendor11="-";	 }
	 tripcat1 =rssopen.getString("TripCategory");
	 if(tripcat1.equalsIgnoreCase("select") || tripcat1==null || tripcat1.equalsIgnoreCase("null"))
	 {		 tripcat1="-";	 }
	 freight1 =rssopen.getString("Frieght");
	 if(freight1==null || freight1.equalsIgnoreCase("null"))
	 {		 freight1="-";	 }
	 adv1 =rssopen.getString("Advance");
	 if(adv1==null || adv1.equalsIgnoreCase("null"))
	 {		 adv1="-";	 }}
else{
	 endedby1="-";
	 weight1="-";
	 vendor11="-";
	 tripcat1="-";
	 freight1="-";
	 adv1="-";	} //out.println("Mila");
%>
 <td style="text-align: right;background-color:<%=bgcolor1%>" id="wtcol<%=k%>"><%=weight1%></td>
 <td style="text-align: right;background-color:<%=bgcolor1%>" id="frcol<%=k%>"><%=freight1%></td>
 <td style="text-align: right;background-color:<%=bgcolor1%>" id="adrscol<%=k%>"><%=adv1%></td>
 <td style="text-align: left;background-color:<%=bgcolor1%>"  id="vendorcol<%=k%>"><%=vendor11%></td>
 <td style="text-align: left;background-color:<%=bgcolor1%>"  id="catcol<%=k%>"><%=tripcat1%></td>
  <td style="text-align: left;background-color:<%=bgcolor1%>" id="cmtcol<%=k%>"><%=comments%>
    </td>	</tr>	   	
		<%	}
	else if(bgcolor2.equals(request.getParameter("colorvalue")))	{
		%>
		<tr>
		<td style="text-align: right;background-color:<%=bgcolor1%>" id="src1col<%=k%>"><%=j%></td>
	<td  WIDTH="6%" id="vehcol<%=k%>" style="background-color:<%=bgcolor1%>" WIDTH="%"><div align="right"   >
	<font>
	<a href="javascript:toggleDetails1(<%=j%>,true);" title="Click To See the Reports"><font size="2"><%=rsttrips.getString("VehRegNo")%></font></a> </font><br />
	<div class="popup" id="popup1<%=j%>">
	<table border="1" bgcolor="white">
	<tr>
					<td> <a href="detailed_report.jsp?vehcode=<%=rsttrips.getString("VehId")%>&fromdata=<%=fromdate%>&todata=<%=todate%>" onclick="toggleDetails1(<%=j%>,false);">Custom Detail Report </a>
			</td></tr>
	<tr><td><a href="javascript:toggleDetails1(<%=j%>,false);">Close</a></td></tr>
	</table>	</div> 	</div></td>
	<%
	try{
	sqlveh="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rsttrips.getString("VehRegNo")+"' order by VehicleRegNumber";
	ResultSet rstveh=stveh.executeQuery(sqlveh);
	System.out.println("veh desc color value" +sqlveh);
	if(rstveh.next())	{
	vehdesc1=rstveh.getString("VehDesc");
	if(vehdesc1==null || vehdesc1.equalsIgnoreCase("null"))
	{
		vehdesc1="-";	}
	vehmodel1=rstveh.getString("VehModel");
	if(vehmodel1==null || vehmodel1.equalsIgnoreCase("null"))
	{
		vehmodel1="-";	}
	vehtype1=rstveh.getString("VehType1");
	if(vehtype1==null || vehtype1.equalsIgnoreCase("null"))
	{
		vehtype1="-";	}	}
	else	{
		vehdesc1="-";
		vehmodel1="-";
		vehtype1="-";	}}catch(Exception e)
		{
			e.printStackTrace();		}
	%>
	<td style="background-color:<%=bgcolor1%>" id="desccol<%=k%>" ><%=vehdesc1%></td>
	<td style="background-color:<%=bgcolor1%>" id="modcol<%=k%>"><%=vehmodel1%></td>
	<td style="background-color:<%=bgcolor1%>" id="typecol<%=k%>"><%=vehtype1%></td>
	
	

	<td style="text-align: left;background-color:<%=bgcolor1%>" id="ownercol<%=k%>"><%=rsttrips.getString("OwnerName")%></td>
	<td WIDTH="6%" style="background-color:<%=bgcolor1%>" id="tripcol<%=k%>"><div align="right" >
	<font size="2">
	<a href="javascript:toggleDetails2(<%=j%>,true);" title="Click To See the Reports"><font size="2"><%=rsttrips.getString("TripId")%></font></a> </font><br />
	<div class="popup" id="popup_<%=j%>">
	<table border="1" bgcolor="white">	<tr>
	<td>
	<%
String briefid = "",rid = "",plannedstatus = "No";
boolean flag = false;
 sql1 = "select * from db_gps.t_briefing where tripid = '"+rsttrips.getString("TripId")+"'";
 rs1 = st1.executeQuery(sql1);
if(rs1.next())
{briefid = rs1.getString("Briefid");}
sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rsttrips.getString("TripId")+"' and briefid = '"+briefid+"' and driverid = '"+rsttrips.getString("DriverCode")+"'  order by advancedtrackid asc ,row asc limit 1 ";
rs1 = st1.executeQuery(sql1);
if(rs1.next())
{rid = rs1.getString("advancedrouteid");
	plannedstatus = "Yes";
	flag = true;}
%>
	<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rsttrips.getString("TripId")%>&vehcode=<%=rsttrips.getString("VehId")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ftime3=<%=ftime3 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&ttime3=<%=ttime3 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=rsttrips.getString("DriverCode")%>" onclick="javascript:toggleDetails2(<%=j%>,false);">Show Trip On Map</a>
	</td>	</tr>
	<%
				if (gpname1.equalsIgnoreCase("Castrol"))				{
					}				else{
					String tripflag="true";
					System.out.println("\n\n in castrol");
			    	String strdate12=rsttrips.getString("StartTime");
					System.out.println("\n\n in NA 1");
						strdate12=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:MM:SS").parse(strdate12));
						System.out.println("\n\n in NA 2");
						String ETA="";
	                String NA="NA";
	                ETA=DisDate;
	                System.out.println("\n\nETA "+ETA);
	                System.out.println("\nNA "+NA);
	                if(ETA.equalsIgnoreCase(NA))	                {
	                	System.out.println("\n\n in NA 3");
	                	ETA=null;	                }
	                else	                {
	                	System.out.println("\n\n in NA 4");
	                    ETA=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(DisDate));
	                }
	%>		   				
			   				<tr>			   			<td>				   									 
					   			<a href="edittrip.jsp?vehno=<%=rsttrips.getString("VehRegNo")%>
					   							&ReportDateTime=<%=rsttrips.getString("ReportDateTime")%>
					   							&strloc=<%=rsttrips.getString("StartPlace")%>
					   							&strdate=<%=fromdate%>
					   							&StartTime=<%=strdate12%>
					   							&ETA=<%=ETA%>
					   							&endp=<%=rsttrips.getString("EndPlace")%>
					   							&driverid=<%=rsttrips.getString("DriverCode")%>
					   							&drivern=<%=rsttrips.getString("DriverName")%>
					   							&tripid=<%=rsttrips.getString("Tripid")%>&tripflag=<%=tripflag%>">Edit Trip </a>
								</td>	</tr><tr><td> 
							<a href="javascript:toggleDetails2(<%=j%>,true);" onclick="javascript:window.open ('CancelTrip.jsp?vehno=<%=rsttrips.getString("VehRegNo")%>&tripid=<%=rsttrips.getString("Tripid")%>','win3','scrollbars=1,resizeable=0,width=300,height=300');";>Cancel Trip</a>
			  				</td></tr>	<%
			}
	%>
	<tr><td>

<a href="#" onclick="javascript:window.open('trippdf.jsp?tripid=<%=rsttrips.getString("Tripid")%>&owner=<%=rsttrips.getString("OwnerName")%>&vid=<%=rsttrips.getString("VehId")%>&vehRegNo=<%=rsttrips.getString("VehRegNo")%>')">Print</a>


</td></tr>
	<tr><td>
	<a href="javascript: flase"  onclick="javascript:window.open('endtrip.jsp?tripid=<%=rsttrips.getString("Tripid")%>&vehcode=<%=rsttrips.getString("VehId")%>&vehno=<%=rsttrips.getString("VehRegNo")%>&pageflag=<%=pageflag%>','','menubar=1,resizable=2,width=900,height=700,location=no');">End Trip</a>
	</td>	</tr>
	
	<%if(role.equalsIgnoreCase("Castrolsuperadmin") || role.equals("Castrolsuperadmin")) {%>

	
	<tr><td>
<a href="#" onclick="javascript:window.open('OverrideReport.jsp?tripid=<%=rsttrips.getString("Tripid")%>&vid=<%=rsttrips.getString("VehId")%>&vehRegNo=<%=rsttrips.getString("VehRegNo")%>&Transporter=<%=rsttrips.getString("OwnerName")%>&SD=<%=rsttrips.getString("StartDate")%> <%=rsttrips.getString("StartTime")%>&ED=<%=today%> <%=currenttime%>&ST=<%=rsttrips.getString("StartTime") %>&ET=<%=currenttime %>')">
Violation Override</a></td></tr>
<%} %>
	<tr><td><a href="javascript:toggleDetails2(<%=j%>,false);">Close</a></td></tr>
	</table>	</div> 	</div></td>
		<%
		try{
String cnfile111="";	
String sqlfile11="select cnfilename from db_gps.t_startedjourney where TripID='"+rsttrips.getString("Tripid")+"'";
System.out.println("cnfile11 query is " +sqlfile11);
ResultSet rs51=st4.executeQuery(sqlfile11);
if(rs51.next()){
	cnfile111=rs51.getString("cnfilename");}
System.out.println("cnfile11 is " +cnfile111);
if(cnfile111.equalsIgnoreCase("-")){
	%>
 <td style="text-align: right;background-color:<%=bgcolor1%>" id="cncol<%=k%>"><%=rsttrips.getString("cnnumber")%></td>
	<%}
else{
		%>
	<td style="background-color:<%=bgcolor1%>" id="cncol<%=k%>">
<a href="#" onclick="getFTPImage('<%=rs51.getString("cnfilename")%>')">
					<%=rsttrips.getString("cnnumber")%></a></td>	
	<%}
}catch(Exception e){	e.printStackTrace();}
%>
		<td style="background-color:<%=bgcolor1%>"id="updtetmecol<%=j%><%=k%>"><div align="right"><%=updtetime%> </div></td>
		<td WIDTH="8%" style="background-color:<%=bgcolor1%>"id="curposcol<%=j%><%=k%>"><div align="left"> 
		<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>','myWin','width=500,height=500');popWin.focus();return false">
		<%=curpos%> </a></div></td>
		
		<td style="background-color:<%=bgcolor1%>"id="drivcol<%=j%><%=k%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
		<td style="background-color:<%=bgcolor1%>"id="stplacecol<%=j%><%=k%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
		<td style="text-align: right;background-color:<%=bgcolor1%>"id="stdatecol<%=j%><%=k%>">
		<% try{
			out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate"))));
		}catch(Exception ee)
		{
			out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrips.getString("StartDate")))+"<br>"+rsttrips.getString("StartTime"));
		}		%></td>
			<td style="background-color:<%=bgcolor1%>"id="endplacecol<%=j%><%=k%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
				<td style="background-color:<%=bgcolor1%>" id="etacol<%=j%><%=k%>"><div align="right"><%=DisDate%> </div></td>
			
			
				
	<%
		if(tTime==0 && totKm==0)
			{
				%>
					<td style="text-align: left;background-color:<%=bgcolor1%>" id="FixedTimecol<%=k%>"> <br>NA</td>
					<td style="text-align: left;background-color:<%=bgcolor1%>" id="FixedKmcol<%=k%>"> <br>NA</td>
					<%			}
			else			{
				%>
					<td style="text-align: right;background-color:<%=bgcolor1%>" id="FixedTimecol<%=k%>"> <br> <%=tTime%></td>
				<% System.out.println("FixedTIme----->"+tTime );%>
	            
					<td style="text-align: right;background-color:<%=bgcolor1%>" id="FixedKmcol<%=k%>"> <br> <%=totKm %></td>
					<% System.out.println("FixedKm----->"+totKm );%>
				<%			}
		
		%>
			<td style="text-align: right;background-color:<%=bgcolor1%>" id="kmsruncol<%=k%>"> <%=kmrundist%></td>  
		<%
			if(tTime==0 && totKm==0)			{
				%>
					<td style="background-color:<%=bgcolor1%>" id="kmstoruncol<%=k%>"><div align="left">NA</div></td>
				<%
			}
			else			{
				%>
					<td style="text-align: right;background-color:<%=bgcolor1%>" id="kmstoruncol<%=k%>"><%=remKm%></td>
				<%			}
			%>			<%
	sqlopen="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,TripCategory from t_startedjourney where tripid='"+rsttrips.getString("Tripid")+"'";
	ResultSet rssopen=stopen.executeQuery(sqlopen);
	if(rssopen.next())	{
		endedby1=rssopen.getString("EndedBy");
		 weight1=rssopen.getString("Weight");
		 if(weight1==null || weight1.equalsIgnoreCase("null"))
		 {
			 weight1="-";		 }
		 vendor11=rssopen.getString("Vendor");
		 
		 if(vendor11.equalsIgnoreCase("select") || vendor11==null || vendor11.equalsIgnoreCase("null"))
		 {
			 vendor11="-";		 }
		 tripcat1 =rssopen.getString("TripCategory");
		 if(tripcat1.equalsIgnoreCase("select") || tripcat1==null || tripcat1.equalsIgnoreCase("null"))
		 {
			 tripcat1="-";		 }
		 freight1 =rssopen.getString("Frieght");
		 if(freight1==null || freight1.equalsIgnoreCase("null"))
		 {
			 freight1="-";		 }
		 adv1 =rssopen.getString("Advance");
		 if(adv1==null || adv1.equalsIgnoreCase("null"))
		 {
			 adv1="-";		 }	}
	else	{
		 endedby1="-";
		 weight1="-";
		 vendor11="-";
		 tripcat1="-";
		 freight1="-";
		 adv1="-";		} //out.println("Mila");
	%>
	     <td style="text-align: right;background-color:<%=bgcolor1%>" id="wtcol<%=k%>"><%=weight1%></td>
	 <td style="text-align: right;background-color:<%=bgcolor1%>" id="frcol<%=k%>"><%=freight1%></td>
	 <td style="text-align: right;background-color:<%=bgcolor1%>" id="adrscol<%=k%>"><%=adv1%></td>	
				
				
	 <td style="text-align: left;background-color:<%=bgcolor1%>" id="vendorcol<%=k%>"><%=vendor11%></td>
	 <td style="text-align: left;background-color:<%=bgcolor1%>" id="catcol<%=k%>"><%=tripcat1%></td>
	   <td style="text-align: left;background-color:<%=bgcolor1%>" id="cmtcol<%=k%>"><%=comments%></td>
	   		</tr>		<%		}
		%>				<%				j++;	}	%>
			<input type="hidden" name="countt" value="<%=k%>"></input>
			<%	%>
	</table>	<p></p>
<%}
else if(statusname.equalsIgnoreCase("Cancelled"))
{
String vehregno="",tripid="",startplace="",endplace="",entryby="",driverid="",startdate="",starttime="",drivername="",OwnerName="",tripcategory="",updateddatetime="",jstatus="";	
Statement st4, sttemp,stopen,stveh;
String today="";
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String currenttime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
	st4=conn.createStatement();
	stveh=conn.createStatement();
	stopen=conn.createStatement();
	String mydate1,mydate2;
	mydate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
	mydate2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
%>
<table border="0" width="100%" align="center"> 
		<tr>
		<td align="center" colspan="24" width="40%">
<font  size="3" color="blue"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font> 
<td id="print" colspan="1" width="100">
<a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a> &nbsp;
</td>
<td id="excel" colspan="1" width="100">
 <a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>&colorvalue=<%=request.getParameter("colorvalue") %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
 <td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%> 
</td>
		</tr>
	</table>	
	<table border="1" class="sortable" width="100%">	<tr>
	<th  class="hed" id="srcolcan" valign="top"> Sr No</th>	<th class="hed" id="tripcolcan" valign="top"> TripId</th>
	<th  class="hed" id="vehcolcan" valign="top">VehicleRegNo</th> 	<th class="hed" id="Drivecolcan" valign="top">DriverID</th>
	<th class="hed" id="namecolcan" valign="top">DriverName</th>	<th class="hed" id="ownercolcan" valign="top">OwnerName</th>
	<th class="hed" id="sdcolcan" valign="top">StartDateTime</th>	<th class="hed" id="spcolcan" valign="top"> StartPlace</th>
	<th  class="hed" id="epcolcan" valign="top">EndPlace</th>		<th class="hed" id="catcolcan" valign="top">TripCategory</th>
	<th class="hed" id="cdcolcan" valign="top">CancelDateTime</th>	<th class="hed" id="cbycolcan" valign="top">CanceledBy</th>
		</tr>	
		<%
	sql="select * from t_startedjourney where Jstatus='Cancelled' and (OwnerName = '"+session.getAttribute("usertypevalue").toString()+"' or GPName = '"+session.getAttribute("usertypevalue").toString()+"' OR Vendor='"+session.getAttribute("usertypevalue").toString()+"') AND Vehid in"+session.getAttribute("VehList").toString()+"AND  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by StartDate desc";
	ResultSet rsttrips=st.executeQuery(sql);
	int j=1;
	while(rsttrips.next())
	{
	tripid="";
       	vehregno=rsttrips.getString("VehRegNo"); 		tripid=rsttrips.getString("TripID");
 		startplace=rsttrips.getString("StartPlace"); 		endplace=rsttrips.getString("EndPlace");
 		startdate=rsttrips.getString("StartDate"); 		starttime=rsttrips.getString("StartTime");
 		drivername=rsttrips.getString("DriverName"); 		OwnerName=rsttrips.getString("OwnerName");
 		tripcategory=rsttrips.getString("TripCategory"); 		updateddatetime=rsttrips.getString("updateddt");
 		jstatus=rsttrips.getString("JStatus"); 		entryby=rsttrips.getString("EntryBy");
 		driverid=rsttrips.getString("DriverCode");
	 	String stdateparse=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")));
      	updateddatetime=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updateddatetime));
   	%>
	<tr>
		<td style="text-align: right;"><%=j%></td>
	<td style="text-align: right;"><%=tripid%></td>
    <td style="text-align: left;"><%=vehregno%></td> 
    <td style="text-align: right;"><%=driverid%></td>
   <td style="text-align: left;"><%=drivername%></td>
       <td style="text-align: left;"><%=OwnerName%></td> 
   <td style="text-align: right;"><%=stdateparse%></td> 
    <td style="text-align: left;"><%=startplace%></td> 
   <td style="text-align: left;"><%=endplace%></td>
       <td style="text-align: left;"><%=tripcategory%></td>
    <td style="text-align: right;"><%=updateddatetime%></td> 
    <td style="text-align: left;"><%=entryby%></td> 
   <%
j++; }}//end of cancel trips...
else if(statusname.equalsIgnoreCase("Vehicle Wise Trips") || statusname.equalsIgnoreCase("Driver Wise Trips") ){
	String fromdate1="",todate1="";
	String Driver1=request.getParameter("Driver");

	vehino=request.getParameter("vehicle");
	StringTokenizer stk = new StringTokenizer(vehino,",");
	String vehiclecode=stk.nextToken();
	String vehicleno=stk.nextToken();
	if(statusname.equalsIgnoreCase("Driver Wise Trips"))
	{
		
	if(Driver1.equalsIgnoreCase("All"))
	{
		Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount,dvcount from db_gps.t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' "+sum+" GROUP BY  DriverName ORDER BY DriverName ";

	}
	else{
	Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount,dvcount from db_gps.t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and DriverName='"+Driver1+"'  "+sum+"  ORDER BY DriverName ";//GROUP BY  DriverName
	System.out.println("IN the  my_trip.jsp form and the SQL query is:- "+Sqlv);
	}
	}else{
   Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount,dvcount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and VehRegNo='"+vehicleno+"' "+sum+" order by StartDate ";
	}
%>
<table border="0" width="800" align="center">
<tr align="center"><td align="center" colspan="24" width="70%">
<%
if(statusname.equalsIgnoreCase("Driver Wise Trips"))
{
	%>
	<font color="brown" size="3">The Trip Report for Driver <%=Driver1%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
		<%}
else{
	%>
	<font color="brown" size="3">The Trip Report for Vehicle <%=vehicleno%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
<%}
		%>
<div class="bodyText" align="right">
<input type="button" value="More Info" onclick="showhide2();" class="formElement" id="tds" name="tds" >&nbsp;&nbsp;
</div></td>
<td id="print" colspan="1" width="100">
<a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>&DriverName=<%=Driver1%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
</td>
<td id="excel" colspan="1" width="100">
<a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>&DriverName=<%=Driver1%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
<td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
</td></tr></table>
<table border="1" class="sortable" width="100%"><tr>
<th>Sr.</th><th>Trip ID</th><th>Driver</th>
<th id="vehcolveh"><a href="#" onClick="hide4('veh');" title="Click to hide Desc,Mode1,Type Cols"><img id="img14" src="images/sub.jpg" width="13px" height="10px" border="0"> </a><br></br>Veh.</th>
<th id="tdd0" style="text-align: left; display: none"> Desc</th><th id="tdm0" style="text-align: left; display: none"> Model</th>
<th id="tdt0" style="text-align: left; display: none">Type</th><th>Owner</th><th id="tdw0" style="text-align: left; display: none">Weight Kg</th>
<th id="tdf0" style="text-align: left; display: none">Freight Rs</th><th id="tda0" style="text-align: left; display: none">Advance Rs</th>
<th>Customer</th><th>Category</th><th>Origin</th><th id="tdr0" style="text-align: left; display: none">Report DateTIme</th>
<th>Start Date Time</th><th id="tdl0" style="text-align: left; display: none">Load Delay (hh:mm:ss)</th><th id="tdldr0" style="text-align: left; display: none">Ld Delay Rsn</th>
<th id="tdlc0" style="text-align: left; display: none">Load Comments</th><th>Destination</th><th>End Date Time</th>
<th id="tdu0" style="text-align: left; display: none">Unload Date Time</th><th id="tdul0" style="text-align: left; display: none">Unload Delay (hh:mm:ss)</th>
<th id="tdudr0" style="text-align: left; display: none">Unld Delay Rsn</th><th id="tduc0" style="text-align: left; display: none">Unload Comments</th>
<th id="stkmcolveh">Std Km</th><th id="sttcolveh">StdTime</th><th id="kmtcolveh">KM Traveled</th><th id="trptcolveh">Trip Time</th>
<th id="oscolveh">OS</th><th id="osscolveh">OS(Sec)</th><th id="racolveh">RA</th><th id="rdcolveh">RD</th><th id="dvcolveh">DV</th><th id="cdcolveh">CD</th>
<th id="ndcolveh">ND</th><th id="dccolveh">DC</th><th id="dckmcolveh">DC Km</th><th id="ratcolveh">Trip Rating</th><th>Closed By</th>
</tr>
<%
System.out.println("Driver wise is-------------->>>>>>>>>>>>>   "+Sqlv);
ResultSet rstcloser=st15.executeQuery(Sqlv);
int i=0,dist1,dist2;
java.util.Date enddte1,strdte1;
double stdDist=0,stdTme=0,capDist=0;
String SDate,EDate,STime,ETime,tripid,StDate,EdDate;
long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0,etime;
String fromdate="",todate="";
String ftime1="00";
String ftime2="00";
String ftime3="00";
String ttime1="00";
String ttime2="00";
String ttime3="00";
String vehdesc="-",vehmodel="-",vehtype="-",tripcat="-",adv="-",freight="-",loadrsn="-",loadcmt="-",endedby="-",weight="-",vendor="-",reptdttme="-",unloadcmt="-",unloadrsn="-";
String sdate,edate,LoadingDelay,UnloadingDelay;
int KmTravelled=0;
while(rstcloser.next()){
i++;
SDate=rstcloser.getString("StartDate");
EDate=rstcloser.getString("EndDate");
STime=rstcloser.getString("StartTime");
ETime=rstcloser.getString("EndTime");
tripid=rstcloser.getString("TripId");
KmTravelled=rstcloser.getInt("KmTravelled");
LoadingDelay=rstcloser.getString("LoadingDelay");
if(LoadingDelay==null || LoadingDelay.equalsIgnoreCase("null")){
LoadingDelay="-";}
UnloadingDelay=rstcloser.getString("UnloadingDelay");
if(UnloadingDelay==null || UnloadingDelay.equalsIgnoreCase("null")){
UnloadingDelay="-";}
unloadcmt=rstcloser.getString("Unloadingcomments");
if(unloadcmt==null || unloadcmt.equalsIgnoreCase("null")){
unloadcmt="-";}
unloadrsn=rstcloser.getString("DelayReason");
if(unloadrsn==null || unloadrsn.equalsIgnoreCase("null")){
unloadrsn="-";}
if(null==STime || STime.length()>8 || STime.equals("-"))
{STime="00:00:00";}
if(null==ETime || ETime.equals("-"))
{ETime="23:59:59";}
sdate=SDate;
System.out.println("sdate  "+sdate);
try{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));}
catch(Exception e){
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));}
try{
java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
ftime1=""+dt.getHours();
ftime2=""+dt.getMinutes();
ftime3=""+dt.getSeconds();
}
catch(Exception e){
	ftime1="00";
	ftime2="00";
	ftime3="00";}
edate=EDate;
try{	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));}
catch(Exception e){	 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
}
try{
java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
ttime1=""+edt.getHours();
ttime2=""+edt.getMinutes();
ttime3=""+edt.getSeconds();}
catch(Exception e){
	ttime1="23";
 	ttime2="59";
 	ttime3="59";}
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00
miliseconds1=fd.getTime();
}catch(Exception e1){
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
miliseconds1=fd.getTime();
}catch(Exception e4){
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
miliseconds1=fd.getTime();}}
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
miliseconds2=fd1.getTime();
}catch(Exception e2){
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
miliseconds2=fd1.getTime();
}catch(Exception e5){
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
miliseconds2=fd1.getTime();}}
try{
fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
}catch(Exception e){
fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
}
try{
	todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
	todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}catch(Exception e){
todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));
}
%>
<tr>
<td style="text-align: right"><%=i%></td>
<td><div align="right"  >
<font size="10">
<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=rstcloser.getString("TripId")%></font></a> </font><br />
<div class="popup" id="popup<%=i%>">
<table border="1" bgcolor="white">
<tr>
<td><a href="detailed_report.jsp?vehcode=<%=rstcloser.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
</td></tr><tr>
<td>
<%
String briefid = "",rid = "",plannedstatus = "No";
boolean flag = false;
 sql1 = "select * from db_gps.t_briefing where tripid = '"+rstcloser.getString("TripId")+"'";
 ResultSet rs1 = st1.executeQuery(sql1);
if(rs1.next())
{briefid = rs1.getString("Briefid");}
sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rstcloser.getString("TripId")+"' and briefid = '"+briefid+"' and driverid = '"+rstcloser.getString("DriverID")+"'  order by advancedtrackid asc ,row asc limit 1 ";
rs1 = st1.executeQuery(sql1);
if(rs1.next())
{rid = rs1.getString("advancedrouteid");
	plannedstatus = "Yes";
	flag = true;}
%>
<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rstcloser.getString("TripId")%>&vehcode=<%=rstcloser.getString("VehId")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ftime3=<%=ftime3 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&ttime3=<%=ttime3 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=rstcloser.getString("DriverID")%>" onclick="javascript:toggleDetails(<%=i%>,false);">Show Trip On Map</a>
</td></tr><tr><td>
<a href="#" onclick="javascript:window.open('TripwiseException.jsp?startDate=<%=rstcloser.getString("StartDate")%>&endDate=<%=rstcloser.getString("EndDate")%>&vehcode=<%=rstcloser.getString("VehId")%>&tripid=<%=rstcloser.getString("Tripid")%>','','menubar=1,scrollbars=1,resizeable=0,width=700,height=700');">TripWise Exception </a>
</td></tr><tr><td>
<a href="#" onclick="javascript:window.open('endtrip.jsp?tripid=<%=rstcloser.getString("Tripid")%>&EDate=<%=EDate%>&ETime=<%=ETime%>&vehcode=<%=rstcloser.getString("VehId")%>','','menubar=1,resizable=2,width=770,height=350,location=no');">Change Unload Time </a>
</td></tr>
<tr><td>
<a href="#" onclick="javascript:window.open('trippdf.jsp?tripid=<%=rstcloser.getString("Tripid")%>&owner=<%=rstcloser.getString("OwnerName")%>&vid=<%=rstcloser.getString("VehId")%>&vehRegNo=<%=rstcloser.getString("VehRegNo")%>')">Print</a>
</td></tr>
<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
</table></div> </div></td>
<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>
<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>
<%
String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"' order by VehicleRegNumber";
ResultSet rstcol=stt2.executeQuery(sql3);
System.out.println("veh desc"+sql3);
if(rstcol.next()){
vehdesc=rstcol.getString("VehDesc");
if(vehdesc==null || vehdesc.equalsIgnoreCase("null"))
{vehdesc="-";}
vehmodel=rstcol.getString("VehModel");
if(vehmodel==null || vehmodel.equalsIgnoreCase("null"))
{vehmodel="-";}
vehtype=rstcol.getString("VehType1");
if(vehtype==null || vehtype.equalsIgnoreCase("null")){
vehtype="-";}}
else{
vehdesc="-";
vehmodel="-";
vehtype="-";}
%>
<td id="tdd<%=i%>" style="text-align: left;display: none;"><%=vehdesc%></td>
<td id="tdm<%=i%>" style="text-align: left;display: none;"><%=vehmodel%></td>
<td id="tdt<%=i%>" style="text-align: left;display: none;"><%=vehtype%></td>
<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>
<%
String sql="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,Loadreason,Loadcomments,TripCategory,FIxedKM,FIxedTime from t_startedjourney where tripid='"+tripid+"'";
ResultSet rss=st2.executeQuery(sql);
if(rss.next()){
stdDist=rss.getDouble("FIxedKM");
stdTme=rss.getDouble("FIxedTime"); 
endedby=rss.getString("EndedBy");
weight=rss.getString("Weight");
if(weight==null || weight.equalsIgnoreCase("null"))
{	 weight="-";}
vendor=rss.getString("Vendor");
if(vendor.equalsIgnoreCase("select") || vendor==null || vendor.equalsIgnoreCase("null"))
{	 vendor="-";}
tripcat =rss.getString("TripCategory");
if(tripcat.equalsIgnoreCase("select") || tripcat==null || tripcat.equalsIgnoreCase("null"))
{	 tripcat="-";}
freight =rss.getString("Frieght");
if(freight==null || freight.equalsIgnoreCase("null"))
{
	 freight="-";
}adv =rss.getString("Advance");
if(adv==null || adv.equalsIgnoreCase("null"))
{	 adv="-";}
try{
	 reptdttme=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rss.getString("ReportDateTime")));
	}catch(Exception ss)
{	 reptdttme=rss.getString("ReportDateTime");}
if(reptdttme==null || reptdttme.equalsIgnoreCase("null"))
{	 reptdttme="-";}
if(loadrsn==null || loadrsn.equalsIgnoreCase("null"))
{	 loadrsn="-";}
if(loadcmt==null || loadcmt.equalsIgnoreCase("null"))
{	 loadcmt="-";}	}
else{
endedby="-";
weight="-";
vendor="-";
reptdttme="-";
tripcat="-";
freight="-";
adv="-";
loadcmt="-";
loadrsn="-";
} //out.println("Mila");
%>
<td id="tdw<%=i%>" style="text-align: left; display: none;"><%=weight%></td>
<td id="tdf<%=i%>" style="text-align: left; display: none;"><%=freight%></td>
<td id="tda<%=i%>" style="text-align: left; display: none;"><%=adv%></td>
<td><%=vendor%></td>
<td><%=tripcat%></td>
<td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>
<td id="tdr<%=i%>" style="text-align: left; display: none;"><%=reptdttme%></td>
<td style="text-align: left">
<% 
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"))));
}catch(Exception ee)
{out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+"<br>"+STime);
}
%>
</td>
<td id="tdl<%=i%>" style="text-align: right; display: none;"><%=LoadingDelay%></td>
<td id="tdldr<%=i%>"style="text-align: right; display: none;"><%=loadrsn%></td>
<td id="tdlc<%=i%>"style="text-align: right; display: none;"><%=loadcmt%></td>
<td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
<td style="text-align: left"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
}catch(Exception ee){
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
}%>
</td>
<td id="tdu<%=i%>"style="text-align: left; display: none;"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
}catch(Exception ee)
{out.print("-");}
%>
</td>
<td id="tdul<%=i%>"style="text-align: right; display: none;"><%=UnloadingDelay%></td>
<td id="tdudr<%=i%>"style="text-align: right; display: none;"><%=unloadrsn%></td>
<td id="tduc<%=i%>"style="text-align: right; display: none;"><%=unloadcmt%></td>
<%
//*********************************************query is changed*****************************************************
DecimalFormat twoDForm1 = new DecimalFormat("##.#");
sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rstcloser.getString("StartPlace")+"' and EndPlace = '"+rstcloser.getString("EndPlace")+"' || StartPlace ='"+rstcloser.getString("EndPlace")+"' and EndPlace = '"+rstcloser.getString("StartPlace")+"'";
ResultSet rstdist=st1.executeQuery(sql);
if(stdDist==0 && stdTme==0){
	if(rstdist.next())	{ 
	stdDist=rstdist.getDouble("Km");
	stdTme=rstdist.getDouble("TTime");	}}
if(stdDist==0 && stdTme==0)
{%>
<td style="text-align: right" id="stkmcolveh<%=i%>">NA</td>
<td style="text-align: right" id="sttcolveh<%=i%>">NA</td>
<%}
else
{%>
<td style="text-align: right" id="stkmcolveh<%=i%>"><%=twoDForm1.format(stdDist)%></td>
<td style="text-align: right" id="sttcolveh<%=i%>"><%=twoDForm1.format(stdTme)%></td>
<%}%>
<td style="text-align: right" id="kmtcolveh<%=i%>"><%=KmTravelled%></td>
<!--<td style="text-align: right">
<%
//***************************************************************************************************************
int dist;
dist=0; dist1=0; dist2=0;
%> 
</td>--> 
<td style="text-align: left" id="trptcolveh<%=i%>">
<%
try{try{
	enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"));
	strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"));}
catch(Exception e){
	enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate"));
	strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate"));}
long hrs,mins;
double hrslong=0.00;
java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
long x=enddte11.getMinutes();
long y=strdte11.getMinutes();
long timediff=enddte11.getTime()-strdte11.getTime();//msec
long mins11=timediff/1000/60;
if(mins11>=60){
hrdiff=mins11/60;//2
if((y>x)&&(x!=0)){
mins=y-x;
mins=60-mins;
out.print(hrdiff+":"+mins);}
else if((x>y)&&(y!=0)){
	mins=x-y;
	out.print(hrdiff+":"+mins);
	}else if(x==y){
	mins=x-y;
	out.print(hrdiff+":"+mins);}
else if((x==0)&&(y>x)){
mins=60-y;
out.print(hrdiff+":"+mins);
}else if(y==0){
mins=x+y;
out.print(hrdiff+":"+mins);}}
else{
hrdiff=0;
mins=mins11;
out.print(hrdiff+":"+mins);}
String enddte=enddte1+" "+ETime;
String strtdte=strdte1+" "+STime;
long tmeinmils=enddte1.getTime()-strdte1.getTime();
long hours=tmeinmils/(1000*60*60);
String extractstrtminutes=STime.substring(3,5);
String extractendminutes=ETime.substring(3,5);
int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
if(totmins >= 60){
hrdiff=hrdiff+1;
totmins=totmins-60;}}
catch(Exception e){}
%>
</td>
<%
DecimalFormat twoDForm = new DecimalFormat("##.##");
%>
<%
String date3="",date4="";
String vehid=rstcloser.getString("Vehid");
int cdcnt=0;
try{
	date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
	date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}
catch(Exception e){
	date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")+" "+rstcloser.getString("StartTime")));
	date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")+" "+rstcloser.getString("EndTime")));
}
%>
<td style="text-align: right" id="oscolveh<%=i%>"><%=rstcloser.getInt("OSCount")%></td>
<td style="text-align: right" id="osscolveh<%=i%>"><%=rstcloser.getDouble("OSDuration")%></td>
<td style="text-align: right" id="racolveh<%=i%>"><%=rstcloser.getInt("RACount")%></td>
<td style="text-align: right" id="rdcolveh<%=i%>"><%=rstcloser.getInt("RDCount")%></td>
<td style="text-align: right" id="dvcolcls<%=i%>"><%if(rstcloser.getInt("DVCount")>0){%><a href="detail_dv.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("VehRegNo")%>&pageType=RouteDeviation&data1=<%=date3%>&data2=<%=date4%>"><%=rstcloser.getInt("DVCount")%><%}else {%><%=rstcloser.getInt("DVCount")%><%}%></a></td>
<td style="text-align: right" id="cdcolveh<%=i%>">
<% 
String sqlcd="select count(*) cdcount from db_gpsExceptions.t_veh"+vehid+"_cr where concat(FromDate,' ',FromTime) >= '"+date3+"' and concat(FromDate,' ',FromTime)<='"+date4+"'";
ResultSet rscd=st16.executeQuery(sqlcd);
while(rscd.next())
{	cdcnt=rscd.getInt("cdcount");}
if(cdcnt>0){
	%>
	<a href="detail_cd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("VehRegNo")%>&pageType=ContinuousDriving&data1=<%=date3%>&data2=<%=date4%>"><%=cdcnt%></a>
		 <%
}
else{
	%>		<%=cdcnt%>
		<%}%>
</td><td style="text-align: right" id="ndcolveh<%=i%>">
<%
if(rstcloser.getInt("NDCount")>0)
{
%>	<a
	href="detail_nd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("vehregno")%>&pageType=NightDriving&data1=<%=fromdate%>&data2=<%=todate%>"">
	<%=rstcloser.getInt("NDCount")%> </a> <%}
else{
	%>	<%=rstcloser.getInt("NDCount")%>
	<%}%>
</td><td style="text-align: right" id="dccolveh<%=i%>">
<%
int discount=0, diskm=0;
String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rstcloser.getString("vehid")+"' and  OffTimeFrom >='"+rstcloser.getString("Startdate")+"'and  OffTimeTo<='"+rstcloser.getString("Enddate")+"' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30'";
ResultSet rstdis=st2.executeQuery(sqldis);
if(rstdis.next())
{
	if(rstdis.getInt("cnt")>0)
	{
		discount=rstdis.getInt("cnt");
		diskm=rstdis.getInt("distance");
		%>
	    <a href="disconnectedDetailsReport.jsp?vehicleCode=<%=rstcloser.getString("vehid")%>&VehicleRegNo=<%=rstcloser.getString("vehregno")%>&ownerName=<%=rstcloser.getString("OwnerName")%>&fromDateTime=<%=rstcloser.getString("Startdate")%>&toDateTime=<%=rstcloser.getString("EndDate")%>&counterv=<%=rstdis.getInt("cnt")%>&tripid=<%=rstcloser.getString("TripId")%>"> <%=discount%> </a>
		<%	}
	else{		
		out.print("0");	}}
else{	out.print("0");}
%>
</td><td style="text-align: right" id="dckmcolveh<%=i%>">
<%
if(discount>0){
	%>
	<%=diskm %>
	<%	}
else{	out.print(0);	}
%>
</td><td style="text-align: right" id="ratcolveh<%=i%>"><%=twoDForm.format(rstcloser.getDouble("TripRating"))%></td>
<%
sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
//System.out.println(sql);
rss=st2.executeQuery(sql);
if(rss.next())
{endedby=rss.getString("EndedBy");} 
%>
<td style="text-align: left">  
<%
if(endedby.equals("-") || endedby.equals(""))
{	out.print("Auto Closed");}
else
{	out.print(endedby);}
%>
</td></tr> 
<%}
%>
<input type="hidden" name="cntcls" id="cntcls" value="<%=i%>">
</table>
<%}
else{}
}
}
catch(Exception e)
{e.printStackTrace();}
finally{		try
		{			conn.close();		}catch(Exception e)
		{}
		try		{
			conn1.close();		}catch(Exception e)		{}
		
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
%>
</table>
</form>
</body>
</html>
<jsp:include page="footernew.jsp"/>
</jsp:useBean>
<%@ include file="header.jsp" %>

 <style><!-- 
    SPAN.searchword { background-color:cyan; }
    // -->
  </style>
  <script src="searchhi.js" type="text/javascript" language="JavaScript"></script>
<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">

  <script language="JavaScript"><!--
    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;
      
    }
    // -->
  </script>

<script type="text/javascript">

function toggleDetails(id, show)
{
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
		
	} else {
		popup.style.visibility = "hidden";
	}
}
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">


function article(programName,width,height)
{

	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; displayWindow=window.open(programName,"displayWindow",temp) ;
}
function fun(aa)
{
	//alert(aa.value);
	document.searchform.h.value=aa.value;
}

function showhide1()
{
	var cnt=document.getElementById("cnt").value;
	//alert("Hi Atul !"+cnt);
	var tda, tdb,tdc,tdd,tde;
	var tdx=document.getElementById("tdx").value;
	
	if(tdx=="Hide Trip Info")
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='none';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='none';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='none';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='none';
			tde=document.getElementById("tde"+i);
			tde.style.display='none';
			document.getElementById("tdx").value="Show Trip Info";
		}
	}
	else
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='';
			tde=document.getElementById("tde"+i);
			tde.style.display='';
			document.getElementById("tdx").value="Hide Trip Info";
		}
	}
}
</script>

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


<%!
Connection conn;
Statement st,st1,stx;
ResultSet rst;
String user,VehList1,aa,regno,sq,searchveh;
%>
<%
try{
Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}
%>
<table border="1" width="100%" >
<tr><td>

<table class="" bgcolor="white" border="0.50" width="100%" >
<tr><th colspan="3" align="center"><font class="bodyText" size="3"><b>Current Position Of Vehicles
<%
if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
{
out.print("<br>You are viewing vehicles which are in 10 km. range from your location and vehicles which are going from your location and coming to your location.");
/* code to search and add vehicle which is not in the list */
%>
<p></p>

<table class="stats">
<form name="searchform" action="" method="get">
<tr><td class="hed" colspan="5">Search and add the vehicle in the list.</td></tr>
<tr><td class="bodyText" colspan="5"><div align="right">Vehicle is not in the list, please enter the Vehicle registration number to search.</div><div align="right"><input type="hidden" name="h" id="h" class="formElement"><input type="text" name="searchveh" class="formElement" onChange="fun(this);">&nbsp;&nbsp;&nbsp; <input type="Submit" name="Search!" value="Search!" class="formElement"></div></td></tr>
</form>
 
<%
searchveh=request.getParameter("searchveh");
if(!(null==searchveh))
{
	String sql="select * from t_group where transporter like '%"+searchveh+"%' and GPName='"+session.getAttribute("usertypevalue").toString()+"' and vehCode not in "+session.getAttribute("VehList").toString();
	//out.print(sql);
	ResultSet rstnew=st.executeQuery(sql);
	%>
	<form name="addveh" method="get" action="addveh.jsp">	
	<tr><td class="bodyText" colspan="5">Please check Vehicle to add in the list</td></tr>
	<tr>
				<td class="hed">Check<input type="hidden" name="hh" value="<%=searchveh%>"></td>
				<td class="hed">Vehicle Reg. No</td>
				<td class="hed">Transporter</td>
				<td class="hed">Updated</td>
				<td class="hed">Location</td>
				</tr>	
	<%
	int j=1;
	while(rstnew.next())
	{
		sql="select * from t_onlinedata where VehicleCode='"+rstnew.getString("VehCode")+"'";
		ResultSet rstnew1=st1.executeQuery(sql);
		if(rstnew1.next())
		{
			%>
				<tr>
				<td><INPUT TYPE=CHECKBOX NAME="ch<%=j%>" value="<%=rstnew1.getString("VehicleCode")%>"></td>
				<td align="left"><%=rstnew1.getString("VehicleRegNo")%></td>
				<td align="left"><%=rstnew1.getString("Transporter")%></td>
				<td align="left"><%= new SimpleDateFormat("dd-MMM-yyyy").format(rstnew1.getDate("TheDate"))%><%=rstnew1.getString("TheTime")%></td>
				<td align="left"><div align="left"><%=rstnew1.getString("Location")%></div></td>
				</tr>			
			<%
			j++;
		}
	}
	%>
<input type="hidden" name="count" value="<%=j%>">
<tr><td colspan="5" align="center"><input type="Submit" value="Add Vehicle" Name="Add_Vehicle" class="formElement"></td></tr>
</form>
<%
}
%>
</table>
<%
/* code end added by Atul Kalaskar on Date 11-11-09 */

}
%>
</b></font>
</th></tr>
<tr><td colspan="3" class="bodyText"><marquee><font color="red" size="2" >Note: </font><font color="green" size="2">New reports have been added. Please click on particular vehicle registration No. to see the reports.</font></marquee></td></tr>
<tr>
<td align="right" colspan="3" class="bodyText"> 
<table width="100%" border="0">
<tr>
<td align="right" class="bodyText">
<a href="onlinedata.jsp" title="Slow Process" id="blinking">Click To View All Vehicle On Map.</a>
</td>
<td align="right" class="bodyText">
<a href="#" onclick="javascript:window.open('printcurrentposition.jsp');" title="Print Current Position Report">
<img src="images/print.jpg" width="15px" height="15px">
</a>&nbsp; &nbsp; 
<a href="excelcorrentposition.jsp"  title="Export to Excel">
<img src="images/excel.jpg" width="15px" height="15px">
</a>
</td>
<td align="right" class="bodyText">
<form method="get" name="searchhi">
<input type="text" name="h" class="formElement"/>

<input type="submit" value="Search Any Text!" class="formElement"/> &nbsp;&nbsp;
Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
out.print(sdt); %>
</form>
</td>
</tr>
</table>
</td>
</tr>
<tr><td colspan="3"><table border="0" width="100%">
<tr bgcolor="#F0E68C">
<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :</b></td >
<td bgcolor="#CCFFCC" class="sorttable_nosort"><b>Moving</b></td>
<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b>Stop</b></td>
<td bgcolor="#DCDCDC" class="sorttable_nosort"><b>Disconnected</b></td>
<td bgcolor="#FFFFFF" class="sorttable_nosort"><b>Not Active</b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Hide Trip Info" onclick="showhide1();" class="formElement" id="tdx" ></td>
</tr>

</table></td></tr>

<tr>
  <td colspan="3">
     <table class="sortable" width="100%">

<tr bgcolor="#DCDCDC">
<td class="hed" align="center"><font class="bodyText" size="3"><b>Sr.</b></font></td>
<td class="hed" align="center"><font class="bodyText" size="3"><b>Vehicle Reg.No.</b></font></td>
<td class="hed" align="center"><font class="bodyText" size="3"><b>Updated</b></font></td>
<td class="hed" align="center" id="tdd0"><font class="bodyText" size="3"><b>Trip Id</b></font></td>
<td class="hed" align="center" id="tde0"><font class="bodyText" size="3"><b>Driver Name(Code)</b></font></td>
<td class="hed" align="center" id="tda0"><font class="bodyText" size="3"><b>Trip Origin</b></font></td>
<td class="hed" align="center" id="tdb0"><font class="bodyText" size="3"><b>Start Date</b></font></td>
<td class="hed" align="center" id="tdc0"><font class="bodyText" size="3"><b>Trip Destination</b></font></td>
<td class="hed" align="center"><font class="bodyText" size="3"><b>Location - Click To View On Map.</b></font></td>
<%
if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
	%>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen1</b></font></td>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen2</b></font></td>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen3</b></font></td>
	<td class="hed" align="center"><font class="bodyText" size="3"><b>Sen4</b></font></td>
	<%
}
%>

</tr>
<%
try{
	
	VehList1=(String)session.getValue("VehList");
String sql="select * from t_onlinedata where vehiclecode in " + VehList1 +" order by concat(TheDate,TheTime) desc";
//out.print(sql);
rst=st.executeQuery(sql);
int i=0;
while(rst.next())
{
i++;
int col=rst.getInt("TheSpeed");

sql="select * from t_usermessage where UserTypeValue='"+rst.getString("Transporter")+"' and MessageId='4'";
ResultSet rstnew=st1.executeQuery(sql);
if(rstnew.next())
{
	%>
<tr bgcolor="white">
<td><%=i%></td>
<td><%=rst.getString("VehicleRegNo")%></td>
<td><%="Blocked"%></td>
<td id="tdd<%=i%>">-</td>
<td id="tde<%=i%>">-</td>
<td id="tda<%=i%>">-</td>
<td id="tdb<%=i%>">-</td>
<td id="tdc<%=i%>">-</td>
<td><%="Access denied for "+rst.getString("Transporter")%></td>
</tr>	
	<%
}
else{
%>
<%

java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDate")+" "+rst.getString("TheTime"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
String showdate1 = formatter1.format(ShowDate1);

java.util.Date ddd= new java.util.Date();
long dt1=ShowDate1.getTime();
long dt2=ddd.getTime();
long days=((dt2-dt1)/
(60 * 60 * 1000L* 24));



 // Code Added by Yogesh to shoe the hours wise status of device disconnected 4 feb 09
                                            java.util.Date ShowDate1EXL = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDate") + " " + rst.getString("TheTime"));
                                            Format formatter1EXL = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
                                            String showdate1EXL = formatter1.format(ShowDate1EXL);

                                            java.util.Date dddEXL = new java.util.Date();
                                            long dt1EXL = ShowDate1EXL.getTime();

                                            long dt2EXL = dddEXL.getTime();
                                            long hours = ((dt2EXL - dt1EXL) / (60 * 60 * 1000L));


                                            // End of code of yogesh

%>
<tr <% if(col >0) { if(days >7 ){%>bgcolor="#DCDCDC" <% }else {%>bgcolor="#CCFFCC" <% }} else { if(days >7 ){%>bgcolor="#DCDCDC" <% }else { %>bgcolor="#FFFFCC" <% } }  %>>
<td class="bodyText"><%=i%></td>
<td class="bodyText">
<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=rst.getString("VehicleRegNo")%> </a><br />
<div class="popup" id="popup<%=i%>">
<table border="1" bgcolor="white">
<tr><td><a href="veh_report_24h.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 24 Hours</a></td></tr>
<tr><td><a href="veh_report_48h.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 48 Hours</a></td></tr>
<tr><td><a href="veh_report_7d.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 7 Days</a></td></tr>
<tr><td><a href="veh_report_15d.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 15 Days</a></td></tr>
<tr><td><a href="veh_showhistory.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Last 24 Hours Journey On Map</a></td></tr>
<tr><td><a href="hourly_detail_report.jsp?vehcode=<%=rst.getString("VehicleCode")%>&h1=no" onclick="toggleDetails(<%=i%>,false);">Detail Report</a></td></tr>
<tr><td><a href="detail_custom_report.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Custom Detail Report</a></td></tr>
<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
</table>
</div>
</td>
<td class="bodyText" >

<%
out.print(showdate1);
%>
</td>
<%
sql="select * from t_startedjourney where Vehid='"+rst.getString("VehicleCode")+"' and JStatus='Running' order by StartDate desc limit 1";
ResultSet rsttrip=stx.executeQuery(sql);
if(rsttrip.next())
{
%>
<td id="tdd<%=i%>"><div align="left"><a href="startedtrip.jsp?tripid=<%=rsttrip.getString("TripId")%>&vehcode=<%=rst.getString("VehicleCode")%>&sdate=<%=rsttrip.getString("StartDate")%>&vehregno=<%=rst.getString("VehicleRegNo")%>&ownername=<%=rsttrip.getString("OwnerName")%>&startplace=<%=rsttrip.getString("StartPlace")%>&endplace=<%=rsttrip.getString("EndPlace")%>&enddate=<%=new SimpleDateFormat("yyyy-DD-MM HH:mm:ss").format(new java.util.Date())%>&pg=st"><%=rsttrip.getString("TripId")%></a></div></td>
<td id="tde<%=i%>"><div align="left"><%=rsttrip.getString("DriverName")+"("+rsttrip.getString("DriverCode")+")"%></div></td>
<td id="tda<%=i%>"><div align="left"><%=rsttrip.getString("StartPlace")%></div></td>
<td id="tdb<%=i%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip.getDate("StartDate"))%></td>
<td id="tdc<%=i%>"><div align="left"><%=rsttrip.getString("EndPlace")%></div></td>
<%
}
else
{
%>
<td  id="tdd<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tde<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tda<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tdb<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tdc<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<%
}

// Code Added by Yogesh to shoe the hours wise status of device disconnected 4 feb 09
                                            if (session.getAttribute("usertypevalue").toString().equals("EXL Services")) {
                                    %><td class="bodyText"><div align="left">
                                            <a href="shownewmap.jsp?lat=<%=rst.getString("LatitudePosition")%>&long=<%=rst.getString("LongitudePosition")%>&discription=<%="<b>" + rst.getString("VehicleRegNo") + "</b><br>"%><%=rst.getString("Location")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst.getString("LatitudePosition")%>&long=<%=rst.getString("LongitudePosition")%>&discription=<%="<b>" + rst.getString("VehicleRegNo") + "</b><br>"%><%=rst.getString("Location")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("Location")%><% if ((hours) > 1) {
                                            out.print("<font color='red' size='2'> Device Disconnected</font>");%></a>
                                    </div></td>
                                    <%  }
                                            }else{
                                            // end of code of yogesh
%>
<td class="bodyText"><div align="left">
<a href="shownewmap.jsp?lat=<%=rst.getString("LatitudePosition")%>&long=<%=rst.getString("LongitudePosition")%>&discription=<%="<b>"+rst.getString("VehicleRegNo")+"</b><br>"%><%=rst.getString("Location")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst.getString("LatitudePosition")%>&long=<%=rst.getString("LongitudePosition")%>&discription=<%="<b>"+rst.getString("VehicleRegNo")+"</b><br>"%><%=rst.getString("Location")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("Location")%><% if(days >7) out.print("<font color='red' size='2'> Device Disconnected</font>"); %></a>

</div></td>


<%
}
if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
sq="select * from t_veh"+rst.getString("VehicleCode")+" where TheFiledTextFileName = 'SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
ResultSet rsx=stx.executeQuery(sq);
if(rsx.next())
{
%>
<td class="hed" align="center"><%
try{
if(rsx.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%
try{

if(rsx.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");
%>
</td>
<td class="hed" align="center"><%

	out.print("xxxx");

 %></td>
<%
}
else
{
%>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>

<%
}
}
%>
</tr>

<%
}
}
/************************ code to show the vehicles which are not updated ********/

StringTokenizer stk= new StringTokenizer(VehList1,",");
	while(stk.hasMoreTokens())
	{
	aa=stk.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	if(!aa.equals("0")){

	String sql01="SELECT *  FROM t_onlinedata where vehiclecode='" + aa +"' order by vehiclecode";
        //out.print(sql01); 
	ResultSet rst01=st.executeQuery(sql01);
	if(rst01.next())
	{
		
	}
	else
	{	String sql02="select * from t_veh"+aa+" order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
		ResultSet rst02=st.executeQuery(sql02);
		if(rst02.next())
		{
		String sql03="select * from t_vehicledetails where VehicleCode='"+aa+"' ";
		ResultSet rst03=st1.executeQuery(sql03);
		if(rst03.next())
		{
		regno=rst03.getString("VehicleRegNumber");
		}
		i++;
	 	%>
	<tr bgcolor="#DCDCDC">
<td class="bodyText"> <%=i%></td>
<td class="bodyText"><%=regno%></td><td class="bodyText"><%java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst02.getString("TheFieldDataDate")+" "+rst02.getString("TheFieldDataTime"));
Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
String showdate3 = formatter3.format(ShowDate3);
out.print(showdate3);
%> </td>


<%
sql="select * from t_startedjourney where Vehid='"+aa+"' order by StartDate desc limit 1";
ResultSet rsttrip1=stx.executeQuery(sql);
if(rsttrip1.next())
{
%>
<td id="tdd<%=i%>"><div align="left"><%=rsttrip1.getString("TripId")%></div></td>
<td id="tde<%=i%>"><div align="left"><%=rsttrip1.getString("DriverName")+"("+rsttrip1.getString("DriverCode")+")"%></div></td>

<td id="tda<%=i%>"><div align="left"><%=rsttrip1.getString("StartPlace")%></div></td>
<td id="tdb<%=i%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip1.getDate("StartDate"))%></td>
<td id="tdc<%=i%>"><div align="left"><%=rsttrip1.getString("EndPlace")%></div></td>
<%
}
else
{
%>
<td  id="tdd<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tde<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tda<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tdb<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tdc<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<%
}
%>


<td class="bodyText"><%=rst02.getString("TheFieldSubject")%><font color="red">Device Disconected</font></td>
<%

if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
sq="select * from t_veh"+aa+" where TheFiledTextFileName = 'SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
ResultSet rsx1=stx.executeQuery(sq);
if(rsx1.next())
{
%>

<td class="hed" align="center"><%
try{
if(rsx1.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx1.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%
try{

if(rsx1.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rsx1.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");
	
 %></td>
<td class="hed" align="center"><%

	out.print("xxxx");
	
 %></td>
<%
}
else
{
%>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<td class="hed" align="center">-</td>
<%
}
}
%>


</tr>
	<%
		}//end of if rst01.
	else
	{
	String sql04="select * from t_vehicledetails where VehicleCode='"+aa+"'";
		ResultSet rst04=st.executeQuery(sql04);
		if(rst04.next())
		{
		String dx=rst04.getString("InstalledDate");
		if(null==dx)
		{
			dx="2008-01-01";
		}
		i++;
	%>
		<tr bgcolor="white">
<td><%=i%></td>
<td class="bodyText"><%=rst04.getString("VehicleRegNumber")%></td><td class="bodyText"><%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(dx);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter2.format(ShowDate2);
out.print(showdate2);
%> 10:00</td>
<%
sql="select * from t_startedjourney where Vehid='"+aa+"' order by StartDate desc limit 1";
ResultSet rsttrip2=stx.executeQuery(sql);
if(rsttrip2.next())
{
%>
<td id="tdd<%=i%>"><div align="left"><%=rsttrip2.getString("TripId")%></div></td>
<td id="tde<%=i%>"><div align="left"><%=rsttrip2.getString("DriverName")+"("+rsttrip2.getString("DriverCode")+")"%></div></td>

<td id="tda<%=i%>"><div align="left"><%=rsttrip2.getString("StartPlace")%></div></td>
<td id="tdb<%=i%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip2.getDate("StartDate"))%></td>
<td id="tdc<%=i%>"><div align="left"><%=rsttrip2.getString("EndPlace")%></div></td>
<%
}
else
{
%>
<td  id="tdd<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tde<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tda<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tdb<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<td  id="tdc<%=i%>"><a href="tripentry.jsp">Enter</a></td>
<%
}
%>

<td class="bodyText"><div align="left">Device Installed But Not Active</div></td>
<%

if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
{
%>
<td class="hed" align="center">xxxx</td>
<td class="hed" align="center">xxxx</td>
<td class="hed" align="center">xxxx</td>
<td class="hed" align="center">xxxx</td>
<%
}
%>
</tr>
  
<%
		}

	

	}//end of else rst01.
	
	}
	}
	} 

/****************** End of Code to show vehicles which are not updates **************/


%>
<input type="hidden" name="cnt" id="cnt" value="<%=i%>">
<%

}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();
}
%>

  
</table>
   </td>
     </tr>
        </table>

</td></tr>
</table> 
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>


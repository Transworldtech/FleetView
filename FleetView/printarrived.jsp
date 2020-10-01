<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/erratic.css" rel="StyleSheet" type="text/css">


</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
          <table border="0" align="left" width="100%">
<tr>
<td>
<!-- unit logo comes here --->
<div align="left">
<img src="images/Transworld.jpeg"  border="0">
</div>
<!-- unit logo comes here --->
<div align="right"> <a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a> Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
</tr>
</table>
			<!-- header file -->
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
<%!
Connection conn, conn1;
Statement st,st1;
String sql,thedate,sdate,edate,vehlist,location,locationcode,mainuser,locationlist;
%>
			<%
if(session.getAttribute("vehlistnew").toString().equals("-"))
{
	out.print("<table class='stats'><tr><td class='hed'>Please select the location first.</td></tr></table>");
}
else
{

try{
	
	location=session.getAttribute("Location").toString();
	locationcode=session.getAttribute("LocationCode").toString();
	vehlist=session.getAttribute("vehlistnew").toString();
	mainuser=session.getAttribute("usertypevaluemain").toString();
	locationlist=session.getAttribute("locationlist").toString();
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	String aa=request.getParameter("data");
	if(null==aa)
	{
	sql="SELECT SUBDATE(now(), INTERVAL 1 MONTH) as TheDate";	
	ResultSet rstdate=st.executeQuery(sql);
	if(rstdate.next())
	{
		thedate=rstdate.getDate("TheDate").toString();
		edate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}
	}
	else
	{
		thedate=request.getParameter("data");
		edate=request.getParameter("data1");
	}
	if(location.equals("All"))
	{
	sql="select * from t_completedjourney where GPName='Castrol' and StartDate >='"+thedate+"' and StartDate <='"+edate+"' order by StartDate asc";
	
	}
	else
	{
		sql="select * from t_completedjourney where Endcode in "+locationlist+" and GPName='"+mainuser+"'  and StartDate >='"+thedate+"'  and StartDate <='"+edate+"' order by StartDate asc";
	}
	//out.print(sql);
	ResultSet rst=st.executeQuery(sql);
	%>
	<table border="1" width="100%" bgcolor="white">
	<tr><td>
	<table class="stats">
	<th colspan="12">Vehicle Arrived
	<%
	if(session.getAttribute("Location").toString().equals("All"))
	{
	}
	else
	{
		out.print(" at "+session.getAttribute("Location").toString() +" From "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate))+" to "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate)) );
	}
	%>
	</th>
	<tr>
	<td class="hed"><div class="bodyText"><b>Trip ID</b></div></td>
	<td class="hed"><div class="bodyText"><b>Vehicle Reg. No</b></div></td>
	<td class="hed"><div class="bodyText"><b>Owner Name</div></b></td>
	<td class="hed"><div class="bodyText"><b>Start Date</div></b></td>
	<td class="hed"><div class="bodyText"><b>End Date</div></b></td>
	<td class="hed"><div class="bodyText"><b>Origin</div></b></td>
	<td class="hed"><div class="bodyText"><b>Destination</div></b></td>
	<td class="hed"><div class="bodyText"><b>Distance</div></b></td>
	<td class="hed"><div class="bodyText"><b>Avg. Speed</div></b></td>
	<td class="hed"><div class="bodyText"><b>Duration</div></b></td>
	<td class="hed"><div class="bodyText"><b>Driver Name</div></b></td>
	<td class="hed"><div class="bodyText"><b>Driver Code</div></b></td>

</tr>
<%
while(rst.next())
{
%>
<tr>
<td class="bodyText"><div align="left">
<a href="startedtrip.jsp?tripid=<%=rst.getString("TripID")%>&vehcode=<%=rst.getString("VehId")%>&sdate=<%=rst.getString("StartDate")%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=rst.getString("OwnerName")%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("endplace")%>&enddate=<%=rst.getString("EndDate")%>&pg=cm"><%=rst.getString("TripID")%> </a>
</div></td>
<td class="bodyText"><div align="left"><%=rst.getString("VehRegNo")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("OwnerName")%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(sd1);
 out.print(sh1);%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sh2 = fmt2.format(sd2);
 out.print(sh2);%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("KmTravelled")%></div></td>
<td class="bodyText"><div align="left"><%


String ss=rst.getString("AvgRunningSpeed");
if(ss.length() >4)
{
out.print(ss.substring(0,4));
}
else
{
out.print(ss);
}
%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("RunningDuration")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("DriverName")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("DriverId")%></div></td>
</tr>


<%
}
%>
</table>
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
</td></tr>
</table>
<%
}
%>
			<!-- body part come here -->
				
			</td>
    <td class="fboxlowright">&nbsp;</td>
    
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
      <%@ include file="footernew.jsp" %>
    </body>
</html>
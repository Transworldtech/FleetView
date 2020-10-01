<%@ include file="headernew.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
  	response.setHeader("Pragma","no-cache");
  	response.setDateHeader ("Expires", 0);
 %>
 
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

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>castrolTotalTrips</title>
</head>
<body>
<%!
	Connection conn,conn1;
	Statement st,st1,st2,st3,st4,st5,st6,st7,st8,stt,st9,st10,st11,sttt,stbrief,stplace,stdebrief,st12,sten,stst,stbt,sten1,sten2,sten3,stst1,sts2,sts3,stbt1,stbt2,stbt3;
	String fromdate, todate,sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sqll,sqlll,sqlplace,sql8,sql9,sqlbrief,sqldebrief,datenew1,datenew2;
	NumberFormat nf = DecimalFormat.getNumberInstance();
	
%>


<table border="0" width="100%" class="stats">
<%
//String sortby=request.getParameter("sortby");
//System.out.println("sortby--->"+sortby);

//out.println("\nsortby-===-->"+sortby);

try
{
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	int kmcountall,kmcount,tripcount,drivercount,tripcountall,drivercountall,vehcount,vehcountall,oscount,oscountall,racount,racountall,rdcount,rdcountall,cdcount,cdcountall,ndcount,ndcountall,countlatency,latency,durationall,duration;
	String startplace,StartCode;
	double ratingcount,ratingcountall;
	double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
	String data1, data2,showdate1,showdate,Owner,datenew1,datenew2,transporter,thename,sTripID="",cTripID="",TripID="";
	String fromdate="", todate="",sql="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="";
	double ss=0.00,aa=0.00,rr=0.00,rt=0.00;
	
	double rtcount=0.00,dtcount=0.00, dtcount1=0.00;
	double rating1=0.00,rating=0.00;
	int i=0;
	String  vv="",ownerNm="",counDriveYesNo=null,ntDriveYesNo=null,sortby="-";
	int  stcount=0, runDuration=0,osduration=0,osduration1=0,tpcount=0,tpcount1=0,dcount=0,dcount1=0,vcount=0, vcount1=0,mydtcount=0,mydtcount1=0;
	int oscount1=0, racount1=0,rdcount1=0, ndcount1=0, stcount1=0,cdcount1=0,transportercount=0,runDuration1=0;
	int pbrief,pdebrief,totpbrief,totpdebrief;
	thename=request.getParameter("thename");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	String Transporter=session.getAttribute("usertypevalue").toString();
	 sortby=request.getParameter("sortby");
	if(!(null==sortby))
	{
		if(sortby.equals("trans"))
		{
			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="2">Transporter Wise Report Of Castrol Monthly Report For Started Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">Transporter Wise Report Of Castrol Monthly Report For Ended Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">Transporter Wise Report Of Castrol Monthly Report For Started & Ended Trips Trips</font></b></td></tr>
				<%
			}
		}
		else if(sortby.equals("location"))
		{
			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="2">LocationWise Report Of Castrol Monthly Report For Started Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">LocationWise Report Of Castrol Monthly Report For Ended Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">LocationWise Report Of Castrol Monthly Report For Started & Ended Trips Trips</font></b></td></tr>
				<%
			}
		}
		else 
		{

			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="2">Total Trips Report Of Castrol Monthly Report For Started Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">Total Trips Report Of Castrol Monthly Report For Ended Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">Total Trips Report Of Castrol Monthly Report For Started & Ended Trips Trips</font></b></td></tr>
				<%
			}
		
		}
	}
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	st5=conn.createStatement();
	
if(!(null==thename))
{
	%>
	<tr>
	<td  class="hed" rowspan="2"> Sr.</td>
	<td  class="hed" rowspan="2"> Trip ID</td>
	<td  class="hed" rowspan="2"> Vehicle Reg. No.</td>
	<td  class="hed" rowspan="2"> Transporter</td>
	<td  class="hed" rowspan="2"> Driver ID</td>
	<td  class="hed" rowspan="2"> Driver Name</td>
	<td  class="hed" rowspan="2"> Start Place</td>
	<td  class="hed" rowspan="2"> Start Date</td>
	<td  class="hed" rowspan="2"> End Place</td>
	<td  class="hed" rowspan="2"> Rating</td>
	</tr>
	<tr>
	<%
	sql1="SELECT Distinct(`TripID`) as count FROM `t_alljddata` WHERE `StartDate` between '"+datenew1+"' and '"+datenew2+"' and Status = 'NotProcessed'";
	//println(sql1);
	ResultSet rst1=st1.executeQuery(sql1);
	while(rst1.next())
	{
	%>
	</tr>
	<%
 //the name
}
} //try

	catch(Exception e)
	{
		e.printStackTrace();
	//	System.out.println("In side exception");	
	}
	finally
	{
		conn.close();
		conn1.close();
	}

	%>
	</table>
	</body>
	</html>
<%@ include file="footernew.jsp" %>
<%@ include file="Connections/conndriver.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn,conn1;
Statement st,st1,st2,st3;
String driverid, cnt,jcode,discription;
String sql,sql1;
int oscount,racount,rdcount,distance;
double rating;
String date1,date2;
java.util.Date enddate=new java.util.Date();
%>
<%
jcode="('000000',";
driverid =request.getParameter("driverid");
cnt=request.getParameter("cnt");
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();

NumberFormat nf = DecimalFormat.getNumberInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
String ratingfrmtd="", ncastratingfrmtd="";

	if(cnt.equals("1"))
	{
	discription="Last Trip";
	sql="select * from t_completedjourney where DriverId='"+driverid+"' order by StartDate desc limit 1";
	}
	if(cnt.equals("2"))
	{
		discription="Last 1 Month Trips";
		java.util.Date dt1= new java.util.Date();
		date1=new SimpleDateFormat("yyyy-MM-dd").format(dt1)+" 00:00:00";
		sql="select (DATE_ADD(CURDATE(),INTERVAL -1 MONTH))as lastmonth";
		ResultSet rstdate=st.executeQuery(sql);
		
		if(rstdate.next())
		{
			date2=new SimpleDateFormat("yyyy-MM-dd").format(rstdate.getDate("lastmonth"))+" 00:00:00";
		}
		sql="select distinct(TripId) as TripId,enddate from t_completedjourney where DriverId='"+driverid+"' and StartDate <='"+date1+"' and startDate >='"+date2+"'";
		
	}
	if(cnt.equals("3"))
	{
		discription="Last 6 Month Trips";
		java.util.Date dt1= new java.util.Date();
		date1=new SimpleDateFormat("yyyy-MM-dd").format(dt1)+" 00:00:00";
		sql="select (DATE_ADD(CURDATE(),INTERVAL -6 MONTH))as lastmonth";
		ResultSet rstdate=st.executeQuery(sql);
		
		if(rstdate.next())
		{
			date2=new SimpleDateFormat("yyyy-MM-dd").format(rstdate.getDate("lastmonth"))+" 00:00:00";
		}
		sql="select distinct(TripId) as TripId,enddate from t_completedjourney where DriverId='"+driverid+"' and StartDate <='"+date1+"' and startDate >='"+date2+"'";
		
	}
	if(cnt.equals("4"))
	{
		discription="All Trips";
		sql="select distinct(TripId) as TripId,enddate from t_completedjourney where DriverId='"+driverid+"'";
		
	}
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		jcode=jcode+"'"+rst.getString("TripId")+"',";
		enddate=rst.getDate("Enddate");
	}
	jcode=jcode.substring(0,jcode.length()-1);
	jcode=jcode+")";
	sql1="select sum(OSCount) as OS, sum(RACount) as RA, sum(RDCount) as RD, sum(Distance) as Distance, avg(Rating) as Rating from t_driver_ds where Jcode in "+jcode;
	ResultSet rst1=st2.executeQuery(sql1);
	oscount=0;
	racount=0;
	rdcount=0;
	distance=0;
	rating=0.0;
	if(rst1.next())
	{
		oscount=rst1.getInt("OS");
		racount=rst1.getInt("RA");
		rdcount=rst1.getInt("RD");
		distance=rst1.getInt("Distance");
		rating=rst1.getDouble("Rating");

		ratingfrmtd=nf.format(rating);
		%>
	<SCRIPT LANGUAGE="JavaScript">
		if(parseInt(navigator.appVersion) >= 4)
		{
			var q = new Graph(100,100);
			q.scale = 1;
			q.title = "Average Rating of a Driver (<%=discription%>)";
			q.yLabel = "";
			q.xLabel = "Last Trip done on <%=new SimpleDateFormat("dd-MMM-yyyy").format(enddate)%>";
			q.setXScale("",1);
			q.setLegend('Over Speed (<%=oscount%>)','Rapid Accelaration (<%=racount%>)','Rapid Decelaration (<%=rdcount%>)','Rating (<%=ratingfrmtd%>)');
			q.addRow(<%=oscount%>);
			q.addRow(<%=racount%>);
			q.addRow(<%=rdcount%>);
			q.addRow(<%=ratingfrmtd%>);
			q.build();
		 }
	</script>


		<%
		
		
	}

	/******************* non castrol trips *******************/
	int ncastdistlasttrip=0, ncastOSlasttrip=0, ncastRDlasttrip=0, ncastRAlasttrip=0, ncastOSDuralasttrip=0;
	int ncastRAlasttripcalc=0, ncastRDlasttripcalc=0, ncastOSlasttripcalc=0, ncastratlasttrip=0;  
		
	String sql16="select sum(Distance) as sumdist, sum(OSCount) as sumos, sum(RDCount) as sumrd, sum(RACount) as sumra,avg(Rating) as Rating from t_driver_ds where JCode='-' and TheDate >= '"+enddate+"' and DCode='"+driverid+"' ";
	//out.print(sql16);	
		ResultSet rs16=st2.executeQuery(sql16);
		while(rs16.next())
		{

			ncastOSlasttrip=rs16.getInt("sumos");
			ncastRAlasttrip=rs16.getInt("sumra");
			ncastRDlasttrip=rs16.getInt("sumrd");
			ncastdistlasttrip=rs16.getInt("sumdist");
			ncastratlasttrip=rs16.getInt("Rating");
			
		}

	
	ncastratingfrmtd=nf.format(ncastratlasttrip);	
	
	/******************* non castrol trips *******************/
	%>
<table class="stats" width="100%" border="1">
<tr>
<td><b>Violations</b></td>
<td><b>Castrol Trips</b></td>
<td><b>Non-Castrol Trips</b></td>
</tr>
<tr>
<td><b>OS</b></td>
<td><%=oscount%></td>
<td><%=ncastOSlasttrip%></td>
</tr>

<tr>
<td><b>RA</b></td>
<td><%=racount%></td>
<td><%=ncastRAlasttrip%></td>
</tr>

<tr>
<td><b>RD</b></td>
<td><%=rdcount%></td>
<td><%=ncastRDlasttrip%></td>
</tr>

<tr>
<td><b>Distance</b></td>
<td><%=distance%></td>
<td><%=ncastdistlasttrip%></td>
</tr>
<tr>
<td><b>Rating</b></td>
<td><%=ratingfrmtd%></td>
<td><%=ncastratingfrmtd%></td>
</tr>

</table>
			
	<%
	}catch(Exception e)
	{
		out.print(e);
	}
	finally
	{
		st.close();
		st1.close();
		st2.close();
		st3.close();
		conn.close();
		conn1.close();
	}
	
	%>

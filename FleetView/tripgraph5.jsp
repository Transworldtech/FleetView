<%@ include file="Connections/conndriver.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/wz_jsgraphics.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/line.js"></SCRIPT>
<%!
Connection conn;
Statement st,st1;
String driverid, cnt,jcode,discription,nonjcode;
String sql,sql1;
int oscount,racount,rdcount,distance;
double rating;
int oscount1,racount1,rdcount1,distance1;
double rating1;
String date1,date2;
%>
<table boder="0"bgcolor="white" width="100%">

<%
jcode="('000000',";
driverid =request.getParameter("driverid");
cnt=request.getParameter("cnt");
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	
	
	NumberFormat nf = DecimalFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);	
	nf.setGroupingUsed(false);
	String ratingfrmtd="", ncastratingfrmtd="";
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
		sql="select distinct(TripId) as TripId from t_completedjourney where DriverId='"+driverid+"' and StartDate <='"+date1+"' and startDate >='"+date2+"'";
		}
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			jcode=jcode+"'"+rst.getString("TripId")+"',";
			//out.print(jcode);
		}
		jcode=jcode.substring(0,jcode.length()-1);
		jcode=jcode+")";
		
		oscount=0;
		racount=0;
		rdcount=0;
		distance=0;
		rating=0.0;
				
		sql1="select count(*) as OS from t_trip_overspeed where Jcode in "+jcode;
		ResultSet rstos=st1.executeQuery(sql1);
		if(rstos.next())
		{
			oscount=rstos.getInt("OS");
		}
		
		sql1="select count(*) as RA from t_trip_ra where Jcode in "+jcode;
		ResultSet rstra=st1.executeQuery(sql1);
		if(rstra.next())
		{
			racount=rstra.getInt("RA");
		}
		
		sql1="select count(*) as RD from t_trip_rd where Jcode in "+jcode;
		ResultSet rstrd=st1.executeQuery(sql1);
		if(rstrd.next())
		{
			rdcount=rstrd.getInt("RD");
		}
		sql1="select sum(KmTravelled) as Distance ,avg(TripRating) as Rating from t_completedjourney where JDCode in"+jcode;
		ResultSet rstdist=st1.executeQuery(sql1);
		if(rstdist.next())
		{
			distance=rstdist.getInt("Distance");
			rating=rstdist.getDouble("Rating");
			ratingfrmtd=nf.format(rating);
		}
				
			String newdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));
			String newdate2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2));
			double weekrate1=0.0,weekrate2=0.0,weekrate3=0.0,weekrate4=0.0,weekrate5=0.0;
			int j=0;
	
			/* code to get rating for first week */
			
			sql1="select avg(TripRating) as Rating from t_completedjourney where JDcode in "+jcode+" and StartDate >='"+newdate2+"' and StartDate <(DATE_ADD('"+newdate2+"',INTERVAL 7 DAY))";
			ResultSet week1=st1.executeQuery(sql1);
			if(week1.next())
			{
				weekrate1=week1.getDouble("Rating");
				if(weekrate1>0.0)
				j++;
			}
		
			sql1="select  avg(TripRating) as Rating from t_completedjourney where JDcode in "+jcode+" and StartDate >=(DATE_ADD('"+newdate2+"',INTERVAL 7 DAY)) and StartDate <(DATE_ADD('"+newdate2+"',INTERVAL 14 DAY))";
			ResultSet week2=st1.executeQuery(sql1);
			if(week2.next())
			{
				weekrate2=week2.getDouble("Rating");
				if(weekrate2>0.0)
				j++;
			}
		
		sql1="select  avg(TripRating) as Rating from t_completedjourney where JDcode in "+jcode+" and StartDate >=(DATE_ADD('"+newdate2+"',INTERVAL 14 DAY)) and StartDate <(DATE_ADD('"+newdate2+"',INTERVAL 21 DAY))";
		ResultSet week3=st1.executeQuery(sql1);
		if(week3.next())
		{
			weekrate3=week3.getDouble("Rating");
			if(weekrate3>0.0)
				j++;
		}
		
		sql1="select  avg(TripRating) as Rating from t_completedjourney where JDcode in "+jcode+" and StartDate >=(DATE_ADD('"+newdate2+"',INTERVAL 21 DAY)) and StartDate <(DATE_ADD('"+newdate2+"',INTERVAL 28 DAY))";
		ResultSet week4=st1.executeQuery(sql1);
		if(week4.next())
		{
			weekrate4=week4.getDouble("Rating");
			if(weekrate4>0.0)
				j++;
		}
		
		sql1="select  avg(TripRating) as Rating from t_completedjourney where JDcode in "+jcode+" and StartDate >=(DATE_ADD('"+newdate2+"',INTERVAL 28 DAY)) and StartDate <'"+newdate1+"'";
		ResultSet week5=st1.executeQuery(sql1);
		if(week5.next())
		{
			weekrate5=week5.getDouble("Rating");
			if(weekrate5>0.0)
				j++;
		}
		%>
				
		<%
		nonjcode="('000000',";
		sql="select distinct(TripId) as TripId from t_completednontripjourney where DriverId='"+driverid+"' and StartDate <='"+date1+"' and startDate >='"+date2+"'";
		
		ResultSet rstnon=st.executeQuery(sql);
		while(rstnon.next())
		{
			nonjcode=nonjcode+"'"+rstnon.getString("TripId")+"',";
			//out.print(nonjcode);
		}
		nonjcode=nonjcode.substring(0,nonjcode.length()-1);
		nonjcode=nonjcode+")";
		oscount1=0;
		racount1=0;
		rdcount1=0;
		distance1=0;
		rating1=0.0;
	
		sql1="select count(*) as OS from t_nontrip_overspeed where Jcode in "+nonjcode;
		ResultSet rstos1=st1.executeQuery(sql1);
		
		if(rstos1.next())
		{
			oscount1=rstos1.getInt("OS");
			
		}
		
		sql1="select count(*) as RA from t_nontrip_ra where Jcode in "+nonjcode;
		ResultSet rstra1=st1.executeQuery(sql1);
		if(rstra1.next())
		{
			racount1=rstra1.getInt("RA");
		}
		
		sql1="select count(*) as RD from t_nontrip_rd where Jcode in "+nonjcode;
		ResultSet rstrd1=st1.executeQuery(sql1);
		if(rstrd1.next())
		{
			rdcount1=rstrd1.getInt("RD");
		}
		sql1="select sum(KmTravelled) as Distance ,avg(TripRating) as Rating from t_completednontripjourney where JDCode in"+nonjcode;
		ResultSet rstdist1=st1.executeQuery(sql1);
		if(rstdist1.next())
		{
			distance1=rstdist1.getInt("Distance");
			rating1=rstdist1.getDouble("Rating");
			ncastratingfrmtd=nf.format(rating1);
		}	
	%>
	
<tr><td colspan="2">
	<table class="stats" width="100%" border="1">
	<tr>
		<td class="hed"><b>Violations</b></td>
		<td class="hed"><b>Castrol Trips</b></td>
		<!--<td class="hed"><b>Non-Castrol Trips</b></td>-->
	</tr>
	<tr>
		<td class="hed"><b>OS</b></td>
		<td><%=oscount%></td>
		<!--<td>< %=oscount1%></td>-->
	</tr>
	<tr>
<td class="hed"><b>RA</b></td>
<td><%=racount%></td>
<!--<td>< %=racount1%></td>-->
</tr>

<tr>
<td class="hed"><b>RD</b></td>
<td><%=rdcount%></td>
<!--<td>< %=rdcount1%></td>-->
</tr>

<tr>
<td class="hed"><b>Distance</b></td>
<td><%=distance%></td>
<!--<td>< %=distance1%></td>-->
</tr>
<tr>
<td class="hed"><b>Rating</b></td>
<td><%=ratingfrmtd%></td>
<!--<td>< %=ncastratingfrmtd%></td>-->
</tr>

</table>
	<%
	}catch(Exception e)
	{
		out.print("Exception---->"+e);
	}
	finally
	{
		try
		{
		st.close();
		st1.close();
		conn.close();
		}catch(Exception e)
		{
			
		}
	}
	
	%>
<td></tr></table>

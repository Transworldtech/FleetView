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
<div align="right">Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
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
			Connection conn;
			Statement st, st1;
			String sql;	
			String data,data1,vehiclecode,vehicleno;		
			%>
			<%
			
			NumberFormat nf = DecimalFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2); 
			
				try
				{
					Class.forName(MM_dbConn_DRIVER); 
					conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
					st=conn.createStatement();
					st1=conn.createStatement();
				}catch(Exception e)
				{	
					out.print("Exception ---->"+e);
				}			
			%>
			<table width="100%" align="center" class="sortable">
				
		<%
		try
			{
			String dd=request.getQueryString();
						if(!(null==dd))
						{
							data=request.getParameter("data");
							data1=request.getParameter("data1");
							
						}
						else
						{
							data=data1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
						}
			if(!(null==request.getQueryString()))
			{	
				String ss=request.getParameter("vehicle");
				StringTokenizer stk = new StringTokenizer(ss,",");
				vehiclecode=stk.nextToken();
				vehicleno=stk.nextToken();		
		%>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Trip Report for Vehicle <%=vehicleno%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Trip Id</th>
			<th class="hed"> Start Date</th>
			<th class="hed"> Origin</th>
			<th class="hed"> End Date</th>
			<th class="hed"> Destination</th>
			<th class="hed"> OS</th>
			<th class="hed"> RA</th>
			<th class="hed"> RD</th>
			<th class="hed"> CD</th>
			<th class="hed"> DT</th>
			<th class="hed"> Run. Hrs</th>
			<th class="hed"> ND</th>
			<th class="hed"> Rating</th>
			</tr>		
			<%
			//sql="select distinct(TripId),StartDate,StartPlace,EndDate,EndPlace,OSCount,RACount,RDCount,CRCount,KmTravelled,TripDuration,NDCount,TripRating from t_completedjourney where vehid='"+vehiclecode+"' and StartDate >='"+data+"' and StartDate <='"+data1+"' order by StartDate";
			sql="select distinct(TripId),StartDate,StartTime,StartPlace,EndDate,EndTime,EndPlace,OSDuration,RACount,RDCount,CRCount,KmTravelled,TripDuration,NDCount,TripRating from t_completedjourney where vehid='"+vehiclecode+"' and StartDate >='"+data+"' and StartDate <='"+data1+"' order by StartDate";
			ResultSet rst1=st.executeQuery(sql);
			int i=1;
			while(rst1.next())
			{
				%>
			<tr>
			<td><%=i%></td>
			<td><%=rst1.getString("tripid")%></td>
			<td><%
			try{			
			out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("StartDate")));
			}catch(Exception ee)
			{
				try{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(rst1.getDate("StartDate")));
				}catch(Exception eee)
				{
					out.print(rst1.getString("StartDate"));
				}
			}
			%></td>
			<td ><div align="left"><%=rst1.getString("StartPlace")%></a></td>
			<td>
			<%
			try{			
			out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("EndDate")));
			}catch(Exception ee)
			{
				try{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(rst1.getDate("EndDate")));
				}catch(Exception eee)
				{
					out.print(rst1.getString("EndDate"));
				}
			}
			%>			
			</td>
			<td ><div align="left"><%=rst1.getString("EndPlace")%></a></td>
			<td ><div align="right"><%=rst1.getInt("OSDuration")%></a></td>
			<td><div align="right"><%=rst1.getInt("RACount")%></a></td>
			<td><div align="right"><%=rst1.getInt("RDCount")%></a></td>
			<td><div align="right"><%=rst1.getString("CRCount")%></a></td>
			<td><div align="right"><%=rst1.getDouble("KmTravelled")%></a></td>
			<td><div align="right"><%=rst1.getString("TripDuration")%></td>
			<td><div align="right"><%=rst1.getString("NDCount")%></td>
			<td><div align="right">
			<%double rating=((Double.valueOf(rst1.getString("RACount")))/(Double.valueOf(rst1.getString("KmTravelled")))*100)+((Double.valueOf(rst1.getString("RDCount")))/(Double.valueOf(rst1.getString("KmTravelled")))*100)+((Double.valueOf(rst1.getInt("OSDuration")))/10/(Double.valueOf(rst1.getString("KmTravelled")))*100);
			if(rst1.getInt("KmTravelled")==0)
			{
				out.print("NA");
			}
			else
			{
				out.print(nf.format(rating));
			}%>
			
			</tr>				
				<%
				i++;
			}
			}			
			%>
			</table>
			<%
			
			
				conn.close();
			}catch(Exception e)
			{	
				out.print("Exception---->"+e);
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
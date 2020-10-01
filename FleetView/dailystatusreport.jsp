 <%@ include file="headernew.jsp" %> 
 
 
<%@page import="java.sql.Date"%><jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
  <script type="text/javascript" src="http://www.google.com/jsapi"></script>
  <SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
</head>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
 <%!
	Connection conn, conn1;
	Statement st1,st2,st,st3,st4,st5,st6,st7,st8,st9,st10,st11;
    ResultSet rst1,rst2,rst3,rst4,rst5,rst6,rst7,rst8;
%>
  <%
	int cntos,cntra,cntrda,cntdt,cntst,cntrh,cntcd,cntnd,cntfc;
	double stopdur,totstopdur;
	Double cntavg=0.00;
	String vehregno,transporter;
	String datex1,datex2,data1,data2;
	String dateformat,yesdate,cdate;
	
	int dist=0,dist1=0,dist2=0,loc=0;
	int totalveh=0,totalavgkm;
	int totalveh1=0;
	Double avg=0.0,avg1=0.0,avg2=0.0,Distance=0.0;
	  DateFormat date;
	  Calendar cal;
	  int i=1,count=0,count1=0,count2=0,vcode=0,vcode1=0;
	  int km=0,totalrunkm=0;
	  String vrgno,sql5,sql6,VehicleRegNumber=null;
	  
	  String today1="";
	  String usertypevalue="",start="",pd="";
	  long mils=0,prvday=0;
	  NumberFormat nf = DecimalFormat.getNumberInstance();
	  nf.setMaximumFractionDigits(2);
	  nf.setMinimumFractionDigits(2);	
	  nf.setGroupingUsed(false);
	  
	  if(!(null==request.getQueryString()))
	   {
		  today1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data"))); //request.getParameter("data");  
		  java.util.Date today = new SimpleDateFormat("yyyy-MM-dd").parse(today1);
		  mils=today.getTime();
		  prvday=60*60*1000*24*1; //mins*sec*miliseconds*hours*day
		  prvday=mils-prvday;
		  today.setTime(prvday);
		  today1=new SimpleDateFormat("yyyy-MM-dd").format(today);
		  System.out.println("From Date By Calender---->"+today1);
		  start=new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(today1));
		  start=start+"-01";
		  System.out.println("To Date---->"+start);
	   }
	   else
	   {
			  java.util.Date today = new java.util.Date();
			  mils=today.getTime();
			  prvday=60*60*1000*24*1; //mins*sec*miliseconds*hours*day
			  prvday=mils-prvday;
			  today.setTime(prvday);
			  today1=new SimpleDateFormat("yyyy-MM-dd").format(today);
			  System.out.println("From Date---->"+today1);
			  start=new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(today1));
			  start=start+"-01";
			  System.out.println("To Date---->"+start);
	   }
	  pd=new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(today1));
  String to=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today1));
  String from=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(start));
  String user;
  user=session.getAttribute("user").toString();
  usertypevalue=session.getAttribute("usertypevalue").toString();
  dateformat = session.getAttribute("dateformat").toString();
  %>
  <table border="0" width="100%" align="center">
  <tr><td colspan="3">
  <table border="0" class="stats">
<tr><td><!-- <font color="block" size="3" >Report No: 10.5</font>-->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font size="3"><B> Daily Status Report For</B></font>
</td>
<td>
<form action="" method="get">
&nbsp;&nbsp;
<input type="text" id="data" name="data" value="<%=to %>" size="15" readonly/>
</td><td align="left">
<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script>
<input type="submit" name="submit" id="submit" value="submit">
</form>
</td>

<td align="right">
<a href="#" onclick="javascript:window.open('printdailystatusreport.jsp');" title="Print Daily Status Report Report"><img src="images/print.jpg" width="20px" height="20px"></a>&nbsp; &nbsp;
<a href="excel_dailystatus.jsp?today1=<%=today1%>"  title="Export to Pdf"><img src="images/acrobat_icon.jpg" width="20px" height="20px"></a>&nbsp;&nbsp;&nbsp;
<a href="excel_dailystatusreport.jsp?today1=<%=today1%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>

<%=fleetview.PrintDate() %></div>
</td>
</tr>
</table>
</td></tr>
<tr><td>
  <table border="1" width=100% align="center" class="stats">
  
<%
java.util.Date ShowDate =new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
String showdate = formatter.format(ShowDate);
System.out.print(showdate);



/*********************************************/

 //if(!(showdate.equals(today1)))
//{
	 //System.out.print("sd "+showdate);
	 //System.out.println("td "+today1);
	// showdate=today1;
	 
	//System.out.println(" check---------->"+today1);
	%>
<tr>
<th colspan=4><font size="3"><B> Daily Status for  <%=usertypevalue%> On Date <%=to %> </B></font></th></tr>
<tr>
<th colspan=4 align="center">Today</th>
</tr>
 <table border="1" width=100% align="center" class="sortable" class="stats">
<tr>
<th>Run</th>

<th>Veh</th>
<th>Run Kmh</th>
<th>Avg. Kmh</th>

</tr>

		 	

<%


String ss=session.getAttribute("VehList").toString();
//System.out.print("veh List"+ss);

	int grt250=0,less250=0,idle=0,offline=0,cnt=0,top1=0,top2=0,top3=0,cnt1=0;
	int cnt3=0,cnt4=0,cnt5=0,cnt6=0,top4=0,top5=0;
	int top11=0, top22=0, top33=0, top44=0, top55=0;
	String veh1="",veh2="",veh3="",veh4="",veh5="";
	String veh11="",veh22="",veh33="",veh44="",veh55="";
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname; 
	String sql,sql1,sql2,sql3;
	
	//count=100;
//count1=120;
	try
	{
		
		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	
		
	//conn = fleetview.ReturnConnection();
	//conn1 = fleetview.ReturnConnection1();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();	
	st4=conn1.createStatement();
	st5=conn.createStatement();
	st6=conn1.createStatement();
	st7=conn1.createStatement();
	st8=conn1.createStatement();
	st9=conn1.createStatement();
	st10=conn1.createStatement();
	st11=conn1.createStatement();
	int vcode2;
	String vregno,sql7;
	int tottransvehcnt=0,tottransvehcntm=0;
	
	
	/**************run km >250***************************/
	String sqlvehcnt="SELECT count(VehicleCode) as count FROM db_gps.`t_vehicledetails` where ownername = '"+usertypevalue+"' and status in ('-','Removed','Missing')";
	ResultSet rstcnt=st1.executeQuery(sqlvehcnt);
	System.out.println("Todays date"+today1);
	System.out.println("sqlvehcnt1   ->"+sqlvehcnt);
	if(rstcnt.next())
	{
		tottransvehcnt=rstcnt.getInt("count");
	}
	
	sql1="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance >= 250 and TheDate ='"+today1+"'";//'2010-08-22';// and TheDate >='"+data1+"'";
		//"select count(*) as vehcount,sum(Distance) as Distance,avg(Distance) as avg from "+tbname+" where  VehCode='"+aa+"'and Distance>250 and TheDate ='2007-02-20'";// and TheDate >='"+data1+"'";
    //Runkm>250
    System.out.println("query "+sql1);
    // System.out.println("1------>"+sql1);
	 rst1=st2.executeQuery(sql1);
	if(rst1.next())
	 {
		grt250=rst1.getInt("vehcount");
			
		 dist=rst1.getInt("Distance");
		 System.out.println("dist"+dist);
		
	 %>
	 <tr>
	 <td>Run>250 Km</td>
	 <td><%=rst1.getInt("vehcount")%></td>

	 <td><%=rst1.getInt("Distance")%></td>
	 <td><%=nf.format(rst1.getDouble("AVG"))%></td>

<%
	 }
%>
</tr>
<% 
	/**************run km <250***************************/
	sql2="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance < 250 and  Distance > 10 and TheDate ='"+today1+"'";//'2010-08-22'";// and TheDate >='"+data1+"'";
	 // System.out.println("Sql2--------->"+sql2);
	 rst2=st7.executeQuery(sql2);
	if(rst2.next())
	 {
		less250=rst2.getInt("vehcount");
		dist1=rst2.getInt("Distance");
		//System.out.println("dist1 "+dist1);
	/*	 count1+=rst2.getInt("vehcount");
		 avg1=rst2.getDouble("avg");
		System.out.println("Distance              "+dist1);
		System.out.println("avg              "+avg1);
		*/
		%>
		
		 <td>Run<250 Km</td>
		<td><%=rst2.getInt("vehcount")%></td>

		 <td><%=rst2.getInt("Distance")%></td>
		 <td><%=nf.format(rst2.getDouble("AVG"))%></td>

	<%
		 }
	%>
	</tr>
	<%
	
	/*************run km <10***************************/
sql3="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance <= 10 and Location not like '%NO DATA%' and TheDate ='"+today1+"'";//'2010-08-22'";// and TheDate >='"+data1+"'";
//System.out.println("Sql3------------->"+sql3);
	rst6=st4.executeQuery(sql3);
	if(rst6.next())
	 {
		idle=rst6.getInt("vehcount"); 
		dist2=rst6.getInt("Distance");
		
		/* count2+=rst6.getInt("vehcount");
		 avg2+=rst6.getDouble("avg");
		 *///System.out.println("Distance              "+dist2);
		 %>
		 
		 <tr>
		 <td>Idle</td>
		 <td><%=rst6.getInt("vehcount")%></td>

		 <td><%=rst6.getInt("Distance")%></td>
		 <td><%=nf.format(rst6.getDouble("AVG"))%></td>

		 
		 <%
	 }
	
	%>
	</tr>
	<%
	
	/**************** vechicle offline*****************/

		
		offline=tottransvehcnt-(idle+less250+grt250);
		//loc+=rst3.getInt("count");
	//System.out.println("Location              "+loc);
	//System.out.println("off "+rst3.getInt("vehcount"));
	%>
	<tr>
	<td>Vehicle Offline</td>
	 <td><%=offline%></td>

	 <td>0</td>
	 <td>0</td>
	 <%

	//}
	
	totalveh=tottransvehcnt;

	totalrunkm=rst1.getInt("Distance")+rst2.getInt("Distance")+rst6.getInt("Distance");
	
	//totalavgkm=rst1.getDouble("AVG")+rst2.getDouble("AVG")+rst6.getDouble("AVG");
	totalavgkm=totalrunkm/totalveh;
	
//System.out.println("total "+totalveh);
%>
<tr><td><b>Total</b></td>
	<td><b><%=totalveh%></b></td>
	<td><b><%=totalrunkm%></b></td>
	<td><b><%=nf.format(totalavgkm)%></b></td>
	</tr>
	</table></td>
<td width=40%>
<table border="1" width=100% align="center" class="stats">
  <tr><th colspan="5" align="center">

<font size="3"><b>Top 3 Vehicles Today for <%=usertypevalue%> On  <%=to %></b></font>
</th></tr>
</table>
<table border="1" width=100% align="center" class="sortable">
<tr><th>Veh Reg.No.</th> <th>KM</th></tr>
<tr>

	<%
	/******************************  code for top 3 vehicles********************************************/
	
		
	sql5="select distinct(VehCode),Distance from t_vehall_ds where  VehCode in "+ss+" and TheDate ='"+today1+"' order by Distance Desc limit 3";
		//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
	//System.out.println("new     "+sql5);
	 rst5=st11.executeQuery(sql5);
	//System.out.println("new1--------> "+sql5);
	while(rst5.next())
	{
		
		cnt++;
		if(cnt==1)
		{
			top1=rst5.getInt("Distance");
		}
		else if(cnt==2)
		{
			top2=rst5.getInt("Distance");
		}
		else if(cnt==3)
		{
			top3=rst5.getInt("Distance");
		}
		
		//System.out.println("Distance-- VehCode----->"+rst5.getDouble("Distance")+"   "+rst5.getInt("VehCode"));
		String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
		
		//System.out.println("sql8-------->"+sql8);
		
		ResultSet rveh=st1.executeQuery(sql8);
		while(rveh.next())
		{
			
			cnt1++;
			if(cnt1==1)
			{
				veh1=""+rveh.getString("VehicleRegNumber");
			}
			else if(cnt1==2)
			{
				veh2=""+rveh.getString("VehicleRegNumber");
			}
			else if(cnt1==3)
			{
				veh3=""+rveh.getString("VehicleRegNumber");
			}
			
			
		
		%>
		
		<td><%=rveh.getString("VehicleRegNumber")%></td>
	<%
		}
		
		%>
		<td><%=rst5.getDouble("Distance")%></td>
		</tr>
		<%
	//	}
		
		/****************************** end of code for top 3 vehicles********************************************/
		
		
    }
	
	
	/******************************Pie chart**************************************/
	%>
	</table></td></tr>
	<tr><td>
	
	<table>
	<tr class="sortbottom">
				<td colspan="8">
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['piechart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data = new google.visualization.DataTable();
        			data.addColumn('string', 'Task');
        			data.addColumn('number', 'Hours per Day');
        			data.addRows(6);
        			data.setValue(0, 0, 'Run >= 250 KM');
        			data.setValue(0, 1, <%=grt250%>);
        			data.setValue(1, 0, 'Run <250 KM and Run> 10 KM');
        			data.setValue(1, 1, <%=less250%>);
        			data.setValue(2, 0, 'Idle <10 KM');
        			data.setValue(2, 1, <%=idle%>);
        			data.setValue(3, 0, 'Veh Offline');
        			data.setValue(3, 1, <%=offline%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        			chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Run Statistics'});
      			}
    			</script>
				 <div id="chart_div" order="1"></div>
				</td>				
				</tr>
	
	</table>
	</td>
	<!--Bar chart code start-->
	<td>
	<table>
	<tr><td valign="top" colspan="2">
	<SCRIPT LANGUAGE="JavaScript">
	if(parseInt(navigator.appVersion) >= 3) {
	var q = new Graph(200,200);
	q.scale = 1;
	q.title ="Top 3 Vehicle KM Rating daily";
	q.yLabel = "KM";
	q.xLabel = "<%=showdate%>";
	q.setXScale("",1);
	<%
	String osp,rax,rdx,rat,rat1;
	osp=""+veh1;
	rax=""+veh2;
	rdx=""+veh3;
	%>
	q.setLegend('<%=veh1%>','<%=veh2%>','<%=veh3%>');
	q.addRow(<%=top1%>);
	q.addRow(<%=top2%>);
	q.addRow(<%=top3%>);
	//q.addRow(< %=top4%>);
	//q.addRow(< %=top5%>);
	q.build();
	} else {
	  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
	}
	
	</SCRIPT>
	</td></tr>
	
	</table>
	
	</td>
	</tr>
	<!--Bar chart code end-->
	<tr><td width=40%>
	  <table border="1" width=100% align="center"  class="sortable">
	  
	<tr>

	<th colspan=4 align="center">Monthly Status Report For <%=usertypevalue %> From  <%=from %> To  <%=to %> </th>
	</tr>

	<tr>
	<th>Run</th>

	<th>Veh</th>
	<th>Run Kmh</th>
	<th>Avg. Kmh</th>

	</tr>
	<% /****************Monthly Status code        **************/
	
		/**************run km >250***************************/
	
	//	String sqlvehcnt1="SELECT count(VehicleCode) as count FROM db_gps.`t_vehicledetails` where ownername = '"+usertypevalue+"' and status in ('-','Removed')";
	 //rstcnt=st1.executeQuery("sqlvehcnt1   ->"+sqlvehcnt1);
	 //System.out.println(sqlvehcnt1);
	 
	//if(rstcnt.next())
	//{
		//tottransvehcntm=rstcnt.getInt("count");
	//}
	int distance=0;
	int dist250=0,lessd250=0,idled250=0;
	int g=0,z=0,idl=0;
	double ag=0.0,al=0.0,ai=0.0;
    double average=0.0;
    int sum=0;
    double avgg=0.0,avgl=0.0,avgi=0.0;
	int cont=0;
	double distance1;
	int add=0,add1=0,add2=0;
	int sum1=0;
	
	sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms >= 250";
	System.out.println(">250 n"+sql);
		//"SELECT vehcode,  Distance as sum,format(( Distance ) / '"+pd+"' , 2 ) AS AVG from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"' group by vehcode";
	   rst3=st8.executeQuery(sql);
	  // System.out.println("Monthm------>"+sql);
	   
	 //  System.out.println("Monthm------>"+sql);
 
	   while(rst3.next())
	   {
		   dist250=rst3.getInt("veh");
		   add=rst3.getInt("Dist");
		   avgg=rst3.getDouble("avg");
	   }	
		  
		 %>
		 <tr>
		 <td>Run>250 Km</td>
		 <td><%=dist250%></td>

		 <td><%=add%></td>
		 <td><%=nf.format(avgg)%></td>

	<%
	%>
	</tr>
	<% 
		/**************run km <250***************************/
		sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms < 250 and avgKms > 10";
		//"SELECT vehcode,  Distance as sum,format(( Distance ) / '"+pd+"' , 2 ) AS AVG from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"' group by vehcode";
	  ResultSet rstt3=st8.executeQuery(sql);
	  // System.out.println("Monthm------>"+sql);
	   
	 //  System.out.println("Monthm------>"+sql);
 
	   while(rstt3.next())
	   {
		   lessd250=rstt3.getInt("veh");
		   add1=rstt3.getInt("Dist");
		   avgl=rstt3.getDouble("avg");
	   }
			%>
			 <td>Run<250 Km</td>
			<td><%=lessd250%></td>

			 <td><%=add1%></td>
			 <td><%=nf.format(avgl)%></td>

		<%
			 //}
		%>
		</tr>
		<%
		
		/*************run km <10***************************/
	sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms < 10";
		//"SELECT vehcode,  Distance as sum,format(( Distance ) / '"+pd+"' , 2 ) AS AVG from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"' group by vehcode";
	  ResultSet rsttt3=st8.executeQuery(sql);
	  // System.out.println("Monthm------>"+sql);
	   
	 //  System.out.println("Monthm------>"+sql);
 
	   while(rsttt3.next())
	   {
		   idled250=rsttt3.getInt("veh");
		   add2=rsttt3.getInt("Dist");
		   avgi=rsttt3.getDouble("avg");
	   }
			 %>
			 
			 <tr>
			 <td>Idle</td>
			 <td><%=idled250%></td>

			 <td><%=add2%></td>
			 <td><%=nf.format(avgi)%></td>

			 
			 <%
		// }
		
		%>
		</tr>
		<%
		
		/**************** vechicle offline*******************/
		//sql1="select count(distinct(VehCode)) as vehcount from t_vehall_ds where  VehCode in "+ss+" and Location='NO DATA' and  TheDate <='"+yesdate+"' and TheDate >='"+start+"'";
		//select count(*) as count from "+tbname+" where Location='NO DATA'and TheDate <='"+yesdate+"' ";// and  TheDate <='"+data2+"' and TheDate >='"+data1+"'";
		//System.out.println("Offline-------------->"+sql1);
		 /*rst3=st6.executeQuery(sql1);
		if(rst3.next())
		{*/
			offline=tottransvehcnt-(idled250+lessd250+dist250);
			//loc+=rst3.getInt("count");
		//System.out.println("Location              "+loc);
		//System.out.println("off "+rst3.getInt("vehcount"));
		%>
		<tr>
		<td>Vehicle Offline</td>
		 <td><%=offline%></td>

		 <td>0</td>
		 <td>0</td>
		 <%

		
		
		totalveh1=tottransvehcnt;
		

		totalrunkm=add+add1+add2;
		
		totalavgkm=totalrunkm/totalveh1;
	//System.out.println("total "+totalveh);
	%>
	<tr><td><b>Total</b></td>
		<td><b><%=totalveh1%></b></td>
		<td><b><%=totalrunkm%></b></td>
		<td><b><%=nf.format(totalavgkm)%></b></td>
		</tr>
		</table></td>
	<td width=40%>
	<table border="1" width=100% align="center"  class="sortable">
	  <tr><th colspan="5" align="center">

	<font size="3"><b>Top 3 Vehicles for <%=usertypevalue%> From  <%=from %> To  <%=to %> </b></font>
	</th></tr>
	<tr><th>Veh Reg.No.</th> <th>KM</th></tr>
	<tr>

		<%
		/******************************  code for top 3 vehicles******************************************/
		
			
		sql5="select distinct(VehCode),sum(Distance) as SUM from t_vehall_ds where  VehCode in  "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"'group by vehcode order by sum(distance) desc limit 3";
			//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
		//System.out.println("new     "+sql5);
		 rst5=st9.executeQuery(sql5);
		System.out.println("Month4--------> "+sql5);
		while(rst5.next())
		{
			
			cnt3++;
			if(cnt3==1)
			{
				top1=rst5.getInt("SUM");
			}
			else if(cnt3==2)
			{
				top2=rst5.getInt("SUM");
			}
			else if(cnt3==3)
			{
				top3=rst5.getInt("SUM");
			}
			
			
			//System.out.println("Distance-- VehCode----->"+rst5.getDouble("Distance")+"   "+rst5.getInt("VehCode"));
			String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
			
			//System.out.println("sql8-------->"+sql8);
			
			ResultSet rveh=st1.executeQuery(sql8);
			while(rveh.next())
			{
				
				cnt4++;
				if(cnt4==1)
				{
					veh1=""+rveh.getString("VehicleRegNumber");
				}
				else if(cnt4==2)
				{
					veh2=""+rveh.getString("VehicleRegNumber");
				}
				else if(cnt4==3)
				{
					veh3=""+rveh.getString("VehicleRegNumber");
				}
			
				
			
			%>
			
			<td><%=rveh.getString("VehicleRegNumber")%></td>
		<%
			}
			
%>
			<td><%=rst5.getDouble("SUM")%></td>
			</tr>
			<%
		//	}
			
			/****************************** end of code for top 3 vehicles********************************************/
			
			
	    }
		
		
		/******************************Pie chart**************************************/
		%>
		</table></td></tr>
	
	<tr><td>
	
	<table>
	<tr class="sortbottom">
				<td colspan="8">
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['piechart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data = new google.visualization.DataTable();
        			data.addColumn('string', 'Task');
        			data.addColumn('number', 'Hours per Day');
        			data.addRows(6);
        			data.setValue(0, 0, 'Run >= 250 KM');
        			data.setValue(0, 1, <%=grt250%>);
        			data.setValue(1, 0, 'Run <250 KM and Run> 10 KM');
        			data.setValue(1, 1, <%=less250%>);
        			data.setValue(2, 0, 'Idle <10 KM');
        			data.setValue(2, 1, <%=idle%>);
        			data.setValue(3, 0, 'Veh Offline');
        			data.setValue(3, 1, <%=offline%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div3'));
        			chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Run Statistics'});
      			}
    			</script>
				 <div id="chart_div3" order="1"></div>
				</td>				
				</tr>
	
	</table>
	</td>
	<!--Bar chart code start-->
	<td>
	<table>
	<tr><td valign="top" colspan="2">
	<SCRIPT LANGUAGE="JavaScript">
	if(parseInt(navigator.appVersion) >= 3) {
	var q = new Graph(200,200);
	q.scale = 1;
	q.title = "Top 3 Vehicle KM Rating Monthly";
	q.yLabel = "KM";
	q.xLabel = "<%=showdate%>";
	q.setXScale("",1);
	<%
	String ospp,raxx,rdxx,ratt,ratt1;
	ospp=""+veh1;
	raxx=""+veh2;
	rdxx=""+veh3;
	%>
	q.setLegend('<%=veh1%>','<%=veh2%>','<%=veh3%>');
	q.addRow(<%=top1%>);
	q.addRow(<%=top2%>);
	q.addRow(<%=top3%>);
	//q.addRow(< %=top4%>);
	//q.addRow(< %=top5%>);
	q.build();
	} else {
	  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
	}
	
	</SCRIPT>
	</td></tr>
	
	</table>
	</td>
	</tr>
	<!--Bar chart code end-->
	<tr>
	<td width=50%>
	<table border=1 width=100%  class="sortable">
	<tr>
	<th colspan=2>Stoppage duration -Top 5 Veh with Km run > 10 KM  on Date <%=to %></th>
	</tr>
	<tr>
	<th>Veh Reg No.</th>
	<th>Stop Hrs</th>
	</tr>
	<tr>
	<%
	
	/******************************  code for top 5 vehicles********************************************/
	
	
	sql5="select distinct(VehCode),DayStopDurationinHrs from t_vehall_ds where  VehCode in "+ss+" and distance>10 and TheDate ='"+today1+"' order by DayStopDurationinHrs Desc limit 5";
		//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
	System.out.println("new     "+sql5);
	 rst5=st10.executeQuery(sql5);
	//System.out.println("new1--------> "+sql5);
	while(rst5.next())
	{
		
		cnt5++;
		if(cnt5==1)
		{
			top11=rst5.getInt("DayStopDurationinHrs");
		}
		else if(cnt5==2)
		{
			top22=rst5.getInt("DayStopDurationinHrs");
		}
		else if(cnt5==3)
		{
			top33=rst5.getInt("DayStopDurationinHrs");
		}
		else if(cnt5==4)
		{
			top44=rst5.getInt("DayStopDurationinHrs");
		}
		else if(cnt5==5)
		{
			top55=rst5.getInt("DayStopDurationinHrs");
		}
		
		//System.out.println("Distance-- VehCode----->"+rst5.getDouble("Distance")+"   "+rst5.getInt("VehCode"));
		String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
		
		//System.out.println("sql8-------->"+sql8);
		
		ResultSet rveh=st1.executeQuery(sql8);
		while(rveh.next())
		{
			
			cnt6++;
			if(cnt6==1)
			{
				veh11=""+rveh.getString("VehicleRegNumber");
			}
			else if(cnt6==2)
			{
				veh22=""+rveh.getString("VehicleRegNumber");
			}
			else if(cnt6==3)
			{
				veh33=""+rveh.getString("VehicleRegNumber");
			}
			else if(cnt6==4)
			{
				veh44=""+rveh.getString("VehicleRegNumber");
			}
			else if(cnt6==5)
			{
				veh55=""+rveh.getString("VehicleRegNumber");
			}
			
			
			
			
		
		%>
		
		<td><%=rveh.getString("VehicleRegNumber")%></td>
	<%
		}
		
		%>
		<td><%=rst5.getDouble("DayStopDurationinHrs")%></td>
		</tr>
		<%
		}
		
		/****************************** end of code for top 3 vehicles********************************************/
		//}
	%>
	
	</table>
	</td>
	<!--Bar chart code start-->
	<td>
	
	<table>
	<tr><td valign="top" colspan="2">
	<SCRIPT LANGUAGE="JavaScript">
	if(parseInt(navigator.appVersion) >= 5) {
	var q = new Graph(200,200);
	q.scale = 1;
	q.title = "Top 5 Vehicle Stop Hrs Rating";
	q.yLabel = "Stop Hrs";
	q.xLabel = "<%=showdate%>";
	q.setXScale("",1);
	<%
	String osp1,rax1,rdx1,rattt1,ratt11;
	osp1=""+top11;
	//out.print("OverSpeed1---osp--->"+osp);
	
	rax1=""+top22;
	//out.print("Accelaration1---rax--->"+rax);
	
	rdx1=""+top33;
	//out.print("Decelaration1--rdx--->"+rdx);
	
	rattt1=""+top44;
	ratt11=""+top55;
	//out.print("rating1---rat--->"+rat);
	
	
	//osp=osp.substring(0,5);
	
	//rax=rax.substring(0,5);
	
	//rdx=rdx.substring(0,5);
	
	//rat=rat.substring(0,5);
	
	%>
	q.setLegend('<%=veh11%>','<%=veh22%>','<%=veh33%>','<%=veh44%>','<%=veh55%>');
	q.addRow(<%=top11%>);
	q.addRow(<%=top22%>);
	q.addRow(<%=top33%>);
	q.addRow(<%=top44%>);
	q.addRow(<%=top55%>);
	q.build();
	} else {
	  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
	}
	
	</SCRIPT>
	</td></tr><tr>
	
	</table>
	</td>
	</tr>
	<tr><td>
	 <table border="1" width=100% align="center" class="sortable">
	 <tr>
	<th colspan=2>OFFLLINE VEHICLES</th>
	</tr>
	<tr>
	<th>Sr. No</th>
	<th>VehReg Number</th>
	</tr>
	<%
	int  vcoden=0,cnttt=0;
	String vrgno1="";
	sql1="select vehcode from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and (location like '%No Data%' or location like '%NO Data%' or location like '%No DATA%' or location like '%NO DATA%') and TheDate ='"+today1+"' UNION select VehicleCode from db_gps.t_vehicledetails where VehicleCode in "+ss+" and status in ('Removed','Missing')";
	//sql1="select count(*) as vehcount from t_vehall_ds where  VehCode in "+ss+" and Location like 'NO DATA' and  TheDate ='2010-08-22'";// and TheDate >='"+data1+"'
	//select count(*) as count from "+tbname+" where Location='NO DATA'and TheDate <='"+yesdate+"' ";// and  TheDate <='"+data2+"' and TheDate >='"+data1+"'";
	System.out.println("Offline-------------->"+sql1);
	rst3=st6.executeQuery(sql1);
	while(rst3.next())
	{
		vcoden=rst3.getInt("vehcode");
		
		String sql8="select distinct(VehicleRegNumber) from db_gps.t_vehicledetails where VehicleCode='"+rst3.getInt("VehCode")+"'";
		//System.out.println("removed "+sql8);		
		ResultSet rveh=st1.executeQuery(sql8);
		//System.out.println("removed "+sql8);	
		while(rveh.next())
		{
			cnttt++;
			vrgno1=rveh.getString("VehicleRegNumber");
			%>
			<tr>
			<td><%=cnttt %></td>
			<td><%=vrgno1 %></td>
			</tr>
			<%
		}
		System.out.println("vrgno"+vrgno1);
		
	}
	%>
	</table>
	</td></tr>
	<%
	/***************** Bar chart code Stop Duration hrs**************************/
	}
	
	//end of try
	
	
		 catch(Exception e)
				 {}
		finally
		{
			try
			{
				conn1.close();
			}catch(Exception e)
			{}
			try
			{
				conn.close();
			}catch(Exception e)
			{}
			try
			{
				fleetview.closeConnection();
			}catch(Exception e)
			{}
			try{
				fleetview.closeConnection1();
			}catch(Exception e)
			{}
		}
		
	
	%>
	
	
	

</table>
</html>
</jsp:useBean>
        <%@ include file="footernew.jsp" %>

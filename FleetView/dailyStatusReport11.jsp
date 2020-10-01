 <%@ include file="headernew.jsp" %> 
 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
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

  <%
	Connection conn, conn1;
	Statement st1,st2,st,st3,st4,st5,st6,st7;
	
	 ResultSet rst1,rst2,rst3,rst4,rst5,rst6,rst7,rst8;
	int cntos,cntra,cntrda,cntdt,cntst,cntrh,cntcd,cntnd,cntfc;
	double stopdur,totstopdur;
	Double cntavg=0.00;
	String vehregno,transporter;
	String datex1,datex2,data1,data2;
	String dateformat,yesdate,cdate;
	
	int dist=0,dist1=0,dist2=0,loc=0;
	int totalveh=0;
	Double avg=0.0,avg1=0.0,avg2=0.0,totalavgkm=0.0,Distance=0.0;
	  DateFormat date;
	  Calendar cal;
	  int i=1,count=0,count1=0,count2=0,vcode=0,vcode1=0;
	  int km=0,totalrunkm=0;
	  String vrgno,sql5,sql6,VehicleRegNumber=null;

	  NumberFormat nf = DecimalFormat.getNumberInstance();
	  nf.setMaximumFractionDigits(2);
	  nf.setMinimumFractionDigits(2);	
	  nf.setGroupingUsed(false);

	  java.util.Date today = new java.util.Date();
	  
	  long mils=today.getTime();
	  long prvday=60*60*1000*24*1;//mins*sec*miliseconds*hours*day
	  prvday=mils-prvday;
  java.util.Date lastday=new java.util.Date();
  lastday.setTime(prvday);
  String today1=new SimpleDateFormat("yyyy-MM-dd").format(lastday);
  
	  

%>
  <%
 
  //code to get system date as data2 and yesterdays date as a data1.
 cal = Calendar.getInstance();
      
	//  data1=data2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  
   date = new SimpleDateFormat("yyyy-MM-dd");
   java.util.Date date1 = new java.util.Date();
   SimpleDateFormat sdf;
   sdf = new SimpleDateFormat("yyyy-MM");
  
   
   String start=sdf.format(date1)+"-01";
  // System.out.println("start " + start);
   
  //System.out.println("Today's date is "+date.format(cal.getTime()));
  cdate=date.format(cal.getTime());

  cal.add(Calendar.DATE, -1);
  yesdate=date.format(cal.getTime());
  
  
  /***********changaes 27-aug************/
  
  
  
  
  String ddx=request.getQueryString();
  if(ddx==null)
  {
	  datex1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
  	  data1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  }
  else
  {
	  data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	 
	  datex1=request.getParameter("data");
	
  }
  
  session.setAttribute("data1",data1);
  
  /*********************end ***************************/
  
 
  String user,usertypevalue;
  user=session.getAttribute("user").toString();
  usertypevalue=session.getAttribute("usertypevalue").toString();
  dateformat = session.getAttribute("dateformat").toString();
  %>
  <table border="0" width="100%" align="center">
<tr><td><!-- <font color="block" size="3" >Report No: 5.5</font>-->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font size="3"><B> Daily Status Report </B></font>
</td>
<!-- DATE       -->
<td align="left">
<form action="" method="get">
<b>From </b>&nbsp;&nbsp;
<input type="text" id="data" name="data" value="" size="15" readonly/>
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


<td><div class="bodyText" align="left">
<a href="#" onclick="javascript:window.open('printdailystatusreport.jsp');" title="Print Last 24 Hours Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_dailystatus.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %></div>
</td>
</tr>
<tr></tr>

<tr><td width=40%>
  <table border="1" width=100% align="center" class="stats">
  <tr><td colspan="5" align="center">

<font size="3"><b> </b></font>
</td></tr>

<tr>
<th colspan=4><font size="3"><B>  <%=usertypevalue%>  </B></font></th></tr>
<tr>
<th colspan=4 align="center">Today</th>
</tr>

<tr>
<th>Run</th>
<th>Veh</th>
<th>Run Kmh</th>
<th>Avg. Kmh</th>

</tr>

		 	

<%
/******************************************/
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
String showdate = formatter.format(ShowDate);
System.out.print(showdate);



/*********************************************/

String dd=request.getQueryString();
 if(!(showdate.equals(today1)))
{
	
	 today1=showdate;
	System.out.println("---------->"+today1);

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
	int vcode2;
	String vregno,sql7;
	int tottransvehcnt=0;
	
	/**************run km >250***************************/
	String sqlvehcnt="SELECT count(VehicleCode) as count FROM db_gps.`t_vehicledetails` where ownername = '"+usertypevalue+"' and status in ('-','Removed')";
	ResultSet rstcnt=st1.executeQuery(sqlvehcnt);
	if(rstcnt.next())
	{
		tottransvehcnt=rstcnt.getInt("count");
	}
	
	sql1="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance >= 250 and TheDate ='"+today1+"'";//'2010-08-22';// and TheDate >='"+data1+"'";
		//"select count(*) as vehcount,sum(Distance) as Distance,avg(Distance) as avg from "+tbname+" where  VehCode='"+aa+"'and Distance>250 and TheDate ='2007-02-20'";// and TheDate >='"+data1+"'";
    //Runkm>250
    //System.out.println(sql1);
     System.out.println("1------>"+sql1);
	 rst1=st2.executeQuery(sql1);
	if(rst1.next())
	 {
		grt250=rst1.getInt("vehcount");
			
		 dist=rst1.getInt("Distance");
	//	 System.out.println("dist"+dist);
		
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
	
	/**************** vechicle offline*******************/
	//sql1="select count(*) as vehcount from t_vehall_ds where  VehCode in "+ss+" and Location like 'NO DATA' and  TheDate ='2010-08-22'";// and TheDate >='"+data1+"'
	//select count(*) as count from "+tbname+" where Location='NO DATA'and TheDate <='"+yesdate+"' ";// and  TheDate <='"+data2+"' and TheDate >='"+data1+"'";
	//System.out.println("Offline-------------->"+sql1);
	// rst3=st6.executeQuery(sql1);
	//if(rst3.next())
	//{
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
	 </tr>
	 <%

	//}
	
	totalveh=tottransvehcnt;

	totalrunkm=rst1.getInt("Distance")+rst2.getInt("Distance")+rst6.getInt("Distance");
	
	totalavgkm=rst1.getDouble("AVG")+rst2.getDouble("AVG")+rst6.getDouble("AVG");
//System.out.println("total "+totalveh);
%>
<tr><td><b>Total</b></td>
	<td><b><%=totalveh%></b></td>
	<td><b><%=totalrunkm%></b></td>
	<td><b><%=nf.format(totalavgkm)%></b></td>
	</tr>
	</table></td>
<td width=40%>
<table border="1" width=100% align="center"  class="stats">
  <tr><th colspan="5" align="center">

<font size="3"><b>Top 3 Vehicles Today for<%=usertypevalue%> On  <%=yesdate %></b></font>
</th></tr>
<tr><th>Veh Reg.No.</th> <th>KM</th></tr>
<tr>

	<%
	/******************************  code for top 3 vehicles********************************************/
	
		
	sql5="select distinct(VehCode),Distance from t_vehall_ds where  VehCode in "+ss+" and TheDate ='"+today1+"' order by Distance Desc limit 3";
		//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
	//System.out.println("new     "+sql5);
	 rst5=st7.executeQuery(sql5);
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
	</table></td>
	</tr>
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
        			data.setValue(1, 0,'Run <250 KM and Run> 10 KM');
        			data.setValue(1, 1, <%=less250%>);
        			data.setValue(2, 0,'Idle <10 KM');
        			data.setValue(2, 1, <%=idle%>);
        			data.setValue(3, 0,'Veh Offline');
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
	<tr>
				<td>
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['columnchart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data1 = new google.visualization.DataTable();
        			data1.addColumn('string', 'Task');
        			data1.addColumn('number', 'km');
        			data1.addRows(6);
        			data1.setValue(0, 0, '<%=veh1%>');
        			data1.setValue(0, 1, <%=top1%>);
        			data1.setValue(1, 0, '<%=veh2%>');
        			data1.setValue(1, 1, <%=top2%>);
        			data1.setValue(2, 0, '<%=veh3%>');
        			data1.setValue(2, 1, <%=top3%>);
        		//	data.setValue(3, 0, 'Veh Offline');
        			//data.setValue(3, 1, <%//=offline%>);
       		//	var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
       		//	chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Run Statistics'});



        			var chart1 = new google.visualization.ColumnChart(document.getElementById('chart_div1'));
        	        chart1.draw(data1, {width: 400, height: 240, title: 'Top 3 Vehicle',is3D:true,
        	        	              hAxis: {title: '<---Veh Reg no.--->', titleTextStyle: {color: 'red'}},
        	                        vAxis: {title: '<----KM--->', titleTextStyle: {color: 'red'}}
        	                         });

        	      
      	      }

        	      
        	    	        	      
               	                                    		
      			
    			</script>
				 <div id="chart_div1" order="1"></div>
				</td>				
				</tr>
	
	</table>
	</td>
	</tr>
	<!--Bar chart code end-->
	<tr><td width=40%>
	  <table border="1" width=100% align="center"  class="stats">
	  <tr><td colspan="5" align="center">

	<font size="3"><b> </b></font>
	</td></tr>

	<tr>

	<th colspan=4 align="center">Monthly</th>
	</tr>

	<tr>
	<th>Run</th>

	<th>Veh</th>
	<th>Run Kmh</th>
	<th>Avg. Kmh</th>

	</tr>
	<% /****************Monthly Status code        **************/
	
		/**************run km >250***************************/
		
		sql1="select count(distinct(VehCode)) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance>=250 and TheDate <='"+yesdate+"' and TheDate >='"+start+"'";
			//"select count(*) as vehcount,sum(Distance) as Distance,avg(Distance) as avg from "+tbname+" where  VehCode='"+aa+"'and Distance>250 and TheDate ='2007-02-20'";// and TheDate >='"+data1+"'";
	    //Runkm>250
	   // System.out.println(sql1);
	    // System.out.println("Month1------>"+sql1);
		 rst1=st2.executeQuery(sql1);
		if(rst1.next())
		 {
			grt250=rst1.getInt("vehcount");
				
			 dist=rst1.getInt("Distance");
			 //System.out.println("dist"+dist);
			
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
	<tr>
	<% 
		/**************run km <250***************************/
		sql2="select count(distinct(VehCode)) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance < 250 and  Distance > 10 and TheDate <='"+yesdate+"' and TheDate >='"+start+"'";
		//  System.out.println("Month2--------->"+sql2);
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
	sql3="select count(distinct(VehCode)) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance <= 10 and Location='NO DATA' and TheDate <='"+yesdate+"' and TheDate >='"+start+"'";
	//System.out.println("Month3------------->"+sql3);
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
		
		/**************** vechicle offline*******************/
		sql1="select count(distinct(VehCode)) as vehcount from t_vehall_ds where  VehCode in "+ss+" and Location='NO DATA' and  TheDate <='"+yesdate+"' and TheDate >='"+start+"'";
		//select count(*) as count from "+tbname+" where Location='NO DATA'and TheDate <='"+yesdate+"' ";// and  TheDate <='"+data2+"' and TheDate >='"+data1+"'";
		//System.out.println("Offline-------------->"+sql1);
		 rst3=st6.executeQuery(sql1);
		if(rst3.next())
		{
			offline=rst3.getInt("vehcount");
			//loc+=rst3.getInt("count");
		//System.out.println("Location              "+loc);
		//System.out.println("off "+rst3.getInt("vehcount"));
		%>
		<tr>
		<td>Vehicle Offline</td>
		 <td><%=rst3.getInt("vehcount")%></td>

		 <td>0</td>
		 <td>0</td>
		 <%

		}
		
		totalveh=rst1.getInt("vehcount")+rst2.getInt("vehcount")+rst6.getInt("vehcount")+rst3.getInt("vehcount");

		totalrunkm=rst1.getInt("Distance")+rst2.getInt("Distance")+rst6.getInt("Distance");
		
		totalavgkm=rst1.getDouble("AVG")+rst2.getDouble("AVG")+rst6.getDouble("AVG");
	//System.out.println("total "+totalveh);
	%>
	<tr><td><b>Total</b></td>
		<td><b><%=totalveh%></b></td>
		<td><b><%=totalrunkm%></b></td>
		<td><b><%=nf.format(totalavgkm)%></b></td>
		</tr>
		</table></td>
	<td width=40%>
	<table border="1" width=100% align="center"  class="stats">
	  <tr><th colspan="5" align="center">

	<font size="3"><b>Top 3 Vehicles for <%=usertypevalue%> From  <%=start %> To  <%=yesdate %> </b></font>
	</th></tr>
	<tr><th>Veh Reg.No.</th> <th>KM</th></tr>
	<tr>

		<%
		/******************************  code for top 3 vehicles********************************************/
		
			
		sql5="select distinct(VehCode),Distance from t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+yesdate+"' and TheDate >='"+start+"' order by Distance Desc limit 3";
			//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
		//System.out.println("new     "+sql5);
		 rst5=st7.executeQuery(sql5);
		//System.out.println("Month4--------> "+sql5);
		while(rst5.next())
		{
			
			cnt3++;
			if(cnt3==1)
			{
				top1=rst5.getInt("Distance");
			}
			else if(cnt3==2)
			{
				top2=rst5.getInt("Distance");
			}
			else if(cnt3==3)
			{
				top3=rst5.getInt("Distance");
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
	<tr>
				<td>
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['columnchart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data1 = new google.visualization.DataTable();
        			data1.addColumn('string', 'Task');
        			data1.addColumn('number', 'km');
        			data1.addRows(6);
        			data1.setValue(0, 0, '<%=veh1%>');
        			data1.setValue(0, 1, <%=top1%>);
        			data1.setValue(1, 0, '<%=veh2%>');
        			data1.setValue(1, 1, <%=top2%>);
        			data1.setValue(2, 0, '<%=veh3%>');
        			data1.setValue(2, 1, <%=top3%>);
        		//	data.setValue(3, 0, 'Veh Offline');
        			//data.setValue(3, 1, <%//=offline%>);
        		//	var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        		//	chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Run Statistics'});



        			var chart2 = new google.visualization.ColumnChart(document.getElementById('chart_div2'));
        	        chart2.draw(data1, {width: 400, height: 240, title: 'Top 3 Vehicle',is3D: true,
        	        	              hAxis: {title: '<----Veh Reg no.---->', titleTextStyle: {color: 'red'}},
        	                          vAxis: {title: '<----KM--->', titleTextStyle: {color: 'red'}}
        	                         });
        	     
        	            	            		
      			}

      			
      			      			
    			</script>
				 <div id="chart_div2" order="1"></div>
				</td>				
				</tr>
	
	</table>
	</td>
	</tr>
	<!--Bar chart code end-->
	<tr>
	<td width=50%>
	<table border=1 width=100%  class="stats">
	<tr>
	<th colspan=2>Stoppage duration -Top 5 Veh with Km run > 10 KM </th>
	</tr>
	<tr>
	<th>Veh Reg No.</th>
	<th>Stop Hrs</th>
	</tr>
	<tr>
	<%
	
	/******************************  code for top 5 vehicles********************************************/
	
	
	sql5="select distinct(VehCode),DayStopDurationinHrs from t_vehall_ds where  VehCode in "+ss+" and TheDate ='2010-02-21' order by Distance Desc limit 5";
		//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
	System.out.println("new     "+sql5);
	 rst5=st7.executeQuery(sql5);
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
	//	}
		
		/****************************** end of code for top 3 vehicles********************************************/
		}
	%>
	
	</table>
	</td>
	<!--Bar chart code start-->
	<td>
	<table>
	<tr>
				<td>
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['columnchart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data1 = new google.visualization.DataTable();
        			data1.addColumn('string', 'Task');
        			data1.addColumn('number', 'km');
        			data1.addRows(8);
        			data1.setValue(0, 0, '<%=veh11%>');
        			data1.setValue(0, 1, <%=top11%>);
        			data1.setValue(1, 0, '<%=veh22%>');
        			data1.setValue(1, 1, <%=top22%>);
        			data1.setValue(2, 0, '<%=veh33%>');
        			data1.setValue(2, 1, <%=top33%>);
        			data1.setValue(3, 0, '<%=veh44%>');
        			data1.setValue(3, 1, <%=top44%>);
        			data1.setValue(4, 0, '<%=veh55%>');
        			data1.setValue(4, 1, <%=top55%>);
        			


        			
        		//	data.setValue(3, 0, 'Veh Offline');
        			//data.setValue(3, 1, <%//=offline%>);
        		//	var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        		//	chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Run Statistics'});



        			var chart1 = new google.visualization.ColumnChart(document.getElementById('chart_div4'));
        	        chart1.draw(data1, {width: 400, height: 240, title: 'Top 5 Vehicle',is3D:true,
        	        				  hAxis: {title: '<----Stop Hrs---->', titleTextStyle: {color: 'red'}},
        	        	              vAxis: {title: '<----Veh Reg no.--->', titleTextStyle: {color: 'red'}}
        	                          
        	                         });
        	            		
      			}
    			</script>
				 <div id="chart_div4" order="1"></div>
				</td>				
				</tr>
	
	</table>
	</td>
	
	
	
	
	</tr>
	
	<%	
	
	/***************** Bar chart code Stop Duration hrs**************************/
	
	
	
	
	
	
	
	
	}//end of try
	
	
		 catch(Exception e)
				 {}
		finally
		{
			
		}
		}
%>


</table>
</html>
</jsp:useBean>
        <%@ include file="footernew.jsp" %>

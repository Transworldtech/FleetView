 <%@ include file="headernew.jsp" %> 
 <%@page import="java.sql.Date"%>
 <%@page import="java.awt.*"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.*"%>
<%@page import="java.awt.Desktop"%>
<%@page import="java.net.URI"%>
<%@page import="java.awt.Rectangle"%>
 <%@page import="java.awt.Robot"%>
 <%@page import="java.awt.Toolkit"%>
 <%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Dimension"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
 <html>
<head>
<title>Vehicle Tracking System</title>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<style>
table.mysortable
			{
				text-align: left;
				font-family: Verdana, Geneva, Arial, Helvetica, sans-serif ;
				font-weight: normal;
				font-size: 11px;
				color: #fff;
				background-color: #1581AB; <!-- -->
				border: thin solid;
				border-collapse: collapse;
				border-spacing: 0px;
			}

			table.mysortable td
			{
				background-color: #F8F8FF;
				color: #000;
				padding: 4px;
				border: 1px #808080 solid;
			}
			table.mysortable th
			{
				background-color: #96B2B3;
				color: white;
				padding: 4px;
				border: 1px #808080 solid;
			}

			table.mysortable td.hed
			{
				background-color: #96B2B3;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 

			table.mysortable td.hed1
			{
				background-color: #96B2B3;
				color: #696969;
				padding: 4px;
				border-bottom: 2px #808080 solid;
				font-size: 12px;
				font-weight: bold;
			} 
</style>


<script>
var tableToExcel = (function()
		   {
	        	var uri = 'data:application/vnd.ms-excel;base64,'
    						, template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    						, base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    						, format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
    return function(table, name) 
    {
    if (!table.nodeType) table = document.getElementById(table)
    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML
    }
    window.location.href = uri + base64(format(template, ctx))
  }
})()
</script>
<script type="text/javascript">  

function gotoExcel(elemId, frmFldId)  
{  
	//var printContents = document.getElementById("mypage").innerHTML;
	//var originalContents = document.body.innerHTML;
	//document.body.innerHTML = printContents;
	//alert("yes");
	//<%
	//Dimension screenSize = (10000,768);//Toolkit.getDefaultToolkit().getScreenSize();
	//Rectangle screenRectangle = new Rectangle(1024,768);//screenSize);
	//Robot robot = new Robot();
	//BufferedImage image = robot.createScreenCapture(screenRectangle);
	//ImageIO.write(image, "png", new File("c:\\screenShot.png"));
	//Robot robot = new Robot();
    //BufferedImage screenShot = robot.createScreenCapture(new Rectangle(Toolkit.getDefaultToolkit().getScreenSize()));
    //ImageIO.write(screenShot, "JPG", new File("c:\\screenShot.jpg"));
   //%>
   //document.body.innerHTML = originalContents;
   
	//var input = document.tallydata.getElementsByTagName("a");
    //var count = input.length;
    //for(var i =0; i < count; i++)
    //{
 	//	document.tallydata.getElementsByTagName("a")[i].removeAttribute("href");
    //}
    //var obj = document.getElementById(elemId);  
    //var oFld = document.getElementById(frmFldId);
    //oFld.value = obj.innerHTML;
    //alert(obj.innerHTML);
    //document.dsr.action ="Image.jsp";
    //document.forms["dsr"].submit();
  //    document.body.innerHTML = originalContents;
}

function gotoPrint(divName)  
{  
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;
     document.body.innerHTML = printContents;
     window.print();
     document.body.innerHTML = originalContents;
}


</script>  
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
	  int tottransvehcnt=0,tottransvehcntm=0;
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
      
       String exportFileName=session.getAttribute("user").toString()+"_dsr.jpg";

if (request.getQueryString()==null)
{
%>

<form action="" method="get" >
<div style="float:left; width:100%; border: thin solid; border-color: black;">
	<table>
  		<tr>
  		<td width="200">
  		<font color="block" size="3" >Report No: 10.5</font>
  		</td>
  		<td width="200">
  		<B> Daily Status Report For</B>
  		</td>
  	    <td width="100">
			<input type="text" id="data" name="data" value="<%=to%>" size="15" readonly/>
        	<script type="text/javascript">
  			Calendar.setup(
    		{
      				inputField  : "data",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",     // the date format
      				button      : "data"       // ID of the button
    		}
  			);
			</script>
		</td>
		<td width="200">
		<input type="submit" name="submit" id="submit" value="submit">
		</td>
 		
		</tr>
		</table>
</div>
</form>
<%
}
if (request.getQueryString()!=null)
{
%>
<form name="dsr" action="" method="post" >
<div style="float:left; border: thin solid;width:100%;">
<table style="width:100%">
<tr align="right" >
        <td>
    
        <!-- 
        <a href="#" onclick="javascript:window.open('printdailystatusreport.jsp');" title="Print Daily Status Report Report"><img src="images/print.jpg" width="20px" height="20px"></a>&nbsp; &nbsp;
		<a href="excel_dailystatus.jsp?today1=<%=today1%>"  title="Export to Pdf"><img src="images/acrobat_icon.jpg" width="20px" height="20px"></a>&nbsp;&nbsp;&nbsp;
		 -->
		</td>
		<td>
		
     <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
     <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
  	 <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('mypage');">
	<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img>
	</a>
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('mypage', 'tableHTML');">
	<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	</a> 
</td>
</tr>
</table>
</div>
<div id="mypage" style="margin-left:10%;border: thin solid; width:90% ">
<div id="first" style="border: thin solid; ">
    <div id="leftfirst" style="float:left;width:35%;height:200; border-style: solid inset; border-color: black;border-width: thin;">
	   <table class="mysortable">
  		  <%
  		//<input type="submit" onclick="gotoExcel('mypage', 'tableHTML');" value="Excel" style="background: url('images/excel.jpg') width:15px; height:15px;"/>
  		  java.util.Date ShowDate =new java.util.Date();
    	  Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		  String showdate = formatter.format(ShowDate);
		  System.out.print(showdate);
   		  %>
		 <tr >
		 <th colspan=4 ><B> Daily Status for  <%=usertypevalue%> On Date <%=to %> </B></th>
		 </tr>
       	    <tr >
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
		try
		{
			Class.forName(MM_dbConn_DRIVER); 
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
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
			System.out.println("query "+sql1);
    		rst1=st2.executeQuery(sql1);
			if(rst1.next())
	 		{
				grt250=rst1.getInt("vehcount");
				dist=rst1.getInt("Distance");
		 		System.out.println("dist"+dist);
			%>
	 		<tr >
	 		<td>Run>250 Km</td>
	 		<td align="right"> <%=rst1.getInt("vehcount")%></td>
		    <td align="right"><%=rst1.getInt("Distance")%></td>
	 		<td align="right"><%=nf.format(rst1.getDouble("AVG"))%></td>
			<%
	 		}
			%>
			</tr>
			<% 
			/**************run km <250***************************/
			sql2="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance < 250 and  Distance > 10 and TheDate ='"+today1+"'";//'2010-08-22'";// and TheDate >='"+data1+"'";
	 		// System.out.println("Sql2--------->"+sql2);
	 		rst2=st7.executeQuery(sql2);
			if (rst2.next())
		   {
				less250=rst2.getInt("vehcount");
				dist1=rst2.getInt("Distance");
				%>
				<tr>
				<td>Run<250 Km</td>
				<td align="right"><%=rst2.getInt("vehcount")%></td>
	    	    <td align="right"><%=rst2.getInt("Distance")%></td>
		 		<td align="right"><%=nf.format(rst2.getDouble("AVG"))%></td>
				<%
		 	}
			%>
			</tr>
			<%
			/*************run km <10***************************/
			sql3="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance <= 10 and Location not like '%NO DATA%' and TheDate ='"+today1+"'";//'2010-08-22'";// and TheDate >='"+data1+"'";
			rst6=st4.executeQuery(sql3);
			if (rst6.next())
			{
					idle=rst6.getInt("vehcount"); 
					dist2=rst6.getInt("Distance");
					 %>
		 			<tr>
		 			<td>Idle</td>
		 			<td align="right"><%=rst6.getInt("vehcount")%></td>
	   		    	<td align="right"><%=rst6.getInt("Distance")%></td>
		        	<td align="right"><%=nf.format(rst6.getDouble("AVG"))%></td>
				<%
	         }
				%>
				</tr>
				<%
	
				/**************** vechicle offline*****************/
				offline=tottransvehcnt-(idle+less250+grt250);
				%>
				<tr>
				<td>Vehicle Offline</td>
	 			<td align="right"><%=offline%></td>
		    	<td align="right">0</td>
	 			<td align="right">0</td></tr>
	 			<%
				totalveh=tottransvehcnt;
				totalrunkm=rst1.getInt("Distance")+rst2.getInt("Distance")+rst6.getInt("Distance");
				totalavgkm=totalrunkm/totalveh;
				%>
				<tr><td><b>Total</b></td>
				<td align="right"><b><%=totalveh%></b></td>
				<td align="right"><b><%=totalrunkm%></b></td>
				<td align="right"> <b><%=nf.format(totalavgkm)%></b></td>
				</tr>
				 </table>
				 </div>
	
			<div id="rightfirst" style="float:left;width:45%; height:200;border-style: solid inset; border-color: black;border-width: thin;">
				 <table>
					<tr>
					<td>
					<div id="chart_div"></div>
					<script type="text/javascript">
		   	  			// Load the Visualization API and the piechart package.
      					google.load('visualization', '1', {'packages':['piechart']});
            			// Set a callback to run when the API is loaded.
      					google.setOnLoadCallback(drawChart);
      		      		// Callback that creates and populates a data table, 
      					// instantiates the pie chart, passes in the data and
      					// draws it.
      					
      					function drawChart()
      					{
          					
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
        					chart.draw(data, {width: 350, height: 160, is3D: true, title: 'Run Statistics'});
         			    }
    				</script>
				 	</td>				
					</tr>
			</table>
			</div>
		<%
		}
		catch(Exception e)
		{
			out.print("Exception --->"+e);
		}
		finally
		{
			//conn.close();
		}
		 %>
</div>

<!--Bar chart code start-->
<div id="second">
    <div id="leftsecond" style="float:left;width:35%;height:200;border-style: solid inset; border-color: black;border-width: thin;">	
    <table class="mysortable">
    <tr>
    <th colspan="2">
    <b>Top 3 Vehicles Today for <%=usertypevalue%> On  <%=to %></b>
    </th>
    </tr>
    <tr>
    <th>Veh Reg.No.</th>
    <th>KM</th>
    </tr>
    
 	<%	
	sql5="select distinct(VehCode),Distance from t_vehall_ds where  VehCode in "+ss+" and TheDate ='"+today1+"' order by Distance Desc limit 3";
	rst5=st11.executeQuery(sql5);
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
		
		String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
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
			<tr>
			<td>
			<%=rveh.getString("VehicleRegNumber")%>
			</td>
			<%
		}
		%>
	    <td align="right"><%=rst5.getDouble("Distance")%></td>
		</tr>
		<%
	}
	%>
	</table>
	</div>
    <div id="rightthird" style="float:left;width:45%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
	<table >
	<tr>
	<td valign="top" colspan="2">
	<SCRIPT LANGUAGE="JavaScript">
	if (parseInt(navigator.appVersion) >= 3)
	{
		var q = new Graph(150,100);
		q.scale = 1;
		q.title ="Top 3 Vehicle KM Rating daily";
		q.yLabel = "KM";
		//q.xLabel = "<%=showdate%>";
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
		q.build();
	}
	else
	{
	  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
	}
	</SCRIPT>
	</td>
	</tr>
	</table>
	</div>
</div>

<% /****************Monthly Status code        **************/ %>

<div id="third">
   <div id="leftthird" style="float:left;width:35%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
		<table class="mysortable">
	    <tr>
   		<th colspan=4 align="center">Monthly Status Report For <%=usertypevalue %> From  <%=from %> To  <%=to %> </th>
		</tr>
		<tr>
		<th>Run</th>
		<th>Veh</th>
		<th>Run Kmh</th>
		<th>Avg. Kmh</th>
		</tr>
        <% 
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
		rst3=st8.executeQuery(sql);
	  	while(rst3.next())
	   	{
		   dist250=rst3.getInt("veh");
		   add=rst3.getInt("Dist");
		   avgg=rst3.getDouble("avg");
	   	}	
		%>
		<tr>
		<td>Run>250 Km</td>
		<td align="right"><%=dist250%></td>
        <td align="right"><%=add%></td>
		<td align="right"><%=nf.format(avgg)%></td>
    	</tr>
    	<tr>
		<% 
		/**************run km <250***************************/
		sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms < 250 and avgKms > 10";
		ResultSet rstt3=st8.executeQuery(sql);
	    while(rstt3.next())
	    {
		   lessd250=rstt3.getInt("veh");
		   add1=rstt3.getInt("Dist");
		   avgl=rstt3.getDouble("avg");
	    }
		%>
		<td>Run<250 Km</td>
		<td align="right"><%=lessd250%></td>
    	<td align="right"><%=add1%></td>
		<td align="right"><%=nf.format(avgl)%></td>
		</tr>
		<%
		
		/*************run km <10***************************/
		sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms < 10";
	    ResultSet rsttt3=st8.executeQuery(sql);
	    while(rsttt3.next())
	    {
		   idled250=rsttt3.getInt("veh");
		   add2=rsttt3.getInt("Dist");
		   avgi=rsttt3.getDouble("avg");
	     }
		 %>
		 <tr>
		 <td>Idle</td>
		 <td align="right"><%=idled250%></td>
		 <td align="right"><%=add2%></td>
		 <td align="right"><%=nf.format(avgi)%></td>
    	 </tr>
		 <%
		 offline=tottransvehcnt-(idled250+lessd250+dist250);
	  	 %>
		<tr>
		<td>Vehicle Offline</td>
		<td align="right"><%=offline%></td>
		<td align="right">0</td>
		<td align="right">0</td>
		</tr>
		 <%
		totalveh1=tottransvehcnt;
		totalrunkm=add+add1+add2;
		totalavgkm=totalrunkm/totalveh1;
    	%>
	    <tr><td><b>Total</b></td>
		<td align="right"><b><%=totalveh1%></b></td>
		<td align="right"><b><%=totalrunkm%></b></td>
		<td align="right"><b><%=nf.format(totalavgkm)%></b></td>
		</tr>
		</table>
	</div>
	<div id="rightthird" style="float:left;width:45%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
	<script type="text/javascript">
			google.load('visualization', '1', {'packages':['piechart']});
        	google.setOnLoadCallback(drawChart);
      	    function drawChart()
      	    {
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
        			chart.draw(data, {width: 350, height: 180, is3D: true, title: 'Run Statistics'});
      		}
    	</script>
		<div id="chart_div3" ></div>
	</div>
</div>
<div id="fourth">
	<div id="leftfourth" style="float:left;width:35%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
		<table class="mysortable">
		<tr><th colspan="5" align="center">
		<b>Top 3 Vehicles for <%=usertypevalue%> From  <%=from %> To  <%=to %> </b>
		</th></tr>
		<tr><th>Veh Reg.No.</th> <th>KM</th></tr>
		<tr>
		<%
		sql5="select distinct(VehCode),sum(Distance) as SUM from t_vehall_ds where  VehCode in  "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"'group by vehcode order by sum(distance) desc limit 3";
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
			String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
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
			<td align="right"><%=rst5.getDouble("SUM")%></td>
			</tr>
			<%
		}
		%>
		</table>
	    
</div>
<div id="rightfourth" style="float:left;width:45%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
	<table >
		<tr><td valign="top" colspan="2">
		<SCRIPT LANGUAGE="JavaScript">
		if(parseInt(navigator.appVersion) >= 3) 
		{
			var q = new Graph(150,100);
			q.scale = 1;
			q.title = "Top 3 Vehicle KM Rating Monthly";
			q.yLabel = "KM";
			//q.xLabel = "<%=showdate%>";
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
			q.build();
		} 
		else
		{
	  		document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
		}
	</SCRIPT>
	</td>
	</tr>
	</table>
</div>
</div>

	<%/******************************  code for top 5 vehicles********************************************/%>
	
<div id="fifth">
		<div id="leftfifth" style="float:left;width:35%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
		<table class="mysortable" >
		<tr>
		<th colspan=2>Stoppage duration -Top 5 Veh with Km run > 10 KM  on Date <%=to %></th>
		</tr>
		<tr>
		<th>Veh Reg No.</th>
		<th>Stop Hrs</th>
		</tr>
		<tr>
		<%
		sql5="select distinct(VehCode),DayStopDurationinHrs from t_vehall_ds where  VehCode in "+ss+" and distance>10 and TheDate ='"+today1+"' order by DayStopDurationinHrs Desc limit 5";
		System.out.println("new     "+sql5);
	 	rst5=st10.executeQuery(sql5);
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
			String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
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
			<td align="right"><%=rst5.getDouble("DayStopDurationinHrs")%></td>
			</tr>
			<%
		}
		%>
	
	</table>
	</div>
	
	<!--Bar chart code start-->
	
	<div id="rightfifth" style="float:left;width:45%;height:200;border-style: solid inset; border-color: black;border-width: thin;">
	<table >
	<tr><td valign="top" colspan="2">
	<SCRIPT LANGUAGE="JavaScript">
		if (parseInt(navigator.appVersion) >= 5)
    	{
			var q = new Graph(150,100);
			q.scale = 1;
			q.title = "Top 5 Vehicle Stop Hrs Rating";
			q.yLabel = "Stop Hrs";
			//q.xLabel = "<%=showdate%>";
			q.setXScale("",1);
			<%
			String osp1,rax1,rdx1,rattt1,ratt11;
			osp1=""+top11;
			rax1=""+top22;
			rdx1=""+top33;
			rattt1=""+top44;
			ratt11=""+top55;
			%>
			q.setLegend('<%=veh11%>','<%=veh22%>','<%=veh33%>','<%=veh44%>','<%=veh55%>');
			q.addRow(<%=top11%>);
			q.addRow(<%=top22%>);
			q.addRow(<%=top33%>);
			q.addRow(<%=top44%>);
			q.addRow(<%=top55%>);
			q.build();
		}
		else
	  	{
			  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
		}
	
	</SCRIPT>
	</table>
	</div>
</div>

<div id="sixth">
	 <div id="leftsixth" style="float:left;width:80%;border-style: solid inset; border-color: black;border-width: thin;">
	 <table class="mysortable" style="align:center;">
	 <tr>
	<th colspan=2>OFFLLINE VEHICLES</th>
	</tr>
	<tr>
	<th>Sr. No</th>
	<th width="400">VehReg Number</th>
	</tr>
	<%
	 int  vcoden=0,cnttt=0;
	String vrgno1="";
	sql1="select vehcode from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and (location like '%No Data%' or location like '%NO Data%' or location like '%No DATA%' or location like '%NO DATA%') and TheDate ='"+today1+"' UNION select VehicleCode from db_gps.t_vehicledetails where VehicleCode in "+ss+" and status in ('Removed','Missing')";
	System.out.println("Offline-------------->"+sql1);
	rst3=st6.executeQuery(sql1);
	while(rst3.next())
	{
		vcoden=rst3.getInt("vehcode");
		String sql8="select distinct(VehicleRegNumber) from db_gps.t_vehicledetails where VehicleCode='"+rst3.getInt("VehCode")+"'";
		ResultSet rveh=st1.executeQuery(sql8);
		while(rveh.next())
		{
			cnttt++;
			vrgno1=rveh.getString("VehicleRegNumber");
			%>
			<tr>
			<td align="right"><%=cnttt %></td>
			<td><%=vrgno1 %></td>
			</tr>
			<%
		}
		System.out.println("vrgno"+vrgno1);
	}
	%>
    </table>
	</div>
</div>
</div>

 </form>
 <%
 }
%>
 </html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>

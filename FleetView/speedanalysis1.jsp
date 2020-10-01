<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<head>
<title>Vehicle Tracking System</title>
  <script type="text/javascript" src="http://www.google.com/jsapi"></script>
</head>
<body bgcolor="lightyellow">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
			<!-- header file -->
			<%@ include file="headernew.jsp" %> 
			<!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<%!
			Connection conn,conn1;
			Statement stmt,stmt1,st2,st3,st4;
			String sql,sql1,vehicle,date1,date2;
			//int cnt1=0,cnt2=0,cnt3=0,cnt4=0,cnt5=0,cnt6=0,cnt7=0,cnt8=0,cnt9=0,cnt10=0,cnt11=0,cnt12=0;
			//int cnt13=0,cnt14=0,cnt15=0,cnt16=0,cnt17=0,cnt18=0,cnt19=0,cnt20=0,cnt21=0,cnt22=0,cnt23=0,cnt24=0;
			 %>
			<%
			try{
				Class.forName("org.gjt.mm.mysql.Driver"); 
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				stmt=conn.createStatement();
				stmt1=conn.createStatement();
				st2=conn.createStatement();
				st3=conn.createStatement();
				ResultSet rst=null,rst1=null;
				
									
			%>
			
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
			
			
			</table>
			<%
			
			
			String date1, date2,date3,vehcode,vehregno,time1,time2,h1,chdate,t1,t2,stoptime="-",runtime="-";
			int dist=0,dist1,dist2;
			String runtime1="-",runtime2="-",runtime3="-",runtime4="-",runtime5="-",runtime6="-",runtime7="-";
			String runtime8="-",runtime9="-",runtime10="-",runtime11="-",runtime12="-",runtime13="-",runtime14="-";
			String runtime15="-",runtime16="-",runtime17="-",runtime18="-",runtime19="-",runtime20="-",runtime21="-";
			String runtime22="-",runtime23="-",runtime24="-";
			int maxspeed;
			double avgspeed=0.0;
			String startplace,endplace;
			int distc;
			int[] cnt=new int[24]; 
			String lat1,lon1,lat2,lon2;
			for(int i=00;i<24;i++)
			{
			cnt[i]=0;
			sql="select * from t_veh3190 where TheFieldDataDate='2010-03-21' and TheFieldDataTime >='"+i+":00:00' and TheFieldDataTime <='"+i+":59:59' and TheFiledTextFileName='SI' order by TheFieldDataTime ";
			System.out.println(sql);
			rst=stmt.executeQuery(sql);
			while(rst.next())
			{
			dist1=rst.getInt("Distance");
			startplace=rst.getString("TheFieldSubject");
			lat1=rst.getString("LatinDec");
			lon1=rst.getString("LonginDec");
			rst.last();
			dist2=rst.getInt("Distance");
			endplace=rst.getString("TheFieldSubject");
			lat2=rst.getString("LatinDec");
			lon2=rst.getString("LonginDec");
			//out.print("<br>"+dist1+"  "+dist2);
			dist=dist2-dist1;
			if(dist <=0)
			{
				maxspeed=0;
				avgspeed=0;
				runtime="00 Hrs. 00";
				stoptime="01 Hrs. 00";
			}
			else
			{
				sql="select avg(Speed), max(Speed) from t_veh3190 where TheFieldDataDate='2010-03-21' and TheFieldDataTime >='10:00:00' and TheFieldDataTime <='10:59:59' and TheFiledTextFileName='SI' and Speed >0 order by TheFieldDataTime ";
				 rst1=stmt1.executeQuery(sql);
				if(rst1.next())
				{
					avgspeed=rst1.getDouble("avg(Speed)");
					maxspeed=rst1.getInt("max(Speed)");

				}
				double tt=(dist/avgspeed)*60;
				int thett=(int)tt;
				int thett1=60-thett;
				if(thett==60)
				{
					runtime="01 Hrs.00";
				}
				else
				{
					runtime="00 Hrs."+thett;
					cnt[i]=thett;
				}
				//runtime=runtime.substring(0,9);
				if(thett1==60)
				{
					stoptime="01 Hrs.00";
				}
				else
				{
					stoptime="00 Hrs."+thett1;
				}
				//stoptime=stoptime.substring(0,9);
			}
		}
			
			//cnt[i]= runtime;
			//,cnt2=0,cnt3=0,cnt4=0,cnt5=0,cnt6=0,cnt7=0,cnt8=0,cnt9=0,cnt10=0,cnt11=0,cnt12=0;
			int cnt13=0,cnt14=0,cnt15=0,cnt16=0,cnt17=0,cnt18=0,cnt19=0,cnt20=0,cnt21=0,cnt22=0,cnt23=0,cnt24=0;
			
			
			System.out.println("runtime---->"+i+"-->"+runtime);
			System.out.println("runtime---->"+i+"-->"+cnt[i]);
			System.out.println("stoptime---->"+i+"-->"+stoptime);
			System.out.println("Dist--->"+i+"-->"+dist);
			System.out.println("Done");
			
			}		
				
		
			%>
			<table>
			<tr class="sortbottom">
				<td colspan="8" align="left">
		
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
	data.addRows(24);
	data.setValue(0, 0, '00:00:00Hrs To 00:59:59Hrs DriveTime:-'+<%=cnt[0]%>+'mins');
	data.setValue(0, 1, <%=cnt[0]%>);
	data.setValue(1, 0, '01:00:00Hrs To 01:59:59Hrs DriveTime:-'+<%=cnt[1]%>+'mins');
	data.setValue(1, 1, <%=cnt[1]%>);
	data.setValue(2, 0, '02:00:00Hrs To 02:59:59Hrs DriveTime:-'+<%=cnt[2]%>+'mins');
	data.setValue(2, 1, <%=cnt[2]%>);
	data.setValue(3, 0, '03:00:00Hrs To 03:59:59Hrs DriveTime:-'+<%=cnt[3]%>+'mins');
	data.setValue(3, 1, <%=cnt[3]%>);
	data.setValue(4, 0, '04:00:00Hrs To 04:59:59Hrs DriveTime:-'+<%=cnt[4]%>+'mins');
	data.setValue(4, 1, <%=cnt[4]%>);
	data.setValue(5, 0, '05:00:00Hrs To 05:59:59Hrs DriveTime:-'+<%=cnt[5]%>+'mins');
	data.setValue(5, 1, <%=cnt[5]%>);
	data.setValue(6, 0, '06:00:00Hrs To 06:59:59Hrs DriveTime:-'+<%=cnt[6]%>+'mins');
	data.setValue(6, 1, <%=cnt[6]%>);
	data.setValue(7, 0, '07:00:00Hrs To 07:59:59Hrs DriveTime:-'+<%=cnt[7]%>+'mins');
	data.setValue(7, 1, <%=cnt[7]%>);
	data.setValue(8, 0, '08:00:00Hrs To 08:59:59Hrs DriveTime:-'+<%=cnt[8]%>+'mins');
	data.setValue(8, 1, <%=cnt[8]%>);
	data.setValue(9, 0, '09:00:00Hrs To 09:59:59Hrs DriveTime:-'+<%=cnt[9]%>+'mins');
	data.setValue(9, 1, <%=cnt[9]%>);
	data.setValue(10, 0, '10:00:00Hrs To 10:59:59Hrs DriveTime:-'+<%=cnt[10]%>+'mins');
	data.setValue(10, 1, <%=cnt[10]%>);
	data.setValue(11, 0, '11:00:00Hrs To 11:59:59Hrs DriveTime:-'+<%=cnt[11]%>+'mins');
	data.setValue(11, 1, <%=cnt[11]%>);
	data.setValue(12, 0, '12:00:00Hrs To 12:59:59Hrs DriveTime:-'+<%=cnt[12]%>+'mins');
	data.setValue(12, 1, <%=cnt[12]%>);
	data.setValue(13, 0, '13:00:00Hrs To 13:59:59Hrs DriveTime:-'+<%=cnt[13]%>+'mins');
	data.setValue(13, 1, <%=cnt[13]%>);
	data.setValue(14, 0, '14:00:00Hrs To 14:59:59Hrs DriveTime:-'+<%=cnt[14]%>+'mins');
	data.setValue(14, 1, <%=cnt[14]%>);
	data.setValue(15, 0, '15:00:00Hrs To 15:59:59Hrs DriveTime:-'+<%=cnt[15]%>+'mins');
	data.setValue(15, 1, <%=cnt[15]%>);
	data.setValue(16, 0, '16:00:00Hrs To 16:59:59Hrs DriveTime:-'+<%=cnt[16]%>+'mins');
	data.setValue(16, 1, <%=cnt[16]%>);
	data.setValue(17, 0, '17:00:00Hrs To 17:59:59Hrs DriveTime:-'+<%=cnt[17]%>+'mins');
	data.setValue(17, 1, <%=cnt[17]%>);
	data.setValue(18, 0, '18:00:00Hrs To 18:59:59Hrs DriveTime:-'+<%=cnt[18]%>+'mins');
	data.setValue(18, 1, <%=cnt[18]%>);
	data.setValue(19, 0, '19:00:00Hrs To 19:59:59Hrs DriveTime:-'+<%=cnt[19]%>+'mins');
	data.setValue(19, 1, <%=cnt[19]%>);
	data.setValue(20, 0, '20:00:00Hrs To 20:59:59Hrs DriveTime:-'+<%=cnt[20]%>+'mins');
	data.setValue(20, 1, <%=cnt[20]%>);
	data.setValue(21, 0, '21:00:00Hrs To 21:59:59Hrs DriveTime:-'+<%=cnt[21]%>+'mins');
	data.setValue(21, 1, <%=cnt[21]%>);
	data.setValue(22, 0, '22:00:00Hrs To 22:59:59Hrs DriveTime:-'+<%=cnt[22]%>+'mins');
	data.setValue(22, 1, <%=cnt[22]%>);
	data.setValue(23, 0, '23:00:00Hrs To 23:59:59Hrs DriveTime:-'+<%=cnt[23]%>+'mins');
	data.setValue(23, 1, <%=cnt[23]%>);
	
	var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	chart.draw(data, {width: 1100, height: 600, is3D: true, title: 'Last 24Hrs Driving Statistics Of The Driver'});
	}
</script>
				 
				

				 <div id="chart_div" order="1"></div>
 
				</td>
								
				</tr>
				<!-- 
				<tr>
				<td>				
<SCRIPT LANGUAGE="JavaScript">

 
function makeBarChart(data, width, height, barcolor) {
    // Provide default values for the optional arguments
    if (!width) width = 500;
    if (!height) height = 350;
    if (!barcolor) barcolor = "blue";
    
    // The width and height arguments specify the overall size of the
    // generated chart. We have to subtract the border and padding
    // sizes from this to get the size of the element we create.
    width -= 24;  // subtract 10px padding and 2px border left and right
    height -= 14; // Subtract 10px top padding and 2px top and bottom border

    // Now create an element to hold the chart.  Note that we make the chart
    // relatively positioned so that can have absolutely positioned children,
    // but it still appears in the normal element flow.
    var chart = document.createElement("DIV");
    chart.style.position = "relative";          // Set relative positioning
    chart.style.width = width + "px";           // Set the chart width
    chart.style.height = height + "px";         // Set the chart height
    chart.style.border = "solid black 2px";     // Give it a border
    chart.style.paddingLeft = "10px";           // Add padding on the left
    chart.style.paddingRight = "10px";          // and on the right
    chart.style.paddingTop = "10px";            // and on the top
    chart.style.paddingBottom = "0px";          // but not on the bottom
    chart.style.backgroundColor = "white";      // Make chart background white

    // Compute the width of each bar
    var barwidth = Math.floor(width/data.length);
    // Find largest number in data[].  Note clever use of Function.apply()
    var maxdata = Math.max.apply(this, data);
    // The scaling factor for the chart: scale*data[i] gives height of a bar
    var scale = height/maxdata;

    // Now loop through the data array and create a bar for each datum
    for(var i = 0; i < data.length; i++) {
        var bar = document.createElement("div"); // Create div for bar
        var barheight = data[i] * scale;         // Compute height of bar
        bar.style.position = "absolute";         // Set bar position and size
        bar.style.left = (barwidth*i+1+10)+"px"; // Add bar border & chart pad
        bar.style.top = height-barheight+10+"px";// Add chart padding
        bar.style.width = (barwidth-2) + "px";   // -2 for the bar border
        bar.style.height = (barheight-1) + "px"; // -1 for the bar top border
        bar.style.border = "solid black 1px";    // Bar border style
        bar.style.backgroundColor = barcolor;    // Bar color
        bar.style.fontSize = "1px";              // IE bug workaround
        chart.appendChild(bar);                  // Add bar to chart
    }

    // Now add the chart we've built to the document body
    document.body.appendChild(chart);

    // Finally, return the chart element so the caller can manipulate it
    return chart;
}

makeBarChart([], 300, 150, "yellow");
</SCRIPT>
</td>
				</tr>
				 -->
			</table>
			<table>
			
			<!-- body part come here -->
				<%
				}catch(Exception e)
				{
					out.print("Exceptions--->"+e);
				}				
				finally
				{
					conn.close();
				}
				%>
	<tr>		
    <td class="fboxlowright">&nbsp;</td>
    </tr>
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
        <%@ include file="footernew.jsp" %>
    </body>
</html>
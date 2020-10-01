<%@ include file="header.jsp" %>
<script language="JavaScript" src="graphs.js"></script>
<script language="JavaScript">
function createGraph() {
  var f = document.f1;
  if(f.graphValues.value != '') {
    var graphBarWidth = isNaN(parseInt(f.graphBarWidth.value)) ? 0 : parseInt(f.graphBarWidth.value);
    var graphBarLength = isNaN(parseFloat(f.graphBarLength.value)) ? 1.0 : parseFloat(f.graphBarLength.value);
    var graphLabelSize = isNaN(parseInt(f.graphLabelSize.value)) ? 0 : parseInt(f.graphLabelSize.value);
    var graphValuesSize = isNaN(parseInt(f.graphValuesSize.value)) ? 0 : parseInt(f.graphValuesSize.value);
    var graphPercSize = isNaN(parseInt(f.graphPercSize.value)) ? 0 : parseInt(f.graphPercSize.value);
    var graphPadding = isNaN(parseInt(f.graphPadding.value)) ? 0 : parseInt(f.graphPadding.value);

    var graph = new BAR_GRAPH(f.graphType.options[f.graphType.selectedIndex].value);
    graph.values = f.graphValues.value;
    graph.labels = f.graphLabels.value;
    graph.showValues = f.graphShowValues.options[f.graphShowValues.selectedIndex].value;
    graph.barWidth = graphBarWidth;
    graph.barLength = graphBarLength;
    graph.labelSize = graphLabelSize;
    graph.absValuesSize = graphValuesSize;
    graph.percValuesSize = graphPercSize;
    graph.graphPadding = graphPadding;
    graph.graphBGColor = f.graphBGColor.value;
    graph.graphBorder = f.graphBorder.value;
    graph.barColors = f.graphBarColor.value;
    graph.barBGColor = f.graphBarBGColor.value;
    graph.barBorder = f.graphBarBorder.value;
    graph.labelColor = f.graphLabelColor.value;
    graph.labelBGColor = f.graphLabelBGColor.value;
    graph.labelBorder = f.graphLabelBorder.value;
    graph.absValuesColor = f.graphValuesColor.value;
    graph.absValuesBGColor = f.graphValuesBGColor.value;
    graph.absValuesBorder = f.graphValuesBorder.value;
    document.getElementById('divGraph').innerHTML = graph.create();

    f.txtCode.value =
      'var graph = new BAR_GRAPH("' + f.graphType.options[f.graphType.selectedIndex].value + '");\n' +
      'graph.values = "' + f.graphValues.value + '";\n' +
      'graph.labels = "' + f.graphLabels.value + '";\n' +
      'graph.showValues = ' + f.graphShowValues.options[f.graphShowValues.selectedIndex].value + ';\n' +
      'graph.barWidth = ' + graphBarWidth + ';\n' +
      'graph.barLength = ' + graphBarLength + ';\n' +
      'graph.labelSize = ' + graphLabelSize + ';\n' +
      'graph.absValuesSize = ' + graphValuesSize + ';\n' +
      'graph.percValuesSize = ' + graphPercSize + ';\n' +
      'graph.graphPadding = ' + graphPadding + ';\n' +
      'graph.graphBGColor = "' + f.graphBGColor.value + '";\n' +
      'graph.graphBorder = "' + f.graphBorder.value + '";\n' +
      'graph.barColors = "' + f.graphBarColor.value + '";\n' +
      'graph.barBGColor = "' + f.graphBarBGColor.value + '";\n' +
      'graph.barBorder = "' + f.graphBarBorder.value + '";\n' +
      'graph.labelColor = "' + f.graphLabelColor.value + '";\n' +
      'graph.labelBGColor = "' + f.graphLabelBGColor.value + '";\n' +
      'graph.labelBorder = "' + f.graphLabelBorder.value + '";\n' +
      'graph.absValuesColor = "' + f.graphValuesColor.value + '";\n' +
      'graph.absValuesBGColor = "' + f.graphValuesBGColor.value + '";\n' +
      'graph.absValuesBorder = "' + f.graphValuesBorder.value + '";\n' +
      'document.write(graph.create());';
  }
  else alert('No values!');
}
</script>


<form name="f1" action="javascript:createGraph()" method="post">
<table border="1" cellspacing="0" cellpadding="2" width="100%">

<tr valign="top" bgcolor="#E0F0FF">
<td align="left">
<%
String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
//String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();
%>
<table border="1" width="100%"><tr><td><table border="0" width="100%" background="images/background1.bmp"><tr><td align="center"><a href="MainformMap2.jsp<%=ll %>">Map</a></td><td align="center"><a href="historypiechart.jsp">Pie Chart</a></td><td align="center"><a href="historybarchart.jsp">Bar Chart</a></td><td align="center"><a href="tempraturereport.jsp">Detail Report</a></td></tr></table></td></tr></table>
  <table border="0" cellspacing="0" cellpadding="1" widht="100%">

<tr>
  <td align="right" class="bodyText" style="font-size: small;">Graph Type:</td>
  <td><select name="graphType" style="width:100px">
  <option value="hBar" selected>horizontal</option>
  <option value="vBar">vertical</option><!--
<option value="fader">fader</option>

<option value="pBar">pBar</option>-->

  </select></td>
  </tr><tr>
  <td align="right" class="bodyText" style="font-size: small;">Show Values:</td>
  <td><select name="graphShowValues" style="width:100px">
  <option value="0">% only</option>
  <option value="1" selected>abs. and %</option>
  <option value="2">abs. only</option>
  <option value="3">none</option>
  </select></td>
  </tr>
<%!
String user;
String vehid;
String fromdate,todate,fff,ttt;

Connection conn, conn1;
Statement st, st1;
long overSpeedDuration, nightDrivingDuration, dayStopDuration, normalRuningDuration, nightStopDuration,dd,nodata;
double datavalues[];
String datanames[];
%>
<%
fff=session.getAttribute("fff").toString();
ttt=session.getAttribute("ttt").toString();
user=session.getAttribute("user").toString();
vehid=session.getAttribute("hvid").toString();
fromdate=session.getAttribute("hdate1").toString();
todate=session.getAttribute("hdate2").toString();
try{

Class.forName(MM_dbConn_DRIVER); 
Connection conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=conn.createStatement();
String sql="select Speed, Distance from t_veh"+vehid+" where TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime >='"+fff+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime<='"+ttt+"' and TheFiledTextFileName='OS'";
ResultSet rst=st.executeQuery(sql);
int overspeedduration=0;
while(rst.next())
{
	//overspeedduration +=(Integer.parseInt(rst.getString("Speed")) *Integer.parseInt( rst.getString("Distance")))/60;
overspeedduration +=Integer.parseInt( rst.getString("Distance"));

 
}
double os=(overspeedduration/(60*60));
overSpeedDuration=Math.abs(Math.round(os));


Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=conn1.createStatement();
String sql1="select Duration, HOUR(Duration) as hours,MINUTE(Duration) as minute, SECOND(Duration) as sec from t_veh"+vehid+"_nd where FromDate>='"+fromdate+"' and FromTime>='"+fff+"' and FromDate<='"+todate+"' and FromTime<='"+ttt+"'";
ResultSet rst1=st1.executeQuery(sql1);
double duration=0.0;

while(rst1.next())
{

	String dur=rst1.getString("Duration");
	//double hours=Double.parseDouble(dur.substring(0,2));

	//double minutes=Double.parseDouble(dur.substring(3,5));
	//double sec=Double.parseDouble(dur.substring(6,8));
	double hours=rst1.getDouble("hours");
	double minutes=rst1.getDouble("minute");
	double sec=rst1.getDouble("sec");
	duration +=((hours*60*60+minutes*60+sec)/60)/60;

}
nightDrivingDuration=Math.abs(Math.round(duration));


String sql2="select Duration, HOUR(Duration) as hours,MINUTE(Duration) as minute, SECOND(Duration) as sec from t_veh"+vehid+"_stsp where FromDate >='"+fromdate+"' and FromTime>='"+fff+"' and FromDate <='"+todate+"' and FromTime<='"+ttt+"'";
ResultSet rst2=st1.executeQuery(sql2);
double duration1=0.0;
while(rst2.next())
{
	String dur1=rst2.getString("Duration");
	//double hours1=Double.parseDouble(dur1.substring(0,2));
	//double minutes1=Double.parseDouble(dur1.substring(4,6));
	//double sec1=Double.parseDouble(dur1.substring(10,12));
	double hours1=rst2.getDouble("hours");
	double minutes1=rst2.getDouble("minute");
	double sec1=rst2.getDouble("sec");
	duration1 +=((hours1*60*60+minutes1*60+sec1)/60)/60;
}
dayStopDuration=Math.abs(Math.round(duration1));
String sql3="select RDuration, HOUR(RDuration) as hours,MINUTE(RDuration) as minute, SECOND(RDuration) as sec from t_veh"+vehid+"_ds where TheDate >='"+fromdate+"'  AND TheDate <='"+todate+"'";
double RunDuration=0;
ResultSet rst3=st1.executeQuery(sql3);
while(rst3.next())
{
	double hours2=rst3.getDouble("hours");
	double minutes2=rst3.getDouble("minute");
	double sec2=rst3.getDouble("sec");
	RunDuration +=((hours2*60*60+minutes2*60+sec2)/60)/60;
	//RunDuration=Integer.parseInt(rst3.getString("RDuration"));
	
}
normalRuningDuration=Math.abs(Math.round(RunDuration));

java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(todate);

dd=( ShowDate1.getTime() - ShowDate.getTime() );


String hrs1=session.getAttribute("stoptime").toString();
String hrs2=session.getAttribute("starttime").toString();

int hours1=Integer.parseInt(hrs1.substring(0,2));
int minute1=Integer.parseInt(hrs1.substring(3,5));
int second1=Integer.parseInt(hrs1.substring(6,8));

int hours2=Integer.parseInt(hrs2.substring(0,2));
int minute2=Integer.parseInt(hrs2.substring(3,5));
int second2=Integer.parseInt(hrs2.substring(6,8));

long timesecond1=(hours1*60*60)+(minute1*60)+second1;
long timesecond2=(hours2*60*60)+(minute2*60)+second2;

long nightstoptime=Math.abs(24-((timesecond1-timesecond2)/60/60));


nightStopDuration=Math.abs(dd/86400000*nightstoptime-Math.round(nightDrivingDuration));


//out.print("Over Speed ="+overSpeedDuration+" Hours<br>Night Driving = "+ nightDrivingDuration+" Hours<br>Day Stop="+ dayStopDuration+" Hours<br>Normal Runing="+ normalRuningDuration+" Hours<br>Normal Night Stop="+ nightStopDuration+"Hours");

long sum1=Math.abs(overSpeedDuration+nightDrivingDuration+dayStopDuration+normalRuningDuration+nightStopDuration);

long totaltime=(dd/86400000*24);
nodata=Math.abs(totaltime-sum1);


dayStopDuration+=nodata;

long sum=Math.abs(overSpeedDuration+nightDrivingDuration+dayStopDuration+normalRuningDuration+nightStopDuration);


//datanames[0] ="Over Speed";
//datanames[1]="Night Driving";
//datanames[2]="Day Stop";
//datanames[3]="Normal Runing";
//datanames[4]="Night Stop";

//datavalues[0]=overSpeedDuration;
//datavalues[1]=nightDrivingDuration;
//datavalues[2]=dayStopDuration;
//datavalues[3]=normalRuningDuration;
//datavalues[4]=nightStopDuration;

}catch(Exception e)
{
	out.print("Exception"+ e);
}
%>


<input type="hidden" name="graphLabels" maxlength="200" style="width:220px" value="Over Speed,Night Driving,Day Stop,Normal Runing,Night Stop">


<input type="hidden" name="graphValues" maxlength="200" style="width:220px" value="<%=overSpeedDuration%>,<%=nightDrivingDuration%>,<%=dayStopDuration%>,<%=normalRuningDuration%>,<%=nightStopDuration%>">

<input type="hidden" name="graphBarWidth" maxlength="3" style="width:30px" value="20"><input type="hidden" name="graphBarLength" maxlength="3" style="width:30px" value="1.0"><input type="hidden" name="graphLabelSize" maxlength="2" style="width:30px" value="12"><input type="hidden" name="graphValuesSize" maxlength="2" style="width:30px" value="12"><input type="hidden" name="graphPercSize" maxlength="2" style="width:30px" value="12"><input type="hidden" name="graphPadding" maxlength="2" style="width:30px" value="10"><tr>
  <td colspan="2" align="left">
  <input type="submit" value="Create Graph" style="width:120px; font-weight:bold"></td>
  </tr></table>
</td>

<input type="hidden" name="graphBGColor" size="14" maxlength="14" value="#ABCDEF"><input type="hidden" name="graphBorder" size="14" maxlength="30" value="1px solid blue"><input type="hidden" name="graphBarColor" size="14" maxlength="14" value="#A0C0F0"><input type="hidden" name="graphBarBGColor" size="14" maxlength="14" value="#E0F0FF"><input type="hidden" name="graphBarBorder" size="14" maxlength="30" value="2px outset white"><input type="hidden" name="graphLabelColor" size="14" maxlength="14" value="#000000"><input type="hidden" name="graphLabelBGColor" size="14" maxlength="14" value="#C0E0FF"><input type="hidden" name="graphLabelBorder" size="14" maxlength="30" value="2px groove white"><input type="hidden" name="graphValuesColor" size="14" maxlength="14" value="#000000"><input type="hidden" name="graphValuesBGColor" size="14" maxlength="14" value="#FFFFFF"><input type="hidden" name="graphValuesBorder" size="14" maxlength="30" value="2px groove white">

<table border="1" cellspacing="0" cellpadding="0" width="100%" bgcolor="white"><tr valign="top">
<td>
<div id="divGraph" style="width:550px height="550px"></div>
</td>
<td><table border="0" width="100%" class="sortable">
<tr><th colspan="2" align="center" style="font-size: medium;" ><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=session.getAttribute("user").toString() %> Logistics  <%=session.getAttribute("hvrno").toString() %>  For the Period :<%=session.getAttribute("HisShowDate").toString() %> to <%=session.getAttribute("HisShowDate1").toString() %></b></center></th></tr>
</table>
<table border="1" width="100%" bgcolor="#F5F5F5"  class="sortable">
<tr><td colspan="2" class="hed" style="font-size: small;"><DIV align="left">Parameters considered for the report</div></td></tr>
<tr><td class="bodyText" style="font-size: small;"><div align="left">1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %></div></td><td class="bodyText" style="font-size: small;"><div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString() %></div></td></tr>
<tr><td class="bodyText" style="font-size: small;"><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString() %></div></td>
<td class="bodyText" style="font-size: small;"><div align="left">4. Continuous Driving :<%=session.getAttribute("cdri").toString() %></div></td></tr>
</table>
<table border="1" class="stats">
<tr><td colspan="2" class="hed" style="font-size: small;">Values In Hours</td></tr>
<tr >
<td class="bodyText" style="font-size: small;"><div align="left">Over Speed :</div></td>
<td class="bodyText" style="font-size: small;"><div align="left"><%=overSpeedDuration+" Hours"%></div></td>
</tr>
<tr>
<td class="bodyText" style="font-size: small;"><div align="left">Night Driving : </div></td>
<td class="bodyText" style="font-size: small;"><div align="left"><%=nightDrivingDuration+" Hours"%></div></td>
</tr>
<tr>
<td class="bodyText" style="font-size: small;"><div align="left">Day Stops : </div></td>
<td class="bodyText" style="font-size: small;"><div align="left"><%=dayStopDuration+" Hours"%></div></td>
</tr>
<tr>
<td class="bodyText" style="font-size: small;"><div align="left">Normal Runing : </div></td>
<td class="bodyText" style="font-size: small;"><div align="left"><%=normalRuningDuration+" Hours"%></div></td>
</tr>
<tr>
<td class="bodyText" style="font-size: small;"><div align="left">Night Stops : </div></td>
<td class="bodyText" style="font-size: small;"><div align="left"><%=nightStopDuration+" Hours"%></div></td>
</tr>

</table>
</td>
</tr></table>
</form>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

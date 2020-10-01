<html>
<body style="font-size: large">

<%@ include file="header.jsp" %>
<%!
String user;
String vehid;
String fromdate,todate,fff,ttt;
Connection conn, conn1;
Statement st, st1;
long overSpeedDuration, nightDrivingDuration, dayStopDuration, normalRuningDuration, nightStopDuration,dd,nodata;
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
String sql="select Speed, Distance from t_veh"+vehid+" where TheFieldDataDate >='"+fromdate+"' and TheFieldDataTime>='"+fff+"' and TheFieldDataDate <='"+todate+"' and TheFieldDataTime <='"+ttt+"' and TheFiledTextFileName='OS'";
ResultSet rst=st.executeQuery(sql);
int overspeedduration=0;

while(rst.next())
{
	//overspeedduration +=Math.abs((Integer.parseInt(rst.getString("Speed")) *Integer.parseInt( rst.getString("Distance")))/60);
overspeedduration +=Integer.parseInt( rst.getString("Distance"));


}
double os=(overspeedduration/(60*60));
overSpeedDuration=Math.abs(Math.round(os));
/**********************************************************/

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

String sql3="select RDuration, HOUR(RDuration) as hours,MINUTE(RDuration) as minute, SECOND(RDuration) as sec from t_veh"+vehid+"_ds where TheDate >='"+fromdate+"' AND TheDate <='"+todate+"'";
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

/*********************************************************/




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


String datanames[] = {"Over Speed","Night Driving","Day Stop","Normal Runing","Night Stop"};

double datavalues[]={overSpeedDuration,nightDrivingDuration,dayStopDuration,normalRuningDuration,nightStopDuration};
double datavalues1[]={overSpeedDuration,nightDrivingDuration,dayStopDuration,normalRuningDuration,nightStopDuration};

for(int i=0; i<datavalues.length; i++){
if(datavalues[i]>0)
{
	datavalues[i]=datavalues[i]/sum*100;
}
}
String aa=datanames[0]+"="+datavalues[0]+"&"+datanames[1]+"="+datavalues[1]+"&"+datanames[2]+"="+datavalues[2]+"&"+datanames[3]+"="+datavalues[3]+"&"+datanames[4]+"="+datavalues[4];
%>

<%
String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
//String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();
%>

<table border="1" width="100%" ><tr><td><table border="0" width="100%" background="images/background1.bmp"><tr><td align="center"><a href="MainformMap2.jsp<%=ll %>">Map</a></td><td align="center"><a href="historypiechart.jsp">Pie Chart</a></td><td align="center"><a href="historybarchart.jsp">Bar Chart</a></td><td align="center"><a href="tempraturereport.jsp">Detail Report</a></td></tr></table>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<input type="hidden" name="aa" id="aa" value="<%=aa+"&size=150" %>">
<SCRIPT LANGUAGE="JavaScript">var GheosPie=document.getElementById("aa").value;</SCRIPT>
<SCRIPT SRC="http://Gheos.net/js/pie.js"></SCRIPT>
</td>
<td valign="top">
<table border="0" width="100%"  class="sortable">
<tr><th colspan="2" align="center"  class="hed" style="font-size: medium;"><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=session.getAttribute("user").toString() %> Logistics <%=session.getAttribute("hvrno").toString()%><br> For the Period :<%=session.getAttribute("HisShowDate").toString() %> to <%=session.getAttribute("HisShowDate1").toString() %></b></center></th></tr>
</table>

<table border="1" width="100%" bgcolor="#F5F5F5"  class="sortable">
<tr><td colspan="2" class="hed" style="font-size: small;"><DIV align="left">Parameters considered for the report</div></td></tr>
<tr><td class="bodyText"  style="font-size: small;"><div align="left">1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %></div></td><td class="bodyText"  style="font-size: small;"><div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString() %></div></td></tr>
<tr><td class="bodyText"  style="font-size: small;"><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString() %></div></td>
<td class="bodyText"  style="font-size: small;"><div align="left">4. Continuous Driving :<%=session.getAttribute("cdri").toString() %></div></td></tr>
</table>

<table border="1" class="stats">
<tr><td colspan="2" class="hed"  style="font-size: small;">Values In Hours</td></tr>
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
<td class="bodyText"><div align="left"><%=dayStopDuration+" Hours"%></div></td>
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
<%
}catch(Exception e)
{
	out.print("Exception"+ e);
}
%>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</td>
</tr>
</table>
</body>
</html>

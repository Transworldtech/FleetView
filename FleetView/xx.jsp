<%@ include file="header.jsp" %>
<%
if(session.getAttribute("vehlistnew").toString().equals("-"))
{
	out.print("<table class='stats'><tr><td class='hed'>Please select the location first.</td></tr></table>");
}
else
{
%>
<table width="100%" border="1" bgcolor="white">
<tr><td>
<!--Main code start -->
<!--BY IRFAN code start -->
<%
Connection conn,conn1;
Statement st,st1,st2,st3,st4,st5,st6,stx,stp;
String sql,vehlist,enddate,location,locationcode,mainuser;
String aa,tbname,sql1,sql2,sql3,transporter,vehregno,sdate,edate,stime,etime,ssdate,eedate,locationlist;
double Lat1,Lon1,Lat2,Lon2;
int oscount, account,dccount,stcount,oo;
long time1,time2,time3,time4,timex;

int startdist,stopdist;

%>
<%
java.util.Date ddd=new java.util.Date();
long dateMillis2 = ddd.getTime();
long dayInMillis2 = 1000 * 60 * 60 *24;
dateMillis2 = dateMillis2 - dayInMillis2;
ddd.setTime(dateMillis2);
Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd");
String data1 = NewFormatter1.format(ddd);

java.util.Date today=new java.util.Date();
Format xxx = new SimpleDateFormat("yyyy-MM-dd");
enddate = xxx.format(today);
vehlist=session.getAttribute("vehlistnew").toString();
location=session.getAttribute("Location").toString();
locationcode=session.getAttribute("LocationCode").toString();
mainuser=session.getAttribute("usertypevalue").toString();
locationlist=session.getAttribute("locationlist").toString();
oo=1;
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
stp=conn.createStatement();
stx=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();
st5=conn.createStatement();
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st6=conn1.createStatement();
%>
<table class="stats">
<tr><th colspan="11"><b>Vehicles available <% if(session.getAttribute("Location").toString().equals("All")){} else{out.print(" at "+session.getAttribute("Location").toString()); }  %> with last 24 hours exception report.</b> <div align="right">Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
<tr><td class="hed">Vehicle Reg. No. </td><td class="hed"> Transporter </td><td class="hed">Updated </td><td class="hed">Waiting Time</td>
<td class="hed">OS</td>
<td class="hed">AC</td>
<td class="hed">DC</td>
<td class="hed">CD</td>
<td class="hed">DT</td>
<td class="hed">Stops</td>
<td class="hed">ND</td>
</tr>
<%
sql="select distinct(SubLocationCode) from t_masterlocation where mainlocationcode='"+locationcode+"'";
ResultSet spl=stp.executeQuery(sql);
while(spl.next())
{
sql="select * from t_warehousedata where WareHouseCode ='"+spl.getString("SubLocationCode")+"' and Owner='"+mainuser+"'";
ResultSet rs=stx.executeQuery(sql);
if(rs.next())
{
	Lat1=rs.getDouble("Latitude");
	Lon1=rs.getDouble("Longitude");
//out.print(Lat1+" "+Lon1+"<br>");
sql="select v.* from t_onlinedata v,t_group g where g.GPname='"+mainuser+"' and v.VehicleCode=g.VehCode and v.TheDate >='"+data1+"' order by v.TheDate desc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	Lat2=rst.getDouble("LatitudePosition");
	Lon2=rst.getDouble("LongitudePosition");
	double theta = Lon1 - Lon2;
	double dist = Math.sin(Lat1* Math.PI / 180.0) * Math.sin(Lat2* Math.PI / 180.0) + Math.cos(Lat1* Math.PI / 180.0) * Math.cos(Lat2* Math.PI / 180.0) * Math.cos(theta* Math.PI / 180.0);
	dist = Math.acos(dist);
	dist = (dist* 180 / Math.PI);
	dist = dist * 60 * 1.1515;
	long dist1 = Math.round(dist * 1.609344);
	if(dist1<= oo)
	{
%>
<tr>
<td class="bodyText"><div align="left">
<a href="last24hoursexception.jsp?date=<%=rst.getString("TheDate")%>&time=<%=rst.getString("TheTime")%>&vehcode=<%=rst.getString("VehicleCode")%>&transporter=<%=rst.getString("Transporter")%>&vehregno=<%=rst.getString("VehicleRegNo")%>"><%=rst.getString("VehicleRegNo")%></a>
</div></td>
<td class="bodyText"><div align="left"><%=rst.getString("Transporter")%></div></td>
<td class="bodyText"><div align="left"></div><%
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(rst.getDate("TheDate"));
out.print(sh1);
%> <%=rst.getString("TheTime")%></td>
<td class="bodyText"><div align="left">
<%
/********start code for waiting time ***********/
sql1="select concat(TheFieldDataDate,TheFieldDataTime) as dt,Distance from t_veh"+rst.getString("VehicleCode")+" where TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
ResultSet rst1=st1.executeQuery(sql1);
if(rst1.next())
{
sql2="select concat(TheFieldDataDate,TheFieldDataTime) as dt,Distance from t_veh"+rst.getString("VehicleCode")+" where TheFiledTextFileName='SI' and "+rst1.getInt("Distance")+"- Distance >=2 order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1";
ResultSet rst2=st2.executeQuery(sql2);
if(rst2.next())
{
java.util.Date NewDate = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rst1.getString("dt"));
long dateMillis = NewDate.getTime();

java.util.Date NewDate1 = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rst2.getString("dt"));
long dateMillis1 = NewDate1.getTime();
//out.print(rst1.getString("dt")+"<br>"+rst2.getString("dt")+"<br>");

long temptime=dateMillis-dateMillis1;
temptime=temptime/1000;
long hours=(temptime /60)/60;
long minutes=((temptime /60)%60);
out.print(hours+" hrs "+minutes+" Min ");


}
}

/********end code for waiting time ***********/
%>
</div></td>
<%
/********start code for OS, AC, DC count time ***********/
edate=rst.getString("TheDate");
etime=rst.getString("TheTime");
stime=etime;
java.util.Date NewDate = new SimpleDateFormat("yyyy-MM-dd").parse(edate);
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format formatter5 = new SimpleDateFormat("yyyy-MM-dd");
sdate = formatter5.format(NewDate);
ssdate=sdate;
eedate=edate;

sdate=sdate+stime;
edate=edate+etime;
sql3="select * from t_veh"+rst.getString("VehicleCode")+" where concat(TheFieldDataDate,TheFieldDataTime) >='"+sdate+"' and concat(TheFieldDataDate,TheFieldDataTime)<='"+edate+"' ";
ResultSet rst3=st3.executeQuery(sql3);
int cn=1,dis=0,d1=0,d2=0;
oscount=0;
account=0;
dccount=0;
stcount=0;
while(rst3.next())
{


String stamp=rst3.getString("TheFiledTextFileName");

if(stamp.equals("OS"))
{
	oscount++;
}

if(stamp.equals("AC"))
{
	if (rst3.getInt("Distance")>5)
	{
	account++;
	
	}

}

if(stamp.equals("DC"))
{
	if (rst3.getInt("Distance")<120)
	{

	dccount++;
	}
}

if(stamp.equals("SI"))
{
	if(cn==1)
	{
		 d1=rst3.getInt("Distance");
		 cn++;
	}
	else
	{
		 d2=rst3.getInt("Distance");
	}
}
dis=d2-d1;
}
%>
<td class="bodyText"><div align="left"></div><%=oscount%></td>
<td class="bodyText"><div align="left"></div><%=account%></td>
<td class="bodyText"><div align="left"></div><%=dccount%></td>
<td class="bodyText"><div align="left"></div>0</td>
<td class="bodyText"><div align="left"></div><%=dis%></td>
<% 
/********End code for OS, AC, DC count time ***********/
%>
<td class="bodyText"><div align="left"></div>
<%
/******************code for stops***************/

sql1="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+rst.getString("VehicleCode")+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,TheFieldDataTime) >='"+sdate+"' and concat(TheFieldDataDate,TheFieldDataTime)<='"+ edate+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
ResultSet rst4= st4.executeQuery(sql1);
stcount=0;
while(rst4.next())
{
sql2="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+rst.getString("VehicleCode")+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,TheFieldDataTime) >='"+sdate+"' and concat(TheFieldDataDate,TheFieldDataTime)<='"+edate+"' and TheFieldDataDate='"+rst4.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst4.getString("time1"))+" and abs(LatinDec - "+rst4.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1"; 
ResultSet rst5= st5.executeQuery(sql2);
if(rst5.next())
{
if(rst5.getDouble("time2")-rst4.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
{
double duration=(Double.parseDouble(rst5.getString("time2"))-Double.parseDouble(rst4.getString("time1")));
int hrs=(int)duration/60;
int min=(int)duration%60;
String html2="ST "+rst4.getString("TheFieldDataDate")+"  "+rst4.getString("TheFieldDataTime")+"<br> "+hrs+"hrs "+min+"min  "+rst4.getString("TheFieldSubject");
stcount++;
}
}
}
out.print(stcount);

/******************code for stops***************/
%>

</td>
<td class="bodyText"><div align="left"></div>
<%
/**************** code for Night Driving ***************/
sql="select * from t_veh"+rst.getString("VehicleCode")+"_nd where concat(FromDate,FromTime) >='"+sdate+"' and concat(FromDate,FromTime)<='"+edate+"' order by concat(FromDate,FromTime) asc";
ResultSet rst6=st6.executeQuery(sql);
if(rst6.next())
{
out.print("Yes");
}
else
{
out.print("No");
}
/***********end of Code for Night Driving ************/

%>
</td>

</tr>

<%
}


}

}//end of while rs
}//end of main while spl
%>
</table>
<%


}catch(Exception e)
{
	out.print("Exception --->"+e);
}
finally
{

}

%>

<!--Main code End -->
</td></tr></table>
<%
}
%>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</body>
</html>

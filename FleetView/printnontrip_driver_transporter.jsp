<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<table border="1" width="90%" bgcolor="white" align="center">

<tr><td>
<!--Main code -->
<%!  
Connection conn,conn1;
Statement st, st1,st2;
String sql,data1,data2,transporter,user,drivercode,showdate,showdate1,drivername,vehcode,vehregno;
int oscount, racount,rdcount, ndcount, stcount,cdcount, dtcount,rhcount,osduration,osduration1,tpcount,tpcount1,tripcount,tripcount1;
int oscount1, racount1,rdcount1, ndcount1, stcount1,cdcount1, dtcount1,rhcount1,transportercount;
double rtcount;
String ss="", vv="",str;
double OverSpeed,Accelaration,Decelaration,Rating,Rating1,Accelaration1,Decelaration1,OverSpeed1;
%>
<%
tripcount1=0;
oscount1=0;
racount1=0;
rdcount1=0;
cdcount1=0;
dtcount1=0;
rhcount1=0;
ndcount1=0;
osduration1=0;
stcount1=0;
Rating1=0;
ss="";
vv="";
transporter=request.getParameter("transporter");
data1=request.getParameter("data1");
data2=request.getParameter("data2");
user=session.getAttribute("user").toString();
try{
Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn1.createStatement();
sql="select distinct(Dcode), VehCode from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and Transporter='"+transporter+"' and JCode ='-'";

ResultSet rst=st.executeQuery(sql);
%>
<table class="stats">
<tr><th colspan="11">Driver wise Exception Report for Non-Castrol trips for <%=transporter%> from date <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>. <div align="right" >Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
<tr>
<tr>
<td class="hed"><div align="center">Driver Name(Code)</div></td>
<td class="hed"><div align="center">Vehicle Reg. No.</div></td>
<td class="hed"><div align="center">OS</div></td>
<td class="hed"><div align="center">RA</div></td>
<td class="hed"><div align="center">RD</div></td>
<td class="hed"><div align="center">CD</div></td>
<td class="hed"><div align="center">TD</div></td>
<td class="hed"><div align="center">Stops</div></td>
<td class="hed"><div align="center">Run Hrs.</div></td>
<td class="hed"><div align="center">ND</div></td>
<td class="hed"><div align="center">Rating</div></td>
</tr>
<%
osduration1=0;
while(rst.next())
{
drivercode=rst.getString("Dcode");
vehcode=rst.getString("VehCode");
sql="select * from t_drivers where DriverId='"+drivercode+"'";
ResultSet rst1=st2.executeQuery(sql);
if(rst1.next())
{
drivername=rst1.getString("DriverName")+" ("+drivercode+") ";

}

sql="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
ResultSet rst2=st2.executeQuery(sql);
if(rst2.next())
{
vehregno=rst2.getString("VehicleRegNumber");
}
/* sql="select count(distinct(JCode)) as tripcount from t_driver_ds where DCode='"+drivercode+"' and TheDate>='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rst3=st1.executeQuery(sql);
if(rst3.next())
{
tripcount=rst3.getInt("tripcount");
tripcount1+=rst3.getInt("tripcount");
}
*/
sql="select count(*) as os, sum(Duration) as osduration from t_driver_overspeed where DCode='"+drivercode+"' and FromDate>='"+data1+"' and FromDate <='"+data2+"' and Jcode = '-' ";
ResultSet rst4=st1.executeQuery(sql);
if(rst4.next())
{
oscount=rst4.getInt("os");
oscount1+=rst4.getInt("os");
osduration=rst4.getInt("osduration");
osduration1+=rst4.getInt("osduration");
}

sql="select count(*) as racount from t_driver_ra where DCode='"+drivercode+"' and TheDate>='"+data1+"' and TheDate <='"+data2+"' and Jcode = '-' ";
ResultSet rst5=st1.executeQuery(sql);
if(rst5.next())
{
racount=rst5.getInt("racount");
racount1+=rst5.getInt("racount");

}

sql="select count(*) as rdcount from t_driver_rd where DCode='"+drivercode+"' and TheDate>='"+data1+"' and TheDate <='"+data2+"' and Jcode = '-' ";
ResultSet rst6=st1.executeQuery(sql);
if(rst6.next())
{
rdcount=rst6.getInt("rdcount");
rdcount1+=rst6.getInt("rdcount");

}

sql="select count(*) as cr from t_driver_cr where DCode='"+drivercode+"' and FromDate>='"+data1+"' and FromDate <='"+data2+"' and Jcode = '-' ";
ResultSet rst7=st1.executeQuery(sql);
if(rst7.next())
{
cdcount=rst7.getInt("cr");
cdcount1+=rst7.getInt("cr");

}

sql="select count(*) as nd from t_driver_nd where DCode='"+drivercode+"' and  FromDate>='"+data1+"' and FromDate <='"+data2+"' and Jcode = '-' ";
ResultSet rst8=st1.executeQuery(sql);
if(rst8.next())
{
ndcount=rst8.getInt("nd");
}



sql="select count(*) as stsp from t_driver_stsp where DCode='"+drivercode+"' and FromDate>='"+data1+"' and FromDate <='"+data2+"' and Jcode = '-' ";
ResultSet rst9=st1.executeQuery(sql);
if(rst9.next())
{
stcount=rst9.getInt("stsp");
stcount1+=rst9.getInt("stsp");

}

sql="select sum(Distance) as dist from t_driver_ds where DCode='"+drivercode+"' and JCode = '-'  and TheDate >='"+data1+"' and TheDate <='"+data2+"'";
ResultSet rst10=st1.executeQuery(sql);

if(rst10.next())
{
dtcount=rst10.getInt("dist");
dtcount1+=rst10.getInt("dist");
}

sql="select sum(HOUR(RDuration)) as hr, sum(MINUTE(RDuration)) as mn from t_driver_ds where DCode='"+drivercode+"' and TheDate>='"+data1+"' and TheDate <='"+data2+"' and JCode = '-'"; 

ResultSet rst11=st1.executeQuery(sql);
if(rst11.next())
{
rhcount=(rst11.getInt("hr")+(rst11.getInt("mn")/60));
rhcount1+=(rst11.getInt("hr")+(rst11.getInt("mn")/60));

}
/*********code to calculate Ratings for Transporter ********/
Accelaration=0;
Decelaration=0;
OverSpeed=0;
if(racount > 0 && dtcount > 0)
{
Accelaration=((double)racount/(double)dtcount)*100;
}
if(rdcount > 0 && dtcount > 0)
{
Decelaration=((double)rdcount/(double)dtcount)*100;
}
if(osduration > 0 && dtcount> 0)
{
OverSpeed =(((double)osduration/10)/(double)dtcount)*100;
}
Rating=Accelaration+Decelaration+OverSpeed;
rtcount+=Rating;

/********* end of code to calculate Ratings for Transporter ********/
%>

<tr>
<td ><div align="left" class="bodyText"><%=drivername%></div></td>
<td><div align="left" class="bodyText"><%=vehregno%></div></td>
<!-- <td><div align="right" class="bodyText"> <%=""+tripcount%> </div></td> -->
<td><div align="right" class="bodyText"><%=""+oscount%></div></td>
<td><div align="right" class="bodyText"><%=""+racount%></div></td>
<td><div align="right" class="bodyText"><%=""+rdcount%></div></td>
<td><div align="right" class="bodyText"><%=""+cdcount%></div></td>
<td><div align="right" class="bodyText"><%=""+dtcount%></div></td>
<td><div align="right" class="bodyText"><%=""+stcount%></div></td>
<td><div align="right" class="bodyText"><%=""+rhcount%></div></td>
<td><div align="right" class="bodyText"><%
if(ndcount >0)
{
out.print("Yes");
ndcount1++;
}
else
{
out.print("No");
}
%></div></td>
<td><div align="right" class="bodyText"><%
String str=""+Rating;
if(str.equals("0.0"))
{
str="0.000";
}
int len=str.length();
if(len > 4)
{
str=str.substring(0,5);
out.print(str);
}
else
{
out.print(str);
}
ss+=drivername+",";
vv+=str+",";
%></div></td>
</tr>


<%

}//end of while.
Accelaration1=0;
Decelaration1=0;
OverSpeed1=0;
Rating1=0;
if(racount1 > 0 && dtcount1 > 0)
{
Accelaration1=((double)racount1/(double)dtcount1)*100;
}
if(rdcount1 > 0 && dtcount1 > 0)
{
Decelaration1=((double)rdcount1/(double)dtcount1)*100;
}
if(osduration1 > 0 && dtcount1> 0)
{
OverSpeed1 =(((double)osduration1/10)/(double)dtcount1)*100;
}
Rating1=Accelaration1+Decelaration1+OverSpeed1;


%>
<tr>
<td class="hed" colspan="2"><div align="right">Total</div></td>
<!-- <td class="hed"><div align="right"><%=tripcount1%></div></td> -->
<td class="hed"><div align="right"><%=oscount1%></div></td>
<td class="hed"><div align="right"><%=racount1%></div></td>
<td class="hed"><div align="right"><%=rdcount1%></div></td>
<td class="hed"><div align="right"><%=cdcount1%></div></td>
<td class="hed"><div align="right"><%=dtcount1%></div></td>
<td class="hed"><div align="right"><%=stcount1%></div></td>
<td class="hed"><div align="right"><%=rhcount1%></div></td>
<td class="hed"><div align="right"><%=ndcount1%></div></td>
<td class="hed"><div align="right"><%
//rtcount=Rating1;
String rt=""+Rating1;
if(rt.length() > 4)
{
rt=rt.substring(0,5);
out.print(rt);
}
else
{
out.print(rt);
}

%></div></td>
</tr>
</table>
<%
ss=ss.substring(0,ss.length()-1);
vv=vv.substring(0,vv.length()-1);
}catch(Exception e)
{
out.print("Exception "+ e);
}
finally
{
conn.close();
conn1.close();
}

%>
<!--Main code -->
</td></tr>
<tr>
<td>
<!--Code for Graph -->

<table border="0" width="100%">
<tr><td valign="top" colspan="2">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var q = new Graph(200,200);
q.scale = 2;
q.title = "Avarage Rating for all Driver";
q.yLabel = "Exceptions";
q.xLabel = "<%=showdate%> to <%=showdate1%>";
q.setXScale("",1);
<%
String osp,rax,rdx,rat;
osp=""+OverSpeed1;
rax=""+Accelaration1;
rdx=""+Decelaration1;
rat=""+Rating1;
if(osp.length() >5)
{
osp=osp.substring(0,5);
}
if(rax.length() >5)
{
rax=rax.substring(0,5);
}
if(rdx.length() >5)
{
rdx=rdx.substring(0,5);
}
if(rat.length() >5)
{
rat=rat.substring(0,5);
}
%>
q.setLegend('Over Speed (<%=osp%>)','Rapid Accelaration (<%=rax%>)','Rapid Decelaration (<%=rdx%>)','Rating (<%=rat%>)');
q.addRow(<%=OverSpeed1%>);
q.addRow(<%=Accelaration1%>);
q.addRow(<%=Decelaration1%>);
q.addRow(<%=Rating1%>);
q.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
}

</SCRIPT>
</td></tr>
<!-- <tr>
<td  valign="top">
<SCRIPT LANGUAGE="JavaScript">

if(parseInt(navigator.appVersion) >= 4) {
var a = new Graph(350,300);
a.scale = 2;
a.title = "Rating Graph";
a.yLabel = "Rating";
a.xLabel = "Drivers";
a.setXScale("",1);
a.setLegend("Rating");
a.addRow(<%=vv%>);
a.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb5.gif\">");
}
</SCRIPT>

</td>
<td  valign="bottom" class="bodyText">
<BLOCKQUOTE>

<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var str="<%=ss%>";
var str1="<%=vv%>"
var vv=str1.split(",");
var ss=str.split(",");
document.writeln("<b>Transporters</b><br>");
for(i=0; i< ss.length; i++)
{
document.writeln(i +">. "+ss[i]+" ("+vv[i]+")<br>");
}
}
</SCRIPT>

</BLOCKQUOTE>
</td>
</tr>
-->
</table>

<!--End code for Graph -->
</td>
</tr>
<tr><td align="center"><input type="button" name="Print" value="Print" class="formElement" onclick="javascript:window.print();"></td></tr>
</table>

<!-- footer start here -->
<table border="1" width="90%" bgcolor="white" align="center">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
    response.addHeader("Content-Disposition", "attachment;filename=\"AVLREPORT.xls\"");
%>
<%@ include file="Connections/conn.jsp" %>
<%! 
int i,cntos,cntac,cntdc,dtcount,mindist,maxdist,cntsi,speed,cntrh,cntcr1,cntcr,cntsp,Dist,Dist1,Dist2;
int cntos1,cntra1,cntrda1,cntcd1,cntdt1,cntst1,cntrh1,cntnd1;
Connection conn;
Statement st,st1,st2;
String data1,data2,fromtime1,fromtime2,totime1,totime2,user,usertypevalue,rfff,rttt,fidDate1;
String sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,aa,tbname,stamp,loc,lat,lon;
%>
<%
cntos1=0;
cntra1=0;
cntrda1=0;
cntcd1=0;
cntst1=0;
cntrh1=0;
cntnd1=0;

data1=session.getAttribute("data1").toString();
data2=session.getAttribute("data2").toString();
rfff=session.getAttribute("rfff").toString();
rttt=session.getAttribute("rttt").toString();


user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();

try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
%>
<table border="0" width="100%">
<tr><td colspan="3" ><b>Exception Analysis Re11port For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period :<%= session.getAttribute("ShowDate").toString() %> <%=session.getAttribute("rfff").toString() %> to <%=session.getAttribute("ShowDate1").toString() %> <%=session.getAttribute("rttt").toString() %></b></td></tr>
</table>
<table border="1" width="100%">
<tr><td colspan="3" >Parameters considered for the report</td></tr>
<tr><td >1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %>
</td><td >2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></td><td >3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></td></tr>
<tr>
<td>4. Night Driving :Beyond <%=session.getAttribute("ndri").toString() %> 
</div>
</td><td>5. Continuous Driving :><%=session.getAttribute("cdri").toString() %></td>
<td>6. Stoppages  :<%=session.getAttribute("stop").toString() %></td></tr>
</table>
<table border="1" width="100%">

<tr ><td><B>Vehicle Reg no.</B></td><td><B>Location at EOD </B></td><td><B>OS</B></td><td ><B>RA</B></td><td><B>RD</B></td><td><B>CD</B></td><td><B>DT</B></td><td><B>No.of Stops</B></td><td ><B>Run Hrs.</B></td><td><B>ND</B></td></tr>

<%
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_veh"+aa;
	if(!aa.equals("0")){
	
	sql="select * from t_vehicledetails where VehicleCode='"+aa+"'";
	
	sql1="select * from "+tbname+" where TheFieldDataDate>='"+data1+"' and TheFieldDataTime>='"+rfff+"' and TheFieldDataDate<='"+data2+"' and TheFieldDataTime<='"+rttt+"'";
ResultSet rst1=st.executeQuery(sql1);
cntos=0;
cntac=0;
cntdc=0;
dtcount=0;
mindist=0;
maxdist=0;
cntsi=0;
speed=0;
cntrh=0;
cntcr1=0;
cntcr=0;
cntsp=0;
Dist=0;
Dist1=0;
Dist2=0;
while(rst1.next())
{
stamp=rst1.getString("TheFiledTextFileName");
if(stamp.equals("SI"))
{
if(dtcount==0)
{
mindist=rst1.getInt("Distance");
dtcount=1;
}
else
	maxdist=rst1.getInt("Distance");
}//end if

if(stamp.equals("OS"))
{
cntos++;
}//end if
if(stamp.equals("AC"))
{
cntac++;
}//end if
if(stamp.equals("DC"))
{
cntdc++;
}//end if
loc=rst1.getString("TheFieldSubject");
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
lat=rst1.getString("LatitudeDir");
lon=rst1.getString("LongitudeDir");
}// end if.
else
{
lat=rst1.getString("LatinDec");
lon=rst1.getString("LonginDec");
}//end else.
if(stamp.equals("SI") && rst1.getInt("Speed") >0)
{
cntsi++;
speed=speed+rst1.getInt("Speed");
}
}//end while rst1.

%>
<tr><td>
<% ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
	String str=rst.getString(2); 
	out.print(str);
	}//enfd if.
%>
</td>
<td>

<%=loc%>
</td>
<td>
<%=cntos%>
<%
cntos1=cntos1+cntos;
%>
</td>
<td>
<%=cntac%>
<%
cntra1=cntra1+cntac;
%>
</td>
<td>
<%=cntdc%>
<%
cntrda1=cntrda1+cntdc;
%>
</td>
<td>
<% 
sql2="select TheFieldDataDate,TheFieldDataTime, Distance from "+tbname+" where TheFieldDataDate>='"+data1+"' and TheFieldDataTime>='"+rfff+"' and TheFieldDataDate<='"+data2+"' and TheFieldDataTime<='"+rttt+"' and TheFiledTextFileName='ST' order by TheFieldDataDate,TheFieldDataTime asc";
ResultSet rst2=st.executeQuery(sql2);

while(rst2.next())
{
sql3="select TheFieldDataDate,TheFieldDataTime ,Distance from "+tbname+" where TheFieldDataDate<='"+rst2.getString("TheFieldDataDate")+"' and TheFieldDataTime<='"+rst2.getString("TheFieldDataTime")+"' and TheFiledTextFileName='SP' order by TheFieldDataDate,TheFieldDataTime asc limit 1";

ResultSet rst3=st1.executeQuery(sql3);
while(rst3.next())
{
int speed1=speed;
int dist=rst3.getInt("Distance")-rst2.getInt("Distance");
if(speed1 >0 && cntsi >0)
{
speed1=speed1/cntsi;
cntcr1=dist/speed1;
if(cntcr1>5)
{
	cntcr++;
}//end if
}//end if

}//end while rst3.
}//end while rst2.
out.print(cntcr);
cntcd1=cntcd1+cntcr;
%>
</td>
<td>
<%=(maxdist-mindist)%>
<%
cntdt1=cntdt1+(maxdist-mindist);
%>
</td>
<td>
<%
sql4="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from "+tbname+" where TheFieldDataDate >='"+data1+"' and TheFieldDataTime >='"+rfff+"' and TheFieldDataDate <='"+data2+"' and TheFieldDataTime <='"+rttt+"' and TheFiledTextFileName='SP' order by TheFieldDataDate,TheFieldDataTime asc";
ResultSet rst4=st.executeQuery(sql4);
while(rst4.next())
{
sql5="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from "+tbname+" where TheFieldDataDate >='"+rst4.getString("TheFieldDataDate")+"' and TheFieldDataTime >='"+rst4.getString("TheFieldDataTime")+"' and TheFieldDataDate <='"+data2+"' and TheFieldDataTime <='"+rttt+"' and TheFiledTextFileName='ST' order by TheFieldDataDate,TheFieldDataTime asc limit 1";
ResultSet rst5=st1.executeQuery(sql5);
if(rst5.next())
{
//out.print(rst5.getInt("time2")-rst5.getInt("time1"));
if((rst5.getInt("time2")-rst4.getInt("time1")) > Integer.parseInt(session.getAttribute("stop11").toString()))
{
	cntsp++;
}

}//end if rst5
}//end while rst4

out.print(cntsp);
cntst1=cntst1+cntsp;
%>
</td>
<td>
<%
if(speed >0 && cntsi >0)
{
speed=speed/cntsi;
cntrh=(maxdist-mindist)/speed;
out.print(cntrh);
cntrh1=cntrh1+cntrh;
}
else
{
out.print("0");
}
%>
</td>
<td>
<%
sql6="select distinct(TheFieldDataDate) from "+tbname+" where TheFieldDataDate >='"+data1+"' and TheFieldDataTime >='"+rfff+"' and TheFieldDataDate <='"+data2+"' and TheFieldDataTime <='"+rttt+"'";
ResultSet rst6=st.executeQuery(sql6);
while(rst6.next())
{
sql7="select MAX(Distance)-MIN(Distance) as Dist1 from "+tbname+" where TheFieldDataDate='"+rst6.getString("TheFieldDataDate")+"' and TheFieldDataTime BETWEEN '"+session.getAttribute("stoptime").toString()+"' and '23:59:59' and TheFieldDataTime >='"+rfff+"' and TheFieldDataTime<='"+rttt+"' and TheFiledTextFileName='SI'";

sql8="select MAX(Distance)-MIN(Distance) as Dist2 from "+tbname+" where TheFieldDataDate='"+rst6.getString("TheFieldDataDate")+"' and TheFieldDataTime BETWEEN '00:00:00' and '"+session.getAttribute("starttime").toString()+"' and TheFieldDataTime >='"+rfff+"' and TheFieldDataTime<='"+rttt+"' and TheFiledTextFileName='SI'";

ResultSet rst7=st1.executeQuery(sql7);
ResultSet rst8=st2.executeQuery(sql8);

if(rst7.next())
{
	Dist1=rst7.getInt("Dist1");
}
if(rst8.next())
{
	Dist2=rst8.getInt("Dist2");
}
Dist=Dist1+Dist2;
}//end while
if(Dist >5)
{
out.print("Yes");
cntnd1=cntnd1+1;
}
else
{
out.print("No");
}
%>
</td>
</tr>
<%
	}//end if.
	}//end while.

%>
<tr ><td colspan="2">Total</td>
<td><%=cntos1 %></td>
<td><%=cntra1 %></td>
<td><%=cntrda1 %></td>
<td><%=cntcd1 %></td>
<td><%=cntdt1 %></td>
<td><%=cntst1 %></td>
<td><%=cntrh1 %></td>
<td><%=cntnd1 %></td>
</tr>

</table>
<%
}//end try
catch(Exception e)
{
out.println("Exception  "+e);

}//catch end.
finally
{

}//finally end.


%>

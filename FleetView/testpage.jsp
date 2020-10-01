<%@ include file="header.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn, conn1;
Statement st0,st, st1, st2,st3,st4;
String user,sql,sql1,sql2,sql3,transporter;
String fidDate, data1, data2,showdate,showdate1,trips;
int oscount, racount,rdcount, ndcount, stcount,cdcount, dtcount,rhcount,osduration,osduration1,tpcount,tpcount1,dcount,dcount1,vcount, vcount1;
int oscount1, racount1,rdcount1, ndcount1, stcount1,cdcount1, dtcount1,rhcount1,transportercount;
double rtcount;
String ss="", vv="";
double OverSpeed,Accelaration,Decelaration,Rating,Rating1,Accelaration1,Decelaration1,OverSpeed1;
%>
<%
ss="";
vv="";
try{
transportercount=0;
tpcount1=0;
oscount1=0;
racount1=0;
rdcount1=0;
ndcount1=0;
stcount1=0;
cdcount1=0;
dtcount1=0;
rhcount1=0;
rtcount=0.0;
osduration1=0;
dcount1=0;
vcount1=0;
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st0=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st4=conn1.createStatement();
	}
	catch(Exception e)
	{
		out.print("Exception "+e);
	}
java.util.Date defoultdate = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
fidDate = formatter.format(defoultdate);
if(!(null==request.getQueryString()))
{
	data1=request.getParameter("data");
	data2=request.getParameter("data1");
}
else
{
	data1=fidDate;
	data2=fidDate;
}
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!--Start of outer table -->
<table class="stats">
<form name="dateform" action="" method="get" onsubmit="validate();">
<tr><td>
<input type="text" id="data" name="data" class="formElement" value="<%=data1%>"  size="15" readonly/>
  </td><td align="left">
<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td>

<input type="text" id="data1" name="data1" class="formElement"  value="<%=data2%>" size="15" readonly/></td><td align="left">
  <input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td>
<td><input type="submit" name="submit" id="submit" value="submit" class="formElement"></td>
</tr>
</form>

<tr><td colspan="5">
<%
String dd=request.getQueryString();
if(dd==null)
{
out.print("<center class='bodyText'><b>Please select the dates to display the report</b></center>");
}
else
{
data1=request.getParameter("data");
data2=request.getParameter("data1");
user=session.getAttribute("usertypevaluemain").toString();

%>
<table class="stats">
<tr><th colspan="13">Exception Report for <%=session.getAttribute("usertypevalue").toString()%> trips for all transporters from date <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>. 
<div align="right">
<a href="#" onclick="javascript:window.open('printtrip_report.jsp?data=<%=data1%>&data1=<%=data2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceltrip_report.jsp?data=<%=data1%>&data1=<%=data2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
out.print(sdt); %>
</div></th></tr>
<tr>
<td class="hed"><div class="bodyText"><b>Customer Name</b></div></td>
<td class="hed"><div class="bodyText"><b>Trips</b></div></td>
<td class="hed"><div class="bodyText"><b>Drivers</b></div></td>
<td class="hed"><div class="bodyText"><b>Vehicle</b></div></td>
<td class="hed"><div class="bodyText"><b>OS</b></div></td>
<td class="hed"><div class="bodyText"><b>RA</b></div></td>
<td class="hed"><div class="bodyText"><b>RD</b></div></td>
<td class="hed"><div class="bodyText"><b>CD</b></div></td>
<td class="hed"><div class="bodyText"><b>DT</b></div></td>
<td class="hed"><div class="bodyText"><b>Stop</b></div></td>
<td class="hed"><div class="bodyText"><b>Run Hrs.</b></div></td>
<td class="hed"><div class="bodyText"><b>ND</b></div></td>
<td class="hed"><div class="bodyText"><b>Rating</b></div></td>
</tr>
<%
try{
sql="select distinct(VehRegNo) from t_group where  VehRegNo not like '% del' and VehRegNo in "+session.getAttribute("ownerlist").toString()+" order by VehRegNo asc";
//out.print(sql);
ResultSet rst=st0.executeQuery(sql);
while(rst.next())
{
	transporter=rst.getString("VehRegNo");
	transportercount++;
		/********** Start code for No of trips by tranporter **************/
		//sql1="select count(distinct(JCode)) as tpcount from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and JCode <>'-' and Transporter='"+transporter+"' and VehCode in "+session.getAttribute("VehList").toString();
	sql1="select count(distinct(TripId)) as tpcount from t_completedjourney where StartDate >='"+data1+"' and StartDate <='"+data2+"' and TripId <>'-' and OwnerName='"+transporter+"'  and Gpname='"+user+"'";
	//sql1="select count(distinct(TripId)) as tpcount from t_completedjourney where StartDate >='"+data1+"' and StartDate <='"+data2+"' and TripId <>'-' and OwnerName='"+transporter+"'";
	ResultSet rst0=st.executeQuery(sql1);
	if(rst0.next())
	{
		tpcount=rst0.getInt("tpcount");
		tpcount1+=rst0.getInt("tpcount");
	}
	/********** End code for No of trips by tranporter **************/
	/******** code start for distinct drivers ****************/

	//sql1="select count(distinct(dCode)) as dcount from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and JCode <>'-' and Transporter='"+transporter+"' and VehCode in "+session.getAttribute("VehList").toString();
	//sql1="select count(distinct(DriverId)) as dcount from t_completedjourney where StartDate >='"+data1+"' and StartDate <='"+data2+"' and TripId <>'-' and OwnerName='"+transporter+"' and gpname='Castrol'";
	sql1="select count(distinct(DriverId)) as dcount from t_completedjourney where StartDate >='"+data1+"' and StartDate <='"+data2+"' and TripId <>'-' and OwnerName='"+transporter+"'";
	ResultSet rst00=st.executeQuery(sql1);
	if(rst00.next())
	{
		dcount=rst00.getInt("dcount");
		dcount1+=rst00.getInt("dcount");}
		/********* code end for Distinct drivers *****************/
		/******** code start for distinct vehicles ****************/
		//sql1="select count(distinct(VehCode)) as vcount from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and JCode <>'-' and Transporter='"+transporter+"' and VehCode in "+session.getAttribute("VehList").toString();
		sql1="select count(distinct(VehId)) as vcount from t_completedjourney where StartDate >='"+data1+"' and StartDate <='"+data2+"' and TripId <>'-' and OwnerName='"+transporter+"' and GpName='Castrol'";
		ResultSet rst000=st.executeQuery(sql1);
		if(rst000.next())
		{
			vcount=rst000.getInt("vcount");
			vcount1+=rst000.getInt("vcount");
		}
		/********* code end for Distinct vehicles *****************/

		sql="select distinct(TripId) as tripid from t_completedjourney where OwnerName='"+transporter+"' and StartDate>='"+data1+"' and StartDate<='"+data2+"' and GPName='Castrol'";
		ResultSet rstrating=st1.executeQuery(sql);
		trips="('99999999999',";
		while(rstrating.next())
		{
			trips=trips+"'"+rstrating.getString("tripid")+"',";
		}	
		trips=trips.substring(0,trips.length()-1);	
		trips=trips+")";
		/******** code for Overspeed ********/
		sql1="select count(*) as os from t_driver_overspeed where jCode in "+trips+" and FromDate>='"+data1+"' and FromDate <='"+data2+"'";
		ResultSet rst1=st2.executeQuery(sql1);
		if(rst1.next())
		{
			oscount=rst1.getInt("os");
			oscount1+=rst1.getInt("os");
		}
		sql1="select sum(Duration) as osduration from t_driver_overspeed where jCode in "+trips+" and FromDate>='"+data1+"' and FromDate <='"+data2+"'";
		ResultSet rstx1=st2.executeQuery(sql1);
		if(rstx1.next())
		{
			osduration=rstx1.getInt("osduration");
			osduration1+=rstx1.getInt("osduration");
		}
		/************* end of overspeed **************/
		/************ code for rapid accelaration ******/
		sql1="select count(*) as ra from t_driver_ra where jCode in "+trips+" and TheDate>='"+data1+"' and theDate <='"+data2+"'";
		ResultSet rst2=st2.executeQuery(sql1);
		if(rst2.next())
		{
			racount=rst2.getInt("ra");
			racount1+=rst2.getInt("ra");
		}
		/************ end code for rapid accelaration ******/
		/************ code for rapid decelaration ******/
		sql1="select count(*) as rd from t_driver_rd where jCode in "+trips+" and TheDate>='"+data1+"' and theDate <='"+data2+"'";
		ResultSet rst3=st2.executeQuery(sql1);	
		if(rst3.next())
		{
			rdcount=rst3.getInt("rd");
			rdcount1+=rst3.getInt("rd");
		}
		/************ end code for rapid decelaration ******/
		/************ code for countinous ranning ******/
		sql1="select count(*) as cr from t_driver_cr where jCode in "+trips+" and FromDate>='"+data1+"' and FromDate <='"+data2+"'";
		ResultSet rst4=st2.executeQuery(sql1);
		if(rst4.next())
		{
			cdcount=rst4.getInt("cr");
			cdcount1+=rst4.getInt("cr");
		}
		/************ end code for countinous ranning ******/
		/************ code for Night Driving ******/
		sql1="select count(*) as nd from t_driver_nd where jCode in "+trips+" and FromDate>='"+data1+"' and FromDate <='"+data2+"'";
		ResultSet rst5=st2.executeQuery(sql1);
		if(rst5.next())
		{
			ndcount=rst5.getInt("nd");
		}
		/************ end code for Night Driving ******/
		/************ code for stop ******/
		sql1="select count(*) as stsp from t_driver_stsp where Transporter='"+transporter+"' and FromDate>='"+data1+"' and FromDate <='"+data2+"' and Jcode <> '-'  and VehCode in "+session.getAttribute("VehList").toString();
		ResultSet rst6=st2.executeQuery(sql1);
		if(rst6.next())
		{
			stcount=rst6.getInt("stsp");
			stcount1+=rst6.getInt("stsp");
		}
		/************ end code for stop ******/
		/******* code for driver rating ******/
		/*******end code for driver rating ******/
		/*********** code for distance tranveled ************/
		//sql1="select sum(Distance) as dist from t_driver_ds where Transporter='"+transporter+"' and JCode <> '-'  and TheDate >='"+data1+"' and TheDate <='"+data2+"' and VehCode in "+session.getAttribute("VehList").toString();
		sql1="select sum(KmTravelled) as dist from t_completedjourney where OwnerName='"+transporter+"' and TripId <> '-'  and StartDate >='"+data1+"' and StartDate <='"+data2+"' and GPname='Castrol'";
		ResultSet rst7=st.executeQuery(sql1);
		if(rst7.next())
		{
			dtcount=rst7.getInt("dist");
			dtcount1+=rst7.getInt("dist");
		}
		/*********** End of code for distance tranveled ************/
		/************ code for run duration ****************/
		sql1="select sum(HOUR(RDuration)) as hr, sum(MINUTE(RDuration)) as mn from t_driver_ds where Transporter='"+transporter+"' and TheDate>='"+data1+"' and TheDate <='"+data2+"' and JCode <> '-'  and VehCode in "+session.getAttribute("VehList").toString();
		ResultSet rst8=st2.executeQuery(sql1);
		if(rst8.next())
		{
			rhcount=(rst8.getInt("hr")+(rst8.getInt("mn")/60));
			rhcount1+=(rst8.getInt("hr")+(rst8.getInt("mn")/60));
		}
		/************ End of code for run duration ****************/
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
<td class="bodyText"><div align="left"><a href="trip_driver_transporter.jsp?data1=<%=data1%>&data2=<%=data2%>&transporter=<%=transporter%>"><%=transporter%></a></div></td>
<td class="bodyText"><div align="right"><%=tpcount%></div></td>
<td class="bodyText"><div align="right"><%=dcount%></div></td>
<td class="bodyText"><div align="right"><%=vcount%></div></td>
<td class="bodyText"><div align="right"><%=oscount%></div></td>
<td class="bodyText"><div align="right"><%=racount%></div></td>
<td class="bodyText"><div align="right"><%=rdcount%></div></td>
<td class="bodyText"><div align="right"><%=cdcount%></div></td>
<td class="bodyText"><div align="right"><%=dtcount%></div></td>
<td class="bodyText"><div align="right"><%=stcount%></div></td>
<td class="bodyText"><div align="right"><%=rhcount%></div></td>
<td class="bodyText"><div align="right"><% if(ndcount >=1){out.print("Yes");
ndcount1++;
 	} else { out.print("No");} %></div></td>
<td class="bodyText"><div align="right">
<%
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
 ss+=transporter+",";
 vv+=str+",";
%>
</div></td>
</tr>

<%

}//end while rst.

Accelaration1=0;
Decelaration1=0;
OverSpeed1=0;

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
<td class="hed"><div class="bodyText" align="right">Total</div></td>
<td class="hed"><div class="bodyText" align="right"><%=tpcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=dcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=vcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=oscount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=racount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=rdcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=cdcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=dtcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=stcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=rhcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%=ndcount1%></div></td>
<td class="hed"><div class="bodyText" align="right"><%
rtcount=Rating1;
String rt=""+rtcount;
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
<%
if(vv.length()>=2)
{
	vv=vv.substring(0,vv.length()-1);
}
else
{
	vv="-";
}
if(ss.length()>=2)
{
	ss=ss.substring(0,ss.length()-1);
}
else
{
	ss="-";
}
%>
<%
}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();
conn1.close();
}
%>
</table>
</td></tr>
</table>
<!--Start Code for the Graph -->
</td></tr>
<tr><td class="bodyText">
<table border="0" width="100%">
<tr><td valign="top" colspan="2">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var q = new Graph(200,200);
q.scale = 1;
q.title = "Average Rating for all transporter";
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
<tr><td  valign="top">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) 
{
	var a = new Graph(250,200);
	a.scale = 2;
	a.title = "Rating Graph";
	a.yLabel = "Rating";
	a.xLabel = "Transporters";
	a.setXScale("",1);
	a.setLegend("Rating");
	a.addRow(<%=vv%>);
	a.build();
}
else
{
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
document.writeln(i +". "+ss[i]+" ("+vv[i]+")<br>");
}
}
</SCRIPT>
</BLOCKQUOTE>
</td>
</tr></table>
<!--End Code for the Graph -->
<!--end of outer table -->
<%
}
%>
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

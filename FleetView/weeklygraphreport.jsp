<%@ include file="headernew.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
String fidDate, data1, data2,showdate,showdate1,trips,user;
int oscount, racount,rdcount, stcount,cdcount, dtcount,rhcount,osduration,osduration1,tpcount,tpcount1,dcount,dcount1,vcount, vcount1;
String ndcount;
int oscount1, racount1,rdcount1, ndcount1, stcount1,cdcount1, dtcount1,rhcount1,transportercount;
double rtcount;
String ss="", vv="";
double OverSpeed,Accelaration,Decelaration,Rating,Rating1,Accelaration1,Decelaration1,OverSpeed1;
int oscountall,oscountall1,oscountall2,oscountall3;
int racountall,racountall1,racountall2,racountall3;
int rdcountall,rdcountall1,rdcountall2,rdcountall3;
int dtcountall,dtcountall1,dtcountall2,dtcountall3;

			Connection conn,conn1;
			Statement st,st1,st2,st3,st4, st5, st6, st7, st8, st9, st10;
			String sql,sql1,vehicle,date1,date2, msg,datenew1,datenew2;
			
			 %>
			<%
			if(null==request.getQueryString())
			{
					vehicle="All";
					datenew2=datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
					msg="Run Analysis Report";
			
			}
			else
			{
					vehicle=request.getParameter("vehicle");
					datenew1=request.getParameter("data");
					datenew2=request.getParameter("data1");
					date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
					date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
			}
			try
			{
				Class.forName("org.gjt.mm.mysql.Driver"); 
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				st=conn.createStatement();
				st1=conn.createStatement();
				st2=conn1.createStatement();
				st3=conn1.createStatement();
				st4=conn1.createStatement();
				st5=conn1.createStatement();
				st6=conn1.createStatement();
				st7=conn1.createStatement();
				st8=conn1.createStatement();
				st9=conn1.createStatement();
				st10=conn1.createStatement();

				int os=0,ra=0,rd=0,dt=0,stops=0,rh=0;
				int os1=0,ra1=0,rd1=0,dt1=0,stops1=0,rh1=0;
				int os2=0,ra2=0,rd2=0,dt2=0,stops2=0,rh2=0;
				int os3=0,ra3=0,rd3=0,dt3=0,stops3=0,rh3=0;
				int kmcountall=0,oscountall=0,racountall=0,rdcountall=0,rhcountall=0,dtcountall=0,stopcountall=0;
				int kmcountall1=0,oscountall1=0,racountall1=0,rdcountall1=0,rhcountall1=0,dtcountall1=0,stopcountall1=0;
				int kmcountall2=0,oscountall2=0,racountall2=0,rdcountall2=0,rhcountall2=0,dtcountall2=0,stopcountall2=0;
				int kmcountall3=0,oscountall3=0,racountall3=0,rdcountall3=0,rhcountall3=0,dtcountall3=0,stopcountall3=0;

				String cd="NO",nd="NO";
				double totkmtrav=0, avgspeedoffleet=0, avgrunspeedoffleet=0;
				
									
			%>
			<table width="100%" align="center" class="sortable">
			<tr><td  class="sorttable_nosort">
			<!-- if date range is not requred please remove this code start from this comment to -->
			
			<script language="javascript">
 			function validate()
  			{
  				if(document.getElementById("data").value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById("data1").value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  				}
  				//return datevalidate();
  				return true;
  		  }
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dy1=date1.substring(0,4);
			dy2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dy1>dy2)
			{
				alert("From date year is should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2) if(dm1>dm2)
			{
				alert("From date month is should not be greater than to date month 5");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dm1==dm2) 
			{
				if(dd1 > dd2)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			return true;
		}

  	</script>
			<table border="0" width="100%">
			<form action="" method="get" onsubmit="return validate();">
			
			<tr bgcolor="#87CEFA">
			<td><b>Vehicle :</b>
			<select name="vehicle" id="vehicle">
			<%
			sql="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleCode";
			ResultSet rst=st.executeQuery(sql);
			//runtotal=0;
			//stoptotal=0;
			//nighttotal=0;
			while(rst.next())
			{
				
				%>
				<option value="<%=rst.getString("VehicleRegNumber")%>" <% if(vehicle.equals(rst.getString("VehicleRegNumber"))){ %>Selected<% } %> ><%=rst.getString("VehicleRegNumber")%></option>				
				<%
			}
			%>
			</select>			
			</td>
			<td align="right">
			  <input type="text" id="data" name="data"  value="<%=datenew1%>"  size="15" readonly/>
			<img src="images/calendar.png" id="trigger" border="0">
  							<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "trigger"       // ID of the button
    			}
  				);	
				</script>
			</td>
			<td align="right">
			  	<input type="text" id="data1" name="data1"  value="<%=datenew2%>" size="15" readonly/>
			<img src="images/calendar.png" id="trigger1" border="0">
  			  
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
			<td>
				<input type="submit" name="submit" id="submit" value="submit">
			</td>
		</tr>
		<tr>
			<td colspan="4"><div id="report_heding"><font color="brown" size="3"><b>Select Date Range Only For One Month</b></font></div></td>
		</tr>
		</form>
		</table>
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
			
			
			</table>
			<%
			if(!(null==request.getQueryString()))
			{			
			%>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Run Analysis Report for <% if(vehicle.equals("All")) {%>All Vehicles <%}else { out.print ("Vehicle "+vehicle); } %> from <%=datenew1%> to <%=datenew2 %></font></div>
			
				<div align="right">
				<a href="#" onclick="javascript:window.open('weeklygraphreport.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>');" title="BAR CHART">BAR CHART</a>&nbsp; &nbsp;
				<a href="#" onclick="javascript:window.open('printstopanalysis.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelstopanalysis.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>			
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th>Sr.No. </th>
			<th>WEEK</th>
			<th>OS</th>
			<th>RA</th>
			<th>RD</th>
			<th>CD</th>
			<th>DT</th>
			<th>Stops</th>
			<th>ND</th>
			</tr>		
			<%
			
			
			java.util.Date lastweek=new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1);
		//	.parse(datenew1);
			
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			//out.print(formatter.format(lastweek));
			long todaymils1 = lastweek.getTime();
			long week1 = 60*60*1000*24*6;
			week1 = todaymils1+week1;
			//lastweek.setTime(week1);
		//	out.print(formatter.format(week1));
			
			//out.print(todaymils1);
			//out.print(formatter.format(todaymils1));
			//out.print(week1);
			//out.print(formatter.format(week1));
			long week2 = week1+(60*60*1000*24*7);
			//out.print(week2);
			//out.print(formatter.format(week2));
			long week3 = week2+(60*60*1000*24*7);
			//out.print(week3);
			//out.print(formatter.format(week3));
			long week4 = week3+(60*60*1000*24*7);
			//out.print(week4);
			//out.print(formatter.format(week4));
			
			
			//java.util.Date lastweek1=new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1);
			//Format formatter1 = new SimpleDateFormat("yyyy-MM-dd");
				//out.print(formatter.format(lastweek1));
				//long firstdaymils1 = lastweek1.getTime();
			//out.print(firstdaymils1);
				
			sql="select * from t_vehicledetails where VehicleRegNumber='"+vehicle+"'";
			ResultSet rst1=st.executeQuery(sql);
			if(rst1.next())
			{	
				
				
				//if(date1 > week1
				//{
				sql="select distinct(TheDate),OSCount,RACount,RDCount,Distance,StopCount,RDuration,ND from t_veh"+rst1.getString("vehicleCode")+"_ds  where TheDate >='"+date1+"' and TheDate <='"+date2+"' order by TheDate Asc";
				//out.print(sql);
				ResultSet rst0=st4.executeQuery(sql);
				int j=1;
				//int i=0;
				//while(rst0.next())
				//{
				//	i++;
				//}
				//out.print(i);
				//ResultSet rst0=st4.executeQuery(sql);
				//rst0.beforeFirst();
				while(rst0.next())
				{
					
					java.util.Date date=rst0.getDate("TheDate");
					//out.print(date);
					long today = date.getTime();
					//out.print(today);
					
					if(today < week1 || today == week1)
					{
						
						
						os=rst0.getInt("OSCount");
						ra=rst0.getInt("RACount");
						rd=rst0.getInt("RDCount");
						dt=rst0.getInt("Distance");
						stops=rst0.getInt("StopCount");
						rh=rst0.getInt("RDuration");
						nd=rst0.getString("ND");
						cd="NO";
						oscountall=oscountall+os;
						racountall=racountall+ra;
						rdcountall=rdcountall+rd;
						dtcountall=dtcountall+dt;
						stopcountall=stopcountall+stops;
						rhcountall=rhcountall+rh;
					}
					else
						if(today < week2 || today == week2)
						{
							os1=rst0.getInt("OSCount");
							ra1=rst0.getInt("RACount");
							rd1=rst0.getInt("RDCount");
							dt1=rst0.getInt("Distance");
							stops1=rst0.getInt("StopCount");
							rh1=rst0.getInt("RDuration");
							nd=rst0.getString("ND");
							cd="NO";
							oscountall1=oscountall1+os1;
							racountall1=racountall1+ra1;
							rdcountall1=rdcountall1+rd1;
							dtcountall1=dtcountall1+dt1;
							stopcountall1=stopcountall1+stops1;
							rhcountall1=rhcountall1+rh1;
						}
						else
							if(today < week3 || today == week3)
							{
								os2=rst0.getInt("OSCount");
								ra2=rst0.getInt("RACount");
								rd2=rst0.getInt("RDCount");
								dt2=rst0.getInt("Distance");
								stops2=rst0.getInt("StopCount");
								rh2=rst0.getInt("RDuration");
								nd=rst0.getString("ND");
								cd="NO";
								oscountall2=oscountall2+os2;
								racountall2=racountall2+ra2;
								rdcountall2=rdcountall2+rd2;
								dtcountall2=dtcountall2+dt2;
								stopcountall2=stopcountall2+stops2;
								rhcountall2=rhcountall2+rh2;
							}
							else
								if(today < week4 || today == week4)
								{
									os3=rst0.getInt("OSCount");
									ra3=rst0.getInt("RACount");
									rd3=rst0.getInt("RDCount");
									dt3=rst0.getInt("Distance");
									stops3=rst0.getInt("StopCount");
									rh3=rst0.getInt("RDuration");
									nd=rst0.getString("ND");
									cd="NO";
									oscountall3=oscountall3+os3;
									racountall3=racountall3+ra3;
									rdcountall3=rdcountall3+rd3;
									dtcountall3=dtcountall3+dt3;
									stopcountall3=stopcountall3+stops3;
									rhcountall3=rhcountall3+rh3;
								}
							
				  if(today == week1)
					{
%>
					<tr>
					<td><%=j%></td>
					<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst0.getDate("TheDate"))%></td>
					
					<td><div align="right"><%=oscountall%></div></td>
					<td><div align="right"><%=racountall%></div></td>
					<td><div align="right"><%=rdcountall%></div></td>
					<td><div align="right"><%=cd%></div></td>
					<td><div align="right"><%=dtcountall%></div></td>
					<td><div align="right"><%=stopcountall%> </div></td>	
					<td><div align="right"><%=nd%></div></td>
					</tr>					
					<%
					j++;
					session.setAttribute("oscountall",oscountall);
					session.setAttribute("racountall",racountall);
					session.setAttribute("rdcountall",rdcountall);
					session.setAttribute("dtcountall",dtcountall);
					//session.setAttribute("");
					}
				  if(today == week2)
					{
%>
					<tr>
					<td><%=j%></td>
					<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst0.getDate("TheDate"))%></td>
					
					<td><div align="right"><%=oscountall1%></div></td>
					<td><div align="right"><%=racountall1%></div></td>
					<td><div align="right"><%=rdcountall1%></div></td>
					<td><div align="right"><%=cd%></div></td>
					<td><div align="right"><%=dtcountall1%></div></td>
					<td><div align="right"><%=stopcountall1%> </div></td>	
					<td><div align="right"><%=nd%></div></td>
					</tr>					
					<%
					j++;
					session.setAttribute("oscountall1",oscountall1);
					session.setAttribute("racountall1",racountall1);
					session.setAttribute("rdcountall1",rdcountall1);
					session.setAttribute("dtcountall1",dtcountall1);
					}
				  if(today == week3)
					{
%>
					<tr>
					<td><%=j%></td>
					<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst0.getDate("TheDate"))%></td>
					<td><div align="right"><%=oscountall2%></div></td>
					<td><div align="right"><%=racountall2%></div></td>
					<td><div align="right"><%=rdcountall2%></div></td>
					<td><div align="right"><%=cd%></div></td>
					<td><div align="right"><%=dtcountall2%></div></td>
					<td><div align="right"><%=stopcountall2%> </div></td>	
					<td><div align="right"><%=nd%></div></td>
					</tr>					
					<%
					j++;
					session.setAttribute("oscountall2",oscountall2);
					session.setAttribute("racountall2",racountall2);
					session.setAttribute("rdcountall2",rdcountall2);
					session.setAttribute("dtcountall2",dtcountall2);
					}
				  if(today == week4)
					{
%>
					<tr>
					<td><%=j%></td>
					<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst0.getDate("TheDate"))%></td>
					<td><div align="right"><%=oscountall3%></div></td>
					<td><div align="right"><%=racountall3%></div></td>
					<td><div align="right"><%=rdcountall3%></div></td>
					<td><div align="right"><%=cd%></div></td>
					<td><div align="right"><%=dtcountall3%></div></td>
					<td><div align="right"><%=stopcountall3%> </div></td>	
					<td><div align="right"><%=nd%></div></td>
					</tr>					
					<%
					j++;
					session.setAttribute("oscountall3",oscountall3);
					session.setAttribute("racountall3",racountall3);
					session.setAttribute("rdcountall3",rdcountall3);
					session.setAttribute("dtcountall3",dtcountall3);
					}
				}
			}
			%>
			</table>
			<%
			}
			%>
			
			<!-- body part come here -->
				<%
				}catch(Exception e)
				{
					out.print("Exceptions--->"+e);
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

q.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
}
</SCRIPT>
</td>

<td valign="top" colspan="2">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var q = new Graph(200,200);
q.scale = 1;
q.title = "Average Rating for all transporter";
q.yLabel = "Exceptions";
q.xLabel = "<%=showdate%> to <%=showdate1%>";
q.setXScale("",1);
<%
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

q.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
}
</SCRIPT>
</td>

</tr>
<tr>
<td valign="top" colspan="2">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var q = new Graph(200,200);
q.scale = 1;
q.title = "Average Rating for all transporter";
q.yLabel = "Exceptions";
q.xLabel = "<%=showdate%> to <%=showdate1%>";
q.setXScale("",1);
<%
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

q.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
}
</SCRIPT>
</td>
<td valign="top" colspan="2">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var q = new Graph(200,200);
q.scale = 1;
q.title = "Average Rating for all transporter";
q.yLabel = "Exceptions";
q.xLabel = "<%=showdate%> to <%=showdate1%>";
q.setXScale("",1);
<%
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

q.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
  
  /* 


  
  select a.*,b.DriverName,c.VehicleRegNumber from db_gpsExceptions.t_driver_ds a,db_gps.t_drivers b,db_gps.t_vehicledetails c where a.DCode=b.DriverID and a.VehCode=c.VehicleCode and RDuration  >='24:00:00' and a.DCode like'9103%' and a.TheDate between '2010-04-01' and '2010-05-25' order by a.DCode,a.TheDate Asc
  27486
  select a.TheDate,a.DCode,b.DriverName,c.VehicleRegNumber,a.RDuration,a.LastWeekRDur from db_gpsExceptions.t_driver_ds a,db_gps.t_drivers b,db_gps.t_vehicledetails c where a.DCode=b.DriverID and a.VehCode=c.VehicleCode and a.DCode like'9103%' and a.TheDate between '2010-04-01' and '2010-04-30' order by a.DCode,a.TheDate Asc
  SELECT * FROM `t_CastrolDrivers6` where DriverID like'9103%' and TheDte between '2010-04-01' and '2010-04-30'   order by DriverID,TheDte Asc
  
  */
}
</SCRIPT>
</td>

</tr>


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

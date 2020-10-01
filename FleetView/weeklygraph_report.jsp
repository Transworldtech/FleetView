<%@ include file="headernew.jsp" %>
<html>
<head>
<title>Graph Analysis</title>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
 <link href="layout.css" rel="stylesheet" type="text/css"></link>
 <script language="javascript" type="text/javascript" src="js/jquery.js"></script>
 <script language="javascript" type="text/javascript" src="js/jquery.plot.js"></script>
</head>
<body>
 <script language="javascript" type="text/javascript" src="js/calendar.js"></script>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
			Connection conn,conn1;
			Statement st,st1,st2,st3,st4, st5, st6, st7, st8, st9, st10;
			ResultSet rst0=null;
			String sql,sql1,vehicle,date1,date2, msg,datenew1,datenew2;
			
			 %>
			<%
			int oscountall=0,oscountall1=0,oscountall2=0,oscountall3=0;
			int racountall=0,racountall1=0,racountall2=0,racountall3=0;
			int rdcountall=0,rdcountall1=0,rdcountall2=0,rdcountall3=0;
			int dtcountall=0,dtcountall1=0,dtcountall2=0,dtcountall3=0;
			String oss="",raa="",rdd="",spp="";
			int j=0;
			String fidDate, data1, data2,showdate,showdate1,trips,user;
			int oscount, racount,rdcount, stcount,cdcount, dtcount,rhcount,osduration,osduration1,tpcount,tpcount1,dcount,dcount1,vcount, vcount1;
			String ndcount;
			int oscount1, racount1,rdcount1, ndcount1, stcount1,cdcount1, dtcount1,rhcount1,transportercount;
			double rtcount;
			String ss="", vv="";
			double OverSpeed,Accelaration,Decelaration,Rating,Rating1,Accelaration1,Decelaration1,OverSpeed1;



			if(null==request.getQueryString())
			{
					vehicle="All";
					datenew2=datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
					msg="Run Analysis Report";
			
			}
			else
			{
					vehicle=request.getParameter("vehicle");
					datenew1=request.getParameter("calender1");
					datenew2=request.getParameter("calender2");
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
				int kmcountall=0,rhcountall=0,stopcountall=0;
				int kmcountall1=0,rhcountall1=0,stopcountall1=0;
				int kmcountall2=0,rhcountall2=0,stopcountall2=0;
				int kmcountall3=0,rhcountall3=0,stopcountall3=0;

				String cd="",nd="";
				double totkmtrav=0, avgspeedoffleet=0, avgrunspeedoffleet=0;
				
									
			%>
			<table width="100%" align="center" class="sortable">
			<tr><td  class="sorttable_nosort">
			<!-- if date range is not requred please remove this code start from this comment to -->
			
			<table border="0" width="100%">
			<form action="" method="get" onsubmit="return validate('calender1','calender2');">
			
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
		<!--  	</td>
			<td align="right"> -->
			
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b>From&nbsp;&nbsp;</b> <input type="text" id="calender1" name="calender1"  value="<%=datenew1%>"  size="15" readonly/>
<!--			<img src="images/calendar.png" id="trigger" border="0">-->
  							<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "calender1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "calender1"       // ID of the button
    			}
  				);	
				</script>
		<!--	</td>
			<td align="right"> -->
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b>To&nbsp;&nbsp;</b>
			  	<input type="text" id="calender2" name="calender2"  value="<%=datenew2%>" size="15" readonly/>
<!--			<img src="images/calendar.png" id="trigger1" border="0">-->
  			  
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "calender2",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "calender2"       // ID of the button
    			}
  				);
				</script>
		<!--	</td>
			<td>   -->
		   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" name="submit" id="submit" value="submit">
				<br><br><h3>Please select at least 2 weeks.This graph does not show any graph line for lower date range.</h3>
			</td>
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
			<div id="report_heding"><font color="brown" size="3">The Exception Analysis Report On Graph for <% if(vehicle.equals("All")) {%>All Vehicles <%}else { out.print ("Vehicle "+vehicle); } %> from <%=datenew1%> to <%=datenew2 %></font></div>
			
				<div align="right">
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>			
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th>WEEK</th>
			<th>Date Range</th>
			<th>OS</th>
			<th>RA</th>
			<th>RD</th>
			<th>Distance</th>
			<th>Stops</th>
			<th>Run Hrs</th>
			<th>CD</th>
			<th>ND</th>
			</tr>		
			<%
			long weekmiliseconds=60*60*1000*24*6;
						
			java.util.Date fromdate=new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1);
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			long frommils = fromdate.getTime();//Miliseconds for From Dtae
			
			java.util.Date todate=new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2);
			long tomils = todate.getTime();//Miliseconds for ToDtae
			
			long frommils1= frommils+weekmiliseconds;
			int i=1;
			
				sql="select * from t_vehicledetails where VehicleRegNumber='"+vehicle+"'";
				ResultSet rst1=st.executeQuery(sql);
				if(rst1.next())
				{	
					oss="[";
					raa="[";
					rdd="[";
					spp="[";
					while(frommils1<=tomils)
					{
						int cnt=0;
						int cnt1=0;
						java.util.Date date1= new java.util.Date();
						date1.setTime(frommils);
						String fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(date1);
						
						java.util.Date date2= new java.util.Date();
						date2.setTime(frommils1);
						String todate1=new SimpleDateFormat("yyyy-MM-dd").format(date2);
							oscountall=0;
							racountall=0;
							rdcountall=0;
							dtcountall=0;
							stopcountall=0;
							rhcountall=0;
					sql="select distinct(TheDate),OSCount,RACount,RDCount,CRCount,Distance,StopCount,RDuration,ND from t_veh"+rst1.getString("vehicleCode")+"_ds  where TheDate between '"+fromdate1+"' and '"+todate1+"' order by TheDate Asc";
					rst0=st4.executeQuery(sql);
					
					while(rst0.next())
					{
							os=rst0.getInt("OSCount");
							ra=rst0.getInt("RACount");
							rd=rst0.getInt("RDCount");
							dt=rst0.getInt("Distance");
							stops=rst0.getInt("StopCount");
							rh=rst0.getInt("RDuration");
							nd=rst0.getString("ND");
							if(nd.equals("Yes"))
							{
								cnt++;
							}
							cd=rst0.getString("CRCount");
							if(cd.equals("Yes"))
							{
								cnt1++;
							}
							oscountall=oscountall+os;
							racountall=racountall+ra;
							rdcountall=rdcountall+rd;
							dtcountall=dtcountall+dt;
							stopcountall=stopcountall+stops;
							rhcountall=rhcountall+rh;
					}
					j++;
						%>
						<tr>
						<td style="text-align:right"><%=j %> </td>
						<td style="text-align:left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate1)) %>  <b><font color="brown">&nbsp; To &nbsp;</font></b> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate1)) %></td>
						<td style="text-align:right"><%=oscountall %></td>
						<td style="text-align:right"><%=racountall %></td>
						<td style="text-align:right"><%=rdcountall %></td>
						<td style="text-align:right"><%=dtcountall%></td>
						<td style="text-align:right"><%=stopcountall%></td>
						<td style="text-align:right"><%=rhcountall %></td>
						<%
						if(cnt>0)
						{
							%>
								<td style="text-align:left">YES</td>
							<%
						}
						else
						{
							%>
								<td style="text-align:left">NO</td>
							<%
						}
						%>
						<%
						if(cnt1>0)
						{
							%>
								<td style="text-align:left">YES</td>
							<%
						}
						else
						{
							%>
								<td style="text-align:left">NO</td>
							<%
						}
						%>
						</tr>
						<%	
						oss=oss+"["+j+","+oscountall+"],";
						raa=raa+"["+j+","+racountall+"],";
						rdd=rdd+"["+j+","+rdcountall+"],";
						spp=spp+"["+j+","+stopcountall+"],";
						frommils=frommils1+24*60*60*1000;
						frommils1= frommils+weekmiliseconds;
				}
					oss=oss.substring(0,oss.length()-1)+"]";
					raa=raa.substring(0,raa.length()-1)+"]";
					rdd=rdd.substring(0,rdd.length()-1)+"]";
					spp=spp.substring(0,spp.length()-1)+"]";
											
			}
			
			%>
			</table>
			<%
			}
			%>
			<!-- body part come here -->
<table border="0" width="100%" align="center">
<tr>
<td align="center"><font color="brown" size="2">
The Exception Analysis On Graph 
</font>
</td>
</tr>
<tr>
<td align="center">
<div id="chart_div" order="1"></div>
<%
if(j<=5)
{
	%>
		<div id="placeholder" style="width:500px;height:400px;"></div>
		
	<%
}
else
	if(j<=10)
	{
		%>
			<div id="placeholder" style="width:800px;height:400px;"></div>
		<%
	}
	else
		if(j<=15)
		{
		%>
			<div id="placeholder" style="width:1100px;height:400px;"></div>
		<%	
		}
		else
			{
			%>
				<div id="placeholder" style="width:1500px;height:400px;"></div>
			<%	
			}
//************************Function To Draw Graph*********************************************
%>

<script id="source" language="javascript" type="text/javascript">
//alert("hiiiiiii");
$(function () {
	//alert("hiiiiiii");
 	<%
/*	try{
		Class.forName("org.gjt.mm.mysql.Driver"); 
		conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement st=conn.createStatement();
		
		**************You Can Write Query Here To Eluminate Data From Data Base************
		
		String sql="select * from t_veh3210_ds where TheDate between '2010-02-01' and '2010-02-07'";
		ResultSet rst00=st.executeQuery(sql);
		oss="[";
		raa="[";
		rdd="[";
		spp="[";
		int ii=1;
		int kmm=0;
		while(rst00.next())
		{

			os=rst.getString("OSCount");
			ra=rst.getString("RACount");
			rd=rst.getString("RDCount");
			sp=rst.getString("StopCount");
			
			oss=oss+"["+rst00.getString("OSCount")+","+rst00.getString("TheDate")+"],";
			raa=raa+"["+rst00.getString("RACount")+","+rst00.getString("TheDate")+"],";
			rd=rd+"["+rst.getString("RDCount")+"],";
			sp=sp+"["+rst.getString("StopCount")+"],";
		System.out.print("os2-->"+os);	
			
			
			ii++;
		}
				
			oss=oss.substring(0,oss.length()-1)+"]";
			System.out.print("OS String-->"+os);
			System.out.print("os3 string-->"+os);
			raa=raa.substring(0,raa.length()-1)+"]";
			rd=rd.substring(0,rd.length()-1)+"]";	
			sp=sp.substring(0,sp.length()-1)+"]";
		
		conn.close();	
	}catch(Exception e)
	{
*/		%>
//			alert(":Exception:");
		<%
/*	}
	*/
	%>
    
	var overspeed = <%=oss%>;
	var rapidacc = <%=raa%>;
	var rapiddeacc = <%=rdd%>;
	var stopages = <%=spp%>;

//	System.out.println("RD String-->"+rdd);
//	System.out.println("STOP String-->"+spp);
	
   //	var rapiddeacc = < %=rd%>;
   
   	//var sp = < %=sp%>;
   	//alert("("+overspeed+")("+rapidacc+")");

    $.plot($("#placeholder"),
           [ { data: overspeed, label: "OS" },
             { data: rapidacc, label: "RA"},
             { data: rapiddeacc, label: "RD"},
             { data: stopages, label: "STOP"}      
           ],
           { xaxis: { mode: 'minute' },
             yaxis: { min: 0 },
             y2axis: { tickFormatter: function (v, axis) { return v.toFixed(axis.tickDecimals)}},
             legend: { position: 'nw' } });
});
</script>
</td>
</tr>
<tr><td align="center"><b><font color="BROWN" size="3"><----  W E E K S  ----></font></b></td></tr>
<tr>
<td>
<div align="center"><input type="button" name="Print" value="Print" onclick="javascript:window.print();"></div>
</td></tr>
</table>
			
			
			
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

<!--Start Code for the Graph -->


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

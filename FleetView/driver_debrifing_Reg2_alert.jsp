
<%@ include file="headernew.jsp" %>

<%@page import="java.util.Date"%>

<html>
<head>
</head>
<body>
 <br><br>
 
 
 <%!
Connection conn;
Statement st,st1, stmt1;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
int os,ra,rd,cd,nd,osdur;
String oscount,racount,rdcount,cdcount;
%>
 <%
 
 System.out.print("1,");
 String tripid=request.getParameter("tripid");
 String DriverId=request.getParameter("DriverId");
 
 try
 {
	 Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
 
 
 %>
<div align="center">
 <font color="red" size="3"><b>
 
Trip'<%=tripid%>' is not briefed. So you can not de-brief the trip. Please check if driver is briefed with dummy trip id for this trip. If so, please enter the correct trip id for the briefing record from trainer history report. Once this is done, then you can de-brief for the said trip.

</b></font></div>
<br></br>

<div>
<table width="100%" border="1" align="center" class="sortable">


			<%
			
			System.out.print("2,");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal=Calendar.getInstance();
			cal.add(Calendar.DATE, -30);
			String twodaysback = dateFormat.format(cal.getTime()); 
		//	prevDayDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(yesrtday));
						
				
			//sql="select * from db_gps.t_briefing where driverid='"+DriverId+"' order by brifdate desc limit 5";
			//sql="SELECT  a.Transporter as Transporter,a.driverid as driverid,a.DriverName as DriverName,a.VehRegNo as VehRegNo,a.tripid as tripid, a.brifdate as brifdate,a.TrainerName as TrainerName, a.brifdate as brifdate,a.Briefid as Briefid FROM    db_gps.t_briefing a  LEFT OUTER JOIN db_gps.t_briefing b on a.tripid = b.tripid  where a.driverid = '"+DriverId+"' and  b.tripid IS NULL";
			sql="SELECT a.Transporter AS Transporter, a.driverid AS driverid, a.DriverName AS DriverName, a.VehRegNo AS VehRegNo, a.tripid AS tripid, a.brifdate AS brifdate, a.TrainerName AS TrainerName, a.brifdate AS brifdate, a.Briefid AS Briefid FROM db_gps.t_briefing a WHERE a.driverid = '"+DriverId+"' and a.brifstatus='briefed' and Debrifstatus='not debriefed' and Status='Close' and DeBrifingStatus='-'";			
			System.out.println(sql);
			ResultSet rst=st.executeQuery(sql);
			System.out.print("3,");
			int i=1;
			
			if(rst.next())
			{
				%>
				<tr>
	<th   align="center" > Sr.</th>
		
			<th   align="center" > Trainer</th>
				
		
			<th class="hed"  align="center" > Briefing Date</th>
			<th class="hed"  align="center" > Briefing Id</th>
			<th class="hed"  align="center">Veh.</th>
			<th class="hed"  align="center">Trip id</th>
			<th class="hed"  align="center">Driver</th>
			<th class="hed"  align="center">Driver Id</th>
			<th class="hed"  align="center">Transporter</th>
			</tr>
				<%
				

			rst.previous();
			while(rst.next())
			{
				String tripidnew="";
				String brifdate="-",debrifdate="-";
				String brifDebrifDate;
				tripidnew = rst.getString("tripid");
			
				System.out.print("4,");
			
			
			
			%>
			<tr>
			<td style="text-align: right"><%=i%></td>
			
			<%
				brifdate = rst.getString("brifdate");
				brifDebrifDate =brifdate;
			%>		
			
			<td style="text-align: left">
				<%
				out.print(rst.getString("TrainerName"));
				%>
				</td>
			
			<td " style="text-align: left">
			<%
			out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("brifdate"))));
			
			%>
			</td>
			<td style="text-align: right;"><%=rst.getString("Briefid")%></td>
		
			<td style="text-align: left">
				<%
				out.print(rst.getString("VehRegNo"));
				%>
				</td>
			<%
			//String today = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			java.util.Date dtbrif = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(brifDebrifDate);
			java.util.Date dtprev = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twodaysback);
			int days=0;
			String numOfDays = "SELECT TO_DAYS('"+brifDebrifDate+"') - TO_DAYS('"+twodaysback+"') as days";
			ResultSet rss = st1.executeQuery(numOfDays);
			if(rss.next())
			{
				days = Integer.parseInt(rss.getString("days"));
				//System.out.println("days=========>"+days);
			}
			if((dtbrif.compareTo(dtprev)>0))
				//else if(days<2)
				{
					
					%>
					
					<td style="text-align: right"><a href="#" onclick="javascript:window.open('enterTripid.jsp?&rdpassport=brif&brifId=<%=rst.getString("Briefid") %>&briefdate=<%=brifdate %>&debrifdate=<%=debrifdate %>&CurrTripId=<%=tripidnew %>','','top=400, left=400,menubar=1,resizable=1,scrollbars=1,width=500,height=100,location=no');"><%=tripidnew%></a></td>
					<%
				}
			else{
				%>
				<td style="text-align: right"><%=tripidnew%></td>
				<%
			}
			
			%>
			
			<td style="text-align: left"><%=rst.getString("DriverName")%></td>
			<td style="text-align: right"><%=rst.getString("driverid")%></td>
			<td style="text-align: left"><%=rst.getString("Transporter")%></td>

			<%
			
			%>
			
			<%
			//if(rsttrip.getDouble("KmTravelled")==0.0 || km.equals("-"))
				//out.println(km);
			
			
			%>

		
			
			</tr>			
			<%
			i++;
			}
			}
			%>
			</table>




</div>

<div>


<%
String sql1="SELECT * FROM `t_drivers` WHERE driverid='"+DriverId+"' ORDER BY Updated LIMIT 1";
System.out.println(sql);
ResultSet rst1=st.executeQuery(sql1);
if(rst1.next())
{
	System.out.println(rst1.getString("DriverName"));
	System.out.println(DriverId);
	System.out.println(rst1.getString("Owner"));
	
%>

<center> 
<table >
<tr> <th><font color="red" size="3"><b> If the tripid is not briefed ,<blink> <a href='BrifReg.jsp?driverid=<%=DriverId%>&drivername=<%=rst1.getString("DriverName") %>&trans=<%=rst1.getString("Owner")%>'>
Click here </a> </blink> to brief
</b></font>
</th>	
</tr>
</table>
</center>
	<%
}
	
	%>

</div>



 
 <div align="center">
<INPUT TYPE="BUTTON" VALUE="Go Back" 
ONCLICK="history.go(-1)">
 </div>
 
 
 <%
 }
 catch(Exception e)
 {
	 
 }
 finally
 {
	 conn.close();
 }
 %>
</body>
</html>
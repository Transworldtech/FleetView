<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
int cnt= 0;
String filename="";
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_DriverIncentiveDetails.xls";
	filename=filename.replace(" ","_");
}
else
{
	filename =session.getAttribute("user").toString()+"_DriverIncentiveDetails.xls";
	filename=filename.replace(" ","_");
}
//String filename=session.getAttribute("user").toString()+"_detail_report.xls";
System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection con=null;
Statement st=null;
Statement st1=null;
Statement st2=null;
Statement st6=null;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();	
	st6=con.createStatement();
	
	String driverid=request.getParameter("driverid");
	String category = request.getParameter("category");
	String month = request.getParameter("month");
	String month1 = request.getParameter("month1");
	java.util.Date NewDate =new java.util.Date();
	long dateMillis = NewDate.getTime();
	long dayInMillis = 1000* 60 *60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
	Format NewFormatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	int monthcount=  0;
	String sqlmonth = "SELECT TIMESTAMPDIFF(MONTH, '"+month+"', '"+month1+"') as monthno";
	ResultSet rsmonth = st.executeQuery(sqlmonth);
	if(rsmonth.next())
	{
		monthcount = rsmonth.getInt("monthno")+1;
		System.out.println("Monthcount    "+rsmonth.getInt("monthno"));
	}
	%>
	<table border="0" width="100%" align="center">
	<tr>
<td align="center" colspan="15" ><font size="3"><b>Driver Incentive Trip Details</b></font></td>
</tr>
	<tr>
	<td align="left" colspan="15">
	                        <br>
	                        <font size="2" color="black"><b> Disclaimer : The Calculated Amount may change if there is a change in the status or count of Violation</b></font> 
	                       </td>
	</tr>
	</table>
	<%System.out.println("*********     hfgsbhdvfdsm"); %>
	<table class="sortable" style="width: 1500px;" border="1">
	<tr>
	<th style="width: 10px;">Sr No</th>
	<th style="width: 60px;">Driver Id</th>
	<th style="width: 100px;">Driver Name</th>
	<th style="width: 60px;">Trip id</th>
	<th style="width: 90px;">Veh Reg No</th>
	<th style="width: 150px;">Origin</th>
	<th style="width: 30px;">Start Date</th>
	<th style="width: 150px;">Destination</th>
	<th style="width: 30px;">End Date</th>
	<th style="width: 20px;">Trip KM</th>
	<th style="width: 20px;">RA</th>
	<th style="width: 20px;">RD</th>
	<th style="width: 20px;">OS</th>
	<th style="width: 20px;">OS Dur</th>
	<th style="width: 20px;">CD</th>
	<th style="width: 20px;">ND</th>
	<th style="width: 20px;">DC</th>
	<th style="width: 30px;">DH Vio</th>
	<th style="width: 30px;">Stops Greater Than 4 hrs</th>
	<th style="width: 30px;">Trip Rating</th>
	<th style="width: 30px;">DVI Points</th>
	<th style="width: 30px;">JRM Points</th>
	<th style="width: 30px;">Adherence To JRM and JP</th>
	<th style="width: 30px;">Distance & Points Based Incentive (A)</th>
	<%
	//if(category.equals("tanker"))	
	//{
		%>
	<!--	<th style="width: 30px;">Tanker Zero DVI Incentive Rate</th>-->
		<%
	//}
	//else
	//{
		%>
	<!--	<th style="width: 30px;">Pri-Sec Zero DVI Incentive Rate</th>-->
		<%
	//}
	%>
	<th style="width: 30px;">Zero DVI Based Incentive (B)</th>
	<th style="width: 40px;">Total Incentive (A+B)</th>
	</tr>
	<%
	int i=1,totincentive1 = 0,zerodvirate1 = 0;
	for(int k =0;k<monthcount;k++)
	{
	Calendar Cal = Calendar.getInstance();
	System.out.println("k:    "+k);
	Cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(month));
	Cal.add(Calendar.MONTH,k);
	String month3 = new SimpleDateFormat("yyyy-MM-dd").format(Cal.getTime());
	System.out.println("Date:    "+month3);


	String data1 = month3;
	String data2 = new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(month3))+"-31";
	System.out.println("Date:    "+month3);
	String user,usertypevalue;
	user=session.getAttribute("user").toString();
	usertypevalue=session.getAttribute("usertypevalue").toString();

	int totaltrips = 0;
	String sql = "";
	if(category.equals("tanker"))	
	{
	String sql1 = "SELECT * FROM `t_DriverIncentive` WHERE ScoreCategory = 'TankerRate'and GPName='Castrol'";
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		zerodvirate1 = rs1.getInt("Points");
	}

	sql1 = "Select count(*)  as cnt from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Tanker')  AND DRIVERID='"+driverid+"' and KmTravelled > 0";
	rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		totaltrips = rs1.getInt("cnt");
	}		

	 sql="Select * from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Tanker') AND DRIVERID='"+driverid+"'  and KmTravelled > 0 ";
	}
	else
	{
	String sql1 = "SELECT * FROM `t_DriverIncentive` WHERE ScoreCategory = 'PrimaryRate'and GPName='Castrol'";
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		zerodvirate1 = rs1.getInt("Points");
	}

	sql1 = "Select count(*)  as cnt from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Primary','Secondary')  AND DRIVERID='"+driverid+"'  and KmTravelled > 0";
	rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		totaltrips = rs1.getInt("cnt");
	}		
	 sql="Select * from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Primary','Secondary') AND DRIVERID='"+driverid+"' and KmTravelled > 0 ";

	}

	ResultSet rs= st.executeQuery(sql);
	int totincentive = 0;
	int totmonthinc = 0,m = 1,l = 0;
	while(rs.next()){
	 int trippoint = 0,zerodvirate=0,zerodviincentive = 0;    
	 trippoint = (rs.getInt("KmTravelled") * (rs.getInt("dvipoint")+rs.getInt("jrmpoint")))/100;
	 totincentive = 0;
	 if(category.equals("tanker"))
	 {
		 zerodvirate = zerodvirate1;
		 if(new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))).equals("0.00")  && (rs.getInt("dvipoint") > 0 || rs.getInt("jrmpoint") > 0))
		 {
			 zerodviincentive = zerodvirate1;
		 }
		 else
		 {
			 zerodviincentive = 0;
		 }
	 }
	 else
	 {
		 if(totaltrips >= 5)
		 {
			 zerodvirate = zerodvirate1;
		 }
		 else
		 {
			 zerodvirate = 0;
		 }
		 if(new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))).equals("0.00") && (rs.getInt("dvipoint") > 0 || rs.getInt("jrmpoint") > 0))
		 {
			 zerodviincentive = zerodvirate;
		 }
		 else
		 {
			 zerodviincentive = 0;
		 }
	 }
	 
	 totincentive = trippoint + zerodviincentive;
	 totmonthinc = totmonthinc + totincentive;
	 
	%>
	<tr>   
	<td><%=i++ %></td>
	<td align="right" ><div style="text-align: right;"> <%=rs.getString("DriverID") %></div></td>
	<td align="left" ><div style="text-align: left; "><%=rs.getString("DriverName") %></div></td>
	<td align="right" ><div style="text-align: right;"><%=rs.getString("TripID") %></a></div></td>  
	<td align="left" ><div style="text-align: left; "><%=rs.getString("VehRegNo") %></div></td>
	<td align="left"><div style="text-align: left; "><%=rs.getString("StartPlace") %></div></td>
	<td align="right"><div style="text-align: right;"><% try { out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")))); } 
	catch(Exception e)
	{
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")+" "+rs.getString("StartTime"))));
	}
	%></div></td>
	<td align="left"><div style="text-align: left;"><%=rs.getString("EndPlace") %></div></td>
	<td align="right"><div style="text-align: right;"><% try { out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("EndDate")))); } 
	catch(Exception e)
	{
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("EndDate")+" "+rs.getString("EndTime"))));
	}

	%></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("KmTravelled") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("OpenRA") %></div></td> 
	<td align="right"><div style="text-align: right;"><%=rs.getString("OpenRD") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("OpenOS") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("OpenOSDur") %></div></td>
	<td align="right"><div style="text-align: right;"><%
	int CRCount=0;
	try{
	CRCount=rs.getInt("OpenCD");
	out.print(CRCount);

	}
	catch(Exception e)
	{
	String CR=rs.getString("OpenCD");
	String Vehid=rs.getString("Vehid");
	if(CR.equalsIgnoreCase("Yes")||CR=="Yes")
	{
		String  sql1 = "SELECT count(*) as CRCount FROM db_gpsExceptions.t_veh"+Vehid+"_cr WHERE concat(FromDate, ' ',FromTime )>= '"+rs.getString("StartDate")+"'and concat(FromDate, ' ',FromTime )<= '"+rs.getString("EndDate")+"'";
		System.out.print("RRRR : "+sql1);
		ResultSet rs1 = st1.executeQuery(sql1);
		if(rs1.next())
		{
			CRCount = rs1.getInt("CRCount");
		}
	}
	out.print(CRCount);	
	System.out.println("In Catch  CR : ");
	}



	%></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("OpenND") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("OpenDC") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("RunHrVio") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("Stopsgreaterthan4hrs") %></div></td>
	<td align="right"><div style="text-align: right;"><%=new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))) %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("dvipoint") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("jrmpoint") %></div></td>
	<td align="right"><div style="text-align: right;"><%=rs.getString("JrmStatus") %></div></td>
	<td align="right"><div style="text-align: right;"><%=trippoint %></div></td>
	<!--<td align="right"><div style="text-align: right;">< %=zerodvirate %></div></td>-->
	<td align="right"><div style="text-align: right;"><%=zerodviincentive%></div></td>
	<td align="right"><div style="text-align: right;"><%=totincentive%></div></td>
	
	</tr>
	<%}

	totincentive1 = totincentive1 + totmonthinc;
	int mntcount = monthcount - 1;
	System.out.println("k  "+k+"  monthcount  "+mntcount+"   m   "+m);
	System.out.println("condition   "+(m==2 || k == mntcount));
	if(m==2 || k != mntcount )
	{
	%>
	
	<%
	}
	%>
	<tr><th colspan="25" align="right">Total Incentive (grouped by month)</th><th  align="right"><%=totmonthinc%></th></tr>
	<%
	}
	%>
	<tr><th colspan="25" align="right"><div style="text-align: right;">Total</div></th><th align="right"><div style="text-align: right;"><%=totincentive1 %></div></th></tr>
	</table>
<br>
<%
	System.out.println("Catagory : "+category);
	if(category.equalsIgnoreCase("prisec")||category=="prisec")
	{
		 %>
	<table width="30%" class="sortable" style="width: 600px;text-align: left" border="1">
	<%
	int i71=0;
	String sql71="SELECT * FROM db_gps.t_DriverIncentive WHERE GPName = 'Castrol'";
	ResultSet rs71 = st6.executeQuery(sql71);
	if(rs71.next())
	{	%>	
		<tr>
		<th colspan="4">
		Driver Incentive Card Rules
		</th>
		</tr>
		<tr class="cbFormTableRow">
		<th rowspan="2">SrNo</th>
		<th colspan="2">Parameter</th>
		<th  rowspan="2" width="95px">Points</th>
		</tr>
		<tr class="cbFormTableRow">
		
		<th width="250px">Catagory</th>
		<th width="95px">Range</th>
			</tr>	
		<%
	rs71.previous();
	int MaxDVI=0,MaxJRM=0;
	while(rs71.next())
	{
	if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI") || rs71.getString("ScoreCategory").equalsIgnoreCase("JRM") )
	{
		System.out.println(" in if :");
		i71++;
		%>
		<tr class="cbFormTableRow">
		<td><%=i71 %></td>
		<td><div align="left"><%=rs71.getString("ScoreCategory") %></div></td>
		<% if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI"))
		{
			if(rs71.getInt("Points")>MaxDVI)
			{			MaxDVI=rs71.getInt("Points");			
			}
		%>
		<td><%=rs71.getString("MinValue") %>-<%=rs71.getString("MaxValue") %></td>
		<%
		}
		else if (rs71.getString("ScoreCategory").equalsIgnoreCase("JRM"))
		{
			if(rs71.getInt("Points")>MaxJRM)
			{			
				MaxJRM=rs71.getInt("Points");
				System.out.println(" MaxJRM : "+MaxJRM);
			}
			System.out.println(" MaxJRM : "+MaxJRM);
		%>
			<td>NA</td><%	
		}
		else 
		{%>
			<td>NA</td><%	
		}
		%>	
		<td><%=rs71.getString("Points") %></td>
		</tr>	
		<%}

	}
	%>
	<tr>
	<td colspan="3">Total</td>
	<%
	System.out.println("Max DVI : "+MaxDVI+" MaxJRM : "+MaxJRM);
	%> 
	<td><% out.print(MaxJRM+MaxDVI); %></td>
	</tr>


		<tr class="cbFormTableRow">
		<th >SrNo</th>
		<th >Category</th>
		<th  width="95px">Range</th>
		<th  width="95px">Maximum Earning Potential</th>
		
		</tr>

	<%
	i71=0;
	rs71.last();
	while(rs71.previous())
	{
	if(rs71.getString("ScoreCategory").equalsIgnoreCase("MaxIncentiveKM") )
	{
		i71++;
		%>
		<tr class="cbFormTableRow">
		<td><%=i71 %></td>
		<td><div align="left"><%=rs71.getString("KmsCategory") %></div></td>
		<td><%=rs71.getString("MinValue") %>-<%
		if(rs71.getString("MaxValue")=="10000"||rs71.getString("MaxValue").equalsIgnoreCase("10000"))
		{out.print("and More");		
		}
		else
		{
			out.print(rs71.getString("MaxValue"));
		}
			%></td>
		
		<td><%=rs71.getString("Points") %></td>
		</tr>	
		<%}

	}




	}
	%>

	<tr> 
	<td colspan="4" align="center"><div align="center">
	<font size="5" ><b>
	<table border="1" >
	<tr >
	<td colspan="2" align="left"><div align="left">
	Pri-Sec Zero DVI Incentive Rate : </div></td>
	<td colspan="2" align="left"><div align="left">
	<%=zerodvirate1 %> For Total Trips >= 5</div> </td>
	 </tr>
	 <tr>
	<td colspan="2" align="right"></td>
	<td colspan="2" align="left"><div align="left">
	0 For Total Trips < 5 </div></td>
	</tr>
	<tr >
	<td colspan="2" align="left"><div align="left">
	Points for trip are forfeited : </div></td>
	<td colspan="2" align="left"><div align="left">
	1. Absence of registered Cleaner</div> </td>
	 </tr>
	<tr>
	<td colspan="2" align="right"></td>
	<td colspan="2" align="left"><div align="left">
	2. GPS Disconnection </div></td>
	</tr>
	<tr>
	<td colspan="2"></td>
	<td colspan="2" align="left"><div align="left">
	3. ND, CD, Stoppages, DH </div></td>
		</tr>
		<tr>
		<tr >

	<td colspan="2" align="left"><div align="left">
	Points for quarter are forfeited : </div></td>
	<td colspan="2" align="left"><div align="left">
	1. If our driver fails to report an incident</div> </td>
	 </tr>
	<tr>
	<td colspan="2" align="right"></td>
	<td colspan="2" align="left"><div align="left">
	2. If our driver fails to take steps to avoid an incident </div></td>
	</tr>
	</tr>
	</table>
	</b>
	</font>
	</div>
	</td> 
	</tr>
	</table>


	<%
	}
	else
	{
		 %>
		 <table width="30%" class="sortable" style="width: 600px;text-align: left">
		 <%
		 int i71=0;
		 String sql71="SELECT * FROM db_gps.t_DriverIncentive WHERE GPName = 'Castrol'";
		 ResultSet rs71 = st6.executeQuery(sql71);
		 if(rs71.next())
		 {	%>	
		 	<tr>
		 	<th colspan="4">
		 	Driver Incentive Card Rules
		 	</th>
		 	</tr>
		 	<tr class="cbFormTableRow">
		 	<th rowspan="2">SrNo</th>
		 	<th colspan="2">Parameter</th>
		 	<th  rowspan="2" width="95px">Points</th>
		 	</tr>
		 	<tr class="cbFormTableRow">
		 	
		 	<th width="250px">Catagory</th>
		 	<th width="95px">Range</th>
		 		</tr>	
		 	<%
		 rs71.previous();
		 int MaxDVI=0,MaxJRM=0;
		 while(rs71.next())
		 {
		 if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI") || rs71.getString("ScoreCategory").equalsIgnoreCase("JRM") )
		 {
		 	System.out.println(" in if :");
		 	i71++;
		 	%>
		 	<tr class="cbFormTableRow">
		 	<td><%=i71 %></td>
		 	<td><div align="left"><%=rs71.getString("ScoreCategory") %></div></td>
		 	<% if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI"))
		 	{
		 		if(rs71.getInt("Points")>MaxDVI)
		 		{			MaxDVI=rs71.getInt("Points");			
		 		}
		 	%>
		 	<td><%=rs71.getString("MinValue") %>-<%=rs71.getString("MaxValue") %></td>
		 	<%
		 	}
		 	else if (rs71.getString("ScoreCategory").equalsIgnoreCase("JRM"))
		 	{
		 		if(rs71.getInt("Points")>MaxJRM)
		 		{			
		 			MaxJRM=rs71.getInt("Points");
		 			System.out.println(" MaxJRM : "+MaxJRM);
		 		}
		 		System.out.println(" MaxJRM : "+MaxJRM);
		 	%>
		 		<td>NA</td><%	
		 	}
		 	else 
		 	{%>
		 		<td>NA</td><%	
		 	}
		 	%>	
		 	<td><%=rs71.getString("Points") %></td>
		 	</tr>	
		 	<%}

		 }
		 %>
		 <tr>
		 <td colspan="3">Total</td>
		 <%
		 System.out.println("Max DVI : "+MaxDVI+" MaxJRM : "+MaxJRM);
		 %> 
		 <td><% out.print(MaxJRM+MaxDVI); %></td>
		 </tr>


		 	<tr class="cbFormTableRow">
		 	<th >SrNo</th>
		 	<th >Category</th>
		 	<th  width="95px">Range</th>
		 	<th  width="95px">Maximum Earning Potential</th>
		 	
		 	</tr>

		 <%
		 i71=0;
		 rs71.last();
		 while(rs71.previous())
		 {
		 if(rs71.getString("ScoreCategory").equalsIgnoreCase("MaxTankerIncentive") )
		 {
		 	i71++;
		 	%>
		 	<tr class="cbFormTableRow">
		 	<td><%=i71 %></td>
		 	<td><div align="left">Maximum earning potential </div></td>
		 	<td>-</td>
		 	
		 	<td><%=rs71.getString("Points") %></td>
		 	</tr>	
		 	<%}

		 }




		 }
		 %>
		
		 <tr> 
		 <td colspan="4" align="center"><div align="center">
		 <font size="5" ><b>
		 <table border="2" >
		 <tr >
		<td colspan="2" align="left"><div align="left">
		Tanker Zero DVI Incentive Rate : </div></td>
		<td colspan="2" align="left"><div align="left">
		<%=zerodvirate1 %></div> </td>
	 	</tr>
		 <tr >

		 <td colspan="2" align="left"><div align="left">
		Points for trip are forfeited : </div></td>
		 <td colspan="2" align="left"><div align="left">
		 1. Absence of registered Cleaner</div> </td>
		  </tr>
		 <tr>
		 <td colspan="2" align="right"></td>
		 <td colspan="2" align="left"><div align="left">
		 2. GPS Disconnection </div></td>
		 </tr>
		 <tr>
		 <td colspan="2"></td>
		 <td colspan="2" align="left"><div align="left">
		 3. ND, CD, Stoppages, DH </div></td>
		 	</tr>
		 	<tr>
		 	<tr >

		 <td colspan="2" align="left"><div align="left">
		 Points for quarter are forfeited : </div></td>
		 <td colspan="2" align="left"><div align="left">
		 1. If our driver fails to report an incident</div> </td>
		  </tr>
		 <tr>
		 <td colspan="2" align="right"></td>
		 <td colspan="2" align="left"><div align="left">
		 2. If our driver fails to take steps to avoid an incident </div></td>
		 </tr>
		 </tr>
		 </table>
		 </b>
		 </font>
		 </div>
		 </td> 
		 </tr>
		 </table>
		 <%} 
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		con.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>
</jsp:useBean>
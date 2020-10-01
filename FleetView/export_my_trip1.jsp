
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"Trips_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn,conn1,conn2;
Statement st,st1,st2,st3,strip,st4,st5;
String fromdate, todate,sql,sql1,transporter,datenew1,datenew2,fromdatetime,todatetime,sortby1,origin,destination,type;

%>
<%

fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");
transporter=request.getParameter("transporter");
datenew1=request.getParameter("fromdate");
datenew2=request.getParameter("todate");
sortby1=request.getParameter("select");
origin=request.getParameter("origin");
destination=request.getParameter("destination");
type=request.getParameter("type");


%>

<table border="0" width="100%" align="center">
<tr><td align="center">
<div align="left"><font size="3">Report No:9.0</font></div>
<font size="3"><B>My Trips Report</B></font>
</td></tr>
<tr><td>
<%
NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2); 

try
{
	
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn2 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn1.createStatement();
strip=conn.createStatement();
st4=conn2.createStatement();
st5=conn.createStatement();
%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<%
if(sortby1.equalsIgnoreCase("primary"))
{
	%>
	
	<font  size="3"><B>Primary Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}	
else if(sortby1.equalsIgnoreCase("tanker"))
{
	%>
	<font  size="3"><B>Tanker Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}	
else if(sortby1.equalsIgnoreCase("secondary"))
{
	%>
	<font  size="3"><B>Secondary Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}
else
{
	%>
	<font  size="3"><B>All Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}	
	%>
 
</td>
</tr>
</table>
<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>Trip ID</th>
<th>Driver</th>
<th>Vehicle</th>
<th>Transporter</th>
<th>Start Date Time</th>
<th>Origin</th>
<th>Start Latitude</th>
<th>Start Longitude</th>
<th>End Date Time</th>
<th>Destination</th>
<th>End Latitude</th>
<th>End Longitude</th>
<th>Fixed Distance</th>
<th>Fixed Time</th>
<th>Distance Traveled</th>
<th>Time Taken</th>
<th>EndTrip Type</th>
<th>Category</th>
<th>Unit Replaced</th>
<th>Vehicle Attended</th>
<th>% Diff in Kms</th>
<th>End Comment</th>
<th>Issues</th>
</tr>
<%
String TripID,category,date1,date2,sqltrip="";
int i=1,j=1,k=0;
int dist1=0,dist2=0;
double stdDist=0,capDist=0,stdDist1=0,capDist1=0;
String bgcolor="";
//System.out.println(fromdate);
//System.out.println(todate);
//date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdate));
//date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todate));

//TripID=res.getString("tripid");

//List tripId=new ArrayList();
//System.out.print(type);

String trip="(";

if(type.equalsIgnoreCase("autoclose"))
			{
	String sql="Select Distinct(TripID) from t_startedjourney where (EndedBy='-' or EndedBy=' ') and GPName='Castrol' and StartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
	ResultSet rs=st2.executeQuery(sql);
	
	//System.out.println(sql);
	while(rs.next())
	{
		trip=trip+"'"+rs.getString("TripID")+"',";
	
		 k++;
	}
	 trip=trip+")";
	trip=trip.replace(",)",")");
			}

	//System.out.print("12345");
//System.out.print(trip);
if(type.equalsIgnoreCase("manual"))
			{
	String sql="Select Distinct(TripID) from t_startedjourney where LENGTH(EndedBy)>2 and GPName='Castrol' and StartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
	ResultSet res=st2.executeQuery(sql);
	//System.out.println(sql);
	while(res.next())
	{
		trip=trip+"'"+res.getString("TripID")+"',";
		
		 k++;
	}
	 trip=trip+")";
	trip=trip.replace(",)",")");
			}
//System.out.println(trip);
if(type.equalsIgnoreCase("all"))
{
String sql="Select Distinct(TripID) from t_startedjourney where GPName='Castrol' and StartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
ResultSet res=st2.executeQuery(sql);
//System.out.println(sql);

while(res.next())
{
trip=trip+"'"+res.getString("TripID")+"',";

k++;
}
trip=trip+")";
trip=trip.replace(",)",")");
}


//System.out.println("tripid-->"+trip);
//System.out.println("type-->"+type);
if(trip.equals("()"))
{
	//System.out.println("tripid--> empty");
	//break;
}
else
{

if((!(origin.equalsIgnoreCase("allorg"))) && (!(destination.equalsIgnoreCase("alldest"))))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and StartPlace='"+origin+"' and EndPlace='"+destination+"' order by StartDate ";
	System.out.print(sqltrip);
}
else if((!(origin.equalsIgnoreCase("allorg"))) && (destination.equalsIgnoreCase("alldest")))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and StartPlace='"+origin+"' order by StartDate ";
	 System.out.print(sqltrip);
}
else if((origin.equalsIgnoreCase("allorg")) && (!(destination.equalsIgnoreCase("alldest"))))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and EndPlace='"+destination+"' order by StartDate ";
	 System.out.print(sqltrip);
}
else if((origin.equalsIgnoreCase("allorg")) && (destination.equalsIgnoreCase("alldest")))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' order by StartDate ";
	 System.out.print(sqltrip);
}
			


ResultSet rstrip=strip.executeQuery(sqltrip);
while(rstrip.next())
{
	TripID=rstrip.getString("tripid");
	
//	System.out.print(TripID);
	
	String ss6="select Category from t_alljddata where TripId='"+TripID+"'";
	ResultSet rs6=st2.executeQuery(ss6);
	if(rs6.next())
	{
		category=rs6.getString("Category");
		if(sortby1.equalsIgnoreCase("primary"))	//primary
		{
			if(category.equalsIgnoreCase("Primary"))
			{
				sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
				
				ResultSet rst=st.executeQuery(sql);						
				java.util.Date enddte1,strdte1;
				int p=1;
				String slat,slon,elat,elon;
				String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
				long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
				if(rst.next())
				{
					//System.out.println("P-->>"+p);
					String finalComment="-",comment="-";
					int loop=0;
					String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
					ResultSet commentRst=st5.executeQuery(sql3);
					while(commentRst.next())
						{
							comment=commentRst.getString(1);
							if(!(comment.equalsIgnoreCase("-")))
							{
							  if(loop==0)
								{
									finalComment=comment+", ";
								}
							 else
								{
									finalComment+=comment+", ";		
								}
							loop++;
						}
		
				}
				if(!(finalComment.equalsIgnoreCase("-")))
				{
					finalComment=finalComment.substring(0,finalComment.lastIndexOf(","));
				}
					SDate=rst.getString("StartDate");
					EDate=rst.getString("EndDate");
					STime=rst.getString("StartTime");
					ETime=rst.getString("EndTime");
					endComment=rst.getString("Comment1");
					//tripid=rst.getString("TripId");

					if(null==STime || STime.length()>8 || STime.equals("-"))
					{
					STime="00:00:00";
					}

					if(null==ETime || ETime.equals("-"))
					{
					ETime="23:59:59";
					}
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
					miliseconds1=fd.getTime();
					}catch(Exception e1)
					{
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
					miliseconds1=fd.getTime();
					}catch(Exception e4)
					{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
					miliseconds1=fd.getTime();
					}
					}
					try{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
					miliseconds2=fd1.getTime();
					}catch(Exception e2)
					{
					try{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
					miliseconds2=fd1.getTime();
					}catch(Exception e5)
					{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
					miliseconds2=fd1.getTime();
					}
					}
					
					millisecdiff=miliseconds2-miliseconds1;
					secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; 

					try{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
					}catch(Exception e)
					{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
					}

					try{
						todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
					}catch(Exception e)
					{
						todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
					}
					
					  	
					//******************************distance difference******************************
					
					String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
					//System.out.println(sqlquery);
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ //System.out.println("12345");
					stdDist1=res1.getDouble("Km");
					//System.out.println(stdDist1);
					
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
				//System.out.println(capDist1);
					if(stdDist1==0)
					{
						//System.out.println("12345");
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
				//	System.out.println(diff);
					
					//System.out.println("abs diff="+Math.abs(diff));
					if(Math.abs(diff)>20)
					{
						//System.out.println("1");
						bgcolor="background-color:#FF0000";
					//	 System.out.println(bgcolor);
				 	 
					}
					else
					{
						
						 bgcolor="";
					}
			
				}
					
					
					
						%>
				
					<tr>
					<td style="text-align: right"><%=i%></td>
					<td><div align="right">
					<%=TripID%>
					
					</div></td>
					<td><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
					<td style="text-align: left"><%=rst.getString("VehRegNo")%></td>
					<td style="text-align: left"><%=rst.getString("OwnerName")%></td>
					<td style="text-align: left"><%
					try{ 
						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
						
//						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")).format(rst.getString("StartDate")));
					}catch(Exception ee)
					{
					//try{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
						

					}//catch(Exception eee)
					/*{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("StartDate"))+" 00:00:00");
					}
					}*/
					%></td>
					<td style="text-align: left"><%=rst.getString("StartPlace")%></td>
					<%
		double lat,lon;
		String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("StartPlace")+"' limit 1";
		ResultSet rst11=st2.executeQuery(sql11);
		if(rst11.next())
		{
			slat=rst11.getString("Latitude");
			slon=rst11.getString("Longitude");

			%>
			<td style="text-align: right"><%=rst11.getString("Latitude")%></td>
		    <td style="text-align: right"><%=rst11.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("StartPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				
				%>
				<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
			    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td><%="-" %></td>
				<td><%="-" %></td>
				<%
			}
		}


		}
		%>
		<td style="text-align: left"><%
		try{ 
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));

		/*if(null==rst.getString("EndTime"))
		{
		} 
		else
		{
		out.print(rst.getString("EndTime"));
		}*/

		}catch(Exception ee)
		{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);
//out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);


		}
		%></td>
		<td style="text-align: left"><%=rst.getString("EndPlace")%></td>
		<%

		String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
		ResultSet rst12=st2.executeQuery(sql12);
		if(rst12.next())
		{
			//slat=rst11.getString("Latitude");
			//slon=rst11.getString("Longitude");
			%>
			<td style="text-align: right"><%=rst12.getString("Latitude")%></td>
		    <td style="text-align: right"><%=rst12.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("EndPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("EndPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				%>
				<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
			    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td><%="-" %></td>
				<td><%="-" %></td>
				<%
			}
		}


		}
		%>
		<%
		//*********************************************qouery is changed*****************************************************
		sql="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'";
		//System.out.println(sql);
		ResultSet rstdist=st1.executeQuery(sql);
		if(rstdist.next())
		{ 
			stdDist=rstdist.getDouble("Km");

		%>
		<td style="text-align: right"><%=rstdist.getString("Km")%></td>
		<td style="text-align: right"><%=rstdist.getString("TTime")%></td>
		<%
		}
		else
		{
			stdDist=0;
		%>
			<td style="text-align: left"><%="NA" %></td>
			<td style="text-align: left"><%="NA" %></td>
		<%}
		%>
		<td style="text-align: right">
		<%
		//***************************************************************************************************************
	/*	int dist;
		dist=0; dist1=0; dist2=0;
		sql="select * from t_veh"+rst.getString("VehId")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+rst.getString("StartDate")+" "+STime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+rst.getString("EndDate")+" "+ETime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1 ";
		ResultSet rstdist1=st2.executeQuery(sql);
		if(rstdist1.next())
		{
		dist1=rstdist1.getInt("Distance");
		}
		sql="select * from t_veh"+rst.getString("VehId")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+rst.getString("EndDate")+" "+ETime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+rst.getString("StartDate")+" "+STime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		//out.print(sql);
		ResultSet rstdist2=st2.executeQuery(sql);

		if(rstdist2.next())
		{
		dist2=rstdist2.getInt("Distance");
		}
		if(dist2==0||dist1==0)
		{
		out.print("-");
		}
		else
		{ capDist=dist2-dist1;
		out.print(dist2-dist1);
		}*/
		capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
		%> 
		</td> 
		<td style="text-align: left">
		<%
		try{

		//String enddte=rst.getString("EndDate");
		//String endtme=rst.getString("EndTime");
		//String strtdte=rst.getString("StartDate");
		//String strtime=rst.getString("StartTime");

		//enddte=enddte+" "+endtme;
		//strtdte=strtdte+" "+strtime;
			try{
				enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
			}
			catch(Exception e)
			{
				enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
			}

		//java.util.Date enddte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddte);
		//java.util.Date strdte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(strtdte);

		String enddte=enddte1+" "+ETime;
		String strtdte=strdte1+" "+STime;

		long tmeinmils=enddte1.getTime()-strdte1.getTime();
		long hours=tmeinmils/(1000*60*60);
		String extractstrtminutes=STime.substring(3,5);
		String extractendminutes=ETime.substring(3,5);
		int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
		if(totmins >= 60)
		{
		hours=hours+1;
		totmins=totmins-60;
		}
		out.print(hours+" hrs "+totmins+" mins"); 
		}
		catch(Exception e)
		{
		out.print("-");
		}
		%>
		</td>



		<td style="text-align: left">
		<%
		String endedby;
		String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
		//System.out.println(sql);
		ResultSet rss=st2.executeQuery(sql);
		if(rss.next())
		{
			 endedby=rss.getString("EndedBy");
			if(endedby.equals("-") || endedby.equals(""))
			{
				out.print("Auto Closed");
			}
			else
			{
				out.print(endedby);
			}
		}

		%>
		</td>
		<td style="text-align: left"><%
		out.print("Primary");
		%></td>
		<%
		String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
		ResultSet rst13=st2.executeQuery(sql13);
		if(rst13.next())
		{
			%>

			<td style="text-align: left"><b><%="Yes" %></b></td>
			<%
		}
		else
		{
			%>
			<td style="text-align: left"><%="No" %></td>
			<%
		}


		
		%>
		
		<%
			String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
		//System.out.println(sql2);
		ResultSet rst2=st4.executeQuery(sql2);
		
		if(rst2.next())
		{%>
		<td style="text-align: left"><b>Attended</b></td>
			
			
			<%
		}
		else
		{%>
		<td style="text-align: left"><%="Not Attended" %></td>
		<%
			
		}

			%>
			
		
		
		<td>
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>

<td style="text-align: left"><%=endComment %></td>
<td style="text-align: left" ><%=finalComment %></td>
 
		</tr> 
		<%
				}
				i++;
			}//end of primary check
		}//end of primary sortby check
		else if(sortby1.equalsIgnoreCase("tanker"))
		{
			if(category.equalsIgnoreCase("BPL")||(category.equalsIgnoreCase("tanker")))
			{
				sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
				ResultSet rst=st.executeQuery(sql);
				
				java.util.Date enddte1,strdte1;
				int t=1;
				String slat,slon,elat,elon;
				String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
				long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
				if(rst.next())
				{
					//System.out.println("T-->>"+t);
				String finalComment="-",comment="-";
					int loop=0;
					String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
					ResultSet commentRst=st5.executeQuery(sql3);
					while(commentRst.next())
						{
							comment=commentRst.getString(1);
							if(!(comment.equalsIgnoreCase("-")))
							{
							  if(loop==0)
								{
									finalComment=comment+", ";
								}
							 else
								{
									finalComment+=comment+", ";		
								}
							loop++;
						}
		
				}
				if(!(finalComment.equalsIgnoreCase("-")))
				{
					finalComment=finalComment.substring(0,finalComment.lastIndexOf(","));
				}
				
					SDate=rst.getString("StartDate");
					EDate=rst.getString("EndDate");
					STime=rst.getString("StartTime");
					ETime=rst.getString("EndTime");
					endComment=rst.getString("Comment1");

					if(null==STime || STime.length()>8 || STime.equals("-"))
					{
					STime="00:00:00";
					}

					if(null==ETime || ETime.equals("-"))
					{
					ETime="23:59:59";
					}
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
					miliseconds1=fd.getTime();
					}catch(Exception e1)
					{
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
					miliseconds1=fd.getTime();
					}catch(Exception e4)
					{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
					miliseconds1=fd.getTime();
					}
					}
					try{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
					miliseconds2=fd1.getTime();
					}catch(Exception e2)
					{
					try{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
					miliseconds2=fd1.getTime();
					}catch(Exception e5)
					{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
					miliseconds2=fd1.getTime();
					}
					}
					
					millisecdiff=miliseconds2-miliseconds1;
					secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; 

					try{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
					}catch(Exception e)
					{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
					}

					try{
						todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
					}catch(Exception e)
					{
						todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
					}
					
					
					
					//******************************distance difference******************************
					
					String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
					//System.out.println(sqlquery);
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ //System.out.println("12345");
					stdDist1=res1.getDouble("Km");
				//	System.out.println(stdDist1);
					
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
				//System.out.println(capDist1);
					if(stdDist1==0)
					{
					//	System.out.println("12345");
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
				//	System.out.println(diff);
					
					//System.out.println("abs diff="+Math.abs(diff));
					if(Math.abs(diff)>20)
					{
						//System.out.println("1");
						bgcolor="background-color:#FF0000";
					//	 System.out.println(bgcolor);
				 	 
					}
					else
					{
						
						 bgcolor="";
					}
			
				}
					
					%>
					<tr>
					<td style="text-align: right"><%=i%></td>
					<td><div align="right">
					<%=TripID%>
					
					</div></td>
					<td><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
					<td style="text-align: left"><%=rst.getString("VehRegNo")%></td>
					<td style="ext-align: left"><%=rst.getString("OwnerName")%></td>
					<td style="text-align: left"><%
					try{ 
						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
						
//						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")).format(rst.getString("StartDate")));
					}catch(Exception ee)
					{
					//try{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
						

					}//catch(Exception eee)
					/*{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("StartDate"))+" 00:00:00");
					}
					}*/
					%></td>
					<td style="text-align: left"><%=rst.getString("StartPlace")%></td>
					<%
		double lat,lon;
		String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("StartPlace")+"' limit 1";
		ResultSet rst11=st2.executeQuery(sql11);
		if(rst11.next())
		{
			slat=rst11.getString("Latitude");
			slon=rst11.getString("Longitude");

			%>
			<td style="text-align: right"><%=rst11.getString("Latitude")%></td>
		    <td style="text-align: right"><%=rst11.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("StartPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				
				%>
				<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
			    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td style="text-align: right"><%="-" %></td>
				<td style="text-align: right"><%="-" %></td>
				<%
			}
		}


		}
		%>
		<td style="text-align: left"><%
		try{ 
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));

		/*if(null==rst.getString("EndTime"))
		{
		} 
		else
		{
		out.print(rst.getString("EndTime"));
		}*/

		}catch(Exception ee)
		{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);

//out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);

		}
		%></td>
		<td style="text-align: left"><%=rst.getString("EndPlace")%></td>
		<%

		String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
		ResultSet rst12=st2.executeQuery(sql12);
		if(rst12.next())
		{
			//slat=rst11.getString("Latitude");
			//slon=rst11.getString("Longitude");
			%>
			<td style="text-align: right"><%=rst12.getString("Latitude")%></td>
		    <td style="text-align: right"><%=rst12.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("EndPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("EndPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				%>
				<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
			    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td style="text-align: right"><%="-" %></td>
				<td style="text-align: right"><%="-" %></td>
				<%
			}
		}


		}
		%>
		<%
		//*********************************************qouery is changed*****************************************************
		sql="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'";
		//System.out.println(sql);
		ResultSet rstdist=st1.executeQuery(sql);
		if(rstdist.next())
		{ 
			stdDist=rstdist.getDouble("Km");

		%>
		<td style="text-align: right"><%=rstdist.getString("Km")%></td>
		<td style="text-align: right"><%=rstdist.getString("TTime")%></td>
		<%
		}
		else
		{
			stdDist=0;
		%>
			<td style="text-align: right"><%="NA" %></td>
			<td style="text-align: right"><%="NA" %></td>
		<%}
		%>
		<td style="text-align: right">
		<%
		//***************************************************************************************************************
		/*	int dist;
		dist=0; dist1=0; dist2=0;
		sql="select * from t_veh"+rst.getString("VehId")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+rst.getString("StartDate")+" "+STime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+rst.getString("EndDate")+" "+ETime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1 ";
		ResultSet rstdist1=st2.executeQuery(sql);
		if(rstdist1.next())
		{
		dist1=rstdist1.getInt("Distance");
		}
		sql="select * from t_veh"+rst.getString("VehId")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+rst.getString("EndDate")+" "+ETime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+rst.getString("StartDate")+" "+STime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		//out.print(sql);
		ResultSet rstdist2=st2.executeQuery(sql);

		if(rstdist2.next())
		{
		dist2=rstdist2.getInt("Distance");
		}
		if(dist2==0||dist1==0)
		{
		out.print("-");
		}
		else
		{ capDist=dist2-dist1;
		out.print(dist2-dist1);
		}*/
		capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
		%> 
		</td> 
		<td style="text-align: left">
		<%
		try{

		//String enddte=rst.getString("EndDate");
		//String endtme=rst.getString("EndTime");
		//String strtdte=rst.getString("StartDate");
		//String strtime=rst.getString("StartTime");

		//enddte=enddte+" "+endtme;
		//strtdte=strtdte+" "+strtime;
			try{
				enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
			}
			catch(Exception e)
			{
				enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
			}

		//java.util.Date enddte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddte);
		//java.util.Date strdte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(strtdte);

		String enddte=enddte1+" "+ETime;
		String strtdte=strdte1+" "+STime;

		long tmeinmils=enddte1.getTime()-strdte1.getTime();
		long hours=tmeinmils/(1000*60*60);
		String extractstrtminutes=STime.substring(3,5);
		String extractendminutes=ETime.substring(3,5);
		int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
		if(totmins >= 60)
		{
		hours=hours+1;
		totmins=totmins-60;
		}
		out.print(hours+" hrs "+totmins+" mins"); 
		}
		catch(Exception e)
		{
		out.print("-");
		}
		%>
		</td>



		<td style="text-align: left">
		<%
		String endedby;
		String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
		//System.out.println(sql);
		ResultSet rss=st2.executeQuery(sql);
		if(rss.next())
		{
			 endedby=rss.getString("EndedBy");
			if(endedby.equals("-") || endedby.equals(""))
			{
				out.print("Auto Closed");
			}
			else
			{
				out.print(endedby);
			}
		}

		%>
		</td>
		<td style="text-align: left"><%
		out.print("Tanker");
		%></td>
		<%
		String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
		ResultSet rst13=st2.executeQuery(sql13);
		if(rst13.next())
		{
			%>

			<td style="text-align: left"><b><%="Yes" %></b></td>
			<%
		}
		else
		{
			%>
			<td style="text-align: left"><%="No" %></td>
			<%
		}
		

		%>
		
		<%
			String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
		ResultSet rst2=st4.executeQuery(sql2);
		if(rst2.next())
		{%>
		<td style="text-align: left"><b>Attended</b></td>
			
			
			<%
		}
		else
		{%>
		<td style="text-align: left"><%="Not Attended" %></td>
		<%
			
		}

			%>
		
		<td>
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>
<td style="text-align: left"><%=endComment %></td>
<td style="text-align: left"><%=finalComment %></td>

		</tr> 
		<%
				}
				i++;
			}//end of tanker || bpl check
		}//end od sortby tanker check
		else if(sortby1.equalsIgnoreCase("secondary"))
		{
			if(!(category.equalsIgnoreCase("Primary") || category.equalsIgnoreCase("BPL") || category.equalsIgnoreCase("Tanker")))
			{
				sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
				ResultSet rst=st.executeQuery(sql);
				java.util.Date enddte1,strdte1;
				
				String slat,slon,elat,elon;
				String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
				long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
				if(rst.next())
				{
				
					String finalComment="-",comment="-";
					int loop=0;
					String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
					ResultSet commentRst=st5.executeQuery(sql3);
					while(commentRst.next())
						{
							comment=commentRst.getString(1);
							if(!(comment.equalsIgnoreCase("-")))
							{
							  if(loop==0)
								{
									finalComment=comment+", ";
								}
							 else
								{
									finalComment+=comment+", ";		
								}
							loop++;
						}
		
				}
				if(!(finalComment.equalsIgnoreCase("-")))
				{
					finalComment=finalComment.substring(0,finalComment.lastIndexOf(","));
				}
					
					SDate=rst.getString("StartDate");
					EDate=rst.getString("EndDate");
					STime=rst.getString("StartTime");
					ETime=rst.getString("EndTime");
					endComment=rst.getString("Comment1");

					if(null==STime || STime.length()>8 || STime.equals("-"))
					{
					STime="00:00:00";
					}

					if(null==ETime || ETime.equals("-"))
					{
					ETime="23:59:59";
					}
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
					miliseconds1=fd.getTime();
					}catch(Exception e1)
					{
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
					miliseconds1=fd.getTime();
					}catch(Exception e4)
					{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
					miliseconds1=fd.getTime();
					}
					}
					try{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
					miliseconds2=fd1.getTime();
					}catch(Exception e2)
					{
					try{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
					miliseconds2=fd1.getTime();
					}catch(Exception e5)
					{
					java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
					miliseconds2=fd1.getTime();
					}
					}
					
					millisecdiff=miliseconds2-miliseconds1;
					secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; 

					try{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
					}catch(Exception e)
					{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
					}

					try{
						todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
					}catch(Exception e)
					{
						todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
					}
					
					//******************************distance difference******************************
					
					String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
					//System.out.println(sqlquery);
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ //System.out.println("12345");
					stdDist1=res1.getDouble("Km");
				//	System.out.println(stdDist1);
					
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
				//System.out.println(capDist1);
					if(stdDist1==0)
					{
						//System.out.println("12345");
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
				//	System.out.println(diff);
					
					//System.out.println("abs diff="+Math.abs(diff));
					if(Math.abs(diff)>20)
					{
						//System.out.println("1");
						bgcolor="background-color:#FF0000";
					//	 System.out.println(bgcolor);
				 	 
					}
					else
					{
						
						 bgcolor="";
					}
			
				}
					
					
					
					
					
					%>
					<tr>
					<td style="text-align: right"><%=i%></td>
					<td><div align="right">
					<%=TripID%>
					
					</div></td>
					<td><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
					<td style="text-align: left"><%=rst.getString("VehRegNo")%></td>
					<td style="text-align: left"><%=rst.getString("OwnerName")%></td>
					<td style="text-align: left"><%
					try{ 
						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
						
//						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")).format(rst.getString("StartDate")));
					}catch(Exception ee)
					{
					//try{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
						

					}//catch(Exception eee)
					/*{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("StartDate"))+" 00:00:00");
					}
					}*/
					%></td>
					<td style="text-align: left"><%=rst.getString("StartPlace")%></td>
					<%
		double lat,lon;
		String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("StartPlace")+"' limit 1";
		ResultSet rst11=st2.executeQuery(sql11);
		if(rst11.next())
		{
			slat=rst11.getString("Latitude");
			slon=rst11.getString("Longitude");

			%>
			<td style="text-align: right"><%=rst11.getString("Latitude")%></td>
		    <td style="text-align: right"><%=rst11.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("StartPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				
				%>
				<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
			    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td style="text-align: right"><%="-" %></td>
				<td style="text-align: right"><%="-" %></td>
				<%
			}
		}


		}
		%>
		<td style="text-align: left"><%
		try{ 
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));

		/*if(null==rst.getString("EndTime"))
		{
		} 
		else
		{
		out.print(rst.getString("EndTime"));
		}*/

		}catch(Exception ee)
		{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);
	  //out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);


		}
		%></td>
		<td style="text-align: left"><%=rst.getString("EndPlace")%></td>
		<%

		String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
		ResultSet rst12=st2.executeQuery(sql12);
		if(rst12.next())
		{
			//slat=rst11.getString("Latitude");
			//slon=rst11.getString("Longitude");
			%>
			<td style="text-align: right"><%=rst12.getString("Latitude")%></td>
		    <td style="text-align: right"><%=rst12.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("EndPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("EndPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				%>
				<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
			    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td style="text-align: right"><%="-" %></td>
				<td style="text-align: right"><%="-" %></td>
				<%
			}
		}


		}
		%>
		<%
		//*********************************************qouery is changed*****************************************************
		sql="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'";
		//System.out.println(sql);
		ResultSet rstdist=st1.executeQuery(sql);
		if(rstdist.next())
		{ 
			stdDist=rstdist.getDouble("Km");

		%>
		<td style="text-align: right"><%=rstdist.getString("Km")%></td>
		<td style="text-align: right"><%=rstdist.getString("TTime")%></td>
		<%
		}
		else
		{
			stdDist=0;
		%>
			<td style="text-align: right"><%="NA" %></td>
			<td style="text-align: right"><%="NA" %></td>
		<%}
		%>
		<td style="text-align: right">
		<%
		//***************************************************************************************************************
		capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
		%> 
		</td> 
		<td style="text-align: left">
		<%
		try{

		//String enddte=rst.getString("EndDate");
		//String endtme=rst.getString("EndTime");
		//String strtdte=rst.getString("StartDate");
		//String strtime=rst.getString("StartTime");

		//enddte=enddte+" "+endtme;
		//strtdte=strtdte+" "+strtime;
			try{
				enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
			}
			catch(Exception e)
			{
				enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
			}

		//java.util.Date enddte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddte);
		//java.util.Date strdte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(strtdte);

		String enddte=enddte1+" "+ETime;
		String strtdte=strdte1+" "+STime;

		long tmeinmils=enddte1.getTime()-strdte1.getTime();
		long hours=tmeinmils/(1000*60*60);
		String extractstrtminutes=STime.substring(3,5);
		String extractendminutes=ETime.substring(3,5);
		int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
		if(totmins >= 60)
		{
		hours=hours+1;
		totmins=totmins-60;
		}
		out.print(hours+" hrs "+totmins+" mins"); 
		}
		catch(Exception e)
		{
		out.print("-");
		}
		%>
		</td>



		<td style="text-align: left">
		<%
		String endedby;
		String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
		//System.out.println(sql);
		ResultSet rss=st2.executeQuery(sql);
		if(rss.next())
		{
			 endedby=rss.getString("EndedBy");
			if(endedby.equals("-") || endedby.equals(""))
			{
				out.print("Auto Closed");
			}
			else
			{
				out.print(endedby);
			}
		}

		%>
		</td>
		<td style="text-align: left"> <%
		out.print("Secondary");
		%></td>
		<%
		String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
		ResultSet rst13=st2.executeQuery(sql13);
		if(rst13.next())
		{
			%>

			<td style="text-align: left"><b><%="Yes" %></b></td>
			<%
		}
		else
		{
			%>
			<td style="text-align: left"><%="No" %></td>
			<%
		}

%>
		
		<%
			String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
		ResultSet rst2=st4.executeQuery(sql2);
		if(rst2.next())
		{%>
		<td style="text-align: left"><b>Attended</b></td>
			
			
			<%
		}
		else
		{%>
		<td style="text-align: left"><%="Not Attended" %></td>
		<%
			
		}

			%>
			
			<td>
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>
<td style="text-align: left"><%=endComment %></td>
<td style="text-align: left"><%=finalComment %></td>

		</tr> 
		<%
				}
				i++;
			}//end of secondary check
		}//end od sortby secondary check
		
		else if(sortby1.equalsIgnoreCase("all"))//for all trips
		{
			//System.out.println("\n\nall");
			sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
			ResultSet rst=st.executeQuery(sql);
			
			java.util.Date enddte1,strdte1;
			
			String slat,slon,elat,elon;
			String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
			long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
			if(rst.next())
			{
				
				
				String finalComment="-",comment="-";
				int loop=0;
				String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
				ResultSet commentRst=st5.executeQuery(sql3);
				while(commentRst.next())
					{
						comment=commentRst.getString(1);
						if(!(comment.equalsIgnoreCase("-")))
						{
						  if(loop==0)
							{
								finalComment=comment+", ";
							}
						 else
							{
								finalComment+=comment+", ";		
							}
						loop++;
					}
	
			}
			if(!(finalComment.equalsIgnoreCase("-")))
			{
				finalComment=finalComment.substring(0,finalComment.lastIndexOf(","));
			}	
			
				SDate=rst.getString("StartDate");
				EDate=rst.getString("EndDate");
				STime=rst.getString("StartTime");
				ETime=rst.getString("EndTime");
				endComment=rst.getString("Comment1");

				if(null==STime || STime.length()>8 || STime.equals("-"))
				{
				STime="00:00:00";
				}

				if(null==ETime || ETime.equals("-"))
				{
				ETime="23:59:59";
				}
				try{
				java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
				miliseconds1=fd.getTime();
				}catch(Exception e1)
				{
				try{
				java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
				miliseconds1=fd.getTime();
				}catch(Exception e4)
				{
				java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
				miliseconds1=fd.getTime();
				}
				}
				try{
				java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
				miliseconds2=fd1.getTime();
				}catch(Exception e2)
				{
				try{
				java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
				miliseconds2=fd1.getTime();
				}catch(Exception e5)
				{
				java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
				miliseconds2=fd1.getTime();
				}
				}
				
				millisecdiff=miliseconds2-miliseconds1;
				secdiff=millisecdiff/1000;
				mindiff=secdiff/60;
				hrdiff=mindiff/60; 
			//	System.out.println("start"+rst.getString("StartDate"));
			//	System.out.println("EndDate"+rst.getString("EndDate"));
				

				try{
					fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
				}catch(Exception e)
				{
					fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")));
				}

				try{
					todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
				}catch(Exception e)
				{
					todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")));
				}
				
				
				
//******************************distance difference******************************
				
			String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
					//System.out.println(sqlquery);
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ //System.out.println("12345");
					stdDist1=res1.getDouble("Km");
				//	System.out.println(stdDist1);
					
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
				//System.out.println(capDist1);
					if(stdDist1==0)
					{
						//System.out.println("12345");
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
				//	System.out.println(diff);
					
					//System.out.println("abs diff="+Math.abs(diff));
					if(Math.abs(diff)>20)
					{
						//System.out.println("1");
						bgcolor="background-color:#FF0000";
					//	 System.out.println(bgcolor);
				 	 
					}
					else
					{
						
						 bgcolor="";
					}
			
				}
				
				
				//************************************************************************
				
				%>
				<tr ">
				<!--tr bgcolor="< %=bgcolor%>"-->
				<td align="right"><%=i%></td>
				<td><div align="right">
					<%=TripID%>
					
					</div></td>
				<td><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
				<td style="text-align: left"><%=rst.getString("VehRegNo")%></td>
				<td style="text-align: left"><%=rst.getString("OwnerName")%></td>
				<td style="text-align: left"><%
				try{ 
					out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
					
//					out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")).format(rst.getString("StartDate")));
				}catch(Exception ee)
				{
				//try{
					out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
					

				}//catch(Exception eee)
				/*{
					out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("StartDate"))+" 00:00:00");
				}
				}*/
				%></td>
				<td style="text-align: left"><%=rst.getString("StartPlace")%></td>
				<%
	double lat,lon;
	String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("StartPlace")+"' limit 1";
	ResultSet rst11=st2.executeQuery(sql11);
	if(rst11.next())
	{
		slat=rst11.getString("Latitude");
		slon=rst11.getString("Longitude");

		%>
		<td style="text-align: right"><%=rst11.getString("Latitude")%></td>
	    <td style="text-align: right"><%=rst11.getString("Longitude")%></td>
		<%
	}
	else
	{

	String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"'";
	ResultSet rstg=st2.executeQuery(sqlg);
	if(rstg.next())
	{
		%>
		<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
	    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
		<%
	}
	else
	{
		String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("StartPlace")+"'";
		ResultSet rstg1=st2.executeQuery(sqlg1);
		if(rstg1.next())
		{
			
			%>
			<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
			<%
		}
		else
		{
			%>
			<td style="text-align: right"><%="-" %></td>
			<td style="text-align: right"><%="-" %></td>
			<%
		}
	}


	}
	%>
	<td style="text-align: left"><%
	try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));
	//out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
	/*if(null==rst.getString("EndTime"))
	{
	} 
	else
	{
	out.print(rst.getString("EndTime"));
	}*/

	}catch(Exception ee)
	{
		
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);	
	
	//out.print((new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"))+"<br>"+ETime)));
//out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);


	}
	%></td>
	<td style="text-align: left"><%=rst.getString("EndPlace")%></td>
	<%

	String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
	ResultSet rst12=st2.executeQuery(sql12);
	if(rst12.next())
	{
		//slat=rst11.getString("Latitude");
		//slon=rst11.getString("Longitude");
		%>
		<td style="text-align: right"><%=rst12.getString("Latitude")%></td>
	    <td style="text-align: right"><%=rst12.getString("Longitude")%></td>
		<%
	}
	else
	{

	String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("EndPlace")+"'";
	ResultSet rstg=st2.executeQuery(sqlg);
	if(rstg.next())
	{
		%>
		<td style="text-align: right"><%=rstg.getString("Startlat")%></td>
	    <td style="text-align: right"><%=rstg.getString("Startlong")%></td>
		<%
	}
	else
	{
		String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("EndPlace")+"'";
		ResultSet rstg1=st2.executeQuery(sqlg1);
		if(rstg1.next())
		{
			%>
			<td style="text-align: right"><%=rstg.getString("Endlat")%></td>
		    <td style="text-align: right"><%=rstg.getString("Endlong")%></td>
			<%
		}
		else
		{
			%>
			<td style="text-align: right"><%="-" %></td>
			<td style="text-align: right"><%="-" %></td>
			<%
		}
	}


	}
	%>
	<%
	//*********************************************qouery is changed*****************************************************
	sql="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'";
	//System.out.println(sql);
	ResultSet rstdist=st1.executeQuery(sql);
	if(rstdist.next())
	{ 
		stdDist=rstdist.getDouble("Km");

	%>
	<td style="text-align: right"><%=rstdist.getString("Km")%></td>
	<td style="text-align: right"><%=rstdist.getString("TTime")%></td>
	<%
	}
	else
	{
		stdDist=0;
	%>
		<td style="text-align: left"><%="NA" %></td>
		<td style="text-align: left"><%="NA" %></td>
	<%}
	%>
	<td style="text-align: right">
	<%
	//***************************************************************************************************************
	capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
	%> 
	</td> 
	<td style="text-align: right">
	<%
	try{

	//String enddte=rst.getString("EndDate");
	//String endtme=rst.getString("EndTime");
	//String strtdte=rst.getString("StartDate");
	//String strtime=rst.getString("StartTime");

	//enddte=enddte+" "+endtme;
	//strtdte=strtdte+" "+strtime;
		try{
			enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
			strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
		}
		catch(Exception e)
		{
			enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
			strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
		}

	//java.util.Date enddte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddte);
	//java.util.Date strdte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(strtdte);

	String enddte=enddte1+" "+ETime;
	String strtdte=strdte1+" "+STime;

	long tmeinmils=enddte1.getTime()-strdte1.getTime();
	long hours=tmeinmils/(1000*60*60);
	String extractstrtminutes=STime.substring(3,5);
	String extractendminutes=ETime.substring(3,5);
	int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
	if(totmins >= 60)
	{
	hours=hours+1;
	totmins=totmins-60;
	}
	out.print(hours+" hrs "+totmins+" mins"); 
	}
	catch(Exception e)
	{
	out.print("-");
	}
	%>
	</td>



	<td style="text-align: left">
	<%
	String endedby;
	String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
	//System.out.println(sql);
	ResultSet rss=st2.executeQuery(sql);
	if(rss.next())
	{
		 endedby=rss.getString("EndedBy");
		if(endedby.equals("-") || endedby.equals(""))
		{
			out.print("Auto Closed");
		}
		else
		{
			out.print(endedby);
		}
	}

	%>
	</td>
	<td style="text-align: left"><%
	if(category.equalsIgnoreCase("Primary"))
	{
		out.print("Primary");
	}
	else if(category.equalsIgnoreCase("BPL")||category.equalsIgnoreCase("Tanker"))
	{
		out.print("Tanker");
	}
	else 
	{
		out.print("Secondary");
	}
	
	
	
	%></td>
	<%
	String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
	ResultSet rst13=st2.executeQuery(sql13);
	if(rst13.next())
	{
		%>

		<td style="text-align: left"><b><%="Yes" %></b></a></td>
		<%
	}
	else
	{
		%>
		<td style="text-align: left"><%="No" %></td>
		<%
	}

	%>
	
<%

String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
ResultSet rst2=st4.executeQuery(sql2);
if(rst2.next())
{%>
<td style="text-align: right"><b>Attended</b></td>
	
	
	<%
}
else
{%>
<td style="text-align: right"><%="Not Attended" %></td>
<%
	
}

	%>
	
	<td>
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>
<td style="text-align: left"><%=endComment %></td>
<td style="text-align: left"><%=finalComment %></td>

	</tr>
	<%
	}
			i++;
		}//end of ALL code
		
			
			
			
		
	}//end of if category check loop
	
	//i++;
	
	
}//end of while loop
}
%>
</table> 
<%
}catch(Exception e)
{
out.print("Exception -->"+e);
}
finally
{
	try
	{
conn.close();
	}
	catch(Exception e){}
	try
	{
conn1.close();
	}
	catch(Exception e){}
	try
	{
conn2.close();
	}
	catch(Exception e){}
}


%>
</td></tr>
</table>
<%@ include file="footernew.jsp" %>
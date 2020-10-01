<%@ include file="headernew.jsp"%>
<%@page import="java.sql.*" import="java.sql.DriverManager"
	import="java.sql.ResultSet" import="java.sql.Statement"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<% 
	try{
     //System.out.println("Hi!!!");
	String user = session.getAttribute("usertypevalue").toString();
	Connection conn1 = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null;
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st =  conn1.createStatement();
	st1 =  conn1.createStatement();
	st2 =  conn1.createStatement();
	
	String vehicleCode = request.getParameter("vehicleCode");
	String VehicleRegNo = request.getParameter("VehicleRegNo");
	String fromDateTime = request.getParameter("fromDateTime");
	String toDateTime = request.getParameter("toDateTime");
	String ownerName = request.getParameter("ownerName");
	System.out.println("fromDateTime "+fromDateTime);
	System.out.println("toDateTime "+toDateTime);
	System.out.println("ownerName "+ownerName);
	String opt = request.getParameter("opt");
	%>
	<form id="doorsensor" name="doorsensor" action="" method="post">

<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">
		<table width="100%" border="0" align="center">	

	<tr>
		<th colspan="3" align="center"><font size="3">
		<%
		if(opt == "0" || opt.equals("0"))
		{
		%>
		Door 1 Access Detail Report for <%=user%> &nbsp;Vehicle Registration
		No. <%=VehicleRegNo%>&nbsp; from <%=new SimpleDateFormat("dd-MMM-yyyy").
		format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDateTime))%>&nbsp;
		to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDateTime))%>
		<%
		}
		else
			if(opt == "1" || opt.equals("1"))
			{
				%>
				Door 2 Access Detail Report for <%=user%> &nbsp;Vehicle Registration
				No. <%=VehicleRegNo%>&nbsp; from <%=new SimpleDateFormat("dd-MMM-yyyy").
				format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDateTime))%>&nbsp;
				to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDateTime))%>
				<%
			}
		%>
		</font>
		<div align="right">
		 Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %>
		</div>
		</th>
		</tr>
		</table>
		</td>
		</tr>
		</table>
		
		<table border="0" width="100%" class="stats" align="center">
		<tr align="center">
		<td align="center">
		<div>
     	<table border="1" class="sortable" align="center">
		<tr>

		<td class="hed">
		<div class="bodyText"><b> Sr. </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> Transporter </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> VehicleRegNumber </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Door Open/Closed</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>From Location</b></div>
		</td>
		
		
	</tr>
	<%
			int i = 1;
			//int j = 0;
			boolean flag=false;
			String fromLocation="",toLocation="",distance="",duration="",tripid="";
			String location1="",location2="",data1="",data2="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;
			double lat2=0.00,lat3=0.00,lon2=0.00,lon3=0.00;
			java.util.Date date=null;
			java.util.Date date1=null;
			java.util.Date date2=null;
			java.util.Date date3=null;
			long time=00,time1=00,time2=00,time3=00;
			String offtime="";
			String ontime="";
			long millis1=00;
			long millis2=00;
			long millis3=00;
			long hrs=00, min=00;
			int x=1;
			String stamp = "";
			String stamp1 = "";
			String sql1="";
			if(opt == "0" || opt.equals("0"))
			{
			sql1="Select TheFiledTextFileName,TheFieldSubject,Thefielddatadatetime,LatinDec,LonginDec from db_gps.t_veh"+vehicleCode+" where TheFiledTextFileName in ('DO1','DS1') and TheFieldDataDate between '"+fromDateTime+"' and '"+toDateTime+"' order by Thefielddatadatetime";
			}
			else
				if(opt == "1" || opt.equals("1"))
			{
					sql1="Select TheFiledTextFileName,TheFieldSubject,Thefielddatadatetime,LatinDec,LonginDec from db_gps.t_veh"+vehicleCode+" where TheFiledTextFileName in ('DO2','DS2') and TheFieldDataDate between '"+fromDateTime+"' and '"+toDateTime+"' order by Thefielddatadatetime";
			}
			System.out.println("------>   "+sql1);
			ResultSet rs2=st1.executeQuery(sql1);
			if(rs2.next())
			{
				stamp =rs2.getString("TheFiledTextFileName");
				location1=rs2.getString("TheFieldSubject");
				data1=rs2.getString("Thefielddatadatetime");
				lat2=rs2.getDouble("LatinDec");
				lon2=rs2.getDouble("LonginDec");
			}
			
			if(rs2.last())
			{
				stamp1 = rs2.getString("TheFiledTextFileName");
				location2=rs2.getString("TheFieldSubject");
				data2=rs2.getString("Thefielddatadatetime");
				lat3=rs2.getDouble("LatinDec");
				lon3=rs2.getDouble("LonginDec");
			}
			
			System.out.println("$$$$$$$$    "+stamp+"  *****   "+stamp1);
			
			if(stamp=="DO1" || stamp.equalsIgnoreCase("DO1") || stamp=="DO2" || stamp.equalsIgnoreCase("DO2"))
			{
				
			}
			else
				if(stamp=="DS1" || stamp.equalsIgnoreCase("DS1")  || stamp=="DS2" || stamp.equalsIgnoreCase("DS2"))
				{
					 %>
		    		   <tr>
               <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
              <td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
              <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=VehicleRegNo %></font></div></td>
               <td class="bodytext"><div align="right"><font size="2" face="Arial">Closed</font></div></td>
				<td class="bodytext"><div align="right"><font size="2" face="Arial"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data1)) %></font></div></td>
				<td class="bodytext"><div align="left"><font size="2" face="Arial"><a href="javascript: flase;"
		        onClick="window.open ('shownewmap.jsp?lat=<%=lat2%>&long=<%=lon2%>&discription=<%=location1%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">
		        <%=location1%></a></font></div></td>
			</tr><%
		    		   i++;
				}
			
			if(opt == "0" || opt.equals("0"))
			{
			 sql1="SELECT a.VehCode,a.TheDate,a.TheTime,a.Lat,a.Lon,b.TheDate,b.TheTime,b.Lat,b.Lon,b.VehCode,a.stamp,b.stamp,a.location,b.location "
				  +" FROM "
				  +"  (select VehCode,TheDate,TheTime,Lat,Lon,stamp,location "
				  +" FROM db_gps.t_dooropen "
				  +"  ) a "
				  +" INNER JOIN db_gps.t_doorclose b "
				  +" ON ( a.VehCode=b.VehCode "
				  +"	AND concat(b.TheDate,' ',b.TheTime) = (select concat(c.thedate,' ',c.thetime) from db_gps.t_doorclose c WHERE c.vehcode= a.vehcode and concat(c.thedate,' ',c.thetime) > concat(a.thedate,' ',a.thetime)  and c.stamp = 'DS1' order by c.thedate,c.thetime asc limit 1) )"   
				  +" WHERE a.TheDate >='"+fromDateTime+"' AND a.TheDate <='"+toDateTime+"'"
				  +" AND a.VehCode ="+vehicleCode
				  +" And a.stamp = 'DO1'"
				  +"  ORDER BY a.TheDate,a.TheTime ASC";
			}
			else
				if(opt == "1" || opt.equals("1"))
				{
					sql1="SELECT a.VehCode,a.TheDate,a.TheTime,a.Lat,a.Lon,b.TheDate,b.TheTime,b.Lat,b.Lon,b.VehCode,a.stamp,b.stamp,a.location,b.location "
						  +" FROM "
						  +"  (select VehCode,TheDate,TheTime,Lat,Lon,stamp,location "
						  +" FROM db_gps.t_dooropen "
						  +"  ) a "
						  +" INNER JOIN db_gps.t_doorclose b "
						  +" ON ( a.VehCode=b.VehCode "
						  +"	AND concat(b.TheDate,' ',b.TheTime) = (select concat(c.thedate,' ',c.thetime) from db_gps.t_doorclose c WHERE c.vehcode= a.vehcode and concat(c.thedate,' ',c.thetime) > concat(a.thedate,' ',a.thetime) and c.stamp = 'DS2' order by c.thedate,c.thetime asc limit 1) )"   
						  +" WHERE a.TheDate >='"+fromDateTime+"' AND a.TheDate <='"+toDateTime+"'"
						  +" AND a.VehCode ="+vehicleCode
						  +" And a.stamp = 'DO2'"
						  +"  ORDER BY a.TheDate,a.TheTime ASC";
				}
			
			System.out.println("%%%%%%%% "+sql1);
			 rs2=st.executeQuery(sql1);
			
			while(rs2.next())
			{
				if(x==1)
				{
				System.out.println(" ######## "+rs2.getString("a.TheDate")+" ###### "+rs2.getString("a.TheTime"));
				System.out.println(" ######## "+rs2.getString("b.TheDate")+" ###### "+rs2.getString("b.TheTime"));
				String offdate=rs2.getString("a.TheDate");
				String  ondate=rs2.getString("b.TheDate");
				offtime=rs2.getString("a.TheTime");
				ontime=rs2.getString("b.TheTime");
				date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("a.TheDate")+" "+rs2.getString("a.TheTime"));
			    time1=date.getTime();
			    
			    date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
				time2=date1.getTime();
				
				time3=time2-time1;
				time3=time3/1000/60;
				
				double lat=rs2.getDouble("a.Lat");
				 double lon=rs2.getDouble("a.Lon");
				 double lat1=rs2.getDouble("b.Lat");
				 double lon1=rs2.getDouble("b.Lon");
				 
				
				 date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
					time=date2.getTime();
					%>
			    		   <tr>
	                <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
	                <td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
	                <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=VehicleRegNo %></font></div></td>
	                <td class="bodytext"><div align="right"><font size="2" face="Arial">Opened</font></div></td>
					<td class="bodytext"><div align="right"><font size="2" face="Arial"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(date) %></font></div></td>
					<td class="bodytext"><div align="left"><font size="2" face="Arial"><a href="javascript: flase;"
			        onClick="window.open ('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%=rs2.getString("a.location")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">
			        <%=rs2.getString("a.location") %></a></font></div></td>
					</tr><%
			    		   i++;
					%>
		    		   <tr>
             <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
             <td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
             <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=VehicleRegNo %></font></div></td>
             <td class="bodytext"><div align="right"><font size="2" face="Arial">Closed</font></div></td>
				<td class="bodytext"><div align="right"><font size="2" face="Arial"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(date1) %></font></div></td>
				<td class="bodytext"><div align="left"><font size="2" face="Arial"><a href="javascript: flase;"
		        onClick="window.open ('shownewmap.jsp?lat=<%=lat1%>&long=<%=lon1%>&discription=<%=rs2.getString("b.location")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">
		        <%=rs2.getString("b.location") %></a></font></div></td>
				</tr><%
			       i++;
				x++;
				}
				else
				{
					System.out.println(" ######## "+rs2.getString("a.TheDate")+" ###### "+rs2.getString("a.TheTime"));
					System.out.println(" ######## "+rs2.getString("b.TheDate")+" ###### "+rs2.getString("b.TheTime"));
					String offdate=rs2.getString("a.TheDate");
					String  ondate=rs2.getString("b.TheDate");
					offtime=rs2.getString("a.TheTime");
					ontime=rs2.getString("b.TheTime");
					date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("a.TheDate")+" "+rs2.getString("a.TheTime"));
				    time1=date.getTime();
				    
				    date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
					time2=date1.getTime();
					
					time3=time2-time1;
					time3=time3/1000/60;
					
					double lat=rs2.getDouble("a.Lat");
					 double lon=rs2.getDouble("a.Lon");
					 double lat1=rs2.getDouble("b.Lat");
					 double lon1=rs2.getDouble("b.Lon");
					 
					if(time1>time)
					{
				
						date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
						time=date2.getTime();

				    		   %>
				    		   <tr>
		                <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
		                <td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
		                <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=VehicleRegNo %></font></div></td>
		                <td class="bodytext"><div align="right"><font size="2" face="Arial">Opened</font></div></td>
						<td class="bodytext"><div align="right"><font size="2" face="Arial"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(date) %></font></div></td>
						<td class="bodytext"><div align="left"><font size="2" face="Arial"><a href="javascript: flase;"
				        onClick="window.open ('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%=rs2.getString("a.location")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">
				        <%=rs2.getString("a.location") %></a></font></div></td>
					    </tr>
					    <%
				    		   i++;
					    %>
			    		   <tr>
	                <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
	                <td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
	                <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=VehicleRegNo %></font></div></td>
	                <td class="bodytext"><div align="right"><font size="2" face="Arial">Closed</font></div></td>
					<td class="bodytext"><div align="right"><font size="2" face="Arial"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(date1) %></font></div></td>
					<td class="bodytext"><div align="left"><font size="2" face="Arial"><a href="javascript: flase;"
			        onClick="window.open ('shownewmap.jsp?lat=<%=lat1%>&long=<%=lon1%>&discription=<%=rs2.getString("b.location")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">
			        <%=rs2.getString("b.location") %></a></font></div></td>
				    </tr>
				    <%
			    		   i++;
				   
					} 
					 x++;  
				}
				
			      }
			 if(stamp1=="DO1" || stamp1.equalsIgnoreCase("DO1")  || stamp=="DO2" || stamp.equalsIgnoreCase("DO2"))
				{
				 %>
	    		   <tr>
      			   <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
     			   <td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
      			   <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=VehicleRegNo %></font></div></td>
        		   <td class="bodytext"><div align="right"><font size="2" face="Arial">Opened</font></div></td>
				   <td class="bodytext"><div align="right"><font size="2" face="Arial"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data2)) %></font></div></td>
				   <td class="bodytext"><div align="left"><font size="2" face="Arial"><a href="javascript: flase;"
	               onClick="window.open ('shownewmap.jsp?lat=<%=lat3%>&long=<%=lon3%>&discription=<%=location2%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">
	              <%=location2%></a></font></div></td>
		          </tr><%
	    		   i++;
				}
			
			st2.close();
			st1.close();
				st.close();
				conn1.close();
						}
	catch(Exception e)
	{
		e.printStackTrace();
		System.out.println("Exception---------------> "+e);
		
	}
	
		
	
	
	%>
	</table>
	</div>
	</td>
	</tr>
	</table>
    </form>
    </body>
    </html>
    <%@ include file="footernew.jsp"%>
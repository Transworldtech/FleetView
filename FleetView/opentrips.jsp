<%@ include file="headerenduser.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script type="text/javascript">
</script>
<%! Connection conn;%>
<%
	try
	{
	       System.out.println("********    in opentrips");
			conn = fleetview.ReturnConnection();
			Statement st=null,st1=null,st2=null,st3 = null;
			String sql=null;
			ResultSet rst=null;
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			st3=conn.createStatement();
			String typevalue = session.getAttribute("usertypevalue").toString();
			 System.out.println("********   "+typevalue);
			String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			String currenttime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
			int tripcnt = 0;
			sql = "select vehcode from db_gps.t_group where GPName = '"+typevalue+"' ";
			rst = st.executeQuery(sql);
			while(rst.next())
			{
				String sqlcheckopen = "select *  from db_gps.t_startedjourney where  vehid  = '"+rst.getString("vehcode")+"' order by StartDate desc limit 1";
				ResultSet rchkopen = st1.executeQuery(sqlcheckopen);
				if(rchkopen.next())
				{
					if(rchkopen.getString("JStatus") == "Running" || rchkopen.getString("JStatus").equalsIgnoreCase("Running") || rchkopen.getString("JStatus") == "tobeclosed" || rchkopen.getString("JStatus").equalsIgnoreCase("tobeclosed"))
					{
						tripcnt++;
					}
				}
			}
			
			if(tripcnt == 0)
			{
				%>
				<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	No Open Trips</div>
				<%
			}
			else
			{
%>

<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	Open Trips</div>
<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="customdetail" method="get">
<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
			<td>
			<table align="center" class="sortable">
			<tr><th><div align="center"><font size="2"><b>Sr. No.</b></font></div></th>
			<th><div align="center"><font size="2"><b>VehRegNo</b></font></div></th>
			<th><div align="center"><font size="2"><b>TripID</b></font></div></th>
			<th><div align="center"><font size="2"><b>Updated Date</b></font></div></th>
			<th><div align="center"><font size="2"><b>Location</b></font></div></th>
			<th><div align="center"><font size="2"><b>Product Carrying</b></font></div></th>
			<th><div align="center"><font size="2"><b>origin</b></font></div></th>
			<th><div align="center"><font size="2"><b>Destination</b></font></div></th>
			<th><div align="center"><font size="2"><b>ETA</b></font></div></th>
			<th><div align="center"><font size="2"><b>Distance to go</b></font></div></th>
			</tr>
			
		<%
		int i=1;
		sql = "select * from db_gps.t_group where GPName = '"+typevalue+"' ";
		
		ResultSet rs = st.executeQuery(sql);
		System.out.println("********   "+sql);
		while(rs.next())
		{
			double totKm = 0,remKm=0;
			long tTime = 0;
			String sql1 = "select * from db_gps.t_startedjourney where Vehid = '"+rs.getString("vehcode")+"'  order by StartDate desc limit 1";
			System.out.println("********   "+sql1);
			ResultSet rs1 = st1.executeQuery(sql1);
			if(rs1.next())
			{
				if(rs1.getString("JStatus") == "Running" || rs1.getString("JStatus").equalsIgnoreCase("Running") || rs1.getString("JStatus") == "tobeclosed" || rs1.getString("JStatus").equalsIgnoreCase("tobeclosed"))
				{
					System.out.println("********   "+rs1.getString("JStatus"));
				String comments=rs1.getString("Loadcomments");
				totKm=rs1.getDouble("FIxedKM");
			    tTime=rs1.getLong("FIxedTime"); 
			     String ETA1=rs1.getString("ETA");
			     String ETADate=ETA1;
			     System.out.println("\n\n ETA from table-->>"+ETA1);
			     int kmrun1 = 0,kmrun2 = 0,kmrundist = 0,distogo = 0;
			     String DisDate = "";
			      if(!(null==ETA1))
			      {
			       ETA1=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA1));
			      }
				%>
				<tr>
				<td align="right"><div align="right"><font size="2" ><%=i%></font></div></td>
				<td align="left"><div align="left"><font size="2" ><%=rs1.getString("VehRegNo") %></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%=rs1.getString("tripid")%></font></div></td>
				<%
				String updateddate = "-",location = "-";
				int distance = 0;
				String sql2 = "select * from db_gps.t_onlinedata where vehiclecode = '"+rs1.getString("Vehid")+"' ";
				ResultSet rs2 = st2.executeQuery(sql2);
				if(rs2.next())
				{
					distance = rs2.getInt("TheDistance");
					%>
					<td align="right"><div align="right"><font size="2" ><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("TheDate")+" "+rs2.getString("TheTime")))%></font></div></td>
					<td align="left"><div align="left"><font size="2" ><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=rs2.getString("LatitudePosition")%>&long=<%=rs2.getString("LongitudePosition")%>&discription=<%=rs2.getString("Location")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=rs2.getString("Location")%> </a></font></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><font size="2" >-</font></div></td>
					<td align="left"><div align="left"><font size="2" >-</font></div></td>
					<%
				}
				%>
				<td align="left"><div align="left"><font size="2" ><%=rs1.getString("GoodsContent") %></font></div></td>
				<%
				String startcode = rs1.getString("StartCode");
				sql2 = "select * from db_gps.t_warehousedata where warehousecode = '"+startcode+"' ";
				rs2=st2.executeQuery(sql2);
				if(rs2.next())
				{
					%>
					<td align="left"><div align="left"><font size="2" ><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=rs2.getString("Latitude")%>&long=<%=rs2.getString("Longitude")%>&discription=<%=rs1.getString("StartPlace")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=rs1.getString("StartPlace")%> </a></font></div></td>
					<%
				}
				else
				{
					%>
					<td align="left"><div align="left"><font size="2" ><%=rs1.getString("StartPlace")%> </font></div></td>
					<%
				}
				%>
				<td align="left"><div align="left"><font size="2" ><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=rs1.getString("EndLat")%>&long=<%=rs1.getString("EndLong")%>&discription=<%=rs1.getString("EndPlace")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=rs1.getString("EndPlace")%> </a></font></div></td>
				<%
				sql2 = "select Distance from t_veh"+rs1.getString("Vehid")+" where TheFieldDataDateTime between '"+rs1.getString("StartDate")+" "+rs1.getString("StartTime")+"' AND '"+today+" "+currenttime+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime asc limit 1";
			    rs2 = st2.executeQuery(sql2);
			    if(rs2.next())
			    {
			    	kmrun1=rs2.getInt("Distance");
			    }
			    
			    sql2="select Distance from t_veh"+rs1.getString("VehId")+" where TheFieldDataDateTime between '"+rs1.getString("StartDate")+" "+rs1.getString("StartTime")+"' AND '"+today+" "+currenttime+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime desc limit 1";
			    rs2 = st2.executeQuery(sql2);
			    if(rs2.next())
			    {
			    	kmrun2=rs2.getInt("Distance");
			    }
			    
			    long myMilisec;
			    sql2="select * from db_gps.t_startedjourney where StartDate='"+rs1.getDate("StartDate")+"' and StartTime='"+rs1.getTime("StartTime")+"' and StartCode='"+rs1.getString("StartCode")+"' and EndCode='"+rs1.getString("EndCode")+"' and Vehid="+rs1.getString("VehId")+"";
				rs2 = st2.executeQuery(sql2);
				if(rs2.next())
				{
					String sql3="select * from db_gps.t_castrolroutes where StartPlace = '"+rs1.getString("StartPlace")+"' and EndPlace = '"+rs1.getString("EndPlace")+"' || EndPlace = '"+rs1.getString("StartPlace")+"' and StartPlace = '"+rs1.getString("EndPlace")+"' limit 1 ";
					System.out.println(":::---SQL2----:::"+sql3);
					ResultSet rst123=st3.executeQuery(sql3);
					if(totKm==0 && tTime==0 )
					{
						if(rst123.next())
							{
								totKm=rst123.getDouble("Km");
							    tTime=rst123.getLong("TTime");
							}
					}
				}
				
				
				kmrundist=kmrun2-kmrun1;  //Finding tot run km by vehicle after trip started.
				System.out.println("********   "+kmrun2+"-----------   "+kmrun1+"  88888888888888   "+kmrundist);
				remKm=totKm-kmrundist;  // Adding todays km also
				distogo = (int)remKm;
				System.out.println("********   "+remKm+"-----------   "+totKm);
				myMilisec=(tTime*60*60*1000);
				if(!(null==ETADate))
				{
					ETADate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETADate));	 
					 DisDate=ETADate;
						System.out.println(":::::-startDtTmAftAdd- ETA::::"+ETADate);
				}
				else
				{
				if(myMilisec==0)
				{
					DisDate="NA";
				}
				else
				{
				System.out.println(":::::-myMilisec-::::"+myMilisec);
		      	java.util.Date resultdate = new java.util.Date();
		      	 SimpleDateFormat sdftimemilli = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		      	java.util.Date startDtTm = sdftimemilli.parse(rs1.getString("StartDate")+" "+rs1.getString("StartTime")); 
		      	
		     // 	java.util.Date startDtTm=rsttrips.getDate("StartDate");
		      //	String starttime=new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(rsttrips.getString("StartTime")));
				//System.out.println(":::::-startDtTmOriginal-::::"+startDtTm);
				long start=startDtTm.getTime();
				System.out.println("\n\n startdatetime in milli second-->>"+start);
				long totdate= start+myMilisec;
				resultdate.setTime(totdate);
		        DisDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(resultdate);
				System.out.println(":::::-startDtTmAftAdd-::::"+DisDate);
				}
			
				}
				
				System.out.println("********   "+DisDate);
				%>
					<td align="right"><div align="right"><font size="2" ><%=DisDate%></font></div></td>
					<%
					if(totKm == 0)
					{
					%>
				  <td align="right"><div align="right"><font size="2" >-</font></div></td>
				  <%
					}
					else
					{
						%>
						  <td align="right"><div align="right"><font size="2" ><%=distogo%></font></div></td>
						  <%
					}
				  %>
				</tr>
				<%
				i++;
			}
			}
		}
		%>
			<tr>
			
			</tr>
			
			</table>
			</td>
			</tr>
			</table></form></div>
			
 <%
			}
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
		conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>
</body>

			
</html>
</jsp:useBean>
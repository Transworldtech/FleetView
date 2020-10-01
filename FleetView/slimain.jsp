<%@ include file="cargoheader.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
	//Connection conn;
	Statement st,st1,st2,st3,st4,st5,st6,st7,st8,st9;
	ResultSet rst=null,rst1=null,rst2=null,rst3=null,rst4=null,rst5=null,rst6=null,rst7=null,rst8=null,rst9=null;
	String user,sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,sql9,sql10,sql11;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	st5=conn.createStatement();
	st6=conn.createStatement();
	st7=conn.createStatement();
	st8=conn.createStatement();
	st9=conn.createStatement();
	user=session.getAttribute("usertypevalue").toString();
	//out.print(user);
	String stat="",location="",StartDate1="",StartDate="",EndDate="-",EndTime="",StartTime="",buzz="",over="",vehcode="",Unitid="",stamp="";
	String vehiclecode="",instr="",stampcode="",Alarmdate="",cranemodelno="-",notice="";
	vehiclecode=request.getParameter("vehiclecode");
	String todey=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	boolean flag=false;
	//out.print(instr);
	instr=request.getParameter("submitted");
	if(instr==null)
	{
		instr="No";
	}
%>
<table width="100%" align="center" >
<tr bgcolor="#F0E68C">
		<td class="sorttable_nosort"><b><class="bodyText"><font size="2">Color Code Indications :</b></td>
		<td bgcolor="lightgreen" class="sorttable_nosort"><font size="2"><b>Working Crane</b></td>
		<td bgcolor="Yellow" class="sorttable_nosort" ><font size="2"><b>Stopped Crane</b></td>
		<td bgcolor="orange" class="sorttable_nosort" ><font size="2"><b>Shows Alarm Event  </b></td>
		<td bgcolor="red" class="sorttable_nosort" ><font size="2"><b>Shows Overload Event</b></td>
		</tr>
<tr><td colspan="8">
<table  border="0" width="100%">
	<tr><td colspan="8" align="center" bgcolor=""><font size="3" color="maroon"><b>Crane Daily Performance Report</font>
 	<div align="right">
    		<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Excelslimain.jsp?instr=<%=instr%>&vehiclecode=<%=vehiclecode %>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
			<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				String sdt = fmt.format(new java.util.Date());
				out.print(sdt);
%>
					</div></td></tr>
	</table>
</td></tr>
<tr><td colspan="8">
<table  border="0" width="100%" class="bodyText">
<tr bgcolor="lightgrey">
	<th align="center"><b><font size="2" Color="black">Sr.No</font></b></th>
	<th align="center"><b><font size="2" Color="black">Crane Model No.</font></b></th>
	<th align="center"><b><font size="2" Color="black">Crane Code</font></b></th>
	<th align="center"><b><font size="2" Color="black">Crane Reg No</font></b></th>
	<th align="center"><b><font size="2" Color="black">Start Date Time</font></b></th>
	<th align="center"><b><font size="2" Color="black">End Date Time </font> </b> </th>
	<th align="center"><b><font size="2" Color="black">Location </font></b></th>
	<th align="center"><b><font size="2" Color="black">Overload Event Count</font></b></th>
	<th align="center"><b><font size="2" Color="black">Bypass Count</font></b></th>
</tr>
<%
	java.util.Date ShowDate2=new java.util.Date();
	int i=1;
	sql="Select vehiclecode as vehcode1,VehicleRegNumber,CraneModelNo  from t_vehicledetails where OwnerName='AllCargo' order by vehiclecode ";
	rst=st.executeQuery(sql);
	while(rst.next())
	{
			//stampcode="";
			vehcode=rst.getString("vehcode1");
			//stampcode=vehcode;
			Unitid=rst.getString("VehicleRegNumber");
			cranemodelno=rst.getString("CraneModelNo");
			//out.print(vehcode);
			//out.print(Unitid);
			//String todey=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());	
			//out.print(todey);
			sql7="select * from t_veh"+vehcode+" where TheFieldDataDate between (DATE_ADD('"+todey+"',INTERVAL -2 DAY)) and '"+todey+"' limit 1";
			//String sql6="select To_days('"+fnddate+"') - To_days('"+newdate+"') as diff8";	
			rst7=st7.executeQuery(sql7);
			if(rst7.next())
			{
					stamp="Yes";
			}
			else
			{
				stamp="No";
				//stampcode=vehcode;
			}
			String loc="",lat="",lon="";
			String sql8="select * from t_veh"+vehcode+" where TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1  ";
			ResultSet rst8=st1.executeQuery(sql8);
			if(rst8.next())
			{
				System.out.println("Hello");
				flag=true;
				loc=rst8.getString("TheFieldSubject");
				lat=rst8.getString("LatinDec");
				lon=rst8.getString("LonginDec");
			}
			sql1="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('CE','AE','CD','KE','KD','AD','OE','OD') order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1  ";
			System.out.println(sql1);
			rst1=st1.executeQuery(sql1);
			if(rst1.next())
			{
				System.out.print("im here");
				stat=rst1.getString("TheFiledTextFileName");
				//location=rst1.getString("TheFieldSubject");
				String sql2="select * from t_veh"+vehcode+" where TheFiledTextFileName like 'CE' and TheFieldDataDate='"+todey+"' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1  ";
				rst2=st2.executeQuery(sql2);
				if(rst2.next())
				{
				ShowDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				Format formatter4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				StartDate = formatter1.format(ShowDate2);
				StartDate1 = formatter4.format(ShowDate2);
					//StartDate=rst1.getString("TheFieldDataDate");
					//StartTime=rst1.getString("TheFieldDataTime");
				
				}
				else
				{
					StartDate="-";
					
				}
				sql3="select * from t_veh"+vehcode+" where TheFiledTextFileName like 'CD' and TheFieldDataDate='"+todey+"' and (concat(TheFieldDataDate,' ',TheFieldDataTime) > '"+StartDate1+"')  order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1  ";
				//out.print(sql3+"hi...........");
				rst3=st3.executeQuery(sql3);
				if(rst3.next())
				{
				java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst3.getString("TheFieldDataDate")+" "+rst3.getString("TheFieldDataTime"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				EndDate = formatter1.format(ShowDate1);
				//EndDate=rst2.getString("TheFieldDataDate");
				//EndTime=rst2.getString("TheFieldDataTime");
				}
				else
				{
					EndDate="-";
				}
				sql4="select * from t_veh"+vehcode+" where TheFiledTextFileName like 'OE' and TheFieldDataDate='"+todey+"'  order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1  ";
				rst4=st4.executeQuery(sql4);
				if(rst4.next())
				{
				java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst4.getString("TheFieldDataDate")+" "+rst4.getString("TheFieldDataTime"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				Alarmdate = formatter1.format(ShowDate1);
					//StartDate=rst1.getString("TheFieldDataDate");
					//StartTime=rst1.getString("TheFieldDataTime");
					
				}
				sql5="select count(TheFiledTextFileName) as buzz from t_veh"+vehcode+" where TheFiledTextFileName like 'OE' and TheFieldDataDate='"+todey+"'  ";	
				//out.print(sql3);
				rst5=st5.executeQuery(sql5);	
				if(rst5.next())
				{
					buzz=rst5.getString("buzz");
				}
	 			sql6="select count(TheFiledTextFileName) as buzz from t_veh"+vehcode+" where TheFiledTextFileName like 'KE' and TheFieldDataDate='"+todey+"'  ";	
				//out.print(sql4);	
				rst6=st6.executeQuery(sql6);	
				if(rst6.next())
				{
					over=rst6.getString("buzz");
				}
				
				//out.print(sql6);
%>
<tr
<%
		if(stamp.equals("No")||(stat.equals("CD")))
		{
%>
			bgcolor="Yellow"
<%		
		}	
		else
		{
				if(stat.equals("CE")||stat.equals("OD")||stat.equals("AD")||stat.equals("KE")||stat.equals("KD")||instr.equals("yes"))
				{
%>	
					bgcolor="lightgreen" 
<%
				}
				if(stat.equals("AE"))
				{
%>	
					bgcolor="orange" 
<%
				}
				if(stat.equals("OE")&& instr.equals("No"))
				{
					sql7="insert into t_noticealert(craneregno,status)values('"+notice+"','No')";
%>	
					bgcolor="red" 
<%
				}
		}
%>
>
<% 
	if(stat.equals("OE")&&instr.equals("No"))
	{
	%>
	<td align="center">
			<font size="2"> <blink><%=i%> </blink></font>
	</td>
	<td align="center"><font size="2" ><blink><%=cranemodelno%></blink></font></td>
	<td align="center"><font size="2" ><blink>-</blink></font></td>
	<td align="center"><font size="2" onmouseover="ajax_showTooltip(window.event,'showDetails.jsp?id=<%=Unitid%>&cranemodno=<%=cranemodelno%>&vehcode=<%=vehcode%>&Alarmdate=<%=Alarmdate%>',this);return false"><blink><%=Unitid%></blink></font></td>
	<td align="center"><font size="2" ><blink><%=StartDate%> <%=StartTime%></blink></font></td>
	<td align="center"><font size="2" ><blink><%=EndDate%> <%=EndTime%></blink></font></td>
	<td><div align="left"> <blink>
					<%=fleetview.showNewMap(lat,lon,loc) %> 
					</blink></div> 
					</td>
	<td align="center"><a href="buzzer.jsp?vehcode=<%=vehcode%>&cranemodno=<%=cranemodelno%>&vehregno=<%=Unitid%>"><font size="2" ><%=buzz%></font></a></td>
	<td align="center"><a href="overkey.jsp?vehcode=<%=vehcode%>&cranemodno=<%=cranemodelno%>&vehregno=<%=Unitid%>"><font size="2" ><%=over%></font></a></td>
<% 
	} 
	else
	{
	%>
		<td align="center"><font size="2" ><%=i%></td>
		<td align="center"><font size="2" ><%=cranemodelno%></font></td>
		<td align="center"><font size="2" >-</td>
		<td align="center"><a href="cranestart.jsp?vehcode=<%=vehcode%>&cranemodno=<%=cranemodelno%>&vehregno=<%=Unitid%>">
		<font size="2" ><%=Unitid%></td>
		<td align="center"><font size="2" ><%=StartDate%> <%=StartTime%></td>
		<td align="center"><font size="2" ><%=EndDate%> <%=EndTime%></td>
		<td align="center"><font size="2" ><%=fleetview.showNewMap(lat,lon,loc) %></font></td>
		<td align="center"><a href="buzzer.jsp?vehcode=<%=vehcode%>&cranemodno=<%=cranemodelno%>&vehregno=<%=Unitid%>">
		<font size="2" ><%=buzz%></a></td>
		<td align="center"><a href="overkey.jsp?vehcode=<%=vehcode%>&cranemodno=<%=cranemodelno%>&vehregno=<%=Unitid%>">
		<font size="2" ><%=over%></a></td>	
<%	
	}
%>
</tr>
<%
	i++;
}
			//*****For SI stamps 
			else if(flag)
			{
			%>
			<tr>
				<td align="center">
				<font size="2"><%=i%></font>
		</td>
		<td align="center"><font size="2" ><%=cranemodelno%></font></td>
		<td align="center"><font size="2" >-</font></td>
		<td align="center"><font size="2"> <%=Unitid%></font></td>
		<td align="center"><font size="2" >-</font></td>
		<td align="center"><font size="2" >-</font></td>
		<td><div align="left">		<%=fleetview.showNewMap(lat,lon,loc) %> 
						</div> 
						</td>
		<td align="center"><font size="2" >0</font></td>
		<td align="center"><font size="2" >0</font></td>
		</tr>
		<%
			}
			else
			{System.out.println("sdfadfa");
			%>
				<tr>
				<td align="center"><font size="2"><%=i%></font>	</td>
				<td align="center"><font size="2" ><%=cranemodelno%></font></td>
				<td align="center"><font size="2" >-</font></td>
				<td align="center"><font size="2"> <%=Unitid%></font></td>
				<td align="center"><font size="2" >In-Active</font></td>
				<td align="center"><font size="2" >In-Active</font></td>
				<td><div align="center"><font size="2" >In-Active</font></div></td>
				<td align="center"><font size="2" >0</font></td>
				<td align="center"><font size="2" >0</font></td>
				</tr>
		<%	}
}
}
catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
</table>
			</td></tr>	
			</table>
			<% //fleetview.closeConnection(); %>
			</jsp:useBean>
        <%@ include file="footernew.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body>

			<!-- header file -->
			<%@ include file="headerexcel.jsp" %> 
			<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_speedanalysis_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
			<%@ include file="Connections/conn.jsp" %>       
       
			<!-- body part come here -->
			<%!
			Connection conn,conn1;
			Statement st,st1,st2,st3,st4;
			String sql,sql1,vehicle,date1,date2;
			int cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,cnt7,cnttotal1,cnttotal2,cnttotal3,cnttotal4,cnttotal5,cnttotal6,cnttotal7;
			 %>
			<%
			String dateformat="dd-MMM-yyy";
			dateformat=session.getAttribute("dateformat").toString();
					vehicle=request.getParameter("vehicle");
					date1=request.getParameter("data");
					date2=request.getParameter("data1");
			
			try
			{
				Class.forName("org.gjt.mm.mysql.Driver"); 
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				st=conn.createStatement();
				st1=conn.createStatement();
				st2=conn.createStatement();
				st3=conn.createStatement();
			if(!(null==request.getQueryString()))
			{			
			%>
			<table width="100%" border="0" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Speed Analysis Report for <% if(vehicle.equals("All")) {%>All Vehicles <%}else { out.print ("Vehicle "+vehicle); } %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></font></div>
			</td>
			</tr>			
			</table>
			<table width="100%" border="0" align="center" class="sortable">
			<tr>
				<%
			String distFormat="Kmph";
			if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
			{
			//	distFormat="Mlph";
				distFormat="Kmph";
			}
			else{
				distFormat="Kmph";
			}
			%>
			<th class="hed"> Sr.</th>
			<th class="hed"> Date</th>
			<th class="hed"> Below 15 <%=distFormat %></th>
			<th class="hed"> 15 to 30 <%=distFormat %></th>
			<th class="hed"> 30 to 40 <%=distFormat %></th>
			<th class="hed"> 40 to 50 <%=distFormat %></th>
			<th class="hed"> 50 to 60 <%=distFormat %></th>
			<th class="hed"> 60 to 80 <%=distFormat %></th>
			<th class="hed"> Above 80 <%=distFormat %></th>
			</tr>		
			<%
				sql="select * from t_vehicledetails where VehicleRegNumber='"+vehicle+"'";
				ResultSet rst1=st.executeQuery(sql);
				if(rst1.next())
				{	
				sql="select distinct(TheFieldDataDate) from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate >='"+date1+"' and TheFieldDataDate <='"+date2+"' order by TheFieldDataDate ";
				ResultSet rst0=st2.executeQuery(sql);
				int j=1;
				cnttotal1=0;
				cnttotal2=0;
				cnttotal3=0;
				cnttotal4=0;
				cnttotal5=0;
				cnttotal6=0;
				cnttotal7=0;
				while(rst0.next())
				{
				cnt1=0;
				cnt2=0;
				cnt3=0;
				cnt4=0;
				cnt5=0;
				cnt6=0;
				cnt7=0;
				sql="select count(*) as cnt1 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed > 0 and Speed <=15";
				ResultSet rstcnt1=st3.executeQuery(sql);
				if(rstcnt1.next())
				{
					cnt1=rstcnt1.getInt("cnt1");
					cnttotal1=cnttotal1+cnt1;
				}
				
				sql="select count(*) as cnt2 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed >15 and Speed <=30";
				ResultSet rstcnt2=st3.executeQuery(sql);
				if(rstcnt2.next())
				{
					cnt2=rstcnt2.getInt("cnt2");
					cnttotal2=cnttotal2+cnt2;
				}	
				
				sql="select count(*) as cnt3 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed >30 and Speed <=40";
				ResultSet rstcnt3=st3.executeQuery(sql);
				if(rstcnt3.next())
				{
					cnt3=rstcnt3.getInt("cnt3");
					cnttotal3=cnttotal3+cnt3;
				}
				
				sql="select count(*) as cnt4 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed >40 and Speed <=50";
				ResultSet rstcnt4=st3.executeQuery(sql);
				if(rstcnt4.next())
				{
					cnt4=rstcnt4.getInt("cnt4");
					cnttotal4=cnttotal4+cnt4;
				}	
				
				sql="select count(*) as cnt5 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed >50 and Speed <=60";
				ResultSet rstcnt5=st3.executeQuery(sql);
				if(rstcnt5.next())
				{
					cnt5=rstcnt5.getInt("cnt5");
					cnttotal5=cnttotal5+cnt5;
				}	
				
				sql="select count(*) as cnt6 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed >60 and Speed<=80 ";
				ResultSet rstcnt6=st3.executeQuery(sql);
				if(rstcnt6.next())
				{
					cnt6=rstcnt6.getInt("cnt6");
					cnttotal6=cnttotal6+cnt6;
				}	
				sql="select count(*) as cnt7 from t_veh"+rst1.getString("vehicleCode")+" where TheFieldDataDate='"+rst0.getString("TheFieldDataDate")+"' and TheFiledTextFileName='SI' and Speed >80 ";
				ResultSet rstcnt7=st3.executeQuery(sql);
				if(rstcnt7.next())
				{
					cnt7=rstcnt7.getInt("cnt7");
					cnttotal7=cnttotal7+cnt7;
				}	
					%>
				<tr>
				<td style="text-align: right"><%=j%></td>
				<td style="text-align: left"><a href="#" onClick="window.open('dayspeedchart.jsp?vehregno=<%=vehicle%>&cnt1=<%=cnt1%>&cnt2=<%=cnt2%>&cnt3=<%=cnt3%>&cnt4=<%=cnt4%>&cnt5=<%=cnt5%>&cnt6=<%=cnt6%>&cnt7=<%=cnt7%>&thedate=<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst0.getDate("TheFieldDataDate"))%>&vehcode=<%=rst1.getString("vehicleCode")%>','win1','width=800,height=900,location=0,menubar=0,scrollbars=1,status=0,toolbar=0,resizable=0')"><%=new SimpleDateFormat(dateformat).format(rst0.getDate("TheFieldDataDate"))%></a></td>
				<td><div align="right"><%=cnt1%></div></td>
				<td><div align="right"><%=cnt2%></div></td>
				<td><div align="right"><%=cnt3%></div></td>
				<td><div align="right"><%=cnt4%></div></td>
				<td><div align="right"><%=cnt5%></div></td>
				<td><div align="right"><%=cnt6%></div></td>	
				<td><div align="right"><%=cnt7%></div></td>	
				</tr>		
					<%
					j++;
				}
			}
			%>
			<tr class="sortbottom">
			<td class="hed" colspan="2"><div align="right">Total :</div></td>			
			<td class="hed"><div align="right"><%=cnttotal1%></div></td>
			<td class="hed"><div align="right"><%=cnttotal2%></div></td>
			<td class="hed"><div align="right"><%=cnttotal3%></div></td>
			<td class="hed"><div align="right"><%=cnttotal4%></div></td>
			<td class="hed"><div align="right"><%=cnttotal5%></div></td>
			<td class="hed"><div align="right"><%=cnttotal6%></div></td>
			<td class="hed"><div align="right"><%=cnttotal7%></div></td>
			</tr>
			</table>
			</td>
			
			
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
					try{
						conn.close();
						//conn1.close();
					}
					catch(Exception e)
					{}
					
				}
				%>

			
	
			<!-- body part come here -->
	
      <%@ include file="footernew.jsp" %>
    </body>
</html>
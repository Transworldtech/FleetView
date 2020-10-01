<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
  <script type="text/javascript" src="http://www.google.com/jsapi"></script>
</head>
<body bgcolor="lightyellow">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
			<!-- header file -->
			<%@ include file="headernew.jsp" %> 
			<!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<%!
			Connection conn,conn1;
			Statement st,st1,st2,st3,st4;
			String sql,sql1,vehicle,date1,date2;
			int cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,cnttotal1,cnttotal2,cnttotal3,cnttotal4,cnttotal5,cnttotal6,cnttotal7,cnt7;
			 %>
			<%
			String dateformat="dd-MMM-yyy";
			dateformat=session.getAttribute("dateformat").toString();
			if(null==request.getQueryString())
			{
					vehicle="All";
					date2=date1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			
			}
			else
			{
					vehicle=request.getParameter("vehicle");
					date1=request.getParameter("data");
					date2=request.getParameter("data1");
			}
			try
			{
				Class.forName("org.gjt.mm.mysql.Driver"); 
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				st=conn.createStatement();
				st1=conn.createStatement();
				st2=conn.createStatement();
				st3=conn.createStatement();
				
									
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
  				return datevalidate();
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
			<table border="0" width="100%" class="sortable_entry">
			<form action="" method="get" onsubmit="return validate();">
			<tr bgcolor="#87CEFA">
			<td><b>Vehicle :</b></td><td>
			<select name="vehicle" id="vehicle">
			<%
			sql="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				%>
				<option value="<%=rst.getString("VehicleRegNumber")%>" <% if(vehicle.equals(rst.getString("VehicleRegNumber"))){ %>Selected<% } %> ><%=rst.getString("VehicleRegNumber")%></option>				
				<%
			}
			%>
			</select>			
			</td>
			<td align="right"><b>From&nbsp;&nbsp;</b>
			  <input type="text" id="data" name="data"  value="<%=date1%>"  size="10" readonly/>
  			<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
<!--  			<td align="left">-->
<!--				<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">-->
<!--				-->
<!--			</td>-->
			<td align="right"><b>To&nbsp;&nbsp;</b>
			  	<input type="text" id="data1" name="data1"  value="<%=date2%>" size="10" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",    // the date format
      			button      : "data1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
<!--			  	<td align="left">-->
<!--  			  	<input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">-->
				
<!--			</td>-->
			<td>
				<input type="submit" name="submit" id="submit" value="submit" >
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
			<div id="report_heding"><font size="3">The Speed Analysis Report for <% if(vehicle.equals("All")) {%>All Vehicles <%}else { out.print ("Vehicle "+vehicle); } %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('printspeedanalysis.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelspeedanalysis.jsp?vehicle=<%=vehicle%>&data=<%=date1%>&data1=<%=date2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>			
			</table>
			<table width="100%" border="0" align="center" class="sortable">
			<tr>
			<%
			String distFormat="Kmph";
			if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
			{
				//distFormat="Mlph";
				distFormat="Kmph";
			}
			else{
				distFormat="Kmph";
			}
			%>
			<td class="hed"> Sr.</td>
			<td class="hed"> Date</td>
			<td class="hed"> Below 15 <%=distFormat %></td>
			<td class="hed"> 15 to 30 <%=distFormat %></td>
			<td class="hed"> 30 to 40 <%=distFormat %></td>
			<td class="hed"> 40 to 50 <%=distFormat %></td>
			<td class="hed"> 50 to 60 <%=distFormat %></td>
			<td class="hed"> 60 to 80 <%=distFormat %></td>
			<td class="hed"> Above 80 <%=distFormat %></td>
			</tr>		
			<%
				sql="select * from t_vehicledetails where VehicleRegNumber='"+vehicle+"' order by VehicleRegNumber";
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
			<tr class="sortbottom">
				<td colspan="10">
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['piechart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data = new google.visualization.DataTable();
        			data.addColumn('string', 'Task');
        			data.addColumn('number', 'Hours per Day');
        			data.addRows(7);
        			data.setValue(0, 0, 'Below 15 <%=distFormat%>');
        			data.setValue(0, 1, <%=cnttotal1%>);
        			data.setValue(1, 0, '15 to 30 <%=distFormat%>');
        			data.setValue(1, 1, <%=cnttotal2%>);
        			data.setValue(2, 0, '30 to 40 <%=distFormat%>');
        			data.setValue(2, 1, <%=cnttotal3%>);
        			data.setValue(3, 0, '40 to 50 <%=distFormat%>');
        			data.setValue(3, 1, <%=cnttotal4%>);
        			data.setValue(4, 0, '50 to 60 <%=distFormat%>');
        			data.setValue(4, 1, <%=cnttotal5%>);
        			data.setValue(5, 0, '60 to 80 <%=distFormat%>');
        			data.setValue(5, 1, <%=cnttotal6%>);
        			data.setValue(6, 0, 'Above 80 <%=distFormat%>');
        			data.setValue(6, 1, <%=cnttotal7%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        			chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Speed Statistics'});
      			}
    			</script>
				 <div id="chart_div" order="1"></div>
				</td>				
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
					}
					catch(Exception e)
					{}
					try{
						conn1.close();
					}
					catch(Exception e)
					{}
				}
				%>
			
    <td class="fboxlowright">&nbsp;</td>
    </tr>
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
        <%@ include file="footernew.jsp" %>
    </body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/erratic.css" rel="StyleSheet" type="text/css">
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
</head>
<body>
<%!
Connection conn;
Statement st,st1,st2,st3;
String sql,vehid,ss1,ss2,ss3,dd,vehicle;
boolean flag;
%>
<%
vehicle =request.getParameter("vehreg");
dd =request.getParameter("dd");
ss1 =request.getParameter("ss1");
ss2 =request.getParameter("ss2");
ss3 =request.getParameter("ss3");
vehid =request.getParameter("vehid");
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
          <table border="0" align="left" width="100%">
<tr>
<td>
<!-- unit logo comes here --->
<div align="left">
<img src="images/Transworld.jpeg"  border="0">
</div>
<!-- unit logo comes here --->
<div align="right">Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
</tr>
</table>
			<!-- header file -->
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<table width="100%" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Detail Report For Vehicle <%=vehicle%> On Date :<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(dd))%></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('print_daydetails.jsp?vehid=<%=vehid%>&vehicle=<%=vehicle%>&dd=<%=dd%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
				<a href="excel_daydetails.jsp?vehid=<%=vehid%>&vehicle=<%=vehicle%>&dd=<%=dd%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>				
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" id="table1" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Date-Time</th>
			<th class="hed"> Speed</th>
			<th class="hed"> Distance</th>
			<th class="hed"> Location</th>
			</tr>	
			<%
			try{			
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			sql="select * from t_veh"+vehid+" where TheFieldDataDate='"+dd+"' and TheFiledTextFileName in ('SI','OF','ON') order by TheFieldDataTime asc";
			ResultSet rst1=st.executeQuery(sql);
			int i=1;
			int dist=0;
			while(rst1.next())
			{
				if(i==1)
				{
					dist=rst1.getInt("Distance");
				}
				if(rst1.getString("TheFiledTextFileName").equals("SI"))
				{
					if(rst1.getInt("Speed")==0)
				{
				if(flag)
				{
					flag=false;
					%>
					<tr>
						<td class="bodyText"><%=i%></td>
						<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></td>
						<td class="bodyText"><%="Stop"%></td>
						<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a></div></td>
					</tr>
					<%	
					i++;
				}
			}
			else
			{		
				flag=true;	
				%>
				<tr>
					<td class="bodyText"><%=i%></td>
					<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></td>
					<td class="bodyText"><%=rst1.getInt("Speed")%></td>
					<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
					<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a></div></td>
				</tr>
				<%
				i++;
			}
		}
		else
		{
			if(rst1.getString("TheFiledTextFileName").equals("OF"))
			{
				String long1,long2,lat1,lat2,loc1,loc2;
				int ds1,ds2;
				java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
				loc1=rst1.getString("TheFieldSubject");
				lat1=rst1.getString("LatinDec");
				long1=rst1.getString("LonginDec");
				ds1=rst1.getInt("Distance");
				if(rst1.next())
				{
					if(rst1.getString("TheFiledTextFileName").equals("ON"))
					{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						if(mils3 > 20)
						{
							%>
							<tr>
								<td class="bodyText"><%=i%></td>
								<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></td>
								<td class="bodyText"><%=""+mils3+" Min. OFF"%></td>
								<td class="bodyText"><%=ds1-dist%></td>
								<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1%>&long=<%=long1%>&discription=<%=loc1%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat1%>&long=<%=long1%>&discription=<%=loc1%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc1%></a></div></td>
							</tr>
							<%		
							i++;
							%>
							<tr>
								<td class="bodyText"><%=i%></td>
								<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></td>
								<td class="bodyText"><%="ON"%></td>
								<td class="bodyText"><%=ds2-dist%></td>
								<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat2%>&long=<%=long2%>&discription=<%=loc2%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat2%>&long=<%=long2%>&discription=<%=loc2%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc2%></a></div></td>
							</tr>		
							<%
							i++;
						}	
					
					}
				}
			
			}
		
		}
	}
	if(rst1.last())
	{
	%>
		<tr>
			<td class="bodyText"><%=i%></td>
			<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></td>
			<td class="bodyText"><%=rst1.getInt("Speed")%></td>
			<td class="bodyText"><%=rst1.getInt("Distance")-dist%></td>
			<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a>
			</div>
			</td>
		</tr>
	<%
	i++;

	}
			}catch(Exception e)
			{
				out.print("Exception--->"+e);
			}
			finally
			{
				try{
				conn.close();
				}
				catch(Exception e)
				{
					
				}
			}
			%>
			<tr><td colspan="5">
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
        			data.addRows(3);
        			data.setValue(0, 0, 'Running Time In Min');
        			data.setValue(0, 1, <%=ss1%>);
        			
        			data.setValue(1, 0, 'Day Stops In Min');
        			data.setValue(1, 1, <%=ss3%>);
				data.setValue(2, 0, 'Night Stop In Min');
        			data.setValue(2, 1, <%=ss2%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        			chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Time Statistics'});
      			}
    			</script>
				 <div id="chart_div" order="1"></div>			
			
			</td></tr>
			</table>
			<!-- body part come here -->
				
			</td>
    <td class="fboxlowright">&nbsp;</td>
    
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
      <%@ include file="footernew.jsp" %>
    </body>
</html>

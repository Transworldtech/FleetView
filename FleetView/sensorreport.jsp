<%@page import="com.transworld.fleetview.framework.DisconnectionReport"
	import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
	import="com.transworld.fleetview.framework.DisconnectionReportViewData"
	import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="powerOnOffReport.ImplementationOfDisconnection"
	import="powerOnOffReport.DisconnectionData"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<script>		
function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}

function gotoExcel (elemId, frmFldId)  
{  
	var obj = document.getElementById(elemId);  

 	var oFld = document.getElementById(frmFldId); 

  	oFld.value = obj.innerHTML;  

  	document.amcrep.action ="excel.jsp";     // CHANGE FORM NAME HERE

  	document.forms["amcrep"].submit();       // CHANGE FORM NAME HERE

} 	
</script>

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>

<%@ include file="headernew.jsp"%>

<%
Connection conn1 = null;

Statement st = null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null;

try{
	
	

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();
	st1 = conn1.createStatement();
	st2 = conn1.createStatement();
	st3 = conn1.createStatement();
	st4 = conn1.createStatement();
	st5 = conn1.createStatement();
	st6 = conn1.createStatement();
	st7 = conn1.createStatement();
	st8 = conn1.createStatement();
	
	

	
%>


<%
	

	System.out.println("Vehicle list "+session.getValue("VehList").toString());
	
	String user = session.getAttribute("usertypevalue").toString();
%>
<form name="amcrep" method="post">	
<div id="table1" align="center">

		
		
		<table border="0" width="50%" align="center" >
			<tr>
				<th colspan="3" align="center"><font size="3">Sensor  Report  </font>
					<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');"/>

	           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>				
				</div>
				</th>
			</tr>
		</table>
		
		<%
			String exportFileName="Sensor_Report.xls";   // GIVE YOUR REPORT NAME
		%>
			<div align="right"><input type="hidden" id="tableHTML"
				name="tableHTML" value="" /></div>
			<div>
		 
	<input type="hidden" id="fileName" name="fileName" value="<%=exportFileName%>" /> 
		
	<table border="1" class="sortable" style="align:center; font:normal 13px Arial,Helvtica,sans-serif; width : 35%;" >
			
			<tr>
				<th>Sr.</th>
				<th > Freezer Tray</th>
				<th>Updated Date Time</th>
				<th>Sensor Value</th>
				
			</tr>
			
			
<%

				String thetime="",thedate="";
				
				String sen1="",sen2="",sen3="",sen4="";	
				String vehcode="";
				String dateformat="dd-MMM-yyyy";
				dateformat=session.getAttribute("dateformat").toString();
			//	String sql="SELECT  v7720.sen1, v7714.TheFieldDataDate, v7714.TheFieldDataTime,  v7714.sen1, v7714.sen2, v7714.sen3, v7714.sen4, v7717.sen1, v7717.sen2, v7717.sen3, v7717.sen4, v7677.sen1, v7677.sen2, v7677.sen3, v7677.sen4, v7680.sen1, v7680.sen2, v7680.sen3, v7680.sen4, v7676.sen1, v7676.sen2, v7676.sen3, v7676.sen4  FROM db_gps.t_veh7714 as v7714, db_gps.t_veh7717 as v7717, db_gps.t_veh7677 as v7677, db_gps.t_veh7680 as v7680, db_gps.t_veh7676 as v7676 , db_gps.t_veh7720 as v7720 where  v7714.sen1<>' ' and v7714.sen1<>'-' and  v7714.sen2<>' ' and v7714.sen2<>'-' and v7714.sen3<>' ' and v7714.sen3<>'-' and v7714.sen4<>' ' and v7714.sen4<>'-' and  (v7714.sen1<>'085.000' and v7714.sen2<>'085.000' and v7714.sen3<>'085.000' and v7714.sen4<>'085.000') and  SUBSTRING(v7714.sen1, 1, 1)='0' and SUBSTRING(v7714.sen2, 1, 1)='0' and SUBSTRING(v7714.sen3, 1, 1)='0'  and SUBSTRING(v7714.sen4, 1, 1)='0' and  v7717.sen1<>' ' and v7717.sen1<>'-' and  v7717.sen2<>' ' and v7717.sen2<>'-' and v7717.sen3<>' ' and v7717.sen3<>'-' and v7717.sen4<>' ' and v7717.sen4<>'-' and  (v7717.sen1<>'085.000' and v7717.sen2<>'085.000' and v7717.sen3<>'085.000' and v7717.sen4<>'085.000') and  SUBSTRING(v7717.sen1, 1, 1)='0' and SUBSTRING(v7717.sen2, 1, 1)='0' and SUBSTRING(v7717.sen3, 1, 1)='0'  and SUBSTRING(v7717.sen4, 1, 1)='0' and  v7677.sen1<>' ' and v7677.sen1<>'-' and  v7677.sen2<>' ' and v7677.sen2<>'-' and v7677.sen3<>' ' and v7677.sen3<>'-' and v7677.sen4<>' ' and v7677.sen4<>'-' and  (v7677.sen1<>'085.000' and v7677.sen2<>'085.000' and v7677.sen3<>'085.000' and v7677.sen4<>'085.000') and  SUBSTRING(v7677.sen1, 1, 1)='0' and SUBSTRING(v7677.sen2, 1, 1)='0' and SUBSTRING(v7677.sen3, 1, 1)='0'  and SUBSTRING(v7677.sen4, 1, 1)='0' and  v7680.sen1<>' ' and v7680.sen1<>'-' and  v7680.sen2<>' ' and v7680.sen2<>'-' and v7680.sen3<>' ' and v7680.sen3<>'-' and v7680.sen4<>' ' and v7680.sen4<>'-' and  (v7680.sen1<>'085.000' and v7680.sen2<>'085.000' and v7680.sen3<>'085.000' and v7680.sen4<>'085.000') and  SUBSTRING(v7680.sen1, 1, 1)='0' and SUBSTRING(v7680.sen2, 1, 1)='0' and SUBSTRING(v7680.sen3, 1, 1)='0'  and SUBSTRING(v7680.sen4, 1, 1)='0' and  v7676.sen1<>' ' and v7676.sen1<>'-' and  v7676.sen2<>' ' and v7676.sen2<>'-' and v7676.sen3<>' ' and v7676.sen3<>'-' and v7676.sen4<>' ' and v7676.sen4<>'-' and  (v7676.sen1<>'085.000' and v7676.sen2<>'085.000' and v7676.sen3<>'085.000' and v7676.sen4<>'085.000') and  SUBSTRING(v7676.sen1, 1, 1)='0' and SUBSTRING(v7676.sen2, 1, 1)='0' and SUBSTRING(v7676.sen3, 1, 1)='0'  and SUBSTRING(v7676.sen4, 1, 1)='0'  and v7714.TheFieldDataDate=CURDATE() limit 1 ";
			String sql = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='8239' and vehicleCode in"+session.getValue("VehList").toString()+"   order by thedate desc";
			System.out.println("sql=" + sql);
			ResultSet rs1 = st.executeQuery(sql);
			  int i=0;	
			if (rs1.next()) 
			{
				i = i + 1;
				thedate=rs1.getString("TheDate");
				System.out.println("The date:"+thedate);
				thetime=rs1.getString("TheTime");
				System.out.println("The Time:"+thetime);
				vehcode=rs1.getString("VehicleCode");
				System.out.println("Vehicle Code:"+vehcode);
				sen1=rs1.getString("Sen1");
				System.out.println("Sen1:"+sen1);
				sen2=rs1.getString("Sen2");
				System.out.println("Sen2:"+sen2);
				sen3=rs1.getString("Sen3");
				System.out.println("Sen3:"+sen3);
				sen4=rs1.getString("Sen4");
				System.out.println("Sen4:"+sen4);
				
				
			
			
		%>	
			<tr>
			
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen4" target="_blank">101</a></div></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs1.getDate("Thedate"))%> <%=" "+rs1.getString("TheTime")%></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen4%></td>
			
		</tr>
		<%} %>
				<%
				String sql1 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='7127' and vehicleCode in"+session.getValue("VehList").toString()+"  order by thedate desc ";
				System.out.println("sql=" + sql1);
				ResultSet rs2 = st1.executeQuery(sql1);
				  
				if (rs2.next()) 
				{
					i = i + 1;
					thedate=rs2.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs2.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs2.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs2.getString("Sen1");
					System.out.println("Sen1:"+sen1);
					sen2=rs2.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs2.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs2.getString("Sen4");
					System.out.println("Sen4:"+sen4);
					
					
				
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen3" target="_blank">107</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs2.getDate("Thedate"))%> <%=" "+rs2.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen3%></td>
				
			</tr>
	
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen2" target="_blank">113</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs2.getDate("Thedate"))%> <%=" "+rs2.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen2%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen1" target="_blank">119</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs2.getDate("Thedate"))%> <%=" "+rs2.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen1%></td>
				
			</tr>
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen4" target="_blank">125</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs2.getDate("Thedate"))%> <%=" "+rs2.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen4%></td>
				
			</tr>
	<%} %>
	<%
				String sql2 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='8268' and vehicleCode in"+session.getValue("VehList").toString()+"  order by thedate desc ";
				System.out.println("sq2=" + sql2);
				ResultSet rs3 = st2.executeQuery(sql2);
				  
				if (rs3.next()) 
				{
					i = i + 1;
					thedate=rs3.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs3.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs3.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs3.getString("Sen1");
					System.out.println("Sen1:"+sen1);

					sen2=rs3.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs3.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs3.getString("Sen4");
					System.out.println("Sen4:"+sen4);
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen1" target="_blank">131</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs3.getDate("Thedate"))%> <%=" "+rs3.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen1%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen2" target="_blank">201</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs3.getDate("Thedate"))%> <%=" "+rs3.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen2%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen4" target="_blank">207</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs3.getDate("Thedate"))%> <%=" "+rs3.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen4%></td>
				
			</tr>
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen3" target="_blank">213</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs3.getDate("Thedate"))%> <%=" "+rs3.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen3%></td>
				
			</tr>
	
	<%} %>	
	
	<%
				String sql3 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='8239' and vehicleCode in"+session.getValue("VehList").toString()+" order by thedate desc ";
				System.out.println("sql3=" + sql3);
				ResultSet rs4 = st3.executeQuery(sql3);
				  
				if (rs4.next()) 
				{
					i = i + 1;
					thedate=rs4.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs4.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs4.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs4.getString("Sen1");
					System.out.println("Sen1:"+sen1);

					sen2=rs4.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs4.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs4.getString("Sen4");
					System.out.println("Sen4:"+sen4);
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen3" target="_blank">219</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs4.getDate("Thedate"))%> <%=" "+rs4.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen3%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen1" target="_blank">225</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs4.getDate("Thedate"))%> <%=" "+rs4.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen1%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen2" target="_blank">231</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs4.getDate("Thedate"))%> <%=" "+rs4.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen2%></td>
				
			</tr>	
	<%} %>		
	
	<%
				String sql4 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='8282' and vehicleCode in"+session.getValue("VehList").toString()+" order by thedate desc ";
				System.out.println("sql4=" + sql4);
				ResultSet rs5 = st4.executeQuery(sql4);
				  
				if (rs5.next()) 
				{
					System.out.println("In sql 4");
					i = i + 1;
					thedate=rs5.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs5.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs5.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs5.getString("Sen1");
					System.out.println("Sen1:"+sen1);

					sen2=rs5.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs5.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs5.getString("Sen4");
					System.out.println("Sen4:"+sen4);
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen1" target="_blank">301</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs5.getDate("Thedate"))%> <%=" "+rs5.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen1%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen4" target="_blank">307</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs5.getDate("Thedate"))%> <%=" "+rs5.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen4%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen2" target="_blank">313</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs5.getDate("Thedate"))%> <%=" "+rs5.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen2%></td>
				
			</tr>	
	<%} %>				
	
	<%
				String sql5 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='8320' and vehicleCode in"+session.getValue("VehList").toString()+" order by thedate desc ";
				System.out.println("sql5=" + sql5);
				ResultSet rs6 = st5.executeQuery(sql5);
				  
				if (rs6.next()) 
				{
					i = i + 1;
					thedate=rs6.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs6.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs6.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs6.getString("Sen1");
					System.out.println("Sen1:"+sen1);

					sen2=rs6.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs6.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs6.getString("Sen4");
					System.out.println("Sen4:"+sen4);
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen2" target="_blank">319</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs6.getDate("Thedate"))%> <%=" "+rs6.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen2%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen4" target="_blank">325</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs6.getDate("Thedate"))%> <%=" "+rs6.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen4%></td>
				
			</tr>
			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen3" target="_blank">331</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs6.getDate("Thedate"))%> <%=" "+rs6.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen3%></td>
				
			</tr>	
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen1" target="_blank">Cold Storage BS</a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs6.getDate("Thedate"))%> <%=" "+rs6.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen1%></td>
				
			</tr>	
	<%} %>				
			
	
	
	<%
				String sql7 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='7961' and vehicleCode in"+session.getValue("VehList").toString()+" order by thedate desc ";
				System.out.println("sql7=" + sql7);
				ResultSet rs8 = st7.executeQuery(sql7);
				  
				if (rs8.next()) 
				{
					i = i + 1;
					thedate=rs8.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs8.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs8.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs8.getString("Sen1");
					System.out.println("Sen1:"+sen1);

					sen2=rs8.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs8.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs8.getString("Sen4");
					System.out.println("Sen4:"+sen4);
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen1" target="_blank"> Cold Storage BS Humidity </a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs8.getDate("Thedate"))%> <%=" "+rs8.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen1%></td>
				
			</tr>
	<%} %>	
		
		<%
				String sql8 = "SELECT TheDate, TheTime,VehicleCode,Sen1,Sen2,Sen3,Sen4 FROM db_gps.t_onlinedata where unitid='8282' and vehicleCode in"+session.getValue("VehList").toString()+" order by thedate desc ";
				System.out.println("sql8=" + sql8);
				ResultSet rs9 = st8.executeQuery(sql8);
				  
				if (rs9.next()) 
				{
					i = i + 1;
					thedate=rs9.getString("TheDate");
					System.out.println("The date:"+thedate);
					thetime=rs9.getString("TheTime");
					System.out.println("The Time:"+thetime);
					vehcode=rs9.getString("VehicleCode");
					System.out.println("Vehicle Code:"+vehcode);
					sen1=rs9.getString("Sen1");
					System.out.println("Sen1:"+sen1);

					sen2=rs9.getString("Sen2");
					System.out.println("Sen2:"+sen2);
					sen3=rs9.getString("Sen3");
					System.out.println("Sen3:"+sen3);
					sen4=rs9.getString("Sen4");
					System.out.println("Sen4:"+sen4);
				
				%>

			
			<tr>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen= Sen3" target="_blank"> Cold Storage MC </a></div></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs9.getDate("Thedate"))%> <%=" "+rs9.getString("TheTime")%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen3%></td>
				
			</tr>
	<%} %>	
	

		</table>
		</div>
		</td>
	</tr>
	
</table>
</div>
</form>

	
<%}catch(Exception e){
	e.printStackTrace();
}
finally{
	st.close();
	conn1.close();
	try
	{
	fleetview.closeConnection();
	}catch(Exception e)
	{
	}
}
%>
<%@ include file="footernew.jsp" %>
</jsp:useBean>

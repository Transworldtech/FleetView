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

Statement st = null,stmt=null;

try{
	
	

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();
	stmt = conn1.createStatement();
	
	
	

	
%>


<%
	

	System.out.println("Vehicle list "+session.getValue("VehList").toString());
	
	//String user = session.getAttribute("usertypevalue").toString();
//	String user=session.getValue("user").toString();
	String user = session.getAttribute("usertypevalue").toString();
	System.out.println("Ownername "+user);
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
				
				String sen="";	
				String vehcode="";
				String owner="", vehregno="", sensor="", label=""; 
				String dateformat="dd-MMM-yyyy";
				dateformat=session.getAttribute("dateformat").toString();
				String labelquery="select * from db_gps.t_sensorlabels where ownername='"+user+"' order by Tray ";
				System.out.println("Label Query"+labelquery);
				ResultSet rs=stmt.executeQuery(labelquery);
				while(rs.next())
				{
					owner= rs.getString("ownername");
					vehregno=rs.getString("vehregno");
					sensor=rs.getString("Sensor");
					label=rs.getString("Tray");
					
					if(sensor.equals("Sensor 1")){
						sensor="Sen1";
					}else if(sensor.equals("Sensor 2")){
						sensor="Sen2";
					}else if(sensor.equals("Sensor 3")){
						sensor="Sen3";
					}else
						sensor="Sen4";
				
			//	String sql="SELECT  v7720.sen1, v7714.TheFieldDataDate, v7714.TheFieldDataTime,  v7714.sen1, v7714.sen2, v7714.sen3, v7714.sen4, v7717.sen1, v7717.sen2, v7717.sen3, v7717.sen4, v7677.sen1, v7677.sen2, v7677.sen3, v7677.sen4, v7680.sen1, v7680.sen2, v7680.sen3, v7680.sen4, v7676.sen1, v7676.sen2, v7676.sen3, v7676.sen4  FROM db_gps.t_veh7714 as v7714, db_gps.t_veh7717 as v7717, db_gps.t_veh7677 as v7677, db_gps.t_veh7680 as v7680, db_gps.t_veh7676 as v7676 , db_gps.t_veh7720 as v7720 where  v7714.sen1<>' ' and v7714.sen1<>'-' and  v7714.sen2<>' ' and v7714.sen2<>'-' and v7714.sen3<>' ' and v7714.sen3<>'-' and v7714.sen4<>' ' and v7714.sen4<>'-' and  (v7714.sen1<>'085.000' and v7714.sen2<>'085.000' and v7714.sen3<>'085.000' and v7714.sen4<>'085.000') and  SUBSTRING(v7714.sen1, 1, 1)='0' and SUBSTRING(v7714.sen2, 1, 1)='0' and SUBSTRING(v7714.sen3, 1, 1)='0'  and SUBSTRING(v7714.sen4, 1, 1)='0' and  v7717.sen1<>' ' and v7717.sen1<>'-' and  v7717.sen2<>' ' and v7717.sen2<>'-' and v7717.sen3<>' ' and v7717.sen3<>'-' and v7717.sen4<>' ' and v7717.sen4<>'-' and  (v7717.sen1<>'085.000' and v7717.sen2<>'085.000' and v7717.sen3<>'085.000' and v7717.sen4<>'085.000') and  SUBSTRING(v7717.sen1, 1, 1)='0' and SUBSTRING(v7717.sen2, 1, 1)='0' and SUBSTRING(v7717.sen3, 1, 1)='0'  and SUBSTRING(v7717.sen4, 1, 1)='0' and  v7677.sen1<>' ' and v7677.sen1<>'-' and  v7677.sen2<>' ' and v7677.sen2<>'-' and v7677.sen3<>' ' and v7677.sen3<>'-' and v7677.sen4<>' ' and v7677.sen4<>'-' and  (v7677.sen1<>'085.000' and v7677.sen2<>'085.000' and v7677.sen3<>'085.000' and v7677.sen4<>'085.000') and  SUBSTRING(v7677.sen1, 1, 1)='0' and SUBSTRING(v7677.sen2, 1, 1)='0' and SUBSTRING(v7677.sen3, 1, 1)='0'  and SUBSTRING(v7677.sen4, 1, 1)='0' and  v7680.sen1<>' ' and v7680.sen1<>'-' and  v7680.sen2<>' ' and v7680.sen2<>'-' and v7680.sen3<>' ' and v7680.sen3<>'-' and v7680.sen4<>' ' and v7680.sen4<>'-' and  (v7680.sen1<>'085.000' and v7680.sen2<>'085.000' and v7680.sen3<>'085.000' and v7680.sen4<>'085.000') and  SUBSTRING(v7680.sen1, 1, 1)='0' and SUBSTRING(v7680.sen2, 1, 1)='0' and SUBSTRING(v7680.sen3, 1, 1)='0'  and SUBSTRING(v7680.sen4, 1, 1)='0' and  v7676.sen1<>' ' and v7676.sen1<>'-' and  v7676.sen2<>' ' and v7676.sen2<>'-' and v7676.sen3<>' ' and v7676.sen3<>'-' and v7676.sen4<>' ' and v7676.sen4<>'-' and  (v7676.sen1<>'085.000' and v7676.sen2<>'085.000' and v7676.sen3<>'085.000' and v7676.sen4<>'085.000') and  SUBSTRING(v7676.sen1, 1, 1)='0' and SUBSTRING(v7676.sen2, 1, 1)='0' and SUBSTRING(v7676.sen3, 1, 1)='0'  and SUBSTRING(v7676.sen4, 1, 1)='0'  and v7714.TheFieldDataDate=CURDATE() limit 1 ";
			String sql = "SELECT TheDate, TheTime,VehicleCode,"+sensor+" as sen FROM db_gps.t_onlinedata where transporter like '%"+owner+"%' and VehicleRegNo in ('"+vehregno+"') and vehicleCode in"+session.getValue("VehList").toString()+"   order by thedate desc";
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
				sen=rs1.getString("sen");
				System.out.println("Sen:"+sen);
				
				
				
			
			
		%>	
			<tr>
			
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= i %></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><div align="right"><a href="tempdetailreportGSIDC.jsp?vehcode=<%= vehcode%>&Sen=<%= sensor%>" target="_blank"><%= label%></a></div></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=new SimpleDateFormat(dateformat).format(rs1.getDate("Thedate"))%> <%=" "+rs1.getString("TheTime")%></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen%></td>
			
		</tr>
		
	<%} %>
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

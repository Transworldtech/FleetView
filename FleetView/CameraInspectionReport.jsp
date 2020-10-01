<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%@page import="java.util.Date"%>

<script type="text/javascript">
function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
} 

function gotoExcel(elemId, frmFldId)
{  
	
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.camera_inspection.action ="excel.jsp";
          document.forms["camera_inspection"].submit();

        //  document.roundtripdata.action ="excel.jsp";

}

function showCameraInspectionImage(imageName)
{	
	var url="showCameraInspectionImage.jsp?imageName=" +imageName;
	testwindow1 = window.open(url,"Image", "width=500,height=500");
    testwindow1.moveTo(250,100);
}

function datevalidate()
{
	 //alert(">>>>");
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	dd22=date2.substring(0,2);
	mm1=date1.substring(3,5);
	mm2=date2.substring(3,5);
	yy11=date1.substring(6,10);
	yy22=date2.substring(6,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	if(yy11>year || yy22>year)
	{
		alert("selected date should not be greater than yesterday date");
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
		if(mm1>month || mm2>month)
		{
			alert("selected date should not be greater than yesterday date");
			return false;
		}
	}
	if(mm1==month && mm2==month)
	{
		if(dd11>day || dd22>day)
		{
			alert("selected date should not be greater than yesterday date");
			return false;
		}
	}

	if(yy11 > yy22)
	{
		alert("From date year should not be greater than to date year");
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
		 if(mm1>mm2)
	{
		alert("From date month should not be greater than to date month");
		return false;
	}
	}
	if(mm1==month && mm2==month) 
	{
		if(yy11==yy22)
		{
		if(dd11 > dd22)
		{
			alert("From date should not be greater than to date");
			return false;
		}
		}
	}
	else
		if(yy11<yy22)
		{
			return true;
		}
	else
		if(dd11 > dd22)
	{
			if(mm1<mm2)
			{
				return true;
			}
			
		alert("From date should not be greater than to date");
		return false;
	}
	
	return true;
}
</script>
<body>
<%! Connection conn = null;
	Statement st = null;
	Statement st1 = null;
	
	String date1 = "";
	String date2 = "";%>	
	
<%

//setting for the From date
SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
Calendar c1 = Calendar.getInstance();
c1.setTime(new java.util.Date());
c1.add(Calendar.DATE, -7);  
String default_date_1 = sdf1.format(c1.getTime());
System.out.println("The default_date_1  is ==>"+default_date_1);

String defaultDate2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
System.out.println("The default date2 is ==>"+defaultDate2);
%>
<%
try{
	
	 date1 = request.getParameter("data");
	 date2 = request.getParameter("data1");
	
	 Class.forName(MM_dbConn_DRIVER);
	 conn = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	 st = conn.createStatement();
	 st1 = conn.createStatement();
	
}catch(Exception e){
	System.out.println("Exception "+e);
}
%>	
<form id="camera_inspection_report" name="camera_inspection_report" onsubmit="return datevalidate();">
<table border="0" width="100%" class="stats">
	<tr>
		<td align="left"><font size="2" face="Arial"><b>From Date&nbsp;&nbsp;</b></font>
		<input type="text" id="data" name="data" size="12" value="<%if(date1==null){ %><%=default_date_1%><%}else{%><%=date1%><%}%>"style="width: 90px; height: 15px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
		<script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font size="2" face="Arial"><b>To Date&nbsp;&nbsp;</b></font>
		<input type="text" id="data1" name="data1" value="<%if(date2==null){ %><%=defaultDate2%><%}else{%><%=date2%><%}%>"  size="12" style="width: 90px; height: 15px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
		<script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",    // the date format
		      button      : "trigger1"       // ID of the button
		    }
		  );
		</script>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type ="submit" name ="submit" id ="submit" value="submit"></input>		
		</td>
	</tr>
</table>
</form>
<br/>

<%

	if(date1==null || date2==null){
			
		date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(default_date_1));
		date2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(defaultDate2));
		
	}else{
		//System.out.println("in else");
		
		date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date1));
		date2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
	}
%>	
<form id="camera_inspection" name="camera_inspection" action="" method="post">

		<%
		 String  exportFileName="camera_inspection_report.xls";
		%>
		
<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">	
				<font size="3" face="Arial"><b>Camera Inspection Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></b></font>
		</td>
	</tr>
	<tr>
		<td align="right">	
							<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>&nbsp;<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new Date()) %></div>
		</td>
	</tr>
</table>	
<div style="width:100%;" align="center" id="table1" >	
<table border="0" class="stats" align ="center" style="width: 100%;">
	<tr>
		<td>
			<table class="sortable">
			<tr>
			<th width = "5px">Sr No</th>
			<th>Veh Reg No</th>
			<th>Transporter</th>
			<th>Peripheral SrNo</th>
			<th>Protective Cover ID</th>
			<th>SD Card Present</th>
			<th>SD Card ID</th>
			<th>SD Card Size</th>
			<th>Seal Broken</th>
			<th>Current Seal ID</th>
			<th>New Seal ID</th>
			<th>Stand ID</th>
			<th>Video Duration</th>
			<th>Video Size</th>
			<th>Locked File Count</th>
			<th>Corrupt File Count</th>
			<th>Total File Count</th>
			<th>Latest Video Date & Time</th>
			<th>Entry By</th>		
			<th>Updated Date & Time</th>
			<th>File Name</th>
			</tr>					
	<%
	try{      
		
	int cnt = 0;
		String sql = "Select * from db_gps.t_vehcileperipheral where UpdatedDateTime between '"+date1+" 00:00:00' AND '"+date2+" 23:59:59' Order by UpdatedDateTime DESC";
		ResultSet rs = st.executeQuery(sql);
		System.out.println("The sql is ==>"+sql);
		while(rs.next()){
			
			String  Vehiclecode = rs.getString("Vehiclecode");
			String  PeripheralSrNo = rs.getString("PeripheralSrNo");
			String  ProtectiveCoverId = rs.getString("ProtectiveCoverId");
			String  SdCardPresent = rs.getString("SdCardPresent");
			String  SdCardId = rs.getString("SdCardId");
			String  SdCardSize = rs.getString("SdCardSize");
			String  SealBroken = rs.getString("SealBroken");
			String  CurrentSealId = rs.getString("CurrentSealId");
			String  NewSealId = rs.getString("NewSealId");
			String  StandId = rs.getString("StandId");
			String  FileCount = rs.getString("FileCount");
			String  VideoDuration = rs.getString("VideoDuration");
			String  VideoSize = rs.getString("VideoSize");
			String  LockedFileCount = rs.getString("LockedFileCount");
			String  CorruptFileCount = rs.getString("CorruptFileCount");
			String  LatestVideoDateTime = rs.getString("LatestVideoDateTime");
			String  EntryBy = rs.getString("EntryBy");
			String  InsertionDateTime = rs.getString("InsertionDateTime");
			String  UpdatedDateTime = rs.getString("UpdatedDateTime");
			String  filename = rs.getString("FileName");
			
	
				//find the vehicle registration number and transporter
				String vehregno = "", transporter = "";
				String sql1 = "Select vehicleregnumber,OwnerName from db_gps.t_vehicledetails where VehicleCode = '"+Vehiclecode+"' ";
				ResultSet rs1 = st1.executeQuery(sql1);
				System.out.println("The sql is ==>"+sql1);
				if(rs1.next()){			
				  vehregno = rs1.getString("vehicleregnumber");
				  transporter = rs1.getString("OwnerName");
				}
				System.out.println("The transporter is :"+transporter);
				//add the data into the table
			%>
				<tr>
				
				<td  width ="10px"><div align="right"><%= ++cnt %></div></td>
				<td align="left"><div align="left"><%= vehregno %></div></td>
				<td align="left"><div align="left"><%= transporter %></div></td>
				<td align="right"><div align="right"><%= PeripheralSrNo %></div></td>
				<td align="right"><div align="right"><%= ProtectiveCoverId %></div></td>
				<td align="left"><div align="left"><%= SdCardPresent %></div></td>
				<td align="right"><div align="right"><%= SdCardId %></div></td>
				<td align="right"><div align="right"><%= SdCardSize %></div></td>
				<td align="left"><div align="left"><%= SealBroken %></div></td>
				<td align="right"><div align="right"><%= CurrentSealId %></div></td>
				<td align="right"><div align="right"><%= NewSealId %></div></td>
				<td align="right"><div align="right"><%= StandId %></div></td>				
				<td align="right"><div align="right"><%= VideoDuration %></div></td>
				<td align="right"><div align="right"><%= VideoSize %></div></td>
				<td align="right"><div align="right"><%= LockedFileCount %></div></td>
				<td align="right"><div align="right"><%= CorruptFileCount %></div></td>
				<td align="right"><div align="right"><%= FileCount %></div></td>
				<%
					if(LatestVideoDateTime!=null) {
						LatestVideoDateTime = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(LatestVideoDateTime));
					}else{
						LatestVideoDateTime = "-";
					}
				%>
				<td align="right"><div align="right"><%= LatestVideoDateTime %></div></td>
				<td align="left"><div align="left"><%= EntryBy %></div></td>
<!--				<td align="right"><div align="right">< %= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(InsertionDateTime)) %></div></td>-->
				<td align="right"><div align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(UpdatedDateTime)) %></div></td>
				<td align="left"><div align="left"><a href="#" onclick="showCameraInspectionImage('<%=filename%>');"><%=filename%></a></div></td>
				</tr>
			<%
			
		}
	}catch(Exception e1){
		System.out.println(e1.getMessage());
		e1.printStackTrace();
	}
	%>
</table>
</td>
</tr>
</table>
</div>
</form>
</jsp:useBean>
 <%@ include file="footernew.jsp" %>
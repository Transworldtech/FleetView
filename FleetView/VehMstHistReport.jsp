<%@ include file="headernew.jsp" %>

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

function getFTPImage(ftpFile)
{
	try
	{
		//alert(escape(ftpFile));
		//alert(ftpFile);
		window.open('showFTP.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=850, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
	}
}
</script>
<%
String datenew1="";
String datenew2="";
//String Status="";
String vehid="";
if(request.getParameter("data")!=null)
{
	System.out.println("yyyyyyyyyyyyyy");
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
 // Status=request.getParameter("Status1");
}
else
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	 //Status = "All";
}
       System.out.println("##########");
		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2));
		vehid = request.getParameter("VehID");
		System.out.println("FFFFFFF   "+vehid);

%>
<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	Vehicle Master History Report</div>
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	<form name = "vehhistory" method="get">
	<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
			<!-- <td align="left"><b>Status&nbsp;&nbsp;</b>
				<select name="Status1"  id="Status1" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
			 		<option value="All">All</option>
			 		<option value="Active">Active</option>
			 		<option value="Inactive">Inactive</option>	
			    </select>
				</td>-->
				<td></td>
			<td id="frmDT" align="left" style="display:''"><b>From&nbsp;&nbsp;</b>
					<input type="text" id="data" name="data" size="12" value="<%=datenew1%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>
				</td>
				<td></td>
				<td id="toDT" align="left" style="display:''"><b>To&nbsp;&nbsp;</b>
					<input type="text" id="data1" name="data1" size="12" value="<%=datenew2%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>&nbsp;&nbsp;&nbsp;
			 	 
				</td>
				<td><input type="submit" name="button" value="Go">
				<input type="hidden" id="VehID" name="VehID" value="<%=vehid%>"/></td>
			</tr>
			</table>
	
	</form>
	</div>
	<%! Connection conn;%>
	<%
	try
	{
	       
			conn = fleetview.ReturnConnection();
			Statement st=null;
			String sql=null;
			ResultSet rst=null;
			st=conn.createStatement();
			int i=1;
			String vehlist = session.getAttribute("VehList").toString();
		
	%>
	
	
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="customdetail" method="get">
<div align="left" style="margin-left: 0.6em"><a href="VehMasterReport.jsp">Back</a></div>
<%
System.out.println("*******  "+vehid);
%>

	<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
			<td>
			<table align="center" class="sortable">
			<tr>
			<th><div align="center"><font size="2"><b>Sr. No.</b></font></div></th>
			<th><div align="center"><font size="2"><b>Veh Reg No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Veh Typ</b></font></div></th>
			<th><div align="center"><font size="2"><b>Usage</b></font></div></th>
			<th><div align="center"><font size="2"><b>Owner Name</b></font></div></th>
			<th><div align="center"><font size="2"><b>Owner Sr No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Company</b></font></div></th>
			<th><div align="center"><font size="2"><b>Addr1</b></font></div></th>
			<th><div align="center"><font size="2"><b>Addr2</b></font></div></th>
			<th><div align="center"><font size="2"><b>Addr3</b></font></div></th>
			<th><div align="center"><font size="2"><b>State</b></font></div></th>
			<th><div align="center"><font size="2"><b>City</b></font></div></th>
			<th><div align="center"><font size="2"><b>PinCode</b></font></div></th>
			<th><div align="center"><font size="2"><b>Mnf Name</b></font></div></th>
			<th><div align="center"><font size="2"><b>Model</b></font></div></th>
			<th><div align="center"><font size="2"><b>Mnf Date</b></font></div></th>
			<th><div align="center"><font size="2"><b>RTO</b></font></div></th>
			<th><div align="center"><font size="2"><b>RTO State</b></font></div></th>
			<th><div align="center"><font size="2"><b>Reg Date</b></font></div></th>
			<th><div align="center"><font size="2"><b>RCBookNo</b></font></div></th>
			<th><div align="center"><font size="2"><b>Engine No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Chassis No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Gear Box No</b></font></div></th>
			<th><div align="center"><font size="2"><b>VIN No</b></font></div></th>
			<th><div align="center"><font size="2"><b>Unladen WT</b></font></div></th>
			<th><div align="center"><font size="2"><b>RLW</b></font></div></th>
			<th><div align="center"><font size="2"><b>GVS</b></font></div></th>	
			<th><div align="center"><font size="2"><b>Veh Class</b></font></div></th>
			<th><div align="center"><font size="2"><b>Type of Body</b></font></div></th>
			<th><div align="center"><font size="2"><b>Length</b></font></div></th>
			<th><div align="center"><font size="2"><b>Breadth</b></font></div></th>
			<th><div align="center"><font size="2"><b>Width</b></font></div></th>
			<th><div align="center"><font size="2"><b>Seating Capacity</b></font></div></th>
			<th><div align="center"><font size="2"><b>Standing Capacity</b></font></div></th>
			<th><div align="center"><font size="2"><b>No of tyres</b></font></div></th>
			<th><div align="center"><font size="2"><b>No of Cylinder</b></font></div></th>
			<th><div align="center"><font size="2"><b>Color</b></font></div></th>
			<th><div align="center"><font size="2"><b>Fuel</b></font></div></th>
			<th><div align="center"><font size="2"><b>RCBook Image</b></font></div></th>
			<th><div align="center"><font size="2"><b>Photo</b></font></div></th>
			<th><div align="center"><font size="2"><b>Entered By</b></font></div></th>
			<th><div align="center"><font size="2"><b>Entered Date Time</b></font></div></th>
			<th><div align="center"><font size="2" ><b>Status</b></font></div></th>
			</tr>
			<%
		//	 System.out.println("##########");
			
			 
			// System.out.println("##########  "+Status);
		//if(Status == "All" || Status.equals("All"))
			//{
				sql = "select * from db_gps.t_VehMsthistory where VehID = '"+vehid+"' and updateddatetime  between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' order by updateddatetime";
			//}
			//else
			//{
			//	sql = "select * from db_gps.t_VehMsthistory where VehID = '"+vehid+"' and updateddatetime  between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Status = '"+Status+"'  order by VehRegn";
			//}
			System.out.println("^^^^^^^^   "+sql);
			rst = st.executeQuery(sql);
		//	System.out.println("^^^^^^^^   "+sql);
			while(rst.next())
			{
				
				String copy1="-",copy2="-";
				%>
				<tr>
				<td align="right"><div align="right"><font size="2" ><%= i%></font></div></td>
				<td align="left"><div align="left"><font size="2" ><%= rst.getString("VehRegn")%></font></div></td>
				<td align="right"><div align="left"><font size="2"><%= rst.getString("VehicleType")%></font></div></td>
				<td align="right"><div align="left"><font size="2"><%= rst.getString("VehUsage")%></font></div></td>
				<td align="right"><div align="left"><font size="2"><%= rst.getString("Regowner")%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%= rst.getString("OSrNo")%></font></div></td>
				<td align="right"><div align="left"><font size="2"><%= rst.getString("Company")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Address1")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Address2")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Address3")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("State")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("City")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Pincode")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("MnfName")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Model")%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rst.getString("Mnfdate")))%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("RTO")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("RTOState")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("RegDate")))%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("RCBookNo")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("Engno")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("Chassisno")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("Gearno")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("VinNo")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("UnladenWt")%></font></div></td>	
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("RLW")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("GVS")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Class")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("body")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("Length")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("Breadth")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("Width")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("SeatingCap")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("StandingCap")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("NoOfTyres")%></font></div></td>		
				<td align="right"><div align="right"><font size="2" ><%= rst.getString("NoofCyl")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Color")%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Fuel")%></font></div></td>
				<%
				if(rst.getString("RCBookCopy")=="-" || rst.getString("RCBookCopy").equals("-") || rst.getString("RCBookCopy")==null || rst.getString("RCBookCopy").equals("null"))
				{
					%>
					<td align="right"><div align="left"><font size="2" ><%= rst.getString("RCBookCopy")%></font></div></td>
					<%
				}
				else
				{
					String[] token=rst.getString("RCBookCopy").split(",");
					System.out.println("************    "+token.length);
					if(token.length==2)
					{
						System.out.println("******   in 2");
						copy1 = token[0].substring(token[0].lastIndexOf("/")+1).substring(18);
				        copy2 = token[1].substring(token[1].lastIndexOf("/")+1).substring(18);
				        %>
				         <td align="right"><div align="left">
				        <a href="#" onclick="getFTPImage('<%=token[0].substring(token[0].lastIndexOf("/")+1) %>')">
						<font size="2" ><%=copy1%></font></a>
						<br>
						<a href="#" onclick="getFTPImage('<%=token[1].substring(token[1].lastIndexOf("/")+1) %>')">
						<font size="2" ><%=copy2%></font></a>
						</div></td>
				        <%
					}
					else
					{
						System.out.println("****** not 2");
						copy1 = token[0].substring(token[0].lastIndexOf("/")+1).substring(18);
						%>
						 <td align="right"><div align="left">
				        <a href="#" onclick="getFTPImage('<%=token[0].substring(token[0].lastIndexOf("/")+1) %>')">
						<font size="2" ><%=copy1%></font></a>
						</div></td>
						<%
						
					}
				}
				
				if(rst.getString("Photo")=="-" || rst.getString("Photo").equals("-") || rst.getString("Photo")==null || rst.getString("Photo").equals("null"))
				{
					%>
					<td align="right"><div align="left"><font size="2" ><%= rst.getString("Photo")%></font></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="left">
					<a href="#" onclick="getFTPImage('<%=rst.getString("Photo").substring(rst.getString("Photo").lastIndexOf("/")+1) %>')">
					<font size="2" ><%= rst.getString("Photo").substring(rst.getString("Photo").lastIndexOf("/")+1).substring(18)%></font></div></td>
					<%
				}
				%>
			<!-- 	<td align="right"><div align="left">
				<a href="#" onclick="getFTPImage('< %=rst.getString("RCBookCopy") %>')">
				<font size="2" >< %= rst.getString("RCBookCopy").substring(rst.getString("RCBookCopy").lastIndexOf("/")+1)%></font></a></div></td>
				<td align="right"><div align="left"><font size="2" >< %= rst.getString("Photo").substring(rst.getString("Photo").lastIndexOf("/")+1)%></font></div></td>-->
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("EntBy")%></font></div></td>
				<td align="right"><div align="right"><font size="2" ><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EntDateTime")))%></font></div></td>
				<td align="right"><div align="left"><font size="2" ><%= rst.getString("Status")%></font></div></td>
				</tr>
		  <%
		  i++;
			}
			
			%>
			
			</table>
	
	  <%
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
	
<%@ include file="headernew.jsp"%>
<%@page import="com.transworld.fleetview.framework.DisconnectionReport"
	import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
	import="com.transworld.fleetview.framework.DisconnectionReportViewData"
	import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="powerOnOffReport.ImplementationOfDisconnection"
	import="powerOnOffReport.DisconnectionData"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"%>
	
<script type="text/javascript">
function validate()
{
	var rdb=document.dateform.rdbsearch.length;
	var i=0;
	
	for(i=0;i<rdb;i++)
	{
		//alert("inside"); 
		if(document.dateform.rdbsearch[i].checked)
		{
			//alert("op  "+i);
			document.getElementById("opt").value = i;
		}
		
	} 
}

</script>
	
	
<%! String data1, data2, showdate, showdate1;
	int total = 0;
	String VehicleRegNo = "";%>
	
	
	
	<%
Connection conn1 = null;

Statement st = null;
Statement st1=null;
Statement st2=null;

	try
	{
		
		String ownerName = null;
		Class.forName(MM_dbConn_DRIVER);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		

		st = conn1.createStatement();
		st1 = conn1.createStatement();
		st2 = conn1.createStatement();
		String fromDate = "", toDate = "";
       
		String dd = request.getQueryString();
		if (dd == null) {
			Calendar cal = Calendar.getInstance();
			String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
					.format(cal.getTime());
			data2 = today_dt;
			String temp = data2;
			toDate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

			cal.add(Calendar.DATE, -1);
			String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
					.format(cal.getTime());
			data1 = yesterday_dt;
			temp = data1;

			fromDate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		} else {

			data1 = request.getParameter("data");

			fromDate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(data1));
			data2 = request.getParameter("data1");

			toDate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(data2));

		} //end of else
		String opt = request.getParameter("opt");
		if(opt == null || opt.equalsIgnoreCase("null") || opt == "" || opt.equalsIgnoreCase(""))
		{
			opt = "0";
		}
		String user = session.getAttribute("usertypevalue").toString();
	%>
	<form name="dateform" action="" method="get"
	onsubmit="return validate();">
<table border="0" align="center" class="sortable_entry" style="width: 80em;margin-left: 20em;">
	<tr>
<td>
<font size="2">		 
				<input type="radio" name="rdbsearch" id="rdbsearch" value="DO1DS1" class="bodyText">Door 1&nbsp;&nbsp; 
				<input type="radio" name="rdbsearch" id="rdbsearch" value="DO2DS2" class="bodyText">Door 2
					
					</font>
</div>
</td>
		<td><b><font size="2">From : </font></b>&nbsp;&nbsp; <input
			type="text" id="data" name="data"
			value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate))%>" size="15" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td><b><font size="2">To : </font></b>&nbsp;&nbsp; <input
			type="text" id="data1" name="data1"
			value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>" size="15" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td align="left"><input type="submit" name="submit" id="submit"
			value="submit">
			<input type="hidden" id="opt" name="opt" value="<%=opt %>">
			</td>
	</tr>
</table>
<div>
</form>
<%
	if (!(null == request.getQueryString())) {
		String data = "", data1 = "", vehicleCode = "", vehicleRegistrationNumber = "",sumOfDist="",intripCount="";
		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		System.out.println("$$$$$$$$ "+fromDate);
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));
		System.out.println("$$$$$$$$ "+toDate);
%>
<table border="0" width="100%" class="stats">
	<tr>
		<td colspan="5">
		<table border="0" width="100%">
			<tr>
			<th colspan="3" align="center"><font size="3">
			<%
			if(opt == "0" || opt.equals("0"))
		   {
		     %>
				Door 1 Access Report  for <%=user%> from <%=request.getParameter("data")%>
				to <%=request.getParameter("data1")%> 
				<%
		   }
			else
				if(opt == "1" || opt.equals("1"))
				{
					%>
					Door 2 Access Report  for <%=user%> from <%=request.getParameter("data")%>
					to <%=request.getParameter("data1")%> 
					<%
				}
				%>
				</font>
				<div align="right">&nbsp;&nbsp;&nbsp;Date : <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 		String sdt = fmt.format(new java.util.Date());
 		out.print(sdt);
 		String fromtime, totime;
 %>
				</div>
				</th>
				</tr>
		</table>
		<table border="1" align="center" class="sortable"  style="width: 80em;margin-left: 20em;">
			<tr>
				<th>Sr.</th>
				<th>Transporter</th>
				<th>Vehicle</th>
				<th>Count</th>
				<!-- <th>Km. during Power Off</th>-->
			</tr>		
	<%
	String commaSeparatedVehicleList = session.getAttribute("VehList").toString();
	System.out.println("vehcode "+commaSeparatedVehicleList);
//	String sql="select a.vehiclecode as vehcode,a.vehicleRegNumber as vehregno,a.ownername as oname,a.UnitID as uid,b.UnitID as uid1 from db_gps.t_vehicledetails as a "
	//+" INNER JOIN db_gps.t_unitmaster as b on (a.UnitID=b.UnitID) and b.peripherals like '%with%' and a.vehiclecode in "+commaSeparatedVehicleList+" and a.vehiclecode <> 1118";
	
	String sql="select * from db_gps.t_vehicledetails where vehiclecode in "+commaSeparatedVehicleList+"";
	//String sql="select * from db_gps.t_vehicledetails where vehiclecode = '2767'";
	ResultSet rs1=st.executeQuery(sql);
	System.out.println("************     "+sql);
	int i = 1;
	int j = 0;
	int x=1;
//	int distance=0;
	///int distance1=0;
	//int distance2=0;
	//int dt=0;
	boolean flag=false;
	
	//String date4=null;
	long millis1=00;
	long millis2=00;
	long millis3=00;
	while(rs1.next())
	{
		java.util.Date date1=null;
		java.util.Date date2=null;
		java.util.Date date=null;
		java.util.Date date3=null;
		long time=0,time1=0,time2=0,time3=00;
		String offtime="";
		String ontime="";
		String stamp = "";
		String stamp1 = "";
		j=0;
	    x=1;
		int k=1;
		//x=1;
		String vehcode=rs1.getString("VehicleCode");
	//	System.out.println("*****************"+vehcode);
		String vehregno=rs1.getString("VehicleRegNumber");
		ownerName=rs1.getString("ownername"); 
		String sql1="";
		System.out.println("opt  ---->   "+opt);
		if(opt == "0" || opt.equals("0"))
		{
		 sql1="Select TheFiledTextFileName from db_gps.t_veh"+vehcode+" where TheFiledTextFileName in ('DO1','DS1') and TheFieldDataDate between '"+fromDate+"' and '"+toDate+"' order by Thefielddatadatetime asc";
		}
		else
			if(opt == "1" || opt.equals("1"))
		{
			sql1="Select TheFiledTextFileName from db_gps.t_veh"+vehcode+" where TheFiledTextFileName in ('DO2','DS2') and TheFieldDataDate between '"+fromDate+"' and '"+toDate+"' order by Thefielddatadatetime asc";
		}
		System.out.println("---->   "+sql1);
		ResultSet rs2=st1.executeQuery(sql1);
		if(rs2.next())
		{
			stamp =rs2.getString("TheFiledTextFileName");
		}
		
		if(rs2.last())
		{
			stamp1 = rs2.getString("TheFiledTextFileName");
		}
		
		System.out.println("$$$$$$$$    "+stamp+"  *****   "+stamp1);
		
		if(stamp=="DO1" || stamp.equalsIgnoreCase("DO1") || stamp=="DO2" || stamp.equalsIgnoreCase("DO2"))
		{
			
		}
		else
			if(stamp=="DS1" || stamp.equalsIgnoreCase("DS1")  || stamp=="DS2" || stamp.equalsIgnoreCase("DS2"))
			{
				j++;
			}
		
		if(opt == "0" || opt.equals("0"))
		{
		 sql1="SELECT a.VehCode,a.TheDate,a.TheTime,a.Lat,a.Lon,b.TheDate,b.TheTime,b.Lat,b.Lon,b.VehCode,a.stamp,b.stamp"
			  +" FROM "
			  +"  (select VehCode,TheDate,TheTime,Lat,Lon,stamp "
			  +" FROM db_gps.t_dooropen "
			  +"  ) a "
			  +" INNER JOIN db_gps.t_doorclose b "
			  +" ON ( a.VehCode=b.VehCode "
			  +"	AND concat(b.TheDate,' ',b.TheTime) = (select concat(c.thedate,' ',c.thetime) from db_gps.t_doorclose c WHERE c.vehcode= a.vehcode and concat(c.thedate,' ',c.thetime) > concat(a.thedate,' ',a.thetime)  and c.stamp = 'DS1' order by c.thedate,c.thetime asc limit 1) )"   
			  +" WHERE a.TheDate >='"+fromDate+"' AND a.TheDate <='"+toDate+"'"
			  +" AND a.VehCode ="+vehcode
			  +" And a.stamp = 'DO1'"
			  +"  ORDER BY a.TheDate,a.TheTime ASC";
		}
		else
			if(opt == "1" || opt.equals("1"))
			{
				sql1="SELECT a.VehCode,a.TheDate,a.TheTime,a.Lat,a.Lon,b.TheDate,b.TheTime,b.Lat,b.Lon,b.VehCode,a.stamp,b.stamp"
					  +" FROM "
					  +"  (select VehCode,TheDate,TheTime,Lat,Lon,stamp "
					  +" FROM db_gps.t_dooropen "
					  +"  ) a "
					  +" INNER JOIN db_gps.t_doorclose b "
					  +" ON ( a.VehCode=b.VehCode "
					  +"	AND concat(b.TheDate,' ',b.TheTime) = (select concat(c.thedate,' ',c.thetime) from db_gps.t_doorclose c WHERE c.vehcode= a.vehcode and concat(c.thedate,' ',c.thetime) > concat(a.thedate,' ',a.thetime) and c.stamp = 'DS2' order by c.thedate,c.thetime asc limit 1) )"   
					  +" WHERE a.TheDate >='"+fromDate+"' AND a.TheDate <='"+toDate+"'"
					  +" AND a.VehCode ="+vehcode
					  +" And a.stamp = 'DO2'"
					  +"  ORDER BY a.TheDate,a.TheTime ASC";
			}
		
		 rs2 = st1.executeQuery(sql1);
		 System.out.println(sql1);
		 while(rs2.next())
		 {
			 
			 if(x==1)
				{
				date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("a.TheDate")+" "+rs2.getString("a.TheTime"));
			    time1=date.getTime();
			    
			    date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
				time2=date1.getTime();
				
				time3=time2-time1;
				time3=time3/1000/60;
				
					  j=j+2;
					  date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
					  time=date2.getTime();
					  System.out.println("%%%%%%%% "+sql1);
				
				x++;
				}
				else
				{
					date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("a.TheDate")+" "+rs2.getString("a.TheTime"));
				    time1=date.getTime();
				    
				    date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
					time2=date1.getTime();
					
					time3=time2-time1;
					time3=time3/1000/60;
					
					if(time1>time)
					{
						 j=j+2;
						  date2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("b.TheDate")+" "+rs2.getString("b.TheTime"));
						  time=date2.getTime();
						  System.out.println("%%%%%%%% "+sql1);
					}
					x++;
				}
		 }
		 if(stamp1=="DO1" || stamp1.equalsIgnoreCase("DO1") || stamp=="DO2" || stamp.equalsIgnoreCase("DO2"))
			{
			     j++;
			}
		
	if(j>0)
	{
	%>
	<tr>
	<td class="bodytext"><div align="right"><font size="2" face="Arial"><%=i %></font></div></td>
	<td class="bodytext"><div align="left"><font size="2" face="Arial"><%=ownerName %></font></div></td>
	<td class="bodytext"><div align="left"><font size="2" face="Arial"><%=vehregno %></font></div></td>
	<td class="bodytext"><div align="right"><font size="2" face="Arial">
     <a href="doorSensorDetailReport.jsp?vehicleCode=<%=vehcode%>&VehicleRegNo=<%=vehregno%>&fromDateTime=<%=fromDate%>&toDateTime=<%=toDate%>&ownerName=<%=ownerName%>&opt=<%=opt %>"><%=j%></a></font></div></td>
	</tr>
	<%
	i++;
}
	%>
	<!-- <td class="bodytext"><div align="right"><font size="2" face="Arial">< %=dt %></font></div></td>-->
	
	<%
	

	}
	
	}
   System.out.println("RRRRRRRRRR");
	}
	catch(Exception e)
	{
		e.printStackTrace();
		System.out.println("Exception------------> "+e);
	}
	finally
	{
		st.close();
		st1.close();
		st2.close();
		conn1.close();
		
	}
	System.out.println("************");
	%>
	<%@ include file="footernew.jsp" %>

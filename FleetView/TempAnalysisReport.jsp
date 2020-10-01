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
          document.kraft_report.action ="excel.jsp";
          document.forms["kraft_report"].submit();

        //  document.roundtripdata.action ="excel.jsp";

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

	//validate vehicle code
	var vehcode=document.getElementById("vehcode").value;
	if(vehcode == "select")
	{
		alert("Select Serial no!");
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
	String date2 = "";
	String vehcode = "";
	String VehicleRegNumber = "";%>	
	
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
	 VehicleRegNumber = request.getParameter("VehicleRegNumber");
	
	 Class.forName(MM_dbConn_DRIVER);
	 conn = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	 st = conn.createStatement();
	 st1 = conn.createStatement();
	
}catch(Exception e){
	System.out.println("Exception "+e);
}
DecimalFormat df = new DecimalFormat("0.00");
%>	
<form id="camera_inspection_report" name="camera_inspection_report" onsubmit="return datevalidate();">
<table border="0" width="100%" class="stats">
	<tr>
		<td align="left">
		<font size="2" face="Arial"><b>Device No</b></font>&nbsp;&nbsp;<select class="element select medium" id="VehicleRegNumber" name="VehicleRegNumber" > 
			<option value="select"></option>
			<%
            String query1 = "select distinct(VehicleRegNumber) from db_gps.t_vehicledetails where OwnerName = 'KRAFT FOODS INC' order by VehicleRegNumber";
             ResultSet rs1 = st1.executeQuery(query1);
             while(rs1.next())
              {
            	 if(rs1.getString("VehicleRegNumber").equals(VehicleRegNumber))
					{
						%><option value="<%=rs1.getString("VehicleRegNumber") %>" selected><%=rs1.getString("VehicleRegNumber")%></option><%
					}else{
						%><option value="<%=rs1.getString("VehicleRegNumber") %>" ><%=rs1.getString("VehicleRegNumber")%></option><%
					}
				%>			
			<%} %>
			
		</select>
		&nbsp;&nbsp;
		<font size="2" face="Arial"><b>From Date&nbsp;&nbsp;</b></font>
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
		
		&nbsp;&nbsp;
		<input type ="submit" name ="submit" id ="submit" value="submit"></input>		
		</td>
	</tr>
</table>
</form>
<br/>

<%if(date1==null || date2==null){

}else {
	date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date1));
	date2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
%>
<%try{ %>
<form id="kraft_report" name="kraft_report" action="" method="post">

		<%
		 String  exportFileName="temperature_analysis_report.xls";
		%>
		
<table border="0" width="90%" class="stats">
	<tr>
		<td align="center">	
				<font size="3" face="Arial"><b>Temperature Analysis Report for Device No <%= VehicleRegNumber%> From <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> To <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%></b></font>
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

<%

String query11 = "select VehicleCode from db_gps.t_vehicledetails where VehicleRegNumber = '"+VehicleRegNumber+"' ";
ResultSet rs11 = st1.executeQuery(query11);
if(rs11.next())
 {
	 	vehcode	= rs11.getString("VehicleCode");
 }

int cnt_sen = 0;
String sql12 = "select count(Sen1) as cnt_sen from db_gps.t_tempsamplevalues where Sen1 <> '0' and Sen1 <> '-' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  AND vehid = '"+vehcode+"' ";
System.out.println(sql12);
ResultSet rsnew12 = st.executeQuery(sql12);
if(rsnew12.next())
{
	cnt_sen = rsnew12.getInt("cnt_sen");
}
if(cnt_sen > 0) {
	
	 		//find all the parameeters
				String Maxsen1 = "",MinSen1 = "",TotalSen1="",Maxsen1datetime="",Minsen1datetime="",mean ="",std="",durOfRecord="",Minstampdatetime="",Maxstampdatetime="",Minstamp="",Maxstamp="",up_22="",up_22_per="",lp_18="",lp_18_per="",bet_sen="",bet_sen_per="";int total_dur=0,dur_of_record=0;
					String sql2 = "select Max(Sen1) as Maxsen1,Min(Sen1) as MinSen1,count(DISTINCT(thefielddatadatetime)) as TotalSen1,FORMAT(avg(Sen1),2) as mean, FORMAT(std(Sen1),2) as std, count(DISTINCT(thefielddatadatetime)) as durOfRecord  from db_gps.t_tempsamplevalues where thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59' AND Sen1<>'-' and  Sen1 <> '0' AND vehid = '"+vehcode+"'";
					System.out.println(sql2);
					ResultSet rsnew2 = st.executeQuery(sql2);
					if(rsnew2.next())
					{
						 Maxsen1 = rsnew2.getString("Maxsen1");
						 MinSen1 = rsnew2.getString("MinSen1");
						 TotalSen1 = rsnew2.getString("TotalSen1");
						 mean = rsnew2.getString("mean");
						 std = rsnew2.getString("std");
						 durOfRecord = rsnew2.getString("durOfRecord");
					}
				
				String sql3 = "select thefielddatadatetime from db_gps.t_tempsamplevalues where Sen1 = '"+Maxsen1+"' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59' AND Sen1<>'-' AND vehid = '"+vehcode+"' limit 1";
				System.out.println(sql3);
				ResultSet rsnew3 = st.executeQuery(sql3);
				if(rsnew3.next())
				{
					 Maxsen1datetime = rsnew3.getString("thefielddatadatetime");
				}
				
				String sql4 = "select thefielddatadatetime from db_gps.t_tempsamplevalues where Sen1 = '"+MinSen1+"' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59' AND Sen1<>'-' AND vehid = '"+vehcode+"' limit 1";
				System.out.println(sql4);
				ResultSet rsnew4 = st.executeQuery(sql4);
				if(rsnew4.next())
				{
					 Minsen1datetime = rsnew4.getString("thefielddatadatetime");
					
				}
				

				String sql5 = "select  Sen1,thefielddatadatetime from db_gps.t_tempsamplevalues where Sen1 <> '-' and Sen1 <> '0' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  AND vehid = '"+vehcode+"' order by thefielddatadatetime ASC limit 1";
				System.out.println(sql5);
				ResultSet rsnew5 = st.executeQuery(sql5);
				if(rsnew5.next())
				{
					 Minstampdatetime = rsnew5.getString("thefielddatadatetime");
					 Minstamp = rsnew5.getString("Sen1");
					
				}
				
				String sql6 = "select Sen1,thefielddatadatetime from db_gps.t_tempsamplevalues where Sen1 <> '-' and  Sen1 <> '0' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  AND vehid = '"+vehcode+"' order by thefielddatadatetime DESC limit 1";
				System.out.println(sql6);
				ResultSet rsnew6 = st.executeQuery(sql6);
				if(rsnew6.next())
				{
					 Maxstampdatetime = rsnew6.getString("thefielddatadatetime");
					 Maxstamp = rsnew6.getString("Sen1");
				}
				
				//above parameters
				String sql7 = "select count(DISTINCT(thefielddatadatetime)) as up_22 from db_gps.t_tempsamplevalues where Sen1 > '22' and  Sen1 <> '0' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  AND vehid = '"+vehcode+"' ";
				System.out.println(sql7);
				ResultSet rsnew7 = st.executeQuery(sql7);
				if(rsnew7.next())
				{
					up_22 = rsnew7.getString("up_22");
				}
				
				String sql8 = "select TIMEDIFF('"+Maxstampdatetime+"','"+Minstampdatetime+"') as dur_of_record";
				System.out.println(sql8);
				ResultSet rsnew8 = st.executeQuery(sql8);
				if(rsnew8.next())
				{
					dur_of_record = rsnew8.getInt(1);
				}
				
				//below parameters
				String sql9 = "select count(DISTINCT(thefielddatadatetime)) as lp_18 from db_gps.t_tempsamplevalues where Sen1 < '18' and  Sen1 <> '0' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  AND vehid = '"+vehcode+"' ";
				System.out.println(sql9);
				ResultSet rsnew9 = st.executeQuery(sql9);
				if(rsnew9.next())
				{
					lp_18 = rsnew9.getString("lp_18");
				}
				
				String sql10 = "select TIMEDIFF('"+date2+" 23:59:59','"+date1+" 00:00:00') as total_dur";
				System.out.println(sql10);
				ResultSet rsnew10 = st.executeQuery(sql10);
				if(rsnew10.next())
				{
					total_dur = rsnew10.getInt("total_dur");
				}
				
				
				//between parameters
				String sql11 = "select count(DISTINCT(thefielddatadatetime)) as bet_sen from db_gps.t_tempsamplevalues where Sen1 >= '18' and Sen1 <= '22' and  Sen1 <> '0' and  Sen1 <> 'null' and  thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  AND vehid = '"+vehcode+"' ";
				System.out.println(sql11);
				ResultSet rsnew11 = st.executeQuery(sql11);
				if(rsnew11.next())
				{
					bet_sen = rsnew11.getString("bet_sen");
				}
				System.out.println("The Maxsen1 = " +Maxsen1);
				System.out.println("The MinSen1 = " +MinSen1);
				System.out.println("The TotalSen1 = " +TotalSen1);
				System.out.println("The mean = " +mean);
				System.out.println("The std = " +std);
				System.out.println("The durOfRecord = " +durOfRecord);
				System.out.println("The Minstamp = " +Minstamp);
				System.out.println("The Minstampdatetime = " +Minstampdatetime);
				System.out.println("The Maxstamp = " +Maxstamp);
				System.out.println("The Maxstampdatetime = " +Maxstampdatetime);
				System.out.println("The up_22 = " +up_22);
				System.out.println("The total_dur = " +total_dur);
				System.out.println("The lp_18 = " +lp_18);
				System.out.println("The lp_18_per = " +lp_18_per);
				System.out.println("The bet_sen = " +bet_sen);
				System.out.println("The bet_sen_per = " +bet_sen_per);
			
			String sensor = "", sendate = "";
			int cnt = 0;
			String sql = "select distinct(thefielddatadatetime),Sen1 from db_gps.t_tempsamplevalues where thefielddatadatetime between '"+date1+" 00:00:00' and '"+date2+" 23:59:59' AND Sen1<>'-' and  Sen1 <> '0' AND vehid = '"+vehcode+"' GROUP BY thefielddatadatetime ORDER BY thefielddatadatetime ASC";
				System.out.println(sql);
				ResultSet rsnew = st.executeQuery(sql);
				while(rsnew.next())
				{
					++cnt;
					if(cnt == 1) {
						String Sen = rsnew.getString("Sen1");
						sensor = Sen;
						String TheFieldDataDateTime = rsnew.getString("TheFieldDataDateTime");
						//TheFieldDataDateTime = new SimpleDateFormat("yyyy, MM, dd, HH, mm, ss, SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(TheFieldDataDateTime));
						sendate = new SimpleDateFormat("yyyy, MM, dd, HH, mm, ss, SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(TheFieldDataDateTime));
					}else{
						String Sen = rsnew.getString("Sen1");
						sensor = sensor +" # "+ Sen;
						String TheFieldDataDateTime = rsnew.getString("TheFieldDataDateTime");
					//	TheFieldDataDateTime = new SimpleDateFormat("yyyy, MM, dd, HH, mm, ss, SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(TheFieldDataDateTime));
						sendate = sendate +" # "+ new SimpleDateFormat("yyyy, MM, dd, HH, mm, ss, SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(TheFieldDataDateTime));
					}
				}
				
		//	System.out.println("The sensor is :"+sensor);
		//	System.out.println("The sendate is :"+sendate);
				
		%>	
<div style="width:90%;" align="center" id="table1" >
<table border="0" align ="center" style="width: 55em; margin-left: 13em;">
	<tr>
		<td>	
			<table border="0" align ="center" style="width: 100%;" cellpadding="2" cellspacing="10" style="width: 80em; margin-left: 20em;" >
	
			<tr>
				<td align="left" width="30%" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Logger <%=VehicleRegNumber %></b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left" width="30%" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Temprecord <%=VehicleRegNumber %></b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left" width="30%" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="4" face="Arial"><b>Summary</b></font></label>
				</td>
			</tr>	
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Data shown is from logger <%=VehicleRegNumber %></b></font></label>
				</td>
			</tr>	
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Date Printed</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%= new SimpleDateFormat("dd-MMM-yyyy").format(new Date())%></font>	
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>	
			<tr>
				<td align="left" >
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Date logger was read</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%= new SimpleDateFormat("dd-MMM-yyyy").format(new Date())%></font>		
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>	
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Logger Type</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					Mobile Eye	</font>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Serial Number</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=vehcode %>	</font>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>
			
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Logger Status</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					logging	</font>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>	
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="3" face="Arial">Logging</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					Temperature only </font>	
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="3" face="Arial">Sample Period</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					1:00:00	</font>
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
					(1.0 / hour)</font>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples in Logger</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=TotalSen1 %></font>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">First Sample</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Minstampdatetime))%></font>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Last Sample</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Maxstampdatetime))%></font>
				</td>
				<td>
				</td>
				<td>
				</td>
			</tr>	
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Start with Button</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					OFF	</font>
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
					Allow Markers</font>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					OFF</font>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Stop with Button</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					OFF	</font>
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
					Loop Overwrite</font>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					OFF</font>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Start with Switcher</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					OFF	</font>
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
					Safe Range Entry</font>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
					OFF</font>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Stop with Switcher</font></label>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">	OFF	</font>			
				</td>
				<td align="left">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Limit Delay</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					0 samples		</font>		
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Upper Limit</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					22.00 C 	</font>			
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
				(exceeded) </font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Lower Limit</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					18.00 C		</font>		
				</td>
				<td align="left" style="color: blue"> <font size="2" face="Arial">
				(exceeded) </font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Total Samples</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=TotalSen1 %>	</font>	
				</td>
				<td align="left" style="color: blue"> <font size="2" face="Arial">
				Logger Version </font>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
				2.13</font>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Total Uses</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					8	</font>		
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
				Memory</font>
				</td>
				<td align="right" style="color: blue"><font size="2" face="Arial">
				8k</font>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Sensor</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					Standard		</font>	
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>User Data</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">User Data 1</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					Cadbury India Limited	</font>	
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">User Data 2</font></label>
				</td>
				<td align="right" style="color: blue">	<font size="2" face="Arial">
					E3 ware house		</font>
				</td>
				<td align="left" style="color: blue"><font size="2" face="Arial">
					Baddi</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">User Data 3</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">User Data 4</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">User Data 5</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Comment Fields</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 1</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 2</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 3</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 4</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 5</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 6</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 7</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 8</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 9</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Field 10</font></label>
				</td>
				<td align="right">			
				</td>
				<td align="center">
				</td>
				<td align="right">
				</td>
			</tr>
			</table>
		</td></tr>
		
		
		<tr>	
		<td>	
		<table border="0" align ="center" style="width: 100%;" cellpadding="2" cellspacing="10" style="width: 80em; margin-left: 20em;" >	
			<tr>
				<td align="left" colspan="4" width="30%">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Logger <%=VehicleRegNumber %></b></font></label>
				</td>
			</tr>
			
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="4" face="Arial"><b>Statistics</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left" width="30%">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">First Sample was at</font></label>
				</td>
				<td align="right" width="25%" style="color: red"><font size="2" face="Arial">
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Minstampdatetime))%></font>			
				</td>
				<td align="left" style="color: red" width="35%"><font size="2" face="Arial">
					(<%=Minstamp %> C)</font>
				</td>
				<td align="right" width="10%">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Last Sample was at</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Maxstampdatetime))%>	</font>
				</td>
				<td align="left" style="color: red"><font size="2" face="Arial">
					(<%=Maxstamp %> C)</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Total Duration</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=total_dur %>:00:00 </font>	
				</td>
				<td align="left" style="color: red"><font size="2" face="Arial">
					(<%=TotalSen1 %> samples)</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" color="blue" face="Arial">Temperature - Statistics for All Samples</font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Start Marker is at Sample</font></label>
				</td>
				<td align="right" style="color: red;"><font size="2" face="Arial">1</font>						
				</td>
				<td align="left" style="color: red"><font size="2" face="Arial">
					(<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Minstampdatetime))%>, <%=Minstamp %> C)</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">End Marker is at Sample</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">	
					<%=TotalSen1 %> </font>
				</td>
				<td align="left" style="color: red"><font size="2" face="Arial">
					(<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Maxstampdatetime))%>, <%=Maxstamp %> C)</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Duration of record</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">	
					<%=dur_of_record %>:00:00</font>
				</td>
				<td align="left" style="color: red"><font size="2" face="Arial">
					(<%=TotalSen1 %> samples)</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Mean</font></label>
				</td>
				<td align="right" style="color: red">		<font size="2" face="Arial">
					<%=mean %> C</font>
				</td>
				<td align="center">			
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Standard Deviation</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">	
					<%=std %> C </font>
				</td>
				<td align="center">			
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Maximum</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">	
					<%= Maxsen1 %> C </font>
				</td>
				<td align="left" style="color: red">	<font size="2" face="Arial">
					(<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Maxsen1datetime))%>)	</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Minimum</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">	
					<%= MinSen1 %> C </font>
				</td>
				<td align="left" style="color: red"><font size="2" face="Arial">	
					(<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Minsen1datetime))%>)	</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Upper Limit (22.00 C)</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Above</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
				<%=up_22 %>:00:00			</font>	
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Above</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=up_22 %>				</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Above</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= df.format((Double.parseDouble(up_22) * 100)/(Double.parseDouble(durOfRecord)))%>	</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Lower Limit (18.00 C)</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Below</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= lp_18%>:00:00		</font>	
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Below</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= lp_18%>			</font>	
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Below</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= df.format((Double.parseDouble(lp_18)*100)/(Double.parseDouble(durOfRecord)))%>		</font>	
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Both Limits (between 18.00 C and 22.00 C)</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Inside</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=bet_sen %>:00:00	</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Inside</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=bet_sen %>	</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Inside</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=df.format((Double.parseDouble(bet_sen) * 100) / (Double.parseDouble(durOfRecord))) %>	</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Outside</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=Integer.parseInt(up_22) + Integer.parseInt(lp_18) %>:00:00	</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Outside</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=Integer.parseInt(up_22) + Integer.parseInt(lp_18) %>	</font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Outside</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= df.format(((Double.parseDouble(up_22) + Double.parseDouble(lp_18)) * 100) / (Double.parseDouble(durOfRecord))) %></font>
				</td>
				<td align="center">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" color="blue" face="Arial"><b>Temperature - Statistics for Samples Between Start and End Markers</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Start Marker is at Sample</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					1</font>
				</td>
				<td align="left" style="color: red">	<font size="2" face="Arial">
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Minstampdatetime))%></font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">End Marker is at Sample</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=TotalSen1 %></font>
				</td>
				<td align="left" style="color: red">	<font size="2" face="Arial">
					<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Maxstampdatetime))%></font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Duration of record</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=dur_of_record %>:00:00 </font>
				</td>
				<td align="left" style="color: red">	<font size="2" face="Arial">
					(<%=TotalSen1 %> samples) </font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Mean</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=mean %> C </font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Standard Deviation</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=std %> C </font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Maximum</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= Maxsen1 %> C </font>
				</td>
				<td align="left" style="color: red">	<font size="2" face="Arial">
					(<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Maxsen1datetime))%>)	</font>	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Minimum</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= MinSen1 %> C </font>
				</td>
				<td align="left" style="color: red">	<font size="2" face="Arial">
					(<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Minsen1datetime))%>)	</font>
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Upper Limit (22.00 C)</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Above</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=up_22 %>:00:00	 </font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Above</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%=up_22 %> </font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Above</font></label>
				</td>
				<td align="right" style="color: red">	<font size="2" face="Arial">
					<%= df.format((Double.parseDouble(up_22) * 100)/(Double.parseDouble(durOfRecord)))%>	</font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Lower Limit (18.00 C)</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Below</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=lp_18 %>:00:00	</font>	
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Below</font></label>
				</td>
				<td align="right" style="color: red"> <font size="2" face="Arial">
					<%=lp_18 %> </font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Below</font></label>
				</td>
				<td align="right" style="color: red"> <font size="2" face="Arial">
					<%= df.format((Double.parseDouble(lp_18)*100)/(Double.parseDouble(durOfRecord) * 24))%>		</font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial"><b>Both Limits (between 18.00 C and 22.00 C)</b></font></label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Inside</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=bet_sen %>:00:00	</font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Inside</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=bet_sen %></font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Inside</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=df.format((Double.parseDouble(bet_sen) * 100) / (Double.parseDouble(durOfRecord))) %></font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Time Outside</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=Integer.parseInt(up_22) + Integer.parseInt(lp_18) %>:00:00</font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Samples Outside</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%=Integer.parseInt(up_22) + Integer.parseInt(lp_18) %></font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
			<tr>
				<td align="left">
					<label class="description" for="element_4" style="text-align: left;"><font size="2" face="Arial">Percentage Outside</font></label>
				</td>
				<td align="right" style="color: red"><font size="2" face="Arial">
					<%= df.format(((Double.parseDouble(up_22) + Double.parseDouble(lp_18)) * 100) / (Double.parseDouble(durOfRecord))) %></font>
				</td>
				<td align="left">	
				</td>
				<td align="right">
				</td>
			</tr>
</table>
</td>
</tr>
</table>
<br></br>
<%// draw chart %>

<%
System.out.println("The sensor is :"+sensor.trim());
System.out.println("The sendate is :"+sendate.trim());

	String []senData = sensor.split(" # ");
	String []senDate = sendate.split(" # ");
	
	System.out.println("The length of sendata "+senData.length);
	System.out.println("The length of senDate "+senDate.length);
	
System.out.println("==========================End of java code============================");	
	
	
%>

<script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">  
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
      var data = new google.visualization.DataTable();
       
      data.addColumn('datetime', 'Date');
      data.addColumn('number', 'Temp');
	
     // var senData1 = [[' < %= hours1%>','< %=hours2%>','< %=hours3%>','< %=hours4%>','< %=hours5%>','< %=hours6%>','< %=hours7%>']];
     // var senDate1 = [[' < %= hours1%>','< %=hours2%>','< %=hours3%>','< %=hours4%>','< %=hours5%>','< %=hours6%>','< %=hours7%>']];

       var senData1 = new Array(<%  
    		       for(int i = 0; i < senData.length; i++) {  
    		         out.print("\""+senData[i]+"\"");  
    		        if(i+1 < senData.length) {  
    		           out.print(",");  
    		         }  
    		       }%>); 

     //  alert(">"+senData1.length+">"+senData1);

       var senDate1 = new Array(<%
    		   for(int i = 0; i < senDate.length; i++) {
    		     out.print("\""+senDate[i]+"\"");
    		     if(i+1 < senDate.length) {
    		       out.print(",");
    		     }
    		   }
    		   %>);
     //  alert(">>><<"+senDate1.length+"<<<<>"+senData1);       
		        
     //   data.addRows( parseInt(senDate1.length,10));
			var formatter = new google.visualization.NumberFormat({decimalSymbol :'.' });
        	formatter.format(data,1);
        	
   try{
        var tideTimes = new Array();
        for(var i = 0; i < senDate1.length;i++)
        {
        	var p = senDate1[i].split(","); 
        	tideTimes[i] = [new Date(p[0],parseInt(p[1],10)-1,p[2],p[3],p[4],p[5],p[6]),parseFloat(senData1[i])];
        }
		//alert(">>>>>>>>>>>"+senData1[i]);
        data.addRows(tideTimes);
        
   }catch(e){alert(e);}     
     //   alert(">>>>>"+senData1.length+">>>>>?????????????");

        
	/*	for(var i = 0;i< senData1.length; i++) {

			alert(">>>>"+senData1[i]+">>>>>"+senDate1[i]);
			data.setValue(i, 0, senDate1[i]); // alert(">>>"+i+">>");
	        data.setValue(i, 1, parseInt(senData1[i],10));//	alert(">>>"+i+">>");
	      //  alert(">end>");
		}*/

		
	//	alert(">end>");

    //       alert(">>>color");
       
        
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
     //   alert(">>>color>>>>>>>>>>>>>>>>>>>>>>>>>>");
        chart.draw(data, {width: 1200, height: 500,isStacked: true, is3D: true, title: 'Temperature Analysis graph',colors:[{color:'blue'}],
                          hAxis: {format:'d-MMM-yy H:m', title: 'DateTime', titleTextStyle: {color: ''},minValue:0},
                          vAxis:{viewWindowMode:'explicit',viewWindow:{min:0}}
                         });

//	alert("The end");
        
      }
     
    </script>
<table>
	<tr><td style="background-color:#FFFFFF">
	<div id="chart_div"></div>
	<div id="placeholder" style="width:930px;height:400px;" align="left" ></div>
	</td>
	</tr>
	</table>
	<script id="source" language="javascript" type="text/javascript"> //alert(">>>>1>>>>>");	
	$(function () {
		//alert(">>>>1>>>>>");
		//alert(">>>>>2>>>>");

		try{
	        var maxt = new Array();
	        for(var i = 0; i < senDate1.length;i++)
	        {
	        	var p = senDate1[i].split(","); 
	        	maxt[i] = [new Date(p[0],parseInt(p[1],10)-1,p[2],p[3],p[4],p[5],p[6]),22];
	        }
			//alert(">>>>>>>>>>>"+senData1[i]);
	        data.addRows(maxt);
	        
	   }catch(e){alert(e);} 

	   try{
	        var mint = new Array();
	        for(var i = 0; i < senDate1.length;i++)
	        {
	        	var p = senDate1[i].split(","); 
	        	mint[i] = [new Date(p[0],parseInt(p[1],10)-1,p[2],p[3],p[4],p[5],p[6]),18];
	        }
			//alert(">>>>>>>>>>>"+senData1[i]);
	        data.addRows(mint);
	        
	   }catch(e){alert(e);}    

		
	    $.plot($("#placeholder"),
	           [ { data: mint, label: "Min", color:"green"},
	             { data: maxt, label: "Max",color:"red"}, 
	           
	           ],
	           { xaxis: { mode: "hours", ticks:24},
	            yaxis: {   },
	 
	             y2axis: { tickFormatter: function (v, axis) { return v.toFixed(axis.tickDecimals)+" km" }},
	             legend: {  backgroundOpacity: 0} });
	});
</script>
</div>
</form>
<%}//end of cnt sen 
else {%>
<div style="width:90%;" align="center" id="table1" >
<table border="0" align ="center" style="width: 60em; margin-left: 20em;">
	<tr>
		<td>	
			<table border="0" align ="center" style="width: 100%;" cellpadding="5" cellspacing="20" style="width: 80em; margin-left: 20em;" >
	
			<tr>
				<td align="left" width="30%" colspan="4">
					<label class="description" for="element_4" style="text-align: left;"><font size="3"><b>Sorry! No Data found..</b></font></label>
					
				</td>
			</tr>
			
			</table>
		</td>
	</tr>
</table>
</div>			
<%} %>

<%}catch(Exception e){
	System.out.println("The Exception "+e);
	e.printStackTrace();
} %>
<%} %>
</jsp:useBean>
 <%@ include file="footernew.jsp" %>
<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%@page import="java.util.Date"%>

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<script type="text/javascript">
var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};



function gotoExcel(elemId, frmFldId)  
{          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.fleet_summart_all.action ="excel.jsp";
          document.forms["fleet_summart_all"].submit();
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

<%! Connection conn = null;
	Statement st = null;
	Statement st1 = null;
	Statement st2 = null; 	
	Statement st3 = null;
	String date1 = "";
	String date2 = "";%>	
	
<%
String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
String date_Sub1 = defaultDate.substring(0,2);
//System.out.println("Substring is =>"+date_Sub1);
defaultDate = defaultDate.replace(date_Sub1,"");
defaultDate.trim();
defaultDate = "01"+defaultDate;
//System.out.println("The default date is ==>"+defaultDate);

//setting for the to date
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Calendar c1 = Calendar.getInstance();
c1.setTime(new Date());
c1.add(Calendar.DATE, -1);  
String default_date_2 = sdf1.format(c1.getTime());
%>	
<%
try{
	
	 date1 = request.getParameter("data");
	 date2 = request.getParameter("data1");
	
	// Class.forName(MM_dbConn_DRIVER);
	//conn = DriverManager.getConnection(MM_dbConn_STRING, MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	conn=fleetview.ReturnConnection();
	 st = conn.createStatement();
	 st1 = conn.createStatement();
	 st2 = conn.createStatement();
	 st3 = conn.createStatement();

%>	


<%@page import="org.apache.poi.hssf.record.formula.functions.Datedif"%><form id="fleetsummary_exp_all" name="fleetsummary_exp_all" onsubmit="return datevalidate();">
<table border="0" width="100%" class="stats">
	<tr>
		<td align="left"><font size="2" face="Arial"><b>From&nbsp;&nbsp;</b></font>
		<input type="text" id="data" name="data" size="12" value="<%if(date1==null){ %><%=defaultDate%><%}else{%><%=date1%><%}%>"style="width: 90px; height: 15px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
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
		<font size="2" face="Arial"><b>To &nbsp;&nbsp;</b></font>
		<input type="text" id="data1" name="data1" value="<%if(date2==null){ %><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(default_date_2))%><%}else{%><%=date2%><%}%>"  size="12" style="width: 90px; height: 15px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
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
int no_of_column = 0;
String date_3 = "";
String date_4 = "";
	
//	System.out.println("Date1 = "+date1+"Date2 ="+date2);
	if(date1==null || date2==null){
		//System.out.println("in if");
		
	//	System.out.println("The default date is :"+defaultDate);
	//	System.out.println("The default date_2 is :"+default_date_2);
		
		date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(defaultDate));
		date2 = default_date_2;
	/*	date1 = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		int index = date1.lastIndexOf("-");
		String date_Sub = date1.substring(index);
		date1 = date1.replace(date_Sub,"");
		date1.trim();
		date1 = date1+"-01";
		date2 = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); */
		
	//	System.out.println("If Date1 = "+date1+"Date2 ="+date2);
		date_3 = date1;
		date_4 = date1;
	//	System.out.println("The date3 is "+date_3);
		
		String datediff = "Select datediff('"+date2+"','"+date1+"') as deteDif";
		ResultSet rs1 = st1.executeQuery(datediff);
		if(rs1.next()){
			no_of_column = rs1.getInt("deteDif");
		}
//		System.out.println("The number of columns in the table :"+no_of_column);
		
	}else{
		//System.out.println("in else");
		
		date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date1));
		date2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date2));
		
	//	System.out.println("else Date1 = "+date1+"Date2 ="+date2);
		
		date_3 = date1;
		date_4 = date1;
	//	System.out.println("The date3 is "+date_3);
		
		String datediff = "Select datediff('"+date2+"','"+date1+"') as deteDif";
		ResultSet rs1 = st1.executeQuery(datediff);
		if(rs1.next()){
			no_of_column = rs1.getInt("deteDif");
		}
		
	//	System.out.println("The number of columns in the table :"+no_of_column);
	}
	System.out.println(">>>");
	String vehlist = session.getAttribute("VehList").toString();
	
	System.out.println("The vehicle list is>>>"+vehlist);
%>	

<form id="fleet_summart_all" name="fleet_summart_all" action="" method="post">

		<%
		 String  exportFileName="fleet_summary_report.xls";
		%>
		
<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">	
				<font size="3"><b>Fleet Summary Report</b></font>
		</td>
	</tr>
	<tr>
		<td align="right">	
							<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
		</td>
	</tr>
</table>	
<div style="width:100%;" align="center" id="table1" >	
<table border="0" width="100%" class="stats">
	<tr>
		<td>
			<table class="sortable">
			<tr>
			<th>Sr No</th>
			<th>VehRegNo</th>
			<th>Transporter</th>
			<%if(date2==null) {
				%><th>Update on <%= default_date_2%> before 10:00:00</th><%
				%><th>Location on <%= default_date_2%> before 10:00:00</th><%
			}else{
				%><th>Update on <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%> before 10:00:00 AM</th><%
				%><th>Location on <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%> before 10:00:00 AM</th><%
				}
			%>
			<%
			for(int i=0;i<= no_of_column;i++){
				
				if(i>0){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar c = Calendar.getInstance();
				c.setTime(sdf.parse(date1));
				c.add(Calendar.DATE, 1);  
				date1 = sdf.format(c.getTime());
				}
				
				System.out.println("The date1 is=====================> :"+date1);
				
				%><th>Distance <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1)) %></th><%
				%><th>RunHrs <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1)) %></th><%
			}
			%>
			<th>Total Distance</th>
			<th>Total RunHrs</th>
			</tr>
			
	<%
	try{
		DecimalFormat df2 = new DecimalFormat("0.00");
        
		
	int cnt = 0;
		String sql = "Select VehicleCode,VehicleRegNumber,OwnerName from db_gps.t_vehicledetails where VehicleCode  IN "+vehlist+"";
		ResultSet rs = st.executeQuery(sql);
		System.out.println("The sql is ==>"+sql);
		while(rs.next()){
			String  vehcode = rs.getString("VehicleCode");
			String  vehregno = rs.getString("VehicleRegNumber");
			String  trans = rs.getString("OwnerName");
			
	//		System.out.println("The srno is :"+cnt+"The vehicle code is :"+vehcode+"The vehicle reg no is :"+vehregno);
	
				//add the data into the table
				%><tr>
				<td><div align="right"><%= ++cnt %></div></td>
				<td><div align="left"><%=  vehregno%></div></td>
				<td><div align="left"><%=  trans%></div></td>
				<%
				
			
				double total_distance = 0;
				double total_runhrs = 0;
				String last_loc = "",date_loc="";
				
					
				//find the last location
				String sql3 = "Select TheFieldSubject,Thefielddatadatetime from db_gps.t_veh"+vehcode+" where Thefielddatadatetime <= '"+date2+" 10:00:00' order by Thefielddatadatetime DESC limit 1";
				ResultSet rs3 = st3.executeQuery(sql3);
	//			System.out.println("The sql2 is==>"+sql3);
				if(rs3.next()) {					
					last_loc = rs3.getString("TheFieldSubject");
					date_loc = rs3.getString("Thefielddatadatetime");
				}else{
					last_loc = "-";
					date_loc = "-";
				}
			%>
			<%
				if(date_loc=="-" || date_loc.equals("-")){
					
					date_loc = "-";
				}else{
					date_loc = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date_loc));
				}
			%>
			<td><div align="left"><%= date_loc %></div></td>
			<td><div align="left"><%=  last_loc%></div></td>
			
		<%
				date_3 = date_4;
				for(int i=0;i<= no_of_column;i++)
				{
					String distance = "",runHrs =""; 
					
					if(i>0){
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Calendar c = Calendar.getInstance();
					c.setTime(sdf.parse(date_3));
					c.add(Calendar.DATE, 1);  
					date_3 = sdf.format(c.getTime());
					}
					
			//		System.out.println("The date1 is=====================> :"+date_3);
					String sql2 = "Select Distance,RDurationinHrs from db_gpsExceptions.t_veh"+vehcode+"_ds where TheDate = '"+date_3+"'";
					ResultSet rs2 = st2.executeQuery(sql2);
		//			System.out.println("The sql2 is==>"+sql2);
					if(rs2.next()) {
						
						distance = rs2.getString("Distance");
						runHrs = rs2.getString("RDurationinHrs");
						
						total_distance = total_distance + Double.parseDouble(distance);
						total_runhrs = total_runhrs + Double.parseDouble(runHrs);
						
					}else{
						
						distance = "-";
						runHrs = "-";
					}
					
					//add data into table
					%>
					<td><div align="right"><%= distance %></div></td>
					<%if(runHrs == "-" || runHrs.equals("-")) {
						%><td><div align="right"><%= runHrs %></div></td><%
					}else{
						%><td><div align="right"><%=  df2.format(Double.parseDouble(runHrs))%></div></td><%
					}
					
				}
				
				%>
					<td><div align="right"><%=  Double.valueOf(df2.format(total_distance)) %></div></td>
					<td><div align="right"><%= Double.valueOf(df2.format(total_runhrs))%></div></td>
				
				<%
			%>
			
			
			</tr><%
			
		}
	}catch(Exception e1){
		System.out.println(e1.getMessage());
		e1.printStackTrace();
	}
}catch(Exception e){
	System.out.println("Exception "+e);
}
finally
{
	try
	{conn.close();
	}catch(Exception e)
	{e.printStackTrace();}

try
{
fleetview.closeConnection();
}catch(Exception e)
{
}	
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
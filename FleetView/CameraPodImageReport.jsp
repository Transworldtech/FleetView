<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%@page import="java.util.Date"%>

<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.pod_jpg_report.action ="excel.jsp";
          document.forms["pod_jpg_report"].submit();
}
function showPODImage(imageName)
{	
	var url="cameraPodImage.jsp?imageName=" +imageName;
	testwindow1 = window.open(url,"Image", "width=800,height=500");
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

<%! Connection conn = null;
	Statement st = null;
	Statement st1 = null;
	
	String date1 = "";
	String date2 = "";%>	
	
<%
//setting for the From date
/*SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
Calendar c1 = Calendar.getInstance();
c1.setTime(new Date());
c1.add(Calendar.DATE, -7);  
String default_date_1 = sdf1.format(c1.getTime());*/
String  default_date_1 = new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
System.out.println("The default_date_1  is ==>"+default_date_1);

String defaultDate2 = new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
//System.out.println("The default date is ==>"+defaultDate);
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


<%@page import="org.apache.poi.hssf.record.formula.functions.Datedif"%>
<form id="fleetsummary_exp_all" name="fleetsummary_exp_all" onsubmit="return datevalidate();">
<table border="0" width="100%" class="stats">
	<tr>
		<td align="left"><font size="2" face="Arial"><b>From&nbsp;&nbsp;</b></font>
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
		<font size="2" face="Arial"><b>To &nbsp;&nbsp;</b></font>
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

<form id="pod_jpg_report" name="pod_jpg_report" action="" method="post">

		<%
		 String  exportFileName="twpod_images_report.xls";
		%>
		
<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">	
				<font size="3"><b>TWPOD Report</b></font>
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
<div style="width:100%;" align="left" id="table1" >	
<table border="0" class="stats" align ="center" style="width: 60em; margin-left: 30em;">
	<tr>
		<td>
			<table class="sortable">
			<tr>
			<th width ="10%">Sr No</th>
			<th>File Name</th>
			<th>File Date & Time</th>
			<th>Trip ID</th>
			<th>Vehicle Reg No</th>
			<th>Unit ID</th>
			</tr>
			
	<%
	try{      
		
	int cnt = 0;
		String sql = "Select jpgfilename,rawfiledatetime,unitid,rawfilename from db_gps.t_jpgsnap where rawfiledatetime between '"+date1+" 00:00:00' AND '"+date2+" 23:59:59' AND jpgfilename like '%pod%' Order by rawfiledatetime DESC";
		ResultSet rs = st.executeQuery(sql);
		System.out.println("The sql is ==>"+sql);
		while(rs.next()){
			
			String  jpgfilename = rs.getString("jpgfilename");
			String  rawfiledatetime = rs.getString("rawfiledatetime");
			String  unitid = rs.getString("unitid");
			String  rawfilename = rs.getString("rawfilename").toString();
			
	
				//add the data into the table
			%>
				<tr>
				
				<td  width ="10%"><div align="right"><%= ++cnt %></div></td>
				<td><div align="left"><a href="#" onclick="showPODImage('<%=jpgfilename%>');"><%=jpgfilename%></a></div></td>
				<td><div align="right"><%=  new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rawfiledatetime))%></div></td>	
				
				<%
				String  stamp = "";String tripid = "";String vehregno = "";
				String sql1 = "Select stamp from db_gps.t_twpodstamptable where rawfiledatetime = '"+rawfiledatetime+"' AND unitid = '"+unitid+"' ";
				ResultSet rs1 = st1.executeQuery(sql1);
				System.out.println("The sql is ==>"+sql1);
				if(rs1.next()){
					
					  stamp = rs1.getString("stamp");
				}
				System.out.println("The stamp is :"+stamp);
				if(stamp == "" || stamp.equals("") || stamp.equals(null))
				{
					tripid = "-";
					vehregno = "-";
				}else{
					
					StringTokenizer st = new StringTokenizer(stamp,"\n");
					while(st.hasMoreTokens()) {
						
						String token = st.nextToken();
						System.out.println("token is :"+token);
						if(token.contains(rawfilename)){
							
							String substr = token.substring(token.indexOf('$'));
							System.out.println("The substr is :"+substr);
							substr = substr.replace("$"+rawfilename+",","");
							System.out.println("The substr is :"+substr);
							StringTokenizer st1 = new StringTokenizer(substr,",");
							
							tripid = st1.nextToken();
							vehregno = st1.nextToken();
							System.out.println("The tripid is :"+tripid+" vehregno"+vehregno);
						}
					}
				}
				
				%>
				
				<td  width ="10%"><div align="right"><%= tripid %></div></td>
				<td  width ="10%"><div align="right"><%= vehregno %></div></td>
				<td  width ="10%"><div align="right"><%= unitid %></div></td>
				</tr>
			<%
			
		}
	}catch(Exception e1){
		System.out.println(e1.getMessage());
		e1.printStackTrace();
	}finally {
		
		conn.close();
		st.close();
		st1.close();
		
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
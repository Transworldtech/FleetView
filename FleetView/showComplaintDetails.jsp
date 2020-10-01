

<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%><html>
<head>
<%@ include file="Connections/conn.jsp" %>

<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 

<script type="text/javascript">

function showExcel()
{
try{
	//alert("Hi >> ");
	var status=document.getElementById("stat").value;
	var fname=document.getElementById("fname").value;
	var lname=document.getElementById("lname").value;
	var email=document.getElementById("email").value;
	
	window.open("complaintexcel.jsp?&status="+status+"&fname="+fname+"&lname="+lname+"&email="+email);
}catch(e)
{
	alert(e);
}
	
}

function regcomplaint(PageName)
{
alert("hi");
	try{
		 alert(PageName);
		// var PageName = document.getElementById("PageName").value;
		// PageName = "bcndsjh";
	window.open('RegisterComplaint.jsp?PageName='+PageName,'Win','width=710,height=570,top=200,left=200,scrollbars=yes');	 
	 }catch(e)
	 {
		 alert(e);
	 }
}
</script>









</head>





<body>

<%!Connection conn, conn1;
	Statement st, st1, st2, st3, st4;
	String sql, sql1, sql2, sql3, sql4, username, userrole, olddate, Svehlist;
	int total, updated, dealy, disconnected, notactive, transid;
	String vid, vehno;%>






<%
try{
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_CustomerComplaints";
	String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";

	
	System.out.println("Creating Connection");
	Class.forName(MM_dbConn_DRIVER);
   // conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    System.out.println(">>>2222aaaaa ");
   conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
   
    System.out.println(">>>2222bbbb ");
    st=conn1.createStatement();
    System.out.println(">>>2222cccc ");
	st1=conn1.createStatement();
	
	   System.out.println(">>>2222ddd ");
    st2=conn1.createStatement();
    st3=conn1.createStatement();
    st4=conn1.createStatement();
    Statement stmt2 = conn1.createStatement();
    Statement stmt7 = conn1.createStatement();
    Statement stmt8 = conn1.createStatement();
	   

	 Statement stveh = conn1.createStatement();
    Statement st9 = conn1.createStatement();
    Statement st5 = conn1.createStatement();
    Statement st6 = conn1.createStatement();
    Statement st7 = conn1.createStatement();


    String status="",fname="",lname="",email="";
    System.out.println(">>>2222 ");
	status=request.getParameter("status");
	fname=request.getParameter("fname");
	lname=request.getParameter("lname");
	email=request.getParameter("email");
	String PageName=this.getClass().getName();
	PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
	System.out.println(PageName);
	PageName=PageName.replace("_",".");
	PageName=PageName.replace(".005f","_");
	System.out.println(PageName);
	System.out.println("status  is " +status);
	String reportno="";
	
	
	
	String sqlpg = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName+"'";
	ResultSet rs = st5.executeQuery(sqlpg);
	if(rs.next())
	{
		reportno = rs.getString("ReportNo");
	}
	System.out.println(reportno);
	%>

	
	<table>
<tr>
<td align="left">	
					<a href="http://www.mobile-eye.in" target="_blank"><img src="images/TW-MobileEyeLogo1.PNG" style="height: 60px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
</td>
</tr>
<tr>
<td>
		<div>
		<input type="hidden" name="PageName" id="PageName" value="<%=PageName %>"/>
		 <a href="#" onclick="regcomplaint('<%=PageName %>')" title="Register Complaint"><font face="Arial" size="2" color="blue"><b>Register Complaint</b></font></a>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font size="2" color="black"> Report No.: <%=reportno %></font>
		</div>
		</td>
</tr>

</table>
	<input type="hidden" id="stat" name="stat" value="<%=status %>"></input>
		<input type="hidden" id="fname" name="fname" value="<%=fname %>"></input>
		<input type="hidden" id="lname" name="lname" value="<%=lname %>"></input>
		<input type="hidden" id="email" name="email" value="<%=email %>"></input>
	
	<%

	if(status.equals("total") || status.equalsIgnoreCase("total"))
	{	
	 %>

<form name="complaintreport" name="complaintreport" method="get">
		<div id="mytable">

<div id="table1" style="text-align: center; margin-left: 100px;margin-right: 100px;">
<%


		String sql="",sql1="";
		
		java.util.Date todaysDate =new java.util.Date();

%>

		<table border="0" style="width: 850px;"  class="stats">
		<tr><td><div class="bodyText" align="center"><font face="Arial" size="4">Complaint Report Of <%=fname %> <%=lname %></font></div></td></tr>
		</table>
		<div style="margin-left: 600px">
		<table style="width: 500px">
		 <tr>
				 <td bgcolor="#FFFFFF" id="print">
			<a id ="print" href="#" onclick="showPrint();" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
			
			<a id="excel" href="#" onclick="showExcel();" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;
		  <font size="2" color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(todaysDate)%></font></td>
		</tr>
 		
				
		</table>
		</div>
		
		
		<table align="center" class="sortable" style="width: 850px;">
		<br></br>
		<tr>
		        <th><b>SrNo</b></th>
		        <th><b>Complaint ID</b></th>
		        <th><b>Complaint DateTime</b></th>
		         <th><b>Report Name</b></th>
				<th><b>Description</b></th>
				<th><b>Website</b></th>
		         <th><b>Category</b></th>
		         <th><b>Priority</b></th>
		         <th><b>Transporter</b></th>
		         
		         <th><b>Contact Number</b></th>
		         
		       	<th><b>Status</b></th>
				<th><b>Entry By</b></th>
				<th><b>Closed Date/Time</b></th>
				
		
		</tr>
		<tr>
		<% 
		
		try{
		String contactno="",closeddate="";
		int i=1;
		sql="select * from db_gps.t_ComplaintDetail where EntBy='"+fname+" "+lname+"' or Email1='"+email+"' order by UpdatedDateTime ";
		System.out.println("Report Query is " +sql);
		ResultSet rscom=st.executeQuery(sql);
		while(rscom.next())
		{
			%> 
			<td align="right"><div align="right"><%=i %></div></td>
						<td align="right"><div align="right"><%=rscom.getString("ComplaintID")%></div></td>
						<td align="left"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rscom.getString("ComplaintDateTime"))) %></div></td>
			
	<td align="left"><div align="left"><%=rscom.getString("PageName") %></div></td>
	<td align="left"><div align="left"><%=rscom.getString("Description") %></div></td>
		<td align="left"><div align="left"><%=rscom.getString("Website") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Category") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Priority") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Transporter") %></div></td>
<%
contactno=rscom.getString("ContactNumber");
	if(contactno.equals("-") || contactno.equals(""))
		{
		%>	<td align="left"><div align="left">NA</div></td>
		<%		
		}else{
		%>
					<td align="right"><div align="right"><%=contactno%></div></td>		
		
		<%
		}
			
			%>
	<td align="left"><div align="left"><%=rscom.getString("Status") %></div></td>
				<td align="left"><div align="left"><%=rscom.getString("EntBy") %></div></td>
	<%
	try{
	closeddate=rscom.getString("Closeddatetime");
	System.out.println("1");
	System.out.println("closeddate is " +closeddate);
	System.out.println("1");
	if(closeddate!=null)
		{		
			System.out.println("In Else Loop ");
		%>
			<td align="left"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(closeddate)) %></div></td>
		
		<%
		}else{
			

			%>	<td align="left"><div align="left">NA</div></td>
			<%
		}
	}catch(Exception e)
	{
		e.printStackTrace();
		break;
	}
			%>
			</tr>
			<%
			
			
			
			i++;
		}
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
%>
		
		
		</table>
		
		
		</div>
		
	
</div>
</form>	
	<%} %>	
		
		<%

		if(status.equals("ptotal") || status.equalsIgnoreCase("ptotal"))
		{
		%>
		<form name="complaintreport" name="complaintreport" method="get">
		<div id="mytable">

<div id="table1" style="text-align: center; margin-left: 100px;margin-right: 100px;">
<%


		String sql="",sql1="";
		
		java.util.Date todaysDate =new java.util.Date();

%>

		<table border="0" style="width: 850px;"  class="stats">
		<tr><td><div class="bodyText" align="center"><font face="Arial" size="4">Complaint Report Of <%=fname %> <%=lname %></font></div></td></tr>
		</table>
		<div style="margin-left: 600px">
		<table style="width: 500px">
		 <tr>
				 <td bgcolor="#FFFFFF" id="print">
			<a id ="print" href="#" onclick="showPrint();" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
			
			<a id="excel" href="#" onclick="showExcel();" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;
		  <font size="2" color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(todaysDate)%></font></td>
		</tr>
 		
				
		</table>
		</div>
		
		
		<table align="center" class="sortable" style="width: 850px;">
		<br></br>
		<tr>
		        <th><b>SrNo</b></th>
		        <th><b>Complaint ID</b></th>
		        <th><b>Complaint DateTime</b></th>
				<th><b>Report Name</b></th>
				<th><b>Description</b></th>
				<th><b>Website</b></th>
				 <th><b>Category</b></th>
		         <th><b>Priority</b></th>
		         <th><b>Transporter</b></th>
		         
		         <th><b>Contact Number</b></th>
		        <th><b>Entry By</b></th>
		         
				<th><b>Status</b></th>
		
		</tr>
		<tr>
			
		<%
		

		try{
			String contactno="";
		int i=1;
		sql="select * from db_gps.t_ComplaintDetail where (EntBy='"+fname+" "+lname+"' or Email1='"+email+"') and Status='Pending' order by UpdatedDateTime ";
		System.out.println("Report Query is " +sql);
		ResultSet rscom=st.executeQuery(sql);
		while(rscom.next())
		{
			%>
			<td align="right"><div align="right"><%=i %></div></td>
			<td align="right"><div align="right"><%=rscom.getString("ComplaintID")%></div></td>
						<td align="left"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rscom.getString("ComplaintDateTime"))) %></div></td>
			
	<td align="left"><div align="left"><%=rscom.getString("PageName") %></div></td>
	<td align="left"><div align="left"><%=rscom.getString("Description") %></div></td>
		<td align="left"><div align="left"><%=rscom.getString("Website") %></div></td>
	
	<td align="left"><div align="left"><%=rscom.getString("Category") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Priority") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Transporter") %></div></td>
	<%
	contactno=rscom.getString("ContactNumber");
	if(contactno.equals("-") || contactno.equals(""))
		{
		%>	<td align="left"><div align="left">NA</div></td>
		<%		
		}else{
		%>
					<td align="right"><div align="right"><%=contactno%></div></td>		
		
		<%
		}
			
			%>
							<td align="left"><div align="left"><%=rscom.getString("EntBy") %></div></td>
			
	<td align="left"><div align="left"><%=rscom.getString("Status") %></div></td></tr>
			<%
			
			
			
			i++;
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
%>
		
		</table>
		
		</div>
	
</div>
</form>	
		
		<%} %>
		<%	
		
		if(status.equals("stotal") || status.equalsIgnoreCase("stotal"))
		{
			%>
			
			<form name="complaintreport" name="complaintreport" method="get">
		<div id="mytable">

<div id="table1" style="text-align: center; margin-left: 100px;margin-right: 100px;">
<%


		String sql="",sql1="";
		
		String  exportFileName=session.getAttribute("user").toString()+"_Complaint_report.xls";
		java.util.Date todaysDate =new java.util.Date();

%>

		<table border="0" style="width: 850px;"  class="stats">
		<tr><td><div class="bodyText" align="center"><font face="Arial" size="4">Complaint Report Of <%=fname %> <%=lname %></font></div></td></tr>
		</table>
		<div style="margin-left: 600px">
		<table style="width: 500px">
		 <tr>
				 <td bgcolor="#FFFFFF" id="print">
			<a id ="print" href="#" onclick="showPrint();" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
			
			<a id="excel" href="#" onclick="showExcel();" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;
		  <font size="2" color="black"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(todaysDate)%></font></td>
		</tr>
 		
				
		</table>
		</div>
		
		<table align="center" class="sortable" style="width: 850px;">
		<br></br>
		<tr>
		       <th><b>SrNo</b></th>
		        <th><b>Complaint ID</b></th>
		        <th><b>Complaint DateTime</b></th>
		         <th><b>Report Name</b></th>
				<th><b>Description</b></th>
				<th><b>Website</b></th>
		         <th><b>Category</b></th>
		         <th><b>Priority</b></th>
		         <th><b>Transporter</b></th>
		         
		         <th><b>Contact Number</b></th>
		         
		       	<th><b>Status</b></th>
				<th><b>Entry By</b></th>
				<th><b>Closed Date/Time</b></th>
		
		</tr>
		<tr>
			
		<%
			String contactno="",closeddate="";
			int i=1;
			sql="select * from db_gps.t_ComplaintDetail where (EntBy='"+fname+" "+lname+"' or Email1='"+email+"') and Status='Closed'  order by UpdatedDateTime ";
			System.out.println("Report Query is " +sql);
			ResultSet rscom=st.executeQuery(sql);
			while(rscom.next())
			{
				%>
				<td align="right"><div align="right"><%=i %></div></td>
						<td align="right"><div align="right"><%=rscom.getString("ComplaintID")%></div></td>
						<td align="left"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rscom.getString("ComplaintDateTime"))) %></div></td>
			
	<td align="left"><div align="left"><%=rscom.getString("PageName") %></div></td>
	<td align="left"><div align="left"><%=rscom.getString("Description") %></div></td>
		<td align="left"><div align="left"><%=rscom.getString("Website") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Category") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Priority") %></div></td>
			<td align="left"><div align="left"><%=rscom.getString("Transporter") %></div></td>
			
			<%
			contactno=rscom.getString("ContactNumber");
	if(contactno.equals("-") || contactno.equals("") )
		{
		%>	<td align="left"><div align="left">NA</div></td>
		<%		
		}else{
		%>
					<td align="right"><div align="right"><%=contactno%></div></td>		
		
		<%
		}
			
			%>
	
	<td align="left"><div align="left"><%=rscom.getString("Status") %></div></td>
				<td align="left"><div align="left"><%=rscom.getString("EntBy") %></div></td>
	
<%
	try{
	closeddate=rscom.getString("Closeddatetime");
	System.out.println("1");
	System.out.println("closeddate is " +closeddate);
	System.out.println("1");
	if(closeddate!=null)
		{		
			System.out.println("In Else Loop ");
		%>
			<td align="left"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(closeddate)) %></div></td>
		
		<%
		}else{
			

			%>	<td align="left"><div align="left">NA</div></td>
			<%
		}
	}catch(Exception e)
	{
		e.printStackTrace();
		break;
	}
			%>
			</tr>
				<%
				
				
				
				i++;
			}
	
	%>	
		
		</table>
		
		
		</div></div>
</form>	
	<%} %>	
		
		
		
<%}catch(Exception e){e.printStackTrace();}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	
	try
	{
conn1.close();
}catch(Exception e)
	{e.printStackTrace();}
	
}


%>

		
		
		
	<%@ include file="footernew.jsp" %>	
		
		
</body>
</html>

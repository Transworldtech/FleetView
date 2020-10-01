<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.CountSmsDetails"  
		import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>

<%@ include file="headernew.jsp" %>

<%@page import="javax.swing.text.NumberFormatter"%>
	<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort">
			<!-- <div align="left"><font size="3">Report No:13.1</font></div>-->
			<font color="block" size="3" ><b>NDAuthorisedReport</b></font>
			<%
			String  cg= request.getParameter("cg");
			String transporter = request.getParameter("transporter");
			String date1 = request.getParameter("date1");
			String date2 = request.getParameter("date2");
			
			if(cg.equals("ND"))
			{
				%>
			<div class="bodyText" align="right">
			<a href="#" onclick="javascript:window.open('printcountreport.jsp?data=<%=date1%>&data2=<%=date2%>&transporter=<%=transporter %>&cg=ND');" title="Print SMS Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_countreport.jsp?date1=<%=date1%>&date2=<%=date2%>&transporter=<%=transporter%>&cg=ND"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
				<%=Utilities.printDate() %></div>
			<% 
			}
			else
			{
				%>
				<div class="bodyText" align="right">
			<a href="#" onclick="javascript:window.open('print_intimation.jsp?data=<%=date1%>&data2=<%=date2%>&transporter=<%=transporter%>&cg=ND');" title="Print SMS Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_intimation.jsp?date1=<%=date1%>&date2=<%=date2%>&transporter=<%=transporter%>&cg=ND"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
			<%=Utilities.printDate() %></div>
				<%
			}
			%>
			
			</td>
			</tr>		


<body>
<%

try
{
	
	session.setAttribute("reportno","Report No:6.0");

//out.println("transporter--->"+transporter);

//session.setAttribute("date1",date1);
//session.setAttribute("date2",date2);
//session.setAttribute("transporter",transporter);
//out.println("date2--->"+date2);
//date1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
//out.println("date1--->"+date1);
//date2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2));
//out.println("date2--->"+date2);
%>
	
	<table width="100%" border="1" align="center" class="sortable">
					<tr>
						<th> <b> Sr. </b></th>
						<th> <b>Vehicle Reg Number</b></th>
						<th> <b>Duration(Hrs)</b></th>
						<th> <b>Sender Name</b></th>
						<th> <b> Mobile Number</b></th>
						<th> <b>Date-Time</b></th>
						<th> <b>Reason</b></th>
						<th> <b>Intimation</b></th>
					</tr>
			
<%
	List<CountSmsDetails> countList = null;
	int recordCount=0;
	try{
		countList = vehicleDao.getCountSmsDetails(cg,transporter,date1,date2);
		recordCount=countList.size();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	int i=0;
	for(int count=0;count<recordCount;count++)
	{
		CountSmsDetails currentRecord = countList.get(count);
		i=count+1;
		%>
		<tr>
			<td style=" text-align: left"><%= i %></td>
			<td style=" text-align: left"><%= currentRecord.getVehicleRegistrationNumber() %></td>
			<td style=" text-align: left"><%= currentRecord.getDuration() %></td>
			<td style=" text-align: left"><%= currentRecord.getSenderName() %></td>
			<td style=" text-align: left"><%= currentRecord.getMobileNumber() %></td>
			<td style=" text-align: left"><%= currentRecord.getStoredDate() %> <%= currentRecord.getStoredTime() %></td>
			<td style=" text-align: left"><%= currentRecord.getReason() %></td>
			<td style=" text-align: left"><%= currentRecord.getIntimation() %></td>
		</tr>
<% 
	}
	
		
}catch(Exception e)
			{
				e.printStackTrace();
			}
	
	

	%>
	</table>
</body>
<%@ include file="footernew.jsp" %>


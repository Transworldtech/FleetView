<%@ include file="header.jsp" %> 

    <%@page import="com.fleetview.beans.DisplayData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="UploadExcelForm.jsp"><font size="2">Main Page</font></a>

<br></br>
<table border=1 width="100%" bgcolor="#F5F5F5" class="sortable">

<% 
//String fileFormat=session.getAttribute("FileFormat").toString();
//out.println(fileFormat);

try{
ArrayList<DisplayData> displist = (ArrayList<DisplayData>)request.getAttribute("InvalidList");

//out.println(displist+"displist");
//out.println(displist.isEmpty());
if(displist.isEmpty()!=true)
{
	
	out.println("<font size='3'>"+"Columns Not Inserted into Database due to Error in Column values"+"</font>");
	%>
	<tr>
<th>Sr.No</th><th>Trip ID</th><th>Trip Date</th><th>Veh No</th><th>Transport</th><th>Trip From</th><th>Trip To</th><th>Driver ID</th><th>Driver Name</th><th>Driver ID</th><th>Driver Name</th><th>ETA</th><th>Weight</th><th>Vendor</th>
<th>Trip Type</th><th>Advance</th><th>Freight</th><th>Fixed Km</th><th>Fixed Time</th><th>ReportDateTime</th><th>LoadDelayReason</th><th>Comments</th></tr>
	<%
	
Object display[]=displist.toArray();
int i=displist.size();
for(int j=0;j<i;j++)
{
DisplayData row=(DisplayData)display[j];

%>
<tr>

<Td><%=row.getSrNo()%></Td>
<Td><%=row.getTripID()%></Td>
<Td><%=row.getDate()%></Td>
<Td><%=row.getVehNo()%></Td>
<Td><%=row.getTransport()%></Td>
<Td><%=row.getTripFrom()%></Td>
<Td><%=row.getTripTo()%></Td>
<Td><%=row.getDriverID1()%></Td>
<Td><%=row.getDriverName1()%></Td>
<Td><%=row.getDriverID2()%></Td>
<Td><%=row.getDriverName2()%></Td>
<Td><%=row.getETA()%></Td>
<Td><%=row.getWeight()%></Td>
<Td><%=row.getVendor()%></Td>
<td><%=row.getTriptype() %></td>
<td><%=row.getAdvance() %></td>
<td><%=row.getFreight() %></td>
<td><%=row.getFxkm() %></td>
<td><%=row.getFxtime() %></td>
<td><%=row.getReportDateTime() %></td>
<td><%=row.getLoadDelayReason() %></td>
<td><%=row.getComment() %></td>
</tr>

<%

}
}
else if(displist.isEmpty()!=false){
	out.println("Record Inserted Successfully......");}
}catch(Exception e)
{
	e.printStackTrace();
}


%>




</table>

</body>
</html>
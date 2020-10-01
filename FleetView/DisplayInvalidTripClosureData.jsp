<%@ include file="header.jsp" %> 

    <%@page import="com.fleetview.beans.TripClosureData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="UploadTripClosureExcel.jsp"><font size="2">Main Page</font></a>
<br></br>
<table border=1 width="100%" bgcolor="#F5F5F5" class="sortable">

<% 


try{
ArrayList<TripClosureData> displist = (ArrayList<TripClosureData>)request.getAttribute("InvalidList");
//out.println(displist+"displist");
if(displist.isEmpty()!=true)
{
	
	out.println("<font size='3'>"+"Columns Not Inserted into Database due to Error in Column values"+"</font>");
	%>
	<tr>
<th>Sr.No</th><th>Trip ID</th><th>VehRegNo</th><th>ArrivalDateTime</th><th>UnloadDateTime</th><th>UnloadReason</th><th>Remark</th></tr>
	<%
	
Object display[]=displist.toArray();
int i=displist.size();
for(int j=0;j<i;j++)
{
	TripClosureData row=(TripClosureData)display[j];

%>
<tr>

<Td><%=row.getSrNo()%></Td>
<Td><%=row.getTripID()%></Td>
<Td><%=row.getVehNo()%></Td>
<Td><%=row.getTripEndDate()%></Td>
<td><%=row.getUnloadDate()%></td>
<Td><%=row.getUnloadDelayReason()%></Td>
<Td><%=row.getRemark()%></Td>

</tr>

<%

}
}
else if(displist.isEmpty()!=false){
	System.out.println("in display message... empty list");
	out.println("Record Inserted Successfully......");}
}catch(Exception e)
{
	e.printStackTrace();
}


%>




</table>

</body>
</html>
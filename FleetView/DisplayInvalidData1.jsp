<%@ include file="header.jsp" %> 

    <%@page import="com.fleetview.beans.DisplayData1"%>
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


try{
ArrayList<DisplayData1> displist = (ArrayList<DisplayData1>)request.getAttribute("InvalidList");
//out.println(displist+"displist");
if(displist.isEmpty()!=true)
{
	
	out.println("<font size='3'>"+"Columns Not Inserted into Database due to Error in Column values"+"</font>");
	%>
	<tr>
<th>Sr.No</th><th>Trip ID</th><th>Veh No</th><th>ArrivalDateTime</th><th>UnloadDateTime</th><th>UnloadReason</th><th>Remark</th>
	<%
	
Object display[]=displist.toArray();
int i=displist.size();
for(int j=0;j<i;j++)
{
DisplayData1 row=(DisplayData1)display[j];

%>
<tr>

<Td><%=row.getSrNo()%></Td>
<Td><%=row.getTripID()%></Td>
<Td><%=row.getVehRegNo()%></Td>
<Td><%=row.getArrivalDateTime()%></Td>
<Td><%=row.getUnloadDateTime()%></Td>
<Td><%=row.getUnloadReason()%></Td>
<Td><%=row.getRemark()%></Td>

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
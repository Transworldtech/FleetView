<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="Connections/conndriver.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<head>

<script language="javascript">


function showtext()
{
	document.getElementById("tr5").style.display = "none";
	document.getElementById("HOD").innerHTML = "";
	document.getElementById("oldHOD").value = "";
	document.getElementById("tr6").style.display = "";
	document.getElementById("newHOD").value = "";
}

</script>




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body onunload="window.opener.location.reload();">
<%

Connection con=null ;
String VehRNo = request.getParameter("VehRNo1");


String msg = "",sql="";




try{
 msg = request.getParameter("msg");
 }
catch(Exception e)
{
	e.printStackTrace();
}
if(null==msg||("null").equalsIgnoreCase(msg)||"".equalsIgnoreCase(msg)){
	
}
else if("UP".equalsIgnoreCase(msg)){
	%>
	<script type="text/javascript">
	
	alert("Vehicle Passed");
	window.opener.location.reload();
	window.close();
	</script>
<%
}
else if("NUP".equalsIgnoreCase(msg)){
	%>
	<script type="text/javascript">
	
	alert("Vehicle Not Passed");
	window.opener.location.reload();
	window.close();
	</script>
	<%
}
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
	Statement stmt2=con.createStatement();
	Statement stmt4=con.createStatement();
	ResultSet rst4;
	
if(msg==null)
{
%>
<form action="driver_briefing_Vehicle_Reject_Update.jsp">

<%
String uid="",hodid="",HODName="",NewHOD="",RejectedDateTime="",RejectedBy="",CommentForRejection="";

String sql1 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver where ReasoneForRejection='Vehicle Rejection' and VehRegNo ='"+VehRNo+"' ORDER BY UpdatedDateTime DESC";
ResultSet rst = stmt.executeQuery(sql1);

if(rst.next())
{
String datenew1=rst.getString("UpdatedDateTime");
			
RejectedDateTime =new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(datenew1));		

RejectedBy=rst.getString("RejectedBy");
CommentForRejection=rst.getString("CommentForRejection");
}

if(!hodid.equalsIgnoreCase("-"))
{
sql="SELECT FirstName,LastName,Email FROM db_gps.t_userdetails WHERE srno='"+hodid+"'";
ResultSet rs2=stmt2.executeQuery(sql);
if(rs2.next())
{
HODName=rs2.getString("FirstName")+" "+rs2.getString("LastName");
NewHOD=rs2.getString("Email");
}
}
%>
<input type="hidden" value="<%=VehRNo %>" name="VehRNo" id="VehRNo">

<table class="stats" width="100%" border="0" align="center">

<tr><td>Date Of Rejecetion : </td><td><%=RejectedDateTime %></td></tr>

<tr><td>Rejected By  : </td><td><%=RejectedBy %></td></tr>

<tr><td>Reason(s)  : </td><td><%=CommentForRejection %></td></tr>



<tr align="center">
<td><input type="submit" value="Pass" name="sub"></input>
</td>
<td><input type="reset" value="Cancel" name="Cancel" onclick="javascript:window.close()"></input>
</td>
</tr>
</table>
</form>
<%
}
}

catch(Exception e)
{
	e.printStackTrace();
}
finally
{
con.close();	
}

%>

</body>
</html>
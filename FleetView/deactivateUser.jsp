<%@ include file="headernew.jsp" %>

<%!
Connection con1, con2;
%>
<script language="javascript">

function validate(){
//alert("in validate function");
	var username=document.deactivate.username.value;
//alert(username);
if("Select"==username){
	alert("please select username");
	return false;
}
}
</script>
 
<form name="deactivate" action="insertDeactivateUser.jsp" onsubmit="return validate();">

<% 
try {

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
String sql="select * from db_gps.t_security where ActiveStatus ='Yes' and TransporterName='"+session.getAttribute("usertypevalue").toString()+"' order by Username ";
ResultSet rs=stmt1.executeQuery(sql);

%>
<table border="0" width="50%" align="center"> 
			<tr><td bgcolor="#f5f5f5" colspan="2" align="center"><font color="maroon" size="2"> <B> DeActivate User</B> </font></td></tr>
			<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Username: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <select name="username">	
				<option value="Select">Select</option>
<%
while(rs.next()){
	%>
		<option value="<%=rs.getString("Username")%>"><%=rs.getString("Username")%>(<%=rs.getString("FullName") %>)</option>
	<%
}
%>
</select>
</td>
</tr>
<tr>
<td colspan="2" align="center" bgcolor="#f5f5f5">
<input type="Submit" name="Submit" value="Submit">
</td>
</tr>
</table>

<%

} catch(Exception e) { }

%>
</form>
<%@ include file="footernew.jsp" %>

<%@ include file="header.jsp" %>

<%!
Connection con1;
%>

<form name="totvehsrepform" method="get" action="" onSubmit="return validate();" >

<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();
ResultSet rs1=null;
String sql1="";

String transp=session.getAttribute("usertypevalue").toString();
%>
<table border="0" width="100%" bgcolor="white">
	<tr>
		<td align="center"> <font color="maroon" size="2"> <B> Castrol Trips of <%=transp%> </B> </font> </td>
	</tr>
</table>

<table border="0" width="100%" bgcolor="white">
<tr>
<td align="center">
	<table class="stats">
	  <tr>		
		<th align="center" > <B> Sr. No.</B>  </th>
		<th align="center" > <B> Vehicle No. </B></th>
		<th align="center" > <B> Start Date  </B> </th> 
		<th align="center" > <B> Start Place  </B> </th> 
		<th align="center" > <B> Destination  </B> </th> 
	  </tr>

<%
int i=1;

sql1="select * from t_startedjourney where OwnerName='"+transp+"' and GPName='Castrol' and JStatus='Running' ";	
rs1=stmt1.executeQuery(sql1);
while(rs1.next())
{ %>
	<tr>
		<td> <%=i%> </td>
		<td> <%=rs1.getString("VehRegNo")%> </td> 
		<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("StartDate")))%> </td> 
		<td> <%=rs1.getString("StartPlace")%> </td> 
		<td> <%=rs1.getString("EndPlace")%> </td> 
	</tr>
<%
	i++;
}

%>
	</table>
</td>
</tr>
</table>

<%


} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>


<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>

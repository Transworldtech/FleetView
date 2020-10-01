<%@ include file="header.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn, conn1;
Statement st, st1, st2,st3,st4;
String sql, sql1,sql2;

%>
<%
try
{
Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn1.createStatement();
st3=conn1.createStatement();
st4=conn1.createStatement();

}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
conn.close();
conn1.close();
}
%>
<table border="1" bgcolor="white" width="100%">
<tr><td>
<!-- Main Code-->
<table class="stats">
<tr><th colspan="10"><div class="bodyText">Exception Report</div></th></tr>
</table>

<!-- Main Code-->
</td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

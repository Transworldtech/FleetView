 <%@ include file="Connections/conn.jsp" %>

<%@ page buffer="16kb" %>

<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
ResultSet rs1=null,rs2=null;
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();

String sql1="";
String user="";
String username=session.getAttribute("user").toString();
//String entby=session.getAttribute("dispalyname").toString();
String security=request.getParameter("security");
boolean flag=true;


String sql="select * from t_sessions where SecutiryCode='"+security+"' and username='"+username+"'"; 
rs1=stmt2.executeQuery(sql);
if(rs1.next())
{
	flag=true;
}
else
{
	flag = false;
}

if(flag)
{
		response.sendRedirect("display_paymsg.jsp");
		return; 
}
else
{
	response.sendRedirect("sessionvalidate.jsp?invalid=true");
	return; 
}





} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
} 

  
%>

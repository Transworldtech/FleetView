<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
int id= 0;
%>
<%
String tripid= "";
String briefid="";
String driverid="";
String Start="";
String End="";
String StopReason="";
String Entryby="";
try
{
	System.out.println("***********22");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	
	 tripid= request.getParameter("tripid");
	 briefid= request.getParameter("briefid");
	 driverid= request.getParameter("driverid");
	 Start= request.getParameter("Start");
	 End= request.getParameter("End");
	 StopReason= request.getParameter("StopReason");
	 Entryby= request.getParameter("Entryby");
		
	

			
	String sql = "delete from  db_gps.t_jrnyplanning where Tripid='"+tripid+"' and Start = '"+Start+"' and End = '"+End+"' and driverid='"+driverid+"' and brifid='"+briefid+"' and Entryby='"+Entryby+"'";
	st.execute(sql);
	System.out.println(sql);
	response.sendRedirect("journeyplanning.jsp?Msg=1&driverid="+driverid+"&briefid="+briefid);
}

catch(Exception e)
{
	System.out.println("RRRRRRRRRRR  "+e);
	response.sendRedirect("journeyplanning.jsp?Msg=2&driverid="+driverid+"&briefid="+briefid);
	e.printStackTrace();
}
finally
{
	try
	{
		con1.close();		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
}
%>
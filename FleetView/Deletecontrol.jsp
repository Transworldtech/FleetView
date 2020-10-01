<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
int id= 0;
%>

<%

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=con1.createStatement();
Statement st1=con1.createStatement();

 
String VehId=request.getParameter("VehId");
System.out.println("VehIDDDDDDDD"+VehId);
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehRegNo"+VehRegNo);

%>
<%
String routeid="",rid="",quantity="",Km="",Balance="";

try
{
	//System.out.println("*****************************************************************************22");

	
	
	rid = request.getParameter("id");
	
	System.out.println("RIDRI98776578967-------------------------D:-"+rid);

			
	String sql = "delete from db_gps.t_controlsystemforcustomfielddata where id = '"+rid+"' ";
	//st.execute(sql);
	System.out.println("sqlsqlsqlsqlsqlsqlslqlsqlslqlsql:-"+sql);

	int i=st.executeUpdate(sql);
	//System.out.println("i **************************************************************************value"+i);
	//System.out.println("*****************************************************************************"+sql);

	//response.sendRedirect("RoutePlan.jsp?Msg=1&RouteCode="+driverid);
	
	out.println("<script type='text/javascript'>alert('Record Deleted Successfully');");
	 out.println("location='EditDcontrol.jsp?VehId="+VehId+"&VehRegNo="+VehRegNo+"'");
	out.println("</script>");
	
}

catch(Exception e)
{
	out.println("<script type='text/javascript'>alert('NOT Inserted');");
	 out.println("location='EditDcontrol.jsp?VehId="+VehId+"&VehRegNo="+VehRegNo+"'");
	out.println("</script>");
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
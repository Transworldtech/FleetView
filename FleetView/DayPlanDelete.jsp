<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
int id= 0;
%>
<%
String routeid="",day="",quantity="",Km="",Balance="";

try
{
	//System.out.println("*****************************************************************************22");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	
	String owner=session.getAttribute("usertypevalue").toString();
	routeid= request.getParameter("routeid");
	//System.out.println("*****************************************************************************"+routeid);
	day= request.getParameter("day");
	//System.out.println("*****************************************************************************"+geofenceid);
	//quantity= request.getParameter("quantity");
	//System.out.println("*****************************************************************************"+geofencename);
	
	

			
	String sql = "delete from  db_gps.t_daywisefuelplan where routeid='"+routeid+"' and day = '"+day+"' ";
	//st.execute(sql);
	int i=st.executeUpdate(sql);
	//System.out.println("i **************************************************************************value"+i);
	//System.out.println("*****************************************************************************"+sql);
	if(i>0)
	{
	response.sendRedirect("RoutePlan.jsp?Msg=1");
	}
	//response.sendRedirect("RoutePlan.jsp?Msg=1&RouteCode="+driverid);
}

catch(Exception e)
{
	System.out.println("RRRRRRRRRRR  "+e);
	response.sendRedirect("RoutePlan.jsp?Msg=2");
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
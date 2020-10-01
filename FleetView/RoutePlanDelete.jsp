<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
int id= 0;
%>
<%
String routeid="",geofenceid="",geofencename="",Km="",Balance="";

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
	geofenceid= request.getParameter("geofenceid");
	//System.out.println("*****************************************************************************"+geofenceid);
	geofencename= request.getParameter("geofencename");
	//System.out.println("*****************************************************************************"+geofencename);
	Km= request.getParameter("Km");
	//System.out.println("*****************************************************************************"+Km);
	//Balance= request.getParameter("Balance");
	//System.out.println("*****************************************************************************"+Balance);
	 

			
	String sql = "delete from  db_gps.t_geofencefuelplan where routeid='"+routeid+"' and geofenceid = '"+geofenceid+"' and geofencename = '"+geofencename+"' and Km='"+Km+"' and owner='"+owner+"' ";
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
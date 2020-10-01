<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	String owner= request.getParameter("owner");
	String vehicle= request.getParameter("vehno");
	String sensor= request.getParameter("sensor");
	String label= request.getParameter("lab");
	
	try 
	{
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		
		String sql="update db_gps.t_sensorlabels set Sensor= '"+sensor+"', Tray='"+label+"' where ownername='"+owner+"' and vehregno='"+vehicle+"' ";
		System.out.println("update query"+sql);
		stmt1.executeUpdate(sql);
		
		response.sendRedirect("AlertGoTo.jsp?msg=Information Updated Successfully.&goto=sensorlabelentry.jsp");
		
		}
	catch(Exception e)
	{
		out.println(e);
		e.printStackTrace();
	}
	finally
	{
		try{
			con1.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
%>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	System.out.println("In Delete page");
/*	String owner= request.getParameter("owner");
	System.out.println("Ownername"+owner);
	String vehicle= request.getParameter("vehicle");
	System.out.println("Vehicle"+vehicle);
	String sensor= request.getParameter("sensor");
	String label= request.getParameter("lab");  */
	
	try 
	{
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		if(request.getParameter("action").equals("delete")){
			String srno=request.getParameter("srno");
			String sql="delete from db_gps.t_sensorlabels where srno ='"+srno+"' limit 1 ";
		//String sql="delete from db_gps.t_sensorlabels where ownername ='"+owner+"' and vehregno='"+vehicle+"' limit 1 ";
		System.out.println("delete query"+sql);
		stmt1.executeUpdate(sql);
		out.println("#Yes");
	//	response.sendRedirect("AlertGoTo.jsp?msg=Record Deleted Successfully.&goto=sensorlabelentry.jsp");
		}
		
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
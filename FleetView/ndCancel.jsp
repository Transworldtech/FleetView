<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	System.out.println("In Cancel page");

	try 
	{
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		if(request.getParameter("action").equals("delete")){
			String vehcode=request.getParameter("vehcode");
			String sql="update db_gps.t_ndintimation set status='No' where  vehcode='"+vehcode+"' ";
			
		//String sql="delete from db_gps.t_sensorlabels where ownername ='"+owner+"' and vehregno='"+vehicle+"' limit 1 ";
		System.out.println("Cancel query"+sql);
		stmt1.executeUpdate(sql);
		//out.println("#Yes");
		response.sendRedirect("ndintimationreport.jsp");
		/* window.location="ndintimationreport.jsp"; */
		//out.println("#Yes");
		
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
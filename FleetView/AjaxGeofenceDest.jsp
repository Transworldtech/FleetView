
<%@page import="java.io.PrintWriter"%>
<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>

<%
		Connection con1 = null;
		Statement st = null;
		
		try 
		{
			 String result = "false";
			String endcode = request.getParameter("endDest");
			Class.forName(MM_dbConn_DRIVER);
			con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=con1.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM db_gps.t_warehousedata where WareHouseCode='"+endcode+"' and Owner='Castrol'");
			if(rs.next())
			{
				result = "true";
				
			}
			else
				result = "false";
			
			//PrintWriter out1 = response.getWriter();
			//response.setContentType("text/html");
			out.write(result);
		}
		catch(Exception e) 
		{ 
			System.out.println("Exception in AjaxGeofenceDest.jsp " +e);
		}
		finally
		{
			st.close();
			con1.close();
		}
%>
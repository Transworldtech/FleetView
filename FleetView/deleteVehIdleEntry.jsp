
<!-- Displayed Header -->
<%@ include file="headernew.jsp"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"	scope="page"></jsp:useBean>
	
<%! public static Connection con1; %>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(MM_dbConn_DRIVER);
	
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script >
function Redirect()
{
	alert("Record Deleted Successfully");
    window.location="VehicleIdleReport.jsp";
	
}
</script>
</head>
<body>
			<%
			
			String fromDate=request.getParameter("fromDate");
			String VehCode=request.getParameter("VehCode");
			int SrNo=Integer.parseInt(request.getParameter("SrNo"));
			
			System.out.println(" VehCode "+VehCode+" SrNo "+SrNo);
			
			String sql= "update  db_gps.t_VehicleIdleEntry set ActiveStatus='Deleted' where SrNo='"+SrNo+"' and VehCode='"+VehCode+"' limit 1";
			System.out.println(" sql "+sql);
			stmt1.executeUpdate(sql);
						
			System.out.println(" updated sccessfully ");
			out.println("<script>  Redirect();</script>");
			
			
			%>
</body>
</html>
<%@ include file="footernew.jsp" %>
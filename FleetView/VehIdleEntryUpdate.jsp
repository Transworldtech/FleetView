
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<%! public static Connection con1; %>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(MM_dbConn_DRIVER);
	
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;

	String VehCode=request.getParameter("VehCode");
	System.out.println(" vehcode is  "+VehCode);
	
	int SrNo=Integer.parseInt(request.getParameter("SrNo"));
	System.out.println("SrNo "+SrNo);
	
	String fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromDate"))) ;
	String toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("toDate"))) ;;
	String comment=request.getParameter("comment");
	String otherComment=request.getParameter("otherComment");
	
	
	 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script >
function Redirect()
{
	alert("Record Updated Successfully");
    window.location="VehicleIdleReport.jsp";
	
}




</script>
</head>
<body>
<%
try{
	final String userName = session.getAttribute("mainuser").toString();
	String sql= "update db_gps.t_VehicleIdleEntry set fromDate='"+fromDate+"',toDate='"+toDate+"',VehComment='"+comment+"', otherComment='"+otherComment+"' where VehCode='"+VehCode+"' and  SrNo='"+SrNo+"'";
	System.out.println("update query "+sql);
	stmt1.executeUpdate(sql);
	
	String sql2= "insert into  db_gps.t_VehIdleHistory(VehCode, fromDate, toDate, VehComment,otherComment, updatedBy) values('"+VehCode+"', '"+fromDate+"','"+toDate+"','"+comment+"','"+otherComment+"','"+userName+"')  ";
	System.out.println("insert query "+sql2);
	stmt1.executeUpdate(sql2);
	
	out.println("<script>  Redirect();</script>");
}catch(Exception e)
{
	out.println("Exception while updating data  "+e.getMessage());	
}
	
%>
</body>
</html>
<%@ include file="footernew.jsp" %>
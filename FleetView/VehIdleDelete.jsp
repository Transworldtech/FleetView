<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


</head>
<script type="text/javascript">

function fun(){
	
	
	
	
		  //alert("a");
		  var  agree=confirm("Are you sure you want to delete this Record?");
		  //alert(agree);
		  
		  var fromDate=document.getElementById("fromDate").value;
		  var VehCode=document.getElementById("VehCode").value;
		  var SrNo=document.getElementById("SrNo").value;
		  (SrNo) ;
		  if(agree)
		  {
			 	
			 window.location="deleteVehIdleEntry.jsp?fromDate="+fromDate+"&VehCode="+VehCode+"&SrNo="+SrNo+""
			 return true ;
		  }	  	   
		  else
		  {
			  //alert("D") ;
			 
			 window.location="VehicleIdleReport.jsp";
		     return false ;
		  }	  	   
	 
}

</script>
<form name="VehDl" id="veh">
<body >

<%			
			
			String fromDate=request.getParameter("fromDate");
//System.out.println("FromDAte======>>>"+fromDate);
%>

<input type="hidden" id="fromDate" name="fromDate" value="<%=fromDate%>" />


<% 
			String VehCode=request.getParameter("VehCode");
%>

<input type="hidden" id="VehCode" name="VehCode" value="<%=VehCode%>" />


<% 
			int SrNo=Integer.parseInt(request.getParameter("SrNo"));
%>

<input type="hidden" id="SrNo" name="SrNo" value="<%=SrNo%>" />


<% 
			%>
<script>
window.onload=fun ;
</script>
		
</body>
</form>
</html>
<%@ include file="footernew.jsp" %>
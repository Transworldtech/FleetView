<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="headernew.jsp"%>
<%-- <%@ include file="Connections/conn.jsp" %> --%>
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
		  var  agree=confirm("Are you sure you want to deactivate this record !!");
		 // alert(agree);
		  
		  var rid=document.getElementById("rid").value;
		  var driverid=document.getElementById("driverid").value;
		//  var SrNo=document.getElementById("SrNo").value;
		//  (SrNo) ;
		  if(agree)
		  {
			 	
			 window.location="driver_status_change.jsp?driverid="+driverid+"&Rid="+rid+"";
			 return true ;
		  }	  	   
		  else
		  {
			  //alert("D") ;
			 
			 window.location="Reportfordriver.jsp";
		     return false ;
		  }	  	   
	 
}

</script>
<form name="VehDl" id="veh">


<%			
			
			String rid=request.getParameter("rid");
//System.out.println("FromDAte======>>>"+fromDate);
%>

<input type="hidden" id="rid" name="rid" value="<%=rid%>" />


<% 
			String driverid=request.getParameter("driverid");
%>

<input type="hidden" id="driverid" name="driverid" value="<%=driverid%>" />


<% 
	
%>

<%-- <input type="hidden" id="SrNo" name="SrNo" value="<%=SrNo%>" /> --%>


<% 
			%>
			
<script>
window.onload=fun ;
</script>
		
</body>
</form>
</html>
<%@ include file="footernew.jsp"%>
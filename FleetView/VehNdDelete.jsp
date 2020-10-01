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


/* function fun()
{
	  //alert("a");
	  var  agree=confirm("Are you sure you want to cancel this Night Driving?");
	  
	  var fromDate=document.getElementById("fromDate").value;
	  
	  var SrNo=document.getElementById("SrNo").value;
	  //alert("B") ;
	  if(agree)
	  {
		 //alert("C") ;	
		 return true ;
	  }	  	   
	  else
	  {
		 //alert("D") ; 
	     return false ;
	  }	  	   
}
	 */  
	  
/* function popUp(webadd,VehicleRegNumber,VehCode,fromtime,totime)
{ 
	 window.open(webadd+'?vehicle='+VehicleRegNumber+'&vehcode='+VehCode+'&fromtime='+fromtime+'&totime='+totime,'jav','width=830,height=400,top=150,left=250,resizable=no,scrollbars=yes');

 } */

function DeleteRow(VehCode)
{
	//alert(VehCode);
	  //var VehCode=id;
	 var agree=confirm("Are you sure you want to cancel this Night Driving?");
	 //alert(agree);
	 if(agree)
	 {
	 	 
	 var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
	    }  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert(">>>    "+reslt);
				var data=reslt.split("#");
				//alert("<*****  "+data);
				if(data[1].indexOf('Yes')!=-1)
				{alert("Cancel successfully.....");					
			    	window.location.reload();
			    	
				}
			
			} 
		}
		
		var queryString = "?action=delete&vehcode="+VehCode;
		
		
		ajaxRequest.open("GET", "ndCancel.jsp" + queryString, true);
		ajaxRequest.send(null); 

	 }
	 else
	 	 {
		 window.location="ndintimationreport.jsp";
	 	  return false;
	 }
	 
	
} 

function fun(){
	
	
	
	
	  //alert("a");
	  var  agree=confirm("Are you sure you want to cancel this Night Driving?");
	  
	 // var fromDate=document.getElementById("fromDate").value;
	  var VehCode=document.getElementById("VehCode").value;
	  //var SrNo=document.getElementById("SrNo").value;
	  //alert(VehCode) ;
	  if(agree)
	  {
		 	
		 window.location="ndCancel.jsp?action=delete&vehcode="+VehCode+"";
		 return true ;
	  }	  	   
	  else
	  {
		  //alert("D") ;
		 
		 window.location="ndintimationreport.jsp";
	     return false ;
	  }	  	   

}
</script>
</head>
<form name="VehDl" id="veh">
<body>




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


window.onload=fun  ;
</script>
		
</body>
</form>
			<%-- <%
			
			String fromDate=request.getParameter("fromDate");
			String VehCode=request.getParameter("VehCode");
			int SrNo=Integer.parseInt(request.getParameter("SrNo"));
			
			System.out.println(" VehCode "+VehCode+" SrNo "+SrNo);
			
			/* String sql= "update  db_gps.t_VehicleIdleEntry set ActiveStatus='Deleted' where SrNo='"+SrNo+"' and VehCode='"+VehCode+"' limit 1";
			System.out.println(" sql "+sql);
			stmt1.executeUpdate(sql);
						
			System.out.println(" updated sccessfully ");
			out.println("<script>  Redirect();</script>");
			 */
			
			%> --%>
			
			
			<%-- <table border="3" style="width: 350px" class="sortable_entry" align="center" >
  		      <tr>
		         <td> <div align="center"> <font face="Arial" size="3"> <b> Delete Night Driving Notification </b> </font>   </div> </td>
		         </tr>
		         
		   			<!-- <tr>
      					<td colspan="2" align="left"> 
      						<div align="center"> 
      							<input type="submit" name="CANCLE" value="Submit" style="border-style: outset; border-color: black" class="formElement" onClick="return Redirect();"/> 
      						</div> 
      					</td>
      					
      					<td colspan="2" align="right"> 
      						<div align="center"> 
      							<input type="submit" name="OK" value="Submit" style="border-style: outset; border-color: black" class="formElement" onClick="return confirmDelete();"/> 
      						</div> 
      					</td>
  					</tr> -->
  					
  					<tr>
  					<td style="width: 2%"><a href="#"  style="font-weight: bold; color: black; "  onclick="DeleteRow('<%= VehCode%>') "><img src="images/delete.jpeg"  width="20px" height="18px"  style="border-style: none"  ></img></a>
  					
					</td>
					</tr>
  					
  					
     		 
		
	</table> --%>
</body>
</html>
<%@ include file="footernew.jsp" %>
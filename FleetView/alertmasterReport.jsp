<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">

function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}


function gotoExcel(elemId, frmFldId)  
{  
	      
         try
         { 
			 //alert("in go to excel funciton start ");

             var obj = document.getElementById(elemId);
          	 var oFld = document.getElementById(frmFldId);
          	 //alert("A");
          	 oFld.value = obj.innerHTML;
          	 //alert("B");	
          	 document.alertMaster.action ="excel.jsp";
          	 //alert("C");	

             try
             {
                 document.forms["alertMaster"].submit();
             }
             catch(e)
             {
                 alert("the exception is in the slertmaster submit function "+e);
             }      

             //alert("D");
         }
         catch(e)
         {
			 alert("the exception is :- "+e);

         }    
             
}


function confirmDelete()
{
	  //alert("a");
	  var  agree=confirm("Are you sure you want to change the status from yes/active  to No?");
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



</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="font-size: 1.3em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	<b>Alert Master Report</b></div>

   <%! 
		Connection conn;
   		Statement st=null,st1=null,st2=null ;	

    %>


<%

  fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
  System.out.println("MM_dbConn_DRIVER :- "+MM_dbConn_DRIVER+" MM_dbConn_STRING:-  "+MM_dbConn_STRING+" MM_dbConn_USERNAME:- "+MM_dbConn_USERNAME+" MM_dbConn_PASSWORD:- "+MM_dbConn_PASSWORD); 	
  	
  conn = fleetview.ReturnConnection();  	
  st   = conn.createStatement() ;
  st1  = conn.createStatement() ;
  String exportFileName=session.getAttribute("user").toString()+"_alertMasterReport.xls";
	  
  String flag = request.getParameter("flag");
  
  
  
  if(flag != null && (!(flag.equalsIgnoreCase("null"))) &&  (!(flag.equalsIgnoreCase(null))) && ((flag.equalsIgnoreCase("deactivate"))))
  {
		  
  	 String srno = request.getParameter("srno");
  	 
  	 String sql_update = "update db_gps.t_alertmaster set status='No' where SrNo='"+srno+"' ";
  	 
  	 System.out.println("the update query is :- "+sql_update);
  	 
  	 int updt = st1.executeUpdate(sql_update); 
  
     if(updt>0)
     {
    	System.out.println("update Successful"); 
    	%> <script type="text/javascript">alert("Updated  Successfully!!!")
     		window.location="alertmasterReport.jsp";
    	   </script>
        <% 
     }
  
  }


%>


<form action="" name="alertMaster" id="alertMaster" method="post">	

	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em;" align="center">
	<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
	
		<tr>
		<td>
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%=exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1')">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" onclick="gotoExcel('table1','tableHTML')">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%>
                           </div>
		</td>
		</tr>
		
		
		<tr>
		
		<td>
		<div align="left"><a href="#" onclick="window.open('addNewAlert.jsp?flag=insert','Edit_PopUp_Window','width=890,height=800,toolbar=true,location=false,status=no,menubar=no,resizable=yes,scrollbars=yes,left=50,top=50');"> <font  size="2">Add New</font></a></div>
		
		<div id="table1">
		<table align="center" class="sortable">
		
		<tr>
			<th><div align="center"><font size="2"><b>Edit/Delete</b></font></div></th>
			<th><div align="center"><font size="2"><b>Sr. No.</b></font></div></th>
			<th><div align="center"><font size="2"><b>Alert Name</b></font></div></th>
			<th><div align="center"><font size="2"><b>Customer</b></font></div></th>
			<th><div align="center"><font size="2"><b>Customer Type</b></font></div></th>
			<th><div align="center"><font size="2"><b>Trip</b></font></div></th>
			<th><div align="center"><font size="2"><b>To</b></font></div></th>
			<th><div align="center"><font size="2"><b>CC</b></font></div></th>
			<th><div align="center"><font size="2"><b>Status</b></font></div></th>
			<th><div align="center"><font size="2"><b>EntryBy</b></font></div></th>
			<th><div align="center"><font size="2"><b>Updated Date Time </b></font></div></th>
		</tr>
		
		<%
		
			String Sql = "select * from db_gps.t_alertmaster ";
			ResultSet rst = st.executeQuery(Sql);
			int i=0;
			while(rst.next())
			{
				
				String UpdatedDateTime = rst.getString("UpdatedDateTime") ;
				
				System.out.println("UpdatedDateTime before taking substring"+UpdatedDateTime);
				
				if(UpdatedDateTime.contains("."))
				{
					UpdatedDateTime = UpdatedDateTime.substring(0,(UpdatedDateTime.lastIndexOf(".")));
				}
				
				System.out.println("UpdatedDateTime after taking substring"+UpdatedDateTime);
				
				UpdatedDateTime = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(UpdatedDateTime));
				
				%>
				
			  	<tr>	
				
				<td style="text-align: left">
				<a href="#" media="html" onclick="window.open('addNewAlert.jsp?srno=<%=rst.getString("SrNo")%>&alertname=<%=rst.getString("AlertName")%>&flag=update','Edit_PopUp_Window','width=890,height=800,toolbar=true,location=false,status=no,menubar=no,resizable=yes,scrollbars=yes,left=50,top=50');"> <img src="images/edittt1.jpeg" width="15px" height="15px" style="border-style: none"></img>  </a> /  
				
				<a href="alertmasterReport.jsp?status=deactivate&srno=<%=rst.getString("SrNo")%>&flag=deactivate" onClick="return confirmDelete();"> <img src="images/delete.jpeg" width="15px" height="15px" style="border-style: none" media="html"></img>   
				
				</a>
				</td>
				
				
				
				<td style="text-align: right"><%=++i%></td>	
				<td style="text-align: left"><font size="2px"><%=rst.getString("AlertName") %></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("Customer") %></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("CustType")%></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("Trip")%></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("ToID")%></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("ToCC")%></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("Status")%></font></td>
				<td style="text-align: left"><font size="2px"><%=rst.getString("EntryBy")%></font></td>
				<td style="text-align: right"><%=UpdatedDateTime%></td>
			
			
			
			
			
			
			
			
			
			
				</tr>
			<% 
			
			}
			
			
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		%>
		
		</table>
		</div>
		
		
		
		</tr>
		</table>
		</div>
		</form>
		
	
	
	
	




</body>
</html>
<%@ include file="footernew.jsp"%>
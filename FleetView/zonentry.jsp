 <%@ include file="headernew.jsp" %>
  
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
 <script language="javascript">
 function validate()
 {
     var veh=document.fuelform.vehs.value;
     var driv=document.fuelform.drivers.value;
     var lits=document.fuelform.lits.value;
     var petpump=document.fuelform.petpump.value;

     if(veh=="Select")
     {
         alert("Please select Vehicle No");
         return false;
     }        

     if(lits=="")
     {
         alert("Please enter amount of fuel filled");
         return false;
     }
     if(isNaN(lits))
     {
         alert("Please enter valid amount of fuel filled");
         return false;
     }    

     if(petpump=="")
     {
         alert("Please enter place name from where fuel was filled");
         return false;
     }
     
     //return datevaildate();
     return true;
 }



</script>


<%!
Connection con1;
%>

<form name="fuelform" method="get" action="zoneinsert.jsp" onSubmit="return validate();" >

<% 
try
{
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
	Statement stmt1=con1.createStatement();
	ResultSet rs2=null, rs3=null, rs4=null, rs5=null;
	String sql2="", sql3="", sql4="", sql5="";
	String user=session.getValue("usertypevalue").toString();
	String usertype=session.getValue("TypeofUser").toString();
	java.util.Date d=new java.util.Date();
	//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
	int hours=(d.getHours());
	int minutes=(d.getMinutes());
	String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
%>
		<table border="0" width="100%" class="stats">
  		      <tr>
			
		         <td> <div align="center"> <font  size="3"> <b> Zone Information </b> </font>  ( <font color="red"> *</font> indicates mandatory fields)</div> </td>
		     </tr>
		     <%
		     	String inserted=request.getParameter("inserted");
		     	String err=request.getParameter("err");
		     	if(!(inserted==null))
		     	{ %>
		     		<tr>
		     				<td colspan="2" align="center"> <font size="2" color="blue">Successfully Inserted!</font> </td>
		     		</tr>			     		
		     <%
		     	}
		     	
	%>	     
		  
<tr><td colspan="2">
	<table border="0" width="70%" align="center" class="sortable_entry">
  	  <tr >
	      <td align="right"> 
	      	 <font  size="2"><b> <div align="right">Zone  Name: </b><font color="red">* </font> </div></font> </td>
				<td> 
						<input type="text" name="zonename" size="10"> </input> 	
				</td>
	 </tr>
	 <tr >
	      <td align="right"> 
	      	 <font  size="2"><b><div align="right"> Zone  code:</b><font color="red">* </font> </div> </font> </td>
				<td> 
						<input type="text" name="zonecode" size="10"> </input> 	
				</td>
	 </tr>
	 
	 
	 <tr >
	      <td align="right"> 
	      	 <font size="2"><b><div align="right">Zone Type:</b></div>  </font> </td>
				<td> 
						
						<select name="zonetype">
							<option value="CFA">CFA</option>
							<option value="-">-</option>
						</select>		
				
				</td>
	 </tr>
	 
	  
	<tr >
      		<td colspan="2" ailgn="center"> <div align="center"> <input type="submit" name="Submit" value="Submit"  class="formElement"/> </div> </td>
  	</tr>
      </table>
  
</td></tr></table>
<% } catch(Exception e) { out.println("Exception----->" +e); }
finally
{

}
%>



	<% fleetview.closeConnection(); %>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>

</form>
</body>
</html>
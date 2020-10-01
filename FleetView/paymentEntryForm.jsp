
<%@ include file="headernew.jsp"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
%>
<html>
<head>

<script language="javascript">
 function validate()
 {
	 
	 var invoice=document.payment.invoice.value;
	 var chequedate=document.payment.chequedate.value;
	 var amount=document.payment.amount.value;
	 var bank = document.payment.bank.value;
	 var branch=document.payment.branch.value;
	 
     if(invoice.length==0)
     {
         alert("Please enter invoice number");
         return false;
     }   
     if(amount.length==0)
     {
         alert("Please enter amount");
         return false;
     } 
     var numericExpression = /^[0-9]+$/;
   	      
     if(bank.length==0)
     {
         alert("Please enter bank name");
         return false;
     }   
     if(branch.length==0)
     {
         alert("Please enter branch");
         return false;
     }  
     if(amount.match(numericExpression)){
    		
    	}else{
    		alert("Amount should be numeric");
    		return false;
    	}   
  /*   var invoice=document.payment.invoice.value;
     var chequedate=document.payment.chequedate.value;
     var amount=document.payment.amount.value;
     var bank = document.payment.bank.value;
     var branch=document.payment.branch.value;*/

    // var split = veh.split(",");
     
 	var agree=confirm("Invoice: "+invoice+"\nCheque Date : "+chequedate+"\nAmount: "+amount+"\nBank : "+bank+"\nBranch : "+branch+" \n\nAre you sure you want to continue with these values?");
 	if (agree)
 		return true ;
 	else
 		return false ;
 	
     
  /*
    	 if (!(lits.match(/^\d+$|^\d+\.\d{2}$/ )) && lits.length!=0)
    	 {
    	 alert("Liters precision should not be greater than 0.2\n\nEg: 40.23");
    	 document.fuelform.lits.value="";
    	  return false;
    	 }
   
      if(varValue=="" &&  lits=="")
      {
          alert("Please enter either Odometer or Litres  reading");
          return false;
      }*/

  	
     return false;
 }

</script>
</head>


<form name="payment" action="paymentinsert.jsp" onSubmit="return validate();">

	
	

		<table border="0" width="50%" align="center" class="sortable_entry">
			<tr>
		<td colspan="2">
		<div align="center"><font size="3"> <b>
		Payment Information </b> </font> (<font color="red"> *</font> indicates mandatory
		fields)</div>
		</td>
	</tr>
	<%
		    String inserted = request.getParameter("ins");
		 
		     			if (!(inserted == null)) {
		     				
		     			if("inserted".equalsIgnoreCase(inserted))
		     			{
		     %>
		     		<tr>
		     				<td colspan="2" align="center"><blink><font color="red"> Successfully Inserted!!! </font></blink></td>
		     		</tr>			     		
		     <%
			     				     	}
		     			
		     			}
		     			
			     				     %>
			<tr>
				<td><font size="2"><b> Invoice No: </b><font color="red">* </font> </font></td>
				<td><input type="text" name="invoice" id ="invoice" size="10"> </td>
			</tr>
			<tr>
				<td> <font size="2"> <b>Cheque Date:</b> <font color="red">* </font></font> </td>
				<td> <input type="text" id="chequedate" name="chequedate"  size="13" value="<%=defaultDate%>" readonly  />
             		<script type="text/javascript">
             			Calendar.setup(
            			 {
             			    inputField  : "chequedate",         // ID of the input field
              				ifFormat    : "%d-%b-%Y",     // the date format
                			button      : "chequedate"       // ID of the button
            			 }
                       );
             		</script>
             		</td>
			</tr>
			<tr>
				<td><font size="2"><b> Amount: </b><font color="red">* </font> </font></td>
				<td><input type="text" name="amount"  id ="amount" size="10"> </td>
			</tr>
			<tr>
				<td><font size="2"><b> Bank: </b><font color="red">* </font> </font></td>
				<td><input type="text" name="bank" id ="bank" size="10"> </td>
			</tr>
			<tr>
				<td><font size="2"><b> Branch: </b><font color="red">* </font> </font></td>
				<td><input type="text" name="branch" id ="branch" size="10"> </td>
			</tr>
			<tr>
				<td><font size="2"><b> Comment: </b> </font></td>
				<td><textarea id="comment" name="comment" cols="25" rows="4"> </textarea> </td>
			</tr>
			<tr>
      			<td colspan="2" align="center"> <div align="center"> <input type="submit" name="Submit" value="Submit" onclick="return confirmSubmit()" /> </div> </td>
  			</tr>
		</table>

</form>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="footernew.jsp" %>
</html>

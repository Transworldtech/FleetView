<%@ include file="headernew.jsp"%>               
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	%>
<% 
		String bankName;
		String	 acctno;
		
		String driverid=request.getParameter("driverid");
		String drivername=request.getParameter("drivername");
		String transporter=request.getParameter("transporter");
		String transcation = request.getParameter("transcation");	
	
			bankName=request.getParameter("bankName");
			acctno=request.getParameter("acctno");
		if(bankName!=null)
		{
						
		}
		else
		{	System.out.println("bankName ->"+ bankName);
			bankName="xxxx";
			
		}
		
		if(acctno!=null)
		{
						
		}
		else
		{	System.out.println("acctno ->"+ acctno);
			acctno="0000";
		}
		
		
		
		String payedBy=request.getParameter("payedBy");
		String payedDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("payedDate")));
		
		String[] formonth=request.getParameterValues("formonth");
		String[] finalIncentive=request.getParameterValues("finalIncentive"); // Entitiled Amt
		String[] paidAmt=request.getParameterValues("paidAmt");
		String[] outStandAmt=request.getParameterValues("outStandAmt");
		String[] place=request.getParameterValues("place");

%>	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Incentive Payment Details</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">

<script>
function confirmSubmit()
{  
	var agree=confirm("Are you sure you want to continue?");
	if (agree)
		return true ;
	else
		return false ;
	
	}

</script> 

</head>
<body id="main_body" >
	
	<img id="top" src="newimages/top.png" alt="">
	
	<div id="form_container">
	
		<h1 align="center">Payment Entry Summary</h1>
	
		<form id="form_370051" class="appnitro"  method="get" action="IncentivePaymentSave.jsp" >
	
		<font size="3" style="margin-left: 0.4em;">Personal Details</font>
		<br>
		<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		
		
		<table border="0" width="40%" align="center" cellspacing="5">
		<tr align="left" >	
		<td colspan="1">
		
		<label class="description" for="element_25" style="width: 100px;"><font size="2">Driver ID </font></label>
		</td>
		
		<td>
		<div>
			<label style="text-align: left;" align="left" >  <font size="2">  <%= driverid %>  <input type="hidden" id="driverid" name="driverid" value="<%= driverid %>">   </font></label> 
		</div> 
		</td>
		
		</tr>
		
		<tr align="left">
		<td colspan="1">
		
		<label class="description" for="element_26" style="width: 150px;"><font size="2">Driver Name</font></label>
		</td>
		<td>
		<div>
		<label style="text-align: left;" align="left" >  <font size="2">  <%= drivername %>  <input type="hidden"id="drivername" name="drivername" value="<%= drivername %>">   </font></label>  </font></label>  
			
		</div> 
		</td>
		</tr>
		<tr align="left">
		<td colspan="1">
		<label class="description" for="element_27" style="width: 150px;"><font size="2">Transporter </font></label>
		</td>
		<td>
		<div>
			<label style="text-align: left;" align="left" >  <font size="2">  <%= transporter %>  <input type="hidden" id="transporter" name="transporter" value="<%= transporter %>">   </font></label>  
						
		</div> 
		</td>
		
		</tr>
		<tr>
			<td>
					<label class="description" for="element_27" style="width: 150px;"><font size="2">Transaction Type </font> </label>
			</td>
			<td> 
				<label id="transcation" name="transcation" style="text-align: left;"  >  <font size="2">  <%= transcation %>  <input type="hidden" id="transcation" name="transcation" value="<%= transcation %>">   </font></label>
				  
			</td>
		</tr>
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2">Bank Name </font></label>
		</td>
		<td>
		<div>
			 
			<label id="bankName" name="bankName" style="text-align: left;" align="left" >  <font size="2">  <%= bankName %>  <input type="hidden" id="bankName" name="bankName"  value="<%= bankName %>">   </font></label>  </font></label>
		</div> 
		</td>
		</tr>
		
			
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2">Account No </font></label>
		</td>
		<td>
		<div>
			 
			<label id="acctno" name="acctno" style="text-align: left;" align="left" >  <font size="2"> 
 
			 <%= acctno %> 
			 <input type="hidden" id="acctno" name="acctno"  value="<%= acctno %>">   </font></label>  </font></label>
		</div> 
		</td>
		</tr>
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2">Paid By </font></label>
			
		</td>
		<td>
		<div>
			 
			<label id="payedBy" name="payedBy" style="text-align: left;"  >  <font size="2">  <%= payedBy %>  <input type="hidden" id="payedBy" name="payedBy" value="<%= payedBy %>">   </font></label>  
		</div> 
		</td>
		</tr>
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2">Date </font></label>
			
		</td>
		<td>
		<div>
			
			<label id="payedDate" name="payedDate" style="text-align: left;"  >  <font size="2"> 
			<%
			out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(payedDate)));
			%> 
			 <input type="hidden" id="payedDate" name="payedDate" value="<%= payedDate %>">   </font></label>
		</div> 
		</td>
		</tr>
			
		</table>
		</div>
		<br></br>
		<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		
		
		<table border="0" width="100%" align="center" cellspacing="5">
		<tr>
		<td>
			<label class="description" for="element_28" style="width: 100px;"><font size="2">Month </font></label>
		</td>
		
		<td>
			<label class="description" for="element_28" style="width: 100px;"><font size="2">Entitled Amount </font></label>
		</td>
		<td>
			<label class="description" for="element_28" style="width: 100px;"><font size="2">Paid Amount </font></label>
		</td>
		<td>
	
			<label class="description" for="element_28" style="width: 100px;"><font size="2">Outstanding Amount </font></label>
		
		</td>
		<td>
			<label class="description" for="element_28" style="width: 100px;"><font size="2">Place </font></label>
		
		</td>
		</tr>
<% 		
for(int i=0;i<formonth.length;i++)
		{	
	%>						
		<tr>
			<td>
					<div>
						<label style="text-align: left;"  >  <font size="2"> 
 <% 
	
		out.print(new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(formonth[i])));
		
%>	 
			
						 
						 
						 
						 
						 <input type="hidden" id="formonth" name="formonth" value="<%=formonth[i] %>">   </font></label> 
						
					</div> 
			</td>
			<td>
					<div>
						<label  style="text-align: left;"  >  <font size="2">  <%= finalIncentive[i] %>   </font></label>
						<input type="hidden" id="finalIncentive<%=i%>" name="finalIncentive" value="<%= finalIncentive[i] %>">  
						
						 
					</div> 
			</td>
			<td>
					<div>
						 
						<label  style="text-align: left;"  >  <font size="2">  <% 
							if(paidAmt[i].isEmpty()  && paidAmt[i]=="")
							{
								out.println("-");									
							}
							else
							{
								out.println(paidAmt[i]);									
							}	
							%>   </font></label>
						<input type="hidden" id="paidAmt" name="paidAmt" value="<%= paidAmt[i] %>">  
					</div> 
			</td>
			<td>
					<div>
						 
						<label  style="text-align: left;"  >  <font size="2">  <%= outStandAmt[i] %>   </font></label>
						<input type="hidden" id="outStandAmt" name="outStandAmt"  value="<%= outStandAmt[i] %>"/>  
					</div> 
			</td>
			<td>
					<div>
						 
						<label  style="text-align: left;"  >  <font size="2"> 
						 <% if(place[i]=="" && place[i].isEmpty())
						 	{	out.println("-");	}
						 else
						 	{	out.println(place[i]); }
						 %>
						    </font></label>
						<input type="hidden" id="place" name="place"  value="<%= place[i] %>"/>  
					</div> 
			</td>
		</tr>
<% }%>		
		
		</table>
		
		
		
		<table border="0" width="100%" align="center">
		<tr>
		<td colspan="4" align="center">
			
					<li class="buttons">
			    <input type="hidden" name="form_id" value="370051" />
			    
				<input id="saveForm" class="button_text" type="submit" name="submit" value="Submit" style="border-style: outset; border-color: black"  onclick="return confirmSubmit()"/>
		</li></td></tr>
		</table></div>
			</ul>
		</form>	
		
		
	</div>
	<img id="bottom" src="newimages/bottom.png" alt="">
	</body>
</html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
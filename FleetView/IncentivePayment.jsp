<%@ include file="headernew.jsp"%>               
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	%>
	<%!Connection con1;
	String bankName;
	Integer AccountNo ;
	String payedBy;
	String payedDate;
	String place;
	%>
<!DOCTYPE html PUBLIC "-//W3C//DfTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Incentive Payment Details</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript">
function disablefield(obj)
{
	if (obj=="Cash")
	{
		
		 document.getElementById('bankName').value = '';
		 document.getElementById('acctno').value = '';
		 
		 document.getElementById('bankName').disabled = true;
		 document.getElementById('acctno').disabled = true;	
	}
	else
	{
		 document.getElementById('bankName').disabled = false;
		 document.getElementById('acctno').disabled = false;	
	}

}

</script>


<script type="text/javascript">
function getAmt()
{
	
	for(i=0;i<6;i++)
	{
		var finalIncentive=document.getElementById("finalIncentive"+i).value;
		var paidamt=document.getElementById("paidAmt"+i).value;

		if(paidamt.trim()=="")
		{
			alert("Please enter paid amount");	
			return false;
		}
		
		finalIncentive++; finalIncentive--;
		paidamt++; paidamt--;

		
		if(finalIncentive>=paidamt)
		{
			var outstandamt=finalIncentive-paidamt;
			document.getElementById("outStandAmt"+i).value=outstandamt;
		}
		else
		{
			document.getElementById("outStandAmt"+i).value="";	
			alert("Paid amount should be smaller than Entitled price");
			return false;
		}

		
	}
	
}


function validate()
		 {
			 			
			var payedBy=document.getElementById('payedBy').value;
			var payedDate=document.getElementById('payedDate').value;
			var bankName=document.getElementById('bankName').value;
			var acctno=document.getElementById('acctno').value;
			
			//var bank=document.getElementById('Bank').checked;

			if(document.getElementById('Bank').checked)
			{
				if(bankName.trim()=="")
				{
					alert("Please enter bank name");
					return false;
				}	
				if(acctno.trim()=="")
				{
					alert("Please enter account no");
					return false;
				}

				if(acctno.length>30)
				{
					alert("Please enter account no less than 30 words");
					return false;
				}
				
				if (isNaN(acctno)) 
				{
					alert('Please enter only numerical filed in account no');
	                return false
	            }	
			}
			
			
			if(payedBy.trim()=="")
			{
				alert("Please enter paidBy");
				return false;
			}
			if(payedDate=='')
			{
				alert("Please select date");
				return false;
			}

			
			return getAmt();
		
			
			}	     
</script>

<script type="text/javascript">
		function validateAttNo()
		{
			var acctno=document.getElementById('acctno').value;
			
			var acctnolen=document.getElementById('acctno').value.length;
			
			if(document.getElementById('Bank').checked)
			{
				
				if(acctno.trim()== "")
				{
					alert("Please enter account no");
					return false;
				}	
			
				if(isNaN(acctno)) 
				{
					alert('Please enter only numerical filed in account no');
	                return false;
	            }
				if(acctnolen>30)
				{
					alert("Please enter account no less than 30 words");
					return false;
				}
				
			}	
		}


		function validateBankName()
		{
			var bankName=document.getElementById('bankName').value;

			if(document.getElementById('Bank').checked)
			{
				if(bankName.trim()=="")
				{
					alert("Please enter bank name");
					return false;
				}	
			}	
		}

		function validatePaidBy()
		{
			var payedBy=document.getElementById('payedBy').value;
		
				if(payedBy.trim()=="")
				{
					alert("Please enter paidBy");
					return false;
				}
					
		}		
</script>

<script>

function dateformat(days)
{
if(days=='Jan')
return(1);
else
if(days=='Feb')
	return(2);
else
	if(days=='Mar')
		return(3);
	else
		if(days=='Apr')
			return(4);
		else
			if(days=='May')
				return(5);
			else
				if(days=='Jun')
					return(6);
				else
					if(days=='Jul')
						return(7);
					else
						if(days=='Aug')
							return(8);
						else
							if(days=='Sep')
								return(9);
							else
								if(days=='Oct')
									return(10);
								else
									if(days=='Nov')
										return(11);
									else
										if(days=='Dec')
											return(12);
}

function datevalidate()
{
				var payedDate=document.getElementById('payedDate').value;
			
				if(payedDate=='')
				{
					alert("Please select date");
					return false;
				}
	
		var date1=document.getElementById("payedDate").value;
		//var date2=document.getElementById("current1").value;
		
		var dm1,dd1,dy1,dm2,dd2,dy2;
		var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
		
		
		
		
		dd11=date1.substring(0,2);
		//dd22=date2.substring(0,2);
		
		
		mm1=date1.substring(3,6);
		//mm2=date2.substring(3,6);
		
		
		mm11=dateformat(mm1);
		//mm22=dateformat(mm2);
			
		
		
		yy11=date1.substring(7,11);
		//yy22=date2.substring(7,11);
		
		
		
		var date=new Date();
		var month=date.getMonth()+1;
		//alert(month);
		var day=date.getDate();
		//alert(day);
		
		var year=date.getFullYear();
		//alert(year);
		
	
		
		if(yy11>year)
		{
		alert("Selected date should not be greater than todays date");
		
		return false;
		}
		else if(year==yy11)
		{
			if(mm11>month)
		{
			alert("Selected date should not be greater than todays date");
			
			return false;
		}
		}
		if(mm11==month)
		{
		if(dd11>day)
		{
			alert("Selected date should not be greater than todays date");
			
			return false;
		}
		}
		
		//return confirmSubmit();	

}
</script>

</head>
<body id="main_body" >
	
	<img id="top" src="newimages/top.png" alt="">
	
	<div id="form_container">
	
		<h1 align="center">Payment Entry Form</h1>
	
		<form id="form_370051" class="appnitro"  method="get" action="IncentiveSummary.jsp" >
				
			<%
				Integer driverid=Integer.parseInt(request.getParameter("driverid"));
				String drivername=request.getParameter("drivername");
				String transporter=request.getParameter("transporter");
				
				String user=session.getAttribute("usertypevalue").toString();
				String entby=session.getAttribute("dispalyname").toString();	
			
			%>
			
			<%
		try {
				
				Class.forName(MM_dbConn_DRIVER);
				con1 = fleetview.ReturnConnection();
				Statement st = con1.createStatement();
				Statement st2 = con1.createStatement();
				String sql;
				
				//sql="select * from db_gps.t_driverincentivedetails where primarytrips=0 and driverid='"+driverid+"'    and transporter = '"+transporter+"'  ORDER BY finalIncentive DESC,driverid ";
				
				// Query to get driver details
				
				sql="select distinct(`driverid`),`drivername`,`transporter`,bankName,AccountNo, payedBy,payedDate    from db_gps.t_driverincentivedetails where primarytrips!=0 and driverid='"+driverid+"' ";
				ResultSet rs= st.executeQuery(sql);
								
				while(rs.next())	
				{	driverid=rs.getInt("driverid");	
					drivername=rs.getString("drivername");
					transporter=rs.getString("transporter");
					bankName=rs.getString("bankName");
					AccountNo=rs.getInt("AccountNo");
					payedBy=rs.getString("payedBy");
					payedDate=rs.getString("payedDate");
					
				
				}
			} catch (Exception e)
			{
				//out.println("In Exception --->"+e.getMessage());
				System.out.println("In Exception --->"+e.getMessage());
			} 		
				%>
			
	
	
		<font size="3" style="margin-left: 0.4em;">Personal Details</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font color="black">(</font> <font color="red">*</font> <font color="black">Indicates Mandatory Fields)</font>
		<br>
		<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		
		
		<table border="0" width="10%" align="center" cellspacing="5">
		<tr align="left" >	
		<td colspan="1">
	
		<label class="description" for="element_25" style="width: 150px;"><font size="2">Driver ID </font></label>
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
				<input onclick="disablefield('Bank')" class="description" id="Bank"  type="radio" name="transcation" value="Bank" checked="checked" />Bank
				<input  onclick="disablefield('Cash')" type="radio"  id="Cash"   name="transcation" value="Cash" />Cash &nbsp;
				 	
				  
			</td>
		</tr>
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2"><font color="red">* </font>Bank Name </font></label>
		</td>
		<td>
		<div>
			<input id="bankName" name="bankName" value="<%=bankName %>" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</td>
		</tr>
		
		
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2"><font color="red">* </font>Account No </font></label>
		</td>
		<td>
		<div>
			<input id="acctno" value="<%= AccountNo %>"  onfocus="return validateBankName();"  name="acctno" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</td>
		</tr>
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2"><font color="red">* </font>Paid By </font></label>
		</td>
		<td>
		<div>
			<input id="payedBy" value="<%= payedBy  %>"  onfocus="return validateAttNo();" name="payedBy" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</td>
		</tr>	
		
		<tr align="left">
		<td>
			<label class="description" for="element_28" style="width: 150px;"><font size="2"><font color="red">* </font>Date </font></label>
			
		</td>
		<td>
		<div>
			<input type="text" id="payedDate" name="payedDate" size="15" class="element text medium" style="width: 125px; height: 16px;"   readonly  onfocus="return validatePaidBy();"
			 value="
<%	try	{
	if(payedDate==null || payedDate.equalsIgnoreCase("null"))
			{
	out.print("");
			} 
else{
	payedDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(payedDate));
	out.print(payedDate);
	} 
	
	}
	catch(Exception e)
	{
		out.println("");
		
	}
	
	%>" 
			     />
			<script type="text/javascript">
			Calendar.setup(
		             {
		                 inputField  : "payedDate",         // ID of the input field
		                 ifFormat    : "%d-%b-%Y",     // the date format
		                 button      : "payedDate"       // ID of the button
		             }      );
         	</script> 
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
			<label class="description" for="element_28" style="width: 100px;"><font size="2">Entitled Price </font></label>
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
				// Logic for getting amount monthywise
			try{
				Class.forName(MM_dbConn_DRIVER);
				con1 = fleetview.ReturnConnection();
				Statement st2 = con1.createStatement();
				String sql2; int finalIncentive;
				sql2="select `formonth`, finalIncentive, paidAmt, place  from db_gps.t_driverincentivedetails where primarytrips!=0 and driverid='"+driverid +"' ";
				
				//paidAmt
				
				ResultSet rs= st2.executeQuery(sql2);			
				
				String formonth;
				int i=0;
				while(rs.next())	
				{
					
					finalIncentive=rs.getInt("finalIncentive");		
					place=rs.getString("place");		
		%>		
		
		
			
		
		
		<tr>
			<td>
					<div>
						<label style="text-align: left;"  >  <font size="2" color="black"> 
						 
						<% 
	try
		{
		if(rs.getString("formonth")==null || rs.getString("formonth").equalsIgnoreCase("null"))
				{	out.print("-");		} 
		else{
		out.print(new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("formonth"))));
		}
		}
		catch(Exception e)
		{
			out.println("-");
			
		}%>	
		</font></label> 
					 <input type="hidden" id="formonth" name="formonth" value="<%=rs.getString("formonth") %>">   </font></label> 
						
					</div> 
			</td>
			<td>
					<div>
						<label  style="text-align: left;" color="black" >  <font size="2" color="black">  <%= finalIncentive %>   </font></label>
						<input type="hidden" id="finalIncentive<%=i%>" name="finalIncentive" value="<%= finalIncentive %>">  
						
						 
					</div> 
			</td>
			<td>	
					<div>
						<input id="paidAmt<%=i%>"  value="<%=rs.getString("paidAmt")%>"  name="paidAmt" class="element text medium" type="text" maxlength="255" onchange="return getAmt();" onfocus="return datevalidate();;" style="width: 150px; height: 20px;"/> 
					</div> 
			</td>
			<td>
					<div>
						<input  readonly id="outStandAmt<%=i%>" name="outStandAmt" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
					</div> 
			</td>
			<td>
					<div>
						<input id="place<%=i%>"  value="<%= place %>"  onkeyup="return validatePlace()" name="place" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
					</div> 
			</td>
		</tr>
		
			<% 
			i++;	
			}
			} catch (Exception e)
			{
				out.println("In Exception --->"+e.getMessage());
			} 		
			%>
		</table>
		
		
		
		<table border="0" width="100%" align="center">
		<tr>
		<td colspan="4" align="center">
			
					<li class="buttons">
			    <input type="hidden" name="form_id" value="370051" />
			    
				<input id="saveForm"  type="submit" onclick="return validate();" class="button_text" name="submit" value="Submit" style="border-style: outset; border-color: black" />
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
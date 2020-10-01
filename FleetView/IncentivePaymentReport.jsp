<%@ include file="headernew.jsp" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%! String date = null;
	String formonth = null;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function gotoPrint(divName)  
{    
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId,frmFldId)  
{  
	try
	{
	
	     var obj = document.getElementById(elemId);  
	     var oFld = document.getElementById(frmFldId); 
         oFld.value = obj.innerHTML;
         document.DriverIncentivePaymentReport.action ="excel.jsp";
         document.forms["DriverIncentivePaymentReport"].submit();
	}
	catch(e)
	{
		alert(e);
	}
} 


</script>
<%
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
String exportFileName=session.getAttribute("user").toString()+"_DriverIncentivePymentReport.xls";
%>


</head>
<body style="font-family: Arial">

	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">

<form name="DriverIncentivePaymentReport" id="DriverIncentivePaymentReport" action="" method="post">
<div id="table1" align="center" style="width: 850px;">
<div style="font-size: 1.4em;" align="center">
<font face="Arial">	Driver Incentive Payment Report For Primary And Secondary Trips    </font></div>
<table border="0" width="100%" align="center">
<tr>

      <td align="right">
      <br>
          <div class="bodyText" align="right">
          <input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

          <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
          <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 

        <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
      <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
       <%=fleetview.PrintDate() %>
          </div>
      </td>
</tr>
</table>

<table class="sortable" width="100%" align="center">
<tr>
<th style="width: 10px">Sr No</th>
<th style="width: 50px">Driver Id</th>
<th style="width: 160px">Driver Name</th>
<th style="width: 160px">Transporter </th>
<th style="width: 25px">Bank Name</th>
<th style="width: 40px">Account No</th>
<th style="width: 60px">Paid By</th>
<th style="width: 60px">Month</th>
<th style="width: 40px">Actual Incentive</th>
<th style="width: 40px">Entitled Incentive</th>
<th style="width: 50px">Paid Incentive</th>
<th style="width: 50px">Outstanding Incentive</th>
<th style="width: 50px">Paid Date</th>
<th style="width: 50px">Place</th>
</tr>
<%
String driverid=request.getParameter("driverid");
String QueryDate=request.getParameter("QueryDate");

try
{
	
	Connection con=null;

	Statement st;
Class.forName(MM_dbConn_DRIVER);
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con.createStatement();

%>

<%
String sql; 

sql="select * from db_gps.t_driverincentivedetails where  primarytrips!=0 and  driverid='"+driverid+"'  ORDER BY finalIncentive DESC,driverid ";
ResultSet rs= st.executeQuery(sql);


int i=1;
Integer outstanding, finalIncentive, paidAmt;


while(rs.next())
{	 
	finalIncentive=rs.getInt("finalIncentive");
	paidAmt=rs.getInt("paidAmt");

	outstanding=finalIncentive-paidAmt;
%>
<tr>   
<td style="text-align: right;" align="right"><%=i++ %></td>
<td style="text-align: right;" align="right" >
<%=rs.getString("driverid") %>
</td>
<td style="text-align: left;" align="left" ><%=rs.getString("drivername") %></td>
<td style="text-align: left;" align="left"><%=rs.getString("transporter") %></td>
<td style="text-align: left;" align="left"><%=rs.getString("bankName") %></td>
<td style="text-align: right;" align="right">
			<% 
			Integer AccountNo=rs.getInt("AccountNo");
			if(AccountNo==0)
				{
					out.println("-");
				}
			else
			{
				out.println(AccountNo);
			}
				%>
</td>
<td style="text-align: left" align="left"><%=rs.getString("payedBy") %></td>
<td style="text-align: right;" align="center">
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
	
	
		
</td>

<td style="text-align: right;" align="right"><%=rs.getString("totalincentive") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("finalIncentive") %></td>
<td style="text-align: right;" align="right"><%=rs.getString("paidAmt") %></td>
<td style="text-align: right;" align="right"><%= outstanding %></td>
<td style="text-align: left;" align="left">
	
	<% 
	try
	{
	
	if(rs.getString("payedDate")==null || rs.getString("payedDate").equalsIgnoreCase("null"))
			{
	out.print("-");
			} 
else{
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("payedDate"))));
	} 
	
	}
	catch(Exception e)
	{
		out.println("-");
		
	}
	
	%>
	
	
	
</td>
<td style="text-align: left;" align="left"><%=rs.getString("place") %></td>
</tr>
<%
}

}
catch(Exception e)
{
	out.print("Exception "+e.getMessage());
	e.printStackTrace();
}

%>
</table>
</div>
</form>
</div>
</body>
</html>
	



</jsp:useBean>
<%@ include file="footernew.jsp" %>	
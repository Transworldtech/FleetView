<%@ include file="headernew.jsp"%>               
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Incentive Payment Details</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/JavaScript">
alert("Data inserted successfully");
redirectTime = "100";
redirectURL = "driverIncentiveDetails.jsp";
window.onload=function(){
	setTimeout("location.href = redirectURL;",redirectTime);
}

</script>
</head>
<body >
<form  >	

	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);

	Connection con1;
	Class.forName(MM_dbConn_DRIVER);
	con1 = fleetview.ReturnConnection();
	Statement st = con1.createStatement();
	Statement st2 = con1.createStatement();
	String sql,sql2;

	
	String driverid=request.getParameter("driverid");
	String drivername=request.getParameter("drivername");
	String transporter=request.getParameter("transporter");
	Integer acctno=Integer.parseInt(request.getParameter("acctno"));
	if(acctno==null)
	{
		acctno='-';		
	}
	
	String bankName=request.getParameter("bankName");
	
	if(bankName==null)
	{
		bankName="-";		
	}
	String payedBy=request.getParameter("payedBy");
	
	String payedDate=request.getParameter("payedDate");
	String[] formonth=request.getParameterValues("formonth");
	String[] finalIncentive=request.getParameterValues("finalIncentive"); // Entitiled Amt
	String[] paidAmt=request.getParameterValues("paidAmt");
	//String outStandAmt=request.getParameter("outStandAmt");
	String[] place=request.getParameterValues("place");
	
	
	try
	{	
	
		for(int i=0;i<formonth.length;i++)
		{	
			if(!paidAmt[i].isEmpty())
			{	
				sql="update t_driverincentivedetails set paidAmt='"+paidAmt[i]+"', AccountNo='"+acctno+"' ,  payedBy='"+payedBy+"' , place='"+place[i]+"', payedDate='"+payedDate+"',  bankName='"+bankName+"', inserted_date=NOW() 	where driverid='"+driverid +"' and formonth='"+formonth[i]+"'  ";
				st.executeUpdate(sql);
			
				
				sql2="insert into incentivepaymenthistory(driverid, formonth, entitled_amount,  paidAmt ,  AccountNo , payedBy, place , payedDate,bankName, inserted_date  ) values('"+driverid+"','"+formonth[i]+"','"+finalIncentive[i]+"' ,'"+paidAmt[i]+"','"+acctno+"','"+payedBy+"','"+place[i]+"','"+payedDate+"', '"+bankName+"',NOW()) ";
				st2.executeUpdate(sql2);
							
				//out.println("\n data inserted successflly");
			}
		}		
    }		
 catch(Exception e)
{	//e.printStackTrace();
	//out.println("\n exception ---->"+e.getMessage());	
	 
}
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
	%></form>
	</head>
</html>	
</jsp:useBean>
<%@ include file="footernew.jsp" %>
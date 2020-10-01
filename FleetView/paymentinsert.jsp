<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="Connections/conndriver.jsp" %>
    <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%! 
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.sun.org.apache.bcel.internal.generic.NEW"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection con=null;
int insert=0;
String sql="";
String msg1="";
//System.out.println("i===>"+i);
try{           
	
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	
	String today = new SimpleDateFormat("dd-MMM-yyyy").format(Calendar.getInstance().getTime());
	System.out.println("(((("+today);
	
	String typevalue	=	session.getAttribute("usertypevalue").toString();
	String user			=	session.getAttribute("dispalyname").toString();
	String invoice		=	request.getParameter("invoice");
	String chequedate	=	request.getParameter("chequedate");
	String amount 		= 	request.getParameter("amount");
	String bank 		= 	request.getParameter("bank");
	String branch 		= 	request.getParameter("branch");
	String comment 		= 	request.getParameter("comment");
	
	chequedate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(chequedate));
		sql="insert into t_paymentdetails (entryby,transporter,invoiceno,chequedate,amount,bank,branch,comment) values ('"+user+"','"+typevalue+"','"+invoice+"','"+chequedate+"','"+amount+"','"+bank+"','"+branch+"','"+comment+"')";
	insert=stmt.executeUpdate(sql);
	
if(insert>0){
	msg1="inserted";
	System.out.println(msg1);
	try{
	String Data="<html><body>"+"\n\n Mam/Sir, \n<br><br> Please find the Payment Entry Details <br>"+"<table border="+1+"> "+
	"<tr><td><b>Entry By</b></td><td>"+user+"</td></tr><tr><td><b>Invoice</b></td><td>"+invoice+"</td></tr><tr><td><b>Cheque Date</b></td><td>"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(chequedate))+"</td></tr><tr><td><b>Amount </b></td><td>"+amount+"</td></tr><tr><td><b>Bank</b></td><td>"+bank+"</td></tr><tr><td><b>Branch</b></td><td>"+branch+"</td></tr><tr><td><b>Remark</b></td><td>"+comment+"</td></tr></table>";
		 Properties props = new Properties();

       	 String host="smtp.transworld-compressor.com";
       	 String protocol = "smtp";
        	  String user1 = "tripend@mobile-eye.in";
        	  String pass = "transworld";
        		props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.user", "user1");
				props.put("mail.smtp.password", "pass");
				props.put("mail.store.protocol", protocol);
				props.put("mail.smtps.host", host);
       		 props.put("mail.smtps.host", host);
	       	       java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
	              Session session1 = Session.getDefaultInstance(props, null);
	               // Construct the message
	               Message msg = new MimeMessage(session1);
	               msg.setSubject("Payment Entry Details: "+today);
	               msg.setSentDate(new java.util.Date());
	               Address recipientAddrs[] = new InternetAddress[1];
	             //  Address recipientAddrs1[] = new InternetAddress[2];
	               recipientAddrs[0] = new InternetAddress("p_kulkarni@transworld-compressor.com");
	             
	               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
	             
	               Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
	          
	               msg.setFrom(fromAddress);
	               msg.setContent(Data+"<br><b>In case of any queries,kindly reply to mail id for assistance : avlsupport@mobile-eye.in</b>  <br> Thanks and Regards <br>Transworld Team " ,"text/html; charset=ISO-8859-1"); 
	               // Send the message
	               Transport t = session1.getTransport("smtps");
	               msg.saveChanges(); // don't forget this
	               try
	               {
	            	  
	                    t.connect(host, user1, pass);
	                    t.sendMessage(msg, msg.getAllRecipients());
	                  
	                    System.out.println("Your message has been sent");
	               }
	               catch(Exception e)
	               {
	                   System.out.print("Exception####>"+e);
	                  
	               } 
	               finally 
	               {
	                   t.close();
	               } 
	          		
	               Transport.send(msg);
	}
	catch(Exception ex){
		ex.printStackTrace();
	}
	response.sendRedirect("paymentEntryForm.jsp?ins="+msg1);
}

	}catch(Exception e){
	e.printStackTrace();
}
	finally{
		try
		{
			con.close();
		}catch(Exception ee)
		{
			
		}
	}
	
%>
</body>
</html>
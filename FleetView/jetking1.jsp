
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor=Bisque>
<table>
<tr>
<div align="center">
<img src="images/rotaract_c.gif" width="100" height="100"></img>
</div>
</tr>
</table>

<table border="0" align="center" width="600px" width="100%"> 
<tr>
		<td align="center"><font color="brown" size="5">Rotaract Club Of Pune Riverside</font></td>
</tr>

<tr><td align="center"><font color="brown" size="5">-Jetking</font>
<td align="right"><a href="jetking.jsp"><b>Back</b></a></td></tr>
</table>

<fieldset style="padding: 2">
	<legend>Thank you,</legend>




<%!
	Connection conn;
	
	
	%>
	<%
//System.out.println("hello jetking!!!");
try
{	

	Class.forName("org.gjt.mm.mysql.Driver"); 
conn = DriverManager.getConnection("jdbc:mysql://localhost/db_rotaractclub","fleetview","1@flv");
//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement s=conn.createStatement();
	boolean flag=false;
	String name=request.getParameter("name");
	String Lname=request.getParameter("Lname");
	String email=request.getParameter("email");
	String mobno=request.getParameter("mobno");
	String address=request.getParameter("address");
	//System.out.println(Lname);
	//System.out.println(email);
	//System.out.println(mobno);
	//System.out.println(address);
	
	String sql="insert into t_jetking1(name,Lname,email,mobno,address) Values('"+name+"','"+Lname+"','"+email+"','"+mobno+"','"+address+"')";
	//System.out.println(sql);
	int rs=0;	
	 rs=s.executeUpdate(sql);
	/*if(rs>=1)
	{
		System.out.println("inserted row--->"+rs);
	}*/
	
	
	String Data="\n\n\n\n\tHello Sir/Mam,\n\n\t <br> Thanks for your registration<br> Your details are: "+"<br><html><body><table border='1'><tr>"+"<th>First Name</th><th>Last Name</th><th>Mobile No.</th><th>Email Id</th><th>Address</th></tr>";
	 //\n\n\tFirst Name="+name+"<br>\n\nLast Name="+Lname+"<br>\n\n\n\nEmail ID="+email+"<br>\n\n\n\nMobile No="+mobno+"<br>\n\n\n\nAddress="+address+" ";
	 String Data1="";
	 Data1=Data1+"<tr> <td>"+name+"</td><td>"+Lname+"</td><td>"+mobno+"</td><td>"+email+"</td><td>"+address+"</td></tr>";
	 Data=Data+Data1+"</table></body></html>";
	 try
	         {
	                
	        	 flag=false;
	        	 		Properties props = new Properties();
	                    String host="smtp.transworld-compressor.com";
	                    String protocol="smtp";
	                    String user="tripend@mobile-eye.in"; 
	                    String pass="transworld";
	                    props.put("mail.smtp.starttls.enable","true");
	                    props.put("mail.smtp.auth", "true");
	                    props.put("mail.smtp.user", "user");
	                    props.put("mail.smtp.password", "pass");  
	                    props.put("mail.store.protocol", protocol);
	                    props.put("mail.smtps.host", host);
	                    java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
	                    Session session1 = Session.getDefaultInstance(props,null);
	                                       // Construct the message
	        Message msg = new MimeMessage(session1);
	        msg.setSubject("Rotaract club of pune Riverside registration.");
	        msg.setSentDate(new java.util.Date());
	                                      // Address add1=new InternetAddress(email,email2);
	                                                          //  mail id-------------
	        Address recipientAddrs[] = new InternetAddress[1];
	                                     
	        recipientAddrs[0] = new InternetAddress(email); 
	        //recipientAddrs[1] = new InternetAddress("s_shinde@transworld-compressor.com"); 
	                                       
	                                    
	                                                 /*  Address recipientAddrs[] = new InternetAddress[1];
	                                               recipientAddrs[0] = new
	        InternetAddress("p_ghotkule@transworld-compressor.com");*/
	                                         
	                                     //  Address add1=new InternetAddress(mailid);
	        
	        msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
	                                   
	       Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
	                                  
	                                 msg.setFrom(fromAddress);
	                                       
	              // ------------ code for sending attachment------------------
	                                       
	                                    // Create the message part 
	                                 /*      BodyPart messageBodyPart = new MimeBodyPart();
	        
	                                       // Fill the message
		 messageBodyPart.setText(Data+"<br> Thanks and Regards, <br> Transworld Team");
	        
	                                       Multipart multipart = new MimeMultipart();
	                                       multipart.addBodyPart(messageBodyPart);
	        
	                                       // Part two is attachment
	                                       messageBodyPart = new MimeBodyPart();
	                                       // filename = "/home/pradnya/Desktop/OR_ER_Count.xls";
	                                       DataSource source = new FileDataSource(filename);
	                                       messageBodyPart.setDataHandler(new DataHandler(source));
	                                       filename="OR_ER_Count.xls";
	                                         messageBodyPart.setFileName(filename);*/
	                                     /*  multipart.addBodyPart(messageBodyPart);
	        
	                                       // Put parts in message
	                                       msg.setContent(multipart); */
	        //--------------------------- end of    logic---------------------------------
           msg.setContent(Data+"\n\n\n\t"+"<br> Thanks and Regards,<br>\n\n\n\t Rotaract Team" ,"text/html; charset=ISO-8859-1"); 
	                                       // Send the message
	                                       
	        
	                                       Transport t = session1.getTransport("smtps");
	                                       msg.saveChanges(); // don't forget this
	                                       
	                                          
	                                       try
	                                       {
	                                          
	                                            t.connect(host, user, pass);
	                                            t.sendMessage(msg, msg.getAllRecipients());
	                                           // t.sendMessage(msg1, msg1.getAllRecipients());
	                                            flag=true;
	                                            out.println(" Your Registration is DONE. ");
	                                            %>
	                                            <br></br>
	                                            
	                                            <br></br>
	                                            <%
	                                            out.println("Vikram Puri, Webmaster");
	                                       }/*catch(SMTPSendFailedException smp)
	                                       {
	        
	        System.out.print("Error:--"+smp.getCommand()+smp.getReturnCode());
	                                       }*/
	                                     catch(Exception e)
	                                       {
	                                           System.out.print("Exception----->"+e);
	                                          
	                                       } 
	                                       finally 
	                                       {
	                                           t.close();
	                                       } 
	                                                
	                                       Transport.send(msg);
	         }                                        
	                                       catch(Exception e)
	                       		        {
	                       		        	
	                       		        	//System.out.println("Sorry, your mail cannot be sent due to Congestion"+e);
	                       		        	
	                       		 
	                       		        }             // Transport.send(msg1);
	        
     
  
	
	
	
	
}
catch(Exception e)
{
	out.println(e);	
}
finally
{
	conn.close();
}
	%></fieldset>
</body>
<table>

<tr>
<div align="center">
<img src="images/riemblem_gold_large.gif" width="100" height="100"></img>
</div>
</tr>
</table>
</html>
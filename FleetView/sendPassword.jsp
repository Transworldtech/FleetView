<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.Properties,javax.mail.*,javax.mail.internet.*"
     import="java.sql.*" pageEncoding="UTF-8"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
Connection conn1;
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME="fleetview";
String MM_dbConn_PASSWORD="1@flv";
String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
%>

<% 
try {
	    
	    
	    
	    Class.forName(MM_dbConn_DRIVER);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		Statement stmt1 = conn1.createStatement();
		Statement stmt2 = conn1.createStatement();
		ResultSet rs=null;
		String username=  request.getParameter("uname");
		username=username.trim();
		String pwd=null;
		boolean flag=false;
		String slq1="";
		String slq="Select FullName,Password,TypeValue from t_security where Username ='"+username+"' and ActiveStatus='Yes'";
		rs = stmt1.executeQuery(slq);
		
		String name=null;
		String tname=null;
		
		if(rs.next())
		{
			 name=rs.getString("FullName");
		     pwd=rs.getString("Password");
		     tname=rs.getString("TypeValue");
		    // System.out.println("Password:" +pwd);
		    
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
		               msg.setSubject("Password retrieval");
		               msg.setSentDate(new java.util.Date());
		               
		               Address recipientAddrs[] = new InternetAddress[1];
		             //  Address recipientAddrs1[] = new InternetAddress[2];
		             String Data="";
		             //username.contains("@");
		             //Pattern p = Pattern.compile("@");
		             //Matcher m = p.matcher(username);
		            // boolean b = m.matches();
		            // System.out.println("b:" +b);
		             if(username.contains("@"))
		             {
		            	 Data="<html><body>"+"\n\n Dear "+name+",\n<br><br> We have received your request for sending password for FleetVeiw, below is details <br><br>URL: www.myfleetview.com<br>UserId:"+username+"<br>Password:"+pwd+"<br><br>If any further assistance require,please contact below<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125<br><br><br>Support Team<br>Transworld </body></html>"; 
		            	 recipientAddrs[0] = new InternetAddress(username);
		            	 //System.out.println("Data:" +Data);
		             }
		             else
		             {
		            	 
		            	 Data="<html><body>"+"\n\n Dear AVL Support, \n<br><br> Request of User received for Forgot Password <br><br>UserId: "+username+"<br>Transporter/Group name: "+tname+"<br><br>You have received this request as above User Id is not with Email ID and system couldn't send email to respective user.<br><br><br>Auto Alert Team<br>Transworld </body></html>";
		            	 recipientAddrs[0] = new InternetAddress("avlsupport@mobile-eye.in");
		             }
		             
		             
		               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
		              // msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
		               Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
		          
		               msg.setFrom(fromAddress);
		               msg.setContent(Data,"text/html; charset=ISO-8859-1");
		               // Send the message
		               Transport t = session1.getTransport("smtps");
		               msg.saveChanges(); // don't forget this
		               try
		               {
		            	  
		                    t.connect(host, user1, pass);
		                    t.sendMessage(msg, msg.getAllRecipients());
		                    flag=true;
		                    //System.out.println("Your message has been sent");
		                    
		                    if(flag==true)
		                    {
		                    	slq1="insert into t_forgotpassword (username,fullname,password,mailstatus) values ('"+username+"','"+name+"','"+pwd+"','Sent')";
		                        //System.out.println(slq1);
		                    	
		                    	stmt2.executeUpdate(slq1);
		                        
		                        
		                        
		                    }
		                    else
		                    {
		                    	slq1="insert into t_forgotpassword (username,fullname,password) values ('"+username+"','"+name+"','"+pwd+"')";
		                        stmt2.executeUpdate(slq1);
		                    }
		                    response.sendRedirect("forgetPassword.jsp?Msg=Your password will be mailed to you shortly.");
		               }
		               catch(Exception e)
		               {
		                   System.out.print("Exception----->"+e);
		                   e.printStackTrace();
		                  
		               } 
		               finally 
		               {
		                   t.close();
		               } 
		          		
		               Transport.send(msg);
		}
		else
		{
			response.sendRedirect("forgetPassword.jsp?Msg=\t Incorrect username!!!!");
		}
		

		//String Data="<html><body>"+"\n\n Dear "+username+", \n<br><br> We have received your request for sending password for FleetVeiw, below is details <br><br>URL: www.myfleetview.com<br>UserId:"+username+"<br>Password:"+pwd"\n<br>If any further assistance require,please contact below<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125\n\n<br>Support Team<br>Transworld </boby></html>";
        //String Data1="<html><body>"+"\n\n Dear Dear AVL Support, \n<br><br> Request of User received for Forgot Password <br><br>UserId:<br>Password:\n<br>You have received this request as above User Id is not with Email ID and system couldn't send email to respective user.<br>Email:avlsupport@Mobile-Eye.in<br>Phone: 020-41214444, 09762007125\n\n<br>Auto Alert Team<br>Transworld </body></html>";
		
        
       
	          	               
	             		              
	 
		
		
		
	
    } 
    catch (Exception e) 
    {
		e.printStackTrace();
	}
	finally {conn1.close();}
%>

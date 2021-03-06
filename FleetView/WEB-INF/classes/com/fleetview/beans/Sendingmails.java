package com.fleetview.beans;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Sendingmails
 */
public class Sendingmails extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Sendingmails() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.setContentType("text/html");
	      //  PrintWriter out = response.getWriter();
	        String email=request.getParameter("user");
	        String securecode=request.getParameter("SecutiryCode");
	        try
	        {
	              Properties props = new Properties();
	              String host="smtp.transworld-compressor.com";
	              String protocol="smtp";
	              String user="report@mobile-eye.in"; 
	              String pass="transworld";
	              props.put("mail.smtp.starttls.enable","true");
	              props.put("mail.smtp.auth", "true");
	              props.put("mail.smtp.user", "user");
	              props.put("mail.smtp.password", "pass");  
	              props.put("mail.store.protocol", protocol);
	              props.put("mail.smtps.host", host);
	              java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
	              Session session = Session.getDefaultInstance(props, null);
	               // Construct the message
	               Message msg = new MimeMessage(session);
	               msg.setSubject("Security code for FleetView. This is a autogenerated mail please do not reply to it.");
	               msg.setSentDate(new Date());
	               Address add1=new InternetAddress(email,"");
	               msg.addRecipient(Message.RecipientType.TO,add1);
	               Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
	               msg.setFrom(fromAddress);
	               msg.setContent("Hello Sir/Mam,\n\n\t Your security code for User Name :-"+email+" on www.myfleetview.com is as follows, \n\n Security Code  :- "+securecode+" \n\n Please use this securuty code to login in case of improper LOG OUT. \n It  will log out your previous sessions and allow you to login again. \n\n Thanks and Regards, \n Transworld Team" ,"text/plain"); 
	               // Send the message
	               Transport t = session.getTransport("smtps");
	               msg.saveChanges(); // don't forget this
	               try
	               {
	            	  
	                    t.connect(host, user, pass);
	                    t.sendMessage(msg, msg.getAllRecipients());
	                    //out.print("Your message has been sent");
	               } 
	               catch(Exception e)
	               {
	                   System.out.print("Exception----->"+e);
	               } 
	               finally 
	               {
	                   t.close();
	               } 
	          
	               Transport.send(msg);

	               response.sendRedirect("SecurityCode.jsp?securecode="+securecode);
	               return;  

	       }
	        catch(Exception e)
	        {
	        	
	              //out.println("Sorry, your mail cannot be sent due to Congestion");
	        	 response.sendRedirect("SecurityCode.jsp?securecode="+securecode);
	              return; 
	 
	        }
	}

}

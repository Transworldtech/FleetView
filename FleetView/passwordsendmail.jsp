<%@page import="java.sql.Date"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<%@ include file="Connections/helpconn.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body></body>

<%
    ResultSet rs12=null,rs=null;
    String recorddate="",recordtime="",SystemName="",Website="",Logo1="",Logo2="",Signature="",fromLabel="",replyToMailid="",Disclaimer="";
    int Datedifference=0;
	try	
	{
		System.out.println("in jsp page=========================================");
        String EmailId=request.getParameter("EmailId");
        //System.out.println("email address==>"+EmailId);
        //email="k_gawande@transworld-compressor.com";
        //System.out.println("email   "+email);
        String Password=request.getParameter("Password");
       // System.out.println("password==>"+Password);
       String UserName=request.getParameter("UserName");
      // System.out.println("UserName==>"+UserName);
        try
        {
        	

        	getStatement=getDattabase.createStatement();
        	
        	String sqlinsert="";
        }catch(Exception e)
        {
        	System.out.println("exception"+e.getMessage());
        }
        	
              /* Properties props = new Properties();
              //String host="smtp.transworld-compressor.com";
              String host="a.mobileeye.in";
              String protocol="smtp";
              //String user="jd@mobile-eye.in"; 
              String user="jd@mobile-eye.in";
              String pass="transworld";
              props.put("mail.smtp.starttls.enable","true");
              props.put("mail.smtp.auth", "true");
              props.put("mail.smtp.user", "user");
              props.put("mail.smtp.password", "pass");  
              props.put("mail.store.protocol", protocol);
              props.put("mail.smtps.host", host);
              java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
              Session session1 = Session.getDefaultInstance(props, null);
             // System.out.println("step1");
               // Construct the message
               Message msg = new MimeMessage(session1);
               msg.setSubject("User Name And Password for FleetView");
               msg.setSentDate(new java.util.Date());
               Address add1=new InternetAddress(EmailId,"");
               msg.addRecipient(Message.RecipientType.TO,add1);
               Address fromAddress=new InternetAddress("jd@mobile-eye.in","transworld");  // in second "", it is short name
               msg.setFrom(fromAddress);
               
               //System.out.println("step2");
               
               msg.setContent("Hello Sir/Mam,\n\n\t Your Password for www.myfleetview.com is as follows, \n  Password :- "+Password+" \n\n Note :- Please Change your password After first login. \n\n\n\t Thanks and Regards, \n\t Transworld Team" ,"text/plain");  */
               // Send the message
             /* String mailbody="<html><body>Hello Sir/Mam,<br/> Your UserName and Password for www.myfleetview.com is as follows,<br> UserName :- "+UserName+" <br> Password :- "+Password+"  <br/> Note :- Please Change your password After first login. <br/> Thanks and Regards,  <br/> Transworld Team</body></html>";
              String subject="User Password for FleetView";  */
               
               /* Transport t = session1.getTransport("smtps");
               msg.saveChanges(); */
               
            	  // System.out.println("step3");
            	   
            	  // t.connect(host, user, pass);
                  //  t.sendMessage(msg, msg.getAllRecipients());
                  
         try
	       {
		
		String getEmailDetails="select * from t_EmailReportSettings	where System='myfleetview' ";
		 rs=getStatement.executeQuery(getEmailDetails);
		
		while(rs.next())
		{
			 SystemName=rs.getString("System");
			 Website=rs.getString("Website");
			 Logo1=rs.getString("Logo1");
			 Logo2=rs.getString("Logo2");
			 Signature=rs.getString("Signature");
			 fromLabel=rs.getString("fromLabel");
			 replyToMailid=rs.getString("replyToMailid");
			 Disclaimer=rs.getString("Disclaimer");
			
		}
		
	}catch(Exception e)
	{
		System.out.println("Exception "+e.getMessage());
	}
		
		
		try
	        {		java.util.Date date = new java.util.Date();
					
			        DateFormat df = new SimpleDateFormat("dd-MMM-yyyy hh:mm");
			        String date3 = df.format(date); 
			        
	        			  			  		
                    String mailbody="<td align = left> Hello Sir/Mam, <div> <br/> Your UserName and Password for www.myfleetview.com is as follows,<br/><br/> UserName :- "+UserName+" <br/> Password :- "+Password+"  <br/> <br/> Note :- Please Change your password After first login. <br/> Thanks and Regards,  <br/> Transworld Team </div> </td>";
                    String subject="User Password for FleetView"; 
			 					        
			        //Mail Format
			        String html = "<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
	 						"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
	 						"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
	 						"<img src="+Logo1+" style=^height: 80px; width: 100px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
	 						"<img src="+Logo2+"  style=^height: 80px; width: 400px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
	 						"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
	 						" <u><a href=http://"+Website+"></u>"+Website+"</a>  "+ df.format(new java.util.Date()) +"  <br> </font><br><table><tr><td align = center style = ^margin-left:20px;^>";
			        
			        html = html + mailbody +"</body></html>";
			        
			        
			         // System.out.println("before the insert query of allpending mail table ");
			          DateFormat dateFormat1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	                  Calendar cal1 = Calendar.getInstance();             
	                  String dt1=dateFormat1.format(cal1.getTime());
	                           
	                           		  
	                 //System.out.println("dt1==>"+dt1);
	                                   
	                       String sqlinsert="insert into t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,MailStatus,SenderName,EntryDateTime) values ('Transworld Username and password','"+"-"+"','"+html+"','"+subject+"','"+EmailId+"','','Pending','avlsupport@mobile-eye.in','"+dt1+"')";
	                       int num=getStatement.executeUpdate(sqlinsert);
	                       
						  
						  // System.out.println("insert query :- "+sqlinsert);	
						   
						   //System.out.println("inserted successfully");					  
						             		 
	                  		if(num>0)
	                  		{ 
	                  			out.println("Success");
	                  		    String sql="update t_security set Password='"+Password+"' where Username='"+UserName+"' ";
	                  			//System.out.println("securityupdate----------->  "+sql);
	                  			getStatement.executeUpdate(sql);
	                  			java.util.Date now=new java.util.Date();
	                  			String currdate=new SimpleDateFormat("yyyy-MM-dd").format(now);
	                  			String currtime=new SimpleDateFormat("HH:mm:ss").format(now);
	                  			String sql12="select datediff(curdate(),RecordDate) as Datedifference,recorddate,recordtime from db_gps.t_loguseractivity where Comments='"+ UserName +"' order by  RecordDate desc limit 1";
	                	        //System.out.println("sql12:-->"+sql12);
	                	        rs12=getStatement.executeQuery(sql12);
	                	        if(rs12.next())
	                	        {
	                	        	//query
	                	        	 Datedifference=rs12.getInt("Datedifference");
	                	        	 recorddate=rs12.getString("recorddate");
	                	        	 recordtime=rs12.getString("recordtime");
	                	        	// System.out.println("Datedifference:-->"+Datedifference);
	                	        	// System.out.println("recorddate:-->"+recorddate);
	                	        	// System.out.println("recordtime:-->"+recordtime);
	                	        	           
	                	        }
	                  			String sql1="update db_gps.t_loguseractivity set RecordDate='"+currdate+"',RecordTime='"+currtime+"' where RecordDate='"+recorddate+"' and RecordTime='"+recordtime+"'";
	                  			//System.out.println("sql1----------->  "+sql1);
	                  			getStatement.executeUpdate(sql1);
	                  	 	}
	                  		else
	                  		{
	                  			out.println("<html><body>Exception</body></html>");
	                  		}	
	                  
	              	                    
		            		 	    
			 	   }  
	       catch(Exception e)
	       {
	    	   e.printStackTrace();
	       }
                  
                         
               
			    // out.print("Yes");
               //response.sendRedirect("mainpage.jsp?inserted=yes&ordrrno="+ordrrno);
               //return;  
               
               
       }
        catch(Exception e)
        {
        	
        	System.out.println("exception******* "+e.getMessage());
        	e.printStackTrace();
           // out.print("Your message is not sent");
 
        }
  %>
</html>
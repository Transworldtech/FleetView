<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<%@ include file="Connections/conn.jsp" %>
<%! 
Connection con1, con2;
%>

<html>

<body>
   
  
     <%
try
{ 
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	Statement stmt=con2.createStatement(),stmt1=con2.createStatement(), stmt2=con2.createStatement(),stmtinsert=con2.createStatement();
	Statement strepre,stadmin;
	strepre=con2.createStatement();
    stadmin=con2.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null;
	String sql="", sql1="", sql2="", sql3="";
	String tm="";
	int vcode=0;
	int vcode1;
   int i=0;
	java.util.Date td =new java.util.Date();
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	String sdt = fmt.format(td);
	
	 String OwnerName=request.getParameter("owner1").trim();
	 String vehcles=request.getParameter("vehcles1");
	 System.out.println(vehcles );
	 String grp=request.getParameter("gadd1").trim();
	   String username=session.getAttribute("user").toString();	
	 if(vehcles.startsWith(",")){
		 vehcles=vehcles.substring(1,vehcles.length());
	 }
	 StringTokenizer str=new StringTokenizer(vehcles,",");
	 int tokencount=str.countTokens();
	 while(str.hasMoreTokens()){
		String vehicleRegNumber=str.nextToken();
		System.out.println("vehicleRegNumber====================>"+vehicleRegNumber);
		 sql="select VehicleCode from db_gps.t_vehicledetails where VehicleRegNumber like '%"+vehicleRegNumber.trim()+"%'";
		 
		 rs1=stmt.executeQuery(sql);
		 if(rs1.next())
		 {
			vcode=rs1.getInt("VehicleCode");
			
		 }
		 
		 //vcode=Integer.parseInt("vcode1");
			
		 sql1="select * from db_gps.t_group where GPName='"+grp+"' and VehCode="+vcode+"";
		 System.out.println(sql1);
		 rs2=stmt1.executeQuery(sql1);
		 if(rs2.next())
		 {
			 System.out.println("group is aleready exists");
		 }
		 else
		 {
			 sql2="insert into db_gps.t_group (GPName,VehRegno,transporter,VehCode,SepReport,Active,LastTripDate,EntryBy)values('"+grp+"','"+OwnerName+"','"+vehicleRegNumber.trim()+"',"+vcode+",'Yes','Yes','"+sdt+"','"+username+"')";
			//Query for t_sqlquery
				String abcd=sql2.replace("'","#");	
				abcd=abcd.replace(",","$");								
				stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
				System.out.println("group is inserted"+sql2);
			  stmt2.executeUpdate(sql2);
			  if("Castrol".equalsIgnoreCase(grp)||grp.equalsIgnoreCase("Castrol")){
				  String sqlrepre="select * from db_CustomerComplaints.t_asgndtranstoreps where Transporter='"+OwnerName+"'";
			  		String RepresentativeMailID="",MailID="";
			  		ResultSet rsrepre=strepre.executeQuery(sqlrepre);
					if(rsrepre.next()){
						String representative=rsrepre.getString("Representative");
						String sqladmin="select * from db_CustomerComplaints.t_admin where Name='"+representative+"'";
						ResultSet rsadmin=stadmin.executeQuery(sqladmin);
						if(rsadmin.next()){
							RepresentativeMailID=rsadmin.getString("Email");
						}
					}
					String sqladmin="select * from db_CustomerComplaints.t_admin where Name='"+username+"'";
					ResultSet rsadmin=stadmin.executeQuery(sqladmin);
					if(rsadmin.next()){
						MailID=rsadmin.getString("Email");
					}
			    	try{
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
			            Session session1 = Session.getDefaultInstance(props, null);
			             // Construct the message
			             Message msg = new MimeMessage(session1);
			             msg.setSubject("Vehicle:"+vehicleRegNumber+" is added to Castrol group and Transporter is "+OwnerName);
			             msg.setSentDate(new java.util.Date());
			            // Address add1=new InternetAddress(email,email2);
			       //     	System.out.println("stp1"+chkdcntr1);
			          			  //  mail id-------------
			             
			          	      Address recipientAddrs[] = new InternetAddress[1];
			          		  recipientAddrs[0] = new InternetAddress("s_shinde@transworld-compressor.com");
			          		
			    		      Address recipientAddrs1[] = new InternetAddress[3];
			                 recipientAddrs1[0] = new InternetAddress("a_laddha@myfleetview.com");
			                 recipientAddrs1[1] = new InternetAddress(RepresentativeMailID);
			          		 recipientAddrs1[2] = new InternetAddress(MailID);
			             msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
			           // msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
			             Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
			          	System.out.println("stp4");
			             msg.setFrom(fromAddress);
			          	System.out.println("stp5");
			       String body="Sir, <br>Vehicle:"+vehicleRegNumber+" is added to Castrol group<br>"+
			       "<html><body><table align=center  cellpadding=0 cellspacing=0 width=100% border=1><tr BGCOLOR=#99CCFF>"+
			       "<td>Vehicle Reg No:</td><td>Transporter"+
			       "</td><td>Removed By</td></tr><tr><td>"+vehicleRegNumber+"</td><td>"+OwnerName+"</td><td>"+username+"</td></tr><br></table></body></html>";
			       System.out.println(body);
			             msg.setContent(body,"text/html; charset=ISO-8859-1"); 
			             // Send the message
			             Transport t = session1.getTransport("smtps");
			             msg.saveChanges(); // don't forget this
			          	System.out.println("stp6");
			           
			             try
			             {
			         	 	System.out.println("stp7");
			                  t.connect(host, user, pass);
			             	System.out.println("stp8");
			                  t.sendMessage(msg, msg.getAllRecipients());
			                  System.out.println("stp8");
			             }
			             catch(Exception e)
			             {
			                 System.out.print("Exception----->"+e);
			                
			             } 
			             finally 
			             {
			                 t.close();
			             } 
			        		try{
			        			 Transport.send(msg);
			        		}catch(Exception e){
			        			
			        		}
			    }catch(Exception e){
			    e.printStackTrace();
			    }

			  }
	 }
	 
	
		
	 }
	
    

	 	 
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	con1.close();
	con2.close();
	 response.sendRedirect("addEditGroup.jsp");
}
%>


</body>
</html>

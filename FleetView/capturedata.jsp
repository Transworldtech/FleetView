<%@ page language="java"%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator"%>
   <%@ page import="java.io.*"%>
   <%@ page import="java.util.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="javax.mail.*" import="java.util.Properties" import="javax.mail.internet.InternetAddress" import="javax.mail.internet.MimeMessage"%>
   <%@ page import="javax.servlet.http.HttpServletRequest" import="javax.mail.internet.MimeBodyPart" import="javax.mail.internet.MimeMultipart"%>
   <%@ page import="javax.servlet.http.HttpSession" %>
   <%@ page import="org.apache.commons.fileupload.FileItem" %>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
   <%@ page import="javax.activation.*" %>
   
   <%!
Connection conn,conn1;
Statement st,st1,st2,st3,st4,stQuickTest;
String data,data1;
String sql,sql1,sql2,sql3,sql4;
%>
   
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>

<body onload="window.opener.location.reload();setTimeout('self.close()',5);"> 
<%
try{
	String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://192.168.2.55/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://192.168.2.55/db_gpsExceptions";
	String MM_dbConn_STRING3="jdbc:mysql://192.168.2.55/db_CustomerComplaints";
	String SiteRoot="http://192.168.2.55:8080/AVL/";
	
	
	
	
	
	System.out.println("Creating Connection");
	Class.forName(MM_dbConn_DRIVER);
   // conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    st=conn1.createStatement();
	st1=conn1.createStatement();
    st2=conn1.createStatement();
    st3=conn1.createStatement();
    st4=conn1.createStatement();
	
	
}catch(Exception e)
{
	e.printStackTrace();
	
}







String Name="",Address="",City="",today="",Zip="",email="",ContactPerson= "",yes ="",PhoneNo="",Mobile="",website="",country="",Make="",Industry="",Comments="";
System.out.println("==============");
out.println("==============");
//yes=request.getParameter("inserted");
Name=request.getParameter("Name");
Address=request.getParameter("Address");
City=request.getParameter("City");
Zip=request.getParameter("Zip");
email=request.getParameter("email");
ContactPerson=request.getParameter("ContactPerson");
PhoneNo=request.getParameter("PhoneNo");
Mobile=request.getParameter("Mobile");
website=request.getParameter("website");
country=request.getParameter("country");
Make=request.getParameter("Make");
Industry=request.getParameter("Industry");
Comments=request.getParameter("Comments");

java.util.Date defoultdate = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
today = formatter.format(defoultdate);




System.out.println("=====today========="+today);


System.out.println("=====Name========="+Name);
System.out.println("======Address========"+Address);
System.out.println("======City========"+City);
System.out.println("======Zip========"+Zip);
System.out.println("===email==========="+email);
System.out.println("===ContactPerson==========="+ContactPerson);
System.out.println("===PhoneNo==========="+PhoneNo);
System.out.println("===Mobile==========="+Mobile);
System.out.println("===website==========="+website);
System.out.println("===country==========="+country);
System.out.println("===Make==========="+Make);
System.out.println("===Industry==========="+Industry);
System.out.println("===Comments==========="+Comments);












//String dateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format( new java.util.Date());

String sqlHistory ="";
//String emailnew=session.getAttribute("email").toString();

//out.println(incdtCmt+"=============="+permanentSol);
try
{
	
	
	//String empName=session.getAttribute("empname").toString();
	//String empName=session.getAttribute("username").toString();
	
	//Statement st=conn1.createStatement();	
	System.out.println("===BEFORE SQL QUERY 1===========");
//	String sql="update t_incidentdata set updateComment='"+incdtCmt+"', permntSolution='"+permanentSol+"', Status='"+incdntStat+"' where complaintid='"+complaintid+"'";
	 int i; 
    
	
    //System.out.println("@@@@@@@@@@@@"+sql);
	//st.executeUpdate(sql);
	
	System.out.println("===AFTER SQL QUERY 2===========");
	//System.out.println("@@@@@@@@@@@@"+sql);
	//====Complaint History=============================================
	
	
	//=================================================================
	//*********************************************************************************
		      	
	
			//response.sendRedirect("incidentUpdateWindow.jsp?inserted1="+yes);
	
try
	{
		
		
				
		
	 
		
		/**
		String sqlMail="select a.EscSysAdmin,a.Category,b.Empemail as systMail,a.EscHOD, c.Empemail as hodMail from "+ 
			"t_incidentescalation as a "+
			"inner join( "+
			"SELECT * FROM t_employee) b "+ 
			"on(b.EmpID=a.EscSysAdmin) "+
			"left outer join( "+
			"select * from t_employee)c "+
			"on(c.EmpID=a.EscHOD) "+
			"where a.Category='"+category+"'";
		System.out.println(sqlMail);
		ResultSet rsMail=st.executeQuery(sqlMail);
		
		if(rsMail.next())
		{
			systAdmin=rsMail.getString("systMail");
			systHod=rsMail.getString("hodMail");
		}
		System.out.println(systAdmin+"##################"+systHod+"#########"+regMail);
		**/
		String DAta="",body="",sql="";		//+++++Send Mail+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		String MailName ="FleetView Enquiry Form",subjectline="Enquiry Form for FleetView ",Toid="sales@transworld-compressor.com ",Tocc=" r_maner@transworld-compressor.com",MailStatus="Pending",SenderName="FleetView Enquiry",Entrydatetime="";						
	       						// boolean flag=false;
		                            
                          		
		
							        try
							       {
							        	 body="<html><head></head><body>The details for New  autogenerated Enquiry  form for FleetView are  as follows,<br><br> "
										 +"<br></br><div style=width:40%; margin-left: 5%;><table align=left border=1 cellpadding=0 cellspacing=0 width=50% style=background: white;><tr><td  valign=top><font size=3 face=Arial><b>Name of the customer </b></td><td   >"+""
				                         +Name+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Address </b></td><td  >"+""
				                         +Address+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>City </b></td><td  >"+""
				                         +City+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Pin </b></td><td  >"+""
				                         +Zip+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Email Address </b></td><td  >"+""
				                         +email+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Contact Person </b></td><td  >"+""
				                         +ContactPerson+"</font></td></tr><tr><td width= valign=top><font size=3 face=Arial><b>Contact No. </b></td><td  >"+""
				                         +PhoneNo+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Mobile number </b></td><td  >"+""
				                         +Mobile+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Website </b></td><td  >"+""
				                         +website+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>No. of vehicles</b></td><td  >"+""
				                         +country+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Make and Model of Vehicles </b></td><td  >"+""
				                         +Make+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Industry type  </b></td><td  >"+""
				                         +Industry+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Additional comments </b></td><td  >"+""
				                         +Make+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Entry DateTime </b></td><td  >"+""
				                         +today+"</font></td></tr><tr><td  valign=top><font size=3 face=Arial><b>Industry type </b></td><td  >"+""
				                         +Comments+"</font></td></tr></table></div><br><br></div>"
				                         +"<div style=width:100%; float:left;>Regards,<br>Transworld Support Team.<br>"
				                         +"Phone: 9120 41214444 <br>Email:  avlsupport@Mobile-Eye.in </div></body></html>";
						
				                         System.out.println(">>>>UP TO HERE>>>>");
                                                      
				                         try{
								            sql ="Insert into db_gps.t_allpendingmailtable (MailName ,Description ,MailBody,subjectline,Toid,Tocc,MailStatus,SenderName ,EntryDateTime)  values ('"+MailName+"', '-', '"+body+"','"+subjectline+"','"+Toid+"','"+Tocc+"','"+MailStatus+"','"+SenderName+"','"+today+"' )  ";
								              
								           st1.executeUpdate(sql);
				                         }catch(Exception e)
				                         {
				                        	 
				                        	 e.printStackTrace();
				                        	 System.out.println(">>>>Exception>>>>"+e);
				                        	 
				                         }
								           System.out.println(">>>>sql>>>>"+sql);
								           
								               // Construct the message
								             
								               
								              // Address recipientAddrs1[];
								           /**
								                if(emailnew.length()>1)
								             	{
							            		   System.out.println("-");
							            		   recipientAddrs1 = new InternetAddress[tokens1.length+2];
								             	}
							            	   else
							            	   {
							            		   System.out.println("not -");
							             	  recipientAddrs1 = new InternetAddress[2];
							            	   }
								               
								             **/  								               							               							               							               
								               							               
								               
								               
								            	  
								            	
								            	 
								           
											  
									             //  recipientAddrs1[0] = new InternetAddress("avlsupport@mobile-eye.in");
									               // recipientAddrs1[1] = new InternetAddress("p_khedkar@transworld-compressor.com");
									               
									               
									            
									          
									              
									           //System.out.println(">>>>BODY>>>>"+body);
									              // System.out.println("%%%%%emailnew%%%%%%"+emailnew);
									               
								              // msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
								              //msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
								         //   	System.out.println("stp3");
								              // Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
								         //   	System.out.println("stp4");
								              
									            
						
										          // Part two is attachment
										   ///       messageBodyPart = new MimeBodyPart();
		              
		              	
		              // Put parts in message
		            
								              
								          		
							
                              }
							
							// end of inner try
	       catch(Exception e)
	       {
	               System.out.println("Sorry, your mail cannot be sent due to Congestion----->"+e);
	               e.printStackTrace();
	       }
	    	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                	
	    	
	     
	    	
	    	
	}
	catch(Exception e)
	{
		System.out.println("Exception Mail Send=====>>"+e);
	} 
	
	
	 response.sendRedirect("index.html"); 	
	 //return;
	
	
	//*********************************************************************************
}
catch(Exception e)
{
	System.out.println("Exception Incident DAta Insert=====>>"+e);
}
%>

</body>

</html>

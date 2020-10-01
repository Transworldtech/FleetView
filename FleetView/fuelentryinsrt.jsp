<%@ include file="Connections/conn.jsp"%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page buffer="16kb"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.*"%>
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
Connection con1;
%>
<!--<script type="text/javascript"> alert("in the fuelentryinsrt.jsp page");</script>-->
<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(),stmt=con1.createStatement(),stmt5=con1.createStatement();
Statement stquery=con1.createStatement() ,st5=con1.createStatement();
String sql1="";
boolean flag=true;
boolean flag1=false;
boolean flag2=false;
String vehno="", date="", time1="", time2="", driver="",time="", litres="", petpump="",checkVal="",odometer="",remark="-",amount="",reset="";
String vehicleRegistrationNumber="",vehicleCode="";
String dateTime1="";
String dateTime2="";
DateFormat formatter;
String datetime="";
String user=session.getAttribute("usertypevalue").toString();
String entby=session.getAttribute("dispalyname").toString();
java.util.Date lastOdometerDate = null;
java.util.Date nextOdometerDate = null;
float lastOdometerReading=0;
float nextOdometerReading=99999999;
String lastOdometerReading1="-";
String nextOdometerReading1="-";
/* *********** get all the fields from the form ************* */
vehno=request.getParameter("vehs");
System.out.println(vehno);
StringTokenizer stk = new StringTokenizer(vehno,",");
vehicleRegistrationNumber=stk.nextToken();	
vehicleCode=stk.nextToken();
Boolean innerflag=false;
System.out.println(vehno);
System.out.println(vehicleCode+"---"+vehicleRegistrationNumber);
date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fueldate")));
time1=request.getParameter("fueltime1");
time2=request.getParameter("fueltime2");
driver=request.getParameter("drivers");
System.out.println("\n\n driverrrr===>"+driver);
litres=request.getParameter("lits");
amount=request.getParameter("amount");
petpump=request.getParameter("petpump");
checkVal=request.getParameter("fulltank");
odometer=request.getParameter("odometer");
reset=request.getParameter("Reset");

System.out.println("resetresetresetresetresetresetresetresetresetresetreset--->"+reset);
float odometerReading=0;
System.out.println("odometer--->"+odometer);
int cnt=0,cnt1=0;



if(reset!=null || reset=="OdometerReset")
{
	
	
	
	String sql5="insert into t_fuelinfo (Transporter, VehNo, TheDateTime, Driver, Litres,amount, PetrolPump, EntBy,vehcode,FullTank,Odometer,Remark) values('"+user+"', '"+vehicleRegistrationNumber+"','"+date+" "+time+"','"+driver+"','"+litres+"','"+amount+"','"+petpump+"','"+entby+"','"+vehicleCode+"','"+checkVal+"','"+odometer+"','"+remark+"')";
	st5.executeUpdate(sql5);
	System.out.println("checked sql5===>"+sql5);
	
	
	
	String sqlinsert5="insert into t_odometerdetails (MailID,Transporter,vehicleregno,vehid,DateTime,Odometer)values('"+entby+"','"+user+"','"+vehicleRegistrationNumber+"','"+vehicleCode+"','"+date+" "+time+"','"+odometerReading+"')";
	stmt5.executeUpdate(sqlinsert5);
	System.out.println("checked sqlinsert5===>"+sqlinsert5);
	
	
	response.sendRedirect("AlertGoTo.jsp?msg=Inserted Successfully &goto=fuelentry.jsp");
	
 	

	
 	
	 
 	
	
	
}
else
{



if("-".equalsIgnoreCase(odometer)|| "".equalsIgnoreCase(odometer)){
 
}
else
	odometerReading=Float.parseFloat(odometer);
remark=request.getParameter("remark");
System.out.println("remark--->"+remark);
if(null==remark || "null".equalsIgnoreCase(remark) || "-".equalsIgnoreCase(remark)){
	remark="-";
}

 time=time1+":"+time2+":00";

datetime=date+" "+time;

formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.util.Date enteredDate=formatter.parse(datetime);
System.out.println("\n\n datetime===>"+datetime);
//System.out.println("\n\nentereddatetime===>"+);
System.out.println("\n\n odometerreading===>"+odometerReading);
String abcd="";



if(null==odometer || "null".equalsIgnoreCase(odometer)||"".equals(odometer))
{
	odometer="-";
	System.out.println("Insert wen odometer blank===>");
	sql1="insert into t_fuelinfo (Transporter, VehNo, TheDateTime, Driver, Litres,amount, PetrolPump, EntBy,vehcode,FullTank,Odometer,Remark) values('"+user+"', '"+vehicleRegistrationNumber+"','"+date+" "+time+"','"+driver+"','"+litres+"','"+amount+"','"+petpump+"','"+entby+"','"+vehicleCode+"','"+checkVal+"','"+odometer+"','"+remark+"')";
	System.out.println("sql1===>"+sql1);
	/*Query to insert query in db_gps.t_sqlquery table*/
	 abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	int i=stmt1.executeUpdate(sql1);
	response.sendRedirect("fuelentry.jsp?inserted=yes");
	return; 
}

else if(!odometer.equals("-"))
{
	System.out.println("b4 odometer===>"+odometer);

	//System.out.println("in if odometer===>"+odometer);
	int j=0;


//System.out.println("enteredDate===>"+enteredDate);

	
	String query="select * from db_gps.t_fuelinfo where VehNo='"+vehicleRegistrationNumber+"' and Odometer<> '-' and thedatetime<'"+datetime+"' order by  thedatetime desc limit 1";
	System.out.println("query===>"+query);
	ResultSet rs=stmt1.executeQuery(query);
	if(rs.next())
	{
		flag1=true;
	 	lastOdometerReading1=rs.getString("Odometer");
		System.out.println("lastOdometerReading===>"+lastOdometerReading1);
		if("-".equalsIgnoreCase(lastOdometerReading1)|| "".equalsIgnoreCase(lastOdometerReading1))
		{
		
			lastOdometerDate=null;
		}
		else
		{
			lastOdometerReading = Float.parseFloat(lastOdometerReading1);
			System.out.println("lastOdometerReading else===>"+lastOdometerReading);
			dateTime1=rs.getString("thedatetime");
			lastOdometerDate = formatter.parse(dateTime1); 
		
		}	
	
	}

	String query1="select * from db_gps.t_fuelinfo where VehNo='"+vehicleRegistrationNumber+"' and Odometer<> '-' and thedatetime>'"+datetime+"' order by thedatetime desc limit 1";
	System.out.println("query===>"+query1);
	ResultSet rs12=stmt1.executeQuery(query1);
	if(rs12.next())
	{
		flag2=true;
	 	nextOdometerReading1=rs12.getString("Odometer");
		System.out.println("nextOdometerReading===>"+nextOdometerReading1);
		if("-".equalsIgnoreCase(nextOdometerReading1) || "".equalsIgnoreCase(nextOdometerReading1))
		{
		
			nextOdometerDate=null;
		}
		else
		{
			nextOdometerReading = Float.parseFloat(nextOdometerReading1);
			System.out.println("nextOdometerReading else===>"+nextOdometerReading);
			dateTime2=rs12.getString("thedatetime");
			nextOdometerDate = formatter.parse(dateTime2); 
		
		}
	
	 }

	System.out.println("flag1===>"+flag1);
	System.out.println("flag2===>"+flag2);
	if(flag1==false && flag2==false)
	{
		lastOdometerDate=null;
		sql1="insert into t_fuelinfo (Transporter, VehNo, TheDateTime, Driver, Litres, amount,PetrolPump, EntBy,vehcode,FullTank,Odometer,Remark) values ('"+user+"', '"+vehicleRegistrationNumber+"','"+date+" "+time+"','"+driver+"','"+litres+"','"+amount+"','"+petpump+"','"+entby+"','"+vehicleCode+"','"+checkVal+"','"+odometerReading+"','"+remark+"')";
		System.out.println("Insert into fuel info===>"+sql1);
		/*Query to insert query in db_gps.t_sqlquery table*/
	 	abcd=sql1.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		int i=stmt1.executeUpdate(sql1);
		response.sendRedirect("fuelentry.jsp?inserted=yes");
		return; 
	}


	System.out.println("lastOdometerReading===>"+lastOdometerReading);
	System.out.println("odometerReading===>"+odometerReading);
	System.out.println("nextOdometerReading===>"+nextOdometerReading);
//System.out.println("lastOdometerReading1===>"+lastOdometerReading1);


//System.out.println("lastOdometerDate===>"+lastOdometerDate);
//j=(enteredDate.compareTo(lastOdometerDate));
//System.out.println("j===>"+j);
	System.out.println("flag===>"+flag);
	System.out.println("lastOdometerDate===>"+lastOdometerDate);
	System.out.println("enteredDate===>"+enteredDate);
	System.out.println("nextOdometerDate===>"+nextOdometerDate);



	if(null==lastOdometerDate || nextOdometerDate==null)
	{
		System.out.println("11===>");
		flag=true;
	}
	else if((enteredDate.compareTo(lastOdometerDate))<0)
	{
		System.out.println("12===>");
		flag=true;
	
	}
	else if((enteredDate.compareTo(nextOdometerDate))>0)
	{
		System.out.println("13===>");
		flag=true;
	
	}
	else
	{
		System.out.println("compare val===>"+enteredDate.compareTo(lastOdometerDate));
		System.out.println("14==>");
		flag=false;
	}
	//System.out.println("flag===>"+flag);

	
	
	
	
	
	

	//Commented on date 15th July for Castrol employees to enter previous daya data
	if(!odometer.equals("-") && ! lastOdometerReading1.equals("-"))
	{
		System.out.println("flag===>in-->>"+flag);
		System.out.println("15===>");
	
		if(odometerReading<lastOdometerReading || odometerReading>nextOdometerReading )
		{
			System.out.println("redirect===>");
			response.sendRedirect("fuelentry.jsp?lastOdometerReading="+lastOdometerReading+"&inserted=no");
		}

		else
		{
			System.out.println("16===>");
	
	//Commented on date 15th July for Castrol employees to enter previous daya data
			if(checkVal!=null && checkVal.equalsIgnoreCase("Yes"))
			{
				System.out.println("17===>");
				checkVal="Yes";
			}
			else
			{
				System.out.println("18===>");
				checkVal="No";
			}


			System.out.println("19===>");
			java.util.Date d12=new java.util.Date();  	
			Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			String now= frt2.format(d12);
			System.out.println("20===>");
/* ***************************************************************** */
			System.out.println("\n\nInsert===>inininin");
			sql1="insert into t_fuelinfo (Transporter, VehNo, TheDateTime, Driver, Litres,amount, PetrolPump, EntBy,vehcode,FullTank,Odometer,Remark) values ('"+user+"', '"+vehicleRegistrationNumber+"','"+date+" "+time+"','"+driver+"','"+litres+"','"+amount+"','"+petpump+"','"+entby+"','"+vehicleCode+"','"+checkVal+"','"+odometerReading+"','"+remark+"')";
			System.out.println("\n\nsql1===>"+sql1);
/*Query to insert query in db_gps.t_sqlquery table*/
 			abcd=sql1.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
/*****************************/

			System.out.println("In send mail===>");
			String Data="<html><body>"+"\n\n Mam/Sir, \n<br><br> Please find the Odometer Details Entry <br>"+"<table border="+1+"><tr><td><b>Date</b></td><td>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date+" "+time))+"</td></tr><tr><td><b>Vehicle</b></td><td>"+vehicleRegistrationNumber+"</td></tr><tr><td><b>Odometer</b></td><td>"+odometer+"</td></tr><tr><td><b>Entry By </b></td><td>"+entby+"</td></tr><tr><td><b>Remark</b></td><td>"+remark+"</td></tr></table>";
			
			String a_data = "<html>"+
			                "<head>"+
			                "<style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}"+
			                "</style> </head>"+
				            "<body>"+
			                "<table  border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^>"+
			                "<tr align=^center^>"+
			                "<td align=^left^ style=^border: 0px;^ width=^100%^>"+
					        "<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^>"+
					        "<tr>"+
					        "<td width=^100%^>"+
					        "<table width = ^97%^ >"+
					        "<tr>"+
					        "<td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
					        "<img src=^http://myfleetview.com/DiarySystem/images/mobile.jpg^ style=^height: 80px; width: 100px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a>"+
					        "</td><td  align = ^right^ >"+
					        "<img src=^http://myfleetview.com/FleetView/newimages/transworld.jpg^  style=^height: 80px; width: 400px;^ />"+
					        "</td></tr></table>"+ 
					        "<font style=^color: #D8D8D8^>"+
					        "________________________________________________________________________________________________________________________________________________</font><br>"+
					        "<div width = ^100%^><font size = ^3^ face = ^Arial^>"+
					        " <a href=^http://www.myfleetview.com^>www.myFleetView.com</a><br>"+"\nOdometer entry acknowledgment</font><br>"+
					        "<table width=^95%^><tr><td align = center style = ^margin-left:20px;^>"+
					        "<table width=100% > "+
					        "<tr>"+
					        "<td>"+
					        "<table align=left  cellpadding=10 cellspacing=5 width=100% border=1 style=^border-collapse: collapse;^>"+
					        "<tr bgcolor=^#ADDFFF^>"+
					        "<td align=center style=^width: 20%;^><font size=^2^ face=^arial^><b> Date </b></font></td>"+
					        "<td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b> Vehicle </b></font></td>"+
					        "<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Odometer </b></font></td>"+
					        "<td align=center style=^width: 25%;^><font size=^2^ face=^arial^><b> Entry By </b></font></td>"+
					        "<td align=center style=^width: 30%;^^><font size=^2^ face=^arial^><b> Remark </b></font></td>"+
					        "<tr>"+
					        "<tr>"+
					        "<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date+" "+time))+"</font></td>"+
					        "<td align=left><font size=^2^ face=^arial^>"+vehicleRegistrationNumber+"</font></td>"+
					        "<td align=right><font size=^2^ face=^arial^>"+odometer+"</font></td>"+
					        "<td align=left><font size=^2^ face=^arial^>"+entby+"</font></td>"+
					        "<td align=left><font size=^2^ face=^arial^>"+remark+"</font></td>"+
					        "</tr>"+
					        "</table>"+
					        "</td></tr>"+
					        "<tr>"+
					        "<td align = left>"+
					        "<table align= left><br></br>"+
					        "<tr>"+
					        "<td><font size=^3^ face=^Arial^>Transworld Support Team</font></td></tr>"+
					        "<tr>"+
					        "<td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr>"+
					        "<tr>"+
					        "<td><font size=^3^ face=^Arial^>Email: avlsupport@mobile-eye.in</font></td></tr>"+
					        "<tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Thanks and Regards</font></td></tr>"+
					        "<tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr></table></td></tr></table>"+
					        "</div></td></tr></table></td></tr></table></body></html>";
			
			
			//System.out.println("Ashutosh html data string:- "+a_data);
					        int i=stmt1.executeUpdate(sql1);
			System.out.println("\n\nsql1===>"+sql1);
			System.out.println("\n\n  i===>"+i);
			if(i>0)
			{
	
				innerflag=true;
				try
				{
		 			flag=false;
		 			if(innerflag==true)
		 			{
			
			 			System.out.println("__________________________________________________________________________");
			 			Properties props = new Properties();
				/*
            	// String host="a.mobileeye.in";
            	String host = "host.transworld.com";
            	 String protocol = "smtp";
             	  String user1 = "test";
             	  String pass = "transworld";
             		props.put("mail.smtp.starttls.enable", "true");
     				props.put("mail.smtp.auth", "false");
     				props.put("mail.smtp.user", "user1");
     				props.put("mail.smtp.password", "pass");
     				props.put("mail.store.protocol", protocol);
     				props.put("mail.smtps.host", host);
            		// props.put("mail.smtps.host", "25");
            		
            		*/
            		
            		
            		
          			String host="a.mobileeye.in"; //host  name
		            
		             	String protocol="smtp";
		       
		        ////     String user="6746";
		             	String user1="9100";
		             
 					 	String pass="transworld";
 					 
 					 
		             	props.put("mail.smtp.starttls.enable","true");    ////false
		             	props.put("mail.smtp.auth", "true");
		             	props.put("mail.smtp.user", user1);  /////
		             	props.put("mail.smtp.password", pass);  /////
		             	props.put("mail.store.protocol", protocol);
		             	props.put("mail.smtp.host", host);
		             	props.put("mail.smtp.port", "25"); /////  25
            		
            			java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		              	Session session1 = Session.getDefaultInstance(props, null);
		               // Construct the message
		               System.out.println("**** &&&&  in mail2");
		               Message msg = new MimeMessage(session1);
		               msg.setSubject("Odometer Entry Details: "+date);
		               String subject = "Odometer Entry Details: "+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(date+" "+time)) ;
		               Address recipientAddrs[] = new InternetAddress[1];//to
		               System.out.println("recipient address :- "+recipientAddrs);
		               Address recipientAddrs1[] = new InternetAddress[1];//cc
		               System.out.println("recipient address1 :- "+recipientAddrs1);
		             	//recipientAddrs[0] = new InternetAddress(entby);
		             recipientAddrs[0] = new InternetAddress("h_kulkarni@transworld-compressor.com");
		               
		               recipientAddrs1[0] = new InternetAddress("jd@twphd.in");
		             //  recipientAddrs1[1] = new InternetAddress("p_khedkar@transworld-compressor.com");
		              // recipientAddrs1[1] = new InternetAddress("a_mahajan@transworld-compressor.com");
		               msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
		               msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
		               Address fromAddress=new InternetAddress("avlsupport@mobile-eye.in","Transworld"); // in second "", it is short name
		          
		               msg.setFrom(fromAddress);
		               // msg.setContent(Data+"<br><b>In case of any queries,kindly reply to mail id for assistance : avlsupport@mobile-eye.in</b>  <br> Thanks and Regards <br>Transworld Team "); 
		               String body = Data + "<br><b>In case of any queries,kindly reply to mail id for assistance : avlsupport@mobile-eye.in</b>  <br> Thanks and Regards <br>Transworld Team ";
		               // Send the message
		               
		               Transport t = session1.getTransport("smtp");
             		   msg.saveChanges(); // don't forget this
		               
             		   //insert the email in the allpendingmailtable
             		   String sqlinsert="insert into t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,MailStatus,SenderName,EntryDateTime)values('Odometer entry details','"+"-"+"','"+a_data+"','"+subject+"','"+entby+"','jd@twphd.in','Pending','avlsupport@mobile-eye.in','"+datetime+"')";
					   stmt.executeUpdate(sqlinsert);
					   System.out.println("insert query :- "+sqlinsert);	
					   System.out.println("inserted successfully");					  
             		 
             	/*	   try
		               {
		            	   System.out.println("**** &&&&  in mail3");
		                    t.connect(host, user1, pass);
		                    System.out.println("**** &&&&  in mail4");
		                    t.sendMessage(msg, msg.getAllRecipients());
		                    System.out.println("**** &&&&  in mail5");
		                    flag=true;
		                    System.out.println("Your message has been sent");
		                    System.out.println("__________________________________________________________________________");
		               }
		               catch(Exception e)
		               {
		                   System.out.print("Exception----->"+e);
		                   System.out.println("1__________________________________________________________________________");
		               } 
		               finally 
		               {
		                   t.close();
		               } */ 
		          		
		        //       Transport.send(msg);
		               //t.send(msg);//this command sends the mail to the id mentioned in to.
		          	               
		             		              
		 			}//if innerflag
		       
				}catch(Exception e)
				{
				   System.out.println("exception occured :- "+e);		
				}
	String sqlinsert="insert into t_odometerdetails (MailID,Transporter,vehicleregno,vehid,DateTime,Odometer)values('"+entby+"','"+user+"','"+vehicleRegistrationNumber+"','"+vehicleCode+"','"+date+" "+time+"','"+odometerReading+"')";
	stmt.executeUpdate(sqlinsert);
	//System.out.println("in the insert into t_odometerdetails and the mail id passed to the insert query is:- "+entby) ;
	response.sendRedirect("fuelentry.jsp?inserted=yes");
	return; 
	}
}
}
}//commented if for last odometer<current
}
}catch(Exception e) { e.printStackTrace(); }
finally
{
	try{
		con1.close();
	}catch(Exception e)
	{}
} 
%>
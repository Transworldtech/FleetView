<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	<table>
<tr>
<td align="left">	
					<a href="http://www.mobile-eye.in" target="_blank"><img src="images/TW-MobileEyeLogo1.PNG" style="height: 50px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
</td>
</tr>
<tr>
<td><%@ include file="headerpopup.jsp"%>
</td></tr>
</table> 
  	<%
  	String fname=(String)session.getAttribute("fname");
  	String lname=(String)session.getAttribute("lname");
  	String username=(String)session.getAttribute("mainuser");
  	//String transporter = (String)session.getAttribute("usertypevaluemain");
	String transporter = (String)session.getAttribute("TYPEVALUEUSER");
  //	String email=(String)session.getAttribute("email");
  	%> 
  
<%!

Connection conn,con;
static int html=1;
static int saveflag=1;static int saveflag1=1;
static int nameflag=1;
 int count=1;
%>

<html><head></head>

<script type="text/javascript">

function closewindow()
{
	window.close();
}

</script>
<body style="background-color: #F5F5F5">

<%
int Msg=1;
String ReportName="-",Description="-",Entby="-",Name="-",EmailID="-",Email1="-",FileName="-",Category="-",name1="";
String Priority="-",ClosingComments="-",ClosedBy="-",Status="-",comments="-",PageName="-",Email2="-",email="-";
String ComplaintDateTime,UpadteDateTime;
String ContactNumber="-";
Boolean innerflag=false;
double n;
int flag2=0;
Boolean flag=false,flag1=true;
Writer output = null;
String issue = "", report = "";
String randomnumber="";
File savedFile;
int count1 = 0, count2 = 0, filecount = 0, count4 = 0, count5 = 0,complaintID=0;
long m=0;
int sendmsg = 0;
String savefilestring="",savefilename="";
String[] filepath =new String[10];
String[] filename =new String[10];
String Mailstatus="";
boolean flag11 = false;


System.out.println("\n\n on complaint insert page");
PageName=request.getParameter("PageName");
System.out.println("@@@@@@@@@@ "+PageName);
ReportName=request.getParameter("ReportName");
Description=request.getParameter("desc");
Entby="-";
Name=fname+" "+lname;
EmailID="avlsupport@mobile-eye.in";
Email1=request.getParameter("EmailID");

ContactNumber=request.getParameter("Number");

FileName=request.getParameter("Filename");

Entby=session.getAttribute("user").toString();
System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+Entby);
//String usertypevalue=session.getAttribute("usertypevalue").toString();

String usertypevalue=session.getAttribute("TYPEVALUEUSER").toString();
System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+usertypevalue);
Category=request.getParameter("Category");
Priority=request.getParameter("Priority");
 ComplaintDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
 UpadteDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
ClosingComments="-";
ClosedBy="-";
Status="Pending";
String query="";
int complaintIDck=0; 		int maxid=0;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
System.out.println("\n\n ismultipart-->>"+isMultipart);
	if (!isMultipart)
	{
		System.out.println("\n\nin multipart..");
		flag11 = true;
	} 
	else {
		System.out.println("\n\n in else with  multipart..");
		FileItemFactory factory = new DiskFileItemFactory();
		//System.out.print("\n\nfactory==>"+factory);
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		//	System.out.print("\n\n items==>"+items);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
		Iterator itr1 = items.iterator();
	
		
		while (itr1.hasNext()) {
			FileItem item = (FileItem) itr1.next();
			if(item.isFormField()) 
			{
				String name = item.getFieldName();
				System.out.print("\n name==>"+name);
				String value = item.getString();
				System.out.print("\n value==>"+value);
				if(name.equals("ReportName")) 
				{
					ReportName = value;
					System.out.print("\nReport name==>"+ReportName);
					count1 = 1;
				}
				if(name.equals("desc")) 
				{
					Description = value;
					System.out.print("\n Description name==>"+Description);
					count1 = 1;
				}
				
				if(name.equals("Entby")) 
				{
					Entby = value;
					System.out.print("\n Entby name==>"+Entby);
					count1 = 1;
				}
				if(name.equals("UserName")) 
				{
					Name = value;
					//System.out.print("\n Name==>"+Name);
					count1 = 1;
				}
				if(name.equals("EmailID")) 
				{
					Email1 = value;
					//System.out.print("\nEmailID 1==>"+Email1);
					count1 = 1;
				}
				
				if(name.equals("Number")) 
				{
					ContactNumber = value;
					System.out.print("\n ContactNumber==>"+ContactNumber);
					count1 = 1;
				}
				if(name.equals("Category")) 
				{
					Category = value;
					//System.out.print("\n Category==>"+Category);
					count1 = 1;
				}
				if(name.equals("Priority")) 
				{
					Priority = value;
					//System.out.print("\n ContactNumber==>"+Priority);
					count1 = 1;
				}
				if(name.equals("PageName"))
				{
					PageName=value;
					count1=1;
				}
				if(name.equals("comments"))
				{
					comments=value;
					count1=1;
				}
				System.out.println("\n $$$$$$$$$$$$$ "+PageName);

			} else {
						try {

								String itemName = item.getName();
								System.out.print("\n\nitemName==>"+itemName);
								m=item.getSize();
								n=(m/1000);
								if(n>500)
								{
									flag1=false;
									System.out.println("############################################" +itemName);
									
									if(nameflag==1)
									{
										name1=""+itemName;
									// savefilestring=""+savedFile;
									 nameflag++;
									 System.out.println("\n\nscreenshot--->>>"+itemName);
									}
									else
										name1=name1+","+itemName;
									 //out.print("successfully saved the file");
									//File file = new File(savedFile);
									//String screenshot=savedFile.getAbsolutePath();
								System.out.println("\n\nscreenshot--->>>"+itemName);
									
									//flag2=0;
								//	Msg = 2;
								}
								
						    	
  							
					} catch (Exception e) {
	      					e.printStackTrace();
	      				}
  			}
  		}
		
		if(flag1)
		{
			flag2=1;
	while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if(item.isFormField()) 
			{
				
			} else {
						try {

								String itemName = item.getName();
								System.out.print("\n\nitemName==>"+itemName);
								if(itemName.equalsIgnoreCase(""))
								{
								}
								else
								{
								 savedFile = new File("/usr/share/tomcat6/webapps/TransworldDocs/complaints/fleetviewcomplaints/"+ComplaintDateTime+""+itemName);
								 //savedFile = new File("/home/s_dhole/test/"+ComplaintDateTime+""+itemName);

								System.out.print("\n\nsavedFile==>"+savedFile);
								item.write(savedFile);
								filepath[filecount]=""+savedFile;
								
								filename[filecount]=itemName;
								filecount++;
								if(saveflag==1)
								{
								
								savefilename=itemName;
								 saveflag++;

								}else{
									savefilename=savefilename+","+itemName;
									//saveflag++;

								}
								
								
								
								if(saveflag1==1)
								{
								 savefilestring=""+savedFile;
								 saveflag1++;
								}
								else{
									savefilestring=savefilestring+","+savedFile;
									//saveflag++;
								}
								 //out.print("successfully saved the file");
								//File file = new File(savedFile);
								String screenshot=savedFile.getAbsolutePath();
							System.out.println("\n\nscreenshot--->>>"+screenshot);
								}
						    	
  							
					} catch (Exception e) {
	      					e.printStackTrace();
	      					//response.sendRedirect("RegisterComplaint.jsp?desc="+Description+"&email="+Email1+"&Msg="+Msg+"&name="+name1+"&PageName1="+PageName+"&Number="+ContactNumber+"&Category="+Category+"&Priority="+Priority);

	      				}
  			}
  		}
		}
		else
		{
			flag2=2;
		}
  	}
	
	if(flag11 == false && savefilename != ""){
	//filename
	savefilename = savefilename.trim();
	if(savefilename.charAt(0) == ','){
		savefilename = savefilename.substring(1).trim();
	}
	
	//filepath
	if(savefilestring.charAt(0) == ','){
		savefilestring = savefilestring.substring(1).trim();
	}
	}
	
	
	
	
	System.out.println("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNnnnn    "+count);
	if(flag2==1)
			{
	if(null!=Description || null!=Category || null!=Priority)
	{
   try {
	  	    System.out.println("Hii");
			Class.forName(MM_dbConn_DRIVER);
			con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			Statement stmt=con.createStatement();
			Statement st=con.createStatement();
			if(null == ContactNumber || ContactNumber.length()==0)
			{
				System.out.println(ContactNumber);
				ContactNumber="-";
			}
			else
			{
				sendmsg++;
			}
			
			System.out.println("*****    "+sendmsg);
			
			if(null == Email1 || Email1.length()==0)
			{
				System.out.println(Email1);
				Email1="-";
			}
			
			String sql6="Select Email from db_gps.t_userdetails where FirstName like '"+fname+"' and LastName like '"+lname+"' and UserName like '"+username+"'";
			System.out.println(sql6);
			ResultSet rs6=st.executeQuery(sql6);
			if(rs6.next())
			{
				email=(String)rs6.getString("Email");
			}
			if(Email1.length()>1)
			{
		         Email2=email+","+Email1;
		         Email2=Email2.replace(",",", ");
			}
			else
			{
		  	     Email2=email;
			}
           

			String compidck="select ComplaintID from t_ComplaintDetail where ReportName='"+ReportName+"' AND Description='"+Description.replaceAll("'"," ")+"' AND EntBy='"+Name+"' AND Email1='"+Email2+"' AND ComplaintDateTime='"+ComplaintDateTime+"' AND ContactNumber='"+ContactNumber+"'";
			System.out.println(compidck);
			ResultSet rssck=stmt.executeQuery(compidck);
			if(rssck.next())
			{
				complaintIDck=rssck.getInt("ComplaintID");
				System.out.println("\n\n complaintID-->>"+complaintID);
			}
			
		String sqlmax="";
			
			sqlmax="select MAX(ComplaintID) as id from db_gps.t_ComplaintDetail limit 1";
			ResultSet rsmax=st.executeQuery(sqlmax);
			if(rsmax.next())
			{
				maxid=rsmax.getInt("id");
				System.out.println("\n\n maxid-->>"+maxid);

			}
			try{
		if(maxid != complaintIDck)	
		{
		    String sqlinsert="insert into t_ComplaintDetail(ReportName,Description,EntBy,Name,EmailID,Email1,ContactNumber,FileName,Category,Priority,ComplaintDateTime,ClosingComment,ClosedBy,Status,Website,PageName,Transporter,Filecomment) "+
			" values('"+ReportName+"','"+Description.replaceAll("'"," ")+"','"+Name+"','"+Name+"','"+EmailID+"','"+Email2+"','"+ContactNumber+"','"+savefilestring+"','"+Category+"','"+Priority+"','"+ComplaintDateTime+"','"+ClosingComments+"','"+ClosedBy+"','"+Status+"','FleetView','"+PageName+"','"+transporter+"','"+comments.replaceAll("'"," ")+"')";	
			
			System.out.println("\n\nquery sqlinsert-->>"+sqlinsert);
			
			
		  int i =0;
		    i=stmt.executeUpdate(sqlinsert);
			System.out.println("Successfully inserted");
			//System.out.println("\ni=>"+i);
			
			String sqlinsert1="insert into t_historyComplaintDetail(ReportName,Description,EntBy,Name,EmailID,Email1,ContactNumber,FileName,Category,Priority,ComplaintDateTime,ClosingComment,ClosedBy,Status,Website,PageName,Transporter,Filecomment) "+
			" values('"+ReportName+"','"+Description.replaceAll("'"," ")+"','"+Name+"','"+Name+"','"+EmailID+"','"+Email2+"','"+ContactNumber+"','"+savefilestring+"','"+Category+"','"+Priority+"','"+ComplaintDateTime+"','"+ClosingComments+"','"+ClosedBy+"','"+Status+"','Fleetview','"+PageName+"','"+transporter+"','"+comments.replaceAll("'"," ")+"')";	
			
			System.out.println("\n\nquery sqlinsert-->>"+sqlinsert1);
			//System.out.println("\n\nquery sqlinsert history table-->>"+sqlinsert1);
			
			
		  
			int k=stmt.executeUpdate(sqlinsert1);
			System.out.println("Successfully inserted");
			//System.out.println("\nk=>"+k);
			
			String datetimemail=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ComplaintDateTime));
			
			if(i>0)
			{
				//System.out.println("\n\n i-->>"+i);
				innerflag=true;
			}
			String compid="select ComplaintID from t_ComplaintDetail where ReportName='"+ReportName+"' AND Description='"+Description.replaceAll("'"," ")+"' AND EntBy='"+Name+"' AND Email1='"+Email2+"' AND ComplaintDateTime='"+ComplaintDateTime+"' AND ContactNumber='"+ContactNumber+"'";
			System.out.println(compid);
			ResultSet rss=stmt.executeQuery(compid);
			if(rss.next())
			{
				complaintID=rss.getInt("ComplaintID");
				//Mailstatus=rss.getString("mailstatus");
				//System.out.println("\n\n complaintID-->>"+complaintID);
			}
			//System.out.println("\n\n Complaint ID-->>"+complaintID);
			
			
			
	
			String comdate=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ComplaintDateTime));
		
			String Data="<html><head><title>Mail Body</title></head><body><table border=^18^ bordercolor=^#E6E6FA^ align=^center^ width=^70%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^><table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><a href=^http://www.mobile-eye.in^ target=^_blank^><img src=^http://myfleetview.com/DiarySystem/images/mobile.jpg^ style=^height: 80px; width: 100px;^ title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a><br/><font style=^color: #D8D8D8^>_____________________________________________________________________________________________________________</font><body><br></br>"+Name+",<br><br>Thank you for contacting us. This is an automated response confirming the receipt of your complaint. One of our team members will get back to you as soon as possible. "
			 +"<br>For your records, the details of the complaint are listed below. When replying, please make sure that the complaint ID is copied in the subject line to ensure that your replies are tracked appropriately."
 			 +"<br></br><div style=^width:70%; margin-left: 5%;^><table align=^left^ border=^0^ cellpadding=^0^ cellspacing=^0^  style=^background: white;^ width=^100%^><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Complaint ID: </b></td><td>"+""
             +complaintID+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Description: </b></td><td width=^80%^>"+""
             +Description+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>File Comments: </b></td><td width=^80%^>"+""
             +comments+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Report Name: </b></td><td width=^80%^>"+""
             +ReportName+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Category: </b></td><td width=^80%^>"+""
             +Category+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Status: </b></td><td width=^80%^>"+""
             +"Pending </font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Priority: </b></td><td width=^80%^>"+""
             +Priority+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Call Me Back: </b></td><td width=^80%^>"+""
             +ContactNumber+"</font></td></tr><tr><td  valign=^top^><font size=^3^ face=^Arial^><b>Transporter: </b></td><td width=^80%^>"+""
             +transporter+"</font></td></tr></table></div><br><br></div>"
             +"<div style=^width:100%; float:left;^>Regards,<br>Transworld Support Team.<br>"
             +"Phone: 9120 41214444 <br>Email:  avlsupport@Mobile-Eye.in </div><font style=^color: #D8D8D8^>_____________________________________________________________________________________________________________</font><br/><br/><br/></td></tr></table></td></tr></table></body></html>";
       		
		
                         
                         String subjectstr="FleetView Complaint ID: "+complaintID+" , Received from  "+Name+""; 
			              String tocc="avlsupport@mobile-eye.in";
			                  
			         
                         
			if(i>0){
try{
				if(innerflag==true)
				 {
					
			           System.out.println("iFile Path is mail" +savefilestring);
			           System.out.println("Name is" +savefilename);

					
	              String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,AttachFilePath,FileName) values ('TWSupport','New Mail for Complaint Insert ','"+Data+"','"+subjectstr+"','"+Email2+"','"+tocc+"','"+ComplaintDateTime+"','Pending','Transworld','"+savefilestring+"','"+savefilename+"')";
	              System.out.println("q2All_PendingMail>>>> :"+q2);
	               st.executeUpdate(q2);        
               
		           System.out.println("inserted in all pending mail");
		           
		           
		           
		           
				 }	//For Inner Flag	
}catch(Exception e){e.printStackTrace();}
				if(sendmsg>0)
				{
					String sms = "";
					try
					{
						sms="New Comp No: "+complaintID+",By: "+Name+",Contact: "+ContactNumber+",Website: FleetView,Rep Name: "+ReportName+",Cat: "+Category+",Pri: "+Priority+"";
						sms=URLEncoder.encode(sms);
				        String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to=9404485566&message="+sms+"&gateway=regular";
				        System.out.println("now in send function"+sms);
				        URL url=new URL(smsurl);
						URLConnection connection = url.openConnection();
						connection.connect();
						BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
						String line;
						while ((line = in.readLine()) != null )
						{
							//System.out.println(line);

						}
					}
					 catch (Exception e) 
			    	{
						 System.out.println("***** Msg sending  Exception    "+e);
			    	}
			      
			    	
					
					System.out.println("Send message");
				}
				
				 }
					       
		}
			
			}catch(Exception e){
				
				
				e.printStackTrace();
			}

	

								%>
								<div
		                          style="background: #E6E6E6; font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em; color:red;width: 40%; margin-left: 18%"">
	                              <blink> Thank You for your support request.</blink> </div><br>
	                             <form name="incident" style="background: #F5F5F5;" method="get">
	                             <br></br>
								   <table align="center" border="0" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 18%;">
								   <tr>
								   <td><div align ="center"><font size="3"><b> Your Complaint ID :<%=complaintID %> </b></font></div></td></tr>
								   <tr></table><br></br>
								    <table align="center" border="1" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 18%;">
							        <tr>
								   <td width="15%"><font size="2" face="Arial"><b> User Name </b></font></td><td width="25%"><font size="2" face="Arial"><%=Name %></font></td></tr><tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Email Id </b></font></td><td width="25%"><font size="2"><%=Email1 %></font></td></tr>
								    
								    <tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Category </b></font></td><td width="25%"><font size="2" face="Arial"><%=Category %></font></td></tr><tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Website</b></font></td><td width="25%"><font size="2" face="Arial"> FleetView</font></td></tr><tr>
								   <td width="15%"><font size="2" face="Arial"><b> Priority </b></font></td><td width="25%"><font size="2" face="Arial"><%=Priority %></font></td></tr>  
								   <tr>
								   <td width="15%"><font size="2" face="Arial"> <b>Report Name </b></font></td><td width="25%"><font size="2" face="Arial"><%=ReportName %></font></td></tr><tr>
								    <td width="15%"><font size="2" face="Arial"><b>Call me back</b></font></td><td width="25%"><font size="2" face="Arial"><%=ContactNumber %></font></td></tr><tr>
								    <td width="15%" valign="top"><font size="2" face="Arial"> <b>Description </b></font></td><td width="25%"><font size="2" face="Arial"><%=Description %></font></td></tr>
								    								    <td width="15%" valign="top"><font size="2" face="Arial"> <b>File Comment </b></font></td><td width="25%"><font size="2" face="Arial"><%=comments %></font></td></tr>
								    
								  						
								</table><br>
								<table align="center" border="0" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 18%;">
								<tr>							
								   <td align="center">
								     <div align ="justify"><font size="2" color="green" face="Arial"><br></br><p>We will revert to you within 2 working days.<br>In case you need urgent assistance, <b>please note down your Complaint ID </b>and contact us on 020-41214444 or mail us on avlsupport@mobile-eye.in </p></font></div>
								   </td></tr></table><br>
								   
								   <table align="center" border="0" cellpadding=0 cellspacing=0 width="40%" style="background: #F5F5F5; margin-left: 18%;">
								<tr>		
								   <td valign="bottom" align="center" colspan="2">
			                           <div><input type="submit" id="OK"
				                       name="OK" value="OK"  onclick="window.close();"/></div>
			                      </td>
			                      </tr>
			                      </table>
								   <br>
								</form>
		<%
	//count++;
   }
   catch(Exception e)
   {
	  Msg = 1;
            e.printStackTrace();
            response.sendRedirect("RegisterComplaint.jsp?desc="+Description+"&email="+Email1+"&name="+name1+"&Msg="+Msg+"&PageName1="+PageName+"&Number="+ContactNumber+"&Category="+Category+"&Priority="+Priority);
            
   }
	}
			}
	else
	{
		 Msg = 2;
        response.sendRedirect("RegisterComplaint.jsp?desc="+Description+"&email="+Email1+"&name="+name1+"&Msg="+Msg+"&PageName1="+PageName+"&Number="+ContactNumber+"&Category="+Category+"&Priority="+Priority);

	}
		%>						
								</body>
								</html>
  							
     
  

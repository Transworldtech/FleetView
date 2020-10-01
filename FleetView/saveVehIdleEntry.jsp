
<%@ include file="headernew.jsp"%>

<%@ page  import="java.net.HttpURLConnection" %> 
<%@ page import="java.net.URL" %>
<%@ page  import="java.net.URLEncoder"%>
<%@ page  import="java.io.*"%>


<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<%! public static Connection con1; %>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(MM_dbConn_DRIVER);
	
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt7 = con1.createStatement();
	
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
%>

<%!
	public static void sendMessage(String msg,String mobno)
	{
		
		String msgid=null, smsurl="";
		 
		  try
	      {
			  	String sms = msg.trim();
	            
			  	String numbers = mobno; 	            
	           	try
	            {
			  		String sqlsms="select Url from db_gps.t_SmsGatewayUrl";
			  		Statement stmt3= con1.createStatement();
			  		ResultSet rst =stmt3.executeQuery(sqlsms);
	                System.out.println("sqlsms...  "+sqlsms);
	                 if (rst.next())
	                 {
	                   smsurl = rst.getString("Url");
	                 }
					
	                
	                
	            }
	            catch(Exception e)
	            {
	                System.out.println("Exception in READING SMS...  "+e);
	                
	            }
	                    
	            System.out.println("smsurl==>"+smsurl);
	            System.out.println("NUMBERS NUMBERS ==>"+numbers);
	            
	            try
	            {
	            	sms=URLEncoder.encode(sms,"UTF-8");
	            	smsurl=smsurl.replaceAll("\\+", "");
	            	smsurl=smsurl.replaceAll("numbers",numbers);
	            	smsurl=smsurl.replaceAll("sms",sms);
	            	smsurl=smsurl.replaceAll("\"","");
	            	smsurl=smsurl.replaceAll(" ","+");
	            
	            }catch(Exception e)
	            {
	                System.out.println("Exception  in  parsing SMS URl==>"+e);    
	                
	            }
	            
	            
	            System.out.println("FINAL  SMS URL==>"+smsurl);
	            
	            
	            sms=sms.replace("'", " ");
	            sms=sms.replace(";", " ");
	            sms=sms.replace("&", " ");
	            sms=sms.replace("@", " ");
	            sms=sms.replace("<>", " ");
	            sms=sms.replace("[", " ");
	            sms=sms.replace("]", " ");
	            sms=URLEncoder.encode(sms,"UTF-8");
	            //smsurl=smsurl.replaceAll("sms",sms);

	            System.out.println("the sms is :- "+sms);
	            System.out.println("and msg is  :- "+msg);
	           
	            System.out.println("smsurl FINAL 1212212==>"+smsurl);
	            
	            try{
	            
	              
	            URL url=new URL(smsurl);
	             
	            HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
	            
	          
	            //String cookie = urlconnection.getHeaderField("Set-Cookie");  
	            urlconnection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");  
	            urlconnection.setRequestProperty("Accept", "*/*");  
	            //urlconnection.setRequestProperty("Cookie", cookie);  
	            urlconnection.setRequestMethod("GET");  
	           
	            urlconnection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
	            urlconnection.setDoOutput(true);
	           
	           
	            
	            //HttpURLConnection connection = url.openConnection();
	            urlconnection.connect();
	            BufferedReader in = new BufferedReader(new InputStreamReader(urlconnection.getInputStream()));
	            String line;
	            while ((line = in.readLine()) != null ) 
	            {
	                System.out.println("line==>"+line);
	                msgid=line;
	            }
	            
	            System.out.println("******SMS IS BEEN SENT************ =>");
	          
	            } 
	            catch (IOException ex) 
	            {
	                System.out.println("****IO EXCEPATION FOR SMS SENDING===>"+ex);
	            }
	            
	            System.out.println("****END OF SMS CODE===>");
	          
	        }
		  	catch(Exception e) 
	        {
	            
	                System.out.println("Exception in Saving into DB (msgs not sent !!)"+e);
	            
	        }
	        //return msgid;    
	
	
	
	}
	
	
	%>
	
<%!
public  boolean sendmail(String str, String toID, String ccID, String Customer,String heading,  String date1, String date2, int displayedReportNo, String ReportName,  String FileName,String AttachFilePath)
{
	
	String SystemName="", Website="", Logo1="", Logo2="", Signature="", fromLabel="",replyToMailid="", Disclaimer="";
	
try
{
	Statement stEmailDetails = con1.createStatement();
	String getEmailDetails="select * from t_EmailReportSettings	where System='myfleetview' ";
	ResultSet rs=stEmailDetails.executeQuery(getEmailDetails);
	
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
	
	boolean flag = false;
	try
        {		java.util.Date date = new java.util.Date();
				
		        DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
		        Statement stmail = con1.createStatement();
		        
        		//Subject
		  		String subject =ReportName+" "+ Customer+" "+df.format(date); 
		 		System.out.println(" subject name "+subject);
		  		
		 		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		        Calendar cal = Calendar.getInstance();
		        String DateTime = dateFormat.format(cal.getTime());
		        
		        //System.out.println("The html data ==>"+str);
		        
		        //Mail Format
		        String html = "<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
 						"<body><table    border=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
 						"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
 						"<img src="+Logo1+" style=^height: 80px; width: 100px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
 						"<img src="+Logo2+"  style=^height: 80px; width: 400px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
 						"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
 						" <u><a href=http://"+Website+">"+Website+"</a></u>  "+ df.format(date) +"  <br>"+"\n  "+ heading  +" "+ date1 +" "+date2+"</font><br><table><tr><td align = left style = ^margin-left:20px;^>";
		        
		        html = html + str;
		        //html = html + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>"+Signature+"</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr><td><font size=^3^ face=^Arial^>Email: avlsupport@mobile-eye.in</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Thanks and Regards</font></td></tr><tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
		        html = html + "<tr><td align = left><table align= left> <td align=left><font size=^2^ face=^arial^>"+FileName+"</font></td>   <br></br> <tr><td><font size=^3^ face=^Arial^>"+Signature+"</font></td>   </tr> <tr>  <td><font size=^3^ face=^Arial^> "+Disclaimer+"</font></td> </tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
		        System.out.println("The html data ==>"+html);
		        String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath)values('TWSupport','Vehicle Idle Report ','"+html+"','"+subject+"','"+toID+"','"+ccID+"','"+DateTime+"','Pending','Transworld', '"+FileName+"'  , '"+AttachFilePath+"')";
		        System.out.println("insert pending ==>"+q2);
		        stmail.executeUpdate(q2);
	            System.out.println("the record has been successfully inserted into table"); 	             
	            flag = true;
		 	    System.out.println(html);
		 	  
       }  
       catch(Exception e)
       {	
    	   e.printStackTrace();
       }
	
	return flag;
}

%>	
	
	

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script >
function Redirect()
{
	alert("Record Inserted Successfully");
    window.location="VehicleIdleReport.jsp";
	
}

function Redirect2()
{
	alert("Entered date intersect with existing date. Please try with some other date!");
    window.location="VehicleIdleEntry.jsp";
	
}
</script>
</head>
<body>
	<%

			String fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromDate")));
			String toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy" ).parse( request.getParameter("toDate")));;
			String comment =request.getParameter("comment");	
			final String userName = session.getAttribute("mainuser").toString();		
			String VehCode=request.getParameter("VehCode");
			String vehregno=request.getParameter("vehregno");
			String otherComment=request.getParameter("otherComment");
			
			System.out.println(" VehCode "+VehCode+" userName "+userName);
				
			 String ReportName="";
			 int displayedReportNo=0; 
			 String str="",Trip = "",CustType = "",  To = "", Cc = "",    Customer="", heading="",  ToDate="",    FileName="", AttachFilePath="";
			 boolean flag=false;
				
			 // Check if previous record is their or not for overlapping date
			//String sql7="select * from db_gps.t_VehicleIdleEntry where fromDate>='"+fromDate+"' and  toDate<='"+toDate+"' and VehCode='"+VehCode+"'";
			String sql7="select * from db_gps.t_VehicleIdleEntry where ActiveStatus='-' and  VehCode='"+VehCode+"' AND(('"+fromDate+"' <= toDate AND '"+toDate+"' >= fromDate )  OR  ('"+fromDate+"' <= fromDate AND '"+toDate+"' >= toDate)   OR   (('"+fromDate+"' <= toDate AND '"+fromDate+"' >= fromDate) OR   ('"+toDate+"' >= toDate AND '"+toDate+"' <= toDate))  )";
			System.out.println("sqlhod...  "+sql7);
			stmt7= con1.createStatement();
			ResultSet rst7=stmt7.executeQuery(sql7);
			if (rst7.next())
            {
				fromDate = rst7.getString("fromDate");
				toDate = rst7.getString("toDate");
				VehCode= rst7.getString("VehCode");
				
				System.out.println("record already exist fromDate "+fromDate+" toDate "+toDate+" VehCode "+VehCode);
				out.println("<script>  Redirect2();</script>");
            } 
			else 
			{ 
				 try {
					String MobileNo="", VehicleRegNumber="", msg="", hodid="", hodmobile="",hodemail="" ;
					String sql= "insert into db_gps.t_VehicleIdleEntry(VehCode, fromDate,toDate, VehComment, entryBy, otherComment) values ('"+VehCode+"','"+fromDate+"','"+toDate+"','"+comment+"', '"+userName+"', '"+otherComment+"')  ";
					System.out.println("insert query "+sql);
					stmt1.executeUpdate(sql);
					
					String sqlmbl="select VehicleCode, VehicleRegNumber  from db_gps.t_vehicledetails where VehicleCode="+VehCode+" ";
					//String sqlmbl="select  Veh.VehicleCode,Veh.VehicleRegNumber as VehicleRegNumber,Usr.Vehid , Usr.UserName, Usr.FirstName, Usr.LastName ,Usr.Email as email,  Usr.MobNo as MobileNo, Usr.Transporter as  Customer, Usr.hodid as hodid from db_gps.t_vehicledetails as Veh, db_gps.t_userdetails as Usr  where Usr.Vehid="+VehCode+" and Veh.VehicleCode="+VehCode+" and  Veh.VehicleCode=Usr.Vehid ";
					System.out.println("sqlsms...  "+sqlmbl);
					Statement stmt2= con1.createStatement();
					ResultSet rst2 =stmt2.executeQuery(sqlmbl);	
	                if (rst2.next())
	                 {
	                	 VehicleRegNumber = rst2.getString("VehicleRegNumber");
	                 }	 
	                
	                String sql5="select  Vehid,UserName,FirstName,LastName,Email,MobNo,Transporter as  Customer,hodid from  db_gps.t_userdetails  where Vehid="+VehCode+" ";
					System.out.println("sqlsms...  "+sql5);
					Statement stmt5= con1.createStatement();
					ResultSet rst5 =stmt5.executeQuery(sql5);	
	                if (rst5.next())
	                 {
	                	 hodid = rst5.getString("hodid");
	                	 To = rst5.getString("email");
	                	 Customer = rst5.getString("Customer");
	                	 MobileNo = rst5.getString("MobNo");
	                	                	 
	                	//took hod email 
	                	String sqlhod="select FirstName, LastName, MobNo as hodmobile, Email as hodemail from  db_gps.t_userdetails where SrNo='"+hodid+"' ";
	 					System.out.println("sqlhod...  "+sqlhod);
	 					Statement stmt4= con1.createStatement();
	 					ResultSet rst3 =stmt4.executeQuery(sqlhod);
	 					if (rst3.next())
		                 {
	 						hodmobile = rst3.getString("hodmobile");
	 						hodemail = rst3.getString("hodemail");
	 					 }
	                	 
	                 } 
	                
	                
	                String sql6="",usrEMailID=""; 
	                sql6="select FirstName, LastName, MobNo as hodmobile, Email as usrEMailID from  db_gps.t_userdetails where UserName like '%"+userName+"%' ";
 					System.out.println("sql 6  "+sql6);
 					Statement stmt6= con1.createStatement();
 					ResultSet rst6 =stmt6.executeQuery(sql6);
 					if (rst6.next())
	                 {
 						usrEMailID = rst6.getString("usrEMailID");
 					 }
                	
	                 Cc="avlsupport@mobile-eye.in, "+hodemail+","+usrEMailID;
	                 System.out.println(" MobileNo "+MobileNo+" VehicleRegNumber "+VehicleRegNumber+" To "+To+"Cc"+Cc);  
	                                
	        			
	        	try{		
	        			// For gettinng report no and name
	        			int ReportNo=297;
	        			String Category="EntryForm";
	        			Statement stReportNo = con1.createStatement();
	        			String sqlreportno = "Select * from db_gps.t_reportnumber where ReportNo='"+ReportNo+"' and Category='"+Category+"' " ;
	        			System.out.println("sqlreportno  "+sqlreportno);
	        			ResultSet rsReportNo = stReportNo.executeQuery(sqlreportno);
	        			if(rsReportNo.next())
	        			{
	        				displayedReportNo=rsReportNo.getInt("ReportNo");
	        				ReportName=rsReportNo.getString("ReportName");
	        			}
	        			heading=ReportName+" "+displayedReportNo;
	        	}catch(Exception e)
	        	{
	        		System.out.println("Exception while getting report details "+e.getMessage());
	        	}
	            
	        	if(comment.equals("Other"))
	            {
	            	comment=otherComment;
	            }
	        	       	
	        	
	        	str="Vehicle "+VehicleRegNumber+" is not in use  from "+fromDate+" To "+toDate+" beacuse "+comment;
	        	
	        	System.out.println(" message is  "+str);
	        	String body="";
	        	
	 			body = body + " <br><font size = ^2^ face = ^Arial^><table width = ^300%^ align = ^center^ border=^0^>" +
	 			"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>Vehicle No :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+VehicleRegNumber+"</font></td></tr>"+
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>From :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+fromDate+"</font></td></tr>"+
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>To  : </font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+toDate+"</font></td></tr></tr>" +
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>Reason :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+comment+"</font></td></tr></font></td></tr></tr>" +
				"</table></font><br><br></table>";
		
				System.out.println("  Body "+body);			
			
				
	        		flag=sendmail(body,To, Cc,Customer,heading, "","",displayedReportNo,ReportName,   FileName, AttachFilePath);
	        		if(flag==true)
	        		{
	        			System.out.println("Mail Send successful");
	        		}
	        		else
	        		{	                           
	        			System.out.println("Mail Send unsuccessful");
	        		}
	        		
	        		
	                //msg="Vehicle "+VehicleRegNumber+" is idle from  "+fromDate+" To "+toDate+" beacuse "+comment; 
	                msg=VehicleRegNumber+" "+comment+" from  "+fromDate+" To "+toDate;
	                System.out.println(" msg "+msg);
	                //MobileNo=MobileNo+","+hodmobile+",7709606058";
	                System.out.println(" MobileNo "+MobileNo);
	                  
					//sendMessage(msg,MobileNo);  // uncomment it if send message
					out.println("<script>  Redirect();</script>");
										 
			}catch (Exception e) {
					System.out.print("Exception" + e);
			} 
			
		}//else	
	%>
	
	
</body>
</html>
<%@ include file="footernew.jsp" %>


<%@ include file="headernew.jsp"%>

<%@ page  import="java.net.HttpURLConnection" %> 
<%@ page import="java.net.URL" %>
<%@ page  import="java.net.URLEncoder"%>
<%@ page  import="java.io.*"%>
<%@ page autoFlush="true" buffer="1094kb"%>


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
		  		//String subject =ReportName+" "+ Customer+" "+df.format(date);
		  		String subject ="Night Driving Intimation Alert";
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
		        String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName,FileName,AttachFilePath)values('TWSupport','Vehicle ND Intimation Report ','"+html+"','"+subject+"','"+toID+"','"+ccID+"','"+DateTime+"','Pending','Transworld', '"+FileName+"'  , '"+AttachFilePath+"')";
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
    window.location="ndintimationreport.jsp";
    window.opener.location.reload();
	window.close();
	
}

function Redirect2()
{
	alert("Entered date intersect with existing date. Please try with some other date!");
    window.location="NdIntimationEntry.jsp";
	
}
function Redirect3()
{
	alert(" Night Driving should be between 11 p.m to 05 a.m!");
    window.location="NdIntimationEntry.jsp";
    return false;
	
}
function Redirect4()
{
	alert(" Night Driving should be between 11 p.m to 05 a.m!");
    window.location="ndUpdate.jsp";
	
}
</script>
</head>
<body>

<%
System.out.println("In insert page ");
			String inserttype=request.getParameter("update");
			System.out.println("Insert"+inserttype);
			String fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(request.getParameter("data1")));
			String toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse( request.getParameter("data2")));;
			String reason =request.getParameter("reason");	
			final String userName = session.getAttribute("mainuser").toString();		
			String VehCode=request.getParameter("VehCode");
			String distance=request.getParameter("distance");
			String vehid=request.getParameter("vehid");
			System.out.println("Vehcode"+VehCode);
			System.out.println("fromdate"+fromDate);
			System.out.println("Todate"+toDate);
			System.out.println("Distance"+distance);
			System.out.println("Reason"+reason);
			System.out.println("Vehid -->"+vehid);

			String date1=fromDate.substring(11,13);
			String date2=toDate.substring(11,13);
			int d1=Integer.parseInt(date1);
			int d2=Integer.parseInt(date2);
			System.out.println("Date1-->"+date1);
			System.out.println("Date2-->"+date2);
			System.out.println(" VehCode "+VehCode+" userName "+userName);
			
			String ReportName="";
			 int displayedReportNo=0; 
			 String str="",Trip = "",CustType = "",  To = "", Cc = "",    Customer="", heading="",  ToDate="",    FileName="", AttachFilePath="";
			 boolean flag=false;
			 String fromtime=request.getParameter("fromtime");
			 String totime=request.getParameter("totime");
			 System.out.println("NightDrivingFromTime->"+fromtime);
			System.out.println("NightDrivingToTime->"+totime);
			String time1 = fromtime.substring(0,2);	
			String time2 = totime.substring(0,2);
			int t1=Integer.parseInt(time1);
			int t2=Integer.parseInt(time2);
			
			System.out.println("Time 1--"+time1);
			System.out.println("Time 2--"+time2);
			System.out.println("T 1--"+t1);
			System.out.println("T 2--"+t2);
			
		//	if(!(d1>=t1 || d1<t2) && d2>t2)
				if(d1<t1  && d2>=t2)
				//	if(d1<t1 && d2>t2)
			{
				if(inserttype.equals("false") || inserttype== "false"){
					%>
					<jsp:forward page="AlertGoTo.jsp">
					 <jsp:param name="msg" value="Night Driving Entry is allowed between only 11 P.M to 05 A.M " ></jsp:param>
					  <jsp:param name="goto" value="NdIntimationEntry.jsp" ></jsp:param>
					 
					 </jsp:forward>
					 <%
				//out.println("<script>  Redirect3();</script>");
				}else{
					%>
					<jsp:forward page="AlertGoTo.jsp">
					 <jsp:param name="msg" value="Night Driving Entry is allowed between only 11 P.M to 05 A.M " ></jsp:param>
					  <jsp:param name="goto" value="ndintimationreport.jsp" ></jsp:param>
					 
					 </jsp:forward>
					 <%
					//out.println("<script>  Redirect3();</script>");
					 };
			}else{
			
			 // Check if previous record is their or not for overlapping date
			//String sql7="select * from db_gps.t_VehicleIdleEntry where fromDate>='"+fromDate+"' and  toDate<='"+toDate+"' and VehCode='"+VehCode+"'";
			String sql7="select * from db_gps.t_ndintimation where  VehCode='"+VehCode+"' AND(('"+fromDate+"' <= toDate AND '"+toDate+"' >= fromDate )  OR  ('"+fromDate+"' <= fromDate AND '"+toDate+"' >= toDate)   OR   (('"+fromDate+"' <= toDate AND '"+fromDate+"' >= fromDate) OR   ('"+toDate+"' >= toDate AND '"+toDate+"' <= toDate))  )";
			System.out.println("sqlhod...  "+sql7);
			stmt7= con1.createStatement();
			ResultSet rst7=stmt7.executeQuery(sql7);
			if (rst7.next())
           {
				fromDate = rst7.getString("fromdate");
				toDate = rst7.getString("todate");
				VehCode= rst7.getString("VehCode");
				
				System.out.println("record already exist fromDate "+fromDate+" toDate "+toDate+" VehCode "+VehCode);
				out.println("<script>  Redirect2();</script>");
           } 
			else  
			{ 
				 try {
					String MobileNo="", VehicleRegNumber="", msg="", hodid="", hodmobile="",hodemail="" ;
					System.out.println("hiiii");
					if(inserttype.equals("true") || inserttype== "true"){
						System.out.println("In If condition");
						String sql="update db_gps.t_ndintimation set fromdate= '"+fromDate+"', todate='"+toDate+"', distance='"+distance+"', reason='"+reason+"'  where  vehcode='"+vehid+"' ";	
						System.out.println("update query"+sql);
						stmt1.executeUpdate(sql);
					
					}else{
						System.out.println("In else condition");
					String sql= "insert into db_gps.t_ndintimation (fromdate,todate, vehcode, distance, reason, entryBy) values ('"+fromDate+"','"+toDate+"','"+VehCode+"','"+distance+"', '"+reason+"', '"+userName+"')  ";
					System.out.println("insert query "+sql);
					stmt1.executeUpdate(sql);
					}
					String sqlmbl="";
					if(inserttype.equals("true") || inserttype== "true"){
					 sqlmbl="select VehicleCode, VehicleRegNumber  from db_gps.t_vehicledetails where VehicleCode="+vehid+" ";
					}else
						 sqlmbl="select VehicleCode, VehicleRegNumber  from db_gps.t_vehicledetails where VehicleCode="+VehCode+" ";
					//String sqlmbl="select  Veh.VehicleCode,Veh.VehicleRegNumber as VehicleRegNumber,Usr.Vehid , Usr.UserName, Usr.FirstName, Usr.LastName ,Usr.Email as email,  Usr.MobNo as MobileNo, Usr.Transporter as  Customer, Usr.hodid as hodid from db_gps.t_vehicledetails as Veh, db_gps.t_userdetails as Usr  where Usr.Vehid="+VehCode+" and Veh.VehicleCode="+VehCode+" and  Veh.VehicleCode=Usr.Vehid ";
					System.out.println("sqlsms...  "+sqlmbl);
					Statement stmt2= con1.createStatement();
					ResultSet rst2 =stmt2.executeQuery(sqlmbl);	
	                if (rst2.next())
	                 {
	                	 VehicleRegNumber = rst2.getString("VehicleRegNumber");
	                 }	
	                String sql5="";
	                if(inserttype.equals("true") || inserttype== "true"){
	                 sql5="select  Vehid,UserName,FirstName,LastName,Email,MobNo,Transporter as  Customer,hodid from  db_gps.t_userdetails  where Vehid="+vehid+" ";
	                } else
	                	 sql5="select  Vehid,UserName,FirstName,LastName,Email,MobNo,Transporter as  Customer,hodid from  db_gps.t_userdetails  where Vehid="+VehCode+" ";
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
				//	To="s_amol@transworld-compressor.com";
              	//	Cc="v_rode@transworld-compressor.com";
	                 Cc="avlsupport@mobile-eye.in, "+hodemail+","+usrEMailID;
	                 System.out.println(" MobileNo "+MobileNo+" VehicleRegNumber "+VehicleRegNumber+" To "+To+"Cc"+Cc);  
	                                
	        			
	        	try{		
	        			// For gettinng report no and name
	        			int ReportNo=432;
	        			String Category="WebReport";
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
	            
	        	
	        	
	     //   	str="Vehicle "+VehicleRegNumber+" is not in use  from "+fromDate+" To "+toDate+" beacuse "+reason;
	        	
	        	System.out.println(" message is  "+str);
	        	String body="";
	        	//
	        	body= body + "<tr><td><table align=left  cellpadding=0 cellspacing=0 width=90% border=0><tr><td align=left><font size=3 face=arial><b> Night Driving Intimation </b></font></br></td></tr></table></td></tr>"+
									"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=90% border=1 style=^border-collapse: collapse^>"+
								"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b> Vehicle No </b></font></td>"+
								"<td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b>  From </b></font></td>"+
								"<td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b> To </b></font></td>"+
								"<td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b> Distance  </b></font></td>"+
								"<td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b>  Reason  </b></font></td>"+
								"<td align=center style=^width: 15%;^><font size=^2^ face=^arial^><b> Entry By </b></font></td>";
								
								
						body= body + "<tr><td align=left><font size=^2^ face=^arial^>"+VehicleRegNumber+"</font></td>"+
									"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(fromDate))+"</font></td>"+
												"<td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(toDate))+"</font></td>"+
												"<td align=right><font size=^2^ face=^arial^>"+distance +"</font></td>"+
								"<td align=left><font size=^2^ face=^arial^>"+reason+"</font></td>"+
								"<td align=left><font size=^2^ face=^arial^>"+userName+"</font></td>";
								
								
								
						body= body + "</table></tr><br/><br/><br/><br/><br/><br/><br/><br/>";

	        	
	        	
	 	/*		String body = body + " <br><font size = ^2^ face = ^Arial^><table width = ^300%^ align = ^center^ border=^0^>" +
	 			"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>Vehicle No :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+VehicleRegNumber+"</font></td></tr>"+
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>From :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+fromDate+"</font></td></tr>"+
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>To  : </font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+toDate+"</font></td></tr></tr>" +
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>Distance :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+distance+"</font></td></tr></font></td></tr></tr>" +
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>Reason :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+reason+"</font></td></tr></font></td></tr></tr>" +
				"<tr><td width = ^140%^ valign = ^top^><font size = ^2^>Entry By :</font></td><td valign = ^top^ width = ^160%^><font size = ^2^>"+userName+"</font></td></tr></font></td></tr></tr>" +
				"</table></font><br><br></table>";  */
		
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
	                msg=VehicleRegNumber+" "+reason+" from  "+fromDate+" To "+toDate;
	                System.out.println(" msg "+msg);
	                //MobileNo=MobileNo+","+hodmobile+",7709606058";
	                System.out.println(" MobileNo "+MobileNo);
	                  
					//sendMessage(msg,MobileNo);  // uncomment it if send message
					out.println("<script>  Redirect();</script>");
										 
			}catch (Exception e) {
					System.out.print("Exception" + e);
			} 
			
		}//else	
		
			}//else
		
	%>
	
	
</body>
</html>
<%@ include file="footernew.jsp" %>


%>

	
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
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
	Statement stmt3 = con2.createStatement();
	Statement strepre,stadmin;
	strepre=con2.createStatement();
    stadmin=con2.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null;
	String sql="", sql1="", sql2="", sql3="";
	String tm="";
	int vcode=0;
	int vcode1;
   int i=0;
   int maxid = 0;
   byte decision, numValue;
   char charValue;
   Random rgen = new Random();
    String password = "",vehicleaddedlist = "";
	java.util.Date td =new java.util.Date();
	String ownername = session.getAttribute("usertypevalue").toString();
	String user = session.getAttribute("mainuser").toString();
	String username = session.getAttribute("fname").toString()+" "+session.getAttribute("lname").toString();
	System.out.println("****   "+user);
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	String sdt = fmt.format(td);
	String usrname = request.getParameter("username");
	usrname = usrname.trim();
	String fname = request.getParameter("fname");
	fname = fname.trim();
	String lname = request.getParameter("lname");
	lname = lname.trim();
	String phno = request.getParameter("phno");
	String phnoold = request.getParameter("phnoold");
	String loc = request.getParameter("loc");
	String locold = request.getParameter("locold");
	String desg = request.getParameter("desg");
	String desgold = request.getParameter("desgold");
	String allocdate = request.getParameter("allocdate1");
	String expdate = request.getParameter("expdate");
	String expdateold = request.getParameter("expcdateold");
	String[] vehicles = request.getParameterValues("assigned1");
	String status = request.getParameter("status");
	//String typeofuser = request.getParameter("trk");
	String typeofuser = "";
//	System.out.println("*******    "+typeofuser);
	String Msg = "";
	String vehid = "";
	String alloc1 = "",exp1 = "";
	alloc1 = allocdate;
	exp1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(expdate));
	
	String vehcode1 = "0";
	sql3 ="select * from db_gps.t_security where username = '"+usrname+"'  and TypeValue = '"+fname+" "+lname+"' and CreationDate = '"+alloc1+"' and ExpiryDate = '"+exp1+"'";
	ResultSet rs4 = stmt3.executeQuery(sql3);
	System.out.println(sql3);
	if(rs4.next())
	{
	sql = "select * from db_gps.t_userdetails where username = '"+usrname+"' and FirstName = '"+fname+"' and LastName = '"+lname+"' and MobNo = '"+phno+"' and Location = '"+loc+"' and Designation = '"+desg+"' ";
	rs1 = stmt.executeQuery(sql);
	System.out.println(sql);
	if(rs1.next())
	{
		for(i = 0;i<vehicles.length;i++)
 		{
			sql2 = "select * from db_gps.t_vehicledetails where VehicleRegNumber = '"+vehicles[i].trim()+"'";
			rs3= stmt2.executeQuery(sql2);
			System.out.println(sql2);
			if(rs3.next())
			{
				if(i==0)
				{
					vehcode1 = rs3.getString("Vehiclecode");
				}
				else
				{
					vehcode1 = vehcode1+","+rs3.getString("Vehiclecode");
				}
				sql1 = "select * from db_gps.t_group where GPName = '"+fname+" "+lname+"' and vehcode = '"+rs3.getString("vehiclecode")+"' and VehRegno = '"+ownername+"' and Active = 'Yes' and SepReport = 'Yes' ";
				rs2 = stmt1.executeQuery(sql1);
				System.out.println(sql1);
				if(rs2.next())
				{
					
				}
				else
				{
					Msg = "1";
				}
			}
			
 		}
		
		
			sql1 = "select * from db_gps.t_group where GPName = '"+fname+" "+lname+"'  and VehRegno = '"+ownername+"' and Active = 'Yes' and SepReport = 'Yes' and vehcode not in ("+vehcode1+")";
		System.out.println(sql1);
		rs2=stmt1.executeQuery(sql1);
		
		if(rs2.next())
		{
			Msg = "1";
		}
		else
		{
		    
		}
	}
	else
	{
		Msg = "1";
	}
	}
	else
	{
		Msg = "1";
	}
	
	System.out.println(Msg);
	
	if(Msg == "1" || Msg.equals("1"))
	{
		
		if(exp1==expdateold || exp1.equalsIgnoreCase(expdateold))
		{
		
			
		}
		else
		{
			sql1 = "select * from db_gps.t_security where username = '"+usrname+"'  and TypeValue = '"+fname+" "+lname+"' and CreationDate = '"+alloc1+"' and ExpiryDate = '"+expdateold+"' ";
			rs1 = stmt1.executeQuery(sql1);
			if(rs1.next())
			{
				
				sql = "insert into db_gps.t_securityhistory (Username,FullName,Password,OtherDetails,RightToViewTracking,RightToAddorEditUsers,RightToSendSMSInterval,RightToSendSMSRelayOpenClose,RightToSendSMSRemotePolling,"+
						"TypeofUser,TypeValue,MM_DBConn_Driver,MM_dbConn_UserName,MM_dbConn_Password,MM_dbConn_String,MM_dbConn_String1,Address,CreationDate,ActiveStatus,LoginInfo,ExpiryDate,TransporterName,Entryby,Status1)  values "+
					" ('"+usrname+"','"+fname+" "+lname+"','"+rs1.getString("Password")+"','"+rs1.getString("OtherDetails")+"','"+rs1.getString("RightToViewTracking")+"','"+rs1.getString("RightToAddorEditUsers")+"','"+rs1.getString("RightToSendSMSInterval")+"','"+rs1.getString("RightToSendSMSRelayOpenClose")+"',"+
					"'"+rs1.getString("RightToSendSMSRemotePolling")+"','"+rs1.getString("TypeofUser")+"','"+rs1.getString("TypeValue")+"','"+rs1.getString("MM_DBConn_Driver")+"','"+rs1.getString("MM_dbConn_UserName")+"','"+rs1.getString("MM_dbConn_Password")+"','"+rs1.getString("MM_dbConn_String")+"',"+
					 "'"+rs1.getString("MM_dbConn_String1")+"','"+rs1.getString("Address")+"','"+rs1.getString("CreationDate")+"','"+rs1.getString("ActiveStatus")+"','"+rs1.getString("LoginInfo")+"','"+rs1.getString("ExpiryDate")+"','"+rs1.getString("TransporterName")+"','"+user+"','Updated')";
				stmt.executeUpdate(sql);
				System.out.println("888   "+sql);
				String abcd444=sql.replace("'","#");	
				 abcd444=abcd444.replace(",","$");								
				stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
				
				sql = "update db_gps.t_security set ExpiryDate = '"+exp1+"'  where username = '"+usrname+"'  and TypeValue = '"+fname+" "+lname+"' and CreationDate = '"+alloc1+"' and ExpiryDate = '"+expdateold+"'";
				stmt.executeUpdate(sql);
				System.out.println("888   "+sql);
				 abcd444=sql.replace("'","#");	
				 abcd444=abcd444.replace(",","$");								
				stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			}
			
			
		
		}
		
		if((phno==phnoold || phno.equalsIgnoreCase(phnoold)) && (loc==locold || loc.equalsIgnoreCase(locold)) && (desg==desgold || desg.equalsIgnoreCase(desgold)))
		{
			
		}
		else
		{
			
			sql1 = "select * from db_gps.t_userdetails where UserName = '"+usrname+"' and FirstName = '"+fname+"' and LastName = '"+lname+"' and MobNo = '"+phnoold+"' and Location = '"+locold+"' and Designation = '"+desgold+"'";
			rs1 = stmt1.executeQuery(sql1);
			if(rs1.next())
			{
				sql = "insert into db_gps.t_userdetailhistory (UserName,Transporter,UserType,SubUser,FirstName,LastName,MobNo,Email,Designation,Location,HODID,Vehid,Entryby,Status)  values "+
						 " ('"+usrname+"','"+rs1.getString("Transporter")+"','"+rs1.getString("UserType")+"','"+rs1.getString("SubUser")+"','"+rs1.getString("FirstName")+"','"+rs1.getString("LastName")+"','"+rs1.getString("MobNo")+"','"+rs1.getString("Email")+"',"+
					   	 "'"+rs1.getString("Designation")+"','"+rs1.getString("Location")+"','"+rs1.getString("HODID")+"','"+rs1.getString("Vehid")+"','"+user+"','Updated')";
				stmt.executeUpdate(sql);
				System.out.println("888   "+sql);
				String abcd444=sql.replace("'","#");	
		 		abcd444=abcd444.replace(",","$");								
				stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
				
				sql = "update db_gps.t_userdetails set MobNo='"+phno+"',Location='"+loc+"',Designation='"+desg+"'   where UserName = '"+usrname+"' and FirstName = '"+fname+"' and LastName = '"+lname+"' and MobNo = '"+phnoold+"' and Location = '"+locold+"' and Designation = '"+desgold+"'";
				stmt.executeUpdate(sql);
				System.out.println("888   "+sql);
				 abcd444=sql.replace("'","#");	
				 abcd444=abcd444.replace(",","$");								
				stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			}
			
		}
		System.out.println("**    "+vehicles.length);
		
	    
		String vehcode = "0";
		for(i = 0;i<vehicles.length;i++)
 		{
		    
			System.out.println("88888   "+i);
 			sql = "select * from db_gps.t_vehicledetails where VehicleRegNumber = '"+vehicles[i].trim()+"' ";
 			rs1 = stmt.executeQuery(sql);
 			System.out.println("*******vehicledetails    "+sql);
 			if(rs1.next())
 			{		
 				if(i==0)
 			    {
 			    	vehcode =rs1.getString("vehiclecode");
 			    }
 				else
 				{
 					vehcode = vehcode+","+rs1.getString("vehiclecode");
 				}
 				sql2 ="select * from db_gps.t_group where GPName = '"+fname+" "+lname+"' and vehcode = '"+rs1.getString("vehiclecode")+"' and VehRegno = '"+ownername+"'";
 				rs2 = stmt1.executeQuery(sql2);
 				System.out.println("*******group    "+sql2);
 				if(rs2.next())
 				{
 					 if((rs2.getString("SepReport") == "Yes" || rs2.getString("SepReport").equalsIgnoreCase("Yes")) && (rs2.getString("Active") == "Yes" || rs2.getString("Active").equalsIgnoreCase("Yes")))
 					 {
 						 
 					 }
 					 else
 					 {
 						sql1 = "insert into db_gps.t_grouphistory (TicketID,GPName,transporter,VehRegNo,Vehcode,status,UpdatedDate,EntBy,InsertedFrom) values "+
 						" ('0','"+fname+" "+lname+"','"+ownername+"','"+vehicles[i].trim()+"','"+rs1.getString("vehiclecode")+"','Updated','"+sdt+"','"+user+"','Edit User')";
 						stmt2.executeUpdate(sql1); 	
 						//System.out.println("888   "+sql);
 						String	 abcd444=sql1.replace("'","#");	
 						 abcd444=abcd444.replace(",","$");								
 						stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
 						
 						
 						System.out.println("*******group    ");
 						sql1 = "update db_gps.t_group  set SepReport='Yes',Active='Yes'  where GPName = '"+fname+" "+lname+"' and vehcode = '"+rs1.getString("vehiclecode")+"' and  VehRegno = '"+ownername+"'";
 						stmt2.executeUpdate(sql1);	
 							 abcd444=sql1.replace("'","#");	
						 abcd444=abcd444.replace(",","$");								
						stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
 					 }
 				}
 				else
 				{
 					sql1 = "insert into db_gps.t_grouphistory (TicketID,GPName,transporter,VehRegNo,Vehcode,status,UpdatedDate,EntBy,InsertedFrom) values "+
						" ('0','"+fname+" "+lname+"','"+ownername+"','"+vehicles[i].trim()+"','"+rs1.getString("vehiclecode")+"','Inserted','"+sdt+"','"+user+"','Edit User')";
						stmt2.executeUpdate(sql1); 
						String	 abcd444=sql1.replace("'","#");	
						 abcd444=abcd444.replace(",","$");								
						stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
 					
 					sql1 = "insert into db_gps.t_group (GPName,VehRegNo,transporter,Vehcode,SepReport,Active,EntryBy) values ('"+fname+" "+lname+"','"+ownername+"','"+vehicles[i].trim()+"','"+rs1.getString("vehiclecode")+"','Yes','Yes','"+user+"')";
 					stmt2.executeUpdate(sql1);
 						 abcd444=sql1.replace("'","#");	
					 abcd444=abcd444.replace(",","$");								
					stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
 				}
 				
 				
 			}
 		}
		
		
			sql = "select * from db_gps.t_group where GPName = '"+fname+" "+lname+"'  and VehRegno = '"+ownername+"' and vehcode not in ("+vehcode+")";
		System.out.println("*******group    "+sql);
		rs1 = stmt.executeQuery(sql);
		while(rs1.next())
		{
			sql1 = "insert into db_gps.t_grouphistory (TicketID,GPName,transporter,VehRegNo,Vehcode,status,UpdatedDate,EntBy,InsertedFrom) values "+
			" ('0','"+fname+" "+lname+"','"+ownername+"','"+rs1.getString("transporter")+"','"+rs1.getString("vehcode")+"','deleted','"+sdt+"','"+user+"','Edit User')";
			stmt2.executeUpdate(sql1); 
			String	 abcd444=sql1.replace("'","#");	
			 abcd444=abcd444.replace(",","$");								
			stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
		}
		
			sql = "update db_gps.t_group set SepReport ='No',Active = 'No'  where GPName = '"+fname+" "+lname+"'  and VehRegno = '"+ownername+"' and vehcode not in  ("+vehcode+")";
		System.out.println("*******group    "+sql);
		stmt.executeUpdate(sql);
		String	 abcd444=sql1.replace("'","#");	
		 abcd444=abcd444.replace(",","$");								
		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
		
	}
	else
	{
		Msg = "2";
	}
	
		response.sendRedirect("edituser.jsp?Msg="+Msg+"&username="+usrname+"&typevalue="+fname+" "+lname+"&activestatus="+status);
	

	}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	con1.close();
	con2.close();
	 
}
%>
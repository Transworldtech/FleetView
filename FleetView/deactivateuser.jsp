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
	String ownername = session.getAttribute("usertypevalue").toString();
	String user = session.getAttribute("mainuser").toString();
	String username = request.getParameter("username");
	String typevalue = request.getParameter("typevalue");
	String status = request.getParameter("status");
	String create = request.getParameter("create");
	String exp = request.getParameter("exp");
	java.util.Date td =new java.util.Date();
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	String sdt = fmt.format(td);
	
	sql = "select * from db_gps.t_security where username = '"+username+"'  and TypeValue = '"+typevalue+"' and CreationDate = '"+create+"' and ExpiryDate = '"+exp+"'  ";
	rs1 = stmt.executeQuery(sql);
	if(rs1.next())
	{
		sql1 = "insert into db_gps.t_securityhistory (Username,FullName,Password,OtherDetails,RightToViewTracking,RightToAddorEditUsers,RightToSendSMSInterval,RightToSendSMSRelayOpenClose,RightToSendSMSRemotePolling,"+
		"TypeofUser,TypeValue,MM_DBConn_Driver,MM_dbConn_UserName,MM_dbConn_Password,MM_dbConn_String,MM_dbConn_String1,Address,CreationDate,ActiveStatus,LoginInfo,ExpiryDate,TransporterName,Entryby,Status1)  values "+
		" ('"+username+"','"+typevalue+"','"+rs1.getString("Password")+"','"+rs1.getString("OtherDetails")+"','"+rs1.getString("RightToViewTracking")+"','"+rs1.getString("RightToAddorEditUsers")+"','"+rs1.getString("RightToSendSMSInterval")+"','"+rs1.getString("RightToSendSMSRelayOpenClose")+"',"+
		"'"+rs1.getString("RightToSendSMSRemotePolling")+"','"+rs1.getString("TypeofUser")+"','"+rs1.getString("TypeValue")+"','"+rs1.getString("MM_DBConn_Driver")+"','"+rs1.getString("MM_dbConn_UserName")+"','"+rs1.getString("MM_dbConn_Password")+"','"+rs1.getString("MM_dbConn_String")+"',"+
		 "'"+rs1.getString("MM_dbConn_String1")+"','"+rs1.getString("Address")+"','"+rs1.getString("CreationDate")+"','"+rs1.getString("ActiveStatus")+"','"+rs1.getString("LoginInfo")+"','"+rs1.getString("ExpiryDate")+"','"+rs1.getString("TransporterName")+"','"+user+"','Deactivated')";
		
		stmt1.executeUpdate(sql1);
		System.out.println("888   "+sql1);
		String abcd444=sql1.replace("'","#");	
		 abcd444=abcd444.replace(",","$");								
		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			
	}
	
	sql = "update db_gps.t_security  set ActiveStatus = 'No' where username = '"+username+"'  and TypeValue = '"+typevalue+"' and CreationDate = '"+create+"' and ExpiryDate = '"+exp+"' ";
	stmt.executeUpdate(sql);
	String abcd444=sql.replace("'","#");	
	 abcd444=abcd444.replace(",","$");								
	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	
     sql = "select * from db_gps.t_userdetails where username = '"+username+"'";
     rs1 = stmt.executeQuery(sql);
     if(rs1.next())
     {
    	 sql1 = "insert into db_gps.t_userdetailhistory (UserName,Transporter,UserType,SubUser,FirstName,LastName,MobNo,Email,Designation,Location,HODID,Vehid,Entryby,Status)  values "+
		 " ('"+username+"','"+rs1.getString("Transporter")+"','"+rs1.getString("UserType")+"','"+rs1.getString("SubUser")+"','"+rs1.getString("FirstName")+"','"+rs1.getString("LastName")+"','"+rs1.getString("MobNo")+"','"+rs1.getString("Email")+"',"+
	   	 "'"+rs1.getString("Designation")+"','"+rs1.getString("Location")+"','"+rs1.getString("HODID")+"','"+rs1.getString("Vehid")+"','"+user+"','Deleted')";
    	 stmt1.executeUpdate(sql1);
    	 abcd444=sql1.replace("'","#");	
    	 abcd444=abcd444.replace(",","$");								
    	 stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
     }
     
     sql = "delete from db_gps.t_userdetails where username = '"+username+"'";
     stmt.executeUpdate(sql);
	 abcd444=sql.replace("'","#");	
	 abcd444=abcd444.replace(",","$");								
	 stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	
	sql = "select * from db_gps.t_group where GPName = '"+typevalue+"' ";
	rs1 = stmt.executeQuery(sql);
	while(rs1.next())
	{
		sql1 = "insert into db_gps.t_grouphistory (TicketID,GPName,transporter,VehRegNo,Vehcode,status,UpdatedDate,EntBy,InsertedFrom) values "+
			" ('0','"+typevalue+"','"+rs1.getString("VehRegNo")+"','"+rs1.getString("transporter")+"','"+rs1.getString("vehcode")+"','Updated','"+sdt+"','"+user+"','Deactivate User')";
		 stmt1.executeUpdate(sql1);
		 abcd444=sql1.replace("'","#");	
		 abcd444=abcd444.replace(",","$");								
		 stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	}
	
	sql = "update db_gps.t_group set SepReport ='No',Active = 'No' where GPName = '"+typevalue+"' ";
	stmt.executeUpdate(sql);
	 abcd444=sql.replace("'","#");	
	 abcd444=abcd444.replace(",","$");								
	 stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
	
	 response.sendRedirect("userreport.jsp?Msg=deactivated");
	 
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
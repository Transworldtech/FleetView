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
	String Msg = "";
	String []name = typevalue.split(" ");
	String typeofuser = "";
	
	sql = "select * from db_gps.t_security where username = '"+username+"' and ActiveStatus = 'Yes' ";
	rs1 = stmt.executeQuery(sql);
	if(rs1.next())
	{
		Msg = "1";
	}
	else
	{
		sql1 = "select * from db_gps.t_userdetails where username = '"+username+"' and concat(FirstName,' ',LastName) = '"+typevalue+"'";
		rs2 = stmt1.executeQuery(sql1);
		if(rs2.next())
		{
			Msg = "2";
		}
		else
		{
			sql2 = "select * from db_gps.t_security where username = '"+username+"' and TypeValue = '"+typevalue+"' and CreationDate = '"+create+"' and ExpiryDate = '"+exp+"' ";
			rs3 = stmt2.executeQuery(sql2);
			if(rs3.next())
			{
				typeofuser = rs3.getString("TypeofUser");
				sql3 = "insert into db_gps.t_securityhistory (Username,FullName,Password,OtherDetails,RightToViewTracking,RightToAddorEditUsers,RightToSendSMSInterval,RightToSendSMSRelayOpenClose,RightToSendSMSRemotePolling,"+
				"TypeofUser,TypeValue,MM_DBConn_Driver,MM_dbConn_UserName,MM_dbConn_Password,MM_dbConn_String,MM_dbConn_String1,Address,CreationDate,ActiveStatus,LoginInfo,ExpiryDate,TransporterName,Entryby,Status1)  values "+
				" ('"+username+"','"+typevalue+"','"+rs3.getString("Password")+"','"+rs3.getString("OtherDetails")+"','"+rs3.getString("RightToViewTracking")+"','"+rs3.getString("RightToAddorEditUsers")+"','"+rs3.getString("RightToSendSMSInterval")+"','"+rs3.getString("RightToSendSMSRelayOpenClose")+"',"+
				"'"+rs3.getString("RightToSendSMSRemotePolling")+"','"+rs3.getString("TypeofUser")+"','"+rs3.getString("TypeValue")+"','"+rs3.getString("MM_DBConn_Driver")+"','"+rs3.getString("MM_dbConn_UserName")+"','"+rs3.getString("MM_dbConn_Password")+"','"+rs3.getString("MM_dbConn_String")+"',"+
				 "'"+rs3.getString("MM_dbConn_String1")+"','"+rs3.getString("Address")+"','"+rs3.getString("CreationDate")+"','"+rs3.getString("ActiveStatus")+"','"+rs3.getString("LoginInfo")+"','"+rs3.getString("ExpiryDate")+"','"+rs3.getString("TransporterName")+"','"+user+"','Activated')";
				
				stmt3.executeUpdate(sql3);
				System.out.println("888   "+sql1);
				String abcd444=sql3.replace("'","#");	
				 abcd444=abcd444.replace(",","$");								
				stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
				
			}
			
			sql2 = "update db_gps.t_security  set ActiveStatus = 'Yes'  where username = '"+username+"' and TypeValue = '"+typevalue+"' and CreationDate = '"+create+"' and ExpiryDate = '"+exp+"' ";
			stmt2.executeUpdate(sql2);
			
			String abcd444=sql2.replace("'","#");	
			 abcd444=abcd444.replace(",","$");								
			stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			
			sql2 = "insert into db_gps.t_userdetails (UserName,Transporter,Usertype,FirstName,LastName) "
		          +"values ('"+username+"','"+ownername+"','"+typeofuser+"','"+name[0]+"','"+name[1]+"')";
			stmt2.executeUpdate(sql2);
			
			 abcd444=sql2.replace("'","#");	
			 abcd444=abcd444.replace(",","$");								
			stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd444+"')");
			Msg = "3";
		}
	}
	
	 response.sendRedirect("userreport.jsp?Msg="+Msg);
	
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
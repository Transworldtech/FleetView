<%@ include file="Connections/conn.jsp"%>
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	Statement stmt3 = conn.createStatement();
String username="", TypeofUser="",typeValue="";
int maxid=0;
String user=session.getAttribute("user").toString();
username=request.getParameter("username");


			java.util.Date d = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String s=formatter.format(d);
			
String sql2="select * from t_security where Username='"+username+"' and ActiveStatus='Yes' ";
out.println(sql2);
ResultSet rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	TypeofUser=rs2.getString("TypeofUser");
	typeValue=rs2.getString("TypeValue");
	
}
	maxid=maxid+1;	
	String transporterName=session.getAttribute("usertypevalue").toString();
	//System.out.println("typeofuser777777777777777"+typeofuser);
	
String sql1="update db_gps.t_security set ActiveStatus='No' where Username='"+username+"' and ActiveStatus='Yes' ";
out.print(sql1);
//out.print(typeofuser);
stmt1.executeUpdate(sql1);
if("GROUP".equalsIgnoreCase(TypeofUser)){
	boolean existsInGroup=false;
	System.out.println("type of user is group");
	String sql3="select * from db_gps.t_group where GPName='"+typeValue+"'";
	ResultSet rs3=stmt2.executeQuery(sql3);
	while(rs3.next()){
		System.out.println("user is exists in t_group");
		sql2= "insert into t_grouphistory (GPName,VehRegno,transporter,VehCode,Status,EntBy,UpdatedDate)values('"+typeValue+"','"+rs3.getString("transporter")+"','"+rs3.getString("VehRegno")+"','"+rs3.getString("VehCode")+"','Deleted','"+user+"','"+s+"') ";
		stmt3.executeUpdate(sql2);
		existsInGroup=true;
	}
	if(existsInGroup==true){
		
		String sql4="delete from t_group where GPName='"+typeValue+"'";
		stmt3.executeUpdate(sql4);
	}
}
response.sendRedirect("deactivateUser.jsp?inserted=successfull");

} catch(Exception e) { e.printStackTrace();response.sendRedirect("deactivateUser.jsp?inserted=successfull"); }


%>

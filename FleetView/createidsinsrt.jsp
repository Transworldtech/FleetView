<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1 = conn.createStatement();
ResultSet rs2=null;
String sql1="", sql2=""; 

String trans="", fn="", pass="", un="",typeofuser="",admin="";
int maxid=0;
trans=request.getParameter("trans");
fn=request.getParameter("fn");
un=request.getParameter("un");
pass=request.getParameter("pass");

			java.util.Date d = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String s=formatter.format(d);
			
sql2="select max(UserId) as maxid from t_security";
out.println(sql2);
rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	maxid=rs2.getInt("maxid");
}
	maxid=maxid+1;	
	//System.out.println("admin777777777777777777"+admin);	

	//	System.out.println("admin======>"+admin);	

		
		sql1="select * from t_security where TypeValue='"+trans+"'";
		out.println(sql1);
ResultSet rsttype=stmt1.executeQuery(sql1);
if(rsttype.next())
{
	typeofuser=rsttype.getString("typeofuser");
}
else
{
	String sql11="select * from t_group where GPName='"+trans+"'";
	out.println(sql11);
	ResultSet rsttype1=stmt1.executeQuery(sql11);
	if(rsttype1.next())
	{
		typeofuser="GROUP";
	}
	else
	{
		typeofuser="Transporter";
	}
}
	
	
	String transporterName=session.getAttribute("usertypevalue").toString();
	//System.out.println("typeofuser777777777777777"+typeofuser);
sql1="insert into t_security (UserId,  UserName, FullName, Password, TypeofUser, TypeValue, CreationDate,TransporterName) values ('"+maxid+"','"+un+"', '"+fn+"', '"+pass+"', '"+typeofuser+"', '"+trans+"', '"+s+"','"+transporterName+"') ";
out.print(sql1);
//out.print(typeofuser);
stmt1.executeUpdate(sql1);
out.print(typeofuser);
response.sendRedirect("createnewid.jsp?inserted=successfull");

} catch(Exception e) { e.printStackTrace();response.sendRedirect("createnewid.jsp?inserted=successfull"); }


%>

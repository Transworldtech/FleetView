<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;

%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=con1.createStatement();
Statement st1=con1.createStatement();
Statement stmtinsert=con1.createStatement();

String sql="";
boolean flag=false;
String username=(String)session.getAttribute("usertypevalue");

	String EndCod=request.getParameter("endcod");
	String StartCod=request.getParameter("StartCod");
	String Cleanername="",owner="",status="",entryby="",rid="",buffer;
//System.out.println("SACHIN KAPRE  ");

	sql = "select * from db_gps.t_castrolroutes where Owner='"+username+"' and StartCode='"+StartCod+"' and EndCode='"+EndCod+"'";
	ResultSet rs = st1.executeQuery(sql);
	System.out.println("  "+sql);
	if(rs.next())
	{
//	 System.out.println("inside if");
	 buffer="Yes";
	}
	else
	{
			buffer="No";
	}
	out.print(buffer);
	
}
catch(Exception e)
{
	
}
%>




	
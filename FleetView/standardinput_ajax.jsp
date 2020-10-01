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

	//String cat1=request.getParameter("cat");
	String subcat1=request.getParameter("subcat");
	String option=request.getParameter("options");
	String Cleanername="",owner="",status="",entryby="",rid="",buffer="";
       System.out.println("option-------------->  " +option);
       System.out.println("subcategory-------------->  " +subcat1);    
try
{
	sql = "select * from db_gps.t_JourneyGoals where Categoery1='"+subcat1+"' and Options='"+option+"'";
	ResultSet rs = st1.executeQuery(sql);
	//System.out.println(" -------------------------------111111111> "+sql);
	if(rs.next())
	{
//	 System.out.println("inside if");
	 buffer="Yes";
	}
	else
	{
			buffer="No";
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
	out.print(buffer);
	
}
catch(Exception e)
{
	
}
%>




	
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

	String cleanid=request.getParameter("cleanid");
	String Cleanername="",owner="",status="",entryby="",rid="",buffer;


	 sql = "select Cleanerid from db_gps.t_cleaners where Owner='"+username+"' and Cleanerid='"+cleanid+"' ";
	System.out.println("***    "+sql);
	ResultSet rs = st1.executeQuery(sql);
	  if(rs.next())
	  {
		  buffer="Yes";
	  }
	  else{
			buffer="No";

		}
		out.print(buffer);
		
}
catch(Exception e)
{

	e.printStackTrace();
}finally
{
	// st.close();
	con1.close();
}
%>




	
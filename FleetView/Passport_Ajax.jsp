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

	String passId=request.getParameter("passId");
	String irtestatus="",driverstatus="",buffer;


	String sqlChk = "select * from t_irtedriver where PassportID = '"+passId+"' ";
	ResultSet rs = st.executeQuery(sqlChk);
	if(rs.next()){
		irtestatus="Yes";
	}
	String sqlChkd = "select * from t_drivers where DriverID = '"+passId+"' ";
	ResultSet rsd = st.executeQuery(sqlChkd);
	if(rsd.next()){
		driverstatus="Yes";
	}
	System.out.println("Value is == " +irtestatus+ "driverstatus===" +driverstatus);
	
if(irtestatus.equalsIgnoreCase("Yes") && driverstatus.equalsIgnoreCase("Yes"))	
	
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




	
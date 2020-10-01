<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
Statement st;
%>
<% 
try {
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();

ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
String DriveId=request.getParameter("DriveId");
String BrifId=request.getParameter("BrifId");
String buffer;
sql="delete from db_gps.t_briefing where Driverid='"+DriveId+"' and  BriefId='"+BrifId+"'";
System.out.println("$$$$$$!!!!"+sql);
int ins=0;	
ins=st.executeUpdate(sql);
if(ins>=1){
		buffer="close";
		System.out.println("Updates : "+sql);
		out.print(buffer);		
}
}
 catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{	st.close();
		con1.close();	}
%>
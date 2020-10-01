
<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>

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
String incidentID=request.getParameter("incidentID");

System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "+incidentID+"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		
sql="select * from db_gps.t_contestIncidentMaster where incidentId='"+incidentID+"'";

System.out.println(sql);
rst=st.executeQuery(sql);
String editBuffer="";
int i=1;
while(rst.next())
{
		 String orgFile=rst.getString("OriginalIncidentFile");
		 String rnameFile=rst.getString("NewIncidentFile");
		 String status=rst.getString("Status");
		 String transporter=rst.getString("Transporter");
		 String veh=rst.getString("vehicle");
		 editBuffer+=orgFile+"#"+rnameFile+"#"+status+"#"+transporter+"#"+veh;		 
}

out.println(editBuffer);

} 
catch(Exception e) 
{ 
	System.out.print("Exception Ajax Contest Incident Edit----->>"+e);
}
finally
{
		st.close();
		con1.close();
}

%>
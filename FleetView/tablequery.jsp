
<%@page import="com.fleetview.beans.classes"%><%@ include file="Connections/conn.jsp" %>

<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn;
String userName,sql,UserType1,UserTypeValue,sql1;
%>
<%
try{
	conn=fleetview.ReturnConnection();
	Statement st=conn.createStatement();
	Statement st1=conn.createStatement();
	int i=0;
	sql="select VehCode from t_group where GPName='Castrol EMP VEH' limit 8,20";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		i++;
		System.out.println(rst.getString("VehCode"));
		sql1="ALTER TABLE t_veh"+rst.getString("VehCode")+" ADD `CorrectDistance` DOUBLE NULL ,ADD `CorrectFactor` DOUBLE NULL";
		st1.executeUpdate(sql1);
		String sql11="ALTER TABLE t_veh"+rst.getString("VehCode")+" ADD `Status` VARCHAR(20) NULL";
		st1.executeUpdate(sql11);
		//System.out.println(sql1);
		
	}
	System.out.println(i);
	
	
	
	

}catch(Exception e)
{
	out.print("Exception---->"+e);
}

%>
<% fleetview.closeConnection(); %>


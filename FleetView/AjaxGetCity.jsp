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
String state = request.getParameter("state");
String html = "<option value='Select' selected='selected'>Select</option>";


	sql = "select distinct(city) from db_gps.t_citystctryinfo where state = '"+state+"' and country = 'India' order by city";
	rst =st.executeQuery(sql);
	while(rst.next())
	{
		html += "<option value='"+rst.getString("City")+"'>"+rst.getString("City")+"</option>";
	}
	



out.println(html);

}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	st.close();
	con1.close();
}
%>


 <%@ include file="Connections/conn.jsp" %>

<%@ page buffer="16kb" %>

<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();
Statement stquery=con1.createStatement();

String sql1="",sql2="";

String zonename="", date="", time1="", time2="", zonecode="", type="";
String user=session.getAttribute("usertypevalue").toString();
String entby=session.getAttribute("dispalyname").toString();

/* *********** get all the fields from the form ************* */
zonename=request.getParameter("zonename");
zonecode=request.getParameter("zonecode");
type=request.getParameter("zonetype");

String time=time1+":"+time2+";00";

/* ***************************************************************** */

sql1="select * from t_castrolzones where zonedesc='"+zonename+"' or zonecode='"+zonecode+"'";
ResultSet rs1=stmt1.executeQuery(sql1);
if(rs1.next())
{
	con1.close();
	response.sendRedirect("zonentry.jsp?inserted=yes");
}
else
{	
	sql2="insert into t_castrolzones(zonecode,zonedesc,type)values('"+zonecode+"','"+zonename+"','"+type+"')";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql2.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	
	stmt1.executeUpdate(sql2);
	con1.close();
	response.sendRedirect("zonentry.jsp?inserted=yes");
}	

return; 
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>
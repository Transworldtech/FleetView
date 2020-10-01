<%@ include file="Connections/conn.jsp" %>

   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ page buffer="16kb" %>
<%@page import="java.util.Date"%>
<%@ page buffer="16kb" %>
<%!
Connection con1=null;
%>
<% 
try {
	//String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new java.util.Date());
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stquery=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql;
String owner="",vehno="",sensor="", frzname=""; 
owner= request.getParameter("owner");
System.out.println("owner" +owner);
vehno= request.getParameter("vehno");
System.out.println("vehno" +vehno);
sensor= request.getParameter("sensor");
System.out.println("sensor" +sensor);
frzname= request.getParameter("label");
System.out.println("Freezer name" +frzname);
//String user=session.getValue("user").toString();
String user = session.getAttribute("usertypevalue").toString();
//email=session.getValue("user").toString();

System.out.println("user-->"+user);
//boolean flag=true;
String sql1="select * from db_gps.t_sensorlabels where Tray like '%"+frzname+"%'";
System.out.println("Sql1"+sql1);
rs1=stmt1.executeQuery(sql1);	
if(rs1.next()){
	//flag=false;
	//response.sendRedirect("AlertGoTo.jsp?msg=Label is already inserted for this vehicle "+vehno+".&goto=sensorlabelentry.jsp");
	%>
	<jsp:forward page="AlertGoTo.jsp">
	 <jsp:param name="msg" value="This Label is already Exist  " ></jsp:param>
	  <jsp:param name="goto" value="sensorlabelentry.jsp" ></jsp:param>
	 
	 </jsp:forward>
	 <% System.out.println("after forword");%>
	 
	<% 
	
}else{

System.out.println("1111");

//email=email+","+emailto;

 sql="insert into db_gps.t_sensorlabels (ownername, vehregno,sensor,tray) values('"+user+"','"+vehno+"','"+sensor+"','"+frzname+"')";



System.out.print("sql : "+sql);
//stmt1.executeUpdate(sql);
//String abcd=sql.replace("'","#");
//abcd=abcd.replace(",","$");
stquery.executeUpdate(sql);
String sendmsg="Information Saved Successfully";
//System.out.println("Sendmsg="+sendmsg);
response.sendRedirect("AlertGoTo.jsp?msg=Information Saved Successfully.&goto=sensorlabelentry.jsp");
return;
}
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
} 
%>

<%@page import="java.util.Date"%><%@ include file="Connections/conn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="java.awt.Window"%><html>
<%!
Connection con;
Statement st,stquery;

String tripid="",vehno="";
static int i=1;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cancel Status</title>
</head>
<script type="text/javascript">

function canceltrip()
{
	//alert("in calcel trip");
	//alert(document.cancelform.calcel.value);
	var calceltripval=document.cancelform.calcel.value;
	//alert(calceltripval);
	if(calceltripval==0)
	{
	//	alert("in if");
		document.cancelform.calcel.value=1;
//	alert(document.cancelform.calcel.value);
	//	alert("Trip Cancel Successfully!!!!");
	//	window.close();
	}
}
</script>
<body>
<form name="cancelform"  method="get" >
<div align="center">


<%
try{ 
	
	int canceltrip=0;
String vehid="",vehcode="",servicetype="",servicedate="";

//String vehiclecode=request.getParameter("vehcode");
int cancel=0;
System.out.println("\n\ncalcel--->>"+cancel);
if(i==1)
{	tripid=request.getParameter("tripid");
 vehno=request.getParameter("vehno");
 i++;
}
String rfname=session.getAttribute("rfname").toString(); //.setAttribute("rfname",fnamelist);
String rlname=session.getAttribute("rlname").toString();
String entby=rfname+" "+rlname+"";

System.out.println("\n\nEnt by--->>"+entby);
System.out.println("\n\ntrip id--->>"+tripid);
System.out.println("\n\nveh no--->>"+vehno);
Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con.createStatement();stquery=con.createStatement();
%>
<table>
<tr><td><font size="2"></font>Please click on OK to confirm cancellation<br>Please refresh  page to reflect the changes.</br></td></tr>
<tr><td><input type="hidden" name="calcel" id="calcel" value="<%=cancel %>"> </td></tr>
<tr><td><input type="Submit"  name="OK" value="OK" onclick="canceltrip();"></td></tr> 

</table>
</div>
<br><br><br><br>
<div align="center">
<table>
<tr><td>
<%
String cancelme=request.getParameter("calcel");
System.out.println("\n\n me-->>"+cancelme);
cancel=Integer.parseInt(cancelme);
String cancelsql="";
if(cancel!=0 )
{
	i=1;
	System.out.println("\n\n in if loop ->>");
cancelsql="update t_startedjourney set JStatus='Cancelled',Endedby='"+rfname+" "+rlname+"' where VehRegNo='"+vehno+"' and tripid='"+tripid+"'";
System.out.println("\n\nupdate query-->>"+cancelsql);
String abcd4=cancelsql.replace("'","#");
abcd4=abcd4.replace(",","$");

stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd4+"')");
int j=st.executeUpdate(cancelsql);
System.out.println("\n\nQuery executed sucessfully-->>"+j);
%>
<script type="text/javascript">

	alert("Trip Cancel Successfully!!!!");
		window.close();
	
</script>
<%
//return;
}	
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</td>
</tr>
</table>
</div>
</form>
</body>
</html>
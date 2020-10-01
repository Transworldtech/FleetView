 <%@ include file="Connections/conn.jsp" %>

<%@ page buffer="16kb" %>
<html>
<head>
<title>Vehicle Tracking System</title>
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>

<script src="js/searchhi.js" type="text/javascript"></script>
<%!
Connection con1;
%>
</head>
<body>
<form name="feedbackreply" method="post" action="trainerfeedback.jsp" onSubmit="" >
<table border="0" align="center" width="600px" width="100%"> 
<tr>
		<td><input type="submit" name="Submit1" value="BACK" class="formElement" /></td>
			</tr></table></form>
<form name="feedbackreply" method="post" action="feedbackreplyinsrt.jsp" onSubmit="" >
<% 
try {
String trans=session.getAttribute("usertypevalue").toString();

	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	ResultSet rs1=null,rs2=null,rs=null;
	Statement stmt=con1.createStatement(),stmt1=con1.createStatement(), stmt2=con1.createStatement();
	String sql1="";
	
boolean flag=true;
int i=0;
String date=new SimpleDateFormat("yyMMdd").format(new java.util.Date());
String feedback="",status="";
//String briefid=request.getParameter("brfid");
//String value=request.getParameter("value");

int cntr=Integer.parseInt(request.getParameter("cntr"));
int z=1, m=0 ;

String[] chkbox=new String[cntr];
String[] id = new String[cntr];
String[] brfid = new String[cntr];

%>
<table border="1" align="center" width="600px" width="100%"> 

<%
String[] x = new String[cntr];
%>
<table border="1" align="center" width="600px" width="100%"> 

<tr>
	
	
	<th>DriverName.</th>
	<th>Driverid</th>
	<th>FeedBack</th>
	<th>FeedBack Reply</th>
</tr>
<% 
for(int k=0;k<cntr;k++)
{
	int c=0;
	
			//id[k] = request.getParameter("id"+k );
			brfid[k] = request.getParameter("brifid"+k );
	
		%>	
			   
				<input type="hidden" name="brfid<%=m %>" value="<%=brfid[k] %>" />
				<%
				
				String sql3="select DriverName,Driverid,FeedBack from t_briefing where Briefid ='"+brfid[k]+"'";
			//	System.out.println(sql3);
				 rs=stmt.executeQuery(sql3);
				 while(rs.next())// && (reset==null || reset.equalsIgnoreCase("no")))
				{
				%>
				<tr>
				
				<td style="text-align: left"><%=rs.getString("DriverName")%> </td>
				<td style="text-align: left"><%=rs.getString("Driverid")%> </td>
				<td style="text-align: left"><%=rs.getString("FeedBack")%> </td>
				<%
				
				%>
					<td align="center" colspan=""><textarea name="feedbackreply<%=m %>" class="formElement"/> </textarea></td>
				</tr>
<%	
			z++;
			m++;
			}
}
%>
			<tr>
						<td align="center" colspan="15"><input type="submit" name="Submit" value="Submit" class="formElement" />
						</td>
			</tr>	
			
			</table>
			</table>
			<input type="hidden" name="cntr" value="<%=z %>"></input>
<%

}catch(Exception e) { out.println("Exception----->" +e); }

%>
</form>
</body>
</html>
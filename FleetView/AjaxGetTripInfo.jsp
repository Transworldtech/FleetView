<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql="",startplace="",endplace="";
String username,startendloc="";
username=session.getAttribute("usertypevalue").toString();
//out.print(username);
//sql="select distinct(Rcode) from t_routedetails where Owner='"+username+"'";
//ResultSet rst=stmt1.executeQuery(sql);
%>
<!--<select name="routename" id="routename" class="formElement" onchange="fun2(this);">-->
<!--<option value="Select">Select</option>-->
<%
//while(rst.next())
//{
	%>
<!--		<option value='< %=rst.getString("RCode")%>'>< %=rst.getString("RCode")%></option>	-->
	<%
//}
%>
<!--</select>-->
<% 
sql="select distinct StartPlace,EndPlace,RouteCode from db_gps.t_castrolroutes where Owner='"+username+"' order by StartPlace,EndPlace asc";
ResultSet rst=stmt1.executeQuery(sql);
%>
<select  name="routename" id="routename" style="width: 400px;" class="element select medium" onchange="fun2(this);">
<option value="Select">Select</option>
<%
int couter=1;
while(rst.next())
{

	startendloc=rst.getString("StartPlace")+"/"+rst.getString("EndPlace");
	%>
		<option value='<%=startendloc+ "/ "
								+ rst.getString("Routecode") + " /"%>'><%=startendloc + "/ "
								+ rst.getString("Routecode") + " /"%></option>	
	<%
//	String buffer=startendloc+couter;
//	System.out.println("buffer ------>"  +buffer);
//	out.print(buffer);
//	couter++;
}

%>
</select>
<%

} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>






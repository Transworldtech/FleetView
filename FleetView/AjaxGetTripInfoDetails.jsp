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
String sql="",tripcode1="";
String username,tripcode;
tripcode=request.getParameter("tripid");

tripcode1=request.getParameter("tripid1");
System.out.println("tripcode-------------->"  +tripcode);
System.out.println("tripcode1-------------->"  +tripcode1);
username=session.getAttribute("usertypevalue").toString();
System.out.println("username-------------->"  +username);
//out.print(tripcode);
//sql="select * from t_routeorderpoints where RCode='"+tripcode+"' order by PointOrder asc";
sql="select * from t_castrolroutes where StartPlace='"+tripcode+"' and EndPlace='"+tripcode1+"' ";
ResultSet rst=stmt1.executeQuery(sql);
System.out.println("castrol000000000000000000--------------->"  +sql);
int i=1;
String loc="";
while(rst.next())
{
	if(i==1)
	{
	loc=rst.getString("StartPlace");
	}
	else
	{
		loc=loc+"#"+rst.getString("StartPlace");
	}
	
	i++;
}
//sql="select * from t_routedetails where RCode='"+tripcode+"'";
sql="select * from t_castrolroutes where StartPlace='"+tripcode+"' and EndPlace='"+tripcode1+"' and Owner='"+username+"' limit 1";
ResultSet rst1=stmt1.executeQuery(sql);
System.out.println("castrol--------------->"  +sql);
//int i=1;
String fixectime="";
String fixecdist="";
if(rst1.next())
{
	
	fixectime=rst1.getString("TTime");
	fixecdist=rst1.getString("Km");
	
}
out.print(loc+"#"+fixectime+"#"+fixecdist);
} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
//System.out.println("Page Called");
ResultSet rs1=null;
String sql="";
String startloc,endloc,username;
String km="0",tt="0";
startloc=request.getParameter("StartPlace");
endloc=request.getParameter("EndPlace");
//System.out.println("Start Place"+startloc);
//System.out.println("End Place"+endloc);
username=session.getAttribute("user").toString();
//out.print(tripcode);

sql="SELECT * FROM db_gps.t_castrolroutes where StartPlace='"+startloc+"' and EndPlace='"+endloc+"' || StartPlace='"+endloc+"' and EndPlace='"+startloc+"'";
//System.out.println("sql"+sql);
ResultSet rst=stmt1.executeQuery(sql);
int i=1;
String loc="test";
if(rst.next())
{
	km=rst.getString("Km");
	tt=rst.getString("TTime");
}
///System.out.println("km"+km+"test");
//System.out.println("tt"+tt);

out.print(i+"#"+km+"#"+tt);

} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>
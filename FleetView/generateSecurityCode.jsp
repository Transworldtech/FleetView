 <%@ include file="Connections/conn.jsp" %>

<%@ page buffer="16kb" %>

<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
ResultSet rs1=null,rs2=null,rs=null;
Statement stmt=con1.createStatement(),stmt1=con1.createStatement(), stmt2=con1.createStatement();
Statement stquery=con1.createStatement();
String sql1="";
String user=session.getAttribute("dispalyname").toString();
boolean flag=true;
String date=new SimpleDateFormat("yyMMdd").format(new java.util.Date());
String securecode="";
String sql3="select *  from t_sessions where Username='"+user+"' and SecutiryCode <>'-'";
String reset=request.getParameter("reseter");
rs=stmt.executeQuery(sql3);
 if(rs.next() && (reset==null || reset.equalsIgnoreCase("no")))
{
	securecode=rs.getString("SecutiryCode");
	response.sendRedirect("SecurityCode.jsp?securecode="+securecode);
	return; 
}
else
{
while (flag)
{
	Random rand = new Random();
	int min=1000, max=9999;
	int randomNum = rand.nextInt(max - min + 1) + min;
	String num = ""+randomNum;
	securecode =securecode.concat(num);
	securecode =securecode.concat(date);
	
String sql="select SecutiryCode from t_sessions where SecutiryCode='"+securecode+"'"; 
rs1=stmt2.executeQuery(sql);
if(rs1.next())
{
	flag=true;
}
else
{
	flag = false;
}
}
sql1="update t_sessions  set SecutiryCode='"+securecode+"'  where Username='"+user+"'";

/*Query to insert query in db_gps.t_sqlquery table*/
String abcd=sql1.replace("'","#");
abcd=abcd.replace(",","$");
stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
/*****************************/

stmt1.executeUpdate(sql1);

response.sendRedirect(request.getContextPath()+"/Sendingmails?user="+user+"&SecutiryCode="+securecode);
return; 
}
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
} 

  
%>

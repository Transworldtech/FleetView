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
String rfname="",rlname="";
java.util.Date dte = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
String today=formatter.format(dte);
rfname=session.getAttribute("rfname").toString(); //.setAttribute("rfname",fnamelist);
rlname=session.getAttribute("rlname").toString();
//System.out.print(rfname+""+rlname);
//",lastnamelist);
String sql1="";
String trans=session.getAttribute("usertypevalue").toString();
int cntr=Integer.parseInt(request.getParameter("cntr"))-1;

//System.out.print(briefid);
boolean flag=true;
//int i=0;
String date=new SimpleDateFormat("yyMMdd").format(new java.util.Date());
String status="";

for(int i=0; i<cntr; i++)
{
	String briefid=request.getParameter("brfid"+i);
	String feedback=request.getParameter("feedbackreply"+i);
	//System.out.println(briefid);
	//System.out.println(feedback);
	
	sql1="Update t_briefing set ReplyFeedBack='"+feedback+"',TicketStatus='Closed',RFDate='"+today+"',ReplyFrom='"+rfname+rlname+"' where Briefid='"+briefid+"'";

/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	
/*****************************/ 
	
	stmt.executeUpdate(sql1);
}
 
 response.sendRedirect("trainerfeedback.jsp");

}catch(Exception e) { out.println("Exception----->" +e); }

finally
{
con1.close();
} 
%>

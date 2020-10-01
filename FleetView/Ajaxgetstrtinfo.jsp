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
String sql1="";
String veh=request.getParameter("veh");
String user=session.getValue("usertypevalue").toString();

   
   sql1="select * from t_startedjourney where OwnerName='"+user+"' and JStatus='Running' and VehRegNo='"+veh+"' ";
   //out.print(sql1);
   rs1=stmt1.executeQuery(sql1);
   
   while(rs1.next())
   {
       out.println(rs1.getString("StartPlace")+ "$#");
       out.println(rs1.getString("StartDate")+ "$#");
       out.println(rs1.getString("EndPlace")+ "$#");
       out.println(rs1.getString("DriverCode")+ "$#");
       out.println(rs1.getString("DriverName")+ "$#");
       out.println(rs1.getString("TripId")+ "$#");
       out.println(rs1.getString("StartTime"));
      
   }


} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>

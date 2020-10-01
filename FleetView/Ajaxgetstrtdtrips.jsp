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
String stloc="";
String user=session.getValue("usertypevalue").toString();

   out.println("<select name='veh' class='formElement' onChange='showstloc(this);'>");
   out.print("<option value='Select'>Select</option>"); 
   sql1="select * from t_startedjourney where OwnerName='"+user+"' and JStatus='Running' order by VehRegNo asc";
   rs1=stmt1.executeQuery(sql1);
   
   while(rs1.next())
   {
      stloc=rs1.getString("StartPlace");
      out.println("<option value='"+rs1.getString("VehRegNo")+"'> "+rs1.getString("VehRegNo")+" </option> " );
      
   }
out.println("</select>");


} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>

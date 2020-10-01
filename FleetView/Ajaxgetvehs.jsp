<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>

<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2="";
String typuser="";
String user=session.getValue("usertypevalue").toString();


   out.println("<select name='veh' class='formElement'> ");
   out.print("<option value='Select'>Select</option>"); 

  sql2="select TypeofUser from t_security where TypeValue='"+user+"' ";
  //out.print(sql2);
  rs2=stmt1.executeQuery(sql2);
   if(rs2.next())
   {
      typuser=rs2.getString("TypeofUser");
   } 


  if(typuser.equals("Transporter")) 
  { 
     sql1="select VehicleRegNumber as vehreg from t_vehicledetails where OwnerName='"+user+"'  ";
     rs1=stmt1.executeQuery(sql1);
  }
  else
  { 
     sql1="select transporter as vehreg from t_group where GPName='"+user+"' order by transporter asc ";
     rs1=stmt1.executeQuery(sql1);
  }

/*   sql1="select * from t_vehicledetails where OwnerName='"+user+"' ";
   out.print(sql1);
   rs1=stmt1.executeQuery(sql1); */
   
   while(rs1.next())
   {
      out.println("<option value='"+rs1.getString("vehreg")+"'> "+rs1.getString("vehreg")+" </option> " );
   }
out.println("</select>");


} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>

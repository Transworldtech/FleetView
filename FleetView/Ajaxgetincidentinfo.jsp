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
String srno=request.getParameter("srno");
sql1="select * from yearlyinfo1 where SrNo='"+srno+"'";
rs1=stmt1.executeQuery(sql1);
if(rs1.next())
{
  %>
  <br>
<table class="stats">
<tr>
<td class="hed">Origin :-</td><td><div align="left"><%=rs1.getString("origin")%></div></td>
<td class="hed">Incident Date :</td><td><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rs1.getDate("AccDate"))+" "+rs1.getString("Time")%></div></td>
</tr>
<tr>
<td class="hed">Discription :-</td><td><div align="left"><%=rs1.getString("Description")%></div></td>
<td class="hed">BU :-</td><td><div align="left"><%=rs1.getString("BU")%></div></td>
</tr>
<tr>
<td class="hed">Location :-</td><td><div align="left"><%=rs1.getString("Location")%></div></td>
<td class="hed">Transpoter Tyle :-</td><td><div align="left"><%=rs1.getString("Transporter")%></div></td>
</tr>
<tr>
<td class="hed">Type Of Vehicle :-</td><td><div align="left"><%=rs1.getString("TypeOfVehicle")%></div></td>
<td class="hed">Type Of Incident :-</td><td><div align="left"><%=rs1.getString("TypeOfAccident")%></div></td>
</tr>
<tr>
<td class="hed">Work Force Fatality :-</td><td><div align="left"><%=rs1.getString("WorkForceFacility")%></div></td>
<td class="hed">Work Force Injury :-</td><td><div align="left"><%=rs1.getString("WorkForceInjury")%></div></td>
</tr>
<tr>
<td class="hed">Third Party Fatality :-</td><td><div align="left"><%=rs1.getString("thirdPartyFacility")%></div></td>
<td class="hed">Transporter  :-</td><td><div align="left"><%=rs1.getString("TransporterNm")%></div></td>
</tr>
</table>  
<%
}
} catch(Exception e) {out.println(e);}
finally
{
con1.close();
}

%>






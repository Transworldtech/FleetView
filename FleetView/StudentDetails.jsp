 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <script language="javascript">

</script>


<%!
Connection con1;
%>



<% 
try {
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
	Statement stmt1=con1.createStatement();
	String user=session.getValue("usertypevalue").toString();
	java.util.Date d=new java.util.Date();
	String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String inserted=request.getParameter("inserted");
	String studname=request.getParameter("studname");
	String studid=request.getParameter("studid");
%>
		<form name="studentdetails" method="post" action="InsertStudentDetailsEntry.jsp" onSubmit="return validate();" >
		<table border="1" width="100%" class="stats">
  		      <tr>
		        <td> <div align="center"> <font size="3"> <b> Student details</b> </font> </div> </td>
		    </tr>
			
				</table>	
					<table border="1" width="100%" class="sortable">	
  		     				<tr>
  		     					<td class="hed"><b>Srno</b></td>
  		     					<td class="hed"><b>Student ID</b></td>
  		     					<td class="hed"><b>Card ID</b></td>
  		     					<td class="hed"><b>Student Name</b></td>
  		     					<td class="hed"><b>School</b></td>
  		     					<td class="hed"><b>DOB</b></td>
  		     					<td class="hed"><b>Class</b></td>
  		     					<td class="hed"><b>Address</b></td>
  		     					<td class="hed"><b>Guardian</b></td>
  		     					<td class="hed"><b>Contact</b></td>
  		     					<td class="hed"><b>Relation</b></td>
								<td class="hed"><b>Enrolled Date</b></td>
  		     					<td class="hed"><b>Entered By</b></td>
  		     					
  		     				</tr>
  							
  							<%
							int i=1;
  							String sql="select * from t_studentdetails order by Studentname ";
  							ResultSet rs1=stmt1.executeQuery(sql);
  							while(rs1.next())
  							{
  							String	studentname=rs1.getString("StudentName");
  							String	StudentID=rs1.getString("StudentID");
  							String	CardID=rs1.getString("CardID");
  							String	School=rs1.getString("School");
  							String	DOB=rs1.getString("DOB");
  							String	Standard=rs1.getString("Standard");
  							String	Address=rs1.getString("Address");
  							String	Parent=rs1.getString("Parent");
  							String	Contact=rs1.getString("Contact");
  							String	Relation=rs1.getString("Relation");
  							String	entby=rs1.getString("entby");
  							String	updatedDateTime=rs1.getString("updatedDateTime");
  							
  							
  							%>
  							   <tr>
  							    <td><%=i%></td>
  							    <td><%=StudentID%></td>
  		     					<td><%=CardID%></td>
  		     					<td><a href="editstudentdetails.jsp?CardID=<%=CardID%>&StudentID=<%=StudentID%>"> <%=studentname%></a></td>
  		     					<td><%=School%></td>
  		     					<td><%=DOB%></td>
  		     					<td><%=Standard%></td>
  		     					<td><%=Address%></td>
  		     					<td><%=Parent%></td>
  		     					<td><%=Contact%></td>
  		     					<td><%=Relation%></td>
								<td><%= updatedDateTime%></td>
  		     					<td><%=entby%></td>
  		     					
  		     				</tr>
  							<%
  							i++;}
  							
  							
  							%>
  							
  						
    					
</table>
 </form>
<% } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
	<% //fleetview.closeConnection(); %>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>


</body>
</html>

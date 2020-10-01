 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>

<%!
Connection con1;
%>



<% 
try {
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
Statement stmt1=con1.createStatement();
ResultSet rs2=null, rs3=null, rs4=null, rs5=null,rs33=null;
String sql2="", sql3="", sql4="", sql5="",sql33="";
String vehno="", prvdid="",lastdriverid="", lastdrivername="";

//vehno=request.getParameter("vehno");


String user=session.getValue("usertypevalue").toString();

java.util.Date d=new java.util.Date();
//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
String StudentID=request.getParameter("StudentID");
String CardID=request.getParameter("CardID");
String inserted=request.getParameter("inserted");
String studname=request.getParameter("studname");
String studid=request.getParameter("studid");
 //java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
  // Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   
%>
		<table border="0" width="100%" class="stats">
  		      <tr>
		         <td> <div align="center"> <font  size="3"> <b> Student details</b> </font> </div> </td>
		    </tr>
		  
<tr><td colspan="2">
<form name="studentdetails" method="get" action="inserteditstudentdetails.jsp" onSubmit="return validate();" >
	<%
	String sql="select * from t_studentdetails where CardID='"+CardID+"'";
	System.out.println(sql);
		ResultSet rs1=stmt1.executeQuery(sql);
		if(rs1.next()){
	%>
	
	<table border="0" width="70%" align="center" class="sortable_entry">
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Card ID</b></div></font></td>
  		     	<td><input type="text" name="studentid"  value="<%=rs1.getString("CardID")%>" id="studentid"/>
  		     	<input type="hidden" name="srno"  value="<%=rs1.getString("StudentID")%>" id="srno"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Full Name</b></div></font></td>
  		     	<td><input type="text" name="fullname"  value="<%=rs1.getString("StudentName")%>" id="fullname"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Date of Birth</b></div></font></td>
  		     	<td>
  		     		<input type="text" id="calender" name="calender" size="13" value="<%=rs1.getString("DOB")%>" readonly  />
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender"       // ID of the button
             }
                           );
             </script>
  		     	</td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Student is in class </b></div></font></td>
  		     	<td><input type="text" name="class"  value="<%=rs1.getString("Standard")%>" id="class"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>School Name </b></div></font></td>
  		     	<td><input type="text" name="school"  value="<%=rs1.getString("school")%>" id="school"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Gender></b></div></font></td>
  		     	<td>
  		     		 <select name="gender" id="gender" onchange="funprsentser();">
  		     			<option value="<%=rs1.getString("gender")%>"><%=rs1.getString("gender")%></option>
  		     			<option value="male">MALE</option>
				 		<option value="female">FEMALE</option>
				 	 </select>
				 </td>
  		     </tr>
  		      <tr>
  		     	<td><font  size="2"><div align="right"><b>Parent Name </b></div></font></td>
  		     	<td><input type="text" name="parent"  value="<%=rs1.getString("Parent")%>" id="class"/></td>
  		     </tr>
  		      <tr>
  		      <td colspan="2" align="center"><div align="center">Please enter comma sepetated mobile number.</div></td>
  		      </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Parent Contact no-</b></div></font></td>
  		     	<td><input type="text" name="contact"  value="<%=rs1.getString("Contact")%>" id="contact"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Address</b></div></font></td>
  		     	<td><textarea name="address" id="address"/><%=rs1.getString("Address")%></textarea></td>
  		     </tr>
 			<tr>
  		     	<td><font  size="2"><div align="right"><b>Contact persons relationship with student</b></div></font></td>
  		     	<td><input type="text" name="relation"  value="<%=rs1.getString("Relation")%>" id="relation"/></td>
  		     </tr>
<!--*************-->
<%
		}

%>
		
	        

	<tr>
      		<td colspan="2" align="center"> <div align="center"><input type="submit" name="submit" id="submit" value="submit"></div> </td>
  	</tr>
  	
  
      </table>
</form>  
</td></tr></table>

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




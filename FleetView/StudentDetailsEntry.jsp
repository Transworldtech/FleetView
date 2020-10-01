 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <script language="javascript">
function validate(){

	//alert("in validate");
	
	var stud=document.studentdetails.studentid.value;
	//alert(stud);
	if(stud==null||stud==""){
		alert("Please enter student id");
		return false;
	}
	var fullname=document.studentdetails.fullname.value;
	//alert(fullname);
	if(fullname==null||fullname==""){
		alert("Please enter student full name");
		return false;
	}
	var parent=document.studentdetails.parent.value;
	//alert(parent);
	if(parent==null||parent==""){
		alert("Please enter Guardians details");
		return false;
	}
	var contact=document.studentdetails.contact.value;
	//alert(contact);
	if(contact==null||contact==""){
		alert("Please enter contact number");
		return false;
	}
	var address=document.studentdetails.address.value;
	//alert(address);
	if(address==null||address==""){
		alert("Please enter address");
		return false;
	}
	var relation=document.studentdetails.relation.value;
	//alert(relation);
	if(relation==null||relation==""){
		alert("Please enter relation with student");
		return false;
	}
	var class1=document.studentdetails.class1.value;
	//alert(class1);
	if(class1==null||class1==""){
		alert("Please enter class");
		return false;
	}
	var school=document.studentdetails.school.value;
	//alert(school);
	if(school==null||school==""){
		alert("Please enter school name");
		return false;
	}
	var gender=document.getElementById(gender);
	//alert(gender);
	if(document.studentdetails.gender[0].checked==false && document.studentdetails.gender[1].checked==false)
	{
		alert("Please select gender as a MALE or FEMALE");
		return false;
	}	
	
	
	 
	
}
</script>


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

String inserted=request.getParameter("inserted");
String studname=request.getParameter("studname");
String studid=request.getParameter("studid");
 //java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
  // Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   
%>
		<table border="0" width="100%" class="stats">
  		      <tr>
		         <td> <div align="center"> <font size="3"> <b> Student details entry form</b> </font> </div> </td>
		    </tr>
		    <%
		    if(inserted==null)
		    {
		    }
		    else
		    { %>
		        <tr> <td><table border="0" width="100%" class="stats">
		    <tr>
		         <td> <div align="center"> <font>  <b>Inserted Successfully </b> </font> </div> </td>
		    </tr>
		    </table>
		      </td>
		      </tr>
		    <%}
		    %>
		     <%
		    if(studname==null)
		    {
		    }
		    else
		    { %>
		         <tr>
		         <td><table border="0" width="100%" class="stats">
		    <tr>
		         <td colspan="2"> <div align="center"> <font>  <b>Card ID <%=studid %> is already entered with name <%=studname %></b> </font> </div> </td>
		    </tr>
		    </table>
		      </td>
		      </tr>
		    <%}
		    %>
		    
		  
<tr><td colspan="2">
<form name="studentdetails" method="post" action="InsertStudentDetailsEntry.jsp" onSubmit="return validate();" >
	
	
	<table border="0" width="70%" align="center" class="sortable_entry">
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Card ID -</b></div></font></td>
  		     	<td><input type="text" name="studentid" id="studentid"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Full Name -</b></div></font></td>
  		     	<td><input type="text" name="fullname"  value="" id="fullname"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Date of Birth -</b></div></font></td>
  		     	<td>
  		     		<input type="text" id="calender" name="calender" size="13" value="<%=nwfrmtdte%>" readonly  />
  
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
  		     	<td><font  size="2"><div align="right"><b>School Name -</b></div></font></td>
  		     	<td><input type="text" name="school"  value="" id="school"/></td>
  		     </tr>
  		     
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Class -</b></div></font></td>
  		     	<td><input type="text" name="class1"  value="" id="class1"/></td>
  		     </tr>
  		    
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Gender -</b></div></font></td>
  		     	<td>	<input type="radio" name="gender" id="gender" value="male">MALE
  		     	<input type="radio" name="gender" id="gender" value="female">FEMALE
  		     		 
				 </td>
  		     </tr>
  		      <tr>
  		     	<td><font  size="2"><div align="right"><b>Guardian/Parent Name -</b></div></font></td>
  		     	<td><input type="text" name="parent"  value="" id="class"/></td>
  		     </tr>
  		      <tr>
  		      <td colspan="2"><div align="right">For multiple contact details,separate it by comma.</div></td>
  		      </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Contact no-</b></div></font></td>
  		     	<td><input type="text" name="contact"  value="" id="contact"/></td>
  		     </tr>
  		     <tr>
  		     	<td><font  size="2"><div align="right"><b>Address-</b></div></font></td>
  		     	<td><textarea name="address" id="address"/></textarea></td>
  		     </tr>
 			<tr>
  		        <td><font  size="2"><div align="right"><b>Relation with Student</b></div></font></td>
  		     	<td><input type="text" name="relation"  value="" id="relation"/></td>
  		     </tr>
<!--*************-->

		
	        

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


</body>
</html>

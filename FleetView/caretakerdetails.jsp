 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <script language="javascript">
function validate()
{
	var name=document.studentdetails.name.value;
	//alert(name);
	if(name==null||name==""){
		alert("Please enter full name");
		return false;
	}
	var contact=document.studentdetails.contact.value;
	//alert(contact);
	if(contact==null||contact==""){
		alert("Please enter contact details");
		return false;
	}
	var address=document.studentdetails.address.value;
	//alert(address);
	if(address==null||address==""){
		alert("Please enter address");
		return false;
	}
	var vehno=document.studentdetails.vehno.value;
	//alert(vehno);
	if(vehno=="select"){
		alert("Please select vehicle number");
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
		         <td> <div align="center"> <font  size="3"> <b> Care taker entry form</b> </font> </div> </td>
		    </tr>
		    <%
		    if(inserted==null)
		    {
		    }
		    else
		    { %>
		        <tr> <td><table border="0" width="100%" class="stats">
		    <tr>
		         <td> <div align="center"> <font >  <b>Inserted Successfully </b> </font> </div> </td>
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
		         <td> <div align="center"> <font >  <b>Student ID <%=studid %> is already entered with name <%=studname %></b> </font> </div> </td>
		    </tr>
		    </table>
		      </td>
		      </tr>
		    <%}
		    %>
		    
		  
<tr><td colspan="2">
<form name="studentdetails" method="get" action="insertcaretakerdetails.jsp" onSubmit="return validate();" >
	
	
	<table border="0" width="70%" align="center" class="sortable_entry">
  		     <tr >
  		     	<td><font  size="2"><div align="right"><b>Name</b></div></font></td>
  		     	<td><input type="text" name="name"  value="" id="name"/></td>
  		     </tr>
  		     <tr >
  		     	<td><font  size="2"><div align="right"><b>Contact</b></div></font></td>
  		     	<td><input type="text" name="contact"  value="" id="contact"/></td>
  		     </tr>
  		     <tr >
  		     	<td><font  size="2"><div align="right"><b>Date of Birth</b></div></font></td>
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
  		     
  		     <tr >
  		     	<td><font  size="2"><div align="right"><b>Address</b></div></font></td>
  		     	<td><textarea name="address" id="address"/></textarea></td>
  		     </tr>
 			<tr >
  		     	<td><font  size="2"><div align="right"><b>Vehicle NO</b></div></font></td>
  		     	 <td><select name="vehno" id="vehno" onchange="funprsentser();">
  		     	 <option value="select">SELECT</option>
  		     	<%
  		     	String sql="select * from t_vehicledetails where OwnerName='VIBGYOR'";
  		     	ResultSet rs=stmt1.executeQuery(sql);
  		     	if(rs.next()){
  		     		%>
  		     		<option value="<%=rs.getString("VehicleRegNumber")%>"><%=rs.getString("VehicleRegNumber")%></option>
  		     		<%
  		     	}
  		     	
  		     	%>
  		     	</select></td>
  		     </tr>
<!--*************-->

		
	        

	<tr >
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

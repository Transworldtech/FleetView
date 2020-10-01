<%@ include file="headernew.jsp" %>
  
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
%>
<script LANGUAGE="JavaScript">

</script>


<%! 
Connection con1, con2;
%>


<form name="addgrpform" method="get" action="insrtempname.jsp" onSubmit="">

<%
try
{	
	
	 //System.out.println("control inside confirm query =========");
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con1.createStatement();
	
	 String empcode = "-",empid = "-",empname="-",hod = "-";
	 String email = "-",location = "-",designation = "-",phno = "-",oldusername="",oldmanagername="",rsmname="";
	
	 String OwnerName=request.getParameter("owner");
	 String vehcles=request.getParameter("vehcles");
	 String grp=request.getParameter("grp");
	 
	 String oldempcode=request.getParameter("oldempcode");
	 
	 //System.out.println("OwnerName=====if loop===   "+OwnerName);
	 //System.out.println("vehcles=====if loop===   "+vehcles);
	 //System.out.println("grp====if loop===   "+grp);
	 
	 //System.out.println("oldempcode===   "+oldempcode);
	 
	 
	 String checkstatus = request.getParameter("checkstatus");
	 if(checkstatus == "Yes" || checkstatus.equalsIgnoreCase("Yes"))
	 {
		 empname=request.getParameter("empname");
		 System.out.println("empcode in confirmation page empname========   "+empname);
		 empcode=request.getParameter("empcode");
		 empid=request.getParameter("newempid");
		 hod = request.getParameter("newHOD");
		 email = request.getParameter("email");
		 location = request.getParameter("loc");
		 designation = request.getParameter("deg");
		 phno = request.getParameter("phno");		
		 oldusername=request.getParameter("oldusername");
		 oldmanagername=request.getParameter("oldmanagername");
		 rsmname=request.getParameter("oldRSMname");
		 System.out.println("empcode in confirmation page rsmname=====if loop===   "+rsmname);
		 //System.out.println("empname in confirmation page=====if loop===   "+empname);
		 
		 
	 }
	 else
		 if(checkstatus == "No" || checkstatus.equalsIgnoreCase("No"))
		 {
			 
			 System.out.println(" else if loop[========   ");
			 
			 empid = request.getParameter("empid");
			 String sql = "select firstname,lastname from db_gps.t_userdetails where username ='"+empid+"'";
			 //System.out.println("sql   "+sql);
			 ResultSet rs = stmt.executeQuery(sql);
			 if(rs.next())
			 {
				 empname = rs.getString("firstname")+" "+rs.getString("lastname");
				 System.out.println("empname:-"+empname);
			 }
			 
			 
			 
			 //System.out.println(" else if loop empname========   "+empname);
			 String oldempname=request.getParameter("oldempname");
			 empname=oldempname;
			 //sql = "select empcode from db_gps.t_empAllocationHistory where empname = '"+empname+"' and VehNo='"+vehcles.trim()+"' ";
			
			 sql = "select empcode from db_gps.t_vehicledetails where empname = '"+empname+"' and Vehicleregnumber='"+vehcles.trim()+"' ";
			 
			 //System.out.println("sql1 empcode  "+sql);
			 rs = stmt.executeQuery(sql);
			 if(rs.next())
			 {
				 empcode = rs.getString("empcode");
			 }
			
			 
			 
			 empcode=oldempcode;
			 hod = request.getParameter("oldHOD");
			 if(hod == null || hod.equals("null") || hod == "" || hod.equals(""))
			 {
				 hod = request.getParameter("newHOD");
			 }
		 }
	
	 
	 //System.out.println("empcode in confirmation page========   "+empcode);
	 rsmname=request.getParameter("oldRSMname");
	 oldusername=request.getParameter("oldusername");
	 System.out.println("empcode in confirmation page rsmname=====if loop===   "+rsmname);
	 oldmanagername=request.getParameter("oldmanagername");
	 String oldempname=request.getParameter("oldempname");
	 
	 System.out.println("empcode in confirmation page oldempname========   "+oldempname);
	 String calender=request.getParameter("calender");
	%>
	
<br></br>
<table border="0" width="750px" bgcolor="#e3e9ff" align="center" class="sortable_entry">
		
		<tr>
		
			<td colspan="4" align="center"><font size="3" color="#2A0A12" ><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>CONFIRM EMPLOYEE DETAILS</b><br>
		<br>  </font></td>
		</tr>
		
</table>
<table border="0" width="750px" bgcolor="#e3e9ff" align="center" class="sortable_entry">
	<tr bgcolor="#e3e9ff">
       <td> <font color="black"><b> Owner Name: </b></font> </td>
       <td><b><%=OwnerName %></b></td>
 	</tr>
   <tr bgcolor="#e3e9ff">
      <td>  <font color="black"><b>Vehicles :</b> </font> </td>
      <td><b><%=vehcles %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Emp Name :</b> </font> </td>
     <td><b><%=empname %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Emp Code :</b> </font> </td>
     <td><b><%=empcode %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>User Name :</b> </font> </td>
     <td><b><%=oldusername %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Manager Name :</b> </font> </td>
     <td><b><%=oldmanagername %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>RSM Name : </b> </font> </td>
     <td><b><%=rsmname %></b></td>
  </tr>
  <%
  if(checkstatus == "Yes" || checkstatus.equalsIgnoreCase("Yes"))
  {
	  %>
	  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>HOD :</b> </font> </td>
     <td><b><%=hod %></b></td>
  </tr>
	  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Email ID :</b> </font> </td>
     <td><b><%=email %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Contact No :</b> </font> </td>
     <td><b><%=phno %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Designation :</b> </font> </td>
     <td><b><%=designation %></b></td>
  </tr>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Location :</b> </font> </td>
     <td><b><%=location %></b></td>
  </tr>
	  <%
  }
  %>
  <tr bgcolor="#e3e9ff">
     <td>  <font color="black"><b>Allocation Date :</b> </font> </td>
     <td><b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MMM-yyyy").parse(calender))%></b></td>
  </tr>
  
  
 
  <tr>
	 <td colspan="2" align="center">
	 	 <input type="hidden" name="owner" value="<%=OwnerName %>" />
  		 <input type="hidden" name="vehcles" value="<%=vehcles %>" />	
 		 <input type="hidden" name="empname" value="<%=empname %>" />		
 		 <input type="hidden" name="empcode" value="<%=empcode %>" />
 		 <input type="hidden" name="empid" value="<%=empid %>" />
 		 <input type="hidden" name="oldempname" value="<%=oldempname%>" />
 		 <input type="hidden" name="oldusername" value="<%=oldusername%>" />
 		 <input type="hidden" name="oldmanagername" value="<%=oldmanagername%>" />
 		 <input type="hidden" name="rsmname" value="<%=rsmname %>" />	
 		 <input type="hidden" name="allocationDate" value="<%=calender%>" />
 	     <input type="hidden" name="hod" value="<%=hod%>" /> 
 		 <input type="hidden" name="email" value="<%=email%>" />
 		 <input type="hidden" name="location" value="<%=location%>" />
 		 <input type="hidden" name="designation" value="<%=designation%>" />
 		 <input type="hidden" name="phno" value="<%=phno%>" />	
 		 <input type="hidden" name="checkstatus" value="<%=checkstatus%>" />
	 	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 	 <input type="submit" name="Submit" value="Submit" class="formElement"">
	 </td>
 </tr>
</table>
<%
}
catch(Exception e)
{
	out.print("Exception --->"+e);
}

%>


</form>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>

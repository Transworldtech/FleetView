
<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Connection conn1;

%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script LANGUAGE="JavaScript"><!--
	function validate()
	{
		
		var firstName=document.editEmpName.firstName.value;
		var lastName=document.editEmpName.lastName.value;
		var vehType=document.editEmpName.vehType.value;
		var empCode=document.editEmpName.empCode.value;
		var mobileNo=document.editEmpName.mobileNo.value;

		
		if(firstName.length==0)
	     {
	         alert("Please enter first name");
	         return false;
	     } 

		if(lastName.length==0)
	     {
	         alert("Please enter last name");
	         return false;	
	     } 

//		if(vehType.length==0)
//	     {
//	         alert("Please enter vehicle type");
//	         return false;
//	     } 

//		if(empCode.length==0)
//	     {
//	         alert("Please enter employee code");
//	         return false;
//	     } 


//		if(mobileNo.length==0)
//	     {
//	         alert("Please enter mobile no");
//	         return false;
//	     } 
	}	
	
</script>
</head>
<body>
		<form name="editEmpName" action="insertEmpName.jsp" onSubmit="return validate();">

		<table border="0" width="50%" align="center" class="sortable_entry">
			<tr>
		<td colspan="2">
		<div align="center"><font size="3"> <b>
		Edit Employee Name </b> </font> (<font color="red"> *</font> indicates mandatory
		fields)</div>
		</div>
		</td>
		</tr>
<%
String vehcode=request.getParameter("vehcode");


Class.forName(MM_dbConn_DRIVER);
Connection con1;
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt=con1.createStatement();
Statement stmt2=con1.createStatement();
ResultSet st, rst2;

String empName="", vehiclecode="", FirstName="", LastName="", Vehid="", Empcode="", MobilePhNo="", vehtype="";

String sql="select Empname, vehiclecode, Empcode, MobilePhNo, vehtype from t_vehicledetails where vehiclecode="+vehcode+"  limit 1 ";
System.out.println(" sql 1 "+sql);
ResultSet rs=stmt.executeQuery(sql);
int i=0;
while(rs.next())
{
		 empName=rs.getString("Empname");
		 vehiclecode=rs.getString("vehiclecode");
		 Empcode=rs.getString("Empcode");
		 MobilePhNo=rs.getString("MobilePhNo");
		 vehtype=rs.getString("vehtype");
		 
		 
		 System.out.println(" empName "+empName+" vehiclecode "+vehiclecode);
}

String sql2="select Vehid,FirstName, LastName   from db_gps.t_userdetails  where Vehid="+vehcode;
System.out.println(" sql 2 "+sql2);
rst2=stmt2.executeQuery(sql2);
while(rst2.next())
{
	FirstName=rst2.getString("FirstName");
	LastName=rst2.getString("LastName");
	Vehid=rst2.getString("Vehid");
	System.out.println(" FirstName "+FirstName+" LastName "+LastName+" Vehid "+Vehid);
}	
%>	

<input type="hidden" id="vehcode" name="vehcode" value="<%= vehcode %>" > </input>
		<tr>
				<td>
				</td>
		</tr>
		<tr>
				<td><font size="2"><b> Employee Name : </b> </font></td>
				<td><font size="2"><%= empName %> </font></td>
	   </tr>
		
		<tr>
				<td><font size="2"><b> First Name : </b> </font> <font color="red">* </font>  </td>
				<td><input type="text" name="firstName"  id ="firstName" size="40" value="<%= FirstName %>"> </td>
	   </tr>
	   
	   <tr>
				<td><font size="2"><b> Last Name : </b> </font> <font color="red">* </font>  </td>
				<td><input type="text" name="lastName"  id ="lastName" size="40" value="<%= LastName %>"> </td>
	   </tr>
	   
	    <tr>
				<td><font size="2"><b> Vehicle Type : </b> </font>  </td>
				<td><input type="text" name="vehType"  id ="vehType" size="40" value="<%= vehtype %>"> </td>
	    </tr>
	   
	    <tr>
				<td><font size="2"><b> Employee Code : </b> </font>  </td>
				<td><input type="text" name="empCode"  id ="empCode" size="40" value="<%= Empcode %>"> </td>
	    </tr>
	   
	    <tr>
				<td><font size="2"><b> Mobile No : </b> </font>   </td>
				<td><input type="text" name="mobileNo"  id ="mobileNo" size="40" value="<%= MobilePhNo %>"> </td>
	    </tr>
	   <tr>
         		<td></td>
         		<td  >  <input type="submit" name="Submit" value="Submit" onclick="return confirmSubmit()" /> 
         		<input type="reset" name="reset" value="Reset" /> </td>
  	   </tr>
	
		</table>

</form>
	
		
		
</body>
</html>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>


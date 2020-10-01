
<%-- 
    Document   : createGroupID.jsp
    Created on : December 09, 2011, 13:19:52
    Author     : Sujata Shinde.
    Discription: Page To Create Group Ids. 
    last updated :-
--%>

<%@ include file="headernew.jsp" %>
<script language="javascript">
function validate()
{
//alert("in validate function");
var trans=document.createidsform.trans.value;
//alert(trans);
	var fn=document.createidsform.veh.value;
	//alert(fn);
	var un=document.createidsform.user.value;
	//alert(un);
	var pass=document.createidsform.typevalue.value;
	//alert(pass);	
	
	
	if(trans=="Select")
	{
		alert("Please select  Transporter Name");
		return false;
	}		

	if(fn=="Select")
	{
		alert("Please select vehicle number");
		return false;
	}

	if(un=="")
	{
		alert("Please enter User");
		return false;
	}

	if(pass=="")
	{
		alert("Please enter type value");
		return false;
	}
	
	return true;	
}
function formsubmit()
{
	var aa=document.createidsform.trans.value;
	if(!(aa=="Select"))
	{	
		document.createidsform.submit();
	}
}
function formsubmit1()
{
	var bb=document.createidsform.owner.value;
	if(!(bb=="Select"))
	{	
		document.createidsform.submit();
	}
}
function redirect()
{
	
	document.createidsform.action="insergrpid.jsp";
	document.createidsform.submit();
	
}
</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b>Create New Group Login Id</b></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1,stmt2; Connection conn;
String sql,sql1;
%>
<%
 
try{
 Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 	String OwnerName=session.getAttribute("usertypevalue").toString();

	 stmt1=conn.createStatement();
	 stmt2=conn.createStatement();
	 String inserted=request.getParameter("inserted");
	 int userlimit=0,usrcount=0;
		sql1="select * from db_gps.t_transporter where TypeValue='"+session.getAttribute("usertypevalue").toString()+"' ";
	//"select distinct(TypeValue) as TypeValue from t_security where TypeofUser in ('Transporter', 'GROUP') union  order by TypeValue asc";
		ResultSet rs1=stmt1.executeQuery(sql1);
		if(rs1.next()){
			userlimit=rs1.getInt("Userlimit");
			//out.println("userlimit@"+userlimit);
		}
		String sql="select count(*) as count from db_gps.t_security where TransporterName='"+session.getAttribute("usertypevalue").toString()+"' and ActiveStatus='Yes'";
		//out.println(sql);
		ResultSet rs=stmt1.executeQuery(sql);
		if(rs.next()){
			usrcount=rs.getInt("count");
			//out.println("usrcount"+usrcount);
		}
		if((usrcount-userlimit)>=0){
			%>
			<table border="0" width="750"> 
				<tr>
					<td bgcolor="#f5f5f5"> <font color="blue" size="2"> <B>User creation limit for transporter is finished.Please contact service department and extend user limit </B> </font> </td>
			    </tr>
			</table>
			<%
		}else{
	 if(inserted==null || "null".equalsIgnoreCase(inserted)){
		
	 }else if("aleradyExists".equalsIgnoreCase(inserted)){
		 %>
		 <table border="0" width="750px">
 			<tr>
    			<td align="center">
    			 UserName is already Exists.
    			</td>
   			 </tr>
    	</table>
		 <%
	 }else if("error".equalsIgnoreCase(inserted)){
		 %>
		 <table border="0" width="750px">
 			<tr>
    			<td align="center">
    			 Error occured on page.Please try again.
    			</td>
   			 </tr>
    	</table>
		 <%
	 }else if("successfull".equalsIgnoreCase(inserted)){
		 %>
		 <table border="0" width="750px">
 			<tr>
    			<td align="center">
    			 Group ID is created successfully.
    			</td>
   			 </tr>
    	</table>
		 <%
	 }else{
		 
	 }
	
%>
<form name="createidsform" action="insergrpid.jsp" onsubmit="return validate();">

	
<table border="0" width="750px">
 <tr>
    <td align="center">

<table border="0" width="550px">

 <tr>
       <td bgcolor="#f5f5f5"> <font color="maroon"><b> Owner Name:</b> </font> </td>
       <td bgcolor="#f5f5f5">
       
      	 <select name="trans" id="trans" onchange="formsubmit();"> 
 					<option value="<%=OwnerName %>" selected="selected"><%=OwnerName %></option>
		</select> 
		
   	   </td>
 </tr>
  <tr>

      <td bgcolor="#f5f5f5">  <font color="maroon"><B>Vehicles : </B></font> </td>
      <td bgcolor="#f5f5f5"> <select name="veh" id="veh">	<!--  onchange="formsubmit1();" -->
           <option value="Select">Select</option>
	   <%
	   sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+OwnerName+"'";
	   ResultSet rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %>
      		<option value="<%=rs2.getString("VehicleRegNumber") %> "> <%=rs2.getString("VehicleRegNumber") %> </option>
	<% } %>
     		
	    </select></td>
  </tr>
  	
 		       	<tr>
				<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Name: </B> </font> </td>
				<td bgcolor="#f5f5f5"> <input type="text" name="user"/> </td>
				</tr>
	 			<tr>
				<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Type Value(Enter Person Name): </B> </font> </td>
				 <td bgcolor="#f5f5f5"> <input type="text" name="typevalue"/> </td>
		</tr>
 		
     
     
   <tr>
	<td colspan="2" align="center"><input type="Submit" name="Submit" value="Submit" class="formElement"></td>
	
  </tr>
</table>

</td>
</tr>
</table>
</form>


<%
		} }catch(Exception e){
	 
 }finally{
	 conn.close();
 }
%>
</td></tr>
</table>
<%@ include file="footernew.jsp" %>
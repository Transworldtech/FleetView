<%@ include file="headernew.jsp" %>

<script language="javascript">
function validate()
{
	var trans=document.createidsform.trans.value;
	var fn=document.createidsform.fn.value;
	var un=document.createidsform.un.value;
	var pass=document.createidsform.pass.value;	
	var cpass=document.createidsform.cpass.value;

	
	if(trans=="Select")
	{
		alert("Please enter Transporter Name");
		return false;
	}		

	if(fn=="")
	{
		alert("Please enter Full Name");
		return false;
	}

	if(un=="")
	{
		alert("Please enter User Name");
		return false;
	}

	if(pass=="")
	{
		alert("Please enter Password");
		return false;
	}

	if(cpass=="")
	{
		alert("Please confirm Password");
		return false;
	}

	if(pass!=cpass)	
	{
		document.createidsform.cpass.value="";
		alert("Password and Confirm Password doesn't match");
		return false;
	}		
}

</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Create New Login Id</b></i></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1;
String sql,sql1;Connection conn;
%>
<%

try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
		stmt1=conn.createStatement();
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
		<table border="0" width="60%"> 
			<tr>
				<td bgcolor="#f5f5f5"> <font color="blue" size="2"> <B>User creation limit for transporter is finished.Please contact service department and extend user limit </B> </font> </td>
		    </tr>
		</table>
		<%
	}else{
%>
<form name="createidsform" action="createidsinsrt.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
			<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Transporter: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <select name="trans">	
				<option value="<%=session.getAttribute("usertypevalue").toString()%>"><%=session.getAttribute("usertypevalue").toString()%></option>
			     </select>	
			 </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Full Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="text" name="fn"/> </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="text" name="un"/> </td>
		</tr>	
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Password: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="password" name="pass"/> </td>
		</tr>	
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Confirm Password: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="password" name="cpass"/> </td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
		</tr>
	</table>
</form>

<%}
}catch(Exception e){
	
}finally{
	conn.close();
}
%>
</td></tr>
</table>
<%@ include file="footernew.jsp" %>
<%@ include file="header.jsp" %>
<script language="javascript">
function validate()
	{
		if(document.form1.userid.value=="")
		{
			alert("Please Enter User Id");
			document.form1.userid.focus();
			return false;
		}
		if(document.form1.password.value=="")
		{
			alert("Please Enter Password");
			document.form1.password.focus();
			return false;
		}
		if(document.form1.password1.value=="")
		{
			alert("Please Enter Password1");
			document.form1.password1.focus();
			return false;
		}
		if(document.form1.password.value!=document.form1.password1.value)
		{
			alert("Password and Password1 not maching");
			document.form1.password.value="";
			document.form1.password1.value="";
			document.form1.password.focus();
			return false;
		}
		if(document.form1.fname.value=="")
		{
			alert("Please Enter First Name");
			document.form1.fname.focus();
			return false;
		}
		if(document.form1.lname.value=="")
		{
			alert("Please Enter Last Name");
			document.form1.lname.focus();
			return false;
		}
		if(document.form1.address.value=="")
		{
			alert("Please Enter Address");
			document.form1.address.focus();
			return false;
		}
		if(document.form1.email.value=="")
		{
			alert("Please Enter Email");
			document.form1.email.focus();
			return false;
		}
		if(document.form1.phone.value=="")
		{
			alert("Please Enter Phone Number");
			document.form1.phone.focus();
			return false;
		}
		if(document.form1.mobile.value=="")
		{
			alert("Please Enter Mobile Number");
			document.form1.mobile.focus();
			return false;
		}
	return true;
	}
</script>
<%!
int cnt;
Connection conn;
Statement st;

 %>
<table border="1" width="100%" bgcolor="white">

<tr><td valign="top">
<table class="stats">
 <%
try{ 
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	String sql="select * from t_subuser where Transporter='"+session.getAttribute("usertypevalue").toString()+"'";
	ResultSet rst=st.executeQuery(sql);
	cnt=0;
	while(rst.next())
	{	
		cnt++;
	}
	%>
	<tr><td class="bodyText" colspan="3">
Welcome <%=session.getAttribute("usertypevalue").toString()%> you have created <%=cnt%> Subuser.</td></tr>
	<%
	ResultSet rst1=st.executeQuery(sql);
	while(rst1.next())
	{
		%><tr><td class="bodyText"><%=rst1.getString("UserId")%></td><td><a href="updatesubuser.jsp?userid=<%=rst1.getString("UserId")%>">  UPDATE</a></td><td><a href="assingvehsubuser.jsp?userid=<%=rst1.getString("UserId")%>">  Assign Vehicles</a></td></tr><%
	}
	}catch(Exception e)
	{
		out.print("Exception "+e);
	}
	finally
	{
		conn.close();
	}
%></table>
</td>
<%
if(cnt<2)
{
%>
<td>
<form name="form1" action="addsubuser.jsp" method="post" onsubmit="return validate();">
<table  width="50%" align="center" class="stats" border="0">
<tr><td colspan="2" class="hed">Create New Subuser! </td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>User ID : </td><td><input type="text" name="userid" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Password :</td><td><input type="password" name="password" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Re-Enter Password :</td><td><input type="password" name="password1" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>First Name :</td><td><input type="text" name="fname" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Last Name :</td><td><input type="text" name="lname" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Address :</td><td><textarea name="address" class="formElement"></textarea></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Email :</td><td><input type="text" name="email" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Phone :</td><td><input type="text" name="phone" class="formElement"></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Mobile :</td><td><input type="text" name="mobile" class="formElement"></td></tr>
<tr><td class="bodyText" colspan="2"><center><input type="Submit" name="Submit" value="Submit" class="formElement"></center></td></tr>
</table>
</form>
</td>
<%
}
%>
</tr>
</table>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2007 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

<%@ include file="cargoheader.jsp" %>
<script language="javascript">
	function validate()
		{
			var pass;
			var pass1;
			var pass2;
			pass=document.changepass.oldpass.value;
			pass1=document.changepass.newpass.value;
			pass2=document.changepass.renewpass.value;
			if(pass=="")
			{
				alert("Please Enter Old Password");
				return false;
			}
			if(pass1=="")
			{
				alert("Please Enter New Password");
				return false;
			}
			if(pass2=="")
			{
				alert("Please Re-Enter New Password");
				return false;
			}
			if(!(pass1==pass2))
			{
				alert("New Password and Re-entered password not maching");
				return false;
			}
			return true;
		}
</script>
<table border="1" width="100%" bgcolor="white">
<tr><td>
	<table border="1" width="60%" align="center">
	<tr><td>
	<form name="changepass" method="post" action="changepassdb.jsp" onSubmit="return validate();">	
	<table border="1" width="60%" align="center" class="stats">
	<tr><td class="hed" colspan="2">Change Password</td></tr>
	<tr><td>User Name</td><td><input type="text" name="user" value="<%=session.getAttribute("user").toString()%>" class="formElement" readonly /></td></tr>
	<tr><td>Old Password </td><td><input type="password" name="oldpass" class="formElement"></td></tr>
	<tr><td>New Password </td><td><input type="password" name="newpass" class="formElement"></td></tr>
	<tr><td>Re-enter New Password</td><td><input type="password" name="renewpass" class="formElement"></td></tr>
	<tr><td colspan="2" align="center"><input type="Submit" name="Submit" value="Submit" class="formElement"></td></tr>
	</table>
</form>
	</td></tr>
</table>
</td></tr>
</table><table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

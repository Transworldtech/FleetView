<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Forgot Password</title>
<h4 align="center"><font color="#284D6E">Password Recovery Form</font></h4>

</head>
<body bgcolor="#F7FCFF">
<script language="javascript">
    function validate()
    {
    	var username=document.forgetpasswordform.uname.value;

    	if(username=="")
    	{
        	alert("Please enter the username!!!! ");
        	return false;
    	}
    }
    
      //var cardid=document.cardidentryform.id.value;
     
</script>
<%
if(request.getQueryString()!=null)
{
%>
<table align="center" bgcolor="#F7FCFF">
<tr align="center">
<td align="center">
<%    
  String msg=request.getParameter("Msg");
  out.println(msg);
 }
%>
</td></tr>
</table>	

<form name="forgetpasswordform" action="sendPassword.jsp" onsubmit="return validate();" >
 <table border="0" width="60%" align="center" bgcolor="#F7FCFF">
    
    <tr></tr>
    <tr></tr>
	<tr align="center">
			<td bgcolor="#F7FCFF"> <font   size="2" color="#284D6E"> <b>Username: </b></font> </td>
			<td bgcolor="#F7FCFF"> <input type="text" name="uname"/></td>
	</tr>
	<tr align="center">
			<td colspan="2" align="center" bgcolor="#F7FCFF"><input  type="submit" id="submit" name="sendpsswd" value=""  style="background-image: url(newimages/submitbutton.gif); width: 79px; height: 32px; border: 1px solid #d0d0d0; margin-bottom: 10px;" /> </td>
	</tr>
 </table>
</form> 
 <p><font size="2"> Note: User name is required to be an email id. If it is not, you will not receive any email for password.<br><br>Please contact support :<br>avlsupport@mobile-eye.in<br>Ph : +91 20 41303040, 4121444</font></p> 
</body>
</html>
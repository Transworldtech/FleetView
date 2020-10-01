
 

  
<html>
<script type="text/javascript">
function changeAction()
{
	//var v1="reseter=yes";
	//document.getElementById("secure").action="generateSecurityCode.jsp?"+v1;
	//alert(document.getElementById("secure").action);
	document.getElementById("reseter").value="yes";
	document.getElementById("secure").submit();
}
</script>
  <body>
 
<form name="secure" id="secure" action="generateSecurityCode.jsp" method="get">
<input type="hidden" id="reseter" name="reseter" value="no"> 
<% 
try {
	
String securecode=request.getParameter("securecode");
%>
		<table align="center" width="80%" border="0" class="sortable_entry">
				<tr><td><font color="red" size="3"><center><b><i>Your security code is " <%=securecode %> "</i></b></center></font>
				<font color="green" size="2">Please Note:-</font><br>
				<font color="brown" size="2">
				1. The security code will help you in login in case of improper "LOG OUT"  without waiting for the 15 min session reset.<br/>
				2. You will have to remember your security code and key in the code when asked for while loging in<br/>
				3. If you have a valid e-mail id then it will be sent it to you via e-mail.
				</font>				
				</td></tr><tr><td align="center"><table><tr><td><input type="button" value="Close" onclick="javascript:window.close()" /></td><td><input type="button" value="Reset Secutiry Code" onclick="changeAction()" /></td></tr></table></td></tr>
				<tr><td align="center"></td></tr>
				<tr><td align="center"><center>Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</center></td></tr>					
				</table>

<% } catch(Exception e) { out.println("Exception----->" +e); }
finally
{

}
%>
		

</form>
</body>

</html>
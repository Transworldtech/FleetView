<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="IRTEpasswordheader.jsp" %>

<%! 
Connection con1;
Statement stmt1;
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>


	<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
	<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
	<script src="sorttable.js" type="text/javascript"></script>

<script language="javascript">
function validate()
{	//alert("I am in validation");
	v1=document.changepass.curpass.value;
	//alert("value of v1");
	v2=document.changepass.newpass.value;
	v3=document.changepass.confpass.value;
	v4=document.changepass.curpasschk.value;

   if(v1.length==0)
   {
      alert("Please enter your current password");
      return false;
   }
   if(v1!=v4)
   {
      alert("Entered current Password doesn't match with our records ");
      return false;
   }
   
   if(v2.length==0)
   {
      alert("Please enter new password");
      return false;
   }

   if(v3.length==0)
   {
      alert("Please confirm your password");
      return false;
   }
 
   if(v2!=v3)
   {
      alert("Text in New password and confirm password doesn't match");
      return false;
   }
      return true;
}
</script>

</head>

<body>
<form name="changepass1" method="post" action="driver_briefing1.jsp" onSubmit="" >
<table border="0" align="center" width="600px" width="100%"> 
<tr>
		<td align="left"><input type="submit" name="Submit1" value="BACK" class="formElement" /></td>
</tr>
</table>
</form>
<form name="changepass" method="get" action="changepassirteinsrt.jsp" onSubmit="return validate();">
<%		
try
{	//out.println("now in shange password");
    Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stmt1=con1.createStatement();	
	ResultSet rs1=null,rs2=null,rs3=null, rs4=null;
	String sql1="",sql,sql2,sql3, sql4;
	String user="", curpass="";

	String changed=request.getParameter("changed");
	//System.out.println("changed"+changed);
	
	if(changed==null)	
	{
	}
	else
	{ %>
		<table border="0" width="750px">
		  <tr>
		      <td align="center"><div><font size="3">Password changed successfully</font></div></td>
  		</tr>
		</table>
<%	}
%>
		<table border="0" width="750px">
		  <tr>
		      <td> <div align="center">  <font color="maroon" size="3"> <B> Change Password </B> </font> </div> </td>
  		</tr>
		</table>
		<br></br>
<%
user=session.getAttribute("user").toString();
//out.println("user"+user);		
//user="IRTE";
%>
<input type="hidden" name="user" value="<%=user%>" />
<%	
	sql1="select Password from t_security where Username='"+ user +"'";
	//System.out.println("sql1----------->"+sql1);
	rs1=stmt1.executeQuery(sql1);
	if(rs1.next())
	{
  		curpass=rs1.getString("Password");
  	//	System.out.println("current password----------->"+curpass);
	}
%>
<input type="hidden" name="curpasschk" value="<%=curpass %>"/>
	<table border="0" width="400px" align="center">
	  <tr>
	       <td width="30%"><font ><b> Current Password </b> </font> </td>
	       <td width="70%"> <input type="password" name="curpass" class="formElement" /> </td>
	  </tr>
	  <tr>
	       <td> <font > <b> New Password </b> </font> </td>
	       <td> <input type="password" name="newpass" class="formElement" /> </td>
	  </tr> 
	  <tr>     
	       <td> <font > <b> Confirm Password </b> </font> </td>
	       <td> <input type="password" name="confpass" class="formElement" /> </td>
	  </tr>
	<tr><td></td></tr>
	  <tr>
	       <td colspan="2"><div align="center"><input type="submit" name="submit"value="Submit" class="formElement" /></div></td> 
	  </tr>
   	</table>
<% 
}catch(Exception e)
{ 
	out.print("Exception -->"+e);
	
}
finally
{
	con1.close();
}
%>

</form>
</body>
<%@ include file="footernew.jsp" %>
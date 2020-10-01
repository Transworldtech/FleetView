<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/helpconn.jsp" %>
<html>
<head>
<title>Vehicle Tracking System </title>
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>


</head>
<body>
<P></P>
<table border="1" width="100%" align="center" bgcolor="#FFFAFA">
<tr>
<td>

<table border="0" width="100%" bgcolor="#F8F8FF">
<tr>
<td rowspan="2" align="center" width="13%">
<a href="images/logo.jpg" >
<img src="images/logo.jpg"  border="0">
</a>
</td>
<td  align="left">
<img src="images/ind11.jpg" width="30%" height="100%">
<img src="images/move.gif" border="0"  width="15%" >
<img src="images/Img6.gif" width="10%" height="30%">
<%@ include file="imgrotate.html" %>
<img src="images/your_ad_here.jpg" width="30%" height="100%">
</td>
</tr>


</table>

</td>
</tr>
</table>
<script src="elabel.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="common/genomics.css" rel="StyleSheet" type="text/css">
<style type="text/css">

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {color: #FFFFFF}
</style>
  
<%!

String Muser,pass, usertypevalue,MsgID,dispstat,message,Paydate,message1,PayDate;
 
int idx=0,tokenCount ;
%>

<%
//Muser=request.getParameter("user");
//pass=request.getParameter("Password");
  Muser=session.getValue("user").toString();
  pass=session.getValue("pass").toString();

%>
<form name="loginform" action="validateuser.jsp"  >
<input type="hidden" name="user" value="<%=Muser%>">
<input type="hidden" name="Password" value="<%=pass%>">
<%
try{	
	
	
	String sql = "SELECT * FROM t_security where Username='"+Muser+"' and Password='"+pass+"'";
	
	ResultSet rs = getStatement.executeQuery(sql);
	
	if(rs.next())
	{
		usertypevalue = rs.getString("TypeValue"); 
	
		String sql1="select * from t_usermessage where UserTypeValue='"+usertypevalue+"' and DisplayStatus='yes'" ;
		ResultSet rs1 = getStatement.executeQuery(sql1);
		if(rs1.next())
		{
			 MsgID=rs1.getString("MessageID");
			Paydate=rs1.getString("PaymentDate");
			java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(Paydate) ;
			Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
			PayDate = formatter2.format(date);
			 //dispstat=rs1.getString("DisplayStatus");
		
			String sql2="select * from t_message where ID='"+MsgID+"'";
			ResultSet rs2 = getStatement.executeQuery(sql2);
			if(rs2.next())
			{
						
			 message=rs2.getString("Message");
			 message=message.replace("paydate",PayDate);
			
			}
	%>	
		<table border="" width="100%" bgcolor="white">
			<tr><td><div align="Center"><font color="red" size="4">  Attention Please</font></div></td></tr>
	<tr><td><div align="center">
<font color="maroon" size="3">
			<%=message%>		
</font>	</div></td>
			</tr>
<%
   if(MsgID.equals("4") || MsgID.equals("5") || MsgID.equals("6"))
	{ %>
  		<tr>
			<td align="center"> <a href="index.html"> Log Out </a></td>
		</tr>
<%	}
   else
   { %>
<tr><td align="center"> <input type="submit" name="OK" value="OK" class="formElement"></td></tr>
<% } %>
		</table><br>
<table border="0" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" colspan="2">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
      
</table>
	<%
	}	
	else
	{
		response.sendRedirect("validateuser.jsp?user="+Muser+"&Password="+pass);
	}
   }
else
{
	response.sendRedirect("index.html");
}
}

catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
		getStatement.close();
	}catch(Exception e)
	{
		
	}
	try
	{
		getDattabase.close();
	}catch(Exception e)
	{
		
	}
	
}

%>


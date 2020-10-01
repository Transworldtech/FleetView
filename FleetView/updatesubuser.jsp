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
Statement st,stquery;
ResultSet  rst, rst1;
String userid, password,fname,lname,address,email,phone,mobile;
 %>

<table border="1" width="100%" bgcolor="white">

<tr><td valign="top">
<table class="stats">
 <%
try{ 
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	stquery = conn.createStatement();
	String sql="select * from t_subuser where Transporter='"+session.getAttribute("usertypevalue").toString()+"'";
	rst=st.executeQuery(sql);
	cnt=0;
	while(rst.next())
	{	
		cnt++;
	}
	%>
	<tr><td class="bodyText" colspan="3">
Welcome <%=session.getAttribute("usertypevalue").toString()%> you have created <%=cnt%> Subuser</td></tr>
	<%
	rst1=st.executeQuery(sql);
	while(rst1.next())
	{
		%><tr><td class="bodyText"><%=rst1.getString("UserId")%></td><td><a href="updatesubuser.jsp?userid=<%=rst1.getString("UserId")%>">  UPDATE</a></td><td><a href="assingvehsubuser.jsp?userid=<%=rst1.getString("UserId")%>">  Assign Vehicles</a></td></tr><%
	}
%>	
</table>

</td><td>
<%
if(request.getParameter("Update")!=null)
{
	userid=request.getParameter("userid");
	password=request.getParameter("password");
	fname=request.getParameter("fname");
	lname=request.getParameter("lname");
	address=request.getParameter("address");
	email=request.getParameter("email");
	phone=request.getParameter("phone");
	mobile=request.getParameter("mobile");
	//out.print(userid+"<br>"+password+"<br>"+fname+"<br>"+lname+"<br>"+address+"<br>"+email+"<br>"+phone+"<br>"+mobile);
	String sql3="update t_subuser set Password='"+password+"', Fname='"+fname+"', Lname='"+lname+"', Address='"+address+"',Email='"+email+"', Phone='"+phone+"', Mobile='"+mobile+"' where UserId='"+userid+"'";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql3.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	int row=st.executeUpdate(sql3);
if(row>0)
{
	out.print("<div class='bodyText'><font color='red'>Record Updated</font></div>");
}

}

%>


<%
String sql1="select * from t_subuser where UserId='"+request.getParameter("userid")+"'";
ResultSet rst2=st.executeQuery(sql1);
if(rst2.next())
{
%>
<form name="form1" action="" method="post" onsubmit="return validate();">
<table border="0" width="50%" align="center">
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>User ID : </td><td><input type="text" name="userid" class="formElement" value='<%=rst2.getString("userid")%>' readonly></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Password :</td><td><input type="password" name="password" class="formElement" value='<%=rst2.getString("Password")%>'></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>First Name :</td><td><input type="text" name="fname" class="formElement" value='<%=rst2.getString("Fname")%>'></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Last Name :</td><td><input type="text" name="lname" class="formElement" value='<%=rst2.getString("Lname")%>'></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Address :</td><td><textarea name="address" class="formElement"><%=rst2.getString("Address")%></textarea></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Email :</td><td><input type="text" name="email" class="formElement" value='<%=rst2.getString("Email")%>'></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Phone :</td><td><input type="text" name="phone" class="formElement" value='<%=rst2.getString("Phone")%>'></td></tr>
<tr><td class="bodyText" align="right"><font color="red" size="2">*</font>Mobile :</td><td><input type="text" name="mobile" class="formElement" value='<%=rst2.getString("Mobile")%>'></td></tr>
<tr><td class="bodyText" colspan="2"><center><input type="Submit" name="Update" value="Update" class="formElement"></center></td></tr>
</table>
</form>
<%
}
%>
</td></tr>
</table>
<%

}catch(Exception e)
	{
		out.print("Exception "+e);
	}
	finally
	{
		conn.close();
	}
%>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2007 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

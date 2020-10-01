<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql, username, oldpasso="", newpass,error,phno,email,fname1,lname1,sql1,fname,lname;
String email1,phno1,Designation,passret1="";
//String fnamelist= "",lname1list="",mobnolist="",emaillist="",lastnamelist="";
%>
<%
try{
	username=(String)session.getAttribute("mainuser");
	oldpasso=request.getParameter("oldpass");
	System.out.println(oldpasso);
	newpass=request.getParameter("newpass");
	System.out.println(newpass);
	email=request.getParameter("email");
	phno=request.getParameter("phno");
	System.out.println(phno);
	//Desig=request.getParameter("user");
	Designation=request.getParameter("Designation");
	fname1=request.getParameter("fname");
	lname1=request.getParameter("lname");
	
	passret1=request.getParameter("passret1");
	System.out.println(passret1);
	email1=(String)session.getAttribute("email");
	phno1=(String)session.getAttribute("phno");
	fname=(String)session.getAttribute("fname");
	lname=(String)session.getAttribute("lname");
	//Designation1=(string)session.getAttribute("Desig");
	System.out.print(username+"  "+oldpasso+"  "+newpass);
    //System.out.print(oldpass+" "+newpass);
	//System.out.print(email+"  "+email1);
	//System.out.print(phno+"  "+phno1);
	//System.out.print(fname+"  "+lname);
	error="Yes";
}catch(Exception e)
{
	e.printStackTrace();
}
      String flag="true";
	try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	Statement stquery=conn.createStatement();
	if(newpass.equalsIgnoreCase(" ")||newpass.equalsIgnoreCase("null")||newpass.equalsIgnoreCase("")||newpass.equalsIgnoreCase(null))
	{
		newpass=oldpasso;
		
	}
	if(phno==null||phno=="")
	{
		if(email1!=email)
		{
			
	   sql1="update t_userdetails set Email='"+email+"', Designation='"+Designation+"',FirstName='"+fname1+"',LastName='"+lname1+"' where UserName='"+username+"' and FirstName='"+fname+"' and LastName='"+lname+"' ";
	   System.out.println(sql1);
	  
		}
	}
	else
	{
		if(email1!=email||phno1!=phno)
		{
		sql1="update t_userdetails set Email='"+email+"',Designation='"+Designation+"',FirstName='"+fname1+"',LastName='"+lname1+"',MobNo='"+phno+"'  where UserName='"+username+"' and FirstName='"+fname+"' and LastName='"+lname+"'";	
		 System.out.println(sql1);
		
		}
	}
	
	
	sql="update t_security set Password='"+newpass+"' where Username='"+username+"' and Password='"+oldpasso+"'";
	System.out.println("securityupdate----------->  "+sql);
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql.replace("'","#");
	abcd=abcd.replace(",","$");
	//System.out.println("62 Hii");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	String abcd1=sql1.replace("'","#");
	abcd1=abcd1.replace(",","$");
	//System.out.println("67 Hii");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
	int aa=0;
	aa=st.executeUpdate(sql);
	System.out.println("securityupdate----------->  "+sql);
	if(aa >0)
	{
		//System.out.println("73 Hii");
	flag="true";
	//System.out.println("75 Hii");
	
	int bb=0;
	bb=st1.executeUpdate(sql1);
	if(bb >0)
	{
		session.setAttribute("rfname",fname1);
		session.setAttribute("rlname",lname1);
		session.setAttribute("phno",phno1);
		session.setAttribute("email",email);
		
		session.setAttribute("fname",fname1);
		session.setAttribute("lname",lname1);
		
		
		
		
		//System.out.println("73 Hii");
	//flag="true";
	//st1.executeUpdate(sql1);
	response.sendRedirect("changepass.jsp?flag="+flag);
	%>
	
	<!-- <table border="0">
	<tr><td>Password Changed Successfully</td></tr>
	</table>-->
	<%
	}
	}
	else
	{
		//System.out.println("86 Hii");
		flag="false";
		response.sendRedirect("changepass.jsp?flag="+flag);
		%>
		<!-- <table border="0">
		<tr><td>Please enter correct old Password</td></tr>
		</table>	-->
		<%
	}
	
}catch(Exception e)
{
	System.out.print("Exception --->"+e);
	e.printStackTrace();
}
finally
{
	try{
		conn.close();	
	}
	catch(Exception e)
	{
		
	}
	
}
%>
<!-- 
</table><table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>-->

<%@ include file="Connections/conn.jsp" %>
<%!
String username,sessionid,updated,clientip;
Connection sessionconn;
Statement sessionst,sessionst1;
ResultSet sessionrst,sessionrst1;
String sessionsql,sessionsql1;
%>
<%
try{
	System.out.println("*******8   &&&&&&&&&&&&&&&&&& ");
	Class.forName(MM_dbConn_DRIVER);
	sessionconn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	sessionst = sessionconn.createStatement();
	sessionst1 = sessionconn.createStatement();
	Statement stquery=sessionconn.createStatement();
	username=session.getAttribute("user").toString().toUpperCase();
	System.out.println("*******8   *******************&&&&&&&&&&&&&&&&&& ");
	String phno="",email="",fname="",lname="";
	phno=session.getAttribute("phno").toString() ;
	email=session.getAttribute("email").toString() ;
	fname=session.getAttribute("fname").toString() ;
	lname=session.getAttribute("lname").toString() ;
	if(phno==null)
	{
		phno=null;
	    session.setAttribute("phno",phno);
	}
	else
	{
		session.setAttribute("phno",phno);
	}
	if(email==null)
	{
		email=null;
	    session.setAttribute("email",email);
	}
	else
	{
		session.setAttribute("email",email);
	}
	session.setAttribute("fname",fname);
	session.setAttribute("lname",lname);
	sessionid=session.getId().toString();
	updated=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	clientip=request.getRemoteAddr();
	String invalid=request.getParameter("invalid");
	sessionsql="select * from t_sessions where UserName='"+username+"'";
	sessionrst=sessionst.executeQuery(sessionsql);
	if(sessionrst.next())
	{
		if(sessionrst.getString("ActiveStatus").equals("No"))
		{
			sessionsql1="update t_sessions set SessionId='"+sessionid+"' ,ActiveStatus='Yes', Updated='"+updated+"', UserIp='"+clientip+"',LoginStatus='Yes' where UserName='"+username+"'";
			
			/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd=sessionsql1.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			/*****************************/
			
			sessionst1.executeUpdate(sessionsql1);
			//response.sendRedirect("abc.jsp");
			response.sendRedirect("display_paymsg.jsp");
		}
		else
		{
			java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sessionrst.getString("Updated"));
			java.util.Date dt2=new java.util.Date();
			long mil1=0;
			long mil2=0;
			long mil3=0;
			mil1=dt1.getTime();
			mil2=dt2.getTime();
			mil3=mil2-mil1;
			//out.print(mil3/(1000*60)+"<br>");
			if(mil3/(1000*60) > 20)
			{
				sessionsql1="update t_sessions set SessionId='"+sessionid+"',ActiveStatus='Yes',Updated='"+updated+"', UserIp='"+clientip+"' where UserName='"+username+"'";
				
				/*Query to insert query in db_gps.t_sqlquery table*/
				String abcd1=sessionsql1.replace("'","#");
				abcd1=abcd1.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
				/*****************************/
				
				sessionst1.executeUpdate(sessionsql1);
				response.sendRedirect("display_paymsg.jsp");
			}
			else
			{
				%>
				<script type="text/javascript">
				function showBox()
				{
					document.getElementById("hide").style.display="block";
				}
				function validate()
				{
					var secure=document.getElementById("security").value;
					secure = secure.replace(/^\s+|\s+$/g,"");//trim
					if(eval(secure.length) == 0) 
				    { 
				        alert("Please enter a valid Security Code ");
				       return false; 
				    }//if 
				    else
				    {
					  return true;   
					}				    
				}
				</script>
				<form action="checkSecurity.jsp" method="get">
				<table width="100%" height="200">
				<tr><td>
				<%if(invalid!=null && invalid.equalsIgnoreCase("true")){
					
					%>
					<table align="center" width="80%" bgcolor="white" border="0">
					<tr><td>
					<font color="red" size="3"><center><b>Invalid Secutiry Code</b></center></font>
					</td></tr>
					</table>
					<%
				}
				%>
				</td></tr>
				</table>
				<table align="center" width="80%" bgcolor="white" border="0">
				<tr><td><font color="red" size="3"><center><b><i>Sorry !! Somebody has already logged in with this id, we are not allowing multiple logins with the same id.</i></b></center></font>
				<font color="green" size="2">Please Note:-</font><br>
				<font color="brown" size="2">
				1. Please click <a href="#" id="secure" onclick="showBox()">Here</a> to enter your Security Code to log out all other active sessions.</font></td></tr>
				<tr id="hide" style="display: none;"><td >
				<input type="password" id="security" name="security"></input> &nbsp;&nbsp;<input type="Submit" value="Submit" onclick="return validate();"></input>
				</td></tr>
				<tr><td><font color="brown" size="2"> 
				2. Either somebody is already Logged in with the same Id or <br>
				3. You probably have not Logged out properly. By logged off properly, we mean to say you have to click on "LOG OUT" link. If you have closed the browser directly, you will have to wait for 15 mins to get the session reset.</font>				
				</td></tr>				
				<tr><td align="center"><a href="index.html">Back To Home Page</a></td></tr>
				<tr><td align="center"></td></tr>
				<tr><td align="center"></td></tr>
				<tr><td align="center"><center>Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</center></td></tr>					
				</table>
				</form>
				<%
			}
		}
	}
	else
	{
		sessionsql="insert into t_sessions (UserName,SessionId,Updated,UserIp) values ('"+username+"','"+sessionid+"','"+updated+"','"+clientip+"')";
		
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd2=sessionsql.replace("'","#");
		abcd2=abcd2.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
		/*****************************/
		
		sessionst1.executeUpdate(sessionsql);
		response.sendRedirect("display_paymsg.jsp");
		//response.sendRedirect("abc.jsp");
	}
	
	
}catch(Exception es)
{
	out.print("Session Validate Exception---->"+es);
}
finally
{
	try
	{
		sessionst.close();
	}catch(Exception e)
	{
		
	}
	try
	{
		sessionst1.close();	
	}catch(Exception e)
	{
		
	}
	try
	{
		sessionconn.close();
	}catch(Exception e)
	{
		
	}
} 
%>

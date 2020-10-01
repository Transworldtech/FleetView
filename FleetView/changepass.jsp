<%@ include file="headernew.jsp" %>
 <%@page import="com.fleetview.beans.classes"%>
 <%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
<%!
Connection conn;
Statement st;
String email="",phno="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">


<!-- <h2 align="center"><font color="black">Change Password</font></h2>-->
</head>
<script language="javascript">
onload=function()
{
	document.changepass.oldpass.value="";
	document.changepass.newpass.value="";
	document.changepass.renewpass.value="";
}

function validateEmail(email)
{
     var splitted = email.match("^(.+)@(.+)$");
    if(splitted == null) return false;
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
	    var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
	    if(splitted[2].match(regexp_ip) == null) return false;
      }// if
      return true;
    }
return false;
}

	function validate()
		{
		try{
			var pass;
			var pass1;
			var pass2;
			var email;
			var phno;
			pass=document.changepass.oldpass1.value;
			//alert(pass);
			pass1=document.changepass.newpass.value;
			pass2=document.changepass.renewpass.value;
			email=document.changepass.email.value;
			phno=document.changepass.phno.value;
			//alert(pass1);
			//alert(pass2);
			//alert(email);
			//alert(phno);
			if(pass=="")
			{
				alert("Please Enter Old Password");
				return false;
			}
		/*	if(pass1=="")
			{
				alert("Please Enter New Password");
				return false;
			}
			if(pass2=="")
			{
				alert("Please Re-Enter New Password");
				return false;
			}*/
			if(!(pass1==pass2))
			{
				alert("New Password and Re-entered password not maching");
				return false;
			}
			if((pass==pass1))
			{
				alert("Please change your password");
				return false;
			}
			if(email==""||email==null)
			{
				alert("Please enter the email Id!!");
				return false;
			}

			var sss=validateEmail(email);
			if(!sss)
				{
					alert("Please enter valid Email Id");
					return false;
				} 

			//alert(phno);
			if(!(phno ==0))
			{
				
				 if(isNaN(phno))
		    		{
		    			alert("Please enter Numeric Value");
		    			return false;
		    		}
		    	//	alert("$$$$$$$$$$$$$"+phno.length);
					 if((phno.length < 8)  || (phno.length >12))
			    	{
		            alert("Please enter valid Mobile Number"); 
		            return false;
		        }
			}
			else
			{
				phno=" ";
			}
	
			
          /*  if(!(email.contains("@"))) 
            {
                alert("Please enter correct email id..!!");
                return false;
            }*/
			
			document.changepass.action="changepassdb.jsp?oldpass="+pass+"&newpass="+pass1+"&email="+email+"&phno="+phno;
			document.changepass.submit();
		}catch(e)
		{alert(e);}
		check();
		}
/*	function check()
	{
	alert("------------------>");	 
var agree=confirm("Do u want to continue");
if(agree)
{
	return true;
	
}
else
{
	return false;
}

	}*/

	
</script>
<body >
<%
try
{
	
	classes fleetview= new classes();
	fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	String username=(String)session.getAttribute("mainuser");
	String fname=(String)session.getAttribute("fname");
	String lname=(String)session.getAttribute("lname");
	//fname=request.getParameter("fname");
	//lname=request.getParameter("lname");
	//String Designation=(String)session.getAttribute("Designation");
	String MobNo=(String)session.getAttribute("MobNo");
	String Designation="",passret="";
	
	String sql="Select * from db_gps.t_userdetails where UserName='"+username+"' and FirstName='"+fname+"' and LastName='"+lname+"'"; 
	ResultSet rs=st.executeQuery(sql);
	if(rs.next())
	{
		fname=rs.getString("FirstName");
		lname=rs.getString("LastName");
		Designation=rs.getString("Designation");
		///System.out.println("Track : "+Desig);
		email=rs.getString("Email");
		MobNo=rs.getString("MobNo");
		
		
		
	}
	String sql1="Select * from db_gps.t_security where UserName='"+username+"' and ActiveStatus='Yes'"; 
	ResultSet rs1=st.executeQuery(sql1);
	System.out.println("Pass---------------------> : "+sql1);
	if(rs1.next())
	{
	   passret=rs1.getString("Password");	
	   System.out.println("Passpasspass---------------------> : "+passret);
	}
	String flag=request.getParameter("flag");
	if(flag!=null && flag.equalsIgnoreCase("true"))
	{
		%>
		<script>
		alert("Information saved Successfully..!!");
		window.location="changepass.jsp";
		</script>
		<%
	}
	else
		if(flag!=null && flag.equalsIgnoreCase("false"))
	{
			%>
			<script>
			alert("Please enter correct old Password..!!");
			window.location="changepass.jsp";
			</script>
			<%
	}
	
	
	
%>

<img id="top" src="newimages/top.png" alt="" style="width: 600px;">
	
	<div id="form_container" style="width: 600px;" align="center">
	
		<h1 align="center"><a>Personal Details</a></h1>

	<form name="changepass"  method="post" action="changepassdb.jsp" onSubmit="return validate();" >
	<input type="hidden" name="passret1" id="passret1" value="<%=passret %>"></input>
<div class="form_container" style="text-align: center;" align="center">
	<div width="100%" align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;">

	      <table border="0" width="100%" align="center">
	       <tr>
           <td><font  size="2"> &nbsp;&nbsp;User Name:-</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="user"  value="<%=username %>" readonly="readonly" />&nbsp;</td>
           </tr>
	      
	       <tr>
           <td><font  size="2"> &nbsp;&nbsp;First Name:-</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="fname"  value="<%=fname %>"  />&nbsp;</td>
           </tr>
	       
	       <tr>
           <td><font  size="2"> &nbsp;&nbsp;Last Name:-</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="lname"  value="<%=lname %>"  />&nbsp;</td>
           </tr>
         
             <tr>
           <td><font  size="2"> &nbsp;&nbsp;Designation:-</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="Designation"  value="<%=Designation %>"  />&nbsp;</td>
           </tr>
	<%
	 System.out.println("Passpasspass---------------------> : "+passret);
	%>
	  <tr>   
           <td><font  size="2"> &nbsp;&nbsp;Old Password:-</font></td>
           <td><input type="password" class="element text medium" style="width: 180px;" name="oldpass1"  value="<%=passret %>" readonly="readonly" />&nbsp;</td>
           </tr>
           
	       <tr>
           <td><font  size="2"> &nbsp;&nbsp;New Password:-</font></td>
           <td><input type="password" class="element text medium" style="width: 180px;" name="newpass"  />&nbsp;</td>
           </tr>
	      
	       <tr>
           <td><font  size="2"> &nbsp;&nbsp;Re-enter New Password:-</font></td>
           <td><input type="password" class="element text medium" style="width: 180px;" name="renewpass"  />&nbsp;</td>
           </tr>
	      
	      
		<tr>
		<td><font  size="2"> &nbsp;&nbsp;Ph.No.:-</font></td>
	
	<%
	if(null==session.getAttribute("phno").toString())
	{
	%>
	 <td><input type="text" class="element text medium" style="width: 180px;" name="phno"  />&nbsp;</td>
	<%
	}
	else
	{
		%>
		 <td><input type="text" class="element text medium" style="width: 180px;" name="phno" value="<%=MobNo %>" />&nbsp;</td>
		
		<%
	}
		%>
	</tr>
	
	<tr>
	<td><font  size="2"> &nbsp;&nbsp;Email Id:-</font></td>
	<%
	if(null==session.getAttribute("email").toString())
	{
	%>
	<td><input type="text" class="element text medium" style="width: 180px;" name="email"  />&nbsp;</td>
	<%
	}
	else
	{
		%>
		 <td><input type="text" class="element text medium" style="width: 180px;" name="email" value="<%=email %>" />&nbsp;</td>
		<%
	}
		%>
	</tr>
	
	<tr align="center">
	<td  colspan="2" align="center"><input type="button" name="btn" value="Submit" onclick="return validate();"></td>
	</tr>
	
	</table>

	</div>
	</div>
	
	
</form>
	</div>
<%
}
catch(Exception e)
{
	System.out.println("Exception--------->"+e);
	e.printStackTrace();
}

%>
<br></br>


<%@ include file="footernew.jsp" %>
<P></P>
</body>
</html>

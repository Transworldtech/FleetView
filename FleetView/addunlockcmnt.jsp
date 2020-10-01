<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<%! Connection conn;%>
<body>

<script type="text/javascript">
function validate()
{
	var reason=document.unlockcomment.reason.value;
	if(document.unlockcomment.castrol.checked)
	{
		
	}
	else
	{
		if(document.unlockcomment.trans.checked)
		{
			
		}
		else
		{
			 alert("Please check any one check box");
		      return false;
		}
	}
   /* if(reason=="")
   {
      alert("Please Enter the Reason");
      return false;
    }*/
    document.unlockcomment.trans.disabled = false;
    document.unlockcomment.castrol.disabled = false;
    
    return true;
}

function allSelected()
{
	if(document.unlockcomment.castrol.checked) 
	{
		document.getElementById("tr1").style.display = "";
	}
	else
	{
		document.getElementById("tr1").style.display = "none";
	}

	if(document.unlockcomment.trans.checked) 
	{
		document.getElementById("tr2").style.display = "";
	}
	else
	{
		document.getElementById("tr2").style.display = "none";
	}
}

function  disablecheck()
{
	alert("JJJJJJ  ");
}
</script>
<%

String Msg = request.getParameter("Msg");
if(Msg!=null && Msg.equalsIgnoreCase("1"))
{
	%>
	<script type="text/javascript">
	alert("Comment added successfully.");
	opener.Reload();
	window.close();
	</script>
	<%
}
else
	if(Msg!=null && Msg.equalsIgnoreCase("2"))
	{
		%>
		<script type="text/javascript">
		//alert("Comment added successfully.");
		opener.Reload();
		window.close();
		</script>
		<%
	}

String vid=request.getParameter("vehcode");
String veh = request.getParameter("vehregno");
System.out.println("*****    "+vid+"   ****  "+veh);

try
{
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null,st2 = null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		String comment = "";
		String transcomment = "";
		String casunlock = "";
		String transunlock = "";

%>
<form name="unlockcomment" method="post" action="addulckcmntinsrt.jsp" onsubmit="return validate()">
<h1  align="center" style="background-color: #063157"><font size="4" face="Arial" color="White"><b>Vehicle Unlock Form</b></font></h1>

<%
sql = "select * from db_gps.t_vehiclelock where vehcode = '"+vid+"'";
rst = st.executeQuery(sql);
if(rst.next())
{
	comment = rst.getString("Comments");
	transcomment = rst.getString("TransComment");
	casunlock = rst.getString("CastrolUnlock");
	transunlock = rst.getString("TransUnlock");
}

if(comment == "-" || comment.equals("-"))
{
	comment = "";
}

if(transcomment == "-" || transcomment.equals("-"))
{
	transcomment = "";
}


%>
<table border="0" align="center" style="font-family: arial;font-size:12;" width="100%">

<tr>
<td><font size="2" face="Arial"><b> Vehicle Reg No:</b></font></td>

<td><input type="text" name="vehregno" style="border: 0px solid #000000;" value="<%=veh%>" onclick="dodisable()" readonly="readonly"/></input>
<td><input type="hidden" name="vid" value="<%=vid%>" /></td>
</td>
</tr>
<tr id="tr1">
<td valign="top"><font size="2" face="Arial"><b> Castrol Comments:</b></font></td>
<td><textarea name="reason" rows="2" id="search-text"
	 style='width: 175px; height: auto; border:1px solid' ><%=comment %></textarea></td>
	 </tr>
	 <tr style="display: none;" id="tr2">
<td valign="top"><font size="2" face="Arial"><b> Transporter Comments:</b></font></td>
<td><textarea name="transreason" rows="2" id="search-text1" 
	 style='width: 175px; height: auto; border:1px solid'><%=transcomment %></textarea></td>
	 
	 </tr>
	 <tr><td><font color="black"><b>
  		Unlocked by Castrol 
  		<input type="checkbox" name="castrol" id="castrol" value="castrol" checked="checked" onclick="allSelected();" ></input>
   </b></font></td>
   
   <td><font color="black"><b>
  		Unlocked by Transporter <input type="checkbox" name="trans" id="trans" value="trans" onclick="allSelected();"></input>
   </b></font></td>
   </tr>
	 <tr><td></td></tr>
	 <tr><td></td></tr>
	 <tr><td></td></tr>
	 <tr><td></td></tr>
	 
<tr align="center" bgcolor="#063157">

<td colspan="2" align="center"><input type="submit" name="submit" value="Unlock" ></td>
</tr>
</table>
</form>
<%
if(casunlock == "Yes" || casunlock.equalsIgnoreCase("Yes"))
{
%>
<script>
document.unlockcomment.castrol.checked = true;
document.unlockcomment.castrol.disabled = true;
document.getElementById("tr1").style.display = "";

</script>
<%
if(comment=="" || comment.equals(""))
{
	
}
else
{
	%>
	<script>
	document.unlockcomment.reason.setAttribute('readonly', 'readonly');
	</script>
	<%
}
}

if(transunlock == "Yes" || transunlock.equalsIgnoreCase("Yes"))
{
%>
<script>
document.unlockcomment.trans.checked = true;
document.unlockcomment.trans.disabled = true;
document.getElementById("tr2").style.display = "";

</script>
<%

if(transcomment=="" || transcomment.equals(""))
{
	
}
else
{
	%>
	<script>
	document.unlockcomment.transreason.setAttribute('readonly', 'readonly');
	</script>
	<%
}
}

}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>
</body>
</jsp:useBean>



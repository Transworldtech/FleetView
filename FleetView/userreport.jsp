<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<script type="text/javascript">

var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};




function Reload()
{
	//alert("Hej");  
    window.location.reload(); 
}

function deactivate(user,typevalue,status,creation,exp)
{
	var action = confirm("Do you want to De-Activate the user");
	if(action == true)
	{
		window.location.href = "deactivateuser.jsp?username="+user+"&typevalue="+typevalue+"&status="+status+"&create="+creation+"&exp="+exp;
	}
	else
	{
		return false;
	}
}

function activate(user,typevalue,status,creation,exp)
{
	var action = confirm("Do you want to Activate the user");
	if(action == true)
	{
		window.location.href = "activateuser.jsp?username="+user+"&typevalue="+typevalue+"&status="+status+"&create="+creation+"&exp="+exp;
	}
	else
	{
		return false;
	}
}

function allSelected(allVal)
{
	if(document.customdetail.extAll.checked) 
	{
		document.getElementById("frmDT").style.display='none';
    	document.getElementById("toDT").style.display='none';
    }
	else 
	{
		document.getElementById("frmDT").style.display="";
    	document.getElementById("toDT").style.display="";
	}
}
</script>
<%
String datenew1="";
String datenew2="";
if(request.getParameter("data")!=null)
{
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
}
else
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}

		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2));
		try
		{
			
			String ownername = session.getAttribute("usertypevalue").toString();
			String vehlist = session.getAttribute("VehList").toString();
%>


<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	User Report</div>
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="customdetail" method="get">
<%//System.out.println("\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");%>
  
		<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
				<td align="left"><b>Active Status&nbsp;&nbsp;</b>
				<select name="Status" id="Status" 
				style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
				    <option value="All">All</option>
			 		<option value="Yes">Active</option>
			 		<option value="No">De-Active</option>
			 		
			 		
			    </select>
				</td>
				<td>
				All <input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected(this.value);"></input>
				</td>
				
				<td id="frmDT" align="left" style="display:''"><b>From&nbsp;&nbsp;</b>
					<input type="text" id="data" name="data" size="12" value="<%=datenew1 %>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>
				</td>
				
				<td id="toDT" align="left" style="display:''"><b>To&nbsp;&nbsp;</b>
					<input type="text" id="data1" name="data1" size="12" value="<%=datenew2 %>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>&nbsp;&nbsp;&nbsp;
			 	 
				</td>
				<td><input type="submit" name="button" value="Go"></td>
			</tr>
		</table>
		

</form>
</div>
<br></br>
<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 10em;margin-right: 3em; width: 80%" align="center">
<form name="ComplaintReport" name="ComplaintReport" action="" method="post">
<div id="table1">
<%! Connection conn=null;%>
<%
String Msg = request.getParameter("Msg");
if(Msg!=null && Msg.equalsIgnoreCase("deactivated"))
{
	%>
	<script>
	alert("Deactivated Successfully....");	
	</script>
	<%
}
else
	if(Msg!=null && Msg.equalsIgnoreCase("3"))
	{
		%>
		<script>
		alert("Activated Successfully....");	
		</script>
		<%
	}
	else
		if(Msg!=null && Msg.equalsIgnoreCase("1"))
		{
			%>
			<script>
			alert("User already exist !!!");	
			</script>
			<%
		}
		else
			if(Msg!=null && Msg.equalsIgnoreCase("2"))
			{
				%>
				<script>
				alert("Firstname and LastName already exist !!!");	
				</script>
				<%
			}
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
		
		String mainuser = session.getAttribute("mainuser").toString();
		String Active = request.getParameter("Status");
		String chvval = request.getParameter("extAll");
		System.out.println("***&&&&&&&&&&   "+Active);
		System.out.println("**********  "+chvval);
		
		String cond ="";
		 if(Active == null || Active.equals("null") || Active == "All" || Active.equals("All"))
		 {
			 cond = "";
		 }
		 else
			 if(Active == "Yes" || Active.equalsIgnoreCase("Yes"))
			 {
				 cond = " and ActiveStatus <> 'No' ";
			 }
			 else
				 if(Active == "No" || Active.equalsIgnoreCase("No"))
				 {
					 cond = " and ActiveStatus = 'No' ";
				 }
		
		 if(chvval == null || chvval.equals("null"))
		 {
			 cond = cond+" and CreationDate >= '"+dataDate1+" 00:00:00' and CreationDate <= '"+dataDate2+" 23:59:59' ";
		 }
		 else
			 if(chvval == "Yes" || chvval.equalsIgnoreCase("Yes"))
			 {
				 
			 }
		 
		 
		%>
		<table width="100%" align="center"><tr><td>
		<table align="center" class="sortable">
		<tr>
		<th><div align="center"><font size="2" ><b>Sr. No.</b></font></div></th>
		<th><div align="center"><font size="2" ><b>User</b></font></div></th>
		<th><div align="center"><font size="2" ><b>TypeofUser</b></font></div></th>
		<th><div align="center"><font size="2"><b>TypeValue</b></font></div></th>
		<th><div align="center"><font size="2"><b>Active Status</b></font></div></th>
		<th><div align="center"><font size="2"><b>CreationDate</b></font></div></th>
		<th><div align="center"><font size="2"><b>ExpiryDate</b></font></div></th>
		<th><div align="center"><font size="2"><b>Action</b></font></div></th>
		</tr>
		
		<%
		int i = 1;
		sql = "select distinct(GPName) from db_gps.t_group where EntryBy = '"+mainuser+"'  and VehRegno = '"+ownername+"' ";
	    rst = st.executeQuery(sql);
	    System.out.println("***********      "+sql);
	    while(rst.next())
	    {
	    	String sql1 = "select * from db_gps.t_security where TypeValue = '"+rst.getString("GPName")+"' "+cond+" ";
	    	ResultSet rs1 = st1.executeQuery(sql1);
	    	System.out.println("5555555      "+sql1);
	    	while(rs1.next())
	    	{
	    		%>
	    		<tr>
	    		<td align="right" ><div align="right"><font size="2" ><%= i%></font></div></td>
	    		<td align="left" ><div align="left"><font size="2" ><%= rs1.getString("username")%></font></div></td>
	    		<td align="left" ><div align="left"><font size="2" ><%= rs1.getString("TypeofUser")%></font></div></td>
	    		<td align="left" ><div align="left"><font size="2" ><%= rs1.getString("TypeValue")%></font></div></td>
	    		<td align="left" ><div align="left"><font size="2" ><%= rs1.getString("ActiveStatus") %></font></div></td>
	    		<td align="right" ><div align="right"><font size="2" ><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs1.getString("CreationDate")))%></font></div></td>
	    		<td align="right" ><div align="right"><font size="2" ><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("ExpiryDate")))%></font></div></td>
	    		<%
	    		if(rs1.getString("ActiveStatus") == "No" || rs1.getString("ActiveStatus").equalsIgnoreCase("No"))
	    		{
	    		%>
	    		<td bgcolor="#f5f5f5" align="left"><a href="javascript: flase" title="Activate" 
			onclick="activate('<%=rs1.getString("UserName")%>','<%=rs1.getString("TypeValue")%>','<%=rs1.getString("ActiveStatus")%>','<%=rs1.getString("CreationDate") %>','<%=rs1.getString("ExpiryDate") %>')"><img src="newimages/activate.jpeg" border="0"></a></td>
			<%
	    		}
	    		else
	    			{
	    				%>
	    				<td bgcolor="#f5f5f5" align="left"><a href="javascript:flase" onclick="window.open('edituser.jsp?username=<%=rs1.getString("UserName")%>&typevalue=<%=rs1.getString("TypeValue")%>&activestatus=<%=rs1.getString("ActiveStatus")%>','win1','width=700,height=500,scrollbars=yes')" title="Edit"><img src="images/edit1.jpg" border="0"></a>&nbsp;&nbsp;<a href="javascript: flase" title="Deactivate" 
			onclick="deactivate('<%=rs1.getString("UserName")%>','<%=rs1.getString("TypeValue")%>','<%=rs1.getString("ActiveStatus")%>','<%=rs1.getString("CreationDate") %>','<%=rs1.getString("ExpiryDate") %>')"><img src="newimages/deactivate.jpg" border="0"></a></td>
	    				
	    				<%
	    			}
			%>
	    		</tr>
	    		<%
	    		i++;
	    	}
	    }
	    
	    
	    %>
	    </table>
	    </td>
	    </tr>
	    </table>
	    </div>
	    </form>
	    </div>
	    
	    <%
}
catch(Exception e)
{
	%>
	<div align="center">
	<%
	out.println("Please Select The Transporter !!");
	%>
	</div>
	<%
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{conn.close();
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
</html>
</jsp:useBean>
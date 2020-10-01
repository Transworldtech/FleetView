<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body onunload="window.opener.location.reload();setTimeout('self.close()',5);">
<script type="text/javascript">
/*function close(){
	alert("reload");
	this.opener.Reload();
	aler("close");
	 setTimeout("self.close()",100);   
	 //
}*/
function validaterdb()
{
	var loc=document.insertLoc.addLoc.value;
	var regex=/[a-zA-z]/; //for alphabtes
	var regexNum = /\d/
	if(regex.test(loc))
	{
		
	}
	else if(loc=="")
	{
		alert("Please enter Valid data");
		return false;
	}
	else if(regexNum.test(loc))
	{
		alert("Numeric characters are not allowed");
		loc.value="";
		//loc.focus();
		return false;
	}
	return true;
}
</script>
<form method="post" name="insertLoc" action="insertNewLocality.jsp"  onsubmit="return validaterdb()">
			<%
				String ins="";
			try{
				ins=request.getParameter("ins");
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			if(null==ins||("null").equalsIgnoreCase(ins)||"".equalsIgnoreCase(ins)){
			}
			else if("inserted".equalsIgnoreCase(ins)){
				//System.out.println(ins);
				%>
				<table align="center">
				<tr><td align="center" ><font color="maroon">Location Saved Inserted Successfully !!!</font></td></tr>
				</table>
				<%
			}
			else if("alreadyexists".equalsIgnoreCase(ins)){
				//System.out.println(ins);
				%>
				<table align="center">
				<tr><td align="center" ><font color="maroon">Location Already Exists !!!</font></td></tr>
				</table>
				<%
			}
			%>
				<table width="100%" class="stats" id="tabl">
				<tr>
					<th align="center">Add New Locality</th>		
				</tr>
				<tr>
					<td>
					<input type="hidden" name="tripid" value="<%=request.getParameter("tripid").toString()%>"></input>
					<input type="hidden" name="startDate" value="<%=request.getParameter("startDate").toString()%>"></input>
					<input type="hidden" name="endDate" value="<%=request.getParameter("endDate").toString()%>"></input>
					<input type="hidden" name="startPlace" value="<%=request.getParameter("startPlace").toString()%>"></input>
					<input type="hidden" name="endPlace" value="<%=request.getParameter("endPlace").toString() %>"></input>
					Add Location Name: </td>
					<td><input type="text" size="15" id="addLoc" name="addLoc"></input></td>
				</tr>
				<tr>
					<td><input type="submit" name="btnsubmit" value="Submit" class="bodyText"></td>
				</tr>
				</table>
			</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body onunload="window.opener.location.reload();setTimeout('self.close()',5);" bgcolor="#00a060">
<script type="text/javascript">
/*function close(){
	alert("reload");
	this.opener.Reload();
	aler("close");
	 setTimeout("self.close()",100);   
	 //
}*/

function confirmSubmit()
{
	var duration=document.insertLoc.duration.value;
	var dist=document.insertLoc.dist.value;
	var roadcondt=document.insertLoc.roadcondt.value;
    
	var agree=confirm("Duration: "+duration+"\nDistance : "+dist+"\nRoad Condition: "+roadcondt+"\n\nAre you sure you want to continue with these values?");
	alert(agree);
	if (agree)
		return true ;
	else
		return false ;
	}

function validaterdb()
{
	var duration=document.insertLoc.duration.value;
	var dist=document.insertLoc.dist.value;
	alert(duration);
	alert(dist);
	var flag=true;
	var agree=false;
	var regex=/[a-zA-z]/; //for alphabtes
	var regexNum = /\d/
	
	 if(regex.test(duration))
	{
		alert("Alphabets are not allowed");
		//loc.value="";
		//loc.focus();
		flag= false;
	//	alert(flag);
	}
	 else if(duration==""){
			alert("Please Enter Duration");
			flag= false;
		}
	 else if(dist==""){
		 alert("Please Enter Distance");
		 flag= false;
	 }
	else if(regex.test(dist))
	{
		alert("Alphabets are not allowed");
		loc.value="";
		//loc.focus();
		flag= false;
	}
		//alert(flag);
	if(flag==true){
		var duration=document.insertLoc.duration.value;
		var dist=document.insertLoc.dist.value;
		var roadcondt=document.insertLoc.roadcondt.value;
	    
		agree=confirm("Duration: "+duration+"\nDistance : "+dist+"\nRoad Condition: "+roadcondt+"\n\nAre you sure you want to continue with these values?");
		//alert(agree);
		
	}
//	alert(agree+"   "+flag);
	if (agree==true && flag==true){
		return true;
	}
	else{
		return false;
	}
}
</script>
<form method="post" name="insertLoc" action="insertRouteZoneInfo.jsp"  onsubmit="return validaterdb();">
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
				System.out.println(ins);
				%>
				<table align="center">
				<tr><td align="center" ><font color="maroon">Location Saved Inserted Successfully !!!</font></td></tr>
				</table>
				<%
			}
			else if("alreadyexists".equalsIgnoreCase(ins)){
				System.out.println(ins);
				%>
				<table align="center">
				<tr><td align="center" ><font color="maroon">Location Already Exists !!!</font></td></tr>
				</table>
				<%
			}
			%>
				<fieldset>
				<legend><font size="3" color="maroon">Route/Zone FeedBack</font></legend>
				<table width="100%" class="stats" id="tabl" align="center">
				
				<tr>
					<td align="right">
					<input type="hidden" name="deviationType" value="<%=request.getParameter("deviationType").toString()%>"></input>
					<input type="hidden" name="tripid" value="<%=request.getParameter("tripid").toString()%>"></input>
					<input type="hidden" name="transporter" value="<%=request.getParameter("transporter").toString()%>"></input>
					<input type="hidden" name="vehid" value="<%=request.getParameter("vehid").toString()%>"></input>
					<input type="hidden" name="driverid" value="<%=request.getParameter("driverid").toString()%>"></input>
					<input type="hidden" name="lat" value="<%=request.getParameter("lat").toString() %>"></input>
					<input type="hidden" name="lon" value="<%=request.getParameter("lon").toString() %>"></input>
					<input type="hidden" name="startplace" value="<%=request.getParameter("startplace").toString() %>"></input>
					Enter Duration(in HH:mm) : </td>
					<td><input type="text" size="15" id="duration" name="duration"></input></td>
				</tr>
				<tr>
					<td align="right">Enter Distance : </td>
					<td><input type="text" size="15" id="dist" name="dist"></input></td>
				</tr>
				<tr>
					<td align="right">Road Condition : </td>
					<td><textarea cols="15" rows="4" id="roadcondt" name="roadcondt"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" name="btnsubmit" value="Submit" class="bodyText"></td>
				</tr>
				</table>
				</fieldset>
			</form>
</body>
</html>
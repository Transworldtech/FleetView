<%@ include file="/headernew.jsp" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="treestructure" class="com.einnovates.controllers.TreePageController" scope="page">


<html>
<head>

</head>

<body>
<%
String username = session.getAttribute("mainuser").toString();
treestructure.setusername(username);

%>
<%@ taglib uri="http://einnovates.com/tree4jsp" prefix="t" %>
<script type="text/javascript">
function toggleDetails(id, show)
{
	//alert("*******");
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
	} else {
		popup.style.visibility = "hidden";
	}
}

function usrname(name)
{
	alert(name);
	try
	{
	    
	}
	catch(e)
	{
		alert(e);
	}
}
</script>
<br></br>
<br></br>
<div style="margin-left: 5em;">
  <t:tree treeData="${deviceTreeData}" imageBase="tree/"
    minusImage="16m.png" plusImage="16p.png"
    urlBase="nodeProperties.htm" target="propertiesFrame"
    nodeObject="nodeObject">
<t:renderer nodeType="ALL_LEAFS"><a href="javascript:toggleDetails('${nodeObject}',true);" style="color: red;font-size: 1.1em;font-family: Arial;" >${nodeObject}</a>
<div  id="popup${nodeObject}" style="position: absolute;visibility: hidden;">
<table border="1" bgcolor="#9db5e5" cellpadding="1px" cellspacing="1px">
		   	<tr>  
				<td> <a href="showvehicles.jsp?uname=${nodeObject}&page=last24hours" onclick="toggleDetails('${nodeObject}',false);" target="_blank" >User Centric Report</a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="javascript:toggleDetails('${nodeObject}',false);">Close </a>
				</td>
		   	</tr>
		   	</table>
</div>
</t:renderer>
    <t:renderer nodeType="ALL"><a href="javascript:toggleDetails('${nodeObject}',true);" style="font-size: 1.1em;font-family: Arial;">${nodeObject}</a>
    <div  id="popup${nodeObject}" style="position: absolute;visibility: hidden;">
<table border="1" bgcolor="#9db5e5" cellpadding="1px" cellspacing="1px">
		   	<tr>  
				<td> <a href="showvehicles.jsp?uname=${nodeObject}&page=last24hours" onclick="toggleDetails('${nodeObject}',false);" target="_blank" >User Centric Report</a>
				</td>
		   	</tr>
		   		<tr>
				<td> <a href="javascript:toggleDetails('${nodeObject}',false);">Close </a>
				</td>
		   	</tr>
		   	</table>
</div>
    </t:renderer>
    <t:renderer nodeType="type1"><span style="color: red;font-size: 1.1em;font-family: Arial;">${nodeObject}</span></t:renderer>
  </t:tree>
  </div>
   <%
    System.out.println("_____________________________________-");
   
   %>
   <br></br>
   <br></br>
</body>
<%@ include file="/footernew.jsp" %>
</html>
</jsp:useBean>
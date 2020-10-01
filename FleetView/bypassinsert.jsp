
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>

<%
	String display="";
	String cranecode=request.getParameter("cranecode");
	String vehcode=request.getParameter("vehcode");
	session.setAttribute("No",display);
	response.sendRedirect("slimain.jsp?vehiclecode="+vehcode+"&submitted=yes");
	session.setAttribute("Yes",display);
%>

</html>

<%@ include file="Connections/conn.jsp" %>
<table border="1" bgcolor="white" width="100%">
<tr><td>
<%
String querystring=request.getQueryString();
String[] result = querystring.split("\\&");
String hh=request.getParameter("hh");
String veh="";
     for (int x=1; x<result.length-1; x++)
         {
		String aa=request.getParameter("ch"+x);
         	if(!(null==aa))
         	{
         	 veh=veh+","+request.getParameter("ch"+x);
         	}
         }
         veh=veh+")";
		//out.print(veh);
		String vehlist=session.getAttribute("VehList").toString();
		vehlist=vehlist.replace(")",veh);
		//out.print(vehlist);
		session.setAttribute("VehList",vehlist);
		response.sendRedirect("currentposition.jsp?h="+hh);
%>
</td></tr></table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
<%@ include file="header.jsp" %>
<table width="100%" border="1">
<tr>
<td>
<table width="100%" border="1" class="stats">
<tr ><td background="images/background1.bmp"><a href="index1.jsp">Show Pie Chart</a></td><td background="images/background1.bmp"><a href="graph.jsp">Show Bar Chart</a></td><td background="images/background1.bmp"><a href="report.jsp?data=<%=session.getAttribute("data1")%>&data1=<%=session.getAttribute("data2")%>">Report</a></td></tr>
<tr>
<td align="center" width="50%">
<%
String datanames[] = (String[])session.getAttribute("datanames");
double datavalues[] = (double[])session.getAttribute("datavalues");

String aa=datanames[0]+"="+datavalues[0]+"&"+datanames[1]+"="+datavalues[1]+"&"+datanames[2]+"="+datavalues[2]+"&"+datanames[3]+"="+datavalues[3]+"&"+datanames[4]+"="+datavalues[4];//+"&"+datanames[5]+"="+datavalues[5]+"&"+datanames[6]+"="+datavalues[6];
%>
<input type="hidden" name="aa" id="aa" value="<%=aa+"&size=150" %>">
<SCRIPT LANGUAGE="JavaScript">var GheosPie=document.getElementById("aa").value;</SCRIPT>
<SCRIPT SRC="http://Gheos.net/js/pie.js"></SCRIPT>

</td><td valign="top" colspan="2">






<table border="0" width="100%" class="stats">
<tr><td colspan="2" align="center" bgcolor="yellow" class="hed"><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=session.getAttribute("user").toString() %> Logistics For the Period :<%=session.getAttribute("ShowDate").toString() %> to <%=session.getAttribute("ShowDate1").toString() %></b></center></td></tr>
</table>



















<table border="1" width="100%" bgcolor="#F5F5F5" class="stats">
<tr><td colspan="2" class="hed"><DIV align="left">Parameters considered for the report</div></td></tr>
<tr><td class="bodyText"><div align="left">1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %></div></td><td class="bodyText"><div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString() %></div></td></tr>
<tr><td class="bodyText" ><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString() %></div></td>
<td class="bodyText"><div align="left">4. Continuous Driving :<%=session.getAttribute("cdri").toString() %></div></td></tr>
</table>






















</td></tr></table></td></tr></table>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

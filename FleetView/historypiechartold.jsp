<%@ include file="header.jsp" %>
<table width="100%" border="1">
<tr>
<td>

<%

String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();
%>
<table border="1" width="100%"><tr><td><table border="0" width="100%" background="images/background1.bmp"><tr><td align="center"><a href="MainformMap2.jsp<%=ll %>">Map</a></td><td align="center"><a href="historypiechart.jsp">Pie Chart</a></td><td align="center"><a href="historybarchart.jsp">Bar Chart</a></td><td align="center"><a href="tempraturereport.jsp">Detail Report</a></td></tr></table></td></tr></table>
<table width="100%" border="1" class="stats">
<tr>
<td align="center" width="50%">
<%

double OS,RA,RD,sum;
OS=Double.parseDouble(session.getAttribute("oscount").toString());
RA=Double.parseDouble(session.getAttribute("account").toString());
RD=Double.parseDouble(session.getAttribute("dccount").toString());
sum=OS+RA+RD;
if(OS >0)
{
	OS=OS/sum*100;
}
if(RA >0)
{
	RA=RA/sum*100;
}
if(RD >0)
{
	RD=RD/sum*100;
}
String aa="Over Speed ="+OS+"&&&Rapid Accelaration="+RA+"&&&Rapid Dccelaration="+RD;
%>
<input type="hidden" name="aa" id="aa" value="<%=aa+"&size=150" %>">
<SCRIPT LANGUAGE="JavaScript">var GheosPie=document.getElementById("aa").value;</SCRIPT>
<SCRIPT SRC="http://Gheos.net/js/pie.js"></SCRIPT>

</td><td valign="top">

<table border="0" width="100%" class="stats">
<tr><td colspan="2" align="center" bgcolor="yellow" class="hed"><center><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=session.getAttribute("user").toString() %> Logistics For the Period :<%=session.getAttribute("HisShowDate").toString() %> to <%=session.getAttribute("HisShowDate1").toString() %></b></center></td></tr>
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

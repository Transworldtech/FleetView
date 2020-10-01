<%@ include file="header.jsp" %>
<script language="JavaScript" src="graphs.js"></script>
<script language="JavaScript">
function createGraph() {
  var f = document.f1;
  if(f.graphValues.value != '') {
    var graphBarWidth = isNaN(parseInt(f.graphBarWidth.value)) ? 0 : parseInt(f.graphBarWidth.value);
    var graphBarLength = isNaN(parseFloat(f.graphBarLength.value)) ? 1.0 : parseFloat(f.graphBarLength.value);
    var graphLabelSize = isNaN(parseInt(f.graphLabelSize.value)) ? 0 : parseInt(f.graphLabelSize.value);
    var graphValuesSize = isNaN(parseInt(f.graphValuesSize.value)) ? 0 : parseInt(f.graphValuesSize.value);
    var graphPercSize = isNaN(parseInt(f.graphPercSize.value)) ? 0 : parseInt(f.graphPercSize.value);
    var graphPadding = isNaN(parseInt(f.graphPadding.value)) ? 0 : parseInt(f.graphPadding.value);

    var graph = new BAR_GRAPH(f.graphType.options[f.graphType.selectedIndex].value);
    graph.values = f.graphValues.value;
    graph.labels = f.graphLabels.value;
    graph.showValues = f.graphShowValues.options[f.graphShowValues.selectedIndex].value;
    graph.barWidth = graphBarWidth;
    graph.barLength = graphBarLength;
    graph.labelSize = graphLabelSize;
    graph.absValuesSize = graphValuesSize;
    graph.percValuesSize = graphPercSize;
    graph.graphPadding = graphPadding;
    graph.graphBGColor = f.graphBGColor.value;
    graph.graphBorder = f.graphBorder.value;
    graph.barColors = f.graphBarColor.value;
    graph.barBGColor = f.graphBarBGColor.value;
    graph.barBorder = f.graphBarBorder.value;
    graph.labelColor = f.graphLabelColor.value;
    graph.labelBGColor = f.graphLabelBGColor.value;
    graph.labelBorder = f.graphLabelBorder.value;
    graph.absValuesColor = f.graphValuesColor.value;
    graph.absValuesBGColor = f.graphValuesBGColor.value;
    graph.absValuesBorder = f.graphValuesBorder.value;
    document.getElementById('divGraph').innerHTML = graph.create();

    f.txtCode.value =
      'var graph = new BAR_GRAPH("' + f.graphType.options[f.graphType.selectedIndex].value + '");\n' +
      'graph.values = "' + f.graphValues.value + '";\n' +
      'graph.labels = "' + f.graphLabels.value + '";\n' +
      'graph.showValues = ' + f.graphShowValues.options[f.graphShowValues.selectedIndex].value + ';\n' +
      'graph.barWidth = ' + graphBarWidth + ';\n' +
      'graph.barLength = ' + graphBarLength + ';\n' +
      'graph.labelSize = ' + graphLabelSize + ';\n' +
      'graph.absValuesSize = ' + graphValuesSize + ';\n' +
      'graph.percValuesSize = ' + graphPercSize + ';\n' +
      'graph.graphPadding = ' + graphPadding + ';\n' +
      'graph.graphBGColor = "' + f.graphBGColor.value + '";\n' +
      'graph.graphBorder = "' + f.graphBorder.value + '";\n' +
      'graph.barColors = "' + f.graphBarColor.value + '";\n' +
      'graph.barBGColor = "' + f.graphBarBGColor.value + '";\n' +
      'graph.barBorder = "' + f.graphBarBorder.value + '";\n' +
      'graph.labelColor = "' + f.graphLabelColor.value + '";\n' +
      'graph.labelBGColor = "' + f.graphLabelBGColor.value + '";\n' +
      'graph.labelBorder = "' + f.graphLabelBorder.value + '";\n' +
      'graph.absValuesColor = "' + f.graphValuesColor.value + '";\n' +
      'graph.absValuesBGColor = "' + f.graphValuesBGColor.value + '";\n' +
      'graph.absValuesBorder = "' + f.graphValuesBorder.value + '";\n' +
      'document.write(graph.create());';
  }
  else alert('No values!');
}
</script>


<form name="f1" action="javascript:createGraph()" method="post">
<table border="2" cellspacing="0" cellpadding="2" width="100%" bgcolor="white">
<tr valign="top" bgcolor="#E0F0FF">
<td>


<table width="100%" border="1" class="stats">
<tr ><td background="images/background1.bmp"><a href="index1.jsp">Show Pie Chart</a></td><td background="images/background1.bmp"><a href="graph.jsp">Show Bar Chart</a></td><td background="images/background1.bmp"><a href="report.jsp?data=<%=session.getAttribute("data1")%>&data1=<%=session.getAttribute("data2")%>">Report</a></td></tr>
</table>

</td>
</tr>


<tr><td>
<table border="0" widht="100%" class="stats">
<tr>
  <td align="right" class="bodyText">Graph Type:</td>
  <td><select name="graphType" style="width:100px">
  <option value="hBar" selected>horizontal</option>
  <option value="vBar">vertical</option>
  </select></td>
 
  <td align="right" class="bodyText">Show Values:</td>
  <td><select name="graphShowValues" style="width:100px">
  <option value="0">% only</option>
  <option value="1" selected>abs. and %</option>
  <option value="2">abs. only</option>
  <option value="3">none</option>
  </select></td>

<%
String datanames[]=(String[])session.getAttribute("datanames");
double datavalues1[]=(double[])session.getAttribute("datavalues1");

%>
<input type="hidden" name="graphValues" maxlength="200" style="width:220px" value="<%=datavalues1[0]%>,<%=datavalues1[1]%>,<%=datavalues1[2]%>,<%=datavalues1[3]%>,<%=datavalues1[4]%>">


<input type="hidden" name="graphLabels" maxlength="200" style="width:220px" value="<%=datanames[0]%>,<%=datanames[1]%>,<%=datanames[2]%>,<%=datanames[3]%>,<%=datanames[4]%>">


<input type="hidden" name="graphBarWidth" maxlength="3" style="width:30px" value="20"><input type="hidden" name="graphBarLength" maxlength="3" style="width:30px" value="1.0"><input type="hidden" name="graphLabelSize" maxlength="2" style="width:30px" value="12"><input type="hidden" name="graphValuesSize" maxlength="2" style="width:30px" value="12"><input type="hidden" name="graphPercSize" maxlength="2" style="width:30px" value="12"><input type="hidden" name="graphPadding" maxlength="2" style="width:30px" value="10">

<td>
  <input type="submit" value="Create Graph" class="formElement"></td>
</tr></table>




<input type="hidden" name="graphBGColor" size="14" maxlength="14" value="#ABCDEF"><input type="hidden" name="graphBorder" size="14" maxlength="30" value="1px solid blue"><input type="hidden" name="graphBarColor" size="14" maxlength="14" value="#A0C0F0"><input type="hidden" name="graphBarBGColor" size="14" maxlength="14" value="#E0F0FF"><input type="hidden" name="graphBarBorder" size="14" maxlength="30" value="2px outset white"><input type="hidden" name="graphLabelColor" size="14" maxlength="14" value="#000000"><input type="hidden" name="graphLabelBGColor" size="14" maxlength="14" value="#C0E0FF"><input type="hidden" name="graphLabelBorder" size="14" maxlength="30" value="2px groove white"><input type="hidden" name="graphValuesColor" size="14" maxlength="14" value="#000000"><input type="hidden" name="graphValuesBGColor" size="14" maxlength="14" value="#FFFFFF"><input type="hidden" name="graphValuesBorder" size="14" maxlength="30" value="2px groove white">
</td></tr>
</table>
<table border="1" cellspacing="0" cellpadding="0" width="100%" bgcolor="white">
<tr valign="top">
<td>
	<div id="divGraph" style="width:550px height="550px"></div>
</td>
<td>
<table border="0" width="100%" class="stats">
<tr><td colspan="2" align="center" bgcolor="yellow" class="hed"><center><b>Exception 		Analysis Report For AVL Mobile Eye 2000 for <%=session.getAttribute("user").toString() %> 	Logistics For the Period :<%=session.getAttribute("ShowDate").toString() %> to 
	<%=session.getAttribute("ShowDate1").toString() %></b></center></td></tr>
	</table>
	<table border="1" width="100%" bgcolor="#F5F5F5" class="stats">
	<tr><td colspan="2" class="hed"><DIV align="left">Parameters considered for the 		report</div></td></tr>
	<tr><td class="bodyText"><div align="left">1. OverSpeed :
	<%=session.getAttribute("overspeed").toString() %></div></td><td class="bodyText"><div 		align="left">2. Rapid Acceleration :
	<%=session.getAttribute("racc").toString() %></div></	td></tr>
<tr><td class="bodyText" ><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString() %></div></td>
<td class="bodyText"><div align="left">4. Continuous Driving :<%=session.getAttribute("cdri").toString() %></div></td></tr>
</table>


</form>
</td></tr></table>
<table border="1" width="100%" >
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>

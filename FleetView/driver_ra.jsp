<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%!
Connection conn,conn1;
Statement st, st1, st2, st3;
String data1, data2, dcode, dname,transporter,vehreg;
String sql;
%>
<%
data1=request.getParameter("data1");
dcode=request.getParameter("dcode");
dname=request.getParameter("dname");
vehreg=request.getParameter("vehregno");
transporter=request.getParameter("transporter");
%>
<script language="javascript">

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


function gotoPrint(divName)  
{  
	  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.RA.action ="excel.jsp";
          document.forms["RA"].submit();
} 

</script>
<%
String exportFileName=session.getAttribute("user").toString()+"_RAExcepReport.xls";
%>
<form id="RA" name="RA"  method="post" >
<div id="table1">
<table border="0" bgcolor="white" width="100%" align="center">
<tr>
<td>
<table border="1" width="100%" align="center" class="stats">
<tr>
<td align="center">
<div align="left"><a href="javascript:history.go(-1);">Back</a></div>
<font size="3">Rapid Acceleration Details for Driver <%=dname%> ( <%=dcode%> ), Vehicle <%=vehreg%> of Transporter <%=transporter%> for <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%>.</font>
<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
                           </div>
</td>
</tr>
<tr>
<td align="center">
<div align="center">
<table class="sortable" border="0" style="width: 700px;text-align: center;">
<tr>
<td class="hed">Sr.</td>
<td class="hed">Time</td>
<td class="hed">From<br>Speed</td>
<td class="hed">To <br>Speed</td>
<td class="hed">Location</td>
</tr>

<%
try{
	//Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	sql="select * from t_driver_ra where Transporter='"+transporter+"' and TheDate='"+data1+"' and dcode='"+dcode+"' order by concat(TheDate,TheTime) asc";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
	%>
	<tr>
	<td align="right" style="width: 10px;"><div align="right"><%=i%></div></td>
	<td align="right" style="width: 25px;"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("TheTime")))%></div></td>
	<td align="right" style="width: 25px;"><div align="right"><%=rst.getString("FromSpeed")%></div></td>
	<td align="right" style="width: 25px;"><div align="right"><%=rst.getString("ToSpeed")%></div></td>
	<td align="left" style="width: 300px;">
	<div align="left">
	<%
	sql="select * from t_veh"+rst.getString("VehCode")+" where TheFieldDataDate='"+data1+"' and TheFieldDataTime='"+rst.getString("TheTime")+"'";	
	ResultSet rst1=st.executeQuery(sql);
	if(rst1.next())
	{
		%>
		<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a>
		<%
	}	
	%>	</div>
	</td>
	</tr>
	<%
	i++;
	}
	}catch(Exception e)
	{
		out.print("Exceptions--->"+e);
	}
	finally
	{
		conn.close();
		conn1.close();
		try
		{fleetview.closeConnection1();}
		catch(Exception e)
		{}

		try
		{fleetview.closeConnection();}
		catch(Exception e)
		{}
	}
%>
</table>
</div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</form>
<!-- footer start here -->
</jsp:useBean>
<%@ include file="footernew.jsp" %>
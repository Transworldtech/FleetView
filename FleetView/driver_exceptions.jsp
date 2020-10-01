<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn,conn1;
Statement st, st1, st2, st3;
String data1, data2, dcode, dname,transporter;
String sql;
%>
<%
data1=request.getParameter("data1");
data2=request.getParameter("data2");
dcode=request.getParameter("dcode");
dname=request.getParameter("dname");
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
          document.driver.action ="excel.jsp";
          document.forms["driver"].submit();
} 

</script>
<%
String exportFileName=session.getAttribute("user").toString()+"_DriverExceptionReport.xls";
%>
<form id="driver" name="driver"  method="post" >
<div id="table1">
<table border="1"  width="100%" align="center" class="stats">
<tr>
<td>
<table border="0" width="100%" align="center">
<tr><td align="center">
<div align="left"><a href="javascript:history.go(-1)">Back</a></div>
<font size="3">Exception Report for Driver <%=dname %> ( <%=dcode%> ), Transporter <%=transporter%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data2))%>.</font>
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
<tr><td align="center">
<div align="center">
<table border="1" style="width: 800px;text-align: center;" class="sortable">
<tr>
<td class="hed">Sr</td>
<td class="hed">Date</td>
<td class="hed">Vehicle</td>
<td class="hed">Trip-ID</td>
<td class="hed">OS</td>
<td class="hed">RA</td>
<td class="hed">RD</td>
<td class="hed">CD</td>
<td class="hed">DT</td>
<td class="hed">Stops</td>
<td class="hed">Run <br>Hrs.</td>
<td class="hed">ND</td>
<td class="hed">Rating</td>
</tr>
<%
try
{
	//Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1(); 
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	
	
	sql="select * from t_driver_ds where Transporter='"+transporter+"' and dcode='"+dcode+"' and TheDate >='"+data1+"' and TheDate <='"+data2+"' order by TheDate";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;	
	while(rst.next())
	{
	%>
	<tr>
	<td align="right" style="width: 10px;"><div align="right"><%=i%></div></td>
	<td align="right" style="width: 50px;"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))%></div></td>
	<td align="left" style="width: 90px;"><div align="left"><%
		sql="select * from t_vehicledetails where OwnerName='"+transporter+"' and  vehiclecode='"+rst.getString("VehCode")+"'";	
		ResultSet rst1=st.executeQuery(sql);
		if(rst1.next())
		{
		out.print(rst1.getString("VehicleRegNumber"));
		}
	%></div></td>
	<td align="right" style="width: 40px;"><div align="right"><%=rst.getString("Jcode")%></div></td>
	<td align="right" style="width: 30px;"><div align="right"><% 
	if(rst.getInt("OSCount") > 0)
	{
	%>
	<a href="driver_os.jsp?dcode=<%=dcode%>&dname=<%=dname%>&transporter=<%=transporter%>&data1=<%=rst.getString("TheDate")%>&vehregno=<%=rst1.getString("VehicleRegNumber")%>"><%=rst.getInt("OSCount")%></a>	
	<%
	}
	else
	{
	out.print(rst.getInt("OSCount"));
	}
	
	%></div></td>
	<td align="right" style="width: 30px;"><div align="right">
	<%
	if(rst.getInt("RACount") > 0)
	{
	%>
	<a href="driver_ra.jsp?dcode=<%=dcode%>&dname=<%=dname%>&transporter=<%=transporter%>&data1=<%=rst.getString("TheDate")%>&vehregno=<%=rst1.getString("VehicleRegNumber")%>"><%=rst.getInt("RACount")%></a>	
	<%
	}
	else
	{
	out.print(rst.getInt("RACount"));
	}
	%>	</div>
	</td>
	<td align="right" style="width: 30px;"><div align="right">
	<%
	if(rst.getInt("RDCount") > 0)
	{
	%>
	<a href="driver_rd.jsp?dcode=<%=dcode%>&dname=<%=dname%>&transporter=<%=transporter%>&data1=<%=rst.getString("TheDate")%>&vehregno=<%=rst1.getString("VehicleRegNumber")%>"><%=rst.getInt("RDCount")%></a>	
	<%
	}
	else
	{
	out.print(rst.getInt("RDCount"));
	}
	%>		
	</div>
	</td>
	<td align="right" style="width: 30px;"><div align="right">
	<%
	if(rst.getInt("CRCount") > 0)
	{
	%>
	<a href="driver_cr.jsp?dcode=<%=dcode%>&dname=<%=dname%>&transporter=<%=transporter%>&data1=<%=rst.getString("TheDate")%>&vehregno=<%=rst1.getString("VehicleRegNumber")%>"><%=rst.getInt("CRCount")%></a>	
	<%
	}
	else
	{
	out.print(rst.getInt("CRCount"));
	}
	%>	</div>	
	</td>
	<td align="right" style="width: 30px;"><div align="right"><%=rst.getString("Distance")%></div></td>
	<td align="right" style="width: 30px;"><div align="right">
	<%
	if(rst.getInt("StopCount") > 0)
	{
	%>
	<a href="driver_st.jsp?dcode=<%=dcode%>&dname=<%=dname%>&transporter=<%=transporter%>&data1=<%=rst.getString("TheDate")%>&vehregno=<%=rst1.getString("VehicleRegNumber")%>"><%=rst.getInt("StopCount")%></a>	
	<%
	}
	else
	{
	out.print(rst.getInt("StopCount"));
	}
	%></div>
	</td>
	<td align="right" style="width: 30px;"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("RDuration")))  %></div></td>
	<td align="left" style="width: 30px;"><div align="left">
	<%
	if(rst.getString("ND").equals("Yes"))
	{
	%>
	<a href="driver_nd.jsp?dcode=<%=dcode%>&dname=<%=dname%>&transporter=<%=transporter%>&data1=<%=rst.getString("TheDate")%>&vehregno=<%=rst1.getString("VehicleRegNumber")%>"><%=rst.getString("ND")%></a>	
	<%
	}
	else
	{
	out.print(rst.getString("ND"));
	}
	%></div>
	</td>
	<td align="right" style="width: 30px;"><div align="right"><% String rt=rst.getString("Rating");
		if(rt.length() > 5)
		{
			out.print(rt.substring(0,rt.indexOf(".")+3));
		}	
		else
		{
		out.print(rt);
		}
	%></div></td>
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
</td></tr>
</table>
</td>
</tr>
</table>
</div>
</form>
<!-- footer start here -->
</jsp:useBean>
<%@ include file="footernew.jsp" %>
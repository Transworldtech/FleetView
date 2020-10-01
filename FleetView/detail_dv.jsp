<%@ include file="headernew.jsp" %>
<%@page import="java.util.*" %>
<%//System.out.println("---------check1111111 "); %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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

</script>
	<%!
Connection conn=null, con1=null;
Statement st,st1, stmt1;

%>
<%
	final String vehicleRegistrationNumber = request.getParameter("vehno");
	final String vehicleCode = request.getParameter("vid");
	
	String fromDate="";
	String toDate="";
	
	String Frmdate11="";
	String Todate22="";
	fromDate=request.getParameter("data1");
	
	toDate=request.getParameter("data2");
	
	if(fromDate==null || fromDate.equals("null"))
	{
	 //System.out.println("----------fromdate is------------>>"+fromDate);
	  String fromDate1 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data1").toString();
	  String toDate1 = (null != request.getParameter("dd")) ? 
		request.getParameter("dd") : session.getAttribute("data2").toString();
		
		
		fromDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1+" 00:00:00"));
		toDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1+" 23:59:59"));
	}
		
	
	//Frmdate11=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate));
	//Todate22=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate));
	
	 session.setAttribute("data1",fromDate);
     session.setAttribute("data2",toDate);
		/*try
		{
			fromDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1));
			toDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1));

			
		}
		catch(Exception e)
		{
			
			fromDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate1+" 00:00:00"));
			toDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate1+" 23:59:59"));
			
		}*/
		
		
	final String tbname = "t_veh" + vehicleCode + "_cr";
	
	final String pageType=request.getParameter("pageType");
   
	
	
	
%>

<table border="1" width="100%" class="stats">
<%
System.out.println("pageType"+pageType);
	if(pageType.equalsIgnoreCase("RouteDeviation"))
	{
%>
	<tr>
		<td colspan="6">
		<div align="left"><a href="javascript: history.go(-1)">Back</a>
		</div>
		<font size="3" face="Arial"><b>Route Deviation for Vehicle <%=vehicleRegistrationNumber%>
		From Date:- <%
			java.util.Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(fromDate);
			Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
			String fromdt = formatter.format(date);
			out.print(fromdt);
		%> To Date:- <%
			java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(toDate);
			Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
			String todt = formatter1.format(date3);
			out.print(todt);
		%> </b></font>
		<div class="bodyText" align="right">&nbsp; &nbsp;<a
			href="excel_cddetails.jsp?vid=<%=vehicleCode%>&datat=<%=fromDate %>&datat1=<%=toDate %>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a>&nbsp;&nbsp;&nbsp; Date : <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 	String curdate = fmt.format(new java.util.Date());
 	out.print(curdate);
 %>
		</div>
		</td>
	</tr>
<%
	}
	else 
	{
%>

	<tr><td colspan="2" align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
%>
</td></tr>
<tr><td align="center"><font size="3">
 <b>NIGHT DRIVING REPORT for Vehicle <%=vehicleRegistrationNumber %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(toDate);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>
</b></font>
<div align="right">
<a href="#" onclick="javascript:window.open('Print_detail_nd.jsp?vid=<%=vehicleCode %>&vehno=<%=vehicleRegistrationNumber%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Export_detail_nd.jsp?vid=<%=vehicleCode %>&vehno=<%=vehicleRegistrationNumber%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

<%=new java.util.Date() %>
</div>
</td></tr>
	
<%
	}
%>
	<tr>
		<td>
		<table class="sortable">
			<tr>
				<th><b>Sr. No.</b></th>
				<th><b>Start Date-Time </b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
			</tr>
			<%
			conn = fleetview.ReturnConnection1();
			con1 = fleetview.ReturnConnection();
				try {
					
					st=conn.createStatement();
					stmt1=con1.createStatement();
					
					int counter=0;
					String sql ="select * from db_gpsExceptions.t_vehall_dv where vehcode='"+vehicleCode+"' and FromDateTime>='"+fromDate+"' and ToDateTime<='"+toDate+"'";
			System.out.println("sql:-"+sql);		
			ResultSet rs=st.executeQuery(sql);
					while(rs.next()){ 
			
			%>
			<tr>
				<td style="text-align: right"><%=++counter%></td>
				<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(rs.getString("fromDateTime"))) %> </td>
				<td>
				<div align="left">
				<%
					
				%> <a
					href="shownewmap.jsp?lat=<%=rs.getString("fromlatitude")%>&long=<%=rs.getString("fromlongitude")%>
								&discription=<%=rs.getString("fromlocation")%>"
					onclick="popWin=open('shownewmap.jsp?lat=<%=rs.getString("fromlocation")%>
													&long=<%=rs.getString("fromlongitude")%>
													&discription=<%=rs.getString("fromlocation")%>', 
													'myWin','width=500, height=500'); 
													popWin.focus(); return false;"><%=rs.getString("fromlocation")%></a>
				
				</div>
				</td>
															
				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(rs.getString("ToDateTime"))) %></td>												
				<td>
				<div align="left">
				<%
					
				%> <a
					href="shownewmap.jsp?lat=<%=rs.getString("tolatitude")%>&long=<%=rs.getString("tolongitude")%>
								&discription=<%=rs.getString("tolocation")%>"
					onclick="popWin=open('shownewmap.jsp?lat=<%=rs.getString("tolatitude")%>
													&long=<%=rs.getString("tolongitude")%>
													&discription=<%=rs.getString("tolocation")%>', 
													'myWin','width=500, height=500'); 
													popWin.focus(); return false;"><%=rs.getString("tolocation")%></a>
				
				</div>
				</td>

				<td>
				<div align="right"><%=rs.getString("Distance")%></div>
				</td>
				<td>
				<div align="right"><%=rs.getString("Duration")%></div>
				</td>

			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</table>
		</td>
	</tr>
</table>
</jsp:useBean>
<%@ include file="footernew.jsp"%>

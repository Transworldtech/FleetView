<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<script type="text/javascript">  
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
          document.Total_nd.action ="excel.jsp";
          document.forms["Total_nd"].submit();

        //  document.roundtripdata.action ="excel.jsp";

}  

</script>

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Statement st=null;
Statement st41=null;
Statement st42=null;
Connection conn=null;
Connection conn1=null;

%>
<%int counter=0;
	//final String vehicleRegistrationNumber = request.getParameter("vehno");
	//final String str_list = request.getParameter("str_os");
	// final String str_list=session.getAttribute("Str_os2").toString();
	 final String strp = request.getParameter("count");
	 int num=Integer.parseInt(strp);
	 String uname=session.getAttribute("user").toString();
	//System.out.println("\n\n\n\n\n\nlist---->>>"+str_list);
	//System.out.println("\n\n\n");
	final String data1 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data1").toString();
	final String data2 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data2").toString();
			String  exportFileName=session.getAttribute("user").toString()+"_Total_ND.xls";
			

			System.out.println("The date1 is :"+data1);
			System.out.println("The date1 is :"+data2);
			%>

<form id="Total_nd" name="Total_nd" action="excel.jsp" method="post"
	autocomplete="off">

<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a></td>

			</tr>
		</table>

		<div id="mytable">
		<body>
		<table width="100%" align="center">
			<tr>
				<td colspan="7" align="center">
				<%
					if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:3.8 </font></div>-->
				<font size="3"><b>Night Driving Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:4.8 </font></div>-->
				<font size="3"><b>Night Driving Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:5.8 </font></div>-->
				<font size="3"><b>Night Driving Report</b></font> <%
					}
					if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
					{
%>
				<!-- <div align="left"><font size="3"> Report No:6.8 </font></div>-->
				<font size="3"><b>Night Driving Report</b></font> <%
					}
%>
				</td>
			</tr>
			<tr>
				<td colspan="7" align="center"><b><font size="3">For
				<%=uname %> From Date :<%
				java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
				Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
				String fromdt = formatter.format(date);
				out.print(fromdt); %> To Date :<%
				java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
				String todt = formatter1.format(date3);
				out.print(todt);%> </font></b></td>
			</tr>
		</table>
		<P></P>
		<table border="1" width="100%" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b> VehRegNo</b></th>
				<th><b> Transporter</b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Trip ID</b></th>
				<th><b>Reason</b></th>
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
				
			</tr>
			<%	
		
// string tokens...
int cnt =0;
			int ab=0;
    conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	Statement stexcep = conn1.createStatement();
	Statement st1 = conn1.createStatement();
	Statement st41 = conn1.createStatement();
	Statement st42 = conn1.createStatement();
	Statement st2 = conn1.createStatement();
	Statement st = conn1.createStatement();
	Statement st3 = conn1.createStatement();
	String ss=session.getAttribute("VehList").toString();
	System.out.println("The ss is :"+ss);
	// String ss=request.getParameter("str_os");
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	int i=1;
	//int num=num1;
	try
	{
	while(s.hasMoreTokens())
	{
			
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	
		String query="select * FROM db_gpsExceptions.t_veh"+aa+"_nd where FromDate >='"+data1+"' AND fromDate <= '"+data2+"' ";
		ResultSet rstcounts=stexcep.executeQuery(query);
		while(rstcounts.next()) { cnt++;
			%>
		<tr>
			<td style="text-align: right"><%=++counter%></td>
			<%
			String vehRegNo="-";
			String q1 = "select VehicleRegNumber from db_gps.t_vehicledetails where VehicleCode='"+aa+"'";
			ResultSet rsv = st3.executeQuery(q1);
			if(rsv.next()){
				vehRegNo = rsv.getString("VehicleRegNumber");
			}
			%>
			<td style="text-align: left"><%=vehRegNo%></td>
			<td style="text-align: left"><%=rstcounts.getString("Transporter")%></td>
			<td>
				<div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcounts.getString("FromDate")+" "+rstcounts.getString("FromTime")))%></div>
			</td>
			
			<td style="text-align: left">
				<div align="left">
			<%
			String sql="SELECT LatinDec, LonginDec, TheFieldSubject FROM db_gps.t_veh"+aa+" WHERE Thefielddatadatetime >= '"+rstcounts.getString("FromDate")+" "+rstcounts.getString("FromTime")+"' order by Thefielddatadatetime ASC limit 1 ";
			ResultSet rst=st1.executeQuery(sql);
			if(rst.next()){
				
				  if(null!= rst.getString("TheFieldSubject") && 
						!"null".equalsIgnoreCase(rst.getString("TheFieldSubject")) &&
						null != rst.getString("LatinDec")
						) 
				{
					String lat1=rst.getString("LatinDec");
					String lon1=rst.getString("LonginDec");
					String disc=rst.getString("TheFieldSubject");
					%> <%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>
	<%
				} else if(null!= rst.getString("TheFieldSubject") && 
						!"null".equalsIgnoreCase(rst.getString("TheFieldSubject"))){
					out.println(rst.getString("TheFieldSubject"));
				}
			}
			%>
			</div>
			</td>
			
			<td>
				<div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcounts.getString("ToDate")+" "+rstcounts.getString("ToTime")))%></div>
			</td>
			
			<td style="text-align: left">
				<div align="left">
			<%
			String sql1="SELECT LatinDec, LonginDec, TheFieldSubject FROM db_gps.t_veh"+aa+" WHERE Thefielddatadatetime >= '"+rstcounts.getString("ToDate")+" "+rstcounts.getString("ToTime")+"' order by Thefielddatadatetime ASC limit 1";
			ResultSet rst1=st2.executeQuery(sql1);
			if(rst1.next()){
				
				  if(null!= rst1.getString("TheFieldSubject") && 
						!"null".equalsIgnoreCase(rst1.getString("TheFieldSubject")) &&
						null != rst1.getString("LatinDec")
						) 
				{
					String lat1=rst1.getString("LatinDec");
					String lon1=rst1.getString("LonginDec");
					String disc=rst1.getString("TheFieldSubject");
					%> <%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>
	<%
				} else if(null!= rst1.getString("TheFieldSubject") && 
						!"null".equalsIgnoreCase(rst1.getString("TheFieldSubject"))){
					out.println(rst1.getString("TheFieldSubject"));
				}
			}
			%>
			</div>
			</td>
			<td style="text-align: right">
				<div align="right"><%=rstcounts.getString("Distance") %></div>
			</td>
			<td style="text-align: right">
				<div align="right"><%=rstcounts.getString("Duration") %></div>
			</td>
			<td style="text-align: right">
				<div align="right"><%=rstcounts.getString("JCode") %></div>
			</td>
			
			<td style="text-align: right"><div align="right">
				<%
				String reason="";
			    try{
			   String sqlreason="select reason from db_gpsExceptions.t_ndpostintimation where Vehcode='"+aa+"' and NdStartDateTime='"+rstcounts.getString("FromDate")+" "+rstcounts.getString("FromTime")+"' and NdEndDateTime='"+rstcounts.getString("ToDate")+" "+rstcounts.getString("ToTime")+"'";
			   ResultSet rsreason=st.executeQuery(sqlreason);
			   if(rsreason.next())
			   {
				   reason=rsreason.getString("reason");
				   
			   }
			    }catch(Exception e)
			    {
			    	System.out.println(">>>>>>>>e:"+e);
			    }
			    if(reason.equals("-") || reason.equals(""))
				{

					%>
				<%="<a href=\"veh_report_ndfeedback.jsp?vehregno="+vehRegNo+"&vid="+aa+"&tripid="+rstcounts.getString("JCode")+"&startdatetime="+rstcounts.getString("FromDate")+" "+rstcounts.getString("FromTime")+"&enddatetime="+rstcounts.getString("ToDate")+" "+rstcounts.getString("ToTime")+"\"onclick=\"popWin=window.open('veh_report_ndfeedback.jsp?vehregno="+vehRegNo+"&vid="+aa+"&tripid="+rstcounts.getString("JCode")+"&startdatetime="+rstcounts.getString("FromDate")+" "+rstcounts.getString("FromTime")+"&enddatetime="+rstcounts.getString("ToDate")+" "+rstcounts.getString("ToTime")+"','ND Reason','width=400,height=350');popWin.focus();return false\">Add Reason</a>"%>
				<%
				}
			    else
				{
					if(reason.length()>10)
					{
						%>
						<%="<a href=\"veh_showreason.jsp?reason="+reason+"\"onclick=\"popWin=window.open('veh_showreason.jsp?reason="+reason+"','ND Reason','width=400,height=300');popWin.focus();return false\">Show Reason</a>"%>
					<%}
					else
					{
					%>
					<%=reason %>
				<%}} %>
				</div>
			</td>
			<%
				//out.println("Join query is");
			String sqlostodate="select concat('"+rstcounts.getString("FromDate")+"',' ','"+rstcounts.getString("FromTime")+"') datetim,concat('"+rstcounts.getString("ToDate")+"',' ','"+rstcounts.getString("ToTime")+"') datetim1";
			//out.println("Join query is"+sqlostodate);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+aa+" and snapdatetime>='"+rsostodate.getString("datetim")+"' and snapdatetime<='"+rsostodate.getString("datetim1")+"'  and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %>&data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehRegNo%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{%>
			<td style="text-align:right;">0</a></td>
			<%}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+aa+" and snapdatetime>='"+rsostodate.getString("datetim")+"' and snapdatetime<='"+rsostodate.getString("datetim1")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim")%>&data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehRegNo%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{%>
			<td style="text-align:right;">0</a></td>
			<%}
			}
			
			%>
		</tr>	
			<%} %>



<%
}//end of hasmore tokens	
System.out.println("The cnt is :"+cnt);
		}catch(Exception e)
		{
			e.printStackTrace();
			//out.print("Exception "+e);
		}
	finally
	{
		
		try
		{
		conn.close();
		}catch(Exception e)
		{}
		try
		{
		conn1.close();
		}catch(Exception e)
		{}
		try
		{
		fleetview.closeConnection1();
		}catch(Exception e)
		{}
		try
		{
		fleetview.closeConnection();
		}catch(Exception e)
		{
		}

		
		
	}
		//session.setAttribute("Str_os2","");
%>
		</table>
		</td>
	</tr>
</table>
</body>
</div>
<%@ include file="footernew.jsp"%></form>
<%-- 
    Document   : brif_driverbrifsum
    Created on : Apr 26, 2009, 1:32:17 PM
    Author     : Vikram
--%>
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"trainer_report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn, con1;
Statement st,st1, stmt1;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
int os,ra,rd,cd,nd,osdur;
String oscount,racount,rdcount,cdcount;
%>
<%
	//String trname=request.getParameter("trNm");
	String brfDate = "";
	String trainername = "";
	String brStatus = "";
	String tripid=request.getParameter("tripid");
	String pagefrom=request.getParameter("pgFrom");
	date1=request.getParameter("data");
	date2=request.getParameter("data1");
	if(null==date1)
	{
		date1=date2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}
	//out.print(tbname);
	try
	{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body >
	<table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" >
    <!-- body part come here -->
	<tr><td>
		<table width="100%" align="center" border="0">
				<tr>
				<td  class="sorttable_nosort" colspan="21">
         		<div id="report_heding" align="center"><b><font color="brown" size="2"><% if(pagefrom.equals("brif")) {out.print(" Briefing ");}else if(pagefrom.equals("debrif")){ out.print(" De-Briefing ");}else{out.print(" Briefing Debriefing  ");} %> report for period from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%></font></div>
         		<div align="right">
         		<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
				</td>
			</tr>
		</table>
	</td></tr>
	<tr><td>	
	<table width="100%" border="1" align="center" class="stats">
	<tr bgcolor="lightgrey">
	<th class="hed" rowspan="2" align="center" bgcolor="lightgrey"> Sr.</th>
		<%if(pagefrom.equals("brif"))
		{
		%>
			<th class="hed" rowspan="2" colspan="3" align="center" bgcolor="lightgrey"> Briefing Date</th>
		<%
		}
		else if((pagefrom.equals("debrif")))
		{
		%>
			<th class="hed" rowspan="2" colspan="3" align="center" bgcolor="lightgrey"> Debriefing Date</th>
		<%
		}
		else
		{
		%>
			<th class="hed" rowspan="2" colspan="3" align="center" bgcolor="lightgrey"> Briefing Date</th>
			<th class="hed" rowspan="2"  colspan="3" align="center" bgcolor="lightgrey"> Debriefing Date</th>	
		<%	
		}
		if(pagefrom.equals("both"))
		{
		%>
				<th class="hed" rowspan="2" colspan="3" align="center" bgcolor="lightgrey">Briefing Trainer</th>
				<th class="hed" rowspan="2" colspan="3" align="center" bgcolor="lightgrey">Debriefing Trainer</th>
		<%
		}
		%>
			<th class="hed" rowspan="2" align="center" bgcolor="lightgrey">Vehicle No</th>
			<th class="hed" rowspan="2" align="center" bgcolor="lightgrey">Trip id</th>
			<th class="hed" colspan="3" align="center" bgcolor="lightgrey">Driver</th>
			<th class="hed" rowspan="2" colspan="2" align="center" bgcolor="lightgrey">Transporter</th>
			<th class="hed" colspan="4" align="center" bgcolor="lightgrey">Trip</th>
			<th class="hed" rowspan="2" align="center" bgcolor="lightgrey">GPS Working</th>
			<th class="hed" rowspan="2" align="center" bgcolor="lightgrey">JRM Brif</th>
			<th class="hed" colspan="8" align="center" bgcolor="lightgrey">Violations</th>
		<%
			if(pagefrom.equals("brif"))
			{
		%>
			<th class="hed" rowspan="2" colspan="4" align="center" bgcolor="lightgrey">Briefing Remark</th>
		<%
			}
			else if((pagefrom.equals("debrif")))
			{
		%>
			<th class="hed" rowspan="2" colspan="4" align="center" bgcolor="lightgrey"> Debriefing Remark</th>
		<%
			}
			else
			{
		%>
			<th class="hed" rowspan="2" colspan="4" align="center" bgcolor="lightgrey"> Briefing Remark</th>
			<th class="hed" rowspan="2" colspan="4" align="center" bgcolor="lightgrey"> Debriefing Remark</th>	
		<%	
			}
		%>
			</tr>
			<tr bgcolor="lightgrey">
				<th class="hed" align="center" colspan="2" bgcolor="lightgrey">Name</th>
				<th class="hed" align="center">Driver Id</th>
				<th class="hed" align="center"> Castrol/Non Castrol</th>		
				<th class="hed" align="center" colspan="2">From</th>
				<th class="hed" align="center">To</th>
				<th class="hed" align="center">Distance</th>
				<th class="hed" align="center">OS</th>
				<th class="hed" align="center">OS Dur.</th>
				<th class="hed" align="center">RA</th>
				<th class="hed" align="center">RD</th>
				<th class="hed" align="center">CD</th>
				<th class="hed" align="center">ND</th>
				<th class="hed" align="center">Rating</th>
			</tr>
		<%
			if(pagefrom.equals("brif"))
			{
				sql="select * from t_briefing where brifdate>='"+date1+" 00:00:00' and brifdate<='"+date2+" 23:59:59' order by brifdate desc";
			}
			else if(pagefrom.equals("debrif"))
			{
				sql="select * from t_debriefing where Debriefdate>='"+date1+" 00:00:00' and Debriefdate<='"+date2+" 23:59:59' order by Debriefdate desc";
			}
			else
			{
				sql="select a.brifdate,a.tripid,a.drivername,a.driverid,b.debriefdate,a.gpsdata,a.jrm,a.remark as BriefingRemark,b.trainername as dbtrainer,a.trainername as btrainer,b.remark as DebriefingRemark from t_briefing a,t_debriefing b where a.debrifstatus like 'debrifed' and (a.briefid=b.briefid) and (a.brifdate>='"+date1+" 00:00:00' and a.brifdate<='"+date2+" 23:59:59') order by a.brifdate desc";
			}	
			//out.print(sql);		
			ResultSet rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{
						
			if(pagefrom.equals("brif"))
			{	
				sql="select * from t_completedjourney where date(startdate)<='"+rst.getDate("brifdate")+"' and driverid='"+rst.getString("DriverId")+"' order by StartDate desc limit 1";
			}
			else if(pagefrom.equals("debrif"))
			{
				sql="select * from t_completedjourney where date(enddate)>='"+rst.getDate("debriefdate")+"' and driverid='"+rst.getString("DriverId")+"' order by EndDate asc limit 1";
			}
			else
			{
				sql="select * from t_completedjourney where date(startdate)<='"+rst.getDate("brifdate")+"' and driverid='"+rst.getString("DriverId")+"' order by StartDate desc limit 1";
			}
			ResultSet rsttrip=st1.executeQuery(sql);
			vehregno="-";
			vehregno="-";
			owner="-";
			km="-";
			rating="-";
			from="-";
			to="-";
			String tripidnew="";
			oscount="0";
			racount="0";
			rdcount="0";
			cdcount="0";
			ndcount="0";
			osdur=0;
			if(rsttrip.next())
			{
			vehregno=rsttrip.getString("VehRegNo");
			owner=rsttrip.getString("OwnerName");
			km=rsttrip.getString("KmTravelled");
			rating=rsttrip.getString("TripRating");
			from=rsttrip.getString("StartPlace");
			to=rsttrip.getString("EndPlace");
			tripidnew=rsttrip.getString("tripid");
			//out.print(tripidnew+" - ");
			oscount=rsttrip.getString("OsCount");
			racount=rsttrip.getString("RaCount");
			rdcount=rsttrip.getString("RdCount");
			cdcount=rsttrip.getString("CrCount");
			ndcount=rsttrip.getString("NDCount");
			osdur=rsttrip.getInt("OSDuration");
			}
		%>
			<tr>
			<td><%=i%></td>
		<%
			if(pagefrom.equals("brif"))
			{
		%>		
			<td colspan="3">'
		<%
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("brifdate"))));
		%>
			</td>
		<%
			}
			else if(pagefrom.equals("debrif"))
			{
		%>
			<td colspan="3">'
		<%
			try{
			out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("debriefdate"))));
			}catch(Exception ee)
			{
				out.print("-");
			}
		%>	
			</td>
		<%
			}		
			else
			{
		%>
			<td colspan="3">'
		<%
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("brifdate"))));
		%>
			</td>
			<td colspan="3">'
		<%
			try
			{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("debriefdate"))));
			}
			catch(Exception ee)
			{
				out.print("-");
			}
		%>
			</td>
		<%
			}
			if(pagefrom.equals("both"))
			{
		%>
			<td colspan="3"><%=rst.getString("btrainer")%></td>
			<td colspan="3"><%=rst.getString("dbtrainer")%></td>
			<%
			}
			%>
			<td><%=vehregno%></td>
			<td><%=tripidnew%></td>
			<td colspan="2"><%=rst.getString("DriverName")%></td>
			<td><%=rst.getString("driverid")%></td>
			<td colspan="2"><%=owner%></td>
			<td>Castrol</td>
			<td colspan="2"><%=from%></td>
			<td><%=to%></td>
			<td><%=km%></td>
			<td>
			<%
				if(pagefrom.equals("brif"))
				{			
					out.print(rst.getString("gpsdata"));
				}
				else if(pagefrom.equals("debrif"))
				{
					out.print(rst.getString("gpscapture"));
				}
				else
				{
					out.print(rst.getString("gpsdata"));
				}
			%>
			</td>
			<td><%=rst.getString("JRM")%></td>
			<td><%=oscount%></td>
			<td><%=osdur%></td>
			<td><%=racount%></td>
			<td><%=rdcount%></td>
			<td><%=cdcount%></td>
			<td><%=ndcount%></td>
			<td colspan="1"><%=rating%></td>
			<%
				if(pagefrom.equals("brif"))
				{
			%>
			<td colspan="4"><%=rst.getString("remark")%></td>	
			<%	}
				else if(pagefrom.equals("debrif"))
				{
			%>
			<td colspan="4"><%=rst.getString("Remark")%></td>	
			<%
				}
				else
				{
			%>
			<td colspan="4"><%=rst.getString("BriefingRemark")%></td>
			<td colspan="4"><%=rst.getString("DebriefingRemark")%></td>	
			<%
				}
			%>			
			</tr>			
			<%
				i++;
			}
			%>
			</table>
<%
}
catch(Exception e)
{
 	out.print("Exception::"+e);
}
%>
<%@ include file="footernew.jsp" %>
</body>
</html>
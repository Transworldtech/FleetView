<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
String filename=session.getAttribute("user").toString();
int cnt= 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_custom_report.xls";
}
else
{
	filename = filename=session.getAttribute("user").toString()+"_custom_report.xls";
}
//System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>


<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%
	data1=session.getAttribute("data1").toString();
	data2=session.getAttribute("data2").toString();
	vid=request.getParameter("vid").toString();
	user=session.getAttribute("user").toString();
	vehno=request.getParameter("vehno").toString();
	session.setAttribute("vid",vid);
	session.setAttribute("vehno",vehno);
%>
<table border="0" width="100%" class="stats">
<tr><td>
<table border="0" width="100%" valign="top" class="stats">
<tr><td colspan="2" align="center">

<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.1
	</font>
	</div>
	<font size="3"><b>Date Wise Exceptions</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.1
	</font>
	</div>
	<font size="3"><b>Date Wise Exceptions</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.1
	</font>
	</div>
	<font size="3"><b>Date Wise Exceptions</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.1
	</font>
	</div>
	<font size="3"><b>Date Wise Exceptions</b></font>
	<%
}
%>

</td></tr>
<tr colspan="2">
<td align="center">
<font size="3"><b> Exception Analysis Report For AVL Mobile Eye 2000 For <%=user.toUpperCase() %> Logistics - <%=vehno %> For The Period :  <%=session.getAttribute("ShowDate").toString()%>  to <%=session.getAttribute("ShowDate1").toString()%></b></font>
<div class="bodyText" align="right">
<%=fleetview.PrintDate() %>
</div>
</td></tr>
</table>
<P></P>
<%! 
Connection conn,conn1;
Statement st,st1,st2,st3,st001,st1001;
String data1,data2,vid,user,vehno,str;

String sql10,sql001,sql1001;
ResultSet rst10,rst001,rst1001;
%>
<%
int cntos, cntra, cntrd, cntcr, cntnd, cntst,stcount21,ss7;
double cntavg=0.00,cntdt=0.0,cntfc=0.0;
cntos=0;
cntra=0;
cntrd=0;
cntcr=0;
cntnd=0;
cntst=0;


try{
	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	String tbname="t_veh"+vid+"_ds";
	
	%>

	<table  bgcolor="#F5F5F5" width="100%" class="sortable"  border="1">
<tr>
<th>Sr.</th>
<th>Date</th>
<th>OS</th>
<th>RA</th>
<th>RD</th>
<th>CD</th>
<th>ND</th>
<th>DT</th>
<th>FC</th>
<th>AVG</th>
<th>Stops</th>
<th>Location</th>
</tr>
<%
String sql="select distinct(TheDate),OSCount,RACount,RDCount,CRCount,ND,Distance,Location,StopCount from "+tbname+" where VehCode='"+vid+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'  order by TheDate asc";
ResultSet rst=st2.executeQuery(sql);
int i=1;
while(rst.next())
{
%>
<tr>
	<td><%=i %></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))%></td>
	<td>
	<div align="right">
	<%
			int ss1=rst.getInt("OSCount");
			cntos=cntos+ss1;
			out.print(""+ss1);
		
%>
</div>
</td>
<td>
<div align="right">
	<%
	int ss2=rst.getInt("RACount");
	
		cntra=cntra+ss2;
		out.print(""+ss2);
	
	%>
</div>
</td>
<td>
	<div align="right">
	<%
	int ss3=rst.getInt("RDCount");
	cntrd=cntrd+ss3;
	out.print(""+ss3);
		
	%>
	</div>
</td>



<td>
<div align="right">
	<%
	int ss4=rst.getInt("CRCount");
	cntcr=cntcr+ss4;
	out.print(""+ss4);
	
	%> 
	</div>
</td>
<td>
<div align="right">
<%
String ss5=rst.getString(6);
	cntnd=cntnd+1;
	out.print(""+ss5);

%> 
</div>
</td>
<td><div align="right"><% int aa=rst.getInt(7); cntdt=cntdt+aa; out.print(""+aa); %></div></td>
<%
		if(fleetview.getUnitDescription(vid).equals("FUELFLOW"))
		{
			%>
			<td><div align="right">
			<%
				
				int fcval=fleetview.getFuelConsumptionForDateRange(vid,rst.getString("TheDate"),rst.getString("TheDate"));
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
			</div></td>
			<td><div align="right"><%
			NumberFormat nf=NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			Double favgval=fleetview.getFuelAVGForDateRange(vid,rst.getString("TheDate"),rst.getString("TheDate"));
			//cntavg=cntavg+favgval;
			if(cntfc>0)
			{
				cntavg=cntdt/cntfc;
			}
			out.print(nf.format(favgval));
			
			
			
			%></div></td>
			
			
			
			<%
		}
		else
		{
			%>
			<td><div align="right">-</div></td>
			<td><div align="right">-</div></td>
			<%
		}
			%>
<td><div align="right">
<%
int ss6=rst.getInt("StopCount");
	cntst=cntst+ss6;
	out.print(ss6);

%> 
</div></td>
<td><div align="left">
<%=rst.getString("Location") %>
</div></td>
</tr>
<%
i++;
	}
	}catch(Exception e)
	{
		System.out.println("Exception"+e);
	}
	finally
	{
		conn.close();
		conn1.close();
	}
	%>
<tr class="sortbottom">
<td class="hed" colspan="2">Total</td>
<td class="hed"><div align="right"><%=cntos%></div></td>
<td class="hed"><div align="right"><%=cntra%></div></td>
<td class="hed"><div align="right"><%=cntrd%></div></td>
<td class="hed"><div align="right"><%=cntcr%></div></td>
<td class="hed"><div align="right"><%=cntnd%></div></td>
<td class="hed"><div align="right"><%=cntdt%></div></td>
<td class="hed"><div align="right"><%=cntfc%></div></td>
<td class="hed"><div align="right">
<%
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
%>
<%=nf1.format(cntavg) %></div></td>
<td class="hed"><div align="right"><%=cntst%></div></td>
<td class="hed"><div align="right">-</div></td>
</tr>
	</table>
</td></tr></table>

<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
        <%@ include file="footernew.jsp" %>

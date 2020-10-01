<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"Custome_report.xls";
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
int cntos, cntra, cntrd, cntcr, cntnd, cntst,cntdt,stcount21,ss7,cntfc;
Double cntavg=0.00;
String sql10,sql001,sql1001;
ResultSet rst10,rst001,rst1001;
%>
<%
cntos=0;
cntra=0;
cntrd=0;
cntcr=0;
cntnd=0;
cntst=0;
cntdt=0;
cntfc=0;

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
<th>Stops</th>
<th>Location</th>
</tr>
<%
String sql="select TheDate,OSCount,RACount,RDCount,CRCount,ND,Distance,Location,StopCount from "+tbname+" where VehCode='"+vid+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'  order by TheDate asc";
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

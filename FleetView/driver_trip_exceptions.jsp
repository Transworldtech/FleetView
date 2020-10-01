<%@ include file="header.jsp" %>
<table border="1" bgcolor="white" width="100%" align="center">
<tr><td>
<%!
String thedate,sql,thedate1;
Connection conn,conn1;
Statement st,st1,st2,st3;
int OS1,RA1,RD1,CD1,DT1,ST1,RT1,ND1;
%>
<%
java.util.Date dt= new java.util.Date();
long miles=dt.getTime();
miles=miles-(1000*24*60*60);
dt.setTime(miles);
thedate=new SimpleDateFormat("dd-MMM-yyyy").format(dt);
thedate1=new SimpleDateFormat("yyyy-MM-dd").format(dt);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
}catch(Exception e)
{
	out.print("Connection Exception --->"+e);
}
%>
<table class="stats">
<tr><td>
<table border="0" width="100%">
<tr><td align="center">
<font color="brown" size="2">Driver Rating Report for Castrol Trips for Date <%=thedate%> </font>
<div align="right">
<a href="#" onclick="javascript:window.open('print_Driver_trip_exceptions.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_driver_trip_exceptions.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
</td></tr>
</table>
</td></tr>
<tr><td>
<table border="0" class="sortable" width="100%">
<tr>
<td class="hed">Sr.</td>
<td class="hed">Driver Name</td>
<td class="hed">Transporter</td>
<td class="hed">Trip Id</td>
<td class="hed">OS</td>
<td class="hed">RA</td>
<td class="hed">RD</td>
<td class="hed">CD</td>
<td class="hed">DT</td>
<td class="hed">ST</td>
<td class="hed">ND</td>
<td class="hed">Rating</td>
</tr>
<%
try{
OS1=0;
RA1=0;
RD1=0;
CD1=0;
DT1=0;
ST1=0;
RT1=0;
ND1=0;
	String trans="(";
	sql="select Distinct(VehRegNo) from t_group where GPName='Castrol'";
	ResultSet rstgp=st.executeQuery(sql);
	while(rstgp.next())
	{
		trans=trans+"'"+rstgp.getString("VehRegNo")+"',";
	}
	trans=trans.substring(0,trans.length()-1);
	trans=trans+")";
	//out.print(trans);
	
	sql="select * from t_driver_ds where TheDate='"+thedate1+"' and Jcode <>'-' and Transporter in "+trans+" order by rating Desc";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;	
	while(rst.next())
	{
	%>
	<tr>
	<td><%=i%></td>
	<td><div align="left"><% 
		sql="select DriverName from t_alljddata where DriverCode='"+rst.getString("Dcode")+"'";	
		ResultSet rstdriver=st.executeQuery(sql);
		if(rstdriver.next())
		{
			out.print(rstdriver.getString("DriverName"));
		}
		out.print(" ( "+rst.getString("Dcode")+" )");
	 %></div></td>
	<td><div align="left"><%=rst.getString("Transporter")%></div></td>
	<td><div align="right"><%=rst.getString("Jcode")%></div></td>
	<td><div align="right"><%=rst.getString("OSCount")%></div></td>
	<td><div align="right"><%=rst.getString("RACount")%></div></td>
	<td><div align="right"><%=rst.getString("RDCount")%></div></td>
	<td><div align="right"><%=rst.getString("CRCount")%></div></td>
	<td><div align="right"><%=rst.getString("Distance")%></div></td>
	<td><div align="right"><%=rst.getString("StopCount")%></div></td>
	<td><div align="right"><%=rst.getString("ND")%></div></td>
	<td><div align="right"><%
	
		String ss=""+rst.getDouble("Rating");
		if(ss.length() >5)
		{
			ss=ss.substring(0,ss.indexOf(".")+2);
		}
		out.print(ss);
	%></div></td>
	</tr>	
	<%
	OS1=OS1+rst.getInt("OSCount");
	RA1=RA1+rst.getInt("RACount");
	RD1=RD1+rst.getInt("RDCount");	
	CD1=CD1+rst.getInt("CRCount");
	DT1=DT1+rst.getInt("Distance");
	ST1=ST1+rst.getInt("StopCount");
	if(rst.getString("ND").equals("Yes"))
	{
	ND1++;
	}
	RT1=RT1+rst.getInt("Rating");	
	i++;
	}
	%>
	<tr class="sortbottom">
	<td class="hed" colspan="4">Total</td>
	<td class="hed"><%=OS1%></td>
	<td class="hed"><%=RA1%></td>
	<td class="hed"><%=RD1%></td>
	<td class="hed"><%=CD1%></td>
	<td class="hed"><%=DT1%></td>
	<td class="hed"><%=ST1%></td>
	<td class="hed"><%=ND1%></td>
	<td class="hed"><%
	double rt=RT1/i;
	out.print(rt);	
	%></td>
	</tr>	
	<%
}catch(Exception ee)
{
	out.print("Sql Query Exceptions ---->"+ee);
}
finally
{
	st.close();
	st1.close();
	st2.close();
	st3.close();
	conn.close();
	conn1.close();
}
%>
</table>
</td></tr>
</table>
</td></tr>
</table>
<!-- footer starts here-->
<table border="1" width="100%" bgcolor="white">
<tr ><td class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
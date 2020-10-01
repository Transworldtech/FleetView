<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
 <%  response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"currentposition.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);

%> 
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn,conn1;
Statement st,st1;
ResultSet rst;
String user,VehList1,aa,regno;
int cnt1, cnt2;
%>
<%
VehList1=(String)session.getValue("VehList");
try{
	cnt1=0;
	cnt2=0;
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","root","flashkit");
	st=conn.createStatement();
	st1=conn.createStatement();
	String sql="select * from t_unitreplacement where VehCode='0' and NewUnitID <>'-' order by OwnerName asc";
	ResultSet rst=st1.executeQuery(sql);
%><TABLE >
<TR><TD>Owner Name</TD><TD>Unit Id</TD><TD>Sim No.</TD><TD>Mob. No.</TD></TR>
<%
	while(rst.next())
	{
	cnt1++;
	//String str=rst.getString("TheFieldFromEmailAddress");
	//out.print(str);
	//int pos=str.indexOf("@");
	//String id=str.substring(2,pos);
	//out.print(id+"<br>");
	String id=rst.getString("NewUnitID");
	String sql1="select * from t_unitmaster where UnitId='"+id+"'";
	ResultSet rst1=st.executeQuery(sql1);
	%>
	<tr>
	<td><%=rst.getString("OwnerName")%></td>
	<td><%=id%></td>
	<%
	if(rst1.next())
	{
	cnt2++;
	%>
	<td><%=rst1.getString("SimNo")%></td>
	<td><%=rst1.getString("MobNo")%></td>
	</tr>
	<%
	}
	else
	{
	%>
	<td></td>
	<td></td>
	</tr>
	<%
	}
	}
}
catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();

	conn1.close();
}

%>

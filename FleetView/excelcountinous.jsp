<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"Countinous_Driving.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>

<table border="0" width="100%">
<tr><td>
<%

String userID1 = "";
if (! session.isNew()) 
userID1 = (String) session.getAttribute("user");
if (null == userID1) 
	{
		response.sendRedirect("index.html");
	}
else
	{
		
%>
<table border="0" width="100%">
<tr><td><b>CONTINUOUS DRIVING for Vehicle <%=session.getAttribute("vehno") %> On Date :<%

java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String s = formatter.format(date);
out.print(s);
 %></b></td></tr>
</table>
<table border="0" width="100%">
<tr><td colspan="2"><b>Period</b></td><td rowspan="2"><b>Distance Covered in kms
</b></td><td rowspan="2"> <b>Duration
</b></td></tr>
<tr><td><b>From </b></td><td><b>To</b></td></tr>
<%!
Connection conn;
 %>
<%
	String data1,data2,vid,vehno,dd;
	data1=session.getAttribute("data1").toString();
	data2=session.getAttribute("data2").toString();
	vid=session.getAttribute("vid").toString();
	vehno=session.getAttribute("vehno").toString();
	dd=request.getParameter("dd").toString();
	String tbname="t_veh"+vid+"_cr";
	try{
		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=conn.createStatement();
	String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		%>
	<tr><td><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%> <%=rst.getString(3) %></td><td><%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(4));
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter2.format(ShowDate2);
 out.print(showdate2);

%> <%=rst.getString(5) %></td><td><%=rst.getString(8) %><td><%=rst.getString(6) %></td></tr>
		<%
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
	finally
	{
		conn.close();
	}




 %>
</table>
<% }
%>
</td></tr>
</table>

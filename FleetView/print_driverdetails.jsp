<%@ include file="headerprintnew.jsp" %> 

<link href="css/css.css" rel="StyleSheet" type="text/css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<table border="1" width="100%">
<%!
Connection conn;
Statement st;

%>
<%
try{
	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	String driverid =request.getParameter("driverid");
	//System.out.println("driverid in print"+driverid);
	String sql1= "select * from t_drivertraining where Dcode = '"+driverid+"'";
	ResultSet rst1=st.executeQuery(sql1);
	if(rst1.next())
	{
		%>
		<tr><td align="center" colspan="3"><b><font size="3" color="maroon">Details of <%=rst1.getString("DriverName") %></td>
		<%
	}
	%>
<body>
<table border="1" width="100%">
<tr ><th><font size="2" >Sr.</font></th>
<th><font size="2" >Name</font></th>
<th><font size="2" >Father's Name</font></th>
<th><font size="2" >Date of Birth</font></th>
<th><font size="2" >Education </font></th>
<th><font size="2" >vendor</font></th>
<th><font size="2" >License No</font></th>
<th><font size="2" >License Type</font></th>
<th><font size="2" >License Place of issue</font></th>
<th><font size="2" >License Expire Date</font></th>
<th><font size="2" >PreTest 40 MM.</font></th>
<th><font size="2" >PreTest %</font></th>
<th><font size="2" >PostTest 40 MM.</font></th>
<th><font size="2" >PostTest %</font></th>
<th><font size="2" >Type of vehicle used for on road coaching and for assessment</font></th>
<th><font size="2" >Driving school education grade</font></th>
<th><font size="2" >Remark</font></th>
</tr>

<%
int count=1;
String sql= "select * from t_drivertraining where Dcode='"+driverid+"'";
//System.out.println("sql from driverdetails-->"+sql);
ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
	%>
	<td style="text-align: right"><font size="2" ><%=count++ %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("DriverName") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("DriverFatherName") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("DOB") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("Education") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("vendor") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("licenceno") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("LicenseType") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("Place")%></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("ExpiryDate") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("PreTest40MM") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("PreTestper") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("PostTest40MM") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("PostTestper") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("Typeofvehicle") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("educationgrade") %></font></td>
	<td style="text-align: left"><font size="2" ><%=rst.getString("Remark") %></font></td>
</table>
<%
}
%>


<%
}catch(Exception e)
{
out.print("Exception--->"+e);
}	
finally
{
    
  //System.out.println("..........");  
conn.close();
}
%>

<%@ include file="footernew.jsp" %>

</table>
<br></br>

</body>
</html>
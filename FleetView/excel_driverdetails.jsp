<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"irtedriverdetails.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn;
Statement st;

%>
<%
try{
	int i=1;
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	String driverid =request.getParameter("driverid");
	session.setAttribute("driverid",driverid);
	//System.out.println("driverid in excel"+driverid);
	%>
<body>


<br></br>

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

<br></br>

</body>
</html>
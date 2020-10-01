<%@ include file="headernew.jsp" %>
<%!
	Connection conn;
	Statement st, st1,st2,st3;
	String sql,qd,sql1,sql2,location,locationcode,vehlist;
	int ds;
	double Lat1,Lat2,Lon1, Lon2;
%>
<%
	java.util.Date NewDate=new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
String data1 = NewFormatter.format(NewDate);
try
{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
%>
<table border="0" width="100%">
<tr><td >
<form action="sellocation.jsp" method="get">

<!--  <form action="validateusernew.jsp" method="get">  -->
<table border="0" bgcolor="white" class="sortable">
<tr>
			<td align="center">
			<!-- <div align="left"><font size="3" >Report No: 3.1</font></div>-->
			</td>
			</tr>
<tr><td align="center" colspan="5">Please select the location to show the journey details.</td></tr>
<tr><td>
<%
sql="select distinct(wareHouse),wareHouseCode from t_warehousedata where Owner='"+session.getAttribute("user").toString()+"' and WareHouse <>'-'  order by WareHouse asc";
//out.print(sql);
//sql="select distinct(MainLocationCode) as wareHouseCode, MainLocationName as WareHouse from t_masterlocation where OwnerName='"+session.getAttribute("usertypevaluemain").toString()+"' order by WareHouse";
ResultSet rst=st.executeQuery(sql);
%>
<select name="location">
<%
int i=0;
while(rst.next())
{
i++;
%>
<option value="<%=rst.getString("WareHouseCode")%>,<%=rst.getString("WareHouse")%>"><%=rst.getString("WareHouse")%></option>
<%

}
%>
</select>
<%
if(i == 0)
{
	out.print("<br><font color='red' size='2'>No Location Geo-Fenced !!</font>");
}

%>
</td></tr>
<tr><td>
<input type="submit" name="submit" value="Submit" class="formElement">
</td></tr>
</table>
</form>

</td></tr>
</table>
<%

}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}
%>
<%@ include file="footernew.jsp" %>

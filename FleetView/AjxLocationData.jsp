<%@ include file="Connections/conn.jsp" %>


  	 

<%!
Connection con1;

%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=con1.createStatement();
Statement st1=con1.createStatement();
Statement stmtinsert=con1.createStatement();

String sql="";

	String wtype=request.getParameter("wtype");
	
	if(wtype.equals("All") || wtype.equalsIgnoreCase("All"))
	{
		System.out.println("In If");
		 sql = "select Latitude,Longitude,WareHouse from db_gps.t_warehousedata where (Owner like '%"+session.getAttribute(
			"usertypevalue").toString()+"%' or Transporter like '%"+session.getAttribute("usertypevalue").toString()+"%') group by WareHouse having count(*) >= 1 order by WareHouse";
			System.out.println("***    "+sql);
		
	}
	else{
		System.out.println("In Else");

	 sql = "select Latitude,Longitude,WareHouse from db_gps.t_warehousedata where (Owner like '%"+session.getAttribute(
	"usertypevalue").toString()+"%' or Transporter like '%"+session.getAttribute("usertypevalue").toString()+"%') and WType='"+wtype+"'  group by WareHouse having count(*) >= 1 order by WareHouse";
	System.out.println("***    "+sql);
	}
	ResultSet rs = st1.executeQuery(sql);
	while(rs.next())
	{
		%>
			<option value="<%=rs.getString("Latitude")%>,<%=rs.getString("Longitude")%>,<%=rs.getString("WareHouse")%>"><%=rs.getString("WareHouse")%></option>					
		<%
	}

	
	
	
}
catch(Exception e)
{
	e.printStackTrace();
}finally
{
	// st.close();
	con1.close();
}
%>




	
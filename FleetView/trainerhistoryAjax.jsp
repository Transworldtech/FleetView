<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%!
Connection con1;
Statement st,st1,st2,st3;
%>
<% 
try {

//Class.forName(MM_dbConn_DRIVER);
con1 = fleetview.ReturnConnection();
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
System.out.println("IN1");
String category=request.getParameter("category");
boolean flg=true;

flg=true;
//String sql7="select distinct(Categoery1) From db_gps.t_JourneyGoals where Categoery='"+category+"'";
String sql7="select TrainerName from t_briefing where TrainerName Not like '%he_india%' and  TrainerName='"+category+"' group by  ";
if(category.equalsIgnoreCase("All"))
{
	sql7="SELECT TrainerName,Driverid,DriverName FROM db_gps.t_briefing GROUP BY DriverName";
	
}else{
sql7="SELECT TrainerName,Driverid,DriverName FROM db_gps.t_briefing  WHERE TrainerName = '"+category+"' GROUP BY DriverName";
}
	ResultSet rs7 = st2.executeQuery(sql7);
	System.out.println(sql7);
	String SrhCat="";
	int i=0;
	
	while(rs7.next())
	{flg=false;
		
		if(i==0)
		{
			SrhCat="All~"+rs7.getString("DriverName");
			i=1;
		}
		else
		{
			SrhCat=SrhCat+"~"+rs7.getString("DriverName");
		}
	}
	
		if(flg==true)
		{
			SrhCat="All";
		}
			out.print(SrhCat);		

}
	catch(Exception e) { 
		out.print("Not"+e);
		}

	finally
	{
		st.close();
		con1.close();
		try
		{fleetview.closeConnection();}
		catch(Exception e)
		{}
	}
%>
</jsp:useBean>
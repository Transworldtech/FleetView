<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1;
%>
<% 
try {
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String IncDate=formatter.format(tdydte);
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;
int element=99;

String DriveId=request.getParameter("DriveId");
String BrifId=request.getParameter("BrifId");

//String debriefid=request.getParameter("debriefid");


String inci=request.getParameter("inci1");



String buffer;


try{
sql="update db_gps.t_briefing set Incident='"+inci+"' where Driverid='"+DriveId+"' and  Briefid ='"+BrifId+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
if(ins>=1){
		buffer="Updated";
		System.out.println("Updates : "+sql);
		out.print(buffer);

//buffer=null;
}


	

	sql1="update db_gps.t_briftimestamp set IncidentT='"+IncDate+"' where  BrifId ='"+BrifId+"'";
	st1.executeUpdate(sql1);
	System.out.println("$$$$$$"+sql1);
	
}
catch(Exception e)
{
	
	e.printStackTrace();
}

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		st1.close();
		con1.close();
	}

%>
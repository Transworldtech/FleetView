
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;

String DriveId=request.getParameter("DriveId");
String TripId=request.getParameter("tripid");
String CId=request.getParameter("CId");

//String debriefid=request.getParameter("debriefid");
String buffer="False~";
//sql="select CleanerId from db_gps.t_briefing where Driverid='"+DriveId+"' and  tripid='"+TripId+"'";
sql="select Cleanerid from db_gps.t_cleaners where  Status='Active' and Cleanerid='"+CId+"'" ;
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ResultSet rr= st.executeQuery(sql);

if(rr.next())
{
	if(rr.getString("CleanerId").equalsIgnoreCase(CId))
	{
		buffer="True";
		System.out.println("Updates : "+sql);
		out.print(buffer);
	}else
	{
		buffer="False~"+rr.getString("CleanerId");
		System.out.println("Updates : "+sql);
		out.print(buffer);
	}

//buffer=null;
}
else
{
	buffer="False~NotBrif";
	System.out.println("Updates : "+sql);
	out.print(buffer);
}

} catch(Exception e) { 
	out.print("False~");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>

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
String TripId=request.getParameter("TripId");

//String debriefid=request.getParameter("debriefid");


String Feedback=request.getParameter("Feedback");

System.out.println(Feedback);
String buffer;



sql="update db_gps.t_debriefing set Feedback='"+Feedback+"' where Driverid='"+DriveId+"' and  tripid='"+TripId+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
if(ins>=1){
		buffer="Updated";
		System.out.println("Updates : "+sql);
		out.print(buffer);

//buffer=null;
}

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>

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
String BrifId=request.getParameter("BrifId");

//String debriefid=request.getParameter("debriefid");


String ChkVeh=request.getParameter("ChkVeh");
//String inci=request.getParameter("inci1");
String reason1=request.getParameter("reason1");

System.out.println(ChkVeh+" ` "+reason1);
String buffer;



sql="update db_gps.t_briefing set VehPass='"+ChkVeh+"',VehPassReason='"+reason1+"' where Driverid='"+DriveId+"' and  BriefId='"+BrifId+"'";
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
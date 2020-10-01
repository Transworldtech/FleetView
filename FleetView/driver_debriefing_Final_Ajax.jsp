
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1,st2,st3;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
ResultSet rst=null;
String sql="";
String sql1="";
boolean flag=false;
int element=99;
String sql11="";
int ins2=0;	
int ins1=0;
String DriveId=request.getParameter("DriveId");
String TripId=request.getParameter("TripId");

//String debriefid=request.getParameter("debriefid");


//String TFinal=request.getParameter("TFinal");

//System.out.println("State : "+TFinal);
String buffer="",sql4="";

sql="update db_gps.t_debriefing set Status='Close' where Driverid='"+DriveId+"' and  tripid ='"+TripId+"'";
System.out.println("$$$$$$1111"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
System.out.println("$$$$$$"+ins);

sql11="select * from db_gps.t_debriefing where Driverid='"+DriveId+"' and  tripid='"+TripId+"'";
rst=st3.executeQuery(sql11);
System.out.println(sql11);		
if(rst.next())
{	
	
	sql1="update db_gps.t_briefing set Debrifstatus='debrifed', DeBrifingStatus='Close' where Driverid='"+DriveId+"' and  tripid='"+TripId+"'";
	System.out.println("$$$$$$3333"+sql1);
	/*****************************/
	ins2=st2.executeUpdate(sql1);
	System.out.println("$$$$$$3333"+sql1);
	System.out.println("Number "+ins2);
	if(ins2>=1){
		buffer="Debriefing is Completed Sucessfully";
		System.out.println("Updates2 : "+sql1);
		out.print(buffer);}
	
	
	}
	
else
	{
		buffer="Debriefing is Incompleted";
		System.out.println("Updates4 : "+sql);
		out.print(buffer);}
	
//buffer=null;


} catch(Exception e) { 
	out.print("NotDone"+e);
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
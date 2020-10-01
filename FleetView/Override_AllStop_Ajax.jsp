
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5,st6,st7;
%>
<% 
try {
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
st4=con1.createStatement();
st5=con1.createStatement();
st6=con1.createStatement();
st7=con1.createStatement();



ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;
int element=99;

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar now123=Calendar.getInstance();
String sysdate22 = dateFormat.format(now123.getTime());
System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);






String date11="",date12="",commentreason="";
String vehid=request.getParameter("vehid");
String date1=request.getParameter("date1");
String date2=request.getParameter("date2");
String comments=request.getParameter("comments7");
String otherall=request.getParameter("otherall");
String userid=session.getAttribute("mainuser").toString();
if(comments=="Other" || comments.equalsIgnoreCase("Other") )
{
	commentreason=otherall;
}
else
{
	commentreason=comments;
}
//System.out.println("vehid of save all : "+vehid);
//System.out.println("date1 of save all : "+date1);
//System.out.println("date2 of save all : "+date2);

//System.out.println("comment of save all : "+comments);

date11=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(date1));
date12=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(date2));
String buffer;

sql = "select FromDatetime from db_gpsExceptions.t_vehall_stsp where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"' and Duration > '04:00:00' and FromTime >='05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate ";
ResultSet rs = st.executeQuery(sql);
while(rs.next())
{
	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("FromDatetime")+"'  and enddate >= '"+rs.getString("FromDatetime")+"'  and vehid = '"+vehid+"' ";
	st1.executeUpdate(sql1);
}

String sql5="Update db_gpsExceptions.t_vehall_stsp set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <= '"+date2+"' and Duration > '04:00:00' and FromTime >= '05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate ";
 int insstop=0;

 insstop=st5.executeUpdate(sql5);
 System.out.println("$$$$$$"+insstop); 
 
 
if( insstop>=1){
	buffer="Updates";
	System.out.println("Updates:"+buffer);
	out.print(buffer);

}
else{
buffer="NotDone";
System.out.println("NotDone:"+buffer);
out.print(buffer);
}


		



}
 catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
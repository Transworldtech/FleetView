
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



sql="update db_gpsExceptions.t_vehall_ra set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where VehCode='"+vehid+"' and violationstatus='Open' and  TheDatetime >= '"+date1+"' and  TheDatetime <='"+date2+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);



	
 sql1="update db_gpsExceptions.t_vehall_rd set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where VehCode='"+vehid+"' and violationstatus='Open' and  TheDatetime >= '"+date1+"' and  TheDatetime <='"+date2+"'";
 int insrd=0;
 insrd=st1.executeUpdate(sql1);
 System.out.println("$$$$$$"+insrd);

String sql2="update db_gpsExceptions.t_vehall_overspeed set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where VehCode='"+vehid+"' and violationstatus='Open' and  FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
int insos=0;

insos=st2.executeUpdate(sql2);
 System.out.println("$$$$$$"+insos);

 String sql3="update db_gpsExceptions.t_vehall_crcopy set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where VehCode='"+vehid+"' and violationstatus='Open' and  FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
 int inscd=0;

inscd=st3.executeUpdate(sql3);
 System.out.println("$$$$$$"+inscd);

 
 String sql4="update db_gpsExceptions.t_vehall_nd set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where VehCode='"+vehid+"' and violationstatus='Open' and  FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
 int insnd=0;

insnd=st4.executeUpdate(sql4);
 System.out.println("$$$$$$"+insnd);

 
 String sql5="update db_gpsExceptions.t_vehall_stsp set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where VehCode='"+vehid+"' and violationstatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
 int insstop=0;

 insstop=st5.executeUpdate(sql5);
 System.out.println("$$$$$$"+insstop); 
 
 
 
 String sql6="update db_gpsExceptions.t_vehall_ds set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where vehcode='"+vehid+"' and violationstatus='Open' and RDuration > '10:00:00' and  thedate >= '"+date11+"' and  thedate <='"+date12+"'";
 int insrhr=0;

 insrhr=st6.executeUpdate(sql6);
 System.out.println("$$$$$$"+insrhr);
	
 
 
 String sql7="update db_gps.t_disconnectionData set ClosingComment='"+commentreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where vehicleCode='"+vehid+"' and violationstatus='Open' and Reason='Disconnection' and OffTimeFrom >= '"+date1+"' and  OffTimeFrom <='"+date2+"'";
 int insdicon=0;

 insdicon=st7.executeUpdate(sql7);
 System.out.println("$$$$$$"+insdicon); 







if(ins>=1 || insos>=1 || insrd>=1 || inscd>=1 || insnd>=1 || insrhr>=1 || insdicon>=1 || insstop>=1){
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
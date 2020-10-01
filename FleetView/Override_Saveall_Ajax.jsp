
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
System.out.println(">>>>>vehid>>>>>>>>>>n "+vehid);

String date1=request.getParameter("date1");
System.out.println(">>>>>date1>>>>>>>>>>n "+date1);

String date2=request.getParameter("date2");
System.out.println(">>>>>>date2>>>>>>>>>n "+date2);

String comments=request.getParameter("comments7");
System.out.println(">comments>>>>>>>>>>>>>>n "+comments);

String otherall=request.getParameter("otherall");
System.out.println(">>>otherall>>>>>>>>>>>>n "+otherall);

String userid=session.getAttribute("mainuser").toString();
System.out.println(">>>>>>userid>>>>>>>>>n "+userid);

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

sql = "select TheDatetime from db_gpsExceptions.t_vehall_ra where VehCode='"+vehid+"' and OverrideStatus='Open' and TheDatetime >= '"+date1+"' and  TheDatetime <='"+date2+"' ";
ResultSet rs = st.executeQuery(sql);
while(rs.next())
{
	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("TheDatetime")+"'  and enddate >= '"+rs.getString("TheDatetime")+"'  and vehid = '"+vehid+"' ";
	st1.executeUpdate(sql1);
}

sql="update db_gpsExceptions.t_vehall_ra set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open'  and  TheDatetime >= '"+date1+"' and  TheDatetime <='"+date2+"'";
//System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);

System.out.println("$$$$$$11111  "+sql);

sql = "select TheDatetime from db_gpsExceptions.t_vehall_rd where VehCode='"+vehid+"' and OverrideStatus='Open' and TheDatetime >= '"+date1+"' and  TheDatetime <='"+date2+"' ";
 rs = st.executeQuery(sql);
while(rs.next())
{
	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("TheDatetime")+"'  and enddate >= '"+rs.getString("TheDatetime")+"'  and vehid = '"+vehid+"' ";
	st1.executeUpdate(sql1);
}
	
 sql1="update db_gpsExceptions.t_vehall_rd set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open' and  TheDatetime >= '"+date1+"' and  TheDatetime <='"+date2+"'";
 int insrd=0;
 insrd=st1.executeUpdate(sql1);
 System.out.println("$$$$$$222222222  "+sql1);

 sql = "select FromDatetime from db_gpsExceptions.t_vehall_overspeed where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"' ";
 rs = st.executeQuery(sql);
while(rs.next())
{
	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("FromDatetime")+"'  and enddate >= '"+rs.getString("FromDatetime")+"'  and vehid = '"+vehid+"' ";
	st1.executeUpdate(sql1);
}
 
String sql2="update db_gpsExceptions.t_vehall_overspeed set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open' and  FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
int insos=0;

insos=st2.executeUpdate(sql2);
 System.out.println("$$$$$$3333333333  "+sql2);

 sql = "select FromDatetime from db_gpsExceptions.t_vehall_crcopy where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"' ";
 rs = st.executeQuery(sql);
while(rs.next())
{
	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("FromDatetime")+"'  and enddate >= '"+rs.getString("FromDatetime")+"'  and vehid = '"+vehid+"' ";
	st1.executeUpdate(sql1);
}
 
 String sql3="update db_gpsExceptions.t_vehall_crcopy set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open' and  FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
 int inscd=0;

inscd=st3.executeUpdate(sql3);
 System.out.println("$$$$$$444444444 "+sql3);

 sql = "select FromDatetime from db_gpsExceptions.t_vehall_nd where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"' ";
 rs = st.executeQuery(sql);
while(rs.next())
{
	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("FromDatetime")+"'  and enddate >= '"+rs.getString("FromDatetime")+"'  and vehid = '"+vehid+"' ";
	st1.executeUpdate(sql1);
}
 
 String sql4="update db_gpsExceptions.t_vehall_nd set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open' and  FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'";
 int insnd=0;

insnd=st4.executeUpdate(sql4);
 System.out.println("$$$$$$55555555 "+sql4);

 sql = "select FromDatetime from db_gpsExceptions.t_vehall_stsp where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"' and Duration > '04:00:00' and FromTime >='05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate ";
 rs = st.executeQuery(sql);
 while(rs.next())
 {
 	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+rs.getString("FromDatetime")+"'  and enddate >= '"+rs.getString("FromDatetime")+"'  and vehid = '"+vehid+"' ";
 	st1.executeUpdate(sql1);
 }
 
 String sql5="update db_gpsExceptions.t_vehall_stsp set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and OverrideStatus='Open' and FromDatetime >= '"+date1+"' and  FromDatetime <='"+date2+"'  and Duration > '04:00:00' and FromTime >='05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate ";
 int insstop=0;

 insstop=st5.executeUpdate(sql5);
 System.out.println("$$$$$$66666666666  "+sql5); 
 
 sql = "select thedate from db_gpsExceptions.t_vehall_ds where vehcode='"+vehid+"' and OverrideStatus='Open' and RDuration > '10:00:00' and  thedate >= '"+date11+"' and  thedate <='"+date12+"' ";
 rs = st.executeQuery(sql);
 while(rs.next())
 {
 	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where ((startdate <= '"+rs.getString("thedate")+" 00:00:00'  and enddate >= '"+rs.getString("thedate")+" 23:59:59')  or (startdate >= '"+rs.getString("thedate")+" 00:00:00'  and  enddate <= '"+rs.getString("thedate")+" 23:59:59'))   and vehid = '"+vehid+"' ";
 	st1.executeUpdate(sql1);
 }
 
 String sql6="update db_gpsExceptions.t_vehall_ds set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where vehcode='"+vehid+"' and OverrideStatus='Open' and RDuration > '10:00:00' and  thedate >= '"+date11+"' and  thedate <='"+date12+"'";
 int insrhr=0;

 insrhr=st6.executeUpdate(sql6);
 System.out.println("$$$$$$777777777777  "+sql6);
	
 sql = "select OffTimeFrom,OffTimeTo from db_gps.t_disconnectionData where vehicleCode='"+vehid+"' and OverrideStatus='Open' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30'  and OffTimeFrom >= '"+date1+"' and  OffTimeFrom <='"+date2+"' ";
 rs = st.executeQuery(sql);
 while(rs.next())
 {
 	sql1 = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where ((startdate <= '"+rs.getString("OffTimeFrom")+"' and enddate >= '"+rs.getString("OffTimeFrom")+"') or (startdate <= '"+rs.getString("OffTimeTo")+"' and enddate >= '"+rs.getString("OffTimeTo")+"') or (startdate >= '"+rs.getString("OffTimeFrom")+"' and enddate <= '"+rs.getString("OffTimeTo")+"')) and vehid = '"+vehid+"' ";
 	st1.executeUpdate(sql1);
 }
 
 String sql7="update db_gps.t_disconnectionData set OverrideComents='"+commentreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where vehicleCode='"+vehid+"' and OverrideStatus='Open' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30'  and OffTimeFrom >= '"+date1+"' and  OffTimeFrom <='"+date2+"'";
 int insdicon=0;

 insdicon=st7.executeUpdate(sql7);
 System.out.println("$$$$$$8888888888888  "+sql7); 







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
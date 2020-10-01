
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1,st2;
%>
<% 
try {
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;
int element=99;


DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar now123=Calendar.getInstance();
String sysdate22 = dateFormat.format(now123.getTime());
System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);



String vehid=request.getParameter("vehid");
String date=request.getParameter("date");
String comment=request.getParameter("comment");
String userid=session.getAttribute("mainuser").toString();



String otherreason="";
String other=request.getParameter("otherrson");
String usertypevalue=session.getAttribute("usertypevalue").toString();

if(comment=="Other" || comment.equalsIgnoreCase("Other"))
{
	otherreason=other;
	String sqlck="select * from db_gps.t_violationclose where Reason='"+otherreason+"'";
    System.out.println("NON insert for other query"+sqlck);

	ResultSet rs=st.executeQuery(sqlck);
	if(rs.next())
	{
		
	    System.out.println("NON insert for other query");

	}else{
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','Discon','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }}
else
{
	otherreason=comment;
}




//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));



String buffer;



sql="update db_gps.t_disconnectionData set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where vehicleCode='"+vehid+"' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30' and OffTimeFrom='"+date+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
if(ins>=1){
	
	String sqlup="insert into db_gpsExceptions.t_override_dc select * from db_gps.t_disconnectionData where vehicleCode='"+vehid+"' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30' and OffTimeFrom='"+date+"'";
	System.out.println(sqlup);
	st2.executeUpdate(sqlup);
	
	
	
	String date1 = "";
	sql = "select OffTimeTo from db_gps.t_disconnectionData where vehicleCode = '"+vehid+"' and  Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30' and OffTimeFrom='"+date+"'  ";
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		date1 = rs.getString("OffTimeTo");
	}
	
	sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where ((startdate <= '"+date+"' and enddate >= '"+date+"') or (startdate <= '"+date1+"' and enddate >= '"+date1+"') or (startdate >= '"+date+"' and enddate <= '"+date1+"')) and vehid = '"+vehid+"' ";
	st.executeUpdate(sql);
	
	buffer="Updates"+"-"+otherreason;
		System.out.println("Updates : "+sql);
		out.print(buffer);

		
		//buffer=null;
}



}
 catch(Exception e) { 
	 e.printStackTrace();
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
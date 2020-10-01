
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1;
%>
<% 
try {
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",sql1="";
boolean flag=false;
int element=99;

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Calendar now123=Calendar.getInstance();
String sysdate22 = dateFormat.format(now123.getTime());
System.out.println(">>>>>>>>>>>>>>>11111111111111111111111111n "+sysdate22);




String vehid=request.getParameter("vehid");
System.out.println("vehid "+vehid);

String date=request.getParameter("date");
System.out.println("date "+date);

String comment=request.getParameter("comment");
System.out.println("commentn "+comment);

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
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','Stop','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }}
else
{
    System.out.println("In elde-------------------------__>");

	
	otherreason=comment;
}



try
{
//date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(date));
}
catch(Exception e)
{
	System.out.println("date-------------> " +e);
}


String buffer;



sql="update db_gpsExceptions.t_vehall_stsp set OverrideComents='"+otherreason+"', OverrideStatus='Close',OverrideBy='"+userid+"',OverrideDateTime='"+sysdate22+"' where VehCode='"+vehid+"' and  FromDatetime='"+date+"' and Duration > '04:00:00' and FromTime >='05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
System.out.println("$$$$$$"+sql);

if(ins>=1){
	
	sql = "Update db_gps.t_completedjourney set DIStatus = 'Pending'  where startdate <= '"+date+"'  and enddate >= '"+date+"'  and vehid = '"+vehid+"' ";
	st.executeUpdate(sql);
	 
	
	buffer="Updates"+"-"+otherreason;
		System.out.println("Updates : "+sql);
		out.print(buffer);

		
		//buffer=null;
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
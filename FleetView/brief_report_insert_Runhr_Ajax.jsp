
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
	String sqloth="insert into db_gps.t_violationclose(Reason,category,Owner,GPName,EntryBy)values('"+otherreason.replaceAll("'"," ")+"','RunDurton','"+usertypevalue+"','Castrol','"+userid+"')";
     st1.executeUpdate(sqloth);
	
    System.out.println("insert for other query"+sqloth);
    }}
else
{
	otherreason=comment;
}





//date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(date));



String buffer;



sql="update db_gpsExceptions.t_vehall_ds set ClosingComment='"+otherreason+"', violationstatus='Close',Closedatetime='"+sysdate22+"',ClosedBy='"+userid+"' where vehcode='"+vehid+"' and RDuration > '10:00:00' and thedate='"+date+"'";
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/
ins=st.executeUpdate(sql);
if(ins>=1){
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
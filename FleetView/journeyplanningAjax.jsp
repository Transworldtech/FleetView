<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection con1=null;
%>

<%
try {
//Class.forName(MM_dbConn_DRIVER);
con1 = fleetview.ReturnConnection();
Statement stmt1=con1.createStatement();
Statement st1=con1.createStatement();
Statement st2=con1.createStatement();
Statement st3=con1.createStatement();
Statement st4=con1.createStatement();
Statement st8=con1.createStatement();
ResultSet rs1=null;
String sql1="";

String sql2="";
String sql3="";
String tripid=request.getParameter("tripid");
String briefid=request.getParameter("briefid");
String driverid=request.getParameter("driverid");
String Day=request.getParameter("Day");
String loc=request.getParameter("loc");
String StopReason=request.getParameter("StopReason");
String VehRegNo=request.getParameter("VehRegNo");
String dateF=request.getParameter("dateF");
String dateT=request.getParameter("dateT");
SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String EntryBy=session.getAttribute("mainuser").toString();
System.out.print("EntryBy"+EntryBy);

System.out.println("tripid:"+tripid+" briefid"+briefid+" driverid"+driverid+" Day"+Day+" loc"+loc+" StopReason"+StopReason+" VehRegNo"+VehRegNo);
System.out.println("date1:"+dateF);

String startDt=df1.format(df.parse(dateF));
String stopDt=df1.format(df.parse(dateT));
String Duration ="";


sql1 = "select TIME_TO_SEC(TIMEDIFF('"+stopDt+"','"+startDt+"')) as HHmm";
System.out.println("zzzz  : "+sql1);
long timeinsec=0;
ResultSet rs = st1.executeQuery(sql1);
if(rs.next())
{
	timeinsec= rs.getLong("HHmm");
	
	long hours=(timeinsec/60)/60;
	long minutes=(timeinsec/60)%60;
	long Seconds=(timeinsec)%60;	
	if(hours>9)
	{	 Duration = ""+hours; 	}
	else
	{	Duration = "0"+hours; 	}						
	if(minutes > 9 )
	{		Duration = Duration+":"+minutes;		}
	else
	{	Duration = Duration+":0"+minutes;	}
	
	if(Seconds > 9 )
	{		Duration = Duration+":"+Seconds;		}
	else
	{	Duration = Duration+":0"+Seconds;	}
	
}
	else
	{
	Duration="00:00:00";	
	}
	
	

int sec =0,sec1 = 0,diffsec = 0;
String flag ="0";
sql1 = "select TIME_TO_SEC('"+Duration+"') as sec";
System.out.print(sql1);
ResultSet rsRR = st2.executeQuery(sql1);
if(rsRR.next())
{
	sec = rsRR.getInt("sec");
}

int min = sec/60;
if(min < 15)
{
	flag = "1";
}

if(flag.equals("1"))
{
	out.print("1");
}
else{

String routeID=""; 
String unitid="";

String str1="Route Name";
String routeName="";



String	mailid="select * from db_gps.t_jrnyplanning where brifid='"+briefid+"' and driverid='"+driverid+"' and Tripid='"+tripid+"' AND ((Start<='"+startDt+"'and End>='"+startDt+"')or(Start<='"+stopDt+"' and End>='"+stopDt+"'))";
System.out.println("Mail id :"+mailid);
   ResultSet rsmailid=st8.executeQuery(mailid);
    if(rsmailid.next())
	         {
    	System.out.print("Already"); 
    	out.print("Already");
	         }else
	         {



String sql21="insert into db_gps.t_jrnyplanning(Tripid,Day,Start,End,StopDuration,Destination,Entryby,brifid,driverid,StopReason)"+
			 "values('"+tripid+"','"+Day+"','"+startDt+"','"+stopDt+"','"+Duration+"','"+loc+"','"+EntryBy+"','"+briefid+"','"+driverid+"','"+StopReason+"')";
System.out.println(sql21);
st1.executeUpdate(sql21);


// 	System.out.println("route name=====>"+routeName);
// 	String Rname=routeName;
// 	StringBuffer str=new StringBuffer("");
// 	str.append("<table border='1' width='100%' class='sortable' style='width:100%;' align='left'><tr><th>Day</th><th>Date time</th><th>Stop Reason</th> <th>Location</th><th>Entry By</th></tr>");
// 	String SqlRoute="select * from t_jrnyplanning where Tripid='"+tripid+"' and brifid='"+briefid+"' and driverid='"+driverid+"' order by Start,UpdatedDateTime ";
// 	System.out.println("route name=====>"+SqlRoute);
// 	ResultSet rsRoute=st3.executeQuery(SqlRoute);
// 	while(rsRoute.next())
// 	{
// 		str.append("<tr><td align='right'><div align='right'>"+rsRoute.getString("Day")+"</div></td>" );
// 		str.append("<td align='right'><div align='right'>"+df.format(df1.parse((rsRoute.getString("End"))))+"</div></td> " );
// 		str.append("<td align='left'><div align='left'>"+rsRoute.getString("StopReason")+"</div></td> " );
// 		str.append("<td align='left'><div align='left'>"+rsRoute.getString("Destination")+"</div></td> " );
// 		str.append("<td align='left'><div align='left'>"+rsRoute.getString("Entryby")+"</div></td></tr> " );
		
		
// 		//str.append("<tr><td align='left'><div align='left'>Green</div></td><td align='right'><div align='right'>"+rsRoute.getString("Entryby")+"</div></td><td align='right'><div align='right'>"+rsRoute.getString("driverid")+"</div></td></tr> " );
// 	}
// 	str.append("</table>");
// 	Rname=Rname+"<br>"+str.toString();
	System.out.print("Added");
	out.print("Added");
	
	         }
	         }

} catch(Exception e) {
	out.println(e);
	}

finally
{
con1.close();
}

%>



</jsp:useBean>


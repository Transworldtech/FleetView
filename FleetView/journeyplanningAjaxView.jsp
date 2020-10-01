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

SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String EntryBy=session.getAttribute("mainuser").toString();
System.out.print("EntryBy"+EntryBy);



String routeID=""; 
String unitid="";

String str1="Route Name";
String routeName="";

	SimpleDateFormat df2 = new SimpleDateFormat("HHH:mm");
	SimpleDateFormat df3 = new SimpleDateFormat("HHH:mm:ss");
String Duration="";

	System.out.println("route name=====>"+routeName);
	String Rname=routeName;
	StringBuffer str=new StringBuffer("");
	int i1=1;
	str.append("<table border='1' width='100%' class='sortable' style='width:100%;' align='left'><tr><th></th><th>SrNo.</th><th>Day</th><th>From DT</th><th>To DT</th><th>Duration</th><th>Stop Reason</th> <th>Location</th><th>Entry By</th></tr>");
	String SqlRoute="select * from t_jrnyplanning where Tripid='"+tripid+"' and brifid='"+briefid+"' and driverid='"+driverid+"' order by Start,UpdatedDateTime ";
	System.out.println("route name=====>"+SqlRoute);
	ResultSet rsRoute=st3.executeQuery(SqlRoute);
	while(rsRoute.next())
	{ 
		str.append("<tr><td><div  align='left'><a href='javascript:deletStop('"+tripid+"','"+briefid+"','"+driverid+"','"+rsRoute.getString("Start")+"','"+rsRoute.getString("End")+"','"+rsRoute.getString("StopReason")+"','"+rsRoute.getString("Entryby")+"');'>Delete</a></div>	</td>");
		str.append("<td align='right'><div align='right'>"+i1+"</div></td>" );
		str.append("<td align='right'><div align='right'>"+rsRoute.getString("Day")+"</div></td>" );
		str.append("<td align='right'><div align='right'>"+df.format(df1.parse((rsRoute.getString("Start"))))+"</div></td> " );
		str.append("<td align='right'><div align='right'>"+df.format(df1.parse((rsRoute.getString("End"))))+"</div></td>");		
		try{
			Duration=rsRoute.getString("StopDuration");
			String dur1[]=Duration.split(":");
			Duration=dur1[0]+":"+dur1[1];				
		
		}catch(Exception e){
				Duration="00:00";
		}
		
		str.append("<td align='right'><div align='right'>"+Duration+"</div></td>");
		str.append("<td align='left'><div align='left'>"+rsRoute.getString("StopReason")+"</div></td> " );
		str.append("<td align='left'><div align='left'>"+rsRoute.getString("Destination")+"</div></td> " );
		str.append("<td align='left'><div align='left'>"+rsRoute.getString("Entryby")+"</div></td></tr> " );
		
		
		//str.append("<tr><td align='left'><div align='left'>Green</div></td><td align='right'><div align='right'>"+rsRoute.getString("Entryby")+"</div></td><td align='right'><div align='right'>"+rsRoute.getString("driverid")+"</div></td></tr> " );
		i1++;
	}
	str.append("</table>");
	Rname=Rname+"<br>"+str.toString();
	System.out.print(Rname);
	out.print(Rname);
	



} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>



</jsp:useBean>


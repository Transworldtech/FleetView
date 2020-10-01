<%@ include file="Connections/conn.jsp" %> 
<%!
Connection conn, conn1,conn00;
String date1,date2,mode,rvehid,hvrno,fff,ttt,mydate1,mydate2;
%>
<%! 
String sql100, sql200;
ResultSet rst100, rst200,rst00;
Statement st00,st100;
%>
<%
String output="";
System.out.println("Himxvcnmdvn   ");
try{
	
	System.out.println("Himxvcnmdvn   ");
	Class.forName(MM_dbConn_DRIVER);
	conn00 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st00=conn00.createStatement();
	st100=conn00.createStatement();
String tripid = session.getAttribute("tripid").toString();
String briefid = session.getAttribute("briefid").toString();
String driverid = session.getAttribute("driverid").toString();
String rid = session.getAttribute("routeid").toString();
String parameter=request.getParameter("para");
fff=session.getAttribute("fff").toString();
ttt=session.getAttribute("ttt").toString();
date1=session.getAttribute("hdate1").toString();
date2=session.getAttribute("hdate2").toString();
System.out.println(fff);
date1 = date1+" "+fff;
date2 = date2+" "+ttt;
System.out.println("Date= "+date1+ "date2= "+date2);
//mode=session.getAttribute("mode").toString();
rvehid=session.getAttribute("hvid").toString();
hvrno=session.getAttribute("hvrno").toString();
String msg = "";
int i = 1,j=0;
if(parameter!=null && parameter.equalsIgnoreCase("Rest"))
{
	sql100 = "select * from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and StopReason = 'Rest'    order by Start ";
	 msg="Planned Stop";
}
else
	if(parameter!=null && parameter.equalsIgnoreCase("NH"))
	{
		sql100 = "select * from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and StopReason = 'Night Halt'  order by Start";
		 msg="Planned Night Halt";
	}
rst00 =  st00.executeQuery(sql100);
java.util.Date spdate=null,stdate=null;
String bgColor="background-color:#FFFFFF";
mydate1= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date1));
mydate2= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date2));
output="<table border='1' width='100%' class='stats'><tr><td class='hed'>"+msg+" Report For "+hvrno+" From "+mydate1+" to "+mydate2+" </td></tr><tr><td><table border='1' width='100%' class='stats'><tr><td><table width='100%' border='1'  class='sortable'><tr>";
output+="<th>Sr.No.</th><th>From Date Time</th><th>To Date Time</th><th>Duration</th><th>Location</th>";
while(rst00.next())
{
	spdate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(rst00.getString("End"));
	double lat1 = 0,lon1 = 0;
	 sql200 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rst00.getString("Destination")+"'  and advancedrouteid = '"+rid+"'";
	    //System.out.println("sql  ****************************************  "+sql1);
	     rst200 = st100.executeQuery(sql200);
		   if(rst200.next())
		   {
			   lat1 = rst200.getDouble("latitude");
			   lon1 = rst200.getDouble("longitude");
		   }
	
	sql200 = "select AddTime('"+rst00.getString("End")+"','"+rst00.getString("StopDuration")+"') as enddate";
	    //System.out.println("sql  ****************************************  "+sql1);
	     rst200 = st100.executeQuery(sql200);
		   if(rst200.next())
		   {
			   stdate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(rst200.getString("enddate"));
		   }
		  
	String spdate1=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(spdate);
	String stdate1=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(stdate);
	output+="<tr>"+
	"<td style='"+bgColor+"; text-align: right'>"+i+"</td>"+
	"<td style='"+bgColor+"; text-align: right'>"+spdate1+"</td>"+
	"<td style='"+bgColor+"; text-align: right'>"+stdate1+"</td>"+
	"<td style='"+bgColor+"; text-align: right'>"+new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst00.getString("StopDuration")))+"</td>"+
	"<td class='bodyText' style='"+bgColor+"; text-align: left'><div align='left'><a href='javascript:zoomtoloc("+j+","+lat1+","+lon1+")'>"+rst00.getString("Destination")+"</a></div></td>"+
	"</tr>";
	i++;
	j++;
}

}catch(Exception e)
{
	out.print("Exception-- "+e);
	e.printStackTrace();
}

finally
{
	
try
{
	st00.close();
	st100.close();
	conn00.close();
}
catch(Exception e){
	e.printStackTrace();
}
}

out.print(output+"$");

%>
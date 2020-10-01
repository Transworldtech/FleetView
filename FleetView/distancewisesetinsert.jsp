<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {
	String owner=session.getAttribute("usertypevalue").toString();
	//out.println("here"+owner);
	String user=session.getAttribute("mainuser").toString();
	//out.println("here"+user);
	//String routeid=request.getParameter("routid");
	String routeid=session.getAttribute("routeid").toString();
	//out.println("here"+routeid);
	String distance=request.getParameter("distance");
	//out.println("here"+Day);
	
	String Totaldistance=request.getParameter("Kmval");
	double Totaldistancem=Double.parseDouble(Totaldistance);
	//System.out.println("fulmaster**Totaldistance***Totaldistancem********************************************"+Totaldistancem);
	//System.out.println("fulmaster**Totaldistance***********************************************"+Totaldistance);
	//double que=Double.parseDouble(Quantity);
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String insertdate = fmt.format(new java.util.Date());
		//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",body="",prevoiusdistance="0";
boolean flag=false;
String sql3="";
String Rname="";
//out.println("here");
//int distancem=Integer.parseInt(distance);
double distancem=Double.parseDouble(distance);
//System.out.println("fulmaster*************************************************:-"+distancem);
//System.out.println("Totaldistancemnopqr*************************************************:-"+distancem);
//int Totaldistancem=to t;
//System.out.println("Totaldistancem*************************************************:-"+Totaldistancem);

if(Totaldistancem<distancem){
	out.println("1");
	//out.println("<font size='2' color='red'>Distance should not greater than Total distance</font>");
	
}else{
	
try{
	 String dis="select distance from db_gps.t_dtwisefuelplan where owner=? and routeid=? order by distance asc"; 
    PreparedStatement ps=con1.prepareStatement(dis);
	ps.setString(1, owner);
	ps.setString(2, routeid);
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		prevoiusdistance=rs.getString("distance");
	} 
	

//int prevoiusdistancem=Integer.parseInt(prevoiusdistance);
double prevoiusdistancem=Double.parseDouble(prevoiusdistance);
if(distancem<prevoiusdistancem)
{
	//out.println("<font size='2' color='red'>Distance should not greater than previous distance</font>");
	out.println("2");
}else{
		
String insrtmaster="insert into db_gps.t_dtwisefuelplan(routeid,distance,entby,insertdate,owner) values(?,?,?,?,?) ";
//out.println("fulmaster*************************************************:-"+insrtmaster);
PreparedStatement ps1=con1.prepareStatement(insrtmaster);
//out.println("fulmaster*************************************************:-"+insrtmaster);
ps1.setString(1, routeid);
ps1.setString(2, distance);
ps1.setString(3, user);
ps1.setString(4, insertdate);
ps1.setString(5, owner);

ps1.executeUpdate();

/* String concatdist="";
String Sqlday1="select * from db_gps.t_dtwisefuelplan where owner=? order by ID";
System.out.println("route name=====>"+Sqlday1);
PreparedStatement ps5=con1.prepareStatement(Sqlday1);
ps5.setString(1, owner);
ResultSet rsd5=ps5.executeQuery();
//int countrow=rsd.getRow();
if(rsd5.next()){
 concatdist=prevoiusdistance+"-"+rsd5.getString("distance");
 System.out.println("fulmaster*************************************************:-"+concatdist);
} */
String concatdist="";
concatdist=prevoiusdistance+"-"+distance;
String distmaster="update db_gps.t_dtwisefuelplan set distrange=? where routeid=? and distance=? and owner=? ";
System.out.println("fulmaster*************************************************:-"+distmaster);
PreparedStatement ps4=con1.prepareStatement(distmaster);
System.out.println("fulmaster*************************************************:-"+distmaster);
ps4.setString(1, concatdist);
ps4.setString(2, routeid);
ps4.setString(3, distance);
ps4.setString(4, owner);

ps4.executeUpdate();

 //response.sendRedirect("RoutePlan.jsp");
 StringBuffer str=new StringBuffer("");
 str.append("<table class='sortable' border='1' style='width:25%;' ><tr><th><b>Sr.No</b></th><th><b>Distance</b></th><th><b>Delete</b></th></tr>");
    int i=1,Balance=0;
    String distrange="";
	String Sqlday="select * from db_gps.t_dtwisefuelplan where owner=? and routeid=? order by ID";
	System.out.println("route name=====>"+Sqlday);
	PreparedStatement ps2=con1.prepareStatement(Sqlday);
	ps2.setString(1, owner);
	ps2.setString(2, routeid);
	ResultSet rsd=ps2.executeQuery();
	//int countrow=rsd.getRow();
    

	while(rsd.next())
	{ 
		//str.append("<tr><td><div  align='left'><a href='javascript:deletStop('"+tripid+"','"+briefid+"','"+driverid+"','"+i+"','"+rsd.getString("geofencename")+"','"+rsd.getString("Km")+"','"+Balance+"');'>Delete</a></div>	</td>");
		distrange=rsd.getString("distrange");
		//out.print("mystring*************************"+str);
		str.append("<tr>");
		str.append("<td align='right'><div align='right'>"+i+"</div></td>"); 
		str.append("<td align='right'><div align='right'>"+distrange+"</div></td>");
		/* str.append("<td align='right'><div align='right'>"+rsd.getInt("quantity")+"</div></td> " ); */
		//str.append("<td align='right'><div align='right'>"+Balance+"</div></td>");
		str.append("<td><div  align='center'><a href='' onClick='return deletdistance('"+rsd.getString("routeid")+"','"+rsd.getString("distance")+"','"+rsd.getString("ID")+"');'>Delete</a></div></td></tr>");
		
		i++;
	}
	str.append("</table>");
	Rname=Rname+str.toString();
	System.out.print(Rname);
	prevoiusdistance="";
	distrange="";
	distance="";
	prevoiusdistance="";
	out.print(Rname);
 //out.print("1");
//System.out.println("fulmaster**************************************************************************************:-");
 //return;

}//else of < than conditions



}catch(Exception e)
{e.printStackTrace();}

}//else of total distance graeter than current


} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		//st.close();
		//st1.close();
		con1.close();
	}

%>
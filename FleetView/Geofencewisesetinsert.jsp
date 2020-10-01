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
	String geofencename=request.getParameter("element_3_1");
	//String geofenceid=request.getParameter("element_3_9");
	String geofence[]=geofencename.split("----");
	//out.println("here"+geofencename);
	
	String km=request.getParameter("element_3_2");
	//out.println("here"+km);
	
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String insertdate = fmt.format(new java.util.Date());
		//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",body="",WareHouseCode="";
boolean flag=false;
String sql3="";
String Rname="";
//out.println("here");
try{
	String loc="select WareHouseCode from db_gps.t_warehousedata where WareHouse=? and Status=? "; 
    PreparedStatement ps=con1.prepareStatement(loc);
	ps.setString(1, geofencename);
	ps.setString(2, "Active");
	ResultSet rs=ps.executeQuery();
	if(rs.next()){
		WareHouseCode=rs.getString("WareHouseCode");
	}
	//out.println("here"+WareHouseCode);
String insrtmaster="insert into db_gps.t_geofencefuelplan(routeid,geofenceid,geofencename,Km,entryby,insertdate,owner) values(?,?,?,?,?,?,?) ";
//out.println("fulmaster*************************************************:-"+insrtmaster);
PreparedStatement ps1=con1.prepareStatement(insrtmaster);
//out.println("fulmaster*************************************************:-"+insrtmaster);
ps1.setString(1, routeid);
ps1.setString(2, geofence[1]);
ps1.setString(3, geofence[0]);
ps1.setString(4, km);
ps1.setString(5, user);
ps1.setString(6, insertdate);
ps1.setString(7, owner);

ps1.executeUpdate();

 //response.sendRedirect("RoutePlan.jsp");
 StringBuffer str=new StringBuffer("");
 str.append("<table class='sortable' border='1' style='width:35%;' ><tr><th><b>Sr No.</b></th><th><b>GeofenceName</b></th><th><b>Km</b></th><th><b>Delete</b></th></tr>");
    int i=1,Balance=0;
	String SqlRoute="select * from db_gps.t_geofencefuelplan where owner=? and routeid=? order by rid";
	System.out.println("route name=====>"+SqlRoute);
	PreparedStatement ps2=con1.prepareStatement(SqlRoute);
	ps2.setString(1, owner);
	ps2.setString(2, routeid);
	ResultSet rsd=ps2.executeQuery();
	while(rsd.next())
	{ 
		//str.append("<tr><td><div  align='left'><a href='javascript:deletStop('"+tripid+"','"+briefid+"','"+driverid+"','"+i+"','"+rsd.getString("geofencename")+"','"+rsd.getString("Km")+"','"+Balance+"');'>Delete</a></div>	</td>");
		
		//out.print("mystring*************************"+str);
		str.append("<tr>");
		str.append("<td align='right'><div align='right'>"+i+"</div></td>");
		str.append("<td align='right'><div align='left'>"+rsd.getString("geofencename")+"</div></td>");
		str.append("<td align='right'><div align='right'>"+rsd.getInt("Km")+"</div></td>");
		/* str.append("<td align='right'><div align='right'>"+Balance+"</div></td>"); */		
		str.append("<td><div  align='center'><a href='' onClick='return deletStop('"+rsd.getString("routeid")+"','"+rsd.getString("geofenceid")+"','"+rsd.getString("geofencename")+"','"+rsd.getInt("Km")+"','"+Balance+"');'>Delete</a></div></td></tr>");
		
		i++;
	}
	str.append("</table>");
	Rname=Rname+str.toString();
	System.out.print(Rname);
	out.print(Rname);
 //out.print("1");
//System.out.println("fulmaster**************************************************************************************:-");
 //return;

}catch(Exception e)
{e.printStackTrace();}

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
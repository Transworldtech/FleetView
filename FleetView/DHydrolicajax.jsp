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
Statement st,st1,st2,st3,st4,st5,st11,st13;
ResultSet rst1=null;
int cnt=0,cnt1=0;


%>

<% 
try {
    String expence=request.getParameter("field");


    Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String insertdate = fmt.format(new java.util.Date());


String user=session.getAttribute("mainuser").toString();
String transporter=session.getAttribute("usertypevalue").toString();
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st3=con1.createStatement();
st11=con1.createStatement();
st13=con1.createStatement();
ResultSet rst=null,rst2=null;
String sql="",body="",WareHouseCode="";
boolean flag=false;
String sql3="";
String Rname="";

try{
	
// 	String vvv=expence;
// 	String strstr=vvv.replace(" "," ");
// 	System.out.println("STRSTR:-"+strstr);
	
String abc="select field from db_gps.t_hydrolicsystemforcustomfieldmaster where field='"+expence+"' and Owner='"+transporter+"'";
rst2=st3.executeQuery(abc);


if(rst2.next( ))
{
	out.println("Field Record Already Exist");
	//out.println("<script type='text/javascript'>alert('Record Already Exist');");
}
else{
  String insrtmaster="insert into db_gps.t_hydrolicsystemforcustomfieldmaster(Entryby,Owner,field) values('"+user+"','"+transporter+"','"+expence+"') ";
  cnt=st1.executeUpdate(insrtmaster);

 StringBuffer str=new StringBuffer("");
 str.append("<table class='sortable' border='1' style='width:50%; ><tr><th><b>Field</b></th></tr>");
       int i=1,Balance=0;
       String dayy="",rid="";
	String Sqlday="select * from db_gps.t_custpto";
	 rst1 = st.executeQuery(Sqlday);
	 System.out.println("xyzxyzxyzxyzxyz111111"+Sqlday);
	 while(rst1.next())
	{ 
		str.append("<tr>");
		str.append("<td align='right'><div align='right'>"+i+"</div></td>" );
		str.append("<td align='right'><div align='right'>"+expence+"</div></td>" );
	    i++;
	}
	str.append("</table>");
	Rname=Rname+str.toString();
	System.out.print(Rname);
	dayy="";
	System.out.print(Rname);

  	String alter=" ALTER TABLE /*IF NOT EXISTS*/  db_gps.t_hydrolicsystemforcustomfielddata add column  "+expence+" varchar(200) NOT NULL DEFAULT '-' ";
     st1.executeUpdate(alter);
     System.out.println("Alter--------"+alter);

     
     String alter1=" ALTER TABLE /*IF NOT EXISTS*/  db_gps.t_hydrolicsystemforcustomfieldhistory add column  "+expence+" varchar(200) NOT NULL DEFAULT '-' ";
     st13.executeUpdate(alter1);
     System.out.println("Alter--------"+alter1);

}
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
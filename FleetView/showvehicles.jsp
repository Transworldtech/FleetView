 <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1,st2,st3,st4,st5;
ResultSet rst;
String sql;

%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	st5=conn.createStatement();
String vehiclelist = "";
String uname = request.getParameter("uname");
String HODID = "";
String vehid = "";
String topage = request.getParameter("page");
sql = "select * from db_gps.t_userdetails where concat(FirstName,' ',LastName) = '"+uname+"' ";
rst = st.executeQuery(sql);
System.out.println("**   "+sql);
if(rst.next())
{
	HODID = rst.getString("SrNo");
	
	 if(uname == "Sanjay Jetly" || uname.equals("Sanjay Jetly") || uname == "Maria Thomas" || uname.equals("Maria Thomas"))
     {
   	  HODID = "4117";
     }
	 
	System.out.println("HODID   "+HODID);
	if(rst.getString("vehid") == "-" || rst.getString("vehid").equals("-"))
	{
		String sql1 = "select * from db_gps.t_userdetails where HODID = '"+HODID+"'";
		
		ResultSet rs = st1.executeQuery(sql1);
		System.out.println("****    "+sql1);
		while(rs.next())
			{
			System.out.println("***** "+HODID);
			    if(rs.getString("vehid") == "-" || rs.getString("vehid").equals("-"))
			    {
			    	String sql2 = "select * from db_gps.t_userdetails where HODID = '"+rs.getString("SrNo")+"'";
			    	ResultSet rs1 = st2.executeQuery(sql2);
			    	System.out.println("****    "+sql2);
			    	while(rs1.next())
			    	{
			    		System.out.println("***** "+rs.getString("SrNo"));
			    		if(rs1.getString("vehid") == "-" || rs1.getString("vehid").equals("-"))
			    		{
			    			String sql3 = "select * from db_gps.t_userdetails where HODID = '"+rs1.getString("SrNo")+"'";
			    	    	ResultSet rs2 = st3.executeQuery(sql3);
			    	    	System.out.println("****    "+sql3);
			    	    	while(rs2.next())
			    	    	{
			    	    		System.out.println("***** "+rs1.getString("SrNo"));
			    	    		if(rs2.getString("vehid") == "-" || rs2.getString("vehid").equals("-"))
			    	    		{
			    	    			String sql4 = "select * from db_gps.t_userdetails where HODID = '"+rs2.getString("SrNo")+"'";
			    	    	    	ResultSet rs3 = st4.executeQuery(sql4);
			    	    	    	System.out.println("****    "+sql4);
			    	    	    	while(rs3.next())
			    	    	    	{
			    	    	    		System.out.println("***** "+rs2.getString("SrNo"));
			    	    	    		if(rs3.getString("vehid") == "-" || rs3.getString("vehid").equals("-"))
			    	    	    		{
			    	    	    		
			    	    	    		}
			    	    	    		else
			    	    	    		{
			    	    	    			vehid =vehid+","+ rs3.getString("vehid");
			    	    	    		}
			    	    	    	}
			    	    		}
			    	    		else
			    	    		{
			    	    			vehid =vehid+","+ rs2.getString("vehid");
			    	    		}
			    	    	}
			    		}
			    		else
			    		{
			    			vehid =vehid+","+ rs1.getString("vehid");
			    		}
			    	}
			    }
			    else
			    {
			    	vehid =vehid+","+ rs.getString("vehid");
			    }
			}
	}
	else
	{
		
		vehid =vehid+","+ rst.getString("vehid");
		System.out.println("****    vehid   "+vehid);
	}
}
System.out.println("*****");

if(vehid == "" || vehid.equals(""))
{
	
}
else
{
int len = vehid.length();
vehid = vehid.substring(1,len);
System.out.println("***   "+vehid);
}
String usrname = uname.replace(" ","");
System.out.println("***   "+usrname+"          "+uname);
session.setAttribute("vlist"+usrname,vehid);
System.out.println("***   "+usrname+"          "+uname);

response.sendRedirect("usercentricreport.jsp?uname="+uname);



}catch(Exception e)
{
	System.out.print("Exception --->"+ e);
	e.printStackTrace();
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e)
	{}
	
}
%>

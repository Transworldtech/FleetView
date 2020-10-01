<%@page import="java.sql.*" import="java.util.*" import=" java.text.*"%>
	
<%!

	Connection con=null;
	Statement stmt=null;
	ResultSet rs;
%>
<%
try 
{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	con=DriverManager.getConnection("jdbc:mysql://localhost/TestDemo","fleetview","1@flv");

	String make="",btrmake="",switchp1="",srtstp1="";
	int siteid=0,gensetid=0,capacity=0,relevel=0,oillevel=0,temprange=0;
	float batvolt;

	String user=session.getValue("usertypevalue").toString();

	out.println(request.getParameter("calender1"));
	String nwfrmtdte=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("calender1")));//format(new java.util.Date());
	out.println("--------"+nwfrmtdte);

	java.util.Date d=new java.util.Date();
	String dd=request.getParameter("calender1");
	
	String s1=request.getParameter("siteid");
	siteid=Integer.parseInt(s1);
	
	String s2=request.getParameter("gensetid");
	gensetid=Integer.parseInt(s2);
	
	String s3=request.getParameter("capacity");
	capacity=Integer.parseInt(s3);
	
	String s4=request.getParameter("relevel");
	relevel=Integer.parseInt(s4);
	
	String s5=request.getParameter("oillevel");
	oillevel=Integer.parseInt(s5);
	
	String s6=request.getParameter("temprange");
	temprange=Integer.parseInt(s6);
	
	make=request.getParameter("make"); 
	
	switchp1=request.getParameter("switchp");
	
	srtstp1=request.getParameter("srtstp");
	
	String s7=request.getParameter("batvolt");
	batvolt=Float.parseFloat(s7);
	
	btrmake=request.getParameter("btrmake");
	
	try{
	String sql1="insert into TestDemo.NewGensetEntry values("+siteid+","+gensetid+",'"+make+"',"+capacity+","+relevel+","+batvolt+","+temprange+",'"+btrmake+"','"+nwfrmtdte+"','"+switchp1+"','"+srtstp1+"',"+oillevel+")";
	stmt=con.createStatement();
	int i=0;
	i=stmt.executeUpdate(sql1);
	out.println("rec inserted");
	response.sendRedirect("airtelcurrentposition.jsp");
	}
	catch(Exception ee){}
}
catch(Exception e)
{
	out.println("Exception:"+e);
}
finally
{
	try{
		con.close();
	}catch(Exception e)
	{}
}
%>

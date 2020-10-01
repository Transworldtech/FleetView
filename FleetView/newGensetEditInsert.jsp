
<%@page import="java.sql.*" import="java.util.*" import=" java.text.*"%>
<%
//classes fleetview=new classes();
%>	
	<%
/*fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Connection con1;
	String flg="N";*/
	Connection con;
	Statement stmt;
	ResultSet rs;

try 
{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	con=DriverManager.getConnection("jdbc:mysql://localhost/TestDemo","fleetview","1@flv");
	/*	Statement stmt1=con1.createStatement();
	ResultSet rs2=null, rs3=null, rs4=null, rs5=null,rs33=null;
	String sql2="", sql3="", sql4="", sql5="",sql33="";
	String vehno="", prvdid="",lastdriverid="", lastdrivername="";*/
	String make="",btrmake="",switchp1="",srtstp1="";
	int siteid=0,gensetid=0,capacity=0,relevel=0,oillevel=0,temprange=0;
	float batvolt;
	String flg="N";
	//Date calender1;
	//vehno=request.getParameter("vehno");
	String user=session.getValue("usertypevalue").toString();
/*	java.util.Date d=new java.util.Date();*/
	out.println(request.getParameter("calender1"));
	String nwfrmtdte=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("calender1")));//format(new java.util.Date());
	out.println("--------"+nwfrmtdte);
	/*SimpleDateFormat formatter = new SimpleDateFormat("dd/MMM/yyyy");
	java.util.Date d=new java.util.Date();
	String dd=request.getParameter("calender1");
	out.println("----Date------"+dd);*/
	/*java.util.Date myDate = new SimpleDateFormat("yyyy-MM-dd").parse(nwfrmtdte); //formatter.parse(dd);
	out.println("-----mydate---"+myDate);
	String dd=request.getParameter("calender1");
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	java.util.Date today = df.parse(dd);*/ 
	//out.println("----Date------"+df.format(today));
	
	String s1=request.getParameter("siteid");
	siteid=Integer.parseInt(s1);
	
	String s2=request.getParameter("genset_id");
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
	out.println("Switch="+switchp1);
	
	srtstp1=request.getParameter("srtstp");
	out.println("Start/stop="+srtstp1);
	
	String s7=request.getParameter("batvolt");
	batvolt=Float.parseFloat(s7);
	
	btrmake=request.getParameter("btrmake");
	
	out.println("site="+siteid+"genset"+gensetid+"make"+make+"capacity"+capacity+"relevel"+relevel+"batvolt"+batvolt+"temprange"+temprange+"btrmake"+btrmake+"nwfrmtdte"+nwfrmtdte+"switchp"+switchp1+"srtstp"+srtstp1+"oillevel"+oillevel);
	try{
	//String sql1="insert into TestDemo.NewGensetEntry values("+siteid+","+gensetid+",'"+make+"',"+capacity+","+relevel+","+batvolt+","+temprange+",'"+btrmake+"','"+nwfrmtdte+"','"+switchp1+"','"+srtstp1+"',"+oillevel+")";
	String sql2="update TestDemo.NewGensetEntry set siteid="+siteid+",make='"+make+"', capacity="+capacity+", refuel_level="+relevel+", bat_voltage="+batvolt+", trange="+temprange+", bmake='"+btrmake+"', m_date='"+nwfrmtdte+"', t_position='"+switchp1+"', r_start='"+srtstp1+"', oil_level="+oillevel+" where gensetid="+gensetid+"";
	stmt=con.createStatement();
	stmt.executeUpdate(sql2);
	response.sendRedirect("airtelcurrentposition.jsp");
	
	}
	catch(Exception e)
	{
		System.out.println("Update:"+e);
	}
/*	out.println("Site ID="+siteid);
	out.println("GenSet ID="+gensetid);
	 <jsp:forward page="abc.jsp" /> 
*/
	
		
	
}
catch(Exception e)
{
	out.println("Exception:"+e);
}
//response.sendRedirect("GensetMasterEntry.jsp");
//return;

%>
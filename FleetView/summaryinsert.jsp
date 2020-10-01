<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	
	String Name = "",location = "",auditby = "",Reviewby = "",auditdate = "",Transporter = "";
	double bonus = 0,total = 0;
	int quarter = 0,year = 0;
	
	Name = request.getParameter("p1");
	Name = Name.replaceAll("'","");
	Name = Name.replaceAll("\"","");
	location =request.getParameter("p2");
	location = location.replaceAll("'","");
	location = location.replaceAll("\"","");
	auditby = request.getParameter("p4");
	auditby = auditby.replaceAll("'","");
	auditby = auditby.replaceAll("\"","");
	Reviewby = request.getParameter("p5");
	Reviewby = Reviewby.replaceAll("'","");
	Reviewby = Reviewby.replaceAll("\"","");
	auditdate = request.getParameter("p3");
	bonus = Double.parseDouble(request.getParameter("p6"));
	total = Double.parseDouble(request.getParameter("p7"));
	quarter = Integer.parseInt(request.getParameter("Q1"));
	year = Integer.parseInt(request.getParameter("Y1"));
	Transporter = request.getParameter("T1");
	String num = request.getParameter("num");
	
	
	
	String sql = "select * from db_gps.t_auditsummary where Transporter = '"+Transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		String sql1 = "update db_gps.t_auditsummary set Name='"+Name+"',Location='"+location+"',AuditBy='"+auditby+"',Reviewby='"+Reviewby+
							   "',AuditDate='"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(auditdate))+
							   "',Bonus='"+bonus+"',Auditscore='"+total+"' where  Transporter = '"+Transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' " ;
		st1.executeUpdate(sql1);
	}
	else
	{
		String sql1 = "insert into db_gps.t_auditsummary (Name,Location,AuditBy,Reviewby,AuditDate,Bonus,Auditscore,Transporter,Quarter,AuditYear) "+
							   " values ('"+Name+"','"+location+"','"+auditby+"','"+Reviewby+"','"+new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(auditdate))+
							   "','"+bonus+"','"+total+"','"+Transporter+"','"+quarter+"','"+year+"')";
		st1.executeUpdate(sql1);
	}
	
	System.out.println("successful");
	if(num == null)
	{
		out.print("Successful");
	}
	else
	{
		out.print(num);
	}
}
catch(Exception e)
{
	e.printStackTrace();
	con1.close();
}

%>
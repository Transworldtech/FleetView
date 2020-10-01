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
	
	String Transporter = "";
	int quarter = 0,year = 0;
	quarter = Integer.parseInt(request.getParameter("Q"));
	year = Integer.parseInt(request.getParameter("Y"));
	String type = request.getParameter("t");
	Transporter = session.getAttribute("usertypevalue").toString();
	String feed =  request.getParameter("f");
	feed = feed.replaceAll("'","");
	feed = feed.replaceAll("\"","");
	String sql1 = "";
	String sql = "select * from db_gps.t_auditsummary where Transporter = '"+Transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"'";
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		if(type.equalsIgnoreCase("c"))
		{
			sql1 = "update db_gps.t_auditsummary set Comment='"+feed+"' where  Transporter = '"+Transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' " ;
		}
		else
			if(type.equalsIgnoreCase("f"))
			{
				 sql1 = "update db_gps.t_auditsummary set FeedBack='"+feed+"' where  Transporter = '"+Transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' " ;
			}
			else
				{
				sql1 = "update db_gps.t_auditsummary set Suggestion='"+feed+"' where  Transporter = '"+Transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' " ;
				}
		System.out.println("bvcxgs  "+sql1);
		st1.executeUpdate(sql1);
	}
	else
	{
		if(type.equalsIgnoreCase("c"))
		{
			sql1 = "insert into db_gps.t_auditsummary (Comment,Transporter,Quarter,AuditYear)  values ('"+feed+"','"+Transporter+"','"+quarter+"','"+year+"')";
		}
		else
			if(type.equalsIgnoreCase("f"))
			{
				sql1 = "insert into db_gps.t_auditsummary (FeedBack,Transporter,Quarter,AuditYear)  values ('"+feed+"','"+Transporter+"','"+quarter+"','"+year+"')";
			}
			else
			{
				 sql1 = "insert into db_gps.t_auditsummary (Suggestion,Transporter,Quarter,AuditYear)  values ('"+feed+"','"+Transporter+"','"+quarter+"','"+year+"')";
			}
		st1.executeUpdate(sql1);
	}
	
	
		System.out.println("successful");
	out.print("Successful");
}
catch(Exception e)
{
	e.printStackTrace();
	con1.close();
}

%>
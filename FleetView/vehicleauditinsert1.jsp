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
	String vehicles = request.getParameter("v1");

	System.out.println("vehicle   "+vehicles);
	String trips = request.getParameter("v2");
	String FTPTrips = request.getParameter("v3");
	String VFTPRate = request.getParameter("v4");
	String VFTPRR = request.getParameter("v5");
	String UFTPRR = request.getParameter("v6");
	String VFTPRateScore = request.getParameter("v7");
	String VFTPRRScore = request.getParameter("v8");
	String UFTPRRScore = request.getParameter("v9");
	String SectionScore = request.getParameter("v10");
	String YearDue1 = request.getParameter("v11");
	String QuarterDue1 = request.getParameter("v12");
	String QuarterCompleted1 = request.getParameter("v13");
	String Overdue1 = request.getParameter("v14");
	String YearCompleted1 = request.getParameter("v15");
	String YearDue2 = request.getParameter("v16");
	String QuarterDue2 = request.getParameter("v17");
	String QuarterCompleted2 = request.getParameter("v18");
	String Overdue2 = request.getParameter("v19");
	String YearCompleted2 = request.getParameter("v20");
	String YearDue3 = request.getParameter("v21");
	String QuarterDue3 = request.getParameter("v22");
	String QuarterCompleted3 = request.getParameter("v23");
	String Overdue3 = request.getParameter("v24");
	String YearCompleted3 = request.getParameter("v25");
	String YearDue4 = request.getParameter("v26");
	String QuarterDue4 = request.getParameter("v27");
	String QuarterCompleted4 = request.getParameter("v28");
	String Overdue4 = request.getParameter("v29");
	String YearCompleted4 = request.getParameter("v30");
	String YearDue5 = request.getParameter("v31");
	String QuarterDue5 = request.getParameter("v32");
	String QuarterCompleted5 = request.getParameter("v33");
	String Overdue5 = request.getParameter("v34");
	String YearCompleted5 = request.getParameter("v35");
	String YearDue6 = request.getParameter("v36");
	String QuarterDue6 = request.getParameter("v37");
	String QuarterCompleted6 = request.getParameter("v38");
	String Overdue6 = request.getParameter("v39");
	String YearCompleted6 = request.getParameter("v40");
	String YearDue7 = request.getParameter("v41");
	String QuarterDue7 = request.getParameter("v42");
	String QuarterCompleted7 = request.getParameter("v43");
	String Overdue7 = request.getParameter("v44");
	String YearCompleted7 = request.getParameter("v45");
	String YearDue8 = request.getParameter("v46");
	String QuarterDue8 = request.getParameter("v47");
	String QuarterCompleted8 = request.getParameter("v48");
	String Overdue8 = request.getParameter("v49");
	String YearCompleted8 = request.getParameter("v50");
	String CompletedScore = request.getParameter("v51");
	System.out.println("CompletedScore "+CompletedScore);
	String quarter = request.getParameter("Q1");
	String audityear = request.getParameter("Y1");
	String transporter = request.getParameter("T1");
	
	String sql = "select * from db_gps.t_vehicleaudit where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"' ";
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		String sql1 = "update db_gps.t_vehicleaudit set Vehciles = '"+vehicles+"',Trips='"+trips+"',FTPTrips='"+FTPTrips+"',VFTPRate='"+VFTPRate+"',VFTPRR='"+VFTPRR+"',UFTPRR='"+UFTPRR+
							  "',VFTPRateScore='"+VFTPRateScore+"',VFTPRRScore='"+VFTPRRScore+"',UFTPRRScore='"+UFTPRRScore+"',SectionScore='"+SectionScore+"',CompletedScore='"+CompletedScore+
							  "',YearDue1='"+YearDue1+"',QuarterDue1='"+QuarterDue1+"',QuarterCompleted1='"+QuarterCompleted1+"',Overdue1='"+Overdue1+"',YearCompleted1='"+YearCompleted1+
							  "',YearDue2='"+YearDue2+"',QuarterDue2='"+QuarterDue2+"',QuarterCompleted2='"+QuarterCompleted2+"',Overdue2='"+Overdue1+"',YearCompleted2='"+YearCompleted2+
							  "',YearDue3='"+YearDue3+"',QuarterDue3='"+QuarterDue3+"',QuarterCompleted3='"+QuarterCompleted3+"',Overdue3='"+Overdue1+"',YearCompleted3='"+YearCompleted3+
							  "',YearDue4='"+YearDue4+"',QuarterDue4='"+QuarterDue4+"',QuarterCompleted4='"+QuarterCompleted4+"',Overdue4='"+Overdue1+"',YearCompleted4='"+YearCompleted4+
							  "',YearDue5='"+YearDue5+"',QuarterDue5='"+QuarterDue5+"',QuarterCompleted5='"+QuarterCompleted5+"',Overdue5='"+Overdue1+"',YearCompleted5='"+YearCompleted5+
							  "',YearDue6='"+YearDue6+"',QuarterDue6='"+QuarterDue6+"',QuarterCompleted6='"+QuarterCompleted6+"',Overdue6='"+Overdue1+"',YearCompleted6='"+YearCompleted6+
							  "',YearDue7='"+YearDue7+"',QuarterDue7='"+QuarterDue7+"',QuarterCompleted7='"+QuarterCompleted7+"',Overdue7='"+Overdue1+"',YearCompleted7='"+YearCompleted7+
							  "',YearDue8='"+YearDue8+"',QuarterDue8='"+QuarterDue8+"',QuarterCompleted8='"+QuarterCompleted8+"',Overdue8='"+Overdue1+"',YearCompleted8='"+YearCompleted8+
							  "' where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+audityear+"'";
		st1.executeUpdate(sql1);
	}
	else
	{
		String sql1 = "insert into db_gps.t_vehicleaudit (Transporter,Quarter,AuditYear,Vehciles,Trips,FTPTrips,VFTPRate,VFTPRR,UFTPRR,VFTPRateScore,VFTPRRScore,UFTPRRScore,SectionScore,"+
							   "YearDue1,QuarterDue1,QuarterCompleted1,Overdue1,YearCompleted1,YearDue2,QuarterDue2,QuarterCompleted2,Overdue2,YearCompleted2,YearDue3,QuarterDue3,"+
							   "QuarterCompleted3,Overdue3,YearCompleted3,YearDue4,QuarterDue4,QuarterCompleted4,Overdue4,YearCompleted4,YearDue5,QuarterDue5,QuarterCompleted5,Overdue5,YearCompleted5,"+
							   "YearDue6,QuarterDue6,QuarterCompleted6,Overdue6,YearCompleted6,YearDue7,QuarterDue7,QuarterCompleted7,Overdue7,YearCompleted7,YearDue8,QuarterDue8,QuarterCompleted8,"+
							   "Overdue8,YearCompleted8,CompletedScore)  values ('"+transporter+"','"+quarter+"','"+audityear+"','"+vehicles+"','"+trips+"','"+FTPTrips+"','"+VFTPRate+"','"+VFTPRR+"','"+UFTPRR+
							   "','"+VFTPRateScore+"','"+VFTPRRScore+"','"+UFTPRRScore+"','"+SectionScore+"','"+YearDue1+"','"+QuarterDue1+"','"+QuarterCompleted1+"','"+Overdue1+"','"+YearCompleted1+
							   "','"+YearDue2+"','"+QuarterDue2+"','"+QuarterCompleted2+"','"+Overdue2+"','"+YearCompleted2+"','"+YearDue3+"','"+QuarterDue3+"','"+QuarterCompleted3+"','"+Overdue3+"','"+YearCompleted3+
							   "','"+YearDue4+"','"+QuarterDue4+"','"+QuarterCompleted4+"','"+Overdue4+"','"+YearCompleted4+"','"+YearDue5+"','"+QuarterDue5+"','"+QuarterCompleted5+"','"+Overdue5+"','"+YearCompleted5+
							   "','"+YearDue6+"','"+QuarterDue6+"','"+QuarterCompleted6+"','"+Overdue6+"','"+YearCompleted6+"','"+YearDue7+"','"+QuarterDue7+"','"+QuarterCompleted7+"','"+Overdue7+"','"+YearCompleted7+
							   "','"+YearDue8+"','"+QuarterDue8+"','"+QuarterCompleted8+"','"+Overdue8+"','"+YearCompleted8+"','"+CompletedScore+"') ";
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
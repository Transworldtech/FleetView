<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn;
Statement st;

%>
<%
try{
	int i=1;
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
//	System.out.println("IAm in update");
	String dcode =request.getParameter("driverid");
	String DriverName =request.getParameter("DriverName");
//	System.out.println(DriverName);
	String DriverFatherName=request.getParameter("DriverFatherName");
	String DOB =request.getParameter("data");
	String Education =request.getParameter("Education");
	String vendor =request.getParameter("vendor");
	String licenceno =request.getParameter("licenceno");
	String LicenseType =request.getParameter("LicenseType");
	String OldPlace =request.getParameter("LicensePlaceofissue");
	String OldExpiryDate =request.getParameter("data1");
	String PreTest40MM =request.getParameter("PreTest40MM.");
	String PreTestper =request.getParameter("PreTest%");
	String PostTest40MM =request.getParameter("PostTest40MM");
	String PostTestper =request.getParameter("PostTest%");
	String Typeofvehicle =request.getParameter("Typeofvehicle");
	String educationgrade =request.getParameter("Drivingschooleducationgrade");
	String Remark =request.getParameter("Remark");
	String status="updated";
	Calendar cal= Calendar.getInstance();
	String Updated=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
//	System.out.println(Updated);
	String user="IRTE";
//	System.out.println("11111"+user);
	String sql1= "update t_drivertraining set dcode='"+dcode+"',DriverName='"+DriverName+"',DriverFatherName='"+DriverFatherName+"',DOB='"+DOB+"',Education='"+Education+"',vendor='"+vendor+"',licenceno='"+licenceno+"',LicenseType='"+LicenseType+"',Place='"+OldPlace+"',ExpiryDate='"+OldExpiryDate+"',PreTest40MM='"+PreTest40MM+"',PreTestper='"+PreTestper+"',PostTest40MM='"+PostTest40MM+"',PostTestper='"+PostTestper+"',Typeofvehicle='"+Typeofvehicle+"',educationgrade='"+educationgrade+"',Remark='"+Remark+"',status='"+status+"',InsrtDt='"+Updated+"',user='"+user+"' where (DriverName like '"+DriverName+"'or dcode like '"+dcode+"')";
//	System.out.println(sql1);
	st.executeUpdate(sql1);
	String sql= "insert into t_drivertrainingHistory(dcode,DriverName,DriverFatherName,DOB,Education,vendor,licenceno,LicenseType,OldPlace,OldExpiryDate,PreTest40MM,PreTestper,PostTest40MM,PostTestper,Typeofvehicle,educationgrade,Remark,status,Updated,user)values('"+dcode+"','"+DriverName+"','"+DriverFatherName+"','"+DOB+"','"+Education+"','"+vendor+"','"+licenceno+"','"+LicenseType+"','"+OldPlace+"','"+OldExpiryDate+"','"+PreTest40MM+"','"+PreTestper+"','"+PostTest40MM+"','"+PostTestper+"','"+Typeofvehicle+"','"+educationgrade+"','"+Remark+"','"+status+"','"+Updated+"','"+user+"')";
//	System.out.println(sql);
	st.executeUpdate(sql);
	out.println("updated");
//	System.out.println(sql);
	
	%>

<%
}catch(Exception e)
{
	System.out.println(e);
}
finally
{
	conn.close();
}
	response.sendRedirect("../driver_briefing1.jsp");
%>

<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</body>

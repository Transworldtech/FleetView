<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="Connections/conndriver.jsp" %>
<%! 
Connection con ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
final String driverId=request.getParameter("driverid");
final String driverName=request.getParameter("driverName");
final String transpoter=request.getParameter("trans");
//final String commentRejection=request.getParameter("commentRejection");
System.out.println("parameter passed --->"+driverId+driverName+transpoter+"---");
int insert=0;
try{           
	System.out.println("nw in page reason of rejection");	
	Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt=con.createStatement();
		String sql="update t_reasonOfRejectionForDriver SET status='No' WHERE DriverId='"+driverId+"' ORDER BY UpdatedDateTime DESC";
		insert=stmt.executeUpdate(sql);
		if(insert>=1){
			System.out.println("hiii..");
			out.println(driverId+"#"+driverName+"#"+transpoter);
		}
		else{
			out.println("notinserted");
		}
		System.out.println("sql" +sql);
	}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>
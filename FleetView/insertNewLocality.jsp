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

String tripID=request.getParameter("tripid");
String startPlace=request.getParameter("startPlace");
//System.out.println("startPlace===>"+startPlace);
String endPlace=request.getParameter("endPlace");
String startDate=request.getParameter("startDate");
String endDate=request.getParameter("endDate");
String addLoc=request.getParameter("addLoc");
String user=session.getAttribute("user").toString();

int insert=0;
String sql="";
String msg="";

try{           
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();

		sql="insert into t_routewiseLocalityName(startPlace,endPlace,locality,enteredBy) values ('"+startPlace+"','"+endPlace+"','"+addLoc+"','"+user+"')";
		try{
		insert=stmt.executeUpdate(sql);
		}
		catch(Exception e){
			response.sendRedirect("addNewLocality.jsp?ins=alreadyexists&tripid="+tripID+"&startDate="+startDate+"&endDate="+endDate+"&startPlace="+startPlace+"&endPlace="+endPlace+"");
		//	response.sendRedirect("stop.jsp?ins=alreadyexists&tripid="+tripID+"&startDate="+startDate+"&endDate="+endDate+"&startPlace="+startPlace+"&endPlace="+endPlace+"");		
		}

		
	

if(insert>0){
	msg="inserted";
	//System.out.println("msg====>"+msg);
	response.sendRedirect("addNewLocality.jsp?ins=inserted&tripid="+tripID+"&startDate="+startDate+"&endDate="+endDate+"&startPlace="+startPlace+"&endPlace="+endPlace+"");
	///response.sendRedirect("stop.jsp?ins=inserted&tripid="+tripID+"&startDate="+startDate+"&endDate="+endDate+"&startPlace="+startPlace+"&endPlace="+endPlace+"");
}

	}catch(Exception e){
	e.printStackTrace();
}
	finally{
		try
		{
			con.close();
		}catch(Exception ee)
		{
			
		}
	}
	
%>
</body>
</html>
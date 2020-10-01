<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="Connections/conndriver.jsp" %>
<%! 
Connection con ;
%>


<%
final String tripid=request.getParameter("tripid");
//System.out.println("tripid======"+tripid);
final String transporter=request.getParameter("transporter");

int insert=0;
try{           
	//System.out.println("nw in stop rep page");	
	Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt=con.createStatement();
		Statement st1=con.createStatement();
		String sql="select * from t_stopReport where tripid='"+tripid+"' and transporter='"+transporter+"'";
		//System.out.println(sql);
		ResultSet rs=stmt.executeQuery(sql);
		if(rs.next()){
		//	System.out.println("tripid======>"+tripid);
				out.println("Yes#"+tripid);
			}
		
		else{
			out.println("No#"+tripid);
		}
		
	}catch(Exception e){
	e.printStackTrace();
}
%>

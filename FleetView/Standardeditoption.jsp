<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ include file="Connections/conndriver.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">


</script>
<body>
<%
Connection con ;
String catold=request.getParameter("categorysend");
String subcatold=request.getParameter("subcategorysend");
String optionold=request.getParameter("optionssend");



String Catnew = request.getParameter("addcatnew");
String SubCatnew = request.getParameter("addsubcatnew");
String Optionnew = request.getParameter("addnewoption");
System.out.println("Add CAtegory"   +Catnew);
System.out.println("Add CAtegory"   +SubCatnew);
System.out.println("Add CAtegory"    +Optionnew);
String oldCatnew = request.getParameter("OldCategory");
String oldSubCatnew = request.getParameter("OldSubCategory");
String oldOptionnew = request.getParameter("oldoption");
System.out.println("Add oldCatnew"   +oldCatnew);
System.out.println("Add oldSubCatnew"   +oldSubCatnew);

String html1="";
String Email=session.getAttribute("email").toString();
String RejectedBy=session.getAttribute("mainuser").toString();




try{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
	Statement stmt6=con.createStatement();
	
	Statement stmt3=con.createStatement();
	Statement stmt2=con.createStatement();
	Statement st1=con.createStatement();
	
String sql1 ="",sql2 ="",sql3 ="",sql4 ="",sql5 ="",sql6=""; 

//sql4="select * from db_gps.t_JourneyGoals where Categoery='"+catold+"' and Categoery1='"+subcatold+"' and Options='"+optionold+"' ";
//ResultSet rsnew=stmt3.executeQuery(sql4);
//System.out.println("select querry   " +sql4);
//while(rsnew.next())
//{
	
//}
if(catold.equalsIgnoreCase(Catnew) && subcatold.equalsIgnoreCase(SubCatnew))
{
 sql1="select * from db_gps.t_JourneyGoals where Categoery='"+Catnew+"' and Categoery1='"+SubCatnew+"' and Options='"+Optionnew+"'";
 ResultSet rs1=stmt.executeQuery(sql1);
 if(rs1.next())
 {
	 out.print("No changes made");
	 response.sendRedirect("Standardedit.jsp?Parameter1=NO Changes made&category="+catold+"&subcategory="+subcatold+"&options="+optionold+"");
 }
 else
 {try
 {
	 sql2="update db_gps.t_JourneyGoals set Categoery='"+Catnew+"', Categoery1='"+SubCatnew+"', Options='"+Optionnew+"' where Categoery='"+oldCatnew+"' and Categoery1='"+oldSubCatnew+"' and Options='"+oldOptionnew+"' ";
		//System.out.println("Add Querry" +sql2);
	st1.executeUpdate(sql2);
	System.out.println("Add Querry---------------------------->" +sql2);
    sql5="insert into db_gps.t_JourneyGoalshistory(Category,Subcategory,Input,Entryby)Values('"+catold+"','"+subcatold+"','"+optionold+"','"+RejectedBy+"')";
 	System.out.println("Add Querryin history----------------------->" +sql5);	
	//sql5="insert into db_gps.t_JourneyGoalshistory values Category='"+catold+"' and Subcategory='"+subcatold+"' and Input='"+optionold+"' and Entryby='"+RejectedBy+"'";
	stmt6.executeUpdate(sql5);
	System.out.println("Add Querryin history---------------11111111111111111>" +sql5);
	String update="yes";
	response.sendRedirect("Standardedit.jsp?param="+update); 
 }
 catch(Exception e)
 {
	 e.printStackTrace();
 }
 }
 
}
else
{
	sql3="select * from db_gps.t_JourneyGoals where Categoery='"+Catnew+"' and Categoery1='"+SubCatnew+"' and Options='"+Optionnew+"'";
	ResultSet rs2=stmt1.executeQuery(sql3);
	if(rs2.next())
	{
		out.print("record already exist");
		 response.sendRedirect("Standardedit.jsp?Parameter2=Record already exist &category="+catold+"&subcategory="+subcatold+"&options="+optionold+"");
	}
	else
	{
	sql2="update db_gps.t_JourneyGoals set Categoery='"+Catnew+"', Categoery1='"+SubCatnew+"', Options='"+Optionnew+"' where Categoery='"+oldCatnew+"' and Categoery1='"+oldSubCatnew+"' and Options='"+oldOptionnew+"' ";
		//System.out.println("Add Querry" +sql2);
	st1.executeUpdate(sql2);
	System.out.println("Add Querry2222222222222222222222222222222" +sql2);
	 sql5="insert into db_gps.t_JourneyGoalshistory(Category,Subcategory,Input,Entryby)Values('"+catold+"','"+subcatold+"','"+optionold+"','"+RejectedBy+"')";
		stmt6.executeUpdate(sql5);
		System.out.println("Add Querryin history---------------2222222222222222222222>" +sql5);
	String update="yes";
	response.sendRedirect("Standardedit.jsp?param="+update);	
	}
	
}

}
catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>
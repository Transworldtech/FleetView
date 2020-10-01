<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

</jsp:useBean>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
Statement st,st1,st2;
Connection conn,conn1;

Class.forName(MM_dbConn_DRIVER);
conn = fleetview.ReturnConnection();
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st1=conn1.createStatement();
st2=conn1.createStatement();
st=conn.createStatement();
	
	System.out.println("in driver status change ") ;

	String driver_id   = request.getParameter("driverid");
	String driver_name = request.getParameter("name");
	
	String user = session.getAttribute("dispalyname").toString(); 
		//session.getAttribute("usertypevalue").toString();
   	
	System.out.println(" ithe check kar User name is :-"+user) ;
	//String driver_name = request.getParameter("name");
	System.out.println("the driver id:- "+driver_id+"driver_name:- "+driver_name);
	
	String update_query = "update t_drivers set activestatus='Deactive' where Driverid='"+driver_id+"' ";	

	int flag = st.executeUpdate(update_query);
	
	if(flag>0)
	{
		System.out.println("record updated successfully ");
		%> <script type="text/javascript"> 
				alert("Record Deactivated Successfully !!!");
		   </script>
		   
		<% 
		
		System.out.println("WWWWWW");
		
		String insert_query = "insert into t_driverhistory(Driverid,Drivername,owner,GPName,Activestatus,"+
				              "DeactReason,EntryBy,UpdatedDtTime,FatherNm,Address1"+
				              ",Address2,Gender,Marital,DOB,DateOfInduction,MobileNo,DOBFile,"+
				              "AddressFile) select Driverid,Drivername,owner,GPName,Activestatus "+
				              ",DeactReason,EntryBy,UpdatedDtTime,FatherNm,Address1,"+
				              "Address2,Gender,Marital,DOB,DateOfInduction,MobileNo,DOBFile,AddressFile"+
				              " from t_drivers where DriverId='"+driver_id+"' " ;
		
		System.out.println("WWWWWW XXXXXX   insert query:- "+insert_query);
		
		int flag1 = st.executeUpdate(insert_query) ;
		
		if(flag1>0)
		{
		   //String user = session.getAttribute("usertypevalue").toString();
		   	
		   String sel_query="select Rid from t_driverhistory order by Rid desc limit 1";
		   
		   ResultSet rs = st.executeQuery(sel_query);
		   
		   System.out.println("Select query :- "+sel_query);
		   
		   if(rs.next())
		   {
			  String rid = rs.getString("Rid");
			  System.out.println("Select query :- "+rid);
			  
			  String Update_query_driverhistory = "update t_driverhistory set EntryBy='"+user+"',Action='Changed Activestatus to Deactivated' where Rid='"+rid+"' ";	  
			  System.out.println("Update query :- "+Update_query_driverhistory);
			  int status_chk = st.executeUpdate(Update_query_driverhistory) ;
			  System.out.println("Update query :- "+status_chk);
			  
		      if(status_chk>0)
		      {
		    	  System.out.println("abhinandan mitra are update query pan exeute zali aahe ");
		      }
		      else
		      {
		    	  System.out.println("are yaar hi  update query nahi zali aahe re nit execute chk kar parat ekda ");
		      }
		   
		   }
		   else
		   {
			  System.out.println("select query nahi zaleli aahe successful "); 
		   }
		   
		   
		   //System.out.println("User name is :-"+user) ;	
		  
			
		   System.out.println("inserted  the records in the history table") ;
		  
		   %> <script type="text/javascript"> 
		   
		   
		   window.location= "Reportfordriver.jsp";
		   
		   </script> 	<% 
		}
		else
		{
			System.out.println("couldn't insert into history table of driver please check in query ");
			
		}
				
	
	}
	else
	{
		System.out.println("are mitra yaar...chuk zali rao are ti update query bahutek execute zali nahi aahe krupaya chk kar ");
		
		%> <script type="text/javascript"> 
		alert(" Sorry could not  update record  please check the database connection and then try again !!!!!");
  	 	</script> <% 
		
  	 	response.sendRedirect("Reportfordriver.jsp");
	
	
	}


%>










</body>
</html>
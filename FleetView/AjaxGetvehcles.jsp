<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%-- <%@ include file="header.jsp" %> --%>
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>

<%
try {
    
    
    Class.forName(MM_dbConn_DRIVER);
//	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    Statement stmt1=con1.createStatement();
    Statement stmt2=con1.createStatement();
    ResultSet rs22=null;
    String sql=""; 
    String Vehicle = request.getParameter("vehcles");
    Statement stmt=con1.createStatement(),stmt19=con1.createStatement(),stmt20=con1.createStatement(),stmt21=con1.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null,rs19=null,rs20=null;
	String sql1="", sql2="", sql3="",sql19="",sql20="";
	String tm="";

	java.util.Date td =new java.util.Date();
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	//Format fmt = new SimpleDateFormat("dd-MMM-yyyy");
	String sdt = fmt.format(td);

	tm=td.getHours()+":"+td.getMinutes()+":"+td.getSeconds();

	
	 String OwnerName=request.getParameter("owner");
	 //String Vehicle=request.getParameter("vehcles");
	 String id=request.getParameter("id");
	 String updated=request.getParameter("updated");
	 String empname = request.getParameter("empname");
	 %>
	 <input type="hidden" name="err1" id="err1" value="<%=id %>"/>
	 <input type="hidden" name="err2" id="err2" value="<%=empname %>"/>

	    
<% 

if(!(null==Vehicle))
 			{
 				%>
 				<!-- <div> -->
  <table border="0" align="center"  style="width: 500px"> 
  <tr bgcolor="#e3e9ff">
  	<td>  <font color="black"><b> Current EMP Name And Code : </b></font> </td>
     <td> 
	   <%
	  // String OwnerName=request.getParameter("owner");
		////System.out.println(OwnerName);
	   sql="select Empname,Empcode from t_vehicledetails where VehicleRegNumber = '"+Vehicle+"'";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %>
      		<%=rs2.getString("Empname") %> &nbsp;&nbsp;&nbsp; <%=rs2.getString("Empcode") %>
      		
      		<input type="hidden" name="oldempname" value="<%=rs2.getString("Empname")%>" />	
      		<input type="hidden" name="oldempcode" value="<%=rs2.getString("Empcode")%>" />	
      			<% } %>
     		
     		
	 </td>   
  	
  </tr>
  <tr bgcolor="#e3e9ff" id="tr19" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>User Name:</b> </font> </td>
      			<td><input type="text" name="newuser" id="newuser" ></input> 
      </td>
      </tr>
      
  <tr bgcolor="#e3e9ff" id="tr20">
  <td>  <font color="red">*</font><font color="black"><b> User Name : </b></font> </td>
  <td> 
	   <%
	  	////System.out.println(OwnerName);
	   String hodid="",managerhodid="",UserName="-";
	   sql="select VehicleCode from t_vehicledetails where VehicleRegNumber = '"+Vehicle+"'";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { 
   	      sql19="select UserName,hodid from t_userdetails where vehid = '"+rs2.getString("VehicleCode")+"'";
	      rs19=stmt19.executeQuery(sql19);
	      if(rs19.next()){
	      %>
      		<%-- <%=rs19.getString("UserName") %> --%> 
      		<% UserName=rs19.getString("UserName"); %>
      			
      			<%hodid=rs19.getString("hodid"); %>
      			<% } } %>

           <input type="text" name="oldusername" id="oldusername" readonly="readonly" value="<%=UserName%>" onblur="usrval()" onkeyup="timer()"/>
           <label name="usrn" id="usrn" style="display: none;"><font color="red">&nbsp;&nbsp;&nbsp;Please Enter User Name</font></label>
<input type="hidden" name="olduser123" id="olduser123" value="false"  >
<!--            please wait functinality is here.... -->
           <!-- <div id="plzwait" name="plzwait" style="display: none;"><font color="red" size="2">Please Wait...</font></div> -->
     </td>
  <%if(request.getParameter("vehcles").equalsIgnoreCase("Select")) { %>
  <td style="display:none;" id="showuser">
     		 <input type="hidden" name="olduser" id="olduser" value=""  >
       <a href = "#"  onclick = "showuser()"> <font color="blue" size="2">Change user</font> </a>
       </td>
      <%  }else {%>
  
      <td>
     		 <input type="hidden" name="olduser" id="olduser" value="" >
       <a href = "#"  onclick = "showuser()"> <font color="blue" size="2">Change user</font> </a>
       </td>
      
      <%} %>
  </tr>
  <tr><td></td><td><div id="searchuser" name="searchuser" style="position: fixed; overflow: auto;"></div></td><td></td></tr>
  
  
  <tr bgcolor="#e3e9ff">
  <td>  <font color="red">*</font><font color="black"><b> Manager Name : </b></font> </td>
  <td> 
	   <%
	   String USERname="-";
	  	////System.out.println(OwnerName);
	   sql20="select FirstName,LastName,UserName,hodid from t_userdetails where SrNo = '"+hodid+"'";
	   rs20=stmt20.executeQuery(sql20);
	   if(rs20.next())
   	   { 
		   //USERname=rs20.getString("FirstName")+" "+rs20.getString("LastName");
		   USERname=rs20.getString("UserName");
   	      %>
      		    <%managerhodid=rs20.getString("hodid"); %>
      			<%  } %>
      		<input type="text" name="oldmanagername" id="oldmanagername" readonly="readonly" value="<%=USERname%>" onblur="manval()" onkeyup="timer1()"/>
      		<label name="mann" id="mann" style="display: none;"><font color="red">&nbsp;&nbsp;&nbsp;Please Enter manager name</font></label>
      			<input type="hidden" name="oldmanager123" id="oldmanager123" value="false"  >
      			<%-- <%=USERname %> --%>
     </td>
     <%if(request.getParameter("vehcles").equalsIgnoreCase("Select")) { %>
     <td style="display:none;" id="showmanager">
     		 <input type="hidden" name="oldmanager" id="oldmanager" value="">
       <a href = "#"  onclick = "showmanager()"> <font color="blue" size="2">Change Manager </font> </a>
       </td> 
       <%}else{ %> 
    	   <td>
   		 <input type="hidden" name="oldmanager" id="oldmanager" value="">
     <a href = "#"  onclick = "showmanager()"> <font color="blue" size="2">Change Manager </font> </a>
     </td>
     
   <%    } %>
       
  
  </tr>
  
  <tr><td></td><td><div id="searchmanager" name="searchmanager" style="position: fixed; overflow: auto;"></div></td><td></td></tr>
  
  <tr bgcolor="#e3e9ff">
  <td>  <font color="black"><b> RSM Name : </b></font> </td>
     <td> 
	   <%
	   String RSMname="-",rsmid="";
	  	////System.out.println(OwnerName);
	   String sql21="select srno,FirstName,LastName,UserName from t_userdetails where SrNo = '"+managerhodid+"'";
	   ResultSet rs21=stmt21.executeQuery(sql21);
	   if(rs21.next())
   	   { 
		   //RSMname=rs21.getString("FirstName")+" "+rs21.getString("LastName");
		   RSMname=rs21.getString("UserName");
   	      %>
      		<%rsmid=rs21.getString("srno"); %>
      			<%  }%>
      			<input type="hidden" name="rsmname" id="rsmname" value="<%=RSMname%>" />
	   <%-- <%=RSMname%> --%>
<input type="text" name="oldRSMname" id="oldRSMname" readonly="readonly" value="<%=RSMname%>" onblur="rsmval()" onkeyup="timer2()"/>
      		<label name="rsmm" id="rsmm" style="display: none;"><font color="red">&nbsp;&nbsp;Please Enter RSM name</font></label>
      			<input type="hidden" name="oldrsm123" id="oldrsm123" value="false"  >
      			<%-- <%=USERname %> --%>
     </td>
<%if(request.getParameter("vehcles").equalsIgnoreCase("Select")) { %>
     <td style="display:none;" id="showrsm">
     		 <input type="hidden" name="oldrsm" id="oldrsm" value="">
       <a href = "#"  onclick = "showrsm()"> <font color="blue" size="2">Change RSM </font> </a>
       </td> 
       <%}else{ %> 
    	   <td>
   		 <input type="hidden" name="oldrsm" id="oldrsm" value="">
     <a href = "#"  onclick = "showrsm()"> <font color="blue" size="2">Change RSM </font> </a>
     </td>
     
   <%    } %>
  </tr>


<tr><td></td><td><div id="searchrsm" name="searchrsm" style="position: fixed; overflow: auto;"></div></td><td></td></tr>
  
  
  
   <tr bgcolor="#e3e9ff">
   <td colspan="2">
   <font color="black"><b>
   Create New User Id <input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected();"></input>
   </b></font>
   </td>
   </tr>
  	
  	           
 		       <tr bgcolor="#e3e9ff" style="display: none;" id="tr1">
  				<td><font color="red">*</font>  <font color="black"><b>New EMP Name : </b></font> </td>
 					<td> <input type="text" name="empname" id="empname" onblur="empval()"></input>
 					<label name="empn" id="empn" style="display: none;"><font color="red">Please Enter Emp Name</font></label>
    				</td>
    			</tr>
    			<tr bgcolor="#e3e9ff" style="display: none;" id="tr2">
  				<td><font color="red">*</font> <font color="black"><b>New EMP Code : </b></font> </td>
 					<td> <input type="text" name="empcode" id="empcode" onblur="codeval()"></input>
 					<label name="coden" id="coden" style="display: none;"><font color="red">Please Enter Emp code</font></label>
    				</td>
    			</tr>
    			 <!-- <tr bgcolor="#e3e9ff" id="tr3">
	  			     <td><font color="red">*</font><font color="black"><b>Fleetview ID :</b> </font> </td>
	   				 <td> <input type="text" name="empid" id="empid" onblur="changehod()"> </input><div>Please enter FleetView Id as username</div></td>
     			 </tr>  -->
    			 <tr bgcolor="#e3e9ff" style="display: none;" id="tr4">
	  			     <td><font color="red">*</font><font color="black"><b>New Fleetview ID :</b> </font> </td>
	   				 <td> <input type="text" name="newempid" id="newempid" onblur="newempidval()"> </input><div id="abc">Please enter FleetView Id as username</div>
	   				 <label name="newempidn" id="newempidn" style="display: none;"><font color="red">Please Enter New Fleetview Id</font></label></td>
     			 </tr>
     			<tr bgcolor="#e3e9ff" id="tr5" style="display: none;">
      			<td><font color="black"><b>HOD Email Id:</b> </font> </td>
      			<td><font color="black" id="HOD"></font> 
     			  &nbsp;&nbsp;&nbsp;
     		 <input type="hidden" name="oldHOD" id="oldHOD" value="">
       <a href = "#"  onclick = "showtext()"> <font color="blue" size="2">Change HOD</font> </a>
       
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr6" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>HOD:</b> </font> </td>
      			<td><input type="text" name="newHOD" id="newHOD" onblur="hodval()"></input> 
      			<label name="hodn" id="hodn" style="display: none;"><font color="red">Please Enter HOD</font></label>
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr7" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>Email:</b> </font> </td>
      			<td><input type="text" name="email" id="email" onblur="emailval()"></input> 
      			<label name="emailn" id="emailn" style="display: none;"><font color="red">Please Enter Email Id</font></label>
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr8" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>Mobile No:</b> </font> </td>
      			<td><input type="text" name="phno" id="phno" onblur="phnoval()"></input> 
      			<label name="phnon" id="phnon" style="display: none;"><font color="red">Please Enter Mobile Number</font></label>
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr9" style="display: none;">
      			<td><font color="black"><b>Designation:</b> </font> </td>
      			<td><input type="text" name="deg" id="deg"></input> 
      </td></tr>
      <tr bgcolor="#e3e9ff" id="tr10" style="display: none;">
      			<td><font color="black"><b>Location:</b> </font> </td>
      			<td><input type="text" name="loc" id="loc"></input> 
      </td>
      </tr>
    			 <%-- <tr bgcolor="#e3e9ff">
	  				<td> <font color="black"><b>Allocation Date : </b></font> </td>
	 				<td>  
	 					<input type="text" id="calender" name="calender" size="13" value="<%=sdt%>" readonly/>
	             	 	<script type="text/javascript">
			            	 Calendar.setup(
			             	{
			               	    inputField  : "calender",         // ID of the input field
			                	ifFormat    : "%Y-%m-%d",     // the date format
			                 	button      : "trigger"       // ID of the button
			             	}
			            );
	             		</script>
	             		<input type="hidden" name="checkstatus" id="checkstatus" value="No">
	    			</td>
    			</tr>  --%>
    			
 				 <%
 			}
 		%>
 </table> 
<!-- </div> -->
<%

} 
catch(Exception e)
	{
		out.println(e);
	}

finally
{
con1.close();
}
%>
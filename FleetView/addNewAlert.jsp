<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
</jsp:useBean>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="headernew.jsp"%>    




<script type="text/javascript">
<!--

//-->
function validate()
{
	var alert_name = document.getElementById("alertName").value;
	var search_text = document.getElementById("search-text").value;
	var toid = document.getElementById("toid").value;	
	var tocc = document.getElementById("tocc").value;
	var trip = document.getElementById("trip").value;
	var customerType = document.getElementById("customerType").value;
	alert("the customerType :- "+customerType)

	if(alert_name == " " || alert_name=="" || alert_name=="-")
	{
		alert("please enter appropriate alert name");
		return false;		
	} 
	else if(search_text == " " || search_text=="" || search_text=="-")
	{
		alert("please enter appropriate customer name");
		return false;		
	}
	else if(toid == " " || toid=="" || toid=="-")
	{
		alert("please enter appropriate toids");
		return false;		
	}
	else if(tocc == " " || tocc=="" || tocc=="-")
	{
		alert("please enter appropriate tocc ids");
		return false;		
	}
	else if(customerType == "select" || customerType=="" || customerType=="-")
	{
		alert("please enter appropriate tocc ids");
		return false;		
	}
	else if(trip == "select" || trip=="" || trip=="-")
	{
		alert("please enter appropriate tocc ids");
		return false;		
	}
	else
	{
		return true;
	}	
	
}





function getTransporterDetails(transporter)
{
	//alert("**********************************   ");
	//alert(transporter);
	//alert("**********66666666666 ************   ");
	
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("search-text").value=transporter;
	
}



function getTransporter(num)
{
	try{
	//alert("Hii");
	var b=0;
	var transporter=document.getElementById("search-text").value;
    if(transporter.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	//alert(transporter);
	//var user=document.getElementById("usertypevalue").value;
	//var counter=document.userform.counter.value;
	/*if(counter>100)
	{
		counter=0;
	}*/
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			//alert("b "+b);
			document.userform.counter.value=b;
			//alert("counter "+document.userform.counter.value);
			document.userform.counter.value=b*document.userform.counter.value;
			counter=document.userform.counter.value;
			//alert("counter "+counter);
		} 
	};
	var queryString = "?transporter="+transporter+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "AjaxGetTransporter.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    }
	}catch(e)
	{
		//alert(e);
	}
}

</script>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	 fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
     Connection conn = fleetview.ReturnConnection();
     
     Statement st,st1,st2,st3,st4,st5;
     
     st  = conn.createStatement();
     st1 = conn.createStatement();
     st2 = conn.createStatement();
     st3 = conn.createStatement();
     st4 = conn.createStatement();
     st5 = conn.createStatement();
     
     
     String customer ="";
     String custtype = "";
     String trip = "";
     String toid="";
     String tocc ="";
     String status = "";
     String entryby = "";
     String srno="";
     String alertname="";
     
     String flag = request.getParameter("flag");
     
     System.out.println("the flag is :- "+flag);
     
    
	 		
	  srno      = request.getParameter("srno");
	  alertname = request.getParameter("alertname");
	 
	 System.out.println("the srno :- "+srno+"alertname:-  "+alertname);
	 
	 if(alertname == null || alertname.equalsIgnoreCase("null") || alertname.equalsIgnoreCase(null))
	 {
		 
	 	alertname="";
	 
	 }
	 
	 
	 
	 if((!(srno == null)) && (!(srno.equalsIgnoreCase("null"))) && (!(srno.equalsIgnoreCase(null))) )
	 {
			 
	 		String sql5 = "select * from db_gps.t_alertmaster where SrNo='"+srno+"' "; 
	 		System.out.println("sql 5 :- "+sql5);
	 		ResultSet rst4 = st3.executeQuery(sql5); 
	 		
	 		if(rst4.next())
	 		{
	 						
	 			customer = rst4.getString("Customer");
	 			custtype = rst4.getString("CustType");
	 			trip     = rst4.getString("Trip");
	 			toid 	 = rst4.getString("ToID");
	 			tocc	 = rst4.getString("ToCC");
	 			status   = rst4.getString("Status");
	 		
	 		}
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 }






%>





<% 

%>

<div id="form_container" style="width: 600px;" align="left" style="margin-left:10%">
<table align="left" border="0" style="width:100%;">
<tr align="left">
<td align="left">
<form  method="get">
	
	<br></br>
	
	
<!--(The previous value is )	<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff  ;width=100%;" >-->
       
<!--     <table border="0" width="100%" align="center" >-->
	     <table border="3" style="width: 500px" class="sortable_entry" align="center" > 
	        
	       <tr style="height:30px">
	       <%if(flag.equalsIgnoreCase("insert")) 
	         {
	         %>
		         <td colspan="2"><font face="Arial" size="3"> <b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Add New Alert Form  </b> </font>    </td>
		   <%} 
		     else
		     {%>		   
		   		<td colspan="2"><font face="Arial" size="3"> <b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Alert Edit  Form  </b> </font>    </td>	
		   <%} %>		   
		   </tr>

	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="flag" id="flag" value="<%=flag%>"   /> </td>
	       
	       <td></td>
	       
	       </tr>	
      	   
      	   <tr>
      	   <td><font  size="2"> <b> Alert Name </b></font> </td>
      	   <td> <input type="text" class="element text medium" style="width: 180px;" name="alertName" id="alertName"  value="<%=alertname%>"  />&nbsp; </td> </td>
      	   </tr> 	
	  
			<tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="srno" id="srno" value="<%=srno%>"   /> </td>
	       
	       <td></td>
	       
	       </tr>	
	       
	       
	       
	       <tr>
      	    <td>
      	   		<font  size="2"> <b> Customer  : </b></font>
      	   
      	   </td>
      	   
      	   <td> 
      	    
      	  <input type="text" autocomplete="off" name="username" id="search-text" value="<%=customer%>" style='width: 250px;' onkeyup="getTransporter(1)" />
      	
      	   	
      	   
      	   
      	   </td>
      	   
      	   
      	  
      	   
      	   
      	   
      	   
      	   
      	   </tr>
	      
	      <tr style="height:30px">
	      <td></td>
	      <td>
	      	<div id='transporterlist' align="center">
		   	<div style="height: 110px; width: 300px; overflow: auto;">
		   	<table style="display: none;">
          	</table>
          	<!-- <input type="hidden" name="usertypevalue" id="usertypevalue" value="< %=session.getValue("usertypevaluemain").toString() %>"/>-->
          	<input type="hidden" name="counter" id="counter" value="10"/>
          	<input type="hidden" name="anothercounter" id="anothercounter" value="10"/>
          	</div>
									
			</div>
	      
	      </td>
	      </tr>
	      	
	      
	      
	      
	      
	      
	      
	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden3" id="hidden3"  value=""  /> </td>
	       
	       <td></td>
	       
	       </tr>
	       
	       
	       <tr>
      	   <td> 
      	   	<font  size="2"> <b> Customer Type : </b></font>	
      	   
      	   </td>
      	   <td> 
      	   	
      	   	<select name="customerType" id="customerType">
      	   	
      	   	<%if(custtype.equalsIgnoreCase("") || custtype.equalsIgnoreCase(" ") )
      	   	  {
      	   	System.out.println("dddd 1 :- ");
      	      %>
      	         <option value="select">---select---</option>
      	    <%} 
      	     else 
      	     { %>
      		    <option value="<%=custtype%>"><%=custtype%></option>       	   
      	   <%}%>
      	   		
      	   		<% 
      	   			String sql2 = "select distinct(CustType) as CustType from db_gps.t_alertmaster";
      	   			ResultSet rs1 = st1.executeQuery(sql2);
      	   			System.out.println("sql 2 :- "+sql2);     	   		
      	   			while(rs1.next())
      	   			{ %>
      	   			
      	   				<option value="<%=rs1.getString("CustType") %>"><%=rs1.getString("CustType") %></option>
      	   	  
      	   	  	  <%}
      	   
      	   
      	   
      	   		%> 
      	   		</select>
      	   
      	   
      	   
      	   </td>
      	   </tr>
	       
	       
	       <tr style="height:30px">
	       
	       <%if(flag.equalsIgnoreCase("insert")) 
	         {
	    	   System.out.println("flag :- "+flag);
	          %>
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="flag_value" id="flag_value" value="insert_new"   /> </td>
	       <%}
	         else
	         {  
	        
	        %>
	       	<td> <input type="hidden" class="element text medium" style="width: 180px;" name="flag_value" id="flag_value" value="update_existing"   /> </td>
	       <%} %>
	       <td></td>
	       
	       </tr>
	       
	       
	       
	       
	       
	       <tr >
           <td><font  size="2"> <b> Trip : </b></font></td>
           <td> 
           		<select name="trip" id="trip">
           		<%if(custtype.equalsIgnoreCase("") || custtype.equalsIgnoreCase(" ") )
      	   	  	{	      	    
					//customerType,trip      	      	
      	      	%>
      	         	<option value="select">---select---</option>
      	      <%} 
      	     	else 
      	     	{ %>
      		    	<option value="<%=trip%>" selected><%=trip%></option>       	   
      	   	  <%}%>
      	   		
      	   		<% 
      	   			String sql3 = "select distinct(Trip) as Trip from db_gps.t_alertmaster";
      	   			ResultSet rs2 = st2.executeQuery(sql3);
      	   		
      	   			while(rs2.next())
      	   			{ %>
      	   			
      	   				<option value="<%=rs2.getString("Trip") %>"><%=rs2.getString("Trip") %></option>
      	   	  
      	   	  	  <%}
      	   
      	   
      	   
      	   		%> 
      	   		</select>
           
           </td>
           </tr>
	      
	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="chk_flag" id="chk_flag" value="1" /> </td>
	       
	       <td></td>
	       
	       </tr>	       
<!--	      <input type="text" class="element text medium" style="width: 180px;" name="toid" id="toid" value="<%=toid%>" /> -->
	       <tr>
           <td><font  size="2"> <b> ToID :</b> </font></td>
           <td><textarea id="toid" name="toid" rows="5" cols="40" placeholder="here it is "/> <%=toid%></textarea>
          </td>
           </tr>
           
           <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden3" id="hidden3"    /> </td>
	       
	       <td></td>
	       
	       </tr>	
           
           
           
           <tr style="height:30px">
				 		
	 		 <td>
	      	  <font  size="2"><b> ToCC :</b> </font>
	  		 </td>
	  		 
	  		 <td >
	  		 	<textarea id="tocc" name="tocc" rows="5" cols="40" /><%=tocc%></textarea> 
<!--	  		 	<input type="text" class="element text medium" style="width: 180px;" name="tocc" id="tocc"  value="<%=tocc%>"/>	-->
	  		 </td>
	 	  
	 	   </tr>
           
            
         
		   <tr></tr>
		   <tr></tr>
		   <tr></tr>
		   
		   <tr style="height:30px">
				 		
	 		 <td>
	      	  <font  size="2"><b> Status :</b> </font>
	  		 </td>
	  		 
	  		 <td > 
	  		 
	  		 <select name="status" id="status">
	  		 
	  		 <%if(status.equalsIgnoreCase("") || status.equalsIgnoreCase(" ") )
      	   	  {	      	    
      	      %>
      	         <option value="select">---select---</option>
      	    <%} 
      	     else 
      	     { %>
      		    <option value="<%=status%>"><%=status%></option>       	   
      	   <%}%>
      	   		
      	   		<% 
      	   			String sql4 = "select distinct(status) as status from db_gps.t_alertmaster";
      	   			ResultSet rs3 = st2.executeQuery(sql4);
      	   		
      	   			while(rs3.next())
      	   			{ %>
      	   			
      	   				<option value="<%=rs3.getString("status") %>"><%=rs3.getString("status") %></option>
      	   	  
      	   	  	  <%}%> 
      	   		</select>
	  		 		
	  		 </td>
	 	  
	 	   </tr>
		   
		   
		   <tr style="height:60px">
           <td></td>
           <td><input type="submit" id="submit" name="submit" value="UPDATE"  onclick="return validate();" /></td>
           </tr>
	


	</table>
<!--	</div>-->
	
	
</form>
</td>     
</tr>
</table>
</div>








<% 
	String flag_value = request.getParameter("flag_value");

	System.out.println("hrishikesh this is the flag value that we have received :- "+flag_value);
	
	if(flag_value==null || flag_value.equalsIgnoreCase(null) || flag_value.equalsIgnoreCase("null"))
	{
		flag_value="";
	
	}
	
	
	if(flag_value.equals("insert_new") || flag_value.equalsIgnoreCase("insert_new") || flag_value=="insert_new")
	{
		
		//customerType,trip
		  alertname = request.getParameter("alertName");	
		  customer = request.getParameter("username");
	      custtype = request.getParameter("customerType");
	      trip 	   = request.getParameter("trip");
	      toid     = request.getParameter("toid");
	      tocc 	   = request.getParameter("tocc");
	      status   = request.getParameter("status");
	      
	      entryby =session.getAttribute("dispalyname").toString();
	      //alertname,customer,custtype,trip,toid,tocc,status,entryby
	      String sql6 = "insert into db_gps.t_alertmaster(AlertName,Customer,CustType,Trip,ToID,ToCC,Status,EntryBy)values('"+alertname+"','"+customer+"','"+custtype+"','"+trip+"','"+toid+"','"+tocc+"','"+status+"','"+entryby+"')";
		  System.out.println("the sql query is :- "+sql6);
	      int inserted_count = st4.executeUpdate(sql6);
		  
		  if(inserted_count>0)
		  {
			  
		  	System.out.println("Got inserted in the table ");
		  	%>
		  	<script type="text/javascript">
			alert("Record updated successfully !!! ") ;	
			window.close() ;
			//window.onunload = refreshParent;
			window.opener.location.reload();

			</script> <% 

		  
		  }
	
	
	
	
	}
	else if(flag_value.equalsIgnoreCase("update_existing") || flag_value == "update_existing")
	{
			
		  alertname = request.getParameter("alertName");	
		  customer = request.getParameter("username");
	      custtype = request.getParameter("customerType");
	      trip 	   = request.getParameter("trip");
	      toid     = request.getParameter("toid").trim();
	      tocc 	   = request.getParameter("tocc").trim();
	      status   = request.getParameter("status");
		
		
		
		
		String sql_update = "update db_gps.t_alertmaster set alertname='"+alertname+"'," +
							"customer='"+customer+"',custtype='"+custtype+"',trip='"+trip+"',"+
							"toid='"+toid+"',tocc='"+tocc+"',status='"+status+"' where SrNo="+srno;
	
	
		System.out.println("the update query is :- "+sql_update);
		
		
		int ch = st5.executeUpdate(sql_update);
		
		if(ch>0)
		{
			System.out.println("updated successfully in the alertmaster");
			
			%>
		  	<script type="text/javascript">
			alert("Record updated successfully !!! ") ;	
			window.close() ;
			//window.onunload = refreshParent;
			window.opener.location.reload();

			</script> <% 
		
		}
	
	
	}



%>














































</body>
</html>
<%@ include file="footernew.jsp"%>
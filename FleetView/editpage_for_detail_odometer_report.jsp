<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
</jsp:useBean>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="headernew.jsp"%>
<%
//classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<<script type="text/javascript">

function validate()
{
	
	//alert("in validate ");



}



</script>





<%!
Connection conn, con1;
Statement st,st1,st2,st3,stveh1,stveh2;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
String dateformat;
%>
<% 
//<a href="editpage_for_detail_odometer_report.jsp?data1=datenew1&data2=datenew2&Oname=ownerNm&odometer=odometerdiff
//&vehregno=vehregno&vehicleCode=vehicleCode&employeeName=employeeName&status=edit&srno=rs21.getString("SrNo")"
String datenew1 = request.getParameter("data1");
String datenew2 = request.getParameter("data2");
//System.out.println("WWWWW   datenew2:- "+datenew2);
String ownernm = request.getParameter("Oname");
String odometer = request.getParameter("odometer");
String vehregno = request.getParameter("vehregno");
String vehicleCode = request.getParameter("vehicleCode");
String employeeName = request.getParameter("employeeName");
String srno = request.getParameter("srno");
String entby=session.getAttribute("dispalyname").toString();
String odometer_val="",liters="0.0";
System.out.println("Hya values Bagh re BABA datenew1:-"+datenew1+"datenew2:-"+datenew2+"ownernm:-"+ownernm+"odometer:- "+odometer+"vehregno:- "+vehregno+"vehicleCode:- "+vehicleCode+"employeeName:- "+employeeName+"srno:- "+srno);
String Date_time = " " ;
String old_odometer_val;
String vehid=" " ;  
String driver_nm =" " ;

%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st = conn.createStatement() ;
String sel_query = "select * from t_fuelinfo where VehNo='"+vehregno+"' and SrNo='"+srno+"' order by TheDateTime";
System.out.println("select Sql query :- "+sel_query);
ResultSet rs=st.executeQuery(sel_query);
System.out.println("resultset :- "+rs);
if(rs.next())
{
	odometer_val = rs.getString("Odometer");
	System.out.println("QQQQ !!!!   Odometer value:- "+odometer_val+"liters:- "+liters) ;
	liters = rs.getString("Litres");
	System.out.println("QQQQ  @@@@  Odometer value:- "+odometer_val+"liters:- "+liters) ;
	Date_time = rs.getString("TheDateTime");
	System.out.println("QQQQ  @@@@ 1111  Date_time"+Date_time) ;
	vehid = rs.getString("VehNo");
	driver_nm = rs.getString("Driver");
}

String Display_Date_time = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(Date_time));

if(liters.equals("") || liters.equals(" ")  || liters.equals("-"))
{
	liters = "0.0";
}
System.out.println("QQQQ  ####  Odometer value:- "+odometer_val+"liters:- "+liters) ;

String query_for_getting_latest_odo_val = "select * from db_gps.t_fuelinfo where VehNo='"+vehregno+"' and theDateTime < '"+Date_time+"' order by TheDateTime desc limit 1" ;

System.out.println("the query for getting the last enetered latest odometer val :- "+query_for_getting_latest_odo_val) ;

ResultSet rst = st.executeQuery(query_for_getting_latest_odo_val) ;

if(rst.next())
{
	old_odometer_val = rst.getString("Odometer") ;
	System.out.println("the value for the odometer is :- "+old_odometer_val);
}
else
{
	old_odometer_val = "0" ;
}



%>
<table align="left" border="0" style="margin-right:50em;width:100%;">
<div id="form_container" style="width: 600px;" align="left" style="margin-left:10%">
<table align="left" border="0" style="width:100%;">
<tr align="left">
<td align="left">
<form  method="get">
	<input type="hidden" id="data1" name="data1" value="<%=datenew1%>"/>
	<input type="hidden" id="data2" name="data2" value="<%=datenew2%>"/>
    <input type="hidden" id="Oname" name="Oname" value="<%=ownernm%>"/>
	<input type="hidden" id="odometer" name="odometer" value="<%=odometer%>"/>
	<input type="hidden" id="vehregno" name="vehregno" value="<%=vehregno%>"/>
	<input type="hidden" id="vehicleCode" name="vehicleCode" value="<%=vehicleCode%>"/>
	<input type="hidden" id="employeeName" name="employeeName" value="<%=employeeName%>"/>
	<input type="hidden" id="srno" name="srno" value="<%=srno%>"/>
	<br></br>
	
	
<!--(The previous value is )	<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff  ;width=100%;" >-->
       
<!--     <table border="0" width="100%" align="center" >-->
	     <table border="3" style="width: 500px" class="sortable_entry" align="center" > 
	        
	       <tr style="height:30px">
		         <td colspan="2"><font face="Arial" size="3"> <b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Odometer Edit Form  </b> </font>    </td>
		   </tr>

	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden1" id="hidden1"    /> </td>
	       
	       <td></td>
	       
	       </tr>	
      	   
      	   <tr>
      	   <td><font  size="2"> <b> Date & Time : </b></font> </td>
      	   <td> <%=Display_Date_time%></td>
      	   </tr> 	
	  
			<tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden2" id="hidden2"    /> </td>
	       
	       <td></td>
	       
	       </tr>	
	       
	       
	       
	       <tr>
      	   <td><font  size="2"> <b> Veh No : </b></font> </td>
      	   <td> <%=vehregno %></td>
      	   </tr>
	       
	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden3" id="hidden3"    /> </td>
	       
	       <td></td>
	       
	       </tr>
	       
	       
	       <tr>
      	   <td><font  size="2"> <b> Driver Name : </b></font> </td>
      	   <td> <%=driver_nm %></td>
      	   </tr>
	       
	       
	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden3" id="hidden3"    /> </td>
	       
	       <td></td>
	       
	       </tr>
	       
	       
	       
	       
	       
	       <tr >
           <td><font  size="2"> <b> Odometer Reading : </b></font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="odometer_val" id="odometer_val"  value="<%=odometer_val%>"  />&nbsp; </td>
           </tr>
	      
	       <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden2" id="hidden2"    /> </td>
	       
	       <td></td>
	       
	       </tr>	       
	       
	       <tr>
           <td><font  size="2"> <b> Litres. :</b> </font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="fuel_val" id="fuel_val" /></td>
           </tr>
           
           <tr style="height:30px">
	       <td> <input type="hidden" class="element text medium" style="width: 180px;" name="hidden3" id="hidden3"    /> </td>
	       
	       <td></td>
	       
	       </tr>	
           
           <tr></tr>
           <tr></tr>
           
           <tr style="height:30px">
				 		
	 		 <td>
	      	  <font  size="2"><b> Remark :</b> </font>
	  		 </td>
	  		 
	  		 <td > 
				<textarea id="cmntreason" id="reason"  name="reason" rows="5" cols="40"/> </textarea> 				
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
</table>
</body>

<% 

	String new_odometer_val = request.getParameter("odometer_val") ;
	
	System.out.println("new_odometer_val:- "+new_odometer_val);

	String new_fuel_val = request.getParameter("fuel_val") ;
	String reason 		= request.getParameter("reason") ;
	
	String updating_date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) ;
 	
	System.out.println("EEEEEEEE AAAA :- "+reason);
 
 if(new_odometer_val != null  &&  new_fuel_val != null && new_fuel_val != " " &&  !(new_odometer_val.equalsIgnoreCase("-"))  )
 {
	System.out.println("aani aata navin values aahet  new_odometer_val:- "+new_odometer_val+"new_fuel_val:- "+new_fuel_val);
	
	if((Double.parseDouble(new_odometer_val)) <= (Double.parseDouble(old_odometer_val)))
	{
		System.out.println("Aapan aata if chya aat aahat jyamdhe aapan odometer chya valued check kelya ahet");
		%><script type="text/javascript">alert("The value of Odometer you have entered is not valid. The value must be greater than   "+"<%=old_odometer_val%>"+"     please enter values again ");</script><%    
				
	}
	else
	{
		String edit_query = "update t_fuelinfo set Odometer='"+new_odometer_val+"',Litres='"+new_fuel_val+"',updatedDtTime='"+updating_date+"',EntBy='"+entby+"'  where SrNo='"+srno+"' and VehNo='"+vehregno+"'";
		System.out.println("aani aata aapan else madhe aahat ");
		int n = st.executeUpdate(edit_query);
		String insert_query = "insert into t_fuelinfo_history (SrNo, Transporter, VehNo, TheDateTime, Driver, Litres, PetrolPump, EntBy, vehcode, FullTank,Odometer,Remark,updatedDtTime,gpsdistance) select * from t_fuelinfo where SrNo='"+srno+"'" ;
		
		if(n>0)
		{
			System.out.println("Updated Successfully ");
			//response.sendRedirect("detail_odomter_transporter.jsp?data1="+datenew1+"&data2="+datenew2+"&Oname="+ownernm+"&odometer="+odometer+"&vehregno="+vehregno+"&vehicleCode="+vehicleCode+"&employeeName="+employeeName+"&status=show report");
			
			int f = st.executeUpdate(insert_query);
			
			if(f>0)
			{
				System.out.println("QWQWQW  QWQW  inserted Successfully") ;
				String update_reason_query = "update t_fuelinfo_history set Remark='"+reason+"',Action='edited' where SrNo ='"+srno+"' and updatedDtTime >='"+updating_date+"' ";
				System.out.println("in the update insert query id:- "+update_reason_query);
				int flag = st.executeUpdate(update_reason_query) ;
				
				if(flag>0)
				{
					System.out.println("Updated the reason value into remark coloumn");
				}
				else
				{
					System.out.println("couldn't update the values in the remark coloumn");
				
				}
			}
			
		
			
			%><script type="text/javascript">
			alert("Record updated successfully !!! ") ;	
			//window.location="detail_odomter_transporter.jsp?data1="+"<%=datenew1%>"+"&data2="+"<%=datenew2%>"+"&Oname="+"<%=ownernm%>"+"&odometer="+"<%=odometer%>"+"&vehregno="+"<%=vehregno%>"+"&vehicleCode="+"<%=vehicleCode%>"+"&employeeName="+"<%=employeeName%>";
			window.close() ;
			//window.onunload = refreshParent;
			window.opener.location.reload();

			</script> <% 
	}
 	
		else
		{
			%> <script type="text/javascript"> alert("couldn't insert data successfully please contact System administrator");
		   	</script><% 


			//-->
		}
 	}
 }	
 else
 {
	  
	 System.out.println("FFFFFFFFFFFFFFFFFFFFf");
	 %> <script type="text/javascript"> alert("please insert proper values for odometer ");
	 	
	 	document.getelementbyid("odometer_val").value=" " ;    
	 	
	 	</script>
	 
 
     <% 
 }
	
%>

<%@ include file="footernew.jsp"%>

</html>


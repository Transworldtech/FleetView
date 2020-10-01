<%@ include file="headernew.jsp"%>
	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script>
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>	
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	ResultSet rs = null;
	
	String VehCode=request.getParameter("vehcode");
	String vehregno=request.getParameter("vehregno");
	String time1="",time2="";
	
	System.out.println(" vehcode is  "+VehCode+" vehregno "+vehregno);
%>
<%!Connection con1;%>

<html>
<head>

<script language="javascript">
 	
 function validate()
 {
	 if(document.getElementById('VehCode').selectedIndex == 0)
	 {
	 alert("Please select Vehicle No");
	 return false;
	 }
	 else
	 {
		 var x = document.forms["formupdate"]["distance"].value;
		 //var x= document.getElementById('distance').selectedIndex == 0
		  //  var y = document.forms["formupdate"]["reason"].value; 
		   var d1 = document.forms["formupdate"]["data1"].value;
	    var d2 = document.forms["formupdate"]["data2"].value;
	    var date=new Date().toISOString().slice(0, 19).replace('T', ' ');

	    if(d2 == d1 || d2 < d1){
		    alert("To Date should be greater than from date");
		    return false;
	    }
		  
		 if (x==null || x==" ") {
		        alert("Please Enter The Distance ");
		        return false;
		    }
		 var numbers = /^[0-9]+$/;
		    if(document.forms["formupdate"]["distance"].value.match(numbers)){
			    }else{
			    	 alert('Please Enter the distance in numeric characters only '); 
			    	 return false;
			    }
		   
	   
	}
		var check1=	document.getElementById('rule1').checked;
		var check2=	document.getElementById('rule2').checked;
		var check3=	document.getElementById('rule3').checked;
	
		
		if(check1 == false ){
			alert("Please Accept All The Rules");
			return false;
		}
		if(check2 == false ){
			alert("Please Accept All The Rules");
			return false;
		}
		if(check3 == false ){
			alert("Please Accept All The Rules");
			return false;
		}
	 
 }

 function checkvalue(val)
 {
	 if(val==="Other")
	       document.getElementById('otherComment').style.display='block';
	    else
	       document.getElementById('otherComment').style.display='none'; 
 }
</script>

</head>

<form name="saveNDEntry"   id="formupdate" method="post" action="saveNdEntry.jsp?update=false" onSubmit="return validate();" >
<%
	try {
			Class.forName(MM_dbConn_DRIVER);
			con1 = fleetview.ReturnConnection();
			
			String sql2 = "", sql3 = "", sql4 = "", sql5 = "";
			String user = session.getValue("usertypevalue").toString();
			String usertype = session.getValue("TypeofUser").toString();
			java.util.Date d = new java.util.Date();
			int hours = (d.getHours());
			int minutes = (d.getMinutes());
			String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy HH:mm")
					.format(new java.util.Date());
			DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");

			Calendar now123=Calendar.getInstance();
			
			String sysdate22 = dateFormat.format(now123.getTime());
			System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);
			
			%>
			<input type="hidden" name="transporter" id="transporter" value="<%=user %>"></input>
			<table border="3" style="width: 200px" class="sortable_entry" align="center" >
  		      <tr>
		         <td> <div align="center"> <font face="Arial" size="3"> <b> Vehicle ND Intimation </b> </font>   </div> </td>
		         </tr>
		         <tr>
		         <td>(<font color="red"> *</font> indicates mandatory fields)</td>
		         </tr>
		     
		<td colspan="">
				<br>
				<table border="0" style="width: 400px" align="center">
  	  			<tr>
	      			<td> 
	      	 			<font color="red">* </font><font face="Arial" size="2"><b> Vehicle No :</b></font> </td>
					<td> 
		 <select class="element select medium" name="VehCode" id="VehCode" style="width: 130px">
		<option value="Select">Select</option>
<%
String fromtime="",totime="";
		try {
			
			//take the from date to date from t_defaultvals and do the validations
			String owner="";
			//String fromtime="",totime="";
			String sql= "select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber ";
			System.out.println(" sql "+sql);
			ResultSet rst = stmt1.executeQuery(sql);
			String regNo="";
			while (rst.next()) {
			regNo = rst.getString("VehicleRegNumber");
			VehCode=rst.getString("vehicleCode");
			owner=rst.getString("Ownername");
			
			
			String sql1="select NightDrivingFromTime, NightDrivingToTime from t_defaultvals where Ownername='"+owner+"' ";
			rs=stmt2.executeQuery(sql1);
			if(rs.next()){
				fromtime=rs.getString("NightDrivingFromTime");
				totime=rs.getString("NightDrivingToTime");
				
			//	System.out.println("NightDrivingFromTime->"+fromtime);
			//	System.out.println("NightDrivingToTime->"+totime);
				
			}
%>
						<option value="<%=VehCode%>"><%=regNo%></option>
	<%
			}
	} catch (Exception e) {
	System.out.print("Exception" + e);
	}
	%>
						
						</select>				
				
					</td>
	 			</tr>
	 			<tr >
	 			
	      			<td> 
	      			<input type="hidden" id="fromtime" name="fromtime" value="<%=fromtime %>"></input>
	      			<input type="hidden" id="totime" name="totime" value="<%=totime %>"></input>
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>From Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td >  
						<input type="text" id="MdateF" name="data1"  value="<%=nwfrmtdte %>"  class="datetimepicker" style="width: 130px;"    readonly/></font></div>
				
							</td>
						 </tr>
			
			
					<tr >
	 			
	      			<td> 
	      		
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>To Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td> 
						<input type="text" id="MdateF" name="data2"  value="<%=nwfrmtdte %>"  class="datetimepicker" style="width: 130px;"    readonly/></font></div>
             			
				
							</td>
						 </tr>
					<tr>
					<td><font color="red">* </font><font face="Arial" size="2"><b> Distance :  </b> </font> <font color="red"></font></td>
					 	<td><input type="text" class="element text medium" style="width: 100px" name="distance" id="distance" size="10"></td>
					 	
					 	
					</tr>
  					<tr>
					<td><font face="Arial" size="2"><b> Reason :  </b> </font> <font color="red"></font></td>
					 	<td><input type="text" class="element text medium" style="width: 100px" name="reason" id="reason" size="10"></td>
					 
					 	
					</tr>
					<tr>
					<td><font color="red">* </font> <input type="checkbox" id="rule1" name="rule1" value="rule1">I will follow road safety rules</h3><br></td>

					</tr>
					<tr>
					<td><font color="red">* </font><input type="checkbox" id="rule2" name="rule2" value="rule2">I will not drink and drive<br></td>

					</tr>
					<tr>
					<td><font color="red">* </font><input type="checkbox" id="rule3" name="rule3" value="rule3">I am driving for personal reason<br></td>

					</tr>
				<tr>
      					<td colspan="2" align="center"> 
      						<div align="center"> 
      							<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" class="formElement"/> 
      						</div> 
      					</td>
  					</tr>
  					
  					
     		 </table>
			</td>
		
	</table>
<%
	} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{
				con1.close();
			}
			catch(Exception e)
			{
				
			}	
		
			try{
				fleetview.closeConnection();
			}
			catch(Exception e)
			{
				
			}
		}
%>




<%@ include file="footernew.jsp" %>
</html>
			

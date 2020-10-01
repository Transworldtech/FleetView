<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.TrainingInformation"
		import="java.util.List"
		import="java.text.*"%>


<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>

<link href="../css/css.css" rel="StyleSheet" type="text/css">
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<link rel="stylesheet" type="text/css" href="../css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="../css/cpanel_colors.css">
<%
String driverId=request.getParameter("driverid");
int numRecords=0;
List<TrainingInformation> data = null;
try{
		data=vehicleDao.getTrainingInformation(driverId);
		numRecords=data.size();
}
catch(Exception e){
	e.printStackTrace();
}
%>
<form action="" style="overflow:scroll" > 
<div class="ScrollTable" style="height: 600px;">
<table border="0" width="50%" align="center" >
<tr><td>
<table class="sortable">
<tr><td align="center"><font size="3">Driver Training Details</font></td></tr>
<tr><td>
 <table border="1" width="50%" align="center" class="sortable">
 <%
 if(numRecords>0){
 	for(int counter=0;counter<numRecords;counter++){
 		final TrainingInformation currentRecord =  data.get(counter);
 		
 %>
         <tr>
				<td align="left"><input type="hidden" id="driverid" name="driverid"  value="<%=driverId%>">
					<div align="left"><font size="2" >Driver Name </font> </div>
				</td>
				<td>
					<div align="left"><font size="2" ><%=currentRecord.getDriverName()%></font> </div>
				</td>
		</tr>
		<tr>
				<td align="center">
					<div  align="left"><font size="2" >Driver's Father Name </font></div>
				</td>
                <td>
                	<div align="left"><font size="2" ><%=currentRecord.getDriverFatherName() %></font> </div>
    			</td>
		</tr>
                         
        <tr>
				<td align="center">
					<div align="left"><font size="2" >Transporter </font></div> 
				</td>
                <td>
                	<div align="left"><font size="2" ><%= currentRecord.getTransporter() %></font></div>
		 		 </td>
        </tr> 
        <tr>
				<td align="center">
					<div  align="left"><font size="2">DOB </font> </div>
				</td>
                <td>
                	<div  align="left"><font size="2"> <% 
				try
				{
                                out.print(new SimpleDateFormat("dd-MMM-yyyy").format(currentRecord.getDateOfBirth()));
                                }
                                catch(Exception ex)
                                {
                                out.print(currentRecord.getDateOfBirth());
                                }%>" 
                       				</font> 
                     </div>  
                </td>
		</tr>
                        
		<tr>
				<td align="center">
						<div  align="left"><font size="2" >License Number </font></div>
				</td>
                <td> 
                		<div  align="left"><font size="2" ><%=currentRecord.getLisenceNumber() %></font></div>
                </td>
			</tr>
            <tr> 
				<td align="center">
						<div  align="left"><font size="2">License ExpiryDate  </font></div>
				</td>
                <td> 
                     	<div  align="left"><font size="2"> <%=currentRecord.getLisenceExpiryDate() %></font></div>
                </td>
        	 </tr> 
             <tr>
				<td align="center">
						<div align="left"><font size="2" >MedicalExam </font> </div>
				</td>
                 <td> 
                       	<div align="left"><font size="2" ><%=currentRecord.getMedicalExamInfo()%> </font> </div>
                 </td>
			</tr>
			<tr>
    				<td align="center"><div align="left"><font size="2" >MedicalExam ExpiryDate</font></div> </td>
                                 

                                 <td align="center"><div align="left"><font size="2" ><%
				
				
				try{
				    out.print(currentRecord.getMedicalExamExpiryDate());
                                }
				
                                catch(Exception ex)
                                {
                                	out.print("-");
                                }
			%> </font></div></td>
 

                                
			</tr>
                         
                        <tr>
				<td align="center"><div align="left"><font size="2" >Place  </font></div></td>
                <td><div align="left"><font size="2" ><%=currentRecord.getPlace() %></font></div></td>
                             
                        </tr> 
                        <tr>
				<td align="center"><div align="left"><font size="2" >Basic  </font></div></td>
				  <td><div align="left"><font size="2" ><%= currentRecord.getBasic() %></font></div></td>
                             
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >Module1</font> </div></td>
				  <td><div align="left"><font size="2" ><%= currentRecord.getModule1()%></font></div></td>
                               
			</tr>
                         
                        <tr>
				<td align="center"><div  align="left"><font size="2" >Module2</font></div>  </td>
				  <td><div align="left"><font size="2" ><%=currentRecord.getModule2()%></font></div></td>
                            
                        </tr> 
                        <tr>
				<td align="center"><div  align="left"><font size="2" >Module3 </font> </div></td>
				  <td><div align="left"><font size="2" ><%=currentRecord.getModule3()%></font></div></td>
                                
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >Module4 </font></div></td>
				  <td><div align="left"><font size="2" ><%= currentRecord.getModule4() %></font></div></td>
                                
			</tr>
                         
                        <tr>
				<td align="center"><div  align="left"><font size="2">Remark</font></div>  </td>
				  <td><div align="left"><font size="2" ><%= currentRecord.getRemark() %></font></div></td>
                              
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">FT Training </font></div> </td>
				 <td><div align="left"><font size="2" ><%= currentRecord.getFTTraining() %></font></div></td>
                           
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">Last Training </font></div> </td>
				 <td><div align="left"><font size="2" ><%= currentRecord.getLastTraining() %></font></div></td>
                           
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">Last Training Date </font></div> </td>
				 <td><div align="left"><font size="2" ><%= currentRecord.getLastTrainingDate() %></font></div></td>
                                
                        </tr> 

     <%
 		}
 	}
 else{
	 %>
	 <tr>
				<td align="left"><input type="hidden" id="driverid" name="driverid"  value="<%=driverId%>">
					<div align="left"><font size="2" >Driver Name </font> </div>
				</td>
				<td>
					<div align="left"><font size="2" >Not trained</font> </div>
				</td>
		</tr>
	 <%
 }

 	
%>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</form>
<%@ include file="../footernew.jsp"%>



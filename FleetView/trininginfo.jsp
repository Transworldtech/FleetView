
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.TrainingInformation"
		import="java.util.List"
		import="java.text.*"%>

<jsp:useBean id="vehicledao"
		type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	

<link href="../css/css.css" rel="StyleSheet" type="text/css">
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<%
String driverId=request.getParameter("driverid");
int numRecords=0;
List<TrainingInformation> data = null;
try{
		data=vehicledao.getTrainingInformation(driverId);
		numRecords=data.size();
}
catch(Exception e){
	e.printStackTrace();
}
%>
<form action="editTrainingInfo.jsp" style="overflow:scroll" > 
<div class="ScrollTable" style="height: 600px;">
<table border="1" width="100%" align="center" >
<tr><td>
<table class="stats">
<tr><td align="center"><font color="brown" size="3">Driver Training Details</font></td></tr>
<tr><td>
 <table border="2" width="100%" align="center" class="stats">
 <%
 	for(int counter=0;counter<numRecords;counter++){
 		final TrainingInformation currentRecord =  data.get(counter);
 		if(numRecords>0){
 %>
                         <tr>
			<td align="left"><input type="hidden" id="driverid" name="driverid"  value="<%=driverId%>">
				<div align="left"><font size="2" >Driver Name </font> </div>
			</td>
			<td>
				<input id="drivername" name="drivername" type="text" value="<%=currentRecord.getDriverName()%>" class="formElement">
				  </td>
			</tr>
			<tr>
				<td align="center"><div  align="left"><font size="2" >Driver's Father Name </font></div></td>
                                <td>
				<input id="driverfather" name="driverfather" type="text" value="<%=currentRecord.getDriverFatherName() %>" class="formElement">
    </td>
			</tr>
                         
                        <tr>
				<td align="center"><div align="left"><font size="2" >Transporter </font></div> </td>
                               <td>
			<input id="Transporter" name="Transporter" type="text" value="<%= currentRecord.getTransporter() %>" class="formElement">
		  </td>
                        </tr> 
                        <tr>
				<td align="center"><div  align="left"><font size="2">DOB </font> </div></td>
                                <td><input id="DOB" name="dob" type="text" value=" <% 
				try
				{
                                out.print(new SimpleDateFormat("dd-MMM-yyyy").format(currentRecord.getDateOfBirth()));
                                }
                                catch(Exception ex)
                                {
                                out.print(currentRecord.getDateOfBirth());
                                }%>" class="formElement">   </td>
			</tr>
                        
			<tr>
				<td align="center"><div  align="left"><font size="2" >License Number </font></div></td>
                                
                                <td> <input id="licenceno" name="licenceno" type="text" value="<%=currentRecord.getLisenceNumber() %>" class="formElement" >  </td>
			</tr>
                <tr> 
				<td align="center"><div  align="left"><font size="2">License ExpiryDate  </font></div></td>
                               <td> 
                                <% try{
                               
                             %>

<input type="text" id="licnExpiryDate" name="licnExpiryDate" value="<%=currentRecord.getLisenceExpiryDate() %>" class="formElement" />

                                 <%
                                }
                                catch(Exception ex)
                                {
                                     %>   <input type="text"  id="licnExpiryDate" name="licnExpiryDate" value="<%=currentRecord.getLisenceExpiryDate()%>"  > <%
                                
                                }%>  
                               </td>
                        </tr> 
                        <tr>
				<td align="center"><div align="left"><font size="2" >MedicalExam </font> </div></td>
                                  <td> <input id="MedicalExam" name="MedicalExam" type="text" value="<%=currentRecord.getMedicalExamInfo()%>" class="formElement">  </td>
                                  
                               
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >MedicalExam ExpiryDate</font></div> </td>
                                 

                                 <td align="center"><input type="text" id="MediclExpDate" name="MediclExpDate" value="<%
				
				
				try{
				    out.print(currentRecord.getMedicalExamExpiryDate());
                                }
				
                                catch(Exception ex)
                                {
                                	out.print("-");
                                }
			%>  " class="formElement"></td>
 

                                
			</tr>
                         
                        <tr>
				<td align="center"><div align="left"><font size="2" >Place  </font></div></td>
                                 <td> <input id="Place" name="Place" type="text" value="<%=currentRecord.getPlace() %>" class="formElement">  </td>
                             
                        </tr> 
                        <tr>
				<td align="center"><div align="left"><font size="2" >Basic  </font></div></td>
                                 <td> <input id="Basic" name="Basic" type="text" value="<%= currentRecord.getBasic() %>" class="formElement">  </td>
                                 
                             
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >Module1</font> </div></td>
                                 <td> <input id="Module1" name="Module1" type="text" value="<%= currentRecord.getModule1()%>" class="formElement">  </td>
                               
			</tr>
                         
                        <tr>
				<td align="center"><div  align="left"><font size="2" >Module2</font></div>  </td>
                                 <td> <input id="Module2" name="Module2" type="text" value="<%=currentRecord.getModule2()%>" class="formElement">  </td>
                            
                        </tr> 
                        <tr>
				<td align="center"><div  align="left"><font size="2" >Module3 </font> </div></td>
                                <td> <input id="Module3" name="Module3" type="text" value="<%=currentRecord.getModule3()%>" class="formElement">  </td>
                                
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >Module4 </font></div></td>
                                 <td> <input id="Module4" name="Module4" type="text" value="<%=currentRecord.getModule4()%>" class="formElement" >  </td>
                                
			</tr>
                         
                        <tr>
				<td align="center"><div  align="left"><font size="2">Remark</font></div>  </td>
                                   <td> <input id="remark" name="remark" type="text" value="<%= currentRecord.getRemark() %>" class="formElement" >  </td>
                              
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">FT Training </font></div> </td>
                                   <td> <input id="FTTraining" name="FTTraining" type="text" value="<%= currentRecord.getFTTraining() %>" class="formElement" >  </td>
                           
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">Last Training </font></div> </td>
                                   <td> <input id="LastTraining" name="LastTraining" type="text" value="<%=currentRecord.getLastTraining() %>" class="formElement" >  </td>
                           
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">Last Training Date </font></div> </td>
                                <td>
                                   <%
                                   try{
                                        if( currentRecord.getLastTrainingDate() == null || currentRecord.getLastTrainingDate().equals("")  ){
                                   %>
                                    <input id="LastTrainingDate" name="LastTrainingDate" type="text" value="NA"  > 
                                   <%    }else{     %>
                                   <input id="LastTrainingDate" name="LastTrainingDate" type="text" value="<%=currentRecord.getLastTrainingDate()  %>" class="formElement" >  
                                   <%} 
                                   }catch (Exception e){
                                  
                                   System.out.println("Exception::"+e);
                                   } %>
                                   </td>
                        </tr> 
                        
<tr>
<td><input type="submit" value="Submit" >
</td></tr>
                        
                        
 		
     <%
 		}
 	else
{
%>
                         <tr>
				<td align="left"><input type="hidden" id="driverid" name="driverid"  value="<%=driverId%>"><div align="left"><font size="2" >Driver Name  </font></div></td>
                                <td>
				<input id="drivername" name="drivername" type="text" value="<%= currentRecord.getDriverName() %>" class="formElement">
				  </td>
			</tr>
			<tr>
				<td align="center"><div  align="left"><font size="2" >Driver's Father Name </font></div></td>
                                <td>
				<input id="driverfather" name="driverfather" type="text" value="<%=currentRecord.getDriverFatherName()%>" class="formElement">
    </td>
			</tr>
                         
                        <tr>
				<td align="center"><div align="left"><font size="2" >Transporter </font></div> </td>
                               <td>
			<input id="Transporter" name="Transporter" type="text" value="<%=currentRecord.getTransporter() %>" class="formElement">
		  </td>
                        </tr> 
                        <tr>
				<td align="center"><div  align="left"><font size="2">DOB </font> </div></td>
                                <td><input id="DOB" name="dob" type="text" value=" " class="formElement">   </td>
			</tr>
                        
			<tr>
				<td align="center"><div  align="left"><font size="2" >License Number </font></div></td>
                                
                                <td> <input id="licenceno" name="licenceno" type="text" value="" class="formElement" >  </td>
			</tr>
                        
                         <tr>
                        
				<td align="center"><div  align="left"><font size="2">Lisence ExpiryDate  </font></div></td>
                               <td> 
                                <% try{
                               
                             %>

<input type="text" id="licnExpiryDate" name="licnExpiryDate" value="" class="formElement" />
                                 <%
                                }
                                catch(Exception ex)
                                {
                                     %>   <input type="text"  id="licnExpiryDate" name="licnExpiryDate" value=""  > <%
                                
                                }%>  
                               </td>
                        </tr> 
                        <tr>
				<td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
                                  <td> <input id="MedicalExam" name="MedicalExam" type="text" value="" class="formElement">  </td>
                                  
                               
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >MedicalExam ExpiryDate</font></div> </td>
                                 

                                 <td align="center"><input type="text" id="MediclExpDate" name="MediclExpDate" value="" class="formElement">
</td>
 

                                
			</tr>
                         
                        <tr>
				<td align="center"><div align="left"><font size="2" >Place</font></div>  </td>
                                 <td> <input id="Place" name="Place" type="text" value="" class="formElement">  </td>
                             
                        </tr> 
                        <tr>
				<td align="center"><div align="left"><font size="2" >Basic  </font></div></td>
                                 <td> <input id="Basic" name="Basic" type="text" value="" class="formElement">  </td>
                                 
                             
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
                                 <td> <input id="Module1" name="Module1" type="text" value="" class="formElement">  </td>
                               
			</tr>
                         
                        <tr>
				<td align="center"><div  align="left"><font size="2" >Module2 </font></div> </td>
                                 <td> <input id="Module2" name="Module2" type="text" value="" class="formElement">  </td>
                            
                        </tr> 
                        <tr>
				<td align="center"><div  align="left"><font size="2" >Module3 </font></div> </td>
                                <td> <input id="Module3" name="Module3" type="text" value="" class="formElement">  </td>
                                
			</tr>
			<tr>
				<td align="center"><div align="left"><font size="2" >Module4 </font></div></td>
                                 <td> <input id="Module4" name="Module4" type="text" value="" class="formElement" >  </td>
                                
			</tr>
                         
                        <tr>
				<td align="center"><div  align="left"><font size="2">Remark</font></div>  </td>
                                   <td> <input id="remark" name="remark" type="text" value="" class="formElement" >  </td>
                              
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">FT Training </font></div></td>
                                   <td> <input id="FTTraining" name="FTTraining" type="text" value="" class="formElement" >  </td>
                           
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">Last Training </font></div> </td>
                                   <td> <input id="LastTraining" name="LastTraining" type="text" value="" class="formElement" >  </td>
                           
                        </tr> 
                         <tr>
				<td align="center"><div align="left"><font size="2">Last Training Date </font></div> </td>
                                <td>
                                   <%
                                   try{
                                        if( currentRecord.getLastTrainingDate() == null || currentRecord.getLastTrainingDate().equals("")  ){
                                   %>
                                    <input id="LastTrainingDate" name="LastTrainingDate" type="text" value="NA"  > 
                                   <%    }else{     %>
                                   <input id="LastTrainingDate" name="LastTrainingDate" type="text" value="" class="formElement" >  
                                   <%} 
                                   }catch (Exception e){
                                  
                                   System.out.println("Exception::"+e);
                                   } %>
                                   </td>
                        </tr> 
                        
<tr><td><input type="submit" value="Submit" >
</td></tr>
<%		
}
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

<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>





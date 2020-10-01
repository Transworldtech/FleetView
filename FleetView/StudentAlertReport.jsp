 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <script language="javascript">

</script>


<%!
Connection con1;
%>



<% 
try {
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
	Statement stmt1=con1.createStatement();
	Statement stmt2=con1.createStatement();
	Statement stmt3=con1.createStatement();
	String user=session.getValue("usertypevalue").toString();

	String inorout=request.getParameter("inorout");
	String studid=request.getParameter("studid");
	String data=request.getParameter("data");
	
	String data1=request.getParameter("data1");
	System.out.println(data+"--------"+data1);
	java.util.Date dte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String today=formatter.format(dte);
	Format formatter11 = new SimpleDateFormat("dd-MMM-yyyy");
	String today11=formatter11.format(dte);
/*	if(data.equalsIgnoreCase("null")||null==data||"null".equalsIgnoreCase(data)){
		System.out.println(data+"-gdfhdfhfdh-------"+data1);
	}else{*/
/*		if(!(null==request.getParameter("data"))){
		data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
		data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
		
		}
		else{
			data=data1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		} */
	System.out.println(data+"--------"+data1);
	//}
%>
		
		<form action="" method="get" name="inoutdetails" onSubmit="return validate();">
		<table border="0" width="100%" class="stats">
  		      <tr>
		        <td> <div align="center"> <font size="3"> <b> Student Check In/Check Out Report</b> </font> </div> </td>
		    </tr>
		    </table>
		    <table border="0" width="100%" class="sortable_entry">
			<tr>
				<td  align="center"><b>Check IN/OUT : </b>
					<select name="inorout"	id="inorout">
						<option value="ALL">ALL</option>
						<option value="IN">IN</option>
						<option value="OUT">OUT</option>
					</select> &nbsp;&nbsp;&nbsp;&nbsp;
				
				<align="right"><b>Student:</b>
					<select name="studid" id="studid">
						<option value="ALL">ALL</option>
						<%
						String sql2="select Distinct(StudentID) as id from t_studentdetails order by StudentID ";
						ResultSet rs2=stmt2.executeQuery(sql2);
						while(rs2.next()){
							%>
							<option value="<%=rs2.getString("id")%>"><%=rs2.getString("id")%></option>
							<%
						}
						%>
						
					</select>&nbsp;&nbsp;&nbsp;&nbsp;
				
				<align="right"><b>From&nbsp;&nbsp;</b>
			  		<input type="text" id="data" name="data" value="<%=today11%>" size="15" readonly/>&nbsp;&nbsp;&nbsp;&nbsp;
			  			<script type="text/javascript">
			  				Calendar.setup(
			    			{
			      			inputField  : "data",         // ID of the input field
			      			ifFormat    : "%d-%b-%Y",     // the date format
			      			button      : "data"       // ID of the button
			    			}
  							);	
						</script>
  				
					<align="right"><b>To&nbsp;&nbsp;</b>
			  		<input type="text" id="data1" name="data1" value="<%=today11%>"  size="15" readonly/>
			  			<script type="text/javascript">
			  				Calendar.setup(
			    			{
			      			inputField  : "data1",         // ID of the input field
			      			ifFormat    : "%d-%b-%Y",    // the date format
			      			button      : "data1"       // ID of the button
			    			}
			  				);
						</script>
			  	</td>
				<td align="center">
					<input type="submit" name="submit" id="submit" value="submit" >
				</td>			
			</tr>
		</table>
	</form>
			<%
			if(!(null==request.getParameter("data")))
			{
				
			
			%>	<br></br>
					<table border="1" width="100%" class="sortable">	
  		     				<tr>
  		     					<td class="hed"><b>Sr. No</b></td>
  		     					<td class="hed"><b>VehNo</b></td>
  		     					<td class="hed"><b>Student</b></td>
  		     					<td class="hed"><b>Card ID</b></td>
  		     					<td class="hed"><b>School</b></td>
  		     					<td class="hed"><b>Date</b></td>
  		     					<td class="hed"><b>Location</b></td>
  		     					<td class="hed"><b>In/Out</b></td>
  		     					<td class="hed"><b>Status</b></td>
  		     					<td class="hed"><b>Recipient Number</b></td>
  		     					<td class="hed"><b>sendID</b></td>
  		     					
  		     				</tr>
  							
  							<%
  							String sql="";String cardid="";
  							int i=1;
  							//out.println(inorout);
  							if(studid!="ALL"){
  							String sqlCardID="select * from t_studentdetails where StudentID='"+studid+"'";
  							ResultSet rsCardID=stmt3.executeQuery(sqlCardID);
  							if(rsCardID.next()){
  								cardid=rsCardID.getString("CardID");
  							}
  							}
  							if("ALL".equalsIgnoreCase(studid) && "All".equalsIgnoreCase(inorout)){
  								sql="select * from t_studentalertdetails where Date between '"+data+"' and '"+data1+"'";
  							}else if(("IN".equalsIgnoreCase(inorout)||"OUT".equalsIgnoreCase(inorout)) && "ALL".equalsIgnoreCase(studid)){
  								sql="select * from t_studentalertdetails where Date between '"+data+"' and '"+data1+"' and inputtype='"+inorout+"'";
  							}else if (studid!="ALL" && "All".equalsIgnoreCase(inorout)){
  								sql="select * from t_studentalertdetails where Date between '"+data+"' and '"+data1+"' and StudentID='"+cardid+"'";
  							}else if(studid!="ALL" && ("IN".equalsIgnoreCase(inorout)||"OUT".equalsIgnoreCase(inorout))){
  								sql="select * from t_studentalertdetails where Date between '"+data+"' and '"+data1+"' and StudentID='"+cardid+"' and inputtype='"+inorout+"'";
  							}else{
  								sql="select * from t_studentalertdetails";
  							}
  							//out.println(sql);
  							ResultSet rs1=stmt1.executeQuery(sql);
  							
  							while(rs1.next())
  							{
  							String studentname="",studentid="",School="",date="",time="",vehno="",Location="",status="",SendNumber="",InOut="",sendID="";
  								String sql1="select * from t_studentdetails where CardID='"+rs1.getString("studentid")+"'";
  							ResultSet rs3=stmt2.executeQuery(sql1);
  							if(rs3.next()){
  							studentname=rs3.getString("StudentName");
  							School=rs3.getString("School");
  							}
  							
  							studentid=rs1.getString("StudentID");
  							date=rs1.getString("Date");
  							time=rs1.getString("Time");
  							vehno=rs1.getString("VehNo");
  							Location=rs1.getString("Location");
  							sendID=rs1.getString("sendID");
  							if(sendID.equalsIgnoreCase("No number found to send SMS!!")){
  								status="Not Sent";
  							}else{
  								status="Sent";
  							}
  							
  							SendNumber=rs1.getString("SendNumber");
  							InOut=rs1.getString("inputtype");
  							%>
  							   <tr>
  							    <td><%=i%></td>
  		     					<td><%=vehno%></td>
  		     					<td><%=studentname%></td>
  		     					<td><%=studentid%></td>
  		     					<td><%=School%></td>
  		     					<td><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></td>
  		     					<td><%=Location%></td>
  		     					<td><%=InOut%></td>
  		     					<td><%=status%></td>
  		     					<td><%=SendNumber%></td>
  		     					<td><%=sendID%></td>
  		     				</tr>
  							<%
  							i++;}
  							
			
  							%>
  							
  						
    					
</table>
 
<%} } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
	<% //fleetview.closeConnection(); %>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>


</body>
</html>

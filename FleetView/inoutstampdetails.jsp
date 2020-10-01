<%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <script language="javascript">
 function gotoPrint(divName)  
 {  
 	  
 	  var printContents = document.getElementById(divName).innerHTML; 
 	  var originalContents = document.body.innerHTML; 
 	  document.body.innerHTML = printContents;  
 	  window.print();
 	  document.body.innerHTML = originalContents;  
 }

 
 
 function gotoExcel(elemId, frmFldId)  
 {  

          
//            alert("HI>>>>>>");
     
           var obj = document.getElementById(elemId);  
           var oFld = document.getElementById(frmFldId); 
           oFld.value = obj.innerHTML;  

//             alert("11111");

            try{
              document.inoutdetails.action ="excel.jsp";

//             alert("222222");
           document.forms["inoutdetails"].submit();
//          alert("33333");

         document.inoutdetails.action="";
            }catch(e){
            	
//             	alert("exception>>>"+e);
            	}

 } 

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
	Statement stmt4=con1.createStatement();
	Statement stmt5=con1.createStatement();
	Statement stmt6=con1.createStatement();
	Statement stmt7=con1.createStatement();
	Statement stmt8=con1.createStatement();
	Statement stmt9=con1.createStatement();
	Statement stmt10=con1.createStatement();
	Statement stmt11=con1.createStatement();
	Statement stmt12=con1.createStatement();
	Statement stmt13=con1.createStatement();
	Statement stmt14=con1.createStatement();
	Statement stmt15=con1.createStatement();
	String busno2="";
	String busno3="",sql5="",sql7="",sql14="",sql16="",sql1="",sql4="";
	String user=session.getValue("usertypevalue").toString();
	System.out.println("VALUE OF USRTYPEVALUE IN INOUTSTAMPDETAILS"+user);
	String user1=session.getAttribute("usertypevalue").toString();
	System.out.println("VALUE OF USRTYPEVALUE in Attribute"+user);
	if(user.equalsIgnoreCase("Managing Director"))
	{
		user="Test";
		
	}
	java.util.Date d=new java.util.Date();
	String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	String inorout=request.getParameter("inorout");
	System.out.println("VALUE OF inorout"+inorout);
	String studid=request.getParameter("studid");
	System.out.println("VALUE OF STUDID"+studid);
	String busno1=request.getParameter("busno");
	System.out.println("Value of busno is"+busno1);
	String data=request.getParameter("data");
	System.out.println("VALUE OF DATA "+data);
	String data21=data+" "+"00:00:00";
	
	String data1=request.getParameter("data1");
	String data31=data1+" "+"23:59:59";
	System.out.println("VALUE OF DATA1 "+data1);
	java.util.Date dte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String today=formatter.format(dte);
	Format formatter11 = new SimpleDateFormat("dd-MMM-yyyy");
	String today1=formatter11.format(dte);
	if(!(null==data)){
	data=formatter.format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
	data1=formatter.format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
// 	Format formatter12 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
// 	String data22=formatter12.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data21));
// 	System.out.println("vLAUE OF data22 "+data22);
// 	String data32=formatter12.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data31));
// 	System.out.println("vLAUE OF data22 "+data32);
	
	
// 	  data21=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data21));
// 	 System.out.println("vLAUE OF data22 "+data21);
// 	  data31=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data31));
// 	 System.out.println("vLAUE OF data32 "+data32);
		
	}
%>
		
		<form action="" method="post" name="inoutdetails" id="inoutdetails" onSubmit="return validate();">
		
                           	
		<table border="0" width="100%" class="sortable_entry">
  		      <tr> 
		        <td style="text-align: center; margin-left: 80em;" colspan="6"> <div align="center"> <font size="3"> <b> Students IN/OUT Details</b> </font> </div> </td>
		    </tr>
			<tr>
			  <td  align="right"><b>Bus No</b>
					<select name="busno" id="busno">
					<option value="ALL">ALL</option>
					<%
// 					String sql90="select Distinct(Busno) as busno from t_studentdetails where Transporter ='"+user+"'order by StudentID";
					String sql90="select  distinct(Busno) from db_gps.t_studentdetails where Transporter = '"+user+"' order by Busno Asc;";
					ResultSet rs=stmt14.executeQuery(sql90);
					System.out.println("Query for bus"+sql90);
		            while(rs.next())
		            {
		            	busno2=rs.getString("busno");
		            	if(busno2.equals(""))
		            	{
		            		
		            	}else if(busno2.equals("-"))
		            	{
		            		
		            	}
		            	else
		            	{
		            	
		            	%>
						<option value="<%=busno2%>"><%=busno2%></option>
						<%
					}
		            }
		            	
		            
					
					
					
					%>
						
					</select>
				</td>
				<td  align="right"><b>IN/OUT</b>
					<select name="inorout"	id="inorout">
						<option value="ALL">ALL</option>
						<option value="IN">IN</option>
						<option value="OUT">OUT</option>
					</select>
				</td>
				<td  align="right"><b>Student Id</b>
					<select name="studid" id="studid">
						<option value="ALL">ALL</option>
						<%
// 						String sql2="select Distinct(StudentID) as id from t_studentdetails where  Transporter='"+user+"' order by StudentID ";
						String sql2="select Distinct(StudentID) as id from t_studentdetails where Transporter ='"+user+"'order by StudentID ";
//                           String sql2="select Distinct(StudentID) as id from t_studentdetails order by StudentID ";
						ResultSet rs2=stmt1.executeQuery(sql2);
						System.out.println("FIRST QUERY"+sql2);
						while(rs2.next()){
							%>
							<option value="<%=rs2.getString("id")%>"><%=rs2.getString("id")%></option>
							<%
						}
						%>
						
					</select>
				</td>
				<td align="right"><b>From&nbsp;&nbsp;</b>
			  		<input type="text" id="data" name="data" value="<%=today1%>" size="15" readonly/>
			  			<script type="text/javascript">
			  				Calendar.setup(
			    			{
			      			inputField  : "data",         // ID of the input field
			      			ifFormat    : "%d-%b-%Y",     // the date format
			      			button      : "data"       // ID of the button
			    			}
  							);	
						</script>
  				</td>
	
				<td align="right"><b>To&nbsp;&nbsp;</b>
			  		<input type="text" id="data1" name="data1" value="<%=today1%>"  size="15" readonly/>
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
				<td>
					<input type="submit" name="SUBMIT" id="SUBMIT" value="submit" >
				</td>			
			</tr>
		</table>
			<%
	
	 String exportFileName="InOutStampdetailReport.xls";  
	
	%>
		
		
		
		<br></br>
				<div align="right">
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a>  
				   
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style:none; "></img></a>
                           
				
				
				<div class="bodyText"  style="text-align: right;">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           </div>
				</div>
				
	</form>
				
				<div id="table1">
		
	
	
					<table border="1" width="100%" class="sortable">	
					
					
  		     				<tr>
  		     					<td class="hed"><b>Srno</b></td>
  		     					<td class="hed"><b>Student ID</b></td>
  		     					<td class="hed"><b>StudentName</b></td>
  		     					<td class="hed"><b>School</b></td>
  		     					<td class="hed"><b>Bus No</b></td>
  		     					<td class="hed"><b>IN/OUT Date</b></td>
  		     					<td class="hed"><b>Status</b></td>
  		     					<td class="hed"><b>In/Out</b></td>
  		     					<td class="hed"><b>location</b></td>
  		     				</tr>
  							
  							<%
  							
  							
  							String sql="";
//   							if("ALL".equalsIgnoreCase(studid) && "All".equalsIgnoreCase(inorout) && "ALL".equalsIgnoreCase(busno1))
  							if("ALL".equalsIgnoreCase(studid) && "All".equalsIgnoreCase(inorout))		
  							{
  								System.out.println("inside the all block");
  								System.out.println("Value of bus no"+busno1);
  								if((!busno1.equals("ALL"))||(!(busno1.equalsIgnoreCase("ALL")))) 
  								{
  									System.out.println("inside the busno block");
// 	                        		String sql91= "select * from db_gps.t_studentdetails as a,db_gps.t_inoutstudent as b where a.busno='"+busno1+"' and a.CardID=b.cardRefNo and concat(b.date,' ',b.time) between '"+data21+"' and '"+data31+"'";	
// 	                        		String sql91= "select * from db_gps.t_studentdetails as a,db_gps.t_inoutstudent as b where a.busno='7' and b.serverstatus='IN' and  b.ownername='Vikas_Gold Crest'and a.CardID=b.cardRefNo and b.date between '2014-11-03' and '2014-11-03'";
                                    String sql91= "select * from db_gps.t_studentdetails as a,db_gps.t_inoutstudent as b where a.busno='"+busno1+"' and  ownername='"+user+"' and a.CardID=b.cardRefNo and b.date between '"+data+"' and '"+data1+"'"; 
	                        		System.out.println("IN this IF Blockkkkkkkkkkkkkkkkk");
	   	  							 ResultSet rs8=stmt15.executeQuery(sql91);
	   	  							 System.out.println("query for in  or out"+sql91);
	   	  						     int i=1;
	   	  						     while(rs8.next())
  	  							   {
	   	  						       String studentname="",School="",studentid="";
	   	  						       studentname=rs8.getString("StudentName");
	  	  							   School=rs8.getString("School");
	  	  						       studentid=rs8.getString("StudentID");
	  	  						       busno3=rs8.getString("Busno");
	  	  						       String	date=rs8.getString("date");
		  	  							String	time=rs8.getString("time");
		  	  							String	vehno=rs8.getString("vehno");
		  	  							String	alert=rs8.getString("alert");
		  	  							String	status=rs8.getString("serverstatus");
		  	  							String	location=rs8.getString("location");
		  	  							%>
	  	  							   <tr>
	  	  							    <td><div align="right"><%=i%></div></td>
	  	  		     					<td><div align="left"><%=studentid%></div></td>
	  	  		     					<td><div align="left"><%=studentname%></div></td>
	  	  		     					<td><div align="left"><%=School%></div></td>
	  	  		     					<td><div align="right"><%=busno3%></div></td>
	  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
	  	  		     					<td><div align="left"><%=alert%></div></td>
	  	  		     					<td><div align="left"><%=status%></div></td>
	  	  		     					<td><div align="left"><%=location%></div></td>
	  	  		     					
	  	  		     					
	  	  		     				</tr>
	  	  		     				<%
  	  							i++;
  	  							
	   	  						    	
  	  							    } 
	                        	
	                        	}else{	
  									
  									
  									
  									
  								sql="select * from t_inoutstudent where date between '"+data+"' and '"+data1+"' and  ownername='"+user+"'  order by concat(date,time) DESC ";
  								
  	  							ResultSet rs1=stmt2.executeQuery(sql);
  	  						    System.out.println("Second Query"+sql);
  	  							int i=1;
  	  							
  	  							while(rs1.next())
  	  							{
  	  							    String studentname="",studentid="",School="",date="",time="",vehno="",alert="",status="",location="";
  	  							   
  	  								 sql1="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"'";
  	  							   
  	  								
//   	  						    String sql1="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"'";	
									ResultSet rs3=stmt3.executeQuery(sql1);
									System.out.println("QUERYYY WHICH M LOOKING FOR"+sql1);
		  	  						if(rs3.next()){
  	  							    studentname=rs3.getString("StudentName");
  	  								School=rs3.getString("School");
  	  							    studentid=rs3.getString("StudentID");
  	  							    busno3=rs3.getString("Busno");
  	  							}
  	  							
//   	  						studentid=rs1.getString("cardRefNo");
  	  					    System.out.println("Card id which m looking for"+studentid);	
  	  					    date=rs1.getString("date");
							time=rs1.getString("time");
							vehno=rs1.getString("vehno");
							alert=rs1.getString("alert");
							status=rs1.getString("serverstatus");
							location=rs1.getString("location");
  	  							%>
  	  							   <tr>
  	  							    <td><div align="right"><%=i%></div></td>
  	  		     					<td><div align="left"><%=studentid%></div></td>
  	  		     					<td><div align="left"><%=studentname%></div></td>
  	  		     					<td><div align="left"><%=School%></div></td>
  	  		     					<td><div align="right"><%=busno3%></div></td>
  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
  	  		     					<td><div align="left"><%=alert%></div></td>
  	  		     					<td><div align="left"><%=status%></div></td>
  	  		     					<td><div align="left"><%=location%></div></td>
  	  		     					
  	  		     					
  	  		     				</tr>
  	  							<%
  	  							i++;
  	  							
  	  							}
  								
	                        	}
  							}
//   							else if(("IN".equalsIgnoreCase(inorout)||"OUT".equalsIgnoreCase(inorout)) && "ALL".equalsIgnoreCase(studid) && (!("ALL".equalsIgnoreCase(busno1))))
	                         else if(("IN".equalsIgnoreCase(inorout)||"OUT".equalsIgnoreCase(inorout)) && "ALL".equalsIgnoreCase(studid))
  							{
	                        	if((!busno1.equals("ALL"))||(!(busno1.equalsIgnoreCase("ALL")))) 
	                        	{
// 	                        		String sql91= "select * from db_gps.t_studentdetails as a,db_gps.t_inoutstudent as b where a.busno='"+busno1+"' and a.CardID=b.cardRefNo and concat(b.date,' ',b.time) between '"+data21+"' and '"+data31+"'";	
// 	                        		String sql91= "select * from db_gps.t_studentdetails as a,db_gps.t_inoutstudent as b where a.busno='7' and b.serverstatus='IN' and  b.ownername='Vikas_Gold Crest'and a.CardID=b.cardRefNo and b.date between '2014-11-03' and '2014-11-03'";
                                    String sql91= "select * from db_gps.t_studentdetails as a,db_gps.t_inoutstudent as b where a.busno='"+busno1+"' and serverstatus='"+inorout+"' and  ownername='"+user+"' and a.CardID=b.cardRefNo and b.date between '"+data+"' and '"+data1+"'"; 
	                        		System.out.println("IN this IF Blockkkkkkkkkkkkkkkkk");
	   	  							 ResultSet rs8=stmt15.executeQuery(sql91);
	   	  							 System.out.println("query for in  or out IF BLOCK WHICh m lookin for "+sql91);
	   	  						     int i=1;
	   	  						     while(rs8.next())
  	  							    {
	   	  						       String studentname="",School="",studentid="";
	   	  						       studentname=rs8.getString("StudentName");
	  	  							   School=rs8.getString("School");
	  	  						       studentid=rs8.getString("StudentID");
	  	  						       busno3=rs8.getString("Busno");
	  	  						       String	date=rs8.getString("date");
		  	  							String	time=rs8.getString("time");
		  	  							String	vehno=rs8.getString("vehno");
		  	  							String	alert=rs8.getString("alert");
		  	  							String	status=rs8.getString("serverstatus");
		  	  							String	location=rs8.getString("location");
		  	  							%>
	  	  							   <tr>
	  	  							    <td><div align="right"><%=i%></div></td>
	  	  		     					<td><div align="left"><%=studentid%></div></td>
	  	  		     					<td><div align="left"><%=studentname%></div></td>
	  	  		     					<td><div align="left"><%=School%></div></td>
	  	  		     					<td><div align="right"><%=busno3%></div></td>
	  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
	  	  		     					<td><div align="left"><%=alert%></div></td>
	  	  		     					<td><div align="left"><%=status%></div></td>
	  	  		     					<td><div align="left"><%=location%></div></td>
	  	  		     					
	  	  		     					
	  	  		     				</tr>
	  	  		     				<%
  	  							i++;
  	  							
	   	  						    	
  	  							    } 
	                        	
	                        	}else
	                        	{	
	                        		System.out.println("IN ELSE BLOCK WHICH M LOOKING FOR");
  								     sql4="select * from t_inoutstudent where date between '"+data+"' and '"+data1+"' and serverstatus='"+inorout+"' and  ownername='"+user+"' order by concat(date,time) DESC";
	                        	
  								System.out.println("IN this Blockkkkkkkkkkkkkkkkk");
  	  							ResultSet rs1=stmt4.executeQuery(sql4);
  	  							System.out.println("query for in  or out sql 44"+sql4);
  	  							int i=1;
  	  							
  	  							while(rs1.next())
  	  							{
  	  							String studentname="",School="",studentid="";
  	  						    
  	  						    	 sql5="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"'";
  	  						     ResultSet rs3=stmt5.executeQuery(sql5);
  	  							if(rs3.next()){
  	  							studentname=rs3.getString("StudentName");
  	  							
  	  							School=rs3.getString("School");
  	  						    studentid=rs3.getString("StudentID");
  	  						    busno3=rs3.getString("Busno");
  	  						   
  	  							}
//   	  						String	studentid=rs1.getString("studentid");
  	  							String	date=rs1.getString("date");
  	  							String	time=rs1.getString("time");
  	  							String	vehno=rs1.getString("vehno");
  	  							String	alert=rs1.getString("alert");
  	  							String	status=rs1.getString("serverstatus");
  	  							String	location=rs1.getString("location");
  	  							%>
  	  							   <tr>
  	  							    <td><div align="right"><%=i%></div></td>
  	  		     					<td><div align="left"><%=studentid%></div></td>
  	  		     					<td><div align="left"><%=studentname%></div></td>
  	  		     					<td><div align="left"><%=School%></div></td>
  	  		     					<td><div align="right"><%=busno3%></div></td>
  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
  	  		     					<td><div align="left"><%=alert%></div></td>
  	  		     					<td><div align="left"><%=status%></div></td>
  	  		     					<td><div align="left"><%=location%></div></td>
  	  		     					
  	  		     					
  	  		     				</tr>
  	  							<%
  	  							i++;
  	  							
  	  							}
  							}
  	  							
  							}
// 	                         else if (studid!="ALL" && "All".equalsIgnoreCase(inorout) && ((!("ALL".equalsIgnoreCase(busno1))|| "ALL".equalsIgnoreCase(busno1))) )
  								else if (studid!="ALL" && "All".equalsIgnoreCase(inorout) && (!studid.equalsIgnoreCase("ALL")))
  							{
  								String sql11="select DISTINCT(CardID) from t_studentdetails where StudentID='"+studid+"' order by updatedDateTime DESC";
  								System.out.println("quuery which m looking for in else block"+sql11);
  								System.out.println("in another blockkkkkkkkkkkkk");
  	  							ResultSet rs11=stmt6.executeQuery(sql11);
  	  							while(rs11.next()){
  	  							String sql6="select * from t_inoutstudent where date between '"+data+"' and '"+data1+"' and cardRefNo='"+rs11.getString("CardID")+"' and  ownername='"+user+"' order by concat(date,time) DESC";
  	  							//out.println(sql);
  	  							System.out.println("query in another blockkkkkkkkkkkkk "+sql6);
  	  							ResultSet rs1=stmt7.executeQuery(sql6);
  	  							int i=1;
  	  							
  	  							while(rs1.next())
  	  							{
  	  							String studentname="",School="",studentid="";
  	  							if(busno1.equals("ALL")||(busno1.equalsIgnoreCase("ALL"))||(busno1=="ALL"))
  	  							{
  	  							sql7="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"'";
  	  							}
  	  							else
  	  							{
  	  							sql7="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"' and Busno='"+busno1+"'";
  	  							}
  	  							
  	  							ResultSet rs3=stmt8.executeQuery(sql7);
  	  							if(rs3.next()){
  	  								studentname=rs3.getString("StudentName");
  	  								School=rs3.getString("School");
  	  							    studentid=rs3.getString("studentid");
  	  							    busno3=rs3.getString("Busno");
  	  							}
//   	  						    	studentid=rs1.getString("studentid");
  	  							String	date=rs1.getString("date");
  	  							String	time=rs1.getString("time");
  	  							String	vehno=rs1.getString("vehno");
  	  							String	alert=rs1.getString("alert");
  	  							String	status=rs1.getString("serverstatus");
  	  							String	location=rs1.getString("location");
  	  							
  	  							
  	  							
  	  							%>
  	  							   <tr>
  	  							    <td><div align="right"><%=i%></div></td>
  	  		     					<td><div align="left"><%=studentid%></div></td>
  	  		     					<td><div align="left"><%=studentname%></div></td>
  	  		     					<td><div align="left"><%=School%></div></td>
  	  		     					<td><div align="right"><%=busno3%></div></td>
  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
  	  		     					<td><div align="left"><%=alert%></div></td>
  	  		     					<td><div align="left"><%=status%></div></td>
  	  		     					<td><div align="left"><%=location%></div></td>
  	  		     					
  	  		     					
  	  		     				</tr>
  	  							<%
  	  							i++;
  	  							
  	  							}
  	  							}
  								
  							}else if(studid!="ALL" && ("IN".equalsIgnoreCase(inorout)||"OUT".equalsIgnoreCase(inorout))){
  								String sql12="select DISTINCT(CardID) from t_studentdetails where StudentID='"+studid+"'  order by updatedDateTime DESC";
  								System.out.println(" first query in unitid block"+sql12);
  								System.out.println("in unitid block");
  								ResultSet rs11=stmt9.executeQuery(sql12);
  	  							while(rs11.next()){
  	  								System.out.println("inside while");
  	  							String sql13="select * from t_inoutstudent where date between '"+data+"' and '"+data1+"' and  cardRefNo='"+rs11.getString("CardID")+"' and serverstatus='"+inorout+"' order by concat(date,time) DESC";
  	  							System.out.println("query in unitid block"+sql13);
  	  							ResultSet rs1=stmt10.executeQuery(sql13);
  	  							int i=1;
  	  							
  	  							while(rs1.next())
  	  							{
  	  							if(busno1.equals("ALL")||(busno1.equalsIgnoreCase("ALL"))||(busno1=="ALL"))
  	  							{
  	  							 sql14="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"'";	
  	  							}else
  	  							{	
  	  							sql14="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"' and Busno='"+busno1+"'";
  	  							}
  	  							ResultSet rs3=stmt11.executeQuery(sql14);
  	  							if(rs3.next()){
  	  								
  	  							
  	  							String	studentname=rs3.getString("StudentName");
  	  						     busno3=rs3.getString("Busno");
  	  							String	studentid=rs3.getString("studentid");
  	  							String	School=rs3.getString("School");
  	  							String	date=rs1.getString("date");
  	  							String	time=rs1.getString("time");
  	  							String	vehno=rs1.getString("vehno");
  	  						    String	alert=rs1.getString("alert");
  	  							String	status=rs1.getString("serverstatus");
  	  							String	location=rs1.getString("location");
  	  							
  	  							
  	  							
  	  							%>
  	  							   <tr>
  	  							    <td><div align="right"><%=i%></div></td>
  	  		     					<td><div align="left"><%=studentid%></div></td>
  	  		     					<td><div align="left"><%=studentname%></div></td>
  	  		     					<td><div align="left"><%=School%></div></td>
  	  		     					<td><div align="right"><%=busno3%></div></td>
  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
  	  		     					<td><div align="left"><%=alert%></div></td>
  	  		     					<td><div align="left"><%=status%></div></td>
  	  		     					<td><div align="left"><%=location%></div></td>
  	  		     					
  	  		     					
  	  		     				</tr>
  	  							<%
  	  							i++;
  	  							}
  	  							}
  	  							}
  							
  							}else{
  								String sql15="select * from t_inoutstudent where date between '"+today+"' and '"+today+"' order by concat(date,time) DESC";
  								System.out.println("in else block");
  								System.out.println("Query in else block"+sql15);
  	  							ResultSet rs1=stmt12.executeQuery(sql15);
  	  							int i=1;
  	  							
  	  							while(rs1.next())
  	  							{
  	  							String studentname="",School="",studentid="";
  	  						
  	  						 sql16="select * from t_studentdetails where CardID='"+rs1.getString("cardRefNo")+"' and Transporter='"+user+"'";
  	  						
  	  						
  	  								
  	  							ResultSet rs3=stmt13.executeQuery(sql16);
  	  							if(rs3.next()){
  	  								studentname=rs3.getString("StudentName");
  	  								School=rs3.getString("School");
  	  							studentid=rs3.getString("studentid");
  	  						    busno3=rs3.getString("Busno");
  	  							}
//   	  								studentid=rs1.getString("studentid");
  	  							String	date=rs1.getString("date");
  	  							String	time=rs1.getString("time");
  	  							String	vehno=rs1.getString("vehno");
  	  							String	alert=rs1.getString("alert");
  	  							String	status=rs1.getString("serverstatus");
  	  							String	location=rs1.getString("location");
  	  						    
  	  							
  	  							
  	  							
  	  							%>
  	  							   <tr>
  	  							    <td><div align="right"><%=i%></div></td>
  	  		     					<td><div align="left"><%=studentid%></div></td>
  	  		     					<td><div align="left"><%=studentname%></div></td>
  	  		     					<td><div align="left"><%=School%></div></td>
  	  		     					<td><div align="right"><%=busno3%></div></td>
  	  		     					<td><div align="right"><%=date%>&nbsp;&nbsp;&nbsp;<%=time%></div></td>
  	  		     					<td><div align="left"><%=alert%></div></td>
  	  		     					<td><div align="left"><%=status%></div></td>
  	  		     					<td><div align="left"><%=location%></div></td>
  	  		     					
  	  		     					
  	  		     				</tr>
  	  							<%
  	  							i++;
  	  							
  	  							}
  	  							}
  						
  						
  							
  							
  							%>
  						
  						
   					
</table>
  </div>	
<% } catch(Exception e) { out.println("Exception----->" +e); }
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


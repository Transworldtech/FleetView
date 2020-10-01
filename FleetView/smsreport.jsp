<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.SMSDetails"  
		import="com.transworld.fleetview.framework.Utilities"%>
		
		
<jsp:useBean id="vehicleDao" type="com.transworld.fleetview.framework.VehicleDao" scope="application"></jsp:useBean>

<%@ include file="headernew.jsp" %>

<%@page import="javax.swing.text.NumberFormatter"%>
			<script language="javascript">
			var renderStart = new Date().getTime();
			window.onload=function() { 
			var renderEnd=new Date().getTime();
			var elapsed = new Date().getTime()-renderStart;   
			var PageName = document.getElementById("PageName").value;
				try{var ajaxRequest;
				try{ajaxRequest = new XMLHttpRequest();	}
					catch (e)
					{
					try
					{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
					catch (e)
					{try
					{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
					catch (e)
					{alert("Your browser broke!");
					return false;
					}}}
					ajaxRequest.onreadystatechange = function()
					{if(ajaxRequest.readyState == 4)
					{try
					{var reslt=ajaxRequest.responseText;
					var result1;
					result1=reslt;
					result1=result1.replace(/^\s+|\s+$/g,'');
					if(result1=="Updated")
					{}
					}catch(e)
					{alert(e);
					}}};		 
					var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
					ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
					ajaxRequest.send(null); 
					}
					   catch(e)
					{
						alert(e);
					}  
			};

			
			
 			function validate()
  			{
  				if(document.getElementById("data").value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById("data1").value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  			   	}
  				return datevalidate();
  		    }
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dd1=date1.substring(0,4);
			dd2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dy1=date1.substring(8,10);
			dy2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dy1>dy2)
			{
				alert("From date year is should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2) if(dm1>dm2)
			{
				alert("From date month is should not be greater than to date month 5");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dm1==dm2) 
			{
				if(dd1 > dd2)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			return true;
		}

  	</script>
  	
  	<body>
  	
  	

<%!

String date1=null, date2=null,datenew1,datenew2,sql,owner,from;
String dateformat,transporter;
String Transporter;
%>
<%

//if(!(null==request.getQueryString()))
//{
	

	datenew1=request.getParameter("data");
	datenew2=request.getParameter("data1");
	//String transporter = request.getParameter("transporter");
	String typeOfUser=session.getAttribute("usertypevaluemain").toString();
	//out.println("---------typeofuser----> "+typeOfUser);
	//dateformat=session.getAttribute("dateformat").toString();
	//String owner=session.getAttribute("usertypevalue").toString();
//}


if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
}
else
{
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
}

try
{
	
	//session.setAttribute("reportno","Report No:13.0");
	//session.setAttribute("reportname","SMS Report");
	//session.setAttribute("date1",date1);
	//session.setAttribute("date2",date2);
	
	//session.setAttribute("transporter",transporter);
	//System.out.println("transporter---> "+ transporter);
	
	
	
%>
<form action="" method="get" name="smsreport" onSubmit="return validate();">
			<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort">
			<!-- <div align="left"><font size="3">Report No:13.0</font></div>-->
			<font color="block" size="3" ><b></>NDAuthorisedReport</b></font>
			
			<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printsmsreport.jsp?data=<%=date1%>&data2=<%=date2%>&transporter=<%=transporter %>');" title="Print SMS Report"><img src="images/print.jpg" width="15px" height="15px"></a>
&nbsp; &nbsp; <a href="excel_smsreport.jsp?data=<%=date1%>&data2=<%=date2%>&transporter=<%=transporter %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
			<%=Utilities.printDate() %></div></td>
			</tr>
			<tr><td>
			
			
			<table border="0" width="100%">
			<form action="" method="get">
			<tr bgcolor="#87CEFA">
			<!--<td> 
	      	 <font color="maroon" size="2"><b> Transporter: </b> </font> </td>
				<td> 
						<select name="transporter">
						<option value="All">All</option>
							
							<%
							
						/*	final List<GroupDetails> list=null;
							int numRecords = 0;
							try{
							
								list = vehicleDao.getGroupDetails(transporter);
								 numRecords = list.size();
								 
							} catch(Exception e){
								e.printStackTrace();
							}
							
							
							
							try{
								for(int counter=0;counter<numRecords;counter++)
								{
									GroupDetails groupRecord=list.get(counter);
									Transporter=groupRecord.getVehicleRegistrationNumber();*/
							%>
									<option value="< %=Transporter%>">< %=Transporter %></option>
							<% 	/*}
							
						}catch (Exception e) 
								{
									System.out.print("Exception"+e);
								} */
	%>
						
						</select>				
				
				</td>
			  --><td align="right"><b>From&nbsp;&nbsp;</b>
			  <input type="text" id="data" name="data" value="<%=datenew1 %>" size="15" readonly/>
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
			  	<input type="text" id="data1" name="data1" value="<%=datenew2 %>"  size="15" readonly/>
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
				<input type="submit" name="submit" id="submit" value="submit" >
			</td>
		</tr>
		</form>
		</table>
		
		</td></tr>
			
			</table>
			<table width="100%" border="1" align="center" class="sortable">
	
				<th> <b> Sr. </b></th>
				<th> <b>Transporter</b></th>
				<th> <b>NDRequest</b></th>
				<th> <b>Intimation</b></th>
		
		
		
				<%	
				 List<SMSDetails> smsList=null;
				int recordCount = 0;
				try{
					//System.out.println("Helloooooooo");
					smsList = vehicleDao.getsmsDetails(typeOfUser,date1,date2);
					recordCount = smsList.size();
					//System.out.println("recordCount---> "+recordCount);
					
					 
				} catch(Exception e){
					e.printStackTrace();
				}
				
				int i=0;
				for(int count=0;count<recordCount;count++)
				{
					SMSDetails currentRecord=smsList.get(count);
					i=count+1;
					%>
					<tr>
					<td style=" text-align: left"><%= i %></td>
					<td style=" text-align: left"><%= currentRecord.getTransporter() %></td>
					<%
					if ("0".equalsIgnoreCase(currentRecord.getNdRequest()))
					{%>
							
						<td><div align="left">0</div></td>			 
					<% 
					}
					else
					{
					%>
					<td style=" text-align: left"><a href="count.jsp?transporter=<%=currentRecord.getTransporter()%>&date1=<%=date1%>&date2=<%=date2%>&cg=ND"><%= currentRecord.getNdRequest() %></a></td>
					
					<%
					}
					
					if("0".equalsIgnoreCase(currentRecord.getIntimation()))
					{%>
					
					<td><div align="left">0</div></td>			 
				<% 
				}
				else
				{	
				%>
				<td style=" text-align: left"><a href="count.jsp?transporter=<%=currentRecord.getTransporter()%>&date1=<%=date1%>&date2=<%=date2%>&cg=IT"><%=currentRecord.getIntimation()%></a></td>
				</tr>
			<%
				}
				}
					
				
					
						}catch(Exception e)
							{
							 	out.print("Exception::"+e);
							}
				
				
				



%>
	</table>
<%@ include file="footernew.jsp" %>

<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script type="text/javascript">

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
	      
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.ComplaintReport.action ="excel.jsp";
          document.forms["ComplaintReport"].submit();
} 

function allSelected(allVal)
{
	if(document.customdetail.extAll.checked) 
	{
		document.getElementById("frmDT").style.display='none';
    	document.getElementById("toDT").style.display='none';
    }
	else 
	{
		document.getElementById("frmDT").style.display="";
    	document.getElementById("toDT").style.display="";
	}
}

function getFTPImage(ftpFile)
{    // var wbsite="";
	try
	{
		//alert(escape(ftpFile));
		//alert(ftpFile);
		window.open('showComplaintFTP.jsp?ftpFile='+ftpFile+'','mywindow','width=500, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)
	{
		alert(e);
	}
}
</script>

<%

		String fname=(String)session.getAttribute("fname");
		 String lname=(String)session.getAttribute("lname");
		 String Name=fname+" "+lname;
		 String UserTypeValue=(String)session.getAttribute("usertypevalue1");
		
String datenew1="";
String datenew2="";
String statVal = "";
String chbxAll = "";
String catval = "";

if(request.getParameter("data")!=null)
{
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
  
   statVal = request.getParameter("incidentDrp");
   chbxAll = request.getParameter("extAll");
   catval = request.getParameter("category");
   System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>"+chbxAll);
}
else
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}

		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2));

		if(request.getQueryString() != null){
			
			String Status = "";
			if(statVal.equals("Solved") || statVal == "Solved")
			{
				Status = "Closed";
			}else if(statVal.equals("All") || statVal == "All")
			{
				Status = "All";
			}else
			{
				Status = "Open";
			}
			
			System.out.println("Status ===>"+Status);
			System.out.println("chbxAll ===>"+chbxAll);
			
			if(chbxAll != null)
			{
				System.out.println("==in if=");
				%>
				<div style="font-size: 1.3em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
					<%= Status %> Complaints Report
				</div>
				<%
				
			}else{
				System.out.println("==in else=");
				%>
				<div style="font-size: 1.3em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
					<%= Status %> Complaints Report for <%= datenew1%> to <%= datenew2%>
				</div>
				<%
			}
			
			
		}else{
			%>
			<div style="font-size: 1.3em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
				Complaint Report
			</div>
			<%
		}
	
	
	
		%>	
	
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="customdetail" method="get">
<%System.out.println("\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");%>
  
		<table align="center" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
				<td align="left"><font color="#F75D59" size="2">Pending</font>&nbsp;&nbsp;&nbsp;<font color="#4CC417" size="2">Solved</font></td>
				<td></td><td></td><td></td>
				<td align="left"><b>Complaints&nbsp;&nbsp;</b>
				<select name="incidentDrp" id="incidentDrp" style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
			 		
			 	<%if(statVal != null) { 	
				%><option value="All">All</option><%
			}else{
				 %><option value="All" selected>All</option><%
				 %><option value="Pending">Pending</option><%
				 %><option value="Solved">Solved</option><%
				
			}
			if(statVal != null)
			{
				if(statVal.equals("Pending") || statVal == "Pending") {	
					 %><option value="Pending" selected>Pending</option><%
					}else{System.out.println("in else s");
						 %><option value="Pending">Pending</option><%
					}
				
				if(statVal.equals("Solved")) {		
					 %><option value="Solved" selected>Solved</option><%
					}else{
						 %><option value="Solved">Solved</option><%
					}
			}	
		     %> 
			    </select>
				</td>
				<td align="left"><b>Priority&nbsp;&nbsp;</b>
				<select name="category" id="category"  style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
				   
				   	
			 	<%if(catval != null) { 	
				%><option value="All">All</option><%
			}else{
				 %><option value="All" selected>All</option><%
				 %><option value="High">High</option><%
				 %><option value="Low">Low</option><%
				
			}
			if(catval != null)
			{
				if(catval.equals("High") || catval == "High") {	
					 %><option value="High" selected>High</option><%
					}else{System.out.println("in else s");
						 %><option value="High">High</option><%
					}
				
				if(catval.equals("Low")) {		
					 %><option value="Low" selected>Low</option><%
					}else{
						 %><option value="Low">Low</option><%
					}
			}%>
			 		
			    </select>
				</td>
				<td></td>
				<td>
				All <input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected(this.value);"></input>
				</td>
				<td></td>
				<td id="frmDT" align="left" style="display:''"><b>From&nbsp;&nbsp;</b>
					<input type="text" id="data" name="data" size="12" value="<%=datenew1%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>
				</td>
				
				<td id="toDT" align="left" style="display:''"><b>To&nbsp;&nbsp;</b>
					<input type="text" id="data1" name="data1" size="12" value="<%=datenew2%>" 
					style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
					<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>&nbsp;&nbsp;&nbsp;
			 	 
				</td>
				<td><input type="submit" name="button" value="Go"></td>
			</tr>
		</table>
		

</form>
</div>

<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em; width: 120%" align="center">
<form name="ComplaintReport" name="ComplaintReport" action="" method="post">
<div id="table1">
<%! Connection conn=null;%>
<%
try
{
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
	    String exportFileName=session.getAttribute("mainuser").toString()+"_ComplaintReport.xls"; 
%>
		<table border="0" width="100%" align="center" class="stats">
		<tr>
		<td>
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
		</td>
		</tr>
		</table>
        <%
        int i=0;
		String sqlData="",DD="";
		
		
        String pri = "";
       
        
        if(catval == null || catval.equalsIgnoreCase("null") || catval == "All" || catval.equals("All"))
        {
        	pri = " and Priority in ('High','Low')";
        }
        else
        {
        	pri = " and Priority ='"+catval+"'";
        }

        
        
        
		if(chbxAll!=null && chbxAll!="")
		{
			if(statVal=="All" || statVal.equals("All"))
			{
        		if(UserTypeValue.equalsIgnoreCase("ALL"))
        		{
        			sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail  where Website = 'FleetView' "+pri+" order by ComplaintDateTime";
        		}
     		   else
       		   {
        			sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where Name='"+Name+"' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
        	   }
		   }
			else
			{
				if(UserTypeValue.equalsIgnoreCase("ALL"))
		        {
					System.out.println(UserTypeValue);
					if(statVal=="Solved" || statVal.equals("Solved"))
					{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail  where  Status = 'Closed'  and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        		
					}else
					{
						sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail  where  Status <> 'Closed'  and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
					}
		        }
		        else
		        {
		        	System.out.println(UserTypeValue);
		        	if(statVal=="Solved" || statVal.equals("Solved"))
		        	{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where Name='"+Name+"' and Status = 'Closed' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        	}else
		        	{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where Name='"+Name+"' and Status <> 'Closed' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        	}
		        }
			}
		}
		
		
		else if(statVal!=null && statVal!="")
		{
			System.out.println("**************************>>"+statVal);
			if(statVal=="All" || statVal.equals("All"))
			{
				if(UserTypeValue.equalsIgnoreCase("ALL"))
		        {
		        	sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail  where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59'  and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        }
		        else
		        {
		        	sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Name='"+Name+"' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        }
			}
			else 
			{
				if(UserTypeValue.equalsIgnoreCase("ALL"))
		        {
					System.out.println(UserTypeValue);
					if(statVal=="Solved" || statVal.equals("Solved"))
		        	{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail  where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Status = 'Closed' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        	}else
		        	{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail  where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Status <> 'Closed' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        	}
		        }
		        else
		        {
		        	if(statVal=="Solved" || statVal.equals("Solved"))
		        	{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Name='"+Name+"' and Status = 'Closed'  and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        	}else
		        	{
		        		sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Name='"+Name+"' and Status <> 'Closed'  and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
		        	}
		        }
			}
		}
		else
		{
			if(UserTypeValue.equalsIgnoreCase("ALL"))
	        {
	        	sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
	        }
	        else
	        {
	        	sql="select ComplaintID,ComplaintDateTime,Description,Website,ReportName,Category,Priority,Transporter,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber,Closeddatetime,FileName from db_gps.t_ComplaintDetail where ComplaintDateTime between '"+dataDate1+" 00:00:00' and '"+dataDate2+" 23:59:59' and Name='"+Name+"' and Website = 'FleetView' "+pri+" order by ComplaintDateTime";
	        }
		}
		
		
	
        System.out.println(sql);
        %>
        <table width="100%" align="center"><tr><td>
		<table align="center" class="sortable">
		<tr>
		<%
		if(statVal=="All" || statVal.equals("All") || statVal=="Solved" || statVal.equals("Solved"))
		{
		%>
		<th><div align="center"><font size="2" ><b>Sr. No.</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Complaint ID</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Complaint Date Time</b></font></div></th>
		<th><div align="center" style="width: 100%;" ><font size="2"><b>Description</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Website</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Report Name</b></font></div></th>
		<th><div align="center"><font size="2"><b>Category</b></font></div></th>
		<th><div align="center"><font size="2"><b>Priority</b></font></div></th>
		<th><div align="center"><font size="2"><b>Transporter</b></font></div></th>
		<th><div  align="center"><font size="2"><b>Email ID</b></font></div></th>
		<th><div align="center"><font size="2"><b>Contact Number</b></font></div></th>
		<th><div align="center"><font size="2"><b>Entered By</b></font></div></th>
		<th><div align="center"><font size="2"><b>Status</b></font></div></th>
		<th><div align="center"><font size="2"><b>Closed Date Time</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Closing Comments</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Closed By</b></font></div></th>
		<th><div style="width: 20px;" align="center"><font size="2" ><b>FileName</b></font></div></th>
		<%
		}
		else
		{
			%>
		<th><div align="center"><font size="2" ><b>Sr. No.</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Complaint ID</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Complaint Date Time</b></font></div></th>
		<th><div align="center" style="width: 100%;" ><font size="2"><b>Description</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Website</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Report Name</b></font></div></th>
		<th><div align="center"><font size="2"><b>Category</b></font></div></th>
		<th><div align="center"><font size="2"><b>Priority</b></font></div></th>
		<th><div align="center"><font size="2"><b>Transporter</b></font></div></th>
		<th><div align="center"><font size="2"><b>Email ID</b></font></div></th>
		<th><div align="center"><font size="2"><b>Contact Number</b></font></div></th>
		<th><div align="center"><font size="2"><b>Entered By</b></font></div></th>
		<th><div align="center"><font size="2"><b>Status</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Closing Comments</b></font></div></th>
		<th><div align="center"><font size="2" ><b>Closed By</b></font></div></th>
		<th><div style="width: 20px;" align="center"><font size="2" ><b>FileName</b></font></div></th>
			
			<%
			}
		%>
		</tr>
		<%
        rst=st.executeQuery(sql);
        while(rst.next())
        {
        	
        	if(rst.getString("Status").equalsIgnoreCase("Closed"))
			{
        		i++;
        		//System.out.println("Solved "+rst.getString("Status"));
					%><tr>
					 <td align="right"  style="background-color: #AEF8B1;"><div align="right"><font size="2" ><%= i%></font></div></td>
          			<td align="right"  style="background-color: #AEF8B1;"><div align="right"><font size="2" ><%= rst.getString("ComplaintID")%></font></div></td>
          			<%
          			if(rst.getString("ComplaintDateTime") == null || rst.getString("ComplaintDateTime").equalsIgnoreCase("null"))
          			{
          				%>
          					<td align="right"  style="background-color: #AEF8B1;" sorttable_customkey="20080211131900"><div align="right"><font size="2" >-</font></div></td>
          				
          				<%
          			}
          			else
          			{
          				%>
          				 <td align="right"  style="background-color: #AEF8B1;" sorttable_customkey="20080211131900"><div align="right"><font size="2" ><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("ComplaintDateTime")))%></font></div></td>
          				
          				<%
          			}
          			%>
          			
		 			 <td align="left"  style="background-color: #AEF8B1; width: 180%;"><div align="left"><font size="2" ><%= rst.getString("Description")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1; width: 20%;"><div align="left"><font size="2" ><%= rst.getString("Website")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1; width: 20%;"><div align="left"><font size="2" ><%= rst.getString("ReportName")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("Category")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("Priority")%></font></div></td>
		  		   <td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("Transporter")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left" style="overflow: auto; width: 150px;"><font size="2" ><%= rst.getString("Email1")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("ContactNumber")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("EntBy")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" >Closed</font></div></td>
		  			<%
		  			if(rst.getString("Closeddatetime")==null)
		  			{
		  			%>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" >-</font></div></td>
		  			<%
		  			}
		  			else
		  			{
		  			%>
		  			<td align="right"  style="background-color: #AEF8B1;" sorttable_customkey="20080211131900"><div align="right"><font size="2" ><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("Closeddatetime")))%></font></div></td>
		   			<%} %>
		   			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("ClosingComment")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;"><div align="left"><font size="2" ><%= rst.getString("ClosedBy")%></font></div></td>
		  			<td align="left"  style="background-color: #AEF8B1;width: 20px;">
						 
						<%
						String File = rst.getString("FileName");
						String wbsite = rst.getString("Website");
						File = File+",";
						String  File1=File.substring(File.lastIndexOf("/")+1,File.length());
						String[] token=File1.split(",");
                        String[] token1=File.split(",");
						 for(int k=0; k<token.length; k++)
                		{    
			
                		%>
							 <div align="left" style="overflow: auto;width: 150px;"><font size="2" >				        
					        	<a href="#" style="white-space: normal;" onclick="getFTPImage('<%=token[k]+","+wbsite%>')"><%=token[k]%></a>
							</font></div>					
						<%	
                		}					
						%>
					
			</td>
		  </tr>				
					<%					
			}
			else 
			{
				i++;
				//System.out.println("Pending " +rst.getString("Status"));
				%><tr>
				<td align="right"  style="background-color: #F9966B;"><div align="right"><font size="2" ><%= i%></font></div></td>
          		<td align="right"  style="background-color: #F9966B;"><div align="right"><font size="2" ><%= rst.getString("ComplaintID")%></font></div></td>
          		
          		<%
          			if(rst.getString("ComplaintDateTime") == null || rst.getString("ComplaintDateTime").equalsIgnoreCase("null"))
          			{
          				%>
          					<td align="right"  style="background-color: #F9966B;" sorttable_customkey="20080211131900"><div align="right"><font size="2" >-</font></div></td>
          				
          				<%
          			}
          			else
          			{
          				%>
          				 <td align="right"  style="background-color: #F9966B;" sorttable_customkey="20080211131900"><div align="right"><font size="2" ><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("ComplaintDateTime")))%></font></div></td>
          				
          				<%
          			}
          			%>
          		
          		
          		
		  		
		 		<td align="left"  style="background-color: #F9966B; width: 180%;"><div align="left"><font size="2" ><%= rst.getString("Description")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B; width: 20%;"><div align="left"><font size="2" ><%= rst.getString("Website")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B; width: 20%;"><div align="left"><font size="2" ><%= rst.getString("ReportName")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("Category")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("Priority")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("Transporter")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left" style="overflow: auto;width: 150px;"><font size="2" ><%= rst.getString("Email1")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("ContactNumber")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("EntBy")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" >Open</font></div></td>
		  		<%
		  		if(statVal=="All" || statVal.equals("All"))
		  		{
		  			%>
		  			<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" >-</font></div></td>
		  			<%
		  		}
		  		%>
		   		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("ClosingComment")%></font></div></td>
		  		<td align="left"  style="background-color: #F9966B;"><div align="left"><font size="2" ><%= rst.getString("ClosedBy")%></font></div></td>
		  	
		  		<td align="left"  style="background-color: #F9966B;width: 20px;">
						 
						<%
						String File = rst.getString("FileName");
						String wbsite = rst.getString("Website");
						File = File+",";
						String  File1=File.substring(File.lastIndexOf("/")+1,File.length());
						String[] token=File1.split(",");
                        String[] token1=File.split(",");
						 for(int k=0; k<token.length; k++)
                		{    
			
                		%>
							 <div align="left" style="overflow: auto;width: 150px;"><font size="2" >				        
					        	<a href="#" style="white-space: normal;" onclick="getFTPImage('<%=token[k]+","+wbsite%>')"><%=token[k]%></a>
							</font></div>					
						<%	
                		}					
						%>
					
			</td>
		  	</tr>
				<%
			}
       
          %>
         
        <% }%> 
         
      </table></td></tr></table>
        </div>
         </form>
         </div>
         
         <%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>

</jsp:useBean>
<%@ include file="footernew.jsp" %>	


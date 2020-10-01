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
</script>

<%

		String fname=(String)session.getAttribute("fname");
		 String lname=(String)session.getAttribute("lname");
		 String Name=fname+" "+lname;
		 String UserTypeValue=(String)session.getAttribute("usertypevalue1");
		
String datenew1="";
String datenew2="";
if(request.getParameter("data")!=null)
{
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
}
else
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}

		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dataDate1=df1234.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew1+" 00:00:00"));
		String dataDate2=df1234.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew2+" 23:59:59"));

		%>
		
		<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
	Map Report</div>
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<form name="customdetail" method="get">
<%System.out.println("\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");%>
<%! Connection conn1;%>
<%
try
{
       String CountOpt1="",CountOpt2="",CountOpt3="";
		conn1 = fleetview.ReturnConnection();
		Statement st2=null,st3=null,st4=null;
		String sql1=null;
		ResultSet rst1=null;
		st2=conn1.createStatement();
		st3=conn1.createStatement();
		st4=conn1.createStatement();
		
		sql1="select count(*) countopt1 from db_gps.t_captureopt where optionentered='opt1'";
		 
		 rst1=st2.executeQuery(sql1);
		 System.out.println(sql1);
		   if(rst1.next())
	        {       	CountOpt1=rst1.getString("countopt1");
	        }
		   
		   sql1="select count(*) countopt1 from db_gps.t_captureopt where optionentered='opt2'";
		   rst1=st3.executeQuery(sql1);
			 System.out.println(sql1);
			   if(rst1.next())
		        {       	CountOpt2=rst1.getString("countopt1");
		        }
			 
		   
		   sql1="select count(*) countopt1 from db_gps.t_captureopt where optionentered='opt3'";
		   rst1=st4.executeQuery(sql1);
			 System.out.println(sql1);
			   if(rst1.next())
		        {       	CountOpt3=rst1.getString("countopt1");
		        }
			 
			
		
		
%>
  
  
  <table align="left" cellspacing="10" cellpadding="0" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
  <tr>
  <th >Transworld</th>
  <th>Google</th>
  <th>Not Confirmed</th>
  </tr>
  <tr>
  <td><%= CountOpt1%> </td>
   <td><%= CountOpt2%> </td>
  <td><%= CountOpt3%> </td>
 
  </tr>
   </table>
  <br>
  
  
		<table align="center" cellpadding="0" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">
			<tr>
<!--				<td align="left"><font color="#F75D59" size="2">GooGle</font>&nbsp;&nbsp;&nbsp;<font color="#4CC417" size="2">Tran</font></td>-->
<!--				<td></td><td></td><td></td>-->
				<td align="left"><b>Map Selection &nbsp;&nbsp;</b>
				<select name="mapSelDrp" id="mapSelDrp" 
				style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
			 		<option value="All">All</option>
			 		<option value="opt1">Transworld</option>
			 		<option value="opt2">Google</option>
			 		<option value="opt3">Not Confirmed</option>
			 		
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
					      ifFormat    :	1 	8  "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>&nbsp;&nbsp;&nbsp;
			 	 
				</td>
				<td><input type="submit" name="button" value="Go"></td>
				</tr>
			      <%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
%>
		</table>
		   

</form>
</div>
<br></br>

<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em; width: 120%" align="center">
<form name="ComplaintReport" name="ComplaintReport" action="" method="post">
<div id="table1">
<%! Connection conn;%>
<%
try
{
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
	    String exportFileName=session.getAttribute("mainuser").toString()+"_MapSelectionReport.xls"; 
%>
		<table border="0" cellpadding="0" width="100%" align="center" class="stats">
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
		String sqlData="";
		
		String Mapval=request.getParameter("mapSelDrp");
		String chbxAll=request.getParameter("extAll");
        
		if(chbxAll!=null && chbxAll!="")
		{
			if(Mapval=="All" || Mapval.equals("All"))
			{
        			sql="select * from db_gps.t_captureopt   order by UpdatedDateTime";
        		
		   }
			else
			{
				System.out.println(UserTypeValue);
		        	sql="select * from db_gps.t_captureopt  where  optionentered='"+Mapval+"'  order by UpdatedDateTime";
		      
			}
		}
		else if(Mapval!=null && Mapval!="")
		{
			System.out.println("**************************>>"+Mapval);
			if(Mapval=="All" || Mapval.equals("All"))
			{
					sql="select * from db_gps.t_captureopt  where UpdatedDateTime >= '"+dataDate1+"' and  UpdatedDateTime <= '"+dataDate2+"' order by UpdatedDateTime";
		        
			}
			else 
			{
					System.out.println(UserTypeValue);
		        	sql="select * from db_gps.t_captureopt where UpdatedDateTime >= '"+dataDate1+"' and  UpdatedDateTime <= '"+dataDate2+"' and optionentered='"+Mapval+"'  order by UpdatedDateTime";
		       
			}
		}
		else
		{
			      	sql="select * from db_gps.t_captureopt where UpdatedDateTime >= '"+dataDate1+"' and  UpdatedDateTime <= '"+dataDate2+"' and optionentered='"+Mapval+"'   order by UpdatedDateTime";
	    }
        System.out.println(sql);
        %>
        <table width="100%" align="center"><tr><td>
		<table align="center" class="sortable">
		<tr>
		<%
		%>
		<th><div align="center"><font size="2" ><b>Sr. No.</b></font></div></th>
		<th><div align="left"><font size="2" ><b>User Name</b></font></div></th>
		<th><div align="center"><font size="2" ><b>First Name</b></font></div></th>
		<th><div align="center" style="width: 100%;" ><font size="2"><b>Last Name</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Transporter</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Map</b></font></div></th>
		<th><div align="center"><font size="2"><b>Date/Time</b></font></div></th>
		
		<%
		
		%>
		</tr>
		<%
        rst=st.executeQuery(sql);
        while(rst.next())
        {
        	
        		i++;
        		//System.out.println("Solved "+rst.getString("Status"));
					%><tr>
					 <td align="right"  ><div align="right"><font size="2" ><%= i%></font></div></td>
          			<td align="left"  "><div align="left"><font size="2" ><%= rst.getString("UserName")%></font></div></td>
		  			 <td align="left"   width: 100;"><div align="left"><font size="2" ><%= rst.getString("FirstName")%></font></div></td>
		  			<td align="left"  width: 20%;"><div align="left"><font size="2" ><%= rst.getString("LastName")%></font></div></td>
		  			<td align="left"   width: 20%;"><div align="left"><font size="2" ><%= rst.getString("TypeValue")%></font></div></td>
		  			<%
		  			String SelectedMap;
		  			if(rst.getString("optionentered").equalsIgnoreCase("opt1"))
		  					{
		  				SelectedMap="Transworld";
		  					}
		  				else if(rst.getString("optionentered").equalsIgnoreCase("opt2"))
		  					{
		  				SelectedMap="Google";
		  					}
		  					else {  
  								SelectedMap="Not Confirmed";
  								}
		  			%>
		  			<td align="left"  ><div align="left"><font size="2" ><%= SelectedMap%></font></div></td>
		  			<td align="right" sorttable_customkey="20080211131900"><div align="right"><font size="2" ><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("UpdatedDateTime")))%></font></div></td>
		 					  			<%
		  
       
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
		conn1.close();
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


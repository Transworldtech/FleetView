<%-- 
    Document   : driver_briefing
    Created on : May 20, 2009, 11:47:09 AM
    Author     : Vikram 
    Description: Shows searched Driver for briefing
    Last Modified on: May 18 2010
    Modified by: Ayaz
--%>


<%@ include file="IRTEheader.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<script language="javascript">
function GetDrivers()
{	

//alert("Hi >>>>>>");
	 var count=(document.driverbriefingform.srchbx.value).length+1;
        
	
	 if(count>2)
         {
      		var srchval=document.driverbriefingform.srchbx.value;
		

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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         // alert(reslt);
                           //var mySplitResult = reslt.split("#");
                          //alert(mySplitResult[15]);
                         document.getElementById("driverinfo").innerHTML=reslt;
                                              
                         
		     } 
         	  }
             var queryString = "?srchval=" +srchval;
             //alert("queryString:"+queryString);
	     ajaxRequest.open("GET", "Ajaxgetdrivers.jsp" + queryString, true);
	     ajaxRequest.send(null); 
		
	 }
}

function showtable(i)
{
	document.getElementById("drvrbriefrep").style.display="";

	document.driverbriefingform.drvrname.value=document.getElementById("drvrname"+i).value;	
	document.driverbriefingform.drvrid.value=document.getElementById("drivid"+i).value;
     	
}

function test11()
{
document.driverform.submit();
alert("hi");
}

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
	try{
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.drivertrainingform.action ="excel.jsp";
          document.forms["drivertrainingform"].submit();
	}
	catch(e){
		alert(e);
	}
 }  
</script>

<%!
Connection con1, con2;
String driveridjsp="";

%>

 
<form name="drivertrainingform" id="drivertrainingform" method="get" action="" onSubmit="return validate();" >

<%
try {
    
     

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();
ResultSet rs2=null, rs1=null;

String msg = (String)request.getParameter("msg");
String briefid = (String)request.getParameter("briefId");
String driver= (String)request.getParameter("drivername");

String srchval=request.getParameter("srchbx");
String  exportFileName=session.getAttribute("user").toString()+"_Driver_report.xls";
java.util.Date todaysDate =new java.util.Date();
%>

	<table border="0" bgcolor="white" width="100%">
	   <tr>
		<td>
		    <table border="0" width="100%">
		    <tr><td align="left"><a href='adddriverdetails.jsp' ><font size="2"> <b>Add new driver.</b></font></a> </td> </tr>
			<tr>
			
				<td> <div align="center"> <font size="3"> <B> Driver Training Details </B> </font> </div> </td>
				
			</tr>
			<tr><td>&nbsp;&nbsp;&nbsp;</td>
			</tr>
		    </table>	
	
		    <table class="stats">
			
			<tr>
				<td> <div align="left"><font size="2"> <B> Search </B> </font>&nbsp;&nbsp;&nbsp; 
<input type="text" name="srchbx" class="formElement"  /> &nbsp;&nbsp;&nbsp;
                               <font size="1.5"><input type="submit" value="Submit" name="btnSearch"  class="formElement" />
		Please enter Driver Name or Driver Id. Matching values would come below in the table automatically .
			</font> </div>
                        </td>
			</tr>
		    </table>
		
		    <table class="stats">
                       
		       <tr>
				 <td> <div id="driverinfo"> </div> </td>
			
                        <td>	<div align="right">
				<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
		<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
		
		<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('mytable');">    
 			<img src="images/print.jpg"  width="15px" height="15px" style="border-style: none"></img>
		</a>
 		<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('mytable', 'tableHTML');">
 			<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
 		</a><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(todaysDate)%>
				</div></td>    
                        </tr>
                        
		    </table>
		</td>
	     </tr>
	  </table>	
	  
	  
	  

<%
if(!(srchval==null))
{
 
//shared.TripRatingCal tr = new shared.TripRatingCal();
//tr.tripRating();

String sql1="";String sql2 ="";

//srchval = srchval.replace(" ", "");
int i=1;
String drivname="",fatherName="",DOB="",PassportID="",LicenseNo="", driverid="", trans="";
String briefId = "";
//out.print("<center> <table border='1' width='50%' bgcolor='white' class='stats'><tr> <th> Sr.No.</th> <th> Driver Name</th> <th> Driver Id </th> <th> Transporter </th> </tr>");
%>
<center>
<div id="mytable">

<table border='1' width='50%' bgcolor='white' class='sortable'>
<tr> 
<th> Sr.No.</th>

<th> Passport Id </th> 
<th> Driver Name</th> 
<th> Father Name</th> 
<th> DOB</th> 
<th> License No </th> 

<th> Transporter </th> 
</tr>

<%

sql1="select *  from t_irtedriver where GPName='castrol' and (DriverName like '%"+srchval+"%' or PassportID like '%"+srchval+"%' or rid like '%"+srchval+"%' ) order by  DriverName asc";
ResultSet rs3 = stmt1.executeQuery(sql1);
while(rs3.next())
{
	drivname=rs3.getString("DriverName");
	driverid=rs3.getString("rid");	
	PassportID=rs3.getString("PassportID");	
	fatherName=rs3.getString("fatherName");
//	System.out.println(fatherName);
	DOB=rs3.getString("DOB");
	LicenseNo=rs3.getString("LicenseNo");
	if (fatherName.equals("-")||DOB.equals("-")||LicenseNo.equals("-"))
	{
		String sql3="select * from t_drivertraining where dcode='"+PassportID+"'";
		ResultSet rs4=stmt2.executeQuery(sql3);
		if(rs4.next())
		{
			fatherName=rs4.getString("DriverFatherName");
			DOB=rs4.getString("DOB");
			LicenseNo=rs4.getString("licenceno");
		}
		else
		{
			fatherName="-";
			DOB="-";
			LicenseNo="-";
		}
	}
	
	sql2="select * from t_startedjourney where DriverCode='"+driverid+"'order by StartDate Desc limit 1";
	rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{
		trans=rs2.getString("OwnerName");
	}
	else
	{
		trans=rs3.getString("Owner");
	}
%>
<tr> 
<td style='text-align:right'><%=i %></td>

<td style='text-align:right'><%=rs3.getString("PassportID")%></td>
<%//out.println("passportid--->"+passportid);
		if(rs3.getString("PassportID").equals(""))
		{//out.println("now in if");
		%>
<td style='text-align:left'><a href="briefing/trininginfo2.jsp?driverid=<%=driverid%>&passportid=<%=PassportID%>&father=<%=fatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&drivname=<%=drivname%>" onclick="popWin = open('briefing/trininginfo2.jsp?driverid=<%=driverid%>&passportid=<%=PassportID%>&father=<%=fatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&drivname=<%=drivname%>&transporter=<%=trans %>','myWin','width=900,height=900');popWin.focus();return false" ><%=drivname %></a>  </td>
<%}else
			{
			%>
			<td style='text-align:left'><a href="briefing/trininginfo1.jsp?driverid=<%=driverid%>&passportid=<%=PassportID%>&driverFatherName=<%=fatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&driverName=<%=drivname%>&transporter=<%=trans%>" onclick="popWin = open('briefing/trininginfo1.jsp?driverid=<%=driverid%>&passportid=<%=PassportID%>&driverFatherName=<%=fatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&driverName=<%=drivname%>&transporter=<%=trans %>','myWin','width=900,height=900');popWin.focus();return false" ><%=drivname %></a>  </td>
			<%	
			}%>
			<%
			try{
		if(DOB.equalsIgnoreCase("null"))
		{
			 DOB=DOB;
		}else{
			 DOB=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(DOB));

		}}catch(Exception e)
		{
			e.printStackTrace();
		}
			
			%>
<td style='text-align:left'><%=fatherName%></td>
<td style='text-align:left'><%=DOB%></td>
<td style='text-align:left'><%=LicenseNo%></td>
<td style='text-align:left'><%=trans %></td>
</tr>


<%
	i++;
}
if(   i<=1  ){
    
    out.print("<center> <table border='1' width='50%'><tr> <th> Driver does not exist. </th> </tr>");
    out.print("<center> <table border='1' width='50%'><tr> <th> <a href='adddriverdetails.jsp' >    Please Click here to add the driver.  </a> </th> </tr>");
}
%>
</table></div></center></form>
<% 
}
} catch(Exception e) { 
//System.out.println("Exception:"+e);
out.print("Exception:"+e);
}
finally
{
    
  //System.out.println("..........");  
con1.close();
}
%>

<%@ include file="footernew.jsp" %>

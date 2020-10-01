<%@ include file="headernew.jsp" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
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

function chk()
{
	//alert("Chk");
	
	
	var chkf="";
	var chkt="";
	var objFromDate = document.getElementById("data").value;
	var fdate=objFromDate.split("-");
	if(fdate[1]=="Jan")
	{
		chkf="01";
	}
	if(fdate[1]=="Feb")
	{
		chkf="02";
	}
	if(fdate[1]=="Mar")
	{
		chkf="03";
	}
	if(fdate[1]=="Apr")
	{
		chkf="04";
	}
	if(fdate[1]=="May")
	{
		chkf="05";
	}
	if(fdate[1]=="Jun")
	{
		chkf="06";
	}
	if(fdate[1]=="Jul")
	{
		chkf="07";
	}
	if(fdate[1]=="Aug")
	{
		chkf="08";
	}
	if(fdate[1]=="Sep")
	{
		chkf="09";
	}
	if(fdate[1]=="Oct")
	{
		chkf="10";
	}
	if(fdate[1]=="Nov")
	{
		chkf="11";
	}
	if(fdate[1]=="Dec")
	{
		chkf="12";
	}
	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
    var objToDate = document.getElementById("data1").value;
    var tdate=objToDate.split("-");
    if(tdate[1]=="Jan")
	{
    	chkt="01";
	}
	if(tdate[1]=="Feb")
	{
		chkt="02";
	}
	if(tdate[1]=="Mar")
	{
		chkt="03";
	}
	if(tdate[1]=="Apr")
	{
		chkt="04";
	}
	if(tdate[1]=="May")
	{
		chkt="05";
	}
	if(tdate[1]=="Jun")
	{
		chkt="06";
	}
	if(tdate[1]=="Jul")
	{
		chkt="07";
	}
	if(tdate[1]=="Aug")
	{
		chkt="08";
	}
	if(tdate[1]=="Sep")
	{
		chkt="09";
	}
	if(tdate[1]=="Oct")
	{
		chkt="10";
	}
	if(tdate[1]=="Nov")
	{
		chkt="11";
	}
	if(tdate[1]=="Dec")
	{
		chkt="12";
	}
    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
     
    var date1 = new Date(objFromDate1);
    var date2 = new Date(objToDate1);
    
    //alert("from > "+date1+" Todate > "+date2);
    
    var date3 = new Date();
    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
    var currentDate = new Date(date4);
     
        if(date1 > date2)
        {
            alert("From Date Should be Less Than To Date");
            return false; 
        }
//         else if(date1 > currentDate)
//         {
//             alert("From Date should be less than current date");
//             return false; 
//         }
//         else if(date2 > currentDate) 
//         {
//             alert("To Date should be less than current date");
//             return false; 
//         }

return true;
	
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
	      
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.ComplaintReport.action ="excel.jsp";
          document.forms["ComplaintReport"].submit();
} 


function allSelected(allVal)
{
	//alert("hi");
	
	//alert(document.getElementById("extAll").checked);
	if(document.getElementById("extAll").checked==true) 
		
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


		  		  

	
function birt(){
	
	//alert("Hi");
	//var vehicle1=document.getElementById("vehlist").value;
	//var b=Validate();
	var a=chk();
	
			//alert("GetValid------>"+a);
			if(a==true)
				{
				//alert("hi");
	//var chbk=document.getElementById("extAll").checked;
	//alert(chbk);
	/* if(chbk==true)
	{
		chbk="ALL";
		
	}
    else
	{
			chbk="no";			
	} */
	var user=document.getElementById("user").value;
	user=user.replace(/\../g,' ');
	//alert(user);
	//alert(userid);
	// var sort=document.getElementById("sort").value;
	var date1= document.getElementById("data").value;//dd-MMM-yyyy HH:mm
	var date2= document.getElementById("data1").value;
	//var date2= document.getElementById("date4").value;
	//var date2= document.getElementById("data1").value;
	
		
	//vehicle="2811,3300,6251";
	
	//date1=date1+" 00:00:00";
	//date2=date2+" 23:59:59";
	
//	alert(vehicle);
	//alert(date1);
	//alert(date2);
	var date = date1.split("-");
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	for(var j=0;j<months.length;j++)
	{
	    if(date[1]==months[j])
	    {
	         date[1]=months.indexOf(months[j])+1;
	    }                      
	} 
	if(date[1]<10)
	{
	    date[1]='0'+date[1];
	}                        
	var formattedDate1 = date[2]+'-'+date[1]+'-'+date[0];
	formattedDate1=formattedDate1+" 00:00:00";//yyyy-MM-dd HH:mm:ss
	//alert(date[1]);
	//alert(date[0]);
	
	var dat = date2.split("-");
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	for(var j=0;j<months.length;j++){
	    if(dat[1]==months[j]){
	         dat[1]=months.indexOf(months[j])+1;
	     }                      
	} 
	if(dat[1]<10){
	    dat[1]='0'+dat[1];
	}                        
	var formattedDate2 = dat[2]+'-'+dat[1]+'-'+dat[0];
	formattedDate2=formattedDate2+" 23:59:59";//yyyy-MM-dd HH:mm:ss
	
	//alert(userid);
	//alert(formattedDate1);
	//alert(formattedDate2);
	document.getElementById("myIframe").src="http://103.8.126.138:8080/birttest/frameset?__report=DriverLicenseExpiry.rptdesign&Date1="+formattedDate1+"&Date2="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&usertypevalue="+user+"&__showtitle=false";
//	document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
	document.getElementById("reportData").style.display="";
	//document.getElementById("footer").style.display="none";
	
	return true;
	
				}
			
			else
				{
					return false;
				}
	
	
	
}  
</script>

<%

		String fname=(String)session.getAttribute("fname");
		 String lname=(String)session.getAttribute("lname");
		 String Name=fname+" "+lname;
		 //String UserTypeValue=(String)session.getAttribute("usertypevalue1");
		 String User=session.getAttribute("usertypevalue").toString();
		 User=User.replaceAll(" ", "..");
		 %>

		 <input type="hidden" id="user" name="user" value=<%=User %>>
		   <script type="text/javascript">

		 //alert("user++++"+document.getElementById("user").value);

		 </script>  
		   
		     <% 
String datenew1="";
String datenew2="";
String datenew11="";
String datenew22="";
String datenew111="";
String datenew222="";
if(request.getParameter("data")!=null)
{
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
  System.out.println("DAte------123"+datenew1+"---------Date---------"+datenew2);
}
else
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	System.out.println("DAte------"+datenew1+"---------Date---------"+datenew2);
	datenew11=datenew22=new SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
}

		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String dataDate1=df1234.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew1+" 00:00:00"));
		String dataDate2=df1234.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew2+" 23:59:59"));
		
		%>
		
		<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
		
	</div>
	<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center">
<!-- <form name="customdetail" method="get"> --> 
<%System.out.println("\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");%>
<%! Connection conn1;
String Exp="";
%>
<%


try
{
 
	
// 	String CountOpt1="",CountOpt2="",CountOpt3="";
// 		conn1 = fleetview.ReturnConnection();
// 		Statement st2=null,st3=null,st4=null;
// 		String sql1=null;
// 		ResultSet rst1=null;
		
// 		st2=conn1.createStatement();
// 		st3=conn1.createStatement();
// 		st4=conn1.createStatement();
		
		

// 		String Date1="1980-01-01";
// 		String Date2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
// 		System.out.println("Date 1"+Date1);
		
// 		Calendar cal = Calendar.getInstance();
// 	    cal.add(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
// 	    cal.set(Calendar.DATE, Calendar.SUNDAY);
// 	    Date firstDateOfPreviousMonth = cal.getTime();

// 	    String Date3=new SimpleDateFormat("yyyy-MM-dd").format(firstDateOfPreviousMonth);
// 	    System.out.println("11firstDateOfcurrentsWeek:-"+datenew11);

// 	    cal.add(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
// 	    cal.set(Calendar.DATE, Calendar.SATURDAY);
// 	    Date lastDateOfweek = cal.getTime();
	    /* for(int i=0; i <7;i++){
	    cal.set(Calendar.DATE,firstDateOfPreviousMonth); // changed calendar to cal
	    System.out.println("DATE weekkk  "+cal.set(Calendar.DATE,1););
	    cal.add(Calendar.DATE,1);
	    } */   
	    /* System.out.println("lastDateOfcurrentWeek:-"+lastDateOfweek); */
	   // Date lastDateOfPreviousMonth = cal.getTime();
// 	    String Date4=new SimpleDateFormat("yyyy-MM-dd").format(lastDateOfweek);
// 	    System.out.println("11lastDateOfcurrentWeek:-"+datenew22);
	    
		//String Date3=new SimpleDateFormat("dd-MM-yyyy").format(datenew11);
		//String Date4=new SimpleDateFormat("dd-MM-yyyy").format(datenew22);
		
// 		System.out.println("Date 3"+Date3);
		
// 		Calendar cal13 = Calendar.getInstance();
// 	    cal13.add(Calendar.MONTH, 0);
// 	    cal13.set(Calendar.DATE, 1);
// 	    Date firstDateMonth = cal13.getTime();

// 	    String Date5=new SimpleDateFormat("yyyy-MM-dd").format(firstDateMonth);
// 	    System.out.println("12firstDateOfcurrentsMonth:-"+datenew111);

// 	    cal13.set(Calendar.DATE, cal13.getActualMaximum(Calendar.DATE)); // changed calendar to cal

// 	    Date lastDatePreviousMonth = cal13.getTime();
// 	    String Date6=new SimpleDateFormat("yyyy-MM-dd").format(lastDatePreviousMonth);
// 	    System.out.println("12lastDateOfcurrentMonth:-"+datenew222);
		
	    //String Date5=new SimpleDateFormat("dd-MM-yyyy").format(datenew111);
		//String Date6=new SimpleDateFormat("dd-MM-yyyy").format(datenew222);
		
// 		System.out.println("Date 6"+Date6);
		String user= session.getAttribute("usertypevalue").toString();//its going through session
		System.out.println("TotalDrivers"+user);
	
	String CountOpt2="",CountOpt3="";
		conn1 = fleetview.ReturnConnection();
		Statement st2=null,st3=null,st4=null;
		String sql1=null;
		ResultSet rst1=null;
		
		st2=conn1.createStatement();
		st3=conn1.createStatement();
		st4=conn1.createStatement();
		
		

		String Date1="1980-01-01";
		String Date2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		System.out.println("Date 1"+Date1);
		
		Calendar cal122 = Calendar.getInstance();
	    cal122.add(Calendar.DATE,Calendar.DATE);
	    cal122.set(Calendar.DATE,Calendar.DATE);
	    //String Month1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

	    datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	    String Date3=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	    System.out.println("122firstDateOfcurrentsMonth:-"+datenew1);

		
// 	    cal122.set(Calendar.DATE,Calendar.DATE);
// 	    cal122.add(Calendar.DATE,); // changed calendar to cal
Calendar cal = Calendar.getInstance();
   System.out.println("The current date is :---------------------- " + cal.getTime());
   // add 20 days to the calendar
   cal.add(Calendar.DATE, 7);
   System.out.println("7 days later:--------------------------------------------- " + cal.getTime());

	    Date lastMonth = cal.getTime();
 String Date4=new SimpleDateFormat("yyyy-MM-dd").format(lastMonth);
		
		
		System.out.println("Date 3-----"+Date3);
		System.out.println("Date 4-----"+Date4);
		//sql1="select count(*) countopt1 from db_gps.t_captureopt where optionentered='opt1'";
		//sql1="SELECT count(if( NextServiceDate<now(),1,NULL)) as count,(count(if(nextservicedate <DATE_ADD(CURDATE(), INTERVAL 7 DAY),1,NULL))-count(if( NextServiceDate<now(),1,NULL))) as cd from db_gps.t_lastservice WHERE alertstatus<>'closed' and transporter='"+session.getValue("usertypevalue").toString()+"'"; 
		
// 		sql1="SELECT count(*) as count from db_gps.t_lastservice where NextServiceDate between '"+Date1+"' and '"+Date2+"' and alertstatus<>'closed' and transporter='"+session.getAttribute("usertypevalue")+"'";
// 		 rst1=st2.executeQuery(sql1);
// 		 System.out.println(sql1);
// 		   if(rst1.next())
// 	        {       	CountOpt1=rst1.getString("count");
// 	                  //  CountOpt2=rst1.getString("cd");
	                    
// 	                    System.out.println("Count----------1"+CountOpt1);
// 	        }
// 		   sql1="SELECT count(*) as count1 from db_gps.t_lastservice where NextServiceDate between '"+Date3+"' and '"+Date4+"' and alertstatus<>'closed' and transporter='"+session.getAttribute("usertypevalue")+"'";
// 			 rst1=st2.executeQuery(sql1);
// 			 System.out.println(sql1);
// 			   if(rst1.next())
// 		        {       	CountOpt2=rst1.getString("count1");
// 		                  //  CountOpt2=rst1.getString("cd");
		                    
// 		                    System.out.println("Count----------2"+CountOpt2);
// 		        }
  sql1="select count(driverid) as Count2 from db_gps.t_drivers where (gpname  = '"+session.getAttribute("usertypevalue")+"'or owner='"+session.getAttribute("usertypevalue")+"') and activestatus='Active' and licenseexpdate >='"+Date1+"' and licenseexpdate<='"+Date2+"'";
			 rst1=st2.executeQuery(sql1);
			 System.out.println(sql1);
			   if(rst1.next())
		        {       	CountOpt2=rst1.getString("Count2");
		                  //  CountOpt2=rst1.getString("cd");
		                    
		                    System.out.println("Count----------2"+CountOpt2);
		        }
				 sql1=" select count(*) as Count3 from db_gps.t_drivers where (gpname='"+session.getAttribute("usertypevalue")+"' or owner='"+session.getAttribute("usertypevalue")+"') and activestatus='Active' and licenseexpdate >='"+Date3+"' and licenseexpdate<='"+Date4+"'";
				 rst1=st2.executeQuery(sql1);
				 System.out.println(sql1);
				   if(rst1.next())
			        {       	CountOpt3=rst1.getString("Count3");
			                  //  CountOpt2=rst1.getString("cd");
			                    
			                    System.out.println("Count----------3"+CountOpt3);
			        }
// 			   sql1="SELECT count(*) as count2 from db_gps.t_lastservice where NextServiceDate between '"+Date5+"' and '"+Date6+"' and alertstatus<>'closed' and transporter='"+session.getAttribute("usertypevalue")+"'";
// 				 rst1=st2.executeQuery(sql1);
// 				 System.out.println(sql1);
// 				   if(rst1.next())
// 			        {       	CountOpt3=rst1.getString("count2");
// 			                  //  CountOpt2=rst1.getString("cd");
			                    
// 			                    System.out.println("Count----------3"+CountOpt3);
// 			        }
		   /* sql1="select count(*) countopt1 from db_gps.t_captureopt where optionentered='opt2'";
		   rst1=st3.executeQuery(sql1);
			 System.out.println(sql1);
			   if(rst1.next())
		        {       	//CountOpt2=rst1.getString("countopt1");
		        }
			 
		   
		   sql1="select count(*) countopt1 from db_gps.t_captureopt where optionentered='opt3'";
		   rst1=st4.executeQuery(sql1);
			 System.out.println(sql1);
			   if(rst1.next())
		        {       	CountOpt3=rst1.getString("countopt1");
		        } */
			 
			
			   
%>
  <tr>
  <table border="0" width="100%" align="center" >
		<tr>
		<td colspan="8" align="center">
		<table style="margin-left:30px ">
		<tr>
		<td>
		<font face="Arial" color="black" size="4" ><b>Driver License Expiry Report</b></font>
		</td>
		</tr>
		
		</table>
		</tr>
  <table align="left" cellspacing="10" cellpadding="0" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em">

 
    <tr>
  <th>Expired </th>
  <th>7 Days </th> 
  </tr>
  <tr>
 
    <td><a href="Licenseexpiryreport.jsp?value=Expired"><%=CountOpt2%> </a></td> 
  <td><a href="Licenseexpiryreport.jsp?value=7"><%= CountOpt3%> </a></td> 
    </tr>
   </table><br><br>
  
  
  
		<table align="center" cellpadding="0" border="0" style="text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 11.1em">
			<tr>
<!--				<td align="left"><font color="#F75D59" size="2">GooGle</font>&nbsp;&nbsp;&nbsp;<font color="#4CC417" size="2">Tran</font></td>-->
<!--				<td></td><td></td><td></td>-->
				<!-- <td align="left"><b>Map Selection &nbsp;&nbsp;</b>
				<select name="mapSelDrp" id="mapSelDrp" 
				style="width: 87px; height:20px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
			 		<option value="All">All</option>
			 		<option value="opt1">Transworld</option>
			 		<option value="opt2">Google</option>
			 		<option value="opt3">Not Confirmed</option>
			 		
			    </select>
				</td> -->
				<td></td>
				<!-- <td>
				All <input type="checkbox" name="extAll" id="extAll"   onclick="allSelected(this.value);"></input>
				</td> -->
				<%
				
				try{
					
				
				String Expired=request.getParameter("value");

				System.out.println("Month---"+Expired);
				if(Expired.equals("Expired"))
				{
					System.out.println("Month---1111111"+Expired);
					datenew1="01-Jan-1980";
					datenew11="1980-01-01";
					datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
					System.out.println("Month---1111111"+Expired);
					String Dat17=datenew11;
					System.out.println("Month---1111111"+Dat17);
					String Dat18=new SimpleDateFormat("yyyy-MM-dd").format(datenew2);
					
					
					System.out.println("Date 777"+Dat17);
					
				} 
				//System.out.println("Monthiiiiii---"+Expired);
				 String week=request.getParameter("ThisWeek"); 
				 System.out.println("Month---"+week);
				 
				 if(Expired.equals("Week"))
				{
					System.out.println("Month---"+Expired);
					Calendar cal110 = Calendar.getInstance();
				    cal110.add(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
				    cal110.set(Calendar.DATE, Calendar.SUNDAY);
				    Date firstDateOfPrevious = cal110.getTime();

				    datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(firstDateOfPrevious);
				    System.out.println("110firstDateOfcurrentsWeek:-"+datenew1);

				    cal110.add(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
				    cal110.set(Calendar.DATE, Calendar.SATURDAY);
				    Date lastDateweek = cal110.getTime();
				    /* for(int i=0; i <7;i++){
				    cal.set(Calendar.DATE,firstDateOfPreviousMonth); // changed calendar to cal
				    System.out.println("DATE weekkk  "+cal.set(Calendar.DATE,1););
				    cal.add(Calendar.DATE,1);
				    } */   
				    /* System.out.println("lastDateOfcurrentWeek:-"+lastDateOfweek); */
				    Date DateOfPreviousMonth = cal110.getTime();
				    datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(lastDateweek);
				    System.out.println("110lastDateOfcurrentWeek:-"+datenew2);
				} 
				 
				 if(Expired.equals("7"))
					{
						System.out.println("Month---"+Expired);
						Calendar cal12 = Calendar.getInstance();
					    cal122.add(Calendar.MONTH, 0);
					    cal122.set(Calendar.DATE, 1);
					    //String Month1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

					    datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
					    System.out.println("122firstDateOfcurrentsMonth:-"+datenew1);

// 					    cal122.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE)); // changed calendar to cal

// 					    Date lastMonth = cal122.getTime();
// 					    datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(lastMonth);
// 					    System.out.println("122lastDateOfcurrentMonth:-"+datenew2);
					    Calendar cal1 = Calendar.getInstance();
					    System.out.println("The current date is ROOOOOOOOOOOOOOOOOOOOOOOOOOOHHHHHHHHHHHHTTTTTTTTT: " + cal1.getTime());


					       cal1.add(Calendar.DATE, 7);
					       System.out.println("20 days later: " + cal1.getTime());
					    					    Date lastMonth1 = cal1.getTime();
					    					    datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(lastMonth1);
					    					    System.out.println("122lastDateOfcurrentMonth:-"+datenew2);

					} 
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
				%>
				<td></td>
				<td align="left"  style="display:''"><b> From&nbsp;&nbsp;</b>
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
				<td><input type="submit"  name="button" value="Submit" onclick="birt()"></td>
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
		   

<!--  </form> --> 

</div>
<br></br>

<div align="right">
<tr><td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		</tr></div>
		
		<%
		DateFormat df12345=new SimpleDateFormat("yyyy-MM-dd");
		String dtt=datenew1;
		String dtt1=datenew2;
		System.out.println("Dtae New For onload dtt "+dtt+"-------------"+dtt1);
		String dataDate12=df12345.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew1+" 00:00:00"));
		String dataDate123=df12345.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datenew2+" 00:00:00"));
		 //String Date3=df12345.format(dtt);
		 String User1=session.getAttribute("usertypevalue").toString();
		// User1=User1.replaceAll(" ", "..");
		// User1=User1.replace("/../g"," ");
		 //user=user.replace("/\../g"," ");
		 System.out.println("Date------------------3>"+dataDate12);
		 System.out.println("Date------------------4>"+dataDate123);
		 System.out.println("User1------------------3>"+User1);
			
				
				
				
				
				
				
		%>
		 <div id="reportData1">		
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=DriverLicenseExpiry.rptdesign&Date1=<%=dataDate12 %>&Date2=<%=dataDate123%>&dt=<%=datenew1%>&dt1=<%=datenew2%>&usertypevalue=<%=User1 %>&__showtitle=false">
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe> 
</div>   <% 
		String Expired1=request.getParameter("value");
		String datenew11111="1980-01-01";
		String User2=session.getAttribute("usertypevalue").toString();
		String datenew22222=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		System.out.println("Expired Date---"+User2+"----------"+datenew22222+"========"+datenew11111);
		
			//System.out.println("Expired Date---"+User2+"----------"+datenew22222+"========"+datenew11111);
				%>
					<%-- <div id="reportData1">
							
			<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=VehMaintenanceDue_report.rptdesign&Date1==<%=datenew11111%>&Date2=<%=datenew22222%>&User=<%=User2%>&__showtitle=false">
				
				<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
				</iframe> 
			</div>   --%>
					<%
		
					 
		
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
%>
		
<div id="reportData">		
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")))%>&date2=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")))%>&drivername=<%= request.getParameter("trNm1")%>";> --%>
	<iframe id="myIframe" width='100%' height='650px' src="">
	</iframe> 
</div>

<%
		}
%>

<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em; width: 120%" align="center">
<form name="ComplaintReport" name="ComplaintReport" action="" method="post">
<div id="table1">
<%! Connection conn;%>
<%-- <%
try
{
       
		conn = fleetview.ReturnConnection();
		Statement st=null,st1=null;
		String sql=null;
		ResultSet rst=null;
		st=conn.createStatement();
		st1=conn.createStatement();
	    String exportFileName=session.getAttribute("mainuser").toString()+"_MapSelectionReport.xls"; 
%> --%>
		<%-- <table border="0" cellpadding="0" width="100%" align="center" class="stats">
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
		</table> --%>
        <%-- <%
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
		custtype	if(Mapval=="All" || Mapval.equals("All"))
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
        %> --%>
        <!-- <table width="100%" align="center"><tr><td>
		<table align="center" class="sortable">
		<tr> -->
		<%
		%>
		<!-- <th><div align="center"><font size="2" ><b>Sr. No.</b></font></div></th>
		<th><div align="left"><font size="2" ><b>User Name</b></font></div></th>
		<th><div align="center"><font size="2" ><b>First Name</b></font></div></th>
		<th><div align="center" style="width: 100%;" ><font size="2"><b>Last Name</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Transporter</b></font></div></th>
		<th><div  style="width: 20%;" align="center"><font size="2" ><b>Map</b></font></div></th>
		<th><div align="center"><font size="2"><b>Date/Time</b></font></div></th> -->
		
		<%-- <%
		
		%> --%>
		<!-- </tr> -->
		<%-- <%
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
         
        <% }%>  --%>
         
      </table></td></tr></table>
        </div>
         </form>
         </div>
         
         <%-- <%
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
%> --%>

</jsp:useBean>
<%-- <%@ include file="footernew.jsp" %> --%>	

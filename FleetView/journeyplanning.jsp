<%@ include file="headerpopup.jsp"%>
<%@page import="java.util.Date"%>
<%!
Connection conn,con;
Statement s,s1,s2,s3,sevent,st3,st4;
String routeid;
%>
<html>
<head>

	<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<!-- <link rel="stylesheet" href="calendar/main.css"> -->

<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script>
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>


<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}

</style>
<style>
#ctrip {visibility:hidden;}

</style>
<script>

</script>
<script>

function Reload()
{
	window.location.reload();
}


function updatevalues1(id,flag10)
{
// 	alert("fffff");
	//var date1 = document.getElementById("MdateF").value;
// 	alert("ketki ");
// 	alert("id:= "+id);
	
	var flag5 ;
// 	alert("flag10 :-  "+flag10);
	flag5 = flag10 ; 
	
// 	alert("the flag5 value after assigning from flag10 :- "+flag5);
	
	
	if(flag5=="correct")
	{
		var date1 = document.getElementById("MdateF").value;	
	}
	
	var tripid = document.getElementById("tripid").value;
//      alert(tripid);	
//      alert("Gawande");
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		// Opera 8.0+, Firefox, Safari
// 		alert("the flag5 XXX :- "+flag5);
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			alert(reslt);
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			alert(reslt);
			alert("the flag5 yyy :- "+flag5);
			
			if(reslt=="Greater than database date")
				{
				 alert("Selected date should be Greater than Tripdate");
				 alert("result is :- "+reslt+" "+flag5);
				 
				 flag5 = "error" ;
				 
				 alert("the flag5 before returning xxx :- "+flag5);
				 return "error";
				}
			else if(reslt=="Selected date is less than today's date*******")
				{
				  alert("Selected date is less than today's date.Please select date which is equal to today's date or greater than today's date");
				  alert("reslt :-  "+reslt+" "+flag5);
				  flag5 = "error";
				  alert("the flag5 before returning yyy :- "+flag5); 
				  return flag5;
				}
		}
	};
	
	var queryString ="?tripid="+tripid+"&date="+date1;
	ajaxRequest.open("GET", "Updatedate112.jsp" + queryString, true);
	ajaxRequest.send(null); 
}



function toggleDetails1(id,show,row,event)
{
	//try
	//{
	var temp="";
	if(row == 1)
	{
		temp = "popupp"+id;
	}
	else
	{
		temp = "popuppf"+id;
	}
	//alert(temp);
var popup = document.getElementById(temp);
	if (show) {
//		alert("in if  "+popup.Value);
	popup.style.visibility = "visible";

	popup.setfocus();

	} else {
		if(row == 1)
		{
			if(event == "No")
			{
				document.getElementById("Reason"+id).innerHTML = "Reason";
			}
			else
			{
				document.getElementById("Reason"+id).innerHTML = event;
			}
		
		popup.style.visibility = "hidden";
		}
		else
		{
			if(event == "No")
			{
				document.getElementById("Reasonf"+id).innerHTML = "Reason";
			}
			else
			{
				document.getElementById("Reasonf"+id).innerHTML = event;
			}
			popup.style.visibility = "hidden";
		}

	 }
	/*}
	catch(e)
	{
       alert(e);
	}*/
}

function open4(TripId,DriveId,BrifId)
{
	try
	{
		routeid = document.getElementById("routeid").value;
	testwindow1 = window.open("ViewJourneyOnMap.jsp?tripid="+TripId+"&driverid="+DriveId+"&briefid="+BrifId+"&rid="+routeid,"ViewOnMap","width=1000,height=900,scrollbars=yes");
	testwindow1.moveTo(250,250);
	}
	catch(e)
	{
		alert(e);
	}
}

function open3(TripId,DriveId,BrifId,Day)
{
	try
	{
		routeid = document.getElementById("routeid").value;
	testwindow1 = window.open("Detailjourney.jsp?tripid="+TripId+"&driverid="+DriveId+"&briefid="+BrifId+"&day="+Day+"&rid="+routeid,"DetailJourney","width=1000,height=900,scrollbars=yes");
	testwindow1.moveTo(250,250);
	}
	catch(e)
	{
		alert(e);
	}
}

function open2(TripId,DriveId,BrifId,Day,routeid)
{
	//alert("oprn2");
	if(Day == 'All')
	{
	testwindow1 = window.open("ViewPlan.jsp?tripid="+TripId+"&driverid="+DriveId+"&briefid="+BrifId,"ViewJourneyPlanning","width=900,height=700,scrollbars=yes");
		testwindow1.moveTo(250,250);
	}
	else
	{
		try
		{
		//alert("ajax");
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
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				try
				{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				document.getElementById("legsum").innerHTML = reslt;
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?tripid="+TripId+"&briefid="+BrifId+"&driverid="+DriveId+"&Day="+Day+"&routeid="+routeid;
		ajaxRequest.open("POST", "LegSummary.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	}
			
}

function toggleDetails(id,show,row,event,drikm,dritime,sttime)
{
	//try
	//{
	var temp="";
	if(row == 1)
	{
		temp = "popup"+id;
	}
	else
	{
		temp = "popupf"+id;
	}
	//alert(temp);
var popup = document.getElementById(temp);
	if (show) {
//		alert("in if  "+popup.Value);
	popup.style.visibility = "visible";

	popup.setfocus();

	} else {
		if(row == 1)
		{
			if(event == "Duty Stop" || event == "Rest" || event == "Night Halt")
			{
				//document.getElementById("drikm"+id).style.display = "none";
				//document.getElementById("dridur"+id).style.display = "none";
				//document.getElementById("stdur"+id).style.display = "none";
			//	document.getElementById("dura"+id).style.display = "";
				document.getElementById("event"+id).innerHTML = event;
			}
			else
				if(event == "No")
				{
					//document.getElementById("drikm"+id).style.display = "none";
					//document.getElementById("dridur"+id).style.display = "none";
					//document.getElementById("stdur"+id).style.display = "none";
				//	document.getElementById("dura"+id).style.display = "none";
				//	document.getElementById("event"+id).innerHTML = event;
				}
				else
					if(event == "Driving" || event == "Deviation Start")
					{
						//document.getElementById("drikm"+id).style.display = "";
						//document.getElementById("dridur"+id).style.display = "";
						//document.getElementById("stdur"+id).style.display = "";
					//	document.getElementById("dura"+id).style.display = "none";
						document.getElementById("event"+id).innerHTML = event;
					}
		
		}
		else
		{
			if(event == "No")
			{
				//document.getElementById("drikmf"+id).style.display = "none";
				//document.getElementById("dridurf"+id).style.display = "none";
				//document.getElementById("stdurf"+id).style.display = "none";
			//	document.getElementById("duraf"+id).style.display = "none";
				//document.getElementById("eventf"+id).innerHTML = event;
			}
			else
				if(event == "Driving"  || event == "Deviation Start")
				{
					//document.getElementById("drikmf"+id).style.display = "";
					//document.getElementById("dridurf"+id).style.display = "";
					//document.getElementById("stdurf"+id).style.display = "";
					//document.getElementById("duraf"+id).style.display = "none";
					document.getElementById("eventf"+id).innerHTML = event;
				}
		
		}
	popup.style.visibility = "hidden";

	 }
	/*}
	catch(e)
	{
       alert(e);
	}*/
}
</script>
<script type="text/javascript">

function datevalidate()
{
	var date1 = document.getElementById("date1").value;
	var hr1="";
	var min1="";
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	mm1=date1.substring(3,6);
	mm11=dateformat(mm1);
	yy11=date1.substring(7,11);
	hr1 = date1.substring(12,14)
	min1 = date1.substring(15,17)
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var hr=date.getHours();
	var min=date.getMinutes();
	//alert(hr);
	//alert(min);
	var year=date.getFullYear();
	//alert("year1   "+yy11+"   year  "+year);
	if(yy11<year) 
	{
		
		alert("selected date should not be Less than todays date");
		document.getElementById("date1").value="";
		document.getElementById("date1").focus;
		return false;
	}
	else if(year==yy11)
	{
		//alert("month1   "+mm11+"   month  "+month);
			if(mm11<month)
		{
			alert("selected date should not be Less than todays date");
			document.getElementById("date1").value="";
			document.getElementById("date1").focus;
			return false;
		}
			else
				if(mm11==month)
				{
					//alert("day1   "+dd11+"   day  "+day);
					if(dd11<day)
					{
						alert("selected date should not be Less than todays date");
						document.getElementById("date1").value="";
						document.getElementById("date1").focus;
						return false;
					}
					else
						if(dd11==day)
						{
							//alert("hr1   "+hr1+"   hr  "+hr);
							if(hr1<hr)
							{
								alert("selected date should not be Less than todays date");
								document.getElementById("date1").value="";
								document.getElementById("date1").focus;
								return false;
							}
							else
								if(hr1==hr)
								{
									//alert("min1   "+min1+"   min  "+min);
									if(min1<min)
									{
										alert("selected date should not be Less than todays date");
										document.getElementById("date1").value="";
										document.getElementById("date1").focus;
										return false;
									}
								}
					    }
		        }
	}
	return true;
}

function dateformat(days)
{
	 if(days=='Jan')
		return(1);
	 else
		if(days=='Feb')
			return(2);
		else
			if(days=='Mar')
				return(3);
			else
				if(days=='Apr')
					return(4);
				else
					if(days=='May') //timeformat: "%M:%S"
						
						return(5);
					else
						if(days=='Jun')
							return(6);
						else
							if(days=='Jul')
								return(7);
							else
								if(days=='Aug')
									return(8);
								else
									if(days=='Sep')
										return(9);
									else
										if(days=='Oct')
											return(10);
										else
											if(days=='Nov')
												return(11);
											else
												if(days=='Dec')
													return(12);
 }

function showtable()
{
//   alert("inside showtable");
	var date21 = document.getElementById("date1").value;
// 	alert("date21 is :- "+date21);
	var date_chk1 = document.getElementById("date23").value;
//      alert("date_chk1 :- "+date_chk1);
     
     var dd51,mm51,mm61,hr51,yy51,min51,dd61,mm71,mm81,hr61,yy61,min61;
     dd51=date21.substring(0,2);
 	mm51=date21.substring(3,6);
 	mm61=dateformat(mm51);
 	yy51=date21.substring(7,11);
 	hr51 = date21.substring(12,14);
 	min51 = date21.substring(15,17);
//  	alert("value of dd51  "+dd51);
//  	alert("values of mm61  "+mm61);
//  	alert("value of yy51  "+yy51);
 	
 	
 	
 	dd61=date_chk1.substring(0,2);
 	mm71=date_chk1.substring(3,6);
 	mm81=dateformat(mm71);
 	yy61=date_chk1.substring(7,11);
 	hr61 =date_chk1.substring(12,14);
 	min61 =date_chk1.substring(15,17);
//  	alert("value of dd61  "+dd61);
//  	alert("values of mm81  "+mm81);
//  	alert("value of yy61  "+yy61);
 	
 	
     
     
     
     
     
//        if(yy51 >= yy61) alert("date is greater");
     
     
     
               
     
     
     
     
//       var check = new Date(date1) ;//Date.parse(date1)
//       var check123 = new Date(date_chk) ;//Date.parse(date_chk)
      
//      alert("Check value"+check);
//      alert("Check2 value"+check123);
//      if (date21 < date_chk1)
//      {
    	
//     	alert("*****************************");
//     	alert("the date you have selected is less than our record");
//      }
//      else
//      {
//     	alert("in else block");

    	
    	
   var date2 = date21+":00";
   //var flag = datevalidate(); 
//    alert("flag value in journey planning"+flag);
   //if(flag)
   //{
// 	if(dd51 >= dd61 && mm61 >= mm81 && yy51 >= yy61)
	if(yy51 >= yy61)
	{
// 	   alert("inside yy block");
		if(yy51 == yy61)
		{	
// 			alert("inside mm block");
			
		 
			if(mm61>mm81 || mm61==mm81)
			{
				
				if(((mm61==mm81)?(dd51>=dd61):true))
				{
					
					if(((dd51==dd61)?(hr51>=hr61):true))
					{
						
					if((hr51==hr61)?(min51>=min61):true)
					{		
					
				     
// 					alert("inside dd block");
				    var tripid = document.getElementById("tripid").value;
					var brifid = document.getElementById("briefid").value;
					var driverid = document.getElementById("driverid").value;
					var routeid = document.getElementById("routeid").value;
// 					alert("before going to  Calculatejourneyplan.jsp page");
					window.location.href = "Calculatejourneyplan.jsp?tripid="+tripid+"&briefid="+brifid+"&driverid="+driverid+"&date1="+date2+"&routeid="+routeid;
				}
				else
				{
// 					alert("Please enter correct time selected hours are greater than databse hours");
					alert("Please enter correct Date and Time");
				}
					
			 }
			else
			{
// 					alert("please enter the correct date , selected date is less than our records");
					alert("Please enter correct Date and Time");
			
			}
			
		 }
				else{
// 					alert("please select correct month selected month is less than our records");
					alert("Please enter correct Date and Time");
				}
		}
			else{
// 				alert("please select correct month selected month is less than our records");
				alert("Please enter correct Date and Time");
			}
		}
	
		else
		{
// 			alert("inside dd block");
		    var tripid = document.getElementById("tripid").value;
			var brifid = document.getElementById("briefid").value;
			var driverid = document.getElementById("driverid").value;
			var routeid = document.getElementById("routeid").value;
			alert("before going to  Calculatejourneyplan.jsp page");
			window.location.href = "Calculatejourneyplan.jsp?tripid="+tripid+"&briefid="+brifid+"&driverid="+driverid+"&date1="+date2+"&routeid="+routeid;
		}	
			
			
			
			
// 			if(dd51 >= dd61)	
// 		 {
			 

// 				alert("inside dd block");
// 	    var tripid = document.getElementById("tripid").value;
// 		var brifid = document.getElementById("briefid").value;
// 		var driverid = document.getElementById("driverid").value;
// 		var routeid = document.getElementById("routeid").value;
// 		alert("before going to  Calculatejourneyplan.jsp page");
// 		window.location.href = "Calculatejourneyplan.jsp?tripid="+tripid+"&briefid="+brifid+"&driverid="+driverid+"&date1="+date2+"&routeid="+routeid;
// 		}  
// 		}
   }
   else
   {
	   
	   alert("Please select correct date");
	   
   }
// }
}

function showtableman(TripId,DriveId,BrifId,VehRegNo)
{
// 	alert("inside showman table");
	loc = document.getElementById("loc").value;
	StopReason = document.getElementById("StopReason").value;
	Day = document.getElementById("Day").value;
	var chk_flag = "correct";
    var date1 = document.getElementById("MdateF").value;
    var date2 = document.getElementById("MdateT").value;
//     alert("in the function showtableman flag is :-  "+chk_flag);
    var date_chk = document.getElementById("date23").value;
    
    
//     alert("date_chk is "+date_chk);
//     alert("date1"+date1);
//     var check = new Date(date1) ;//Date.parse(date1)
//     var check123 = new Date(date_chk) ;//Date.parse(date_chk)
    
//     alert("ththth  date1 is :- "+new Date(date1).toString());
    
    
//     alert("caution");
//     if (dateformat(date1,"yyyy-mm-dd") > dateformat(date_chk,"yyyy-mm-dd"))
// 	{
// 		alert("aata babo    ");
// 		alert("the date you have selected is less than our record");
// 	}
    
    
    
    
    
    
//     alert("date1 is :- "+date1);
//     alert("check"+check);
//     alert("check123 "+check123);
// //     try
//     {
//     	if ((check1.getTime()) < (check1234.getTime()))
//     	{
//     		alert("ata mazi satakali");
//     		alert("the date you have selected is less than our record");
//     	}
//     }catch(e)
//     {
    	
//     alert(e);
//     }
    
    
    
    var date = new Date();
    
    if(date1!="")
	{
    	try{
	  
//     	alert("chk_flag before calling function "+chk_flag);
    	//chk_flag=updatevalues1(date1,"correct");
// 		alert("tuurning point "+chk_flag);
// 		alert("chk_flag after returning from function "+chk_flag);
// 		alert("tuurning point4561235");
	}catch(e)
	{
		alert(e);
	}
	}
	
    
    
    if(date1==""||date2=="")
	{
	alert("Please Select Date");
	}  
	
    	//else if(date1>date2)
    	//{
    	//alert("From date should not greater than to date  !!!");
    	//}  
    
    if (date1 < date_chk)
	{
// 		alert("ata mazi satakali");
// 		alert("the date you have selected is less than our record");
		alert("Please select correct date");
	}
    	
    else if(loc=="")
	{
		alert("Please Enter Location");
	}
//     else if (check1.getTime() > check1234.getTime())
//     {
    	
//     	alert("the date you have selected is less than our record");
//     }
    
    else //iff(chk_flag!="error")//&& flag!=undefined   	
   {
//     alert("in the else block for inserting data ");
    var date11 = date1+":00";
    var date22 = date2+":00";
    
    
//     alert(date22);
		try
		{
// 		alert("ajax 222");
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
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				try
				{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				if(reslt == "1")
					{
						alert("Stop duration should not be less than 15 min");
					}
				
				if(reslt=="Already")
					{
					alert("The stop has been already generated for the selected date\\time range !!!");
					}
				if(reslt=="Added")
					{
					showtablemanView(TripId,DriveId,BrifId,VehRegNo);
					}
				
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?tripid="+TripId+"&briefid="+BrifId+"&driverid="+DriveId+"&Day="+Day+"&loc="+loc+"&StopReason="+StopReason+"&VehRegNo="+VehRegNo+"&dateF="+date11+"&dateT="+date22;
		//alert(queryString);
		ajaxRequest.open("POST", "journeyplanningAjax.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
    	}
}			

function showtablemanView(TripId,DriveId,BrifId,VehRegNo)
{
	//alert("oprn2");
	
			try
		{
		//alert("ajax");
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
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				try
				{
				var reslt=ajaxRequest.responseText;
				//alert(reslt);
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				//alert(reslt);
				document.getElementById("mTrip").innerHTML = reslt;
				}
				catch(e)
				{
					alert(e);
				}
			}
		};
		
		var queryString ="?tripid="+TripId+"&briefid="+BrifId+"&driverid="+DriveId+"&VehRegNo="+VehRegNo;
		ajaxRequest.open("POST", "journeyplanningAjaxView.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
}	


function deletStop(tripid,briefid,driverid,Start,End,StopReason,Entryby)
{try{
	var agree=confirm("Do You Want to Delete this Vehicle?");
// 	alert("in delete function");
	if(agree)
    {
		
//             alert("before delete");
           window.location="journeyplanningDelete.jsp?tripid="+tripid+"&briefid="+briefid+"&driverid="+driverid+"&Start="+Start+"&End="+End+"&StopReason="+StopReason+"&Entryby="+Entryby;
    }

}catch(e)
{alert(e);
}
}


</script>
<script>

function savedata1(id,tid,row,routeid)
{
	alert("savedata");
}

</script>
</head>
<body style="margin: 20px;text-align: center;">
<%
try
{

Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 s = con.createStatement();
 s1 = con.createStatement();
 s2 = con.createStatement();
 s3 = con.createStatement();
 st3 = con.createStatement();
 st4 = con.createStatement();
 sevent= con.createStatement();
String driverid = "";
String drivername = "";
String tripid = "",startplace = "",endplace = "",vehregno = "",transporter = "";
routeid = "";
String date23 = "";
driverid = request.getParameter("driverid");
String briefid = request.getParameter("briefid");
//System.out.println("***   "+driverid);
//System.out.println("***   "+briefid);

String sql = "SELECT * FROM db_gps.t_briefing WHERE driverid = '"+driverid+"' and briefid = '"+briefid+"' ORDER BY brifdate DESC";
//String sql = "SELECT * FROM db_gps.t_briefing WHERE driverid = '"+driverid+"'  ORDER BY brifdate DESC";
ResultSet rs = s.executeQuery(sql);
if(rs.next())
{
	tripid = rs.getString("tripid");
	startplace = rs.getString("startplace");
	endplace = rs.getString("endplace");
	transporter = rs.getString("Transporter");
	vehregno = rs.getString("VehRegNo");
	drivername = rs.getString("DriverName");
}
//startplace = "Castrol Patalganga Plant";
//endplace = "Delhi";
//tripid = "785023";
//briefid = "67319";

String sql50="select concat(StartDate,' ',StartTime) as time from db_gps.t_startedjourney where TripID='"+tripid+"'";

ResultSet rs22 = st4.executeQuery(sql50);

System.out.println("QUERY FIRE BY ME **********"+sql50);

if(rs22.next())
{
	date23=rs22.getString("time");	

}

else
{
	String sysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()); 
	date23 = sysDate ;
    System.out.println("System Date"+sysDate);
}
date23=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date23));



String date = request.getParameter("date1");
if(date == null || date.equals("null"))
{
	date = "";
}

%>
		<%	
			String Msg ="0";
			Msg = request.getParameter("Msg");
			if(Msg!=null && Msg.equalsIgnoreCase("1"))
			{
			%>
			<script>
					alert("Deleted Successfully!!!");
			</script>
			<%
			}
			else
				if(Msg!=null && Msg.equalsIgnoreCase("2"))
				{
					%>
					<script>
					   alert("Unable to delete the Vehicle!!!");
					</script>
					<%
				}
%>

<form name="jrnyplan" id="jrnyplan" >

<h1  align="center"><font>Journey Plan</font></h1>
<div align="center">
<table width="100%" border="0">
<tr>
<td width="60%">
<table border="0"  width="100%">
<tr align="left">
<td  valign="top" width="20%"><font color="black">  <b> Trip ID:</b> <%=tripid %></font></td>
<td valign="top"><font color="black"><b>Driver ID: </b> <%=driverid %></font>
<input type="hidden" name="driverid" value="<%=driverid %>" id="driverid"> 
<input type="hidden" name="briefid"  id = "briefid" value="<%=briefid %>">
<input type="hidden" name="tripid"  id = "tripid" value="<%=tripid %>"></td>
<input type="hidden" name="date23"  id ="date23" value="<%=date23%>"></td>
<td valign="top"><font color="black"><b>Driver Name:</b> <%=drivername %> </font></td>
<td valign="top"><font color="black"><b>Transporter: </b> <%=transporter %></font></td>
</tr>
<tr align="left">
<td valign="top"  width="20%"><font color="black"><b>Origin:</b> <%=startplace %></font></td>
<td valign="top" ><font color="black"><b>Destination:</b> <%=endplace %></font></td>

<td valign="top" ><font color="black"><b>Vehicle:</b> <%=vehregno %></font></td>
<td valign="top"><font color="black" id="dist"><b>Distance:</b> 120</font></td>
</tr>
</table>
</td>

<td width="50%" align="center">
<table border="0" >
<tr >
<%
String routename = "";
int  totzone = 0,totkm =0,redzone =0,redkm =0,yellowzone =0,yelllowkm =0,greenzone =0,greenkm = 0;
sql = "select *  from db_gps.t_jrmrouteadvancedmaster where StartPlace = '"+startplace+"' and EndPlace = '"+endplace+"'";
System.out.println("****   "+sql);
rs = s.executeQuery(sql);
if(rs.next())
{
	routeid = rs.getString("routeid");
	totzone = rs.getInt("totalzone");
	totkm = rs.getInt("totalkm");
	redzone = rs.getInt("redzonecount");
	redkm = rs.getInt("redzonedist");
	yellowzone =rs.getInt("yellowzonecount");
	yelllowkm = rs.getInt("yellowzonedist");
	greenzone = rs.getInt("greenzonecount");
	greenkm = rs.getInt("greenzonedist");	
	routename = rs.getString("routename");
}

//routeid = "1";
%>
<input type="hidden" name="routeid" value="<%=routeid %>" id="routeid"> 
<%

System.out.println("****   "+routeid);
if(routeid == "" || routeid == null)
{
	
}
else
{
/*sql = "select a.totzone,a.totkm,b.redzone,b.redkm,c.yellowzone,c.yellowkm,d.greenzone,d.greenkm from "
		+"(select count(zone) totzone, sum(legdist) totkm from db_gps.t_jrmrouteadvanceddetails where "
		+"advancedrouteid = 1) a inner join (select count(zone) redzone, sum(legdist) redkm from "
		+"db_gps.t_jrmrouteadvanceddetails where advancedrouteid = 1 and zone = 'red') b "
		+"inner join (select count(zone) yellowzone, sum(legdist) yellowkm from db_gps.t_jrmrouteadvanceddetails "
		+" where advancedrouteid = 1 and zone = 'yellow') c inner join (select count(zone) greenzone, sum(legdist) greenkm "
		+"from db_gps.t_jrmrouteadvanceddetails where advancedrouteid = 1 and zone = 'green') d  ";*/
//System.out.println("****   "+sql);
/*sql = "select * from db_gps.t_advjrmroutemst where routeid = '"+routeid+"'";
rs = s.executeQuery(sql);
if(rs.next())
{
	routename = rs.getString("RouteName");
	totzone = rs.getString("TotZoneCount");
	totkm = rs.getString("TotZoneKm");
	redzone = rs.getString("RedZoneCount");
	redkm = rs.getString("RedZoneKm");
	yellowzone = rs.getString("YellowZoneCount");
	yelllowkm = rs.getString("YellowZoneKm");
	greenzone = rs.getString("GreenZoneCount");
	greenkm = rs.getString("GreenZoneKm");	
}*/
//routename = "Patalganga-Delhi";

}

//String sql2 = "select * from db_gps.t_intermediatejrmroute where advancedrouteid = '"+routeid+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' order by CumTime limit 1" ;
String sql2 = "select * from db_gps.t_jrnyplanning where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' order by Start  limit 1" ;
ResultSet rs2 = s2.executeQuery(sql2);
//System.out.println("sql2 ---------------->     "+sql2);
if(rs2.next())
{
	//System.out.println("**     "+rs2.getString("Start"));
	date = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("Start")));
	//System.out.println("**     "+rs2.getString("Start"));
}
else
{
	date = "";
}
%>

<th align="center">
<%
if(routeid == null || routeid.equals("") || routeid.equals("null") || routeid.equals(" "))
		{
	
		}
else
{
	%>
	<div style="text-align: center;">Route Name:  <%=routename %></div>
	<%
}
%>
</th>
</tr>
</table>
<%
if(routeid == null  || routeid.equals("") || routeid.equals("null") || routeid.equals(" "))
		{
			
		}
		else
		{	
%>

<table border="1"  class="sortable" align="center" style="width: 60px;">
<tr>
<th></th>
<th>Total</th>
<th>Red</th>
<th>Yellow</th>
<th>Green</th>
</tr>
<tr>
<td align="left"><div align="left">Zones</div></td>
<td align="right"><div align="right"><%=totzone %></div></td>
<td align="right" style= "background-color: #FF9E9E"><div align="right"><%=redzone %></div></td>
<td align="right" style= "background-color: #FFF2A1"><div align="right"><%=yellowzone %></div></td>
<td align="right" style= "background-color: #C6FFB5"><div align="right"><%=greenzone %></div></td>
</tr>
<tr>
<td align="left"><div align="left">KM</div></td>
<td align="right"><div align="right"><%=totkm %></div></td>
<td align="right" style= "background-color: #FF9E9E"><div align="right"><%=redkm %></div></td>
<td align="right" style= "background-color: #FFF2A1"><div align="right"><%=yelllowkm %></div></td>
<td align="right" style= "background-color: #C6FFB5"><div align="right"><%=greenkm %></div></td>
</tr>
</table>
<%
		}
%>
</td>
</tr>
</table>
</div> 

<script>
document.getElementById("dist").innerHTML = "<b>Distance:</b> <%=totkm%>";

</script>
<%
if(routeid.equals("") || routeid.equals("null") || routeid.equals(" "))
		{
				%>
			 <div align="center"><font size="3">No System Route Available - Create Plan Manually </font></div>
			 <div align="left">
			 <table border="0" width="100%">
			 <tr>
			 <td style="width: 100px"><b>&nbsp;&nbsp;From Date/Time: </b></td>
			  <td>
			 <div align="left"><font color="black"> &nbsp;&nbsp;
			<input type="text" id="MdateF" name="Mdate1"  value=""  class="datetimepicker" style="width: 150px;" readonly/></font></div>
			 </td>
			 <td style="width: 100px"><b>&nbsp;&nbsp;To Date/Time: </b></td>
			  <td>
			 <div align="left"><font color="black"> &nbsp;&nbsp;
			<input type="text" id="MdateT" name="Mdate1"  value=""  class="datetimepicker" style="width: 150px;"    readonly/></font></div>
			 </td>
			 <td style="width: 50px"><b>
			 &nbsp;&nbsp; Day: 
			 </b>
			 </td>
			 <td>
			 
			 <select id="Day" name="Day">	
			 <option value="1">Day 1</option>
			 <option value="2">Day 2</option>
			 <option value="3">Day 3</option>
			 <option value="4">Day 4</option>
			 <option value="5">Day 5</option>
			 <option value="6">Day 6</option>
			 <option value="7">Day 7</option>
			 <option value="8">Day 8</option>
			 <option value="9">Day 9</option>
			 <option value="10">Day 10</option>		 
			 </select>		 
			 </td>
<td><b>
			 &nbsp;&nbsp; Stop Type: 
			 </b> 
			 </td>
			 <td>
			 <select id="StopReason" name="StopReason">	
			 <option value="Meals">Meals</option>
			 <option value="Rest">Rest</option>
			 <option value="Night halt">Night halt</option>
			 <option value="Destination">Destination</option>
			 </select>		 
			 </td>
			 <td><b>&nbsp;&nbsp; Location</b></td>
			 <td>
			 <input id="loc" name="loc" value=""> 
			 </td>
			 <td>
			 <input type="button" class="button_text" style="border-style: outset; border-color: black"  value="Submit" onclick="javaprg:try{showtableman('<%=tripid %>','<%=driverid %>','<%=briefid %>','<%=vehregno %>');}catch(e){alert(e);}" />
			 </td>
			 </tr>			 
			 </table>
			 </div>
  		 	 <div id="mTrip" align="center">
  		 	 
  		 	 <table border='1' width='100%' class='sortable' style='width:100%;' align='left'><tr><th></th><th>SrNo.</th><th>Day</th><th>From DT</th><th>To DT</th><th>Duration</th><th>Stop Reason</th> <th>Location</th><th>Entry By</th></tr>
  		 	 <%
  		 	SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
  		 	SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  		 	SimpleDateFormat df2 = new SimpleDateFormat("HH:mm");
  		 	SimpleDateFormat df3 = new SimpleDateFormat("HH:mm:ss");

  		int i1=1; 	 
	String SqlRoute="select * from t_jrnyplanning where Tripid='"+tripid+"' and brifid='"+briefid+"' and driverid='"+driverid+"' order by Start,UpdatedDateTime ";
	System.out.println("route name=====>"+SqlRoute);
	ResultSet rsRoute=st3.executeQuery(SqlRoute); 
	while(rsRoute.next())
	{
	%>
	
		<tr>
		<td><div  align="left"><a href="javascript:deletStop('<%=tripid %>','<%=briefid %>','<%=driverid %>','<%=rsRoute.getString("Start")%>','<%=rsRoute.getString("End")%>','<%=rsRoute.getString("StopReason")%>','<%=rsRoute.getString("Entryby")%>');">Delete</a></div>
				</td>
		<td align='right'><div align='right'><%=i1 %></div></td>
		<td align='right'><div align='right'><%=rsRoute.getString("Day") %></div></td>
		<td align='right'><div align='right'><%=df.format(df1.parse((rsRoute.getString("Start")))) %></div></td>
		<td align='right'><div align='right'><%=df.format(df1.parse((rsRoute.getString("End")))) %></div></td>
		<td align='right'><div align='right'><%
		
		
		try{
			String dur=rsRoute.getString("StopDuration");
			String dur1[]=dur.split(":");
			out.print(dur1[0]+":"+dur1[1]);
				
		}catch(Exception e){out.print("00:00");}%></div></td>
		
		<td align='left'><div align='left'><%=rsRoute.getString("StopReason") %></div></td>
		<td align='left'><div align='left'><%=rsRoute.getString("Destination") %></div></td>
		<td align='left'><div align='left'><%=rsRoute.getString("Entryby") %></div></td></tr>
		
		<%
		i1++;
	}
	%>
	</table>
  	 </div>
  			  <%
		}
		else
		{	
			
	//	System.out.println("***   date  "+date);
%>
<table border="0" width="75%">
<tr>
<td>
<div align="left"><font color="black"><b>Journey Start:</b> &nbsp;&nbsp;
		<input type="text" id="date1" name="date1"  value="<%=date %>"  class="datetimepicker" style="width: 150px;"   readonly/>
	</font>  &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button_text" style="border-style: outset; border-color: black"  value="Create Journey" onclick="javaprg:try{showtable();}catch(e){alert(e);}" /></div>
	</td>
	<td></td>
	<td><a href="#" onclick="open1('<%=tripid %>','<%=driverid %>','<%=briefid %>')"><font size="2"><b>View Summary</b></font></a></td>
	<td><a href="#" onclick="open2('<%=tripid %>','<%=driverid %>','<%=briefid %>','All','<%=routeid %>')"><font size="2"><b>View Leg Summary</b></font></a></td>
	<td><a href="#" onclick="open3('<%=tripid %>','<%=driverid %>','<%=briefid %>','All')"><font size="2"><b>View Detail</b></font></a></td>
	<td><a href="#" onclick="open4('<%=tripid %>','<%=driverid %>','<%=briefid %>')"><font size="2"><b>View Journey on Map</b></font></a></td>
	</tr>
	</table>
	</form>
	<script>
	try
{
//document.getElementById("date1").value = "< %=date%>";
var a= 2;
var b = 3;
var cnt = a+b;
//alert(cnt);
}
catch(e)
{
	//alert(e);
}
</script>
	<%
	if(date == null || date.equals("null") || date.equals(""))
	{
		
	}
	else
	{
		int i = 1;
		%>
	
	<div align="right"></div>
	<br>
	<center>
	<div  style="width: 80%;" align="center">
		<table border="1"  class="sortable" align="center" >
		<tr>
		<th>Day</th>
		<th>Date</th>
		<th>Legs</th>
		<th>Km</th>
		<th>Red Zone</th>
		<th>Red Zone Km</th>
		<th>Yellow Zone</th>
		<th>Yellow Zone Km</th>
		<th>Green Zone</th>
<!--		<th>Calculated Date</th>-->
		<th>Green Zone Km</th>	
		<th>Stop Count</th>
		<th>Stop Duration</th>
		<th>Runhrs</th>
		<th>Night Stop Duration</th>
		<th>Night Stop Location</th>
		
		
		</tr>
		
			<%
		String dis = "0";
			//String startdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(date));
			String  sql1 = "";
			ResultSet rs1 = null;
			// System.out.println(" Legs   Day   km");
			sql1 = "select count(*) as cnt,Day,sum(LegDistance) as km,SEC_TO_TIME(sum(TIME_TO_SEC(Duration))) as runhrs from db_gps.t_jrnyplanning where  Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' group by Day ";	
			 rs1 = s1.executeQuery(sql1);
			// System.out.println("****    "+sql1);
			 while(rs1.next())
			{    
			   String DayDate = "",runhrs = "",NHLoc = "-",stdur = "",NHdur = "";
			   int rzone = 0,rzonekm = 0,yzone = 0,yzonekm = 0,gzone = 0,gzonkm = 0,stcount = 0;
			   String lat = "",lon = "";
				
			   sql = "select Start from db_gps.t_jrnyplanning where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' ";
			   rs = s.executeQuery(sql);
			   if(rs.next())
			   {
				   DayDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("Start")));			   
			   }	
			   
			   sql = "select Destination,StopDuration from db_gps.t_jrnyplanning where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and StopReason = 'Night Halt' ";
			   rs = s.executeQuery(sql);
			  // System.out.println("****    "+sql);
			   if(rs.next())
			   {
				   NHdur = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("StopDuration")));
				   NHLoc = rs.getString("Destination");
				   
				   sql2 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rs.getString("Destination")+"'  and advancedrouteid = '"+routeid+"'";
				   rs2 = s2.executeQuery(sql2);
				   if(rs2.next())
				   {
					   lat = rs2.getString("latitude");
					   lon = rs2.getString("longitude");
				   }
			   }		
			   
			   sql = "select Destination from db_gps.t_jrnyplanning where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and StopReason = 'Journey End'";
			   rs = s.executeQuery(sql);
			  // System.out.println("****    "+sql);
			   if(rs.next())
			   {
				   NHdur = "-";
				   NHLoc = rs.getString("Destination")+" (Destination)";
				   
				   sql2 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rs.getString("Destination")+"'  and advancedrouteid = '"+routeid+"'";
				   rs2 = s2.executeQuery(sql2);
				   if(rs2.next())
				   {
					   lat = rs2.getString("latitude");
					   lon = rs2.getString("longitude");
				   }
				   
			   }	
			   
			   sql = "select count(*) as cnt,SEC_TO_TIME(sum(TIME_TO_SEC(StopDuration))) as stdur from db_gps.t_jrnyplanning where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and StopReason = 'Rest'";
			   rs = s.executeQuery(sql);
			 //  System.out.println("**** sql   "+sql);
			   if(rs.next())
			   {
				   stcount = rs.getInt("cnt");
				   stdur = rs.getString("stdur");
				  // System.out.println("**** stdur   "+stdur);
				   if(stdur==null || stdur.equalsIgnoreCase("null"))
				   {
					   stdur = "-";
				   }
				   else
				   {
					   stdur = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(stdur));
				   }
				   
			   }			   
			   sql = "select count(*) as cnt,sum(LegDist) as redkm from db_gps.t_intermediatejrmroute where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and zone = 'red'";
			   rs = s.executeQuery(sql);
			   if(rs.next())
			   {
				   rzone = rs.getInt("cnt");
				   rzonekm = rs.getInt("redkm")/1000;
			   }
			   sql = "select count(*) as cnt,sum(LegDist) as yellowkm from db_gps.t_intermediatejrmroute where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and zone = 'yellow'";
			   rs = s.executeQuery(sql);
			   if(rs.next())
			   {
				   yzone = rs.getInt("cnt");
				   yzonekm = rs.getInt("yellowkm")/1000;
			   }
			   sql = "select count(*) as cnt,sum(LegDist) as greenkm from db_gps.t_intermediatejrmroute where Day = '"+rs1.getInt("Day")+"'  and Tripid = '"+tripid+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"' and advancedrouteid = '"+routeid+"' and zone = 'green'";
			  //System.out.println("--->   "+sql);
			   rs = s.executeQuery(sql);
			   if(rs.next())
			   {
				   gzone = rs.getInt("cnt");
				   gzonkm = rs.getInt("greenkm")/1000;
			   }
			   %>
			  <tr>
		   	  <td align="right"><div align="right"><%=rs1.getString("Day") %></div></td>
		   	  <td align="right" width="10%"><div align="right"><a href="#" onclick="open2('<%=tripid %>','<%=driverid %>','<%=briefid %>','<%=rs1.getString("Day") %>','<%=routeid %>')"><%=DayDate %></a></div></td>
		   	  <td align="right" ><div align="right"><%=rs1.getString("cnt") %></div></td>
		   	  <td align="right" width="10%"><div align="right"><%=rs1.getInt("km")/1000 %></div></td>
		   	  <td align="right" ><div align="right"><%=rzone %></div></td>
		   	  <td align="right" ><div align="right"><%=rzonekm%></div></td>
		   	  <td align="right" ><div align="right"><%=yzone %></div></td>
		   	  <td align="right" ><div align="right"><%=yzonekm%></div></td>
		   	  <td align="right" ><div align="right"><%=gzone %></div></td>
		   	  <td align="right" ><div align="right"><%=gzonkm %></div></td>
		   	  <td align="right" ><div align="right"><%=stcount %></div></td>
		   	  <td align="right" width="5%"><div align="right"><%=stdur%></div></td>
		   	  <td align="right" width="5%"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("runhrs")))%></div></td>
		   	    <td align="right" width="5%"><div align="right"><%=NHdur%></div></td>
		   	  <td align="left" width="80%"><div align="left"><a href="shownewmap.jsp?lat=<%=lat %>&long=<%=lon%>&discription=<%=NHLoc %>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat %>&long=<%=lon%>&discription=<%=NHLoc %>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=NHLoc %></a></div></td>
		   	  </tr>
			   <%		   
			}
		%>
		</table>
		</div>
		<br>
		<div id="legsum">
		
		</div>
		</center>
		<input type="hidden" value="<%=i-1 %>" id="cnt">
		<input type="hidden" value="<%=date%>" id="data">
		<%//System.out.println("dis***** "+dis);
		%>
		<input type="hidden" value="<%=dis%>" id="distance">
		<input type="hidden" value="0" id="cddur">
		<input type="hidden" value="0" id="stdur">
		<%
	}
		}
%>

<script>
function savedata(id,tid,row,rid)
{
	try
	{
	var date = document.getElementById("date1").value;
	var preid = 0;
	var postid = 0;
	var drikm = 0;
	var dridur = "";
	var stdur = "";
	var reason = "";
	var event = "";
	var dur = "";
	var ctime = "";
	var caltime = "";
	var tripid = "",brifid = "",drivid = "";
	tripid = document.getElementById("tripid").value;
	brifid = document.getElementById("briefid").value;
	drivid = document.getElementById("driverid").value;
	preid = document.getElementById("inpre"+id).value;
	postid = document.getElementById("inpost"+id).value;
	var cnt = document.getElementById("cnt").value;
	if(row == 1)
	{
		event = document.getElementById("event"+id).innerHTML;
		drikm = document.getElementById("drikm"+id).value;
		dridur = document.getElementById("dridur"+id).value;
		stdur = document.getElementById("stdur"+id).value;
		reason = document.getElementById("Reason"+id).innerHTML;
		ctime = document.getElementById("time"+id).innerHTML;
		caltime = document.getElementById("caldate"+id).innerHTML;
	}
	else
		if(row == 2)
		{
			event = document.getElementById("eventf"+id).innerHTML;
			drikm = document.getElementById("drikmf"+id).value;
			dridur = document.getElementById("dridurf"+id).value;
			stdur = document.getElementById("stdurf"+id).value;
			reason = document.getElementById("Reasonf"+id).innerHTML;
			ctime = document.getElementById("timef"+id).innerHTML;
			caltime = document.getElementById("caldatef"+id).innerHTML;
		}
	
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			try
			{
			var reslt=ajaxRequest.responseText;
			//alert(reslt);
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			var token = reslt.split("~");
			//alert(token[0]);
			if(row == 1)
			{
				document .getElementById("day"+id).innerHTML = token[2];
			}
			else
			{
				document .getElementById("dayf"+id).innerHTML = token[2];
			}
				
			if(token[0] == 0)
			{
				updatedate(id,tid,row,rid,token[1],stdur,dridur);
			}
			else
			{
				//alert("Please save again");
			}
					
			
			}
			catch(e)
			{
				//alert(e);
			}
		}
	};
	//alert("Success");
	var queryString = "?tid="+tid+"&date="+date+"&event="+event+"&drikm="+drikm+"&dridur="+dridur+"&tripid="+tripid+"&brifid="+
	brifid+"&drid="+drivid+"&rid="+rid+"&preid="+preid+"&stdur="+stdur+"&reason="+reason+"&postid="+postid+"&ctime="+ctime+"&row="+row+"&caltime="+caltime;
	ajaxRequest.open("GET", "Ajaxcheckdetails.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		//alert(e);
	}
}

function updatedate(id,tid,row,rid,postid,stdur,dridur)
{
	//alert("updtae");
	var date = document.getElementById("date1").value;
	var preid = 0;
	
	//var drikm = 0;
	
	
	var reason = "";
	var event = "";
	var dur = "";
	var ctime = "";
	var caltime = "";
	var tripid = "",brifid = "",drivid = "";
	var flag = 0;
	tripid = document.getElementById("tripid").value;
	brifid = document.getElementById("briefid").value;
	drivid = document.getElementById("driverid").value;
	//preid = document.getElementById("inpre"+id).value;
	//postid = document.getElementById("inpost"+id).value;
	var cnt = document.getElementById("cnt").value;
	if(row == 1)
	{
		event = document.getElementById("event"+id).innerHTML;	
		reason = document.getElementById("Reason"+id).innerHTML;		
		caltime = document.getElementById("caldate"+id).innerHTML;
	}
	else
		if(row == 2)
		{
			event = document.getElementById("eventf"+id).innerHTML;			
			reason = document.getElementById("Reasonf"+id).innerHTML;		
			caltime = document.getElementById("caldatef"+id).innerHTML;
		}
	
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			//alert(reslt);
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert(reslt);
			var token = reslt.split("^");
		//	alert(token.length);
			for(var k=0;k<token.length;k++)
			{
				var token1 = token[k].split("~");
				var a = token1[5];
				var b = token1[6];
				a = a++;
				var l = a--;
				b = b++;
				m = b--;
				if(l  < m)
				{
					//alert(" a  "+l+"   b "+ m);
					try
					{
					document.getElementById("event"+token1[5]).innerHTML = token1[0];
					document.getElementById("drikm"+token1[5]).value = "";
					document.getElementById("drikm"+token1[5]).style.display = "none";
					document.getElementById("dridur"+token1[5]).value ="";
					document.getElementById("dridur"+token1[5]).style.display = "none";
					document.getElementById("stdur"+token1[5]).value ="";
					document.getElementById("stdur"+token1[5]).style.display = "none";
					document.getElementById("Reason"+token1[5]).innerHTML = "Reason";
					document.getElementById("caldate"+token1[5]).innerHTML = token1[1];
					document.getElementById("time"+token1[5]).innerHTML = token1[4];
					document.getElementById("dur"+token1[5]).innerHTML = token1[3];
				//	alert(token1[2]+"    id"+token1[5]+"    "+token1[6]);
					document.getElementById("day"+token1[5]).innerHTML = token1[2];
					document.getElementById("trm"+token1[5]).style.display = "none";
					}
					catch(e)
					{
						alert(e);
					}
				}
				else
					if(l == m)
					{
						document.getElementById("event"+token1[5]).innerHTML = token1[0];
						document.getElementById("drikm"+token1[5]).value = "";
						document.getElementById("drikm"+token1[5]).style.display = "none";
						document.getElementById("dridur"+token1[5]).value ="";
						document.getElementById("dridur"+token1[5]).style.display = "none";
						document.getElementById("stdur"+token1[5]).value ="";
						document.getElementById("stdur"+token1[5]).style.display = "none";
						document.getElementById("Reason"+token1[5]).innerHTML = "Reason";
						document.getElementById("caldate"+token1[5]).innerHTML = token1[1];
						document.getElementById("time"+token1[5]).innerHTML = token1[4];
						document.getElementById("dur"+token1[5]).innerHTML = token1[3];
						document.getElementById("day"+token1[5]).innerHTML = token1[2];
						document.getElementById("trm"+token1[5]).style.display = "";
						document.getElementById("eventf"+token1[5]).innerHTML = "Click to Plan";
						document.getElementById("drikmf"+token1[5]).value = "";
						document.getElementById("drikmf"+token1[5]).style.display = "none";
						document.getElementById("dridurf"+token1[5]).value ="";
						document.getElementById("dridurf"+token1[5]).style.display = "none";
						document.getElementById("stdurf"+token1[5]).value ="";
						document.getElementById("stdurf"+token1[5]).style.display = "none";
						document.getElementById("Reasonf"+token1[5]).innerHTML = "Reason";
						document.getElementById("caldatef"+token1[5]).innerHTML = token1[1];
						document.getElementById("timef"+token1[5]).innerHTML = token1[4];
						document.getElementById("durf"+token1[5]).innerHTML = "00:00:00";
						document.getElementById("dayf"+token1[5]).innerHTML = "";
						document.getElementById("ldistf"+token1[5]).innerHTML = "0";
					}
					else
					{
						document.getElementById("event"+token1[5]).innerHTML = token1[0];
						document.getElementById("drikm"+token1[5]).value = "";
						document.getElementById("drikm"+token1[5]).style.display = "none";
						document.getElementById("dridur"+token1[5]).value ="";
						document.getElementById("dridur"+token1[5]).style.display = "none";
						document.getElementById("stdur"+token1[5]).value ="";
						document.getElementById("stdur"+token1[5]).style.display = "none";
						document.getElementById("Reason"+token1[5]).innerHTML = "Reason";
						document.getElementById("caldate"+token1[5]).innerHTML = token1[1];
						document.getElementById("time"+token1[5]).innerHTML = token1[4];
						document.getElementById("dur"+token1[5]).innerHTML = token1[3];
						document.getElementById("day"+token1[5]).innerHTML = "";
						document.getElementById("trm"+token1[5]).style.display = "none";
					}
				
			}
			
		}
	}

	var queryString ="?id="+id+"&tripid="+tripid+"&briefid="+brifid+"&driverid="+drivid+"&row="+row+"&routeid="+rid+"&date="+date+"&postid="+postid+"&cnt="+cnt;
	ajaxRequest.open("GET", "Updatedate.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}

function updatevalues(id,tid,row,rid,postid)
{
	var date = document.getElementById("date1").value;
	var tripid = document.getElementById("tripid").value;
	var brifid = document.getElementById("briefid").value;
	var drivid = document.getElementById("driverid").value;
	var cnt = document.getElementById("cnt").value;

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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			//alert(reslt);
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert(reslt);
		}
	}
	
	var queryString ="?id="+id+"&tripid="+tripid+"&briefid="+brifid+"&driverid="+drivid+"&routeid="+rid+"&date="+date;
	ajaxRequest.open("GET", "Updatedate1.jsp" + queryString, true);
	ajaxRequest.send(null); 
}




















</script>
<%
}
catch(Exception e)
{
	System.out.println("Exception--->   "+e);
}
%>
<br>
<br>
</body>

</html>

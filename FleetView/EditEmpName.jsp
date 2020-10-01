<%@ include file="headernew.jsp" %>
  
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
%>


<script language="javascript">
function validate()
{
	try
	{
	//alert("Hiiiiii");
	var v1=document.addgrpform.owner.value;
	var v2=document.addgrpform.vehcles.value;
	//alert(v2);
	
	if(v1=="Select")
	{	
		alert("Select OwnerName i.e (Transporter) ");
		return false;
	}
	else if(v2=="Select")
	{
		alert("Select Vehicle");
		return false;
	}
	
	else	
	{
		if(document.addgrpform.extAll.checked)
		{
			var v3 = document.addgrpform.email.value;
			if(v3.length=="")
			{
				
			}
			else
			{
				var sss=validateEmail(v3);
				if(!sss)
				{
				    //alert(sss);
					alert("Please enter valid email id");
					return false;
				} 	
			}

			var v4 = document.addgrpform.phno.value;
			if(v4.length=="")
			{
				
			}
			else
			{
				if(isNaN(v4))
				{
					alert("Please valid Mobile No");
					return false;
				}
			}

			var v5 = document.addgrpform.newHOD.value;
			if(v5.length=="")
			{
				
			}
			else
			{
				var sss=validateEmail(v5);
				if(!sss)
				{
				    //alert(sss);
					alert("HOD ID should be an email id");
					return false;
				} 	
			}
			
			var v6=document.addgrpform.empname.value;
			if(v6.length=="")
			{
				alert("Enter Emp Name");
				return false;
			}
			//alert(v3);
			var v7=document.addgrpform.empcode.value;
			if(v7.length=="")
			{
				alert("Enter Emp Code");
				return false;
			}
			//alert(v4);
			
			var v8=document.addgrpform.newempid.value;
			if(v8.length=="")
			{
				alert("Enter New FleetView Id");
				return false;
			}

			var sss=validateEmail(v8);
			if(!sss)
			{
			    //alert(sss);
				alert("Please enter valid Username");
				return false;
			} 	
			var v10=document.addgrpform.newHOD.value;
			if(v10.length=="")
			{
				alert("Enter HOD EmailID");
				return false;
			}
			var v11=document.addgrpform.email.value;
			if(v11.length=="")
			{
				alert("Enter Email ID");
				return false;
			}
			var v9=document.addgrpform.phno.value;
			if(v9.length=="")
			{
				alert("Enter Mobile Number");
				return false;
			}else if(v9.length<10)
				{
				alert("Enter Valid Mobile Number");
				return false;
				}
		}
		else
		{
			/* var v3=document.addgrpform.empid.value;
			if(v3.length=="")
			{
				alert("Enter FleetView Emp Id");
				return false;
			}

			var sss=validateEmail(v3);
			if(!sss)
			{
		   	     //alert(sss);
				 alert("Please enter valid Username");
				 return false;
			} 
 */
			var v4 =  document.addgrpform.oldHOD.value;
			//alert(v4);
             
            if(v4 == "-")
			{
				//alert(v4);
			}
			else
			{
				
				if(v4.length == "")
				{
					var v5 = document.addgrpform.newHOD.value;
					if(v5.length == "")
					{
						
					}
					else
					{
						
						sss=validateEmail(v5);
						if(!sss)
						{
					   	     //alert(sss);
							 alert("HOD ID should be an email id");
							 return false;
						} 
					}
				}
				else
				{
					//alert("&&&&&"+v4);
					
					//alert("&&&&&"+v4);
					sss=validateEmail(v4);
					//alert(sss);
					if(!sss)
					{
				   	     //alert(sss);
						 alert("HOD ID should be an email id");
						 return false;
					} 
				}
			}
		}
		//alert(v5);
		
	}
	var v19=document.addgrpform.oldusername.value;
	var v20=document.addgrpform.oldmanagername.value;
	
	if(v19.length=="")
	{
		alert("Select User Name");
		return false;
	}
	if(v20.length=="")
	{
		alert("Select Manager ");
		return false;
	}
	if(document.getElementById("calender").value=="")
		{
	  		alert("Please Select the Allocation Date");
			return false;
		}
	return datevalidate();
	return true;
	
	}
	catch(e)
	{
		//alert(e);
	}
}






	 function datevalidate()
	 {
	 	var date1=document.getElementById("calender").value;
		
		var dm1,dd1,dy1,dm2,dd2,dy2;
		var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;

		dd11=date1.substring(0,2);
		mm1=date1.substring(3,6);
		mm11=dateformat(mm1);
					
		yy11=date1.substring(7,11);
		
		var date=new Date();
		var month=date.getMonth()+1;
		var day=date.getDate();
		var year=date.getFullYear();
		
		if(yy11>year)
		{xmlhttp.open("GET","Ajaxredirectpage.jsp?id="+a,true);
			alert("Selected Date Should Not Be Greater Than Today's Date");
			document.getElementById("calender").value="";
			document.getElementById("calender").focus;
			return false;
		}
		else if(year==yy11)
		{
  			if(mm11>month)
			{
				alert("Selected Date Should Not Be Greater Than Today's Date");
				document.getElementById("calender").value="";
				document.getElementById("calender").focus;
				return false;
			}
		}
		if(mm11==month)
		{
			if(dd11>day)
			{
				alert("Selected Date Should Not Be Greater Than Today's Date");
				document.getElementById("calender").value="";
				document.getElementById("calender").focus;
				return false;
			}
		}

		
		return true;
	}
/* function datevalidate()
{
	try
	{
	//alert("***");
	var date1=document.getElementById("calender").value;
	var dm1,dd1,dy1;
	var dd11,yy11,mm1,mm11;
	dd11=date1.substring(8,11);
	mm1=date1.substring(5,7);
	//mm11=dateformat(mm1);
	mm11 = mm1;
	yy11=date1.substring(0,4);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	
	var year=date.getFullYear();
	
   // alert("yy11  "+yy11+"  year   "+year);
  //  alert("mm11  "+mm11+"  month   "+month);
   // alert("dd11  "+dd11+"  day   "+day);
if(date1 == "")
{
	alert("Please Select the Allocation Date");
	return false;
}
else
{
	if(yy11>year)
	{
		alert("selected date should not be greater than todays date");
		//alert("year");
		document.getElementById("calender").value="";
		document.getElementById("calender").focus;
		return false;
	} 
	else if(year==yy11)
	{
		if(mm11>month)
		{
			alert("selected date should not be greater than todays date");
			//alert("month");
			document.getElementById("calender").value="";
			document.getElementById("calender").focus;
			return false;
		}
	}
	if(mm11==month)
	{
		if(dd11>day)
		{
			alert("selected date should not be greater than todays date");
			//alert("day");
			document.getElementById("calender").value="";
			document.getElementById("calender").focus;
			return false;
		}
	}
}
	}
	catch(e)
	{
		//alert(e);
	}
	return true;
}
 */
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
function validateEmail(email)
{
   /*  var splitted = email.match("^(.+)@(.+)$");
    if(splitted == null) return false;
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
	    var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
	    if(splitted[2].match(regexp_ip) == null) return false;
      }// if
      return true;
    }
return false;*/

var flag = false;
var pattern=/^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+\.([a-zA-Z])+([a-zA-Z])+/;
var pattern1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;  

if(pattern1.test(email))
{
	flag = true;
}
else
{
	if(pattern.test(email))
	{
		flag = true;
	}
	else
	{
		flag = false;
	}
}
if(flag)
{
	return true;
}
else
{
	return false;
}

}

function formsubmit()
{
	
	try
	{
		var aa=document.addgrpform.owner.value;
	var owner = document.getElementById("owner").value;
	//alert("owner"+owner);
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
		      //reslt = reslt.replace(/\s+/g,'');
			//alert(reslt);
			//document.getElementById("tr6").style.display = "none";
			//document.getElementById("newHOD").value = "";
			//document.getElementById("tr5").style.display="";
			document.getElementById("vehcles").innerHTML=reslt;
			//document.getElementById("oldHOD").value = reslt;
			}
			catch(e)
			{
				//alert(e);
			}
		} 
	};
	
	var queryString = "?owner="+owner;
	ajaxRequest.open("GET", "AjaxGetVeh.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		//alert(e);
	}

	/* var aa=document.addgrpform.owner.value;
	if(!(aa=="Select"))
	{	
		document.addgrpform.submit();
	} */
}
function formsubmit1()
{
	try
	{
		var vehcles=document.addgrpform.vehcles.value;
	var vehcles = document.getElementById("vehcles").value;
	//alert("vehcles"+vehcles);
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
		      //reslt = reslt.replace(/\s+/g,'');
			//alert(reslt);
			//vehcles=reslt;
			//document.getElementById("tr6").style.display = "none";
			//document.getElementById("newHOD").value = "";
			//document.getElementById("tr5").style.display="";
			document.getElementById("tp").innerHTML=reslt;
			//document.getElementById("oldHOD").value = reslt;
			}
			catch(e)
			{
				//alert(e);
			}
		} 
	};
	
	var queryString = "?vehcles="+vehcles;
	ajaxRequest.open("GET", "AjaxGetvehcles.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		//alert(e);
	}

	/* var bb=document.addgrpform.owner.value;
	if(!(bb=="Select"))
	{	
		document.addgrpform.submit();
		document.getElementById("owner").disabled=true;
		//document.getElementById("showuser").style.display="";
		//document.getElementById("showmanager").style.display="";
	} */
}
function redirect()
{
	var check=validate();
	//alert(check);
	if(check==true)
	{
	document.addgrpform.action="cnfrmempname.jsp";
	document.addgrpform.submit();
	}
	
}

function allSelected()
{
	
	if(document.addgrpform.extAll.checked)
	{
		
		document.getElementById("checkstatus").value = "Yes"; 
		//document.getElementById("tr3").style.display = "none";
		document.getElementById("tr5").style.display = "none";
		//document.getElementById("empid").value = ""; 
		document.getElementById("HOD").innerHTML = "";
		document.getElementById("oldHOD").value = "";
		document.getElementById("tr1").style.display = "";
		document.getElementById("tr2").style.display = "";
		document.getElementById("tr4").style.display = "";
		document.getElementById("tr6").style.display = "";
		document.getElementById("tr7").style.display = "";
		document.getElementById("tr8").style.display = "";
		document.getElementById("tr9").style.display = "";
		document.getElementById("tr10").style.display = "";
		document.getElementById("empn").style.display = "none";
		document.getElementById("coden").style.display = "none";
		
	}
	else
	{
		document.getElementById("checkstatus").value = "No"; 
		//document.getElementById("tr3").style.display = "";
		document.getElementById("tr1").style.display = "none";
		document.getElementById("tr2").style.display = "none";
		document.getElementById("tr4").style.display = "none";
		document.getElementById("tr6").style.display = "none";
		document.getElementById("empname").value = ""; 
		document.getElementById("empcode").value = ""; 
		document.getElementById("newempid").value = ""; 
		document.getElementById("newHOD").value = "";
		document.getElementById("tr7").style.display = "none";
		document.getElementById("tr8").style.display = "none";
		document.getElementById("tr9").style.display = "none";
		document.getElementById("tr10").style.display = "none";
		document.getElementById("email").value = ""; 
		document.getElementById("phno").value = ""; 
		document.getElementById("deg").value = ""; 
		document.getElementById("loc").value = ""; 
		document.getElementById("empn").style.display = "";
		document.getElementById("coden").style.display = "";
	}
}

function newempidval(){
	var newempid123=document.addgrpform.newempid.value;
	document.getElementById("newempidn").style.display="none";
	if(newempid123==null || newempid123=="" || newempid123.length==0){
		document.getElementById("abc").style.display="none";
	   document.getElementById("newempidn").style.display="";
	}
}
		
function hodval(){
	var hodcode123=document.addgrpform.newHOD.value;
	document.getElementById("hodn").style.display="none";
	if(hodcode123==null || hodcode123=="" || hodcode123.length==0){
	   document.getElementById("hodn").style.display="";
	}
}
function phnoval(){
	var phnoncode123=document.addgrpform.phno.value;
	document.getElementById("phnon").style.display="none";
	if(phnoncode123==null || phnoncode123=="" || phnoncode123.length==0){
	   document.getElementById("phnon").style.display="";
	}
}
function emailval(){

	var emailcode123=document.addgrpform.email.value;
	document.getElementById("emailn").style.display = "none";

	if(emailcode123==null || emailcode123=="" || emailcode123.length==0){
		document.getElementById("emailn").style.display = "";
		return false;
	}

}
function codeval(){
	//empcode
	var empcode123=document.addgrpform.empcode.value;
	document.getElementById("coden").style.display = "none";

	if(empcode123==null || empcode123=="" || empcode123.length==0){
		document.getElementById("coden").style.display = "";
		return false;
	}

	
}


function rsmval()
{
	var rsmname=document.addgrpform.oldRSMname.value;
	document.getElementById("rsmm").style.display = "none";

	if(rsmname==null || rsmname=="" || rsmname.length==0){
		document.getElementById("rsmm").style.display = "";
		return false;
	}
	
	
	}

function manval()
{
	var managername=document.addgrpform.oldmanagername.value;
	document.getElementById("mann").style.display = "none";

	if(managername==null || managername=="" || managername.length==0){
		document.getElementById("mann").style.display = "";
		return false;
	}
	
	
	}

function usrval()
{
	var username=document.addgrpform.oldusername.value;
	document.getElementById("usrn").style.display = "none";

	if(username==null || username=="" || username.length==0){
		document.getElementById("usrn").style.display = "";
		return false;
	}
	
	
	}
	
function empval(){
	
	var empname123=document.addgrpform.empname.value;
	document.getElementById("empn").style.display = "none";

	if(empname123==null || empname123=="" || empname123.length==0){
		document.getElementById("empn").style.display = "";
		return false;
	}
}

function showrsm(){
	
	document.getElementById("oldRSMname").removeAttribute("readonly");
	document.getElementById("oldrsm123").value = "true";
	 return false;
}
function showmanager(){
	
	document.getElementById("oldmanagername").removeAttribute("readonly");
	document.getElementById("oldmanager123").value = "true";
	 return false;
}
function showuser()
{
	//alert("in show user");
	//document.getElementById("oldusername").disabled=false;
	 //var eleman = document.getElementById("oldusername");
	   // eleman.removeAttribute("disabled"); 
	    document.getElementById("oldusername").removeAttribute("readonly");
	    document.getElementById("olduser123").value = "true";
	    return false;
		 
	/* document.getElementById("tr20").style.display = "none";
	document.getElementById("olduser").value = "";
	document.getElementById("tr19").style.display = "";
	document.getElementById("newuser").value = ""; */
}

function setname(newuser){
	//alert("in set");
	//document.getElementById("oldusername").value=newuser;
	document.addgrpform.oldusername.value=newuser;
	document.getElementById("searchuser").style.display='none';
	
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
			//alert("reslt:-"+reslt);
			var reslt1=reslt.split("#");
			//document.getElementById("oldmanagername").innerHTML=reslt;
			document.getElementById("oldmanagername").value=reslt1[0].trim();
			document.getElementById("oldRSMname").value=reslt1[1].trim();
		} 
	}
	var queryString = "?oldmanagername=" +newuser;
	ajaxRequest.open("GET", "AjaxSetoldmanager.jsp" + queryString, true);
	ajaxRequest.send(null);
	
}

function setname1(newmanager){
	//alert("in set1");
	//document.getElementById("oldusername").value=newuser;
	document.addgrpform.oldmanagername.value=newmanager;
	document.getElementById("searchmanager").style.display='none';
	
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
			//alert("reslt:-"+reslt);
			//var reslt1=reslt.split("#");
			//document.getElementById("oldmanagername").innerHTML=reslt;
			//document.getElementById("oldmanagername").value=reslt1[0].trim();
			document.getElementById("oldRSMname").value=reslt.trim();
		} 
	}
	var queryString = "?oldmanagername=" +newmanager;
	ajaxRequest.open("GET", "AjaxSetoldRSM.jsp" + queryString, true);
	ajaxRequest.send(null);	
}


function setname2(newrsm){
	//alert("in set1");
	//document.getElementById("oldusername").value=newuser;
	document.addgrpform.oldRSMname.value=newrsm;
	document.getElementById("searchrsm").style.display='none';
	
}



function timer2(){
	
	setTimeout("mysearch2()",2000);
}

function mysearch2(){
	
	//alert("in olduser");
	//document.getElementById("searchuser").style.visibility="visible";
	
	var x2=document.getElementById("oldrsm123").value;
	//alert(x);
	if(x2=="false"){
		//alert("-false");
		
	}
	else{
	
	
	document.getElementById("searchrsm").style.display='block';
	var oldRSMname=document.addgrpform.oldRSMname.value;
	var oldRSMname=document.getElementById("oldRSMname").value;
	//alert("oldmanagername:-"+oldmanagername);
	if(oldRSMname.length=="")
		{
		document.getElementById("searchrsm").style.visibility='hidden';
		}
	else{
		
		document.getElementById("searchrsm").style.visibility="visible";
		
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
			document.getElementById("searchrsm").innerHTML=reslt;
		} 
	}
	var queryString = "?oldRSMname=" +oldRSMname;
	ajaxRequest.open("GET", "AjaxGetoldRSM.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	
	}
}

function timer1(){
	
	setTimeout("mysearch1()",2000);
}

function mysearch1(){
	//alert("in olduser");
	//document.getElementById("searchuser").style.visibility="visible";
	
	var x1=document.getElementById("oldmanager123").value;
	//alert(x);
	if(x1=="false"){
		//alert("-false");
		
	}
	else{
	
	
	document.getElementById("searchmanager").style.display='block';
	var oldmanagername=document.addgrpform.oldmanagername.value;
	var oldmanagername=document.getElementById("oldmanagername").value;
	//alert("oldmanagername:-"+oldmanagername);
	if(oldmanagername.length=="")
		{
		document.getElementById("searchmanager").style.visibility='hidden';
		}
	else{
		
		document.getElementById("searchmanager").style.visibility="visible";
		
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
			document.getElementById("searchmanager").innerHTML=reslt;
		} 
	}
	var queryString = "?oldmanagername=" +oldmanagername;
	ajaxRequest.open("GET", "AjaxGetoldmanager.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	
	}
}


function timer(){
	//to display the please wait ..
	//document.getElementById("plzwait").style.display="";
	setTimeout("mysearch()",2000);
	}
	
function mysearch(){
	//alert("in olduser");
	//document.getElementById("searchuser").style.visibility="visible";
	//var x = document.getElementById("oldusername").disabled;
	var x=document.getElementById("olduser123").value;
	//alert(x);
	if(x=="false"){
		//alert("-false");
		
	}
	else{
		//alert("-true");
	
	
	
	document.getElementById("searchuser").style.display='block';
	var oldusername=document.addgrpform.oldusername.value;
	var oldusername=document.getElementById("oldusername").value;
	//alert("oldusername:-"+oldusername);
	if(oldusername.length=="")
		{
		 document.getElementById("searchuser").style.visibility='hidden';
		//document.getElementById("searchuser").style.display="none";
		}
	else{
		
		document.getElementById("searchuser").style.visibility="visible";
		
		
		
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
			document.getElementById("searchuser").innerHTML=reslt;
			//document.getElementById("plzwait").style.display="none";
		} 
	}
	var queryString = "?oldusername=" +oldusername;
	ajaxRequest.open("GET", "AjaxGetolduser.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	
	}
}

function showtext()
{
	document.getElementById("tr5").style.display = "none";
	document.getElementById("HOD").innerHTML = "";
	document.getElementById("oldHOD").value = "";
	document.getElementById("tr6").style.display = "";
	document.getElementById("newHOD").value = "";
}

function changehod()
{
	try
	{
		
	var username = document.getElementById("empid").value; 
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
		      reslt = reslt.replace(/\s+/g,'');
			//alert(reslt);
			document.getElementById("tr6").style.display = "none";
			document.getElementById("newHOD").value = "";
			document.getElementById("tr5").style.display="";
			document.getElementById("HOD").innerHTML=reslt;
			document.getElementById("oldHOD").value = reslt;
			}
			catch(e)
			{
				//alert(e);
			}
		} 
	};
	
	var queryString = "?username="+username;
	ajaxRequest.open("GET", "AjaxGetHOD.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		//alert(e);
	}
	
}
</script>

<%! 
Connection con1, con2;
%>


<form name="addgrpform" method="get" action="" onSubmit="return validate();">
<%
try
{//1 gps 
	Class.forName(MM_dbConn_DRIVER);
	con2 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	Statement stmt=con1.createStatement(),stmt1=con1.createStatement(), stmt2=con2.createStatement(),stmt19=con2.createStatement(),stmt20=con2.createStatement(),stmt21=con2.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null,rs19=null,rs20=null;
	String sql="", sql1="", sql2="", sql3="",sql19="",sql20="";
	String tm="";

	java.util.Date td =new java.util.Date();
	Format fmt = new SimpleDateFormat("yyyy-MM-dd");
	//Format fmt = new SimpleDateFormat("dd-MMM-yyyy");
	String sdt = fmt.format(td);

	tm=td.getHours()+":"+td.getMinutes()+":"+td.getSeconds();

	
	 String OwnerName=request.getParameter("owner");
	 String Vehicle=request.getParameter("vehcles");
	 String id=request.getParameter("id");
	 String updated=request.getParameter("updated");
	 String empname = request.getParameter("empname");
	 %>
	 <input type="hidden" name="err1" id="err1" value="<%=id %>"/>
	 <input type="hidden" name="err2" id="err2" value="<%=empname %>"/>
	 <%
	 
	 if(updated==null)
	 {
		 
	 }
	 else
		 if(updated == "1" || updated.equals("1"))
	 {
			 %>
			 <script>
				var err = document.getElementById("err1").value;
			    alert("User ID "+err+" already exist !!");
			 </script>
			 <%
	 }
		 else
			 if(updated == "2" || updated.equals("2"))
		 {
			 %>
			 
			 <script>
				var err = document.getElementById("err1").value;
			    alert("Record updated successfully for ID "+err);
			 </script>
			 			
			 <%
		 }
			 else
				 if(updated == "3" || updated.equals("3"))
			 {
				 %>
				 <script>
				var err = document.getElementById("err1").value;
			    alert("User ID "+err+" does not exist !! Please create new user.");
			     </script>
				 			
				 <%
			 }
				 else if(updated == "4" || updated.equals("4"))
				 {
					 %>
					 <script>
					  var err = document.getElementById("err2").value;
			   		  alert(err+" already exist !!");
			    	 </script>
					 			
					 <%
				 }
					 else
						 if(updated == "5" || updated.equals("5"))
					 {
						 %>
						 <script>
						  var err = document.getElementById("err2").value;
				   		  alert(err+" is blocked !!");
				    	 </script>
						 			
						 <%
					 }
	
	 
	%>
	 <!-- <table border="0" width="1250px" align="center" margin-left="200px" position="relative" text-align="center" width=60%> -->
   <table border="0" width="1250px" class="sortable_entry" style="width: 537px">
   <tr align="center">
   <td align="center">
<table border="0" width="500px" bgcolor="#e3e9ff" align="center" class="sortable_entry" style="width: 537px">
		<!-- <tr align="center">
			<td colspan="4" align="center"><font size="3" color="#2A0A12" ><b>ADD/EDIT EMPLOYEE NAME</b>  </font></td>
			     <td> <div align="center"> <font  size="3" color="#20086c"> <b> Add Edit Employee Details </b> </font></div> </td>
		</tr> -->
</table>
</td>
		</tr>
</table>

<br></br>
   <!-- <table border="5" align="center" class="sortable_entry" style="width: 537px"> -->
   	<!-- <tr><td> <div align="center"> <font  size="3" color="#20086c"> <br> </font></div> </td></tr> -->
   <!-- <tr align="center">
   <td align="center">
    --> <!-- <div align="center" style="width: 500px;"> -->
   <table border="2" class="sortable_entry" style="width: 537px" bgcolor="#e3e9ff" align="center">
	<tr align="center">
			<!-- <td colspan="4" align="center"><font size="3" color="#2A0A12" ><b>ADD/EDIT EMPLOYEE NAME</b>  </font></td> -->
			     <td> <div align="center"> <font  size="3" color="#20086c"> <b> Add Edit Employee Details </b> </font>
			     <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" >(<font color="red"> *</font> indicates mandatory fields)</font></div> </td>
			     
		</tr>
	
	<tr bgcolor="#e3e9ff">
       <td>&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font><font color="black"> <b>Owner Name: </b></font> 
       
       <%-- <%   String ownerfrchk="";
       try{
     	  out.println("0.0");
     	  ownerfrchk=request.getParameter("owner");
       out.println(ownerfrchk);
       }catch(Exception e){
     	  e.printStackTrace();
     	  out.println("Exe");
       }
 %> --%>
      	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="owner" id="owner" onchange="formsubmit();"> 
         <option value="Select">Select</option>
          <%
          if(!(null==OwnerName))
			{%>
				 <option value="<%=OwnerName %>" selected="selected"><%=OwnerName %></option>  
				 <%
				
			}
 			out.println("1");
 		%>
        <%
        sql="select Distinct(OwnerName) as Transporter from t_vehicledetails where OwnerName in ('Castrol East','Castrol West','Castrol North','Castrol South','Castrol ILS') and OwnerName not like '%del' order by OwnerName";
        rs1=stmt2.executeQuery(sql);
        out.println("2");
        
        while(rs1.next())
   	   {
        	
        	if(rs1.getString("Transporter").equalsIgnoreCase(OwnerName)){ 
 				%>
 			<option value="<%=rs1.getString("Transporter") %> " selected="selected"> <%=rs1.getString("Transporter") %> </option>
 			<%
 			}else{
				%>
 		   	<option value="<%=rs1.getString("Transporter") %> " > <%=rs1.getString("Transporter") %> </option>
			 <%	
			}
 			
 			%>
	<% } %>
		</select> 
		
   	   </td>
 </tr>
 <br>
  <tr bgcolor="#e3e9ff" >

      <td>&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font><font color="black"><b>Vehicles : </b></font> 
       <!-- <select name="vehcles" id="vehcles" onchange="formsubmit1();"> -->
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="vehcles" id="vehcles" onchange="formsubmit1();">
           <option value="Select">Select</option>
           
           <%
 			if(!(null==Vehicle))
 			{
 				%>
 		       
 					<option value="<%=Vehicle %>" selected="selected"><%=Vehicle %></option>
 				 <%
 			}
 		%>
	   <%
	  // String OwnerName=request.getParameter("owner");
		////System.out.println(OwnerName);
	   sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+OwnerName+"' order by VehicleRegNumber asc";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %>
      		<option value="<%=rs2.getString("VehicleRegNumber") %> "> <%=rs2.getString("VehicleRegNumber") %> </option>
	<% } %>
     		
	    </select></td>
  </tr>
  
   
  <%
 			if(!(null==Vehicle))
 			{
 				%>
  <tr bgcolor="#e3e9ff">
  	<td>  <font color="black"><b> Current EMP Name And Code : </b></font> </td>
     <td> 
	   <%
	  // String OwnerName=request.getParameter("owner");
		////System.out.println(OwnerName);
	   sql="select Empname,Empcode from t_vehicledetails where VehicleRegNumber = '"+Vehicle+"'";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %>
      		<%=rs2.getString("Empname") %> &nbsp;&nbsp;&nbsp; <%=rs2.getString("Empcode") %>
      		
      		<input type="hidden" name="oldempname" value="<%=rs2.getString("Empname")%>" />	
      		<input type="hidden" name="oldempcode" value="<%=rs2.getString("Empcode")%>" />	
      			<% } %>
     		
     		
	 </td>   
  	
  </tr>
  <tr bgcolor="#e3e9ff" id="tr19" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>User Name:</b> </font> </td>
      			<td><input type="text" name="newuser" id="newuser" ></input> 
      </td>
      </tr>
      
  <tr bgcolor="#e3e9ff" id="tr20">
  <td>  <font color="black"><b> User Name : </b></font> </td>
  <td> 
	   <%
	  	////System.out.println(OwnerName);
	   String hodid="",managerhodid="",UserName="-",rsmid="";
	   sql="select VehicleCode from t_vehicledetails where VehicleRegNumber = '"+Vehicle+"'";
	   rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { 
   	      sql19="select UserName,hodid from t_userdetails where vehid = '"+rs2.getString("VehicleCode")+"'";
	      rs19=stmt19.executeQuery(sql19);
	      if(rs19.next()){
	      %>
      		<%-- <%=rs19.getString("UserName") %> --%> 
      		<% UserName=rs19.getString("UserName"); %>
      			
      			<%hodid=rs19.getString("hodid"); %>
      			<% } } %>

           <input type="text" name="oldusername" id="oldusername" readonly="readonly" value="<%=UserName%>" />
     </td>
  <%if(request.getParameter("vehcles").equalsIgnoreCase("Select")) { %>
  <td style="display:none;" id="showuser">
     		 <input type="hidden" name="olduser" id="olduser" value="">
       <a href = "#"  onclick = "showuser()"> <font color="blue" size="2">Edit user</font> </a>
       </td>
      <%  }else {%>
  
      <td>
     		 <input type="hidden" name="olduser" id="olduser" value="">
       <a href = "#"  onclick = "showuser()"> <font color="blue" size="2">Edit user</font> </a>
       </td>
      
      <%} %>
  </tr>
  
  <tr bgcolor="#e3e9ff">
  <td>  <font color="black"><b> Manager Name : </b></font> </td>
  <td> 
	   <%
	   String USERname="-";
	  	////System.out.println(OwnerName);
	   sql20="select FirstName,LastName,UserName,hodid from t_userdetails where SrNo = '"+hodid+"'";
	   rs20=stmt20.executeQuery(sql20);
	   if(rs20.next())
   	   { 
		   USERname=rs20.getString("FirstName")+" "+rs20.getString("LastName");
   	      %>
      		    <%managerhodid=rs20.getString("hodid"); %>
      			<%  } %>
      		<input type="text" name="oldmanagername" id="oldmanagername" readonly="readonly" value="<%=USERname%>" />
      			<%-- <%=USERname %> --%>
     </td>
     <%if(request.getParameter("vehcles").equalsIgnoreCase("Select")) { %>
     <td style="display:none;" id="showmanager">
     		 <input type="hidden" name="oldmanager" id="oldmanager" value="">
       <a href = "#"  onclick = "showmanager()"> <font color="blue" size="2">Edit Manager Name</font> </a>
       </td> 
       <%}else{ %> 
    	   <td>
   		 <input type="hidden" name="oldmanager" id="oldmanager" value="">
     <a href = "#"  onclick = "showmanager()"> <font color="blue" size="2">Edit Manager Name</font> </a>
     </td>
     
   <%    } %>
       
  
  </tr>
  
  <tr bgcolor="#e3e9ff">
  <td>  <font color="black"><b> RSM Name : </b></font> </td>
     <td> 
	   <%
	   String RSMname="-";
	  	////System.out.println(OwnerName);
	   String sql21="select srno,FirstName,LastName,UserName from t_userdetails where SrNo = '"+managerhodid+"'";
	   ResultSet rs21=stmt21.executeQuery(sql21);
	   if(rs21.next())
   	   { 
		   RSMname=rs21.getString("FirstName")+" "+rs21.getString("LastName");
   	      %>
   	      <%rsmid=rs21.getString("srno"); %>
      				
      		<input type="hidden" name="oldempname" value="<%=rs21.getString("UserName")%>" />
      		<input type="hidden" name="oldRSMname" value="<%=rs21.getString("UserName")%>" />	
      			
      			<%  }%>
	   <%=RSMname%>
     </td>
     
     <%if(request.getParameter("vehcles").equalsIgnoreCase("Select")) { %>
     <td style="display:none;" id="showrsm">
     		 <input type="hidden" name="oldrsm" id="oldrsm" value="">
       <a href = "#"  onclick = "showrsm()"> <font color="blue" size="2">Edit RSM Name</font> </a>
       </td> 
       <%}else{ %> 
    	   <td>
   		 <input type="hidden" name="oldrsm" id="oldrsm" value="">
     <a href = "#"  onclick = "showrsm()"> <font color="blue" size="2">Edit RSM Name</font> </a>
     </td>
     
   <%    } %>
     
     
     
  </tr>
  
   <tr bgcolor="#e3e9ff">
   <td colspan="2">
   <font color="black"><b>
   Create New User Id <input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected();"></input>
   </b></font>
   </td>
   </tr>
  	
  	           
 		       <tr bgcolor="#e3e9ff" style="display: none;" id="tr1">
  				<td><font color="red">*</font>  <font color="black"><b>New EMP Name : </b></font> </td>
 					<td> <input type="text" name="empname" id="empname" onblur="empval()"></input>
 					<label name="empn" id="empn" style="display: none;"><font color="red">Please Enter Emp Name</font></label>
    				</td>
    			</tr>
    			<tr bgcolor="#e3e9ff" style="display: none;" id="tr2">
  				<td><font color="red">*</font> <font color="black"><b>New EMP Code : </b></font> </td>
 					<td> <input type="text" name="empcode" id="empcode" onblur="codeval()"></input>
 					<label name="coden" id="coden" style="display: none;"><font color="red">Please Enter Emp code</font></label>
    				</td>
    			</tr>
    			<!-- <tr bgcolor="#e3e9ff" id="tr3">
	  			     <td><font color="red">*</font><font color="black"><b>Fleetview ID :</b> </font> </td>
	   				 <td> <input type="text" name="empid" id="empid" onblur="changehod()"> </input><div>Please enter FleetView Id as username</div></td>
     			 </tr> -->
    			 <tr bgcolor="#e3e9ff" style="display: none;" id="tr4">
	  			     <td><font color="red">*</font><font color="black"><b>New Fleetview ID :</b> </font> </td>
	   				 <td> <input type="text" name="newempid" id="newempid" onblur="newempidval()"> </input><div id="abc">Please enter FleetView Id as username</div>
	   				 <label name="newempidn" id="newempidn" style="display: none;"><font color="red">Please Enter New Fleetview Id</font></label></td>
     			 </tr>
     			<tr bgcolor="#e3e9ff" id="tr5" style="display: none;">
      			<td><font color="black"><b>HOD Email Id:</b> </font> </td>
      			<td><font color="black" id="HOD"></font> 
     			  &nbsp;&nbsp;&nbsp;
     		 <input type="hidden" name="oldHOD" id="oldHOD" value="">
       <a href = "#"  onclick = "showtext()"> <font color="blue" size="2">Change HOD</font> </a>
       
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr6" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>HOD:</b> </font> </td>
      			<td><input type="text" name="newHOD" id="newHOD" onblur="hodval()"></input> 
      			<label name="hodn" id="hodn" style="display: none;"><font color="red">Please Enter HOD</font></label>
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr7" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>Email:</b> </font> </td>
      			<td><input type="text" name="email" id="email" onblur="emailval()"></input> 
      			<label name="emailn" id="emailn" style="display: none;"><font color="red">Please Enter Email Id</font></label>
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr8" style="display: none;">
      			<td><font color="red">*</font><font color="black"><b>Mobile No:</b> </font> </td>
      			<td><input type="text" name="phno" id="phno" onblur="phnoval()"></input> 
      			<label name="phnon" id="phnon" style="display: none;"><font color="red">Please Enter Mobile Number</font></label>
      </td>
      </tr>
      <tr bgcolor="#e3e9ff" id="tr9" style="display: none;">
      			<td><font color="black"><b>Designation:</b> </font> </td>
      			<td><input type="text" name="deg" id="deg"></input> 
      </td></tr>
      <tr bgcolor="#e3e9ff" id="tr10" style="display: none;">
      			<td><font color="black"><b>Location:</b> </font> </td>
      			<td><input type="text" name="loc" id="loc"></input> 
      </td>
      </tr>
    			<tr bgcolor="#e3e9ff">
	  				<td> <font color="black"><b>Allocation Date : </b></font> </td>
	 				<td>  
	 					<input type="text" id="calender" name="calender" size="13" value="<%=sdt%>" readonly/>
	             	 	<script type="text/javascript">
			            	 Calendar.setup(
			             	{
			               	    inputField  : "calender",         // ID of the input field
			                	ifFormat    : "%Y-%m-%d",     // the date format
			                 	button      : "trigger"       // ID of the button
			             	}
			            );
	             		</script>
	             		<input type="hidden" name="checkstatus" id="checkstatus" value="No">
	    			</td>
    			</tr>
    			
 				 <%
 			}
 		%>
    
    <tr>
    <td>
    <div id="tp" name="tp"></div>
    </td>
    </tr>  
    <tr bgcolor="#e3e9ff">
	  				<td>&nbsp;&nbsp;&nbsp;&nbsp; <font color="black"><b>Allocation Date : </b></font> 
	 				 
	 					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="calender" name="calender" size="7" value="<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdt))%>" readonly/>
	             	 	<script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "calender",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "calender"       // ID of the button
		    }
		  );
		</script>
	             		<input type="hidden" name="checkstatus" id="checkstatus" value="No">
	    			</td>
    			</tr>
    			
   <tr align="center">




    <td colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Submit" value="Submit" class="formElement" onclick="redirect();"></td>
	
  </tr>
</table>

<!-- <div class="pace">
<div class="pace-progress" data-progress="50" data-progress-text="50%" style="-webkit-transform: translate3d(50%, 0px, 0px); -ms-transform: translate3d(50%, 0px, 0px); transform: translate3d(50%, 0px, 0px);"><div class="pace-progress-inner"></div></div>
<div class="pace-activity">
</div>
</div>gl -->
<!-- <div class="pace"><div class="pace-progress" data-progress="50" data-progress-text="50%" style="-webkit-transform: translate3d(50%, 0px, 0px); -ms-transform: translate3d(50%, 0px, 0px); transform: translate3d(50%, 0px, 0px);"><div class="pace-progress-inner"></div></div><div class="pace-activity"></div></div>gl
 --> <!-- </div>
 </td>
 </tr>
</table> -->
</form>
<%
}
catch(Exception e)
{
	out.print("Exception --->"+e);
}
finally
{
	con1.close();
	
}
%>



</jsp:useBean>
<%@ include file="footernew.jsp" %>


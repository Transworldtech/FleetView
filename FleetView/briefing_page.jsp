
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
			fleetview.getConnection1(MM_dbConn_DRIVER, MM_dbConn_STRING1,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	%>

	<%@page  import="java.util.Date" import="java.lang.Math" import="java.text.*"%>
	<%@ include file="headernew.jsp"%>
	<%-- <jsp:include page="headernew.jsp" /> --%>
	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
	
	
	<%!Connection con1 = null;
	int id = 0;%>
	<style>
#ctrip {
	visibility: hidden;
}
</style>
	<style type="text/css">
h1 {
	font-size: 22px;
	font-family: Arial;
	font-style: normal;
	font-weight: bold;
	margin: 14px 0px 7px 0px;
	padding: 0px;
}

input.text {
	background: #fff url(../../../images/shadow.gif) repeat-x top;
	border-bottom: 1px solid #ddd;
	border-left: 1px solid #c3c3c3;
	border-right: 1px solid #c3c3c3;
	border-top: 1px solid #7c7c7c;
	color: #333;
	font-size: 100%;
	margin: 0;
	padding: 2px 0;
}

h2 {
	font-size: 17px;
	font-family: Arial;
	font-style: normal;
	font-weight: bold;
	padding: 0px;
	margin: 14px 0px 7px 0px;
}

h3 {
	font-size: 14px;
	font-family: Arial;
	font-style: normal;
	font-weight: bold;
	padding: 0px;
	margin: 14px 0px 7px 0px;
}

p {
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
	line-height: 130%;
	margin: 7px 0px 7px 0px;
}

.popup {
	background-color: #98AFC7;
	 position: absolute; 
	/* position: fix; */
	 visibility: hidden; 
}

.popupnew {
	background-color: #98AFC7;
	position: absolute;
	visibility: visible;
}

ul {
	list-style-position: inside;
	list-style-type: square;
	margin: 7px 0px 7px 0px;
	padding: 0px;
}

li {
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
	margin: 1px 0px 1px 0px;
	padding: 0px;
}

a {
	color: #0000ff;
	text-decoration: underline;
}

a:hover {
	color: #0000ff;
	text-decoration: none;
}

.cbFormLabel {
	font-size: 12.5px;
	font-family: Arial;
	font-style: normal;
	font-weight: ;
}

.cbFormLabelError {
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
}

.cbFormError {
	color: #ff0000;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: bold;
	text-align: left;
	vertical-align: middle;
	margin-left: 5px;
}

.cbFormTable {
	border-collapse: collapse;
}

.cbFormTableRow {
	padding: 7px;
}

.cbFormLabelCell {
	text-align: left;
	vertical-align: top;
	width: auto;
	font-size: 12.5px;
	font-family: Arial;
	padding: 3px;
	white-space: normal;
}

.cbFormTextField {
	color: #000000;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
}

.cbFormTextArea {
	color: #000000;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
}

.cbFormPassword {
	color: #000000;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
	padding: 1px 1px 1px 1px;
}

.cbFormFieldCell {
	font-size: 12px;
	text-align: left;
	vertical-align: top;
	padding: 3px;
	white-space: nowrap;
}

.cbFormDataCell {
	text-align: left;
	vertical-align: top;
	width: auto;
	padding: 3px;
	white-space: normal;
}

select.select {
	color: #333;
	font-size: 100%;
	margin: 1px 0;
	padding: 1px 0 0;
	background: #fff url(../../../images/shadow.gif) repeat-x top;
	border-bottom: 1px solid #ddd;
	border-left: 1px solid #c3c3c3;
	border-right: 1px solid #c3c3c3;
	border-top: 1px solid #7c7c7c;
}

.cbHTMLBlockContainer {
	text-align: left;
	vertical-align: top;
	padding: 3px;
}

.cbFormNestedTable {
	height: 100%;
	border-collapse: collapse;
	padding: 0px;
	border: none;
}

.cbFormNestedTableContainer {
	text-align: left;
	vertical-align: top;
	padding: 0px;
}

.cbFormLabelRequired {
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: ;
}

.cbFormRequiredMarker {
	font-size: 12px;
	font-family: Arial;
	margin-left: 2px;
	font-style: normal;
	font-weight: bold;
}

.cbFormData {
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
}

.cbFormCalendar {
	padding-left: 5px;
}

.cbFormErrorMarker {
	margin-right: 5px;
}

.cbFormSelect {
	color: #000000;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
}

.cbFormFile {
	color: #000000;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
}

.cbFormDataLink {
	color: #0000ff;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
	text-decoration: underline;
}

input.button_text {
	overflow: visible;
	padding: 0 7px;
	width: auto;
}

.cbFormDataLink:hover {
	color: #0000ff;
	font-size: 12px;
	font-family: Arial;
	font-style: normal;
	font-weight: normal;
	text-decoration: none;
	76
	in
	the
	generated
	java
	file
	The
	code
	of
	method
	_jspService(HttpServletRequest,
	HttpServletResponse)
	is
	exceeding
	the
	65535
	bytes
	limit
}

.cbSubmitButton {
	font-weight: normal;
	width: auto;
	height: auto;
	margin: 0 3px;
}

.cbSubmitButton_hover {
	font-weight: normal;
	width: auto;
	height: auto;
	margin: 0 3px;
}

.cbSubmitButtonContainer {
	padding: 3px;
	text-align: center;
	vertical-align: middle;
}
</style>
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
		}  }
function toggleDetails(id, show)
{	//alert(show);
	//alert(id);
	var popup = document.getElementById("popup"+id);
	//var popup = document.getElementById("popup");
	//alert(popup);
       	if(show){popup.style.visibility = "visible";
       	popup.setfocus();
       	}
	else{popup.style.visibility = "hidden";	}
}
function Displayer(n)
{var check = document.getElementById('Section' + n);
if(check.style.display == 'none')
{check.style.display='inline';}
else{check.style.display='none';}
}
function showtext8()
{var autho=document.getElementById("AuthoD");
var email=document.getElementById("emailD");
if(autho.checked==true ){document.getElementById("authoR").style.display = "";
	document.getElementById("emailD").style.display = "";	}
	else{document.getElementById("authoR").style.display = "none";
		document.getElementById("emailD").style.display = "none";	}
	}
function showtext9()
{var authom=document.getElementById("AuthoM");
var email=document.getElementById("emailR1");
	if(authom.checked==true ){
	document.getElementById("authoR1").style.display = "";
	document.getElementById("emailR1").style.display = "";}
	else{		document.getElementById("authoR1").style.display = "none";
		document.getElementById("emailR1").style.display = "none";
		}
		}
		
function showtext10()
{	var authot=document.getElementById("AuthoT");
	var email=document.getElementById("emailR2");
	if(authot.checked==true )
	{document.getElementById("authoR2").style.display = "";
	document.getElementById("emailR2").style.display = "";	}
	else{		document.getElementById("authoR2").style.display = "none";
		document.getElementById("emailR2").style.display = "none";
			}	
}
function showtext11()
{	var authot=document.getElementById("Driver");
	var Val1 = document.getElementsByName("DVR");
	  for ( var i = 0; i < Val1.length; i++ ) 
		  {	if ( Val1[i].checked==true)
		 		{	TJrm=Val1[i].value;
	 			if(Val1[i].value=="Driver" )
	 			{document.getElementById("driver").style.display = "";	}
	 			else{document.getElementById("driver").style.display = "none";
	 			}
	 			if(Val1[i].value=="Route" )	{
	 				document.getElementById("route").style.display = "";
	 			}else{	document.getElementById("route").style.display = "none";
	 			}
	 			if(Val1[i].value=="Vehicle" )
	 			{document.getElementById("vehicle").style.display = "";
 			}	else{	document.getElementById("vehicle").style.display = "none";
	 			}	 }  }
}
function showtext12()
{
	var authot=document.getElementById("Route");
	if(authot.checked==true )
	{document.getElementById("route").style.display = "";
	}
	else{document.getElementById("route").style.display = "none";
		}
	}
function showtext19()
{	var authot=document.getElementById("Vehicle");
	if(authot.checked==true )
	{document.getElementById("vehicle").style.display = "";
	}
	else{document.getElementById("vehicle").style.display = "none";
		}}
var TJrm,TPCD,TPND;
function showtext5()
{
	try{var Val1 = document.getElementsByName("Jrm");
	  for ( var i = 0; i < Val1.length; i++ ) 
		  {
	 		if ( Val1[i].checked==true)
		 		{TJrm=Val1[i].value;
	 			if ( Val1[i].value=='NO'){}
	 			else{}
		 	 }	
		  }
	}catch(e)
	{
	alert(e);
		}
}
function showtext6()
{	try{
		var Val1 = document.getElementsByName("PNd");
	  for ( var i = 0; i < Val1.length; i++ ) 
		  {
	 		if ( Val1[i].checked==true)
		 		{TPND=Val1[i].value;
	 			if ( Val1[i].value=='NO')
	 			{}else{}
		 	 }	
		  }
	}catch(e)
	{
	alert(e);
		}
}
function showtext7()
{
	try{
		
		var Val1 = document.getElementsByName("PCD");
	  for ( var i = 0; i < Val1.length; i++ ) 
		  {
	 		if ( Val1[i].checked==true)
		 		{
	 			TPCD=Val1[i].value;
	 			if ( Val1[i].value=='NO')
	 				{}
	 			else
	 			{}
		 	 }	
		  }
	}catch(e)
	{
	alert(e);
		}
}
function addUser2() {
	try
	{var src = document.brief.resources1;
    var dest = document.brief.assigned2;
    for(var count=0; count < src.options.length; count++) {
        if(src.options[count].selected == true) {
                var option = src.options[count];
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
	}
	catch(e)
	{
		alert(e);
	}
}
function removeUser2() {
    var src =document.brief.assigned2;
    
    var dest =  document.brief.resources1;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);                        
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);                        
                 }
                count--;
        }
    }
}
var goalCount=0;
function addUser3() {
	try
	{
	
    if(goalCount>=3)
    	{
    	alert("Maximum 3 goals for trip can be set. !!!");
    	}
    
	var src = document.brief.resources3;
    
    var dest = document.brief.assigned4;
 
    for(var count=0; count < src.options.length; count++) {
        
        if(src.options[count].selected == true && goalCount<3 ) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) 
                 {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
                goalCount++;
            }
        }    
	  }
	catch(e)
	{
		alert(e);
	}
}
function removeUser3() {
    var src =document.brief.assigned4;
    
    var dest =  document.brief.resources3;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                        
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                        
                 }
                count--;
                goalCount--;
        }
    }
}
function addUser4() {
	try
	{
	
    var src = document.brief.resources5;
    
    var dest = document.brief.assigned6;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
	}
	catch(e)
	{
		alert(e);
	}
}
function removeUser4() {
    var src =document.brief.assigned6;
    
    var dest =  document.brief.resources5;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
}
function GetJRM(DriveId,BrifId,TripId)
{
		try{
						showtext5();
						var t=0;
						var TJrm = document.getElementById("TTJRM").value;	
						 var res ="-"
						 var per = "-";
			if(TJrm =="Yes")
			 {
				per = document.getElementById("percent").value;
						 }	
			var ajaxRequest;  // The variable that makes Ajax possible!
						try{
							ajaxRequest = new XMLHttpRequest();
						}  
						catch (e)
						{							try
							{								ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
							} 
							catch (e)
							{								try
								{									ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
								} 
								catch (e)
								{	alert("Your browser broke!");
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
								var result1;
								result1=reslt;
								result1=result1.replace(/^\s+|\s+$/g,'');
								if(result1=="Updated")
									{
									GetScore(DriveId,TripId);
									document.getElementById("TTJRM").value;
									}
									//	alert("Record updated Succesfully");
							
								}catch(e)
								{
								alert(e);
								}
							} 
						};		 
				
						var queryString = "?ChkJrm="+TJrm+"&per="+per+"&res="+res+"&DriveId="+DriveId+"&BrifId="+BrifId+"";
						ajaxRequest.open("GET","driver_briefing_Update_Ajax4.jsp" + queryString, true);
						ajaxRequest.send(null); 
						
						}
					    catch(e)
						{
							alert(e);
						}
				}
function GetScore(DriveId,TripId)
			{
				try{
					var b=0;
					
					var scrNDH=document.getElementById("scr_N_DH").value;
					var scrNND=document.getElementById("scr_N_ND").value;
					var scrNCD=document.getElementById("scr_N_CD").value;
					var scrNDVI=document.getElementById("scr_N_DVI").value;
					var TNScr=document.getElementById("T_N_Scr").value;
					var ajaxRequest;  // The variable that makes Ajax possible!
					try{// Opera 8.0+, Firefox, Safari
						ajaxRequest = new XMLHttpRequest();	}  
					catch (e)
					{// Internet Explorer Browsers
						try{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
						catch (e)
						{try{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");} 
							catch (e)
							{// Something went wrong
								alert("Your browser broke!");return false;}}}
					ajaxRequest.onreadystatechange = function()
					{	if(ajaxRequest.readyState == 4)
						{try{	
							var reslt=ajaxRequest.responseText;
					
							reslt=reslt.replace(/^\s+|\s+$/g,'');
							var respo=reslt.split("~");
							if(respo[0]=="Updated"){
								alert("Record updated Succesfully");
								document.getElementById("Tol_N_Scr").innerHTML = respo[1];
								document.getElementById("Tab7").value="1";
								flg6=1;
								}else if(respo[0]=="NoUpdated")
								{		alert("New Point should be less than or equal to Points Allocated ");
								flg6=0;
								}							
							}catch(e)
							{alert(e);}}};
						
					var queryString = "?&scrNDH="+scrNDH+"&scrNND="+scrNND+"&scrNCD="+scrNCD+"&scrNDVI="+scrNDVI+"&DriveId="+DriveId+"&TripId="+TripId+"&TNScr="+TNScr+"";
					
					ajaxRequest.open("POST", "driver_briefing_Score_Ajax.jsp" + queryString, true);
					ajaxRequest.send(null); 
					}					
				    catch(e)					{						alert(e);
					}
			}
function GetMail(DriveId,BrifId,TripId,StartPlc,EndPlc)
		{
			try{
				var b=0;
				
				var lr = document.getElementById("authoReason").value;
				var EmailId = document.getElementById("emailD").value;
				if(lr=="")
				{
				alert("Please Enter Reason");
				}
				else if(EmailId=="")
				{
				alert("Please Enter Email ID");
				}
				else
					{
				
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
					
						var result1;
						result1=reslt;
						result1=result1.replace(/^\s+|\s+$/g,'');
                     var r=result1.split("~")
						
						if(r[0]=="Updated")
						{
							alert("Escalation Mail Sent Successfully ");
							
						}
					
						}catch(e)
						{
						alert(e);
						}
					} 
				};
				 
				var queryString = "?lr="+lr+"&DriveId="+DriveId+"&EmailId="+EmailId+"&TripId="+TripId+"&BrifId="+BrifId+"&StPlc="+StartPlc+"&EdPlc="+EndPlc+"";
				ajaxRequest.open("GET", "driver_briefing_LMail_Ajax.jsp" + queryString, true);
				ajaxRequest.send(null); 
				}
				}
			    catch(e)
				{
					alert(e);
				}
		
		}
function GetMail1(DriveId,BrifId,TripId,StartPlc,EndPlc)
		{
			try{
				var b=0;
				
				var mr = document.getElementById("authoReason1").value;
				
				var EmailId = document.getElementById("emailR1").value;
				if(mr=="")
				{
				alert("Please Enter Reason");
				}
				else if(EmailId=="")
				{
				alert("Please Enter Email ID");
				}
				
				else
					{
				
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
					
						var result1;
						result1=reslt;
					
						result1=result1.replace(/^\s+|\s+$/g,'');
						var r=result1.split("~")
						
						if(r[0]=="Updated")
							alert("Mail Sent Successfully ");
					
						}catch(e)
						{
						alert(e);
						}
					} 
				};
				 
				var queryString = "?mr="+mr+"&DriveId="+DriveId+"&TripId="+TripId+"&EmailId="+EmailId+"&BrifId="+BrifId+"&StPlc="+StartPlc+"&EdPlc="+EndPlc+"";
				ajaxRequest.open("GET", "driver_briefing_MMail_Ajax.jsp" + queryString, true);
				ajaxRequest.send(null); 
				}
				}
			    catch(e)
				{
					alert(e);
				}
	}
		function GetMail2(DriveId,BrifId,TripId,StartPlc,EndPlc)
		{
			try{
				var b=0;
				
				var tr = document.getElementById("authoReason2").value;
				
				var EmailId = document.getElementById("emailR2").value;
				if(tr=="")
				{
				alert("Please Enter Reason");
				}
				else if(EmailId=="")
				{
				alert("Please Enter Email ID");
				}
				
				else
					{
				
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
					
						var result1;
						result1=reslt;
						result1=result1.replace(/^\s+|\s+$/g,'');
                   var r=result1.split("~")
						
						if(r[0]=="Updated")
							alert("Mail Sent Successfully ");
						}catch(e)
						{
						alert(e);
						}
					} 
				};
				 
				var queryString = "?tr="+tr+"&DriveId="+DriveId+"&TripId="+TripId+"&EmailId="+EmailId+"&BrifId="+BrifId+"&StPlc="+StartPlc+"&EdPlc="+EndPlc+"";
				ajaxRequest.open("GET", "driver_briefing_TMail_Ajax.jsp" + queryString, true);
				ajaxRequest.send(null); 
				}
				}
			    catch(e)
				{
					alert(e);
				}				
		}	
		
function GetMail4(DriveId,BrifId,TripId,StartPlc,EndPlc)
		{
			try{
				var b=0;
				
				var tr = document.getElementById("authoReason11").value;
				var EmailId = document.getElementById("emailR11").value;
						
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
					
						var result1;
						result1=reslt;
					
						result1=result1.replace(/^\s+|\s+$/g,'');
						var r=result1.split("~");
						
						if(r[0]=="Updated")
							{alert("Mail Sent Successfully ");
							document.getElementById("Tmail").style.display = "none";
							}
					
						}catch(e)
						{
						alert(e);
						}
					} 
				};
				 
				var queryString = "?tr="+tr+"&DriveId="+DriveId+"&TripId="+TripId+"&EmailId="+EmailId+"&BrifId="+BrifId+"&StPlc="+StartPlc+"&EdPlc="+EndPlc+"";
				ajaxRequest.open("GET", "driver_briefing_RMail_Ajax.jsp" + queryString, true);
				ajaxRequest.send(null); 
				}
			    catch(e)
				{
					alert(e);
				}	}
		
function GetGoal(DriveId,BrifId,TripId)
{
	try{
		var b=0;
		var goal="";
		var src = document.brief.assigned4;
		for(var count=0; count < src.options.length; count++) {
			    var option = src.options[count];
			    if(count==0)
			    	goal+=option.value;
			    else
			    	goal+="~"+option.value;
			  
				}
		if(goal=="")
		{
		alert("Please Enter Goal");
		}
		else
			{
		
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
				var result1;
				result1=reslt;
				result1=result1.replace(/^\s+|\s+$/g,'');
				if(result1=="Updated")
					alert("Record updated Succesfully");
				document.getElementById("Tab6").value="1";
				}catch(e)
				{
				alert(e);
				}
			} 
		};
		 
		var queryString = "?goal="+goal+"&DriveId="+DriveId+"&BrifId="+BrifId+"";
		ajaxRequest.open("GET", "driver_briefing_Update_Ajax3.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		}
	    catch(e)
		{
			alert(e);
		}
		
}
function GetDmc(DriveId,BrifId,TripId)
{
	try{
		showtext6();
		showtext7();
	var h=0;
	var dmc1="";
	
	var src = document.brief.assigned6;
	for(var count=0; count < src.options.length; count++) {
		    var option = src.options[count];
		    if(count==0)
		    	dmc1+=option.value;
		    else
		    	dmc1+="~"+option.value;
		  
			}
	if(dmc1=="")
	{
	alert("Please Enter DMC/Counsellor Input ");
	}
	else
		{
	
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
			var result1;
			result1=reslt;
			result1=result1.replace(/^\s+|\s+$/g,'');
			if(result1=="Updated")
				alert("Record updated Succesfully");
			document.getElementById("Tab5").value="1";
		
			}catch(e)
			{
			alert(e);
			}
		} 
	};
	 
	var queryString = "?dmc1="+dmc1+"&DriveId="+DriveId+"&BrifId="+BrifId+"&TPCD="+TPCD+"&TPND="+TPND+"";	
		ajaxRequest.open("GET", "driver_briefing_Update_Ajax2.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		}
	    catch(e)
		{
			alert(e);
		}
	 
	
}
function GoalCategoery()
{
	try{
		var goalCat=document.getElementById("GoalCat").value;
	
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
				  var r1;
				  var a;
				  var i;
				 
             	  reslt=reslt.replace(/^\s+|\s+$/g,'');
             	
             	 r1=reslt;
 			
            r1=r1.toString();
              strLen = r1.length;
              r1 = r1.slice(0,strLen-1);
              
              r1 = r1.split(",");
              
        	  document.getElementById('resources3').length = 0;
        	  
              for(var count=0; count < r1.length; count++) 
              {          	
           	  
                  var opt = document.createElement("option");
          		opt.setAttribute("value",r1[count]);
          		opt.innerHTML = r1[count];
           document.getElementById("resources3").appendChild(opt);
          	}
        	  }
              
        				catch(e)
				{
				alert(e);
				}
			} 
		};
		 
		var queryString = "?cat="+goalCat+"";	
			ajaxRequest.open("GET", "Goal_CAT_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			
		    catch(e)
			{
				alert(e);
			}
	}
function IncCategoery()
{
	try{
		var IncCat=document.getElementById("IncCat").value;
		
		var ajaxRequest;  // The variable that makes Ajax possible!
		try{
			
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
				  var r1;
				  var a;
				  var i;
             	  reslt=reslt.replace(/^\s+|\s+$/g,'');
                   	 r1=reslt;
            r1=r1.toString();
            
              strLen = r1.length;
              r1 = r1.slice(0,strLen-1);     
            r1 = r1.split(",");
            
        	  document.getElementById('resources1').length = 0;
        	   for(var count=0; count < r1.length; count++) 
              {          	
                  var opt = document.createElement("option");
          		opt.setAttribute("value",r1[count]);
          		opt.innerHTML = r1[count];
                
          		
           document.getElementById("resources1").appendChild(opt);
          	}
        	  }
            	catch(e)
				{
				alert(e);
				}
			} 
		};
		 
		var queryString = "?cat="+IncCat+"";	
			ajaxRequest.open("GET", "Inc_CAT_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			
		    catch(e)
			{
				alert(e);
			}
		
	}
function chkCategoery()
{
	try{
		var chkCat=document.getElementById("DmcCat").value;
		var ajaxRequest;  // The variable that makes Ajax possible!
		try{
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
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
				  var r1;
				  var a;
				  var i;
				 
             	  reslt=reslt.replace(/^\s+|\s+$/g,'');
             	
             	 r1=reslt;
 			
            r1=r1.toString();
              strLen = r1.length;
              r1 = r1.slice(0,strLen-1);
              r1 = r1.split(",");
        	  document.getElementById('resources5').length = 0;
              for(var count=0; count < r1.length; count++) 
              {          	
                 var opt = document.createElement("option");
          		opt.setAttribute("value",r1[count]);
          		opt.innerHTML = r1[count];
          		
           document.getElementById("resources5").appendChild(opt);
          	}
              
 	}	catch(e)
				{
				alert(e);
				}
			} 
		};
		 
		var queryString = "?cat="+chkCat+"";	
			ajaxRequest.open("GET", "DMC_CAT_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			
		    catch(e)
			{
				alert(e);
			}
} 
function GetInci(DriveId,BrifId,TripId)
{
	try{
	var b=0;
	var inci1="";
	
	var src = document.brief.assigned2;
	for(var count=0; count < src.options.length; count++) {
		    var option = src.options[count];
		    if(count==0)
		    	inci1+=option.value;
		    else
		    	inci1+="~"+option.value;
		  
			}
	if(inci1=="")
	{
	alert("Please Enter Incident");
	}
	else
		{
	
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
			var result1;
			result1=reslt;
			result1=result1.replace(/^\s+|\s+$/g,'');
			if(result1=="Updated")
				alert("Record updated Succesfully");
			document.getElementById("Tab4").value="1";
		
			}catch(e)
			{
			alert(e);
			}
		} 
	};
	 
	var queryString = "?inci1="+inci1+"&DriveId="+DriveId+"&BrifId="+BrifId+"";
	ajaxRequest.open("GET", "driver_briefing_Update_Ajax1.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	}
    catch(e)
	{
		alert(e);
	} 
}

function GetNews(DriveId,BrifId,TripId,driveraddress)
{
	try{
	var b=0;
	var inci1="";
	
	//var src = document.brief.Innewletter;
	var address=document.getElementById("driveradd").value;
	//alert(address);
	var src =document.getElementById("Innewletter").value;
	//alert(src);
	inci1=src;
/* 	for(var count=0; count < src.options.length; count++) {
		    var option = src.options[count];
		    if(count==0)
		    	inci1+=option.value;
		    else
		    	inci1+="~"+option.value;
		  
			} */
	if(inci1=="")
	{
	alert("Please Select Newsletter");
	}
	else
		{
	
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
			var result1;
			result1=reslt;
			result1=result1.replace(/^\s+|\s+$/g,'');
			if(result1=="Updated")
				alert("Record Updated Succesfully");
			document.getElementById("Tab10").value="1";
		
			}catch(e)
			{
			alert(e);
			}
		} 
	};
	 
	var queryString = "?inci1="+inci1+"&DriveId="+DriveId+"&BrifId="+BrifId+"&DriverAddress="+address+"";
	ajaxRequest.open("GET", "driver_briefing_Update_news.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	}
    catch(e)
	{
		alert(e);
	} 
}


function GetFinal(DriveId,BrifId)
{
	try{
		
		var Tab4=document.getElementById("Tab4").value;
		var Tab5=document.getElementById("Tab5").value;
		var Tab6=document.getElementById("Tab6").value;
		var Tab10=document.getElementById("Tab10").value;
		//var Tab7=document.getElementById("Tab7").value;
		
		//alert(Tab4+" : "+Tab5+" : "+Tab6+" : "+Tab7); 
		
		if(Tab4=="0")
			{ 
			alert("Tab '5. Incidents Shared' have not been save properly. \n Kindly save it.");
			}
		else if(Tab10=="0")
		{
		alert("Tab '6. Personal Engagement' have not been save properly. \n Kindly save it.");
		}
		else if(Tab5=="0")
			{
			alert("Tab '7. DMC/Trainer Input' have not been save properly. \n Kindly save it.");
			}
		else if(Tab6=="0")
			{
			alert("Tab '8. Goal Of Conversation' have not been save properly. \n Kindly save it.");
			}
		else{
		
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
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				if(reslt=="Briefing is complete")
					alert("Your Briefing Completed Succesfully");
				
				window.location.href="Driver_briefing_New.jsp";
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};
			
		
		var queryString = "?DriveId="+DriveId+"&BrifId="+BrifId+"";
		ajaxRequest.open("GET", "driver_briefing_Final_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 
			}
	}
	    catch(e)
		{
			alert(e);
		}
}
 
function GoalReset()
{
var src3 = document.brief.assigned4;
var dest3 = document.brief.resources3;
for(var count=0; count < src3.options.length; count++) {
var option = src3.options[count];
var newOption = document.createElement("option");
newOption.value = option.value;
newOption.text = option.text;
newOption.title= option.title;
newOption.selected = false;
try {
dest3.add(newOption, null); //Standard
src3.remove(count, null);
}catch(error) {
dest3.add(newOption); // IE only
src3.remove(count);
}
count--;
}
}
function IncReset()
{
var src4 = document.brief.assigned2;
var dest4 = document.brief.resources1;
for(var count=0; count < src4.options.length; count++) {
var option = src4.options[count];
var newOption = document.createElement("option");
newOption.value = option.value;
newOption.text = option.text;
newOption.title= option.title;
newOption.selected = false;
try {
dest4.add(newOption, null); //Standard
src4.remove(count, null);
}catch(error) {
dest4.add(newOption); // IE only
src4.remove(count);
}
count--;
}
}
function DmcReset()
{
var src5 = document.brief.assigned6;
var dest5 = document.brief.resources5;
for(var count=0; count < src5.options.length; count++) 
{
var option = src5.options[count];
var newOption = document.createElement("option");
newOption.value = option.value;
newOption.text = option.text;
newOption.title= option.title;

newOption.selected = false;
try {
dest5.add(newOption, null); //Standard
src5.remove(count, null);
}
catch(error) {
dest5.add(newOption); // IE only
src5.remove(count);
}
count--;
}
}
function JrmReset() {
	 var ele = document.getElementsByName("Jrm");
	 //var per1=document.brief.percent.value="";
	 var res1=document.brief.Reason1.value="";
	 document.getElementById("tr2").style.display = "none";
	document.getElementById("tr3").style.display = "none";
	   for(var i=0;i<ele.length;i++)
	      ele[i].checked = false;
}
function DReset()
{
	try{
		document.brief.authoReason.value='';
	}
	catch(e)
	{
		alert(e);
	}
	
}
function MReset()
{
	try{
		document.brief.authoReason1.value='';
	}
	catch(e)
	{
		alert(e);
	}
	
}
function LReset()
{
	try{
		document.brief.authoReason2.value='';
	
	}
	catch(e)
	{
		alert(e);
	}
	
}
function open2(TripId,DriveId,BrifId)
{
	testwindow1 = window.open("ViewPlan.jsp?tripid="+TripId+"&driverid="+DriveId+"&briefid="+BrifId,"ViewJourneyPlanning","width=800,height=600,scrollbars=yes");
		testwindow1.moveTo(250,250);
			
}
function open1(DriveId,BrifId)
{
	testwindow = window.open("journeyplanning.jsp?driverid="+DriveId+"&briefid="+BrifId,"JourneyPlanning","width=800,height=600,scrollbars=yes");
		testwindow.moveTo(250,250);
}

function openJF(BriStartPlc,BriEndPlc)
{
	testwindow = window.open("lastJrmFeedback.jsp?startplace="+BriStartPlc+"&endplace="+BriEndPlc,"JRMFeedback","width=800,height=600,scrollbars=yes");
		testwindow.moveTo(250,250);
}

function openNM(BriStartPlc,BriEndPlc)
{
	testwindow = window.open("lastNearMiss.jsp?startplace="+BriStartPlc+"&endplace="+BriEndPlc,"NearMiss","width=800,height=600,scrollbars=yes");
		testwindow.moveTo(250,250);
}


function OpenF()
{
	var DriveId=document.getElementById("DriveId").value;
	var BrifId=document.getElementById("BrifId").value;
	 
	
	var agree=confirm("Do you want to delete briefing record for Driver Id : "+DriveId+", Brief Id : "+BrifId+"?");
if(agree)
{
	try{var ajaxRequest;  // The variable that makes Ajax possible!
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
					reslt=reslt.replace(/^\s+|\s+$/g,'');
					if(reslt=="close"){ 
						//alert("For DriveId:"+DriveId+", Brief Id:"+BrifId+" has been deleted Succesfully");
					
					window.location.href="Driver_briefing_New.jsp";
					}
					else{
						//alert("Error : Record Not Deleted");
					}
					}catch(e)
					{
					alert(e);
					}
				} 
			};
			
			
			var queryString = "?DriveId="+DriveId+"&BrifId="+BrifId+"";
			ajaxRequest.open("GET", "driver_briefing_Close_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			
		}
		    catch(e)
			{
				alert(e);
			}
	
	}
else
{
	//alert("Record not deleted !!!");
}
}
function OpenE()
{
	window.location.href="Driver_briefing_New.jsp";
	
}
function GetVisibleTable()
{
	try{
		
		var Val1 = document.getElementsByName("Trip");
		
	  for ( var i = 0; i < Val1.length; i++ ) 
		  {
		 // alert(Val1[i].value);
		 // alert(Val1[i].checked);
	 		if ( Val1[i].checked==true)
		 		{
	 			TPCD=Val1[i].value;
	 			
	 		//alert(TPCD);
	 			if ( Val1[i].value=='Driver')
	 			//	if ( TPCD=='Driver')
	 				{
	 					
	 				 //document.getElementById("DivDriver").style.display = "inline";			
	 				 document.getElementById("DivDriver").style.display = "inline";
	 				document.getElementById("DivVehicle").style.display = "none";
	 				document.getElementById("DivRoute").style.display = "none";
		 			}
	 			
	 			 if ( Val1[i].value=='Vehicle') 
	 			//if ( TPCD=='Vehicle')
 				{
 				 document.getElementById("DivDriver").style.display = "none";			
 				document.getElementById("DivVehicle").style.display = "inline";
 				document.getElementById("DivRoute").style.display = "none";
	 			}
	 			if ( Val1[i].value=='Route')
	 			//if ( TPCD=='Route')
 				{
 				 document.getElementById("DivDriver").style.display = "none";			
 				document.getElementById("DivVehicle").style.display = "none";
 				document.getElementById("DivRoute").style.display = "inline";
	 			}
 			
	 			
		 	 }	
		  }
	}catch(e)
	{
	alert(e);
		}
	}
function ChkDh()
{
	
	var ChkscrNDH=document.getElementById("Chkscr_N_DH");
	if(ChkscrNDH.checked==true)
		{
		document.getElementById("LblDH").innerHTML=document.getElementById("MaxPointRH").value;		
		document.getElementById("scr_N_DH").value=document.getElementById("MaxPointRH").value;
		}else
			{document.getElementById("LblDH").innerHTML="0";
			document.getElementById("scr_N_DH").value="0";
			}
	
}
function ChkND()
{try{
	var ChkscrNND=document.getElementById("Chkscr_N_ND");
	
	if(ChkscrNND.checked==true)
		{
	
		document.getElementById("LblND").innerHTML=document.getElementById("MaxPointND").value;
		document.getElementById("scr_N_ND").value=document.getElementById("MaxPointND").value;
		}else
		{
		
			document.getElementById("LblND").innerHTML="0";
			document.getElementById("scr_N_ND").value="0";
			}
	}
	catch(e)
	{
		alert(e);
	}
	
}
function ChkCD()
{try{
	var ChkscrNCD=document.getElementById("Chkscr_N_CD");
	
	if(ChkscrNCD.checked==true)
		{
	
		document.getElementById("LblCD").innerHTML=document.getElementById("MaxPointCD").value;
		document.getElementById("scr_N_CD").value=document.getElementById("MaxPointCD").value;
		}else
		{
		
			document.getElementById("LblCD").innerHTML="0";
			document.getElementById("scr_N_CD").value="0";
			}
	}
	catch(e)
	{		alert(e);
	}	
}
</script>
<script language="javascript"><!--
function checkvalue(val)
 {
	
	 	 if(val=="Yes")
		 {	 
	        	 document.getElementById('oldModelRow').style.display='block';
	 	       document.getElementById('newModelRow').style.display='block';
  	
	 	  }	
	 	   else
	 	   {	   
	 		  document.getElementById('oldModelRow').style.display='none';
	 	      document.getElementById('newModelRow').style.display='none';
	 	   }

		 if(val=="Select")
		 {
			 document.getElementById('oldModelRow').style.display='none';
	 	      document.getElementById('newModelRow').style.display='none';
	 	      
			}	 
	 	    
 }



window.onload = function() {
	
	    	  document.getElementById('oldModelRow').style.display='none';
	          document.getElementById('newModelRow').style.display='none';	      
	
			  document.getElementById('ModelChange1').checked=true;
			  document.getElementById('ModelChange').checked=false;	

}



function ResetVehicleChange()
{
	try{
		document.getElementById("VehChange").checked = false;
		document.getElementById("ModelChange").checked = false;
		document.getElementById("oldModel").value="";
		document.getElementById("newModel").value="";
		document.getElementById("DriverChange").checked = false;
		
	}
	catch(e)
	{
		alert(e);
	}
	
}

function checkField(fieldname)
{
	var numbers = /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/;  
    if(fieldname.match(numbers)) 
	{
	alert ("Only alphanumeric characters and spaces are valid in this field");
	return false;
	}
	return true
}


function validateModel(BrifId)
{ 
	var oldModel = document.getElementById("oldModel").value;
	var newModel = document.getElementById("newModel").value;
	oldModel=oldModel.trim();
	newModel=newModel.trim();  

	if(!(document.getElementById("ModelChange1").checked))
	{
				if(oldModel.length == 0){
				alert("Please enter old Model!");
				return false;
				}

				var numbers = /[\sA-Z,a-z,1234567890]/;  
			    if(!oldModel.match(numbers)) 
				{
				alert ("Please enter characters and no only in old model!");
				return false;
				}
				
				if(newModel.length == 0){
					alert("Please enter New Model!");
					return false;
				}
			
				var numbers = /[\sA-Z,a-z,1234567890]/;  
			    if(!newModel.match(numbers)) 
				{
				alert ("Please enter characters and no only in new model!");
				return false;
				}			
	}
		
	SaveVehicleChange(BrifId);


	
}

function checkModel()
{ 
	var oldModel = document.getElementById("oldModel").value;
	//var newModel = document.getElementById("newModel").value;
	oldModel=oldModel.trim();
	//newModel=newModel.trim();  

	if(!(document.getElementById("ModelChange1").checked))
	{
				if(oldModel.length == 0){
				alert("Please enter old Model!");
				return false;
				}

				var numbers = /[\sA-Z,a-z,1234567890]/;  
			    if(!oldModel.match(numbers)) 
				{
				alert ("Please enter characters and no only in old model!");
				return false;
				}
				
				
	}
		
	//SaveVehicleChange(BrifId);


	
}

function checkModel1()
{ 
	//var oldModel = document.getElementById("oldModel").value;
	var newModel = document.getElementById("newModel").value;
//	oldModel=oldModel.trim();
	newModel=newModel.trim();  

	if(!(document.getElementById("ModelChange1").checked))
	{
				
				
				if(newModel.length == 0){
					alert("Please enter New Model!");
					return false;
				}
			
				var numbers = /[\sA-Z,a-z,1234567890]/;  
			    if(!newModel.match(numbers)) 
				{
				alert ("Please enter characters and no only in new model!");
				return false;
				}			
	}
		
	//SaveVehicleChange(BrifId);


	
}


function SaveVehicleChange(BrifId)
{
	try{
		
		var VehChange = document.getElementById("VehChange").value;
		var ModelChange = document.getElementById("ModelChange").value;
		var ModelChange1 = document.getElementById("ModelChange1").value;
		var oldModel = document.getElementById("oldModel").value;
		var newModel = document.getElementById("newModel").value;		
		var DriverChange = document.getElementById("DriverChange").value;

		if(document.getElementById("ModelChange").checked)
		{
			ModelChange='Yes';
		}
		else
		{
			ModelChange='No';	
		}

		if(document.getElementById("ModelChange1").checked)
		{
			ModelChange1='Yes';
		}
		else
		{
			ModelChange1='No';	
		}
		//alert(ModelChange);
		
	}catch(e)
	{
		alert(" e "+e);
	}

	if(ModelChange=='Yes')
	{		
		//validateModel();
		
	}
	else
	{
		
	}	
	
	
		
	try{	
			
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
			
				var result1;
				result1=reslt;
			
				result1=result1.replace(/^\s+|\s+$/g,'');
				//var r=result1.split("~");
				
				if(result1=="true")
					{
						alert("Record Saved Successfully ");
					}
				else
				{
					alert("Error in saving record. Please try again!");
				}
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};
	 
		var queryString = "?VehChange="+VehChange+"&ModelChange="+ModelChange+"&oldModel="+oldModel+"&BrifId="+BrifId+"&newModel="+newModel+"&DriverChange="+DriverChange+"";
		ajaxRequest.open("GET", "saveVehicleChange_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
	    catch(e)
		{
			alert(e);
		}
			}
			
			function clear1(){
				//alert("Hi");
				//document.getElementById("driveradd").value="";
				// $("#name").prop('readonly', false);
			 document.getElementById("driveradd").removeAttribute("readonly");
			 return false;
				
			}
			
			

</script>
	<%@ include file="include_briefingpage1.jsp"%>

<%-- <jsp:include page="include_briefingpage1.jsp" /> --%>
<%-- <%!

		ResultSet rs11;
%>
	<%
		try {

				con1 = fleetview.ReturnConnection();
				Statement st = con1.createStatement();
				Statement st2 = con1.createStatement();
				Statement st3 = con1.createStatement();
				Statement st4 = con1.createStatement();
				Statement st6 = con1.createStatement();
				Statement s = con1.createStatement();
				Statement s1 = con1.createStatement();
				Statement s2 = con1.createStatement();
				Statement s3 = con1.createStatement();
				Statement st16 = con1.createStatement();
				Statement st20 = con1.createStatement();
				Statement st21 = con1.createStatement();
				Statement st22 = con1.createStatement();
				Statement strep = con1.createStatement();
				Statement std=con1.createStatement();
				Statement stn=con1.createStatement();
				Statement stnews=con1.createStatement();
				Statement nst=con1.createStatement();
				String DriveId = request.getParameter("driverid");
				final String drverid = request.getParameter("driverid");
				final String drivernam = request.getParameter("drivername");
				final String drivername = (String) session
						.getAttribute("drivername");
				final String driverid = (String) session
						.getAttribute("driverid");
				final String transporterName = (String) session
						.getAttribute("tname");
				final String transname = request.getParameter("trans");
				String DriverName = request.getParameter("drivername");
				String BrifId = request.getParameter("briefId");
				String StartP = request.getParameter("startP");
				String startcode = request.getParameter("startcode");
				String endcode = request.getParameter("endcode");
				String VehType1 = request.getParameter("VehType");
				String EndP1 = request.getParameter("endP11");
				String MobNo = request.getParameter("mobno");
				String CleanerId = request.getParameter("CleanerId");
				String CleanerName = request.getParameter("CleanerName");
				String Brifdate = request.getParameter("BrifDate");
				String date11 = new SimpleDateFormat("dd-MMM-yyyy hh:mm")
						.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.parse(Brifdate));
				String TripId = request.getParameter("TripId");
				String Transporter = request.getParameter("transporter");
				session.setAttribute("drivername", drivernam);
				session.setAttribute("driverid", drverid);
				session.setAttribute("tname", transname);
				String msg = "", VehCode2 = "";
				String limit = "10";
				int numRecords = 0;
				int numRecordsFor = 0;
			/* 	List<DebriefSubmitData> data = null;
				List<ReasonOfRejection> reason = null;
				List<DebriefSubmitViewData> viewData = null;
				List<VehicleRegistrationNumberForTransporter> VehRegNumber = null;
				List<PeripheralOfUnitDuringTrip> peripheral = null; */
				List<String> castrolZones = null;
				int numOfRejectionRecords = 0;
				int numOfVehRecords = 0;
				int numOfPeripheralRecords = 0;
				Calendar now = Calendar.getInstance();
				int flgJRM = 0;
				Date new12 = new Date();
				int scr_N_DH = 0, scr_N_Adh = 0, scr_N_ND = 0, scr_N_CD = 0, scr_N_DVI = 0;
				String PExp = "", PEDate = "", PEDate1 = "", PExp1 = "", MExp = "", LTDate = "", MExp1 = "", LTDate1 = "", tid = "", VehNo = "", oname = "", gname = "", startplace = "", endp = "", startt1 = "", startd1 = "", startd = "", startt = "", tripcat = "", entryb = "", jstatus = "", LastM = "", LastD = "", Loc = "";
				String VehReg = "", VehType = "", base1 = "", BTName = "", M1TName = "", M2TName = "", M3TName = "", M4TName = "", M5TName = "", based = "", remark = "", inci1 = "", inci11 = "", mod1 = "", moddate1 = "", red1 = "", getD1 = "", getD2 = "", red2 = "", res1 = "", res11 = "", goal1 = "", per12 = "", spe1 = "", get1 = "", vehRej = "", get2 = "", get3 = "", startdate1 = "", mod2 = "", TotScore = "", scoreCat = "", scoreP = "", moddate2 = "", mod3 = "", moddate3 = "", mod4 = "", moddate4 = "", moddate11 = "", moddate12 = "", moddate13 = "", moddate14 = "", LastD1 = "", moddate15 = "", mod14 = "", mod15 = "", mod5 = "", moddate5 = "", score = "", MTD = "";
				String probableND = "", probableCD = "";
				String tripid1 = "", vehtype1 = "", runhr = "", Vehid = "", ttime1 = "", ttime2 = "",ttime3="", ftime1 = "", ftime2 = "",ftime3="", VehRegNo1 = "", OwnerName1 = "", StartPlace1 = "", date100 = "", date101 = "", date201 = "", date200 = "", StartDate1 = "", StartTime1 = "", EndPlace1 = "", EndDate1 = "", EndTime1 = "", KmTravelled1 = "", OSCount1 = "", RACount1 = "", RDCount1 = "", OSDuration1 = "", CRCount1 = "", NDCount1 = "", DisconnectionCount1 = "";
				double TripRating1 = 0.0;
				
				String driveraddress="",newsletter="",newsletter1="";
				
				String news="''";
				int Dist = 0, score1 = 0, mtd1 = 0, flag = 1, routeid = 0, crcountnew = 0, ndcnt = 0;
				int MaxDisND = 0, MaxDisCD = 0, MaxPointND = 0, MaxPointCD = 0, MaxDisRH = 0, MaxPointRH = 0, MaxPointAdh = 0, MaxPointDVI = 0, per11 = 0, MaxDis = 0;
				NumberFormat nf1 = DecimalFormat.getInstance();
				nf1.setMaximumFractionDigits(2);
				nf1.setMinimumFractionDigits(2);
				String BriStartPlc = "", BriEndPlc = "";
				String fromdate, search = "", todate, sql, sql1, sql2, sql3, transporter, pageflag, datenew1, datenew2, fromdatetime, todatetime, vendor1, category1, startp, ven, startp1, endp1, vendername, categoryname, startplacename, endplacename, statusname, vehino, vehicleno, vehiclecode, Sqlv = "", distributorname = "";
				String sqlname = null, briefing = "", sqlbrif = null, Dbriefing = "", etaclose = "", reportclose = "", tripsrch = "", vehsrch = "", spsrch = "";
				String epsrch = "", ownsrch = "", statuasrch = "", statuarsrun = "", etaclose1 = "", sdtime1 = "", sddate1 = "", etdate = "", repdate = "", reportclose1 = "";
				String sql4 = "select VehRegNo,startplace,endplace,CleanerId,CleanerName from t_briefing where Briefid='"
						+ BrifId + "' order by brifdate desc limit 1";
				ResultSet rs4 = st.executeQuery(sql4);
				if (rs4.next()) {
					VehReg = rs4.getString("VehRegNo");
					BriStartPlc = rs4.getString("startplace");
					BriEndPlc = rs4.getString("endplace");
					CleanerId = rs4.getString("CleanerId");
					CleanerName = rs4.getString("CleanerName");
				}
				String sql5 = "select vehtype,VehicleCode from t_vehicledetails where VehicleRegNumber='"
						+ VehReg + "'";
				ResultSet rs5 = st.executeQuery(sql5);
				if (rs5.next()) {
					VehType = rs5.getString("vehtype");
					VehCode2 = rs5.getString("VehicleCode");
				}
	%>
	<body background="#83738A" onload="checkvalue('Select');">
	<form style="margin: 0px;" action="" id="brief" name="brief"
		method="post" id="caspioform" >
	<h2 align="center">Briefing</h2>
	<input type="hidden" name="AppKey" value="6cbb100090d21faa8db649229faa" />
	<input type="hidden" id="PageName" name="PageName"
		value="<%=PageName%>" />

	<div align="center">
	<table align="center">
		<tr>

			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Brief ID : </b><%=BrifId%></font> </label></td>
			<td align="left"><label for="">&nbsp;&nbsp;&nbsp;<font
				size="2"></font> </label>&nbsp;</td>
			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Trip ID : </b><%=TripId%></font> </label></td>
			<td align="left"><label for="">&nbsp;&nbsp;&nbsp;<font
				size="2"></font> </label></td>
			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Transporter : </b><%=Transporter%></font> </label></td>
			<td align="left"><label>&nbsp;&nbsp;&nbsp;<font
				size="2">&nbsp;</font> </label></td>
			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Brief Date : </b><%=date11%></font> </label></td>
			<td align="left"><label>&nbsp;&nbsp;&nbsp;<font
				size="2"></font> </label></td>
		</tr>
		<tr>
			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Passport ID : </b><%=DriveId%></font> </label></td>
			<td align="left"><label>&nbsp;&nbsp;&nbsp;<font size="2"></font>
			</label>&nbsp;</td>
			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Driver Name : </b><%=DriverName%></font></label></td>
			<td align="left"><label>&nbsp;&nbsp;&nbsp;<font
				size="2"></font> </label></td>
			<td align="left"><label for=""><font face="Arial"
				size="2"><b>Cleaner Passport ID : </b><%=CleanerId%></font> </label></td>
			<td align="left"><label for="">&nbsp;&nbsp;&nbsp; <font
				size="2"></font> </label></td>
			<td><label for=""><font face="Arial" size="2"><b>Cleaner
			Name : </b><%=CleanerName%></font></label></td>
			<td><label>&nbsp;&nbsp;&nbsp;<font size="2"> </font> </label>
			</td>
		</tr>
		<tr>
			<td><label for=""><font face="Arial" size="2"><b>Vehicle
			Type : </b><%=VehType1%></font> </label></td>
			<td><label>&nbsp;&nbsp;&nbsp;<font size="2"></font> </label></td>
			<td><label><font face="Arial" size="2"><b>Vehicle
			No : </b><%=VehReg%></font> </label></td>
			<td><label>&nbsp;&nbsp;&nbsp;<font size="2"></font> </label></td>
			<td><label><font face="Arial" size="2"><b>Origin
			: </b><%=BriStartPlc%></font> </label></td>
			<td><label>&nbsp;&nbsp;&nbsp;<font size="2"></font> </label></td>
			<td><label><font face="Arial" size="2"><b>Destination
			: </b><%=BriEndPlc%></font> </label></td>
			<td><label>&nbsp;&nbsp;&nbsp;<font size="2"></font> </label></td>
		</tr>
	</table>
	</div>
	<div style="margin-left: 50px">

	<table>
		<tr>
			<td bgcolor="#485682" style="height: 30px; width: 30px"><font
				color="white"><b>Informative</b></font></td>
			<td bgcolor="#FF5959"><font color="white"><b>Pending</b></font></td>
			<td bgcolor="#56C556"><font color="white"><b>Completed</b></font></td>
		</tr>
	</table>
	</div>
	<div style="margin-top: 10px; margin-left: 750px">
	<table class="cbFormNestedTable" align="c" cellspacing="0">
		<tr>
			<td style="margin-left: 0px"><input type="button"
				class="button_text"
				style="border-style: outset; border-color: black"
				value="Save Briefing "
				onclick="GetFinal('<%=DriveId%>','<%=BrifId%>')" /></td>
			<td style="margin-left: 0px"><input type="button"
				class="button_text"
				style="border-style: outset; border-color: black"
				value="Delete Briefing" onclick="OpenF();" /></td>
		</tr>
	</table>
	</div>
	<table>
		<tr>
			<td>
			<div
				style="background: #FAFAFE; height: 100; width: 930px; margin-left: 50px">
			<h2 style="background: #485682; color: #ffffff; cursor: pointer;"
				onClick="Displayer(1)">&nbsp;+ 1. Driver Details&nbsp;</h2>
			<table id="Section1" style="display: none;">
				<tr>
					<td>
					<table>

						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordFirst_Name"><b>Counseling Details
							:</b> </label></td>
						</tr>
						<%
							sql3 = "select Basic,basicdate,BasicTrainerName,Module1TrainerName,Module2TrainerName,Module3TrainerName,Module4TrainerName,Module5TrainerName,Module1,Module1date,Module2,Module2date,Module3,Module3date,Module4,Module4date,Module5,Module5date,LastTraining,LastTrainingDate,Place,remark,PreTest40MM,PreTestper,PostTest40MM,BasicTrainerName,Module1TrainerName,Module2TrainerName,Module3TrainerName,Module4TrainerName,Module5TrainerName from t_drivertraining where dcode ='"
											+ DriveId + "'";
									ResultSet rs3 = st.executeQuery(sql3);
									if (rs3.next()) {
										mod1 = rs3.getString("Module1");
										moddate1 = rs3.getString("Module1date");
										mod2 = rs3.getString("Module2");
										moddate2 = rs3.getString("Module2date");
										mod3 = rs3.getString("Module3");
										moddate3 = rs3.getString("Module3date");
										mod4 = rs3.getString("Module4");
										moddate4 = rs3.getString("Module4date");
										mod5 = rs3.getString("Module5");
										moddate5 = rs3.getString("Module5date");
										LastM = rs3.getString("LastTraining");
										LastD = rs3.getString("LastTrainingDate");
										Loc = rs3.getString("Place");
										base1 = rs3.getString("Basic");
										based = rs3.getString("basicdate");
										remark = rs3.getString("remark");
										BTName = rs3.getString("BasicTrainerName");
										M1TName = rs3.getString("Module1TrainerName");
										M2TName = rs3.getString("Module2TrainerName");
										M3TName = rs3.getString("Module3TrainerName");
										M4TName = rs3.getString("Module4TrainerName");
										M5TName = rs3.getString("Module5TrainerName");
									}
									if (moddate1 == null || moddate1.equals("-")
											|| moddate1 == "-" || moddate1.equals(" ")
											|| moddate1 == " " || moddate1.equals("")
											|| moddate1 == "") {
										moddate11 = "NA";
									} else {
										try {
											moddate11 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(moddate1));
										} catch (Exception e) {
											moddate11 = moddate1;
										}
									}
									if (moddate2 == null || moddate2.equals("-")
											|| moddate2 == "-" || moddate2.equals(" ")
											|| moddate2 == " " || moddate2.equals("")
											|| moddate2 == "") {
										moddate12 = "NA";
									} else {
										try {
											moddate12 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(moddate2));
										} catch (Exception e) {
											moddate12 = moddate2;
										}
									}
									if (moddate3 == null || moddate3.equals("-")
											|| moddate3 == "-" || moddate3.equals(" ")
											|| moddate3 == " " || moddate3.equals("")
											|| moddate3 == "") {
										moddate13 = "NA";
									} else {
										try {
											moddate13 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(moddate3));
										} catch (Exception e) {
											moddate13 = moddate3;
										}
									}
									if (moddate4 == null || moddate4.equals("-")
											|| moddate4 == "-" || moddate4.equals(" ")
											|| moddate4 == " " || moddate4.equals("")
											|| moddate4 == "") {
										moddate14 = "NA";
									} else {
										try {
											moddate14 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(moddate4));
										} catch (Exception e) {
											moddate14 = moddate4;
										}
									}
									if (moddate5 == null || moddate5.equals("-")
											|| moddate5 == "-" || moddate5.equals(" ")
											|| moddate5 == " " || moddate5.equals("")
											|| moddate5 == "") {
										moddate15 = "NA";
									} else {
										try {
											moddate15 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(moddate5));
										} catch (Exception e) {
											moddate15 = moddate5;
										}
									}
									if (LastD == null || LastD.equals("-") || LastD == "-"
											|| LastD.equals(" ") || LastD == " "
											|| LastD.equals("") || LastD == "") {
										LastD1 = "NA";
									} else {
										try {
											LastD1 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(LastD));
										} catch (Exception e) {
											LastD1 = LastD;
										}
									}
						%>
						<tr>
							<td colspan="2" class="cbFormNestedTableContainer">
							<div style="border: ; width: 207px; margin-left: 200px">
							<table class="sortable" border="2">
								<tr>
									<th class="cbFormLabelRequired">Module</th>
									<th class="cbFormLabelRequired">Date</th>
									<th class="cbFormLabelRequired">Location</th>
									<th class="cbFormLabelRequired">Score</th>
									<th class="cbFormLabelRequired">Counsellor Name</th>
								</tr>
								<tr>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">Basic</font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=moddate11%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=mod1%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">NA</font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"><%=BTName%></font>
									</label></td>
								</tr>
								<tr>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">Module
									1</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=moddate12%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=mod2%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">NA
									</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"><%=M1TName%></font>
									</label></td>
								</tr>
								<tr>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">Module
									2</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=moddate13%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=mod3%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">NA
									</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"><%=M2TName%></font>
									</label></td>
								</tr>
								<tr>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">Module
									3</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=moddate14%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=mod4%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">NA
									</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"><%=M3TName%></font>
									</label></td>
								</tr>
								<tr>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">Module
									4</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=moddate15%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=mod5%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">NA
									</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"><%=M4TName%></font>
									</label></td>
								</tr>
								<tr>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">Module
									5</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=LastD1%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"> <%=LastM%></font>
									</label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2">NA
									</font> </label></td>
									<td class="cbFormFieldCell"><label
										for="InsertRecordFirst_Name"><font size="2"><%=M5TName%></font>
									</label></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<%
					sql1 = "select ExpiryDate,ExpiryDate2,LastTrainingDate,PassportExpiryDate from t_drivertraining where dcode ='"
									+ DriveId + "'";
							ResultSet rs1 = st.executeQuery(sql1);
							if (rs1.next()) {
								try {
									PExp = rs1.getString("ExpiryDate");
									MExp = rs1.getString("ExpiryDate2");
									LTDate = rs1.getString("LastTrainingDate");
									PEDate = rs1.getString("PassportExpiryDate");
								} catch (Exception e) {
									System.out.println("Exception---->   " + e);
								}
							}
							if (PEDate == null || PEDate.equals("-") || PEDate == "-"
									|| PEDate.equals(" ") || PEDate == " "
									|| PEDate.equals("") || PEDate == "") {
								PEDate1 = "NA";
							} else {
								try {
									PEDate1 = new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd")
													.parse(PEDate));
								} catch (Exception e) {
									PEDate1 = PEDate;
								}

							}
							if (PExp == null || PExp.equals("-") || PExp == "-"
									|| PExp.equals(" ") || PExp == " "
									|| PExp.equals("") || PExp == "") {
								PExp1 = "NA";
							} else {
								try {
									PExp1 = new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd")
													.parse(PExp));
								} catch (Exception e) {
									PExp1 = PExp;
								}

							}
							if (MExp == null || MExp.equals("-") || MExp == "-"
									|| MExp.equals(" ") || MExp == " "
									|| MExp.equals("") || MExp == "") {
								MExp1 = "NA";
							} else {
								try {
									MExp1 = new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd")
													.parse(MExp));
								} catch (Exception e) {
									MExp1 = MExp;
								}
							}
							if (LTDate == null || LTDate.equals("-") || LTDate == "-"
									|| LTDate.equals(" ") || LTDate == " "
									|| LTDate.equals("") || LTDate == "") {
								LTDate1 = "NA";
							} else {
								try {
									LTDate1 = new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat("yyyy-MM-dd")
													.parse(LTDate));
								} catch (Exception e) {
									LTDate1 = LTDate;
								}

							}
				%>
				<tr>
					<td colspan="2" class="cbFormNestedTableContainer">
					<table class="cbFormNestedTable">
						<tr>
							<br></br>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordDate_of_Birth"><b>Passport Expiry
							Date :</b></label></td>
							<td class="cbFormFieldCell cbFormLabel"><label
								for="InsertRecordFirst_Name"><font size="2">&nbsp;&nbsp;<%=PEDate1%></font></label>
							</td>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordLast_Name"><b>Driving License
							Expiry Date :</b></label></td>
							<td class="cbFormFieldCell cbFormLabel"><label
								for="InsertRecordFirst_Name"><font size="2"><%=PExp1%></font></label>
							<%
								if (PExp1 == "NA") {
										} else {
											try {
												java.util.Date drivexpdate1 = new SimpleDateFormat(
														"dd-MMM-yyyy").parse(PExp1);
												java.util.Date sysdate23 = new Date();
												java.util.Date sysdate22 = new Date();
												Calendar now123 = Calendar.getInstance();
												now123.setTime(sysdate23);
												now123.add(Calendar.DATE, 7);
												sysdate23 = now123.getTime();
												if (drivexpdate1.after(sysdate22)
														&& drivexpdate1.before(sysdate23)) {
							%> <blink><label for="InsertRecordFirst_Name"><font
								color="red" size="2">&nbsp;Driving License Will Expire On
							<%=PExp1%></font></label></blink> <%
 	} else {
 %> <%
 	}
 				} catch (Exception e) {
 				}
 			}
 %>
							</td>
						</tr>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordSocial_Security_Number"><b> Last
							Medical Checkup Date :</b></label></td>
							<td class="cbFormFieldCell"><label
								for="InsertRecordFirst_Name"><font size="2">&nbsp;&nbsp;<%=MExp1%></font></label>
							</td>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordEmail"><b>Last Counseling Date :</b></label></td>
							<td class="cbFormFieldCell"><label
								for="InsertRecordFirst_Name"><font size="2"><%=LTDate1%></font></label>
							</td>
						</tr>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordEmail"><b>Counsellor Observation :</b></label>
							</td>
							<td class="cbFormFieldCell"><label
								for="InsertRecordFirst_Name"><font size="2">&nbsp;<%=remark%></font></label>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td>
					<table>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordEmail"><b>Caution Rules :</b></label></td>
							<td><label for="InsertRecordEmail"><font size="2">1.
							Refresher Training once in 3 years </font></label></td>
						</tr>
						<tr>
							<td></td>
							<td><label for="InsertRecordEmail"><font size="2">2.
							Medical Check up once a year</font></label></td>
						</tr>
						<tr>
							<td></td>
							<td><label for="InsertRecordEmail"><font size="2">3.
							Driving License expiry check </font></label></td>
						</tr>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordEmail"><b>Caution Report :</b></label></td>
							<td></td>
						</tr>
						<%
							int CautionFlg = 0;
									if (PExp1 == "NA") {
										CautionFlg = 1;
						%>
						<tr>
							<td class="cbFormFieldCell 24Dec2009"><label
								for="InsertRecordEmail"><font color="red" size="2">Driving
							License Date not mentioned</font></label></td>
						</tr>
						<%
							} else {
										int t = 0;
										try {
											java.util.Date tesdate2 = new SimpleDateFormat(
													"dd-MMM-yyyy").parse(PExp1);
											t = 0;
										} catch (Exception e) {
											t = 1;
										}
										if (t == 0) {
											java.util.Date sysdate = new Date();
											java.util.Date drivexpdate = new SimpleDateFormat(
													"dd-MMM-yyyy").parse(PExp1);
											if (drivexpdate.before(sysdate)) {
												CautionFlg = 1;
						%>
						<tr>
							<td class="cbFormFieldCell 24Dec2009"><label
								for="InsertRecordEmail"><font color="red" size="2">Driving
							License Date Expired</font></label></td>
						</tr>
						<tr>

							<td><label class="description" for="element_1"
								style="width: 170px;"><font size="2">Authorise </font></label></td>
							<td class="cbFormFieldCell"><input type="checkbox"
								name="AuthoD" id="AuthoD" value="Yes" onclick="showtext8()"></input>
							<label class="description" for="element_1"><font
								size="2">Yes</font></label></td>
							<tr>
								<td></td>
								<td id="authoR" style="display: none;">
								<table>
									<tr>
										<td>Email ID : &nbsp;&nbsp;</td>
										<td><input type="text" id="emailD" name="emailD"
											style="width: 400px;"></td>
									</tr>
									<tr>
										<td valign="top">Message : &nbsp;&nbsp;</td>
										<td><textarea id="authoReason" name="authoReason"
											rows="2" cols="55"></textarea></td>
									</tr>
									<tr>
										<td></td>
										<td align="center"><input type="button"
											class="button_text"
											style="border-style: outset; border-color: black"
											value="Save"
											onclick="GetMail('<%=DriveId%>','<%=BrifId%>','<%=TripId%>','<%=BriStartPlc%>','<%=BriEndPlc%>')" />
										<input type="button" class="button_text"
											style="border-style: outset; border-color: black"
											value="Reset" onclick="DReset()" /></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
								}
											} else {
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font size="2"></font></label></td>
							</tr>
							<%
								}
										}
							%>
							<%
								if (MExp1 == "NA") {
											CautionFlg = 1;
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font color="red" size="2">Medical
								Checkup Date not mentioned</font></label></td>
							</tr>
							<%
								} else {
											int g = 0;
											try {
												java.util.Date tesdate = new SimpleDateFormat(
														"dd-MMM-yyyy").parse(MExp1);
												g = 0;
											} catch (Exception e) {
												g = 1;
											}
											if (g == 0) {
												java.util.Date sysdate = new Date();
												java.util.Date MEdexpdate = new SimpleDateFormat(
														"dd-MMM-yyyy").parse(MExp1);
												Calendar cal = Calendar.getInstance();
												cal.setTime(MEdexpdate);
												cal.add(Calendar.YEAR, 1);
												MEdexpdate = cal.getTime();
												if (MEdexpdate.before(sysdate)) {
													CautionFlg = 1;
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font color="red" size="2">Medical
								Checkup Date Expired</font></label></td>
							</tr>
							<tr>
								<td><label class="description" for="element_1"
									style="width: 170px;"><font size="2">Authorise </font></label>
								</td>
								<td class="cbFormFieldCell"><input type="checkbox"
									name="AuthoM" id="AuthoM" value="" onclick="showtext9()"></input>
								<label class="description" for="element_1"><font
									size="2">Yes</font></label></td>
							</tr>
							<tr>
								<td></td>
								<td id="authoR1" style="display: none;">
								<table>
									<tr>
										<td>Email ID : &nbsp;&nbsp;</td>
										<td><input type="text" id="emailR1" name="emailR1"
											style="width: 400px;"></td>
									</tr>
									<tr>
										<td valign="top">Message : &nbsp;&nbsp;</td>
										<td><textarea id="authoReason1" name="authoReason1"
											rows="2" cols="55"></textarea></td>
									</tr>
									<tr>
										<td></td>
										<td align="center"><input type="button"
											class="button_text"
											style="border-style: outset; border-color: black"
										value="Save"
											onclick="GetMail1('<%=DriveId%>','<%=BrifId%>','<%=TripId%>',,'<%=BriStartPlc%>','<%=BriEndPlc%>')" />
										<input type="button" class="button_text"
											style="border-style: outset; border-color: black"
											value="Reset" onclick="MReset()" /></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
								}
											} else {
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font size="2"></font></label></td>
							</tr>
							<%
								}
										}
							%>
							<%
								if (LTDate1 == "NA") {
											CautionFlg = 1;
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font color="red" size="2">Last
								Counseling Date not mentioned</font></label></td>
							</tr>
							<%
								} else {
											int s21 = 0;
											try {
												java.util.Date tesdate1 = new SimpleDateFormat(
														"dd-MMM-yyyy").parse(LTDate1);
												s21 = 0;
											} catch (Exception e) {
												s21 = 1;
											}
											if (s21 == 0) {
												java.util.Date sysdate = new Date();
												java.util.Date Lastexpdate = new SimpleDateFormat(
														"dd-MMM-yyyy").parse(LTDate1);
												Calendar cal = Calendar.getInstance();
												cal.setTime(Lastexpdate);
												cal.add(Calendar.YEAR, 3);
												Lastexpdate = cal.getTime();
												if (Lastexpdate.before(sysdate)) {
													CautionFlg = 1;
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font color="red" size="2">Refresher
								Counseling Required</font></label></td>
							</tr>
							<tr>

								<td><label class="description" for="element_1"
									style="width: 170px;"><font size="2">Authorise </font></label>
								</td>
								<td class="cbFormFieldCell"><input type="checkbox"
									name="AuthoT" id="AuthoT" value="" onclick="showtext10()"></input>
								<label class="description" for="element_1"><font
									size="2">Yes</font></label></td>
							</tr>
							<tr>
								<td></td>
								<td id="authoR2" style="display: none;">
								<table>
									<tr>
										<td>Email ID : &nbsp;&nbsp;</td>
										<td><input type="text" id="emailR2" name="emailR2"
											style="width: 400px;"></td>
									</tr>
									<tr>
										<td valign="top">Message : &nbsp;&nbsp;</td>
										<td><textarea id="authoReason2" name="authoReason2"
											rows="2" cols="55"></textarea></td>
									</tr>
									<tr>
										<td></td>
										<td align="center"><input type="button"
											class="button_text"
											style="border-style: outset; border-color: black"
											value="Save"
											onclick="GetMail2('<%=DriveId%>','<%=BrifId%>','<%=TripId%>','<%=BriStartPlc%>','<%=BriEndPlc%>')" />
										<input type="button" class="button_text"
											style="border-style: outset; border-color: black"
											value="Reset" onclick="LReset()" /></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
								}
											} else {
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font size="2"></font></label></td>
							</tr>
							<%
								}
										}
							%>
							<%
								if (CautionFlg == 0) {
							%>
							<tr>
								<td class="cbFormFieldCell 24Dec2009"><label
									for="InsertRecordEmail"><font size="2">Nil</font></label></td>
							</tr>
							<%
								}
							%>
						
					</table>
					<table class="cbFormNestedTable">
						<tr id="email" style="display: none;">
							<td>
							<div align="center">
							<table>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td class="cbFormLabelCell  cbFormLabel"><label for=""><b>Please
									select e-mail id :</b> </label></td>
									<td><select class="element select medium" id="EmailId"
										name="EmailId" style="width: 250px">
										<%
											String sql225 = "select Eid from db_gps.t_authorizeeid";
													int x = 0;
													ResultSet rs225 = st.executeQuery(sql225);
													while (rs225.next()) {
										%>
										<option value="<%=rs225.getString("Eid")%>"
											title="<%=rs225.getString("Eid")%>"><%=rs225.getString("Eid")%></option>
										<%
											x++;
													}
										%>
									</select></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<%
							sql2 = "select TripID,StartPlace,VehRegNo,EndPlace,StartDate,StartTime,OwnerName,GPName,TripCategory,JStatus,EntryBy from t_startedjourney where DriverCode ='"
											+ DriveId + "' order by StartDate,StartTime desc ";
									ResultSet rs2 = st.executeQuery(sql2);
									while (rs2.next()) {
										tid = rs2.getString("TripID");
										oname = rs2.getString("OwnerName");
										gname = rs2.getString("GPName");
										startplace = rs2.getString("StartPlace");
										VehNo = rs2.getString("VehRegNo");
										endp = rs2.getString("EndPlace");
										startd = rs2.getString("StartDate");
										startt = rs2.getString("StartTime");
										tripcat = rs2.getString("TripCategory");
										entryb = rs2.getString("EntryBy");
										jstatus = rs2.getString("JStatus");
									}
									if (startd == null || startd.equals("-") || startd == "-"
											|| startd.equals(" ") || startd == " "
											|| startd.equals("") || startd == "") {
										startd1 = "NA";
									} else {
										try {
											startd1 = new SimpleDateFormat("dd-MMM-yyyy")
													.format(new SimpleDateFormat("yyyy-MM-dd")
															.parse(startd));
										} catch (Exception e) {
											startd1 = startd;
										}
									}
						%>

	<tr>
			<td class="cbFormLabelCell  cbFormLabel">
					<label	for="InsertRecordDate_of_Birth"><b>Vehicle Details</b></label>
			</td>
	</tr>
	<tr>
			<td class="cbFormLabelCell  cbFormLabel"><label	for="InsertRecordDate_of_Birth"><b>Vehicle Changed ? :</b></label>
				<label	for="InsertRecordFirst_Name"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Yes<input type="radio" name="VehChange"  id="VehChange" value="Yes" > 
				No<input type="radio" name="VehChange"  id="VehChange" value="No" checked="checked" >  
				</font></label>
			</td>
	</tr>
	

	<tr>
			<td class="cbFormLabelCell  cbFormLabel"><label	for="InsertRecordDate_of_Birth"><b>Model Changed  ? :</b></label>		
			
				<label	for="InsertRecordFirst_Name"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Yes<input type="radio" name="ModelChange"  id="ModelChange" value="Yes"  onchange='checkvalue(this.value)'> 
				No<input type="radio" name="ModelChange"  id="ModelChange1" value="No" checked="checked"  onchange='checkvalue(this.value)'>   
				       
				</font></label>
			</td>
	</tr>
	<tr id="oldModelRow">
			<td><font face="Arial" size="2"><font color="red"> *</font><b> Old Model &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </b> </font> <font color="red"></font>
		 	
		 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 		<input type="text" id="oldModel" name="oldModel" onblur="checkModel()" style="width: 400px;">
		 	</td>
		 		
	</tr>

	
	
	<tr id="newModelRow" >		
			<td><font face="Arial" size="2"><font color="red"> *</font><b> New Model &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </b> </font> <font color="red"></font>		 	
		 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 	<input type="text" id="newModel" name="newModel" onblur="checkModel1()" style="width: 400px;"></td>
		 		
	</tr>
	
	<tr>
			<td class="cbFormLabelCell  cbFormLabel"><label	for="InsertRecordDate_of_Birth"><b>Driver engaged on changed ? :</b></label>		
				<label	for="InsertRecordFirst_Name"><font size="2">&nbsp;&nbsp;&nbsp;
					Yes<input type="radio" name="DriverChange" id="DriverChange" value="Yes" > 
				    No<input type="radio" name="DriverChange" id="DriverChange" value="No" checked="checked">  				
			</font></label>
			</td>
	</tr>		
	<div style="margin-right: -3px;">
							<table class="cbFormNestedTable" align="right" cellspacing="0">
								<tr>
									<td class="cbFormLabelCell  cbFormLabel">
									
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black" value="Save"
										onclick="validateModel('<%=BrifId%>')" /></td>
									<td>&nbsp;&nbsp;&nbsp;
									
									<input type="button" value="Reset" onclick="ResetVehicleChange()"
										class="button_text"
										style="border-style: outset; border-color: black" /></td>
								</tr>
							</table>
							</div>
	
	</table>
			</td>
		</tr>
	  </table>
	</div>





			<div style="background: #FAFAFE; width: 930px; margin-left: 50px">
			<h2 style="background: #485682; color: #ffffff; cursor: pointer;"
				onClick="Displayer(2)">&nbsp;+ 2. Driver History&nbsp;</h2>
			<table id="Section2" style="display: none;">
				<tr class="cbFormTableRow" align="center">
					<td colspan="2" class="cbFormNestedTableContainer"><input
						type="hidden" id="DriveId" name="DriveId" value="<%=DriveId%>"></input>
					<input type="hidden" id="BrifId" name="BrifId" value="<%=BrifId%>"></input>
					<table class="cbFormNestedTable" cellspacing="0">
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordCity"><b>Route Specific History
							And DVI Trend :</b></label>&nbsp;&nbsp; <%
 	todate = new SimpleDateFormat("dd-MMM-yyyy")
 					.format(new java.util.Date());
 			Calendar cal = Calendar.getInstance();
 			cal.add(Calendar.DATE, -7);
 			fromdate = new SimpleDateFormat("dd-MMM-yyyy").format(cal
 					.getTime());
 			String Sp1 = "", Ep1 = "";
 			/* String sql2211 = "select startplace,endplace from db_gps.t_briefing where Briefid='"
 					+ BrifId
 					+ "' and tripid='"
 					+ TripId
 					+ "' and Driverid='"
 					+ DriveId
 					+ "' and DriverName='" + DriverName + "'"; */
 					 String sql2211="select StartCode,EndCode from db_gps.t_startedjourney where TripID='"+TripId+"' and DriverCode='"+DriveId+"'"; 
 			//String sql2211 = "select StartCode,EndCode from db_gps.t_startedjourney where TripID='"+TripId+"'";
 					System.out.println("Sql2211-------"+sql2211);
 					 rs11= nst.executeQuery(sql2211);
 					 
 					 if(!rs11.next())
 							{
 						System.out.println("---------------In !rs11-------");
 					}
 					else
 					{
 						
 						rs11.previous();
 						//Sp1 = rs11.getString("StartCode");
 		 				//Ep1 = rs11.getString("EndCode");
 		 				 
 			while(rs11.next()) 
 			{
 				System.out.println("-------------------In While rs11-----------------------------");
 				Sp1 = rs11.getString("StartCode");
 				Ep1 = rs11.getString("EndCode");
 				
 			}
 			
 			System.out.println("start and end code"+Sp1+""+Ep1);
 			
 					
 					}
 			
 %> <a href="veh_Violation_report.jsp?vid=<%=VehCode2%>&rpttime=7day"
								target="_blank"> <a href="detail_custom_report.jsp?vehcode=<%=VehCode2 %>&data=<%=fromdate %>&data1=<%=todate %>&ftime1=00&ftime2=00&ttime1=23&ttime2=59&fromPage=temperaturegraph">
							7 Days Detail Report </a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="#"
						onclick="openJF('<%=BriStartPlc%>','<%=BriEndPlc%>')"><font size="2"><b>&nbsp;&nbsp;Last 5 JRM Feedback </b></font></a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#"
						onclick="openNM('<%=BriStartPlc%>','<%=BriEndPlc%>')"><font size="2"><b>&nbsp;&nbsp;Last 5 Near Miss </b></font></a></td>
							<td></td>
						</tr>
						<tr>
							<td>
							<table align="center">
								<tr>
									<td><label class="description" for="element_1"><font
										size="2"><b> Trip Details :</b></font></label></td>
									<td><input type="radio" name="Trip" id="Trip"
										value="Driver" checked="checked" onclick="GetVisibleTable()">
									Driver</td>
									<td><input type="radio" name="Trip" id="Trip"
										value="Vehicle" onclick="GetVisibleTable()"> Vehicle</td>
									<td><input type="radio" name="Trip" id="Trip"
										value="Route" onclick="GetVisibleTable()"> Route</td>
								</tr>
								
								<tr>
							<font  size="1" >
							    *For dummy trip ids, StartPlace and EndPlace will not match in routewise report.   
							   </font></tr>
							   
							</table>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" class="cbFormNestedTableContainer">
							<%
							int Cnt = 0;
								String SubQuery[] = {
												" DriverID=\'" + DriveId + "\'",
												" VehRegNo=\'" + VehReg + "\'",
												" StartCode like '%"+Sp1+"%' and EndCode like '%"+Ep1+"%'" };
										String DivName[] = { "Driver", "Vehicle", "Route" };
										System.out.println("Driver---"+SubQuery[0]);
										System.out.println("Vehicle--"+SubQuery[1]);
										System.out.println("Route--"+SubQuery[2]);
										  /* if(SubQuery[2].equals("Route") && Sp1==null || Sp1=="" && Ep1==null || Ep1=="") */
											  
										 
										String DivDisplay = "inline";
										
										
										while (Cnt < 3) {
											
											
											
											
											//System.out.println("In While");
											//System.out.println("Div Name "+ DivName[Cnt]);
											System.out.println("DivName[Cnt] "+DivName[Cnt]);
							%>
							<div style="border:;width:479px; display: <%=DivDisplay%>;"
								id="Div<%=DivName[Cnt]%>">
								
											
											
							<table class="sortable" cellspacing="0" border="2">
								<tr>
									<th class="cbFormLabelRequired">Sr No</th>
									<th class="cbFormLabelRequired">Vehicle No</th>
									<th class="cbFormLabelRequired">Vehicle Type</th>
									<th class="cbFormLabelRequired">TripId</th>
									<th class="cbFormLabelRequired">Transporter</th>
									<th class="cbFormLabelRequired">Start Date</th>
									<th class="cbFormLabelRequired">End Date</th>
									<th class="cbFormLabelRequired">Start Place</th>
									<th class="cbFormLabelRequired">Destination Place</th>
									<th class="cbFormLabelRequired">Distance</th>
									<!-- <th class="cbFormLabelRequired"> Run Hr</th> -->
									<!-- <th class="cbFormLabelRequired">Avg RunHr/Day</th> -->
									<th class="cbFormLabelRequired">Run Hr Violation</th>
									<th class="cbFormLabelRequired">OS</th>
									<th class="cbFormLabelRequired">OS (sec)</th>
									<th class="cbFormLabelRequired">OS (sec) in Red Zone</th>
									<th class="cbFormLabelRequired">OS (sec) in Yellow Zone</th>
									<th class="cbFormLabelRequired">OS (sec) in Green Zone</th>
									<th class="cbFormLabelRequired">RA</th>
									<th class="cbFormLabelRequired">RD</th>
									<th class="cbFormLabelRequired">CD</th>
									<th class="cbFormLabelRequired">ND</th>
									<!-- <th class="cbFormLabelRequired"> ND Distance</th> -->
									<!-- <th class="cbFormLabelRequired"> ND Duration</th> -->
									<!-- <th class="cbFormLabelRequired"> DC</th> -->
									<!-- <th class="cbFormLabelRequired"> DC Km</th> -->
									<th class="cbFormLabelRequired">Rating</th>
								</tr>
								<%
									try {
													int gk = 1;
													String todat1 = "", fromdat1 = "", sql500 = "";
													todat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
															.format(new java.util.Date());
													Calendar cal1 = Calendar.getInstance();
													cal1.add(Calendar.MONTH, -1);
													fromdat1 = new SimpleDateFormat(
															"yyyy-MM-dd HH:mm:ss").format(cal1
															.getTime());
													int Count = 0;

													//System.out.println("fromdat1-*******************--->>"+fromdat1);
													
													String UsertypeValue=session.getAttribute("usertypevalue").toString();
													 
													sql500 = "select RunHrVio,CRCount,tripid, pod, Vehid, TripRating, VehRegNo, OwnerName, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, UnloadDateTime, LoadingDelay, UnloadingDelay, JourneyStatus, DriverID, DriverName, JDCode, Weight, Vendor, Unloadingcomments, DelayReason, OSCount, RACount, RDCount, OSDuration, OSDurationInRedZone, OSDurationInYellowZone, OSDurationInGreenZone, NDCount, DisconnectionCount, DateDIFF( EndDate, StartDate ) AS noofdays from db_gps.t_completedjourney where (ownername='"+UsertypeValue+"' or Gpname='"+UsertypeValue+"' or Vendor='"+UsertypeValue+"') and "+SubQuery[Cnt]+" order by StartDate desc limit 10";
													System.out.println("UserTypevalue---------------"+sql500);
													 /* String sql601 = "select count(tripid) as Count from db_gps.t_completedjourney where "+SubQuery[Cnt]+"";
													System.out.println("sql601 : " + sql601);
													ResultSet rs601 = st.executeQuery(sql601);
													if (rs601.next()) {
														Count = Integer.parseInt(rs601
																.getString("Count"));
														
														System.out.println("@@@@@@@@@--Count of Trip Id--@@@@@@@@@@@@@@@"+Count);
													}
													if (Count <= 10) {//sql500="select tripid,Vehid,TripRating,EndTime,VehRegNo,OwnerName,StartPlace,StartDate,EndPlace,EndDate,KmTravelled,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount,CRCount from db_gps.t_completedjourney where DriverID='"+DriveId+"' group by tripid having count(*)>=1  order by StartDate  desc limit 10 ";
														sql500 = "select RunHrVio,CRCount,tripid, pod, Vehid, TripRating, VehRegNo, OwnerName, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, UnloadDateTime, LoadingDelay, UnloadingDelay, JourneyStatus, DriverID, DriverName, JDCode, Weight, Vendor, Unloadingcomments, DelayReason, OSCount, RACount, RDCount, OSDuration, OSDurationInRedZone, OSDurationInYellowZone, OSDurationInGreenZone, NDCount, DisconnectionCount, DateDIFF( EndDate, StartDate ) AS noofdays from db_gps.t_completedjourney where "
																+ SubQuery[Cnt]
																+ " group by tripid having count(*)>=1  order by StartDate  desc limit 10 ";
													} else {
														//sql500="select distinct(tripid),Vehid,TripRating,EndTime,VehRegNo,OwnerName,StartPlace,StartDate,EndPlace,EndDate,KmTravelled,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount,CRCount from db_gps.t_completedjourney where DriverID='"+DriveId+"' and StartDate > '"+fromdat1+"' order by StartDate desc";
													sql500 = "select RunHrVio,CRCount,tripid, pod, Vehid, TripRating, VehRegNo, OwnerName, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, UnloadDateTime, LoadingDelay, UnloadingDelay, JourneyStatus, DriverID, DriverName, JDCode, Weight, Vendor, Unloadingcomments, DelayReason, OSCount, RACount, RDCount, OSDuration, OSDurationInRedZone, OSDurationInYellowZone, OSDurationInGreenZone, NDCount, DisconnectionCount, DateDIFF( EndDate, StartDate ) AS noofdays from db_gps.t_completedjourney where (ownername='"+UsertypeValue+"' or Gpname='"+UsertypeValue+"') and "+SubQuery[Cnt]+" order by StartDate desc limit 10";
													System.out.println("UserTypevalue---------------"+sql500);
													}  */
													int i = 0, dist1, dist2;
													java.util.Date enddte1, strdte1;
													double stdDist = 0, stdTme = 0, capDist = 0;
													String SDate, EDate, STime, ETime, tripid, StDate, EdDate;
													long millisecdiff = 0, miliseconds1 = 0, miliseconds2 = 0, secdiff = 0, mindiff = 0, hrdiff = 0, etime;
													fromdate = "";
													todate = "";
													ftime1 = "00";
													ftime2 = "00";
													ftime3 = "00";
													ttime1 = "00";
													ttime2 = "00";
													ttime3 = "00";
													int noofdays = 0;
													String fromdate1 = "", todate1 = "";
													String vehdesc = "-", vehmodel = "-", vehtype = "-", adv = "-", freight = "-", loadrsn = "-", loadcmt = "-", endedby = "-", weight = "-", vendor = "-", reptdttme = "-", unloadcmt = "-", unloadrsn = "-";
													String sdate, edate, LoadingDelay, UnloadingDelay;
													String crcount = "";
													int KmTravelled = 0, runhrscnt = 0, CRcnt = 0, NDcnt = 0;
													System.out.println("sql500 : "+sql500);
													ResultSet rs500 = st.executeQuery(sql500);
													while (rs500.next()) {
														tripid1 = rs500.getString("tripid");
														Vehid = rs500.getString("Vehid");
														TripRating1 = rs500.getDouble("TripRating");
														VehRegNo1 = rs500.getString("VehRegNo");
														OwnerName1 = rs500.getString("OwnerName");
														StartPlace1 = rs500.getString("StartPlace");
														StartDate1 = rs500.getString("StartDate");
														EndPlace1 = rs500.getString("EndPlace");
														EndDate1 = rs500.getString("EndDate");
														EndTime1 = rs500.getString("EndTime");
														KmTravelled1 = rs500.getString("KmTravelled");
														OSCount1 = rs500.getString("OSCount");
														RACount1 = rs500.getString("RACount");
														RDCount1 = rs500.getString("RDCount");
														OSDuration1 = rs500.getString("OSDuration");
														NDCount1 = rs500.getString("NDCount");
														CRCount1 = rs500.getString("CRCount");

														if (CRCount1.equalsIgnoreCase("No")) {

															CRcnt = 0;

														} else if (CRCount1.equalsIgnoreCase("Yes")) {

															CRcnt = 1;
														} else {

															CRcnt = rs500.getInt("CRCount");

														}

														// 	NDcnt=rs500.getInt("NDCount");

														runhrscnt = rs500.getInt("RunHrVio");//////Run HRS COUNT

														DisconnectionCount1 = rs500
																.getString("DisconnectionCount");

														try {
															date101 = new SimpleDateFormat(
																	"dd-MMM-yyyy HH:mm")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(StartDate1));
															date201 = new SimpleDateFormat(
																	"dd-MMM-yyyy HH:mm")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(EndDate1));
														} catch (Exception e) {

															date101 = new SimpleDateFormat(
																	"dd-MMM-yyyy")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd")
																			.parse(StartDate1));
															date201 = new SimpleDateFormat(
																	"dd-MMM-yyyy")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd")
																			.parse(EndDate1));

														}

														//////////////////////////////////////////////////////////////////////////////////////////////////	
														i++;
														String tripflag = "true";
														SDate = rs500.getString("StartDate");
														EDate = rs500.getString("EndDate");
														STime = rs500.getString("StartTime");
														ETime = rs500.getString("EndTime");
														tripid = rs500.getString("TripId");
														KmTravelled = rs500.getInt("KmTravelled");
														noofdays = rs500.getInt("noofdays") + 1;
														LoadingDelay = rs500.getString("LoadingDelay");
														if (LoadingDelay == null
																|| LoadingDelay
																		.equalsIgnoreCase("null")) {
															LoadingDelay = "-";
														}
														UnloadingDelay = rs500
																.getString("UnloadingDelay");
														if (UnloadingDelay == null
																|| UnloadingDelay
																		.equalsIgnoreCase("null")) {
															UnloadingDelay = "-";
														}
														unloadcmt = rs500
																.getString("Unloadingcomments");
														if (unloadcmt == null
																|| unloadcmt.equalsIgnoreCase("null")) {
															unloadcmt = "-";
														}
														unloadrsn = rs500.getString("DelayReason");
														if (unloadrsn == null
																|| unloadrsn.equalsIgnoreCase("null")) {
															unloadrsn = "-";
														}
														if (null == STime || STime.length() > 8
																|| STime.equals("-")) {
															STime = "00:00:00";
														}
														if (null == ETime || ETime.equals("-")) {
															ETime = "23:59:59";
														}
														sdate = SDate;
														try {
															fromdate = new SimpleDateFormat(
																	"yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(sdate));
														} catch (Exception e) {
															fromdate = new SimpleDateFormat(
																	"yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(sdate));
														}
														try {
															java.util.Date dt = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss").parse(sdate);
															ftime1 = "" + dt.getHours();
															ftime2 = "" + dt.getMinutes();
														} catch (Exception e) {
															ftime1 = "00";
															ftime1 = "00";
														}
														edate = EDate;
														try {
															todate = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(edate));
														} catch (Exception e) {
															todate = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(edate));
														}
														try {
															java.util.Date edt = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss").parse(edate);
															ttime1 = "" + edt.getHours();
															ttime2 = "" + edt.getMinutes();
														} catch (Exception e) {
															ttime1 = "23";
															ttime2 = "59";
														}
														/*#################################change#############################*/
														try {
															java.util.Date fd = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss").parse(SDate
																	+ " " + STime);//00:00:00
															miliseconds1 = fd.getTime();
														} catch (Exception e1) {
															try {
																java.util.Date fd = new SimpleDateFormat(
																		"yyyy-MM-dd HH:mm:ss")
																		.parse(SDate);
																miliseconds1 = fd.getTime();
															} catch (Exception e4) {
																java.util.Date fd = new SimpleDateFormat(
																		"yyyy-MM-dd").parse(SDate);
																miliseconds1 = fd.getTime();
															}
														}
														try {
															java.util.Date fd1 = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss").parse(EDate
																	+ " " + ETime);
															miliseconds2 = fd1.getTime();
														} catch (Exception e2) {
															try {
																java.util.Date fd1 = new SimpleDateFormat(
																		"yyyy-MM-dd HH:mm:ss")
																		.parse(EDate);
																miliseconds2 = fd1.getTime();
															} catch (Exception e5) {
																java.util.Date fd1 = new SimpleDateFormat(
																		"yyyy-MM-dd").parse(EDate);
																miliseconds2 = fd1.getTime();
															}
														}
														try {
															fromdatetime = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("StartDate")));
															fromdate1 = new SimpleDateFormat(
																	"yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("StartDate")));
														} catch (Exception e) {
															fromdatetime = new SimpleDateFormat(
																	"yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(rs500
																			.getString("StartDate")))
																	+ " " + STime;
															fromdate1 = new SimpleDateFormat(
																	"yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(rs500
																			.getString("StartDate")));
														}
														try {
															todatetime = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("EndDate")));
															todate1 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("EndDate")));
														} catch (Exception e) {
															todatetime = new SimpleDateFormat(
																	"yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(rs500
																			.getString("EndDate")))
																	+ " " + ETime;
															todate1 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(rs500
																			.getString("EndDate")));

														}

														String dcode = rs500.getString("DriverID");
														String briefid = "", rid = "", plannedstatus = "No";

														sql1 = "select * from db_gps.t_briefing where tripid = '"
																+ tripid1 + "'";
														rs1 = strep.executeQuery(sql1);
														if (rs1.next()) {
															briefid = rs1.getString("Briefid");
														}

														sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"
																+ tripid1
																+ "' and briefid = '"
																+ briefid
																+ "' and driverid = '"
																+ dcode
																+ "'  order by advancedtrackid asc ,row asc limit 1 ";
														rs1 = strep.executeQuery(sql1);
														if (rs1.next()) {
															rid = rs1.getString("advancedrouteid");
															plannedstatus = "Yes";

														}
								%>
								<%
									String sqlreport = "select * from db_gps.t_startedjourney where TripID='"
																+ rs500.getString("TripID") + "'";
														ResultSet report = strep
																.executeQuery(sqlreport);
														if (report.next()) {
															etaclose = report.getString("ETA");
															reportclose = report
																	.getString("ReportDateTime");
														}
														/////////////////////////////////////////////////////////////////////////////////////////////////////	
														try {
															date100 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(StartDate1));
														} catch (Exception e) {
															date100 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd")
																			.parse(StartDate1));
														}
														try {
															java.util.Date dt = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.parse(StartDate1);
															ftime1 = "" + dt.getHours();
															ftime2 = "" + dt.getMinutes();
															ftime3 = "" + dt.getSeconds();
														} catch (Exception e) {
															ftime1 = "00";
															ftime2 = "00";
															ftime3 = "00";
														}
														try {
															date200 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(EndDate1));
														} catch (Exception e) {
															date200 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd")
																			.parse(EndDate1));
														}
														try {
															java.util.Date edt = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.parse(EndDate1);
															ttime1 = "" + edt.getHours();
															ttime2 = "" + edt.getMinutes();
															ttime3 = "" + edt.getSeconds();
														} catch (Exception e) {
															ttime1 = "23";
															ttime2 = "59";
															ttime3 = "59";
														}

														String sql502 = "select vehtype from db_gps.t_vehicledetails where  VehicleRegNumber='"
																+ VehRegNo1 + "' ";
														ResultSet rs502 = st3.executeQuery(sql502);
														if (rs502.next()) {
															vehtype1 = rs502.getString("vehtype");
														}
														if(vehtype1.equalsIgnoreCase("null")|| vehtype1==null)
														{
															vehtype1="-";
														}
														/*

														 String sql501="select count(RDurationinHrs) as runhr from db_gpsExceptions.t_vehall_ds where VehCode='"+Vehid+"' and TheDate >='"+date100+"' and TheDate <='"+date200+"' and RDuration>='10:00:00'";
														 ResultSet rs501=st4.executeQuery(sql501);
														 while(rs501.next())
														 {	runhr=rs501.getString("runhr");	
														 }
														 */

														String date1 = "", date2 = "", date311 = "", date411 = "";
														String Sdate = "";
														double runhrs = 00.00;
														double avgrunhrs = 00.00;
														int k = 0;
														try {
															date1 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("StartDate")));
															date2 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("EndDate")));
														} catch (Exception e) {
															date1 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(rs500
																			.getString("StartDate")));
															date2 = new SimpleDateFormat("yyyy-MM-dd")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd").parse(rs500
																			.getString("EndDate")));
														}
														session.setAttribute("data1", date1);
														session.setAttribute("data2", date2);
														String vehid = rs500.getString("Vehid");

														//ResultSet rs=null;

														/*
														 sql5="Select SUM(RDurationinHrs) as runhrs from db_gpsExceptions.t_veh"+vehid+"_ds where TheDate>='"+date1+"' and TheDate<='"+date2+"'";
														 if(i==52){}
														 ResultSet rs=st3.executeQuery(sql5);
														 if(rs.next()){
														 if(null==rs.getString("runhrs") || rs.getString("runhrs").equalsIgnoreCase("null"))     {
														 runhrs=00.00;      }
														 else{
														 runhrs=rs.getDouble("runhrs");}
														
														 }



														 avgrunhrs=runhrs/noofdays;
														 */

														int j = 0;

														j = runhrscnt;
														/*


														 sql5="Select RDurationinHrs  from db_gpsExceptions.t_veh"+vehid+"_ds where TheDate>='"+date1+"'and TheDate<='"+date2+"'";
														 if(i==52){}
														 rs=st3.executeQuery(sql5);
														 while(rs.next()){
														 if(rs.getDouble("RDurationinHrs")>10.00)	{
														 j++;	}}


														 */

														DecimalFormat twoDForm = new DecimalFormat(
																"00.00");
														String date3 = "", date4 = "";
														try {
															date3 = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("StartDate")));
															date4 = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("EndDate")));
														} catch (Exception e) {
															date3 = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("StartDate")
																					+ " "
																					+ rs500
																							.getString("StartTime")));
															date4 = new SimpleDateFormat(
																	"yyyy-MM-dd HH:mm:ss")
																	.format(new SimpleDateFormat(
																			"yyyy-MM-dd HH:mm:ss")
																			.parse(rs500
																					.getString("EndDate")
																					+ " "
																					+ rs500
																							.getString("EndTime")));

														}
														//System.out.println("date3->>"+date3);
														//System.out.println("date4---->>"+date4);
								%>
								<tr>
									<td style="text-align: right"><%=gk%></td>
									<td style="text-align: right"><%=VehRegNo1%></td>
									<td style="text-align: left"><%=vehtype1%></td>
									<td style="text-align: right"><a
										href="javascript:toggleDetails(<%=gk%>,true);"
										title="Click To See the Reports"> <%=tripid1%></a> <br>
									<div class="popup" id="popup<%=gk%>">
									<table border="1" bgcolor="white">
										<tr>
											<td><a href="#"
												onclick="javascript:window.open('detailed_report.jsp?vehcode=<%=Vehid%>&fromdata=<%=StartDate1%>&todata=<%=EndDate1%>&submit=Submit','','menubar=1,scrollbars=1,resizeable=0,width=900,height=900');">Detail
											Report</a></td>
										</tr>
										<tr>
											<td><a href="#"
												onclick="javascript:window.open('ActAndPlanJrnyCompOnMap.jsp?tripid=<%=tripid1%>&vehcode=<%=Vehid%>&data=<%=date100%>&data1=<%=date200%>&ftime1=<%=ftime1%>&ftime2=<%=ftime2%>&ftime3=<%=ftime3%>&ttime1=<%=ttime1%>&ttime2=<%=ttime2%>&ttime3=<%=ttime3%>&pg=cm&pstatus=<%=plannedstatus%>&brifid=<%=briefid%>&rid=<%=rid%>&driverid=<%=dcode%>','','menubar=1,scrollbars=1,resizeable=0,width=900,height=900');">Show
											Trip On Map</a></td>
										</tr>
										<tr>
											<td><a href="#"
												onclick="javascript:window.open('TripwiseException.jsp?startDate=<%=StartDate1%>&endDate=<%=EndDate1%>&vehcode=<%=Vehid%>&tripid=<%=tripid1%>','','menubar=1,scrollbars=1,resizeable=0,width=700,height=700');">TripWise
											Exception</a></td>
										</tr>
										<tr>
											<td><a href="#"
												onclick="javascript:window.open('endtrip1.jsp?tripid=<%=tripid1%>&EDate=<%=EndDate1%>&ETime=<%=EndTime1%>&vehcode=<%=Vehid%>','','menubar=1,scrollbars=1,resizeable=0,width=500,height=500');">Change
											Unload Time</a></td>
										</tr>
										<tr>
											<td><a href="javascript:toggleDetails(<%=gk%>,false);">Close
											</a></td>
										</tr>
									</table>
									</div>
									</td>
									<td style="text-align: left"><%=OwnerName1%></td>
									<td style="text-align: right"><%=date101%></td>
									<td style="text-align: right"><%=date201%></td>
									<td style="text-align: left"><%=StartPlace1%></td>
									<td style="text-align: left"><%=EndPlace1%></td>
									<td style="text-align: right"><%=KmTravelled1%></td>
									<td style="text-align: right" id="rhrcolcls<%=i%>"><%=twoDForm.format(runhrs)%></td>
									<td style="text-align: right" id="avcolcls<%=i%>"><%=twoDForm.format(avgrunhrs)%></td>
									<td style="text-align: right" id="rhrvcolcls<%=i%>"><%=j%></td>
									<td style="text-align: right" id="oscolcls<%=i%>"><%=rs500.getInt("OSCount")%></td>
									<td style="text-align: right" id="osscolcls<%=i%>"><%=twoDForm.format(rs500
												.getDouble("OSDuration"))%></td>
									<td style="text-align: right" id="rzonecolcls<%=i%>"><%=twoDForm
														.format(rs500
																.getDouble("OSDurationInRedZone"))%></td>
									<td style="text-align: right" id="yzonecolcls<%=i%>"><%=twoDForm
														.format(rs500
																.getDouble("OSDurationInYellowZone"))%></td>
									<td style="text-align: right" id="gzonecolcls<%=i%>"><%=twoDForm
														.format(rs500
																.getDouble("OSDurationInGreenZone"))%></td>
									<td style="text-align: right" id="racolcls<%=i%>"><%=rs500.getInt("RACount")%></td>
									<td style="text-align: right" id="rdcolcls<%=i%>"><%=rs500.getInt("RDCount")%></td>

									<td style="text-align: right" id="cdcolcls<%=i%>">
									<%
										int cdcnt = 0;

															/*
															 String sqlcd="select count(*) cdcount from db_gpsExceptions.t_veh"+Vehid+"_cr where concat(FromDate,' ',FromTime) between '"+date3+"' and '"+date4+"'";
															 ResultSet rscd=st16.executeQuery(sqlcd);
															 while(rscd.next()){
															 cdcnt=rscd.getInt("cdcount");
															 }
															 */

															cdcnt = CRcnt;
									%>
									<%
										if (cdcnt > 0) {
									%> <a
										href="detail_cd.jsp?vid=<%=rs500.getString("vehid")%>&vehno=<%=rs500.getString("VehRegNo")%>&pageType=ContinuousDriving&data1=<%=date3%>&data2=<%=date4%>"><%=cdcnt%></a>
									<%
										} else {
									%> <%=cdcnt%> <%
 	}
 %>
									</td>
									<td style="text-align: right" id="ndcolcls<%=i%>">
									<%
										if (rs500.getInt("NDCount") > 0) {
									%> <a
										href="detail_nd.jsp?vid=<%=rs500.getString("vehid")%>&vehno=<%=rs500.getString("vehregno")%>&pageType=NightDriving&data1=<%=date3%>&data2=<%=date4%>"">
									<%=rs500.getInt("NDCount")%> </a> <%
 	} else {
 %> <%=rs500.getInt("NDCount")%> <%
 	}
 %>
									</td>
									<%
										int d = 0;

															String ndduration = "";
															/*

															 sql5="select SUM(Distance) as distance,Sum(Time_to_Sec(Duration)) as duration from db_gpsExceptions.t_veh"+vehid+"_nd where concat(FromDate,' ',FromTime) >= '"+date3+"' and concat(FromDate,' ',FromTime)<='"+date4+"'";
															 System.out.println(k+"ND Distance>>>>>>     "+sql5);
															 if(i==68){	System.out.println(k+"ND Distance>>>>>>     "+sql5);}
															 try{
															 ResultSet	rs=st3.executeQuery(sql5);
															 if(rs.next()){
															 d=rs.getInt("distance");
															 ndduration=rs.getString("duration");
															 if(ndduration==null || ndduration.equalsIgnoreCase("null")){
															 ndduration="0";}
															 else{String rundur = "";
															 int min = 0,hrs = 0,min1 = 0;		
															 min1 = rs.getInt("duration")/60;
															 hrs = min1/60;
															 min = min1%60;		
															 if(hrs>9)
															 {rundur = rundur+hrs;}
															 else
															 {rundur = "0"+hrs;}
															 if(min>9)
															 {rundur = rundur+":"+min;}
															 else
															 {rundur = rundur+":0"+min;}
															 ndduration=rundur;		
															 }	
															 }



															 }
															 catch(Exception e){e.printStackTrace();}


															 */
									%>
									<td style="text-align: right" id="nddcolcls<%=i%>"><%=d %></td>
									<td style="text-align: right" id="ndducolcls<%=i%>"><%=ndduration%></td>
									<td style="text-align: right" id="dccolcls<%=i%>">


									<%
										/*
															 int discount=0, diskm=0;
															 String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rs500.getString("vehid")+"' and  OffTimeFrom >='"+rs500.getString("Startdate")+"'and  OffTimeTo<='"+rs500.getString("Enddate")+"' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30' ";
															 ResultSet rstdis=st2.executeQuery(sqldis);
															 if(rstdis.next())
															 {
															 if(rstdis.getInt("cnt")>0)	{
															 discount=rstdis.getInt("cnt");
															 diskm=rstdis.getInt("distance");
															
															 */
									%>
											<a href="disconnectedDetailsReport.jsp?vehicleCode=<%=rs500.getString("vehid")%>&VehicleRegNo=<%=rs500.getString("vehregno")%>&ownerName=<%=rs500.getString("OwnerName")%>&fromDateTime=<%=rs500.getString("Startdate")%>&toDateTime=<%=rs500.getString("EndDate")%>&counterv=<%=rstdis.getInt("cnt")%>&tripid=<%=rs500.getString("TripId")%>"> <%=discount%> </a>
									<%
										/*
															}
															else{
																		out.print("0");
															}}
															else{
															out.print("0");}


															 */
									%>
									<!-- </td> -->

									<td style="text-align: right" id="dckmcolcls<%=i%>">
									<%
										/*
															 if(discount>0){
															 */
									%>
										<%=diskm %>
									<%
										/*
															}
															else{	out.print(0);	}


															 */
									%>


									<!-- </td> -->


									<td style="text-align: right" id="ratcolcls<%=i%>"><%=twoDForm.format(rs500
												.getDouble("TripRating"))%></td>
									<%
										gk++;
														}
													
													} catch (Exception e) {
														e.printStackTrace();
														out.print("EXXXXXXX: " + e);
													}
									%>
								</tr>
							</table>
							</div>
							<%
								Cnt++;
											DivDisplay = "none";
										}
																	%>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr class="cbFormTableRow">
					<td colspan="4" class="cbHTMLBlockContainer"></td>
				</tr>
			</table>
			</div>








			<div style="background: #FAFAFE; width: 930px; margin-left: 50px">
			<h2 style="background: #485682; color: #ffffff; cursor: pointer;"
				onClick="Displayer(3)">&nbsp;+ 3. Fatigue Meter&nbsp;</h2>
			<table id="Section3" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div style="border: ; width: 109px;"><br></br>
					<table class="sortable" cellspacing="0" border="2">
						<tr>
							<td align="center" colspan="5"><b>Driver Run Hours </b></td>
						</tr>
						<tr>
							<td valign="top" style="background-color: #FFFFFF">
							<div id="div1"><IFRAME
								src='driverRunHoursChart.jsp?driverid=<%=driverid%>'
								scrolling=no id='banner1' width='800' height='350'
								style='padding-top: 10; padding-left: 10;' frameborder='0'></IFRAME>
							</div>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>
				<tr class="cbFormTableRow">
					<td colspan="4" class="cbHTMLBlockContainer"></td>
			</table>
			</div>
			<div style="background: #FAFAFE; width: 930px; margin-left: 50px">
			<h2 style="background: #485682; color: #ffffff; cursor: pointer;"
				onClick="Displayer(4)">&nbsp;+ 4. Incentive Details&nbsp;</h2>
			<table id="Section4" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div style="border: ; width: 109px;"><br></br>
					<table class="sortable" cellspacing="0" border="2">
						<tr>
							<td valign="top" style="background-color: #FFFFFF">
							<div id="div2"><IFRAME src='driverIncentiveShowDetails.jsp'
								scrolling="auto" id='banner2' width='900' height='350'
								style='padding-top: 10; padding-left: 10;' frameborder='0'
								seamless="seamless" sandbox=""></IFRAME></div>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>
				<tr class="cbFormTableRow">
					<td colspan="4" class="cbHTMLBlockContainer"></td>
			</table>
			</div>
			<%
				String get111 = "", colorIncident = "";
						int flg111 = 0;
						String sql221 = "select Incident from db_gps.t_briefing where Briefid='"
								+ BrifId
								+ "' and tripid='"
								+ TripId
								+ "' and Driverid='"
								+ DriveId
								+ "' and DriverName='" + DriverName + "'";
						ResultSet rs221 = st.executeQuery(sql221);
						while (rs221.next()) {
							get111 = rs221.getString("Incident");
							if (get111 == null) {
							} else {
								flg111 = 1;
							}
						}
						if (flg111 == 1) {
							colorIncident = "#56C556";
						} else {
							colorIncident = "#FF5959";
						}
			%> <%
 	String get112 = "", colorDmc = "";
 			int flg112 = 0;
 			String sql222 = "select DMC from db_gps.t_briefing where Briefid='"
 					+ BrifId
 					+ "' and tripid='"
 					+ TripId
 					+ "' and Driverid='"
 					+ DriveId
 					+ "' and DriverName='" + DriverName + "'";
 			ResultSet rs222 = st.executeQuery(sql222);
 			while (rs222.next()) {
 				get112 = rs222.getString("DMC");
 				if (get112 == null) {
 					flg112 = 0;
 				} else {
 					flg112 = 1;
 				}
 			}
 			if (flg112 == 1) {
 				colorDmc = "#56C556";
 			} else {
 				colorDmc = "#FF5959";
 			}
 %> <%
 	String get113 = "", colorGoal = "";
 			int flg113 = 0;
 			String sql223 = "select GoalsToBeAchieved from db_gps.t_briefing where Briefid='"
 					+ BrifId
 					+ "' and tripid='"
 					+ TripId
 					+ "' and Driverid='"
 					+ DriveId
 					+ "' and DriverName='" + DriverName + "'";
 			ResultSet rs223 = st.executeQuery(sql223);
 			while (rs223.next()) {
 				get113 = rs223.getString("GoalsToBeAchieved");
 				if (get113 == null) {
 				} else {
 					flg113 = 1;
 				}
 			}
 			if (flg113 == 1) {
 				colorGoal = "#56C556";
 			} else {
 				colorGoal = "#FF5959";
 			}
 %> <%
 	String red21 = "", colorJRM = "";
 			int flg114 = 0;
 			String sql292 = "select Total_N_Scr,JRM,probableND,probableCD from db_gps.t_briefing where Briefid='"
 					+ BrifId
 					+ "' and tripid='"
 					+ TripId
 					+ "' and Driverid='" + DriveId + "' ";
 			ResultSet rs292 = st.executeQuery(sql292);
 			try {
 				if (rs292.next()) {
 					probableCD = rs292.getString("probableCD");
 					probableND = rs292.getString("probableND");
 					red21 = rs292.getString("Total_N_Scr");
 					if (red21 == "0" || red21.equalsIgnoreCase("0")) {
 						flg114 = 0;
 					} else {
 						flg114 = 1;
 					}
 				}
 			} catch (Exception e) {
 				System.out.println(e);
 			}
 			if (flg114 == 1) {
 				colorJRM = "#56C556"; //Green
 			} else {
 				colorJRM = "#FF5959";//Red
 			}
 %> <input type="hidden" id="Tab4" name="Tab4" value="<%=flg111%>"></input>
			<div style="background: #FAFAFE; margin-left: 50px; width: 930px">
			<h2
				style="background:<%=colorIncident%>; color:#ffffff; cursor:pointer;"
				onClick="Displayer(5)">&nbsp;+ 5. Incidents Shared&nbsp;</h2>
			<table id="Section5" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div>
					<table class="cbFormNestedTable" cellspacing="0">
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordCoApplicant_First_Name"><b>List Of
							incidents shared :</b></label></td>
						</tr>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>Incident Category :</b> </label> <select
								class="element select medium" id="IncCat" name="IncCat"
								onchange="IncCategoery();" style="width: 150px">
								<%
									String sql210 = "select Categoery1 from db_gps.t_JourneyGoals where Categoery='incident_shared' group by Categoery1 order by Categoery1 ";
											int pn = 0;
											ResultSet rs210 = st.executeQuery(sql210);
											while (rs210.next()) {
								%>
								<option value="<%=rs210.getString("Categoery1")%>"
									title="<%=rs210.getString("Categoery1")%>"><%=rs210.getString("Categoery1")%></option>
								<%
									pn++;
											}
								%>
							</select></td>
						</tr>
						<tr>
							<td valign="top" class="cbFormLabelCell  cbFormLabel"><br>
							<select name="resources1" style="width: 300px" size="7"
								id="resources1" multiple="multiple">
								<%
									String sql236 = "select Options from db_gps.t_JourneyGoals where Categoery='incident_shared' and Categoery1='Minor'";
											ResultSet rs236 = st.executeQuery(sql236);
											while (rs236.next()) {
								%>
								<option value="<%=rs236.getString("Options")%>"
									title="<%=rs236.getString("Options")%>"><%=rs236.getString("Options")%></option>
								<%
									}
								%>
							</select></td>
							<td valign="middle" class="cbFormLabelCell  cbFormLabel"><br>
							<div><input type="button" class="button" value="&gt;"
								onClick="addUser2();" /></div>
							<div><input type="button" class="button" value="&lt;"
								onClick="removeUser2()" /></div>
							</td>
								<td valign="top" class="cbFormLabelCell  cbFormLabel"><br>
							<select name="assigned2" style="width: 300px" size="7"
								multiple="multiple">
								<%
									int a = 0;
											String sql22 = "select Incident from db_gps.t_briefing where Briefid='"
													+ BrifId
													+ "' and tripid='"
													+ TripId
													+ "' and Driverid='"
													+ DriveId
													+ "' and DriverName='" + DriverName + "'";
											ResultSet rs22 = st.executeQuery(sql22);
											while (rs22.next()) {
												get1 = rs22.getString("Incident");
												if (get1 == null) {
												} else {
													StringTokenizer stk = new StringTokenizer(get1, "~");
													a = stk.countTokens();
													while (stk.hasMoreTokens()) {
														get2 = stk.nextToken();
								%>
								<option title="<%=get2%>"><%=get2%></option>
								<%
									}
												}
								%>
								<%
									}
								%>
							</select> <select name="assigned3" style="width: 160px; display: none"
								size="7" multiple="multiple">
							</select></td>
							<td class="cbFormLabelCell  cbFormLabel"></td>
							<td class="cbFormLabelCell  cbFormLabel"><label for=""><b>Incidents
							shared :</b></label>
							<table class="sortable" cellspacing="0" border="2"
								style="height: ">
								<tr>
									<th class="cbFormLabelRequired">Incident Shared</th>
									<th class="cbFormLabelRequired">Count</th>
									<th class="cbFormLabelRequired">Date</th>
								</tr>
								<%
									int count = 0;
											String sql41 = "select Options from db_gps.t_JourneyGoals where Categoery='incident_shared' order by UpdatedDateTime";
											ResultSet rst41 = st.executeQuery(sql41);
											while (rst41.next()) {
												try {
													inci1 = rst41.getString("Options");
													int cnt = 0;
													String DD = "";
													//String sql40="select Incident,brifdate  from t_briefing where Driverid='"+DriveId+"' order by brifdate desc limit 5";
													String sql40 = "select count(Incident) as Incident,Max(brifdate) as brifdate from t_briefing where Driverid='"
															+ DriveId
															+ "' and Incident like '%"
															+ inci1 + "%'";
													ResultSet rs40 = st3.executeQuery(sql40);
													if (rs40.next()) {
														DD = new SimpleDateFormat("dd-MMM-yyyy")
																.format(new SimpleDateFormat(
																		"yyyy-MM-dd HH:mm:ss")
																		.parse(rs40
																				.getString("brifdate")));
														cnt = rs40.getInt("Incident");
													}
													if (cnt > 0) {
								%>
								<tr>
									<td style="text-align: left;"><%=inci1%></td>
									<td><%=cnt%></td>
									<td><%=DD%></td>
								</tr>
								<%
									}
												} catch (Exception e) {
													//System.out.println("^^^^^^6     " + e);
												}
											}
								%>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="cbFormNestedTableContainer">
							<div style="margin-right: -3px;">
							<table class="cbFormNestedTable" align="right" cellspacing="0">
								<tr>
									<td class="cbFormLabelCell  cbFormLabel">
									<td align="center" colspan="2"><br>
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black" value="Save"
										onclick="GetInci('<%=DriveId%>','<%=BrifId%>','<%=TripId%>')" /></td>
									<td>&nbsp;&nbsp;&nbsp;
									<td align="center" colspan="2"><br>
									<input type="button" value="Reset" onclick="IncReset()"
										class="button_text"
										style="border-style: outset; border-color: black" /></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>
				<tr class="cbFormTableRow">
					<td colspan="4" class="cbHTMLBlockContainer"></td>
			</table>
			</div>
			
			<div style="background: #FAFAFE; margin-left: 50px; width: 930px">
			<input type="hidden" id="Tab10" name="Tab10" value="<%=flg111%>"></input>
			<h2
				style="background:<%=colorIncident%>; color:#ffffff; cursor:pointer;"
				onClick="Displayer(9)">&nbsp;+ 6. Personal Engagement&nbsp;</h2>
			<table id="Section9" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div>
					<table class="cbFormNestedTable" cellspacing="0">
					<tr>
					
					<% 
					driveraddress=""; 
					String sqld="select driver_address from db_gps.t_drivers where DriverID='"+DriveId+"'";
					ResultSet rsd=std.executeQuery(sqld);
					if(rsd.next())
					{
						driveraddress=rsd.getString("driver_address");
					}
					if(driveraddress==null || driveraddress.equalsIgnoreCase("NULL")){
						driveraddress="";
					}
					//driveraddress="At-Po-Kothali,TQ-Motala, Dist-Buldhana";
				 String sqln="select Newsletter from t_briefing where Driverid='"+ DriveId+"'";
				ResultSet rsn=stn.executeQuery(sqln);
				while(rsn.next())
				{
					newsletter=rsn.getString("Newsletter");
				
					newsletter1=newsletter;
					newsletter1="'"+newsletter1+"'";
					newsletter=newsletter+",";
					news=news+","+newsletter1;
					
					
				}
				try{
				newsletter=newsletter.substring(0, newsletter.length()-1);
				}catch(Exception e)
				{
					
					e.printStackTrace();
				}
				//	newsletter="News1,News2";
					
					%>
					
					<td class="cbFormLabelCell  cbFormLabel" colspan="0"><label
								for=""><b>Driver Address:</b> </label></td>
							<td><textarea id="driveradd" name="driveradd"  
												rows="2" cols="35" readonly="readonly"><%=driveraddress%></textarea></td>
												<td><button id="driveraddr" value="Edit" name="edit" height="150" onclick="return clear1();" width="100">Edit</button>
												</td>
			</tr>
			
			<tr>
			<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>Newsletter Shared :</b> </label>
								<label><%=newsletter %></label>
								</td>
								
			   
			</tr>
			
			<tr>
			<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>Newsletter Shared In This Session:</b> </label> <select
								class="element select medium" id="Innewletter" name="Innewletter"
								 style="width: 150px">
								 <option value="Select" selected="selected">Select</option>
					<%	
					//String sqlnews="select Newsletter from t_briefing where Driverid='"+ DriveId+"' and Newsletter not in ("+news+")";
					String sqlnews="select Options from db_gps.t_JourneyGoals where Categoery='newsletter_shared' and  Options not in ("+news+")";
					System.out.println("sqlnews:-"+sqlnews);
					ResultSet rsnews=stnews.executeQuery(sqlnews);
					while(rsnews.next())
					{
					%>			
								<option value=<%=rsnews.getString("Options") %>> <%=rsnews.getString("Options") %></option>
								
								
								
							<%} %>
							</select>	
								</td>
			</tr>
			
			<tr>
									<td class="cbFormLabelCell  cbFormLabel">
									<td></td>
									<td align="center" colspan="2"><br>
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black" value="Save"
										onclick="GetNews('<%=DriveId%>','<%=BrifId%>','<%=TripId%>','<%=request.getParameter("driveradd")%>')" /></td>
									
									<!-- <td align="center" colspan="2"><br>
									<input type="button" value="Reset" onclick="IncReset()"
										class="button_text"
										style="border-style: outset; border-color: black" /></td> -->
								</tr>
			</table>
			</div>
			
			</table>
			</div>
			
			<input type="hidden" id="Tab5" name="Tab5" value="<%=flg112%>"></input>
			<div style="background: #FAFAFE; width: 930px; margin-left: 50px">
			<h2 style="background:<%=colorDmc%>; color:#ffffff; cursor:pointer;"
				onClick="Displayer(6)">&nbsp;+ 7. DMC/Trainer Input&nbsp;</h2>
			<table id="Section6" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div>
					<table class="cbFormNestedTable" cellspacing="0">
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordCoApplicant_First_Name"><b>List Of
							DMC/Counsellor Input :</b></label></td>
						</tr>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>DMC Counseling Category :</b> </label> <select
								class="element select medium" id="DmcCat" name="DmcCat"
								onchange="chkCategoery();" style="width: 150px">
								<%
									String sql200 = "select Categoery1 from db_gps.t_JourneyGoals where Categoery='DMC_Trainer_Input' group by Categoery1 order by Categoery1";
											int p = 0;
											ResultSet rs200 = st.executeQuery(sql200);
											while (rs200.next()) {
								%>
								<option value="<%=rs200.getString("Categoery1")%>"
									title="<%=rs200.getString("Categoery1")%>"><%=rs200.getString("Categoery1")%></option>
								<%
									p++;
											}
								%>
							</select></td>
						</tr>
						<tr class="cbFormTableRow" align="center">
							<td valign="top" class="cbFormLabelCell  cbFormLabel"><br>
							<select name="resources5" style="width: 300px" size="7"
								id="resources5" multiple="multiple">
								<%
									String sql235 = "select Options from db_gps.t_JourneyGoals where Categoery='DMC_Trainer_Input' and Categoery1='Environment'";
											ResultSet rs235 = st.executeQuery(sql235);
											while (rs235.next()) {
								%>
								<option value="<%=rs235.getString("Options")%>"
									title="<%=rs235.getString("Options")%>"><%=rs235.getString("Options")%></option>
								<%
									}
								%>
							</select></td>
							<td valign="top" class="cbFormLabelCell  cbFormLabel"><br>
							<div><input type="button" class="button" value="&gt;"
								onClick="addUser4();" /></div>
							<div><input type="button" class="button" value="&lt;"
								onClick="removeUser4()" /></div>
							</td>
							<td align="center" valign="top"
								class="cbFormLabelCell  cbFormLabel"><br>
							<select name="assigned6" style="width: 300px" size="7"
								multiple="multiple">
								<%
									int h = 0;
											String sql31 = "select DMC from db_gps.t_briefing where Briefid='"
													+ BrifId
													+ "' and tripid='"
													+ TripId
													+ "' and Driverid='"
													+ DriveId
													+ "' and DriverName='" + DriverName + "'";
											ResultSet rs31 = st.executeQuery(sql31);
											while (rs31.next()) {
												getD1 = rs31.getString("DMC");
												if (getD1 == null) {
												} else {
													StringTokenizer stk = new StringTokenizer(getD1,
															"~");
													h = stk.countTokens();
													while (stk.hasMoreTokens()) {
														getD2 = stk.nextToken();
								%>
								<option title="<%=getD2%>"><%=getD2%></option>
								<%
									}
												}
								%>
								<%
									}
								%>
							</select> <select name="assigned7" style="width: 160px; display: none"
								size="7" multiple="multiple">
							</select></td>
						</tr>
						<tr>
							<td>
							<table class="cbFormNestedTable" cellspacing="0">
								<tr>
									<td class="cbFormLabelCell  cbFormLabel"><label
										for="InsertRecordStreet_Address"><b>Probable CD :
									</b></label></td>
									<%%>
									<td colspan="4" class="cbFormNestedTableContainer">
									<td class="cbFormFieldCell">
									<%
										if (probableCD == "Yes"
														|| probableCD.equalsIgnoreCase("Yes")) {
									%> <input type="radio" checked="checked" name="PCD" id="PCD" value="YES"
										onclick="showtext7()" /><b>YES</b> <%
 	} else {
 %> <input type="radio" name="PCD" id="PCD" value="YES"
										onclick="showtext7()" /><b>YES</b> <%
 	}
 %>
									</td>
									<td class="cbFormFieldCell">
									<%
										if (probableCD == "No" || probableCD.equalsIgnoreCase("No")) {
									%> <input type="radio" name="PCD" checked="checked" id="PCD" value="NO"
										onclick="showtext7()" /><b>NO</b> <%
 	} else {
 %> <input type="radio" name="PCD" id="PCD" value="NO"
										onclick="showtext7()" /><b>NO</b> <%
 	}
 %>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table class="cbFormNestedTable" cellspacing="0">
								<tr>
									<td class="cbFormLabelCell  cbFormLabel"><label
										for="InsertRecordStreet_Address"><b>Probable ND :
									</b></label></td>
									<%%>
									<td colspan="4" class="cbFormNestedTableContainer">
									<td class="cbFormFieldCell">
									<%
										if (probableND.equalsIgnoreCase("Yes")
														|| probableND == "Yes") {
									%> <input type="radio" checked="checked" name="PNd" id="PNd"
										value="YES" onclick="showtext6()" /><b>YES</b> <%
 	} else {
 %> <input type="radio" name="PNd" id="PNd" value="YES"
										onclick="showtext6()" /><b>YES</b> <%
 	}
 %>
									</td>
									<td class="cbFormFieldCell">
									<%
										if (probableND == "No" || probableND.equalsIgnoreCase("No")) {
									%> <input type="radio" name="PNd" checked="checked" id="PNd" value="NO"
										onclick="showtext6()" /><b>NO</b> <%
 	} else {
 %> <input type="radio" name="PNd" id="PNd" value="NO"
										onclick="showtext6()" /><b>NO</b> <%
 	}
 %>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="cbFormNestedTableContainer">
							<div style="margin-right: -3px;">
							<table class="cbFormNestedTable" align="right" cellspacing="0">
								<tr>
									<td class="cbFormLabelCell  cbFormLabel">
									<td align="center" colspan="2"><br>
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black" value="Save"
										onclick="GetDmc('<%=DriveId%>','<%=BrifId%>','<%=TripId%>')" /></td>
									<td>&nbsp;&nbsp;&nbsp;
									<td align="center" colspan="2"><br>
									<input type="button" value="Reset" onclick="DmcReset()"
										class="button_text"
										style="border-style: outset; border-color: black" /></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>
				<tr class="cbFormTableRow">
					<td colspan="4" class="cbHTMLBlockContainer"></td>
			</table>
			</div>
			<input type="hidden" id="Tab6" name="Tab6" value="<%=flg113%>"></input>
			<div style="background: #FAFAFE; width: 930px; margin-left: 50px">
			<h2
				style="background:<%=colorGoal%>; color:#ffffff; cursor:pointer;"
				onClick="Displayer(7)">&nbsp;+ 8. Goal Of Conversation&nbsp;</h2>
			<table id="Section7" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div>
					<table class="cbFormNestedTable" cellspacing="0">
						<tr>
							<td class="cbFormLabelCell  cbFormLabel"><label
								for="InsertRecordCoApplicant_First_Name"><b>Goals :</b></label>
							</td>
						</tr>
						<tr>
							<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>Goal Category :</b> </label> <select
								class="element select medium" id="GoalCat" name="GoalCat"
								onchange="GoalCategoery();" style="width: 150px">
								<%
									String sql201 = "select Categoery1 from db_gps.t_JourneyGoals where Categoery='Goal_Brif' group by Categoery1 order by Categoery1";
											int rt = 0;
											ResultSet rs201 = st.executeQuery(sql201);
											while (rs201.next()) {
								%>
								<option value="<%=rs201.getString("Categoery1")%>"
									title="<%=rs201.getString("Categoery1")%>"><%=rs201.getString("Categoery1")%></option>
								<%
									rt++;
											}
								%>
							</select></td>

						</tr>
						<tr class="cbFormTableRow" align="center">
							<td valign="top" class="cbFormLabelCell  cbFormLabel"><br>
							<select name="resources3" style="width: 300px; overflow: scroll;"
								size="7" id="resources3" multiple="multiple">
								<%
									String sql206 = "select Options from db_gps.t_JourneyGoals where Categoery='Goal_Brif' and Categoery1='Skill'";
											ResultSet rs206 = st.executeQuery(sql206);
											while (rs206.next()) {
								%>
								<option value="<%=rs206.getString("Options")%>"
									title="<%=rs206.getString("Options")%>"><%=rs206.getString("Options")%></option>
								<%
									}
								%>
							</select></td>
							<td valign="top" class="cbFormLabelCell  cbFormLabel"><br>
							<div><input type="button" class="button" value="&gt;"
								onClick="addUser3();" /></div>
							<div><input type="button" class="button" value="&lt;"
								onClick="removeUser3()" /></div>
							</td>
							<td align="center" valign="top"
								class="cbFormLabelCell  cbFormLabel"><br>
							<select name="assigned4" style="width: 300px" size="7"
								multiple="multiple">
								<%
									int b = 0;
											String sql23 = "select GoalsToBeAchieved from db_gps.t_briefing where Briefid='"
													+ BrifId
													+ "' and tripid='"
													+ TripId
													+ "' and Driverid='" + DriveId + "'";
											ResultSet rs23 = st.executeQuery(sql23);
											while (rs23.next()) {
												goal1 = rs23.getString("GoalsToBeAchieved");
												if (goal1 == null) {
												} else {
													StringTokenizer stk = new StringTokenizer(goal1,
															"~");
													b = stk.countTokens();
													while (stk.hasMoreTokens()) {
														goal1 = stk.nextToken();
								%>
								<option title="<%=goal1%>"><%=goal1%></option>
								<%
									}
												}
								%>
								<%
									}
								%>
							</select> <select name="assigned5" style="width: 160px; display: none"
								size="7" multiple="multiple">
							</select></td>
						</tr>
						<td></td>
						<td></td>
						<td><font color="Red" size="1"> * Maximum 3 Goals for
						trip can be set</font></td>
						<tr>
							<td colspan="4" class="cbFormNestedTableContainer">
							<div style="margin-right: -3px;">
							<table class="cbFormNestedTable" align="right" cellspacing="0">
								<tr>
									<td class="cbFormLabelCell  cbFormLabel">
									<td align="center" colspan="2"><br>
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black" value="Save"
										onclick="GetGoal('<%=DriveId%>','<%=BrifId%>','<%=TripId%>')" /></td>
									<td>&nbsp;&nbsp;&nbsp;
									<td align="center" colspan="2"><br>
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black"
										value="Reset" onclick="GoalReset()" /></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>
				<tr class="cbFormTableRow">
					<td colspan="4" class="cbHTMLBlockContainer"></td>
			</table>
			</div>
			<div style="background: #FAFAFE; width: 930px; margin-left: 50px">
			<input type="hidden" id="Tab7" name="Tab7" value="<%=flg114%>"></input>
			<h2 style="background: #485682; color: #ffffff; cursor: pointer;"
				onClick="Displayer(8)">&nbsp;+ 9. JRM Route / Journey
			Planning&nbsp;</h2>
			<table id="Section8" style="display: none; width: 930px;">
				<tr>
					<td class="cbFormLabelCell  cbFormLabel"><font><b>Journey
					Plan : </b></font> &nbsp;&nbsp;&nbsp;&nbsp; <label><a href="#"
						onclick="open1('<%=DriveId%>','<%=BrifId%>')"><font size="2"><b>&nbsp;&nbsp;Create
					/ View </b></font></a></label></td>
				</tr>

				<tr class="cbFormTableRow" align="center">
					<td colspan="4" class="cbFormNestedTableContainer">
					<table class="cbFormNestedTable" cellspacing="0">
						<tr>
							<td class="cbFormLabelCell  cbFormLabel" width="300px"><label
								for="InsertRecordStreet_Address"><b>JRM Route :</b></label></td>
							<%
								String sql28 = "select jrmpercent from db_gps.t_jrmrouteadvancedmaster where StartCode ='"
												+Sp1+"' and EndCode ='"+Ep1+"'";
										System.out.println("sql28" + sql28);
										ResultSet rs28 = st.executeQuery(sql28);
										if (rs28.next()) {
											per11 = rs28.getInt("jrmpercent");

										}
							%>
							<%
								scr_N_DH = 0;
										scr_N_Adh = 0;
										scr_N_ND = 0;
										scr_N_CD = 0;
										scr_N_DVI = 0;
										String sql33 = "select JrmReason,scr_N_DH,scr_N_ND,scr_N_CD,scr_N_DVI  from db_gps.t_briefing where Briefid='"
												+ BrifId
												+ "' and tripid='"
												+ TripId
												+ "' and Driverid='" + DriveId + "'";
										ResultSet rs33 = st.executeQuery(sql33);

										if (rs33.next()) {
											res11 = rs33.getString("JrmReason");
											scr_N_DH = rs33.getInt("scr_N_DH");
											scr_N_ND = rs33.getInt("scr_N_ND");
											scr_N_CD = rs33.getInt("scr_N_CD");
											scr_N_DVI = rs33.getInt("scr_N_DVI");
										}
							%>
							
							<%
								if (flgJRM == 1) {
							%>
							<script language="javascript">
	 var Val224 = document.getElementById("percent").value = "<%=per11%>";
	 showtext5();
		Val224.value=<%=per11%>;
	</script>
							<%
								}if (flgJRM == 2) {
							%>
							<script language="javascript">
showtext5();
 document.getElementById("Reason1").value = "<%=res11%>";
</script>
							<%
								}
							%>
							<td class="cbFormNestedTableContainer" align="center">
							<div align="center">
							<table class="cbFormNestedTable" cellspacing="0">
								<tr>
									
									<%
									
									
									String TmpJRM = "";
										if (per11 < 1) {
													TmpJRM = "No";
									%>
									<td class="cbFormLabelCell  cbFormLabel" style="width: 200px">

									<b>JRM data not available for this route. </b></td>
									<td width="50%">
									<table>
										<tr>
											<td>Escalate_to (Email-ID): &nbsp;&nbsp;</td>
											<td><input type="text" id="emailR11" name="emailR11"
												style="width: 400px;"></td>
										</tr>
										<tr>
											<td valign="top">Message: &nbsp;&nbsp;</td>
											<td><textarea id="authoReason11" name="authoReason11"
												rows="2" cols="55"></textarea></td>
										</tr>
										<tr>
											<td></td>
											<td align="center" id="Tmail" style="display: "><input
												type="button" class="button_text"
												style="border-style: outset; border-color: black"
												value="Escalate"
												onclick="GetMail4('<%=DriveId%>','<%=BrifId%>','<%=TripId%>','<%=BriStartPlc%>','<%=BriEndPlc%>')" />
											</td>
										</tr>
									</table>
									</td>

									<%
										} else {
													TmpJRM = "Yes";
									%>
									<td class="cbFormLabelCell  cbFormLabel" width="150"><label
										type="radio" checked="checked" name="Jrm" id="Jrm" value="YES"
										onclick="showtext5()" /><b>YES</b> <label
										for="InsertRecordUnit_Number"><b>&nbsp;&nbsp;&nbsp;&nbsp;
									Percent :</b></label></td>
									<td class="cbFormLabelCell  cbFormLabel" width="100"><%=per11%>
									% <input type="hidden" id="percent" name="percent"
										value="<%=per11%>" class="element text medium"
										style="width: 50px" readonly="readonly"></input></td>
									<%
										}
									%>


									<!-- //// -->


									<%
										String routename = "", routeid1 = "";
												int totzone = 0, totkm = 0, redzone = 0, redkm = 0, yellowzone = 0, yelllowkm = 0, greenzone = 0, greenkm = 0;
												sql = "select *  from db_gps.t_jrmrouteadvancedmaster where StartCode ='"
														+Sp1+"' and EndCode = '"+Ep1+"'";
												System.out.println("RRRR****   " + sql);
												ResultSet rs = s.executeQuery(sql);
												if (rs.next()) {
													routeid1 = rs.getString("routeid");
													totzone = rs.getInt("totalzone");
													totkm = rs.getInt("totalkm");
													redzone = rs.getInt("redzonecount");
													redkm = rs.getInt("redzonedist");
													yellowzone = rs.getInt("yellowzonecount");
													yelllowkm = rs.getInt("yellowzonedist");
													greenzone = rs.getInt("greenzonecount");
													greenkm = rs.getInt("greenzonedist");
													routename = rs.getString("routename");
												}

												//routeid = "1";
									%>
									<input type="hidden" name="routeid1" value="<%=routeid1%>"
										id="routeid1">
									<%

									
if(routeid1 == null  || routeid1.equals("") || routeid1.equals("null") || routeid1.equals(" "))
		{
			
		}
		else
		{	
%>
									<td width="50%" align="center">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<table border="1" class="sortable" align="center"
										style="width: 60px;">
										<tr>
											<th></th>
											<th>Total</th>
											<th>Red</th>
											<th>Yellow</th>
											<th>Green</th>
										</tr>
										<tr>
											<td align="left">
											<div align="left">Zones</div>
											</td>
											<td align="right">
											<div align="right"><%=totzone%></div>
											</td>
											<td align="right" style="background-color: #FF9E9E">
											<div align="right"><%=redzone%></div>
											</td>
											<td align="right" style="background-color: #FFF2A1">
											<div align="right"><%=yellowzone%></div>
											</td>
											<td align="right" style="background-color: #C6FFB5">
											<div align="right"><%=greenzone%></div>
											</td>
										</tr>
										<tr>
											<td align="left">
											<div align="left">KM</div>
											</td>
											<td align="right">
											<div align="right"><%=totkm%></div>
											</td>
											<td align="right" style="background-color: #FF9E9E">
											<div align="right"><%=redkm%></div>
											</td>
											<td align="right" style="background-color: #FFF2A1">
											<div align="right"><%=yelllowkm%></div>
											</td>
											<td align="right" style="background-color: #C6FFB5">
											<div align="right"><%=greenkm%></div>
											</td>
										</tr>
									</table>
									</td>
									
								</tr>
								<tr>

									<td class="cbFormFieldCell"><input type="hidden"
										name="TTJRM" id="TTJRM" value="<%=TmpJRM%>"></input></td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>		
			</table>
			</div>

	</table>
	
	<div style="margin-top: 10px; margin-left: 750px">
	<table class="cbFormNestedTable" align="c" cellspacing="0">
		<tr>
			<td style="margin-left: 0px"><input type="button"
				class="button_text"
				style="border-style: outset; border-color: black"
				value="Save Briefing "
				onclick="GetFinal('<%=DriveId%>','<%=BrifId%>')" /></td>
			<td style="margin-left: 0px"><input type="button"
				class="button_text"
				style="border-style: outset; border-color: black"
				value="Delete Briefing" onclick="OpenF();" /></td>
		</tr>

	</table>

	</div>

	<% 
										}} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					fleetview.closeConnection();
				} catch (Exception e) {
				}
				con1.close();
			}		%>
	 <input type="hidden" name="Mod0InsertRecordPageID" value="" /> 
	 <input	type="hidden" name="PrevPageID" value="" />
	
	
	</form>
	
	
	</body>

</jsp:useBean>
<%@ include file="footernew.jsp" %> --%>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
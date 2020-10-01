function savefeed(Q,Y)
{
	var f = document.getElementById("comment").value
	try
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
				var reslt=ajaxRequest.responseText;
				//alert(reslt.indexOf("unsuccess"));
				if(reslt.indexOf("Successful") > 0)
				{
					savefeed1(Q,Y);
				}
				
			} 
		};
		var queryString = "?f="+f+"&Q="+Q+"&Y="+Y+"&t=c";
		ajaxRequest.open("GET", "feedbackinsert.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
	
}

function calculatepoints4(type)
{
	//alert("Hii");
	try
	{
	var Q1 = document.getElementById("quarter").value;
	var Y1 = document.getElementById("year").value;
	var T1 =  document.getElementById("Trans").value;
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
			reslt=reslt.replace(/^\s+|\s+$/g,'');
			var token = reslt.split("~");
			//alert(token[0]);
			if(token[0] == "1")
			{
			document.getElementById("JPHvalue").innerHTML = token[1];
			document.getElementById("JPHscore").innerHTML = token[2];
			document.getElementById("DDvalue").innerHTML = token[3];
			document.getElementById("DDscore").innerHTML = token[4];
			document.getElementById("VFTPRvalue").innerHTML = token[5];
			document.getElementById("VFTPRscore").innerHTML = token[6];
			document.getElementById("CSAvalue").innerHTML = token[7];
			document.getElementById("CSAscore").innerHTML = token[8];
			document.getElementById("CLIvalue").innerHTML = token[9];
			document.getElementById("CLIscore").innerHTML = token[10];
			document.getElementById("Viovalue").innerHTML = token[11];
			document.getElementById("Vioscore").innerHTML = token[12];
			document.getElementById("TIscore").innerHTML = token[13];
			}
			else
				if(token[0] == "2")
				{
					document.getElementById("VFTPRvalue").innerHTML = token[1];
					document.getElementById("VFTPRscore").innerHTML = token[2];
					document.getElementById("TIscore").innerHTML = token[3];
				}
				else
					if(token[0] == "3")
					{
						document.getElementById("Viovalue").innerHTML = token[1];
						document.getElementById("Vioscore").innerHTML = token[2];
						document.getElementById("TIscore").innerHTML = token[3];
					}
					else
						if(token[0] == "4")
						{
							document.getElementById("JPHvalue").innerHTML = token[1];
							document.getElementById("JPHscore").innerHTML = token[2];
							document.getElementById("DDvalue").innerHTML = token[3];
							document.getElementById("DDscore").innerHTML = token[4];
							document.getElementById("TIscore").innerHTML = token[5];
						}
						else
							if(token[0] == "5")
							{
								document.getElementById("CLIvalue").innerHTML = token[1];
								document.getElementById("CLIscore").innerHTML = token[2];
								document.getElementById("TIscore").innerHTML = token[3];
							}
							else
								if(token[0] == "6")
								{
									document.getElementById("CSAvalue").innerHTML = token[1];
									document.getElementById("CSAscore").innerHTML = token[2];
									document.getElementById("TIscore").innerHTML = token[3];
								}
		} 
	};
	//alert("jhdfjdvn");
	var queryString = "?type="+type+"&Q1="+Q1+"&Y1="+Y1+"&T1="+T1;
	ajaxRequest.open("GET", "calculatetotincentive.jsp"+queryString, true);
	
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
}

function savefeed1(Q,Y)
{
	var f = document.getElementById("FeedBack").value
	try
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
				var reslt=ajaxRequest.responseText;
				//alert(reslt.indexOf("unsuccess"));
				if(reslt.indexOf("Successful") > 0)
				{
					savefeed2(Q,Y);
				}
				
			} 
		};
		var queryString = "?f="+f+"&Q="+Q+"&Y="+Y+"&t=f";
		ajaxRequest.open("GET", "feedbackinsert.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
	
}

function savefeed2(Q,Y)
{
	var f = document.getElementById("suggestions").value
	try
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
				var reslt=ajaxRequest.responseText;
				//alert(reslt.indexOf("unsuccess"));
				if(reslt.indexOf("Successful") > 0)
				{
					alert("Successfully Saved");
				}
				
			} 
		};
		var queryString = "?f="+f+"&Q="+Q+"&Y="+Y+"&t=s";
		ajaxRequest.open("GET", "feedbackinsert.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
	
}

function checkvalidity5(id,num)
{
	var checkvalue =document.getElementById(id).value;
	//alert("checkvalue "+checkvalue);
	if(id == "comment")
	{
		//alert("checkvalue "+checkvalue);
		if(checkvalue.length>=500)
		{
			alert("Comment Entered is too long. Max limit is 500 characters !!");
			document.getElementById(id).value = "";
		}
	}
	if(id == "FeedBack")
	{
		//alert("checkvalue "+checkvalue);
		if(checkvalue.length>=500)
		{
			alert("FeedBack Entered is too long. Max limit is 500 characters !!");
			document.getElementById(id).value = "";
		}
	}
	if(id == "suggestions")
	{
		//alert("checkvalue "+checkvalue);
		if(checkvalue.length>=500)
		{
			alert("Suggestions Entered is too long. Max limit is 500 characters !!");
			document.getElementById(id).value = "";
		}
	}
}

function savejourney() 
{
	var j1 = document.getElementById("JRMReview").value;
	var j2 = document.getElementById("requestDMC").value;
	var j3 = document.getElementById("JRMDS").value;
	var j4 = document.getElementById("DevAppr").value;
	var j5 = document.getElementById("VioMonitorS").value;
	var Q1 = document.getElementById("quarter").value;
	var Y1 = document.getElementById("year").value;
	var T1 =  document.getElementById("Trans").value;
	
	try
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
				var reslt=ajaxRequest.responseText;
				//alert(reslt.indexOf("unsuccess"));
				if(reslt.indexOf("Successful") > 0)
				{
					alert("Successfully Saved");
					document.getElementById("journeyscore").innerHTML = document.getElementById("Jsectionscore").innerHTML;
					var vehscore = document.getElementById("vehiclescore").innerHTML;vehscore++;vehscore--;
					var driverscore = document.getElementById("driverscore").innerHTML;driverscore++;driverscore--;
					var jrnyscore = document.getElementById("journeyscore").innerHTML;jrnyscore++;jrnyscore--;
					var processscore = document.getElementById("processscore").innerHTML;processscore++;processscore--;
					var bonusscore = document.getElementById("bonusscore").value;bonusscore++;bonusscore--;
					var totscore = vehscore+driverscore+jrnyscore+processscore+bonusscore;
					//alert("totscore   "+totscore);
					var er = /^[0-9]+$/;
					if(er.test(totscore))
					{}
					else
					{
						var totscore1 = totscore+"";
						var token = totscore1.split(".");
						if(token[1].length > 2)
						{
							totscore = token[0]+"."+token[1].substring(0,2);
						}
					}
					document.getElementById("selfauditscore").innerHTML = "&nbsp;"+totscore;
					savesummary1(4);
				}
				
			} 
		};
		var queryString = "?j1="+j1+"&j2="+j2+"&j3="+j3+"&j4="+j4+"&j5="+j5+"&Q1="+Q1+"&Y1="+Y1+"&T1="+T1;
		ajaxRequest.open("GET", "journeyvalinsert1.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
}

function checkvalidity2(id,num)
{
	try
	{
		var checkvalue =document.getElementById(id).value;
		if(isNaN(checkvalue))
		{
			alert("Please Enter numeric Value !!!");
			document.getElementById(id).value = 0;
			return false;
		}

		if(checkvalue.length>=11)
		{
			alert("Entered Value is too long. Please enter valid integer value !!");
			document.getElementById(id).value = 0;
			return false;
		}
		
		var oth=checkvalue.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		if(checkvalue=="" || oth=="")
		{
			document.getElementById(id).value = 0;
		}
	}
	catch(e)
	{
		alert(e);
	}
}
	
function calculatepoints2()
{
	try
	{
		if(document.getElementById("JRMDS").value == "Yes")
		{
			document.getElementById("JRMD").innerHTML = document.getElementById("MJRMD").innerHTML;
			//document.getElementById("JRMD1").value = document.getElementById("MJRMD").innerHTML;
		}
		else
		{
			document.getElementById("JRMD").innerHTML = "0";
			//document.getElementById("JRMD1").value = "0";
		}

		if(document.getElementById("DevAppr").value == "Yes")
		{
			document.getElementById("DevApprovalS").innerHTML = document.getElementById("MDevApprovalS").innerHTML;
			//document.getElementById("DevApprovalS1").value = document.getElementById("MDevApprovalS").innerHTML;
		}
		else
		{
			document.getElementById("DevApprovalS").innerHTML = "0";
			//document.getElementById("DevApprovalS1").value = "0";
		}
	
		if(document.getElementById("VioMonitorS").value == "Yes")
		{
			document.getElementById("VioMonitor").innerHTML = document.getElementById("MVioMonitor").innerHTML;
			//document.getElementById("VioMonitor1").value = document.getElementById("MVioMonitor").innerHTML;
		}
		else
		{
			document.getElementById("VioMonitor").innerHTML = "0";
			//document.getElementById("VioMonitor1").value = "0";
		}
		
		var JRMAdh = document.getElementById("JRMAdh").innerHTML;JRMAdh++;JRMAdh--;
		var zerodvi = document.getElementById("zerodvi").innerHTML;zerodvi++;zerodvi--;
		var JRMD = document.getElementById("JRMD").innerHTML;JRMD++;JRMD--;
		var DevApprovalS = document.getElementById("DevApprovalS").innerHTML;DevApprovalS++;DevApprovalS--;
		var VioMonitor = document.getElementById("VioMonitor").innerHTML;VioMonitor++;VioMonitor--;
		var er = /^[0-9]+$/;
		var secscore = JRMAdh+zerodvi+JRMD+DevApprovalS+VioMonitor;
		if(er.test(secscore))
		{}
		else
		{
			var secscore1 = secscore+"";
			var token = secscore1.split(".");
			if(token[1].length > 2)
			{
				secscore = token[0]+"."+token[1].substring(0,2);
			}
		}
		document.getElementById("Jsectionscore").innerHTML = secscore;
		//document.getElementById("sectionscore1").value = secscore;
		
	}
	catch(e)
	{
		alert(e);
	}
}

function getScore2(num)
{
	if(num== 1)
	{
		if(document.getElementById("JRMDS").value == "Yes")
		{
			document.getElementById("JRMD").innerHTML = document.getElementById("MJRMD").innerHTML;
			//document.getElementById("JRMD1").value = document.getElementById("MJRMD").innerHTML;
		}
		else
		{
			document.getElementById("JRMD").innerHTML = "0";
			//document.getElementById("JRMD1").value = "0";
		}
	}
	if(num== 2)
	{
		if(document.getElementById("DevAppr").value == "Yes")
		{
			document.getElementById("DevApprovalS").innerHTML = document.getElementById("MDevApprovalS").innerHTML;
			//document.getElementById("DevApprovalS1").value = document.getElementById("MDevApprovalS").innerHTML;
		}
		else
		{
			document.getElementById("DevApprovalS").innerHTML = "0";
			//document.getElementById("DevApprovalS1").value = "0";
		}
	}
	if(num== 3)
	{
		if(document.getElementById("VioMonitorS").value == "Yes")
		{
			document.getElementById("VioMonitor").innerHTML = document.getElementById("MVioMonitor").innerHTML;
			//document.getElementById("VioMonitor1").value = document.getElementById("MVioMonitor").innerHTML;
		}
		else
		{
			document.getElementById("VioMonitor").innerHTML = "0";
			//document.getElementById("VioMonitor1").value = "0";
		}
	}
	
	var JRMAdh = document.getElementById("JRMAdh").innerHTML;JRMAdh++;JRMAdh--;
	var zerodvi = document.getElementById("zerodvi").innerHTML;zerodvi++;zerodvi--;
	var JRMD = document.getElementById("JRMD").innerHTML;JRMD++;JRMD--;
	var DevApprovalS = document.getElementById("DevApprovalS").innerHTML;DevApprovalS++;DevApprovalS--;
	var VioMonitor = document.getElementById("VioMonitor").innerHTML;VioMonitor++;VioMonitor--;
	var er = /^[0-9]+$/;
	var secscore = JRMAdh+zerodvi+JRMD+DevApprovalS+VioMonitor;
	if(er.test(secscore))
	{}
	else
	{
		var secscore1 = secscore+"";
		var token = secscore1.split(".");
		if(token[1].length > 2)
		{
			secscore = token[0]+"."+token[1].substring(0,2);
		}
	}
	document.getElementById("Jsectionscore").innerHTML = secscore;
	//document.getElementById("sectionscore1").value = secscore;
	
}
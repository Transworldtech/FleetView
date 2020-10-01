function checkfilter()
{
	var quarter = document.getElementById("quarter").value;
	var year1 = document.getElementById("year").value;
	var date=new Date();
	var currmonth = date.getMonth()+1;
	var curryear  = date.getFullYear();
	var currquarter = 0;
	//alert("quarter  "+quarter);
	//alert("year1  "+year1);
	//alert("currmonth  "+currmonth);
	//alert("curryear  "+curryear);
	
	if(currmonth == 1 || currmonth == 2 || currmonth ==3)
	{
		currquarter = 1;
	}
	if(currmonth == 4 || currmonth == 5 || currmonth ==6)
	{
		currquarter = 2;
	}
	if(currmonth == 7 || currmonth == 8 || currmonth ==9)
	{
		currquarter = 3;
	}
	if(currmonth == 10 || currmonth == 11 || currmonth ==12)
	{
		currquarter = 4;
	}
	
	//alert("curryear  "+curryear);
	if(year1 > curryear)
	{
		alert("Selected year should not be greater than Current Year");
		document.getElementById("year").value = curryear;
		return false;
	}
	else
		if(year1 == curryear)
		{
			if(quarter > currquarter)
			{
				alert("Selected Quarter should not be greater than Current Quarter");
				document.getElementById("quarter").value = currquarter;
				return false;
			}
		}
   }

function savesummary()
{
	//alert("Hiii   ");
	var p1 = document.getElementById("Name").value;
	var p2 = document.getElementById("location").value;
	var p3 = document.getElementById("data1").value;
	var p4 = document.getElementById("auditby").value;
	var p5 = document.getElementById("reviewby").value;
	var p6 = document.getElementById("bonusscore").value;
	var p7 = document.getElementById("selfauditscore").innerHTML;
	p7 = p7.replace("&nbsp;","");
	var Q1 = document.getElementById("quarter").value;
	var Y1 = document.getElementById("year").value;
	var T1 =  document.getElementById("Trans").value;
	flag = 0;
	
	var oth=p1.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(p1=="" || oth=="")
	{
		alert("Please Enter Name");
		flag = 1;
		return false;
	}
	if(p1.length>=255)
	{
		alert("Name Entered is too long. Please enter valid Name !!");
		document.getElementById("Name").value = "";
		flag = 1;
		return false;
	}
	
	if(p2.length>=255)
	{
		alert("Entered Value is too long. Please enter valid Location !!");
		document.getElementById("location").value = "";
		flag = 1;
		return false;
	}
	
	oth=p4.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(p4=="" || oth=="")
	{
		alert("Please Enter Name in  Audit Done By Field");
		flag = 1;
		return false;
	}
	if(p4.length>=255)
	{
		alert("Entered Value is too long. Please enter valid  Name !!");
		document.getElementById("auditby").value = "";
		flag = 1;
		return false;
	}

	oth=p5.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(p5=="" || oth=="")
	{
		alert("Please Enter Name in  reviewed by field");
		flag = 1;
		return false;
	}
	if(p5.length>=255)
	{
		alert("Entered Value is too long. Please enter valid  Name !!");
		document.getElementById("reviewby").value = "";
		flag = 1;
		return false;
	}
	
	
	if(flag == 0)
	{
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
					calculatepoints4(6);
				}
				
			} 
		};
		var queryString = "?p1="+p1+"&p2="+p2+"&p3="+p3+"&p4="+p4+"&p5="+p5+"&p6="+p6+"&p7="+p7+"&Q1="+Q1+"&Y1="+Y1+"&T1="+T1;
		ajaxRequest.open("GET", "summaryinsert.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
	}
}

function savesummary1(num)
{
	//alert("Hiii   ");
	var p1 = document.getElementById("Name").value;
	var p2 = document.getElementById("location").value;
	var p3 = document.getElementById("data1").value;
	var p4 = document.getElementById("auditby").value;
	var p5 = document.getElementById("reviewby").value;
	var p6 = document.getElementById("bonusscore").value;
	var p7 = document.getElementById("selfauditscore").innerHTML;
	p7 = p7.replace("&nbsp;","");
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
				reslt=reslt.replace(/^\s+|\s+$/g,'');
				if(reslt.indexOf("Successful") > 0)
				{
					//alert("Successfully Saved");
				}
				else
				{
					calculatepoints4(reslt);
				}
				
			} 
		};
		var queryString = "?p1="+p1+"&p2="+p2+"&p3="+p3+"&p4="+p4+"&p5="+p5+"&p6="+p6+"&p7="+p7+"&Q1="+Q1+"&Y1="+Y1+"&T1="+T1+"&num="+num;
		ajaxRequest.open("GET", "summaryinsert.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
}

function checkvalidity4(id,num)
{
	//alert("Hii");
		var checkvalue =document.getElementById(id).value;
		//alert("checkvalue "+checkvalue);
		if(id == "Name")
		{
			//alert("checkvalue "+checkvalue);
			var oth=checkvalue.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if(checkvalue=="" || oth=="")
			{
				alert("Please Enter Name");
			}
			if(checkvalue.length>=255)
			{
				alert("Entered Value is too long. Please enter valid Name !!");
				document.getElementById(id).value = "";
			}
		}
		if(id == "location")
		{
			if(checkvalue.length>=255)
			{
				alert("Entered Value is too long. Please enter valid Location !!");
				document.getElementById(id).value = "";
			}
		}
		if(id == "auditby")
		{
			var oth=checkvalue.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if(checkvalue=="" || oth=="")
			{
				alert("Please Enter Name in  Audit Done By Field");
			}
			if(checkvalue.length>=255)
			{
				alert("Entered Value is too long. Please enter valid  Name !!");
				document.getElementById(id).value = "";
			}
		}
		if(id == "reviewby")
		{
			var oth=checkvalue.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if(checkvalue=="" || oth=="")
			{
				alert("Please Enter Name in  reviewed by field");
			}
			if(checkvalue.length>=255)
			{
				alert("Entered Value is too long. Please enter valid  Name !!");
				document.getElementById(id).value = "";
			}
		}
		
		if(id == "bonusscore")
		{
			//alert("checkvalue"+checkvalue+"888888888888")
			var oth=checkvalue.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			if(checkvalue=="" || oth=="")
			{
				alert("Please Enter Valid Bonus score");
				document.getElementById(id).value = 0;
			}
			
			if(isNaN(checkvalue))
			{
				alert("Please Enter numeric Value !!!");
				document.getElementById(id).value = 0;
				//return false;
			}

			if(checkvalue.length>=11)
			{
				alert("Entered Value is too long. Please enter valid integer value !!");
				document.getElementById(id).value = 0;
				//return false;
			}
			
			var vehscore = document.getElementById("vehiclescore").innerHTML;vehscore++;vehscore--;
			var driverscore = document.getElementById("driverscore").innerHTML;driverscore++;driverscore--;
			var jrnyscore = document.getElementById("journeyscore").innerHTML;jrnyscore++;jrnyscore--;
			var processscore = document.getElementById("processscore").innerHTML;processscore++;processscore--;
			var bonusscore = document.getElementById("bonusscore").value;bonusscore++;bonusscore--;
			var totscore = vehscore+driverscore+jrnyscore+processscore+bonusscore;
			//alert("totscore   "+totscore);
			//alert("totscore   "+(totscore > 100.00));
			if(totscore > 100.00)
			{
				bonusscore = 0.0;
				alert("Contractor Self Audit Score should not be greater than Max Score (i.e 100).");
				document.getElementById("bonusscore").value = bonusscore;
				totscore = vehscore+driverscore+jrnyscore+processscore+bonusscore;
			}
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
		}

}

function saveprocess()
{
	var p1 = document.getElementById("NoDamage").value;
	var p2 = document.getElementById("DamageGoods").value;
	var p3 = document.getElementById("QIncident").value;
	var p4 = document.getElementById("PolicyDoc").value;
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
					document.getElementById("processscore").innerHTML = document.getElementById("Psectionscore").innerHTML;
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
					savesummary1(5);
				}
				
			} 
		};
		var queryString = "?p1="+p1+"&p2="+p2+"&p3="+p3+"&p4="+p4+"&Q1="+Q1+"&Y1="+Y1+"&T1="+T1;
		ajaxRequest.open("GET", "processvalinsert1.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
	
}

function calculatepoints3()
{
	try
	{
		//alert("HIii");
		if(document.getElementById("PolicyDoc").value == "Yes")
		{
			document.getElementById("PolicyDocScore").innerHTML = document.getElementById("MPolicyDocScore").innerHTML;
			//document.getElementById("PolicyDocScore1").value = document.getElementById("MPolicyDocScore").innerHTML;
		}
		else
		{
			document.getElementById("PolicyDocScore").innerHTML = "0";
			//document.getElementById("PolicyDocScore1").value = "0";
		}
		
		var LoadSecure = document.getElementById("NoDamageScore").innerHTML;LoadSecure++;LoadSecure--;
		var StopScore = document.getElementById("StopScore").innerHTML;StopScore++;StopScore--;
		var LAClosureScore = document.getElementById("LAClosureScore").innerHTML;LAClosureScore++;LAClosureScore--;
		var PolicyDocScore = document.getElementById("PolicyDocScore").innerHTML;PolicyDocScore++;PolicyDocScore--;
		
		var er = /^[0-9]+$/;
		var secscore = LoadSecure+StopScore+LAClosureScore+PolicyDocScore;
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
		document.getElementById("Psectionscore").innerHTML = secscore;
		//document.getElementById("sectionscore1").value = secscore;
		
		
		document.getElementById("showsummary").value = "1";
		document.getElementById("showvehicle").value = "0";
		document.getElementById("showdriver").value = "0";
		document.getElementById("showjourney").value = "0";
		document.getElementById("showprocess").value = "0";
		document.getElementById("consummary").value = "0";
		document.getElementById("commentsug").value = "0";
		//document.getElementById("totalscore").value = "1";
	}
	catch(e)
	{
		alert(e);
	}
}

function getScore3(num)
{
	if(document.getElementById("PolicyDoc").value == "Yes")
	{
		document.getElementById("PolicyDocScore").innerHTML = document.getElementById("MPolicyDocScore").innerHTML;
		//document.getElementById("PolicyDocScore1").value = document.getElementById("MPolicyDocScore").innerHTML;
	}
	else
	{
		document.getElementById("PolicyDocScore").innerHTML = "0";
	//	document.getElementById("PolicyDocScore1").value = "0";
	}
	
	var LoadSecure = document.getElementById("NoDamageScore").innerHTML;LoadSecure++;LoadSecure--;
	var StopScore = document.getElementById("StopScore").innerHTML;StopScore++;StopScore--;
	var LAClosureScore = document.getElementById("LAClosureScore").innerHTML;LAClosureScore++;LAClosureScore--;
	var PolicyDocScore = document.getElementById("PolicyDocScore").innerHTML;PolicyDocScore++;PolicyDocScore--;
	
	var er = /^[0-9]+$/;
	var secscore = LoadSecure+StopScore+LAClosureScore+PolicyDocScore;
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
	document.getElementById("Psectionscore").innerHTML = secscore;
	//document.getElementById("sectionscore1").value = secscore;
}

function checkvalidity3(id,num)
{
	try
	{
		//alert("Hii");
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
		
		if(num == "1")
		{
			var er = /^[0-9]+$/;
			var tottrips = document.getElementById("tottrips3").innerHTML;tottrips++;tottrips--;
			//alert(tottrips);
			var damagetrips = document.getElementById("NoDamage").value;damagetrips++;damagetrips--;
			var MNoDamageScore = document.getElementById("MNoDamageScore").innerHTML;MNoDamageScore++;MNoDamageScore--;
			var NoDamageScore = 0;
			if(damagetrips>tottrips)
			{
				alert("No-Damage Trips should not be greater than Total Trips");
				document.getElementById("NoDamage").value = 0;
				damagetrips = 0;
			}
			
			if(tottrips > 0)
			{
				NoDamageScore = (damagetrips/tottrips)*MNoDamageScore;
			}
			if(er.test(NoDamageScore))
			{}
			else
			{
				var NoDamageScore1 = NoDamageScore+"";
				var token = NoDamageScore1.split(".");
				if(token[1].length > 2)
				{
					NoDamageScore = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("NoDamageScore").innerHTML = NoDamageScore;
			//document.getElementById("NoDamageScore1").value = NoDamageScore;
			NoDamageScore++;
			NoDamageScore--;
			var StopScore = document.getElementById("StopScore").innerHTML;StopScore++;StopScore--;
			var LAClosureScore = document.getElementById("LAClosureScore").innerHTML;LAClosureScore++;LAClosureScore--;
			var PolicyDocScore = document.getElementById("PolicyDocScore").innerHTML;PolicyDocScore++;PolicyDocScore--;
			var secscore = NoDamageScore+StopScore+LAClosureScore+PolicyDocScore;
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
			document.getElementById("Psectionscore").innerHTML = secscore;
			//document.getElementById("sectionscore1").value = secscore;
		}
		
	}
	catch(e)
	{
		alert(e);
	}
}

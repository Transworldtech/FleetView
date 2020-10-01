function savedriver() 
{
	var v1 =document.getElementById("Toverdue").value;var v2 =document.getElementById("Moverdue").value;
	var v3 =document.getElementById("DPS").value;var v4 =document.getElementById("Decletter").value;
	var v5 =document.getElementById("DUR").value;
	var v6 =document.getElementById("DYD1").value;var v7 =document.getElementById("DQD1").value;
	var v8=document.getElementById("DQC1").value;var v9 =document.getElementById("DO1").innerHTML;
	var v10 =document.getElementById("DYC1").value;var v11 =document.getElementById("DYD2").value;
	var v12 =document.getElementById("DQD2").value;var v13 =document.getElementById("DQC2").value;
	var v14 =document.getElementById("DO2").innerHTML;var v15 =document.getElementById("DYC2").value;
	var v16 =document.getElementById("DYD3").value;var v17 =document.getElementById("DQD3").value;
	var v18 =document.getElementById("DQC3").value;var v19 =document.getElementById("DO3").innerHTML;
	var v20=document.getElementById("DYC3").value;var v21 =document.getElementById("DYD4").value;
	var v22=document.getElementById("DQD4").value;var v23 =document.getElementById("DQC4").value;
	var v24 =document.getElementById("DO4").innerHTML;var v25 =document.getElementById("DYC4").value;
	var v26 =document.getElementById("DYD5").value;var v27=document.getElementById("DQD5").value;
	var v28 =document.getElementById("DQC5").value;var v29=document.getElementById("DO5").innerHTML;
	var v30 =document.getElementById("DYC5").value;var v31=document.getElementById("DYD6").value;
	var v32 =document.getElementById("DQD6").value;var v33 =document.getElementById("DQC6").value;
	var v34 =document.getElementById("DO6").innerHTML;var v35 =document.getElementById("DYC6").value;
	var Q1 = document.getElementById("quarter").value;var Y1 = document.getElementById("year").value;
	var v36 = document.getElementById("Drivblacklist").value;
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
					document.getElementById("driverscore").innerHTML = document.getElementById("Dsectionscore").innerHTML;
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
					savesummary1(3);
				}
				
			} 
		};
		var queryString = "?v1="+v1+"&v2="+v2+"&v2="+v2+"&v3="+v3+"&v4="+v4+"&v5="+v5+"&v6="+v6+"&v7="+v7+"&v8="+v8+"&v9="+v9+"&v10="+v10+"&v11="+v11+"&v12="+v12+"&v13="+v13+
										"&v14="+v14+"&v15="+v15+"&v16="+v16+"&v17="+v17+"&v18="+v18+"&v19="+v19+"&v20="+v20+"&v21="+v21+"&v22="+v22+"&v23="+v23+"&v24="+v24+"&v25="+v25+"&v26="+v26+"&v27="+v27+
										"&v28="+v28+"&v29="+v29+"&v30="+v30+"&v31="+v31+"&v32="+v32+"&v33="+v33+"&v34="+v34+"&v35="+v35+"&Q1="+Q1+"&Y1="+Y1+"&v36="+v36;
		ajaxRequest.open("GET", "driverauditinsert1.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
}
	


function getScore1(num)
{
	if(num== 1)
	{
		if(document.getElementById("DPS").value == "Yes")
		{
			document.getElementById("drivpresent").innerHTML = document.getElementById("MDPS").innerHTML;
//			document.getElementById("drivpresent1").value = document.getElementById("MDPS").innerHTML;
		}
		else
		{
			document.getElementById("drivpresent").innerHTML = "0";
			//document.getElementById("drivpresent1").value = "0";
		}
	}
	if(num== 2)
	{
		if(document.getElementById("Decletter").value == "Yes")
		{
			document.getElementById("letter").innerHTML = document.getElementById("MDecletter").innerHTML;
			//document.getElementById("letter1").value = document.getElementById("MDecletter").innerHTML;
		}
		else
		{
			document.getElementById("letter").innerHTML = "0";
			//document.getElementById("letter1").value = "0";
		}
	}
	if(num== 3)
	{
		if(document.getElementById("DUR").value == "Yes")
		{
			document.getElementById("UpdatedRegister").innerHTML = document.getElementById("MDUR").innerHTML;
			//document.getElementById("UpdatedRegister1").value = document.getElementById("MDUR").innerHTML;
		}
		else
		{
			document.getElementById("UpdatedRegister").innerHTML = "0";
			//document.getElementById("UpdatedRegister1").value = "0";
		}
	}

	var DTO = document.getElementById("DTO").innerHTML;
	DTO++;
	DTO--;
	var DMO = document.getElementById("DMO").innerHTML;
	DMO++;
	DMO--;
	var driverreject = document.getElementById("driverreject").innerHTML;
	driverreject++;
	driverreject--;
	var Acleaner = document.getElementById("Acleaner").innerHTML;
	Acleaner++;
	Acleaner--;
	var drivpresent = document.getElementById("drivpresent").innerHTML;
	drivpresent++;
	drivpresent--;
	var letter = document.getElementById("letter").innerHTML;
	letter++;
	letter--;
	var UpdatedRegister = document.getElementById("UpdatedRegister").innerHTML;
	UpdatedRegister++;
	UpdatedRegister--;
	var MCheck = document.getElementById("MCheck").innerHTML;
	MCheck++;
	MCheck--;
	var Basic = document.getElementById("Basic").innerHTML;
	Basic++;
	Basic--;
	var cap1 = document.getElementById("cap1").innerHTML;
	cap1++;
	cap1--;
	var cap2 = document.getElementById("cap2").innerHTML;
	cap2++;
	cap2--;
	var cap3 = document.getElementById("cap3").innerHTML;
	cap3++;
	cap3--;
	var Rcap = document.getElementById("Rcap").innerHTML;
	Rcap++;
	Rcap--;
	
	var secscore = DTO+DMO+driverreject+Acleaner+drivpresent+letter+UpdatedRegister+MCheck+Basic+cap1+cap2+cap3+Rcap;
	var er = /^[0-9]+$/;
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
	document.getElementById("Dsectionscore").innerHTML = secscore;
//	document.getElementById("sectionscore1").value = secscore;
}

function calculatepoints1()
{
	try
	{
	//alert("Hiiii");
		if(document.getElementById("DPS").value == "Yes")
		{
			document.getElementById("drivpresent").innerHTML = document.getElementById("MDPS").innerHTML;
//			document.getElementById("drivpresent1").value = document.getElementById("MDPS").innerHTML;
		}
		else
		{
			document.getElementById("drivpresent").innerHTML = "0";
			//document.getElementById("drivpresent1").value = "0";
		}

		if(document.getElementById("Decletter").value == "Yes")
		{
			document.getElementById("letter").innerHTML = document.getElementById("MDecletter").innerHTML;
			//document.getElementById("letter1").value = document.getElementById("MDecletter").innerHTML;
		}
		else
		{
			document.getElementById("letter").innerHTML = "0";
			//document.getElementById("letter1").value = "0";
		}
	
		if(document.getElementById("DUR").value == "Yes")
		{
			document.getElementById("UpdatedRegister").innerHTML = document.getElementById("MDUR").innerHTML;
		//	document.getElementById("UpdatedRegister1").value = document.getElementById("MDUR").innerHTML;
		}
		else
		{
			document.getElementById("UpdatedRegister").innerHTML = "0";
		//	document.getElementById("UpdatedRegister1").value = "0";
		}
		document.getElementById("DTO").innerHTML = "1";
		document.getElementById("DMO").innerHTML = "1";
		document.getElementById("driverreject").innerHTML = "1";
		var DTO = document.getElementById("DTO").innerHTML;
		DTO++;
		DTO--;
		var DMO = document.getElementById("DMO").innerHTML;
		DMO++;
		DMO--;
		var driverreject = document.getElementById("driverreject").innerHTML;
		driverreject++;
		driverreject--;
		var Acleaner = document.getElementById("Acleaner").innerHTML;
		Acleaner++;
		Acleaner--;
		var drivpresent = document.getElementById("drivpresent").innerHTML;
		drivpresent++;
		drivpresent--;
		var letter = document.getElementById("letter").innerHTML;
		letter++;
		letter--;
		var UpdatedRegister = document.getElementById("UpdatedRegister").innerHTML;
		UpdatedRegister++;
		UpdatedRegister--;
	var due1 = document.getElementById("DQD1").value;
	due1++;
	due1--;
	var complete1 = document.getElementById("DQC1").value;
	complete1++;
	complete1--;
	document.getElementById("DO1").innerHTML =due1 - complete1;
	var due2 = document.getElementById("DQD2").value;
	due2++;
	due2--;
	var complete2 = document.getElementById("DQC2").value;
	complete2++;
	complete2--;
	document.getElementById("DO2").innerHTML =due2 - complete2;
	var due3 = document.getElementById("DQD3").value;
	due3++;
	due3--;
	var complete3 = document.getElementById("DQC3").value;
	complete3++;
	complete3--;
	document.getElementById("DO3").innerHTML =due3 - complete3;
	var due4 = document.getElementById("DQD4").value;
	due4++;
	due4--;
	var complete4 = document.getElementById("DQC4").value;
	complete4++;
	complete4--;
	document.getElementById("DO4").innerHTML =due4 - complete4;
	var due5 = document.getElementById("DQD5").value;
	due5++;
	due5--;
	var complete5 = document.getElementById("DQC5").value;
	complete5++;
	complete5--;
	document.getElementById("DO5").innerHTML =due5 - complete5;
	var due6 = document.getElementById("DQD6").value;
	due6++;
	due6--;
	var complete6 = document.getElementById("DQC6").value;
	complete6++;
	complete6--;
	document.getElementById("DO6").innerHTML =due6 - complete6;
	var er = /^[0-9]+$/;
	var MMcheck = document.getElementById("MMCheck").innerHTML;
	var MCheck = 0;
	if(due1 > 0)
	{
		MCheck = (complete1/due1)*MMcheck;
	}
	else
	{
		MCheck = MMcheck;
	}
	if(er.test(MCheck))
	{}
	else
	{
		var MCheck1 = MCheck+"";
		var token = MCheck1.split(".");
		if(token[1].length > 2)
		{
			MCheck = token[0]+"."+token[1].substring(0,2);
		}
	}
	document.getElementById("MCheck").innerHTML = MCheck;
	//document.getElementById("MCheck1").value = MCheck;
	MCheck++;
	MCheck--;
	
	var MBasic = document.getElementById("MBasic").innerHTML;
	var Basic = 0;
	if(due2 > 0)
	{
		Basic = (complete2/due2)*MBasic;
	}
	else
	{
		Basic = MBasic;
	}
	if(er.test(Basic))
	{}
	else
	{
		var Basic1 = Basic+"";
		var token = Basic1.split(".");
		if(token[1].length > 2)
		{
			Basic = token[0]+"."+token[1].substring(0,2);
		}
	}
	document.getElementById("Basic").innerHTML = Basic;
	//document.getElementById("Basic1").value = Basic;
	Basic++;
	Basic--;
	
	var Mcap1 = document.getElementById("Mcap1").innerHTML;
	var cap1 = 0;
	if(due3 > 0)
	{
		cap1 = (complete3/due3)*Mcap1;
	}
	else
	{
		cap1 = Mcap1;
	}
	if(er.test(cap1))
	{}
	else
	{
		var cap11 = cap1+"";
		var token = cap11.split(".");
		if(token[1].length > 2)
		{
			cap1 = token[0]+"."+token[1].substring(0,2);
		}
	}
	document.getElementById("cap1").innerHTML = cap1;
	//document.getElementById("caps1").value = cap1;
	cap1++;
	cap1--;
	
	var Mcap2 = document.getElementById("Mcap2").innerHTML;
	var cap2 = 0;
	if(due4 > 0)
	{
		cap2 = (complete4/due4)*Mcap2;
	}
	else
	{
		cap2= Mcap2;
	}
	if(er.test(cap2))
	{}
	else
	{
		var cap21 = cap2+"";
		var token = cap21.split(".");
		if(token[1].length > 2)
		{
			cap2 = token[0]+"."+token[1].substring(0,2);
		}
	}
	document.getElementById("cap2").innerHTML = cap2;
	//document.getElementById("caps2").value = cap2;
	cap2++;
	cap2--;
	
	var Mcap3 = document.getElementById("Mcap3").innerHTML;
	var cap3 = 0
	if(due5 > 0)
	{
		cap3 = (complete5/due5)*Mcap3;
	}
	else
	{
		cap3 = Mcap3;
	}
	if(er.test(cap3))
	{}
	else
	{
		var cap31 = cap3+"";
		var token = cap31.split(".");
		if(token[1].length > 2)
		{
			cap3 = token[0]+"."+token[1].substring(0,2);
		}
	}
	document.getElementById("cap3").innerHTML = cap3;
	//document.getElementById("caps3").value = cap3;
	cap3++;
	cap3--;
	
	var MRcap = document.getElementById("MRcap").innerHTML;
	var Rcap = 0;
	if(due6 > 0)
	{
		Rcap = (complete6/due6)*MRcap;
	}
	else
	{
		Rcap = MRcap;
	}
	if(er.test(Rcap))
	{}
	else
	{
		var Rcap1 = Rcap+"";
		var token = Rcap1.split(".");
		if(token[1].length > 2)
		{
			Rcap = token[0]+"."+token[1].substring(0,2);
		}
	}
	
	document.getElementById("Rcap").innerHTML = Rcap;
	//document.getElementById("Rcap1").value = Rcap;
	Rcap++;
	Rcap--;

	var secscore = DTO+DMO+driverreject+Acleaner+drivpresent+letter+UpdatedRegister+MCheck+Basic+cap1+cap2+cap3+Rcap;
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
	document.getElementById("Dsectionscore").innerHTML = secscore;
	//document.getElementById("sectionscore1").value = secscore;
	}
	catch(e)
	{
		alert(e);
	}
}

function checkvalidity1(id,num)
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
		
		var DTO = document.getElementById("DTO").innerHTML;
		DTO++;
		DTO--;
		var DMO = document.getElementById("DMO").innerHTML;
		DMO++;
		DMO--;
		var driverreject = document.getElementById("driverreject").innerHTML;
		driverreject++;
		driverreject--;
		var Acleaner = document.getElementById("Acleaner").innerHTML;
		Acleaner++;
		Acleaner--;
		var drivpresent = document.getElementById("drivpresent").innerHTML;
		drivpresent++;
		drivpresent--;
		var letter = document.getElementById("letter").innerHTML;
		letter++;
		letter--;
		var UpdatedRegister = document.getElementById("UpdatedRegister").innerHTML;
		UpdatedRegister++;
		UpdatedRegister--;
		
		var MMcheck = document.getElementById("MMCheck").innerHTML;
		var MCheck = document.getElementById("MCheck").innerHTML;MCheck++;MCheck--;
		var MBasic = document.getElementById("MBasic").innerHTML;
		var Basic = document.getElementById("Basic").innerHTML;Basic++;Basic--;
		var Mcap1 = document.getElementById("Mcap1").innerHTML;
		var cap1 = document.getElementById("cap1").innerHTML;cap1++;cap1--;
		var Mcap2 = document.getElementById("Mcap2").innerHTML;
		var cap2 = document.getElementById("cap2").innerHTML;cap2++;cap2--;
		var Mcap3 = document.getElementById("Mcap3").innerHTML;
		var cap3 =document.getElementById("cap3").innerHTML;cap3++;cap3--;
		var MRcap = document.getElementById("MRcap").innerHTML;
		var Rcap = document.getElementById("Rcap").innerHTML;Rcap++;Rcap--;
		var er = /^[0-9]+$/;
		
		if(num == "1")
		{
			var yeardue = document.getElementById("DYD1").value;yeardue++;yeardue--;
			var quarterdue = document.getElementById("DQD1").value;quarterdue++;quarterdue--;
			var quartercomp = document.getElementById("DQC1").value;quartercomp++;quartercomp--;
			var overdue = document.getElementById("DO1").innerHTML;overdue++;overdue--;
			var totalcomp = document.getElementById("DYC1").value;totalcomp++;totalcomp--;

			if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
			{
				alert("Due in the year should be greater than other values!!!");
				document.getElementById("DYD1").value = 0;
				document.getElementById("DQD1").value = 0;
				document.getElementById("DQC1").value = 0;
				document.getElementById("DO1").innerHTML = 0;
				document.getElementById("DYC1").value = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}

			if(quarterdue < quartercomp)
			{
				alert("Due in the quarter should be greater completed in the quarter!!!");
				document.getElementById("DQD1").value = 0;
				document.getElementById("DQC1").value = 0;
				document.getElementById("DO1").innerHTML = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}
			
			if(id=="DQC1" || id=="DQD1")
			{
				var calcoverdue = quarterdue - quartercomp;
				document.getElementById("DO1").innerHTML = calcoverdue;
			}
			
			if(quarterdue > 0)
			{
				MCheck = (quartercomp/quarterdue)*MMcheck;
			}
			else
			{
				MCheck = MMcheck;
			}
			//alert(MCheck);
			if(er.test(MCheck))
			{}
			else
			{
				var MCheck1 = MCheck+"";
				var token = MCheck1.split(".");
				if(token[1].length > 2)
				{
					MCheck = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("MCheck").innerHTML = MCheck;
			//document.getElementById("MCheck1").value = MCheck;
			MCheck++;
			MCheck--;
		}
		
		if(num == "2")
		{
			var yeardue = document.getElementById("DYD2").value;yeardue++;yeardue--;
			var quarterdue = document.getElementById("DQD2").value;quarterdue++;quarterdue--;
			var quartercomp = document.getElementById("DQC2").value;quartercomp++;quartercomp--;
			var overdue = document.getElementById("DO2").innerHTML;overdue++;overdue--;
			var totalcomp = document.getElementById("DYC2").value;totalcomp++;totalcomp--;

			if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
			{
				alert("Due in the year should be greater than other values!!!");
				document.getElementById("DYD2").value = 0;
				document.getElementById("DQD2").value = 0;
				document.getElementById("DQC2").value = 0;
				document.getElementById("DO2").innerHTML = 0;
				document.getElementById("DYC2").value = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}

			if(quarterdue < quartercomp)
			{
				alert("Due in the quarter should be greater completed in the quarter!!!");
				document.getElementById("DQD2").value = 0;
				document.getElementById("DQC2").value = 0;
				document.getElementById("DO2").innerHTML = 0;
				quarterdue = 0;quartercomp = 0;
			}
			
			if(id=="DQC2"  || id=="DQD2")
			{
				var calcoverdue = quarterdue - quartercomp;
				document.getElementById("DO2").innerHTML = calcoverdue;
			}
			
			if(quarterdue > 0)
			{
				Basic = (quartercomp/quarterdue)*MBasic;
			}
			else
			{
				Basic = MBasic;
			}
			
			if(er.test(Basic))
			{}
			else
			{
				var Basic1 = Basic+"";
				var token = Basic1.split(".");
				if(token[1].length > 2)
				{
					Basic = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("Basic").innerHTML = Basic;
		//	document.getElementById("Basic1").value = Basic;
			Basic++;
			Basic--;
		}
		
		if(num == "3")
		{
			var yeardue = document.getElementById("DYD3").value;yeardue++;yeardue--;
			var quarterdue = document.getElementById("DQD3").value;quarterdue++;quarterdue--;
			var quartercomp = document.getElementById("DQC3").value;quartercomp++;quartercomp--;
			var overdue = document.getElementById("DO3").innerHTML;overdue++;overdue--;
			var totalcomp = document.getElementById("DYC3").value;totalcomp++;totalcomp--;

			if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
			{
				alert("Due in the year should be greater than other values!!!");
				document.getElementById("DYD3").value = 0;
				document.getElementById("DQD3").value = 0;
				document.getElementById("DQC3").value = 0;
				document.getElementById("DO3").innerHTML = 0;
				document.getElementById("DYC3").value = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}

			if(quarterdue < quartercomp)
			{
				alert("Due in the quarter should be greater completed in the quarter!!!");
				document.getElementById("DQD3").value = 0;
				document.getElementById("DQC3").value = 0;
				document.getElementById("DO3").innerHTML = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}
			
			if(id=="DQC3"  || id=="DQD3")
			{
				var calcoverdue = quarterdue - quartercomp;
				document.getElementById("DO3").innerHTML = calcoverdue;
			}
			
			if(quarterdue > 0)
			{
				cap1 = (quartercomp/quarterdue)*Mcap1;
			}
			else
			{
				cap1 = Mcap1;
			}
			
			if(er.test(cap1))
			{}
			else
			{
				var cap11 = cap1+"";
				var token = cap11.split(".");
				if(token[1].length > 2)
				{
					cap1 = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("cap1").innerHTML = cap1;
		//	document.getElementById("caps1").value = cap1;
			cap1++;
			cap1--;
		}
		
		if(num == "4")
		{
			var yeardue = document.getElementById("DYD4").value;yeardue++;yeardue--;
			var quarterdue = document.getElementById("DQD4").value;quarterdue++;quarterdue--;
			var quartercomp = document.getElementById("DQC4").value;quartercomp++;quartercomp--;
			var overdue = document.getElementById("DO4").innerHTML;overdue++;overdue--;
			var totalcomp = document.getElementById("DYC4").value;totalcomp++;totalcomp--;

			if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
			{
				alert("Due in the year should be greater than other values!!!");
				document.getElementById("DYD4").value = 0;
				document.getElementById("DQD4").value = 0;
				document.getElementById("DQC4").value = 0;
				document.getElementById("DO4").innerHTML = 0;
				document.getElementById("DYC4").value = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}

			if(quarterdue < quartercomp)
			{
				alert("Due in the quarter should be greater completed in the quarter!!!");
				document.getElementById("DQD4").value = 0;
				document.getElementById("DQC4").value = 0;
				document.getElementById("DO4").innerHTML = 0;
				quarterdue = 0;quartercomp = 0;
			}
			
			if(id=="DQC4"  || id=="DQD4")
			{
				var calcoverdue = quarterdue - quartercomp;
				document.getElementById("DO4").innerHTML = calcoverdue;
			}
			
			if(quarterdue > 0)
			{
				cap2 = (quartercomp/quarterdue)*Mcap2;
			}
			else
			{
				cap2 = Mcap2;
			}
			if(er.test(cap2))
			{}
			else
			{
				var cap21 = cap2+"";
				var token = cap21.split(".");
				if(token[1].length > 2)
				{
					cap2 = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("cap2").innerHTML = cap2;
			//document.getElementById("caps2").value = cap2;
			cap2++;
			cap2--;
		}
		
		if(num == "5")
		{
			var yeardue = document.getElementById("DYD5").value;yeardue++;yeardue--;
			var quarterdue = document.getElementById("DQD5").value;quarterdue++;quarterdue--;
			var quartercomp = document.getElementById("DQC5").value;quartercomp++;quartercomp--;
			var overdue = document.getElementById("DO5").innerHTML;overdue++;overdue--;
			var totalcomp = document.getElementById("DYC5").value;totalcomp++;totalcomp--;

			if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
			{
				alert("Due in the year should be greater than other values!!!");
				document.getElementById("DYD5").value = 0;
				document.getElementById("DQD5").value = 0;
				document.getElementById("DQC5").value = 0;
				document.getElementById("DO5").innerHTML = 0;
				document.getElementById("DYC5").value = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}

			if(quarterdue < quartercomp)
			{
				alert("Due in the quarter should be greater completed in the quarter!!!");
				document.getElementById("DQD5").value = 0;
				document.getElementById("DQC5").value = 0;
				document.getElementById("DO5").innerHTML = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}
			if(id=="DQC5"  || id=="DQD5")
			{
				var calcoverdue = quarterdue - quartercomp;
				document.getElementById("DO5").innerHTML = calcoverdue;
			}
			
			if(quarterdue > 0)
			{
				cap3 = (quartercomp/quarterdue)*Mcap3;
			}
			else
			{
				cap3 = Mcap3;
			}
			if(er.test(cap3))
			{}
			else
			{
				var cap31 = cap3+"";
				var token = cap31.split(".");
				if(token[1].length > 2)
				{
					cap3 = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("cap3").innerHTML = cap3;
		//	document.getElementById("caps3").value = cap3;
			cap3++;
			cap3--;
		}
		
		if(num == "6" )
		{
			var yeardue = document.getElementById("DYD6").value;yeardue++;yeardue--;
			var quarterdue = document.getElementById("DQD6").value;quarterdue++;quarterdue--;
			var quartercomp = document.getElementById("DQC6").value;quartercomp++;quartercomp--;
			var overdue = document.getElementById("DO6").innerHTML;overdue++;overdue--;
			var totalcomp = document.getElementById("DYC6").value;totalcomp++;totalcomp--;

			if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
			{
				alert("Due in the year should be greater than other values!!!");
				document.getElementById("DYD6").value = 0;
				document.getElementById("DQD6").value = 0;
				document.getElementById("DQC6").value = 0;
				document.getElementById("DO6").innerHTML = 0;
				document.getElementById("DYC6").value = 0;
				quarterdue = 0;quartercomp = 0;
				//return false;
			}

			if(quarterdue < quartercomp)
			{
				alert("Due in the quarter should be greater completed in the quarter!!!");
				document.getElementById("DQD6").value = 0;
				document.getElementById("DQC6").value = 0;
				document.getElementById("DO6").innerHTML = 0;
				quarterdue = 0;quartercomp = 0;
			}
			
			if(id=="DQC6"  || id=="DQD6")
			{
				var calcoverdue = quarterdue - quartercomp;
				document.getElementById("DO6").innerHTML = calcoverdue;
			}
			
			if(quarterdue > 0)
			{
				Rcap = (quartercomp/quarterdue)*MRcap;
			}
			else
			{
				Rcap = MRcap;
			}
			if(er.test(Rcap))
			{}
			else
			{
				var Rcap1 = Rcap+"";
				var token = Rcap1.split(".");
				if(token[1].length > 2)
				{
					Rcap = token[0]+"."+token[1].substring(0,2);
				}
			}
			document.getElementById("Rcap").innerHTML = Rcap;
		//	document.getElementById("Rcap1").value = Rcap;
			Rcap++;
			Rcap--;
		}
		
		var secscore = DTO+DMO+driverreject+Acleaner+drivpresent+letter+UpdatedRegister+MCheck+Basic+cap1+cap2+cap3+Rcap;
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
		document.getElementById("Dsectionscore").innerHTML = secscore;
	//	document.getElementById("sectionscore1").value = secscore;
		
	}
	catch(e)
	{
		alert(e);
	}
}

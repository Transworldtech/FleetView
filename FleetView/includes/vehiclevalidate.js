function showtab(num)
{
	if(num == "1")
	{
		var show = document.getElementById("showsummary").value;
		if(show=="0")
		{
			document.getElementById("sumplus").style.display = "none";
			document.getElementById("summinus").style.display = "";
			document.getElementById("summary").style.display = "";
			//document.getElementById("auditscore").style.display = "";
			document.getElementById("totincenscore").style.display = "";
			document.getElementById("showsummary").value = "1";
		}
		else
		{
			document.getElementById("sumplus").style.display = "";
			document.getElementById("summinus").style.display = "none";
			document.getElementById("summary").style.display = "none";
		//	document.getElementById("auditscore").style.display = "none";
			document.getElementById("totincenscore").style.display = "none";
			document.getElementById("showsummary").value = "0";
		}
	}
	if(num == "2")
	{
		var show = document.getElementById("showvehicle").value;
		if(show=="0")
		{
			document.getElementById("vehplus").style.display = "none";
			document.getElementById("vehminus").style.display = "";
			document.getElementById("vehicleaccess").style.display = "";
			document.getElementById("showvehicle").value = "1";
		}
		else
		{
			document.getElementById("vehplus").style.display = "";
			document.getElementById("vehminus").style.display = "none";
			document.getElementById("vehicleaccess").style.display = "none";
			document.getElementById("showvehicle").value = "0";
		}
	}
	
	if(num == "3")
	{
		var show = document.getElementById("showdriver").value;
		if(show=="0")
		{
			document.getElementById("drivplus").style.display = "none";
			document.getElementById("drivminus").style.display = "";
			document.getElementById("driveraccess").style.display = "";
			document.getElementById("showdriver").value = "1";
		}
		else
		{
			document.getElementById("drivplus").style.display = "";
			document.getElementById("drivminus").style.display = "none";
			document.getElementById("driveraccess").style.display = "none";
			document.getElementById("showdriver").value = "0";
		}
	}
	if(num == "4")
	{
		var show = document.getElementById("showjourney").value;
		if(show=="0")
		{
			document.getElementById("jrnyplus").style.display = "none";
			document.getElementById("jrnyminus").style.display = "";
			document.getElementById("journeyaccess").style.display = "";
			document.getElementById("showjourney").value = "1";
		}
		else
		{
			document.getElementById("jrnyplus").style.display = "";
			document.getElementById("jrnyminus").style.display = "none";
			document.getElementById("journeyaccess").style.display = "none";
			document.getElementById("showjourney").value = "0";
		}
	}
	if(num == "5")
	{
		var show = document.getElementById("showprocess").value;
		if(show=="0")
		{
			document.getElementById("procplus").style.display = "none";
			document.getElementById("procminus").style.display = "";
			document.getElementById("processaccess").style.display = "";
			document.getElementById("showprocess").value = "1";
		}
		else
		{
			document.getElementById("procplus").style.display = "";
			document.getElementById("procminus").style.display = "none";
			document.getElementById("processaccess").style.display = "none";
			document.getElementById("showprocess").value = "0";
		}
	}
	if(num == "6")
	{
		var show = document.getElementById("consummary").value;
		if(show=="0")
		{
			document.getElementById("conplus").style.display = "none";
			document.getElementById("conminus").style.display = "";
			document.getElementById("conselfauditscore").style.display = "";
			document.getElementById("consummary").value = "1";
		}
		else
		{
			document.getElementById("conplus").style.display = "";
			document.getElementById("conminus").style.display = "none";
			document.getElementById("conselfauditscore").style.display = "none";
			document.getElementById("consummary").value = "0";
		}
	}
	if(num == "7")
	{
		var show = document.getElementById("commentsug").value;
		if(show=="0")
		{
			document.getElementById("feedplus").style.display = "none";
			document.getElementById("feedminus").style.display = "";
			document.getElementById("feedbackcom").style.display = "";
			document.getElementById("feedbacksave").style.display = "";
			document.getElementById("commentsug").value = "1";
		}
		else
		{
			document.getElementById("feedplus").style.display = "";
			document.getElementById("feedminus").style.display = "none";
			document.getElementById("feedbackcom").style.display = "none";
			document.getElementById("feedbacksave").style.display = "none";
			document.getElementById("commentsug").value = "0";
		}
	}
	if(num == "8")
	{
		var show = document.getElementById("totalscore").value;
		if(show=="0")
		{
			document.getElementById("totalplus").style.display = "none";
			document.getElementById("totalminus").style.display = "";
			document.getElementById("totalincentive").style.display = "";
			//document.getElementById("feedbacksave").style.display = "";
			document.getElementById("totalscore").value = "1";
		}
		else
		{
			document.getElementById("totalplus").style.display = "";
			document.getElementById("totalminus").style.display = "none";
			document.getElementById("totalincentive").style.display = "none";
			//document.getElementById("feedbacksave").style.display = "none";
			document.getElementById("totalscore").value = "0";
		}
	}
}

function savevehicle()
{
	var v1 =document.getElementById("totvehicle").innerHTML;var v2 =document.getElementById("tottrips").innerHTML;
	var v3 =document.getElementById("vehftpass").innerHTML;var v4 =document.getElementById("vehftpassrate").innerHTML;
	v4 = v4.replace("%","");
	var v5 =document.getElementById("FTPR").value;var v6 =document.getElementById("UFTPR").value;
	var v7 =document.getElementById("VFTPRate").innerHTML;var v8 =document.getElementById("VFTPRR").innerHTML;
	var v9 =document.getElementById("Vpresent").innerHTML;var v10 =document.getElementById("Vsectionscore").innerHTML;
	var v11 =document.getElementById("YD1").value;var v12 =document.getElementById("QD1").value;
	var v13=document.getElementById("QC1").value;var v14 =document.getElementById("O1").innerHTML;
	var v15 =document.getElementById("YC1").value;var v16 =document.getElementById("YD2").value;
	var v17 =document.getElementById("QD2").value;var v18 =document.getElementById("QC2").value;
	var v19 =document.getElementById("O2").innerHTML;var v20 =document.getElementById("YC2").value;
	var v21 =document.getElementById("YD3").value;var v22 =document.getElementById("QD3").value;
	var v23 =document.getElementById("QC3").value;var v24 =document.getElementById("O3").innerHTML;
	var v25=document.getElementById("YC3").value;var v26 =document.getElementById("YD4").value;
	var v27=document.getElementById("QD4").value;var v28 =document.getElementById("QC4").value;
	var v29 =document.getElementById("O4").innerHTML;var v30 =document.getElementById("YC4").value;
	var v31 =document.getElementById("YD5").value;var v32=document.getElementById("QD5").value;
	var v33 =document.getElementById("QC5").value;var v34=document.getElementById("O5").innerHTML;
	var v35 =document.getElementById("YC5").value;var v36=document.getElementById("YD6").value;
	var v37 =document.getElementById("QD6").value;var v38 =document.getElementById("QC6").value;
	var v39 =document.getElementById("O6").innerHTML;var v40 =document.getElementById("YC6").value;
	var v41 =document.getElementById("YD7").value;var v42 =document.getElementById("QD7").value;
	var v43 =document.getElementById("QC7").value;var v44 =document.getElementById("O7").innerHTML;
	var v45 =document.getElementById("YC7").value;var v46 =document.getElementById("YD8").value;
	var v47 =document.getElementById("QD8").value;var v48 =document.getElementById("QC8").value;
	var v49 =document.getElementById("O8").innerHTML;var v50 =document.getElementById("YC8").value;
	var v51 = document.getElementById("Vcompletedscore").innerHTML;var T1 =  document.getElementById("Trans").value;
	var Q1 = document.getElementById("quarter").value;var Y1 = document.getElementById("year").value;
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
					document.getElementById("vehiclescore").innerHTML = v10;
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
					savesummary1(2);
					
				}
				
			} 
		};
		var queryString = "?v1="+v1+"&v2="+v2+"&v3="+v3+"&v4="+v4+"&v5="+v5+"&v6="+v6+"&v7="+v7+"&v8="+v8+"&v9="+v9+"&v10="+v10+"&v11="+v11+"&v12="+v12+"&v13="+v13+
										"&v14="+v14+"&v15="+v15+"&v16="+v16+"&v17="+v17+"&v18="+v18+"&v19="+v19+"&v20="+v20+"&v21="+v21+"&v22="+v22+"&v23="+v23+"&v24="+v24+"&v25="+v25+"&v26="+v26+"&v27="+v27+
										"&v28="+v28+"&v29="+v29+"&v30="+v30+"&v31="+v31+"&v32="+v32+"&v33="+v33+"&v34="+v34+"&v35="+v35+"&v36="+v36+"&v37="+v37+"&v38="+v38+"&v39="+v39+"&v40="+v40+"&v41="+v41+
										"&v42="+v42+"&v43="+v43+"&v44="+v44+"&v45="+v45+"&v46="+v46+"&v47="+v47+"&v48="+v48+"&v49="+v49+"&v50="+v50+"&v51="+v51+"&Q1="+Q1+"&Y1="+Y1+"&T1="+T1;
		ajaxRequest.open("GET", "vehicleauditinsert1.jsp"+queryString, true);
		
		ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
	}
}

function checkvalidity(id,num)
{
	try
	{
	//alert("Hiii    "+id);
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
		var yeardue = document.getElementById("YD1").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD1").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC1").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O1").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC1").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD1").value = 0;
			document.getElementById("QD1").value = 0;
			document.getElementById("QC1").value = 0;
			document.getElementById("O1").innerHTML = 0;
			document.getElementById("YC1").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD1").value = 0;
			document.getElementById("QC1").value = 0;
			document.getElementById("O1").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		
		if(id=="QC1"  || id=="QD1")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O1").innerHTML = calcoverdue;
		}
	}
	if(num == "2")
	{
		var yeardue = document.getElementById("YD2").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD2").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC2").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O2").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC2").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD2").value = 0;
			document.getElementById("QD2").value = 0;
			document.getElementById("QC2").value = 0;
			document.getElementById("O2").innerHTML = 0;
			document.getElementById("YC2").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD2").value = 0;
			document.getElementById("QC2").value = 0;
			document.getElementById("O2").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		
		if(id=="QC2"  || id=="QD2")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O2").innerHTML = calcoverdue;
		}
	}
	if(num == "3")
	{
		var yeardue = document.getElementById("YD3").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD3").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC3").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O3").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC3").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD3").value = 0;
			document.getElementById("QD3").value = 0;
			document.getElementById("QC3").value = 0;
			document.getElementById("O3").innerHTML = 0;
			document.getElementById("YC3").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD3").value = 0;
			document.getElementById("QC3").value = 0;
			document.getElementById("O3").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		if(id=="QC3"  || id=="QD3")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O3").innerHTML = calcoverdue;
		}
	}
	if(num == "4")
	{
		var yeardue = document.getElementById("YD4").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD4").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC4").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O4").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC4").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD4").value = 0;
			document.getElementById("QD4").value = 0;
			document.getElementById("QC4").value = 0;
			document.getElementById("O4").innerHTML = 0;
			document.getElementById("YC4").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD4").value = 0;
			document.getElementById("QC4").value = 0;
			document.getElementById("O4").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		if(id=="QC4"  || id=="QD4")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O4").innerHTML = calcoverdue;
		}
		
	}
	if(num == "5")
	{
		var yeardue = document.getElementById("YD5").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD5").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC5").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O5").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC5").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD5").value = 0;
			document.getElementById("QD5").value = 0;
			document.getElementById("QC5").value = 0;
			document.getElementById("O5").innerHTML = 0;
			document.getElementById("YC5").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD5").value = 0;
			document.getElementById("QC5").value = 0;
			document.getElementById("O5").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		if(id=="QC5"  || id=="QD5")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O5").innerHTML = calcoverdue;
		}
		
	}
	if(num == "6")
	{
		var yeardue = document.getElementById("YD6").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD6").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC6").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O6").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC6").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD6").value = 0;
			document.getElementById("QD6").value = 0;
			document.getElementById("QC6").value = 0;
			document.getElementById("O6").innerHTML = 0;
			document.getElementById("YC6").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD6").value = 0;
			document.getElementById("QC6").value = 0;
			document.getElementById("O6").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		if(id=="QC6"  || id=="QD6")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O6").innerHTML = calcoverdue;
		}
		
	}
	if(num == "7")
	{
		var yeardue = document.getElementById("YD7").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD7").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC7").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O7").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC7").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD7").value = 0;
			document.getElementById("QD7").value = 0;
			document.getElementById("QC7").value = 0;
			document.getElementById("O7").innerHTML = 0;
			document.getElementById("YC7").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD7").value = 0;
			document.getElementById("QC7").value = 0;
			document.getElementById("O7").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		if(id=="QC7"  || id=="QD7")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O7").innerHTML = calcoverdue;
		}
		
	}
	if(num == "8")
	{
		var yeardue = document.getElementById("YD8").value;yeardue++;yeardue--;
		var quarterdue = document.getElementById("QD8").value;quarterdue++;quarterdue--;
		var quartercomp = document.getElementById("QC8").value;quartercomp++;quartercomp--;
		var overdue = document.getElementById("O8").innerHTML;overdue++;overdue--;
		var totalcomp = document.getElementById("YC8").value;totalcomp++;totalcomp--;

		if((yeardue < quarterdue) || (yeardue < quartercomp) || (yeardue < overdue) || (yeardue < totalcomp))
		{
			alert("Due in the year should be greater than other values!!!");
			document.getElementById("YD8").value = 0;
			document.getElementById("QD8").value = 0;
			document.getElementById("QC8").value = 0;
			document.getElementById("O8").innerHTML = 0;
			document.getElementById("YC8").value = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}

		if(quarterdue < quartercomp)
		{
			alert("Due in the quarter should be greater completed in the quarter!!!");
			document.getElementById("QD8").value = 0;
			document.getElementById("QC8").value = 0;
			document.getElementById("O8").innerHTML = 0;
			quarterdue = 0;quartercomp = 0;
			//return false;
		}
		if(id=="QC8"  || id=="QD8")
		{
			var calcoverdue = quarterdue - quartercomp;
			document.getElementById("O8").innerHTML = calcoverdue;
		}
		
	}
	
		var FTPRrate = document.getElementById("VFTPRate").innerHTML;
		FTPRrate++;
		FTPRrate--;
		var FTPRR = document.getElementById("VFTPRR").innerHTML;
		FTPRR++;
		FTPRR--;
		var Present = document.getElementById("Vpresent").innerHTML;
		Present++;
		Present--;
		var due1 = document.getElementById("QD1").value;
		due1++;
		due1--;
		var complete1 = document.getElementById("QC1").value;
		complete1++;
		complete1--;
		var due2 = document.getElementById("QD2").value;
		due2++;
		due2--;
		var complete2 = document.getElementById("QC2").value;
		complete2++;
		complete2--;
		var due3 = document.getElementById("QD3").value;
		due3++;
		due3--;
		var complete3 = document.getElementById("QC3").value;
		complete3++;
		complete3--;
		var due4 = document.getElementById("QD4").value;
		due4++;
		due4--;
		var complete4 = document.getElementById("QC4").value;
		complete4++;
		complete4--;
		var due5 = document.getElementById("QD5").value;
		due5++;
		due5--;
		var complete5 = document.getElementById("QC5").value;
		complete5++;
		complete5--;
		var due6 = document.getElementById("QD6").value;
		due6++;
		due6--;
		var complete6 = document.getElementById("QC6").value;
		complete6++;
		complete6--;
		var due7 = document.getElementById("QD7").value;
		due7++;
		due7--;
		var complete7 = document.getElementById("QC7").value;
		complete7++;
		complete7--;
		var due8 = document.getElementById("QD8").value;
		due8++;
		due8--;
		var complete8 = document.getElementById("QC8").value;
		complete8++;
		complete8--;

		var Tdue = due1+due2+due3+due4+due5+due6+due7+due8;
		var Tcomplete = complete1+complete2+complete3+complete4+complete5+complete6+complete7+complete8;

		var Mcomplete =document.getElementById("Mcompletedscore").innerHTML; 
		Mcomplete++;
		Mcomplete--;
		//alert("Tcomplete  "+Tcomplete);
		//alert("Tdue  "+Tdue);
		//alert("Mcomplete  "+Mcomplete);
       
		var completedscore =0;
		if(Tdue > 0)
		{
			completedscore = (Tcomplete/Tdue)*Mcomplete;
		}
		else
		{
			completedscore = Mcomplete;
		}

		//alert(completedscore);
		var er = /^[0-9]+$/;
		//alert((er.test(completedscore)));
		if(er.test(completedscore))
		{}
		else
		{
			var completedscore1 = completedscore+"";
		//	alert(completedscore1);
			var token = completedscore1.split(".");
			if(token[1].length > 2)
			{
				completedscore = token[0]+"."+token[1].substring(0,2);
				//alert("completedscore"+completedscore)
				//completedscore1++;
				//alert("completedscore"+completedscore)
				//completedscore1--;
				//alert("completedscore"+completedscore)
			}
		}
		
		document.getElementById("Vcompletedscore").innerHTML = completedscore;
		//document.getElementById("completedscore1").value = completedscore;
		completedscore++;
		completedscore--;
		var secscore = FTPRrate+FTPRR+Present+completedscore;
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
		document.getElementById("Vsectionscore").innerHTML = secscore;
		//document.getElementById("sectionscore1").value = secscore;
	}
	catch(e)
	{
		alert(e);
	}
}

function calculatepoints()
{
	try
	{
	//alert("Hiiii");
	if(document.getElementById("FTPR").value == "Yes")
		{
			document.getElementById("VFTPRR").innerHTML = document.getElementById("MVFTPRR").innerHTML;
//			document.getElementById("VFTPRR1").value = document.getElementById("MVFTPRR").innerHTML;
		}
		else
		{
			document.getElementById("VFTPRR").innerHTML = "0";
			//document.getElementById("VFTPRR1").value = "0";
		}

	if(document.getElementById("UFTPR").value == "Yes")
	{
		document.getElementById("Vpresent").innerHTML = document.getElementById("MVpresent").innerHTML;
		//document.getElementById("Vpresent1").value = document.getElementById("MVpresent").innerHTML;
	}
	else
	{
		document.getElementById("Vpresent").innerHTML = "0";
		//document.getElementById("Vpresent1").value = "0";
	}
	
	var FTPRrate = document.getElementById("VFTPRate").innerHTML;
	FTPRrate++;
	FTPRrate--;
	var FTPRR = document.getElementById("VFTPRR").innerHTML;
	FTPRR++;
	FTPRR--;
	var Present = document.getElementById("Vpresent").innerHTML;
	Present++;
	Present--;
	var due1 = document.getElementById("QD1").value;
	due1++;
	due1--;
	var complete1 = document.getElementById("QC1").value;
	complete1++;
	complete1--;
	document.getElementById("O1").innerHTML = due1 - complete1;
	var due2 = document.getElementById("QD2").value;
	due2++;
	due2--;
	var complete2 = document.getElementById("QC2").value;
	complete2++;
	complete2--;
	document.getElementById("O2").innerHTML = due2 - complete2;
	var due3 = document.getElementById("QD3").value;
	due3++;
	due3--;
	var complete3 = document.getElementById("QC3").value;
	complete3++;
	complete3--;
	document.getElementById("O3").innerHTML = due3 - complete3;
	var due4 = document.getElementById("QD4").value;
	due4++;
	due4--;
	var complete4 = document.getElementById("QC4").value;
	complete4++;
	complete4--;
	document.getElementById("O4").innerHTML = due4 - complete4;
	var due5 = document.getElementById("QD5").value;
	due5++;
	due5--;
	var complete5 = document.getElementById("QC5").value;
	complete5++;
	complete5--;
	document.getElementById("O5").innerHTML = due5 - complete5;
	var due6 = document.getElementById("QD6").value;
	due6++;
	due6--;
	var complete6 = document.getElementById("QC6").value;
	complete6++;
	complete6--;
	document.getElementById("O6").innerHTML = due6 - complete6;
	var due7 = document.getElementById("QD7").value;
	due7++;
	due7--;
	var complete7 = document.getElementById("QC7").value;
	complete7++;
	complete7--;
	document.getElementById("O7").innerHTML = due7 - complete7;
	var due8 = document.getElementById("QD8").value;
	due8++;
	due8--;
	var complete8 = document.getElementById("QC8").value;
	complete8++;
	complete8--;
	document.getElementById("O8").innerHTML = due8 - complete8;

	var Tdue = due1+due2+due3+due4+due5+due6+due7+due8;
	var Tcomplete = complete1+complete2+complete3+complete4+complete5+complete6+complete7+complete8;

	var Mcomplete =document.getElementById("Mcompletedscore").innerHTML; 
	Mcomplete++;
	Mcomplete--;
	//alert("Tcomplete  "+Tcomplete);
	//alert("Tdue  "+Tdue);
	//alert("Mcomplete  "+Mcomplete);

	var completedscore =0;
	if(Tdue > 0)
	{
		completedscore = (Tcomplete/Tdue)*Mcomplete;
	}
	else
	{
		completedscore = Mcomplete;
	}
	
	var er = /^[0-9]+$/;
	if(er.test(completedscore))
	{}
	else
	{
		var completedscore1 = completedscore+"";
		var token = completedscore1.split(".");
		if(token[1].length > 2)
		{
			completedscore = token[0]+"."+token[1].substring(0,2);
			
		}
	}
	
	document.getElementById("Vcompletedscore").innerHTML = completedscore;
	//document.getElementById("completedscore1").value = completedscore;
	completedscore++;
	completedscore--;
	var secscore = FTPRrate+FTPRR+Present+completedscore;
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
	document.getElementById("Vsectionscore").innerHTML = secscore;
	//document.getElementById("sectionscore1").value = secscore;
	}
	catch(e)
	{
		alert(e);
	}
}

function getScore(num)
{
	if(num== 1)
	{
		if(document.getElementById("FTPR").value == "Yes")
		{
			document.getElementById("VFTPRR").innerHTML = document.getElementById("MVFTPRR").innerHTML;
			//document.getElementById("VFTPRR1").value = document.getElementById("MVFTPRR").innerHTML;
		}
		else
		{
			document.getElementById("VFTPRR").innerHTML = "0";
			//document.getElementById("VFTPRR1").value = "0";
		}
	}
	if(num== 2)
	{
		if(document.getElementById("UFTPR").value == "Yes")
		{
			document.getElementById("Vpresent").innerHTML = document.getElementById("MVpresent").innerHTML;
			//document.getElementById("Vpresent1").value = document.getElementById("MVpresent").innerHTML;
		}
		else
		{
			document.getElementById("Vpresent").innerHTML = "0";
			//document.getElementById("Vpresent").value = "0";
		}
	}

	var FTPRrate = document.getElementById("VFTPRate").innerHTML;
	FTPRrate++;
	FTPRrate--;
	var FTPRR = document.getElementById("VFTPRR").innerHTML;
	FTPRR++;
	FTPRR--;
	var Present = document.getElementById("Vpresent").innerHTML;
	Present++;
	Present--;
	var completedscore = document.getElementById("Vcompletedscore").innerHTML;
	completedscore++;
	completedscore--;
	var secscore = FTPRrate+FTPRR+Present+completedscore;
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
	document.getElementById("Vsectionscore").innerHTML = secscore;
	//document.getElementById("sectionscore1").value = secscore;
}
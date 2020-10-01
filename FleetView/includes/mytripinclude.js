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

function hide(id){ 
	var cnt=document.dateform.cntcls.value;
		if(id=="veh")	{
	if(document.getElementById("stkmcolcls").style.display=="") //if sign is minus
		{
			document.getElementById("stkmcolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("stkmcolcls"+i).style.display='none';			}
			document.getElementById("sdtcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("sdtcolcls"+i).style.display='none';			}
			document.getElementById("kmtcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("kmtcolcls"+i).style.display='none';			}	
			document.getElementById("trpdcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("trpdcolcls"+i).style.display='none';			}  
			document.getElementById("trptcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("trptcolcls"+i).style.display='none';			}
			document.getElementById("rhrcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("rhrcolcls"+i).style.display='none';			}
			document.getElementById("avcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("avcolcls"+i).style.display='none';			}	  
			  document.getElementById("rhrvcolcls").style.display='none';for(var i=1;i<=cnt;i++)			{document.getElementById("rhrvcolcls"+i).style.display='none';			}
            document.getElementById("oscolcls").style.display='none';for(var i=1;i<=cnt;i++)		   {document.getElementById("oscolcls"+i).style.display='none';		   }
		document.getElementById("osscolcls").style.display='none';for(var i=1;i<=cnt;i++)		{document.getElementById("osscolcls"+i).style.display='none';		}
		document.getElementById("rzonecolcls").style.display='none';for(var i=1;i<=cnt;i++)		{document.getElementById("rzonecolcls"+i).style.display='none';		}	  
		  document.getElementById("yzonecolcls").style.display='none';for(var i=1;i<=cnt;i++)		{document.getElementById("yzonecolcls"+i).style.display='none';		}
	document.getElementById("gzonecolcls").style.display='none';for(var i=1;i<=cnt;i++)	{document.getElementById("gzonecolcls"+i).style.display='none';	}
	document.getElementById("racolcls").style.display='none';for(var i=1;i<=cnt;i++)	{document.getElementById("racolcls"+i).style.display='none';	}
	document.getElementById("rdcolcls").style.display='none';for(var i=1;i<=cnt;i++)	{		document.getElementById("rdcolcls"+i).style.display='none';	}	  
	  document.getElementById("cdcolcls").style.display='none';for(var i=1;i<=cnt;i++)	{document.getElementById("cdcolcls"+i).style.display='none';	}
document.getElementById("ndcolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("ndcolcls"+i).style.display='none';}
document.getElementById("nddcolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("nddcolcls"+i).style.display='none';}
document.getElementById("ndducolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("ndducolcls"+i).style.display='none';}	  
  document.getElementById("dccolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("dccolcls"+i).style.display='none';}
document.getElementById("dckmcolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("dckmcolcls"+i).style.display='none';}
document.getElementById("ratcolcls").style.display='none';for(var i=1;i<=cnt;i++){document.getElementById("ratcolcls"+i).style.display='none';}
		document.getElementById("img13").src="images/plus.jpg";		}else		{document.getElementById("stkmcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("stkmcolcls"+i).style.display="";			}document.getElementById("sdtcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("sdtcolcls"+i).style.display="";			}document.getElementById("kmtcolcls").style.display="";
	         for(var i=1;i<=cnt;i++)			{	document.getElementById("kmtcolcls"+i).style.display="";			}document.getElementById("trpdcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("trpdcolcls"+i).style.display="";			} document.getElementById("trptcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("trptcolcls"+i).style.display="";			}document.getElementById("rhrcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("rhrcolcls"+i).style.display="";			}document.getElementById("avcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("avcolcls"+i).style.display="";			}	 document.getElementById("rhrvcolcls").style.display="";
			for(var i=1;i<=cnt;i++)			{document.getElementById("rhrvcolcls"+i).style.display="";			}document.getElementById("oscolcls").style.display="";
		for(var i=1;i<=cnt;i++)		{document.getElementById("oscolcls"+i).style.display="";		}document.getElementById("osscolcls").style.display="";
		for(var i=1;i<=cnt;i++)		{document.getElementById("osscolcls"+i).style.display="";		}document.getElementById("rzonecolcls").style.display="";
		for(var i=1;i<=cnt;i++)		{document.getElementById("rzonecolcls"+i).style.display="";		}	 document.getElementById("yzonecolcls").style.display="";
		for(var i=1;i<=cnt;i++)		{document.getElementById("yzonecolcls"+i).style.display="";		}document.getElementById("gzonecolcls").style.display="";
	for(var i=1;i<=cnt;i++)	{document.getElementById("gzonecolcls"+i).style.display="";	}document.getElementById("racolcls").style.display="";
	for(var i=1;i<=cnt;i++)	{document.getElementById("racolcls"+i).style.display="";	}document.getElementById("rdcolcls").style.display="";
	for(var i=1;i<=cnt;i++)	{document.getElementById("rdcolcls"+i).style.display="";	}	document.getElementById("cdcolcls").style.display="";
	for(var i=1;i<=cnt;i++)	{document.getElementById("cdcolcls"+i).style.display="";	}document.getElementById("ndcolcls").style.display="";
for(var i=1;i<=cnt;i++){document.getElementById("ndcolcls"+i).style.display="";}document.getElementById("nddcolcls").style.display="";
for(var i=1;i<=cnt;i++){document.getElementById("nddcolcls"+i).style.display="";}document.getElementById("ndducolcls").style.display="";
for(var i=1;i<=cnt;i++){document.getElementById("ndducolcls"+i).style.display="";}	 document.getElementById("dccolcls").style.display="";
for(var i=1;i<=cnt;i++){document.getElementById("dccolcls"+i).style.display="";}document.getElementById("dckmcolcls").style.display="";
for(var i=1;i<=cnt;i++){document.getElementById("dckmcolcls"+i).style.display="";}document.getElementById("ratcolcls").style.display="";
for(var i=1;i<=cnt;i++){document.getElementById("ratcolcls"+i).style.display="";}document.getElementById("img13").src="images/sub.jpg";		}}	}
function hide1(id){ 
	var cnt1=document.dateform.countt.value;
		if(id=="veh")	{
	if(document.getElementById("desccol").style.display==""){document.getElementById("desccol").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("desccol"+i).style.display='none';			}document.getElementById("modcol").style.display='none';
			for(var i=1;i<=cnt1;i++)			{document.getElementById("modcol"+i).style.display='none';			}
			document.getElementById("typecol").style.display='none';for(var i=1;i<=cnt1;i++)			{document.getElementById("typecol"+i).style.display='none';			}	
			document.getElementById("FixedTimecol").style.display='none';for(var i=1;i<=cnt1;i++)			{document.getElementById("FixedTimecol"+i).style.display='none';			}  
			document.getElementById("FixedKmcol").style.display='none';for(var i=1;i<=cnt1;i++)			{document.getElementById("FixedKmcol"+i).style.display='none';			}
			document.getElementById("kmsruncol").style.display='none';for(var i=1;i<=cnt1;i++)			{document.getElementById("kmsruncol"+i).style.display='none';			}
			document.getElementById("kmstoruncol").style.display='none';for(var i=1;i<=cnt1;i++)			{document.getElementById("kmstoruncol"+i).style.display='none';			}	  
			  document.getElementById("wtcol").style.display='none';for(var i=1;i<=cnt1;i++)			{document.getElementById("wtcol"+i).style.display='none';			}
		document.getElementById("frcol").style.display='none';for(var i=1;i<=cnt1;i++)		{document.getElementById("frcol"+i).style.display='none';		}
		document.getElementById("adrscol").style.display='none';for(var i=1;i<=cnt1;i++)		{document.getElementById("adrscol"+i).style.display='none';		}
		document.getElementById("img11").src="images/plus.jpg";		}else		{document.getElementById("desccol").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("desccol"+i).style.display="";			}document.getElementById("modcol").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("modcol"+i).style.display="";			}document.getElementById("typecol").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("typecol"+i).style.display="";			}document.getElementById("FixedTimecol").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("FixedTimecol"+i).style.display="";			}document.getElementById("FixedKmcol").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("FixedKmcol"+i).style.display="";			}document.getElementById("kmsruncol").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("kmsruncol"+i).style.display="";			}document.getElementById("kmstoruncol").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("kmstoruncol"+i).style.display="";			}document.getElementById("wtcol").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("wtcol"+i).style.display="";			}document.getElementById("frcol").style.display="";
		for(var i=1;i<=cnt1;i++)		{document.getElementById("frcol"+i).style.display="";		}document.getElementById("adrscol").style.display="";
		for(var i=1;i<=cnt1;i++)		{document.getElementById("adrscol"+i).style.display="";		}document.getElementById("img11").src="images/sub.jpg";		}}	}
function hide2(id){ 
	var cnt3=document.dateform.countt.value;
	if(id=="trip"){
if(document.getElementById("vendorcol").style.display=="") //if sign is minus
	{document.getElementById("vendorcol").style.display='none'; for(var i=1;i<=cnt3;i++)	    {
		document.getElementById("vendorcol"+i).style.display='none';	    }	
	     document.getElementById("catcol").style.display='none';for(var i=1;i<=cnt3;i++)		{
			document.getElementById("catcol"+i).style.display='none';		}document.getElementById("cmtcol").style.display='none';
		for(var i=1;i<=cnt3;i++)		{document.getElementById("cmtcol"+i).style.display='none';		} 
		   document.getElementById("img12").src="images/plus.jpg";	}else	{document.getElementById("vendorcol").style.display="";
for(var i=1;i<=cnt3;i++){document.getElementById("vendorcol"+i).style.display="";}	
document.getElementById("catcol").style.display="";for(var i=1;i<=cnt3;i++)	{
		document.getElementById("catcol"+i).style.display="";	}
	document.getElementById("cmtcol").style.display="";for(var i=1;i<=cnt3;i++)	{document.getElementById("cmtcol"+i).style.display="";	} 
		document.getElementById("img12").src="images/sub.jpg";	}}		}
function hide4(id){ 
	var cnt1=document.dateform.cntcls.value;
		if(id=="veh")	{
	if(document.getElementById("stkmcolveh").style.display=="") //if sign is minus
		{document.getElementById("stkmcolveh").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("stkmcolveh"+i).style.display='none';			}
			document.getElementById("sttcolveh").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("sttcolveh"+i).style.display='none';			}document.getElementById("kmtcolveh").style.display='none';
				for(var i=1;i<=cnt1;i++)			{document.getElementById("kmtcolveh"+i).style.display='none';			}	
			document.getElementById("trptcolveh").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("trptcolveh"+i).style.display='none';			} document.getElementById("oscolveh").style.display='none';
			for(var i=1;i<=cnt1;i++)			{document.getElementById("oscolveh"+i).style.display='none';			}
			document.getElementById("osscolveh").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("osscolveh"+i).style.display='none';			}
			document.getElementById("racolveh").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("racolveh"+i).style.display='none';			} document.getElementById("rdcolveh").style.display='none';
			for(var i=1;i<=cnt1;i++)			{document.getElementById("rdcolveh"+i).style.display='none';			}
		document.getElementById("cdcolveh").style.display='none';for(var i=1;i<=cnt1;i++)		{
			document.getElementById("cdcolveh"+i).style.display='none';		}document.getElementById("ndcolveh").style.display='none';
		for(var i=1;i<=cnt1;i++)		{document.getElementById("ndcolveh"+i).style.display='none';		}
		  document.getElementById("dccolveh").style.display='none';for(var i=1;i<=cnt1;i++)			{
				document.getElementById("dccolveh"+i).style.display='none';			}document.getElementById("dckmcolveh").style.display='none';
		for(var i=1;i<=cnt1;i++)		{document.getElementById("dckmcolveh"+i).style.display='none';		}document.getElementById("ratcolveh").style.display='none';
		for(var i=1;i<=cnt1;i++)		{document.getElementById("ratcolveh"+i).style.display='none';		}
		document.getElementById("img14").src="images/plus.jpg";		}else		{document.getElementById("stkmcolveh").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("stkmcolveh"+i).style.display="";			}
			document.getElementById("sttcolveh").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("sttcolveh"+i).style.display="";			}document.getElementById("kmtcolveh").style.display="";
				for(var i=1;i<=cnt1;i++)			{document.getElementById("kmtcolveh"+i).style.display="";			}	
			document.getElementById("trptcolveh").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("trptcolveh"+i).style.display="";			}  
			document.getElementById("oscolveh").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("oscolveh"+i).style.display="";			}document.getElementById("osscolveh").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("osscolveh"+i).style.display="";			}
			document.getElementById("racolveh").style.display="";
			for(var i=1;i<=cnt1;i++)			{document.getElementById("racolveh"+i).style.display="";			}	  
			  document.getElementById("rdcolveh").style.display="";for(var i=1;i<=cnt1;i++)			{document.getElementById("rdcolveh"+i).style.display="";			}
		document.getElementById("cdcolveh").style.display="";for(var i=1;i<=cnt1;i++)		{document.getElementById("cdcolveh"+i).style.display="";		}
		document.getElementById("ndcolveh").style.display="";for(var i=1;i<=cnt1;i++)		{document.getElementById("ndcolveh"+i).style.display="";		}
		  document.getElementById("dccolveh").style.display="";for(var i=1;i<=cnt1;i++)			{
				document.getElementById("dccolveh"+i).style.display="";			}
		document.getElementById("dckmcolveh").style.display="";for(var i=1;i<=cnt1;i++)		{
			document.getElementById("dckmcolveh"+i).style.display="";		}
		document.getElementById("ratcolveh").style.display="";for(var i=1;i<=cnt1;i++)		{
			document.getElementById("ratcolveh"+i).style.display="";		}
			document.getElementById("img14").src="images/sub.jpg";		}}	}


function show1(ftp1){try{
	var ajaxRequest;  // The variable that makes Ajax possible!
		try{
			ajaxRequest = new XMLHttpRequest();		}  
		catch (e)
		{
			try			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} 
			catch (e)			{
				try				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)				{
					alert("Your browser broke!");
					return false;				}			}		}
		ajaxRequest.onreadystatechange = function()		{
			if(ajaxRequest.readyState == 4)			{
				try				{
				var reslt=ajaxRequest.responseText;
				}catch(e)				{
				alert(e);				}			} 		};
		var queryString = "?file="+ftp1+"";
		ajaxRequest.open("GET", "Image_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 		}
	    catch(e)		{
			alert(e);		}
}
function getFTPImage(ftpFile)		{			try			{
				window.open('showFTPImage.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=850, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
			}
			catch(e)			{
				alert(e);			}
		}
function toggleDetails1(id, show)
	{
		var popupp1 = document.getElementById("popup1"+id);
		if (show) {
			popupp1.style.visibility = "visible";
			popupp1.setfocus();
				} else {
			popupp1.style.visibility = "hidden";
		}	}
	function getvalue()	{
		var Driver2=document.getElementById("Driver").value;
		var vender2=document.getElementById("vendor").value;
		document.getElementById("vend1").value=vender2;
		var category2=document.getElementById("category").value;
		document.getElementById("cat1").value=category2;
		var startp2=document.getElementById("startp").value;
		document.getElementById("startpl1").value=startp2;
		var endp2=document.getElementById("endp").value;
		document.getElementById("endpl1").value=endp2;		}

	function statuscloser(){
		var stat=document.getElementById("status").value;
			if(stat=="Closed")	{
				document.getElementById("tdvh").style.display='none';		document.getElementById("tdvend").style.display='';
				document.getElementById("tdcat").style.display='';		document.getElementById("tdstpl").style.display=''; 
				document.getElementById("tdendpl").style.display='';		document.getElementById("tddrv").style.display='none';}
			else if(stat=="Open")	{
				document.getElementById("tdvh").style.display='none';		document.getElementById("tdvend").style.display='none';
				document.getElementById("tdcat").style.display='none';		document.getElementById("tdstpl").style.display='none';
				document.getElementById("tdendpl").style.display='none';	document.getElementById("tddrv").style.display='none';}
			else if(stat=="Cancelled")	{
				document.getElementById("tdvh").style.display='none';		document.getElementById("tdvend").style.display='none';
				document.getElementById("tdcat").style.display='none';		document.getElementById("tdstpl").style.display='none';
				document.getElementById("tdendpl").style.display='none';		document.getElementById("tddrv").style.display='none';}
			else if(stat=="Vehicle Wise Trips")	{
				document.getElementById("tdvh").style.display='';		document.getElementById("tdvend").style.display='';
				document.getElementById("tdcat").style.display='';		document.getElementById("tdstpl").style.display='';
				document.getElementById("tdendpl").style.display='';		document.getElementById("tddrv").style.display='none';}
			else{document.getElementById("tddrv").style.display='';      document.getElementById("tdvh").style.display='none';
			document.getElementById("tdvend").style.display='';           document.getElementById("tdcat").style.display='';
			document.getElementById("tdstpl").style.display='';           document.getElementById("tdendpl").style.display='';}}	
	
	function showhide2(){
		var frmdte=document.getElementById("data11").value;
		var todte=document.getElementById("data22").value;
		var trns=document.getElementById("transporter1").value;
		var statusname= document.getElementById("status").value;
		var cnt=document.getElementById("cntcls").value;
		var vendername=document.getElementById("vendor").value;
		var categoryname=document.getElementById("category").value;
		var startplacename=document.getElementById("startp").value;
		var endplacename=document.getElementById("endp").value;
		var vehicleno=document.getElementById("vehicle").value;
		var tdd,tdm,tdt;
		var tds=document.getElementById("tds").value;
		if(tds=="More Info")	{
			for(i=0;i<=cnt;i++)		{	
					tdd=document.getElementById("tdd"+i);			tdd.style.display='';			tdm=document.getElementById("tdm"+i);
					tdm.style.display='';			tdt=document.getElementById("tdt"+i);			tdt.style.display='';
					tdw=document.getElementById("tdw"+i);			tdw.style.display='';			tda=document.getElementById("tda"+i);
					tda.style.display='';			tdf=document.getElementById("tdf"+i);			tdf.style.display='';
					tdr=document.getElementById("tdr"+i);			tdr.style.display='';			tdu=document.getElementById("tdu"+i);
					tdu.style.display='';			tdl=document.getElementById("tdl"+i);			tdl.style.display='';
					tdldr=document.getElementById("tdldr"+i);			tdldr.style.display='';			tdlc=document.getElementById("tdlc"+i);
					tdlc.style.display='';			tdul=document.getElementById("tdul"+i);			tdul.style.display='';
					tdudr=document.getElementById("tdudr"+i);			tdudr.style.display='';			tduc=document.getElementById("tduc"+i);
					tduc.style.display='';
					document.getElementById("tds").value="Hide Info";		}
				document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'print_my_trips.jsp?tds=More Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'&statusp1='+statusname+'&vendor='+vendername+'&category='+categoryname+'&startp='+startplacename+'&endp='+endplacename+'&vehicle='+vehicleno+'\');" title="Print My Trips Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
				document.getElementById("excel").innerHTML='<a href="export_my_trip.jsp?&tds=More Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'&statusp1='+statusname+'&vendor='+vendername+'&category='+categoryname+'&startp='+startplacename+'&endp='+endplacename+'&vehicle='+vehicleno+'" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';	}
			else	{
				for(i=0;i<=cnt;i++)		{	
					tdd=document.getElementById("tdd"+i);			tdd.style.display='none';			tdm=document.getElementById("tdm"+i);
					tdm.style.display='none';			tdt=document.getElementById("tdt"+i);			tdt.style.display='none';
					tdw=document.getElementById("tdw"+i);			tdw.style.display='none';			tda=document.getElementById("tda"+i);
					tda.style.display='none';			tdf=document.getElementById("tdf"+i);			tdf.style.display='none';
					tdr=document.getElementById("tdr"+i);			tdr.style.display='none';			tdu=document.getElementById("tdu"+i);
					tdu.style.display='none';			tdl=document.getElementById("tdl"+i);			tdl.style.display='none';
					tdldr=document.getElementById("tdldr"+i);			tdldr.style.display='none';			tdlc=document.getElementById("tdlc"+i);
					tdlc.style.display='none';			tdul=document.getElementById("tdul"+i);			tdul.style.display='none';
					tdudr=document.getElementById("tdudr"+i);			tdudr.style.display='none';			tduc=document.getElementById("tduc"+i);
					tduc.style.display='none';			document.getElementById("tds").value="More Info";		}
				document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'print_my_trips.jsp?tds=Hide Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'&statusp1='+statusname+'&vendor='+vendername+'&category='+categoryname+'&startp='+startplacename+'&endp='+endplacename+'&vehicle='+vehicleno+'\');" title="Print My Trips Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
				document.getElementById("excel").innerHTML='<a href="export_my_trip.jsp?&tds=Hide Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'&statusp1='+statusname+'&vendor='+vendername+'&category='+categoryname+'&startp='+startplacename+'&endp='+endplacename+'&vehicle='+vehicleno+'" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';	}}
		  function validate()  {
			  var myDate = new Date(document.getElementById("data1").value);
			  if(document.getElementById("data1").value=="")  {
		    alert("Please select the from date");
		  return false;  }
		  if(document.getElementById("data2").value=="")  {
		    alert("Please select the to date");
		  return false;  }
		  return true;  }
		  function datevalidate()
		{ var date1=document.getElementById("data1").value;
		var date2=document.getElementById("data2").value;
		var dm1,dd1,dy1,dm2,dd2,dy2;
		dy1=date1.substring(0,4);dy2=date2.substring(0,4);dm1=date1.substring(5,7);dm2=date2.substring(5,7);dd1=date1.substring(8,10);
		dd2=date2.substring(8,10);
		var date=new Date();
		var month=date.getMonth()+1;
		var day=date.getDate();
		var year=date.getFullYear();
		if(dy1>year || dy2>year){
		alert("selected date should not be greater than todays date");
		document.getElementById("data1").value="";document.getElementById("data2").value="";document.getElementById("data1").focus;
		return false;}
		else if(year==dy1 && year==dy2) if(dm1>month || dm2>month){
		alert("selected date should not be greater than todays date");
		document.getElementById("data1").value="";document.getElementById("data2").value="";document.getElementById("data1").focus;
		return false;}
		if(dm1==month){
		if(dd1>day || dd2>day){
		alert("selected date should not be greater than todays date");
		document.getElementById("data1").value="";document.getElementById("data2").value="";document.getElementById("data1").focus;
		return false;}}
		if(dy1>dy2){
		alert("From date year is should not be greater than to date year");
		document.getElementById("data1").value="";document.getElementById("data2").value="";document.getElementById("data1").focus;
		return false;}
		else if(year==dy1 && year==dy2) if(dm1>dm2){
		alert("From date month is should not be greater than to date month");
		document.getElementById("data1").value="";document.getElementById("data2").value="";document.getElementById("data1").focus;
		return false;}
		if(dm1==dm2) {
		if(dd1 > dd2){
		alert("From date is should not be greater than to date");
		document.getElementById("data1").value="";document.getElementById("data2").value="";document.getElementById("data1").focus;
		return false;}}
		return true;}
		  
		  function toggleDetails(id,show){
				var popup = document.getElementById("popup"+id);
			if (show) {
			popup.style.visibility = "visible";
			popup.setfocus();
			} else {
			popup.style.visibility = "hidden";
			 }}
			function toggleDetails2(id,show){
				var temp="popup_"+id;
			var popup = document.getElementById(temp);
			if (show) {
			popup.style.visibility = "visible";
			popup.setfocus();
			} else {
			popup.style.visibility = "hidden";}}
			function searchTrip(){var srchbx=document.getElementById("searchid").value;
				if(srchbx==""||srchbx.length==0||srchbx==null){alert("Please enter trip id");}else
				{
					window.location.href="my_trips.jsp?searchid="+srchbx;

					}}
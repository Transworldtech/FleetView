<%@ include file="headernew.jsp"%>

	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	<html>
	<head>
	<script type="text/javascript">

function saveos(id,vehid)
{

	
		try{
			

			
			var comments=document.getElementById("comments"+id).value;
			var date = document.getElementById("data"+id).value;
			//alert(date);
			var otherrson=document.getElementById("othosreason"+id).value;
			var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

		//alert(comments);
		//alert(date);
		
   if(comments=="Select")
   {
	   alert("Please Select Reason");
   }
   else if(comments=="Other" && (otherrson=="" || oth==""))
   {
	      alert("Please Enter Other Reason");

	   
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
					//alert(reslt);
					reslt=reslt.split("-");
					//alert(reslt[0]);
					//alert(reslt[1]);
					if(reslt[0]=="Updates")
					alert("Record Saved Succesfully");

					document.getElementById("tdreason"+id).innerHTML = reslt[1];
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+comments;
			ajaxRequest.open("GET", "brief_report_insert_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
		}
			
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}


function savera(id,vehid)
{

	
		try{
			  

			
//alert(id);
			var commentsra=document.getElementById("commentsra"+id).value;
			var date1 = document.getElementById("datara"+id).value;
			//alert(date1);
			
			var otherrson=document.getElementById("othRAreason"+id).value;
			var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			if(commentsra=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentsra=="Other" && (otherrson=="" || oth==""))
			   {
				      alert("Please Enter Other Reason");

				   
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
//alert(reslt);					
                    reslt=reslt.split("-");

					if(reslt[0]=="Updates")
						alert("Record Saved Succesfully");
					
					document.getElementById("tdreasonra"+id).innerHTML = reslt[1];
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date1+"&otherrson="+otherrson+"&comment="+commentsra;
			ajaxRequest.open("GET", "brief_report_insert_ra_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

		}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}

function saverd(id,vehid)
{

	
		try{

			//alert(id);
			
			var commentsrd=document.getElementById("commentsrd"+id).value;
			var date2 = document.getElementById("datard"+id).value;
			//alert(date2);
			
			var otherrson=document.getElementById("othRDreason"+id).value;
			var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			if(commentsrd=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentsrd=="Other" && (otherrson=="" || oth==""))
			   {
				      alert("Please Enter Other Reason");

				   
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
//alert(reslt);
                     reslt=reslt.split("-");
                     
					if(reslt[0]=="Updates")
						alert("Record Saved Succesfully");
					
					document.getElementById("tdreasonrd"+id).innerHTML = reslt[1];
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date2+"&otherrson="+otherrson+"&comment="+commentsrd;
			ajaxRequest.open("GET", "brief_report_insert_rd_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
		}
			
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}

function savend(id,vehid)
{

	
		try{

			//alert(id);

			var commentsnd=document.getElementById("commentsnd"+id).value;
			var date = document.getElementById("datand"+id).value;
			//alert(date);
			
			var otherrson=document.getElementById("othNDreason"+id).value;
			var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			//alert(date);
			//alert(commentsnd);
			
			
			if(commentsnd=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentsnd=="Other" && (oth=="" || otherrson==""))
			   {
				      alert("Please Enter Other Reason");

				   
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
					//alert(reslt);
                      reslt=reslt.split("-");
                    
					if(reslt[0]=="Updates")
						alert("Record Saved Succesfully");
					
					document.getElementById("tdreasonnd"+id).innerHTML = reslt[1];
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentsnd;
			ajaxRequest.open("GET", "brief_report_insert_nd_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

		}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}

function savedv(id,vehid)
{

	
		try{

			//alert(id);

			var commentsnd=document.getElementById("commentsdv"+id).value;
			var date = document.getElementById("datadv"+id).value;
			//alert(date);
			
			var otherrson=document.getElementById("othDVreason"+id).value;
			var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			//alert(date);
			//alert(commentsnd);
			
			
			if(commentsnd=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentsnd=="Other" && (oth=="" || otherrson==""))
			   {
				      alert("Please Enter Other Reason");

				   
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
					//alert(reslt);
                      reslt=reslt.split("-");
                    
					if(reslt[0]=="Updates")
						alert("Record Saved Succesfully");
					
					document.getElementById("tdreasondv"+id).innerHTML = reslt[1];
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentsnd;
			ajaxRequest.open("GET", "brief_report_insert_dv_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

		}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}









function savecd(id,vehid)
{

	
		try{

			   

			//alert(id);
			var commentscd=document.getElementById("commentscd"+id).value;
			var date = document.getElementById("datacd"+id).value;
			//alert(date);
			
			var otherrson=document.getElementById("othCDreason"+id).value;
			var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			if(commentscd=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentscd=="Other" && (oth=="" || otherrson==""))
			   {
				   
				      alert("Please Enter Other Reason");

				   
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
//alert(reslt);
                      reslt=reslt.split("-");
                    
					if(reslt[0]=="Updates" || reslt=="")
						alert("Record Saved Succesfully");
					
					document.getElementById("tdreasoncd"+id).innerHTML = reslt[1];
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentscd;
			ajaxRequest.open("GET", "brief_report_insert_cd_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 

			}
		}
		    catch(e)
			{
				alert(e);
			}

	
		
}


function savestp(id,vehid)
{

	try{
		  

		//alert(id);
		var commentsstp=document.getElementById("commentsstp"+id).value;
		//alert(commentsstp);
		
		var date = document.getElementById("datastp"+id).value;
		//alert(date);
		
		var otherrson=document.getElementById("othSTOPreason"+id).value;
		var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		if(commentsstp=="Select")
		   {
			   alert("Please Select Reason");
		   }
		else if(commentsstp=="Other" && (oth=="" || otherrson==""))
		   {
			      alert("Please Enter Other Reason");

			   
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
//alert(reslt);
                           reslt=reslt.split("-");
      
				if(reslt[0]=="Updates" || reslt=="")
					alert("Record Saved Succesfully");
				
				document.getElementById("tdreasonstp"+id).innerHTML = reslt[1];
				
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};

		

		
		var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentsstp;
		ajaxRequest.open("GET", "brief_report_insert_stop_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 

		}
	}
	    catch(e)
		{
			alert(e);
		}


}




function savedicon(id,vehid)
{
	try{

			

		//alert(id);
		var commentsdicon=document.getElementById("commentsdic"+id).value;
		var date = document.getElementById("datadic"+id).value;
		//alert(date);
		
		var otherrson=document.getElementById("othDCreason"+id).value;
		var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

		if(commentsdicon=="Select")
		   {
			   alert("Please Select Reason");
		   }
		else if(commentsdicon=="Other" && (oth=="" || otherrson==""))
		   {
			      alert("Please Enter Other Reason");

			   
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
//alert(reslt);
                     reslt=reslt.split("-");
            
				if(reslt[0]=="Updates" || reslt=="")
					alert("Record Saved Succesfully");
				
				document.getElementById("tdreasondic"+id).innerHTML = reslt[1];
				
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};

		

		
		var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentsdicon;
		ajaxRequest.open("GET", "brief_report_insert_dicon_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 

		}
	}
	    catch(e)
		{
			alert(e);
		}

	
}


//saverunhr

function saverunhr(id,vehid)
{
	try{

		//alert(id);tdreasonrunhr datarunhr commentsrunhr
		var commentsRnhr=document.getElementById("commentsrunhr"+id).value;
		var date = document.getElementById("datarunhr"+id).value;
		//alert(date);

		var otherrson=document.getElementById("othRHRreason"+id).value;
		
		var oth=otherrson.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		//alert(commentsRnhr);
		if(commentsRnhr=="Select")
		   {
			   alert("Please Select Reason");
		   }
		else if(commentsRnhr=="Other" && (oth=="" || otherrson=="" ))
		   {
			      alert("Please Enter Other Reason");

			   
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
//alert(reslt);
                       reslt=reslt.split("-");
  
				if(reslt[0]=="Updates" || reslt=="")
					alert("Record Saved Succesfully");
				
				document.getElementById("tdreasonrunhr"+id).innerHTML=reslt[1];
				
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};

		

		
		var queryString ="?vehid="+vehid+"&date="+date+"&otherrson="+otherrson+"&comment="+commentsRnhr;
		ajaxRequest.open("GET", "brief_report_insert_Runhr_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 

		}
	}
	    catch(e)
		{
			alert(e);
		}

	
}






function saveall()
{

	
		try{


			
			var vehid=document.getElementById("vid1").value;
			var date1=document.getElementById("thedate1").value;
			var date2=document.getElementById("thedate2").value;
			var commentsall=document.getElementById("commentsall").value;
			var otherall=document.getElementById("othALLreason").value;
			var oth=otherall.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

			
			
			if(commentsall=="Select")
			   {
				   alert("Please Select Reason");
			   }
			else if(commentsall=="Other" && (otherall=="" || oth==""))
			   {
				      alert("Please Enter Other Reason");

				   
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
					//alert(reslt);

					if(reslt=="Updates"){
						alert("Record Saved Succesfully");
						window.location.reload("brief_report_7days.jsp");
						
					}else{
						alert("Violations are already closed");
						
					}
					
				
					}catch(e)
					{
					alert(e);
					}
				} 
			};

			

			
			var queryString ="?vehid="+vehid+"&date1="+date1+"&comments7="+commentsall+"&otherall="+otherall+"&date2="+date2;
			ajaxRequest.open("GET", "brief_report_insert_saveall_Ajax.jsp" + queryString, true);
			ajaxRequest.send(null); 
			}
			
		}
		    catch(e)
			{
				alert(e);
			}

	
		
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
    
    document.brief7close.action ="excel.jsp";
    document.forms["brief7close"].submit();
} 
function showothloc(id)
{
	//alert(id);
	var SelValue1=document.getElementById("comments"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othosreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othosreason"+id).style.display='none';         
       }
}


function showothlocra(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsra"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othRAreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othRAreason"+id).style.display='none';         
       }
}

function showothlocrd(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsrd"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othRDreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othRDreason"+id).style.display='none';         
       }
}

function showothlocnd(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsnd"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othNDreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othNDreason"+id).style.display='none';         
       }
}
function showothlocdv(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsdv"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othDVreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othDVreason"+id).style.display='none';         
       }
}

function showothloccd(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentscd"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othCDreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othCDreason"+id).style.display='none';         
       }
}

function showothlocdc(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsdic"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othDCreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othDCreason"+id).style.display='none';         
       }
}

function showothlocrhr(id)
{
	//alert(id);
	var SelValue1=document.getElementById("commentsrunhr"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othRHRreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othRHRreason"+id).style.display='none';         
       }
}

function showothlocstop(id)
{
	//alert(id); 
	var SelValue1=document.getElementById("commentsstp"+id).value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othSTOPreason"+id).style.display="";          
        }
        else 
       {
        	document.getElementById("othSTOPreason"+id).style.display='none';         
       }
}




function showothlocall()
{
	//alert(id);
	var SelValue1=document.getElementById("commentsall").value;
	//alert(SelValue1);
        if(SelValue1=="Other")
        {
        	document.getElementById("othall").style.display="";          
        }
        else 
       {
        	document.getElementById("othall").style.display='none';         
       }
}






</script>

</head>

	
<%

String vid="", sql="",sql1="",sql2="", transporter="", vehregno="", thedate1="", thedate2="",Transporter="",vehRegNo="";
String showdate="",dateformat="";
Connection con=null ;

%>


<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st1=con.createStatement();
	 Statement st2=con.createStatement();
	Statement st3=con.createStatement();
	 Statement st4=con.createStatement();
	 Statement smtos=con.createStatement();
	 Statement smtra=con.createStatement();
	 Statement smtrd=con.createStatement();
	 Statement smtnd=con.createStatement();
	 Statement smtcd=con.createStatement();
	 Statement smtalll=con.createStatement();
	 Statement smtstp=con.createStatement();
	 Statement smtdicc=con.createStatement();

	
	vid=request.getParameter("vid");
	
	thedate1=request.getParameter("SD");
	
	thedate2=request.getParameter("ED");
	vehRegNo=request.getParameter("vehRegNo");
	Transporter=request.getParameter("Transporter");

	
	
	
%>
<%	   String exportFileName=session.getAttribute("user").toString()+"_brief7closeReport.xls";
%>
<body>

<form id="brief7close" name="brief7close" action="" method="post">

<table border="0" cellpadding="0" width="100%" align="center" class="stats">
		<tr>
		<td>
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=Utilities.printDate()%>
                           </div>
		</td>
		</tr>
		</table>
		 <div id="table1">
		
<table width="100%" align="center" class="stats" >
			<tr>
			<td align="center">
		<!-- 	<div align="left"><font size="3" >Report No: 1.8</font></div>-->
			<font  size="3" ><b></b></font></td>
			</tr>			<tr>			<td>
			<div align="center"><font face="Arial" color="black"  size="3"><b>Exception Report For <%=Transporter%>, Vehicle <%=vehRegNo%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate1)) %>  to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2))%>  </b></font></div>
					</td>			</tr>
		
			</table>
						<div style="margin-left: 100px">			<br></br>
			<table border="0" align="center" width="100%">
					<tr>
			<td><input type="button" id="save" name="save" value="Save All" style="border-style: outset;border-color: black " onclick="saveall();"></input>
			
			
			<input type="hidden" id="vid1" name="vid1" value="<%=vid %>"></input>
			<input type="hidden" id="thedate1" name="thedate1" value="<%=thedate1 %>"></input>
			<input type="hidden" id="thedate2" name="thedate2" value="<%=thedate2 %>"></input>
				<%
					String sqlalll = "select Reason from db_gps.t_violationclose where GPName='Castrol'";
			             ResultSet rsalll = smtalll.executeQuery(sqlalll);
									
					%>
			
			<select name="commentsall" id="commentsall" class="element select medium" style="width: 250px" onChange="showothlocall();">
                     <option value="Select">--Select--</option>
                     <%
							while (rsalll.next()) {
						%>
						<option value="<%=rsalll.getString("Reason")%>"><%=rsalll.getString("Reason")%>
						</option>
						<%		}	%>   
						
						<option value="Other">Other</option>
                     			 </select>	
                     	              

                      
			</td>
						</tr>
						<tr id="othall" style="display: none;">
						<td><br></br>
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   <input type="text" class="element text medium" name="othALLreason" id="othALLreason" style="width: 250px" />
											
						</td>
						
						</tr>
			</table>
			</div>
				
			
			<table border="0" align="center"  class="stats">
			
			
			<tr>
					
			
		<td align="center"><font face="Arial" color="black" size="3">Over Speed</font></td>
	</tr>
	
	<tr>
		<td>
		<div align="center">
		<table  border="1" style="width: 800px" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>From-Date-Time</b></th>
				<th><b>Speed</b></th>
				<th><b>Duration/Sec</b></th>
				
				<th><b>Reason</b></th>
			</tr>
			
				<%
				try{
				int i=1,h=0;
				String cmt4="",ostimefrom="";
				sql="select FromDate,FromTime,Speed,Duration,ClosingComment from db_gpsExceptions.t_vehall_overspeed where VehCode='"+vid+"' and OverrideStatus='Open' and FromDatetime >='"+thedate1+"' and FromDatetime <='"+thedate2+"'";
				
				ResultSet rs=st1.executeQuery(sql);
				while(rs.next())
				{
					cmt4=rs.getString("ClosingComment");
					ostimefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("FromTime")));

					%>
					
					<tr>
					<td align="right" ><div align="right"><%=i %></div></td>
					<td align="right"><div  align="right">
					<%out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("FromDate"))));
					%> <%=ostimefrom%></div><input type="hidden" id="data<%=i%>"  value="<%=rs.getString("FromDate")+" "+rs.getString("FromTime")%>"></input>
					 </td>
					<td align="right"><div align="right"><%=rs.getString("Speed") %></div></td>
					<td align="right"><div align="right"><%=rs.getString("Duration") %></div></td>
					
					<%
					
					if(cmt4=="-" || cmt4.equals("-"))
					{
					%>
					<td id = "tdreason<%=i%>" align="left" style="width: 45%;"><div align="left">
					<%
					String sqloss = "select Reason from db_gps.t_violationclose where category='OS' and GPName='Castrol'";
			             ResultSet rsoss = smtos.executeQuery(sqloss);
									
					%>
					
					<select name="comments" id="comments<%=i %>" class="element select medium" style="width: 250px" onChange="showothloc(<%=i%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsoss.next()) {
						%>
						<option value="<%=rsoss.getString("Reason")%>"><%=rsoss.getString("Reason")%>
						</option>
						<%
							}
						%>
                     
                     						<option value="Other">Other</option>
                     			 </select>	  <input type="text" class="element text medium" name="othosreason" id="othosreason<%=i%>" style="display:none;width: 230px" />
                     			 		
                       
                       
                <a title="Save" onclick="saveos(<%=i%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>   
                                     
                      </div> 
                      
                      
                      
                      </td>
                     
 
                        
                        
                        <%
                        
					}
					else{
						%>
						<td align="left" ><div align="left"><%=cmt4 %></div></td>
						
						<%
						
					}
                        
                        
                        %>
					</tr>
					<%
					
					i++;	
					
				}
				}catch(Exception e)
				{
				e.printStackTrace();	
				}
				
				
				
				%>
				
				
			
						
		</table>
		</div>

		</td>	
		
	</tr>
	<tr>
		<td align="center"><font face="Arial" color="black" size="3">Rapid
		Acceleration</font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Reason1</b></th>
			</tr>
			
			
			
			<%
			    int m=1,s=0;
			String cmt3="",ratimefrom="";
				String sql4="select TheDate,TheTime,FromSpeed,ToSpeed,ClosingComment from db_gpsExceptions.t_vehall_ra where VehCode='"+vid+"' and OverrideStatus='Open' and TheDatetime >='"+thedate1+"' and TheDatetime <='"+thedate2+"'";
				
				ResultSet rs4=st1.executeQuery(sql4);
				while(rs4.next())
				{
					cmt3=rs4.getString("ClosingComment");
                    System.out.println("ra cmt is "+cmt3);
					ratimefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs4.getString("TheTime")));

					%>
					
					<tr>
					<td align="right"><div align="right"><%=m%></div></td>
					<td align="right"><div  align="right"><%out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs4.getString("TheDate"))));
						%> <%=ratimefrom%></div><input type="hidden" id="datara<%=m%>" value="<%=rs4.getString("TheDate")+" "+rs4.getString("TheTime")%>" ></input>
										
			</td>
					<td align="right"><div align="right"><%=rs4.getString("FromSpeed") %></div></td>
					<td align="right"><div align="right"><%=rs4.getString("ToSpeed") %></div></td>
					
					<%
					if(cmt3=="-" || cmt3.equals("-"))
					{
					
					%>
					<td id = "tdreasonra<%=m%>" align="left" style="width: 45%;"><div align="left">
						<%
					String sqlraa = "select Reason from db_gps.t_violationclose where category='RA' and GPName='Castrol'";
			             ResultSet rsraa = smtra.executeQuery(sqlraa);
									
					%>
					<select name="commentsra" id="commentsra<%=m%>" class="element select medium" style="width: 250px" onChange="showothlocra(<%=m%>)">
                     <option value="Select">--Select--</option>
                        <%
							while (rsraa.next()) {
						%>
						<option value="<%=rsraa.getString("Reason")%>"><%=rsraa.getString("Reason")%>
						</option>
						<%
							} 
						%>
                     <option value="Other">Other</option>
                     			 </select>	  <input type="text" class="element text medium" name="othRAreason" id="othRAreason<%=m%>" style="display:none;width: 230px" />
                     			 		
                     
                <a title="Save" onclick="savera(<%=m%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                        </div></td>
                        
                        
                        <%
                        
					}
					
					else{
						
						%>
						<td align="left"><div align="left"><%=cmt3 %></div></td>
						<%
					}
                        %>
					</tr>
					<%
					
					m++;	
					
				}
			
			
			
			%>
			
			
			
				
		</table>
		</div>
		</td>
		</tr>
	<tr>
		<td align="center"><font face="Arial" color="black" size="3">Rapid
		Deceleration</font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Reason</b></th>
			</tr>
			
			
			
			<%
			    int j=1,t=0;
			String cmt2="",rdtimefrom="";
				sql1="select TheDate,TheTime,FromSpeed,ToSpeed,ClosingComment from db_gpsExceptions.t_vehall_rd where VehCode='"+vid+"' and OverrideStatus='Open' and TheDatetime >='"+thedate1+"' and TheDatetime <='"+thedate2+"'";
				
				ResultSet rs1=st1.executeQuery(sql1);
				while(rs1.next())
				{
					cmt2=rs1.getString("ClosingComment");
					rdtimefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs1.getString("TheTime")));

					%>
					
					<tr>
					<td align="right"><div align="right"><%=j%></div></td>
					<td align="right"><div  align="right"><%
					out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate"))));
 %> <%=rdtimefrom%></div><input type="hidden" id="datard<%=j%>" value="<%=rs1.getString("TheDate")+" "+rs1.getString("TheTime")%>"></input></td>
					<td align="right"><div align="right"><%=rs1.getString("FromSpeed") %></div></td>
					<td align="right"><div align="right"><%=rs1.getString("ToSpeed") %></div></td>
					
					
					
					<%
					if(cmt2=="-" || cmt2.equals("-"))
					{
					%>
					<td id = "tdreasonrd<%=j%>" align="left" style="width: 45%;"><div align="left">
					<%
					String sqlrdd = "select Reason from db_gps.t_violationclose where category='RD' and GPName='Castrol'";
			             ResultSet rsrdd = smtrd.executeQuery(sqlrdd);
									
					%>
					<select name="commentsrd" id="commentsrd<%=j %>" class="element select medium" style="width: 250px" onChange="showothlocrd(<%=j%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsrdd.next()) {
						%>
						<option value="<%=rsrdd.getString("Reason")%>"><%=rsrdd.getString("Reason")%>
						</option>
						<%
							}
						%>  
                     
                     <option value="Other">Other</option>
                     			 </select>	  <input type="text" class="element text medium" name="othRDreason" id="othRDreason<%=j%>" style="display:none;width: 230px" />
                     		

                <a title="Save" onclick="saverd(<%=j%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                     </div>   </td>
                        
                        
                        <%
					}
					else{
						%>
						<td align="left"><div align="left"><%=cmt2 %></div></td>
						<%
						
					}
                        
                        %>
					</tr>
					<%
					
					j++;		
							
				}
			
			
			
			%>
			
			
			
			
			
			
		</table></div>
		</td>
	</tr>
	
	
	<tr>
		<td align="center"><font face="Arial" color="black" size="3">Night Driving</font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Reason</b></th>
			</tr>
			
			
			<%
				int k=1,kn=0;
			String cmt1="",ndtimefrom="",ndtimeto="";
				sql2="select FromDate,FromTime,ToDate,ToTime,Distance,Duration,ClosingComment from db_gpsExceptions.t_vehall_nd where VehCode='"+vid+"' and OverrideStatus='Open' and FromDatetime >='"+thedate1+"' and FromDatetime <='"+thedate2+"'";
				
				ResultSet rs2=st1.executeQuery(sql2);
				while(rs2.next())
				{
					cmt1=rs2.getString("ClosingComment");
					ndtimefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs2.getString("FromTime")));
					ndtimeto=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs2.getString("ToTime")));

					
					%>
					
					<tr>
					<td align="right"><div align="right"><%=k %></div></td>
					<td align="right"><div align="right"><%out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs2.getString("FromDate"))));
 %> <%=ndtimefrom%></div><input type="hidden" id="datand<%=k%>" value="<%=rs2.getString("FromDate")+" "+rs2.getString("FromTime")%>"></input></td>
<td align="right"><div align="right"><%out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs2.getString("ToDate"))));
 %> <%=ndtimeto%></div></td> 
 					<td align="right"><div align="right"><%=rs2.getString("Distance") %></div></td>
					<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs2.getString("Duration")))  %></div></td>
					
					
					
					<%
					
					if(cmt1=="-" || cmt1.equals("-"))
					{
					
					%>
					<td id = "tdreasonnd<%=k%>" align="left" style="width: 45%;"><div id = "tdreasonnd<%=k%>" align="left">
					<%
					String sqlndd = "select Reason from db_gps.t_violationclose where category='ND' and GPName='Castrol'";
			             ResultSet rsndd = smtnd.executeQuery(sqlndd);
									
					%>
					
					<select name="commentsnd" id="commentsnd<%=k %>" class="element select medium" style="width: 250px" onChange="showothlocnd(<%=k%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsndd.next()) {
						%>
						<option value="<%=rsndd.getString("Reason")%>"><%=rsndd.getString("Reason")%>
						</option>
						<%
							}
						%> 
                     <option value="Other">Other</option>
                     			 </select>	  <input type="text" class="element text medium" name="othNDreason" id="othNDreason<%=k%>" style="display:none;width: 230px" />
                     		
                     

                <a title="Save" onclick="savend(<%=k%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div> </td>
                        <%
					}
					else{
						
						%>
						<td align="left"><div align="left"><%=cmt1 %></div></td>
						<%
						
					}
                        
                        %>
					</tr>
					<%
					
					k++;
					
				}
				
				
				
				
				%>
			
			
		</table></div>
		</td>
	</tr>
	
	<tr>
		<td align="center"><font face="Arial" color="black" size="3">Continuous
		Driving</font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Reason</b></th>
				
			</tr>
			
			
			
			<%
				int l=1,ln=0;
			
			String cmt="",datecdvio="",datecdvios="",cdtimefrom="",cdtimeto="";
				String sql3="select FromDate,FromTime,ToDate,ToTime,Distance,Duration,ClosingComment from db_gpsExceptions.t_vehall_crcopy where VehCode='"+vid+"' and OverrideStatus='Open' and FromDatetime >='"+thedate1+"' and FromDatetime <='"+thedate2+"'";
				
				ResultSet rs3=st1.executeQuery(sql3);
				while(rs3.next())
				{
					cmt=rs3.getString("ClosingComment");
					datecdvio=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs3.getString("FromDate")));
					datecdvios=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs3.getString("ToDate")));
					cdtimefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs3.getString("FromTime")));
					cdtimeto=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs3.getString("ToTime")));
					
					%>
					
					<tr>
					<td align="right"><div align="right"><%=l %></div></td>
					<td align="right"><div align="right"><%=datecdvio%> <%=cdtimefrom%></div>
					<input type="hidden" id="datacd<%=l%>" value="<%=rs3.getString("FromDate")+" "+rs3.getString("FromTime")%>"></input>
					
					</td>
					<td align="right"><div align="right"><%=datecdvios%> <%=cdtimeto%></div></td> 
 		<td align="right"><div align="right"><%=rs3.getString("Distance") %></div></td>
					<td align="right"><div align="right"><%=rs3.getString("Duration")%></div></td>
					
					<%
					if(cmt=="-" || cmt.equals("-"))
					{
						%>
						<td id = "tdreasoncd<%=l%>"  align="left" style="width: 45%;"><div align="left">
					<%
					String sqlcdd = "select Reason from db_gps.t_violationclose where category='CD' and GPName='Castrol'";
			             ResultSet rscdd = smtcd.executeQuery(sqlcdd);
									
					%>
					<select name="commentscd" id="commentscd<%=l %>" class="element select medium" style="width: 250px" onChange="showothloccd(<%=l%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rscdd.next()) {
						%>
						<option value="<%=rscdd.getString("Reason")%>"><%=rscdd.getString("Reason")%>
						</option>
						<%
							}
						%>
                     
<option value="Other">Other</option>   
                     			 </select>	  <input type="text" class="element text medium" name="othCDreason" id="othCDreason<%=l%>" style="display:none;width: 230px" />
                     	
                      
                <a title="Save" onclick="savecd(<%=l%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div></td>
						<%
						
					}
					else{
						
						
						%>
						<td align="left"><div align="left"><%=cmt %></div></td>
						<%
					}
					
					%>
					
					</tr>
					<%
					
					l++;
					
				}
				
				
				
				
				%>
				
			
		
			
		</table></div>
		</td>
	</tr>






<tr>
		<td align="center"><font face="Arial" color="black" size="3">Stops</font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Duration</b></th>
				<th><b>Location</b></th>
				<th><b>Reason</b></th>
				
			</tr>
			
			
			
			<%
				int st=1,sp=0;
			
			String cmtstp="",datestpvio="",datestpvios="",timefrom="",timeto="";
				String sqlstp="select FromDate,FromTime,ToDate,ToTime,Duration,Location,ClosingComment from db_gpsExceptions.t_vehall_stsp where VehCode='"+vid+"' and Duration > '04:00:00' and FromTime >='05:00:00' and FromTime <= '23:00:00' and FromDate=ToDate and OverrideStatus='Open' and FromDatetime >='"+thedate1+"' and FromDatetime <='"+thedate2+"'";
				System.out.println("sqlstp>>>>"+sqlstp);

				ResultSet rsstp=st1.executeQuery(sqlstp);
				while(rsstp.next())
				{
					cmtstp=rsstp.getString("ClosingComment");
					datestpvio=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsstp.getString("FromDate")));
					datestpvios=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsstp.getString("ToDate")));
					timefrom=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsstp.getString("FromTime")));
					timeto=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsstp.getString("ToTime")));
					%>
					
					<tr>
					<td align="right"><div align="right"><%=st%></div></td>
					<td align="right" style="width: 120px"><div  align="right"><%=datestpvio%> <%=timefrom%></div>
					<input type="hidden" id="datastp<%=st%>" value="<%=rsstp.getString("FromDate")+" "+rsstp.getString("FromTime")%>"></input>
					</td>
					<td align="right" style="width: 120px"><div align="right"><%=datestpvios%> <%=timeto%></div></td> 
 		<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsstp.getString("Duration")))%></div></td>
					<td align="right"><div align="left"><%=rsstp.getString("Location") %></div></td>
					
					<%
					if(cmtstp=="-" || cmtstp.equals("-"))
					{
						%>
						<td id = "tdreasonstp<%=st%>" style="width: 40%" align="left"><div align="left">
					<%
					String sqlstpp = "select Reason from db_gps.t_violationclose where category='Stop' and GPName='Castrol'";
			             ResultSet rsstpp=smtstp.executeQuery(sqlstpp);
									
					%>
					<select name="commentsstp" id="commentsstp<%=st%>" class="element select medium" style="width: 250px" onChange="showothlocstop(<%=st%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsstpp.next()) {
						%>
						<option value="<%=rsstpp.getString("Reason")%>"><%=rsstpp.getString("Reason")%>
						</option>
						<%
							}
						%>
                     <option value="Other">Other</option>   
                     			 </select>	  <input type="text" class="element text medium" name="othSTOPreason" id="othSTOPreason<%=st%>" style="display:none;width: 230px" />
                     	
                     

                      
                <a title="Save" onclick="savestp(<%=st%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div></td>
						<%
						
					}
					else{
						
						
						%>
						<td align="left"><div align="left"><%=cmtstp %></div></td>
						<%
					}
					
					%>
					
					</tr>
					<%
					
					st++;
					
				}
				
				
				
				
				%>
				
			
		
			
		</table></div>
		</td>
	</tr>


























<tr>
		<td align="center"><font face="Arial" color="black" size="3">Disconnection Data</font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
				<tr>
				<th><b> Sr. </b></th>
				<th><b>Off TimeFrom</b></th>
				<th><b>From Location</b></th>
				<th><b>Off TimeTo</b></th>
				<th><b>To Location</b></th>
				<th><b>Distance</b></th>
				<th><b>Reason</b></th>
			</tr>
			
	<%
	try{
    int dic=1;

				String sqlDic="";
	String cmtdic="",datedicvio="",datedicvios="";


				 sqlDic="select * from db_gps.t_disconnectionData where vehicleCode='"+vid+"' and Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+thedate1+"'  and OffTimeFrom<='"+thedate2+"') or (OffTimeTo >='"+thedate1+"'  and OffTimeTo<='"+thedate2+"') or (OffTimeFrom <='"+thedate1+"' and OffTimeTo >='"+thedate2+"')) ";
				System.out.println("sqlstp>>>>"+sqlDic);

				ResultSet rsdic=smtdicc.executeQuery(sqlDic);
				while(rsdic.next())
				{
				
					cmtdic=rsdic.getString("ClosingComment");
					datedicvio=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdic.getString("OffTimeFrom")));
					datedicvios=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdic.getString("OffTimeTo")));
					 
					
					%>
					
					<tr>
					<td align="right"><div align="right"><%=dic%></div></td>
					<td align="right" style="width: 10%" ><div align="right"><%=datedicvio%></div>
					<input type="hidden" id="datadic<%=dic%>" value="<%=rsdic.getString("OffTimeFrom")%>"></input>
					
					</td>
					<td align="left" style="width: 20%" ><div align="left"><%=rsdic.getString("FromLocation") %></div></td>
					
					<td align="right" style="width: 10%" ><div align="right"><%=datedicvios%></div></td> 
					<td align="left" style="width: 20%"><div align="left"><%=rsdic.getString("ToLocation") %></div></td>
					
					<td align="right"><div align="right"><%=rsdic.getString("Distance") %></div></td>
					
					<%
					if(cmtdic=="-" || cmtdic.equals("-"))
					{
						%>
						<td id = "tdreasondic<%=dic%>" style="width: 45%" align="left"><div align="left">
					<%
					String sqlDiscon = "select Reason from db_gps.t_violationclose where category='Discon' and GPName='Castrol'";
			             ResultSet rsdicon=smtstp.executeQuery(sqlDiscon);
									
					%>
					<select name="commentsdic" id="commentsdic<%=dic%>" class="element select medium" style="width: 250px" onChange="showothlocdc(<%=dic%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsdicon.next()) {
						%>
						<option value="<%=rsdicon.getString("Reason")%>"><%=rsdicon.getString("Reason")%>
						</option>
						<%
							}
						%>
                     <option value="Other">Other</option>   
                     			 </select>	  <input type="text" class="element text medium" name="othDCreason" id="othDCreason<%=dic%>" style="display:none;width: 230px" />
                     	

                       
                <a title="Save" onclick="savedicon(<%=dic%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div></td>
						<%
						
					}
					else{
						
						
						%>
						<td align="left"><div align="left"><%=cmtdic%></div></td>
						<%
					}
					
					%>
					
					</tr>
					<%
					
					dic++;
					
				}
				
				
				
	}catch(Exception e)
	{
		e.printStackTrace();
	}
				%>
				
			
		
			
		</table></div>
		</td>
	</tr>



<tr>
		<td align="center"><font face="Arial" color="black" size="3">Run Hours </font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date</b></th>
				<th><b>Location</b></th>
				<th><b>Distance</b></th>
				<th><b>RDuration</b></th>
				<th><b>Reason</b></th>
				
				
			</tr>
			<%
		   int runhr=1;
			String daterhr="",thedate11="",thedate12="",cmtrsRhr="";
			//thedate1+" 00:00:00", thedate2+" 23:59:59
							thedate11=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate1));
							thedate12=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate2));


		String	sqlRhr="SELECT * FROM db_gpsExceptions.t_vehall_ds WHERE vehcode ='"+vid+"' and RDuration > '10:00:00' and OverrideStatus='Open' and thedate >='"+thedate11+"' and thedate <='"+thedate12+"'";
			System.out.println("Query of Run hrviolation " +sqlRhr);
			ResultSet rsRhr=st4.executeQuery(sqlRhr);
			
			
			
			while(rsRhr.next())
			{
				
				cmtrsRhr=rsRhr.getString("ClosingComment");

				daterhr=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsRhr.getString("TheDate")));
				
			%>
			<tr>
			<td align="right"><div align="right"><%=runhr%></div></td>
					<td align="right" ><div align="right"><%=daterhr%></div>
					<input type="hidden" id="datarunhr<%=runhr%>" value="<%=rsRhr.getString("TheDate")%>" ></input>
					
					</td>
					<td align="left"><div align="left" style="width: "><%=rsRhr.getString("Location") %></div></td>
					
					<td align="right"><div align="right"><%=rsRhr.getString("Distance") %></div></td>
					<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsRhr.getString("RDuration")))  %></div></td>
					
					
					<%
					if(cmtrsRhr=="-" || cmtrsRhr.equals("-"))
					{
						%>
						<td id="tdreasonrunhr<%=runhr%>" style="width: 45%;" align="left"><div align="left">
					<%
					String sqlrunhrReson = "select Reason from db_gps.t_violationclose where category='RunDurton' and GPName='Castrol'";
			             ResultSet rsrunhrr=smtstp.executeQuery(sqlrunhrReson);
									
					%>
					<select name="commentsrunhr" id="commentsrunhr<%=runhr%>" class="element select medium" style="width: 250px" onChange="showothlocrhr(<%=runhr%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsrunhrr.next()) {
						%>
						<option value="<%=rsrunhrr.getString("Reason")%>"><%=rsrunhrr.getString("Reason")%>
						</option>
						<%
							}
						%>
                     
  <option value="Other">Other</option>
                     			 </select>	  <input type="text" class="element text medium" name="othRHRreason" id="othRHRreason<%=runhr%>" style="display:none;width: 230px" />
                     
                <a title="Save" onclick="saverunhr(<%=runhr%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div></td>
						<%
						
					}
					else{
						
						
						%>
						<td align="left"><div align="left"><%=cmtrsRhr%></div></td>
						<%
					}
					
					%>
					
					
					
					
					
			
			
			</tr>
			
			<%
				
			runhr++;
				
			}
			
		%>
		</table></div></td></tr>
		
			
				
			<tr>
		<td align="center"><font face="Arial" color="black" size="3">Route Deviation </font></td>
	</tr>
	<tr>
		<td><div align="center">
		<table style="width: 800px" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Reason</b></th>
			</tr>
			
			
			<%
				int r=1,rkn=0;
			String cmt11="",dvtimefrom="",dvtimeto="";
				sql2="select * from db_gpsExceptions.t_vehall_dv where VehCode='"+vid+"' and FromDatetime >='"+thedate1+"' and FromDatetime <='"+thedate2+"' and violationstatus='Open'";
				
				ResultSet rsdv=st1.executeQuery(sql2);
				while(rsdv.next())
				{
					cmt11="";
					cmt11=rsdv.getString("OverrideComents");
					dvtimefrom=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdv.getString("FromDateTime")));
					dvtimeto=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdv.getString("ToDateTime")));

					%>
					
					<tr>
					<td align="right"><div align="right"><%=r %></div></td>
					<td align="right"><div  align="right"><%=dvtimefrom%></div><input type="hidden" id="datadv<%=r%>" value="<%=rsdv.getString("FromDateTIme")%>"></input></td>
<td align="right"><div align="right"> <%=dvtimeto%></div><input type="hidden" id="datadv1<%=r%>" value="<%=rsdv.getString("ToDateTime")%>"></input></td> 
 					<td align="right"><div align="right"><%=rsdv.getString("Distance") %></div></td>
					<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsdv.getString("Duration")))  %></div></td>
					
					
					
					<%
					
					if(cmt11.equals("-"))
					{
					
					%>
					<td id = "tdreasondv<%=r%>" align="left" style="width: 45%;"><div align="left">
					<%
					String sqlndd = "select Reason from db_gps.t_violationclose where category='DV' and GPName='Castrol'";
			             ResultSet rsn = smtnd.executeQuery(sqlndd);
									
					%>
					
					<select name="commentsdv" id="commentsdv<%=r %>" class="element select medium" style="width: 250px" onChange="showothlocdv(<%=r%>)">
                     <option value="Select">--Select--</option>
                     <%
							while (rsn.next()) {
						%>
						<option value="<%=rsn.getString("Reason")%>"><%=rsn.getString("Reason")%>
						</option>
						<%
							}
						%> 
                     <option value="Other">Other</option>
                     			 </select>	  <input type="text" class="element text medium" name="othDVreason" id="othDVreason<%=r%>" style="display:none;width: 230px" />
                     		
                     

                <a title="Save" onclick="savedv(<%=r%>,<%=vid%>);"><img src="newimages/save.png" border="0"></a>                        
                       </div> </td>
                        <%
					}
					else{
						
						%>
						<td align="left"><div align="left"><%=cmt11 %></div></td>
						<%
						
					}
                        
                        %>
					</tr>
					<%
					
					r++;
					
				}
				
				
				
				
				%>
			
			
		</table></div>
		</td>
	</tr>
	




















</table>
</div>
</form>
</body>
</html>
<%
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			finally
			{
				try{
					con.close();
				}catch(Exception e)
				{
					
				}
			}
		
	%>



<%@ include file="footernew.jsp"%>
<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vehicle Maintainance Entry Edit</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
	<script language="javascript">
 var showothothsertype="No";

 var preventive="No";
 var oil="No";
 var puc="No";
 var insurance="No";
 var fitness="No";
 var npermit="No";
 var tax="No";
 
function validate()
{  
	//alert("In Validate");
	 var v1=document.vehmaintenanceform.vehicle.value;
	 var v2=document.vehmaintenanceform.sertype.value;
	 var v3=document.vehmaintenanceform.serkm.value;
	 var v4=document.vehmaintenanceform.nxtserkm.value;
	 var v5=document.vehmaintenanceform.days.value;
	 var v51=document.getElementById("presentalert").innerHTML;
	 var v10=document.vehmaintenanceform.calender1.value;
	 var v11=document.vehmaintenanceform.calender.value;
	 var v12=document.vehmaintenanceform.emailto.value;

	 var vname=document.vehmaintenanceform.vendorname.value;  

	 var amount=document.vehmaintenanceform.amount.value;   

	 var recieptno=document.vehmaintenanceform.recieptno.value;   

	 var docid=document.vehmaintenanceform.docid.value;  

	 var numericExpressionn = /^[.0-9]+$/;



	/* if(Select=="Yes" &&preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No")
		{
		 if(v7=="Select")
			 {
                       alert("Please select the ment type");
			 }
		}

		else*/
			
	if(preventive=="Yes" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && permit=="No"&& sparepart=="No")
	{
		//alert("----------in function-------");
		if(v1=="Select")
	    {
	        alert("Please Select Vehicle");
	        return false;   
	    }


		var invalid = /[^A-Za-z\s]/;  
		var vname=document.vehmaintenanceform.vendorname.value;
	    if(vname=="") {}
	    if(invalid.test(vname))
	     {     
	         alert('vendor name must have characters only');  
	         return false;  
	      }  
		
	    if(isNaN(amount))
		{
			alert("Please Enter the valid amount");
		       return false;    

		}
		
		if(v12=="")
	 	{
	 		alert("Please Enter Atleast One Email Address");
	 		return false; 
	 	}

		
	 	
		if(v51.length>0)
	    {
	       alert("Alert For This Entry Already Present");
	       return false;   
	    }
	}else
		if(preventive=="No" && oil=="Yes" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && permit=="No"&& sparepart=="No")
		{
			if(v1=="Select")
		      {
		         alert("Please Select Vehicle");
		         return false;   
		      }

		      if(v2=="Select")  
		      {
		          alert("Please Select Maintenance Type");
		          return false;   
		      }

		      if(showothothsertype=="Yes")
		      { 
		          var v21=document.vehmaintenanceform.othsertype.value;
		          
		         if(v21.length==0)
		         { 
		            alert("Please Enter New Maintenance Type");
		            return false;
		         }
		      }
		 	if(v3.length==0)
			{
				alert("Please Enter Maintenance Km");
		        return false;
			}
		 	else if(!(v3.match(numericExpressionn)))
		 	{
		 		alert("Please Enter Numeric value for Maintenance Km");
		        return false;
		 	 }
			if(v4.length==0)
			{
				alert("Please Enter Next Maintenance Km");
		        return false;
			}
			else if(!(v4.match(numericExpressionn)))
		 	{
		 		alert("Please Enter Numeric value for Next Maintenance Km");
		        return false;
		 	}
			
		 	if(v10==v11)
		 	{
		 		alert("Please Change Next Maintenance Date");
		 		return false; 
		 	}
		 	if(v5.length==0)
			{
				alert("Please Enter Alert Before Days");
		        return false;
			}
			else if(!(v5.match(numericExpressionn)))
		 	{
		 		alert("Please Enter Numeric value for Alert Before Days");
		        return false;
		 	}
		 	if(v12=="")
		 	{
		 		alert("Please Enter Atleast One Email Address");
		 		return false; 
		 	}


            
		 	var invalid = /[^A-Za-z\s]/;  
			var vname=document.vehmaintenanceform.vendorname.value;
		    if(vname=="") {}
		    if(invalid.test(vname))
		     {     
		         alert('vendor name must have characters only');  
		         return false;  
		      }  
			
		 	if(isNaN(amount))
			{
				alert("Please Enter the valid amount");
			       return false;    

			}
		 	if(v51.length>0)
		    {
		       alert("Alert For This Entry Already Present");
		       return false;   
		    }
		 	return datevalidate();



		 	
			
		}else
			if(preventive=="No" && oil=="No" && puc=="Yes" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && permit=="No"&& sparepart=="No")
			{
				if(v1=="Select")
			    {
			        alert("Please Select Vehicle");
			        return false;   
			    }
				if(v10==v11)
			 	{
			 		alert("Please Change Next Maintenance Date");
			 		return false; 
			 	}


				var invalid = /[^A-Za-z\s]/;  
				var vname=document.vehmaintenanceform.vendorname.value;
			    if(vname=="") {}
			    if(invalid.test(vname))
			     {     
			         alert('vendor name must have characters only');  
			         return false;  
			      }  
			      
			    if(isNaN(amount))
				{
					alert("Please Enter the valid amount");
				       return false;    

				} 
				
			 	if(v5.length==0)
				{
					alert("Please Enter Alert Before Days");
			        return false;
				}
				else if(!(v5.match(numericExpressionn)))
			 	{
			 		alert("Please Enter Numeric value for Alert Before Days");
			        return false;
			 	}
			 	if(v12=="")
			 	{
			 		alert("Please Enter Atleast One Email Address");
			 		return false; 
			 	}
			 	if(v51.length>0)
			    {
			       alert("Alert For This Entry Already Present");
			       return false;   
			    }
			 	return datevalidate();
			}else
				if(preventive=="No" && oil=="No" && puc=="No" && insurance=="Yes" && fitness=="No" && npermit=="No" && tax=="No" && permit=="No"&& sparepart=="No")
				{
					if(v1=="Select")
				    {
				        alert("Please Select Vehicle");
				        return false;   
				    }
					if(v10==v11)
				 	{
				 		alert("Please Change Next Maintenance Date");
				 		return false; 
				 	}

					var invalid = /[^A-Za-z\s]/;  
					var vname=document.vehmaintenanceform.vendorname.value;
				    if(vname=="") {}
				    if(invalid.test(vname))
				     {     
				         alert('vendor name must have characters only');  
				         return false;  
				      }  

				    if(isNaN(amount))
					{
						alert("Please Enter the valid amount");
					       return false;    

					}
					
				 	if(v5.length==0)
					{
						alert("Please Enter Alert Before Days");
				        return false;
					}
					else if(!(v5.match(numericExpressionn)))
				 	{
				 		alert("Please Enter Numeric value for Alert Before Days");
				        return false;
				 	}
				 	if(v12=="")
				 	{
				 		alert("Please Enter Atleast One Email Address");
				 		return false; 
				 	}

				 	
				 	if(v51.length>0)
				    {
				       alert("Alert For This Entry Already Present");
				       return false;   
				    }
				 	return datevalidate();
				}else
					if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="Yes" && npermit=="No" && tax=="No" && permit=="No"&& sparepart=="No")
					{
						if(v1=="Select")
					    {
					        alert("Please Select Vehicle");
					        return false;   
					    }
						if(v10==v11)
					 	{
					 		alert("Please Change Next Maintenance Date");
					 		return false; 
					 	}

						var invalid = /[^A-Za-z\s]/;  
						var vname=document.vehmaintenanceform.vendorname.value;
					    if(vname=="") {}
					    if(invalid.test(vname))
					     {     
					         alert('vendor name must have characters only');  
					         return false;  
					      }  

					    if(isNaN(amount))
						{
							alert("Please Enter the valid amount");
						       return false;    

						}
						
					 	if(v5.length==0)
						{
							alert("Please Enter Alert Before Days");
					        return false;
						}
						else if(!(v5.match(numericExpressionn)))
					 	{
					 		alert("Please Enter Numeric value for Alert Before Days");
					        return false;
					 	}
					 	if(v12=="")
					 	{
					 		alert("Please Enter Atleast One Email Address");
					 		return false; 
					 	}


					 	
					 	if(v51.length>0)
					    {
					       alert("Alert For This Entry Already Present");
					       return false;   
					    }
					 	return datevalidate();
					}else
						if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="Yes" && tax=="No" && permit=="No"&& sparepart=="No")
						{
							if(v1=="Select")
						    {
						        alert("Please Select Vehicle");
						        return false;   
						    }
							if(v10==v11)
						 	{
						 		alert("Please Change Next Maintenance Date");
						 		return false; 
						 	}

							var invalid = /[^A-Za-z\s]/;  
							var vname=document.vehmaintenanceform.vendorname.value;
						    if(vname=="") {}
						    if(invalid.test(vname))
						     {     
						         alert('vendor name must have characters only');  
						         return false;  
						      }  

						    if(isNaN(amount))
							{
								alert("Please Enter the valid amount");
							       return false;    

							}
							
						 	if(v5.length==0)
							{
								alert("Please Enter Alert Before Days");
						        return false;
							}
							else if(!(v5.match(numericExpressionn)))
						 	{
						 		alert("Please Enter Numeric value for Alert Before Days");
						        return false;
						 	}
						 	if(v12=="")
						 	{
						 		alert("Please Enter Atleast One Email Address");
						 		return false; 
						 	}

						 	
						 	if(v51.length>0)
						    {
						       alert("Alert For This Entry Already Present");
						       return false;   
						    }
						 	return datevalidate();
						}else
							if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="Yes" && permit=="No"&& sparepart=="No")
							{
								if(v1=="Select")
							    {
							        alert("Please Select Vehicle");
							        return false;   
							    }
								if(v10==v11)
							 	{
							 		alert("Please Change Next Maintenance Date");
							 		return false; 
							 	}

								var invalid = /[^A-Za-z\s]/;  
								var vname=document.vehmaintenanceform.vendorname.value;
							    if(vname=="") {}
							    if(invalid.test(vname))
							     {     
							         alert('vendor name must have characters only');  
							         return false;  
							      }  

							    if(isNaN(amount))
								{
									alert("Please Enter the valid amount");
								       return false;    

								}
								
							 	if(v5.length==0)
								{
									alert("Please Enter Alert Before Days");
							        return false;
								}
								else if(!(v5.match(numericExpressionn)))
							 	{
							 		alert("Please Enter Numeric value for Alert Before Days");
							        return false;
							 	}
							 	if(v12=="")
							 	{
							 		alert("Please Enter Atleast One Email Address");
							 		return false; 
							 	}

							 	
							 	if(v51.length>0)
							    {
							       alert("Alert For This Entry Already Present");
							       return false;  
							    }
							 	return datevalidate();
							}else



								if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No"&& permit=="Yes"&& sparepart=="No")
								{
									if(v1=="Select")
								    {
								        alert("Please Select Vehicle");
								        return false;   
								    }
									if(v10==v11)
								 	{
								 		alert("Please Change Next Maintenance Date");
								 		return false; 
								 	}

									var invalid = /[^A-Za-z\s]/;  
									var vname=document.vehmaintenanceform.vendorname.value;
								    if(vname=="") {}
								    if(invalid.test(vname))
								     {     
								         alert('vendor name must have characters only');  
								         return false;  
								      }  

								    if(isNaN(amount))
									{
										alert("Please Enter the valid amount");
									       return false;    

									}
									
								 	if(v5.length==0)
									{
										alert("Please Enter Alert Before Days");
								        return false;
									}
									else if(!(v5.match(numericExpressionn)))
								 	{
								 		alert("Please Enter Numeric value for Alert Before Days");
								        return false;
								 	}
								 	if(v12=="")
								 	{
								 		alert("Please Enter Atleast One Email Address");
								 		return false; 
								 	}

								 	
								 	if(v51.length>0)
								    {
								       alert("Alert For This Entry Already Present");
								       return false;  
								    }
								 	return datevalidate();
								}

								else

									if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No"&& permit=="No"&& sparepart=="Yes")
									{
										if(v1=="Select")
									    {
									        alert("Please Select Vehicle");
									        return false;   
									    }
										if(v10==v11)
									 	{
									 		alert("Please Change Next Maintenance Date");
									 		return false; 
									 	}


										var invalid = /[^A-Za-z\s]/;  
										var vname=document.vehmaintenanceform.vendorname.value;
									    if(vname=="") {}
									    if(invalid.test(vname))
									     {     
									         alert('vendor name must have characters only');  
									         return false;  
									      }  

									    if(isNaN(amount))
										{
											alert("Please Enter the valid amount");
										       return false;    

										}
										
									 	if(v5.length==0)
										{
											alert("Please Enter Alert Before Days");
									        return false;
										}
										else if(!(v5.match(numericExpressionn)))
									 	{
									 		alert("Please Enter Numeric value for Alert Before Days");
									        return false;
									 	}
									 	if(v12=="")
									 	{
									 		alert("Please Enter Atleast One Email Address");
									 		return false; 
									 	}

									 	
									 	if(v51.length>0)
									    {
									       alert("Alert For This Entry Already Present");
									       return false;  
									    }
									 	return datevalidate();
									}
									else
										if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No"&& permit=="No"&& sparepart=="No")
										{
											alert("Please select the maintaince type.");
											return false;
										}
	
									else
				{
					if(v1=="Select")
				      {
				         alert("Please Select Vehicle");
				         return false;   
				      }

				      if(v2=="Select")  
				      {
				          alert("Please Select Maintenance Type");
				          return false;   
				      }

				      if(showothothsertype=="Yes")
				      { 
				          var v21=document.vehmaintenanceform.othsertype.value;
				          
				         if(v21.length==0)
				         { 
				            alert("Please Enter New Maintenance Type");
				            return false;
				         }
				      }
				 	if(v3.length==0)
					{
						alert("Please Enter Maintenance Km");
				        return false;
					}
				 	else if(!(v3.match(numericExpressionn)))
				 	{
				 		alert("Please Enter Numeric value for Maintenance Km");
				        return false;
				 	 }
					if(v4.length==0)
					{
						alert("Please Enter Next Maintenance Km");
				        return false;
					}
					else if(!(v4.match(numericExpressionn)))
				 	{
				 		alert("Please Enter Numeric value for Next Maintenance Km");
				        return false;
				 	}



					var invalid = /[^A-Za-z\s]/;  
					var vname=document.vehmaintenanceform.vendorname.value;
				    if(vname=="") {}
				    if(invalid.test(vname))
				     {     
				         alert('vendor name must have characters only');  
				         return false;  
				      }  

				    if(isNaN(amount))
					{
						alert("Please Enter the valid amount");
					       return false;    

					}
				 	
					if(v5.length==0)
					{
						alert("Please Enter Alert Before Days");
				        return false;
					}
					else if(!(v5.match(numericExpressionn)))
				 	{
				 		alert("Please Enter Numeric value for Alert Before Days");
				        return false;
				 	}
				 	if(v10==v11)
				 	{
				 		alert("Please Change Next Maintenance Date");
				 		return false; 
				 	}
				 	if(v12=="")
				 	{
				 		alert("Please Enter Atleast One Email Address");
				 		return false; 
				 	}
				 	if(v51.length>0)
				    {
				       alert("Alert For This Entry Already Present");
				       return false;   
				    }
				 	return datevalidate();
				}
	return true; 
}

 function datevalidate()
 {
 	//alert("hiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
 	var date1=document.vehmaintenanceform.calender1.value;
 	var date2=document.vehmaintenanceform.calender.value;
 	var dm1,dd1,dy1,dm2,dd2,dy2;
 	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
 	dd11=date1.substring(0,2);
 	dd22=date2.substring(0,2);
 	mm1=date1.substring(3,6);
 	mm2=date2.substring(3,6);
 	mm11=dateformat(mm1);
 	mm22=dateformat(mm2);
 	yy11=date1.substring(7,11);
 	yy22=date2.substring(7,11);
 	
 	if(yy11 > yy22)
 	{
 		alert("Next Service Date should Be Greater Than Service Date");
 		
 		return false;
 	}
 	else if(yy11==yy22)
 	{
 		 if(mm11 > mm22)
 		{
 		alert("Next Service Date should Be Greater Than Service Date");
 		
 		return false;
 		}
 		 else if(mm11 == mm22)
 		 {
 			if(dd11 > dd22)
 	 		{
 	 			alert("Next Service Date should Be Greater Than Service Date");
 	 			
 	 			return false;
 	 		}
 	 	 }
 	}
 	
 	
 	return true;
}

 function dateformat(days)
	{
	//alert("Days-->"+days);
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
						if(days=='May')
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

function message()
{
alert("---------------------in funcction------");	

try{
 var m=document.getElementById("veh").value;
 var n=document.getElementById("ment").value;
 var p=document.getElementById("mentdt").value;
 var a=document.getElementById("mentkm").value;
 var b=document.getElementById("nxtmnt").value;
 var c=document.getElementById("altbfdt").value;
 var d=document.getElementById("etaddr").value;
 var e=document.getElementById("nxtmtaft").value;

 var f=document.getElementById("sertype").value;
 alert("===ssertype=======");
 


if(f=="Select" || f.contains("Select"))
{
	alert("Please select the type");
}
 

if(a==null || a=="" || a.contains("null") || a.contains(" ")){

alert("Please give some Km value  ");

	
}
if(b==null || b=="" || b.contains("null") || b.contains(" ")){

	alert("Please give some  value for next maintainance  Km   ");

		
	}

if(c==null || c=="" || c.contains("null") || c.contains(" ")){

	alert("Please give some value for alert before days   ");

		
	}


if(d==null || d=="" || d.contains("null") || d.contains(" "))
{

	alert("Please give some value for email field  ");		
	}
}catch(e){
	alert("1245>>>>>   "+e);
	// System.out.println("-------------exception in meassage----");
	
}
}

 
function funprsentser()
{
	//alert("in funpresentser function");
	var v6=document.vehmaintenanceform.vehicle.value;
	var v7=document.vehmaintenanceform.sertype.value;
	var v8=document.vehmaintenanceform.calender1.value;
	//alert("Selected veh-->"+v5);
	//var v8=dropdown.selectedIndex;
    //var SelValue1 = dropdown.options[v8].value;
    //alert(v7);
    if(v7=="Select")
	{
		document.getElementById("mntdte").style.display="";
	 	document.getElementById("nxtmntdte").style.display="";
	 	document.getElementById("mkm").style.display="";
	 	document.getElementById("nmaftrkm").style.display="";
	 	document.vehmaintenanceform.nxtserkm.value='';
	 	document.getElementById("abd").style.display="";


	 	document.getElementById("vname").style.display="";
	 	document.getElementById("amt").style.display="";
	 	document.getElementById("rcptno").style.display="";
	 	document.getElementById("doc").style.display="";
	 	
	 	preventive="No";
	 	oil="No";
	 	puc="No";
	 	insurance="No";
	 	fitness="No";
	 	npermit="No";
	 	tax="No";
	 	permit="No";
			sparepart="No";
  	}else
  	  	
  		if(v7=="Other")
  		{
  			document.getElementById("mntdte").style.display="";
		 	document.getElementById("nxtmntdte").style.display="";
		 	document.getElementById("mkm").style.display="";
		 	document.getElementById("nmaftrkm").style.display="";
		 	document.vehmaintenanceform.nxtserkm.value='';
		 	document.getElementById("abd").style.display="";


		 	document.getElementById("vname").style.display="";
		 		document.getElementById("amt").style.display="";
		 		document.getElementById("rcptno").style.display="";
		 		document.getElementById("doc").style.display="";

		 		
		 	preventive="No";
		 	oil="No";
		 	puc="No";
		 	insurance="No";
		 	fitness="No";
		 	npermit="No";
		 	tax="No";
		 	permit="No";
	 			sparepart="No";
	  	}else
		  		if(v7=="preventive")
  		  		{
  		  			document.getElementById("mntdte").style.display="";
  				 	document.getElementById("nxtmntdte").style.display='none';
  				 	document.getElementById("mkm").style.display="";
  				 	document.getElementById("nmaftrkm").style.display="";
  				 	document.vehmaintenanceform.nxtserkm.value='2000';
  				 	document.getElementById("abd").style.display='none';

  				 	document.getElementById("vname").style.display="";
				 		document.getElementById("amt").style.display="";
				 		document.getElementById("rcptno").style.display="";
				 		document.getElementById("doc").style.display="";

				 		
  					preventive="Yes";
  				 	oil="No";
  				 	puc="No";
  				 	insurance="No";
  				 	fitness="No";
  				 	npermit="No";
  				 	tax="No";
  				 	permit="No";
	 		 			sparepart="No";
  			  	}else 
  			  	      if(v7=="oil")
	  	  			{
	  			  		document.getElementById("mntdte").style.display="";
	  			 	 	document.getElementById("nxtmntdte").style.display="";
	  			 	 	document.getElementById("mkm").style.display="";
	  			 	 	document.getElementById("nmaftrkm").style.display="";
	  			 		document.vehmaintenanceform.nxtserkm.value='';
				 		document.getElementById("abd").style.display="";
				 		document.getElementById("vname").style.display="";
				 		document.getElementById("amt").style.display="";
				 		document.getElementById("rcptno").style.display="";
				 		document.getElementById("doc").style.display="";
	  			 	 	oil="Yes";
	  			 		preventive="No";
	  		 			puc="No";
	  		 			insurance="No";
	  		 			fitness="No";
	  		 			npermit="No";
	  		 			tax="No";
	  		 			permit="No";
 	 		 			sparepart="No";
	  		  		}else
	  					if(v7=="puc")
	  	  				{
	  	 					document.getElementById("mkm").style.display='none';
	  	 					document.getElementById("nmaftrkm").style.display='none';
	  	 	 				document.getElementById("mntdte").style.display="";
	  	 	 				document.getElementById("nxtmntdte").style.display="";
	  	 	 				document.vehmaintenanceform.nxtserkm.value='';
	  				 		document.getElementById("abd").style.display="";

	  				 		document.getElementById("vname").style.display="";
	  				 		document.getElementById("amt").style.display="";
	  				 		document.getElementById("rcptno").style.display="";
	  				 		document.getElementById("doc").style.display="";
	  				 		
	  	 	 				puc="Yes";
	  	 	 				preventive="No";
	  	 	 	 			oil="No";
			  	 	 	 	insurance="No";
			  	 		 	fitness="No";
			  		 		npermit="No";
			  		 		tax="No";
			  		 		permit="No";
	 	 		 			sparepart="No";
	  	  				}else
		  	  				if(v7=="insurance")
		  	  				{
		  	  					document.getElementById("mkm").style.display='none';
	  	 						document.getElementById("nmaftrkm").style.display='none';
	  	 	 					document.getElementById("mntdte").style.display="";
	  	 	 					document.getElementById("nxtmntdte").style.display="";
	  	 	 					document.vehmaintenanceform.nxtserkm.value='';
	  	  				 		document.getElementById("abd").style.display="";

	  	  				 	document.getElementById("vname").style.display="";
	  				 		document.getElementById("amt").style.display="";
	  				 		document.getElementById("rcptno").style.display="";
	  				 		document.getElementById("doc").style.display="";
	  				 		
	  	 	 					insurance="Yes";
	  	 	 					preventive="No";
	  	 	 		 			oil="No";
	  	 	 		 			puc="No";

	  	 	 		 		fitness="No";
	 	 		 				npermit="No";
	 	 		 				tax="No";
	 	 		 			permit="No";
	 	 		 			sparepart="No";
	  	 	 		 			
	  	 	 		 		}else
			  	  				if(v7=="npermit")
			  	  				{
			  	  					document.getElementById("mkm").style.display='none';
		  	 						document.getElementById("nmaftrkm").style.display='none';
		  	 	 					document.getElementById("mntdte").style.display="";
		  	 	 					document.getElementById("nxtmntdte").style.display="";
		  	 	 					document.vehmaintenanceform.nxtserkm.value='';
		  	  				 		document.getElementById("abd").style.display="";

		  	  				 	document.getElementById("vname").style.display="";
		  				 		document.getElementById("amt").style.display="";
		  				 		document.getElementById("rcptno").style.display="";
		  				 		document.getElementById("doc").style.display="";

		  				 		
		  	 	 					insurance="No";
		  	 	 					preventive="No";
		  	 	 		 			oil="No";
		  	 	 		 			puc="No";
		  	 	 		 			fitness="No";
	  	 	 		 				npermit="Yes";
	  	 	 		 				tax="No";
	  	 	 		 			permit="No";
	  	 	 		 			sparepart="No";
		  	 	 		 		}else
				  	  				if(v7=="tax")
				  	  				{
				  	  					document.getElementById("mkm").style.display='none';
			  	 						document.getElementById("nmaftrkm").style.display='none';
			  	 	 					document.getElementById("mntdte").style.display="";
			  	 	 					document.getElementById("nxtmntdte").style.display="";
			  	 	 					document.vehmaintenanceform.nxtserkm.value='';
			  	  				 		document.getElementById("abd").style.display="";

			  	  				 	document.getElementById("vname").style.display="";
			  				 		document.getElementById("amt").style.display="";
			  				 		document.getElementById("rcptno").style.display="";
			  				 		document.getElementById("doc").style.display="";

			  				 		
			  	 	 					insurance="No";
			  	 	 					preventive="No";
			  	 	 		 			oil="No";
			  	 	 		 			puc="No";
			  	 	 		 			fitness="No";
		  	 	 		 				npermit="No";
		  	 	 		 				tax="Yes";
		  	 	 		 			permit="No";
		  	 	 		 			sparepart="No";
			  	 	 		 		}else
					  	  				if(v7=="fitness")
					  	  				{
					  	  					document.getElementById("mkm").style.display='none';
				  	 						document.getElementById("nmaftrkm").style.display='none';
				  	 	 					document.getElementById("mntdte").style.display="";
				  	 	 					document.getElementById("nxtmntdte").style.display="";
				  	 	 					document.vehmaintenanceform.nxtserkm.value='';
				  	  				 		document.getElementById("abd").style.display="";

				  	  				 	document.getElementById("vname").style.display="";
				  				 		document.getElementById("amt").style.display="";
				  				 		document.getElementById("rcptno").style.display="";
				  				 		document.getElementById("doc").style.display="";
				  				 		
				  	 	 					insurance="No";
				  	 	 					preventive="No";
				  	 	 		 			oil="No";
				  	 	 		 			puc="No";
				  	 	 		 			fitness="Yes";
			  	 	 		 				npermit="No";
			  	 	 		 				tax="No";
			  	 	 		 			permit="No";
			  	 	 		 			sparepart="No";
				  	 	 		 		}
					  	  			else 
						  	  			if(v7=="permit")
				  	  				{
				  	  					document.getElementById("mkm").style.display='none';
			  	 						document.getElementById("nmaftrkm").style.display='none';
			  	 	 					document.getElementById("mntdte").style.display="";
			  	 	 					document.getElementById("nxtmntdte").style.display="";
			  	 	 					document.vehmaintenanceform.nxtserkm.value='';
			  	  				 		document.getElementById("abd").style.display="";
			  	  				 	document.getElementById("vname").style.display="";
			  	  				document.getElementById("amt").style.display="";
			  	  			document.getElementById("rcptno").style.display="";
			  	  		document.getElementById("doc").style.display="";
			  	 	 					insurance="No";
			  	 	 					preventive="No";
			  	 	 		 			oil="No";
			  	 	 		 			puc="No";
			  	 	 		 			fitness="No";
		  	 	 		 				npermit="No";
		  	 	 		 				tax="No";
		  	 	 		 			    permit="Yes";
		  	 	 		 			sparepart="No";
			  	 	 		 		}
				  	  			else 
					  	  			if(v7=="sparepart")
			  	  				{
			  	  					document.getElementById("mkm").style.display='none';
		  	 						document.getElementById("nmaftrkm").style.display='none';
		  	 	 					document.getElementById("mntdte").style.display="";
		  	 	 					document.getElementById("nxtmntdte").style.display="";
		  	 	 					document.vehmaintenanceform.nxtserkm.value='';
		  	  				 		document.getElementById("abd").style.display="";
		  	  				 	document.getElementById("vname").style.display="";
		  	  				document.getElementById("amt").style.display="";
		  	  			document.getElementById("rcptno").style.display="";
		  	  		document.getElementById("doc").style.display="";
		  	 	 					insurance="No";
		  	 	 					preventive="No";
		  	 	 		 			oil="No";
		  	 	 		 			puc="No";
		  	 	 		 			fitness="No";
	  	 	 		 				npermit="No";
	  	 	 		 				tax="No";
	  	 	 		 				permit="No";
	  	 	 		 			sparepart="Yes";
		  	 	 		 		}                       
	  	  				
  	  
			  		
   
    if(v7=="Other")
    {
        document.vehmaintenanceform.othsertype.style.display="";
        showothothsertype="Yes";
    }
    else 
   {
        document.vehmaintenanceform.othsertype.style.display="none";
        document.vehmaintenanceform.othsertype.value="";
        showothothsertype="No";
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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var resltt=ajaxRequest.responseText;
                       // alert(resltt);
                         var ress=resltt.split("#");
						var v10=ress[0];
                        // alert(ress[0]);
                       // alert(ress[2]);
                       // alert(ress[3]);
						//alert(v10);
						var v20=ress[2];
						var v21=ress[3];
						
						/*var dd11=date1.substring(0,4);
					 	dd22=date2.substring(0,2);
					 	mm1=date1.substring(3,6);
					 	mm2=date2.substring(3,6);
					 	mm11=dateformat(mm1);
					 	mm22=dateformat(mm2);
					 	yy11=date1.substring(7,11);
					 	yy22=date2.substring(7,11);*/
					 	//else   {
						document.vehmaintenanceform.serkm.value=ress[1];
					    //}
						if(v7=="puc")
						{
						document.vehmaintenanceform.calender.value=ress[2];
						}
						else
							if(v7=="insurance" || v7=="npermit" || v7=="tax" || v7=="fitness"|| v7=="permit" || v7=="sparepart")
							{
								document.vehmaintenanceform.calender.value=ress[3];
							}
							else
								if(v7=="oil" || v7=="Select" || v7=="Other")
								{
									document.vehmaintenanceform.calender.value=document.vehmaintenanceform.calender1.value;
								}
													
							
						if(v10.match("Yes"))
			             {
			              //  alert("Yesyes");
			             document.getElementById("presentalert").innerHTML="";
			             }	
						else
						{
							//alert("NOno");
							document.getElementById("presentalert").innerHTML="";
						}
						if(v6=="Select")
						{
							//alert("Setting Value");
					    	document.vehmaintenanceform.serkm.value='';
					    	//alert("End Setting Value");
					    }
		            } 
         	  }
             var queryString = "?veh="+v6+"&sertyp="+v7+"&date="+v8;
    	     ajaxRequest.open("GET", "vehmaintenanceAjax.jsp"+queryString, true);
	     ajaxRequest.send(null); 

}



</script>
</head>
<body id="main_body" >

	<%!
Connection con1;
%>

<img id="top" src="newimages/top.png" alt="" style="width: 600px;">
	
	<div id="form_container" style="width: 600px;">
	
		<h1 align="center"><a>Vehicle Maintainance Edit Module</a></h1>

	<% 
try {
	System.out.println("><><><><1111");
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
Statement stmt1=con1.createStatement();
ResultSet rs2=null, rs3=null, rs4=null, rs5=null,rs33=null;
String sql2="", sql3="", sql4="", sql5="",sql33="";
String vehno="", prvdid="",lastdriverid="", lastdrivername="";

//vehno=request.getParameter("vehno");
System.out.println("><><><><222");



String user=session.getValue("usertypevalue").toString();
System.out.println("><><><><5555");
String vehregnor=request.getParameter("vehregno");
String vehcoder=request.getParameter("vid");
String servicekm=request.getParameter("srvkm");
String nextsrvkm=request.getParameter("nxtsrvkm");

String servicedater=request.getParameter("servicedate");
String servicetyper=request.getParameter("servicetype");
String servicename=request.getParameter("srvname");
String nxtservicedate=request.getParameter("nxtsrvdate");
String alertdate=request.getParameter("altdate");
String vendorname=request.getParameter("vendorname");
String amount=request.getParameter("amount");
String recieptno=request.getParameter("recieptno");
String docid=request.getParameter("docid");

String entereddate=request.getParameter("entdate");






System.out.println("><><><><......1");
String servicedater1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(servicedater));
String servicedater2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(servicedater));
System.out.println("><><><><......2");
String alertdays=request.getParameter("alertdays");
String nextdate=request.getParameter("nextdate");
System.out.println("><><><><......3");
String nextservicedater2="-";
String nextservicedater1="-";

if(nextdate==null || nextdate==""|| nextdate.contains("null") || nextdate.contains(""))
{
	nextservicedater2="-";
	nextservicedater1="-";
	}
else{
	
	nextservicedater2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("dd-MM-yyyy").parse(nextdate));
	 nextservicedater1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(nextdate));
}





String email=request.getParameter("email");

System.out.println("><><><><9999");
System.out.println("vehregnor==>"+vehregnor);
System.out.println("vehcoder==>"+vehcoder);
System.out.println("servicedater1==>"+servicedater1);
System.out.println("servicename==>"+servicename);
System.out.println("servicedater2==>"+servicedater2);
System.out.println("nextservicedater==>"+nxtservicedate);
System.out.println("alertdate==>"+alertdate);
System.out.println("entdate==>"+entereddate);
System.out.println("servicetyper==>"+servicetyper);

System.out.println("><><><>vehiclecode......."+vehcoder);

java.util.Date d=new java.util.Date();
//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());



System.out.println("><><><><2122");
 //java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
  // Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   
%>
	

		
<form name="vehmaintenanceform" class="appnitro" enctype="multipart/form-data" method="get" action="EditVehMeantUpdate.jsp" onSubmit="return validate();">
        <div class="form_container" style="text-align: center;">
         <div style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;">
         <table border="0" width="100%">
         <tr align="center">
          <td align="center">
          
          <table border="0" width="90%" align="center">
		<tr>
			<td><div align="left"><a href="javascript:history.go(-1)"> <img src="images/arrow.bmp" width="20px" height="20px" border="0"> </a></div>
			</td>
		</tr>
         
		
				<tr >
					<td><font  size="2">*Vehicle:</font></td>
					
					<td ><b><%=vehregnor%></b><input type="hidden" name="vehicle" id="vehicle" class="element text medium" style="border: 0px solid #000000;" value="<%=vehregnor%>" readonly="readonly"></input>
					 </td>
					   
				</tr>
				<%
				System.out.println("><><><><2122");
			    String distance="";
				String	sql="select Distance from t_veh"+vehcoder+" where TheFieldDataDate <='"+servicedater1+"' and TheFiledTextFileName='SI' order by TheFieldDataDate desc limit 1";
				
			
				//System.out.println(sql);
				try
				{
				ResultSet md=stmt1.executeQuery(sql);
				if(rs2.next())
				{
					distance=md.getString("Distance");
					//transporter=rs1.getString("OwnerName");
				}
				}catch(Exception e)
				{
					
				}
				
				%>
				<tr >
					<td><font  size="2">*Maintenance Type:</font></td>
					<td><select name="sertype" id="sertype" class="element select medium" style="width: 180px;" onchange="funprsentser();">
						<option value="Select">Select</option>
						
						
							
						<% 
						//System.out.println("><><><><1111");
						if(servicetyper=="preventive" || servicetyper.equalsIgnoreCase("preventive"))
						{%>
							
							
							<option value="preventive" selected>Preventive Maintenance</option>
							
					   <% }else{
						  
						   %>
						   <option value="preventive" >Preventive Maintenance</option>
					   <% }
						
						%>
						
						<% 
						if(servicetyper=="oil" || servicetyper.equalsIgnoreCase("oil") )
						{%>
							
							
							<option value="oil" selected>Engine Oil Change/Hub Greasing</option>
							
					   <% }else{
						  
						   %>
						   <option value="oil" >Engine Oil Change/Hub Greasing</option>
					   <% }
						
						%>
						
						<% 
						if(servicetyper=="puc" || servicetyper.equalsIgnoreCase("puc"))
						{%>
							
							
							<option value="puc" selected>PUC</option>
							
					   <% }else{
						  
						   %>
						   <option value="puc" >PUC</option>
					   <% }
						
						%>
						
						<% 
						if(servicetyper=="insurance" || servicetyper.equalsIgnoreCase("insurance") )
						{%>
							
							
							<option value="insurance" selected>Vehicle Insurance</option>
							
					   <% }else{
						  
						   %>
						   <option value="insurance" >Vehicle Insurance</option>
					   <% }
						
						%>
						
						
						<% 
						if(servicetyper=="npermit" || servicetyper.equalsIgnoreCase("npermit"))
						{%>
							
							
							<option value="npermit" selected>National Permit</option>
							
					   <% }else{
						  
						   %>
						   <option value="npermit" >National Permit</option>
					   <% }
						
						%>
						
						
						<% 
						if(servicetyper=="tax" || servicetyper.equalsIgnoreCase("tax"))
						{%>
							
							
							<option value="tax" selected>Tax</option>
							
					   <% }else{
						  
						   %>
						   <option value="tax" >Tax</option>
					   <% }
						
						%>
						
						<% 
						if(servicetyper=="fitness" || servicetyper.equalsIgnoreCase("fitness"))
						{%>
							
							
							<option value="fitness" selected>Vehicle Fitness</option>
							
					   <% }else{
						  
						   %>
						   <option value="fitness" >Vehicle Fitness</option>
					   <% }
						
						%>
						
						
						<% 
						if(servicetyper=="permit" || servicetyper.equalsIgnoreCase("permit"))
						{%>
							
							
							<option value="permit" selected>Permit Five Years</option>
							
					   <% }else{
						  
						   %>
						   <option value="permit" >Permit Five Years</option>
					   <% }
						
						%>
						
						
						<% 
						if(servicetyper=="sparepart" || servicetyper.equalsIgnoreCase("sparepart"))
						{%>
							
							
							<option value="sparepart" selected>Spare Part Repairing</option>
							
					   <% }else{
						  
						   %>
						   <option value="sparepart" >Spare Part Repairing</option>
					   <% }
						
						%>
						
						
						
						
						<input type="hidden" name="service_name" value="<%=servicename %>"></input>
						<input type="hidden" name="nextservicedate1" value=<%=nxtservicedate %>></input>
						<input type="hidden" name="nextservicedate2" value=<%=nextservicedater2 %>></input>
						<input type="hidden" name="alertdate1" value=<%=alertdate %>></input>
						<input type="hidden" name="entereddate1" value=<%=entereddate %>></input>
						<input type="hidden" name="service_type" value=<%=servicetyper %>></input>
						<input type="hidden" name="service_date" value=<%=servicedater %>></input>
						<input type="hidden" name="service_date1" value=<%=servicedater1 %>></input>
						<input type="hidden" name="vehicle_code" value=<%=vehcoder %>></input>
						<input type="hidden" name="service_date22" value=<%=servicedater2 %>></input>
						<input type="hidden" name="service_km" value=<%=servicekm %>></input>
						<input type="hidden" name="service_nxtsrv" value=<%=nextsrvkm %>></input>
						
						<input type="hidden" name="vendor" value=<%=vendorname %>></input>
						<input type="hidden" name="amnt" value=<%=amount %>></input>
						<input type="hidden" name="recptno" value=<%=recieptno %>></input>
						<input type="hidden" name="documentid" value=<%=docid %>></input>
						
						
						
						<%/*    
						sql2="select Distinct(ServiceType) from t_lastservice order by ServiceType";
				 		rs2=stmt1.executeQuery(sql2);nxtservicedate
				 		while(rs2.next())
        				{*/
				 %>
						<!--<option value="<  %=rs2.getString("ServiceType")%>">< %=rs2.getString("ServiceType")%></option>-->
						<%     
				 		//}
				 %>
						<!--<option value="Other">Other </option>-->
					</select> &nbsp;&nbsp;&nbsp; <input type="text" name="othsertype"
						style="visibility: hidden" />
					<div id="presentalert"></div>
					</td>

				</tr>

				<tr  id="mntdte">
					<td><font  size="2">*Maintenance Date: </font></td>
					<td><input type="text" id="calender1" name="calender1"
						class="element text medium" size="13" class="element text medium"  value="<%=servicedater2%>" onblur="funprsentser();" readonly />

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
					<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
					<script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender1"       // ID of the button
             }
                           );
             </script></td>
				</tr>

				<tr  id="mkm">
					<td><font  size="2">*Maintenance Km:</font></td>
					<td><input type="text" name="serkm" class="element text medium" value="<%=servicekm%>" id="serkm" />Kms.
					&nbsp;</td>
				</tr>

				<tr  id="nxtmntdte">
					<td><font  size="2">*Next Maintenance Date:</font></td>
					<td><input type="text" id="calender" name="calender" class="element text medium" size="13" value="<%=nextservicedater2%>" readonly />

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
					<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
					<script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender"       // ID of the button
             }
                           );
             </script></td>
				</tr>

				<tr  id="nmaftrkm">
					<td><font  size="2">*Next Maintenance After:</font></td>
					<td><input type="text" name="nxtserkm" class="element text medium" value="<%= nextsrvkm %>" id="nxtserkm" />Kms.
					&nbsp;</td>
				</tr>
						
						
					<tr id="vname">
           <td><font  size="2">&nbsp;Vendor Name:</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="vendorname" value="<%=vendorname %>" id="vendorname"/>&nbsp;</td>
           </tr>
		
		<tr><td></td></tr>
		
		<tr id="amt">
           <td><font  size="2">&nbsp;Amount:</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="amount"  value="<%=amount %>" id="amount"/>&nbsp;</td>
           </tr>
	        
	    <tr><td></td></tr>    
	        
	      <tr id="rcptno">
           <td><font  size="2">&nbsp;Reciept No:</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="recieptno"  value="<%=recieptno %>" id="recieptno"/>&nbsp;</td>
           </tr> 
           
           
           <tr><td></td></tr>
           
           
           <tr id="doc">
           <td><font  size="2">&nbsp;Document ID:</font></td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="docid"  value="<%=docid %>" id="docid"/>&nbsp;</td>
           </tr>  	
						
						
						
						
							
				<tr  id="abd">
					<td><font  size="2">*Alert Before Days:</font></td>
					<td><input type="text" name="days" class="element text medium" value="<%=alertdays%>" id="days" />Days.
					&nbsp;</td>
				</tr>
				<tr  id="mail">
					<td><font size="2">*Email To Address:</font></td>
					<td><input type="text" name="emailto"  class="element text medium" style="width: 180px;" value="<%=email%>" id="emailto" /><div>(Enter Comma Seperated Mail ID )</div>
					<input  type="hidden" name="servicedaterp" value="<%=servicedater1%>"></input>
					<input  type="hidden" name="servicetyperp" value="<%=servicetyper%>"></input>
					
					</td>
				</tr>
				<!--*************-->


                <tr><td></td></tr>

				<tr >
					<td colspan="2" align="center">
					<div align="center"><input type="submit" name="submit"
						class="button_text" style="border-style: outset; border-color: black" id="submit" value="submit" ></div>
					</td>
				</tr>


			</table>
			</table>
			</td></tr>
			</table>
			</div>
			</div>
			</form>
			</td>
		</tr>
	</table>
	<script>
	funprsentser();
	</script>


</div>
	<img id="bottom" src="newimages/bottom.png" alt="">

	<% } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
	<% //fleetview.closeConnection(); %>
</jsp:useBean>
<%@ include file="footernew.jsp"%>


</body>
</html>

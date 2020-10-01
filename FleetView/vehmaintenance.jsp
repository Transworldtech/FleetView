 <%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vehicle Master Entry</title>
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
 var sparepart="No";
 var eng="No";
 var chasis="No";
 var radiator="No";
 var frontaxle="No";
 var frontaxle="No";
 var clutch="No";
 var gearbox="No";
 var diffrential="No";
 var pto="No";
 var apt="No";
 var vaccum="No";
 var suction="No";
 var jetting="No";
 var electpanel="No";
 var hyd="No";
 var hydcyl="No";
 var airpipe="No";
 var fitting="No";
 var airfilter="No";
 var hydcyl="No";
 var airpipe="No";
 var fitting="No";
 var cabin="No";
 var profshaft="No";
 var fuellines="No";
 var oil1="No";
 
 
 
 
 
 
 
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

	if(preventive=="Yes" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No")
	{
		if(v1=="Select")
	    {
	        alert("Please Select Vehicle");
	        return false;   
	    }
		
		
		var invalid = /[^A-Za-z\s.]/;  
		var vname=document.vehmaintenanceform.vendorname.value;
	    if(vname=="") {}
	    if(invalid.test(vname))
	     {     
	         alert('Vendor name must have characters only');  
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
		var n1=v12.indexOf("@");
		var n2=v12.lastIndexOf(".");
		if(n1<1 || n2-n1<2)
		{
			alert("Please Enter Valid Email Address");
		return false;
		
		}
		if(v51.length>0)
	    {
	       alert("Alert For This Entry Already Present");
	       return false;   
	    }
		return datevalidate();
		



		
		
	}else
		if(preventive=="No" && oil=="Yes" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No")
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
		      if(v10==v11)
			 	{
			 		alert("Please Change Next Maintenance Date");
			 		return false; 
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
		 	var n1=v12.indexOf("@");
			var n2=v12.lastIndexOf(".");
			if(n1<1 || n2-n1<2)
			{
				alert("Please Enter Valid Email Address");
			return false;
			
			}


            
		 	var invalid = /[^A-Za-z\s.]/;  
			var vname=document.vehmaintenanceform.vendorname.value;
		    if(vname=="") {}
		    if(invalid.test(vname))
		     {     
		         alert('Vendor name must have characters only');  
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
			if(preventive=="No" && oil=="No" && puc=="Yes" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No")
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
				 
				if(v10==v11)
			 	{
			 		alert("Please Change Next Maintenance Date");
			 		return false; 
			 	}


				var invalid = /[^A-Za-z\s.]/;  
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
			 	var n1=v12.indexOf("@");
				var n2=v12.lastIndexOf(".");
				if(n1<1 || n2-n1<2)
				{
					alert("Please Enter Valid Email Address");
				return false;
				
				}
			 	

			 	
			      
			 	if(v51.length>0)
			    {
			       alert("Alert For This Entry Already Present");
			       return false;   
			    }
			 	return datevalidate();

			 	

			 	
			}else
				if(preventive=="No" && oil=="No" && puc=="No" && insurance=="Yes" && fitness=="No" && npermit=="No" && tax=="No")
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
				 	var n1=v12.indexOf("@");
					var n2=v12.lastIndexOf(".");
					if(n1<1 || n2-n1<2)
					{
						alert("Please Enter Valid Email Address");
					return false;
					
					}

				 	var invalid = /[^A-Za-z\s.]/;  
					var vname=document.vehmaintenanceform.vendorname.value;
				    if(vname=="") {}
				    if(invalid.test(vname))
				     {     
				         alert('Vendor name must have characters only');  
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
					if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="Yes" && npermit=="No" && tax=="No")
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
					 	var n1=v12.indexOf("@");
						var n2=v12.lastIndexOf(".");
						if(n1<1 || n2-n1<2)
						{
							alert("Please Enter Valid Email Address");
						return false;
						
						}
					 	
					 	
					 	var invalid = /[^A-Za-z\s.]/;  
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
						if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="Yes" && tax=="No")
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
						 	var n1=v12.indexOf("@");
							var n2=v12.lastIndexOf(".");
							if(n1<1 || n2-n1<2)
							{
								alert("Please Enter Valid Email Address");
							return false;
							
							}
							
						 	var invalid = /[^A-Za-z\s.]/;  
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
							if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="Yes")
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
							 	var n1=v12.indexOf("@");
								var n2=v12.lastIndexOf(".");
								if(n1<1 || n2-n1<2)
								{
									alert("Please Enter Valid Email Address");
								return false;
								
								}                  

							 	var invalid = /[^A-Za-z\s.]/;  
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


							 	
							 	
							}
							
							else
								if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && eng=="Yes")
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
									if(v10==v11)
								 	{
								 		alert("Please Change Next Maintenance Date");
								 		return false; 
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
								 	var n1=v12.indexOf("@");
									var n2=v12.lastIndexOf(".");
									if(n1<1 || n2-n1<2)
									{
										alert("Please Enter Valid Email Address");
									return false;
									
									}                  

								 	var invalid = /[^A-Za-z\s.]/;  
									var vname=document.vehmaintenanceform.vendorname.value;
								    if(vname=="") {}
								    if(invalid.test(vname))
								     {     
								         alert('Vendor name must have characters only');  
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
							
							
							
							
							
							
								}
								else
									if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && chasis=="Yes")
									{
										if(v1=="Select")
									    {
									        alert("Please Select Vehicle chasisi");
									        return false;   
									    }
										 if(v2=="Select")  
									      {
									          alert("Please Select Maintenance Type");
									          return false;   
									      }
										if(v10==v11)
									 	{
									 		alert("Please Change Next Maintenance Date");
									 		return false; 
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
									 	var n1=v12.indexOf("@");
										var n2=v12.lastIndexOf(".");
										if(n1<1 || n2-n1<2)
										{
											alert("Please Enter Valid Email Address");
										return false;
										
										}                  

									 	var invalid = /[^A-Za-z\s.]/;  
										var vname=document.vehmaintenanceform.vendorname.value;
									    if(vname=="") {}
									    if(invalid.test(vname))
									     {     
									         alert('Vendor name must have characters only');  
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
								
								
								
								
								
								
									}
									else
										if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && radiator=="Yes")
										{
											if(v1=="Select")
										    {
										        alert("Please Select Vehicle chasisi");
										        return false;   
										    }
											 if(v2=="Select")  
										      {
										          alert("Please Select Maintenance Type");
										          return false;   
										      }
											if(v10==v11)
										 	{
										 		alert("Please Change Next Maintenance Date");
										 		return false; 
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
										 	var n1=v12.indexOf("@");
											var n2=v12.lastIndexOf(".");
											if(n1<1 || n2-n1<2)
											{
												alert("Please Enter Valid Email Address");
											return false;
											
											}                  

										 	var invalid = /[^A-Za-z\s.]/;  
											var vname=document.vehmaintenanceform.vendorname.value;
										    if(vname=="") {}
										    if(invalid.test(vname))
										     {     
										         alert('Vendor name must have characters only');  
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
									
									
									
									
									
									
										}
										else
											if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && frontaxle=="Yes")
											{
												if(v1=="Select")
											    {
											        alert("Please Select Vehicle chasisi");
											        return false;   
											    }
												 if(v2=="Select")  
											      {
											          alert("Please Select Maintenance Type");
											          return false;   
											      }
												if(v10==v11)
											 	{
											 		alert("Please Change Next Maintenance Date");
											 		return false; 
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
											 	var n1=v12.indexOf("@");
												var n2=v12.lastIndexOf(".");
												if(n1<1 || n2-n1<2)
												{
													alert("Please Enter Valid Email Address");
												return false;
												
												}                  

											 	var invalid = /[^A-Za-z\s.]/;  
												var vname=document.vehmaintenanceform.vendorname.value;
											    if(vname=="") {}
											    if(invalid.test(vname))
											     {     
											         alert('Vendor name must have characters only');  
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
										
										
										
										
										
										
											}
											else
												if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && clutch=="Yes")
												{
													if(v1=="Select")
												    {
												        alert("Please Select Vehicle chasisi");
												        return false;   
												    }
													 if(v2=="Select")  
												      {
												          alert("Please Select Maintenance Type");
												          return false;   
												      }
													if(v10==v11)
												 	{
												 		alert("Please Change Next Maintenance Date");
												 		return false; 
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
												 	var n1=v12.indexOf("@");
													var n2=v12.lastIndexOf(".");
													if(n1<1 || n2-n1<2)
													{
														alert("Please Enter Valid Email Address");
													return false;
													
													}                  

												 	var invalid = /[^A-Za-z\s.]/;  
													var vname=document.vehmaintenanceform.vendorname.value;
												    if(vname=="") {}
												    if(invalid.test(vname))
												     {     
												         alert('Vendor name must have characters only');  
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
											
											
											
											
											
											
												}
												else
													if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && gearbox=="Yes")
													{
														if(v1=="Select")
													    {
													        alert("Please Select Vehicle chasisi");
													        return false;   
													    }
														 if(v2=="Select")  
													      {
													          alert("Please Select Maintenance Type");
													          return false;   
													      }
														if(v10==v11)
													 	{
													 		alert("Please Change Next Maintenance Date");
													 		return false; 
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
													 	var n1=v12.indexOf("@");
														var n2=v12.lastIndexOf(".");
														if(n1<1 || n2-n1<2)
														{
															alert("Please Enter Valid Email Address");
														return false;
														
														}                  

													 	var invalid = /[^A-Za-z\s.]/;  
														var vname=document.vehmaintenanceform.vendorname.value;
													    if(vname=="") {}
													    if(invalid.test(vname))
													     {     
													         alert('Vendor name must have characters only');  
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
												
												
												
												
												
												
													}
													else
														if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && diffrential=="Yes")
														{
															if(v1=="Select")
														    {
														        alert("Please Select Vehicle chasisi");
														        return false;   
														    }
															 if(v2=="Select")  
														      {
														          alert("Please Select Maintenance Type");
														          return false;   
														      }
															if(v10==v11)
														 	{
														 		alert("Please Change Next Maintenance Date");
														 		return false; 
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
														 	var n1=v12.indexOf("@");
															var n2=v12.lastIndexOf(".");
															if(n1<1 || n2-n1<2)
															{
																alert("Please Enter Valid Email Address");
															return false;
															
															}                  

														 	var invalid = /[^A-Za-z\s.]/;  
															var vname=document.vehmaintenanceform.vendorname.value;
														    if(vname=="") {}
														    if(invalid.test(vname))
														     {     
														         alert('Vendor name must have characters only');  
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
													
													
													
													
													
													
														}
	
														else
															if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && pto=="Yes")
															{
																if(v1=="Select")
															    {
															        alert("Please Select Vehicle chasisi");
															        return false;   
															    }
																 if(v2=="Select")  
															      {
															          alert("Please Select Maintenance Type");
															          return false;   
															      }
																if(v10==v11)
															 	{
															 		alert("Please Change Next Maintenance Date");
															 		return false; 
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
															 	var n1=v12.indexOf("@");
																var n2=v12.lastIndexOf(".");
																if(n1<1 || n2-n1<2)
																{
																	alert("Please Enter Valid Email Address");
																return false;
																
																}                  

															 	var invalid = /[^A-Za-z\s.]/;  
																var vname=document.vehmaintenanceform.vendorname.value;
															    if(vname=="") {}
															    if(invalid.test(vname))
															     {     
															         alert('Vendor name must have characters only');  
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
														
														
														
														
														
														
															}
															else
																if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && apt=="Yes")
																{
																	if(v1=="Select")
																    {
																        alert("Please Select Vehicle chasisi");
																        return false;   
																    }
																	 if(v2=="Select")  
																      {
																          alert("Please Select Maintenance Type");
																          return false;   
																      }
																	if(v10==v11)
																 	{
																 		alert("Please Change Next Maintenance Date");
																 		return false; 
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
																 	var n1=v12.indexOf("@");
																	var n2=v12.lastIndexOf(".");
																	if(n1<1 || n2-n1<2)
																	{
																		alert("Please Enter Valid Email Address");
																	return false;
																	
																	}                  

																 	var invalid = /[^A-Za-z\s.]/;  
																	var vname=document.vehmaintenanceform.vendorname.value;
																    if(vname=="") {}
																    if(invalid.test(vname))
																     {     
																         alert('Vendor name must have characters only');  
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
															
															
															
															
															
															
																}
														 else
																	if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && vaccum=="Yes")
																	{
																		if(v1=="Select")
																	    {
																	        alert("Please Select Vehicle chasisi");
																	        return false;   
																	    }
																		 if(v2=="Select")  
																	      {
																	          alert("Please Select Maintenance Type");
																	          return false;   
																	      }
																		if(v10==v11)
																	 	{
																	 		alert("Please Change Next Maintenance Date");
																	 		return false; 
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
																	 	var n1=v12.indexOf("@");
																		var n2=v12.lastIndexOf(".");
																		if(n1<1 || n2-n1<2)
																		{
																			alert("Please Enter Valid Email Address");
																		return false;
																		
																		}                  

																	 	var invalid = /[^A-Za-z\s.]/;  
																		var vname=document.vehmaintenanceform.vendorname.value;
																	    if(vname=="") {}
																	    if(invalid.test(vname))
																	     {     
																	         alert('Vendor name must have characters only');  
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
																
																
																
																
																
																
																	}
																	else
																		if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && suction=="Yes")
																		{
																			if(v1=="Select")
																		    {
																		        alert("Please Select Vehicle chasisi");
																		        return false;   
																		    }
																			 if(v2=="Select")  
																		      {
																		          alert("Please Select Maintenance Type");
																		          return false;   
																		      }
																			if(v10==v11)
																		 	{
																		 		alert("Please Change Next Maintenance Date");
																		 		return false; 
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
																		 	var n1=v12.indexOf("@");
																			var n2=v12.lastIndexOf(".");
																			if(n1<1 || n2-n1<2)
																			{
																				alert("Please Enter Valid Email Address");
																			return false;
																			
																			}                  

																		 	var invalid = /[^A-Za-z\s.]/;  
																			var vname=document.vehmaintenanceform.vendorname.value;
																		    if(vname=="") {}
																		    if(invalid.test(vname))
																		     {     
																		         alert('Vendor name must have characters only');  
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
																	
																	
																	
																	
																	
																	
																		}
																		else
																			if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && jetting=="Yes")
																			{
																				if(v1=="Select")
																			    {
																			        alert("Please Select Vehicle chasisi");
																			        return false;   
																			    }
																				 if(v2=="Select")  
																			      {
																			          alert("Please Select Maintenance Type");
																			          return false;   
																			      }
																				if(v10==v11)
																			 	{
																			 		alert("Please Change Next Maintenance Date");
																			 		return false; 
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
																			 	var n1=v12.indexOf("@");
																				var n2=v12.lastIndexOf(".");
																				if(n1<1 || n2-n1<2)
																				{
																					alert("Please Enter Valid Email Address");
																				return false;
																				
																				}                  

																			 	var invalid = /[^A-Za-z\s.]/;  
																				var vname=document.vehmaintenanceform.vendorname.value;
																			    if(vname=="") {}
																			    if(invalid.test(vname))
																			     {     
																			         alert('Vendor name must have characters only');  
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
																		
																		
																		
																		
																		
																		
																			}
						
																			else
																				if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && electpanel=="Yes")
																				{
																					if(v1=="Select")
																				    {
																				        alert("Please Select Vehicle chasisi");
																				        return false;   
																				    }
																					 if(v2=="Select")  
																				      {
																				          alert("Please Select Maintenance Type");
																				          return false;   
																				      }
																					if(v10==v11)
																				 	{
																				 		alert("Please Change Next Maintenance Date");
																				 		return false; 
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
																				 	var n1=v12.indexOf("@");
																					var n2=v12.lastIndexOf(".");
																					if(n1<1 || n2-n1<2)
																					{
																						alert("Please Enter Valid Email Address");
																					return false;
																					
																					}                  

																				 	var invalid = /[^A-Za-z\s.]/;  
																					var vname=document.vehmaintenanceform.vendorname.value;
																				    if(vname=="") {}
																				    if(invalid.test(vname))
																				     {     
																				         alert('Vendor name must have characters only');  
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
																			
																			
																			
																			
																			
																			
																				}
																				else
																					if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && hyd=="Yes")
																					{
																						if(v1=="Select")
																					    {
																					        alert("Please Select Vehicle chasisi");
																					        return false;   
																					    }
																						 if(v2=="Select")  
																					      {
																					          alert("Please Select Maintenance Type");
																					          return false;   
																					      }
																						if(v10==v11)
																					 	{
																					 		alert("Please Change Next Maintenance Date");
																					 		return false; 
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
																					 	var n1=v12.indexOf("@");
																						var n2=v12.lastIndexOf(".");
																						if(n1<1 || n2-n1<2)
																						{
																							alert("Please Enter Valid Email Address");
																						return false;
																						
																						}                  

																					 	var invalid = /[^A-Za-z\s.]/;  
																						var vname=document.vehmaintenanceform.vendorname.value;
																					    if(vname=="") {}
																					    if(invalid.test(vname))
																					     {     
																					         alert('Vendor name must have characters only');  
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
																				
																				
																				
																				
																				
																				
																					}
																					else
																						if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && hydcyl=="Yes")
																						{
																							if(v1=="Select")
																						    {
																						        alert("Please Select Vehicle chasisi");
																						        return false;   
																						    }
																							 if(v2=="Select")  
																						      {
																						          alert("Please Select Maintenance Type");
																						          return false;   
																						      }
																							if(v10==v11)
																						 	{
																						 		alert("Please Change Next Maintenance Date");
																						 		return false; 
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
																						 	var n1=v12.indexOf("@");
																							var n2=v12.lastIndexOf(".");
																							if(n1<1 || n2-n1<2)
																							{
																								alert("Please Enter Valid Email Address");
																							return false;
																							
																							}                  

																						 	var invalid = /[^A-Za-z\s.]/;  
																							var vname=document.vehmaintenanceform.vendorname.value;
																						    if(vname=="") {}
																						    if(invalid.test(vname))
																						     {     
																						         alert('Vendor name must have characters only');  
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
																					
																					
																					
																					
																					
																					
																						}
																						else
																							if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && airpipe=="Yes")
																							{
																								if(v1=="Select")
																							    {
																							        alert("Please Select Vehicle chasisi");
																							        return false;   
																							    }
																								 if(v2=="Select")  
																							      {
																							          alert("Please Select Maintenance Type");
																							          return false;   
																							      }
																								if(v10==v11)
																							 	{
																							 		alert("Please Change Next Maintenance Date");
																							 		return false; 
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
																							 	var n1=v12.indexOf("@");
																								var n2=v12.lastIndexOf(".");
																								if(n1<1 || n2-n1<2)
																								{
																									alert("Please Enter Valid Email Address");
																								return false;
																								
																								}                  

																							 	var invalid = /[^A-Za-z\s.]/;  
																								var vname=document.vehmaintenanceform.vendorname.value;
																							    if(vname=="") {}
																							    if(invalid.test(vname))
																							     {     
																							         alert('Vendor name must have characters only');  
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
																						
																						
																						
																						
																						
																						
																							}
																							else
																								if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && fitting=="Yes")
																								{
																									if(v1=="Select")
																								    {
																								        alert("Please Select Vehicle chasisi");
																								        return false;   
																								    }
																									 if(v2=="Select")  
																								      {
																								          alert("Please Select Maintenance Type");
																								          return false;   
																								      }
																									if(v10==v11)
																								 	{
																								 		alert("Please Change Next Maintenance Date");
																								 		return false; 
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
																								 	var n1=v12.indexOf("@");
																									var n2=v12.lastIndexOf(".");
																									if(n1<1 || n2-n1<2)
																									{
																										alert("Please Enter Valid Email Address");
																									return false;
																									
																									}                  

																								 	var invalid = /[^A-Za-z\s.]/;  
																									var vname=document.vehmaintenanceform.vendorname.value;
																								    if(vname=="") {}
																								    if(invalid.test(vname))
																								     {     
																								         alert('Vendor name must have characters only');  
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
																							
																							
																							
																							
																							
																							
																								}
																								else
																									if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && airfilter=="Yes")
																									{
																										if(v1=="Select")
																									    {
																									        alert("Please Select Vehicle chasisi");
																									        return false;   
																									    }
																										 if(v2=="Select")  
																									      {
																									          alert("Please Select Maintenance Type");
																									          return false;   
																									      }
																										if(v10==v11)
																									 	{
																									 		alert("Please Change Next Maintenance Date");
																									 		return false; 
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
																									 	var n1=v12.indexOf("@");
																										var n2=v12.lastIndexOf(".");
																										if(n1<1 || n2-n1<2)
																										{
																											alert("Please Enter Valid Email Address");
																										return false;
																										
																										}                  

																									 	var invalid = /[^A-Za-z\s.]/;  
																										var vname=document.vehmaintenanceform.vendorname.value;
																									    if(vname=="") {}
																									    if(invalid.test(vname))
																									     {     
																									         alert('Vendor name must have characters only');  
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
																								
																								
																								
																								
																								
																								
																									}
																									else
																										if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && cabin=="Yes")
																										{
																											if(v1=="Select")
																										    {
																										        alert("Please Select Vehicle chasisi");
																										        return false;   
																										    }
																											 if(v2=="Select")  
																										      {
																										          alert("Please Select Maintenance Type");
																										          return false;   
																										      }
																											if(v10==v11)
																										 	{
																										 		alert("Please Change Next Maintenance Date");
																										 		return false; 
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
																										 	var n1=v12.indexOf("@");
																											var n2=v12.lastIndexOf(".");
																											if(n1<1 || n2-n1<2)
																											{
																												alert("Please Enter Valid Email Address");
																											return false;
																											
																											}                  

																										 	var invalid = /[^A-Za-z\s.]/;  
																											var vname=document.vehmaintenanceform.vendorname.value;
																										    if(vname=="") {}
																										    if(invalid.test(vname))
																										     {     
																										         alert('Vendor name must have characters only');  
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
																									
																									
																									
																									
																									
																									
																										}
																										else
																											if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && profshaft=="Yes")
																											{
																												if(v1=="Select")
																											    {
																											        alert("Please Select Vehicle chasisi");
																											        return false;   
																											    }
																												 if(v2=="Select")  
																											      {
																											          alert("Please Select Maintenance Type");
																											          return false;   
																											      }
																												if(v10==v11)
																											 	{
																											 		alert("Please Change Next Maintenance Date");
																											 		return false; 
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
																											 	var n1=v12.indexOf("@");
																												var n2=v12.lastIndexOf(".");
																												if(n1<1 || n2-n1<2)
																												{
																													alert("Please Enter Valid Email Address");
																												return false;
																												
																												}                  

																											 	var invalid = /[^A-Za-z\s.]/;  
																												var vname=document.vehmaintenanceform.vendorname.value;
																											    if(vname=="") {}
																											    if(invalid.test(vname))
																											     {     
																											         alert('Vendor name must have characters only');  
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
																										
																										
																										
																										
																										
																										
																											}
																											else
																												if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && fuellines=="Yes")
																												{
																													if(v1=="Select")
																												    {
																												        alert("Please Select Vehicle chasisi");
																												        return false;   
																												    }
																													 if(v2=="Select")  
																												      {
																												          alert("Please Select Maintenance Type");
																												          return false;   
																												      }
																													if(v10==v11)
																												 	{
																												 		alert("Please Change Next Maintenance Date");
																												 		return false; 
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
																												 	var n1=v12.indexOf("@");
																													var n2=v12.lastIndexOf(".");
																													if(n1<1 || n2-n1<2)
																													{
																														alert("Please Enter Valid Email Address");
																													return false;
																													
																													}                  

																												 	var invalid = /[^A-Za-z\s.]/;  
																													var vname=document.vehmaintenanceform.vendorname.value;
																												    if(vname=="") {}
																												    if(invalid.test(vname))
																												     {     
																												         alert('Vendor name must have characters only');  
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
																											
																											
																											
																											
																											
																											
																												}
																												else
																													if(preventive=="No" && oil=="No" && puc=="No" && insurance=="No" && fitness=="No" && npermit=="No" && tax=="No" && oil1=="Yes")
																													{
																														if(v1=="Select")
																													    {
																													        alert("Please Select Vehicle chasisi");
																													        return false;   
																													    }
																														 if(v2=="Select")  
																													      {
																													          alert("Please Select Maintenance Type");
																													          return false;   
																													      }
																														if(v10==v11)
																													 	{
																													 		alert("Please Change Next Maintenance Date");
																													 		return false; 
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
																													 	var n1=v12.indexOf("@");
																														var n2=v12.lastIndexOf(".");
																														if(n1<1 || n2-n1<2)
																														{
																															alert("Please Enter Valid Email Address");
																														return false;
																														
																														}                  

																													 	var invalid = /[^A-Za-z\s.]/;  
																														var vname=document.vehmaintenanceform.vendorname.value;
																													    if(vname=="") {}
																													    if(invalid.test(vname))
																													     {     
																													         alert('Vendor name must have characters only');  
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

				
	if(sparepart !="Yes")
		{
		            
		    if(v2=="Select")  
	                {
	                alert("Please Select Maintenance Type");
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
				 	var n1=v12.indexOf("@");
					var n2=v12.lastIndexOf(".");
					if(n1<1 || n2-n1<2)
					{
						alert("Please Enter Valid Email Address");
					return false;
					
					}
		}		 	 
//+++++++
				 	
				 	
				 	
				 	var invalid = /[^A-Za-z\s.]/;  
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
		  		  

	function datevalidate()
	{
		
		var date1=document.getElementById("calender1").value;
		var date2=document.getElementById("calender").value;
		var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
		dy1=date1.substring(0,2);
		dy2=date2.substring(0,2);
		dm1=date1.substring(3,6);
		dm2=date2.substring(3,6);

		dm11=dateformat(dm1);
		dm22=dateformat(dm2);	
		dd1=date1.substring(7,11);
		dd2=date2.substring(7,11);
		var date=new Date();
		var month=date.getMonth()+1;
		//var month1=date2.getMonth();
		var day=date.getDate();
		var year=date.getFullYear();
		
		
		
		
		if(dd1>dd2)
		{  
			
			
			
			alert("Next Maintenance Date should be greater than Maintenance Date ");
		
			document.getElementById("calender1").focus;
			return false;
			
		}
		
		else if(year==dd1 && year==dd2) if(dm11>dm22)
		{
			
			alert("Next Maintenance Date should be greater than Maintenance Date ");
		
			document.getElementById("calender1").focus;
			return false;
		}
		 if(dm1==dm2 && dd1==dd2) {
		if(dy1 > dy2)
		{
			alert("Next Maintenance Date should be greater than Maintenance Date ");
			
			document.getElementById("calender1").focus;
			return false;
		}
		}
		return true;
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
    document.getElementById("TyreD").style.display="none";
	document.getElementById("TyreSrno").style.display="none";
	
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
	 	document.getElementById("Mdet").style.display="none";
	 	document.getElementById("mail").style.display="";
	 	
	 	
	 	preventive="No";
	 	oil="No";
	 	puc="No";
	 	insurance="No";
	 	fitness="No";
	 	npermit="No";
	 	tax="No";
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
		 	document.getElementById("Mdet").style.display="none";
		 	document.getElementById("mail").style.display="none";
		 	preventive="No";
		 	oil="No";
		 	puc="No";
		 	insurance="No";
		 	fitness="No";
		 	npermit="No";
		 	tax="No";
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
  				 	document.getElementById("Mdet").style.display="none";
  				 	document.getElementById("mail").style.display="none";
  					preventive="Yes";
  				 	oil="No";
  				 	puc="No";
  				 	insurance="No";
  				 	fitness="No";
  				 	npermit="No";
  				 	tax="No";
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
  				 		document.getElementById("Mdet").style.display="none";
  				 		document.getElementById("mail").style.display="";
  	  			 	 	oil="Yes";
  	  			 		preventive="No";
  	  		 			puc="No";
  	  		 			insurance="No";
  	  		 			fitness="No";
  	  		 			npermit="No";
  	  		 			tax="No";
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
	  				 		document.getElementById("Mdet").style.display="none";
	  				 		document.getElementById("mail").style.display="";
	  	 	 				puc="Yes";
	  	 	 				preventive="No";
	  	 	 	 			oil="No";
			  	 	 	 	insurance="No";
			  	 		 	fitness="No";
			  		 		npermit="No";
			  		 		tax="No";
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
	  	  	document.getElementById("Mdet").style.display="none";
	  	  document.getElementById("mail").style.display="";
	  	 	 					insurance="Yes";
	  	 	 					preventive="No";
	  	 	 		 			oil="No";
	  	 	 		 			puc="No";
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
		  	  	document.getElementById("Mdet").style.display="none";
		  	  document.getElementById("mail").style.display="";
		  	 	 					insurance="No";
		  	 	 					preventive="No";
		  	 	 		 			oil="No";
		  	 	 		 			puc="No";
		  	 	 		 			fitness="Yes";
	  	 	 		 				npermit="No";
	  	 	 		 				tax="No";
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
			  	  	document.getElementById("Mdet").style.display="none";
			  	  document.getElementById("mail").style.display="";
			  	 	 					insurance="No";
			  	 	 					preventive="No";
			  	 	 		 			oil="No";
			  	 	 		 			puc="No";
			  	 	 		 			fitness="No";
		  	 	 		 				npermit="Yes";
		  	 	 		 				tax="No";
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
				  	  	document.getElementById("Mdet").style.display="none";
				  	  document.getElementById("mail").style.display="";
				  	 	 					insurance="No";
				  	 	 					preventive="No";
				  	 	 		 			oil="No";
				  	 	 		 			puc="No";
				  	 	 		 			fitness="Yes";
			  	 	 		 				npermit="No";
			  	 	 		 				tax="No";
				  	 	 		 		}
					  	  				else if(v7=="permit")
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
				  	  	document.getElementById("Mdet").style.display="none";
				  	  document.getElementById("mail").style.display="";
				  	 	 					insurance="No";
				  	 	 					preventive="No";
				  	 	 		 			oil="No";
				  	 	 		 			puc="No";
				  	 	 		 			fitness="No";
			  	 	 		 				npermit="No";
			  	 	 		 				tax="No";
				  	 	 		 		}
					  	  			else if(v7=="sparepart")
				  	  				{
					  	  				
				  	  					document.getElementById("mkm").style.display='none';
			  	 						document.getElementById("nmaftrkm").style.display='none';
			  	 	 					document.getElementById("mntdte").style.display="";
			  	 	 					document.getElementById("nxtmntdte").style.display="none";
			  	 	 					document.getElementById("Mdet").style.display="";
			  	 	 					document.vehmaintenanceform.nxtserkm.value='';
			  	  				 		document.getElementById("abd").style.display='none';
			  	  				 	document.getElementById("mail").style.display='none';
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
		  	 	 		 				sparepart = "Yes";
			  	 	 		 		} else  if(v7=="TyreM")
			  	 	  		  		{
			  	 	  		  			document.getElementById("mntdte").style.display="";
			  	 	  				 	document.getElementById("nxtmntdte").style.display='none';
			  	 	  				 	document.getElementById("mkm").style.display="";
			  	 	  				 	document.getElementById("nmaftrkm").style.display="";
			  	 	  				 	document.vehmaintenanceform.nxtserkm.value='2000';
			  	 	  				 	document.getElementById("abd").style.display='';
			  	 	  				 	document.getElementById("vname").style.display="";
			  	 	  				 	document.getElementById("amt").style.display="";
			  	 	  				 	document.getElementById("rcptno").style.display="";
			  	 	  				 	document.getElementById("doc").style.display="";
			  	 	  				document.getElementById("mail").style.display="";
			  	 	  				document.getElementById("TyreD").style.display="";
		  	 	  				 	document.getElementById("TyreSrno").style.display="";
		  	 	  				document.getElementById("Mdet").style.display="none";
		  	 	  				 	
			  	 	  					preventive="Yes";
			  	 	  				 	oil="No";
			  	 	  				 	puc="No";
			  	 	  				 	insurance="No";
			  	 	  				 	fitness="No";
			  	 	  				 	npermit="No"; 
			  	 	  				 	tax="No";
			  	 	  			  	}
			  	 	 		 	else  if(v7=="remoldtypre")
		  	 	  		  		{
		  	 	  		  			document.getElementById("mntdte").style.display="";
		  	 	  				 	document.getElementById("nxtmntdte").style.display='none';
		  	 	  				 	document.getElementById("mkm").style.display="";
		  	 	  				 	document.getElementById("nmaftrkm").style.display="";
		  	 	  				 	document.vehmaintenanceform.nxtserkm.value='2000';
		  	 	  				 	document.getElementById("abd").style.display='';
		  	 	  				 	document.getElementById("vname").style.display="";
		  	 	  				 	document.getElementById("amt").style.display="";
		  	 	  				 	document.getElementById("rcptno").style.display="";
		  	 	  				 	document.getElementById("doc").style.display="";
		  	 	  				document.getElementById("mail").style.display="";
		  	 	  				document.getElementById("TyreD").style.display="none";
	  	 	  				 	document.getElementById("TyreSrno").style.display="none";
	  	 	  				document.getElementById("Mdet").style.display="none";
	  	 	  				 	
		  	 	  					preventive="No";
		  	 	  				 	oil="No";
		  	 	  				 	puc="No";
		  	 	  				 	insurance="No";
		  	 	  				 	fitness="No";
		  	 	  				 	npermit="No"; 
		  	 	  				 	tax="No";
		  	 	  			  	}
			  	 	 		else  if(v7=="batteryM")
	  	 	  		  		{
	  	 	  		  			document.getElementById("mntdte").style.display="";
	  	 	  				 	document.getElementById("nxtmntdte").style.display='none';
	  	 	  				 	document.getElementById("mkm").style.display="";
	  	 	  				 	document.getElementById("nmaftrkm").style.display="";
	  	 	  				 	document.vehmaintenanceform.nxtserkm.value='2000';
	  	 	  				 	document.getElementById("abd").style.display='';
	  	 	  				 	document.getElementById("vname").style.display="";
	  	 	  				 	document.getElementById("amt").style.display="";
	  	 	  				 	document.getElementById("rcptno").style.display="";
	  	 	  				 	document.getElementById("doc").style.display="";
	  	 	  				document.getElementById("mail").style.display="";
	  	 	  				document.getElementById("TyreD").style.display="none";
  	 	  				 	document.getElementById("TyreSrno").style.display="none";
  	 	  				document.getElementById("Mdet").style.display="none";
  	 	  				 	
	  	 	  					preventive="No";
	  	 	  				 	oil="No";
	  	 	  				 	puc="No";
	  	 	  				 	insurance="No";
	  	 	  				 	fitness="No";
	  	 	  				 	npermit="No"; 
	  	 	  				 	tax="No";
	  	 	  			  	}
		
 		
	  	  				
			  	 	 	else if(v7=="eng")
	  	  				{
	  	  					document.getElementById("mkm").style.display="";
  	 						document.getElementById("nmaftrkm").style.display="";
  	 	 					document.getElementById("mntdte").style.display="";
  	 	 					document.getElementById("nxtmntdte").style.display="";
  	 	 					document.vehmaintenanceform.nxtserkm.value='';
  	  				 		document.getElementById("abd").style.display="";
  	  				 	document.getElementById("vname").style.display="";
  	  				document.getElementById("amt").style.display="";
  	  			document.getElementById("rcptno").style.display="";
  	  		document.getElementById("doc").style.display="";
  	  	document.getElementById("Mdet").style.display="none";
  	  document.getElementById("mail").style.display="";
  	 	 					insurance="No";
  	 	 					preventive="No";
  	 	 		 			oil="No";
  	 	 		 			puc="No";
  	 	 		 			fitness="No";
	 	 		 				npermit="No";
	 	 		 				tax="No";
	 	 		 				eng="Yes";
  	 	 		 		}
			  	 		else if(v7=="chasis")
	  	  				{
	  	  					document.getElementById("mkm").style.display="";
  	 						document.getElementById("nmaftrkm").style.display="";
  	 	 					document.getElementById("mntdte").style.display="";
  	 	 					document.getElementById("nxtmntdte").style.display="";
  	 	 					document.vehmaintenanceform.nxtserkm.value='';
  	  				 		document.getElementById("abd").style.display="";
  	  				 	document.getElementById("vname").style.display="";
  	  				document.getElementById("amt").style.display="";
  	  			document.getElementById("rcptno").style.display="";
  	  		document.getElementById("doc").style.display="";
  	  	document.getElementById("Mdet").style.display="none";
  	  document.getElementById("mail").style.display="";
  	 	 					insurance="No";
  	 	 					preventive="No";
  	 	 		 			oil="No";
  	 	 		 			puc="No";
  	 	 		 			fitness="No";
	 	 		 				npermit="No";
	 	 		 				tax="No";
	 	 		 				chasis="Yes";
  	 	 		 		}
  	 	 		 	else if(v7=="radiator")
  	  				{
  	  					document.getElementById("mkm").style.display="";
	 						document.getElementById("nmaftrkm").style.display="";
	 	 					document.getElementById("mntdte").style.display="";
	 	 					document.getElementById("nxtmntdte").style.display="";
	 	 					document.vehmaintenanceform.nxtserkm.value='';
	  				 		document.getElementById("abd").style.display="";
	  				 	document.getElementById("vname").style.display="";
	  				document.getElementById("amt").style.display="";
	  			document.getElementById("rcptno").style.display="";
	  		document.getElementById("doc").style.display="";
	  	document.getElementById("Mdet").style.display="none";
	  document.getElementById("mail").style.display="";
	 	 					insurance="No";
	 	 					preventive="No";
	 	 		 			oil="No";
	 	 		 			puc="No";
	 	 		 			fitness="No";
 	 		 				npermit="No";
 	 		 				tax="No";
 	 		 				radiator="Yes";
	 	 		 		}
  	 	 		else if(v7=="frontaxle")
	  				{
	  					document.getElementById("mkm").style.display="";
 						document.getElementById("nmaftrkm").style.display="";
 	 					document.getElementById("mntdte").style.display="";
 	 					document.getElementById("nxtmntdte").style.display="";
 	 					document.vehmaintenanceform.nxtserkm.value='';
  				 		document.getElementById("abd").style.display="";
  				 	document.getElementById("vname").style.display="";
  				document.getElementById("amt").style.display="";
  			document.getElementById("rcptno").style.display="";
  		document.getElementById("doc").style.display="";
  	document.getElementById("Mdet").style.display="none";
  document.getElementById("mail").style.display="";
 	 					insurance="No";
 	 					preventive="No";
 	 		 			oil="No";
 	 		 			puc="No";
 	 		 			fitness="No";
	 		 				npermit="No";
	 		 				tax="No";
	 		 				frontaxle="Yes";
 	 		 		}
  	 	 	else if(v7=="clutch")
				{
					document.getElementById("mkm").style.display="";
					document.getElementById("nmaftrkm").style.display="";
					document.getElementById("mntdte").style.display="";
					document.getElementById("nxtmntdte").style.display="";
					document.vehmaintenanceform.nxtserkm.value='';
			 		document.getElementById("abd").style.display="";
			 	document.getElementById("vname").style.display="";
			document.getElementById("amt").style.display="";
		document.getElementById("rcptno").style.display="";
	document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
					insurance="No";
					preventive="No";
		 			oil="No";
		 			puc="No";
		 			fitness="No";
		 				npermit="No";
		 				tax="No";
		 				clutch="Yes";
		 		}
  	 	 else if(v7=="gearbox")
			{
				document.getElementById("mkm").style.display="";
				document.getElementById("nmaftrkm").style.display="";
				document.getElementById("mntdte").style.display="";
				document.getElementById("nxtmntdte").style.display="";
				document.vehmaintenanceform.nxtserkm.value='';
		 		document.getElementById("abd").style.display="";
		 	document.getElementById("vname").style.display="";
		document.getElementById("amt").style.display="";
	document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
				insurance="No";
				preventive="No";
	 			oil="No";
	 			puc="No";
	 			fitness="No";
	 				npermit="No";
	 				tax="No";
	 				gearbox="Yes";
	 		}
  	 	else if(v7=="diffrential")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				diffrential="Yes";
 		}
  	 	else if(v7=="pto")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				pto="pto";
 		}
  	 	else if(v7=="apt")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				pto="Yes";
 		}
   
  	 	else if(v7=="vaccum")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				vaccum="Yes";
 		}
  	 	else if(v7=="suction")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				suction="Yes";
 		}
  	 	else if(v7=="jetting")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				jetting="Yes";
 		}
  	 	else if(v7=="electpanel")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				electpanel="Yes";
 		}
  	 	else if(v7=="hyd")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				hyd="Yes";
 		}
  	 	else if(v7=="hydcyl")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				hydcyl="Yes";
 		}
  	 	else if(v7=="airpipe")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				airpipe="Yes";
 		}
  	 	else if(v7=="fitting")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				airpipe="Yes";
 		}
  	 	else if(v7=="airfilter")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				airfilter="Yes";
 		}
  	 	else if(v7=="cabin")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				airfilter="Yes";
 		}
  	 	else if(v7=="profshaft")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				airfilter="Yes";
 		}
  	 	else if(v7=="fuellines")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				fuellines="Yes";
 		}
  	 	else if(v7=="oil1")
		{
			document.getElementById("mkm").style.display="";
			document.getElementById("nmaftrkm").style.display="";
			document.getElementById("mntdte").style.display="";
			document.getElementById("nxtmntdte").style.display="";
			document.vehmaintenanceform.nxtserkm.value='';
	 		document.getElementById("abd").style.display="";
	 	document.getElementById("vname").style.display="";
	document.getElementById("amt").style.display="";
document.getElementById("rcptno").style.display="";
document.getElementById("doc").style.display="";
document.getElementById("Mdet").style.display="none";
document.getElementById("mail").style.display="";
			insurance="No";
			preventive="No";
 			oil="No";
 			puc="No";
 			fitness="No";
 				npermit="No";
 				tax="No";
 				oil1="Yes";
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
							if(v7=="insurance" || v7=="npermit" || v7=="tax" || v7=="fitness")
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
			             document.getElementById("presentalert").innerHTML="<label name='present' id='present'><font color='maroon' size='2'> <b>Entry Already Done For "+v7+" For "+v6+". </b></font> </label>";
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

function upload(num)
{
	if(num==1)
	{
	  var name1= document.getElementById("element_43").value;
	  var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  { 
	  document.getElementById("element_43").style.display="none";
	  document.getElementById("f1").innerHTML=name1;
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=name1;
	  document.getElementById("remove1").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("element_43").value="";
			  
	  }
	}
	else
	{

		if(num==2)
		{
		  var name1= document.getElementById("element_44").value;
			 //alert(name1);
		var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  {
		  document.getElementById("element_44").style.display="none";
		  document.getElementById("f2").innerHTML=name1;
		  document.getElementById("f2").style.display="";
		  document.getElementById("f7").value=name1;
		  document.getElementById("remove2").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("element_44").value="";
			  
	  }
		  
		}
	}
		
}

function remove(num)
{
	if(num==1)
	{
		document.getElementById("f1").innerHTML="";
		document.getElementById("f1").style.display="none";
		document.getElementById("remove1").style.display="none";
		document.getElementById("element_43").value="";
		document.getElementById("f6").value="";
		document.getElementById("element_43").style.display="";
	}
	else
	{
		if(num==2)
		{
			document.getElementById("f2").innerHTML="";
			document.getElementById("f2").style.display="none";
			document.getElementById("remove2").style.display="none";
			document.getElementById("element_44").value="";
			document.getElementById("f7").value="";
			document.getElementById("element_44").style.display="";
		}
	}
}


</script>
</head>
<body id="main_body" >
<%!
Connection con1;
%>

<img id="top" src="newimages/top.png" alt="" style="width: 600px;">
	
	<div id="form_container" style="width: 600px;">
	
<!-- 		<h1 align="center" style="3"><b>Vehicle Maintenance Entry Module</b></h1> -->
<tr>
		         <td> <div align="center"> <font face="Arial" size="3"> <b> Vehicle Maintenance Entry Module </b> </font>   </div> </td>
		         </tr>
<% 
try {
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
Statement stmt1=con1.createStatement();
Statement stmt2 =con1.createStatement();
Statement stmt10 =con1.createStatement();
ResultSet rs2=null, rs3=null, rs4=null, rs5=null,rs33=null;
String sql2="", sql3="", sql4="", sql5="",sql33="";
String vehno="", prvdid="",lastdriverid="", lastdrivername="";

//vehno=request.getParameter("vehno");


String user=session.getValue("usertypevalue").toString();

java.util.Date d=new java.util.Date();
//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

String inserted=request.getParameter("inserted");


 //java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
  // Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   
%>
<form name="vehmaintenanceform" class="appnitro" enctype="multipart/form-data"method="post" action="vehmaintenanceinsert.jsp" onSubmit="return validate();" >
	
<div class="form_container" style="text-align: center;">
	<div width="100%" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;">
	<table border="0" width="100%" align="center">
<tr align="center">
<td align="center">
			
			<table border="0" width="90%" align="center">
  		   
		    <tr align="center">
		    <td colspan="2" align="center">
		    <div align="center">
		    <%
		    if(inserted==null)
		    {
		    }
		    else
		    { %>
		         <table border="0" width="100%" >
		    <tr>
		         <td> <div align="center"> <font >  <b>Inserted Successfully </b> </font> </div> </td>
		    </tr>
		    </table>
		      
		    <%}
		    %>
		    </div>
		    </td>
		     </tr>
  		  
  		  
  		 
  		  
  		  <tr>
				<td><font color="red" size="2">*</font>Vehicle:-&nbsp;&nbsp;&nbsp;&nbsp; </td>
				<td>
				 <select class="element select medium" name="vehicle" id="vehicle" style="width: 120px;" onchange="funprsentser();"> <option value="Select">Select</option> 

				 <%    
						sql2="select * from t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
				 		rs2=stmt1.executeQuery(sql2);
				 		while(rs2.next())
        				{
				 %>
				            <option value="<%=rs2.getString("VehicleRegNumber")%>"><%=rs2.getString("VehicleRegNumber")%></option>
				 <%     
				 		}
				 %>
				 </select> 
				 </td>
	  		</tr>
	  		
	  		<tr><td></td></tr>
	  		
	  		
	  		<tr>
				<td><font color="red" size="2">*</font>Maintenance Type:- </td>
				<td>
				 <select class="element select medium" name="sertype" id="sertype" style="width: 180px;"onchange="funprsentser();"> 
				 <option value="Select">Select</option> 
				 <%
				 
				 if(!user.equalsIgnoreCase("Aryan Pumps And Enviro Solutions Pvt Ltd Pune"))
				 {
				
				 	 String sql10 = "select servicetype,servicename from db_gps.t_vehmaintanancetype where Owner= 'Default' and activestatus = 'yes' order by servicename ASC";
					 System.out.println("Query==>"+sql10);
					 ResultSet rs10 = stmt2.executeQuery(sql10);
				 	 System.out.println("Query==>"+sql10);
				 	 while(rs10.next())
				 	 {
					 
				 		 %> <option value="<%= rs10.getString("servicetype").trim()%>"><%= rs10.getString("servicename")%></option><%
				 	 }
				 }
				 else
				 {
					 
					 String sql100 = "select servicetype,servicename from db_gps.t_vehmaintanancetype where activestatus = 'yes' order by servicename ASC";
					 System.out.println("Query==>"+sql100);
					 ResultSet rs100 = stmt10.executeQuery(sql100);
				 	 System.out.println("Query==>"+sql100);
				 	 while(rs100.next())
				 	 {
					 
				 		 %> <option value="<%= rs100.getString("servicetype").trim()%>"><%= rs100.getString("servicename")%></option><%
				 	 }
				
				 }
				 %>

				 <%/*    
						sql2="select Distinct(ServiceType) from t_lastservice order by ServiceType";
				 		rs2=stmt1.executeQuery(sql2);
				 		while(rs2.next())
        				{*/
				 %>
				            <!--<option value="<  %=rs2.getString("ServiceType")%>">< %=rs2.getString("ServiceType")%></option>-->
				 <%     
				 		//}
				 %>
				 <!--<option value="Other">Other </option>-->
				 </select> 
				 <input type="text" name="othsertype"  style="display:none;" /> 
				 <div id="presentalert"> </div>
				</td>	
						
	  		</tr>
	  		
	  		<tr><td></td></tr>

	   		<tr id="Mdet" style="display: none;">
      		<td>  <font color="red" size="2">*</font>Maintenance Details:-  </td>
			<td> 
			<input type="text" class="element text medium" name="Mdet1" style="width: 180px;" value="" id="Mdet1"/>
       		</td>
  	  </tr>
	  		
	  		<tr><td></td></tr>

	   		<tr id="mntdte">
      		<td>  <font color="red" size="2">*</font>Maintenance Date:- </td>
		<td> <input type="text" class="element text medium" id="calender1" name="calender1" style="width: 120px;"size="13" value="<%=nwfrmtdte%>"  onblur="funprsentser();"  readonly  />
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender1"       // ID of the button
             }
                           );
             </script>
       		</td>
  	  </tr>
  	  
  	  
  	  <tr><td></td></tr>
  	  
  	  <tr id="mkm">
      		<td> <font color="red" size="2">*</font>Maintenance Km:-</td>
	   		<td><input type="text" class="element text medium" name="serkm" style="width: 180px;" value="" id="serkm"/>Kms. &nbsp;</td>
	  </tr>
	  
	  <tr><td></td></tr>
	  
  	  <tr id="nxtmntdte">
      		<td> <font color="red" size="2">*</font>Next Maintenance Date:-  </td>
		<td> <input type="text" class="element text medium" id="calender" name="calender" style="width: 120px;" size="13" value="<%=nwfrmtdte%>" readonly  />
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender"       // ID of the button
             }
                           );
             </script>
        	 </td>
  	  </tr>
  	  
  	  <tr><td></td></tr>
  	  
  	  
	  <tr id="nmaftrkm">
      		<td> <font color="red" size="2">*</font>Next Maintenance After:-</td>
	   		<td><input type="text" class="element text medium" name="nxtserkm" style="width: 180px;" value="" id="nxtserkm"/>Kms. &nbsp;</td>
	  </tr> 
	  
	  <tr><td></td></tr>
	  
	  <tr id="vname">
           <td><font  size="2"> &nbsp;</font>Vendor Name:-</td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="vendorname"  value="" id="vendorname"/>&nbsp;</td>
           </tr>
		
		<tr><td></td></tr>
		
		<tr id="amt">
           <td><font  size="2"> &nbsp;</font>Amount:-</td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="amount"  value="" id="amount"/>&nbsp;</td>
           </tr>
	        
	    <tr><td></td></tr>    
	        
	      <tr id="rcptno">
           <td><font  size="2"> &nbsp;</font>Reciept No:-</td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="recieptno"  value="" id="recieptno"/>&nbsp;</td>
           </tr> 
           
           
           <tr><td></td></tr>
           
           
           <tr id="doc">
           <td><font  size="2"> &nbsp;</font>Document ID:-</td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="docid"  value="" id="docid"/>&nbsp;</td>
           </tr>  
	  
	  		<tr id="TyreSrno">
           <td><font  size="2"> &nbsp;</font>Tyre Serial No.:-</td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="txtTyreSrno"  value="" id="txtTyreSrno"/>&nbsp;</td>
           </tr>
           <tr id="TyreD">
           <td><font  size="2"> &nbsp;</font>Tyre Details :-</td>
           <td><input type="text" class="element text medium" style="width: 180px;" name="txtTyreD"  value="" id="txtTyreD"/>&nbsp;</td>
           </tr>
	  
	  <tr><td></td></tr>
	   	  
	  <tr id="abd">
      		<td> <font color="red" size="2">*</font>Alert Before Days:-</td>
	   		<td><input type="text" class="element text medium" style="width: 180px;" name="days"  value="" id="days"/>Days. &nbsp;</td>
	  </tr>
	  
	  <tr><td></td></tr>
	  
	  <tr id="mail" >
      		<td> <font color="red" size="2">*</font>Email To Address:-</td>
	   		<td><input type="text" class="element text medium" style="width: 180px;" name="emailto"  value="" id="emailto"/><div>(Enter Comma Seperated Mail ID )</div></td>
	  </tr>
	  
	  	
	      	   <tr>
  	<td><br></br> <font  size="2"><div align="right"> <b>File Upload :</b></div> </font> </td>
	    <td><br></br>
<input type="file" cols="20" name="element_43" id="element_43" value="" onchange="upload(1);" style="background-image: newimages/browse.jpg"/>
		<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
&nbsp;&nbsp;<a href="#" onclick="remove(1);" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		      </td>
		      </tr>
		    <tr>
<tr id="remark">
 <td><font face="Arial" size="2">Remark : <font color="red"> </font></font></td> 
 <td><textarea  name="remark" style='width: 180px; height:50px' class="element textarea medium"  type="text" value=""/></textarea></td> 
</tr>

<tr><td><br></br></td></tr>
	<tr>
      		<td colspan="2" align="center"> <div align="center"><input type="submit" class="button_text" style="border-style: outset; border-color: black" name="submit" id="submit" value="submit"></div> </td>
  	</tr>
  	
  
      </table>
     </td></tr>
      </table>
      </div>
      </div>
      
      
</form>  
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



</body>
</html>
 <table border="0" width="100%" align="center" style="padding-bottom: 56px" >
<tr><td  bgcolor="#0B2161" >
<ui><li><center><font color="white" >Copyright &copy; 2008-2016 by Transworld Technologies Ltd. All Rights Reserved.</font></center></li></ui>
</td></tr>
</table>
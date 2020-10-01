function validate(a,b)
  			{
  				//alert("hiiii");
  				//alert(a);
				if(document.getElementById(a).value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById(b).value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  				}
  				//alert(document.getElementById(a).value);
  				//alert(document.getElementById(b).value);
  				return datevalidate(a,b);
  				
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
function datevalidate(c,d)
{
	//alert("hiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
	var date1=document.getElementById(c).value;
	var date2=document.getElementById(d).value;
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
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	//alert(dd11);
	//alert(dd22);
	//alert(mm11);
	//alert(mm22);
	//alert(yy11);
	//alert(yy22);
	
	if(yy11>year || yy22>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById(c).value="";
		document.getElementById(d).value="";
		document.getElementById(c).focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
			if(mm11>month || mm22>month)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById(c).value="";
			document.getElementById(d).value="";
			document.getElementById(c).focus;
			return false;
		}
			if(mm11<month || mm22==month)
			{
				if(dd22>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById(c).value="";
					document.getElementById(d).value="";
					document.getElementById(c).focus;
					return false;
				}
			}
	}
	if(mm11==month && mm22==month)
	{
		if(dd11>day || dd22>day)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById(c).value="";
			document.getElementById(d).value="";
			document.getElementById(c).focus;
			return false;
		}
	}
	
	
	
	
	
	if(yy11 > yy22)
	{
		alert("From date year should not be greater than to date year");
		document.getElementById(c).value="";
		document.getElementById(d).value="";
		document.getElementById(c).focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
		 if(mm11>mm22)
	{
		alert("From date month should not be greater than to date month");
		document.getElementById(c).value="";
		document.getElementById(d).value="";
		document.getElementById(c).focus;
		return false;
	}
	}
	if(mm11==month && mm22==month) 
	{
		if(yy11==yy22)
		{
		if(dd11 > dd22)
		{
			alert("From date should not be greater than to date");
			document.getElementById(c).value="";
			document.getElementById(d).value="";
			document.getElementById(c).focus;
			return false;
		}
		}
	}
	else
		if(yy11<yy22)
		{
			return true;
		}
	else
		if(dd11 > dd22)
	{
			if(mm11<mm22)
			{
				return true;
			}
			
		alert("From date should not be greater than to date");
		document.getElementById(c).value="";
		document.getElementById(d).value="";
		document.getElementById(c).focus;
		return false;
	}
	
	return true;
}
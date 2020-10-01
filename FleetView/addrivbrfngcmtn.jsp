<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.DriverComments"
	import ="java.util.List"%>
	
	
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
<html>
<head>
<title>Vehicle Tracking System </title>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<script src="elabel.js" type="text/javascript"></script>
<script language="javascript">	
function validate()
{
	alert("please Enter Some text");
	var comtext=document.vehfamform.commenttext.value;
	if(comtext.equals("")||comtext==""||comtext.length==0)
	{
		alert("Please Enter Some Text");
		return false;
	}
	return true;
}

function showopt(val,cnt)
{

	var textareaVal = document.getElementById('commenttext').value;
	//alert(textareaVal.length);
	textareaVal=textareaVal.replace(/^\s+|\s+$/g,"");
if(document.getElementById('dis'+cnt).checked){
	if(textareaVal.length==0)
		{
			textareaVal=textareaVal+val;
		}
	else
		{
    		textareaVal =  textareaVal +'\n'+ val;
		}	
	
	document.getElementById('commenttext').value=textareaVal;
    }
	else
	{
     index = 0;
     while(index < textareaVal.length)
     {
        startIndex = index;
	endIndex = 0;
        while(textareaVal.charAt(index) != '\n' && index < textareaVal.length)
        {
            index++;
        }
	if(startIndex!=index)
	{
		 // its jst a newline char
        	endIndex = index - 1;
		
        	if(startIndex==endIndex )
		{
	
			lineStr = textareaVal.charAt(startIndex);
			
	
		}
		else if(startIndex!=endIndex)
		{
			lineStr = textareaVal.substring(startIndex,endIndex+1);
			
		}
	var ind=endIndex+2;	
	var begString;
       		if(lineStr == val)
		{
		
			if(ind >= textareaVal.length)
			{
				begString = textareaVal.substring(0,startIndex-1);
				document.getElementById('commenttext').value=begString;
			}
			else
			{
				begString = textareaVal.substring(0,startIndex);
				remString = textareaVal.substring(ind,textareaVal.length);
				var compString = begString + remString;
				document.getElementById('commenttext').value=compString;
			}
			index=textareaVal.length-1;

		}

		}//end if

		index++;

        } //end while
    }//end else
}

</script>

<script>
function deleted(index,url)
{
	//alert("hi"+index+" "+url);
	//alert(param+" "+param1);
	var del= document.forms['vehfamform'].elements['editText'+index].value;
	//alert(del);
	
	var agree=confirm("Are you sure you wish to continue?");
		if (agree)
			{
				document.forms['vehfamform'].action=url;
			    window.location.assign(document.forms['vehfamform'].action) ;
					//return true;
			}
		else
			{
			return false ;
		}
} 

</script>
<script>
function onClick(index){
	//alert("hi");
	document.forms['vehfamform'].elements['editText'+index].style.color = 'green';
	document.forms['vehfamform'].elements['editText'+index].readOnly = false;
	document.forms['vehfamform'].elements['editButton'+index].style.display= 'none';
	document.forms['vehfamform'].elements['submitButton'+index].style.display= 'block';
}
function onSubmit(index,url)
{
		var editcomm = document.forms['vehfamform'].elements['editText'+index].value;
//url=url+"&editcomm="+editcomm;
editcomm=editcomm.replace(/^\s+|\s+$/g,"");
	if(editcomm.length==0)
	{
		alert("Please Enter value");
		return false;
	}
	else
	{ 
		
		var agree=confirm("Are you sure you wish to continue?");
		if (agree)
		{
			document.forms['vehfamform'].action=url;
			alert(document.forms['vehfamform'].action);
			  window.location.assign(document.forms['vehfamform'].action) ;
			//return true;
		}
		else
		{
			return false ;
		}
	
	}
}

</script>
</head>
<%!
	private boolean isNull(final String input)
	{
		return (null == input) ? true : false;
	}
%>
<form  name="vehfamform" method="get" action="addcommentinsert.jsp" style="overflow:scroll" > 

<div class="ScrollTable" style="height:600px;width:250px">
<%
	String commentSubmitted=request.getParameter("commentsubmitted");
	String commentFrom=request.getParameter("comfrom");	
	String commentFor=request.getParameter("commentfor");
	//System.out.println("commentFor-->"+commentFor);
	String commentType = null;
	int numRecords=0;
	List<DriverComments> list = null;
	try{
		list = vehicleDao.getDriverComments(commentFor);	
		numRecords=list.size();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
%>
<input type="hidden" name="comfrom" value="<%=commentFrom%>"/>
<%	
	if(!isNull(commentSubmitted))
	{
%>
		<script language="javascript">		
			window.close();
		</script>
<%	
	} 
	String edited=request.getParameter("edited");	 
	String inserted=request.getParameter("inserted");
	String deleted=request.getParameter("deleted");
	if(inserted==null)
	{
		if(edited==null)
		{}
		else
		{
			%>
			<font size="2" color="green"><b><blink> Successfully edited!!!</blink></b></font> 
			<%
		}
		if(deleted==null)
		{}
		else
		{
			%>
			<font size="2" color="green"><b><blink> Successfully deleted!!!</blink></b></font> 
			<%
		}
	}	
	else
	{ %>
	<table border="0" width="100%">
	<tr><td>
		<font size="2" color="green"><b><blink> Successfully Saved!!!</blink></b></font>
	</td></tr> 
	</table>		
<%	}
	
	if(commentFor.equals("vehiclefamiliarize1"))
	{
		try
		{	

			commentType=session.getAttribute("vehiclefamiliarizecomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}


else if(commentFor.equals("traininginpt"))
{ 
		try
		{	
			commentType=session.getAttribute("traininginptcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
		
}

else if(commentFor.equals("PIMC"))
{ 
		try
		{	
			commentType=session.getAttribute("PIMCcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}



else if(commentFor.equals("rdinduct"))
{ 
		try
		{	
			commentType=session.getAttribute("rdinductcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}		
}


else if(commentFor.equals("nextTraining"))
{ 
		try
		{	
			commentType=session.getAttribute("nextTrainingcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("MedicalChkup"))
{ 
		try
		{	
			commentType=session.getAttribute("MedicalChkupcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("drengage"))
{ 
		try
		{	
			commentType=session.getAttribute("drengagecom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("briefingremark"))
{ 
		try
		{	
			commentType=session.getAttribute("remarkcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}


else if(commentFor.equals("Serviceable"))
{ 
		try
		{	
			commentType=session.getAttribute("Serviceablecom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}


else if(commentFor.equals("tripdata"))
{ 
		try
		{	
			commentType=session.getAttribute("tripdatacom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

else if(commentFor.equals("reactive"))
{ 
		try
		{	
			commentType=session.getAttribute("reactivecom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}


else if(commentFor.equals("replaced"))
{ 
		try
		{	
			commentType=session.getAttribute("replacedcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}


else if(commentFor.equals("OtherObs"))
{ 
		try
		{	
			commentType=session.getAttribute("OtherObscom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}




else if(commentFor.equals("jrmdb"))
{ 
		try
		{	
			commentType=session.getAttribute("jrmdbcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("drivearlier"))
{ 
		try
		{	
			commentType=session.getAttribute("drivearliercom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("unsched"))
{ 
		try
		{	
			commentType=session.getAttribute("unschedcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}



else if(commentFor.equals("routdev"))
{ 
		try
		{	
			commentType=session.getAttribute("routdevcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("jrmrisk"))
{ 
		try
		{	
			commentType=session.getAttribute("jrmriskcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
///////////////////////////////////////

else if(commentFor.equals("zonechangewarning"))
{ 
		try
		{	
			commentType=session.getAttribute("zonechangewarningcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("otherFeedback"))
{ 
		try
		{	
			commentType=session.getAttribute("otherFeedbackcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("JRMinstalled"))
{ 
		try
		{	
			commentType=session.getAttribute("JRMinstalledcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("routeUpload"))
{ 
		try
		{	
			commentType=session.getAttribute("routeUploadcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

/////////////////////////////////////
else if(commentFor.equals("vehfit"))
{ 
		try
		{	
			commentType=session.getAttribute("vehfitcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}



else if(commentFor.equals("servicedue"))
{ 
		try
		{	
			commentType=session.getAttribute("serviceduecom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("visibledamage"))
{ 
		try
		{	
			commentType=session.getAttribute("visibledamagecom").toString();
		}catch(Exception e)
		{
			commentType="";
		}		
}


else if(commentFor.equals("overall"))
{ 
		try
		{	
			commentType=session.getAttribute("overallcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("driverfit"))
{ 
		try
		{	
			commentType=session.getAttribute("driverfitcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
		
}

else if(commentFor.equals("visibleabnorm"))
{ 
		try
		{	
			commentType=session.getAttribute("visibleabnormcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
		
}

else if(commentFor.equals("drrespons"))
{ 
		try
		{	
			commentType=session.getAttribute("drresponscom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
		
}

else if(commentFor.equals("drfitothobs"))
{ 
		try
		{	
			commentType=session.getAttribute("drfitothobscom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

else if(commentFor.equals("tripsamedriver"))
{ 
		try
		{	
			commentType=session.getAttribute("tripsamedrivercom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}



else if(commentFor.equals("AllOthrObs"))
{ 
		try
		{	
			commentType=session.getAttribute("AllOthrObscom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}


else if(commentFor.equals("vehicl"))
{ 
	try
	{	
		commentType=session.getAttribute("vehiclcomm").toString();
				}catch(Exception e)
				{
					commentType="";
				}
		}
			else if(commentFor.equals("rdrootfam"))
			{ 
			try
				{	
					commentType=session.getAttribute("rdrootfamcom").toString();
				}catch(Exception e)
				{
					commentType="";
				}
		}
		else if(commentFor.equals("rdmental"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdmentalcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		} 
		else if(commentFor.equals("rdlicen"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdlicencomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}		

		else if(commentFor.equals("rdtaxpermit"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdtaxpermitcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}	

     		 else if(commentFor.equals("rddriven"))
		{ 
			try
			{	
				commentType=session.getAttribute("rddrivencomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}	
         else if(commentFor.equals("rdhelper"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdhelpercomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}	

else if(commentFor.equals("rdsignldevice"))
{ 
	try
	{	
		commentType=session.getAttribute("rdsignldevicecomm").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
		}	

                 else if(commentFor.equals("rdinstrmntpanels"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdinstrmntcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}	

		 else if(commentFor.equals("rdwidescreenmirror"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdwidescrcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}
		else if(commentFor.equals("rdtyrepress"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdtyrecomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}

                else if(commentFor.equals("rdbreaks"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdbreakscomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}


               else if(commentFor.equals("rdseatbelt"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdseatbeltcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}

              else if(commentFor.equals("rdrupd"))
		{ 
			try
			{	
				commentType=session.getAttribute("rdrupdcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}

		else if(commentFor.equals("rdtraininginpt"))
		{ 
			try
			{	
				commentType=session.getAttribute("traincomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
		}



		else if(commentFor.equals("rdjrmbrief"))
		{	 
			try
			{	
				commentType=session.getAttribute("rdjrmbriefcomm").toString();
			}catch(Exception e)
			{
				commentType="";
			}
	} 
	else if(commentFor.equals("driverreponse"))
	{ 
		try
		{	
			commentType=session.getAttribute("driverreponsecomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
		} 
		else if(commentFor.equals("specinst"))
		{
			try
			{	
				commentType=session.getAttribute("specinstcomm").toString();
			}catch(Exception e)
		{
			commentType="";
		}
		} 
	        else if(commentFor.equals("shortages"))
		{
		try
		{	
			commentType=session.getAttribute("shortagescomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
	} 
         else if(commentFor.equals("rtDeviation"))
	{
		try
		{	
			commentType=session.getAttribute("rtDeviationcomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
	} 
        else if(commentFor.equals("drLicnRd"))
	{
		try
		{	
			commentType=session.getAttribute("drLicnRdcomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
	} 
        else if(commentFor.equals("gpsdata"))
	{
		try
		{	
			commentType=session.getAttribute("gpsdatacomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
 	 }     
	else if(commentFor.equals("rdpassport"))
	{
		try
		{	
			commentType=session.getAttribute("rdpassportcomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
	}
        else if(commentFor.equals("rdlastTrDet"))
	{
	try
	{	
		commentType=session.getAttribute("getlastTrDet").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}
      
      else if(commentFor.equals("rdTraining"))
{
	try
	{	
		commentType=session.getAttribute("rdTrainingcomm").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}
else if(commentFor.equals("rdStatus"))
{
	try
	{	
		commentType=session.getAttribute("rdStatuscomm").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}
      
 else if(commentFor.equals("rdMedicalChkup"))
{
try
		{	
			commentType=session.getAttribute("rdMedicalChkupcomm").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
      
 else if(commentFor.equals("rdServiceable"))
{
try
		{	
			commentType=session.getAttribute("rdServiceablecom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

 else if(commentFor.equals("rdReActivated"))
{
try
		{	
			commentType=session.getAttribute("rdReActivatedcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}   
 else if(commentFor.equals("rdReplaced"))
{
try
		{	
			commentType=session.getAttribute("rdReplacedcom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
 else if(commentFor.equals("rdAllOthrObs"))
{
try
		{	
			commentType=session.getAttribute("rdAllOthrObscom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("rdLicn"))
{
try
		{	
			commentType=session.getAttribute("rdLicncom").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("rdDocuments"))
{
	try
	{	
		commentType=session.getAttribute("rdDocumentscom").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}
else if(commentFor.equals("rdhelpr"))
{
	try
	{	
		commentType=session.getAttribute("rdhelprcom").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}
else if(commentFor.equals("rdSignal"))
{
	try
	{	
		commentType=session.getAttribute("rdSignalcom").toString();
	}catch(Exception e)
		{
			commentType="";
		}
}
else if(commentFor.equals("rdInstru"))
{
	try
	{	
		commentType=session.getAttribute("rdInstrucom").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}
else if(commentFor.equals("rdTyre"))
{
	try
	{	
		commentType=session.getAttribute("getRdTyre").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
}



 else if(commentFor.equals("rdSeatBelt"))
{
try
		{	
			commentType=session.getAttribute("getSeatBelt").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}



 else if(commentFor.equals("rdSUPD"))
{
try
		{	
			commentType=session.getAttribute("getSUPD").toString();
		}catch(Exception e)
		{
			commentType="";
		}

}



 else if(commentFor.equals("rdfire"))
{
try
		{	
			commentType=session.getAttribute("getFireExt").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

      


 else if(commentFor.equals("rdreflector"))
{
try
		{	
			commentType=session.getAttribute("getReflector").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

	if(commentFor.equals("rdfirstaid"))
{
try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}

     else if(commentFor.equals("rdtoolbox"))
{
try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}
      
   
        else if(commentFor.equals("rdcondveh"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 


                 else if(commentFor.equals("rdearlierdriven"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
}     
                 else if(commentFor.equals("rdstopsched"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

        else if(commentFor.equals("rdriskunder"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}

} 

else if(commentFor.equals("rdgenapearance"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

             else if(commentFor.equals("rdvisibleinjury"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

         else if(commentFor.equals("rdrepetstrech"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

   else if(commentFor.equals("rddrug"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

else if(commentFor.equals("rdmentalprob"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 

else if(commentFor.equals("rdadequetsleep"))
	{
		try
		{	
			commentType=session.getAttribute("getFirstAid").toString();
		}catch(Exception e)
		{
			commentType="";
		}
} 
else if(commentFor.equals("rdotherobser"))
{
	try
	{	
		commentType=session.getAttribute("getFirstAid").toString();
	}
	catch(Exception e)
	{
		commentType="";
	}
} 

else if(commentFor.equals("rdOtherObs"))
{
	try
	{	
		commentType=session.getAttribute("getFirstAid").toString();
	}catch(Exception e)
	{
		commentType="";
	}
} 
%>
<table border="0" width="100%">
<%

int i=1, j=0;
for(int counter=0; counter<numRecords;counter++)
{	
	final DriverComments currentRecord = list.get(counter);
	String commentValue=currentRecord.getComment();
	String srno=currentRecord.getSerialNumber();
%> 
	<tr><td>
<input type="checkbox" id="dis<%=j %>" name="dis<%=j %>" value="<%=commentValue%>" onchange="showopt('<%=commentValue%>','<%=j%>')";onKeyUp="entred()"/>
<script>
function entred()
{

}
</script>
</td>
<td >
<input type="text" size="50%" border="0" style="border: none;" value="<%=commentValue %>" id="editText<%=j%>" readonly="readonly"/>

</td>



<td><input type="button" id="del" name="del" value="Delete" onclick="deleted('<%=j %>','dele.jsp?srno=<%=srno%>&commfor=<%=commentFor %>&commaction=delete')"></input></td>

</tr>

<%
		i++;
		j++;
}
 %>
</table>
<input type="hidden" name="countcom" value="<%=i-1%>"/>
<input type="hidden" name="commentsubmitted" value="yes" />
<input type="hidden" name="commentfor" value="<%=commentFor%>" />

<table border="0" width="100%" class="stats">
  		  <tr>
			<td class="hed" align="center"><b><font size="2"> <%=commentFor%></font></b> </td>
		</tr>
		
		  <tr>
		  	<td> <textarea border="5" name="commenttext"  id="commenttext" rows="6" cols="70"> <%=commentType%> </textarea> </td>
  		  </tr> 
  		  <tr>
        		<td align="center"> <input type="submit" name="submit" value="Submit" class="formElement" />
			&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="fix" value="Fixed" class="formElement" /> </td>
  		  </tr>	
		</table>

</div>
</form>

</html>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%--  <%@page import="com.transworld.fleetview.framework.VehicleDao"
        import="com.transworld.fleetview.framework.DebriefSubmitData"
        import="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
        import="com.transworld.fleetview.framework.DebriefSubmitViewData"
        import="com.transworld.fleetview.framework.ReasonOfRejection"
        import="com.transworld.fleetview.framework.VehicleRegistrationNumberForTransporter"
        import="com.fleetview.beans.DisconnectionCount"
        import="com.transworld.fleetview.framework.PeripheralOfUnitDuringTrip"%>     --%>     
<%@ include file="headernew.jsp"%>
<%-- <jsp:useBean id="vehicleDao"
        type="com.transworld.fleetview.framework.VehicleDao"
        scope="application"></jsp:useBean> --%>

<%-- <jsp:useBean id="debriefSubmitViewDataProvider"
        type="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
        scope="application"></jsp:useBean> --%>
 
<style type="text/css">
<!--
h1
{

 font-size: 22px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 margin: 14px 0px 7px 0px;
 padding: 0px;

}
h2
{

 font-size: 17px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 padding: 0px;
 margin: 14px 0px 7px 0px;

}
h3
{

 font-size: 14px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 padding: 0px;
 margin: 14px 0px 7px 0px;

}
p
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 line-height: 130%;
 margin: 7px 0px 7px 0px;

}
ul
{

 list-style-position: inside;
 list-style-type: square;
 margin: 7px 0px 7px 0px;
 
 padding: 0px;

}
li
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 margin: 1px 0px 1px 0px;
 
 padding: 0px;

}
a
{

 color: #0000ff;
 text-decoration: underline;

}
a:hover
{

 color: #0000ff;
 text-decoration: none;0

}
.cbFormLabel
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;

}
.cbFormLabelError
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormError
{

 color: #ff0000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 text-align: left;
 vertical-align: middle; 
 
 margin-left: 5px;

}
.cbFormTable
{

 border-collapse: collapse;

}
.cbFormTableRow
{

 padding: 7px;

}
.cbFormLabelCell
{

 text-align: left;
 vertical-align: top;
 width: auto;
 font-size: 13px;
 padding: 3px;
 white-space: normal;

}
.cbFormTextField
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormTextArea
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormPassword
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 padding: 1px 1px 1px 1px;

}
.cbFormFieldCell
{
 font-size: 12px;
 text-align: left;
 vertical-align: top;
 padding: 3px;
 white-space: nowrap;

}
.cbFormDataCell
{

 text-align: left;
 vertical-align: top;
 width: auto;
 padding: 3px;
 white-space: normal;

}
.cbHTMLBlockContainer
{

 text-align: left;
 vertical-align: top;
 padding: 3px;

}
.cbFormNestedTable
{

 height:100%;
 border-collapse:collapse;
 padding: 0px;
 border: none;

}
.cbFormNestedTableContainer
{
 text-align: left;
 vertical-align: top;
 padding: 0px;
}
.cbFormLabelRequired
{
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;

}
.cbFormRequiredMarker
{

 font-size: 12px;
 font-family: Arial;
     
 margin-left: 2px;
 font-style: normal;
 font-weight: bold;

}
.cbFormData
{
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormCalendar
{

 padding-left:5px;

}
.cbFormErrorMarker
{

 margin-right:5px;
}
.cbFormSelect
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormFile
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormDataLink
{

 color: #0000ff;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 text-decoration: underline;

}
.cbFormDataLink:hover
{

 color: #0000ff;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 text-decoration: none;

}
.cbSubmitButton
{

 font-weight: normal;
 
 width: auto;
 height: auto;
 margin: 0 3px;

}
.cbSubmitButton_hover
{

 font-weight: normal;
 
 width: auto;
 height: auto;
 margin: 0 3px;

}
.cbSubmitButtonContainer
{

 padding: 3px;
 text-align: center;
 vertical-align: middle;

}

-->
</style>

<head></head>
<script language="javascript">

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
}

var TChkAdh,TChkAdhJ,flg1=0,flg2=0,flg3=0,flg4=0,flg5=0,flg6=0;
var scr_DH=0,scr_ND=0,scr_CD=0,scr_DVI=0,scr_Adh=0,scr_N_DH=0,scr_N_ND=0,scr_N_CD=0,scr_N_DVI=0,scr_N_Adh=0;
function showtext()
{
        try{
                         var Val1 = document.getElementsByName("ChkAdh");
                flg1=0;
          for ( var i = 0; i < Val1.length; i++ ) 
                  {
                        if ( Val1[i].checked==true)
                                {
                                TChkAdh=Val1[i].value;
                                flg1=1;
                                if ( Val1[i].value=='No')
                                        {
                                        document.getElementById("tr1").style.display = "";
try{

                                        document.getElementById("PointType5").innerHTML = "0";
                                        document.getElementById("PointType51").innerHTML = "0";
                                        scr_N_Adh=0;
}catch(e)       {}                      
                                                
                                        }
                                else
                                {document.getElementById("tr1").style.display = "none";
        try{
                                document.getElementById("PointType5").innerHTML = "15";
                                document.getElementById("PointType51").innerHTML = "15";
                                scr_N_Adh=15;
        }
        catch(e)
        {       }
                                }
                         }      
                  }
          
                if(flg1==0)
                {
                //alert("Please Select Option"+flg1);
                        }
        }catch(e)
        {
        alert(e);
                }
}

function showtext1()
{
        try{
         var Val2 = document.getElementsByName("ChkAdhJ");
         flg2=0;
          for ( var i = 0; i < Val2.length; i++ ) 
                  {
                        if ( Val2[i].checked==true)
                                {
                                TChkAdhJ =Val2[i].value;
                                flg2=1;
                                if ( Val2[i].value=='No')
                                        {
                                        document.getElementById("tr2").style.display = "";
                                        }
                                else
                                {document.getElementById("tr2").style.display = "none";
                                        
                                }
                         }      
                  }
          if(flg2==0)
                {
                //alert("Please Select Option");
                        }
        }catch(e)
        {
        alert(e);
                }
}


function GetAdherance(DriveId,TripId)
{
        try{
                flg=0;
                //alert(DriveId+": "+BrifId+" : "+TripId)
                
                showtext1();
                showtext();
                //validateMiss();
                
    var NearMiss=document.getElementById("NMissT").checked;
	
    
	if((document.getElementById("NMissT").checked))
	{

		var NearMissD = document.getElementById("NearMissD").value;
		var RouteCause = document.getElementById("RouteCause").value;
		var prevention = document.getElementById("prevention").value;
		var jrmFeedBack= document.getElementById("jrmFeedBack").value;
		var jrmFeedBack1=document.getElementById("jrmFeedBack").value; 
		
		if(jrmFeedBack1 == "Select")
		{
		alert("please enter JRM Feedback !");
		return false;
		}
		
		
		NearMissD=NearMissD.trim();
		RouteCause=RouteCause.trim();
		prevention=prevention.trim();  
		jrmFeedBack=jrmFeedBack.trim();
			
		
				if(NearMissD.length == 0){
				alert("Please enter near miss description !");
				return false;
				}

							
				if(RouteCause.length == 0){
					alert("Please enter Route Cause !");
					return false;
				}

				if(prevention.length == 0){
					alert("Please enter Preventive action for feature !");
					return false;
				}
				if(jrmFeedBack == 0){
					alert("Please enter JRM feedback !");
					return false;
				}
						
	}
	else
	{
		var jrmFeedBack= document.getElementById("jrmFeedBack").value;
		var jrmFeedBack1=document.getElementById("jrmFeedBack").value; 
		
		if(jrmFeedBack1 == "Select")
		{
		alert("please enter JRM Feedback !");
		return false;
		}
		
		jrmFeedBack=jrmFeedBack.trim();
		var RouteCause = "-";
		var prevention = "-";
		var NearMissD = "-";
		
		if(jrmFeedBack == 0){
			alert("Please enter JRM feedback !");
			return false;
		}
		
	}
	
                
                
                //alert("Hii");
                var b=0;
                //var reason1=document.getElementById("reason1").value;
                //var reason2=document.getElementById("reason2").value;
                var reason1="";
                var reason2="";

                if(TChkAdh=="No")
                 {var src = document.DriDebrif.assigned;
                 for(var count=0; count < src.options.length; count++) {
                            var option = src.options[count];
                            if(count==0)
                                reason1+=option.value;
                            else
                            reason1+="~"+option.value;
                          
                                }
                 }
                 else
                 {reason1="-";
                         }
                        
                 if(TChkAdhJ=="No")
                        {var src = document.DriDebrif.assigned2;
                         for(var count=0; count < src.options.length; count++) 
                                 {
                                    var option = src.options[count];
                                    if(count==0)
                                        reason2+=option.value;
                                    else
                                    reason2+="~"+option.value;
                                 }
                                   
                        }
                        else
                        {
                                reason2=document.getElementById("JRMPer").value;
                        }


                
                //alert("Adh: "+TChkAdh+" Adhj:"+TChkAdhJ+" Reson:"+reason1+" Reson2:"+reason2);
                
                if((TChkAdh=="No" && reason1=="")||(TChkAdhJ=="No" && reason2=="")||(flg1==0||flg2==0))
                {
                alert("Either Adherence to JRM or Journey plan or both options not selected");
                }
                else
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
                                try
                                {
                                        
                                var reslt=ajaxRequest.responseText;

                                reslt=reslt.replace(/^\s+|\s+$/g,'');

                                if(reslt=="Updated")
                                        {alert("Record updated Succesfully");
                                        flg4=1; 
                                        document.getElementById("Tab2").value="1";
                                        }
                                else
                                {               alert("Record updated UnSuccesfully");
                                flg4=0;
                                }
                        
                        
                                }catch(e)//
                                {
                                alert(e);
                                }
                        } 
                };


                
                var queryString = "?ChkAdh="+TChkAdh+"&ChkAdhJ="+TChkAdhJ+"&reason1="+reason1+"&reason2="+reason2+"&DriveId="+DriveId+"&TripId="+TripId+"&NearMiss="+NearMiss+"&NearMissD="+NearMissD+"&RouteCause="+RouteCause+"&prevention="+prevention+"&jrmFeedBack="+jrmFeedBack+""; //
                ajaxRequest.open("GET", "driver_debriefing_Update_Ajax.jsp" + queryString, true);
                ajaxRequest.send(null); 

                }
                }
            catch(e)
                {
                        alert(e);
                }

}


function GetFeedback(DriveId,TripId)
{
        try{
                        flg5=0;
                //alert(DriveId+": "+BrifId+" : "+TripId);
                //alert("Hii");
                var b=0;
                //var reason1=document.getElementById("reason1").value;
                //var reason2=document.getElementById("reason2").value;
                var Feedback=document.getElementById("Feedback").value;;
                //alert("Adh: "+TChkAdh+" Adhj:"+TChkAdhJ+" Reson:"+reason1+" Reson2:"+reason2);
                
                if(Feedback=="")
                {
                alert("Please Enter Feedback");
                }
                else
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
                                try
                                {
                                        
                                var reslt=ajaxRequest.responseText;
                                reslt=reslt.replace(/^\s+|\s+$/g,'');

                                                        
                                //alert(reslt);
                                if(reslt=="Updated")
                                        {alert("Record updated Succesfully");
                                        flg5=1;
                                        document.getElementById("Tab3").value="1";
                                        }
                                else
                                {               alert("Record updated UnSuccesfully");
                                flg5=0;
                                }
                        
                        
                                }catch(e)
                                {
                                alert(e);
                                }
                        } 
                };


                
                var queryString = "?&Feedback="+Feedback+"&DriveId="+DriveId+"&TripId="+TripId+"";
                ajaxRequest.open("GET", "driver_debriefing_Feedback_Ajax.jsp" + queryString, true);
                ajaxRequest.send(null); 

                }
                }
            catch(e)
                {
                        alert(e);
                }
        }

function GetGoals(DriveId,TripId)
{
        try{
                flg3=0;
                var b=0;
                //var reason1=document.getElementById("reason1").value;
                //var reason2=document.getElementById("reason2").value;
                var GoalsAchived="";
        

                 var src = document.DriDebrif.assigned3;
                 for(var count=0; count < src.options.length; count++) 
                         {
                            var option = src.options[count];
                            if(count==0)
                                GoalsAchived+=option.value;
                            else
                                GoalsAchived+="~"+option.value;

                         }

                
                //alert("Adh: "+TChkAdh+" Adhj:"+TChkAdhJ+" Reson:"+reason1+" Reson2:"+reason2);
                
                if((GoalsAchived==""))
                {
                	var agree=confirm("Are you sure? No goals achieved by driver");
                	if(agree)
                		{
                		flag11=true;
                		GoalsAchived="Goals Not Achived";
                		}
                	else
                		{
                		flag11=false;
                		}
                }
                else{
                	
                	flag11=true;
                }
                
                
                
                
                
                
                if(flag11==true)
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
                                try
                                {
                                        
                                var reslt=ajaxRequest.responseText;
                                
                                reslt=reslt.replace(/^\s+|\s+$/g,'');
                                
                                if(reslt=="Updated")
                                        {alert("Record updated Succesfully");
                                        flg3=1;
                                        document.getElementById("Tab4").value="1";
                                        }
                                else
                                {               alert("Record updated UnSuccesfully");
                                flg3=0;
                                }
                                        
                        
                                }catch(e)
                                {
                                alert(e);
                                }
                        } 
                };                                         
                
                var queryString = "?&GoalsAchived="+GoalsAchived+"&DriveId="+DriveId+"&TripId="+TripId+"";
                ajaxRequest.open("GET", "driver_debriefing_Goals_Ajax.jsp" + queryString, true);
                ajaxRequest.send(null); 

                }
                }
            catch(e)
                {
                        alert(e);
                }

}


function GetFinal(DriveId,TripId)
{
        try{

    

                showtext();
                showtext1();
                var Feedback=document.getElementById("Feedback").value;;
                     
                var Tab2=document.getElementById("Tab2").value;
        		var Tab3=document.getElementById("Tab3").value;
        		var Tab4=document.getElementById("Tab4").value;
        		var Tab6=document.getElementById("Tab6").value;
        		//var Tab5=document.getElementById("Tab5").value;
        		 
        		        		
        		if(Tab2=="0")
        			{ 
        			alert("Tab '2. Adherence to JRM And Journey plan' have not been save properly. \n Kindly save it.");
        			}
        		else if(Tab3=="0")
        			{
        			alert("Tab '3. Feedback' have not been save properly. \n Kindly save it.");
        			}   
        		else if(Tab4=="0")
    			{
    			alert("Tab '5. Goals Achieved ' have not been save properly. \n Kindly save it.");
    			}
        		else if(Tab6=="0")
    			{
    			alert("Tab '5. Personal Engagemnet ' have not been save properly. \n Kindly save it.");
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
                                alert(reslt);
                                window.location.href="Driver_briefing_New.jsp";
                                
                                //if(reslt=="Updated")
                                //      {alert("Record updated Succesfully");
                                //              }
                                //
                                //else
                                //{             alert("Record updated UnSuccesfully");}
                        
//                      
                                }catch(e)
                                {
                                alert(e);
                                }
                        } 
                };
               var queryString = "?&DriveId="+DriveId+"&TripId="+TripId+"";
               ajaxRequest.open("GET", "driver_debriefing_Final_Ajax.jsp" + queryString, true);
                ajaxRequest.send(null); 

                }
        		}
        
            catch(e)
                {
                        alert(e);
                }

}




function GetFinal1(DriveId,TripId)
{
        try{

                                window.location.href="Driver_briefing_New.jsp";
        
        }
            catch(e)
                {
                        alert(e);
                }

}















function GetScore(DriveId,TripId)
{
        try{
                showtext();
                var b=0;
                var scrDH=0,scrND=0,scrCD=0,scrDVI=0;
                
        		scrDH=document.getElementById("scr_DH").value;
                scrND=document.getElementById("scr_ND").value;
                scrCD=document.getElementById("scr_CD").value;
                scrDVI=document.getElementById("scr_DVI").value;
                        
                var scrNDH=document.getElementById("scr_N_DH").value;
                var scrNND=document.getElementById("scr_N_ND").value;
                var scrNCD=document.getElementById("scr_N_CD").value;
                var scrNDVI=document.getElementById("scr_N_DVI").value;


                var RscrNDH=document.getElementById("R_scr_N_DH").value;
                var RscrNND=document.getElementById("R_scr_N_ND").value;
                var RscrNDVI=document.getElementById("R_scr_N_DVI").value;
                var RscrNCD=document.getElementById("R_scr_N_CD").value;
                                
                var TScr=document.getElementById("T_Scr").value;
                var TNScr=document.getElementById("T_N_Scr").value;

                                               
                var ajaxRequest;  // The variable that makes Ajax possible!
                try{// Opera 8.0+, Firefox, Safari
                        ajaxRequest = new XMLHttpRequest();     }  
                catch (e)
                {// Internet Explorer Browsers
                        try{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
                        catch (e)
                        {try{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");} 
                                catch (e)
                                {// Something went wrong
                                        alert("Your browser broke!");return false;}}}
                ajaxRequest.onreadystatechange = function()
                {       if(ajaxRequest.readyState == 4)
                        {try{   
                                var reslt=ajaxRequest.responseText;
                          
                                reslt=reslt.replace(/^\s+|\s+$/g,'');
                                var respo=reslt.split("~");
                                 
                        
                                if(respo[0]=="Updated"){
                                        alert("Record updated Succesfully");
                                        document.getElementById("Tol_Scr").innerHTML = respo[1];
                                        document.getElementById("Tol_N_Scr").innerHTML = respo[2];
                                        document.DriDebrif.T_N_Scr.value=respo[2];
                                        document.getElementById("Tab5").value="1";
                                        flg6=1;
                                        }else if(respo[0]=="NoUpdated")
                                        {               alert("New Point should be less than or equal to Points Allocated ");
                                        flg6=0;
                                        }
                                
                                }catch(e)
                                {alert(e);}}};
                                //alert(DriveId+" "+TripId);    
                var queryString = "?&scrNDH="+scrNDH+"&RscrNDH="+RscrNDH+"&scrNND="+scrNND+"&RscrNND="+RscrNND+"&scrNCD="+scrNCD+"&RscrNCD="+RscrNCD+"&scrNDVI="+scrNDVI+"&RscrNDVI="+RscrNDVI+"&scrAdh="+scr_N_Adh+"&TScr="+TScr+"&DriveId="+DriveId+"&TripId="+TripId+"&scrDH="+scrDH+"&scrND="+scrND+"&scrCD="+scrCD+"&scrDVI="+scrDVI+"&TNScr="+TNScr+"";
                
                ajaxRequest.open("POST", "driver_debriefing_Score_Ajax.jsp" + queryString, true);
                ajaxRequest.send(null); 

                
                }
                
            catch(e)
                {
                        alert(e);
                }

}




function Displayer(n)
{

var check = document.getElementById('Section' + n);

if(check.style.display == 'none')
{
check.style.display='inline';
}
else
{
check.style.display='none';
}

}




function addUser() {
        try
        {
        
    var src = document.DriDebrif.resources;
    var dest = document.DriDebrif.assigned;
        
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
        }
        catch(e)
        {
                alert(e);
        }
}

function removeUser() {
    var src = document.DriDebrif.assigned;
    var dest =  document.DriDebrif.resources;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                        
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                        
                 }
                count--;
        }
    }
}

function addUser2() {
        try
        {
        
    var src2 = document.DriDebrif.resources2;
    var dest2 = document.DriDebrif.assigned2;
        
    for(var count=0; count < src2.options.length; count++) {
 
        if(src2.options[count].selected == true) {
                var option = src2.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest2.add(newOption, null); //Standard
                         src2.remove(count, null);
                 }catch(error) {
                         dest2.add(newOption); // IE only
                         src2.remove(count);
                 }
                count--;
        }
    }
        }
        catch(e)
        {
                alert(e);
        }
}

function removeUser2() {
    var src2 = document.DriDebrif.assigned2;
    var dest2 =  document.DriDebrif.resources2;
 
    for(var count=0; count < src2.options.length; count++) {
 
        if(src2.options[count].selected == true) {
                var option = src2.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest2.add(newOption, null); //Standard
                         src2.remove(count, null);
                        
                 }catch(error) {
                         dest2.add(newOption); // IE only
                         src2.remove(count);
                        
                 }
                count--;
        }
    }
}


function addUser3() {
        try
        {
        
    var src3 = document.DriDebrif.resources3;
    var dest3 = document.DriDebrif.assigned3;
        
    for(var count=0; count < src3.options.length; count++) {
 
        if(src3.options[count].selected == true) {
                var option = src3.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest3.add(newOption, null); //Standard
                         src3.remove(count, null);
                 }catch(error) {
                         dest3.add(newOption); // IE only
                         src3.remove(count);
                 }
                count--;
        }
    }
        }
        catch(e)
        {
                alert(e);
        }
}

function removeUser3() {
    var src3 = document.DriDebrif.assigned3;
    var dest3 =  document.DriDebrif.resources3;
    for(var count=0; count < src3.options.length; count++) {
 
        if(src3.options[count].selected == true) {
                var option = src3.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.title= option.title;
                newOption.selected = false;
                try {
                         dest3.add(newOption, null); //Standard
                         src3.remove(count, null);
                        
                 }catch(error) {
                         dest3.add(newOption); // IE only
                         src3.remove(count);
                        
                 }
                count--;
        }
    }
}





function AdhReset() {
        document.getElementById("tr1").style.display = "none";
        document.getElementById("tr2").style.display = "none";
 var ele = document.getElementsByName("ChkAdh");
   for(var i=0;i<ele.length;i++)
      {ele[i].checked = false;
                }
   
   var ele = document.getElementsByName("ChkAdhJ");
   for(var i=0;i<ele.length;i++)
      ele[i].checked = false;


   var src = document.DriDebrif.assigned;
   var dest =  document.DriDebrif.resources;

   for(var count=0; count < src.options.length; count++) {
               var option = src.options[count];
               var newOption = document.createElement("option");
               newOption.value = option.value;
               newOption.text = option.text;
               newOption.title= option.title;
               newOption.selected = false;
               try {
                        dest.add(newOption, null); //Standard
                        src.remove(count, null);
                       
                }catch(error) {
                        dest.add(newOption); // IE only
                        src.remove(count);
                       
                }
               count--;       
   }


   var src2 = document.DriDebrif.assigned2;
   var dest2 =  document.DriDebrif.resources2;

   for(var count=0; count < src2.options.length; count++) {
               var option = src2.options[count];
               var newOption = document.createElement("option");
               newOption.value = option.value;
               newOption.text = option.text;
               newOption.title= option.title;
               newOption.selected = false;
               try {
                        dest2.add(newOption, null); //Standard
                        src2.remove(count, null);
                       
                }catch(error) {
                        dest2.add(newOption); // IE only//
                        src2.remove(count);
                       
                }
               count--;       
   }


        
}


function FeedbackReset() {
        try
        {               
        document.DriDebrif.Feedback.value='';
        }catch(e)
        {
        alert(e);
                }               
}


function FeedbackReset() {
        try
        {               
        document.DriDebrif.Feedback.value='';
        }catch(e)
        {
        alert(e);
                }               
}



function GoalsReset() {
           var src2 = document.DriDebrif.assigned3;
           var dest2 =  document.DriDebrif.resources3;

           for(var count=0; count < src2.options.length; count++) {
                       var option = src2.options[count];
                       var newOption = document.createElement("option");
                       newOption.value = option.value;
                       newOption.text = option.text;
                       newOption.selected = false;
                       try {
                                dest2.add(newOption, null); //Standard
                                src2.remove(count, null);
                               
                        }catch(error) {
                                dest2.add(newOption); // IE only
                                src2.remove(count);
                               
                        }
                       count--;       
           }


                
}

var totalChk=0, checkedChk=0;
function GetJRM() {
         checkedChk=0;
           var src2 =document.getElementsByName("jrnyPlaning");
           for(var count=0; count < src2.length; count++) {
                        if(src2[count].checked==true)
                                        {   
                                checkedChk++;
                                        }                                      
           }    
                var JRMPer=((checkedChk/count)*100); 
                JRMPer=parseInt(JRMPer);
                var JRMPer1; 
                JRMPer1=JRMPer+"%";
   document.getElementById("JRMPer").value=JRMPer;
   document.getElementById("JRMPer1").innerHTML=JRMPer1;
}



function ChkDh()
{
        
        var ChkscrNDH=document.getElementById("Chkscr_N_DH");
        if(ChkscrNDH.checked==true)
                {
                document.getElementById("LblDH").innerHTML=document.getElementById("scr_C_DH").value;           
                document.getElementById("scr_N_DH").value=document.getElementById("scr_C_DH").value;
                }else
                        {document.getElementById("LblDH").innerHTML="0";
                        document.getElementById("scr_N_DH").value="0";
                        }
        
}

function ChkND()
{try{
        var ChkscrNND=document.getElementById("Chkscr_N_ND");
        
        if(ChkscrNND.checked==true)
                {
        
                document.getElementById("LblND").innerHTML=document.getElementById("scr_C_ND").value;
                document.getElementById("scr_N_ND").value=document.getElementById("scr_C_ND").value;
                }else
                {
                
                        document.getElementById("LblND").innerHTML="0";
                        document.getElementById("scr_N_ND").value="0";
                        }
        }
        catch(e)
        {
                alert(e);
        }
        
}



function ChkCD()
{try{

        var ChkscrNCD=document.getElementById("Chkscr_N_CD");
        
        if(ChkscrNCD.checked==true)
                {
        
                document.getElementById("LblCD").innerHTML=document.getElementById("scr_C_CD").value;
                document.getElementById("scr_N_CD").value=document.getElementById("scr_C_CD").value;
                }else
                {
                
                        document.getElementById("LblCD").innerHTML="0";
                        document.getElementById("scr_N_CD").value="0";
                        }
        }
        catch(e)
        {
                alert(e);
        }
        
}

function open2(TripId,DriveId,BrifId,Day,routeid)
{
	//alert("oprn2");
	if(Day == 'All')
	{
	testwindow1 = window.open("ViewPlan.jsp?tripid="+TripId+"&driverid="+DriveId+"&briefid="+BrifId,"ViewJourneyPlanning","width=900,height=700,scrollbars=yes");
		testwindow1.moveTo(250,250);
	}
	else
	{
		try
		{
		//alert("ajax");
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
			
				document.getElementById("legsum").innerHTML = reslt;
				}
				catch(e)
				{
					alert(e);
				}
			}
		}
		
		var queryString ="?tripid="+TripId+"&briefid="+BrifId+"&driverid="+DriveId+"&Day="+Day+"&routeid="+routeid;
		ajaxRequest.open("POST", "LegSummary.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		catch(e)
		{
			alert(e);
		}
	}
			
}


function open4(TripId,DriveId,BrifId,routeid)
{
	try
	{
		//routeid = document.getElementById("routeid").value;
	testwindow1 = window.open("ViewJourneyOnMap.jsp?tripid="+TripId+"&driverid="+DriveId+"&briefid="+BrifId+"&rid="+routeid,"ViewOnMap","width=1000,height=900,scrollbars=yes");
	testwindow1.moveTo(250,250);
	}
	catch(e)
	{
		alert(e);
	}
}



function checkvalue(val)
{

	
	 	 if(val=="Yes")
		 {	 
	        	 document.getElementById('NearMissRow').style.display='block';
	 	         document.getElementById('routeCauseRow').style.display='block';
	 	        document.getElementById('PreventionRow').style.display='block';
	 	     //  document.getElementById('jrmFeedBackRow').style.display='block';
		 	       
 	
	 	  }	
	 	   else
	 	   {	   
	 		  document.getElementById('NearMissRow').style.display='none';
	 	      document.getElementById('routeCauseRow').style.display='none';
	 	     document.getElementById('PreventionRow').style.display='none';
	 	 //   document.getElementById('jrmFeedBackRow').style.display='none';
	 	   }

		 if(val=="Select")
		 {
			 document.getElementById('NearMissRow').style.display='none';
	 	      document.getElementById('routeCauseRow').style.display='none';
	 	     document.getElementById('PreventionRow').style.display='none';
	 	//    document.getElementById('jrmFeedBackRow').style.display='none';
			}	 
	 	    
}

function validateMiss()
{ 
	var NearMissD = document.getElementById("NearMissD").value;
	var RouteCause = document.getElementById("RouteCause").value;
	var prevention = document.getElementById("prevention").value;
	var jrmFeedBack= document.getElementById("jrmFeedBack").value;
	
	NearMissD=NearMissD.trim();
	RouteCause=RouteCause.trim();
	prevention=prevention.trim();  
	jrmFeedBack=jrmFeedBack.trim();
	
	if((document.getElementById("NMissT").checked))
	{
				if(NearMissD.length == 0){
				alert("Please enter near miss description !");
				return false;
				}

							
				if(RouteCause.length == 0){
					alert("Please enter Route Cause !");
					return false;
				}

				if(prevention.length == 0){
					alert("Please enter Preventive action for feature !");
					return false;
				}

				if(prevention.length == 0){
					alert("Please enter Preventive action for feature !");
					return false;
				}		

				if(jrmFeedBack.length == 0 ){
					alert("Please enter JRM Feedback !");
					return false;
				}		
	}
	else
	{
		return true;
	}
		
}


window.onload = function() {
	
	    	  document.getElementById('NearMissRow').style.display='none';
	          document.getElementById('routeCauseRow').style.display='none';
	          document.getElementById('PreventionRow').style.display='none';
	        //  document.getElementById('jrmFeedBackRow').style.display='none';	      
	
			  document.getElementById('NMissF').checked=true;
			  document.getElementById('NMissT').checked=false;	

}

function GetNews(DriveId,BrifId,TripId,driveraddress)
{
	try{
	var b=0;
	var inci1="";
	
	//var src = document.brief.Innewletter;
	var address=document.getElementById("driveradd").value;
	//alert(address);
	var src =document.getElementById("Innewletter").value;
	//alert(src);
	inci1=src;
/* 	for(var count=0; count < src.options.length; count++) {
		    var option = src.options[count];
		    if(count==0)
		    	inci1+=option.value;
		    else
		    	inci1+="~"+option.value;
		  
			} */
	if(inci1=="")
	{
	alert("Please Select Newsletter");
	}
	else
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
			try
			{
				
			var reslt=ajaxRequest.responseText;
			var result1;
			result1=reslt;
			result1=result1.replace(/^\s+|\s+$/g,'');
			if(result1=="Updated")
				alert("Record Updated Succesfully");
			document.getElementById("Tab6").value="1";
		
			}catch(e)
			{
			alert(e);
			}
		} 
	};
	 
	var queryString = "?inci1="+inci1+"&DriveId="+DriveId+"&BrifId="+BrifId+"&DriverAddress="+address+"";
	ajaxRequest.open("GET", "driver_debriefing_Update_news.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	}
    catch(e)
	{
		alert(e);
	} 
}


function clear1(){
	//alert("Hi");
	//document.getElementById("driveradd").value="";
	// $("#name").prop('readonly', false);
 document.getElementById("driveradd").removeAttribute("readonly");
 return false;
	
}

        </script>
        <%!
Connection con1=null;
        String category="";
int id= 0;

private static void setTimeToBeginningOfDay(Calendar calendar) {
    calendar.set(Calendar.HOUR_OF_DAY, 0);
    calendar.set(Calendar.MINUTE, 0);
    calendar.set(Calendar.SECOND, 0);
    calendar.set(Calendar.MILLISECOND, 0);
}
private static void setTimeToEndofDay(Calendar calendar) {
    calendar.set(Calendar.HOUR_OF_DAY, 23);
    calendar.set(Calendar.MINUTE, 59);
    calendar.set(Calendar.SECOND, 59);
    calendar.set(Calendar.MILLISECOND, 999);
}
%>

<%

try{
con1 = fleetview.ReturnConnection();
Statement st=con1.createStatement();
Statement st1=con1.createStatement();
Statement st2=con1.createStatement();
Statement st3=con1.createStatement();
Statement st31=con1.createStatement();
Statement st4=con1.createStatement();
Statement st5=con1.createStatement();
Statement st6=con1.createStatement();
Statement st61=con1.createStatement();
Statement st7=con1.createStatement();
Statement st21=con1.createStatement();
Statement st8=con1.createStatement();
Statement st9=con1.createStatement();
Statement st10=con1.createStatement();
Statement st11=con1.createStatement();
Statement st12=con1.createStatement();
Statement st13=con1.createStatement();
Statement st14=con1.createStatement();
Statement st15=con1.createStatement();
Statement st16=con1.createStatement();
Statement stn=con1.createStatement();
Statement std=con1.createStatement();
Statement stnews=con1.createStatement();
Statement stMain=con1.createStatement();
Statement st99=con1.createStatement();
%>


<body background="#83738A">

<% 
String DriveId=request.getParameter("driverid");
String DriverName=request.getParameter("drivername");
String TripId=request.getParameter("TripId");

String PDate=request.getParameter("PDate");

String veh=request.getParameter("veh");
String Transporter=request.getParameter("transporter");
String debriefid=request.getParameter("debriefid");

String AdhJRM="",AdhJRMReason="",AdhJourney="",AdhJourneyReason="",FeedBack="",GoalsAchived="",VehRNo22="";
String driveraddress="",newsletter="",newsletter1="",news="''";
int flgAdh=0,flgAdhJ=0;

String VehCodeN="",StartDateN="",EndPlaceN="",StartPlaceN="",EndDateN="",StartTripDT="",EndTripDT="",Briefid="";
if(veh.equalsIgnoreCase("null")||veh.equalsIgnoreCase("")||veh=="")
{
String sql41 = "SELECT VehRegNo,TripCategory FROM db_gps.t_completedjourney WHERE driverid = '"+DriveId+"' AND TripID='"+TripId+"'";
ResultSet rs41 = st31.executeQuery(sql41);
        if(rs41.next())
        {
                veh=rs41.getString("VehRegNo");
                category=rs41.getString("TripCategory");
        }
}

String sqlMain ="select * from db_gps.t_debriefing where driverid='"+DriveId+"' and tripid='"+TripId+"' order by updateddt DESC";
ResultSet rsMain = stMain.executeQuery(sqlMain);
int iMain=0;
if(rsMain.next())
{try{
        debriefid=rsMain.getString("debriefid");}
        catch(Exception e)
        {debriefid="-";}
        
try{
	Briefid=rsMain.getString("Briefid");}
    catch(Exception e)
    {Briefid="-";}


try{
        Transporter=rsMain.getString("transporter");}
        catch(Exception e)
        {Transporter="-";}
        
        try{
        AdhJRM=rsMain.getString("AdhJRM");}
        catch(Exception e)
        {AdhJRM="-";}
        
        try{
        AdhJRMReason=rsMain.getString("AdhJRMReason");}
        catch(Exception e)
        {AdhJRMReason="-";}
        
        try{
        AdhJourney=rsMain.getString("AdhJourney");}
        catch(Exception e)
        {AdhJourney="-";}
        
        try{
        AdhJourneyReason=rsMain.getString("AdhJourneyReason");}
        catch(Exception e)
        {AdhJourneyReason="-";}
        
        try{
                
                FeedBack=rsMain.getString("FeedBack");
                if(FeedBack==null)
                {FeedBack="";}          
        }
        catch(Exception e)
        {FeedBack="-";}
        
        try{
                if(rsMain.getString("GoalsAchived")==null)
                {
                        
                        GoalsAchived="-";
                }else
                {
        GoalsAchived=rsMain.getString("GoalsAchived");
                }
        
        }
        catch(Exception e)
        {GoalsAchived="-";}
        try{
                VehRNo22 =rsMain.getString("transporter");}
                catch(Exception e)
                {VehRNo22="-";} 
        
                
}
%>
 <%
String StartDateDbFormat="",EndDateDBFormat="",routeid = "",CleanerName="",CleanerId="";
String sql14 = "SELECT * FROM db_gps.t_completedjourney WHERE TripID='"+TripId+"'";

ResultSet rs14 = st14.executeQuery(sql14);
float TripDist=0;
if(rs14.next())
{
        VehCodeN=rs14.getString("Vehid");
        StartDateN=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs14.getString("StartDate")));
        StartDateDbFormat=rs14.getString("StartDate");
        StartTripDT=new SimpleDateFormat("yyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs14.getString("StartDate")));
        EndPlaceN=rs14.getString("EndPlace");
        StartPlaceN=rs14.getString("StartPlace");
        EndDateN=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs14.getString("EndDate")));
        EndDateDBFormat=rs14.getString("EndDate");
        EndTripDT=new SimpleDateFormat("yyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs14.getString("EndDate")));
        TripDist=rs14.getInt("KmTravelled");
        VehRNo22 = rs14.getString("VehRegNo");
}

try{
    
String sql41 = "SELECT CleanerId,CleanerName FROM t_briefing WHERE  tripid = '"+TripId+"' and driverid = '"+DriveId+"'";

ResultSet rs41 = st3.executeQuery(sql41);
        
        String str4="-";
        if(rs41.next())
        {                       
       
        	CleanerId=rs41.getString("CleanerId");
        	CleanerName=rs41.getString("CleanerName");
        	       	
       
        }
}
catch(Exception e)
        {
        out.println(e);
        }


sql14 = "select advancedrouteid from db_gps.t_intermediatejrmroute where tripid = '"+TripId+"' and driverid = '"+DriveId+"' and briefid = '"+Briefid+"'";
rs14 = st14.executeQuery(sql14);
if(rs14.next())
{
	routeid = rs14.getString("advancedrouteid");
}
%>
 <form  style="margin: 0px;" action = "" method="post" id="DriDebrif" name="DriDebrif"  class="appnitro" enctype="multipart/form-data" >
 <h2 align="center">Edit De-briefing Page</h2>
 <div align="center">
 
 <table  class="cbFormNestedTable" cellspacing="0" align="center" >
<tr>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Driver ID :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><%=DriveId %>  
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Driver Name :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><font size="2"><%=DriverName %>  
</font> </label></td>
<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Transporter :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><font size="2"><%=Transporter %>   </font> 
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Trip ID :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><%=TripId %> 
 </label></td>
</tr>
<tr>
 
<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>De BriefId : </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel" align="left"><label for="InsertRecordFirst_Name"  ><font size="2"><%=debriefid%></font>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Vehicle Reg No : </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel" align="left"> <label for="InsertRecordFirst_Name"  ><font size="2"><%=veh %></font> 
</label></td>



<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Cleaner Id :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><%=CleanerId %> 
 </label></td>
 
 <td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Cleaner Name :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><%=CleanerName %> 
 </label></td>



</tr>
<tr>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Origin :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel">
<label for="InsertRecordFirst_Name" ><%=StartPlaceN  %>  
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Start Date :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><font size="2"><%=StartDateN %>   </font> 
</label></td>


<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>Destination :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><%=EndPlaceN  %>  
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><b>End Date :  </b>
</label></td>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordFirst_Name" ><font size="2"><%=EndDateN %>
</font> </label></td>

</tr>
</table>
</div>
 <input type="hidden" name="AppKey" value="6cbb100090d21faa8db649229faa"/>
  <div style="margin-left: 950px" >
  <input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>
          <input type="button" class="button_text" style="border-style: outset; border-color: black" value="Exit"  onclick="GetFinal1('<%=DriveId %>','<%=TripId %>')" >
        <input type="button" class="button_text" style="border-style: outset; border-color: black" value="Complete Debriefing"  onclick="GetFinal('<%=DriveId %>','<%=TripId %>')" >
        
         </div>
          <table  cellpadding="0" cellspacing="0" border="0">
                 <tr>
                 <td>
                 <table  cellspacing="0"  class="cbFormTable">
         <tr class="cbFormTableRow">
         <td colspan="4" class="cbHTMLBlockContainer">
         
<div style="background:#FAFAFE; width:950px;margin-left: 200px ">
<h2 style="background:#7979FF; color:#000000; cursor:pointer;" onClick="Displayer(1)">&nbsp;+ 1. Trip Details&nbsp;</h2>







<table id="Section1" style="display:none;">
<tr>
<td  class="cbFormNestedTableContainer" >
<br>
<div style="width:109px;" align="left" >
<table  class="sortable" cellspacing="0" border="2" >
<tr>
<td align="center" colspan="5"><b>Driver Run Hours</b>
</td>
</tr>
<tr>
<td valign="top"  style="background-color:#FFFFFF">
<div id="div1">
<IFRAME src='driverRunHoursChart.jsp?driverid=<%=DriveId %>' scrolling=no id='banner1' width='800' height='350'
                                        style='padding-top: 10; padding-left: 10;' frameborder='0'></IFRAME>
</div>
</td>
                                
</tr>
</table>
</div>
</td>

</tr>
</table>
                 </div>
                 <%

String colorAdh="";
int flg112=0;
if(AdhJourney!=null||AdhJRM!=null)
{
if(((AdhJourney.equalsIgnoreCase("Yes"))||(AdhJourney.equalsIgnoreCase("No")))&&((AdhJRM.equalsIgnoreCase("Yes"))||(AdhJRM.equalsIgnoreCase("No"))))
{       colorAdh="#56C556"; //Green 
flg112=1;
}else
{
        colorAdh="#FF5959";     //Red
        flg112=0;
}

}else
{
        colorAdh="#FF5959";     //Red
        flg112=0;
}

%>

 
<input type="hidden" id="Tab2" name="Tab2" value="<%=flg112 %>"></input>
<div style="background:#FAFAFE; width:950px;margin-left: 200px ">
<h2 id="HeadAdh" style="background-color: <%=colorAdh %>;  color:#000000; cursor:pointer;" onClick="Displayer(2)">&nbsp;+ 2. Adherence to JRM And Journey plan&nbsp;</h2>

<table id="Section2" style="display:none; margin-left: 30px">
<tr>

<td  class="cbFormNestedTableContainer">
<table  class="cbFormNestedTable" cellspacing="0">

<%
if(routeid==""||routeid.equalsIgnoreCase("null")){}
else{
%>

<tr>
<td colspan="4" class="cbFormLabelCell  cbFormLabel" align="center">
<div align="center">
<a href="#" onclick="open2('<%=TripId %>','<%=DriveId %>','<%=Briefid %>','All','<%=routeid %>')"><font size="2"><b>View Leg Summary</b></font></a> </div></td>
<td colspan="4" class="cbFormLabelCell  cbFormLabel" align="center"><div align="center">
<a href="#" onclick="open4('<%=TripId %>','<%=DriveId %>','<%=Briefid %>','<%=routeid %>')"><font size="2"><b>View Journey on Map</b></font></a></div>
</td>
</tr>
<%
}
%>
<tr>
<td colspan="8" class="cbFormLabelCell  cbFormLabel" align="center">
<div  style="width:800px; overflow: auto;text-align: center;">
<br>
<table  border="1" align="center" >

<tr>
<td align="center" ><b>Planned Journey</b></td>
<td align="center" ><b>Actual Journey</b></td>
</tr>
<tr>
<td colspan="1"  width="50%">
<%
try{
String sql15="SELECT  * FROM db_gps.t_jrnyplanning WHERE driverid = '"+DriveId+"' AND tripid = '"+TripId+"' and StopReason not in ('Journey End','Night Halt')  ORDER BY t_jrnyplanning.Start ";
//String sql15="SELECT  * FROM db_gps.t_jrnyplanning WHERE driverid = '91038785' AND tripid = '12121212' and StopReason not in ('Journey End','Night Halt')  ORDER BY t_jrnyplanning.Start DESC ";
System.out.println(sql15);
ResultSet rs15 = st15.executeQuery(sql15);
int i15=1;
if(rs15.next())
{
%>
<div style="height:300px; overflow: auto;">
<table    border="1"  class="sortable" >
<tr>
<td><b>Sr. no</b></td>
<td><b>Mark</b></td>
<td><b>Start D/T</b></td>
<td><b>End D/T</b></td>
<td><b>Place</b></td>
<td><b>Duration</b></td>

</tr>
<%
rs15.previous();
while(rs15.next())
{ 
	 	
	String EndTime="";
	String sql2121="select ADDTIME('"+rs15.getString("End")+"','"+rs15.getString("StopDuration")+"') as EndTime";
	System.out.println(sql2121);
	ResultSet rs21 = st21.executeQuery(sql2121);
	System.out.println(sql2121);
	 
	if(rs21.next())
	{
		try{
	EndTime=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs21.getString("EndTime")));
		}
		catch(Exception e)
		{
			EndTime=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs15.getString("End")));
		}
	}
	
	
%>
<tr>

<td><%=i15 %> </td>
<td><input type="checkbox" name="jrnyPlaning" id="jp<%=i15 %>" value="<%=i15 %>" onclick="GetJRM()"></input> </td>
<td><%=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs15.getString("End")))
 %></td>
<td><%=EndTime%></td>
<td><%=rs15.getString("Destination") %></td>
<td><%=rs15.getString("StopDuration") %></td>

</tr>
<%
i15++;
}
%>
</table>
<%
}
}
catch(Exception e)
{
e.printStackTrace();
}
%>
</div>

</td>
<td colspan="1"  width="50%">
<%

String sql16="SELECT * FROM db_gpsExceptions.t_veh"+VehCodeN+"_stsp  where concat(FromDate,' ',FromTime) BETWEEN '"+StartDateDbFormat+"' AND '"+EndDateDBFormat+"' ORDER BY FromDate, FromTime ASC ";
//String sql16="SELECT * FROM db_gpsExceptions.t_veh420_stsp  where FromDate BETWEEN '2011-04-01' AND '2011-04-14' ORDER BY FromDate, FromTime ASC ";

ResultSet rs16 = st16.executeQuery(sql16);

int i16=1;
if(rs16.next())
{
%>
<div style="height:300px; overflow: auto;">
<table class="sortable"  border="1">

<tr>
<td>Sr. no</td>
<td>Start D/T</td>
<td>End D/T</td>
<td>Place</td>
<td>Duration</td>
</tr>
<%
rs16.previous();
while(rs16.next())
{
%>
<tr>
<td><%=i16 %> </td>
<td><%=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs16.getString("FromDate")+" "+rs16.getString("FromTime")))
%></td>
<td><%=new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs16.getString("ToDate")+" "+rs16.getString("ToTime")))
 %></td>
<td><%=rs16.getString("Location") %></td>
<td><%=rs16.getString("Duration") %></td>
</tr>
<%
i16++;
}

%>

</table>
</div>
<%
}


String sql = "select *  from db_gps.t_jrmrouteadvancedmaster where StartPlace = '"+StartPlaceN+"' and EndPlace = '"+EndPlaceN+"'";
System.out.println("RRRR****   "+sql);
ResultSet rsT1 = st.executeQuery(sql);
int  totzone = 0,redzone =0,redkm =0,yellowzone =0,yelllowkm =0,greenzone =0,greenkm = 0;
float GPSPer=0,totkm=0 ; 
if(rsT1.next())
{
	
	totzone = rsT1.getInt("totalzone");
	totkm = rsT1.getInt("totalkm");
	redzone = rsT1.getInt("redzonecount");
	redkm = rsT1.getInt("redzonedist");
	yellowzone =rsT1.getInt("yellowzonecount");
	yelllowkm = rsT1.getInt("yellowzonedist");
	greenzone = rsT1.getInt("greenzonecount");
	greenkm = rsT1.getInt("greenzonedist");	
	
}

System.out.println("RRRR****   "+sql);
DecimalFormat dec1 = new DecimalFormat("####"); 
String totkm1=dec1.format(totkm);
String TripDist1=dec1.format(TripDist);

%>

</td>
</tr>
</table>
</div>
</td>

</tr>
<tr>
<td></td>
<td colspan="7" class="cbFormNestedTableContainer" >
<div >

<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordCoApplicant_First_Name" >GPS percentage : 
</label></td>
<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">

<tr>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name">Trip Distance : </label>
</td>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name"><%=TripDist1 %> Km</label>
</td>
</tr> 
<tr>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name" >Standard Distance  : </label>
</td>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name" ><%=totkm1 %> Km</label>
</td>
</tr>
<tr>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name">Percentage : </label>
</td>
<td  class="cbFormFieldCell">
<%
DecimalFormat dec = new DecimalFormat("###.#");
String GPSPer1="0";
		
try{
	if(totkm!=0)
	{
GPSPer=((TripDist/totkm)*100);

GPSPer1=dec.format(GPSPer);


	}else{
		GPSPer1="0";
		}
	
}catch(Exception e)
{
e.printStackTrace();	
GPSPer1="0";
}
%>
<label for="InsertRecordCoApplicant_First_Name"><%=GPSPer1 %> %</label> 
</td>
</tr>
</table>
</td>
</tr>
<!--

Added here

		-->
		</br>
		<td colspan="7" class="cbFormNestedTableContainer" >
		<table  class="cbFormNestedTable" cellspacing="0">
				<tr>
			<td class="cbFormLabelCell  cbFormLabel"><label	for="InsertRecordDate_of_Birth"><b> Near miss during the trip? :</b></label>		
			
				<label	for="InsertRecordFirst_Name"><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Yes<input type="radio" name="NMiss"  id="NMissT" value="Yes"  onchange='checkvalue(this.value)'> 
				No<input type="radio" name="NMiss"  id="NMissF" value="No" checked="checked"  onchange='checkvalue(this.value)'>   
				       
				</font></label>
			</td>
	</tr>
	<tr id="NearMissRow">
			<td><font face="Arial" size="2"><font color="red"> *</font><b>  Near miss Description &nbsp;: </b> </font> <font color="red"></font>
		 	
		 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 		<input type="text" id="NearMissD" name="NearMissD" style="width: 400px;">
		 	</td>
		 		
	</tr>

	
	
	<tr id="routeCauseRow" >		
			<td><font face="Arial" size="2"><font color="red"> *</font><b> Route Cause &nbsp;: </b> </font> <font color="red"></font>		 	
		 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 	<input type="text" id="RouteCause" name="RouteCause" style="width: 400px;"></td>
		 		
	</tr>

	<tr id="PreventionRow" >		
			<td><font face="Arial" size="2"><font color="red"> *</font><b> Preventive action for feature &nbsp;: </b> </font> <font color="red"></font>		 	
		 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 			
		 	<input type="text" id="prevention" name="prevention" style="width: 400px;"></td>
		 		
	</tr>
	
	<!-- <tr id="jrmFeedBackRow" >		
			<td><font face="Arial" size="2"><font color="red"> *</font><b> JRM Feedback &nbsp;: </b> </font> <font color="red"></font>		 	
		 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
		 	<input type="text" id="jrmFeedBack" name="jrmFeedBack" style="width: 400px;"></td>
		 			
		 	
		 		
	</tr> -->
	
	<tr id="jrmFeedBackRow" >		
			<td><font face="Arial" size="2"><font color="red"> *</font><b>JRM Route Feedback Given by Driver&nbsp;: </b> </font> <font color="red"></font>		 	
		 	<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
		 	&nbsp;&nbsp;&nbsp;&nbsp;	
		 	<select  name="jrmFeedBack" id="jrmFeedBack" class="element select medium" style="width: 180px;">	
		 	<!-- <input type="text" id="jrmFeedBack" name="jrmFeedBack" style="width: 400px;"> -->
		 	<% 
		 	String sql99="select Options from db_gps.t_JourneyGoals where Categoery='JRM Feedback' order by Options asc";
		 	ResultSet rs99=st99.executeQuery(sql99);
		 	%>
		 	<option value="Select" >Select--</option>
		 	<% 
		 	while(rs99.next())
		 	{%>
		 	<option value="<%=rs99.getString("Options")%>"><%=rs99.getString("Options")%></option>
		 	<%} %></select>
		 	</td>
		 			
		 	
		 		
	</tr>
	
		
		</table>
		</td>
		</br>	


<tr>
<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordCoApplicant_First_Name" >Adherance to JRM  : 
</label></td>
<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdh" id="ChkAdh" value="Yes" onclick="showtext()" ></input>
</td>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name" >YES </label>
<input type="hidden" id="JRMPer" value=""></input>
</td>
</tr>
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdh" id="ChkAdh" value="No" onclick="showtext()"  ></input>
</td>
<td  class="cbFormFieldCell">
<label for="InsertRecordCoApplicant_First_Name">NO</label>
</td>
</tr>
</table>
</td>

</tr>

</table>

</div>
</td>

</tr>


<tr id="tr1" style="display: none;">
<td></td>
<td colspan="7" class="cbFormNestedTableContainer" valign="top">
<table  class="cbFormNestedTable" cellspacing="0" >
<tr>
<td  class="cbFormLabelCell  cbFormLabel" valign="top">
<label for="InsertRecordCoApplicant_First_Name" >Reasons</label>
</td>


<td valign="top" class="cbFormLabelCell  cbFormLabel">
<select name="resources" style="width:300px" size="7" id="resources" multiple="multiple">
<%
                String sql3 = "select Options from db_gps.t_JourneyGoals where Categoery='Reson_AdhToJrm' order by UpdatedDateTime";
                ResultSet rs = st1.executeQuery(sql3);
                        int i=0;
                while(rs.next())
                {
                
                        %> <option value="<%=rs.getString("Options") %>" title="<%=rs.getString("Options") %>" ><%=rs.getString("Options") %></option>
                                        <%
        i++;
        }
              
        %>

</select>
</td>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<div><input type="button" class="button_text" style="border-style: outset; border-color: black" value="&gt;" onClick="addUser();" /></div>
<div><input type="button" class="button_text" style="border-style: outset; border-color: black" value="&lt;" onClick="removeUser()" /></div>
</td>
<td  valign="top" class="cbFormLabelCell  cbFormLabel">


<% 
int GreenFlgAdh=0;
try{
        
        
        
if(AdhJRM.equalsIgnoreCase("Yes"))
{
        
%>
        <script  language="javascript">
        try{
         var Val21 = document.getElementsByName("ChkAdh");
          for ( var i = 0; i < Val21.length; i++ ) 
                  {if(Val21[i].value=='Yes')
                                {                               
                                Val21[i].checked=true;  
                                <%GreenFlgAdh=1;%>                      
                                }
                 }      
        }catch(e)
        {
        alert(e);
                }
        
        </script>
<%
}
}catch(Exception e)
{
        System.out.println(e);
}


try{
if(AdhJRM.equalsIgnoreCase("No"))
{
%>
        <script  language="javascript">
        try{
         var Val21 = document.getElementsByName("ChkAdh");
          for ( var i = 0; i < Val21.length; i++ ) 
                  {if(Val21[i].value=='No')
                                {                               
                                Val21[i].checked=true;
                                showtext();     
                                <%
                                flgAdh=1;
                                GreenFlgAdh=1;
                                
                                %>                      
                                }
                 }      
        }catch(e)
        {
        alert(e);
                }
        
        </script>
<%
}
}catch(Exception e)
{
        System.out.println(e);
}
%>
<select name="assigned" style="width:300px" size="7" multiple="multiple">
<%
        if(flgAdh==1)
        {
        int b=0;
                String goal1;
            goal1=AdhJRMReason;
            StringTokenizer stk = new StringTokenizer(goal1,"~");
            b=stk.countTokens();
             while(stk.hasMoreTokens())
                {
                    goal1=stk.nextToken();
                    %>
                     <option  ><%=goal1 %></option>
                            <%
                }
          
            }
%>      
        
</select>
</td>

</tr>
</table>
</td>

</tr>
<tr>
<td></td>
<td colspan="7" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordCoApplicant_First_Name" >Adherance to Journey Plan
</label>
</td>

<td colspan="8" class="cbFormNestedTableContainer">
<table  class="cbFormNestedTable" cellspacing="0">

<tr>
<td  class="cbFormFieldCell"><input type="radio" name="ChkAdhJ" id="ChkAdhJ" value="Yes"  onclick="showtext1()"></input></td>
<td  class="cbFormFieldCell"><label for="InsertRecordCoApplicant_First_Name" >YES</label>&nbsp;<b><blink><font id="JRMPer1" color="red" size="3"></font></blink></b></td>
</tr>
<tr>
<td  class="cbFormFieldCell"><input type="radio" name="ChkAdhJ" id="ChkAdhJ" value="No" onclick="showtext1()" ></input></td>
<td  class="cbFormFieldCell"><label for="InsertRecordCoApplicant_First_Name" >NO</label></td>
</tr>
</table>

</td>
</tr>

</table>
</td>

</tr>
<tr id="tr2" style="display: none;">
<td>
</td>
<td colspan="7" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>

<td  class="cbFormLabelCell  cbFormLabel"><label for="InsertRecordCoApplicant_First_Name" >Reasons</label></td>

<td  class="cbFormFieldCell">
<table  class="cbFormNestedTable" cellspacing="0" >
<tr>

<td valign="top" class="cbFormLabelCell  cbFormLabel">
<select name="resources2" style="width:300px" size="7" id="resources2" multiple="multiple">
<%
                String sql2 = "select Options from db_gps.t_JourneyGoals where Categoery='Reson_AdhToJourney' order by UpdatedDateTime";
                ResultSet rs2 = st2.executeQuery(sql2);
             
                int i2=0;
                while(rs2.next())
                {
                                %>
                         <option value="<%=rs2.getString("Options") %>"title="<%=rs2.getString("Options") %>"  ><%=rs2.getString("Options") %></option>
                                        <%
        i2++;
        }
        
        %>

</select>
</td>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<div><input type="button" class="button" value="&gt;" onClick="addUser2();" /></div>
<div><input type="button" class="button" value="&lt;" onClick="removeUser2()" /></div>
</td>
<td align="center" valign="top" class="cbFormLabelCell  cbFormLabel">
<% 
try{
if(AdhJourney.equalsIgnoreCase("Yes"))
{
%>
        <script  language="javascript">
        try{
         var Val22 = document.getElementsByName("ChkAdhJ");
          for ( var i = 0; i < Val22.length; i++ ) 
                  {if(Val22[i].value=='Yes')
                                {                               
                                Val22[i].checked=true;                          
                                }
                 }      
        }
        catch(e)
        {
        alert(e);
        }
        
        </script>
<%
}
}catch(Exception e)
{
        System.out.println(e);
}


try{
if(AdhJourney.equalsIgnoreCase("No"))
{
%>
        <script  language="javascript">
        try{
         var Val22 = document.getElementsByName("ChkAdhJ");
          for ( var i = 0; i < Val22.length; i++ ) 
                  {if(Val22[i].value=='No')
                                {                               
                                Val22[i].checked=true;
                                showtext1();    
                                <%
                                flgAdhJ=1;
                                %>                      
                                }
                 }      
        }catch(e)
        {
        alert(e);
                }
        
        </script>
<%
}
}catch(Exception e)
{
        System.out.println(e);
}
%>
<select name="assigned2" style="width:300px" size="7" multiple="multiple">
<%
if(flgAdhJ==1)
        {
        int b=0;
                String goal1;
            goal1=AdhJourneyReason;
            StringTokenizer stk = new StringTokenizer(goal1,"~");
            b=stk.countTokens();
          
                while(stk.hasMoreTokens())
                {
                    goal1=stk.nextToken();
                    %>
                     <option title="<%=goal1 %>" ><%=goal1 %></option>
                            <%
                }
          
            }
%>      
        
</select>
</td>
</tr>
</table>
</td>
</tr>

</table>
</td>
</tr>


</table>
</td>
</tr>




<tr class="cbFormTableRow" align="center">
<td colspan="8" class="cbFormNestedTableContainer" align="center">
<div align="center" >
<table  class="cbFormNestedTable" align="center" cellspacing="0">
<tr align="center" >
<td align="center" colspan="4"><br><input type="button" class="button_text" style="border-style: outset; border-color: black" value="Save" onclick="GetAdherance('<%=DriveId %>','<%=TripId %>')"/></td>        
<!--<td align="center" colspan="2"><br><input type="button" class="Edit" value="Edit"  /></td>  -->
<td align="center" colspan="4"><br><input type="button" class="button_text" style="border-style: outset; border-color: black" value="Reset" onclick="AdhReset()" /></td>        
</tr>
</table>
</div>
</td>
</tr>

</table>
</td>

</tr>
</table>
</div>



<div style="background:#FAFAFE;width:950px;margin-left: 200px">
<%
int flg113=0;
String colorFeed="";
if(FeedBack==""||FeedBack==null||FeedBack=="-"||FeedBack.equalsIgnoreCase("")||FeedBack.equalsIgnoreCase("null")||FeedBack.equalsIgnoreCase("-"))
{       colorFeed="#FF5959";   
		flg113=0;
}       
else
{colorFeed="#56C556"; 
		flg113=1;
}
%>
<input type="hidden" id="Tab3" name="Tab3" value="<%=flg113 %>"></input>
<h2 style="background:<%=colorFeed %>; color:#000000; cursor:pointer;" onClick="Displayer(3)">&nbsp;+ 3. Feedback&nbsp;</h2>
<div style="text-align: center;">
<table id="Section3" style="display:none;" border="0" align="center">
<tr align="center">





<td class="cbFormNestedTableContainer" align="center">

<table  class="cbFormNestedTable" cellspacing="0" >

<tr class="cbFormTableRow" align="center">

<td colspan="8" class="cbFormNestedTableContainer" align="center">
<div align="center">
<table  class="cbFormNestedTable" align="center" cellspacing="0">
<tr align="center">
<td  align="center" class="cbFormLabelCell  cbFormLabel" colspan="8"><label for="InsertRecordFirst_Name" >Enter Feedback..</label></td>
</tr>
<tr align="center">

<td align="center" class="cbFormLabelCell  cbFormLabel" colspan="8"><textarea id="Feedback" name="Feedback" cols="60" rows="8"><%=FeedBack %></textarea></td>

</tr>
</table>
</div>
</td>
</tr>

<tr class="cbFormTableRow" align="center">

<td colspan="8" class="cbFormNestedTableContainer" align="center">
<div align="center">
<table  class="cbFormNestedTable" align="center" cellspacing="0">
<tr>
<td align="center" colspan="4"><br><input type="button" class="button_text" style="border-style: outset; border-color: black" value="Save"  onclick="GetFeedback('<%=DriveId %>','<%=TripId %>')" /></td>       
<td align="center" colspan="4"><br><input type="button" class="button_text" style="border-style: outset; border-color: black" value="Reset" onclick="FeedbackReset()" /></td>   
</tr>
</table>
</div>
</td>
</tr>
</table>

</td>

</tr>
</table>
</div>
</div>

<%
String colorGoals="";
int flg114=0;
if(GoalsAchived==""||GoalsAchived==null||GoalsAchived=="-"||GoalsAchived.equalsIgnoreCase("")||GoalsAchived.equalsIgnoreCase("null")||GoalsAchived.equalsIgnoreCase("-"))
{       colorGoals="#FF5959";  
flg114=0;
}       
else
{colorGoals="#56C556";  
flg114=1;
}

%>

<input type="hidden" id="Tab4" name="Tab4" value="<%=flg114 %>"></input>
<div style="background:#FAFAFE;width:950px;margin-left: 200px ">
<h2 style="background:<%=colorGoals %>; color:#000000; cursor:pointer;" onClick="Displayer(4)">&nbsp;+ 4. Goals Achieved&nbsp;</h2>
<div style="text-align: center;">
<table id="Section4" style="display:none;" border="0">
<tr>

<td  class="cbFormNestedTableContainer">
<table  class="cbFormNestedTable" cellspacing="0" border="0">
	<tr>

<td colspan="8" class="cbFormNestedTableContainer" align="center">
<div  align="center">
<table  border="0" align="center">
<tr>

<td  class="cbFormLabelCell  cbFormLabel" colspan="0">
<label for="InsertRecordCoApplicant_First_Name" >Goals set at the time of briefing  :</label>
</td>
<td></td>
<td  class="cbFormLabelCell  cbFormLabel" colspan="0">
<label for="InsertRecordCoApplicant_First_Name" >Goals Achieved :</label>
</td>

</tr>
<tr class="cbFormTableRow" align="center" style="overflow: auto;">
<td valign="top" class="cbFormLabelCell  cbFormLabel">                          
<select name="resources3" style="width:300px" size="8" id="resources3" multiple="multiple">             
        <%
                        
        String sql4 = "SELECT GoalsToBeAchieved FROM t_briefing WHERE driverid = '"+DriveId+"' AND tripid='"+TripId+"' order by updateddt DESC";        
        ResultSet rs4 = st3.executeQuery(sql4);
                
                String str4="-";
                if(rs4.next())
                {                       
                try{
                	
                        if((rs4.getString("GoalsToBeAchieved")==null|| rs4.getString("GoalsToBeAchieved").equalsIgnoreCase("null")))
                        {
                        	str4="Goals not Set";
                        }
                        else{
                        	str4=rs4.getString("GoalsToBeAchieved");
                                }
                }
                catch(Exception e)
                        {
                	str4="Goals not Set";
                	System.out.println("Goals Exception"+e);
                        }
                }else
                { 
                	str4="Goals not Set"; 
                	
                }
                
                
                  String[] tempe;
                  if(str4.equalsIgnoreCase("-"))
                  {
                          
                  }
                  else{
                  String delimiter = "~";
                  tempe = str4.split(delimiter);
                 
                  
                  for(int i4 =0; i4 < tempe.length ; i4++)
                  { 
                        %>
                         <option value="<%=tempe[i4] %>" title="<%=tempe[i4] %>"><%=tempe[i4] %></option>
                        <%
                  }
                  }
        %>
        
        
</select></td>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<div><input type="button" class="button" value="&gt;" onClick="addUser3();" /></div>
<div><input type="button" class="button" value="&lt;" onClick="removeUser3()" /></div>
</td>
<td align="center" valign="top" class="cbFormLabelCell  cbFormLabel">
<select name="assigned3" id="assigned3" style="width:300px" size="8" multiple="multiple">
        <% 
        
       
        try{
        if(GoalsAchived.equalsIgnoreCase("-"))
        {
            
        }
        else{
                String goal1;
            goal1=GoalsAchived;
            StringTokenizer stk = new StringTokenizer(goal1,"~");
           
                while(stk.hasMoreTokens())
                {
                    goal1=stk.nextToken();
                    %>
                     <option title="<%=goal1 %>"  ><%=goal1 %></option>
                            <%
                }
           
          
        }    
        }
        catch(Exception e)
        {
                GoalsAchived="-";
                
        }
%>      
        
        
        
</select>
</td>

</tr>
</table>
</div>
</td>

</tr>
<tr>
<td colspan="8" class="cbFormNestedTableContainer" align="center">
<div align="center">
<table  class="cbFormNestedTable" align="center" cellspacing="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel"></td>
<td align="center" colspan="4"><br><input type="button" class="button_text" style="border-style: outset; border-color: black" value="Save"  onclick="GetGoals('<%=DriveId %>','<%=TripId %>')" /></td>  
<!--<td align="center" colspan="2"><br><input type="button" class="Edit" value="Edit"  /></td>  -->
<td align="center" colspan="4"><br><input type="button" class="button_text" style="border-style: outset; border-color: black" value="Reset" onclick="GoalsReset()" /></td>      

</tr>
</table>
</div>
</td>
</tr>

</table>
</td>

</tr>
</table>
</div>
</div>
<% 
int flgnews=0;
%>
<div style="background:#FAFAFE;width:950px;margin-left: 200px ">
			<input type="hidden" id="Tab6" name="Tab6" value="<%=flgnews%>"></input>
			<h2
				style="background:<%=colorGoals%>; color:#000000; cursor:pointer;"
				onClick="Displayer(6)">&nbsp;+ 5. Personal Engagement&nbsp;</h2>
			<table id="Section6" style="display: none;">
				<tr>
					<td colspan="4" class="cbFormNestedTableContainer">
					<div>
					<table class="cbFormNestedTable" cellspacing="0">
					<tr>
					
					<% 
					driveraddress=""; 
					String sqld="select driver_address from db_gps.t_drivers where DriverID='"+DriveId+"'";
					ResultSet rsd=std.executeQuery(sqld);
					if(rsd.next())
					{
						driveraddress=rsd.getString("driver_address");
					}
					if(driveraddress==null || driveraddress.equalsIgnoreCase("NULL")){
						driveraddress="";
					}
					
					//driveraddress="At-Po-Kothali,TQ-Motala, Dist-Buldhana";
				 String sqln="select Newsletter from t_debriefing where Driverid='"+ DriveId+"'";
				ResultSet rsn=stn.executeQuery(sqln);
				while(rsn.next())
				{
					newsletter=rsn.getString("Newsletter");
				
					newsletter1=newsletter;
					newsletter1="'"+newsletter1+"'";
					newsletter=newsletter+",";
					news=news+","+newsletter1;
					
					
				}
				try{
				newsletter=newsletter.substring(0, newsletter.length()-1);
				}catch(Exception e)
				{
					
					e.printStackTrace();
				}
				//	newsletter="News1,News2";
					
					%>
					
					<td class="cbFormLabelCell  cbFormLabel" colspan="0"><label
								for=""><b>Driver Address:</b> </label></td>
							<td><textarea id="driveradd" name="driveradd"  
												rows="2" cols="35" readonly="readonly"><%=driveraddress%></textarea></td>
												<td><button id="driveraddr" value="Edit" name="edit" height="150" onclick="return clear1();" width="100">Edit</button>
												</td>
			</tr>
			
			<tr>
			<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>Newsletter Shared :</b> </label>
								<label><%=newsletter %></label>
								</td>
								
			   
			</tr>
			
			<tr>
			<td class="cbFormLabelCell  cbFormLabel" colspan="2"><label
								for=""><b>Newsletter Shared In This Session:</b> </label> <select
								class="element select medium" id="Innewletter" name="Innewletter"
								 style="width: 150px">
								 <option value="Select" selected="selected">Select</option>
					<%	
					//String sqlnews="select Newsletter from t_briefing where Driverid='"+ DriveId+"' and Newsletter not in ("+news+")";
					String sqlnews="select Options from db_gps.t_JourneyGoals where Categoery='newsletter_shared' and  Options not in ("+news+")";
					System.out.println("sqlnews:-"+sqlnews);
					ResultSet rsnews=stnews.executeQuery(sqlnews);
					while(rsnews.next())
					{
					%>			
								<option value=<%=rsnews.getString("Options") %>> <%=rsnews.getString("Options") %></option>
								
								
								
							<%} %>
							</select>	
								</td>
			</tr>
			
			<tr>
									<td class="cbFormLabelCell  cbFormLabel">
									<td></td>
									<td align="center" colspan="2"><br>
									<input type="button" class="button_text"
										style="border-style: outset; border-color: black" value="Save"
										onclick="GetNews('<%=DriveId%>','<%=debriefid%>','<%=TripId%>','<%=request.getParameter("driveradd")%>')" /></td>
									
									<!-- <td align="center" colspan="2"><br>
									<input type="button" value="Reset" onclick="IncReset()"
										class="button_text"
										style="border-style: outset; border-color: black" /></td> -->
								</tr>
			</table>
			</div>
			
			</table>
			</div>

<%
String TripCat="";
if(category=="Tanker"||category.equalsIgnoreCase("Tanker"))
{
	TripCat="tanker";
	}else
	{
		TripCat="prisec";
	}
DateFormat df1= new SimpleDateFormat("MM-dd-yyyy");
DateFormat dfDB1=new SimpleDateFormat("yyyy-MM-dd");
DateFormat dfFE1=new SimpleDateFormat("dd-MMM-yyyy"); 
Calendar Cal = Calendar.getInstance();
Calendar Cal1 = Calendar.getInstance();
Cal.add(Calendar.MONTH, -2);
Cal1.add(Calendar.MONTH, 0); 
String ld=(Cal.get(Calendar.MONTH)+1)+"-"+Cal.get(Calendar.DATE)+"-"+Cal.get(Calendar.YEAR);
String ystday=dfDB1.format(df1.parse(ld));
System.out.println("ystday : "+ystday); 

 Cal.set(Calendar.DAY_OF_MONTH,Cal.getActualMinimum(Calendar.DAY_OF_MONTH));
setTimeToBeginningOfDay(Cal);        
String begining=(Cal.get(Calendar.MONTH)+1)+"-"+Cal.get(Calendar.DATE)+"-"+Cal.get(Calendar.YEAR);
begining=dfDB1.format(df1.parse(begining));
System.out.println("Month Start : "+begining);

Cal1.set(Calendar.DAY_OF_MONTH,Cal1.getActualMaximum(Calendar.DAY_OF_MONTH));
setTimeToEndofDay(Cal1);
String end=(Cal1.get(Calendar.MONTH)+1)+"-"+Cal1.get(Calendar.DATE)+"-"+Cal1.get(Calendar.YEAR);
end=dfDB1.format(df1.parse(end));
System.out.println("Month End : "+end);

System.out.println(begining);

String MonthStartDate=dfDB1.format(df1.parse(begining));
String MonthEndDate=dfDB1.format(df1.parse(end));
%>

<div style="background:#FAFAFE; width:950px;margin-left: 200px ">
<h2 style="background:#7979FF; color:#000000; cursor:pointer;" onClick="Displayer(5)">&nbsp;+ 6. Incentive&nbsp;</h2>
             
<table id="Section5" style="display:none;">
<tr>
<%
System.out.println("RRRRRRR"+TripCat);

%>
<td><font size="2"><a target="_blank" href="StopOverride.jsp?tripid=<%=TripId%>&vid=<%=VehCodeN%>&vehRegNo=<%=VehRNo22%>&Transporter=<%=Transporter%>&SD=<%=StartDateDbFormat%>&ED=<%=EndDateDBFormat %>">Stoppage Override</a></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2"><a target="_blank" href="driverIncentiveShowTrips.jsp?driverid=<%=DriveId %>&category=<%=TripCat %>&month=<%=begining %>&month1=<%=end%>">Driver Quarterly Incentive Report</a></font>
</td>

</tr>
<tr>
<td align="left">
<font size="2" color="BLACK"> Disclaimer : The Calculated Amount may change if there is a change in the status or count of Violation</font> 
</td> 	
</tr>
<tr>
<td> 
<%
////////////////////////////////////////////////////
			DateFormat df= new SimpleDateFormat("MM-dd-yyyy");
			DateFormat dfDB=new SimpleDateFormat("yyyy-MM-dd");
			DateFormat dfFE=new SimpleDateFormat("dd-MMM-yyyy"); 
	    	String NDStartTime = "",NDStopTime = "",stopdur = "";
	    	int maxdvi=0,maxjrm=0;
	    	sql = "select NightDrivingFromTime,NightDrivingToTime from db_gps.t_defaultvals where ownername = 'castrol' ";
	    	System.out.println("1 : "+sql);
			 rs = st.executeQuery(sql);
			 if(rs.next())
			 {
				 NDStartTime = rs.getString("NightDrivingFromTime");
				 NDStopTime = rs.getString("NightDrivingToTime");
			 }
	    	
			 sql = "select Duration from db_gps.t_DriverIncentive where ScoreCategory = 'StopDuration'  ";
			 rs = st.executeQuery(sql);
			 if(rs.next())
			 {
				 stopdur = rs.getString("Duration");
			 }
			 
			 sql="select points from db_gps.t_DriverIncentive where MinValue<='0.00' and MaxValue>='0.00' and ScoreCategory='DVI' and GPName='Castrol'";
			 rs= st.executeQuery(sql);
			 if(rs.next())
			 {
				 maxdvi=rs.getInt("points");
			 }
			 
			 sql="select points from db_gps.t_DriverIncentive where ScoreCategory='JRM' and GPName='Castrol'";
			 rs= st.executeQuery(sql);
			 if(rs.next())
			 {
				 maxjrm=rs.getInt("points");
			 }		 
			 
			 sql="Select Tripid,TripRating,Tripid,KmTravelled,startdate,enddate,vehid,tankerreturntripstatus,StartPlace,EndPlace from db_gps.t_completedjourney where  driverid = '"+DriveId+"' AND TripID='"+TripId+"'  and GPName = 'Castrol' ";
			System.out.println(sql);
			 rs = st.executeQuery(sql);
			if(rs.next())
				{
				 int DVIPoint=0,JRMPoint=0,runhrvio = 0,stcount = 0;
				 int NDCount1=0,racount = 0,rdcount = 0,oscount = 0;
				 String CRCount1="0";
				 int DisconnectionCount=0;
				 String vehid = rs.getString("vehid");
				 double TripRating = 0.0,osduration = 0.0,AC = 0,DC = 0,os = 0;
				 double kmtravelled = rs.getDouble("KmTravelled");
				 String Tripid =rs.getString("Tripid");
				 String JRMStatus = "No",stopsmorethan4hrs = "No";
				 String startdate = rs.getString("startdate");
				 String enddate = rs.getString("enddate");
				 String vehcode = rs.getString("vehid");
				 String origin = rs.getString("StartPlace");
				 String Destination = rs.getString("EndPlace");
				 String returntripstatus = rs.getString("tankerreturntripstatus");
				 String date1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdate));
				 String date2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate));
				 java.util.Date date5 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
				 java.util.Date date6 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
				 String date7 = "";
				 boolean flag = true,calcenddateDH = true;
				 if(date5 == date6)
				 	{
				 		date7 = date2;
				 		calcenddateDH = false;
				 	}
				 	else
				 	{
				 		Calendar cal = Calendar.getInstance();
				 		cal.setTime(date6);
				 		cal.add(Calendar.DAY_OF_MONTH,-1);
				 		java.util.Date yesterday = cal.getTime();
				 		date7 =new SimpleDateFormat("yyyy-MM-dd").format(yesterday);
				 		calcenddateDH = true;
				 	}
				 
					  sql3 = "select count(*) as cnt from db_gpsExceptions.t_vehall_ds where thedate >= '"+date1+"' and thedate <= '"+date7+"' and RDuration > '10:00:00' and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
					  ResultSet rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 flag = false;
						 runhrvio = rs3.getInt("cnt");
					 }
					
					 if(calcenddateDH == true)
					 {
						 sql3 = "select *  from db_gpsExceptions.t_vehall_ds where thedate = '"+date2+"'  and RDuration > '10:00:00' and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
						 rs3 = st1.executeQuery(sql3);
						 if(rs3.next())
						 {
								String drivstart = "",predatetime = "",currdatetime = "";
								long runtime = 0,timediff = 0,timediffinsec = 0,runhrs = 0,excludedtimediffinsec = 0;
								int prespeed = 0,currspeed = 0,previousRecordDistance=0,currentRecordDistance=0,processedDistanceDiff=0;
								double RunKM = 0,ExcludedDist =0,ExcludedDist1 = 0;
								sql3 = "select * from db_gps.t_veh"+vehcode+" where thefielddatadate = '"+date2+"'  and speed > 0 and thefiledtextfilename in ('SI','ON','OF','ST','SP')  order by thefielddatadatetime asc limit 1 ";
								rs3 = st2.executeQuery(sql3);
								if(rs3.next())
								{
									drivstart = rs3.getString("thefielddatadatetime");
								}
								
								sql3 = "select * from db_gps.t_veh"+vehcode+" where thefielddatadatetime >= '"+drivstart+"' and thefielddatadatetime <= '"+enddate+"' and thefiledtextfilename in ('SI','ON','OF','ST','SP')";
								rs3 = st2.executeQuery(sql3);
								while(rs3.next())
								{
									predatetime = rs3.getString("thefielddatadatetime");
									prespeed = (int)Double.parseDouble(rs3.getString("speed"));
									previousRecordDistance = (int)Double.parseDouble(rs3.getString("Distance"));
									if(rs3.next())
									{
										currdatetime = rs3.getString("thefielddatadatetime");
										currspeed =   (int)Double.parseDouble(rs3.getString("speed"));
										currentRecordDistance = (int)Double.parseDouble(rs3.getString("Distance"));
										processedDistanceDiff = currentRecordDistance - previousRecordDistance;
										String TimeDiff = "select Time_To_Sec(TIMEDIFF('"+currdatetime+"','"+predatetime+"')) as ftimediff";
										ResultSet rstimediff = st3.executeQuery(TimeDiff);
										if(rstimediff.next())
										{
											timediffinsec=rstimediff.getLong("ftimediff");
											timediff=timediffinsec/60; 
										}
										
										if((timediffinsec)>900)  //GAP (comparison in sec)
										{
											if(processedDistanceDiff != 0) //RUN
											{
												RunKM=(processedDistanceDiff);
												ExcludedDist = RunKM ;
												ExcludedDist1=ExcludedDist1+ExcludedDist;
												double excludedtimehrs=(ExcludedDist/30); 
												excludedtimediffinsec = (long) (excludedtimehrs*3600); // time diff using 30 avg speed
												if(timediffinsec<excludedtimediffinsec) 
												{
													runtime = runtime + timediffinsec; 
												}
												else
												{
													runtime=runtime+excludedtimediffinsec;
												}
											}
										}
										else
										{
											if((prespeed>0 && currspeed>0) || (prespeed>0 && currspeed == 0))
											{  
												runtime = runtime + timediffinsec;
											}
										}
									}
									rs3.previous();
								}
								runhrs = runtime/60/60;
								if(runhrs >10)
								{
									flag = false;
									runhrvio ++;
								}
						 }
					 }
					 
					 sql3 = "select count(*) as cnt from db_gpsExceptions.t_vehall_ra where TheDatetime >= '"+startdate+"' and TheDatetime <= '"+enddate+"'  and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
					 rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 racount = rs3.getInt("cnt");
					 }
					 
					 sql3 = "select count(*) as cnt from db_gpsExceptions.t_vehall_rd where TheDatetime >= '"+startdate+"' and TheDatetime <= '"+enddate+"'  and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
					 rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 rdcount = rs3.getInt("cnt");
					 }
					 
					 sql3 = "select sum(duration) as duration,count(*) as oscount from db_gpsExceptions.t_vehall_overspeed where FromDatetime >= '"+startdate+"' and FromDatetime <= '"+enddate+"'  and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
					 rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 osduration = rs3.getDouble("duration");
						 oscount = rs3.getInt("oscount");
					 }
					 
					 if(kmtravelled > 0)
					 {
						 	AC = (racount/kmtravelled) * 100;
							DC = (rdcount/kmtravelled) * 100;
							os = ((osduration / 10)/kmtravelled) * 100;
							TripRating = (AC + DC + os);
					 }
					 else
					 {
						 TripRating = 0.0;
					 }
					 
					 sql3 = "select count(*) as cnt from db_gpsExceptions.t_vehall_nd where FromDatetime >= '"+startdate+"' and FromDatetime <= '"+enddate+"'  and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
					  rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 NDCount1 = rs3.getInt("cnt");
					 }
					 
					 sql3 = "select count(*) as cnt from db_gpsExceptions.t_vehall_crcopy where FromDatetime >= '"+startdate+"' and FromDatetime <= '"+enddate+"'  and VehCode = '"+vehid+"' and OverrideStatus = 'Open' ";
					 rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 CRCount1 = rs3.getString("cnt");
					 }
					 
					 sql3 = "select count(*) as cnt from db_gps.t_disconnectionData where tripid like'%"+Tripid+"%'   and OverrideStatus = 'Open' and Reason='Disconnection'  and Duration >= '0:30' ";
					 rs3 = st1.executeQuery(sql3);
					 if(rs3.next())
					 {
						 DisconnectionCount = rs3.getInt("cnt");
					 }
					 
						  sql4 = "SELECT * FROM db_gpsExceptions.t_vehall_stsp WHERE fromdatetime >= '"+startdate+"'  AND fromdatetime <= '"+enddate+"' AND duration >= '"+stopdur+"' AND fromtime >= '"+NDStopTime+"' AND fromtime <= '"+NDStartTime+"' AND vehcode = '"+vehcode+"'  and OverrideStatus = 'Open'";
						 rs4 = st1.executeQuery(sql4);
						while(rs4.next())
						{
							long timediff1 = 0,timediffinhrs = 0;
							sql3 = "select Time_To_Sec(TIMEDIFF('"+rs4.getString("fromdate")+" "+NDStartTime+"','"+rs4.getString("fromdatetime")+"')) as ftimediff";
							rs3 = st2.executeQuery(sql3);
							if(rs3.next())
							{
								timediff1 = rs3.getLong("ftimediff");
							}
							timediffinhrs = timediff1/60/60;
							
							if(timediffinhrs>= 4)
							{
								String thedate = "",thedate1 = "";
								sql3 = "select ADDTIME('"+rs4.getString("fromdatetime")+"','04:00:00' ) as thedate";
								rs3 = st2.executeQuery(sql3);
								if(rs3.next())
								{
									thedate = rs3.getString("thedate");
								}
								thedate1 = enddate;
								
								java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate);
								java.util.Date date4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(thedate1);
								
							if(date3.before(date4) || date3 == date4)
							{
							String drivstart = "",predatetime = "",currdatetime = "";
							long runtime = 0,timediff = 0,timediffinsec = 0,runhrs = 0,excludedtimediffinsec = 0;
							int prespeed = 0,currspeed = 0,previousRecordDistance=0,currentRecordDistance=0,processedDistanceDiff=0;
							double RunKM = 0,ExcludedDist =0,ExcludedDist1 = 0;
							sql3 = "select * from db_gps.t_veh"+vehcode+" where thefielddatadate = '"+rs4.getString("FromDate")+"'  and speed > 0 and thefiledtextfilename in ('SI','ON','OF','ST','SP')  order by thefielddatadatetime asc limit 1 ";
							rs3 = st2.executeQuery(sql3);
							if(rs3.next())
							{
								drivstart = rs3.getString("thefielddatadatetime");
							}
							
							sql3 = "select * from db_gps.t_veh"+vehcode+" where thefielddatadatetime >= '"+drivstart+"' and thefielddatadatetime <= '"+rs4.getString("FromDate")+" "+rs4.getString("FromTime")+"' and thefiledtextfilename in ('SI','ON','OF','ST','SP')";
							rs3 = st2.executeQuery(sql3);
							while(rs3.next())
							{
								predatetime = rs3.getString("thefielddatadatetime");
								prespeed = (int)Double.parseDouble(rs3.getString("speed"));
								previousRecordDistance = (int)Double.parseDouble(rs3.getString("Distance"));
								if(rs3.next())
								{
									currdatetime = rs3.getString("thefielddatadatetime");
									currspeed =  (int)Double.parseDouble(rs3.getString("speed"));
									currentRecordDistance = (int)Double.parseDouble(rs3.getString("Distance"));
									processedDistanceDiff = currentRecordDistance - previousRecordDistance;
									
									String TimeDiff = "select Time_To_Sec(TIMEDIFF('"+currdatetime+"','"+predatetime+"')) as ftimediff";
									ResultSet rstimediff = st3.executeQuery(TimeDiff);
									if(rstimediff.next())
									{
										timediffinsec=rstimediff.getLong("ftimediff");
										timediff=timediffinsec/60; 
									}
									
									if((timediffinsec)>900)  //GAP (comparison in sec)
									{
										if(processedDistanceDiff != 0) //RUN
										{
											RunKM=(processedDistanceDiff);
											ExcludedDist = RunKM ;
											ExcludedDist1=ExcludedDist1+ExcludedDist;
											double excludedtimehrs=(ExcludedDist/30); 
											excludedtimediffinsec = (long) (excludedtimehrs*3600); // time diff using 30 avg speed
											if(timediffinsec<excludedtimediffinsec) 
											{
												runtime = runtime + timediffinsec; 
											}
											else
											{
												runtime=runtime+excludedtimediffinsec;
											}
										}
									}
									else
									{
										if((prespeed>0 && currspeed>0) || (prespeed>0 && currspeed == 0))
										{  
											runtime = runtime + timediffinsec;
										}
									}
								}
								rs3.previous();
							}
							runhrs = runtime/60/60;
							if(runhrs >=10)
							{
								flag = true;
							}
							else
							{
								flag = false;
								stopsmorethan4hrs = "Yes";
								stcount ++;
							}
								}
						}
				}
					 
				//	System.out.println(Tripid);	
					 if((NDCount1==0)&&(CRCount1=="No"||CRCount1.equalsIgnoreCase("No")||CRCount1.equals("0"))&&(DisconnectionCount==0) && (runhrvio == 0) && (stcount==0))
					 {
					//String sql1="Select * from db_gps.t_DriverIncentive where MinValue<='"+TripRating+"' and MaxValue>='"+TripRating+"' and `ScoreCategory`='DVI' and GPName='Castrol'";
					String sql1="SELECT Points FROM db_gps.t_DriverIncentive WHERE MinValue<='"+TripRating+"' AND MaxValue>='"+TripRating+"' AND `ScoreCategory`='DVI' AND GPName='Castrol'";
				//	System.out.println("sql1"+sql1);
					ResultSet rs1=st1.executeQuery(sql1);
					if(rs1.next())
						{
						DVIPoint=rs1.getInt("Points");
						}

					boolean proportionatejrm  = false;
                    sql1 = "select * from db_gps.t_jrmrouteadvancedmaster where StartPlace = '"+origin+"' and EndPlace = '"+Destination+"' ";
                    rs1 = st1.executeQuery(sql1);
                    if(rs1.next())
                    {
                            if(rs1.getInt("jrmpercent") < 100)
                            {
                                    proportionatejrm = true;
                            }
                    }
                    else
                    {
                            proportionatejrm = true;
                    }
                    
                    if(returntripstatus.equalsIgnoreCase("Return") || proportionatejrm== true)
                    {
                            if(DVIPoint == 0)
                            {
                                    JRMPoint = 0;
                            }
                            else
                            {
                                    double num1 = (double)DVIPoint/(double)maxdvi;
                                    double num2 = num1 *maxjrm;
                                    JRMPoint =(int)num2;
                            }
                            JRMStatus = "NA";
                    }
                    else
                    {                                       


					
					
					sql1="Select Briefid,AdhJRM,AdhJourney from db_gps.t_debriefing where tripid='"+Tripid+"' and AdhJRM='Yes' and AdhJourney='Yes'";
					System.out.println(sql1);
					rs1=st1.executeQuery(sql1);
					if(rs1.next())
						{
						 sql2="SELECT * FROM `t_DriverIncentive` WHERE `ScoreCategory` = 'JRM'and GPName='Castrol'"; 
						 rs2=st2.executeQuery(sql2);
						if(rs2.next())
							{
							JRMPoint=rs2.getInt("Points");
							JRMStatus = "Yes";
							}
						}
                    }
					 sql1="update db_gps.t_completedjourney set dvipoint='"+DVIPoint+"',jrmpoint='"+JRMPoint+"',JrmStatus='"+JRMStatus+"',RunHrVio='"+runhrvio+"',Stopsgreaterthan4hrs = '"+stcount+
					 		  "',OpenRA='"+racount+"',OpenRD='"+rdcount+"',OpenOS='"+oscount+"',OpenOSDur='"+osduration+"',OpenCD='"+CRCount1+"',OpenND='"+NDCount1+"',OpenDC='"+
					 		  DisconnectionCount+"',OpenRating='"+TripRating+"'  where TripID='"+Tripid+"'";
					 System.out.println(sql1);
					 st1.executeUpdate(sql1);						 
				 }	
				 else
				 {
					 String sql1="Select Briefid,AdhJRM,AdhJourney from db_gps.t_debriefing where tripid='"+Tripid+"' and AdhJRM='Yes' and AdhJourney='Yes'";
					System.out.println(sql1);
					ResultSet rs1=st1.executeQuery(sql1);
					if(rs1.next())
					{
						JRMStatus = "Yes";								
					}
					 
					 sql1="update db_gps.t_completedjourney set dvipoint='"+DVIPoint+"',jrmpoint='"+JRMPoint+"',JrmStatus='"+JRMStatus+"',RunHrVio='"+runhrvio+"',Stopsgreaterthan4hrs = '"+stcount+
					 		  "',OpenRA='"+racount+"',OpenRD='"+rdcount+"',OpenOS='"+oscount+"',OpenOSDur='"+osduration+"',OpenCD='"+CRCount1+"',OpenND='"+NDCount1+"',OpenDC='"+
					 		  DisconnectionCount+"',OpenRating='"+TripRating+"'  where TripID='"+Tripid+"' ";
					 System.out.println(sql1);
					 st1.executeUpdate(sql1);
				 }
				}			

////////////////////////////////////////////////////////////

System.out.println("11");
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
String exportFileName=session.getAttribute("user").toString()+"_DriverIncentiveForTankerReport.xls";  
int zerodvirate1 = 0,totaltrips = 0;
 sql = "";
 
 System.out.println("2");
if(category.equalsIgnoreCase("tanker"))	
{
	String sql1 = "SELECT * FROM `t_DriverIncentive` WHERE ScoreCategory = 'TankerRate'and GPName='Castrol'";
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		zerodvirate1 = rs1.getInt("Points");
	}
	 sql="Select * from db_gps.t_completedjourney where  tripid='"+TripId+"' AND DRIVERID='"+DriveId+"'";
}
else
{
	String sql1 = "SELECT * FROM `t_DriverIncentive` WHERE ScoreCategory = 'PrimaryRate'and GPName='Castrol'";
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		zerodvirate1 = rs1.getInt("Points");
	}
	
	sql1 = "Select count(*)  as cnt from db_gps.t_completedjourney where tripid='"+TripId+"' AND DRIVERID='"+DriveId+"'";
	rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		totaltrips = rs1.getInt("cnt");
	}		
	 sql="Select * from db_gps.t_completedjourney where  tripid='"+TripId+"' AND DRIVERID='"+DriveId+"'";

}
 rs= st.executeQuery(sql);

%>
<form id="last24hours" name="last24hours" action="" method="post" >

<div align="center">
<table >
<tr>
<td>
</td>
</tr>
<tr><td align="center">
<div align="center" id="table1">
<table class="sortable" style="width: 950px;">
<tr>
<th style="width: 20px;">Trip KM</th>
<th style="width: 20px;">RA</th>
<th style="width: 20px;">RD</th> 
<th style="width: 20px;">OS</th>
<th style="width: 20px;">OS Dur</th>
<th style="width: 20px;">CD</th>
<th style="width: 20px;">ND</th>
<th style="width: 20px;">DC</th>
<th style="width: 30px;">DH Vio</th>
<th style="width: 30px;">Stops Greater Than 4 hrs</th>
<th style="width: 30px;">Trip Rating</th>
<th style="width: 30px;">DVI Points</th>
<th style="width: 30px;">JRM Points</th>
<th style="width: 30px;">Adherence To JRM and JP</th>
<th style="width: 30px;">Distance & Points Based Incentive (A)</th>
<%
if(category.equalsIgnoreCase("tanker"))	
{
	%>
	<th style="width: 30px;">Tanker Zero DVI Incentive Rate</th>
	<%
}
else
{
	%>
	<th style="width: 30px;">Pri-Sec Zero DVI Incentive Rate</th>
	<%
}
%>
<th style="width: 30px;">Zero DVI Based Incentive (B)</th>
<th style="width: 40px;">Trip Incentive (A+B)</th>
</tr>
<%
int totmonthinc = 0;
i=1;
while(rs.next()){
 int trippoint = 0,zerodvirate=0,zerodviincentive = 0,totincentive = 0;    
 trippoint = (rs.getInt("KmTravelled") * (rs.getInt("dvipoint")+rs.getInt("jrmpoint")))/100;
 
 if(category.equalsIgnoreCase("tanker"))
 {
	 zerodvirate = zerodvirate1;
	 if(new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))).equals("0.00")  && (rs.getInt("dvipoint") > 0 || rs.getInt("jrmpoint") > 0))
	 {
		 zerodviincentive = zerodvirate1;
	 }
	 else
	 {
		 zerodviincentive = 0;
	 }
 }
 else
 {
	 if(totaltrips >= 5)
	 {
		 zerodvirate = zerodvirate1;
	 }
	 else
	 {
		 zerodvirate = 0;
	 }
	 if(new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))).equals("0.00") && (rs.getInt("dvipoint") > 0 || rs.getInt("jrmpoint") > 0))
	 {
		 zerodviincentive = zerodvirate;
	 }
	 else
	 {
		 zerodviincentive = 0;
	 }
 }
 
 totincentive = trippoint + zerodviincentive;
 totmonthinc = totmonthinc + totincentive;
 
%>
<tr>   
<td align="right"><div style="text-align: right;"><%=rs.getString("KmTravelled") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenRA") %></div></td> 
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenRD") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenOS") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenOSDur") %></div></td>
<td align="right"><div style="text-align: right;"><%
int CRCount1=0;
try{
CRCount1=rs.getInt("OpenCD");
out.print(CRCount1);
System.out.println("In Try CR : ");
}
catch(Exception e)
{
String CR=rs.getString("OpenCD");
String Vehid=rs.getString("Vehid");
if(CR.equalsIgnoreCase("Yes")||CR=="Yes")
{
	String sql1 = "SELECT count(*) as CRCount FROM db_gpsExceptions.t_veh"+Vehid+"_cr WHERE concat(FromDate, ' ',FromTime )>= '"+rs.getString("StartDate")+"'and concat(FromDate, ' ',FromTime )<= '"+rs.getString("EndDate")+"'";
	System.out.print("RRRR : "+sql1);
	ResultSet rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		CRCount1 = rs1.getInt("CRCount");
	}
}
out.print(CRCount1);	
System.out.println("In Catch  CR : ");
}



%></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenND") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenDC") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("RunHrVio") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("Stopsgreaterthan4hrs") %></div></td>
<td align="right"><div style="text-align: right;"><%=new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))) %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("dvipoint") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("jrmpoint") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("JrmStatus") %></div></td>
<td align="right"><div style="text-align: right;"><%=trippoint %></div></td>
<td align="right"><div style="text-align: right;"><%=zerodvirate %></div></td>
<td align="right"><div style="text-align: right;"><%=zerodviincentive%></div></td>
<td align="right"><div style="text-align: right;"><%=totincentive%></div></td></tr>
<%}
%>
<!-- <tr> -->
<!-- <th align="right" colspan="17"><div style="text-align: right;">Total Incentive  (grouped by month)</div></th> -->
<%-- <th align="right" colspan="1"><div style="text-align: right;">< % =totmonthinc%></div></th> --%>
<!-- </tr> -->
</table>


</td>
</tr>

</table>
</div>


                 </td>          
                 </tr>
                 </table>
                 </td>
                 </tr>
                 </table>
                 <div style="margin-left: 950px">

         <input type="button" class="button_text" style="border-style: outset; border-color: black" value="Exit"  onclick="GetFinal1('<%=DriveId %>','<%=TripId %>')" >
        <input type="button" class="button_text" style="border-style: outset; border-color: black" value="Complete Debriefing"  onclick="GetFinal('<%=DriveId %>','<%=TripId %>')" >
        
        </div>
         
        <%
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
        finally
        {
        	try
        	{fleetview.closeConnection();}	
        	catch(Exception e)
        	{}
        	con1.close();
        }
        
        %> 
 
 </td>
 </tr></table></form></body></jsp:useBean>
 <%@ include file="footernew.jsp" %>
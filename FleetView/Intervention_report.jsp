<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%-- 
	Document   : brif_driverbrifsum
	Created on : June 26, 2009, 1:32:17 PM
	Author     : vikram
--%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/calendar.js">
</script>
<script type="text/javascript">

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

         
         // alert("HI>>>>>>");
    
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  

         //  alert("11111");

           //try{
             document.aks.action ="excel.jsp";

         //  alert("222222");
          document.forms["aks"].submit();
        //  alert("33333");


           //}catch(e){alert("exception>>>"+e);}

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



function chk()
{

	
	
	var chkf="";
	var chkt="";
	var objFromDate = document.getElementById("data").value;
	var fdate=objFromDate.split("-");
	if(fdate[1]=="Jan")
	{
		chkf="01";
	}
	if(fdate[1]=="Feb")
	{
		chkf="02";
	}
	if(fdate[1]=="Mar")
	{
		chkf="03";
	}
	if(fdate[1]=="Apr")
	{
		chkf="04";
	}
	if(fdate[1]=="May")
	{
		chkf="05";
	}
	if(fdate[1]=="Jun")
	{
		chkf="06";
	}
	if(fdate[1]=="Jul")
	{
		chkf="07";
	}
	if(fdate[1]=="Aug")
	{
		chkf="08";
	}
	if(fdate[1]=="Sep")
	{
		chkf="09";
	}
	if(fdate[1]=="Oct")
	{
		chkf="10";
	}
	if(fdate[1]=="Nov")
	{
		chkf="11";
	}
	if(fdate[1]=="Dec")
	{
		chkf="12";
	}
	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
    var objToDate = document.getElementById("data1").value;
    var tdate=objToDate.split("-");
    if(tdate[1]=="Jan")
	{
    	chkt="01";
	}
	if(tdate[1]=="Feb")
	{
		chkt="02";
	}
	if(tdate[1]=="Mar")
	{
		chkt="03";
	}
	if(tdate[1]=="Apr")
	{
		chkt="04";
	}
	if(tdate[1]=="May")
	{
		chkt="05";
	}
	if(tdate[1]=="Jun")
	{
		chkt="06";
	}
	if(tdate[1]=="Jul")
	{
		chkt="07";
	}
	if(tdate[1]=="Aug")
	{
		chkt="08";
	}
	if(tdate[1]=="Sep")
	{
		chkt="09";
	}
	if(tdate[1]=="Oct")
	{
		chkt="10";
	}
	if(tdate[1]=="Nov")
	{
		chkt="11";
	}
	if(tdate[1]=="Dec")
	{
		chkt="12";
	}
    var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
   // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
     
    var date1 = new Date(objFromDate1);
    var date2 = new Date(objToDate1);
    
    //alert("from > "+date1+" Todate > "+date2);
    
    var date3 = new Date();
    var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
    var currentDate = new Date(date4);
     
        if(date1 > date2)
        {
            alert("From Date Should be Less Than To Date");
            return false; 
        }
//         else if(date1 > currentDate)
//         {
//             alert("From Date should be less than current date");
//             return false; 
//         }
//         else if(date2 > currentDate) 
//         {
//             alert("To Date should be less than current date");
//             return false; 
//         }

        return true;
	
}
function datevalidate()
{	
//alert("Hi===>");
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;

//alert(date1);
//alert(date2);
	dy1=date1.substring(7,11);
	dy2=date2.substring(7,11);
	dm1=date1.substring(3,6);
	dm2=date2.substring(3,6);
	dd1=date1.substring(0,2);
	dd2=date2.substring(0,2);

	//alert("dm1==>"+dm1);
    //alert("dm2==>"+dm2);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
    var mnth1=dateformat(dm1);
    var mnth2=dateformat(dm2);


    
    
	//alert("mnth1==>"+mnth1);
	//alert("mnth2==>"+mnth2);
	
	//alert("dy1==>"+dy1);
	//alert("dy2==>"+dy2);

	//alert("dd1==>"+dd1);
	//alert("dd2==>"+dd2);
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		//document.getElementById("data").value="";
		//document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(year==dy1 && year==dy2){
	  if(mnth1>month || mnth2>month)
		{
			alert("selected date should not be greater than todays date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data").focus;

			return false;
	
		}
	}

	if(mnth1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
	//	document.getElementById("data").value="";
		//document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
//alert("111");
		alert("From date should not be greater than to date");
	//	document.getElementById("data").value="";
		//document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(year==dy1 && year==dy2) if(mnth1>mnth2)
	{
		alert("From date should not be greater than to date  ");
		//document.getElementById("data").value="";
		//document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(mnth1==mnth2) {
	if(dd1 > dd2)
	{
		alert("From date should not be greater than to date");
		//document.getElementById("data").value="";
		//document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
//alert("end==>");
	return true;
}


</script>




</head>
<body>
<%!
Connection conn;
Statement st,st1, stmt1,st2,st3,st4,st5,st6,st7,stt1,stt2,stt3,stt4,stt5,st8,st_ds,st_ds1,st_ds2;
String date1, date2,datenew1,datenew2,daterm4="", vehcode, vehregno,tbname,sql,owner,km,rating,from,to,datenew11="",datenew21="",date11="",date21="",VehRegNo="",voilationdate="";
int os,ra,rd,cd,nd,osdur;
int oscount=0,racount=0,rdcount=0,cdcount=0,ndcount=0,stcnt=0,dhcnt=0,discnt=0,dvcount=0;
String drvcode="",strttm="",endtm="",strtplace="",endplace="",strttime="",status="",strtdate="",drivername="",transporter="",briefedby="",enddate="",strtdate1="",endtime="",starttime="",Selected="";
String sql1=null,sql2=null,sql3=null,sql4=null,sql5=null,sql6=null,sql7=null,sum1="",daterm2="",daterm3="",datentm2="",datentm3="",sum2="";
int racountall=0,rdcountall=0,cdcountall=0,ndcountall=0,oscountall=0,stcntall=0,dhcntall=0,discntall=0,dvcountall=0;


String sum3="",sum4="",sum7="";

int total_vltn=0,tot_cls_ontm=0,tot_esclt=0,tot_opn=0;

int racountall_close=0,rdcountall_close=0,cdcountall_close=0,ndcountall_close=0,oscountall_close=0,stcntall_close=0,dhcntall_close=0,discntall_close=0,dvcountall_close=0;

int racountall_esc=0,rdcountall_esc=0,cdcountall_esc=0,ndcountall_esc=0,oscountall_esc=0,stcntall_esc=0,dhcntall_esc=0,discntall_esc=0;

int oscount_esc=0,racount_esc=0,rdcount_esc=0,cdcount_esc=0,ndcount_esc=0,stcnt_esc=0,dhcnt_esc=0,discnt_esc=0; 

int  discnt_final=0,discnt_cls=0,discnt_final_cls=0,discnt_final_esc=0;

int oscount_cs=0,racount_cs=0,rdcount_cs=0,cdcount_cs=0,ndcount_cs=0,stcnt_cs=0,dhcnt_cs=0,discnt_cs=0,dvcount_cs=0;

int  discntnew=0,discntnew_final=0,discnt_final_all=0;
String date_dmc="",date_dmc1="",date_dmc3="",date_dmc2="";
String dtall="",dtall1="";

String sqlnew1="",sqlnew2="",sqlnew3="";
%>
<%
String trname=request.getParameter("trNm");

String brfDate = "",daterm="",daterm1="",datentm="",datentm1="",datentm4="";
String trainername = "";
String brStatus = "",StartDate="",EndDate="",enddate1="";

String tripid=request.getParameter("tripid");
String pagefrom="";
pagefrom=request.getParameter("rdpassport");
final String VehicleList = session.getAttribute("VehList").toString();


String usertypevalue=session.getAttribute("usertypevalue").toString();

String role = session.getAttribute("userrole").toString();


String typeouuser = session.getAttribute("TypeofUser").toString();
System.out.println("role>>>"+role);


System.out.println("typeouuser>>>"+typeouuser);

datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
System.out.println("check>>>"+!(role.equalsIgnoreCase("-")));



if(role.equalsIgnoreCase("-")){

	Selected=request.getParameter("Selected");
	//Selected="All";
	
	

}else if(role.equalsIgnoreCase("NTM primary"))
{

	Selected="Primary Escalation";
	
	
}else if(role.equalsIgnoreCase("NTM Tanker"))
{

	Selected="Tanker Escalation";
	
	
}else if(role.equalsIgnoreCase("NTM Secondary"))
{

	Selected="Secondary Escalation";
	
	
}
else if(role.equalsIgnoreCase("CFM"))
{

	Selected="CFM";
	
	
}


else{
	
	//Selected=request.getParameter("Selected");
	Selected = "All";
	
}


datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
System.out.println("datenew111111111   "+datenew1);
//Selected=request.getParameter("Selected");
//System.out.println("Selecteeeeeed"    +Selected);
NumberFormat nf1 = DecimalFormat.getNumberInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);	
nf1.setGroupingUsed(false);
try
{
	//System.out.println("Selecteeeeeed");
if(null==datenew1 || datenew1.equalsIgnoreCase("null"))
{
	//System.out.println("Selecteeeeeed");

	datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	// System.out.println("datenew2 whole"   +datenew2);
	// ttime1=new SimpleDateFormat("HH").format(new java.util.Date());
    /// ttime2=new SimpleDateFormat("mm").format(new java.util.Date());
     Calendar cal=Calendar.getInstance();
   //  cal.set(cal.get(cal.YEAR),cal.get(cal.MONTH),1);///commented for 1st date of any month condn
     
    cal.add(Calendar.DATE,-7);
    // cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
   //  System.out.println("datenew1 whole"   +datenew1);
   if(role.equalsIgnoreCase("-"))
   {
   Selected = "All";
   }
}



System.out.println("Selected AFTEr&&&&&&&&&&&&&&&&&&&&&&&&&&&"+Selected);

dtall=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("daterm111111111"   +daterm1);
Calendar cal7=Calendar.getInstance();
cal7.add(Calendar.DATE,-2);
dtall1=new SimpleDateFormat("yyyy-MM-dd").format(cal7.getTime());


//////for DMC
date_dmc=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("daterm111111111"   +daterm1);
Calendar cal4=Calendar.getInstance();
cal4.add(Calendar.DATE,-3);
date_dmc1=new SimpleDateFormat("yyyy-MM-dd").format(cal4.getTime());


//System.out.println("date_dmc1"   +date_dmc1);


daterm1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("daterm111111111"   +daterm1);
Calendar cal=Calendar.getInstance();
cal.add(Calendar.DATE,-3);
daterm3=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());////////change it to 3 for RM
//System.out.println("daterm333333"   +daterm3);

daterm2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("daterm22222222"   +daterm2);
Calendar cal1=Calendar.getInstance();
cal1.add(Calendar.DATE,-4);
daterm4=new SimpleDateFormat("yyyy-MM-dd").format(cal1.getTime());////change it to 4 for RM
//System.out.println("daterm44444444444"   +daterm4);

datentm1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("datentm111111"   +datentm1);
Calendar cal2=Calendar.getInstance();
cal2.add(Calendar.DATE,-4);
datentm3=new SimpleDateFormat("yyyy-MM-dd").format(cal2.getTime());/////change it to 5 for NTM
//System.out.println("datentm333333333333"   +datentm3);

datentm2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("datentm22222222"   +datentm2);
Calendar cal3=Calendar.getInstance();
cal3.add(Calendar.DATE,-3);
datentm4=new SimpleDateFormat("yyyy-MM-dd").format(cal3.getTime());/////change it to 7 for NTM
System.out.println("datentm444444444444444444"   +datentm4);
//System.out.println("datentm444444444444444444"   +datentm4);
 /* if(Selected.equals("All")||Selected.equalsIgnoreCase("All"))
  {
	datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	 System.out.println("datenew2 whole"   +datenew2);
	// ttime1=new SimpleDateFormat("HH").format(new java.util.Date());
    /// ttime2=new SimpleDateFormat("mm").format(new java.util.Date());
     Calendar cal=Calendar.getInstance();
     cal.add(Calendar.DATE,-7);
    // cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
     System.out.println("datenew1 whole"   +datenew1);
  }
 
  else if(Selected.equals("RM")||Selected.equalsIgnoreCase("RM"))
			{
		System.out.println("Selecteeeeeed");
		 datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		 System.out.println("datenew2 rm"   +datenew2);
	// ttime1=new SimpleDateFormat("HH").format(new java.util.Date());
    /// ttime2=new SimpleDateFormat("mm").format(new java.util.Date());
     Calendar cal1=Calendar.getInstance();
     cal1.add(Calendar.DATE,-2);
    // cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal1.getTime());
     System.out.println("datenew1  rm"   +datenew1);
			}
	      else if(Selected.equals("NTM")|| Selected.equalsIgnoreCase("NTM"))
			{
	    	  System.out.println("Selecteeeeeed");
		     datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		     System.out.println("datenew2 ntm"   +datenew2);
		     
		     Calendar cal2=Calendar.getInstance();
		     cal2.add(Calendar.DATE,-4);
		     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal2.getTime());
		     System.out.println("datenew1 ntm"   +datenew1);
			}
	      else if(Selected.equals("CFM")|| Selected.equalsIgnoreCase("CFM"))
	      {
	    	  datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	    	  System.out.println("datenew2  cfm"   +datenew2);
			     Calendar cal3=Calendar.getInstance();
			     cal3.add(Calendar.DATE,-8);
			     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal3.getTime());
			     System.out.println("datenew1  cfm"   +datenew1);
	      }*/


}
catch(Exception e)
{
	e.printStackTrace();
}
     
    // ftime1=new SimpleDateFormat("HH").format(cal.getTime());
    // ftime2=new SimpleDateFormat("mm").format(cal.getTime());
    // System.out.println("VehicleCode "+VehicleCode);
     //System.out.println("date3 "+date3);
    // System.out.println("datenew1 "+datenew1);
    // System.out.println("datenew2 "+datenew2);
   //  System.out.println("ftime1 "+ftime1);
   //  System.out.println("ftime2 "+ftime2);
    // System.out.println("ttime1 "+ttime1);
    // System.out.println("ttime2 "+ttime2);


/*if(null==datenew1)
{ 
	java.util.Date datenew1 =new java.util.Date();
	Calendar cal=Calendar.getInstance();
	cal.setTime(datenew1);
	cal.add(Calendar.DATE,-7);
	String datenew2=new SimpleDateFormat("dd-MM-yyyy").format(cal.getTime());
	String currentdate1=new SimpleDateFormat("dd-MM-yyyy").format(datenew1);
	
	
	//datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	 //ttime1=new SimpleDateFormat("HH").format(new java.util.Date());
  //  ttime2=new SimpleDateFormat("mm").format(new java.util.Date());
   // Calendar cal=Calendar.getInstance();
   // cal.add(Calendar.DATE,-7);
   // cal.add(Calendar.HOUR,+12);
   // datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
}*/

	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));

	
	// System.out.println("date1>>>>>NEW>>>>>>>>> "+date1);
	
System.out.println("1111111");
System.out.println("date1==>"+date1);
System.out.println("date2==>"+date2);
System.out.println("datenew1==>"+datenew1);
System.out.println("datenew2==>"+datenew2);
int total_vltn=0;
if(typeouuser.equalsIgnoreCase("GROUP"))
{
	
	Selected="All";
}
//out.print(tbname);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	st5=conn.createStatement();
	st6=conn.createStatement();
	st7=conn.createStatement();
	st8=conn.createStatement();
	st_ds=conn.createStatement();
	st_ds1=conn.createStatement();
	st_ds2=conn.createStatement();
	stt1=conn.createStatement();
	stt2=conn.createStatement();
	stt3=conn.createStatement();
	stt4=conn.createStatement();
	stt5=conn.createStatement();
if(Selected!=null){
%>
<form name="dateform" action="" method="post" onsubmit="return validate();">




<table border="0" width="300%" align="center" class="stats">
<tr><td align="center">
<!-- <div align="left"><font size="3">Report No:9.0</font></div>-->
<font size="3"><B>Open Trip Violations  Report for <%=Selected %></B></font>
</td></tr>
</table>

<table border="0" width="500" align="center" class="sortable_entry">



<tr>
<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data" name="data" value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1)) %>" class="element text medium"   style="width:08em" size="15" readonly/>
 
<!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script>
</td>
<td>
<b>To</b> &nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data1" name="data1" value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2))%>" class="element text medium"  style="width:08em"  size="15" readonly/></td><td align="left">
<!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
</td>
<%
System.out.println("typeouuser==>" +typeouuser);

if(typeouuser.equalsIgnoreCase("GROUP"))
{
	
	Selected="All";
}
System.out.println("Selected AFTEr*************akkkk**"+Selected);

if(typeouuser.equalsIgnoreCase("Transporter") ||  typeouuser.equalsIgnoreCase("SUBUSER"))
{

	
	System.out.println("start querr    fgdggfdgfdgy" +Selected);
%>



<td style="width:27em; "><b>Category </b><select id="Selected" name="Selected" onChange="statuscloser(this.value)"class="element select medium">
<%

System.out.println(">>>2222  Selected=query=>"+Selected);
if(Selected.equals("All"))
{
	%>
	<option value="All" selected="selected">All</option>
	<%
}
else
{
	%>
	<option value="All">All</option>
	<%
}

if(Selected.equals("Transporter"))
{
	%>
	<option value="Transporter" selected="selected">Transporter</option>
	<%
}
else
{
	%>
	<option value="Transporter">Transporter</option>
	<%
}





if(Selected.equalsIgnoreCase("Primary Escalation"))
{System.out.println(">>>INSIDE ME=>");
	%>
	<option value="Primary Escalation" selected="selected">Primary Escalation</option>
	<%
}
else
{
	%>
	<option value="Primary Escalation">Primary Escalation</option>
	<%
}



if(Selected.equalsIgnoreCase("Tanker Escalation"))
{
	%>
	<option value="Tanker Escalation" selected="selected">Tanker Escalation</option>
	<%
}
else
{
	%>
	<option value="Tanker Escalation">Tanker Escalation</option>
	<%
}
if(Selected.equalsIgnoreCase("Secondary Escalation"))
{
	%>
	<option value="Secondary Escalation" selected="selected">Secondary Escalation</option>
	<%
}
else
{
	%>
	<option value="Secondary Escalation">Secondary Escalation</option>
	<%
}
if(Selected.equals("CFM"))
{
	%>
	<option value="CFM" selected="selected">CFM</option>
	<%
}
else
{
	%>
	<option value="CFM">CFM</option>
	<%
}
%>
</select>

</td>
<%
}
 %>

<td>
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<input type="hidden"  name="colorvalue" id="colorvalue" value="all"></input>
<input id="submit" class="button_text" type="submit" name="ubmit" value="Submit" onclick="return chk();" style="border-style: outset; border-color: black" />

</table>





</form>

<form   name ="aks" id ="aks" method="post" action=" "> 
<div id="table1">	



<%
	
	 String exportFileName="InterventationReport.xls";  
	
	%>
	<div class="bodyText"  style="text-align: right;">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           </div>
                           
       <table align ="right">
       
       <tr>
       <td>
       <div align="right" >
       
<!--       <input type="hidden"><font size="3"><B>Intervention Report for < %=Selected %></B></font></input>-->
      
      </div>
      
       </td>
       
       
       </tr>
       
       
       <tr>
       
       
       
       <td>
       
       <div style="text-align: right;width: 750px;margin-left: 45em;"><!--    <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> --> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style:none; "></img></a></div>
       
       </td>
       </tr>  </table><br></br> 
       
       <div align="center">
<!--     <table border="1"  style="width:50em;border-style:solid;border: medium;vertical-align: middle; "   align="center" cellspacing="0" cellpadding="0"  class="sortable_entry" >-->



  
  
  </div>
  <br>
  </br>     
       
       <table border="0"  width="100%" class="stats">
				<tr>
				
					<td colspan="3" align="center">
					<input type="hidden" name="type" id="type" value="More Info"/><font size="3"><b>Trip Violations Report
					 for  <%=usertypevalue %> For
					the Period : <%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
out.print(showdate);
%> to  <%
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
java.util.Date showdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
String showdate2=formatter.format(showdate1);
out.print(showdate2);
%> <%
session.setAttribute("ShowDate",showdate+" 00:00:00");
session.setAttribute("ShowDate1",showdate2+" 23:59:00");
System.out.println("2222222222");
final String UserTypeValue =(String) session.getAttribute("usertypevalue");
System.out.println("UserTypeValue : "+UserTypeValue);
String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());
//String type=request.getParameter("type");
//System.out.println(">>>>>>>>>>type:"+type);
%></b></font>
					
					</td>
				</tr>
			</table>
       
       <div align ="center">
   <table border="1" style="width:1000px;"  align="center" bgcolor="#F5F5F5" class="sortable">
				<tr>
					<th colspan="3" class="">
					<div align="center">Parameters considered for the Report</div>
					</th>
				</tr>
				<tr>
					<td class="bodyText">
					<div align="left">1. OverSpeed :Red Zone >30Kmph ,Yellow Zone >40 kmph,Green Zone>60kmph
					</div>
					</td>
					<td class="bodyText">
					<div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></div>
					</td>
					<td class="bodyText">
					<div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></div>
					</td>
					
				</tr>
				<tr>
					
					<td class="bodyText">
<!--					<div align="left">4. Night Driving : Duration > 30 Mins-->
<!--					</div><br>-->
					<div align="left">4. Continuous Driving : <%=session.getAttribute("cdri").toString() %></div>
					</td>
					<td class="bodyText">
					<div align="left">5. Run Duration(RH) :Run Duration > '10:00:00' Hrs  </div>
					</td>
					
					<td class="bodyText">
					<div align="left">6. Disconnection(DIS) :Duration >30Mins  </div>
					</td>
				</tr>
				
				
				
				
				
			</table>
			
			</div>
            <br>                     
<div align="center" >
<table  border="1" style="width:1200px;"  align="center" class="sortable">
<tr>
				<th class="hed" align="center">Sr no</th>
				<th class="hed" align="center">Trip id</th>
				<th class="hed" align="center">Vehicle Reg no.</th>
				<th class="hed" align="center">Transporter</th>
				<th class="hed" align="center">Start place</th>
				<th class="hed" align="center">End place</th>		
					<th class="hed" align="center">Start date</th>
					<th class="hed" align="center">Start Time</th>
				<th class="hed" align="center">End date</th>
				<th class="hed" align="center">End Time</th>
				<th class="hed" align="center">Driver Id</th>
				<th class="hed" align="center">Driver name</th>
				<th class="hed" align="center">Status</th>
				<th class="hed" align="center">Briefed by</th>
								
				
				<th class="hed" align="center">OS</th>
				
				
				<th class="hed" align="center">RA</th>
				<th class="hed" align="center">RD</th>
				<th class="hed" align="center">CD</th>
				<th class="hed" align="center">ND</th>
				<th class="hed" align="center">DV</th>
				
<!--				<th class="hed" align="center">ST</th>-->
				<th class="hed" align="center">RH</th>
				<th class="hed" align="center">DIS</th>
			</tr>
			<%
			
				int i=1;
			//select count(*) from db_gps.t_startedjourney where startdate between'2012-10-20' and '2012-10-27' and GPName = 'Castrol' and JStatus in('Running','tobeclosed') and TripCategory in ('Primary','Secondary');
               int hide=0;
			
               if(Selected!=null)
               {
               
               if(Selected.equals("Primary Escalation") || Selected.equalsIgnoreCase("Primary Escalation"))
               {
            	   sql="select VehRegNo,DriverCode ,DriverName,OwnerName,Vehid,TripID,StartPlace,EndPlace,JStatus,StartDate,StartTime from db_gps.t_startedjourney where (OwnerName='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and startdate>='"+date1+"' and startdate<='"+date2+"' and Vehid in "+VehicleList+" and JStatus in('Running','Completed') and TripCategory ='Primary'  order by startdate ";
               }
               
               else if (Selected.equals("Tanker Escalation") || Selected.equalsIgnoreCase("Tanker Escalation")){
            	   
            	   sql="select VehRegNo,DriverCode ,DriverName,OwnerName,Vehid,TripID,StartPlace,EndPlace,JStatus,StartDate,StartTime from db_gps.t_startedjourney where (OwnerName='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and startdate>='"+date1+"' and startdate<='"+date2+"' and Vehid in "+VehicleList+" and JStatus in('Running','Completed') and TripCategory ='tanker'  order by startdate "; 
            	            	  
               }
               
               else if (Selected.equals("Secondary Escalation") || Selected.equalsIgnoreCase("Secondary Escalation")){
            	   
            	   sql="select VehRegNo,DriverCode ,DriverName,OwnerName,Vehid,TripID,StartPlace,EndPlace,JStatus,StartDate,StartTime from db_gps.t_startedjourney where (OwnerName='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and startdate>='"+date1+"' and startdate<='"+date2+"' and Vehid in "+VehicleList+" and  JStatus in('Running','Completed') and TripCategory ='secondary'  order by startdate ";   
            	   
               }
               
               else
               {
            	   sql="select VehRegNo,DriverCode ,DriverName,OwnerName,Vehid,TripID,StartPlace,EndPlace,JStatus,StartDate,StartTime from db_gps.t_startedjourney where (OwnerName='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and startdate>='"+date1+"' and startdate<='"+date2+"' and Vehid in "+VehicleList+" and  JStatus in('Running','Completed') and TripCategory in ('Primary','Secondary','Tanker') order by startdate ";  
            	   
               }
               
			
			//System.out.println("start querry"  +sql);
			ResultSet rs=st.executeQuery(sql);
			System.out.println("start querry"  +sql);
			racountall=0;
			rdcountall=0;
			cdcountall=0;
			ndcountall=0;
			oscountall=0;
			stcntall=0;
			discntall=0;
			dhcntall=0;
			
			int discntnew_final=0;
			
		//	total_vltn=0;
			tot_cls_ontm=0;
			tot_esclt=0;
			tot_opn=0;




		racountall_close=0;
			rdcountall_close=0;
			cdcountall_close=0;
			ndcountall_close=0;
			oscountall_close=0;
			stcntall_close=0;
			discntall_close=0;
			dhcntall_close=0;


			racountall_esc=0;
			rdcountall_esc=0;
			cdcountall_esc=0;
			ndcountall_esc=0;
			oscountall_esc=0;
			stcntall_esc=0;
			discntall_esc=0;
			dhcntall_esc=0;

			double discnt_final_all=0;
			
			int dvcountall_close=0;
			int dvcountall=0;
			
			
			
			
			while (rs.next())
			{
				//i++;
				hide=1;
				//ownername=rs.getString("GPName");
				//VehRegNo
				VehRegNo=rs.getString("VehRegNo");
				vehcode=rs.getString("Vehid");
				tripid=rs.getString("TripID");
				strtplace=rs.getString("StartPlace");
				endplace=rs.getString("EndPlace");
				status=rs.getString("JStatus");
				strtdate=rs.getString("StartDate");
				strttime=rs.getString("StartTime");
				//discnt=rs.getInt("DisconnectionKm");///used the query for disconnection query
				drvcode=rs.getString("DriverCode");
                double kmtravelled = 0;
				
                
				
				strtdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(strtdate));
				
				strttime=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(strttime));
				//System.out.println("start date1111111"  +strtdate);
				//enddate=rs.getString("");
				drivername=rs.getString("DriverName");
				transporter=rs.getString("OwnerName");
				 
				
				
				System.out.println("Violation Count Main Query trip id--------->"  +tripid+"---Vehicel Code-----"+vehcode+"---VehRegNo----"+VehRegNo+"----Owner----"+transporter);
				
				try
				{
					
				
			/*	sql="select StartDate, StartTime from t_startedjourney where Vehid='"+vehcode+"' and StartDate > '"+rs.getString("StartDate")+"' order by StartDate ";
				  ResultSet rs8=st2.executeQuery(sql);
				   System.out.println("aaaaaaaaaaaa" +sql);
				    if(rs8.next())
						{
					        enddate=rs8.getString("StartDate");
					        System.out.println("StartDate" +enddate);
					         endtime=rs8.getString("StartTime");
					        System.out.println("StartDate111"  +endtime);
					        enddate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate));
					       
						}*/
				    
				    
				    if(status=="Running" || status.equalsIgnoreCase("Running"))
				    {
				    	enddate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
				    	endtime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
				    	kmtravelled = 1;
				    }
				    else
				    {
				    	sql="select EndDate,EndTime,kmtravelled  from t_completedjourney where TripID='"+tripid+"'";
				    	ResultSet rs10=st2.executeQuery(sql);
				       //  System.out.println("endateqqqqqqqq" +sql);
				    	if(rs10.next())
				    	{    		
				    		 enddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs10.getString("EndDate")));
				    		 endtime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:mm:ss").parse(rs10.getString("EndTime")));
				    		 kmtravelled = rs10.getDouble("kmtravelled");
				    	}
				    	
				    	
				    }
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				sql1="select TrainerName from t_briefing where tripid='"+tripid+"'" ;
				ResultSet rs1=st1.executeQuery(sql1);
				//System.out.println("brif querry"  +sql1);
				
				if(rs1.next())
				{
					
				//	System.out.println("brif querry11111111111" );
					briefedby=rs1.getString("TrainerName");
					//System.out.println("TrainerName"  +briefedby);
					
				}
				
				/////////////////////////Querry for cal voilation date////////////////////
			/*	sql="select distinct(UpdateDateTime) as voidate from db_gpsExceptions.t_vehall_ra where UpdateDateTime between '"+date1+"' and '"+date2+"' and VehCode='"+vehcode+"' and  violationstatus='open' ";
				ResultSet ra=st1.executeQuery(sql);
				System.out.println("voilation querry"   +sql);
				if(ra.next())
				{
					voilationdate=ra.getString("voidate");
					System.out.println("voilation date"   +voilationdate);
				}
				
				sql="select distinct(UpdateDateTime) as voidate from db_gpsExceptions.t_vehall_rd where UpdateDateTime between '"+date1+"' and '"+date2+"' and VehCode='"+vehcode+"' and  violationstatus='open' ";
				ResultSet rd=st1.executeQuery(sql);
				System.out.println("voilation querry"   +sql);
				if(ra.next())
				{
					voilationdate=ra.getString("voidate");
					System.out.println("voilation date"   +voilationdate);
				}
				
				sql="select distinct(FromDateTime) as voidate from db_gpsExceptions.t_vehall_overspeed where UpdateDateTime between '"+date1+"' and '"+date2+"' and VehCode='"+vehcode+"' and  violationstatus='open' ";
				ResultSet overspeed=st1.executeQuery(sql);
				System.out.println("voilation querry"   +sql);
				if(ra.next())
				{
					voilationdate=ra.getString("voidate");
					System.out.println("voilation date"   +voilationdate);
				}
				sql="select distinct(FromDateTime) as voidate from db_gpsExceptions.t_vehall_nd where UpdateDateTime between '"+date1+"' and '"+date2+"' and VehCode='"+vehcode+"' and  violationstatus='open' ";
				ResultSet ra=st1.executeQuery(sql);
				System.out.println("voilation querry"   +sql);
				if(ra.next())
				{
					voilationdate=ra.getString("voidate");
					System.out.println("voilation date"   +voilationdate);
				}
				sql="select distinct(FromDateTime) as voidate from db_gpsExceptions.t_vehall_crcopy where UpdateDateTime between '"+date1+"' and '"+date2+"' and VehCode='"+vehcode+"' and  violationstatus='open' ";
				ResultSet ra=st1.executeQuery(sql);
				System.out.println("voilation querry"   +sql);
				if(ra.next())
				{
					voilationdate=ra.getString("voidate");
					System.out.println("voilation date"   +voilationdate);
				}
				
				*/
				try
				{
					
				
		           sum1="";
		           sum3="";
		           if(Selected.equals("All")|| Selected.equalsIgnoreCase("All"))
					{
		     		 sum1= sum1+" and  TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'  ";
		     		 //System.out.println("sum3333333333333333333>>>DMC "  +sum1);
		     		 sum2="";
			     	
		     		
		     		sum3=sum3+" and  TheDate <'"+datentm3+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"' ";
		     		 
		     		 sum2= sum2+"  and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
				
					
		     		sum4="";
			 		sum4= sum4+" and  FromDate <'"+datentm3+"' and  FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
					
		     		sum7="";
		     		sum7= sum7+" and FromDate>= '"+rs.getString("StartDate")+"' and FromDate<= '"+enddate+"' ";
		     		
					
					}
		           else if(Selected.equals("Transporter")|| Selected.equalsIgnoreCase("Transporter"))
			     	{
			     		 sum1= sum1+" and TheDate>='"+dtall1+"'  and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'  ";
			     		 //System.out.println("sum3333333333333333333>>>DMC "  +sum1);
			     		 sum2="";
				     	sum2= sum2+" and FromDate>='"+dtall1+"' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
			     	
				     	sum4="";
			     		sum4= sum4+" and FromDate <'"+dtall1+"' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
			     	
			     	
			     		 sum3=sum3+" and TheDate <'"+dtall1+"'  and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"' ";
			     		
			     		sum7="";
			     		sum7= sum7+" and FromDate>='"+dtall1+"' and FromDate>= '"+rs.getString("StartDate")+"' and FromDate<= '"+enddate+"' ";
			     	}
		               
		           
		           
		           else if(Selected.equals("DMC")|| Selected.equalsIgnoreCase("DMC"))
			     	{
			     		 sum1= sum1+" and TheDate='"+daterm3+"'  and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'  ";
			     		 //System.out.println("sum3333333333333333333>>>DMC "  +sum1);
			     		 sum2="";
				     	sum2= sum2+" and FromDate='"+daterm3+"' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
			     	}
				
		     	else if(Selected.equals("RM")|| Selected.equalsIgnoreCase("RM"))
		     	{
		     		 sum1= sum1+" and  TheDate='"+daterm4+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'";
		     		 //System.out.println("sum222222222222222 >RM"  +sum1);
		     		 sum2="";
		     		sum2= sum2+" and  FromDate='"+daterm4+"'  and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' "; //cd,nd,os
		     		// System.out.println("sum222222222222222 >RM"  +sum2);
		     	}
		     	else if(Selected.equals("Primary Escalation")|| Selected.equalsIgnoreCase("Primary Escalation") || Selected.equals("Tanker Escalation")|| Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equals("Secondary Escalation")|| Selected.equalsIgnoreCase("Secondary Escalation"))
		     	{
		     		 sum1= sum1+" and TheDate = '"+datentm4+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'  ";
		     		// System.out.println("sum3333333333333333333 NTM "  +sum1);
		     		 sum2="";
			     	sum2= sum2+" and FromDate= '"+datentm4+"' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
			     	// System.out.println("sum3333333333333333333 NTM "  +sum2);
		     	
		     	
			     	sum3=sum3+" and TheDate <'"+datentm4+"'  and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"' ";
			     	
			     	
			     	
			   	 
			 		sum4="";
			 		sum4= sum4+" and FromDate < '"+datentm4+"' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
		     	
			 		sum7="";
			 		sum7= sum7+" and FromDate= '"+datentm4+"' and FromDate>= '"+rs.getString("StartDate")+"' and FromDate<= '"+enddate+"' ";
		     	
		     	}
		     	else
		     	{
		     		 sum1= sum1+" and  TheDate <= '"+datentm3+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'  ";
		     		// System.out.println("sum444444444444444444  ELSE " +sum1);
		     		 sum2="";
			     	sum2= sum2+" and FromDate <='"+datentm3+"' and  FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
			     	 //System.out.println("sum444444444444444444  ELSE " +sum2);
		     	
			     	 
			     	  sum3=sum3+" and TheDate<'"+datentm3+"'  and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'  ";
			     	 
			     	 
			     	 
			    	sum4="";
			     	sum4= sum4+" and FromDate <'"+datentm3+"' and  FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
			     	 
			     	sum7="";
			     	sum7= sum7+" and FromDate <='"+datentm3+"' and  FromDate>= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"' ";
		     	
		     	
		     	
		     	}
		           
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				///////////////////////////Querries for calculating count//////////////////////////
				String sql2="select count( * ) as racount from db_gpsExceptions.t_vehall_ra where  violationstatus='open' and   VehCode='"+vehcode+"'  "+sum1+""  ; 
				ResultSet rs2=stt1.executeQuery(sql2);
				//System.out.println(">45455RA>>>>>>NNNNNNNN" +sql2);
				if(rs2.next())
				{
					//System.out.println("IN OPEN----------RA");
					
					racount=rs2.getInt("racount");
					if(kmtravelled > 0)
					{
					racountall=racountall+racount;
					}
				}
				
				
				
				
				////11111
				
				NumberFormat nf3=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
				
				String sql21="select count( * ) as racount from db_gpsExceptions.t_vehall_ra where VehCode='"+vehcode+"' and  violationstatus='close'  "+sum1+"" ; 
	ResultSet rs22=st6.executeQuery(sql21);
	//System.out.println(">>>RA CLOSE>>>>NNNNNNNN" +sql21);
	if(rs22.next())
	{
		//System.out.println("IN Close----------RA");
		racount_cs=rs22.getInt("racount");
		racountall_close=racountall_close+racount_cs;
	}
	
	
////commenting the all esc queries 
	

      /*


	String sql24="select count( * ) as racount from db_gpsExceptions.t_vehall_ra where VehCode='"+vehcode+"' and  violationstatus='open'  "+sum3+"" ; 
	ResultSet rs24=st7.executeQuery(sql24);
	System.out.println(">>>ESC>>>RA>NNNNNNNN" +sql24);
	if(rs24.next())
	{
		racount_esc=rs24.getInt("racount");
		racountall_esc=racountall_esc+racount_esc;
	}
				
*/				
				
				
				
				
				
				
				
				
				
				String sql3="select count( * ) as rdcount from db_gpsExceptions.t_vehall_rd where violationstatus='open' and VehCode='"+vehcode+"'   "+sum1+"	"; 
				ResultSet rs3=stt2.executeQuery(sql3);
				//System.out.println(">>>>>>>NNNNNNNN  RD>>" +sql3);
				if(rs3.next())
				{//System.out.println("IN OPEN----------Rd");
				
					rdcount=rs3.getInt("rdcount");
					if(kmtravelled > 0)
					{
					rdcountall=rdcountall+rdcount;
					}
				}
				//System.out.println(">>>>>>>NNNNNNNN  rdcountall>>" +rdcountall);
				
				
				////222222222
				String sql33="select count( * ) as rdcount from db_gpsExceptions.t_vehall_rd where VehCode='"+vehcode+"' and  violationstatus='close'  "+sum1+"	"; 
	ResultSet rs32=st6.executeQuery(sql33);
//	System.out.println(">>>>>>>NNNsql33NNNNN  RD close>>" +sql33);
	if(rs32.next())
	{
		//System.out.println("IN Close----------Rd");
		rdcount_cs=rs32.getInt("rdcount");
		rdcountall_close=rdcountall_close+rdcount_cs;
	}
	
	
	
	
////commenting the all esc queries 
	
/*
	String sql34="select count( * ) as rdcount from db_gpsExceptions.t_vehall_rd where VehCode='"+vehcode+"' and  violationstatus='open'  "+sum3+"	"; 
	ResultSet rs34=st7.executeQuery(sql34);
	System.out.println(">>>>ESC>sql34>>NNNNNNNN  RD>>" +sql34);
	if(rs34.next())
	{
		rdcount_esc=rs34.getInt("rdcount");
		rdcountall_esc=rdcountall_esc+rdcount_esc;
	}
				
	*/			
				
				
				
				
				String sql5="select count( * ) as cdcount from db_gpsExceptions.t_vehall_crcopy where violationstatus='open' and VehCode='"+vehcode+"'    "+sum2+""; 
				ResultSet rs5=stt3.executeQuery(sql5);
				//System.out.println(">>>>>>>NNNNNNNN CD cnt " +sql5);
				if(rs5.next())
				{
					//System.out.println("IN Open----------cd");
					cdcount=rs5.getInt("cdcount");
					if(kmtravelled > 0)
					{
					cdcountall=cdcountall+cdcount;
					}
				}
				
				
				/////333333333333
				
				String sql51="select count( * ) as cdcount from db_gpsExceptions.t_vehall_crcopy where VehCode='"+vehcode+"'  and violationstatus='close'  "+sum2+""; 
	ResultSet rs51=st6.executeQuery(sql51);
	//System.out.println(">>>>>>>NNNsql51NNNNN CD cnt close" +sql51);
	if(rs51.next())
	{
		//System.out.println("IN Close----------cd");
		cdcount_cs=rs51.getInt("cdcount");
		cdcountall_close=cdcountall_close+cdcount_cs;
	}
	
	
////commenting the all esc queries 
/*
	
	String sql53="select count( * ) as cdcount from db_gpsExceptions.t_vehall_crcopy where VehCode='"+vehcode+"'  and violationstatus='open'  "+sum4+""; 
	ResultSet rs53=st7.executeQuery(sql53);
	System.out.println(">>ESC>>>sql53>>NNNNNNNN CD cnt " +sql53);
	if(rs53.next())
	{
		cdcount_esc=rs53.getInt("cdcount");
		cdcountall_esc=cdcountall_esc+cdcount_esc;
	}
	*/			
				
				
				
				
				
				
				
				
				String sql6="select count( * ) as ndcount from db_gpsExceptions.t_vehall_nd where violationstatus='open' and VehCode='"+vehcode+"' "+sum2+""; 
				
				
				ResultSet rs6=stt4.executeQuery(sql6);
				//System.out.println(">>>>1111>>>NNNNNNNN" +sql6);
				if(rs6.next())
				{
					
					//System.out.println("IN open----------nd");
					ndcount=rs6.getInt("ndcount");
					if(kmtravelled > 0)
					{
					ndcountall=ndcountall+ndcount;
					}
				}
				
				
				//////444444444
				 String sql61="select count( * ) as ndcount from db_gpsExceptions.t_vehall_nd where VehCode='"+vehcode+"'  and  violationstatus='close' "+sum2+""; 
	
	
	ResultSet rs61=st6.executeQuery(sql61);
  	//System.out.println(">>>>>>sql61 ND close>NNNNNNNN" +sql61);
	if(rs61.next())
	{
		//System.out.println("IN Close----------nd");
		ndcount_cs=rs61.getInt("ndcount");
		ndcountall_close=ndcountall_close+ndcount_cs;
	}
	
	
	String sqldv="select count(*) as dvcount from db_gpsExceptions.t_vehall_dv where VehCode='"+vehcode+"' and violationstatus='open' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
	ResultSet rsdv=stt4.executeQuery(sqldv);
	
	if(rsdv.next()){
		
		//System.out.println("IN open----------dv");
		dvcount=rsdv.getInt(1);
		
		if(kmtravelled > 0){
			dvcountall=dvcountall+dvcount;
		}
	}
	System.out.println("Dv opencount-------->"+dvcountall);
	
	String sqldv1="select count(*) as dvcount from db_gpsExceptions.t_vehall_dv where VehCode='"+vehcode+"' and violationstatus='close' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"' ";
	ResultSet rsdv1=st6.executeQuery(sqldv1);
	if(rsdv1.next()){
		
		//System.out.println("IN close----------dv");
		dvcount_cs=rsdv1.getInt(1);
		dvcountall_close=dvcountall_close+dvcount_cs;
	}
	//System.out.println("Dv closecount-------->"+dvcountall);
////commenting the all esc queries 
 /*
		
	 String sql63="select count( * ) as ndcount from db_gpsExceptions.t_vehall_nd where VehCode='"+vehcode+"'  and Duration >= '00:30:00'  and violationstatus='open' "+sum4+""; 
		
		
		ResultSet rs63=st7.executeQuery(sql63);
		System.out.println(">>ESCsql63>>>>>NNNNNNNN" +sql63);
		if(rs63.next())
		{
			ndcount_esc=rs63.getInt("ndcount");
			ndcountall_esc=ndcountall_esc+ndcount_esc;
		}
				
				
	*/			
				
				
				
				
				
				
				String sql7="select count( * ) as oscount from db_gpsExceptions.t_vehall_overspeed where violationstatus='open' and VehCode='"+vehcode+"'   "+sum2+""; 
				ResultSet rs7=stt5.executeQuery(sql7);
				//System.out.println(">>>>>OS>>NNNNNNNN" +sql7);
				if(rs7.next())
				{
					oscount=rs7.getInt("oscount");
					if(kmtravelled > 0)
					{
					oscountall=oscountall+oscount;
					}
				}
				
				//String  sqlnew="select count( * ) as stoppage  from db_gpsExceptions.t_vehall_stsp where VehCode='"+vehcode+"'  and  "+sum2+""; 
				
				//System.out.println("oscount>>>%%%%%%%%%%%%%" +oscount);
				
				
				//////
				String sql71="select count( * ) as oscount from db_gpsExceptions.t_vehall_overspeed where VehCode='"+vehcode+"'  and violationstatus='close' "+sum2+""; 
	ResultSet rs71=st6.executeQuery(sql71);
	//System.out.println(">>>>>>sql71 OS CLOSE>NNNNNNNN" +sql71);
	if(rs71.next())
	{
		oscount_cs=rs71.getInt("oscount");
		oscountall_close=oscountall_close+oscount_cs;
	}
	
	
	
////commenting the all esc queries 
/*
	
	String sql74="select count( * ) as oscount from db_gpsExceptions.t_vehall_overspeed where VehCode='"+vehcode+"'  and violationstatus='open' "+sum4+""; 
	ResultSet rs74=st7.executeQuery(sql74);
	System.out.println(">ESC>OS>>>>>NNNNNNNN" +sql74);
	if(rs74.next())
	{
		oscount_esc=rs74.getInt("oscount");
		oscountall_esc=oscountall_esc+oscount_esc;
	}
	*/			
				
				
				
			/*	
				
				String  sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"' "; 
				
				ResultSet rsnew=st3.executeQuery(sqlnew);
				System.out.println(">>>>stoppage>>>NNNNsqlnew>>>" +sqlnew);
				if(rsnew.next())
				{
					stcnt=rsnew.getInt("stoppage");
					//stcntall=stcntall+stcnt;
				}
				
				*/
				
				/*
				String  sqlnew="";
				if(Selected.equalsIgnoreCase("All"))
                {
					  sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"' "; 
               	 
               	 
                }
				
				else if(Selected.equalsIgnoreCase("Transporter"))
                {
					  sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"'  and FromDate >='"+dtall1+"' "; 
               	 
               	 
                }
				
				else if(Selected.equalsIgnoreCase("Primary Escalation") || Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equalsIgnoreCase("Secondary Escalation"))
                    {
						//sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and   FromDate ='"+datentm4+"' "; 
						 sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"'  and   FromDate ='"+datentm4+"' "; 
                   	 
                    }else
                    {
                    	//sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and   FromDate <='"+datentm3+"' "; 
                   	 
                    	 sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"'  and   FromDate <='"+datentm3+"' "; 
                    }
				
				ResultSet rsnew22=st3.executeQuery(sqlnew);
				System.out.println(">>>>check query  stoppage query@@@@>>>NNNNsqlnew>>>" +sqlnew);
				if(rsnew22.next())
				{
					stcnt=rsnew22.getInt("stoppage");
					//stcntall=stcntall+stcnt;
				}
				System.out.println("stcnt>>>%%%%%%%%%%%%%" +stcnt);
				
				*/
				
				
        // String  sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  FromTime >= '05:00:00' and ToTime <= '23:00:00' and ToDate = FromDate  "+sum7+" "; 
			
        
        
        /////commenting the eblow query of stsp****************************************************
        
        // String  sqlnew="select count(*) as stoppage from db_gpsExceptions.t_vehall_stsp  where Duration > '04:00:00'  and  FromTime >= '05:00:00' and ToTime <= '23:00:00' and ToDate = FromDate and  violationstatus ='open' and   VehCode='"+vehcode+"' "+sum2+"  "; 
         
        
				//ResultSet rsnew=st3.executeQuery(sqlnew);
				//System.out.println(">>>stoppage>>>>NNNNsqlnew>>>" +sqlnew);
				//if(rsnew.next())
				//{
					//stcnt=rsnew.getInt("stoppage");
					//stcntall=stcntall+stcnt;
			//	}
				
				//System.out.println(">>>stoppage>COUNT>>>" +stcnt);
				 /////commenting the eblow query of stsp****************************************************
         
				 //String  sqlnew11="select count(*) as stoppage from db_gpsExceptions.t_vehall_stsp  where Duration > '04:00:00'  and violationstatus ='close'  and  FromTime >= '05:00:00' and ToTime <= '23:00:00' and ToDate = FromDate   and   VehCode='"+vehcode+"' "+sum2+"  "; 
				
				//ResultSet rsnew11=st8.executeQuery(sqlnew11);
				//System.out.println(">>>>>>>NN stoppage close NNsqlnew11>>111111>" +sqlnew11);
				//if(rsnew11.next())
				//{
					//stcnt_cs=rsnew11.getInt("stoppage");
					//stcntall=stcntall+stcnt;
				//}
				
				
			////commenting the all esc queries 
			/*
				
                 String  sqlnew111="select count(*) as stoppage from db_gpsExceptions.t_vehall_stsp  where Duration > '04:00:00'  and  FromTime >= '05:00:00' and ToTime <= '23:00:00' and ToDate = FromDate  and violationstatus ='open' and  VehCode='"+vehcode+"' "+sum4+"  "; 
				
				ResultSet rsnew111=st4.executeQuery(sqlnew111);
				System.out.println(">>>>ESC STPG>>>NNNNsqlnew111>>22222>" +sqlnew111);
				if(rsnew111.next())
				{
					stcnt_esc=rsnew11.getInt("stoppage");
				//	stcntall=stcntall+stcnt;
				}
				
				
				*/
				
				
				/*
				
				String  sqlnew11="";
				if(Selected.equalsIgnoreCase("All"))
                {
					  sqlnew11="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"' "; 
               	 
               	 
                }
				
				else if(Selected.equalsIgnoreCase("Transporter"))
                {
					  sqlnew11="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"'  and FromDate >='"+dtall1+"' "; 
               	 
               	 
                }
				
				else if(Selected.equalsIgnoreCase("Primary Escalation") || Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equalsIgnoreCase("Secondary Escalation"))
                    {
						//sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and   FromDate ='"+datentm4+"' "; 
						 sqlnew11="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"'  and   FromDate ='"+datentm4+"' "; 
                   	 
                    }else
                    {
                    	//sqlnew="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and   FromDate <='"+datentm3+"' "; 
                   	 
                    	 sqlnew11="select count(*) as stoppage from db_gpsExceptions.t_veh"+vehcode+"_stsp  where Duration > '04:00:00' and  ToDate = FromDate  and FromTime >= '05:00:00' and ToTime <= '23:00:00' and FromDate >= '"+rs.getString("StartDate")+"' and FromDate <= '"+enddate+"'  and   FromDate <='"+datentm3+"' "; 
                    }
				
				ResultSet rsnew22=st3.executeQuery(sqlnew);
				System.out.println(">>>>check query  stoppage query@@@@>>>NNNNsqlnew>>>" +sqlnew);
				if(rsnew22.next())
				{
					stcnt=rsnew22.getInt("stoppage");
					//stcntall=stcntall+stcnt;
				}
				
				
				
				*/
				
				
				//System.out.println("ndcount>>>%%%%%%%%%%%%%" +ndcount);
				//String  sqlnew1="select DisconnectionKm,RunHrVio  from db_gps.t_completedjourney  where VehCode='"+vehcode+"'  and  "+sum2+""; 
				/*
				String  sqlnew1="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '12:00:00'"; 
				ResultSet rsnew1=st4.executeQuery(sqlnew1);
				//System.out.println(">>>>>>>NNNNsqlnew>>>" +sqlnew1);
				if(rsnew1.next())
				{
					
					dhcnt=rsnew1.getInt("RunHrVio");
					//discnt=rsnew1.getInt("DisconnectionKm");
					dhcntall=dhcntall+dhcnt;
					//discntall=discntall+discnt;
					
				}
				
				*/
				
				
				
				String  sqlnew1="";
				
				if(Selected.equalsIgnoreCase("All"))
                {
				  sqlnew1="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00'  and  violationstatus='open'";  
               	 
               	 
                }			
				
				else if(Selected.equalsIgnoreCase("Transporter"))
                {
				  sqlnew1="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and violationstatus='open' and  TheDate >='"+dtall1+"'  ";  
               	 
               	 
                }			
				
				else if(Selected.equalsIgnoreCase("Primary Escalation") || Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equalsIgnoreCase("Secondary Escalation"))
                    {
					  sqlnew1="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and violationstatus='open' and  TheDate ='"+datentm4+"'  ";  
                   	 
                   	 
                    }else
                    {
                    	sqlnew1="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and  violationstatus='open' and  TheDate <='"+datentm3+"'  ";  
                   	 
                   	 
                    }
				
				
				//System.out.println(">>>>check query>>BEFORE>NNNNsqlnew>>>" +sqlnew1);
				
				ResultSet rsnew1=st4.executeQuery(sqlnew1);
				//System.out.println(">>>>check Run Duaration query>>>NNNNsqlnew>>>" +sqlnew1);
				if(rsnew1.next())
				{
					
					dhcnt=rsnew1.getInt("RunHrVio");
					//discnt=rsnew1.getInt("DisconnectionKm");
					if(kmtravelled > 0)
					{
					dhcntall=dhcntall+dhcnt;
					}
					//discntall=discntall+discnt;
					
				}
				
				//System.out.println("yo yo >>%%%%%%%%%%%%%"+Selected);
				
           String  sqlnew2="";
				
				if(Selected.equalsIgnoreCase("All"))
                {
				  sqlnew2="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and violationstatus ='close' ";  
               	 
               	 
                }			
				
				else if(Selected.equalsIgnoreCase("Transporter"))
                {
				  sqlnew2="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and   TheDate >='"+dtall1+"' and violationstatus ='close' ";  
               	 
               	 
                }			
				
				else if(Selected.equalsIgnoreCase("Primary Escalation") || Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equalsIgnoreCase("Secondary Escalation"))
                    {
					  sqlnew2="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and   TheDate ='"+datentm4+"' and violationstatus ='close' ";  
                   	 
                   	 
                    }else
                    {
                    	sqlnew2="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '10:00:00' and   TheDate <='"+datentm3+"' and violationstatus ='close' ";  
                   	 
                   	 
                    }
				
				
				//System.out.println(">>>>check query>>BEFORE>NNNNsqlnew>>>" +sqlnew1);
				
				ResultSet rsnew88=st8.executeQuery(sqlnew2);
				//System.out.println(">>>>check Run Duaration query>>close >NNNNsqlnew>>>" +sqlnew2);
				if(rsnew88.next())
				{
					
					dhcnt_cs=rsnew88.getInt("RunHrVio");
					//discnt=rsnew1.getInt("DisconnectionKm");
					//dhcntall=dhcntall+dhcnt;
					//discntall=discntall+discnt;
					
				}
				
				
			////commenting the all esc queries 
				
			/*
            String  sqlnew3="";
				
				if(Selected.equalsIgnoreCase("All"))
                {
				  sqlnew3="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"'  and   TheDate <'"+datentm3+"' and    RDuration > '12:00:00' and violationstatus ='open' ";  
               	 
               	 
                }			
				
				else if(Selected.equalsIgnoreCase("Transporter"))
                {
				  sqlnew3="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '12:00:00' and TheDate <'"+dtall1+"' and violationstatus ='open' ";  
               	 
               	 
                }			
				
				else if(Selected.equalsIgnoreCase("Primary Escalation") || Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equalsIgnoreCase("Secondary Escalation"))
                    {
					  sqlnew3="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '12:00:00' and   TheDate < '"+datentm4+"' and violationstatus ='open' ";  
                   	 
                   	 
                    }else
                    {
                    	sqlnew3="select count(*) as RunHrVio from db_gpsExceptions.t_vehall_ds where vehcode = '"+vehcode+"' and thedate >= '"+rs.getString("StartDate")+"'  and thedate <= '"+enddate+"' and RDuration > '12:00:00' and   TheDate <'"+datentm3+"' and violationstatus ='open' ";  
                   	 
                   	 
                    }
				
				*/
				//System.out.println(">>>>check query>>BEFORE>NNNNsqlnew>>>" +sqlnew1);
				
				/*
				ResultSet rsnew77=st4.executeQuery(sqlnew3);
				System.out.println(">>>>check Run Duaration query>>esc>NNNNsqlnew>>>" +sqlnew3);
				if(rsnew77.next())
				{
					
					dhcnt_esc=rsnew77.getInt("RunHrVio");
					//discnt=rsnew1.getInt("DisconnectionKm");
					dhcntall=dhcntall+dhcnt;
					//discntall=discntall+discnt;
					
				}
				
				*/
				
				discntall=discntall+discnt;

				String  dsct ="";
				discnt=0;
				discnt_final=0;
				int discntnew=0;
				if(Selected.equals("All")|| Selected.equalsIgnoreCase("All")){
					 dsct="SELECT count(*)  as  disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"')) ";
					}
				
				else if(Selected.equals("Transporter")|| Selected.equalsIgnoreCase("Transporter")){
					 dsct="SELECT count(*)  as  disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"'   and  OffTimeFrom >= '"+dtall1+" 00:00:00'  and    Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"'))  limit 1	 ";
					}else if(Selected.equals("Primary Escalation")|| Selected.equalsIgnoreCase("Primary Escalation") || Selected.equals("Tanker Escalation")|| Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equals("Secondary Escalation")|| Selected.equalsIgnoreCase("Secondary Escalation")){
					 dsct="SELECT count(*)  as  disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"'  and  OffTimeFrom between '"+datentm4+" 00:00:00' and '"+datentm4+" 23:59:59'    and Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"')) 	limit 1 ";
					} else {
						
						 dsct="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and  OffTimeFrom <='"+datentm3+" 23:59:59'   and Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"'))  limit 1	 ";
						
					}
				//System.out.println("dsct>>BEFORE>%11111%%%%%%%%%%%%" +dsct);
					
					ResultSet rsnew1_dscnt=st_ds.executeQuery(dsct);
					
					
					//System.out.println("dsct>>query>%11111%%%%%%%%%%%%" +dsct);
					if(rsnew1_dscnt.next())
					{
						
						discnt=rsnew1_dscnt.getInt("disconnectioncount");
						//discnt=rsnew1.getInt("DisconnectionKm");
						discnt_final=discnt_final +discnt;
						//discntall=discntall+discnt;
						
					}
					
					discntnew=discnt;
					
					if(kmtravelled > 0)
					{
						discntnew_final=discntnew_final+discntnew;
					}
					
					discnt_final_all =discnt_final_all+discnt_final;
					
					//System.out.println("discntnew>>>%11111%%%%%%%%%%%%" +discntnew);
					
					String  dsct1 ="";
					discnt_cls=0;
					discnt_final_cls=0;
					
					if(Selected.equals("All")|| Selected.equalsIgnoreCase("All")){
						 dsct1="SELECT count(*)  as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and   Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"')) 	 ";
						}
					
					else if(Selected.equals("Transporter")|| Selected.equalsIgnoreCase("Transporter")){
						 dsct1="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and  OffTimeFrom >= '"+dtall1+" 00:00:00'  and Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"')) 	 ";
						}else if(Selected.equals("Primary Escalation")|| Selected.equalsIgnoreCase("Primary Escalation") || Selected.equals("Tanker Escalation")|| Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equals("Secondary Escalation")|| Selected.equalsIgnoreCase("Secondary Escalation")){
						 dsct1="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and   OffTimeFrom between '"+datentm4+" 00:00:00' and '"+datentm4+" 23:59:59' and  Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"'))	 ";
						} else {
							
							 dsct1="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and  OffTimeFrom <='"+datentm3+" 23:59:59' and Duration>='0:30' and Reason ='Disconnection' and ignoredstamp='no' and violationstatus ='open' and ((OffTimeFrom >= '"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >='"+rs.getString("startdate")+" "+rs.getString("starttime")+"'  and OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <='"+rs.getString("startdate")+" "+rs.getString("starttime")+"' and OffTimeTo >='"+enddate+" "+endtime+"')) 	 ";
							
						}
						
						
						ResultSet rsnew1_dscnt1=st_ds1.executeQuery(dsct1);
						
						
						//System.out.println("dsct>>>%11111%%CLose QUERy%%%%%%%%%%" +dsct1);
						if(rsnew1_dscnt1.next())
						{
							
							discnt_cls=rsnew1_dscnt1.getInt("disconnectioncount");
							//discnt=rsnew1.getInt("DisconnectionKm");
							discnt_final_cls=discnt_final_cls +discnt_cls;
							//discntall=discntall+discnt;
							
						}
					
					
						//System.out.println("dsdiscnt_final_clsct>>>%11111%%ESC QUERy%%%%%%%%%%" +discnt_cls);
					
					
						String  dsct2="";
						discnt_esc=0;
						discnt_final_esc=0;
						
					////commenting the all esc queries 
					/*
						
						
						if(Selected.equals("All")|| Selected.equalsIgnoreCase("All")){
							 dsct2="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and Distance > 25 and Reason ='Disconnection'  and violationstatus ='Open' and   OffTimeFrom <='"+datentm3+" 23:59:59' and   OffTimeFrom> '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and OffTimeTo<= '"+enddate+" "+endtime+"' 	 ";
							}
						
						else if(Selected.equals("Transporter")|| Selected.equalsIgnoreCase("Transporter")){
							 dsct2="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and Distance > 25 and Reason ='Disconnection'  and violationstatus ='Open' and  OffTimeFrom < '"+dtall1+" 00:00:00'  and    OffTimeFrom>= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and OffTimeTo<= '"+enddate+" "+endtime+"' 	 ";
							}else if(Selected.equals("Primary Escalation")|| Selected.equalsIgnoreCase("Primary Escalation") || Selected.equals("Tanker Escalation")|| Selected.equalsIgnoreCase("Tanker Escalation") || Selected.equals("Secondary Escalation")|| Selected.equalsIgnoreCase("Secondary Escalation")){
							 dsct2="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and Distance > 25 and Reason ='Disconnection'  and violationstatus ='Open' and  OffTimeFrom between '"+datentm4+" 00:00:00' and '"+datentm4+" 23:59:59' and    OffTimeFrom>= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and OffTimeTo<= '"+enddate+" "+endtime+"' 	 ";
							} else {
								
								 dsct2="SELECT count(*) as disconnectioncount   FROM db_gps.t_disconnectionData where vehicleCode = '"+vehcode+"' and Distance > 25 and Reason ='Disconnection'  and violationstatus ='Open' and  OffTimeFrom <'"+datentm3+" 23:59:59' and    OffTimeFrom>= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and OffTimeTo<= '"+enddate+" "+endtime+"' 	 ";
								
							}
							
							
							ResultSet rsnew1_dscnt2=st_ds2.executeQuery(dsct2);
							
							
							System.out.println("dsct2>>>%11111%%ESC QUERy%%%%%%%%%%" +dsct2);
							if(rsnew1_dscnt2.next())
							{
								
								discnt_esc=rsnew1_dscnt2.getInt("disconnectioncount");
								//discnt=rsnew1.getInt("DisconnectionKm");
								discnt_final_esc=discnt_final_esc +discnt_esc;
								//discntall=discntall+discnt;
								
							}
						
						
							
							*/
							//System.out.println("dsdiscnt_final_clsct>>>%11111%%ESC QUERy%%%%%%%%%%" +discnt_esc);
						
						
				int sum=0;
				     sum=racount+rdcount+oscount+cdcount+ndcount+dvcount;
				   //  System.out.println("sum"  +sum);
					
				  // System.out.println(">>>>>>>discnt>>>" +discnt);
				   
				    // tot_esclt=tot_esclt+racount_esc+rdcount_esc+oscount_esc+cdcount_esc+ndcount_esc+stcnt+dhcnt+discnt;
				   
				     
				     //total_vltn=total_vltn+racount+rdcount+oscount+cdcount+ndcount+racountall_close+rdcountall_close+oscountall_close+cdcountall_close+ndcountall_close+stcnt+dhcnt+discnt;
				     
				   
				    // tot_cls_ontm=tot_cls_ontm+racount_cs+rdcount_cs+oscount_cs+cdcount_cs+ndcount_cs; 
				     
				     
				     //tot_opn=tot_opn+racount+rdcount+oscount+cdcount+ndcount+stcnt+dhcnt+discnt;
				     
				     //System.out.println("end of loop==-111>");
				     if(kmtravelled > 0 && (sum >0 ||  stcnt>=1 || cdcount>=1 || ((racount+rdcount) >=1) || oscount >=1 || discnt >0 || ndcount>=1 || dhcnt>=1  ))
					{
					   stcntall=stcntall+stcnt;
					  
					  // total_vltn=total_vltn+racount+rdcount+oscount+cdcount+ndcount+racountall_close+rdcountall_close+oscountall_close+cdcountall_close+ndcountall_close+stcnt+dhcnt+discnt;
						  
						//  tot_cls_ontm=tot_cls_ontm+racount_cs+rdcount_cs+oscount_cs+cdcount_cs+ndcount_cs; 
						  
						//  tot_esclt=tot_esclt+racount_esc+rdcount_esc+oscount_esc+cdcount_esc+ndcount_esc;
						  
						 // tot_opn=tot_opn+racount+rdcount+oscount+cdcount+ndcount+stcnt+dhcnt+discnt;
					   
						 
						 
						// tot_esclt=tot_esclt+racount_esc+rdcount_esc+oscount_esc+cdcount_esc+ndcount_esc+discnt_esc+stcnt_esc+dhcnt_esc;
				   
				     
				    // total_vltn=total_vltn+racountall+rdcountall+oscountall+cdcountall+ndcountall+dvcountall+racountall_close+rdcountall_close+oscountall_close+cdcountall_close+ndcountall_close+stcnt+dhcnt+discnt+discnt_cls+stcnt_cs+dhcnt_cs;
				     
				   
				     tot_cls_ontm=tot_cls_ontm+racount_cs+rdcount_cs+oscount_cs+cdcount_cs+ndcount_cs+discnt_cls+stcnt_cs+dhcnt_cs+dvcount_cs; 
				     
				     
				     tot_opn=tot_opn+racount+rdcount+oscount+cdcount+ndcount+stcnt+dhcnt+discnt+dvcount;
						 
				     total_vltn=tot_cls_ontm+tot_opn;
					   
				 	//System.out.println("tot_esclt======>" +tot_esclt);

						   //System.out.println(">>>>>>>racount_esc>>>" +racount_esc);
						  // System.out.println(">>>>>>>rdcount_esc>>>" +rdcount_esc);
						   //System.out.println(">>>>>>>oscount_esc>>>" +oscount_esc);
						  // System.out.println(">>>>>>>cdcount_esc>>>" +cdcount_esc);
						  // System.out.println(">>>>>>>tot_esclt>>>" +tot_esclt);
					   
						  
						  
						  
						  
					
                  //   hide=0;style=^background: white;^
			
			%>
			<tr>
			<td align="right"><div align="right"><%=i%></div></td>
			<td align="left"><div align="right"><a href="#" onclick="javascript:window.open('brief_report_7days.jsp?&vid=<%=vehcode %>&vehRegNo=<%=VehRegNo%>&Transporter=<%=transporter%>&SD=<%=rs.getString("StartDate")%> <%=rs.getString("StartTime")%>&ED=<%=enddate%> <%=endtime%>')">
			<%=tripid %></a></div></td>
			<td align="left"><div align="left"><%=VehRegNo %></div></td>
			 <td align="left"><div align="left"><%=transporter%></div></td>
					
			<td align="left"><div align="left"><%=strtplace %></div></td>
			<td align="left"><div align="left"><%=endplace %></div></td>
			<td align="right"><div align="right"><%=strtdate%></div></td>
			<td align="right"><div align="right"><%=strttime%></div></td>
			
			
			
			
			
			
			
<!--			<td align="right"><div align="right">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(strtdate+" "+rs.getString("StartTime")))%></div></td>-->
<!--			-->

			<%
			
				
			
			if(status=="Running"|| status.equalsIgnoreCase("Running"))
			{
				//System.out.println("in if loop");
				%>
				<td align="left"><div align="left">NA</div></td>
				<td align="left"><div align="left">NA</div></td>
				<%
				
			}
			else
			{
				//System.out.println("in else loop");
				%>
<!--				<td align="right"><div align="right">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(enddate+" "+endtime))%></div></td>-->
       <td align="right"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate))%></div></td>
        <td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(endtime))%></div></td>
				<% 
			}
			
			%>
			
			 <td align="left"><div align="left"><%= drvcode%></div></td>
			 <td align="left"><div align="left"><%= drivername%></div></td>
			<td align="left"><div align="left"><%=status %></div></td>
			 
			
					<td align="left"><div align="left"><%=briefedby%></div></td>
		
				  <td align="right"><div align="right"><%=oscount%></div></td>
			 <td align="right"><div align="right"><%=racount%></div></td>
			 <td align="right"><div align="right"><%=rdcount%></div></td>
			 <td align="right"><div align="right"><%=cdcount%></div></td>
			
			 <td align="right"><div align="right"><%=ndcount%></div></td>
			 <td align="right"><div align="right"><%=dvcount%></div></td>
			
			  
<!--			  <td align="right"><div align="right">< %=stcnt%></div></td>-->
			  <td align="right"><div align="right"><%=dhcnt%></div></td>
			   <td align="right"><div align="right"><%=discntnew%></div></td>
			 
			 
			 </tr>
			<%
			 i++;
				
					
			}
			}	

		
			if(hide==1)
			{
				
			%>
			<tr>
			<td align="right"><div align="right"><b>Total:-</b></div></td>
			<td align="right"><div align="right"><%="-" %></div></td>
			<td align="left"><div align="left"><%="-" %></div></td>
			<td align="left"><div align="left"><%="-"%></div></td>
			<td align="left"><div align="left"><%="-" %></div></td>
			<td align="left"><div align="left"><%="-" %></div></td>
			<td align="right"><div align="right"><%= "-"%></div></td>
			 <td align="right"><div align="right"><%="-" %></div></td>
			 <td align="left"><div align="left"><%= "-"%></div></td>
			 <td align="left"><div align="left"><%="-"%></div></td>
			 
		  <td align="left"><div align="left"><%="-"%></div></td>
		   <td align="left"><div align="left"><%="-"%></div></td>
		    <td align="left"><div align="left"><%="-"%></div></td>
		     <td align="left"><div align="left"><%="-"%></div></td>
			
					
		
			 
			  <td align="right"><div align="right"><%=oscountall%></div></td>
			 <td align="right"><div align="right"><%=racountall%></div></td>
			 <td align="right"><div align="right"><%=rdcountall%></div></td>
			 <td align="right"><div align="right"><%=cdcountall%></div></td>
			 <td align="right"><div align="right"><%=ndcountall%></div></td>
			 <td align="right"><div align="right"><%=dvcountall%></div></td>
			
			 
<!--			  <td align="right"><div align="right"><=stcntall%></div></td>-->
			   <td align="right"><div align="right"><%=dhcntall%></div></td>
			    <td align="right"><div align="right"><%=discntnew_final%></div></td>
			 
			 
			 
			 <% 
			i++;
			hide=0;
			}	
			 %>
				</tr>
				
				<%
               }
				sql="select vehid from t_tanker where  startdate>='"+date1+"' and startdate<='"+date2+"' and GPName = 'Castrol'  and TripCategory in ('tanker') order by startdate";
				
				%>
				</table>
				</div>
				
				<br></br>
				<table border="1" style="width:60em;margin-left:20em;border-collapse:collapse;background-color: #C6DEFF; "  align="center" "> 

<tr>

<td align="center" >
<b>Total violations</b>

 </td>
<td align="center">
<b>Total violations closed on time</b>
</td>
 <td align="center">
<b>Total violations escalated</b>
</td>
<td align="center">
<b>Total violations open</b>
</td>


</tr>
				
	<tr>




<td align="right"><div align="right"><%=total_vltn %></div></td>
<td align="right"><div align="right"> <%=tot_cls_ontm %></div></td>

 <td align="right"><div align="right"><%=tot_esclt %></div></td>
<td align="right"><div align="right"><%=tot_opn %></div></td>

</tr>



 
</table>  

		
				
	<br></br>			

				
	 <%	
			
						
			
			
///////*********************Before two days*******//
 

//////**************************Before four days**********************//
 System.out.println("end of loop==>");
}
}
catch(Exception e)
{
 	out.print("Exception::"+e);
 }
  finally
  {
	try
	{
	  st.close();
	  st1.close();
	  st2.close();
	  stmt1.close();
	  conn.close();
	 }
	catch(Exception e)
	{
		
	}
	
  }
%>


</div>
</form>
</body>
</html>
</jsp:useBean>
<html>
<body>
<div align="center">
<table style=" width=100% ">

<%@include file="footernew.jsp" %>
</table>
</div>	
</body>
</html>
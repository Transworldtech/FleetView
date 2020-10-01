<%@ include file="headernew.jsp" %>
<%@ page  import="java.util.*" %>
<%//System.out.println("---------check1111111 "); %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<html>
<head>


<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<!-- <link rel="stylesheet" href="calendar/main.css"> -->

<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script>
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>


<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
String from_date1,to_date1 ;
from_date1 = request.getParameter("Mdate1") ;
to_date1 = request.getParameter("Mdate2") ;
	
   if(from_date1 == null && to_date1 == null)
	{
		System.out.println("in the if statement from_date and to_date check");
	   	from_date1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) ;
		to_date1   = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) ;		
	
	}

%>

	<script language="javascript">
	function validate()
		{
			if(document.getElementById("data").value=="")
			{
		  		alert("Please select the from date");
				return false;
			}
			if(document.getElementById("data1").value=="")
			{
	  		alert("Please select the to date");
				return false;
			}
			return datevalidate();
			
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

		//alert(">>>>>>>>>>> datevalidate") ;
		SubmitForm();

		var hr1="",hr2="";
		var min1="",min2="";
//		alert("******************** ") ;
 		var date1=document.getElementById("Mdate1").value;//31-aug-2013
 		//alert("date1 "+date1) ;
		var date2=document.getElementById("Mdate2").value;
		//alert("date2 "+date2) ;
		var dm1,dd1,dy1,dm2,dd2,dy2;
		dy1=date1.substring(7,11);
		//alert("dy1 "+dy1);
		dy2=date2.substring(7,11);

      //dt1=date1.substring(12,17);
      //dt2=date2.substring(12,17);

      //alert("dt1==>"+dt1);
      //alert("dt1==>"+dt2);


      
		
		//alert("dy2 "+dy2);
		dm1=date1.substring(3,6);
	//alert("dm1 "+dm1);	
	 
		dm1= dateformat(dm1);
		
		//alert("dm1 "+dm1);
		
		dm2=date2.substring(3,6);
		//alert("dm2 "+dm2);
		dm2= dateformat(dm2);
		//alert("dm2 "+dm2);
		
		dd1=date1.substring(0,2);
		
		//alert("dd1 "+dd1);
		dd2=date2.substring(0,2);

		//alert("dd2 "+dd2);

		var date=new Date();//Mon Sep 02 2013 17:42:38 GMT+0530 (IST)
		//alert("date :- "+date);


		var day=date.getDate();
		var hr=date.getHours();
		var min=date.getMinutes();


		hr1 = date1.substring(12,14);
		min1 = date1.substring(15,17);


		hr2 = date2.substring(12,14);
		min2 = date2.substring(15,17);



		//alert("hr1:- "+hr1);
		//alert("hr2:- "+hr2);
		//alert("min2:- "+min2);
		//alert("min1:- "+min1);


		
		var month=date.getMonth()+1;
		var month1=date;
		//alert("month:- "+month);
		var day=date.getDate();
		//alert("day :- "+day);
		
		var year=date.getFullYear();
		
		if(dy1>year || dy2>year)
		{
		alert("selected year is greater than current running year please select year correctly");
		document.getElementById("Mdate1").value="";
		document.getElementById("Mdate2").value="";
		document.getElementById("Mdate1").focus;
		return false;
		}
		else if(year==dy1 && year==dy2)
		{
			if(dm1>month || dm2>month)
			{
			alert("selected month is greater than the current runnig month please select month appropriatly ");
			document.getElementById("Mdate1").value="";
			document.getElementById("Mdate2").value="";
			document.getElementById("Mdate1").focus;
			return false;
			}
		}
		
		if(dm1==month)
		{
			//alert("in the dm1==month check");
			
			if(dd1>day) //|| dd2>day)//Mon Sep 02 2013 17:42:38 GMT+0530 (IST)
			{
			alert("selected date should not be greater than todays date");
			document.getElementById("Mdate1").value="";
			document.getElementById("Mdate2").value="";
			document.getElementById("Mdate1").focus;
			return false;
			}
		}

		//alert("day :- "+day);
		//alert("day :- "+day);
		//alert("hr1 :- "+hr1);
		//alert("hr2 :- "+hr2);
		//alert("day :- "+day);
						//alert("hr1   "+hr1+"   hr  "+hr+ "hr2   "+hr2);
		
		if(dd1==day || dd2==day )
			{
				//alert("hr1 ak  "+hr1+"   hr  "+hr+ "hr2   "+hr2);
				//alert("hr2   "+hr2);
				if(hr2<hr)
				{
					//alert("selected date should not be Less than todays date");
					//document.getElementById("Mdate2").value="";
					//document.getElementById("Mdate1").value="";
					//document.getElementById("Mdate2").focus;
					//return false;
				}
				else
					if(hr1==hr || hr2==hr)
					{
						//alert("min1   "+min1+"   min  "+min+" min2  "+min2);
						if(min2<min)
						{
							alert("selected date should not be Less than todays date");
							document.getElementById("Mdate2").value="";
							document.getElementById("Mdate1").value="";
							document.getElementById("Mdate2").focus;
							return false;
						}
					}

					else
						if(hr1>hr || hr2>hr)
						{
							//alert("min1 1212  "+min1+"   min  "+min);
							if(min1>min || min2>min)
							{
								alert("selected date should not be greater than todays date");
								document.getElementById("Mdate2").value="";
								document.getElementById("Mdate1").value="";
								document.getElementById("Mdate2").focus;
								return false;
							}
						}

				
		    }



		if(dd1==day || dd2==day)
		{
		if(hr1>hr || hr2>hr)
			{
				//alert("min1****2323**   "+min1+"   min******  "+min);

				alert("selected date should not be greater than todays date");
				document.getElementById("Mdate2").value="";
				document.getElementById("Mdate1").value="";
				document.getElementById("Mdate2").focus;
				return false;


				
			}
		if(min1>min || min2>min)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("Mdate2").value="";
			document.getElementById("Mdate1").value="";
			document.getElementById("Mdate2").focus;
			return false;
		}

		}
/*
		alert("dm1 :- "+dm1);
		alert("dm2 :- "+dm2);
if(dm1==dm2)
{
		   if(dd1==dd2)
   {

if(hr<hr1)
{
	alert("selected To should not be Less than From date");

}



	   

   }
   
}

		
*/
		
			
		
		if(dm2==month)
		{	
			if(dd2>day)
			{
				//alert("in dd2 greater than day check ");
				alert("selected date should not be greater than todays date");
				document.getElementById("Mdate1").value="";
				document.getElementById("Mdate2").value="";
				document.getElementById("Mdate1").focus;
				return false;
				
		 	}
		}
	
		
		
		if(dy1>dy2)
		{
		alert("From date year  should not be greater than to date year");
		document.getElementById("Mdate1").value="";
		document.getElementById("Mdate2").value="";
		document.getElementById("Mdate1").focus;
		return false;
		}
		else if(year==dy1 && year==dy2) if(dm1>dm2)
		{
		alert("From date month is should not be greater than to date month 5");
		document.getElementById("Mdate1").value="";
		document.getElementById("Mdate2").value="";
		document.getElementById("Mdate1").focus;
		return false;
		}
	if(dm1==dm2) 
	{
		if(dd1 > dd2)
		{
			alert("From date should not be greater than to date");
			document.getElementById("Mdate1").value="";
			document.getElementById("Mdate2").value="";
			document.getElementById("Mdate1").focus;
			return false;
		}
	}
	return true;
}


	
	function open4(unitid,idate,from_date,to_date)
	{
		try
		{
		testwindow1 = window.open("IncidentViewJourneyOnMap.jsp?unitid="+unitid+"&idate="+idate+"&from_date="+from_date+"&to_date="+to_date,"ViewOnMap","width=1000,height=900,scrollbars=yes");
		//window.open opens the jsp file mentioned as a parameter in it 
		testwindow1.moveTo(250,250);
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
	          document.Total_os.action ="excel.jsp";
	          document.forms["Total_os"].submit();
	 }  
	
	function goToFullExcel(sp,date,mtsr) {
		//alert(">>>>"+sp+">>>>>>>>"+date+">>>>>>");

			window.location.href="Incident_excel.jsp?sp="+sp+"&TheDate="+date+"&month="+mtsr;	


			}
function SubmitForm()
{
	//alert(">>>>>>>>>>> SubmitForm") ;
	var date1=document.getElementById("Mdate1").value;//31-aug-2013
		//alert("date1 "+date1) ;
	var date2=document.getElementById("Mdate2").value;
	//alert("date2 "+date2) ;

if(date1=="" || date2=="" )
{
	alert("Please select the date range to view the report");
	
	return false;
}



}



	
		  	</script>

<%//System.out.println("-check "); %>
<%!
Connection conn;
Statement st,st1;
String date1 ,date2;
%>
<%
String UnitId="";	
try
{	
	String exportFileName="PMF Report.xls";
	
	try
	{
		UnitId=request.getParameter("UnitId");
		//idate=request.getParameter("idate");
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	//System.out.print(date1+"  "+ date2+"  "+ vehcode+"  "+ vehregno);
	//String MM_dbConn_STRING1 = "jdbc:mysql://192.168.2.55/db_gps" ;
	
	System.out.println("************************** ");
	String MM_dbConn_STRING1 = "jdbc:mysql://localhost/db_gps" ;
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	System.out.println("************Got the connection************** "+UnitId);
	
	//out.println(UnitId);	
}catch(Exception e)
{
	e.printStackTrace();
}
%>
 
<form id="CastrolCD" name="CastrolCD" action = "#" method="get"  onsubmit="validate();">
<div id="mytable" style="width:1450px" align="center">
	<table border="0" width="100%" align="center" >
		<tr>
		<td colspan="8" align="center">
		<table style="margin-right:95px ">
		<tr>
		<td>
		<font size="4" ><b>  Incident Report </b></font>
		</td>
		</tr>
		
		</table>
		
	</td>
	</tr>
	<tr>
	<td>
		<table border="0" width="700px" align="center" class="sortable_entry">
		<tr>
			<td>
			<div align="left">
			<b>Unit Id :</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="UnitId" id="UnitId" >

					<%
					String sql11=" select unitid from db_gps.t_processincident group by unitid";
					//sql="select Distinct(Username) as TrainerName from t_security where (TypeofUser like '%SUBUSER%' and TypeValue like '%Castrol%') and Username like '%@%' order by Username Asc";

					ResultSet rsttrainer=st1.executeQuery(sql11);
					
					while(rsttrainer.next())
					{
						
						if(UnitId!=null)
						{
							
						if(UnitId==rsttrainer.getString("unitid") || UnitId.equalsIgnoreCase(rsttrainer.getString("unitid")))					
						{%>
							
							<option value="<%=rsttrainer.getString("unitid") %>" selected="selected"><%=rsttrainer.getString("unitid")%></option>
							
						<%}else{
							%>
							
						
				<option value="<%=rsttrainer.getString("unitid")%>"><%=rsttrainer.getString("unitid")%></option>
							
					<%}
						}else{
						%>
							<option value="<%=rsttrainer.getString("unitid")%>"><%=rsttrainer.getString("unitid")%></option>				
						<%}
					
						
						}
					
					%>
									
					<%
											
					%>
					</select>
					</div>
			</td>
			
<!--			<td align="right"><b>From </b>&nbsp;&nbsp;-->
<!--			  <input type="text" id="data" name="data" value="< %=from_date1%>"  size="15" readonly/>-->
<!--			  <script type="text/javascript">    new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date())-->
<!--  				Calendar.setup(-->
<!--    			{-->
<!--      			inputField  : "data",         // ID of the input field-->
<!--      			ifFormat    : "%d-%b-%Y",     //"%Y-%m-%d"// the date format-->
<!--      			button      : "data"       // ID of the button-->
<!--    			}-->
<!--  				);	-->
<!--				</script>-->
<!--  			</td>			-->
<!--			-->
<!--			<td align="right"><b>To </b>&nbsp;&nbsp;-->
<!--			  	<input type="text" id="data1" name="data1" value="< %=to_date1%>" size="15" readonly/>-->
<!--			  	<script type="text/javascript">  new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date()) -->
<!--  				Calendar.setup(-->
<!--    			{-->
<!--      			inputField  : "data1",         // ID of the input field-->
<!--      			ifFormat    : "%d-%b-%Y",    // the date format-->
<!--      			button      : "data1"       // ID of the button-->
<!--    			}-->
<!--  				);-->
<!--				</script>-->
<!--			</td>-->


<!--<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp;-->
<!--<input type="text" id="data" name="data" value="< %=from_date1 %>" class="element text medium"   style="width:08em" size="15" readonly/>-->
<!-- -->
<!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
<!--<script type="text/javascript">-->
<!--  Calendar.setup(-->
<!--    {-->
<!--      inputField  : "data",         // ID of the input field-->
<!--      ifFormat    : "%d-%b-%Y",     // the date format-->
<!--      button      : "data"       // ID of the button-->
<!--    }-->
<!--  );-->
<!--</script>-->
<!--</td>-->
<!--<td>-->
<!--<b>To</b> &nbsp;&nbsp;&nbsp;&nbsp;-->
<!--<input type="text" id="data1" name="data1" value="< %=to_date1%>" class="element text medium"  style="width:08em"  size="15" readonly/></td><td align="left">-->
<!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--<script type="text/javascript">-->
<!--  Calendar.setup(-->
<!--    {-->
<!--      inputField  : "data1",         // ID of the input field-->
<!--      ifFormat    : "%d-%b-%Y",    // the date format-->
<!--      button      : "data1"       // ID of the button-->
<!--    }-->
<!--  );-->
<!--</script>-->
<!--</td>-->

<td style="width: 100px"><b>&nbsp;&nbsp;From Date/Time: </b></td>
			  <td>
			 <div align="left"><font color="black"> &nbsp;&nbsp;
			<input type="text" id="Mdate1" name="Mdate1"  value="<%=from_date1%>"  class="datetimepicker" style="width: 150px;"    readonly/></font></div>
			 </td>
			 <td style="width: 100px"><b>&nbsp;&nbsp;To Date/Time: </b></td>
			  <td>
			 <div align="left"><font color="black"> &nbsp;&nbsp;
			<input type="text" id="Mdate2" name="Mdate2"  value="<%=to_date1%>"  class="datetimepicker" style="width: 150px;"    readonly/></font></div>
			 </td>



<!-- 			<td> -->
<!-- 			<div align="center"> -->
<!-- 			<b>Incident Date :</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 					<select name="idate" id="idate" > -->
<!-- <!--					<option value="ALL">All</option>			--> 
<%-- 					<% 
// 					String sql111=" select stampdate  from db_gps.t_processincident group by stampdate ";
// 					//sql="select Distinct(Username) as TrainerName from t_security where (TypeofUser like '%SUBUSER%' and TypeValue like '%Castrol%') and Username like '%@%' order by Username Asc";

// 					ResultSet rsttrainer1=st1.executeQuery(sql111);
					
// 					while(rsttrainer1.next())
// 					{
// 						System.out.println(rsttrainer1.getString("stampdate"));
<%-- 					%> --%>
<%-- 					<option value="<%=rsttrainer1.getString("stampdate")%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrainer1.getString("stampdate")))%></option>				 --%>
<%-- 					<%	
// 					}						
<%-- 					%> --%>
<!-- 					</select> -->
<!-- 					</div> -->
<!-- 			</td> -->
					<td >
<!--					<div align="center"><input type="submit" name="submit" id="submit" onclick="try{return datevalidate()}catch(e){alert(e)};" value="submit" ></div>-->
		<div align="center"><input type="submit" name="submit" id="submit" onclick="" value="submit" ></div>
		
			</td>	
							
		</tr>	
		
	</table> 
	</td>
	</tr>
	</table>
</div>
</form>


<%
String test_from_date = "",test_to_date = "", unit_id = "",idate=""; 

test_from_date = request.getParameter("Mdate1") ;
test_to_date = request.getParameter("Mdate2") ;
unit_id = request.getParameter("UnitId") ;

System.out.println("from_date :- "+test_from_date) ;
System.out.println("to_date :- "+test_to_date) ;
System.out.println("unit_id :- "+unit_id) ;

//unit_id="7486";
//System.out.println(" from_date"+from_date+" to_date "+to_date +" UnitId"+UnitId);
%>


<%
try{
	

if(null != test_from_date && !("".equalsIgnoreCase(test_from_date)))
{

	System.out.println("if*************");
	String from_date = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(test_from_date)) ;
	String to_date = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(test_to_date)) ;


%>
<br>
<div  style="width:1800px " id="mytable" align="center" >
	
	<table  style="margin-left:5px"   align="">
		<tr>
			<td align="">
					
			 				 
			 				  
				<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="goToFullExcel('<%=from_date%>','<%=to_date %>','<%=unit_id %>')">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
        	</td>
		</tr>
		
		</table>	
	</div>
	
	<div style="width:900px"  id="mytable" align="center">
	
	
	<table  border="1" style="width:700px;margin-left:270px "  align="center" class="sortable"  >
	

<tr>
<th>SrNO.</th>
<th>UnitId</th>
<th>Mail Date Time</th>
<th>Count</th>

</tr>
	<tr>

<!--	<tr> -->
<!--	<th>Sr.No.</th>-->
<!--	<th>Unit Id</th>-->
<!--	<th>Vehicle Code</th>-->
<!--	<th>Date</th>-->
<!--	<th>Time</th>-->
<!--	<th>Latitude</th>-->
<!--	<th>Longitude</th>-->
<!--	<th>Speed</th>-->
<!--	<th>Direction Degree</th>-->
<!--	</tr>-->
	
	<%
int i = 1;
	
	
	//from_date="2013-09-24 00:00:00";
	//to_date="2013-09-24 23:59:59";
	String sql="",maildatetime="-";

	System.out.println("Here  ------------------- ");
	
	int count=0,totalcount=0;
	 sql = "select unitid,maildatetime, count(*) as Count from db_gps.t_processincident where  unitid='"+unit_id+"' and maildatetime>='"+from_date+"' and maildatetime<='"+to_date+"'  group by  maildatetime";
	  System.out.println(" sql count "+sql);
	
	DecimalFormat dc = new DecimalFormat("#0.00");

	ResultSet rs = st.executeQuery(sql);
	
	
	boolean flg=false;
	
	
	while(rs.next())
	{
		System.out.println("in while  ------------------- ");
		
		System.out.println(" in while count "+count);
		
		UnitId = rs.getString("unitid");
		maildatetime  = rs.getString("maildatetime");
		 count = rs.getInt("Count");
		 totalcount=totalcount+count; 
	
		 System.out.println(" UnitId "+UnitId+" maildatetime "+maildatetime+" count "+count+" totalcount "+totalcount);
	%>	
		
	
		<td align="right"><div align="right"><%=i %></div></td>
		<td align="right"><div align="right"><%=UnitId %></div></td>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(maildatetime)) %></div></td>
		<td align="right"><div align="right"><%=count %></div></td>
		
		</tr>
		
	<%
	i++;
	}
	
	
	%>
	
	<tr>
	<td align="center"><div align="center">Total</div></td>
	<td align="center"><div align="center">-</div></td>
	<td align="center"><div align="center">-</div></td>
	<td align="center"><div align="right"><%=totalcount %></div></td>
	</tr>
	<%
	
	/*
	int i = 1;
	
	
	from_date="2013-09-23";
	to_date="2013-09-23";
	String sql="";

	 sql = "select *, FORMAT(speed,4) as Sp1 from db_gps.t_processincident  where  unitid='"+unit_id+"' and maildatetime>='"+from_date+"' and maildatetime<='"+to_date+"' order by maildatetime ";

	
	DecimalFormat dc = new DecimalFormat("#0.00");
	System.out.println(sql);
	ResultSet rs = st.executeQuery(sql);
	
	//System.out.println(rs);
	boolean flg=false;
	
	
	while(rs.next())
	{
		if(!idate.equalsIgnoreCase(rs.getString("stampdate")))
		{
			flg=false;
		}
			
		
		String UnitId1 = rs.getString("unitid");
		String vehcode = rs.getString("vehcode");
		String lati = rs.getString("lati");
		String longi = rs.getString("longi");
		String TheDate = rs.getString("stampdate");
		String TheTime = rs.getString("stamptime");
		String speed = 	rs.getString("Sp1");
		String dirdig = rs.getString("dirdig");
		 idate = rs.getString("stampdate");
		java.util.Date date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("stampdate")+" "+rs.getString("stamptime"));
		
		
		
		
		
		if(flg==false)
		{

			*/
			%>
<%-- 		<input type="hidden" name="idate" id="idate" value="< %=TheDate %>"> --%>
<!--		<tr >	-->
<!--		<td  colspan="9" style="text-align: left; "><a href="#" onclick="open4('< %=unit_id %>','< %=idate %>','< %=from_date%>','< %=to_date%>')"><font size="2"><b>View Journey on Map</b></font></a></td>	-->
<!--		</tr>-->
		<%
		//flg=true;
	//	}
		
		%>
		
		
<!--		<tr>-->
<!--		<td align="right"><div align="right">< %=i %></div></td>-->
<!--		<td align="right"><div align="right">< %=UnitId1 %></div></td>-->
<!--		<td align="right"><div align="right">< %=vehcode %></div></td>-->
<!--		<td align="right"><div align="right">< %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TheDate)) %></div></td>-->
<!--		<td align="right"><div align="right">< %=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:mm:ss").parse(TheTime)) %></div></td>-->
		
		<%

		%>
<!--		<td align="right"><div align="right">< %=lati %></div></td>-->
<!--		<td align="right"><div align="right">< %=longi %></div></td>-->
<!--		<td align="right"><div align="right">< %=speed %></div></td>-->
<!--		<td align="right"><div align="right">< %=dirdig %></div></td>-->
<!--	</tr>-->
		<%
		//i++;

	}
	%> 
	</table>
	</div>
	<br>
	<%
	System.out.println("unit_id :- "+unit_id) ;
	if(unit_id!=null)
	
	{	
	%>
	
	<div style="width:900px"  id="mytable" align="center">
	<table align="" style="width:700px;margin-left:450px ">
	<tr>
	<td>
	<b>Note:</b> <font color="blue"> Only records upto 15000 can be export to excel</font> 
	</td>
	</tr>
	</table>
	</div>
	
	
	
	<%
	}
	%>
	
	
	
	
	
<%
//}else//
//{
	//System.out.println("else");
//}

}catch(Exception e) 
{
	out.print("Exception "+e);
	e.printStackTrace();
}




	%>
	
</head>	
	</html>
</jsp:useBean>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>

<br><br>
<%@include file="footernew.jsp" %>

<%@ include file="headernew.jsp"%> 

 
<!DOCTYPE HTML>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"><!-- css for datepicker -->
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script><!-- Javascript for datepicker -->
		<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
		<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
 <%-- <%-- <table border="0" width=600 align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><div align="left"><font size="3"></font></div>
			<font face="Arial" color="black" size="3"><b style= "font:normal 16px Arial,Helvtica,sans-serif;"><b> Vehicle Offline Report </b></font></td>
		</tr>
	</table> --%>
	
	
	<%
	String ftime1="",ftime2="",ttime1="",ttime2="";
	String datenew1="";
	String datenew2="";
	String vehcode=request.getParameter("vehcode");
	datenew1=request.getParameter("data");
	datenew2=request.getParameter("data1");
	ftime1=request.getParameter("ftime1");
	ftime2=request.getParameter("ftime2");
	ttime1=request.getParameter("ttime1");
	 ttime2=request.getParameter("ttime2");
	String fromdate1=datenew1+" "+ftime1+":"+ftime2;
	String todate1=datenew2+" "+ttime1+":"+ttime2;
	fromdate1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(fromdate1));
	todate1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(todate1));
	
	
	
	%>



	<table border="0" align="center" width="750" align="right" class="sortable_entry">  
 	<tr>
 	<td align="left"><font size="2" face="Arial"><b>From&nbsp;&nbsp;</b></font>
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>"  class="formElement" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ftime1" id="ftime1"  class="formElement">
		<%-- <option value="<%=ftime1%>" selected><%=ftime1%></option> --%>
			<option value="00" selected>00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<24;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
		%>
		</select>
		<select name="ftime2" id="ftime2"  class="formElement">
	<%-- 	<option value="<%=ftime2%>" selected><%=ftime2%></option> --%>
			<option value="00" selected>00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<60;i++)
				{
				%>
					<option value="<%=i%>" ><%=i%></option>
				<%
				}		
		%>
		
		</select>
  		</td>
<!--	<td align="left">-->
<!--		<input type="button" name="From Date" value="From Date" id="trigger">-->
<!--		-->
<!--	</td>-->
	<td align="left"><font size="2" face="Arial"><b>To&nbsp;&nbsp;</b></font>
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12"  class="formElement" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ttime1" id="ttime1"  class="formElement">
		
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
		
		<select name="ttime2" id="ttime2"  class="formElement" >
			<option value="<%=ttime2%>" selected><%=ttime2%></option>
			<option value="00">00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<59;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
			%>
			<option value="59" selected>59</option>
			
		
		</select>		
		</td>
<!--		<td align="left">-->
<!--  		<input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--		-->
<!--	</td>-->
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit"  class="formElement" onclick="datevalidate();">
	</div></td>
	</tr>
	</table>
	<!-- <table border="0" align="center" width="750" align="right" class="sortable_entry">  
	<tr>
	<td>
	<table border="1" align="right" width="750" align="right" class="sortable_entry">  
	<tr>
	<td align="right" style="width: 40%; display:  " id="tr1">
	<br></br>
	<div class="bodyText" align="right">
    <font size="2" face="Arial">Enter Time interval in minutes:
      <input type="text" id="interval" name="interval" size="8" style="border-color: activeborder;" value="0"/></font>
    </div>
	</td>
	<td  align="right" style="width: 30%;">
	<br></br>
	<div class="bodyText" align="right" id="tr2" >
	<font size="2" face="Arial">Show only start/stop:<br>
	<input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected(this.value);"></input>
	</font>
	</div>
	</td>
	<td  align="right" style="width: 100%; display:  " >
	<br></br>
	<div class="bodyText" align="right" id="tr3">
	<font size="2" face="Arial">Don't Show Start/Stop:<br>
	<input type="checkbox" name="extAll1" id="extAll1" value="yes"  onclick="allSelected1(this.value);"></input>
	</font>
	</div>
	</td>
	</tr>
	</table> -->

	<!-- Select date and time from calendar -->

		<%-- <div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<!-- <form action="" method="get" onsubmit="return validate();"> -->
		
		<tr>
			<tr>
			<td align="right"><font face="Arial" color="black" size="2"><b>From
			: </b></font>&nbsp;&nbsp;
			 <input type="text" id="data" name="data" value="<%=datenew1 %>" size="15" readonly  class="element text medium" style="width: 125px; height: 16px;"  /> <script
				type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "data"       // ID of the button
			    }
			  );
			</script>
			&nbsp;&nbsp;
		<select name="ftime1" id="ftime1"  class="formElement">
			<option value="00" selected>00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<24;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
		%>
		</select>
		<select name="ftime2" id="ftime2"  class="formElement">
			<option value="00" selected>00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<60;i++)
				{
				%>
					<option value="<%=i%>" ><%=i%></option>
				<%
				}		
		%>
		
		</select>
			
			
			</td>
			<td align="right"><font face="Arial" color="black" size="2"><b>To
			: </b></font>&nbsp;&nbsp; <input type="text" id="data1" name="data1" value="<%=datenew2%>" size="15" readonly   class="element text medium" style="width: 125px; height: 16px;"  /> 
			<script	type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data1",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "data1"       // ID of the button
			    }
			  );
			</script>
</td>
<td>
		<select name="ttime1" id="ttime1"  class="formElement">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
	</td>
	<td>
		<select name="ttime2" id="ttime2"  class="formElement" >
			<option value="00">00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<%
				for(int i=10;i<59;i++)
				{
				%>
					<option value="<%=i%>"><%=i%></option>
				<%
				}		
			%>
			<option value="59" selected>59</option>
			
		
		</select>		
			
			
			
			
			
			
			</td>
			<td>&nbsp;&nbsp;<input type="submit" name="submit" id="submit" onclick="datevalidate();" value="submit"></td>
		</tr>
		<!-- </form> -->
	<!-- 	<div id="chartContainer" style="height: 400px; width: 100%;"></div> -->
	</table>  --%>
		<!-- </div> -->
	<script type="text/javascript">
	function datevalidate()
	{
		var date1=document.getElementById("data").value;
		var date2=document.getElementById("data1").value;
		  var ftime1=document.getElementById("ftime1").value;
		    var ftime2=document.getElementById("ftime2").value;
		    var ttime1=document.getElementById("ttime1").value;
		    var ttime2=document.getElementById("ttime2").value;
		/* var hr1=document.getElementById("ftime1").value;
		var min1=document.getElementById("ftime2").value;
		var hr2=document.getElementById("ttime1").value;
		var min2=document.getElementById("ttime2").value;
		var dm1,dd1,dy1,dm2,dd2,dy2; */
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
		var hr=date.getHours();
		
		var min=date.getMinutes();
		//alert(hr);
		//alert(min);
		var year=date.getFullYear();
		
		if(dd11==dd22 && mm11==mm22 && yy11==yy22)
		{
		if(ftime1==ttime1)
			{
			if(ftime2==ttime2)
				{
				alert("From time and To time should not be equal");
				return false;
				}
			if(ftime2>ttime2)
			{
			alert("From time should not be greater than to time");
			return false;
			
			}
				
			}
		if(ftime1>ttime1)
			{
			alert("From time should not be greater than To time");
			return false;
			}
			
		
		
		}

		if(yy11>year  || yy22>year) 
		{
			alert("Selected date should not be greater than today's date");
		
			return false;
		}
		else if(year==yy11 && year==yy22)
		{
				if(mm11>month || mm22>month)
			{
				alert("Selected date should not be greater than today's date");
			
				return false;
			}
		}
		if(mm11==month && mm22==month)
		{
			if(dd11>day || dd22>day)
			{
				alert("Selected date should not be greater than today's date");
			
				return false;
			}
		}

		if(yy11 > yy22)
		{
			alert("From date year should not be greater than To date year");
		
			return false;
		}
		else if(year==yy11 && year==yy22)
		{
			 if(mm11>mm22)
		{
			alert("From date month should not be greater than To date month");
		
			return false;
		}
		}
		if(mm11==month && mm22==month) 
		{
			if(yy11==yy22)
			{
			if(dd11 > dd22)
			{
				alert("From date should not be greater than To date");
			
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
				
			alert("From date should not be greater than To date");
		
			return false;
		}
		
		  
		   
		graph();
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
						if(days=='May') //timeformat: "%M:%S"
							
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

	function graph()
	{
		
	var from=document.getElementById("data").value;	
	var to=document.getElementById("data1").value;	
    var ftime1=document.getElementById("ftime1").value;
    var ftime2=document.getElementById("ftime2").value;
    var ttime1=document.getElementById("ttime1").value;
    var ttime2=document.getElementById("ttime2").value;
	/* var date1 = from.split("-");
	var date2=to.split("-");
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	for(var j=0;j<months.length;j++)
	{
	    if(date1[1]==months[j])
	    {
	         date1[1]=months.indexOf(months[j])+1;
	    }                      
	} 
	
	for(var j=0;j<months.length;j++)
	{
	    if(date2[1]==months[j])
	    {
	         date2[1]=months.indexOf(months[j])+1;
	    }                      
	}  */
	/* var formattedDate1 = date1[2]+'-'+date1[1]+'-'+date1[0];
	var formattedDate2 = date2[2]+'-'+date2[1]+'-'+date2[0];
	 var fromdatetime=formattedDate1+" 00:00:00";
	 var todatetime=formattedDate2+" 23:59:59";*/
	 var vehcode=document.getElementById("vehcode").value;
	
	
	 window.location.replace("temperaturegraph.jsp?vehcode="+vehcode+"&data="+from+"&data1="+to+"&ftime1="+ftime1+"&ftime2="+ftime2+"&ttime1="+ttime1+"&ttime2="+ttime2);
	 
	/*  window.location.replace("temperaturegraph.jsp?name="+name);
	 document.getElementById("fromdatetime").value =fromdatetime;
	 document.getElementById("todatetime").value =todatetime;*/
	}
	
	//var x=  document.getElementById("data").value; 

		
	<%
	Connection con=null;
	Statement st,st1;
	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	  con = DriverManager.getConnection("jdbc:mysql://103.8.126.138/db_gps","fleetview","1@flv");
	  st=con.createStatement();
	  st1=con.createStatement(); 
	   String x="";
	  String y="";
	  String date="";
	  String dd="";
	  String mm="";
	  String yy="";
	  String temper="";
	 String vehregno=""; 
	/*String d1=request.getParameter("fromdatetime");
	String d2=request.getParameter("todatetime"); */		 
	 // DATE_FORMAT(orderdate, '%Y-%m-%d %H:%i') orderDate  CEILING(-1.23)
	 /*  String sql="SELECT thefielddatadatetime as date,sen1 as temp FROM db_gps.t_veh7963 WHERE thefielddatadatetime BETWEEN '2016-07-15 00:00:00' AND '2016-07-16 23:59:59' and replace(sen1,'$','-') and sen1<>' ' and sen1<>'-' and (sen1<>'085.000' and sen2<>'085.000' and sen3<>'085.000' and sen4<>'085.000')"; */
	 String sql="SELECT DATE_FORMAT(thefielddatadatetime,'%Y-%m-%d %H:%i') date,sen1 as temp FROM db_gps.t_veh"+vehcode+" WHERE thefielddatadatetime BETWEEN '"+fromdate1+"' AND '"+todate1+"' and replace(sen1,'$','-') and sen1<>' ' and sen1<>'-' and (sen1<>'085.000' and sen2<>'085.000' and sen3<>'085.000' and sen4<>'085.000')";
	System.out.println("query====>"+sql);
	  ResultSet Rs=st.executeQuery(sql);
	  while(Rs.next())
	  {
		/* x+="{x:"+Rs.getString("date")+",y:"+Rs.getString("temp")+"},"; */
		date=Rs.getString("date");
		y=Rs.getString("temp");
		//int y1=Integer.parseInt(y);
		Double y1=Double.parseDouble(y);
		String[] words=date.split(" ");
		String date1=words[0];
		String time1=words[1];
		String []date5=date1.split("-");
		 String yyy=date5[0];
		 String mmm=date5[1];
		 String ddd=date5[2];
		 int m9=Integer.parseInt(mmm)-1;
		 date1=yyy+"-"+m9+"-"+ddd;
		System.out.println("Date"+date1+"time1"+time1);
		String date3=date1.replace('-',',');
		String time2=time1.replace(':',',');
		System.out.println("Date"+date3+"time1"+time2);
		
		x+="{x: new Date("+date3+","+time2+") , y: "+y1+"},";
		
		
		}
	  System.out.println(x);
	  String sql1="select * from t_vehicledetails where VehicleCode='"+vehcode+"' limit 1";
		ResultSet rs=st.executeQuery(sql1);
		if(rs.next())
		{
			vehregno=rs.getString("VehicleRegNumber");
			
		} 
	  
	  
	 /*  if (x.charAt(x.length()-1)==',')
	  {
	        x= x.replace(x.substring(x.length()-1), "");
	  }
 */	 // System.out.println(x);
	  
	  %>	
	
	
	 window.onload = function () {
		 
		 
		
		
		    var chart = new CanvasJS.Chart("chartContainer",
		    {
		    	 zoomEnabled: true,
		         zoomType: "xy",
		      title:{
		        text: "Temperature for <%=vehregno%> From <%=datenew1%> <%=ftime1%>:<%=ftime2%>:00 To <%=datenew2%> <%=ttime1%>:<%=ttime2%>:00",
		        fontFamily: "Arial",
		        fontWeight: "bold",
		        fontSize: 18,
		        padding:15, 
		      },
		      exportEnabled: true,
		      axisX:{
		        title: "Time",
		        titleFontSize: 20,
		        gridThickness: 2,
		        labelFontSize: 13,
		        titleFontSize: 13,
		        titleFontFamily: "Arial",
		        intervalType: "hour", 
		        labelFontColor: "black",
		        titleFontColor: "black",
		        valueFormatString: "D-MMM-YYYY HH:mm " ,
		        labelAngle: -10
		      },
		      
		      legend: {
		          horizontalAlign: "right",
		          verticalAlign: "center"
		        },
		        
		        
		      axisY:{
		        title: "Temperature \B0C",
		        titleFontSize: 13,
		        labelFontSize: 13,
		        titleFontFamily: "Arial",
		        labelFontColor: "black",
		        titleFontColor: "black",
		        valueFormatString:  "#,##0.##"
		      },
		      data: [
		      {        
		        type: "spline",
		       
		        color: "blue",  
		        dataPoints: [//array
		                   <%=x%>
		                  
		   
		        ]
		      }
		      ]
		    });

		chart.render();
		} 
	</script>
	
	
	
	
	<script src="js/canvasjs.min.js"></script>

	<title>CanvasJS Example</title>
</head>

<body>
      <input type="hidden" style="width: 180px;" name="vehcode" id="vehcode" value="<%=vehcode%>" readonly  />
	 <input type="hidden" style="width: 180px;" name="fromdatetime" id="fromdatetime" value="<%=fromdate1%>" readonly  />
	 <input type="hidden" style="width: 180px;" name="todatetime" id="todatetime" value="<%=todate1%>" readonly  />

	<div id="chartContainer"   style="height: 400px; width: 100%;"></div>

	<!-- <button id="exportButton" type="button">Export as PDF</button> -->
</body>

</html>
<table border="0" width="100%" align="center" style="padding-bottom: 56px" >
<tr><td  bgcolor="#0B2161" >
<center><font color="white" >Copyright &copy; 2008-2016 by Transworld Technologies Ltd. All Rights Reserved.</font></center>
</td></tr>
</table>
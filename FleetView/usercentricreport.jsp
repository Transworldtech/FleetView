<%@ include file="headernew.jsp" %> 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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
	return true;String trans="";
	String trasn="select OwnerName from db_gps.t_vehicledetails where VehicleCode='"+aa+"'";
	ResultSet trasnrs=st4.executeQuery(trasn);
	if(trasnrs.next())
	{
		trans=trasnrs.getString("OwnerName");
	}
		
  	//return datevalidate();
  	
  }
  function datevalidate()
{	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	
	
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(year==dy1 && year==dy2){
	  if(dm1>month || dm2>month)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;

			return false;
	
		}
	}

	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
		alert("From date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(year==dy1 && year==dy2) if(dm1>dm2)
	{
		alert("From date month is should not be greater than to date month 5");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}

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
	
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.Total_os.action ="excel.jsp";
          document.forms["Total_os"].submit();
 }  
</script>
  
  <%!
	Connection conn, conn1;
	Statement st1,st2,st,st3,st4,st5,st6;
	int cntos,cntra,cntrda,cntdt,cntst,cntcd,cntnd,cntfc,datadaystotal;
	double cntrh=0.0;
	double cntavg=0.00;
	double cntosdur;
	String vehregno,transporter,empname,empcode;
	String datex1,datex2,data1,data2;
	
%>
<%
System.out.println("_____________________________________________________________________________________________________________");
    String str_os = "("; 
	String str_os1= "("; 
	String str_os2= "("; 
	String str_os3= "("; 
	 int temp = 1;
	 int temp1= 1 ;
	 int temp2= 1;
	 int temp3= 1;
  
	 datadaystotal=0;
  cntos=0;
  cntra=0;
  cntrda=0;
  cntdt=0;
  cntst=0;
  cntrh=0.0;
  cntcd=0;
  cntnd=0;
  cntfc=0;
  cntosdur = 0.0;
  String  exportFileName=session.getAttribute("mainuser").toString()+"_custom_report.xls";
  //code to get system date as data2 and yesterdays date as a data1.

  String ddx=request.getQueryString();
  System.out.println("88888888    "+ddx);
  String data4 = "",data5="";
 data4= datex1=request.getParameter("data");
  data5 = datex2=request.getParameter("data1");
  if(datex1==null || datex2==null)
  {
	  data4 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	  data5 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
  }
  else
  {
	  System.out.println("\n\n in date00000");
	  data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
	  data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
	  
  }
  String username = request.getParameter("uname");
  //username = username.replace("")
  System.out.println("&&&&&&&&     "+username);
  session.setAttribute("data1",data1);
  session.setAttribute("data2",data2);
  String user,usertypevalue;
  user=session.getAttribute("user").toString();
  usertypevalue=session.getAttribute("usertypevalue").toString();
  %>
  <table border="0" width="300" align="center" class="stats">
  <tr><td colspan="5" align="center">
<!-- <div align="left"><font size="3">Report No:7.0</font></div>-->
<font size="3"><b>Custom Report For Full Fleet</b></font>
</td></tr>
<form action="" method="get" onsubmit="return validate();">
<tr><td align="right">
<b>From&nbsp;&nbsp;</b>
<input type="text" id="data" name="data" value="<%=data4 %>" size="15" readonly/>
</td>
<!--<td align="left">-->
<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
</script>
<!--</td>-->
<td align="right">
<b>To&nbsp;&nbsp;</b>
  <input type="text" id="data1" name="data1" value="<%=data5 %>"  size="15" readonly/></td>
<!--  <td align="left">-->
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
<!--</td>-->
<input type="hidden" name="uname" id="uname" value="<%=username %>">
<td><input type="submit" name="submit" id="submit" value="submit"></td></tr>
</form>
</table>  
 <table border="0" width="100%" align="center">
 <tr align="center"><td align="center">
 
<%
String dd=request.getQueryString();
if(datex1==null || datex2==null)
{
out.println("<center ><font size='2'>Please select the dates to display the report.</font></center>");

}else{
//database connectivity to get the transporter wise report.
try{
	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=conn.createStatement();
	st2=conn1.createStatement();
	st4=conn1.createStatement();
	st5 = conn1.createStatement();
	st6 = conn1.createStatement();
session.setAttribute("reportno","Report No:6.0");
session.setAttribute("reportname","Custom Report For Full Fleet");
%>
<table border="0" width="100%" class="stats" align="center">
<tr align="center">
<td colspan="3" align="center">
<%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);

Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));

 %>
 <table border="0" width="100%" align="center"> 
		<tr align="center">
		<td  class="sorttable_nosort" align="center"><font size="3"><b>Full Fleet Report </b></font></td></tr></table>
		</table></td></tr><tr><td>
<form id="Total_os" name="Total_os" action="" method="post">
 <div id="mytable">
<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>

		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a></td>
			</tr></table>
		
		
		 

	

<center><font size="3" color="blue"><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=username %> For the Period : 
<%

out.print(showdate);
%> 00:00:00 am to <%

out.print(showdate1);
session.setAttribute("ShowDate",showdate+" 00:00:00");
session.setAttribute("ShowDate1",showdate1+" 23:59:00");

String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());

%> 23:59:00 am

</b></font></center>
<table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
  <tr>
      <th colspan="3" class="sorttable_nosort">
      <div align="center">Parameters considered for the Report</div>
      </th>
  </tr>
    
  <tr>
      <td class="bodyText">
      <div align="left">1. OverSpeed :<%=session.getAttribute("overspeed").toString() %>
      </div>
      </td>
      <td class="bodyText">
      <div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%>
      </div>
      </td>
      <td class="bodyText" >
      <div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%>
      </div>
      </td>
  </tr>
  
  <tr>
       <td class="bodyText">
       <div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %> 
       </div>
       </td>
       <td class="bodyText">
       <div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %>
       </div>
       </td>
       <td  class="bodyText">
       <div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %>
       </div>
       </td>
  </tr>
</table>

<p></p>
<table border="1" width="100%" class="sortable">
       <tr >
            <th>Sr.</th>
           <th>Employee Name</th>
           <th>Employee Code</th>
           <th>Veh.</th>
           <th>Transporter</th>
           <th>Date</th>
           <th>Location </th>
           <th>Data Days</th>
           <th>OS</th>
           <th>OS Dur</th>
           <th>RA</th>
           <th>RD</th>
           <th>CD</th>
           <th>DT</th>
           <th>Stops</th>
           <th>Run Hrs.</th>
           <th>ND</th>
      </tr>  
      <%
      System.out.println("_____________________________________________________________________________________________________________");
      
      System.out.println("*****  "+username);
      String groupname = "",vehidlist = "";
      System.out.println("**    "+groupname);
      String HODID = "";
      String sql = "select * from db_gps.t_userdetails where concat(FirstName,' ',LastName) = '"+username+"' ";
      System.out.println("sql    "+sql);
      ResultSet rs = st.executeQuery(sql);
      System.out.println("sql    "+sql);
      String firstname = "",lastname = "";
      if(rs.next())
      {
    	  HODID = rs.getString("SrNo");
 		 //  if(username == "kishore.kumar@se1.bp.com" || username.equals("kishore.kumar@se1.bp.com") || username == "sanjay.jetly@se1.bp.com" || username.equals("sanjay.jetly@se1.bp.com"))
    	  if(username == "Sanjay Jetly" || username.equals("Sanjay Jetly") || username == "Maria Thomas" || username.equals("Maria Thomas"))
    	  {
    		  HODID = "1029";
    	  }
    	  
    	  System.out.println("*****  "+rs.getString("HODID"));
    	  if(rs.getString("vehid") == "-" || rs.getString("vehid").equals("-"))
    	  {
    		  String sql1 = "select * from db_gps.t_userdetails where HODID = '"+HODID+"' ";
    		  ResultSet rs1 = st1.executeQuery(sql1);
    		  System.out.println("sql1    "+sql1);
    		  while(rs1.next())
    		  {
    			  System.out.println("*****  "+rs1.getString("SrNo"));
    			  if(rs1.getString("vehid") == "-" || rs1.getString("vehid").equals("-"))
    	    	  {
    				  String sql2 = "select * from db_gps.t_userdetails where HODID = '"+rs1.getString("SrNo")+"' ";
    	    		  ResultSet rs2 = st2.executeQuery(sql2);
    	    		  System.out.println("sql2    "+sql2);
    	    		  while(rs2.next())
    	    		  {
    	    			  System.out.println("*****  "+rs2.getString("SrNo"));
    	    			  if(rs2.getString("vehid") == "-" || rs2.getString("vehid").equals("-"))
    	    	    	  {
    	    			 	  String sql3 = "select * from db_gps.t_userdetails where HODID = '"+rs2.getString("SrNo")+"' ";
        	    		      ResultSet rs3 = st3.executeQuery(sql3);
        	    		      System.out.println("sql3    "+sql3);
        	    		 	  while(rs3.next())
        	    		 	  {
        	    		 		 System.out.println("*****  "+rs3.getString("SrNo"));
        	    		 		 if(rs3.getString("vehid") == "-" || rs3.getString("vehid").equals("-"))
           	    	    		 {
        	    		 			String sql4 = "select * from db_gps.t_userdetails where HODID = '"+rs3.getString("SrNo")+"' ";
              	    		        ResultSet rs4 = st4.executeQuery(sql4);
              	    		      System.out.println("sql4    "+sql4);
              	    		        while(rs4.next())
              	    		        {
              	    		        	System.out.println("*****  "+rs4.getString("SrNo"));
              	    		        	 if(rs4.getString("vehid") == "-" || rs4.getString("vehid").equals("-"))
              	    	    	    	  {
              	    		        		  
              	    	    	    	  }
              	    		        	 else
              	    		        	 {
              	    		        		 firstname = rs4.getString("FirstName");
              	    		        		 lastname = rs4.getString("LastName");
              	    		        		firstname = firstname.trim();
              	    		        		lastname = lastname.trim();
              	    		        		vehidlist =vehidlist+","+rs4.getString("vehid");
              	    		        		groupname =groupname+","+firstname+" "+lastname;
              	    		        	 }
              	    		        }
           	    	    	 	 }
        	    		 		 else
        	    		 		 {
        	    		 			firstname = rs3.getString("FirstName");
     	    		        		 lastname = rs3.getString("LastName");
     	    		        		firstname = firstname.trim();
     	    		        		lastname = lastname.trim();
        	    		 			vehidlist =vehidlist+","+rs3.getString("vehid");
        	    		 			groupname =groupname+","+firstname+" "+lastname;
        	    		 		 }
        	    		 	  }
    	    	    	  }
    	    			  else
    	    			  {
    	    				  firstname = rs2.getString("FirstName");
	    		        		 lastname = rs2.getString("LastName");
	    		        		firstname = firstname.trim();
	    		        		lastname = lastname.trim();
    	    				  vehidlist =vehidlist+","+rs2.getString("vehid");
    	    				  groupname =groupname+","+firstname+" "+lastname;
    	    			  }
    	    		  }
    	    	  }
    			  else
    			  {
    				  firstname = rs1.getString("FirstName");
		        		 lastname = rs1.getString("LastName");
		        		firstname = firstname.trim();
		        		lastname = lastname.trim();
    				  vehidlist =vehidlist+","+rs1.getString("vehid");
    				  groupname =groupname+","+firstname+" "+lastname;
    			  }
    		  }
    	  }
    	  else
    	  {
    		  firstname = rs.getString("FirstName");
     		 lastname = rs.getString("LastName");
     		firstname = firstname.trim();
     		lastname = lastname.trim();
    		  vehidlist =vehidlist+","+rs.getString("vehid");
    		  groupname =groupname+","+firstname+" "+lastname;
    	  }
      }
      System.out.println("**    "+groupname);
      if(groupname == "" || groupname.equals(""))
      {
      	
      }
      else
      {
      int len = groupname.length();
      groupname = groupname.substring(1,len);
      System.out.println("***   "+groupname);
      }
      if(vehidlist == "" || vehidlist.equals(""))
      {
    	  
      }
      else
      {
    	  vehidlist = vehidlist.substring(1,vehidlist.length());
      }
      
      String vehid[]=vehidlist.split(",");
      String group[] = groupname.split(",");
      
      
      int l = 1;
      
      for(int i = 0;i<group.length;i++)
      {
    	  System.out.println("****     "+group[i]+"   ****     "+vehid[i]);
    	  int k = 0;
    	  int j = 0;
    	  String Vehregno = "",transporter = "",empcode = "",empname = "",ND = "",location = "",date = "";
    	  int os = 0,ra =0,rd =0,cd =0,dt = 0,stsp =0,nd = 0;
    	  double osdur = 0.0,rh = 0.0;
    	sql = "select * from db_gps.t_vehicledetails where vehiclecode = '"+vehid[i]+"'";
    	rs = st.executeQuery(sql);
    	System.out.println("^^^^    "+sql);
    	if(rs.next())
    	{
    		Vehregno = rs.getString("vehicleRegNumber");
    		transporter = rs.getString("OwnerName");
    		empcode = rs.getString("EmpCode");
    		empname = group[i];
    	}
    	sql = "select * from db_gpsExceptions.t_veh"+vehid[i]+"_ds where VehCode='"+vehid[i]+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
    	ResultSet rst = st.executeQuery(sql);
    	if(rst.next())
    	{
    		location = rst.getString("Location");
    		date = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")));
    	}
    	
    	System.out.println("********   506");
    	int datadayscount = 0;
    	if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
    		System.out.println("********   506");
    		%>
			<tr>
			<td style="text-align: right"><%=l %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=Vehregno %></td>
			<td style="text-align: right"><%=transporter %></td>
			<td style="text-align: left">Blocked</td>
			<td style="text-align: left">Access denied for <%=transporter%></td>
			<td style="text-align: right"><%=datadayscount %></td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			</tr>
			<%
			l++;
		}
    	else
    	{
    		String data3 = "";
    		String sql5 = "select * from db_gps.t_empAllocationHistory where empname = '"+empname+"' and AllocationDate = '"+data1+"'";
    		ResultSet rs5 = st5.executeQuery(sql5);
    		if(rs5.next())
    		{
    			data3 = data1;
    		}
    		else
    		{
    		String sql4 = "select * from db_gps.t_empAllocationHistory where empname = '"+empname+"' and AllocationDate <= '"+data1+"'  order by Allocationdate desc limit 1";
    		ResultSet rs4 = st4.executeQuery(sql4);
    		if(rs4.next())
    		{
    			data3 = rs4.getString("AllocationDate");
    		}
    		else
    		{
    			data3 = data1;
    		}
    		}
    	 	 String sql1 = "select * from db_gps.t_empAllocationHistory where empname = '"+empname+"' and AllocationDate >= '"+data3+"' and  AllocationDate  < '"+data2+"' order by Allocationdate";
    	  	 ResultSet rs1 = st1.executeQuery(sql1);
    	   	System.out.println("****    "+sql1);
    	   	while(rs1.next())
    	   	{
    		   j++;
    		   
    		   String fromdate = "",todate = "";
    		   String vehcode= "";
    		   fromdate = rs1.getString("AllocationDate");
    		   
    		   java.util.Date fromdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
    		   java.util.Date fromdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
    		   
    		   if(fromdate1.before(fromdate2))
    		   {
    			   fromdate = data1;
    		   }
    		 
    		   
    		   System.out.println("fromdate   "+fromdate);
    		   vehcode = rs1.getString("VehicleCode");
    		  if(rs1.next())
    		  {
    		   todate = rs1.getString("AllocationDate");
    		   System.out.println("Todate   "+todate);
    		   if(fromdate == todate || fromdate.equals(todate))
    		   {
    			   
    		   }
    		   else
    		   {
    		   java.util.Date todate1 = new SimpleDateFormat("yyyy-MM-dd").parse(todate);
    		   long mil = todate1.getTime();
    		   mil = mil - 1000 * 60 * 60 *24;
    		   todate1.setTime(mil);
    		   todate = new SimpleDateFormat("yyyy-MM-dd").format(todate1);
    		  
    		   String datadays="select count(distinct(TheFieldDataDate)) as count  from db_gps.t_veh"+vehcode+" where TheFieldDataDate>='"+fromdate+"' and TheFieldDataDate<='"+todate+"'";
				ResultSet datadaysrs=st3.executeQuery(datadays);
				if(datadaysrs.next())
				{
					datadayscount = datadayscount + datadaysrs.getInt("count");
					datadaystotal=datadaystotal+datadayscount;
				}
				
				sql = "select * from db_gpsExceptions.t_veh"+vehcode+"_ds where VehCode='"+vehcode+"' and TheDate <='"+todate+"' and TheDate >='"+fromdate+"' order by TheDate desc";
				rs = st.executeQuery(sql);
				if(rs.next())
				{
					k++;
    		   ResultSet rscount = fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(vehcode,fromdate,todate);
    		   if(rscount.next())
    		   {
    			   os = os + rscount.getInt(1);
    			   cntos+=os;
    			   
    			   String sqlos="SELECT sum(Duration)as duration FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed  where concat(FromDate,' ',FromTime) >='"+fromdate+" 00:00:00' and ToDate <='"+todate+" 23:59:59' order by concat(FromDate,' ',FromTime)";
    				
    				ResultSet rstos=st4.executeQuery(sqlos);
    				if(rstos.next())
    				{
    					osdur=osdur+rstos.getDouble("Duration");
    					//System.out.println(" OS Duration--->"+osduration);
    				}
    				cntosdur= cntosdur +osdur;
    				
    				ra=ra + rscount.getInt(2);
    				cntra+=ra;
    				
    				rd=rd + rscount.getInt(3);
    				cntrda+=rd;
    				
    				cd=cd + rscount.getInt(4);
    				cntcd+=cd;
    				
    				dt=dt + rscount.getInt(5);
    				cntdt+=dt;
    				
    				stsp=rscount.getInt(6);
    				cntst+=stsp;
    				
    				rh=rh + rscount.getDouble(11);
    				cntrh=cntrh + rh;
    				
    				if(fleetview.isNightDrivingFormExceptionsForDateRange(vehcode,fromdate,todate).equals("Yes"))
    				{
    					nd++;
    					cntnd++;
    				}
    		   }
				}
    		   }
    		  }
    		  rs1.previous();
    	   }
    	   if(j>0)
    	   {
    		   if(rs1.last())
    		   {
    			   String fromdate = "",todate = "";
        		   String vehcode= "";
        		   fromdate = rs1.getString("AllocationDate");
        		   vehcode = rs1.getString("VehicleCode");
        		   
        		   java.util.Date fromdate1 = new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
        		   java.util.Date fromdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
        		   
        		   if(fromdate1.before(fromdate2))
        		   {
        			   fromdate = data1;
        		   }
        		   
        		   todate = data2;
        		 
        		String datadays="select count(distinct(TheFieldDataDate)) as count  from db_gps.t_veh"+vehcode+" where TheFieldDataDate>='"+fromdate+"' and TheFieldDataDate<='"+todate+"'";
   				ResultSet datadaysrs=st3.executeQuery(datadays);
   				if(datadaysrs.next())
   				{
   					datadayscount = datadayscount + datadaysrs.getInt("count");
   					datadaystotal=datadaystotal+datadayscount;
   				}
   				
   				sql = "select * from db_gpsExceptions.t_veh"+vehcode+"_ds where VehCode='"+vehcode+"' and TheDate <='"+todate+"' and TheDate >='"+fromdate+"' order by TheDate desc";
				rs = st.executeQuery(sql);
				if(rs.next())
				{
					k++;
   				
       		   ResultSet rscount = fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(vehcode,fromdate,todate);
       		   if(rscount.next())
       		   {
       			   os = os + rscount.getInt(1);
       			   cntos+=os;
       			   
       			   String sqlos="SELECT sum(Duration)as duration FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed  where concat(FromDate,' ',FromTime) >='"+fromdate+" 00:00:00' and ToDate <='"+todate+" 23:59:59' order by concat(FromDate,' ',FromTime)";
       				
       				ResultSet rstos=st4.executeQuery(sqlos);
       				if(rstos.next())
       				{
       					osdur=osdur+rstos.getDouble("Duration");
       					//System.out.println(" OS Duration--->"+osduration);
       				}
       				cntosdur= cntosdur +osdur;
       				
       				ra=ra + rscount.getInt(2);
       				cntra+=ra;
       				
       				rd=rd + rscount.getInt(3);
       				cntrda+=rd;
       				
       				cd=cd + rscount.getInt(4);
       				cntcd+=cd;
       				
       				dt=dt + rscount.getInt(5);
       				cntdt+=dt;
       				
       				stsp=rscount.getInt(6);
       				cntst+=stsp;
       				
       				rh=rh + rscount.getDouble(11);
       				cntrh=cntrh + rh;
       				
       				if(fleetview.isNightDrivingFormExceptionsForDateRange(vehcode,fromdate,todate).equals("Yes"))
       				{
       					nd++;
       					cntnd++;
       				}
       			   }
				}
        		}
    	   }
    	   else
    	   {
    		   String datadays="select count(distinct(TheFieldDataDate)) as count  from db_gps.t_veh"+vehid[i]+" where TheFieldDataDate>='"+data1+"' and TheFieldDataDate<='"+data2+"'";
  				ResultSet datadaysrs=st3.executeQuery(datadays);
  				if(datadaysrs.next())
  				{
  					datadayscount = datadayscount + datadaysrs.getInt("count");
  					datadaystotal=datadaystotal+datadayscount;
  				}
  				
  				sql = "select * from db_gpsExceptions.t_veh"+vehid[i]+"_ds where VehCode='"+vehid[i]+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
				rs = st.executeQuery(sql);
				if(rs.next())
				{
					k++;
      		   ResultSet rscount = fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(vehid[i],data1,data2);
      		   if(rscount.next())
      		   {
      			   os = os + rscount.getInt(1);
      			   cntos+=os;
      			   
      			   String sqlos="SELECT sum(Duration)as duration FROM db_gpsExceptions.t_veh"+vehid[i]+"_overspeed  where concat(FromDate,' ',FromTime) >='"+data1+" 00:00:00' and ToDate <='"+data2+" 23:59:59' order by concat(FromDate,' ',FromTime)";
      				
      				ResultSet rstos=st4.executeQuery(sqlos);
      				if(rstos.next())
      				{
      					osdur=osdur+rstos.getDouble("Duration");
      					//System.out.println(" OS Duration--->"+osduration);
      				}
      				cntosdur= cntosdur +osdur;
      				
      				ra=ra + rscount.getInt(2);
      				cntra+=ra;
      				
      				rd=rd + rscount.getInt(3);
      				cntrda+=rd;
      				
      				cd=cd + rscount.getInt(4);
      				cntcd+=cd;
      				
      				dt=dt + rscount.getInt(5);
      				cntdt+=dt;
      				
      				stsp=rscount.getInt(6);
      				cntst+=stsp;
      				
      				rh=rh + rscount.getDouble(11);
      				cntrh=cntrh + rh;
      				
      				if(fleetview.isNightDrivingFormExceptionsForDateRange(vehid[i],data1,data2).equals("Yes"))
      				{
      					nd++;
      					cntnd++;
      				}
      			   }
				}
    	   }
    	   
    	  if(k > 0)
    	  {
    	   %>
    	   <tr>
			<td style="text-align: right"><%=l %></td>
			<td style="text-align: left"><a href="usercentriccustomreport.jsp?empname=<%=empname %>&vehid=<%=vehid[i] %>&vehregno=<%=Vehregno %> "><%=empname %></a></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=Vehregno %></td>
			<td style="text-align: right"><%=transporter %></td>
			<td style="text-align: left"><%=date %></td>
			<td><div align="left">
			<%
			if(location.equals("-"))
	    	{
				System.out.println("**^^^^^^^^**   "+location);
			out.print(location);
		    }
			else
			{
				System.out.println("****   "+fleetview.ShowOnMapOnlyByLocation(location,vehid[i],date));
				out.print(fleetview.ShowOnMapOnlyByLocation(location,vehid[i],date));
			}
		
		%>
		</div>
			</td>
			<td style="text-align: right"><%=datadayscount %></td>
			<td><div align="right"><%=os %></div></td>
			<td><div align="right"><%=osdur %></div></td>
			<td><div align="right"><%=ra %></div></td>
			<td><div align="right"><%=rd %></div></td>
			<td><div align="right"><%=cd %></div></td>
			<td><div align="right"><%=dt %></div></td>
			<td><div align="right"><%=stsp %></div></td>
			<%
			NumberFormat nf = DecimalFormat.getNumberInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);	
			nf.setGroupingUsed(false);
			String runhrs = nf.format(rh);
			%>
			<td><div align="right"><%=runhrs %></div></td>
			<td><div align="left">
			<%
			if(nd>0)
			{
				out.println("Yes");
			}
			else
			{
				out.println("No");
			}
			%>
			</div></td>
			
			</tr>
    	   <%
    	   l++;
    	  }
    	  else
    	  {
    		  %>
  			<tr>
  			<td style="text-align: right"><%=l %></td>
  			<td style="text-align: left"><%=empname %></td>
  			<td style="text-align: right"><%=empcode %></td>
  			<td style="text-align: left"><%=Vehregno %></td>
  			<td style="text-align: right"><%=transporter %></td>
  			<td style="text-align: left">No DATA</td>
  			<td style="text-align: left">No DATA</td>
  			<td style="text-align: right"><%=datadayscount%></td>
  			<td><div align="right">0</div></td>
  			<td><div align="right">0.0</div></td>
  			<td><div align="right">0</div></td>
  			<td><div align="right">0</div></td>
  			<td><div align="right">0</div></td>
  			<td><div align="right">0</div></td>
  			<td><div align="right">0</div></td>
  			<td><div align="right">0</div></td>
  			<td style="text-align: left">No</td>
  			</tr>
  			<%
  			l++;
    	  }
    	}
      }
      
    }catch(Exception e)
{
	System.out.println("Exception   " +e);
}
finally
{
		conn.close();
		conn1.close();
	
}
}

fleetview.closeConnection1();
fleetview.closeConnection();
%>

</table>
</td>
</tr>
</table>
</div>
</form>
</td>
</tr>
</table>
</jsp:useBean>

<center><div><font size="2" face="Arial">This Report displays data based on vehicle allocation details which is available from  07-Apr-2012 onwards</font></div></center>
        <%@ include file="footernew.jsp" %>
	
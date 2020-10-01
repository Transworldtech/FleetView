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

<script language="javascript" >
/*function gotoExcel(elemId, frmFldId)
{  
	      alert("in the gotoExcel function");
          var obj = document.getElementById(elemId);
          alert("A");	
          var oFld = document.getElementById(frmFldId);
          alert("B");	
          oFld.value = obj.innerHTML;
          alert("C");
          document.interventionreport_closed.action ="excel.jsp";
          alert("D");	
          document.forms["interventionreport_closed"].submit();
          alert("E");	
}*/	

function gotoExcel(elemId,frmFldId)
{  
		  try
		  { //alert("A");	
          	var obj = document.getElementById(elemId);  
          	var oFld = document.getElementById(frmFldId);  
          	//alert("B");	
          	oFld.value = obj.innerHTML;  
          	//alert("C");	//forms[document.getElementById()]
           	document.interventionreport.action ='excel.jsp';//interventionreport_closed_form1
           	//alert("D");	
          	document.getElementById("interventionreport_closed_form1").submit();//interventionreport_closed_form1
          	//alert("E");	
		  }catch(e){ alert(e);}	


 }  

</script>

</head>
<body>
<%!
Connection conn;
Statement st,st1, stmt1,st2;
String date1, date2,datenew1,datenew2,daterm4="", vehcode, vehregno,tbname,sql,owner,km,rating,from,to,datenew11="",datenew21="",date11="",date21="",VehRegNo="",voilationdate="";
String  exportFileName="interventionreport_closed.xls";
String date_nd="",date_nd1=""; 
int os,ra,rd,cd,nd,osdur;
int oscount=0,racount=0,rdcount=0,cdcount=0,ndcount=0,dvcount=0;
String strtplace="",endplace="",strttime="",status="",strtdate="",drivername="",transporter="",briefedby="",enddate="",strtdate1="",endtime="",starttime="",Selected="";
String sql1=null,sql2=null,sql3=null,sql4=null,sql5=null,sql6=null,sql7=null,sum1="",daterm2="",daterm3="",datentm2="",datentm3="",sum2="";
int racountall=0,rdcountall=0,cdcountall=0,ndcountall=0,oscountall=0,dvcountall=0;
%>
<%
String trname=request.getParameter("trNm");

String brfDate = "",daterm="",daterm1="",datentm="",datentm1="",datentm4="";
String trainername = "";
String brStatus = "",StartDate="",EndDate="",enddate1="";

String clsedby="-",clsedbyfnl="-",clsedby1="-",clsedby2="-",clsedby3="-",clsedby4="-",clsedby5="-";


String tripid=request.getParameter("tripid");
String pagefrom="";
pagefrom=request.getParameter("rdpassport");
final String VehicleList = session.getAttribute("VehList").toString();

datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");


//System.out.println("datenew111111111   "+datenew1);
Selected=request.getParameter("Selected");
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
     cal.add(Calendar.DATE,-7);
    // cal.add(Calendar.HOUR,+12);
     datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
   //  System.out.println("datenew1 whole"   +datenew1);
     Selected = "All";
}

daterm1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("daterm111111111"   +daterm1);
Calendar cal=Calendar.getInstance();
cal.add(Calendar.DATE,-1);
daterm3=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
//System.out.println("daterm333333"   +daterm3);

daterm2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("daterm22222222"   +daterm2);
Calendar cal1=Calendar.getInstance();
cal1.add(Calendar.DATE,-2);
daterm4=new SimpleDateFormat("yyyy-MM-dd").format(cal1.getTime());
//System.out.println("daterm44444444444"   +daterm4);

datentm1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("datentm111111"   +datentm1);
Calendar cal2=Calendar.getInstance();
cal2.add(Calendar.DATE,-3);
datentm3=new SimpleDateFormat("yyyy-MM-dd").format(cal2.getTime());
//System.out.println("datentm333333333333"   +datentm3);

datentm2=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
//System.out.println("datentm22222222"   +datentm2);
Calendar cal3=Calendar.getInstance();
cal3.add(Calendar.DATE,-4);
datentm4=new SimpleDateFormat("yyyy-MM-dd").format(cal3.getTime());
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



//out.print(tbname);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();


%>

<form name="interventionreport"  id="interventionreport_closed_form1"  method="post"  >



<table border="0" width="300%" align="center" class="stats">

<tr><td align="center">

<!-- <div align="left"><font size="3">Report No:9.0</font></div>-->

<font size="3"><B> Closed Violations  Report </B></font>

</td>

<td align="right">	
<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>&nbsp;<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new Date()) %></div>
</td>

</tr>

</table>

<table border="0" width="500" align="center" class="sortable_entry">
<tr>
<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data1" name="data1" value="<%=datenew1%>" class="element text medium" size="15" readonly/>
 
<!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
</td>
<td>
<b>To</b> &nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data2" name="data2" value="<%=datenew2%>" class="element text medium" size="15" readonly/></td><td align="left">
<!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script>
</td>
<%
%>

<td>
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<input type="hidden"  name="colorvalue" id="colorvalue" value="all"></input>
<input id="bt_submit" class="button_text" type="submit" name="ubmit" value="SUBMIT" style="border-style: outset; border-color: black" />

</table>
<%
  
		  //{
	  
		 
%>

<div  id="table1" >
<table width="100%" align="center" class="sortable entry">
<tr>
				<th class="hed" align="center">Sr no</th>
				<th class="hed" align="center">Trip id</th>
				<th class="hed" align="center">Vehregno</th>
				<th class="hed" align="center">Start place</th>
				<th class="hed" align="center">End place</th>		
				<th class="hed" align="center">Status</th>
				<th class="hed" align="center">Start date</th>
				<th class="hed" align="center">End date</th>
				<th class="hed" align="center">Driver name</th>
				<th class="hed" align="center">Transporter</th>
				<th class="hed" align="center">Briefed by</th>
     			<th class="hed" align="center">Closed by</th>  
				<th class="hed" align="center">RA</th>
				<th class="hed" align="center">RD</th>
				<th class="hed" align="center">OS</th>
				<th class="hed" align="center">ND</th>
				<th class="hed" align="center">CD</th>
				<th class="hed" align="center">DV</th>
			</tr>
			<%
			
				int i=1;
			//select count(*) from db_gps.t_startedjourney where startdate between'2012-10-20' and '2012-10-27' and GPName = 'Castrol' and JStatus in('Running','tobeclosed') and TripCategory in ('Primary','Secondary');
               int hide=0;
			sql="select * from db_gps.t_startedjourney where startdate>='"+date1+"' and startdate<='"+date2+"' and Vehid in "+VehicleList+" and GPName = 'Castrol' and JStatus in('Running','Completed') and TripCategory in ('Primary','Secondary','Tanker') order by startdate ";
			
			ResultSet rs=st.executeQuery(sql);
			System.out.println("start querry"  +sql);
			racountall=0;
			rdcountall=0;
			cdcountall=0;
			ndcountall=0;
			oscountall=0;
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
				String startdate = strtdate;
				strtdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(strtdate));
				
				//System.out.println("start date1111111"  +strtdate);
				//enddate=rs.getString("");
				double kmtravelled = 0;
				drivername=rs.getString("DriverName");
				transporter=rs.getString("OwnerName");
				 
				
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
				    	sql="select EndDate,Kmtravelled from t_completedjourney where TripID='"+tripid+"'";
				    	ResultSet rs10=st2.executeQuery(sql);
				       //  System.out.println("endateqqqqqqqq" +sql);
				    	if(rs10.next())
				    	{    		
				    		 enddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs10.getString("EndDate")));
				    		 endtime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs10.getString("EndDate")));
				    		 kmtravelled = rs10.getDouble("Kmtravelled");
				    	}
				    	
				    	
				    }
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				if(kmtravelled > 0)
				{
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
		     	if(Selected.equals("All")|| Selected.equalsIgnoreCase("All"))
					{
				      sum1=" and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"' ";
				     // System.out.println("sum11111"  +sum1);
				      sum2 = " and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"'" ;
					}
				
		     	else if(Selected.equals("RM")|| Selected.equalsIgnoreCase("RM"))
		     	{
		     		 sum1= sum1+" and TheDate<='"+daterm3+"' and TheDate>='"+daterm4+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"'";
		     		// System.out.println("sum222222222222222"  +sum1);
		     		 sum2="";
		     		sum2= sum2+" and FromDate<='"+daterm3+"' and FromDate>='"+daterm4+"'  and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"'"; //cd,nd,os
		     	}
		     	else if(Selected.equals("NTM")|| Selected.equalsIgnoreCase("NTM"))
		     	{
		     		 sum1= sum1+" and TheDate<='"+datentm3+"' and TheDate>='"+datentm4+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"' ";
		     		// System.out.println("sum3333333333333333333"  +sum1);
		     		 sum2="";
			     	sum2= sum2+" and FromDate<='"+datentm3+"' and FromDate>='"+datentm4+"' and FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"'";
		     	}
		     	else
		     	{
		     		 sum1= sum1+" and TheDate>='"+strtdate +"' and TheDate<='"+datentm4+"' and TheDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and TheDateTime <= '"+enddate+" "+endtime+"' ";
		     		// System.out.println("sum444444444444444444"  +sum1);
		     		 sum2="";
			     	sum2= sum2+" and FromDate<='"+datentm4+"' and  FromDateTime  >= '"+rs.getString("StartDate")+" "+rs.getString("StartTime")+"' and FromDateTime <= '"+enddate+" "+endtime+"'";
		     	}
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				///////////////////////////Querries for calculating count//////////////////////////
				String sql2="select count( * ) as racount,ClosedBy  from db_gpsExceptions.t_vehall_ra where VehCode='"+vehcode+"' and  violationstatus='Close'  and TheDatetime>='"+startdate+" "+strttime+"' and TheDatetime<='"+enddate+" "+endtime+"'  "  ; 
				ResultSet rs2=st2.executeQuery(sql2);
				//System.out.println(">>>>>>>NNNNNNNN" +sql2);
				if(rs2.next())
				{
					
					 clsedby=rs2.getString("ClosedBy");
					racount=rs2.getInt("racount");
					racountall=racountall+racount;
				}
				
				
				
			
				String sql3="select count( * ) as rdcount,ClosedBy from db_gpsExceptions.t_vehall_rd where VehCode='"+vehcode+"' and  violationstatus='Close' and TheDatetime>='"+startdate+" "+strttime+"' and TheDatetime<='"+enddate+" "+endtime+"'   "; 
				ResultSet rs3=st2.executeQuery(sql3);
				//System.out.println(">>>>>>>NNNNNNNN" +sql3);
				if(rs3.next())
				{
					clsedby1=rs3.getString("ClosedBy");
					rdcount=rs3.getInt("rdcount");
					rdcountall=rdcountall+rdcount;
				}
				
				if(clsedby1!=null)
				{
				clsedbyfnl=clsedbyfnl+clsedby1+",";
				}
				
				String sql5="select count( * ) as cdcount,ClosedBy from db_gpsExceptions.t_vehall_crcopy where VehCode='"+vehcode+"'  and violationstatus='Close' and FromDatetime>='"+startdate+" "+strttime+"' and FromDatetime<='"+enddate+" "+endtime+"'  "; 
				ResultSet rs5=st2.executeQuery(sql5);
				//System.out.println(">>>>>>>NNNNNNNN" +sql5);
				if(rs5.next())
				{
					
					clsedby2=rs5.getString("ClosedBy");
					cdcount=rs5.getInt("cdcount");
					cdcountall=cdcountall+cdcount;
				}
				
				if(clsedby2!=null)
				{
				clsedbyfnl= clsedbyfnl+clsedby2+",";
				}
				
				
				String sql6="select count( * ) as ndcount,ClosedBy from db_gpsExceptions.t_vehall_nd where VehCode='"+vehcode+"'   and violationstatus='Close' and FromDatetime>='"+startdate+" "+strttime+"' and FromDatetime<='"+enddate+" "+endtime+"'  "; 
				
				//System.out.println(">>>>>>>NNNNNNNN" +sql6);
				ResultSet rs6=st2.executeQuery(sql6);
				System.out.println(">>>>>>>NNNNNNNNd>>" +sql6);
				if(rs6.next())
				{
					try
					{
						clsedby3=rs6.getString("ClosedBy");
					}catch(Exception e)
					{
						System.out.println("in the catch block before A");
						e.printStackTrace();
					}
					System.out.println("A");
					ndcount=rs6.getInt("ndcount");
					System.out.println("B");
					ndcountall=ndcountall+ndcount;
					
				
				}
				
				if(clsedby3!=null)
				{
					System.out.println("C");
					clsedbyfnl=clsedbyfnl+clsedby3+",";
				
				}
				
				String sqldv="select count(*) as dvcount ,ClosedBy from db_gpsExceptions.t_vehall_dv where vehcode='"+vehcode+"' and violationstatus='Close' and FromDateTime>='"+startdate+" "+strttime+"' and FromDatetime<='"+enddate+" "+endtime+"' ";
				ResultSet rsdv=st2.executeQuery(sqldv);
				if(rsdv.next())
				{
					clsedby5=rsdv.getString("ClosedBy");
					dvcount=rsdv.getInt("dvcount");
					dvcountall=dvcountall+dvcount;
				}
				
				if(clsedby5!=null){
					clsedbyfnl=clsedbyfnl+clsedby5+",";
				}
				
			
				String sql7="select count( * ) as oscount ,ClosedBy from db_gpsExceptions.t_vehall_overspeed where VehCode='"+vehcode+"'  and violationstatus='Close' and FromDatetime>='"+startdate+" "+strttime+"' and FromDatetime<='"+enddate+" "+endtime+"' "; 
				ResultSet rs7=st2.executeQuery(sql7);
				System.out.println("D");
				//System.out.println(">>>>>>>NNNNNNNN" +sql7);
				if(rs7.next())
				{
					System.out.println("E");
					clsedby4=rs7.getString("ClosedBy");
					oscount=rs7.getInt("oscount");
					oscountall=oscountall+oscount;
				}
				
				//System.out.println("F");
				if(clsedby4!=null)
				{
				clsedbyfnl=clsedbyfnl+clsedby4;
				}
				
				//System.out.println("G");
				//System.out.println("H1");
				//System.out.println("clsedby:- "+clsedby+"clsedby1:- "+clsedby1+"clsedby2:- "+clsedby2+"clsedby3:- "+clsedby3+"clsedby4:- "+clsedby4);
				
				if(clsedby!=null && clsedby1!=null && clsedby2!=null && clsedby3!=null && clsedby4!=null && clsedby5!=null)
				{
					
					System.out.println("H1");
					if(clsedby.equalsIgnoreCase(clsedby1) && clsedby1.equalsIgnoreCase(clsedby2) && clsedby3.equalsIgnoreCase(clsedby4) && clsedby4.equalsIgnoreCase(clsedby5))
					{
						System.out.println("H11");
						clsedbyfnl=clsedby;
						
						
					}else{
						System.out.println("H111");
						clsedbyfnl=clsedby+","+clsedby1+","+clsedby2+","+clsedby3+","+clsedby4+","+clsedby5;
					}
					clsedbyfnl=clsedby+","+clsedby1+","+clsedby2+","+clsedby3+","+clsedby4+","+clsedby5;
					
					System.out.println("I");
				}else if(clsedby!=null && clsedby1!=null && clsedby2!=null && clsedby3!=null)
				{
					System.out.println("J");
					if(clsedby.equalsIgnoreCase(clsedby1) && clsedby2.equalsIgnoreCase(clsedby3))
					{
						System.out.println("K");
						clsedbyfnl=clsedby;
					}else{
						clsedbyfnl=clsedby+","+clsedby1+","+clsedby2+","+clsedby3;
						System.out.println("L");	
					}
					
					clsedbyfnl=clsedby+","+clsedby1+","+clsedby2+","+clsedby3;
					System.out.println("M");
				}else if(clsedby!=null && clsedby1!=null && clsedby2!=null && clsedby4!=null && clsedby5!=null)
				{
					if(clsedby.equalsIgnoreCase(clsedby1) && clsedby2.equalsIgnoreCase(clsedby4) && clsedby4.equalsIgnoreCase(clsedby5))
					{
						System.out.println("N");	
						clsedbyfnl=clsedby;
					}else{
						
						System.out.println("O");
						clsedbyfnl=clsedby+","+clsedby1+","+clsedby2+","+clsedby4+","+clsedby5;
					}
					
					
					System.out.println("P");
				}
				else if(clsedby!=null && clsedby1!=null && clsedby2!=null)
				{
					System.out.println("Q");
					if(clsedby.equalsIgnoreCase(clsedby1) && clsedby.equalsIgnoreCase(clsedby2))
					{
						System.out.println("R");
						clsedbyfnl=clsedby;	
						
					}else{
						System.out.println("S");
						clsedbyfnl=clsedby+","+clsedby1+","+clsedby2;	
					}
					
					System.out.println("T");
					
				}else if(clsedby!=null && clsedby1!=null && clsedby3!=null)
				{
					
					if(clsedby.equalsIgnoreCase(clsedby1) && clsedby.equalsIgnoreCase(clsedby3))
					{
						
						clsedbyfnl=clsedby;
					}else{
						
						clsedbyfnl=clsedby+","+clsedby1+","+clsedby3;
						
					}
					
					
					
				}else if(clsedby!=null && clsedby1!=null && clsedby4!=null && clsedby5!=null)
				{
					
					if(clsedby.equalsIgnoreCase(clsedby1) && clsedby.equalsIgnoreCase(clsedby4) && clsedby.equalsIgnoreCase(clsedby5))
					{
						clsedbyfnl=clsedby;
						
					}else{
						clsedbyfnl=clsedby+","+clsedby1+","+clsedby4+","+clsedby5;
						
					}
				
					
				}				
				else if(clsedby!=null && clsedby1!=null)
				{
					
					if(clsedby.equalsIgnoreCase(clsedby1))
					{
						clsedbyfnl=clsedby;
						
					}else{
						clsedbyfnl=clsedby+","+clsedby1;
						
					}
					
					
					
				}else if(clsedby!=null && clsedby2!=null)
				{
					
					if(clsedby.equalsIgnoreCase(clsedby2))
					{
						clsedbyfnl=clsedby;
						
					}else{
						clsedbyfnl=clsedby+","+clsedby2;
						
					}
					
					
				}else if(clsedby!=null && clsedby3!=null)
				{
					if(clsedby.equalsIgnoreCase(clsedby3))
					{
						clsedbyfnl=clsedby;
						
					}else{
						clsedbyfnl=clsedby+","+clsedby3;
						
					}
					
					
				}else if(clsedby!=null && clsedby4!=null)
				{
					
					if(clsedby.equalsIgnoreCase(clsedby4))
					{
						clsedbyfnl=clsedby;
						
					}else{
						clsedbyfnl=clsedby+","+clsedby4;
						
					}
					
					
				}
				else if(clsedby!=null && clsedby5!=null)
				{
					
					if(clsedby.equalsIgnoreCase(clsedby5))
					{
						clsedbyfnl=clsedby;
						
					}else{
						clsedbyfnl=clsedby+","+clsedby5;
						
					}
					
					
				}
				 else if(clsedby1!=null && clsedby2!=null)
				{
					
					if(clsedby1.equalsIgnoreCase(clsedby2))
					{
						clsedbyfnl=clsedby1;
						
					}else{
						clsedbyfnl=clsedby1+","+clsedby2;
						
					}
					
					
				}else if(clsedby1!=null && clsedby3!=null)
				{
					if(clsedby1.equalsIgnoreCase(clsedby3))
					{
						clsedbyfnl=clsedby1;
						
					}else{
						clsedbyfnl=clsedby1+","+clsedby3;
						
					}
					
					
					
				}else if(clsedby1!=null && clsedby4!=null)
				{
					
					if(clsedby1.equalsIgnoreCase(clsedby4))
					{
						clsedbyfnl=clsedby1;
						
					}else{
						clsedbyfnl=clsedby1+","+clsedby4;
						
					}
					//clsedbyfnl=clsedby1+","+clsedby4;
					
				}
				else if(clsedby1!=null && clsedby5!=null)
				{
					
					if(clsedby1.equalsIgnoreCase(clsedby5))
					{
						clsedbyfnl=clsedby1;
						
					}else{
						clsedbyfnl=clsedby1+","+clsedby5;
						
					}
					//clsedbyfnl=clsedby1+","+clsedby4;
					
				}
				else if(clsedby2!=null && clsedby3!=null)
				{
					if(clsedby2.equalsIgnoreCase(clsedby3))
					{
						clsedbyfnl=clsedby2;
						
					}else{
						clsedbyfnl=clsedby2+","+clsedby3;
						
					}
					
					
				}else if(clsedby2!=null && clsedby4!=null)
				{
					
					if(clsedby2.equalsIgnoreCase(clsedby4))
					{
						clsedbyfnl=clsedby2;
						
					}else{
						clsedbyfnl=clsedby2+","+clsedby4;
						
					}
					
					
				}
				else if(clsedby2!=null && clsedby5!=null)
				{
					
					if(clsedby2.equalsIgnoreCase(clsedby5))
					{
						clsedbyfnl=clsedby2;
						
					}else{
						clsedbyfnl=clsedby2+","+clsedby5;
						
					}
					
					
				}
				else if(clsedby3!=null && clsedby4!=null)
				{
					if(clsedby3.equalsIgnoreCase(clsedby4))
					{
						clsedbyfnl=clsedby3;
						
					}else{
						clsedbyfnl=clsedby3+","+clsedby4;
						
					}
					
					
				}
				else if(clsedby3!=null && clsedby5!=null)
				{
					if(clsedby3.equalsIgnoreCase(clsedby5))
					{
						clsedbyfnl=clsedby3;
						
					}else{
						clsedbyfnl=clsedby3+","+clsedby5;
						
					}
					
					
				}
				else if(clsedby3!=null && clsedby!=null)
				{
					if(clsedby3.equalsIgnoreCase(clsedby))
					{
						clsedbyfnl=clsedby3;
						
					}else{
						clsedbyfnl=clsedby3+","+clsedby;
						
					}
					
					
				}else if(clsedby3!=null && clsedby1!=null)
				{
					
					if(clsedby1.equalsIgnoreCase(clsedby3))
					{
						clsedbyfnl=clsedby1;
						
					}else{
						clsedbyfnl=clsedby1+","+clsedby3;
						
					}
					
				}
				else if(clsedby3!=null && clsedby2!=null)
				{
					if(clsedby2.equalsIgnoreCase(clsedby3))
					{
						clsedbyfnl=clsedby2;
						
					}else{
						clsedbyfnl=clsedby2+","+clsedby3;
						
					}
					
					
				}else if(clsedby!=null)
				{
					clsedbyfnl=clsedby;
					
				}else if(clsedby1!=null)
				{
					clsedbyfnl=clsedby1;
					
				}
				else if(clsedby2!=null)
				{
					clsedbyfnl=clsedby2;
					
				}else if(clsedby3!=null)
				{
					clsedbyfnl=clsedby3;	
					
				}else if(clsedby4!=null)
				{
					clsedbyfnl=clsedby4;
					
				}else if(clsedby5!=null)
				{
					clsedbyfnl=clsedby5;
					
				}
				else {
					
					
				}
				
				
				//System.out.println(">>>>>>>clsedby" +clsedby);
				//System.out.println(">>>>>>>clsedby1" +clsedby1);
				//System.out.println(">>>>>>>clsedby2" +clsedby2);
				//System.out.println(">>>>>>>clsedby3" +clsedby3);
				//System.out.println(">>>>>>>clsedby4" +clsedby4);
				//System.out.println(">>>>>>>clsedbyfnl" +clsedbyfnl);
				
				
				
				
				
				
			       int sum=0;
				     sum=racount+rdcount+oscount+cdcount+ndcount+dvcount;
				   //  System.out.println("sum"  +sum);
					 if(sum>0)
					{
					
                  //   hide=0;
			
			%>
			<tr>
			<td align="right"><div align="right"><%=i%></div></td>
			<td align="right"><div align="right"><a href="#" onclick="javascript:window.open('brief_report_7days_closed_violation.jsp?&vid=<%=vehcode %>&vehRegNo=<%=VehRegNo%>&Transporter=<%=transporter%>&SD=<%=startdate+" "+strttime%>&ED=<%=enddate+" "+endtime%>')">
			<%=tripid %></a></div></td>
			<td align="right"><div align="right"><%=VehRegNo %></div></td>
			<td align="left"><div align="left"><%=strtplace %></div></td>
			<td align="left"><div align="left"><%=endplace %></div></td>
			<td align="left"><div align="left"><%=status %></div></td>
<!--			<td align="right"><div align="right">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(strtdate+" "+rs.getString("StartTime")))%></div></td>-->
<!--			-->
<td align="left"><div align="left"><%=strtdate%></div></td>
			<%
			
				
			
			if(status=="Running"|| status.equalsIgnoreCase("Running"))
			{
				//System.out.println("in if loop");
				%>
				<td align="left"><div align="left">NA</div></td>
				<%
				
			}
			else
			{
				//System.out.println("in else loop");
				%>
<!--				<td align="right"><div align="right">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(enddate+" "+endtime))%></div></td>-->
       <td align="left"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate))%></div></td>
				<% 
			}
			
			%>
			
			 
			 <td align="left"><div align="left"><%= drivername%></div></td>
			 <td align="left"><div align="left"><%=transporter%></div></td>
			 
			
					<td align="left"><div align="left"><%=briefedby%></div></td>
					<td align="left"><div align="left"><%=clsedbyfnl%></div></td>
		<%       
		      	
				
				 %>
			 <td align="right"><div align="right"><%=racount%></div></td>
			 <td align="right"><div align="right"><%=rdcount%></div></td>
			 <td align="right"><div align="right"><%=oscount%></div></td>
			 <td align="right"><div align="right"><%=ndcount%></div></td>
			 <td align="right"><div align="right"><%=cdcount%></div></td>
			 <td align="right"><div align="right"><%=dvcount%></div></td>
			 </tr>
			<%
			 i++;
				
					
			}
				}
			}	
			 
			System.out.println(">>>>>>>clsedbyfnl" +clsedby3);
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
					
		
			 
			 
			 <td align="right"><div align="right"><%=racountall%></div></td>
			 <td align="right"><div align="right"><%=rdcountall%></div></td>
			 <td align="right"><div align="right"><%=oscountall%></div></td>
			 <td align="right"><div align="right"><%=ndcountall%></div></td>
			 <td align="right"><div align="right"><%=cdcountall%></div></td>
			  <td align="right"><div align="right"><%=dvcountall%></div></td>
			 
			 <% 
			//i++;
			//hide=0;
			}	
			 %>
				</tr>
				
				<%
				sql="select vehid from t_tanker where  startdate>='"+date1+"' and startdate<='"+date2+"' and GPName = 'Castrol'  and TripCategory in ('tanker') order by startdate";
				
				%>
				</table>
				
				
				
	 <%	
			
						
			
			
///////*********************Before two days*******//
 

//////**************************Before four days**********************//
 
}
catch(Exception e)
{
 	System.out.print("Exception::"+e);
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

<%@include file="footernew.jsp" %>

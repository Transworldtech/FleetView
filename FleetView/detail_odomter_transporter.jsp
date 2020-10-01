
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
	<%@ include file="headernew.jsp"%>
	<html>
	<head>
	<script type="text/javascript">
	function gotoPrint(divName)  
	{  
		 
		  var printContents = document.getElementById(divName).innerHTML; 
		  var originalContents = document.body.innerHTML; 
		  
			  
		  document.body.innerHTML = printContents;  
		  window.print();
		  document.body.innerHTML = originalContents;  
	}

	function gotoExcel(elemId,frmFldId)  
	{  
		      
		     
	          var obj = document.getElementById(elemId);  
	          var oFld = document.getElementById(frmFldId); 
	          oFld.value = obj.innerHTML;
	        
	          
	          document.DetailOdoReport.action ="excel.jsp";
	          document.forms["DetailOdoReport"].submit();
	} 
		

  Xoffset=-60;    // modify these values to ...
  Yoffset= 20;    // change the popup position.
 
 var old,skn,iex=(document.all),yyy=-1000;

  var ns4=document.layers;
  var ns6=document.getElementById&&!document.all;
  var ie4=document.all;

  if (ns4)
  skn=document.dek;
  else if (ns6)
  skn=document.getElementById("dek").style;
  else if (ie4)
  skn=document.all.dek.style;headernew.jsp
  if(ns4)document.captureEvents(Event.MOUSEMOVE);
  else{
  skn.visibility="visible";
  skn.display="none";
  }
  document.onmousemove=get_mouse; 

    function show(fullaction)
    {
     //alert("show");
     
    // var i="i"+fullaction;
     //alert(fullaction.value);
    // alert(document.getElementById.fullaction.value);
     var v=fullaction.value;  
     //alert(v); 
    popup(v,"pink"); 
      
    }
 
  function popup(msg,bak){
	 // alert("popup");
  var content="<TABLE  WIDTH=150 BORDER=1 BORDERCOLOR=black CELLPADDING=2 CELLSPACING=0 "+
"BGCOLOR="+bak+"><TD ALIGN=center><FONT COLOR=black SIZE=2>"+msg+"</FONT></TD></TABLE>";
  yyy=Yoffset;
   if(ns4){skn.document.write(content);skn.document.close();skn.visibility="visible";}
   if(ns6){document.getElementById("dek").innerHTML=content;skn.display='';}
   if(ie4){document.all("dek").innerHTML=content;skn.display='';}
  }

  function get_mouse(e){

	 // alert("get mouse");
  var x=(ns4||ns6)?e.pageX:event.x+document.body.scrollLeft;
  skn.left=x+Xoffset;
  var y=(ns4||ns6)?e.pageY:event.y+document.body.scrollTop;
  skn.top=y+yyy;
  }

  function kill(){
	 // alert("kill");
  yyy=-1000;
  if(ns4){skn.visibility="hidden";}
  else if (ns6||ie4)
  skn.display="none";
  }



  function confirmDelete()
  {
	  //alert("a");
	  var  agree=confirm("Are you sure you want to delete this Record?");
	  //alert("B") ;
	  if(agree)
	  {
		 //alert("C") ;	
		 return true ;
	  }	  	   
	  else
	  {
		 //alert("D") ; 
	     return false ;
	  }	  	   
  }


</script>
	</head>


	<%
//classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

	<%@page import="com.fleetview.beans.classes"%>
	<%@page import="javax.swing.text.NumberFormatter"%>
	<form id="DetailOdoReport" name="DetailOdoReport" action="" method="post" >
	   <div id="table1">
		<%!
Connection conn, con1;
Statement st,st1,st2,st3,stveh1,stveh2;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
String dateformat;
%>
		<%
//data1=datenew1&data2=datenew2&Oname=ownerNm&odometer=odometerdiff&vehregno=vehregno&vehicleCode=vehicleCode&employeeName=employeeName		
datenew1=request.getParameter("data1");
//datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
//datenew2=request.getParameter("todate");
String vehno=request.getParameter("vehs");
String vehregno=request.getParameter("vehregno");
dateformat=session.getAttribute("dateformat").toString();
//String owner=session.getAttribute("usertypevalue").toString();
String ownerNm =request.getParameter("Oname");
String odometerdiff=request.getParameter("odometer");
String employeeName=request.getParameter("employeeName");
String vehicleCode=request.getParameter("vehicleCode");
String user=session.getAttribute("usertypevalue").toString();
String status ;
int srno_for_del ;
String status1 = request.getParameter("status");
if(status1 == null)
{
	status1="show report";
}
//System.out.println("vehicleCode=="+vehicleCode);
System.out.println("AAAAA~~~~~~");
if(status1.equalsIgnoreCase("delete"))
{
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	//System.out.println("AAAAAAAAA");
	String srno = request.getParameter("srno");
	//System.out.println("BBBB arno:- "+srno);
	String del_query = "delete from t_fuelinfo where SrNo = '"+srno+"'";
	String insert_query = "insert into t_fuelinfo_history (SrNo, Transporter, VehNo, TheDateTime, Driver, Litres, PetrolPump, EntBy, vehcode, FullTank,Odometer,Remark,updatedDtTime,gpsdistance) select * from t_fuelinfo where SrNo='"+srno+"'" ;
	System.out.println("CCCC insert_query:- "+insert_query);
	int flag1 = st.executeUpdate(insert_query);
	//System.out.println("DDDD flag1:- "+flag1);
	if(flag1>0)
	{	
		
		System.out.println("tumhi aata ya block madhe aahat karan insert query successfully ececute zali aahe please database madhala table check kara thank you ");
		
		String update_action_query = "update t_fuelinfo_history set Action='Deleted' ";
		
		int flag2 =  st.executeUpdate(update_action_query);
		
		if(flag2>0)
		{
			System.out.println("tumchya table madhla action coloumn update zala aahe krupaya check kara table madhe ");
		}
		else
		{
			System.out.println("Arrrey re re re  update kartana sql madhe kahitari chuk zali aahe krupaya query check kara ");
		}
		
		
		int flag  =  st.executeUpdate(del_query);
		
		if(flag>0)
		{
			System.out.println("deleted successfully ");
			%> <script type="text/javascript">alert("Deleted Successfully!!!")</script><% 
		//response.sendRedirect("detail_odomter_transporter.jsp?data1="+datenew1+"&data2="+datenew2+"&Oname="+ownerNm+"&odometer="+odometerdiff+"&vehregno="+vehregno+"&vehicleCode="+vehicleCode+"&employeeName="+employeeName+"&status=show report");
		}
		else 
		{
			System.out.println("couldn't delete check the operation");
		}
	
		System.out.println("SSSSSSS   @@@@"+response);
		%> <script type="text/javascript">
	
		window.location="detail_odomter_transporter.jsp?data1="+"<%=datenew1%>"+"&data2="+"<%=datenew2%>"+"&Oname="+"<%=ownerNm%>"+"&odometer="+"<%=odometerdiff%>"+"&vehregno="+"<%=vehregno%>"+"&vehicleCode="+"<%=vehicleCode%>"+"&employeeName="+"<%=employeeName%>";
		</script>
		<% 
		//detail_odomter_transporter.jsp?data1=2012-11-02&data2=2013-11-19&Oname=Castrol EMP VEH&odometer=1954&vehregno=RJ 14 CP 4293&vehicleCode=3323&employeeName=Dhruv Lakhotia
	 }
	 else
	 {
		 %><script type="text/javascript">alert("sorry couldn't delete please try again this may have occured due to unsuccessful insertion of row to be deleted in the fuelinfo_history table");</script><% 
	 }
}	
else if(status1.equalsIgnoreCase("edit"))
{
	
}
else
{	
	try
	{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st3=con1.createStatement();
	stveh1 =conn.createStatement();
	stveh2=conn.createStatement();
	String exportFileName=session.getAttribute("user").toString()+"_DetailOdoReport.xls";
	System.out.println(exportFileName);
%>

<table width="100%" align="center" class="sortable">
		<tr>
			<td align="center" class="sorttable_nosort">
			<!-- <div align="left"><font color="block" size="3">Report
			No: 5.6</font></div>-->
			<font face="arial" color="block" size="3"><b>Detail Report for Fuel & odometer from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew1)) %> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew2)) %></b></font>
			<div align="right"><!--<a href="#" onclick="javascript:window.open('printcustfuel.jsp?owner=< %=ownerNm%>&vehno=< %=vehno%>&data=< %=date1 %>&data1=< %=date2 %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>-->&nbsp;
			&nbsp; 
			<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
			<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />
      
			<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
		      
			<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
			<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
			
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
			</div>
			</td>
		</tr>
 
	</table>
	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th><b>Edit/Delete</b></th>
			<th><b> Sr. </b></th>
			<th><b>VehID</b></th>
			<th><b>User</b></th>
			<th><b>Driver</b></th>
			<th><b>Date-Time</b></th>
			<th><b>Odometer reading</b></th>
			<th><b>OdoDistance</b></th>
			<th><b>GpsDistance</b></th>
			<th><b>Odo-Gps</b></th>
			
		
			<th>
			<%
	     
	      			if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{
	    	  	%> <b> Gallans </b> <%	}
				else
				{%> <b> Liters </b> <%
				}%>
			</th>
			<th><b>Ent By</b></th>
			<th><b>Ent Date Time</b></th>
           <th><b>Remark and </b>
			
			<%
	      if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
				{
	    	  
	    	  %> <b> Gas Station</b> <%	}
				else
				{%> <b> Petrol Pump</b> <%
				}%>
			</th>
			
			
		</tr>
		<%
			String trans="",remark="";
			int c=1;
			int i=1;
			double fueladded=0,totfuel=0,totalGpsDiff=0,totalOdoDiff=0,finalDiff=0 ,totalfinalDiff=0;
			double Avg=0.00;
			//owner ="Penzoil1";
			Double odolast=0.00,odofirst=0.00,Odometer1=0.00;
			int cnt=0,temp=0;
			String vehicle="",datetime="",driver="",odometer="",petrolpump="",entby="";
			double lits=0.0,prvOdo=0,currOdo=0;
			String sql21="select * from t_fuelinfo where VehNo='"+vehregno+"' and TheDateTime between '"+datenew1+" 00:00:00' and '"+datenew2+" 23:59:59' order by TheDateTime";
			System.out.println("ikde bagh  detail====>"+sql21);
			ResultSet rsgps=st1.executeQuery(sql21);
			ResultSet rs21=st.executeQuery(sql21);
			while(rs21.next())
			{
				double odo=0.0;
				double gpsveh=0;
				
				double odo1=0.0;
				double gpsveh1=0;
				
				currOdo=0;
				prvOdo=0;
				double odoDiff=0;
				double gpsDiff=0;
				String updatedate = "";
				String fuelDateTime="";
				String fieldDate="";
				String fieldTime="";
				
				String fuelDateTime1="";
				String fieldDate1="";
				String fieldTime1="";
				String tankfull="-";
				String first="";
				String last="";
				prvOdo=0;
			//	System.out.println("\n\n tank 1-->>"+tankfull);
				tankfull=rs21.getString("FullTank");
				System.out.println("\n\n tank full-->>"+tankfull);
				vehicle=rs21.getString("VehNo");
				datetime=rs21.getString("TheDateTime");
				driver=rs21.getString("Driver");
				updatedate = rs21.getString("updatedDtTime");
				/*String sql4 = "select * from t_drivers where Owner='"
 					+ user + "' order by DriverName asc";
			System.out.println(sql4);
			ResultSet rs5 = st3.executeQuery(sql4);
			if (rs5.next()) {
				//lastdriverid = rs5.getString("DriverId");
				driver = rs5.getString("DriverName");
				System.out.println("\n\n driver name-->>"+driver);
			}*/
				
				if("Select".equalsIgnoreCase(driver)){
					driver="-";
				}
			if(cnt>0)
			{
				prvOdo=Double.parseDouble(odometer);
				
			}	
			odometer=rs21.getString("Odometer");
			if(odometer.equals("-"))
			{
				currOdo=0;
			}
			else
			{
			currOdo=Double.parseDouble(odometer);
			}
			System.out.println("\n\n preveous odo->>"+prvOdo);		
			System.out.println("\n\n current odo->>"+currOdo);	
				
				lits=rs21.getDouble("Litres");
				petrolpump=rs21.getString("PetrolPump");
				System.out.println("\n\n PetrolPump name-->>"+petrolpump);
				if(petrolpump.equals("-") || petrolpump.equals(""))
				{
					petrolpump="PetrolPump Not Entered";
				}
				entby=rs21.getString("EntBy");
				String eny="select FirstName,LastName from db_gps.t_userdetails where UserName='"+entby+"'";
				System.out.println("\n\n username query-->>"+eny);
				ResultSet rste=st3.executeQuery(eny);
				if(rste.next())
				{
					first=rste.getString("FirstName");
					last=rste.getString("LastName");
					entby=first+" "+last;
					
				}
			
				remark=rs21.getString("Remark");
				System.out.println("\n\n Remark name-->>"+remark);
				if(remark.equals("-") || remark.equals("") || remark.equals(" ") || (remark==null))
				{
					remark="No Remark";
				}
				fueladded=fueladded+lits;
				if(cnt==0)
				{
					gpsDiff=0;
					odoDiff=0;
				}
				else{
					//calculate Odometer difference
					if(currOdo!=0)
					odoDiff=currOdo-prvOdo;
						
					
					if(rsgps.next())
					{
				
					
					
					fuelDateTime=rsgps.getString("TheDateTime");
					
					try{
					if(rsgps.next())
					{
					
					fuelDateTime1=rsgps.getString("TheDateTime");
				//	out.println("\n"+fuelDateTime1);
					try{
						if(cnt>1)
						{
							String sqlgpsFirst="SELECT Distance, TheFieldDataDate, TheFieldDataTime,TheFieldDataDateTime " +
							"FROM t_veh"+vehicleCode+" " +
							"WHERE  TheFieldDataDateTime <= '"+fuelDateTime+"' " +
							"AND TheFiledTextFileName in ('SI','ON','OF') " +
							"ORDER BY TheFieldDataDateTime " +
							"DESC LIMIT 1";
						//	System.out.println("datechange <===>"+sqlgpsFirst);
							ResultSet rsveh1=stveh1.executeQuery(sqlgpsFirst);
							if(rsveh1.next()){
								fuelDateTime=rsveh1.getString("TheFieldDataDateTime");
								//System.out.println("new date <===>"+sqlgpsFirst);
							}
						}
						String sqlgpsFirst="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
						"FROM t_veh"+vehicleCode+" " +
						"WHERE  TheFieldDataDateTime BETWEEN '"+fuelDateTime+"' AND '"+fuelDateTime1+"' " +
						"AND TheFiledTextFileName in ('SI','ON','OF') " +
						"ORDER BY TheFieldDataDateTime " +
						"LIMIT 1";
					//	System.out.println("1st=="+sqlgpsFirst);
						ResultSet rsveh1=stveh1.executeQuery(sqlgpsFirst);
						if(rsveh1.next()){
						fieldDate=rsveh1.getString("TheFieldDataDate");
						fieldTime=rsveh1.getString("TheFieldDataTime");
						gpsveh=Double.parseDouble(rsveh1.getString("Distance"));
						System.out.println("gpsveh="+gpsveh);
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();//printd the whole error trace 
				}
					try{
							String sqlgpsSecond="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
							"FROM t_veh"+vehicleCode+" " +
							"WHERE TheFieldDataDateTime BETWEEN '"+fuelDateTime+"' AND '"+fuelDateTime1+"'" +
							"AND TheFiledTextFileName in ('SI','ON','OF') " +
							"ORDER BY TheFieldDataDateTime DESC " +
							"LIMIT 1";
						//	System.out.println("2nd=="+sqlgpsSecond);
							ResultSet rsveh2=stveh2.executeQuery(sqlgpsSecond);
							if(rsveh2.next()){
							fieldDate1=rsveh2.getString("TheFieldDataDate");
							fieldTime1=rsveh2.getString("TheFieldDataTime");
							gpsveh1=Double.parseDouble(rsveh2.getString("Distance"));
							System.out.println("\ngpsveh1="+gpsveh1);
							gpsDiff=gpsveh1-gpsveh;
							System.out.println("\ngpsDiff="+gpsDiff);
					}
					}
					catch(Exception e){
						e.printStackTrace();
					}
					
					}
					
				}catch(Exception e){
					e.printStackTrace();
				}
					
					totalGpsDiff=totalGpsDiff+gpsDiff;
					totalOdoDiff=totalOdoDiff+odoDiff;
					
						finalDiff=odoDiff-gpsDiff;
					
					totalfinalDiff=totalfinalDiff+finalDiff;
					//System.out.println("\ngpdiff="+gpsDiff);
					rsgps.previous();
				}
				
				}				
				datetime=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
				System.out.println("\n\n date -->>"+datetime);
			%>
<!-- data1=datenew1&data2=datenew2&Oname=ownerNm&odometer=odometerdiff&vehregno=vehregno&vehicleCode=vehicleCode&employeeName=employeeName -->			
		<tr>
			<td style="text-align: right">
				<a href="#" onclick="window.open('editpage_for_detail_odometer_report.jsp?data1=<%=datenew1%>&data2=<%=datenew2%>&Oname=<%=ownerNm%>&odometer=<%=odometerdiff%>&vehregno=<%=vehregno%>&vehicleCode=<%=vehicleCode%>&employeeName=<%=employeeName%>&status=edit&srno=<%=rs21.getString("SrNo")%>','Edit_PopUp_Window','width=890,height=800,toolbar=true,location=false,status=no,menubar=no,resizable=yes,scrollbars=no,left=50,top=50');"> <img src="images/edittt1.jpeg" width="15px" height="15px" style="border-style: none"></img>  </a> /  
				
				<a href="detail_odomter_transporter.jsp?data1=<%=datenew1%>&data2=<%=datenew2%>&Oname=<%=ownerNm%>&odometer=<%=odometerdiff%>&vehregno=<%=vehregno%>&vehicleCode=<%=vehicleCode%>&employeeName=<%=employeeName%>&status=delete&srno=<%=rs21.getString("SrNo")%>" onClick="return confirmDelete();"> <img src="images/delete.jpeg" width="15px" height="15px" style="border-style: none" ></img>   
				
				</a>
			</td>
			
			<td style="text-align: right"><%=i++ %></td>
			<td style="text-align: left"><%=vehicle %></td>
			<td style="text-align: right"><%=employeeName%></td>
			<td style="text-align: left"><%=driver %></td>
			<td style="text-align: right"><%=datetime %></td>
			
			<td style="text-align: right"><%=odometer%></td>
			<td style="text-align: right"><%=Double.valueOf(odoDiff).intValue()%></td>
			<td style="text-align: right"><%=Double.valueOf(gpsDiff).intValue()%></td>
			<td style="text-align: right"><%=Double.valueOf(finalDiff).intValue()%></td>
			<td style="text-align: right"><%=lits%></td>
			
			<td style="text-align: left"><%=entby %></td>
			<td style="text-align: right;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedate)) %></td>
			<%
				//if(null==remark || "null".equalsIgnoreCase(remark) || "-".equalsIgnoreCase(remark)){
					if(tankfull.equals("No"))
					{
%>
			<td style="text-align: left"><%=remark%> :<%=petrolpump%></td>

			<%
				}
				else{
					
				
%>
             <td style="text-align: left"><%=remark%> :<%=petrolpump%> :Full tank</td>
		
		
			<!--<td style="text-align: left"><input type="hidden" id="i+< %=c %>" name="i+< %=c %>" value="< %=remark%>< %=c %>">
				< %=remark %>...
			<div id="sh< %=c %>" name="sh< %=c %>">
				<a href="#" ONMOUSEOVER="show(document.getElementById('i+< %=c %>'))" ; ONMOUSEOUT="kill()">Show Remark </a></div>
			</td>-->
			<%
				//	c=c+1;
			}
%>
		</tr>
		<%
		cnt++;
			}
			/*String sql2="select * from t_group where gpname='"+ownerNm+"'";
			ResultSet rs2=st.executeQuery(sql2);
			if(rs2.next())
			{
				trans=rs2.getString("vehregno");
			}
				int i=1;
				int dist=0,totdist=0;
				double fueladded=0,totfuel=0;
				String Vehcode="",tabname="";
				String sql1="select * from t_fuelinfo where Transporter='"+ownerNm+"' and TheDateTime >= '"+datenew1+" 00:00:00' and TheDateTime <='"+datenew2+" 23:59:59' and Transporter ='"+ownerNm+"' order by Thedatetime desc";
				//System.out.println(sql1);
				ResultSet rs1=st1.executeQuery(sql1);
				while(rs1.next())
				{
					 if(i==1)
					 {	
						 odofirst=rs1.getDouble("Odometer");
					 }
					//Vehcode=rs1.getString("vehcode");
					String sqlvehcode="select VehicleCode from db_gps.t_vehicledetails where VehicleRegNumber='"+rs1.getString("Vehno")+"' and status='-'";
					ResultSet rstcode=st.executeQuery(sqlvehcode);
					if(rstcode.next())
					{
						Vehcode=rstcode.getString("VehicleCode");
					}
					tabname="t_veh"+Vehcode+"_ds";
					fueladded=Double.parseDouble(rs1.getString("Litres"));
					totfuel=totfuel+fueladded;*/
			%>
		<!--<tr>
				<td style="text-align: right"> < %=i %></td>
				<td style="text-align: left"> < %=rs1.getString("VehNo") %></td>
				<%
					//String datef=new SimpleDateFormat(dateformat+" hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rs1.getString("TheDateTime")));
				%>
				<td style="text-align: left"> < %=datef %></td>
				<td style="text-align: left"> < %=rs1.getString("Driver") %></td>
				<td style="text-align: right">< %=rs1.getDouble("Odometer")%></td>
				 
				 <td ><div align="right">
				<%
					//if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					//{ 
				%>
<!--				 			
				<%
					//}else{ 
				%>
				 			<% //=rs1.getString("Litres") %>
				<% //} %>
				 </div></td>
				<td style="text-align: left"> < %=rs1.getString("PetrolPump") %></td>
				<td style="text-align: left"> < %=rs1.getString("EntBy") %></td>
			</tr>-->

		<%
				/*i++;
				} if(rs1.last())
				{
					odolast=rs1.getDouble("Odometer");
				}
			
			 Odometer1= odolast-odofirst;*/
			if(i>1){
			 %>
		<tr>
			<td class="bodyText" colspan="5">
			<div align="right"><b>Total</b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=odometerdiff%></b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=Double.valueOf(totalOdoDiff).intValue()%></b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=Double.valueOf(totalGpsDiff).intValue()%></b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=Double.valueOf(totalfinalDiff).intValue()%></b></div>
			</td>
			<td class="bodyText">
			<div align="right"><b><%=fueladded%></b></div>
			</td>
			<td class="bodyText" colspan="4">
			<div align="right"></div>
			</td>
		</tr>
		<%} %>
	</table>
	</div>
	</form>

	<%
			
}
catch(Exception e)
{
 //	out.print("Exception::"+e);
 	e.printStackTrace();
}
finally
{
	try{
		con1.close();
		}
	catch(Exception e)
	{}
	try{
		conn.close();
		}
	catch(Exception e)
	{}
	try{
		fleetview.closeConnection();
		}
	catch(Exception e)
	{}
}
//ALTER TABLE `db_gps.t_fuelinfo_history` CHANGE `updatedDtTime` `updatedDtTime` DATETIME NULL DEFAULT '0000-00-00 00:00';
//ALTER TABLE `db_gps.t_fuelinfo_history` ADD `Action_DateTime` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ;
 }
%>



</html>
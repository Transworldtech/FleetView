<html>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<%@ include file="header.jsp" %>
<%@ include file="headercallcenter.jsp" %>	
</td></tr>
<script src="sorttable.js"></script>
<script language="javascript">
function Validate()
{ 
    
	if(document.venderkmentry.data.value=="") 
	{
		alert("Please select From Date");
		return false;
	}

	var date2=document.getElementById("data1").value;
	if(date2=="")
	{
		alert("Please select To Date");
		return false;
	}

	return datevalidate();
  	
	
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
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
	else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
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
		alert("From date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}
</script>
<%!
Connection con1, con2, con3;
%>

<form name="venderkmentry" method="get" action="kmdetails.jsp" onSubmit="return Validate();">
<%
try {

Class.forName(MM_dbConn_DRIVER); 
con1 = DriverManager.getConnection(MM_dbConn_STRING5,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
con2 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
con3 = DriverManager.getConnection(MM_dbConn_STRING7,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);

Statement stmt1 = con1.createStatement(), stmt2 = con2.createStatement(),
stmt3 = con2.createStatement(),stmt4 = con2.createStatement();
ResultSet rs1=null, rs2=null, rs3=null,rs4=null;
String sql1="", sql2="", sql3="";
%>
<tr><td>
	<table border="0" width="100%"  bgcolor="white">
	<tr><td align="left">

  <input type="text" id="data" name="data" class="formElement"  size="10" readonly/>
  
<input type="button" name="From Date" value="From Date" id="trigger" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

 <input type="text" id="data1" name="data1" class="formElement"  size="10" readonly/>
  
<input type="button" name="To Date" value="To Date" id="trigger1" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" name="submit" value="Submit" class="formElement">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2"><b> Note : Please select date to check Report.</font>
</td>

</tr>
</table>	
<%
String fromdate=request.getParameter("data");
String todate=request.getParameter("data1");

%>


<%	if(fromdate=="" || fromdate==null)	
	{
	}
	else
	{ %>	
<%
java.util.Date d1= new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
long miliseconds=d1.getTime();
miliseconds=miliseconds+ 1000 * 60 * 60 *24;
d1.setTime(miliseconds);	
 String fromdate1= new SimpleDateFormat("yyyy-MM-dd").format(d1);			
//out.print("next"+ fromdate1);

java.util.Date d2= new SimpleDateFormat("yyyy-MM-dd").parse(todate);
long miliseconds4=d2.getTime();
miliseconds4=miliseconds4+ 1000 * 60 * 60 *24;
d2.setTime(miliseconds4);	
 String todate1= new SimpleDateFormat("yyyy-MM-dd").format(d2);			
//out.print("next ="+ todate1);
%>
<table border="0" width="100%" >
<tr bgcolor="#F0E68C">
<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :</b></td ><td bgcolor="#CCFFCC" class="sorttable_nosort" align="center"><b>Got Full 24 hours Data</b></td><td bgcolor="#FFFFCC" class="sorttable_nosort" align="center"><b>Got Less than 24 hours data</b></td>
</tr>
</table>	
<table border="0" width="100%" >
	  <tr>
		<td width="65%">  <div align="right"> <font color="blue" size="3"> <B> Km Details from 
<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%> </B> </font></div> 	
		</td>
	<td><div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('printkmdetail.jsp?fromdate=<%=fromdate%>&fromdate1=<%=todate%>');" title="Print Current Position Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="Excelkmdetails.jsp?fromdate=<%=fromdate%>&fromdate1=<%=todate%>" title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>&nbsp;&nbsp;&nbsp;
		Date : <%
		Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
		String curdate = fmt.format(new java.util.Date());
		//out.print(curdate); %>
	</div></td>
	  </tr>
	</table>
		
	<table border="0" width="100%" class="" bgcolor="white">
	
	  <tr bgcolor="#DCDCDC">
		<td class="bodyText">  <div align="center"> <font color="maroon" size=""> <B> Sr No </B> </font> </td>
		<td class="bodyText">  <div align="center"> <font color="maroon"> <B> Vehicles</B> </font></td>
	     <td>
		 <table border="0" width="100%" >
	  	 <tr>
		   <td align="center" class="bodyText"> <font color="maroon"> <B> As per Vendor </B> </font> </div> </td>
 		 </tr>
		<tr>
		    <table border="0" width="100%" >
	  	     <tr>
	<td width="33%" class="bodyText"> <font color="maroon"> <div align="center"><B>Opening Km </div> </font></td>
	<td width="33%" class="bodyText"> <font color="maroon"> <div align="center"><B>Closing Km</div></font></td>
	<td width="33%" class="bodyText"> <font color="maroon"> <div align="center"><B>Total km</div></font></td>
		     </tr>	
		    </table>	
 		
            </td>

	<td>
		 <table border="0" width="100%" >
	  	 <tr>
		   <td class="bodyText">  <div align="center"> <font color="maroon"> <B> As per EXL </B> </font>
		 </div> </td>
 		 </tr>
		<tr>
		    <table border="0" width="100%" >
	  	     <tr>
		       <td  align="center" width="33%" > <font color="maroon"><B>Kms  </font></td>
			<td  align="center" width="33%" class="bodyText"> <font color="maroon"><B>Emp  </font></td>
			<td  align="center" width="33%" class="bodyText"> <font color="maroon"><B>Total km</font></td>
		     </tr>	
		    </table>	
 		 
            </td>
		<td>
		 <table border="0" width="100%" >
	  	 <tr>
		   <td>  <div align="center" class="bodyText"> <font color="maroon"> <B> As per Gps </B> </font> </div> </td>
 		 </tr>
		<tr>
		    <table border="0" width="100%" >
	  	     <tr>
		       <td  align="center" class="bodyText"> <font color="maroon"><b>Distance(km) </font></td>
			
		     </tr>	
		    </table>	
 		
            </td>
	<td>
		 <table border="0" width="100%" >
	  	 <tr>
		   <td>  <div align="center" class="bodyText"> <font color="maroon"> <B> Variance </B> </font>
		 </div> </td>
 		 </tr>
		<tr>
		    <table border="0" width="100%" >
	  	     <tr>
		       <td  align="center" width="50%" class="bodyText"> <font color="maroon"><B>Gps & Vendor
			</font></td>
		<td  align="center" width="50%" class="bodyText"> <font color="maroon"><B>Gps & EXL </font></td>
		
		     </tr>	
		    </table>	
 		 
            </td>
	<td>
		    <table border="0" width="100%" >
	  	     <tr rowspan="2">
		       
		<td  align="center" rowspan="2" class="bodyText"> <font color="maroon"><B>DND</font></td>
		     </tr>	
		    </table>	
	</td>
	
</tr>
<%
int i=1;
String vehcode="";
//out.print(fromdate);
//out.print(Todate);
sql2="select * from t_vehicledetails where Ownername='EXL Services' order by VehicleRegNumber asc";
rs2=stmt2.executeQuery(sql2);
while(rs2.next())
	  { 
		String veh1="",dist="",fdate="",ftime="",fdate1="",ftime1="";
		long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
		veh1=rs2.getString("VehicleRegNumber");
		vehcode=rs2.getString("VehicleCode");	
		int dist1=0,dist2=0,total=0;
		



		sql3="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >= '"+fromdate+" 07:00:00' and concat(TheFieldDataDate,' ',TheFieldDataTime) <= '"+todate1+" 07:00:00' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1";
		//out.print(sql3);
		rs3=stmt3.executeQuery(sql3);
		if(rs3.next())
		{
			dist1=rs3.getInt("Distance");
			fdate=rs3.getString("TheFieldDataDate");
			ftime=rs3.getString("TheFieldDataTime");
	java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fdate+" "+ftime);
	 miliseconds1=fd.getTime();
	//out.print("fd="+fd);
		} 
		//out.print(dist1);
				
		String sql4="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+todate1+" 07:00:00' and concat(TheFieldDataDate,' ',TheFieldDataTime) >= '"+fromdate+" 07:00:00' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		//out.print(sql4);
		rs4=stmt4.executeQuery(sql4);
		if(rs4.next())
		{
			dist2=rs4.getInt("Distance");
			fdate1=rs4.getString("TheFieldDataDate");
			ftime1=rs4.getString("TheFieldDataTime");
		java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fdate1+" "+ftime1);
	 miliseconds2=fd1.getTime();
//out.print("fd1="+fd1);
		}
		millisecdiff=miliseconds2-miliseconds1;
		secdiff=millisecdiff/1000;
		mindiff=secdiff/60;
		hrdiff=mindiff/60;
		//out.print("hrdiff= "+hrdiff);
		total=dist2-dist1;
		//out.print("distance2= "+dist2);
		
int vendopkm=0, vendclokm=0, vendtot=0, exlkms=0, exltot=0, vendopkm1=0, vendclokm1=0, vendtot1=0, exlkms1=0, exltot1=0, exltotal2=0, exlkmstotal=0, gpsvenddiff=0,gpsexldiff=0, dndexl1=0, dndexl2=0, dndexltotal=0;
int exlnoofemp=0,exlnoofemptot=0,exlnoofemp1=0; 
int vendtotal=0, exlapptot=0, exlnoemp=0, exlapptotal=0, exlappdnd=0;
	 
sql1="select * from t_kmdetails where CabRegNo='"+veh1+"' and ondate='"+fromdate+"' ";
//out.print(sql1);
rs1=stmt1.executeQuery(sql1);
while(rs1.next())
		{
			vendopkm=rs1.getInt("openingkm");
			vendclokm=rs1.getInt("Closingkm");
			vendtot=rs1.getInt("Total1");
			exlkms=rs1.getInt("Approvedkms");
			exlnoofemp=rs1.getInt("No_Emp");
			exltot=rs1.getInt("ApprovedTotal");
			dndexl1=rs1.getInt("dnd");
			
		}

	String sql5="select * from t_kmdetails where CabRegNo='"+veh1+"' and ondate ='"+todate+"' ";
ResultSet rs5=stmt1.executeQuery(sql5);
while(rs5.next())
		{
			vendopkm1=rs5.getInt("openingkm");
			vendclokm1=rs5.getInt("Closingkm");
			vendtot1=rs5.getInt("Total1");
			exlkms1=exlkms1+rs5.getInt("Approvedkms");
			exlnoofemp1=exlnoofemp1+rs5.getInt("No_Emp");
			exltot1=rs5.getInt("ApprovedTotal");
			dndexl2=rs5.getInt("dnd");
		} 

		String sql6="select sum(Total1) from t_kmdetails where CabRegNo='"+veh1+"' and ondate >='"+fromdate+"' and ondate <='"+todate+"' ";
		//out.print(sql6);
		ResultSet rs6=stmt1.executeQuery(sql6);
		if(rs6.next())
		{
			vendtotal=rs6.getInt(1);
			
		}

		String sql7="select sum(Approvedkms), sum(No_Emp), sum(ApprovedTotal), sum(dnd) from t_kmdetails where CabRegNo='"+veh1+"' and ondate >='"+fromdate+"' and ondate <='"+todate+"'";
		ResultSet rs7=stmt1.executeQuery(sql7);
		if(rs7.next())
		{
			exlapptot=rs7.getInt(1);
			exlnoemp=rs7.getInt(2);
			exlapptotal=rs7.getInt(3);
			exlappdnd=rs7.getInt(4);
		}
		
		
		gpsvenddiff=total-vendtotal;
		gpsexldiff=total-exlapptotal;
		
 %>
<tr <% if(hrdiff>=23 ){%>bgcolor="#CCFFCC"  <% }else { %>bgcolor="#FFFFCC"  <% }%>>



			
			<td  align="center"> <B> <%=i%> </B></td>
			<td  align="center" class="bodyText"> <B> <%=veh1%> </B></td>
			   <td> 
 				<table border="0" width="100%">
	            		  <tr>
				    <td  align="center" width="33%" class="bodyText">
					 <%=vendopkm%> </td> 
	            		    <td  align="center" width="33%" class="bodyText"> <%=vendclokm1%></td>
				    <td  align="center" width="33%" class="bodyText"> <%=vendtotal%></td>
				  </tr>
				</table>
			   </td>	
			   <td> 
 				<table border="0" width="100%">
	            		  <tr>
					<td align="center" width="33%" class="bodyText"> <%=exlapptot%> </td> 
	            		   	<td  align="center" width="33%" class="bodyText"> <%=exlnoemp%></td>
				   	<td  align="center" width="33%" class="bodyText"> <%=exlapptotal%></td>	
				  </tr>
				</table>
			   	
			  </td>
			  <td> 
 				<table border="0" width="100%">
	            		  <tr>
					<td  align="center" class="bodyText"> <%=total%> </td> 
	            		   	 
				  </tr>
				</table>
			   	
			  </td>	
			<td> 
 				<table border="0" width="100%">
	            		  <tr>
					<td align="center" width="50%" class="bodyText"> <%=gpsvenddiff%> </td> 
	            		   	<td  align="center" width="50%" class="bodyText"><%=gpsexldiff%> </td>
				   		
				  </tr>
				</table>
			   	
			  </td>
				
			<td> 
 				<table border="0" width="100%">
	            		  <tr>
					
				   	<td  align="center" width="" class="bodyText"> <%=exlappdnd%></td>	
				  </tr>
				</table>
			   	
			  </td>	
			</tr>
<%		
	i++;	
}

%>	
	

	</table>			
	
</td></tr>
<%
}
}
 catch(Exception e)
 {
	out.println("Exception----->" +e);
 }
finally
{
	con1.close();
}
%>

<tr><td>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</form>
</body>
</td></tr>
</table>

</html>
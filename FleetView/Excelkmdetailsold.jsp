<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"KmDetails.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%@ include file="headercallcenter.jsp" %>
<%!
Connection con1, con2, con3;
%>
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
<%
String fromdate1=request.getParameter("fromdate1");

String fromdate=request.getParameter("fromdate");

if(fromdate==""||fromdate==null)	
	{
	}
	else
	{ 
java.util.Date d1= new SimpleDateFormat("yyyy-MM-dd").parse(fromdate);
long miliseconds=d1.getTime();
miliseconds=miliseconds+ 1000 * 60 * 60 *24;
d1.setTime(miliseconds);	
  fromdate1= new SimpleDateFormat("yyyy-MM-dd").format(d1);			
//out.print("next"+ fromdate1);
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
	<table border="0" width="100%" >
	<tr bgcolor="#F0E68C" width="100%">
	<td class="sorttable_nosort" class="bodyText" colspan="4">Color Code Indications :</b></td >
	<td bgcolor="#CCFFCC" class="sorttable_nosort" colspan="4"><b>Got full 24 hour Data</b></td>
	<td bgcolor="#FFFFCC" class="sorttable_nosort" colspan="4"><b>Got Less Than 24 hours data</b></td>
	</tr>
	</table>	
	<table border="0" width="100%" >
	  <tr>
		<td  colspan="8" align="center"> <font color="blue" size="3">
			<B> Km Details for 
<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> </B> </font> 	</td>
		
		<td align="center">
		Date : <%
		Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
		String curdate = fmt.format(new java.util.Date());
		out.print(curdate); %>
	</td>
	  </tr>
	</table>
</td></tr>
<tr><td>	
	<table border="0" width="100%" class="bodyText" bgcolor="white">
	  <tr bgcolor="#DCDCDC">
		<td class="bodyText">  <div align="center"> <font color="maroon" >
			 <B> Sr No </B> </font> 
		</td>
		<td class="bodyText">  <div align="center"> <font color="maroon">
			 <B> Vehicles</B> </font>
		</td>
	     	<td>
		 	<table border="0" width="100%" >
	  	 	<tr>
		 	<td align="center" class="bodyText"> <font color="maroon">
				 <B> As per Vendor </B> </font> </div>
			</td>
 		 	</tr>
			<tr><td>
				<table border="0" width="100%">
	  			<tr>
				<td width="33%" class="bodyText"> <font color="maroon">
					<div align="center"><B>Opening Km </div> </font>
				</td>
				<td width="33%" class="bodyText"> <font color="maroon"> 
					<div align="center"><B>Closing Km</div></font>
				</td>
				<td width="33%" class="bodyText"> <font color="maroon">
					<div align="center"><B>Total km</div></font>
				</td>
		     		</tr>	
		    		</table>	
 		        </td></tr>
			</table>
		</td>
		<td>
		 	<table border="0" width="100%" >
	  	 	<tr>
		   		<td class="bodyText" align="center"> <font color="maroon"> 					<B> As per EXL </B> </font>
				
				</td>
 			</tr>
			<tr><td>
			    	<table border="0" width="100%" >
	  	     		<tr>
		       		<td  align="center" width="33%" > <font color="maroon">
					<B>Kms  </font>
				</td>
				<td  align="center" width="33%" class="bodyText">
					<font color="maroon"><B>Emp  </font>
				</td>
				<td  align="center" width="33%" class="bodyText"> 
					<font color="maroon"><B>Total km</font>
				</td>
		     		</tr>	
		    		</table>
			</td></tr>
			</table>	
 		 </td>
		 <td>
		 	<table border="0" width="100%" >
	  	 	<tr>
				<td>  <div align="center" class="bodyText"> <font color="maroon"> 						<B> As per Gps </B> </font> </div> 
				</td>
 		 	</tr>
			<tr><td>
		    		<table border="0" width="100%" >
	  	     		<tr>
		       		<td  align="center" class="bodyText"> 
					<font color="maroon"><b>Distance(km) </font>
				</td>
				</tr>	
		    		</table>	
 		       </td></tr>
			</table>
		</td>
		<td>
		 	<table border="0" width="100%" >
	  	 	<tr>
		   		<td align="center" class="bodyText"> <font color="maroon"> 					<B> Variance </B> </font></div>
				</td>
 		 	</tr>
			<tr><td>
		    		<table border="0" width="100%" >
	  	     		<tr>
					<td  align="center" width="50%" class="bodyText">
						<font color="maroon"><B>Gps & Vender</font>
					</td>
					<td  align="center" width="50%" class="bodyText">
						<font color="maroon"><B>Gps & EXL </font>
					</td>
				</tr>		
		    		</table>	
 		        </td></tr>
			</table>
		</td>
		<td>
		   	<table border="0" width="100%" >
	  	   	<tr rowspan="2">      
				<td  align="center" rowspan="2" class="bodyText">
					<font color="maroon"><B>DND</font>
				</td>
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
		



		sql3="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >= concat('"+fromdate+" 07:00:00') and concat(TheFieldDataDate,' ',TheFieldDataTime) <= concat('"+fromdate1+" 07:00:00') and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1";
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
				
		String sql4="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <=concat('"+fromdate1+" 07:00:00') and concat(TheFieldDataDate,' ',TheFieldDataTime) >= concat('"+fromdate+" 07:00:00') and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
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

	/*String sql5="select * from t_kmdetails where CabRegNo='"+veh1+"' and ondate ='"+fromdate+"' ";
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
		
		exltotal2=exltot+exltot1;
		exlkmstotal=exlkms+exlkms1;
		exlnoofemptot=exlnoofemp+exlnoofemp1;
*/
		gpsvenddiff=total-vendtot;
		gpsexldiff=total-exltot;
		//dndexltotal=dndexl1+dndexl2;
 %>
	<tr <% if(hrdiff>=23 ){%>bgcolor="#CCFFCC"  <% }else { %>bgcolor="#FFFFCC"  <% }%>>
		<td  align="center"> <B> <%=i%> </B></td>
		<td  align="center" class="bodyText"> <B> <%=veh1%> </B></td>
		<td > <table border="0" width="100%" >
	  	 	<tr>
		 	<td align="center" class="bodyText">
			
 			<table border="0" width="100%">
	        	<tr>
				<td  align="center" width="33%" class="bodyText">
					<%=vendopkm%>
				</td> 
	            		<td  align="center" width="33%" class="bodyText">
					<%=vendclokm%>
				</td>
				<td  align="center" width="33%" class="bodyText"> 
					<%=vendtot%>
				</td>
			</tr>
			</table>
			
			</td></tr>
			</table>
		</td>	
		<td> <table border="0" width="100%" >
	  	 	<tr>
		 	<td align="center" class="bodyText">
 			<table border="0" width="100%">
	        	<tr>
				<td align="center" width="33%" class="bodyText"> 
					<%=exlkms%>
				</td> 
	            		<td  align="center" width="33%" class="bodyText"> 
					<%=exlnoofemp%>
				</td>
				<td  align="center" width="33%" class="bodyText">
					<%=exltot%>
				</td>
			</tr>
			</table>
			
			</td></tr>
			</table>
		</td>	
		<td> <table border="0" width="100%" >
	  	 	<tr>
		 	<td align="center" class="bodyText">
			
 			<table border="0" width="100%">
	        	<tr>
				<td  align="center" class="bodyText"> <%=total%> 
				</td>
			</tr>
			</table>
			
			</td></tr>
			</table>
		</td>	
		<td> <table border="0" width="100%" >
	  	 	<tr>
		 	<td align="center" class="bodyText">
 			<table border="0" width="100%">
	        	<tr>
				<td align="center" width="50%" class="bodyText">
					<%=gpsvenddiff%>
				</td> 
	            		<td  align="center" width="50%" class="bodyText">
					<%=gpsexldiff%>
				</td>
			</tr>
			</table>
			
			</td></tr>
			</table>
		</td>	
		<td> <table border="0" width="100%" >
	  	 	<tr>
		 	<td align="center" class="bodyText">
 			<table border="0" width="100%">
	        	<tr>
			   	<td  align="center" width="" class="bodyText">
					 <%=dndexl1%>
				</td>
			</tr>
			</table>
			
			</td></tr>
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
<tr ><td bgcolor="white" class="copyright" width="100%" colspan="15" align="center">
Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</form>
</body>
</html>

<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn,conn1;
Statement st4,st1,st2,st5,stv;
String fromdate, todate;
NumberFormat nf = DecimalFormat.getNumberInstance();
%>

<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);


if(!(null==request.getQueryString()))
{

try
{
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String thename,fromdate="", todate="",category="";
	thename=request.getParameter("thename");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	
	//String Transporter=session.getAttribute("usertypevalue").toString();
	
		
			if(thename.equals("started"))
			{       %> 
				 
				    	<tr><td><b><font size="2">Daily Driving Hrs Violation Report For :- <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
						    	 
				  
			  	    
				  
				<%  
				  }
			else if(thename.equals("ended"))
			{
				%>
				 
				<tr><td><b><font size="2">Daily Driving Hrs Violation Report For :- <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				
		<%	}	     
			  	 					
			else if(thename.equals("both"))
			{
				
				
				%>
				         <tr><td><b><font size="2">Daily Driving Hrs Violation Report For <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				
				
	<%		  	     
			  	     
					}
		
	
	Class.forName(MM_dbConn_DRIVER); 
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

	st4=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st5=conn.createStatement();
	stv=conn1.createStatement();
if(!(null==thename))
{ 
		//*********************************
	
	if(thename.equalsIgnoreCase("ended"))
	{

		//***************************************started all trips**************************************************
		java.util.Date startdate=new java.util.Date();
		java.util.Date sevenday=new java.util.Date();
	//	java.util.Date lastdate=new java.util.Date();
		String lastdate,nextday;
			%>
				<table border="1" width="100%" class=sortable>
				<tr>
				<td ><b>Sr.</b></td>
				<td ><b>DriverName </b></td>
				<td><b>DriverID</b></td>
				<td><b>Date</b></td>
				<td><b>Transporter</b></td>
				<td><b>Vehicle</b></td>
				<td><b>Km Traveled</b></td>
				<td><b>Duration(Hrs)</b></td>
				<td><b>CastrolTrip</b></td>
				<td><b>Prev day Km Traveled</b></td>
				<td><b>Prev day Duration(Hrs)</b></td>
				<td> <b>Prev day CastrolTrip</b></td>
				<td> <b>Next day Km Traveled</td>
				<td><b>Next day Duration(Hrs)</td>
				<td><b>Next day CastrolTrip </td>
				<td><b>Total Km Traveled</b></td>
				<td><b>Total Duration(Hrs)</b></td>
				<td><b>Castrol Days</b></td>
				</tr>
	<%
			int i1=1;
			double stdkm=0.00, ttime=0.00,ratinge=0.00;
			int nd=0;
			int totkm=0,totdur=0,totcastrol=0;
			int km=0,dur=0,castrol=0;
			int prvkm=0,prvdur=0,prvcastrol=0;
			int nxtkm=0,nxtdur=0,nxtcastrol=0,vehid;
			int c;
			String drivernm="",drivernm1="",vehregno="";
			String sql="",jcode;
			
		       String	sql5= "select JCode,count(*) as countTrip from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'  and RDurationinHrs>='10' and  JCode<>'-' group by JCode ";
	           ResultSet vset=st4.executeQuery(sql5); 
	           while(vset.next())
	             {
	            	   c=vset.getInt("countTrip");       
	        	    
	            	  
	            	  
		            	 if(c>1)
	        	          {
	        	        	
	                       jcode=vset.getString("JCode");
	        	        	 
	            		  
	        	       sql="select * from t_driver_ds  where JCode='"+jcode+"' and TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and RDurationinHrs>='10'";
	        	       ResultSet rst=st5.executeQuery(sql);	          
	        	          
	        	          
	        	     
			           while(rst.next())
				         {
						
			        	   drivernm=rst.getString("DCode");
							
							String sqld="select DriverName from t_drivers where DriverID='"+drivernm+"'";
							
							ResultSet rstd=stv.executeQuery(sqld);
							if(rstd.next())
							{
								drivernm1=rstd.getString("DriverName");
								
							}
							vehid=rst.getInt("VehCode");
							String sqlv="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+vehid+"'";
							//System.out.println("sqlv--->"+sqlv);
							ResultSet rstv=stv.executeQuery(sqlv);
							if(rstv.next())
							{
								vehregno=rstv.getString("VehicleRegNumber");
								
							}  	  
			        	   //km=rst.getInt("Distance");
						%>
						<tr>
						<td><%=i1%></td>
						<td><%=drivernm1%></td>
						<td><%=rst.getString("DCode")%></td>
						<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%></td>
						<td><%=rst.getString("Transporter")%></td>
						<td><%=vehregno%></td>
						<td><%=rst.getString("Distance")%></td>
						<td><%=rst.getString("RDurationinHrs")%></td>
						<td><%=rst.getString("JCode")%></td>
						<%
						startdate=rst.getDate("TheDate");
						long todaymils = startdate.getTime();
						long previousday=60*60*1000*24*1;
						previousday=todaymils-previousday;
						sevenday.setTime(previousday);
						//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						lastdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						long nextday1=60*60*1000*24*1;
						nextday1=todaymils+nextday1;
						sevenday.setTime(nextday1);
						//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						nextday=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						 
						
						/*if(category.equalsIgnoreCase("Tanker"))
						{
							//sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='Tanker' and RDurationinHrs>='10' order by TheDate Asc";
							sql1="select * from t_driver_ds where TheDate = '"+lastdate+"' and DCode = '"+rst.getString("DriverID")+"'";
						}
						else if(category.equalsIgnoreCase("Primary"))
						{
							sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='primary' and RDurationinHrs>='10' order by TheDate Asc";
						}
						else
						{
							sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='secondary' and RDurationinHrs>='10' order by TheDate Asc";
						}*/
						String sql1="select * from t_driver_ds where TheDate = '"+lastdate+"' and DCode = '"+rst.getString("DCode")+"'";
						//System.out.println(sql1);
						ResultSet rst1=st1.executeQuery(sql1);
						if(rst1.next())
						{
							//prvkm=rst1.getInt("Distance");
							%>
							<td><%=rst1.getString("Distance")%></td>
							<td><%=rst1.getString("RDurationinHrs")%></td>
							<td><%=rst1.getString("JCode")%></td>
							<%
						}
						else
						{
							//prvkm=0;
							%>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<%
						}
						String sql11="select * from t_driver_ds where TheDate = '"+nextday+"' and DCode = '"+rst.getString("DCode")+"'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst11=st1.executeQuery(sql11);
						//System.out.println(sql11);
						if(rst11.next())
						{
							//nxtkm=rst11.getInt("Distance");
							%>
							<td><%=rst11.getString("Distance")%></td>
							<td><%=rst11.getString("RDurationinHrs")%></td>
							<td><%=rst11.getString("JCode")%></td>
							<%
						}
						else
						{
							//nxtkm=0;
							%>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<%
						}
						String sql111="select sum(RDurationinHrs) as sumdur,sum(Distance) as Distance from t_driver_ds where DCode='"+rst.getString("DCode")+"' and TheDate between '"+lastdate+"' and  '"+nextday+"'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst111=st1.executeQuery(sql111);
						//System.out.println(sql111);
						if(rst111.next())
						{
							//nxtkm=rst111.getInt("Distance");
							String totdur11=rst111.getString("sumdur");
							//System.out.println("totaldur::>>"+totdur11);
							%>
							<td><%=rst111.getString("Distance")%></td>
							<td><%=rst111.getString("sumdur")%></td>
							<%
						}
						String sql1111="select count(*) as count from t_driver_ds where DCode='"+rst.getString("DCode")+"' and TheDate between '"+lastdate+"' and  '"+nextday+"' and JCode <> '-'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst1111=st1.executeQuery(sql1111);
						//System.out.println(sql1111);
						
						if(rst1111.next())
						{
							//nxtkm=rst111.getInt("Distance");
							%>
							<td><%=rst1111.getString("count")%></td>
							
							<%
						}
						else
						{
							%>
							<td>0</td>
							
							<%	
						}
						//totkm=km+prvkm+nxtkm;
						%>
						
						</tr>
						<%
						i1++;
						
				         }
			          
			          
	        	          }
			        	   
                  }
		  	           
			           
		%>
		</table>
		<%		
		
		
		
		

		
	}

///************************************************STARTED**********************************************************************************************	
	else if(thename.equalsIgnoreCase("started"))
	{
		//***************************************started all trips**************************************************
		java.util.Date startdate=new java.util.Date();
		java.util.Date sevenday=new java.util.Date();
	//	java.util.Date lastdate=new java.util.Date();
		String lastdate,nextday;
			%>
			<table border="1" width="100%" class=sortable>
				<tr>
				<td ><b>Sr.</b></td>
				<td ><b>DriverName </b></td>
				<td><b>DriverID</b></td>
				<td><b>Date</b></td>
				<td><b>Transporter</b></td>
				<td><b>Vehicle</b></td>
				<td><b>Km Traveled</b></td>
				<td><b>Duration(Hrs)</b></td>
				<td><b>CastrolTrip</b></td>
				<td><b>Prev day Km Traveled</b></td>
				<td><b>Prev day Duration(Hrs)</b></td>
				<td> <b>Prev day CastrolTrip</b></td>
				<td> <b>Next day Km Traveled</td>
				<td><b>Next day Duration(Hrs)</td>
				<td><b>Next day CastrolTrip </td>
				<td><b>Total Km Traveled</b></td>
				<td><b>Total Duration(Hrs)</b></td>
				<td><b>Castrol Days</b></td>
				</tr>
	<%
			int i1=1;
			double stdkm=0.00, ttime=0.00,ratinge=0.00;
			int nd=0;
			int totkm=0,totdur=0,totcastrol=0;
			int km=0,dur=0,castrol=0;
			int prvkm=0,prvdur=0,prvcastrol=0;
			int nxtkm=0,nxtdur=0,nxtcastrol=0,vehid;
			int c1;
			String drivernm="",drivernm1="",vehregno="";
			String sql="";
			
		       String	sql3= "select JCode,count(*) as countTrip from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'  and RDurationinHrs>='10' and  JCode<>'-' group by JCode ";
	           ResultSet vset1=st4.executeQuery(sql3); 
	           while(vset1.next())
	             {
	            	   c1=vset1.getInt("countTrip");       
	        	    
	            	  
	            	  
		            	 if(c1>1)
	        	          {
	        	        	
	                      String jcode= vset1.getString("JCode");
	        	        	 
	            		  
	        	       sql="select * from t_driver_ds  where JCode='"+jcode+"' and TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and RDurationinHrs>='10'";
	        	       ResultSet rst=st5.executeQuery(sql);	          
	        	          
	        	          
	        	     
			           while(rst.next())
				         {
			        	   drivernm=rst.getString("DCode");
							
							String sqld="select DriverName from t_drivers where DriverID='"+drivernm+"'";
							
							ResultSet rstd=stv.executeQuery(sqld);
							if(rstd.next())
							{
								drivernm1=rstd.getString("DriverName");
								
							}
							vehid=rst.getInt("VehCode");
							String sqlv="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+vehid+"'";
					//		System.out.println("sqlv--->"+sqlv);
							ResultSet rstv=stv.executeQuery(sqlv);
							if(rstv.next())
							{
								vehregno=rstv.getString("VehicleRegNumber");
								
							}
			        	  
			        	   //km=rst.getInt("Distance");
						%>
						<tr>
						<td><%=i1%></td>
						<td><%=drivernm1%></td>
						<td><%=rst.getString("DCode")%></td>
						<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%></td>
						<td><%=rst.getString("Transporter")%></td>
						<td><%=vehregno%></td>
						<td><%=rst.getString("Distance")%></td>
						<td><%=rst.getString("RDurationinHrs")%></td>
						<td><%=rst.getString("JCode")%></td>
						<%
						startdate=rst.getDate("TheDate");
						long todaymils = startdate.getTime();
						long previousday=60*60*1000*24*1;
						previousday=todaymils-previousday;
						sevenday.setTime(previousday);
						//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						lastdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						long nextday1=60*60*1000*24*1;
						nextday1=todaymils+nextday1;
						sevenday.setTime(nextday1);
						//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						nextday=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						 
						
						/*if(category.equalsIgnoreCase("Tanker"))
						{
							//sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='Tanker' and RDurationinHrs>='10' order by TheDate Asc";
							sql1="select * from t_driver_ds where TheDate = '"+lastdate+"' and DCode = '"+rst.getString("DriverID")+"'";
						}
						else if(category.equalsIgnoreCase("Primary"))
						{
							sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='primary' and RDurationinHrs>='10' order by TheDate Asc";
						}
						else
						{
							sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='secondary' and RDurationinHrs>='10' order by TheDate Asc";
						}*/
						String sql1="select * from t_driver_ds where TheDate = '"+lastdate+"' and DCode = '"+rst.getString("DCode")+"'";
						//System.out.println(sql1);
						ResultSet rst1=st1.executeQuery(sql1);
						if(rst1.next())
						{
							//prvkm=rst1.getInt("Distance");
							%>
							<td><%=rst1.getString("Distance")%></td>
							<td><%=rst1.getString("RDurationinHrs")%></td>
							<td><%=rst1.getString("JCode")%></td>
							<%
						}
						else
						{
							//prvkm=0;
							%>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<%
						}
						String sql11="select * from t_driver_ds where TheDate = '"+nextday+"' and DCode = '"+rst.getString("DCode")+"'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst11=st1.executeQuery(sql11);
						//System.out.println(sql11);
						if(rst11.next())
						{
							//nxtkm=rst11.getInt("Distance");
							%>
							<td><%=rst11.getString("Distance")%></td>
							<td><%=rst11.getString("RDurationinHrs")%></td>
							<td><%=rst11.getString("JCode")%></td>
							<%
						}
						else
						{
							//nxtkm=0;
							%>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<%
						}
						String sql111="select sum(RDurationinHrs) as sumdur,sum(Distance) as Distance from t_driver_ds where DCode='"+rst.getString("DCode")+"' and TheDate between '"+lastdate+"' and  '"+nextday+"'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst111=st1.executeQuery(sql111);
						//System.out.println(sql111);
						if(rst111.next())
						{
							//nxtkm=rst111.getInt("Distance");
							String totdur11=rst111.getString("sumdur");
							//System.out.println("totaldur::>>"+totdur11);
							%>
							<td><%=rst111.getString("Distance")%></td>
							<td><%=rst111.getString("sumdur")%></td>
							<%
						}
						String sql1111="select count(*) as count from t_driver_ds where DCode='"+rst.getString("DCode")+"' and TheDate between '"+lastdate+"' and  '"+nextday+"' and JCode <> '-'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst1111=st1.executeQuery(sql1111);
						//System.out.println(sql1111);
						
						if(rst1111.next())
						{
							//nxtkm=rst111.getInt("Distance");
							%>
							<td><%=rst1111.getString("count")%></td>
							
							<%
						}
						else
						{
							%>
							<td>0</td>
							
							<%	
						}
						//totkm=km+prvkm+nxtkm;
						%>
						
						</tr>
						<%
						i1++;
						
				         }
			          
			          
	        	          }
			        	   
                  }
		  	           
			           
		%>
		</table>
		<%

			
	}
		
	
	//}//end of else if started
	else if(thename.equalsIgnoreCase("both"))
	{

		//***************************************started all trips**************************************************
		java.util.Date startdate=new java.util.Date();
		java.util.Date sevenday=new java.util.Date();
	//	java.util.Date lastdate=new java.util.Date();
		String lastdate,nextday;
			%>
				<table border="1" width="100%" class=sortable>
				<tr>
				<td ><b>Sr.</b></td>
				<td ><b>DriverName </b></td>
				<td><b>DriverID</b></td>
				<td><b>Date</b></td>
				<td><b>Transporter</b></td>
				<td><b>Vehicle</b></td>
				<td><b>Km Traveled</b></td>
				<td><b>Duration(Hrs)</b></td>
				<td><b>CastrolTrip</b></td>
				<td><b>Prev day Km Traveled</b></td>
				<td><b>Prev day Duration(Hrs)</b></td>
				<td> <b>Prev day CastrolTrip</b></td>
				<td> <b>Next day Km Traveled</td>
				<td><b>Next day Duration(Hrs)</td>
				<td><b>Next day CastrolTrip </td>
				<td><b>Total Km Traveled</b></td>
				<td><b>Total Duration(Hrs)</b></td>
				<td><b>Castrol Days</b></td>
				</tr>
	<%
			int i1=1;
			double stdkm=0.00, ttime=0.00,ratinge=0.00;
			int nd=0;
			int totkm=0,totdur=0,totcastrol=0;
			int km=0,dur=0,castrol=0;
			int prvkm=0,prvdur=0,prvcastrol=0;
			int nxtkm=0,nxtdur=0,nxtcastrol=0,vehid;
			int count=0,c=0,c2;
			String drivernm="",drivernm1="",vehregno="";
			String sql="";
			
		       String	sql4= "select JCode,count(*) as countTrip from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'  and RDurationinHrs>='10' and  JCode<>'-' group by JCode ";
	           ResultSet vset2=st4.executeQuery(sql4); 
	           while(vset2.next())
	             {
	            	   c2=vset2.getInt("countTrip");       
	        	    
	            	  
	            	  
		            	 if(c2>1)
	        	          {
	        	        	
	                      String jcode=vset2.getString("JCode");
	        	        	 
	            		  
	        	       sql="select * from t_driver_ds  where JCode='"+jcode+"' and TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and RDurationinHrs>='10'";
	        	       ResultSet rst=st5.executeQuery(sql);	          
	        	          
	        	          
	        	     
			           while(rst.next())
				         {
			        	   drivernm=rst.getString("DCode");
							
							String sqld="select DriverName from t_drivers where DriverID='"+drivernm+"'";
							
							ResultSet rstd=stv.executeQuery(sqld);
							if(rstd.next())
							{
								drivernm1=rstd.getString("DriverName");
								
							}
							vehid=rst.getInt("VehCode");
							String sqlv="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+vehid+"'";
						//	System.out.println("sqlv--->"+sqlv);
							ResultSet rstv=stv.executeQuery(sqlv);
							if(rstv.next())
							{
								vehregno=rstv.getString("VehicleRegNumber");
								
							}
			        	  
			        	   //km=rst.getInt("Distance");
						%>
						<tr>
						<td><%=i1%></td>
						<td><%=drivernm1%></td>
						<td><%=rst.getString("DCode")%></td>
						<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%></td>
						<td><%=rst.getString("Transporter")%></td>
						<td><%=vehregno%></td>
						<td><%=rst.getString("Distance")%></td>
						<td><%=rst.getString("RDurationinHrs")%></td>
						<td><%=rst.getString("JCode")%></td>
						<%
						startdate=rst.getDate("TheDate");
						long todaymils = startdate.getTime();
						long previousday=60*60*1000*24*1;
						previousday=todaymils-previousday;
						sevenday.setTime(previousday);
						//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						lastdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						long nextday1=60*60*1000*24*1;
						nextday1=todaymils+nextday1;
						sevenday.setTime(nextday1);
						//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						nextday=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						 
						
						/*if(category.equalsIgnoreCase("Tanker"))
						{
							//sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='Tanker' and RDurationinHrs>='10' order by TheDate Asc";
							sql1="select * from t_driver_ds where TheDate = '"+lastdate+"' and DCode = '"+rst.getString("DriverID")+"'";
						}
						else if(category.equalsIgnoreCase("Primary"))
						{
							sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='primary' and RDurationinHrs>='10' order by TheDate Asc";
						}
						else
						{
							sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol' and Category='secondary' and RDurationinHrs>='10' order by TheDate Asc";
						}*/
						String sql1="select * from t_driver_ds where TheDate = '"+lastdate+"' and DCode = '"+rst.getString("DCode")+"'";
						//System.out.println(sql1);
						ResultSet rst1=st1.executeQuery(sql1);
						if(rst1.next())
						{
							//prvkm=rst1.getInt("Distance");
							%>
							<td><%=rst1.getString("Distance")%></td>
							<td><%=rst1.getString("RDurationinHrs")%></td>
							<td><%=rst1.getString("JCode")%></td>
							<%
						}
						else
						{
							//prvkm=0;
							%>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<%
						}
						String sql11="select * from t_driver_ds where TheDate = '"+nextday+"' and DCode = '"+rst.getString("DCode")+"'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst11=st1.executeQuery(sql11);
						//System.out.println(sql11);
						if(rst11.next())
						{
							//nxtkm=rst11.getInt("Distance");
							%>
							<td><%=rst11.getString("Distance")%></td>
							<td><%=rst11.getString("RDurationinHrs")%></td>
							<td><%=rst11.getString("JCode")%></td>
							<%
						}
						else
						{
							//nxtkm=0;
							%>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<td><%="NA"%></td>
							<%
						}
						String sql111="select sum(RDurationinHrs) as sumdur,sum(Distance) as Distance from t_driver_ds where DCode='"+rst.getString("DCode")+"' and TheDate between '"+lastdate+"' and  '"+nextday+"'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst111=st1.executeQuery(sql111);
						//System.out.println(sql111);
						if(rst111.next())
						{
							//nxtkm=rst111.getInt("Distance");
							String totdur11=rst111.getString("sumdur");
							//System.out.println("totaldur::>>"+totdur11);
							%>
							<td><%=rst111.getString("Distance")%></td>
							<td><%=rst111.getString("sumdur")%></td>
							<%
						}
						String sql1111="select count(*) as count from t_driver_ds where DCode='"+rst.getString("DCode")+"' and TheDate between '"+lastdate+"' and  '"+nextday+"' and JCode <> '-'";
						//"select * from t_CastrolDrivers6 where TheDate > '"+rst.getString("TheDate")+"' order by Thedte Asc limit 1";
						ResultSet rst1111=st1.executeQuery(sql1111);
						//System.out.println(sql1111);
						
						if(rst1111.next())
						{
							//nxtkm=rst111.getInt("Distance");
							%>
							<td><%=rst1111.getString("count")%></td>
							
							<%
						}
						else
						{
							%>
							<td>0</td>
							
							<%	
						}
						//totkm=km+prvkm+nxtkm;
						%>
						
						</tr>
						<%
						i1++;
				         }
			          
			          
	        	          }
			        	   
                  }
		  	           
			           
		%>
		</table>
		<%
		
		
		
	}

//*********************************************************************************************

} //the name

}//try

	catch(Exception e)
	{
		e.printStackTrace();
	//	System.out.println("In side exception");	
	}
	finally
	{
		conn.close();
		//conn1.close();
	}
	}
	%>
	</table>
	</body>
	</html>
<%@ include file="footernew.jsp" %>

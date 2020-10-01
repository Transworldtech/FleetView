 <%@ include file="headerprintnew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<!-- herer end here-->
<table border="0" width="100%" align="center" bgcolor="white">
<td><div align="left"><font size="3">Report No:8.0</font></div></td>
<tr><td><div align="center"><font  size="3"><B>Vehicle Waiting Report.</B></font></div>
<%=fleetview.PrintDate() %>
</td></tr>
<tr><td>
<%!
Connection conn;
Statement st,st1,st2,st3;
String sql,sql1,vehlist,thedate;
String dist,dist1;
%>
<%
try
{		
	    String waithrs= request.getParameter("waithrs");
		//out.println("in code");
		java.util.Date today=new java.util.Date();
		//long milisecond=today.getTime();
		//milisecond=milisecond-1000*60*60*24;
		//today.setTime(milisecond);
		thedate=new SimpleDateFormat("yyyy-MM-dd").format(today);
		//out.print(thedate);
		vehlist=session.getAttribute("VehList").toString();
		//out.print(vehlist);
		conn = fleetview.ReturnConnection();
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		st3=conn.createStatement();
		%>
		<table  width="100%" border="1" class="sortable" >
		<tr>
		<th>Sr.</th>
		<th>Vehicle.</th>
		<th>Transporter</th>
		<th>Updated</th>
		<th>FromDate</th>
		<th>Todate</th>
		<th>Waiting (HH:mm)</th>
		<th>Location</th>
		</tr>		
		<%
		sql="select VehicleCode,VehicleRegNo,LatitudePosition,LongitudePosition,Location,TheDate,TheTime,TheDistance,Transporter from t_onlinedata where VehicleCode in "+vehlist+" and TheDate ='"+thedate+"' and TheSpeed=0 order by TheDate desc,TheTime desc";
		System.out.println("sql--->"+sql);
		ResultSet rst=st.executeQuery(sql);
		String loc="";
		String date3="",time3=""	;
		int i=1,x=1;
		java.util.Date date33=null;
		while(rst.next())
		{
			String transporter=rst.getString("Transporter");
			String vehregno=rst.getString("VehicleRegNo");
			String latpos=rst.getString("LatitudePosition");
			String longpos=rst.getString("LongitudePosition");
			loc=rst.getString("Location");
			date33=rst.getDate("TheDate"); 
			date3=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"));
			time3=rst.getString("TheTime");
			String DateTime=date33+" "+time3;
			System.out.println("DateTime======>"+DateTime);
			
			String vehcode=rst.getString("VehicleCode");
			java.util.Date date1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime);


				String waitdate="",fielddate="",fielddatetime="",todate="";
				sql="Select thefielddatadate,thefielddatatime,TheFieldSubject,Thefielddatadatetime,Distance,((ACOS(SIN(" +rst.getDouble("LatitudePosition")+ " * PI() / 180) * SIN(latindec * PI() / 180) + COS(" +rst.getDouble("LatitudePosition")+ " * PI() / 180) * COS(latindec * PI() / 180) * COS((" +rst.getDouble("LongitudePosition")+ " - longindec) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance1  from t_veh" + vehcode+ "  where TheFieldDataDateTime<='"+date33+ " "+time3+"'  and  TheFiledTextFileName in ('SI','OF','ON')  and ((ACOS(SIN("+rst.getDouble("LatitudePosition")+" * PI() / 180) * SIN(latindec * PI() / 180) + COS("+rst.getDouble("LatitudePosition")+ " * PI() / 180) * COS(latindec * PI() / 180) * COS(("+rst.getDouble("LongitudePosition")+" - longindec) * PI() / 180)) * 180 / PI()) * 60 * 1.1515)>0.5 order by thefielddatadate desc,thefielddatatime desc limit 1 ";
				
               
				ResultSet rst1=st1.executeQuery(sql);
				System.out.println("sql======>"+sql);
				if(rst1.next())
				{
					dist=rst1.getString("Distance");
					System.out.print("dist===>"+dist);
					System.out.println("Date TIme  New "+rst1.getString("TheFieldDataDateTime"));
					
					fielddate=rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime");
					
					//waitdate=rst1.getString("TheFieldDataDateTime");
					System.out.println("Updates date >>>>>>>>>>>>>>>"+date1);

					//sql="select Distance, TheFieldDataDateTime as date2,TheFieldDataDate,TheFieldDataTime from t_veh"+vehcode+" where TheFieldDataDateTime<='"+date33+ " "+time3+"' and TheFiledTextFileName='SI' and Distance="+dist+"  and  TheFieldDataDate>= DATE_SUB(CURDATE(),INTERVAL 30 DAY) order by TheFieldDataDate Asc,TheFieldDataTime Asc limit 1";
					//sql="select Distance, TheFieldDataDateTime,TheFieldDataDate,TheFieldDataTime from t_veh"+vehcode+" where TheFieldDataDateTime<='"+waitdate+"' and TheFiledTextFileName in('SI','ON','OF') and ("+dist+"> Distance)  order by TheFieldDataDate desc,TheFieldDataTime desc limit 1";
					sql="select Distance, TheFieldDataDateTime ,TheFieldDataDate,TheFieldDataTime,latindec,longindec from t_veh"+vehcode+" where TheFieldDataDateTime>'"+fielddate+"' and TheFiledTextFileName in('SI','ON','OF') order by TheFieldDataDate asc,TheFieldDataTime asc limit 1";
					System.out.println("sql1=====>"+sql);
					ResultSet rst2=st2.executeQuery(sql);
				//out.print("SQL2::"+sql);
			if(rst2.next())
			{
				fielddatetime=rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime");
				
				System.out.println("Date1:::"+fielddatetime);				
				
				java.util.Date date2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fielddatetime);
				
				System.out.println("Date2:::"+date2);
				
				 todate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(date2);
				
				//System.out.println("todate:::"+todate);			
				
				long mils=date1.getTime()-date2.getTime();
				System.out.println("Time after sub:::"+mils+"<br>");
				mils=mils/(1000*60);	
				
				
				//System.out.println("Time:::"+mils+"<br>");
			
		// ****************************Modfications Done************************ -->
		//****************************Each of the fields printed on the page are first taken in variables********************
		int hr=240;
		//String waithrs= "4hrs";
			
		
		{
			System.out.println("waithrs--->"+waithrs);
			if(waithrs.equalsIgnoreCase("2hrs"))
				hr=120;
			else if(waithrs.equalsIgnoreCase("4hrs"))
				hr=240;
			else if(waithrs.equalsIgnoreCase("8hrs"))
				hr=480;
			else if(waithrs.equalsIgnoreCase("12hrs"))
				hr=720;
			else if(waithrs.equalsIgnoreCase("16hrs"))
				hr=960;
			else if(waithrs.equalsIgnoreCase("18hrs"))
				hr=1200;
			else if(waithrs.equalsIgnoreCase("22hrs"))
				hr=1440;
			else if(waithrs.equalsIgnoreCase("24hrs"))
				hr=1680;
		}
		if(mils>hr)
			 {
				 %>
				 <tr>
					<td style="text-align: right"><%=x%></td>
					<%
				
					long mils1=mils/60;
					long mils2=mils%60;
					%>
					
					<td><div align="left"><%=vehregno%></div></td>
					<td><div align="left"><%=transporter%></div></td>
					<td style="text-align: left"><%=date3%> <%=time3%></td>
					<td style="text-align: left"><%=todate%></td>
					<td style="text-align: left"><%=date3%> <%=time3%></td>
					<td><div align="right">
					<%
					
					out.print(mils1+":"+mils2);
					
					%>
					</div>
					</td>
					<td class="bodyText"> <div align="left">
					<%=fleetview.showNewMap(latpos,longpos,loc) %>
						</div>
					</td>		
					</tr>	
					<!-- ***************End of the Modifications done********************************* -->
					<%	
				
				x++;
				//milsort=milsort+mils+',';
			 }	
			}
		}		
		
		
		
		i++;
		}
				%>
			</table>	
		<%

}
catch(Exception e)
{
	out.print("Exception --->"+e);
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e){}
	
	try
	{
	fleetview.closeConnection1();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection();
	}
	catch(Exception e){}
}

%>

</td></tr>
</form>
</body>
</table>
<%  %>
	<%  %>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>
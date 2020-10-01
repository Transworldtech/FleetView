<%@ include file="headerprintnew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>

<table border="1" width="100%" bgcolor="white">
<tr>
<td>
<!-- code start here -->
		<%!
		Connection connnew;
		Statement st1;
		%>
		<%
		String fromdate="",todate="";
		int ftime1=0;
		int ftime2=0;
		int ttime1=0;
		int ttime2=0;
		String sdate,edate;
		String user,sql="";
		String data1=null, data2=null,showdate1=null,showdate=null,DriverName=null,Owner,drivercode,transporter,Vcode;
		int OScount=0, RAcount=0, RDcount=0,Distance=0,vid=0,j=1,distance;
		double Rating=0.00;
		int cntos=0, cntra=0, cntrd=0, cntcr=0, cntnd=0, cntst=0,cntdt=0;
		//String vehno,sdate,edate;
		java.util.Date dt1=null;
		java.util.Date dt2=null;
		
		
		NumberFormat nf = DecimalFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2); 
		
		try
		{
		Class.forName(MM_dbConn_DRIVER); 
		connnew = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		
			st1=connnew.createStatement();
		
			data1=request.getParameter("data1");
			data2=request.getParameter("data2");
			drivercode=request.getParameter("DriverID");
			DriverName=request.getParameter("DriverName");
			transporter=request.getParameter("transporter");
			System.out.println("transporter=="+transporter);		
%>
			<table class="stats">
			<tr>
			<th colspan="13" >
			<font size="2">
			Rating Report for Transporter
			<%=transporter%> from date 
			<% java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");showdate = formatter2.format(ShowDate);out.print(showdate);%> to 
			<%java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(data2);Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");showdate1 = formatter1.format(ShowDate1);out.print(showdate1);%>.
			<br>
			
			 </font>
			 </th>
			 </tr>
			<tr>
			<td class="hed">Sr no.</td>
			<td class="hed">VehicleID</td>
			<td class="hed">Vehicle Reg.No.</td>
			<td class="hed">StartDate</td>
			<td class="hed">StartPlace</td>
			<td class="hed">EndDate</td>
			<td class="hed">EndPlace</td>
			<td class="hed">OS Duration<br>(in Sec)</td>
			<td class="hed">RA Count</td>
			<td class="hed">RD Count</td>
			<td class="hed">Distance</td>
			<td class="hed">CD</td>
			<td class="hed">ND</td>
			<td class="hed">Rating</td>
			</tr>
				<%
				int VehCode,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0;
				double rating;
				double rating1;
				int i=0;
			sql="select sum( RACount ) AS RAcount,sum( NDCount) AS NDcount,TripID,CRCount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration, Sum( KmTravelled ) AS KmTravelled,EndPlace,StartPlace,EndDate,StartDate,VehId,VehRegNo from t_completedjourney WHERE StartDate >= '"+data1+"' AND EndDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"')and OwnerName = '"+transporter+"'GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC";
				System.out.println("sql in trip_driver1111--->"+sql);
			ResultSet rst=st1.executeQuery(sql);
			while(rst.next())
			{	
				System.out.println("now in resultset");
				OSduration=rst.getInt("OSDuration");
				dt1 =rst.getDate("StartDate");
				dt2 =rst.getDate("EndDate");
				sdate=rst.getString("StartDate");
				try
				{
				  fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
				}
				catch(Exception e)
				{
				
					try
			    	{
						fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
			    	}
			    	catch(Exception x)
			    	{
			    		fromdate=sdate;
			    	}
				}
			
			try
			{
					 java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
					 ftime1=dt.getHours();
					 ftime2=dt.getMinutes();
			}
			catch(Exception e)
		  	{
		  		ftime1=00;
		  		ftime1=00;
		  	}
		
			 edate=rst.getString("EndDate");
			 try
			 {
			 	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
			 }
			 catch(Exception e)
			 {
					 
				 try
			  		{
			  			
					 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
			  		}
			  		catch(Exception c)
			  		{
			  			todate=edate;
			  		}
				 
			}
			try
			{
			java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
			 ttime1=edt.getHours();
			 ttime2=edt.getMinutes();
			}
			catch(Exception e)
		  	{
		  		ttime1=23;
		  	 	ttime2=59;
		  	}

		%>

	<tr>
			<td class="bodyText"><div align="left"><%=j++ %></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("VehId")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("VehRegNo")%></div></td>
			<td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(dt1)%></div></td>
			<td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%></div></td>
			<td class="bodyText"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(dt2)%></div></td>
			<td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%></div></td>
			<td class="bodyText">
				<div align="right">
			<%
				int ss3=rst.getInt("OSDuration");
				System.out.println("OSduration:::>>"+ss3);
				if(ss3>0)
				{
					cntos=cntos+ss3;
					out.print("<a href='KPI_osduration.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss3+"</a>");
				}
				else
				{
					out.print(""+ss3);
				}
			%>
				</div>
			</td>
			<td class="bodyText">
				<div align="right">
			<%
				int ss2=rst.getInt("RACount");
				if(ss2>0)
				{
					cntra=cntra+ss2;
					out.print("<a href='KPI_rapidacc.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss2+"</a>");
				}
				else
				{
					out.print(""+ss2);
				}
			%>
				</div>
			</td>
			<td class="bodyText">
			<div align="right">
			<%
				int ss1=rst.getInt("RDCount");
				if(ss1>0)
				{
					cntrd=cntrd+ss1;
					out.print("<a href='KPI_rapiddeacc.jsp?tripid="+rst.getString("TripID")+"&sdate="+sdate+"&edate="+edate+"&vid="+rst.getString("Vehid")+"'>"+ss1+"</a>");
				}
				else
				{
					out.print(""+ss1);
				}
			%>
			</div>
			</td>
			<td class="bodyText">
			<div align="right">
			<%
			//distance=rst.getInt("Distance");
				int ss4=rst.getInt("KmTravelled");
				if(ss4>0)
				{
					cntdt=cntdt+ss4;
					out.print(rst.getInt("KmTravelled"));
				}
				else
				{
					out.print(""+ss4);
				}
			%>
			</div>
			</td>
			<td class="bodyText">
			<div align="right">
			<%
				String ss6=rst.getString("CRCount");
				if(ss6.equals("Yes"))
				{
					cntcr=cntcr+1;
					out.print(""+ss6);
				}
				else
				{
					out.print(""+ss6);
				}
			%> 
			</div>
			</td>
			<td class="bodyText">
			<div align="right">
			<%
			String ss5=rst.getString("NDCount");
			if(ss5.equals("Yes"))
			{	
				cntnd=cntnd+1;
				out.print(""+ss5);
			}
			else
			{
				out.print(""+ss5);
			}
			%> 
			</div>
			</td>
			
			<td class="bodyText">
			<div align="right">
			<%
					rating=((Double.valueOf(rst.getString("RACount")))/(Double.valueOf(rst.getString("KmTravelled")))*100)+((Double.valueOf(rst.getString("RDCount")))/(Double.valueOf(rst.getString("KmTravelled")))*100)+((Double.valueOf(OSduration))/10/(Double.valueOf(rst.getString("KmTravelled")))*100);
					if(rst.getInt("KmTravelled")==0)
						{
							out.print("NA");
						}
						else
						{
							out.print(nf.format(rating));
						}

			%>
</div>
</td>
</tr>
<%
i++;
}
%>
			<tr>
			<td class="bodyText"><div align="right"><b></b></div></td>
			<td class="bodyText" colspan="6"><div align="right"><b>Total</b></div></td>
			<td class="bodyText"><div align="right"><b><%=cntos%></b></div></td>
			<td class="bodyText"><div align="right"><b><%=cntra%></b></div></td>
			<td class="bodyText"><div align="right"><b><%=cntrd%></b></div></td>
			<td class="bodyText"><div align="right"><b><%=cntdt%></b></div></td>
			<td class="bodyText"><div align="right"><b>
			<%
				if(cntcr>0)
				{
					out.print("Yes");
				}
				else
				{
					out.print("No");
				}
			%>
				</b>
				</div>
			</td>
			<td class="bodyText"><div align="right"><b>
			<%
				if(cntnd>0)
				{
					out.print("Yes");
				}
				else
				{
					out.print("No");
				}
			%>
				
				</b></div></td>
			<td class="bodyText">
			<div align="right">
			<b>
			<%
			double a,b,c;
			a=(Double.valueOf(cntra))/(Double.valueOf(cntdt))*100;
			b=(Double.valueOf(cntrd))/(Double.valueOf(cntdt))*100;
			c=(Double.valueOf(cntos))/10/(Double.valueOf(cntdt))*100;
			
			rating1=a+b+c;
			out.print(nf.format(rating1));
			
			%>
			
			</b>
			</div>
			</td>
</tr>
</table>
<%
}
catch(Exception e)
{
	out.print("Exception -->" +e);
}
finally
{
	connnew.close();
}
%>
</td></tr>
</table>
<%@ include file="footernew.jsp" %>
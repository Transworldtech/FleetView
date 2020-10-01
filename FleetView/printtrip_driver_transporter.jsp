<%@ include file="headerprintnew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">

<!-- code start Here -->

<%!
Connection connnew;
Statement st, st1, st2,st3,st4;
String user,sql,sql1,sql2;
String data1, data2,showdate1,showdate,DriverName,Owner,datenew1,datenew2,transporter,Transporter;
int OScount, RAcount, RDcount,Distance;
double Rating;
double rating1=0.00,rating=0.00;
 %>
<%
//***************************8
NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 

datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
	transporter=request.getParameter("Oname");
	Class.forName(MM_dbConn_DRIVER); 
	connnew = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=connnew.createStatement();
	st1=connnew.createStatement();
	st2=connnew.createStatement();
	st3=connnew.createStatement();
	st4=connnew.createStatement();
%>
<table border="0" width="100%" bgcolor="white" >
	<tr><td align="center"><font size="2"><b>Driver Rating Report for <%=transporter%> from date
	<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew1))%> to <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew2))%>. </b></font><div align="right">
	<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %></div></td></tr>
	</table>
	<table border="0" width="100%" bgcolor="white" class="sortable">
	<tr>
	<td class="hed">SR.</td>
	<td class="hed">Driver Name</td>
	<td class="hed">Driver Code</td>
	<td class="hed">Transporter</td>
	<td class="hed">OS Duration<br>(in Sec)</td>
	<td class="hed">RA Count</td>
	<td class="hed">RD Count</td>
	<td class="hed">Distance</td>
	<td class="hed">Rating</td>
	</tr>
	<%
	int JCode,VehCode,RAcount,RDcount,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0;
	double rating;
	//double a,b,c;
	double ctr=0.0;
	double d=0.0;
	String DriverID,DriverName;
	String ll="";
	try
	{
		sql="SELECT sum( RACount ) AS RAcount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration, DriverID, DriverName, OwnerName, Sum( KmTravelled ) AS Distance FROM t_completedjourney WHERE StartDate >= '"+datenew1+"' AND EndDate <= '"+datenew2+"' AND (OwnerName LIKE 'Castrol' OR GPName LIKE 'Castrol') and OwnerName = '"+transporter+" 'GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC"; 
	
//	out.println("SQL:::"+sql);
	//sql="select distinct(Dcode), avg(Rating) as Rating ,sum(Distance) as Distance from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and distance > 0 and Jcode <>'-' group by Dcode order by Rating,Distance desc";
	ResultSet rst=st2.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		//VehCode=rst.getInt("Vehid");
		RAcount=rst.getInt("RAcount");
		//System.out.println("RACount::"+RAcount);
		RDcount=rst.getInt("RDCount");
		//System.out.println("RDCount::"+RDcount);
		OSduration=rst.getInt("OSDuration");
		//System.out.println("OSDuration::"+OSduration);
		DriverID=rst.getString("DriverID");
		//System.out.println("DriverCode::"+DriverID);
		DriverName=rst.getString("DriverName");
		//System.out.println("DriverName::"+DriverName);
		Transporter=rst.getString("OwnerName");
		//System.out.println("Transporter::"+Transporter);
		//rating=rst.getDouble("Rating");
		distance=rst.getInt("Distance");
		//System.out.println("Distance::"+distance);
		
		
		%>
		<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
		<td class="bodyText"><div align="left"><%=DriverName%></div></td>
		<td class="bodyText"><div align="right"><%=DriverID%></div></td>
		<td class="bodyText"><div align="left"><%=Transporter%></div></td>
		<td class="bodyText"><div align="right"><%=OSduration%></div></td>
		<td class="bodyText"><div align="right"><%=RAcount%></div></td>
		<td class="bodyText"><div align="right"><%=RDcount%></div></td>
		<td class="bodyText"><div align="right"><%=distance%></div></td>
		
		<%rating=0.00;
		if(distance ==0)
		{
			//out.print("NA");
		}
		else
		{
			rating=(((Double.valueOf(RAcount)/distance)*100)+((Double.valueOf(RDcount)/distance)*100)+((Double.valueOf(OSduration)/10/distance)*100));
			//System.out.println("RatingBeforeSubstring::"+rating);
			//ll=""+rating;
			///if(ll.length() >5)
			//{
				//ll=ll.substring(0,5);
			//}
			//out.print(ll);
			//d=Double.valueOf(ll);
			//System.out.println("RatingAfterSubstring::::"+d);
		}
		if(rating!=0)
		{
		%>
		<td class="bodyText"><div align="right"><%=nf.format(rating)%>
		<%
		}else{
		%>
		<td class="bodyText"><div align="right"><%="NA"%>
		<%	
		}
		%></div></td></tr>
		<%
		i++;
		RAcnt=RAcnt+RAcount;
		//System.out.println("RACnt::::"+RAcnt);
		RDcnt=RDcnt+RDcount;
		//System.out.println("RDCnt::::"+RDcnt);
		OScnt=OScnt+OSduration;
		//System.out.println("OSCnt::::"+OScnt);
		Distcnt=Distcnt+distance;
		//System.out.println("Distcnt::::"+Distcnt);
		//ctr=ctr+d;
		//cntrate=cntrate+rating;
		}
	if(Distcnt!=0.00)
	{
	    rating1=(((Double.valueOf(RAcnt)/Distcnt)*100)+((Double.valueOf(RDcnt)/Distcnt)*100)+((Double.valueOf(OScnt)/10/Distcnt)*100));
	}
	else{
		rating1=0;
	}
		%>
		<tr>
		<td class="bodyText" colspan="4"><div align="right"><b>Total</b></div></td>
			<td class="bodyText"><div align="right"><b><%=OScnt%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=RAcnt%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=RDcnt%></b></div></td>
		<td class="bodyText"><div align="right"><b><%=Distcnt%></b></div></td>
	
		<%//rating1=0.00;
		//String  ss=""+ctr;
		//if(ss.length() >5)
		//{
			//ss=ss.substring(0,5);
		//}
		//out.print(ss);
		if(rating1!=0)
			{
			%>
				<td class="bodyText"><div align="right"><%=nf.format(rating1)%>
					
			<%}else{%>
			
				<td class="bodyText"><div align="right"><%="NA"%>
			<%		
				}
		%>
		</b></div></td>
		</tr>
	</table>
	<%
	}catch(Exception e)
	{
		out.print("Exception -->"+ e);
	}
	finally
	{
		try{
			connnew.close();
		}
		catch(Exception e)
		{
			
		}
	}
	%>
	<!-- code end here -->
	</td></tr>
	</table>
	<%@ include file="footernew.jsp" %>
	
        	
<%@ include file="headerprintnew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">

<!-- code start Here -->

<%!
//Connection connnew;
Connection conn, conn1;
Statement st0,st, st1, st2,st3,st4;
String user,sql,sql1,sql2;

 %>
<%
String data1, data2,showdate1=null,showdate=null,DriverName,Owner,datenew1,datenew2,Transporter="";
int OScount, RAcount, RDcount,Distance;
double Rating;
String user,sql="",sql1=null,sql2=null,sql3=null,transporter=null,ndcnt=null;
String fidDate=null, trips=null,counDriveYesNo=null,ntDriveYesNo=null;
int oscount=0, racount=0,rdcount=0, ndcount=0, stcount=0,cdcount=0, runDuration=0,osduration=0,osduration1=0,tpcount=0,tpcount1=0,dcount=0,dcount1=0,vcount=0, vcount1=0,mydtcount=0,mydtcount1=0;
int oscount1=0, racount1=0,rdcount1=0, ndcount1=0, stcount1=0,cdcount1=0,transportercount=0,runDuration1=0;
double rtcount=0.00,dtcount=0.00, dtcount1=0.00;
String ss="", vv="",ownerNm="";
double Accelaration1=0.00,Decelaration1=0.00,OverSpeed1=0.00;
double rating1=0.00,rating=0.00;
int cntos=0, cntra=0, cntrd=0, cntcr=0, cntnd=0, cntst=0,cntd=0,cntdt=0;

NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2); 
//datenew1=request.getParameter("data1");
//datenew2=request.getParameter("data2");
datenew1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
datenew2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));

Transporter=request.getParameter("userval");
//System.out.println("Transporter");

try{
		
		cntos=0;
		cntra=0;
		cntrd=0;
		cntdt=0;
	transportercount=0;
	tpcount1=0;
	oscount1=0;
	racount1=0;
	rdcount1=0;
	ndcount1=0;
	stcount1=0;
	cdcount1=0;
	runDuration1=0;
	rtcount=0.0;
	osduration1=0;
	dcount1=0;
	vcount1=0;
	mydtcount=0;
	mydtcount1=0;
	
		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st0=conn.createStatement();
		st1=conn.createStatement();
		
		}
		catch(Exception e)
		{
			out.print("Exception "+e);
		}
%>
<table class="stats">

	<th colspan="13">Exception Report for <%=Transporter%> transporters from date <%
	out.print(request.getParameter("data1"));
	//Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
	//showdate = formatter2.format(ShowDate);
	//out.print(showdate);
	%> to <%
	out.print(request.getParameter("data2"));
	//Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	//showdate1 = formatter1.format(ShowDate1);
	//out.print(showdate1);
	%>. <div align="right">
	
	<%
	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	String sdt = fmt.format(new java.util.Date());
	// out.print(sdt);
	 String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
		String fromdate1="",todate1="";
	%></div></th>
	<tr>
<td class="hed"><div class="bodyText"><b>SR</b></div></td>
	<td class="hed"><div class="bodyText"><b>Customer Name</b></div></td>
	<td class="hed"><div class="bodyText"><b>Trips</b></div></td>
	<td class="hed"><div class="bodyText"><b>Drivers</b></div></td>
	<td class="hed"><div class="bodyText"><b>Vehicle</b></div></td>
	<td class="hed"><div class="bodyText"><b>OS Duration<br>(in Sec)</b></div></td>
	<td class="hed"><div class="bodyText"><b>RA</b></div></td>
	<td class="hed"><div class="bodyText"><b>RD</b></div></td>
	<td class="hed"><div class="bodyText"><b>DT</b></div></td>
	<td class="hed"><div class="bodyText"><b>CD</b></div></td>
	<td class="hed"><div class="bodyText"><b>ND</b></div></td>
	<td class="hed"><div class="bodyText"><b>Rating</b></div></td>
	</tr>
		<%int i=0;
		try{
			sql="select OwnerName,DriverID,DriverName,count(distinct(TripId)) as tpcount,DriverName, count(distinct(VehId)) as vcount ,count(distinct(DriverId)) as dcount, sum(OSDuration) as osduration, sum(RACount) as racount,sum(RDCount) as rdcount ,sum(KmTravelled) as dist, NDCount as ndcount ,CRCount as crcount from t_completedjourney where (OwnerName like '"+session.getAttribute("usertypevalue").toString()+"'  OR GPName like '"+session.getAttribute("usertypevalue").toString()+"' ) and StartDate between '"+datenew1+"' and '"+datenew2+"'  group by Ownername  " ;
			//out.println("sql--"+sql);
			ResultSet rst=st0.executeQuery(sql);
				while(rst.next())
				{
					//System.out.println("===In rst==");
					racount=rst.getInt("racount");
					racount1+=rst.getInt("racount");
					DriverName=rst.getString("DriverName");
					
					rdcount=rst.getInt("rdcount");
					rdcount1+=rst.getInt("rdcount");
					
					counDriveYesNo=rst.getString("crcount");
					
					ntDriveYesNo=rst.getString("ndcount");
					
					mydtcount=rst.getInt("dist");
					
					mydtcount1+=rst.getInt("dist");
					
					tpcount=rst.getInt("tpcount");
					tpcount1+=rst.getInt("tpcount");
					
					dcount=rst.getInt("dcount");
					dcount1+=rst.getInt("dcount");
					
					vcount=rst.getInt("vcount");
					vcount1+=rst.getInt("vcount");
					
					osduration=rst.getInt("osduration");
					osduration1+=rst.getInt("osduration");
					
					ownerNm=rst.getString("OwnerName");
					
					String drivId=rst.getString("DriverID");
				String	DriverNm=rst.getString("DriverName");
				i++;		
					
			%>
			<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
			<!--<td class="bodyText"><div align="left"><%//=ownerNm%></div></td>--> 
			 <td class="bodyText"><div align="left"><%=ownerNm%></div></td> 
			<td class="bodyText"><div align="right"><%=tpcount%></div></td>
			<td class="bodyText"><div align="right"><%=dcount%></div></td>
			<td class="bodyText"><div align="right"><%=vcount%></div></td>
			<td class="bodyText"><div align="right"><%=osduration%></div></td>
			<td class="bodyText"><div align="right"><%=racount%></div></td>
			<td class="bodyText"><div align="right"><%=rdcount%></div></td>
			<td class="bodyText"><div align="right"><%=mydtcount%></div></td>
			
			<td class="bodyText"><div align="right">
			<%
			
			String ss2=rst.getString("CRCount");
			if(ss2.equals("Yes"))
			{
				cntra=cntra++;
				out.print(""+ss2);
			}
			else
			{
				out.print(""+ss2);
			}
			%>
	</div></td>
			
			<td class="bodyText"><div align="right">	
			<%
				String ss5=rst.getString("NDCount");
				if(ss5.equals("Yes"))
				{	cntnd=cntnd+1;
					out.print(""+ss5);
				}
				else
				{
					out.print(""+ss5);
				}
			%> 
</div></td>
			<%	
			/************ code for rating calculation ****************/
			 dtcount = Double.valueOf(mydtcount);
			 rating=0.00;
			if(dtcount!=0.00)
			{
				//rating=((racount/dtcount)*100)+((rdcount/dtcount)*100)+((osduration/10/dtcount)*100);
				rating=(((Double.valueOf(racount)/dtcount)*100)+((Double.valueOf(rdcount)/dtcount)*100)+((Double.valueOf(osduration)/10/dtcount)*100));
				//System.out.println("=====rating===dtcount!=0=="+rating);
			}
			else 
			{
				rating=0;
				//System.out.println("=====rating===dtcount=0=="+rating);
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
			}//ss+=ownerNm+",";
			 %>
			</div></td>
			</tr>
			<%
			} //end of rst while
				//i++;
		
				//i++;
				
			%>
			<tr>
			<td class="hed"><div class="bodyText" align="right"></div></td>
			<td class="hed"><div class="bodyText" align="right">Total</div></td>
			<td class="hed"><div class="bodyText" align="right"><%=tpcount1%></div></td>
			<td class="hed"><div class="bodyText" align="right"><%=dcount1%></div></td>
			<td class="hed"><div class="bodyText" align="right"><%=vcount1%></div></td>
			<td class="hed"><div class="bodyText" align="right"><%=osduration1%></div></td>
			<td class="hed"><div class="bodyText" align="right"><%=racount1%></div></td>
			<td class="hed"><div class="bodyText" align="right"><%=rdcount1%></div></td>
			<td class="hed"><div class="bodyText" align="right"><%=mydtcount1%></div></td>
			<td class="hed"><div class="bodyText" align="right">
			<%	Accelaration1=0;
			Decelaration1=0;
			OverSpeed1=0;
			
				if((racount1 != 0) && (mydtcount1 > 0))
				{
					//out.print("in acc Accelaration1===>");
				Accelaration1=((double)racount1/(double)mydtcount1)*100;
				//out.print("Accelaration1===>"+Accelaration1);
				}
				if((rdcount1 != 0) && (mydtcount1 > 0))
				{
				//out.print("in acc Decelaration1===>");
				Decelaration1=((double)rdcount1/(double)mydtcount1)*100;
				//out.print("Decelaration1===>"+Decelaration1);
				}
				if((osduration1 != 0) && (mydtcount1> 0))
				{
					//out.print("in acc osduration1===>");
				OverSpeed1 =(((double)osduration1/10)/(double)mydtcount1)*100;
				//out.print("OverSpeed1===>"+OverSpeed1);
				}
			//	Rating1=Accelaration1+Decelaration1+OverSpeed1;
				
				if(cntcr>0)
				{
					out.print("Yes");
				}
				else
				{
					out.print("No");
				}
			%>
			 </div></td>
			<td class="hed"><div class="bodyText" align="right">
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
			</div></td>
				<%
				 dtcount1 = Double.valueOf(mydtcount1);
					/************ code for rating calculation ****************/
			 rating1=0.00;
			if(dtcount1!=0.00)
			{
				//rating1=((racount1/dtcount1)*100)+((rdcount1/dtcount1)*100)+((osduration1/10/dtcount1)*100);
				rating1=(((Double.valueOf(racount1)/dtcount1)*100)+((Double.valueOf(rdcount1)/dtcount1)*100)+((Double.valueOf(osduration1)/10/dtcount1)*100));
				
				//System.out.println("=====rating===dtcount!=0=="+rating);
			}
			else 
			{
				rating1=0;
				//System.out.println("=====rating===dtcount=0=="+rating);
			}
			
			if(rating1!=0)
			{
			%>
				<td class="bodyText"><div align="right"><%=nf.format(rating1)%>
					
			<%}else{%>
			
				<td class="bodyText"><div align="right"><%="NA"%>
			<%		
				}
			String str=""+rating1;
				ss+=ownerNm+",";
			 	vv+=str+",";
			 %>
		
		</div></td>
					
			</tr>
			<%
	if(vv.length()>=2)
	{
		vv=vv.substring(0,vv.length()-1);
	}
	else
	{
		vv="-";
	}
	if(ss.length()>=2)
	{
		ss=ss.substring(0,ss.length()-1);
	}
	else
	{
		ss="-";
	}
	
			}catch(Exception e)
			{
			out.print("Exception "+e);
			}
			finally
			{
				try{
					conn.close();
					conn1.close();
				}
				catch(Exception e)
				{
					
				}
			
			}
			%>
	</table>
<!-- code end here -->

<%@ include file="footernew.jsp" %>
    
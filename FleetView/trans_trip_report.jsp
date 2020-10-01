<%@ include file="headernew.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>

<%!
Connection conn, conn1;
Statement st0,st, st1, st2,st3,st4;
String user,sql="",sql1,sql2,sql3,transporter,ndcnt=null;
String fidDate, data1, data2,showdate,showdate1,trips,counDriveYesNo,ntDriveYesNo;
int oscount, racount,rdcount, ndcount, stcount,cdcount, runDuration,osduration,osduration1,tpcount,tpcount1,dcount,dcount1,vcount, vcount1;
int oscount1, racount1,rdcount1, ndcount1, stcount1,cdcount1,transportercount,runDuration1;
double rtcount,dtcount, dtcount1;
String ss="", vv="",ownerNm="";
double OverSpeed,Accelaration,Decelaration,Rating,Rating1,Accelaration1,Decelaration1,OverSpeed1;
double rating1=0.00;
%>
<%
ss="";
vv="";
try{
	
	
transportercount=0;
tpcount1=0;
oscount1=0;
racount1=0;
rdcount1=0;
ndcount1=0;
stcount1=0;
cdcount1=0;
dtcount1=0.00;
runDuration1=0;
rtcount=0.0;
osduration1=0;
dcount1=0;
vcount1=0;

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
//java.util.Date defoultdate = new java.util.Date();
//Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
//fidDate = formatter.format(defoultdate);
String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	if(!(null==request.getParameter("data")))
	{
		//fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
		//todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
	fromdate1=request.getParameter("data");
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
	todate1=request.getParameter("data1");
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
	//out.print(fromdate);
	}
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	//out.print(todate);
	}

%>
<script language="javascript">
 			function validate()
  			{
 	  			//alert("hi");
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
  				return datevalidate();
  		  }
  		 function datevalidate()
		 {
  			// alert("hidate");
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2,dmom1,dmom2;
			
			dd1=date1.substring(0,2);
			//alert("dd1-->"+dd1);
			
			dm1=date1.substring(3,6);
			//alert("dm1-->"+dm1);
			
			dy1=date1.substring(7,11);
			//alert("dy1-->"+dy1);

			
			if(dm1=="Jan"){
				dm1="01";
			}else if(dm1=="Feb"){
				dm1="02";
			}else if(dm1=="Mar"){
				dm1="03";
			}else if(dm1=="Apr"){
				dm1="04";
			}else if(dm1=="May"){
				dm1="05";
			}else if(dm1=="Jun"){
				dm1="06";
			}else if(dm1=="Jul"){
				dm1="07";
			}else if(dm1=="Aug"){
				dm1="08";
			}else if(dm1=="Sep"){
				dm1="09";
			}else if(dm1=="Oct"){
				dm1="10";
			}else if(dm1=="Nov"){
				dm1="11";
			}else if(dm1=="Dec"){
				dm1="12";
			}


		//	alert("dm1===>"+dm1);
			
			//dmom2=date2.substring(5,7);

			dd2=date2.substring(0,2);
			//alert("dd2-->"+dd2);
			
			dm2=date2.substring(3,6);
		//	alert("dm2-->"+dm2);
			
			dy2=date2.substring(7,11);
		//	alert("dy2-->"+dy2);

			
			if(dm2=="Jan"){
				dm2="01";
			}else if(dm2=="Feb"){
				dm2="02";
			}else if(dm2=="Mar"){
				dm2="03";
			}else if(dm2=="Apr"){
				dm2="04";
			}else if(dm1=="May"){
				dm2="05";
			}else if(dm2=="Jun"){
				dm2="06";
			}else if(dm2=="Jul"){
				dm2="07";
			}else if(dm2=="Aug"){
				dm2="08";
			}else if(dm2=="Sep"){
				dm2="09";
			}else if(dm2=="Oct"){
				dm2="10";
			}else if(dm2=="Nov"){
				dm2="11";
			}else if(dm2=="Dec"){
				dm2="12";
			}
			//alert("dm2===>"+dm2);
			
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
			var date=new Date();
			//alert("date====>"+date);
			var month=date.getMonth()+1;
			//alert("month====>"+month);
			var day=date.getDate();
			//alert("day====>"+day);
			var year=date.getFullYear();
			
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			
			if(dm1==month)
			{
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
			if(dm1==dm2) 
			{
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
<table border="1" width="100%" bgcolor="white">

<tr><td>
<!--Start of outer table -->
<table class="stats">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td>
<input type="text" id="data" name="data" value="<%=fromdate1%>"  size="15" readonly/>
  </td><td align="left">
<input type="button" name="From Date" value="From Date" id="trigger" >
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",      // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td>

<input type="text" id="data1" name="data1" value="<%=todate1%>" size="15" readonly/></td><td align="left">
  <input type="button" name="To Date" value="To Date" id="trigger1" >
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td>
<td><input type="submit" name="submit" id="submit" value="submit" ></td>
</tr>
</form>

<tr><td colspan="5">
<%
String dd=request.getQueryString();
if(dd==null)
{
out.print("<center class='bodyText'><b>Please select the dates to display the report</b></center>");
}
else
{
data1=request.getParameter("data");
data2=request.getParameter("data1");

user=session.getAttribute("usertypevaluemain").toString();
%>
<table class="stats">
<th colspan="13">Exception Report for <%=user%> transporters from date <%
java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy").parse(data1);
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
showdate = formatter2.format(ShowDate);
out.print(showdate);
%> to <%
java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy").parse(data2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
showdate1 = formatter1.format(ShowDate1);
out.print(showdate1);
%>. <div align="right">
<div align="right">
<a href="#" onclick="javascript:window.open('printtrip_report.jsp?userval=<%=user%>&data=<%=data1%>&data1=<%=data2%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceltrip_report.jsp?userval=<%=user%>&data=<%=data1%>&data1=<%=data2%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div></th></tr>
<tr>
<td class="hed"><div class="bodyText"><b>Customer Name</b></div></td>
<td class="hed"><div class="bodyText"><b>Trips</b></div></td>
<td class="hed"><div class="bodyText"><b>Drivers</b></div></td>
<td class="hed"><div class="bodyText"><b>Vehicle</b></div></td>
<td class="hed"><div class="bodyText"><b>OS Duration</b></div></td>
<td class="hed"><div class="bodyText"><b>RA</b></div></td>
<td class="hed"><div class="bodyText"><b>RD</b></div></td>
<td class="hed"><div class="bodyText"><b>DT</b></div></td>
<td class="hed"><div class="bodyText"><b>Run Hrs.</b></div></td>
<td class="hed"><div class="bodyText"><b>CD</b></div></td>
<td class="hed"><div class="bodyText"><b>ND</b></div></td>
<td class="hed"><div class="bodyText"><b>Rating</b></div></td>
</tr>
	<%
	
	try{
		sql="select OwnerName,count(distinct(TripId)) as tpcount, sum(RunningDuration)as runDuration, count(distinct(VehId)) as vcount ,count(distinct(DriverId)) as dcount, sum(OSDuration) as osduration, sum(RACount) as racount,sum(RDCount) as rdcount ,sum(KmTravelled) as dist, NDCount as ndcount ,CRCount as crcount from t_completedjourney where OwnerName ='"+user+"' and StartDate between '"+fromdate+"' and '"+todate+"'  group by Ownername  " ;
		//out.println("SQL:::-->"+sql);
		
		ResultSet rst=st0.executeQuery(sql);
			while(rst.next())
			{
				//System.out.println("===In rst==");

				racount=rst.getInt("racount");
				racount1+=rst.getInt("racount");
				
				rdcount=rst.getInt("rdcount");
				rdcount1+=rst.getInt("rdcount");
				
				counDriveYesNo=rst.getString("crcount");
				
				ntDriveYesNo=rst.getString("ndcount");
				
				dtcount=rst.getDouble("dist");
				dtcount1+=rst.getDouble("dist");
				
				tpcount=rst.getInt("tpcount");
				tpcount1+=rst.getInt("tpcount");
				
				dcount=rst.getInt("dcount");
				dcount1+=rst.getInt("dcount");
				
				vcount=rst.getInt("vcount");
				vcount1+=rst.getInt("vcount");
				
				osduration=rst.getInt("osduration");
				osduration1+=rst.getInt("osduration");
				
				ownerNm=rst.getString("OwnerName");
				
				runDuration=rst.getInt("runDuration");
				runDuration1+=rst.getInt("runDuration");
				
		%>
		<tr>
		<td class="bodyText"><div align="left"><%=ownerNm%></div></td>
		<td class="bodyText"><div align="right"><%=tpcount%></div></td>
		<td class="bodyText"><div align="right"><%=dcount%></div></td>
		<td class="bodyText"><div align="right"><%=vcount%></div></td>
		<td class="bodyText"><div align="right"><%=osduration%></div></td>
		<td class="bodyText"><div align="right"><%=racount%></div></td>
		<td class="bodyText"><div align="right"><%=rdcount%></div></td>
		<td class="bodyText"><div align="right"><%=dtcount%></div></td>
		<td class="bodyText"><div align="right"><%=runDuration%></div></td>
		<td class="bodyText"><div align="right">
		<%try{
			sql2="select * from t_completedjourney where OwnerName ='"+user+"'and StartDate between '"+fromdate+"' and '"+todate+"' and CRCount like 'Yes' limit 1 " ;
			ResultSet rst2=st1.executeQuery(sql2);
			//out.println("===In sql1===Yes?==>"+sql2);
			while(rst2.next())
			{
				counDriveYesNo=rst2.getString("CRCount");
			}
			if(counDriveYesNo!=null)
			{
				if((counDriveYesNo.equalsIgnoreCase("Yes")||(counDriveYesNo.equalsIgnoreCase("YES"))||(counDriveYesNo.equalsIgnoreCase("yes"))))
					{ 
						out.print("Yes");
			 		} else
			 		{ 
			 			out.print("No");
			 		}
			}
		else
		{
			out.print("No");
		} }catch(Exception e)
 		{
 			System.out.println("--Exception-In side CD---");
 			e.printStackTrace();
 		}
		 	%></div></td>
		<td class="bodyText"><div align="right">
			<% 
			try{
			sql1="select * from t_completedjourney where OwnerName ='"+user+"' and StartDate between '"+fromdate+"' and '"+todate+"' and NDCount like 'Yes' limit 1 " ;
			//out.println("-In side ND---"+sql1);
			ResultSet rst1=st1.executeQuery(sql1);
			while(rst1.next())
			{
			   ndcnt=rst1.getString("NDCount");
			}
			if(ndcnt!=null)
			{
				if((ndcnt.equalsIgnoreCase("Yes"))||(ndcnt.equalsIgnoreCase("YES"))||(ndcnt.equalsIgnoreCase("yes")))
				{ 
					out.print("Yes");
				} else
			 	{
					out.print("No");
			 	}
			}else{
				out.print("No");
			}
			
			}catch(Exception ee)
			{
				System.out.println("--Exception-In side ND---");
				ee.printStackTrace();
			}
		 	%>
		</div></td>
		<%	/************ code for rating calculation ****************/
		double rating=0.00;
		if(dtcount!=0.00)
		{
			rating=((racount/dtcount)*100)+((rdcount/dtcount)*100)+((osduration/10/dtcount)*100);
			//System.out.println("=====rating===dtcount!=0=="+rating);
		}
		else 
		{
			rating=0;
			//System.out.println("=====rating===dtcount=0=="+rating);
		}
		%>
		<td class="bodyText"><div align="right"><%
		if(rating!=0)
		{
				String str=""+rating;
				//System.out.println("===str=rating=="+str);
				if(str.equals("0.0"))
				{
					str="0.00";
					//System.out.println("===str.equals(0.0)=="+str);
				
				}
				int len=str.length();
				if(len > 4)
				{
					str=str.substring(0,4);
					//System.out.println("===str.substring(0,4)=="+str);
					out.print(str);
				}
				else
				{
					out.print(str);
				}
				
				 ss+=ownerNm+",";
				 vv+=str+",";
		}else
			{
				out.print("NA");
			}
		
		%>
		</div></td>
		</tr>
		<%
		} //end of rst while
			Accelaration1=0;
			Decelaration1=0;
			OverSpeed1=0;
	
			if(racount1 > 0 && dtcount1 > 0)
			{
			Accelaration1=((double)racount1/(double)dtcount1)*100;
			}
			if(rdcount1 > 0 && dtcount1 > 0)
			{
			Decelaration1=((double)rdcount1/(double)dtcount1)*100;
			}
			if(osduration1 > 0 && dtcount1> 0)
			{
			OverSpeed1 =(((double)osduration1/10)/(double)dtcount1)*100;
			}
			Rating1=Accelaration1+Decelaration1+OverSpeed1;
		%>
		<tr>
		<td class="hed"><div class="bodyText" align="right">Total</div></td>
		<td class="hed"><div class="bodyText" align="right"><%=tpcount1%></div></td>
		<td class="hed"><div class="bodyText" align="right"><%=dcount1%></div></td>
		<td class="hed"><div class="bodyText" align="right"><%=vcount1%></div></td>
		<td class="hed"><div class="bodyText" align="right"><%=osduration1%></div></td>
		<td class="hed"><div class="bodyText" align="right"><%=racount1%></div></td>
		<td class="hed"><div class="bodyText" align="right"><%=rdcount1%></div></td>
		<td class="hed"><div class="bodyText" align="right"><%=dtcount1%></div></td>
		
		<td class="hed"><div class="bodyText" align="right"><%=runDuration1%></div></td>
		<td class="hed"><div class="bodyText" align="right">
		<%if((counDriveYesNo.equalsIgnoreCase("Yes")||(counDriveYesNo.equalsIgnoreCase("YES"))||(counDriveYesNo.equalsIgnoreCase("yes"))))
				{ 
					out.print("Yes");
		 		} else
		 		{ 
		 			out.print("No");
		 		} 
		 %>
		 </div></td>
		<td class="hed"><div class="bodyText" align="right">
		<%
		if((ndcnt.equalsIgnoreCase("Yes"))||(ndcnt.equalsIgnoreCase("YES"))||(ndcnt.equalsIgnoreCase("yes")))
		{ out.print("Yes");
			
 		} else
 		{ out.print("No");
 		} 
		 	%></div></td>
				<%	/************ code for rating calculation ****************/
				if(dtcount1!=0.00)
				{
					rating1=((racount1/dtcount1)*100)+((rdcount1/dtcount1)*100)+((osduration1/10/dtcount1)*100);
					//System.out.println("=====rating=1==dtcount!=0=="+rating1);
				}
				else 
				{
					rating1=0;
					//System.out.println("=====rating1===dtcount=0=="+rating1);
				}
				%>
				<td class="bodyText"><div align="right"><%
				if(rating1!=0)
				{
						String str1=""+rating1;
						//System.out.println("===str=rating1=="+str1);
						if(str1.equals("0.0"))
						{
							str1="0.00";
							//System.out.println("===str.equals(0.0)=="+str1);
						}
						int len=str1.length();
						if(len > 4)
						{
							str1=str1.substring(0,4);
							//System.out.println("===str.substring(0,4)=="+str1);
							out.print(str1);
						}
						else
						{
							out.print(str1);
						}
						 //ss+=ownerNm+",";
						// vv+=str1+",";
				}else
					{
						out.print("NA");
					}
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
		conn.close();
		conn1.close();
		}
		%>
</table>

</td></tr>

</table>
<!--Start Code for the Graph -->
</td></tr>
<tr><td class="bodyText">
<table border="0" width="100%">
<tr><td valign="top" colspan="2">
<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var q = new Graph(200,200);
q.scale = 1;
q.title = "Average Rating for all transporter";
q.yLabel = "Exceptions";
q.xLabel = "<%=showdate%> to <%=showdate1%>";
q.setXScale("",1);
<%
String osp,rax,rdx,rat;
osp=""+OverSpeed1;
rax=""+Accelaration1;
rdx=""+Decelaration1;
rat=""+rating1;
if(osp.length() >5)
{
osp=osp.substring(0,5);
}
if(rax.length() >5)
{
rax=rax.substring(0,5);
}
if(rdx.length() >5)
{
rdx=rdx.substring(0,5);
}
if(rat.length() >5)
{
rat=rat.substring(0,5);
}
%>
q.setLegend('Over Speed (<%=osp%>)','Rapid Accelaration (<%=rax%>)','Rapid Decelaration (<%=rdx%>)','Rating (<%=rat%>)');
q.addRow(<%=OverSpeed1%>);
q.addRow(<%=Accelaration1%>);
q.addRow(<%=Decelaration1%>);
q.addRow(<%=Rating1%>);
q.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb4.gif\">");
}

</SCRIPT>
</td></tr><tr>
<td  valign="top">
<SCRIPT LANGUAGE="JavaScript">

if(parseInt(navigator.appVersion) >= 4) {
var a = new Graph(250,200);
a.scale = 2;
a.title = "Rating Graph";
a.yLabel = "Rating";
a.xLabel = "Transporters";
a.setXScale("",1);
a.setLegend("Rating");
a.addRow(<%=vv%>);
a.build();
} else {
  document.writeln("<IMG ALT=\"Upgrade to Communicator!\" SRC=\"exb5.gif\">");
}
</SCRIPT>

</td>
<td  valign="bottom" class="bodyText">
<BLOCKQUOTE>

<SCRIPT LANGUAGE="JavaScript">
if(parseInt(navigator.appVersion) >= 4) {
var str="<%=ss%>";

var str1="<%=vv%>";

var vv=str1.split(",");
var ss=str.split(",");

document.writeln("<b>Transporters</b><br>");
for(i=0; i< ss.length; i++)
{
document.writeln(i +". "+ss[i]+" ("+vv[i]+")<br>");
}
}
</SCRIPT>

</BLOCKQUOTE>
</td>
</tr></table>
<!--End Code for the Graph -->

<!--end of outer table -->
<%

}

%>
</td></tr>
</form>
</table>
<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>


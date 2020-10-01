<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<style>
<!-- 
    SPAN.searchword { background-color:cyan; }
    
// -->
</style>

<style>

SPAN.super 
{
	text-decoration: blink;
	text-align: center; 
}

</style>

<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">
<script language="JavaScript">
<!--
    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;     
    }
    // -->
</script>
<script type="text/javascript">
function toggleDetails(id, show)
{
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
			} else {
		popup.style.visibility = "hidden";
	}
}

function toggleDetails1(id, show)
{
	var popupx = document.getElementById("popupx"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
		
	} else {
		popupx.style.visibility = "hidden";
	}
}
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function article(programName,width,height)
{

	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; displayWindow=window.open(programName,"displayWindow",temp) ;
}
function fun(aa)
{
	//alert(aa.value);
	document.searchform.h.value=aa.value;
}

function showhide1()
{
	var cnt=document.getElementById("cnt").value;
	//alert("Hi Atul !"+cnt);
	var tda, tdb,tdc,tdd,tde;
	var tdx=document.getElementById("tdx").value;
	
	if(tdx=="Hide Trip Info")
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='none';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='none';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='none';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='none';
			tde=document.getElementById("tde"+i);
			tde.style.display='none';
			document.getElementById("tdx").value="Show Trip Info";
		}
	}
	else
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='';
			tde=document.getElementById("tde"+i);
			tde.style.display='';
			document.getElementById("tdx").value="Hide Trip Info";
		}
	}
}
//*********************Code for Hide Fuel INfo Button***********************************************************
function showhide2()
{
	var cnt=document.getElementById("cnt").value;
	//alert("Hi Atul !"+cnt);
	var tdp, tdm,tdf,tdl,tdy,tdr,tdn;
	var tds=document.getElementById("tds").value;
	
	if(tds=="Hide Fuel Info")
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tdp=document.getElementById("tdp"+i);
			tdp.style.display='none';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='none';
			tdf=document.getElementById("tdf"+i);
			tdf.style.display='none';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='none';
			tdy=document.getElementById("tdy"+i);
			tdy.style.display='none';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='none';
			tdn=document.getElementById("tdn"+i);
			tdn.style.display='none';
			document.getElementById("tds").value="Show Fuel Info";
		}
	}
	else
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tdp=document.getElementById("tdp"+i);
			tdp.style.display='';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='';
			tdf=document.getElementById("tdf"+i);
			tdf.style.display='';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='';
			tdy=document.getElementById("tdy"+i);
			tdy.style.display='';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='';
			tdn=document.getElementById("tdn"+i);
			tdn.style.display='';
			document.getElementById("tds").value="Hide Fuel Info";
		}
	}
}
//*************************************End of Hide Fuel INfo Button**********************************************
//---------------------------- validation for Search through vehicle or driver-------------
function validaterdb()
{
	//alert(" hi");
	var rdb=document.searchhi.rdbsearch.length;
	//alert(rdb);
	var i=0;
	var flag=false;
	for(i=0;i<rdb;i++)
	{
		//alert("inside"); 
		if(document.searchhi.rdbsearch[i].checked)
		{
			flag=true;
		}
		
	} 
	if(flag==false)
	{
		alert("Please Select one option");
		return false; 
	}
	
	if(document.searchhi.txtsearch.value == "" || document.searchhi.txtsearch.value == " ")
	{
		alert("Please Enter the value in searchbox");
		return false;
	}	
	
	return true;
}

function enablesearch()
{
	//alert(document.getElementById("search").style.display);
	if(document.getElementById("search").style.display=='none')
	{
		//alert("hi");
		document.getElementById("search").style.display='block';
	}
	else
	{
		document.getElementById("search").style.display='none';
	}
	//document.getElementById("search").dtyle.display='';
}
//-------------------------------------------------------------------------
</script>

<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>


<%!
	Connection conn,conn1;
	Statement st,st1,stx,st2,stmt;
	String aa,regno,sq,searchveh;
%>
<%
try
{
	conn=fleetview.ReturnConnection();
	conn1=fleetview.ReturnConnection1();
	st=conn.createStatement();
	stmt=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	//out.print(session.getAttribute("VehList").toString());
%><div style="width: 40%;text-align: left;">			
	<!-- <font color="block" size="3" >Report No: 1.0</font>-->
	
		
	<font color="green" size="4"><B> <I> </I> </B><a href="#" onclick="javascript:window.open('generateSecurityCode.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');"><font style="font-size: 0.6em;"> Security Code </font></a> </font>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		
		<blink>
		<font color="green" size="4"><a href="#" onclick="javascript:window.open('trainerfeedback.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');"> <font style="font-size: 0.6em;">HE Trainer Feedback.</font> </a> </font>
		</blink>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	<%
		//out.print(session.getValue("usertypevalue"));
		String sql2="select GPName from t_group where VehRegno like '%"+session.getValue("usertypevalue")+"%' and GPName='Castrol' ";
	//	System.out.println(sql);
		
		ResultSet rstneww=st.executeQuery(sql2);
		//out.print(rstneww.next());
		//gp=rstneww.getString("GPName");
		//gp1=rstneww.getString("GPName");
		if(rstneww.next())	
		{
			//out.println(rstneww.getString("GPName"));
			if(rstneww.getString("GPName").equalsIgnoreCase("castrol"))
			{
		%>
		
		<font color="green" size="4"><a href="#" onclick="javascript:window.open('images/ND_SMS_Intimation_Template1.pdf','','menubar=1,resizable=1,width=550,height=350,location=no');"> <font style="font-size: 0.6em;">Night Driving Intimation</font> </a> </font>
		
		
		<%
			}
		}
		%>
		</div>
		<div align="center" style="margin-top: -1%;"><font style="font-size: 1.2em;"><b>Current Position Of Vehicles </b></font></div>
<div style="text-align: right;margin-right: 10%;position: relative;margin-top: -1.4%;">
	
	<form method="post" name="searchhi" action="">
				
				
		<!-- ************************Row is excluded**********************-->
			<!-- 
			<a href="onlinedata.jsp" title="Slow Process" id="blinking">Click To View All Vehicle On Map.</a>
			 -->
	  <!-- ******************end of modification************************** -->
	  
	  
	 <input type="radio" name="rdbsearch" id="rdbsearch" value="vehicle" class="bodyText"><font color="green">Vehicle</input>&nbsp;&nbsp; 
	 <input type="radio" name="rdbsearch" id="rdbsearch" value="driver" class="bodyText"><font color="green">Driver</input>			
<!--	 	</td>-->
<!--			<td class="bodyText">-->
			<input  name="txtsearch" id="txtsearch" value="" class="bodyText"  style="border: thin;border-style: solid;"></input> &nbsp; &nbsp;
			<input type="submit" name="btnsubmit" value="Go" class="bodyText" onclick="return validaterdb();"></input>	
				
			</form>
	</div>
	
	<table border="0" width="100%" align="center" style="">
		<tr><td align="center">
		<%
		
		//------------- code for searching vehicle wise and driver wise---------------
		//--------------------------------- Pradnya--------------------------------------------
		
		String search="",driversearch="",searchlist="";
		String radiobtn=request.getParameter("rdbsearch");
		System.out.println(radiobtn+" radiobtn");
		if(radiobtn!=null)
		{
			search=request.getParameter("txtsearch");
		}
		/*
		if(radiobtn!=null && radiobtn.equalsIgnoreCase("vehicle"))
		{
				vehsearch=request.getParameter("txtsearch");
				StringTokenizer strtoken=new StringTokenizer(vehsearch,",");
				while(strtoken.hasMoreTokens())
				{
					searchlist="'"+strtoken.nextToken()+"',"+searchlist;
				}
				
		}
		else if(radiobtn!=null && radiobtn.equalsIgnoreCase("driver"))
		{
			driversearch=request.getParameter("txtsearch");
			StringTokenizer strtoken=new StringTokenizer(vehsearch,",");
			while(strtoken.hasMoreTokens())
			{
				searchlist="'"+strtoken.nextToken()+"',"+searchlist;
			}
			
		}
		*/
		
		
		//---------------------------------------------------------------------------------------------------
		
		if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
		{
			out.print("<br><font size='2'>You are viewing vehicles which are in 10 km. range from your location and vehicles which are going from your location and coming to your location.</font>");
			/* code to search and add vehicle which is not in the list */
		%>
		<p></p>
		<table class="stats">
			<form name="searchform" action="" method="get">
			<tr><th  colspan="5">Search and add the vehicle in the list.</th></tr>
			<tr><td class="bodyText" colspan="5"><div align="right">Vehicle is not in the list, please enter the Vehicle registration number to search.</div><div align="right"><input type="hidden" name="h" id="h" class="formElement"><input type="text" name="searchveh" class="formElement" onChange="fun(this);">&nbsp;&nbsp;&nbsp; <input type="submit" name="Search!" value="Search!" class="formElement"></div></td></tr>
			</form>
 
			<%
			searchveh=request.getParameter("searchveh");
			if(!(null==searchveh))
			{
				String sql="select * from t_group where transporter like '%"+searchveh+"%' and GPName='"+session.getAttribute("usertypevalue").toString()+"' and vehCode not in "+session.getAttribute("VehList").toString();
				//out.print(sql);
				ResultSet rstnew=st.executeQuery(sql);
			%>
			<form name="addveh" method="get" action="addveh.jsp">	
			<tr><td class="bodyText" colspan="5">Please check Vehicle to add in the list</td></tr>
			<tr>
				<td class="hed">Check<input type="hidden" name="hh" value="<%=searchveh%>"></td>
				<td class="hed">Vehicle Reg. No</td>
				<td class="hed">Transporter</td>
				<td class="hed">Updated</td>
				<td class="hed">Location</td>
				</tr>	
			<%
			int j=1;
			while(rstnew.next())
			{
				sql="select * from t_onlinedata where VehicleCode='"+rstnew.getString("VehCode")+"'";
				ResultSet rstnew1=st1.executeQuery(sql);
				if(rstnew1.next())
				{
				%>
				<tr>
				<td><INPUT TYPE=CHECKBOX NAME="ch<%=j%>" value="<%=rstnew1.getString("VehicleCode")%>"></td>
				<td align="left"><%=rstnew1.getString("VehicleRegNo")%></td>
				<td align="left"><%=rstnew1.getString("Transporter")%></td>
				<td align="left"><%= new SimpleDateFormat("dd-MMM-yyyy").format(rstnew1.getDate("TheDate"))%><%=rstnew1.getString("TheTime")%></td>
				<td align="left"><div align="left"><%=rstnew1.getString("Location")%> </div></td>
				</tr>			
			<%
			j++;
			}
			}
			%>
			<input type="hidden" name="count" value="<%=j%>">
			<tr><td colspan="5" align="center"><input type="submit" value="Add Vehicle" Name="Add_Vehicle" class="formElement"></td></tr>
			</form>
			<%
			}
			%>
		</table>
		<%
		/* code end added by Atul Kalaskar on Date 11-11-09 */

		}
		%>
	
	</td></tr>
	<tr><td>
	
	<table border="0" widht="100%" align="center">
	
	<!-- *************************************Modifications done *************************************************-->
	<!-- The following four rows are excluded -->
	
		<!--<tr><td><font color="red" size="2"><B> Kind Attention : Due to server maintainance the website will be unavailable from 06.30 p.m to 08.00 p.m. on 23rd Jan 2010. Sorry for the inconvenience. </blink></I> </B> 
		</font>		</td></tr>-->
		<!-- 
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 
		<a href="imeimessage.jsp">
		<font color="lightred" size="2"><B> <I> <blink>IMPORTANT NOTICE: IMEI NUMBER </blink></I> </B> 
		</font>	
			</td></tr>
		<tr><td>
		<blink>
		<font color="maroon" size="3"><B> <I> Note: </I> </B>Please upload Fuel Fill-Up data for all Vehicles to get correct average. Click <a href="fuelentry.jsp"> Here </a> to insert Fuel data.  </font>
		
		</blink>
		</td></tr>
		 -->
	<!-- ********************************end of modifications done*************************************************** -->
		
		
		
			 
		 
	<tr><td>
	<table width="100%" border="0">
			<tr>
			
			
			</tr>
		</table>
	</td></tr>
	<tr><td>
	<!--  Mian Code Comes Here -->
	<table border="0" width="100%">
		<tr bgcolor="#F0E68C">
		<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :<a href="currentposition.jsp"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full Fleet</b></td>
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="moving.jsp">Moving</a></b></td>
		<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="stopped.jsp">Stop</a></b></td>
		<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="disconnected.jsp">Disconnected</a></b></td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="Hide Trip Info" onclick="showhide1();" class="formElement" id="tdx" style="border: thin;border-style: solid;">&nbsp;&nbsp;
		<input type="button" value="Show Fuel Info" onclick="showhide2();" class="formElement" id="tds" style="border: thin;border-style: solid;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#" onclick="javascript:window.open('printcurrentposition.jsp');" title="Print Current Position Report">
			<img src="images/print.jpg" width="15px" height="15px">
			</a>&nbsp; &nbsp; 
			<a href="excelcorrentposition.jsp"  title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px">
			</a>
		&nbsp;&nbsp;
			<%=fleetview.PrintDate()%>
		</td>
		</tr>

		</table>
			
			<%
			final String  VehList=session.getAttribute("VehList").toString();
			///////---------------------------------------- get vehicles code -----------------
			 String  VehList1="";
			System.out.println("VehList1"+VehList1);
			//searchlist=searchlist.substring(0,searchlist.length()-1);
			if(radiobtn!=null && radiobtn.equalsIgnoreCase("vehicle"))
			{
				
				
				
				StringTokenizer strtoken=new StringTokenizer(search,",");
				while(strtoken.hasMoreTokens())
				{
					//searchlist="'"+strtoken.nextToken().trim()+"',"+searchlist;	
					
					String vehicle=strtoken.nextToken().trim();
					System.out.println("hdgn***********cb   "+vehicle);
			String que="select vehiclecode from t_onlinedata where VehicleRegNo LIKE '%"+vehicle+"%' and vehiclecode in "+ VehList +"";
			ResultSet rsget=stmt.executeQuery(que);
			while(rsget.next())
			{
				VehList1=rsget.getString("vehiclecode")+","+VehList1;
				
			}
			}
			//----------------- to remove last comma---------------------------
				if(!VehList1.equals(""))
		  			VehList1=VehList1.substring(0,VehList1.length()-1);
			}// if
			//------------------------------------------------------------------------------
			else if(radiobtn!=null && radiobtn.equalsIgnoreCase("driver"))
			{
				
				StringTokenizer strtoken=new StringTokenizer(search,",");
				while(strtoken.hasMoreTokens())
				{
					
					String driver=strtoken.nextToken().trim();
				
				String sql1="select Vehid from t_startedjourney where (DriverName LIKE '%"+driver+"%' or DriverCode like '%"+driver+"%') and Vehid in "+ VehList +" and JStatus='Running'";
				System.out.println(sql1);
				
				ResultSet rsget=stmt.executeQuery(sql1);
				while(rsget.next())
				{
					VehList1=rsget.getString("Vehid")+","+VehList1;
					
				}
				}
				if(!VehList1.equals(""))
				VehList1=VehList1.substring(0,VehList1.length()-1);
			}
			
			
			
			
			System.out.print("VehList1--"+VehList1);
			int i=0;
			if(VehList1.equals(""))
			{
				%>
				<br>
				<div align="center" width = "100%"><font size="4" face="Arial" color="black"><b>No Vehicle Available</b></font></div>
				<%
			}
			else
			{
				%>
				<table width="100%" border="1" align="center" class="sortable">
				<tr>
				<th> <b> Sr. </b></th>
				<th> <b>Veh.</b></th>
				
				<th> <b>Updated</b></th>
				<!-- ***************** new Column added************************** -->
				<th> <b>Transporter</b></th>
				<!-- ***************** end ************************** -->
				<th id="tdd0"> <b>Trip Id</b></th>
				<th id="tde0"><b>Driver Name(Code)</b></th>
				<th id="tda0"><b>Trip Origin</b></th>
				<th id="tdb0"><b>Start Date</b></th>
				<th id="tdc0"><b>Trip Destination</b></th>
				<th> <b>Location</b></th>
				<th> <b>Ignition</b></th>
				<th> <b>Speed</b></th>
				<th> <b>OS Today</b></th>
				<th> <b>Distance Today</b></th>
				<th> <b>Distance This Month</b></th>
				<!-- *****************Changes done************************** -->
				<th id="tdp0" style="display: none;"> <b>Previous Day Avg.</b></th>
				<th id="tdm0" style="display: none;"> <b>Avg. This Month</b></th>
				<th id="tdf0" style="display: none;"> <b>Fuel</b></th>
				<th id="tdl0" style="display: none;"> <b>Fuel Alert</b></th>
				<th id="tdy0" style="display: none;"> <b>Yesterday's Fuel Added</b></th>
				<th id="tdr0" style="display: none;"> <b>Day Shift Driver</b></th>
				<th id="tdn0" style="display: none;"> <b>Night Shift Driver</b></th>
				<!-- *********************End of changes done******************* -->
				<%
				if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
				{
				%>
				<th><b>Sen1</b></th>
				<th><b>Sen2</b></th>
				<th><b>Sen3</b></th>
				<th><b>Sen4</b></th>
				<%
				}
				%>
				</tr>		
			<%
			String sql="select * from t_onlinedata where vehiclecode in ("+ VehList1 +") and vehiclecode <> '0'  order by concat(TheDate,TheTime) desc";
			System.out.println(sql);
			ResultSet rst=st.executeQuery(sql);
			
			while(rst.next())
			{
				i++;
				long ax=0, bx=12, cx=24, dx=36, ex=48, fx=60, gx=72, hx=84, ix=96, jx=108, kx=120, lx=132, mx=144, nx=156, ox=168, px=180, qx=192, rx=204, sx=216, tx=228, ux=240;
				int col=rst.getInt("TheSpeed");
				int kmtoday=0,kmlastday=0,kmthismonth=0,thedistance=0,ostoday;
				String fuelvalue="0";
				
				if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal") && !(rst.getString("FuelLevel").equalsIgnoreCase("NA")))
				{
					fuelvalue=""+fleetview.Liter_To_Gallan(rst.getInt("FuelLevel"));
				}
				else
				{
					fuelvalue=rst.getString("FuelLevel");
				}
				String vcode=rst.getString("VehicleCode");
				ostoday=rst.getInt("OSCount");
				if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				{
					thedistance=(int)fleetview.KM_TO_MILES1(rst.getInt("TheDistance"));
					kmlastday=(int)fleetview.KM_TO_MILES1(rst.getInt("LastDayKm"));
					kmtoday=thedistance-kmlastday;
					if(kmtoday <0 || kmtoday >800)
					{
						kmtoday=0;
					}
					kmthismonth=(int)fleetview.KM_TO_MILES1(rst.getInt("KMMonth"))+kmtoday;
				}
				else
				{
					thedistance=rst.getInt("TheDistance");
					kmlastday=rst.getInt("LastDayKm");
					kmtoday=thedistance-kmlastday;
					if(kmtoday <0 || kmtoday >800)
					{
						kmtoday=0;
					}
					kmthismonth=rst.getInt("KMMonth")+kmtoday;
				}
				
				
				//out.print(kmtoday+"  "+kmthismonth+" ");
				if(fleetview.checkUserBlocked(rst.getString("Transporter")).equals("Yes"))
				{
				%>
					<tr bgcolor="white">
					<td style="text-align:right"><%=i%></td>
					<td style="text-align:left"><%=rst.getString("VehicleRegNo")%></td>
					<td style="text-align:left"><%="Blocked"%></td>
					<!-- *****************Changes done************************** -->
					<td style="text-align:left"><%=rst.getString("Transporter")%></td>
					<!-- ***************** end of Changes done************************** -->
					<td id="tdd<%=i%>">-</td>
					<td id="tde<%=i%>">-</td>
					<td id="tda<%=i%>">-</td>
					<td id="tdb<%=i%>">-</td>
					<td id="tdc<%=i%>">-</td>
					<td style="text-align:left"><%="Access denied for "+rst.getString("Transporter")%></td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<!-- *********************Changes done**************************** -->
					<td id="tdp<%=i%>" style="display: none;">-</td>
					<td id="tdm<%=i%>" style="display: none;">-</td>
					<td id="tdf<%=i%>" style="display: none;">-</td>
					<td id="tdl<%=i%>" style="display: none;">-</td>
					<td id="tdy<%=i%>" style="display: none;">-</td>
					<td id="tdr<%=i%>" style="display: none;">-</td>
					<td id="tdn<%=i%>" style="display: none;">-</td>
					<!-- ***********************End of changes done********************* -->
					<%
					if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
					{
					%>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<%
					}
					%>
				</tr>	
				<%
				}
				else
				{
	java.util.Date todaysDate =new java.util.Date();
					
					Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Format NewFormatter2 = new SimpleDateFormat("yyyy-MM-dd");
					String currentDateTime = NewFormatter1.format(todaysDate);
					
					String d2=NewFormatter2.format(todaysDate);
					
					long todaysDateMillis = todaysDate.getTime(); // todays date in millisecs
					long dayInMillis = 1000 * 60 * 60 *24; // 1 day in millisecs
					
					todaysDateMillis = todaysDateMillis - dayInMillis; // 24 hrs previous datetime from currentdatetime (in millisecs)
					todaysDate.setTime(todaysDateMillis);
					
					String twentyFourHoursPrevDatetime = NewFormatter1.format(todaysDate);
					
					String d1=NewFormatter2.format(todaysDate);
					
					
					String twentyFourHoursPrevDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
					String currentDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
					String ftime1= new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
					String ftime2= new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
					String ttime1= new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTime));
					String ttime2= new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTime));
					
					
					session.setAttribute("hvid",rst.getString("VehicleCode"));
					session.setAttribute("fff",twentyFourHoursPrevDatetime);
					session.setAttribute("ttt",currentDateTime);
					session.setAttribute("hdate1",d1);
					session.setAttribute("hdate2",d2);	
					
				
					java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDate")+" "+rst.getString("TheTime"));
					Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
					String showdate1 = formatter1.format(ShowDate1);
					java.util.Date ddd= new java.util.Date();
					long dt1=ShowDate1.getTime();
					long dt2=ddd.getTime();
					long days=((dt2-dt1)/(60 * 60 * 1000L* 24));
					long mins=((dt2-dt1)/60000);
					long mins2=Integer.parseInt(session.getAttribute("desconnected").toString());
					String bgcolor="";
					String igni="NA";
					
						igni=rst.getString("ignition");
					
					if(col > 0 && igni.equals("OFF"))
					{
						bgcolor="background-color:#FF6600";
					}
					else if(col >0) 
					 { 
						 if(mins >mins2 )
						 	{
						 		bgcolor="background-color:#DCDCDC";
						 	}
						 else 
						 	{
						 		bgcolor="background-color:#CCFFCC";
						 	}
					 } 
					 else 
					 { 
						 if(mins >mins2 )
						 {
						 bgcolor="background-color:#DCDCDC";
						 }
						 else
						 { 
							 bgcolor="background-color:#FFFFCC";
						 } 
					}  				 
					%>
					<tr>
					<td style="<%=bgcolor %>; text-align:right" ><%=i %></td>
					<td style="<%=bgcolor %>;  text-align:left">
					<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=rst.getString("VehicleRegNo")%> </a>  <br />
        		<div class="popup" id="popup<%=i%>">
				<table border="1" bgcolor="white">
		   	<tr>  
				<td> <a href="veh_report_24h.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 24 Hours </a>
				</td>
		   	</tr>
		   	<tr>
		   	<td> <a href="veh_report_48h.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 48 Hours </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="veh_report_7d.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 7 Days </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="veh_report_15d.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 15 Days </a>
				</td>
		   	</tr>
		   	<tr>
		   		<td> <a href="ShowCustomReportonTWMap.jsp?tripid=''&vehcode=<%=rst.getString("VehicleCode")%>&data=<%=twentyFourHoursPrevDate%>&data1=<%=currentDate%>&ftime1=<%=ftime1%>&ftime2=<%=ftime2%>&ttime1=<%=ttime2%>&ttime2=<%=ttime2%>" onclick="toggleDetails(<%=i%>,false);">Last 24 Hours Journey On Map </a> 
				</td>
				<!--<td> <a href="veh_showhistory.jsp?vehcode=< %=rst.getString("VehicleCode")%>" onclick="toggleDetails(< %=i%>,false);">Last 24 Hours Journey On Map </a> 
		  		</td>-->
		   	</tr>
		   	<tr>
				<td> <a href="hourly_detail_report.jsp?vehcode=<%=rst.getString("VehicleCode")%>&h1=no" onclick="toggleDetails(<%=i%>,false);">Detail Report </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="detail_custom_report.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Custom Detail Report </a>
				</td>
		   	</tr>
		   	<tr>
				<td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
				</td>
		   	</tr>
	   		</table>
				</div>
					</td>
					<td style="<%=bgcolor %>; text-align:left">
					<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
					</td>
					<!-- *****************Changes done************************** -->
					<td style="<%=bgcolor %>; text-align:left"><%=rst.getString("Transporter") %></td>
					<!-- *****************end of Changes done************************** -->
					<%
					ResultSet rsttrip=fleetview.isInTrip(rst.getString("VehicleCode"),session.getAttribute("TypeofUser").toString());
					if(rsttrip.next())
					{
					%>
					<td style="<%=bgcolor %>" id="tdd<%=i%>; text-align:right">
					<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><%=rsttrip.getString("TripId")%> </a>  <br />
        			<div class="popup" id="popupx<%=i%>">
					<table border="1" bgcolor="white">
<!--		   			<tr>  -->
<!--					<td> <a href="startedtrip.jsp?tripid=<%=rsttrip.getString("TripId")%>&vehcode=<%=rst.getString("VehicleCode")%>&sdate=<%=rsttrip.getString("StartDate")%>&vehregno=<%=rst.getString("VehicleRegNo")%>&ownername=<%=rsttrip.getString("OwnerName")%>&startplace=<%=rsttrip.getString("StartPlace")%>&endplace=<%=rsttrip.getString("EndPlace")%>&enddate=<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())%>&pg=st" onclick="toggleDetails1(<%=i%>,false);">Show Trip on Map </a>-->
<!--					</td>-->
<!--		   			</tr>-->
		   			<tr>
					<td><a href="javascript: flase" onClick="window.open ('endtrip.jsp?tripid=<%=rsttrip.getString("TripId")%>&vehcode=<%=rst.getString("VehicleCode")%>&vehno=<%=rst.getString("VehicleRegNo")%>', 'win1', 'width=400, height=250, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">End Trip </a>
					</td>
		   			</tr>
			  		 <tr>
					<td> <a href="javascript:toggleDetails1(<%=i%>,false);">Close </a>
					</td>
		   			</tr>
	   				</table>
					</div>
					</td>
					<td style="<%=bgcolor %>; text-align:left" id="tde<%=i%>"><div align="left"><%=rsttrip.getString("DriverName")+"("+rsttrip.getString("DriverCode")+")"%></div></td>
					<td style="<%=bgcolor %>; text-align:left" id="tda<%=i%>"><div align="left"><%=rsttrip.getString("StartPlace")%></div></td>
					<td style="<%=bgcolor %>; text-align:left" id="tdb<%=i%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip.getDate("StartDate"))%></td>
					<td style="<%=bgcolor %>; text-align:left" id="tdc<%=i%>"><div align="left"><%=rsttrip.getString("EndPlace")%></div></td>
					<%
					}
					else
					{
					%>
					<td style="<%=bgcolor %>; text-align:left" id="tdd<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>"><--Enter</a></td>
					<td style="<%=bgcolor %>; text-align:left" id="tde<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">New</a></td>
					<td style="<%=bgcolor %>; text-align:left" id="tda<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">Trip</a></td>
					<td style="<%=bgcolor %>; text-align:left" id="tdb<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">Information</a></td>
					<td style="<%=bgcolor %>; text-align:left" id="tdc<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">Here --></a></td>
				
					<%
					}
					%>
					<td style="<%=bgcolor %>" ><div align="left"> 
					
					<%=fleetview.showNewMap(rst.getString("LatitudePosition"),rst.getString("LongitudePosition"),rst.getString("Location")) %> 
					<%
					if(fleetview.isUnitRemoved(rst.getString("VehicleCode")).equals("Yes"))
					{
						out.print("<font color='blue' size='2'> Device Removed</font>");
					}
					else
					{
						if(mins >mins2) 
						{
							out.print("<font color='red' size='2'> Device Disconnected</font>"); 
						}
					}
					%>
					</div> 
					</td>
					<td style="<%=bgcolor %>; text-align:left">
					<%
							out.print(igni);
					
					%>
					</td>
					<td style="<%=bgcolor %>"><div align="right"><%=rst.getInt("TheSpeed") %></div></td>
					<td style="<%=bgcolor %>"><div align="right">
					<% 
					if(ostoday >0)
					{
						%>
						<a href="newos.jsp?vehcode=<%=rst.getString("VehicleCode") %>&fromdate=<%=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>&todate=<%=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"><%=ostoday %></a>
						<%
					}
					else
					{
						out.print(ostoday);
					}
					
					%>
					</div></td>
					<td style="<%=bgcolor %>"><div align="right"><%=kmtoday %></div></td>
					<td style="<%=bgcolor %>"><div align="right"><%=kmthismonth %></div></td>
								
					<% 
					if(fleetview.getUnitDescription(rst.getString("VehicleCode")).equals("FUELFLOW"))
					{ 	
						java.util.Date lastday=new java.util.Date();
						long todaymils=lastday.getTime();
						long oneday=1000*60*60*24;
						todaymils=todaymils-oneday;
						lastday.setTime(todaymils);
						String daybefor=new SimpleDateFormat("yyyy-MM-dd").format(lastday);
						String firstday=daybefor.substring(0,8)+"01";
					%>
					<!-- *********************Changes done**************************************** -->
					<td style="display: none; <%=bgcolor %>; text-align:right"  id="tdp<%=i%>"><%= rst.getString("LastDayAVG")%></td>
					<td style="display: none; <%=bgcolor %>; text-align:right" id="tdm<%=i%>"><%= rst.getString("LastMonthAVG") %></td>
					
					<!-- *********************end Changes done**************************************** -->
					<%
					//fleetview.getFuelLevel(rst.getString("VehicleCode"),i) 
					if(rst.getString("LastDayAVG").equals("NC"))
					{%>
						<td style="display: none; <%=bgcolor %>; text-align:left" id="tdf<%=i%>">Not Calibrated</td>
					<%}
					else
					{
						if(!((fuelvalue.equals("NA")) ||(fuelvalue.equals("0"))))
						{
							String str="<div id=\"showbar"+i+"\" style=\"font-size:6pt;padding:1px;border:solid black 1px;visibility:hidden\"> <span id=\"progressA"+i+"\">&nbsp;</span><span id=\"progressB"+i+"\">&nbsp;</span><span id=\"progressC"+i+"\">&nbsp;</span><span id=\"progressD"+i+"\">&nbsp;</span><span id=\"progressE"+i+"\">&nbsp;</span><span id=\"progressF"+i+"\">&nbsp;</span><span id=\"progressG"+i+"\">&nbsp;</span><span id=\"progressH"+i+"\">&nbsp;</span><span id=\"progressI"+i+"\">&nbsp;</span><span id=\"progressJ"+i+"\">&nbsp;</span><span id=\"progressK"+i+"\">&nbsp;</span><span id=\"progressL"+i+"\">&nbsp;</span><span id=\"progressM"+i+"\">&nbsp;</span><span id=\"progressN"+i+"\">&nbsp;</span><span id=\"progressO"+i+"\">&nbsp;</span><span id=\"progressP"+i+"\">&nbsp;</span><span id=\"progressQ"+i+"\">&nbsp;</span><span id=\"progressR"+i+"\">&nbsp;</span><span id=\"progressS"+i+"\">&nbsp;</span><span id=\"progressT"+i+"\">&nbsp;</span></div>";
							String str1="";
							if(Integer.parseInt(fuelvalue) > ax && Integer.parseInt(fuelvalue)<=bx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >bx && Integer.parseInt(fuelvalue)<=cx)
							{	
							str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >cx && Integer.parseInt(fuelvalue)<=dx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >dx && Integer.parseInt(fuelvalue)<=ex)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >ex && Integer.parseInt(fuelvalue)<=fx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >fx && Integer.parseInt(fuelvalue)<=gx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >gx && Integer.parseInt(fuelvalue)<=hx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >hx && Integer.parseInt(fuelvalue)<=ix)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >ix && Integer.parseInt(fuelvalue)<=jx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >jx && Integer.parseInt(fuelvalue)<=kx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >kx && Integer.parseInt(fuelvalue)<=lx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >lx && Integer.parseInt(fuelvalue)<=mx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >mx && Integer.parseInt(fuelvalue)<=nx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >nx && Integer.parseInt(fuelvalue)<=ox)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >ox && Integer.parseInt(fuelvalue)<=px)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >px && Integer.parseInt(fuelvalue)<=qx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >qx && Integer.parseInt(fuelvalue)<=rx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >rx && Integer.parseInt(fuelvalue)<=sx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressR"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >sx && Integer.parseInt(fuelvalue)<=tx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressR"+i+"').style.backgroundColor = progressColor;document.getElementById('progressS"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) > tx && Integer.parseInt(fuelvalue)<= ux)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressR"+i+"').style.backgroundColor = progressColor;document.getElementById('progressS"+i+"').style.backgroundColor = progressColor;document.getElementById('progressT"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
							{
							fuelvalue=fuelvalue +" Gal"+str +str1;
							}
							else
							{
								fuelvalue=fuelvalue +" ltr"+str +str1;
							}
						}
						%>
						<td style="display: none; <%=bgcolor %>; text-align:right" id="tdf<%=i%>"><%=fuelvalue %></td>
			<%		}
					%>
					</td> 
					<%
					String yesdate="",facnt="",ftcount="";
					String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
					String today2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
					try{
					String sql3="select DATE_ADD('"+today+"',INTERVAL -1 DAY) as newdate";
					ResultSet rs3= st1.executeQuery(sql3);
					if(rs3.next())
					{  
						yesdate=rs3.getString("newdate");
					}
					}catch (Exception e) {
						System.out.print("Exception--->"+e);
					}
					try{
						String sql16="select count(*) as ftcount from t_vehft where vehcode like '"+vcode+"' and Thedate>='"+today+"' and TheDate <='"+today+"' order by concat(TheDate,TheTime) desc";
						ResultSet rs16= st2.executeQuery(sql16);
						if(rs16.next())
						{  
							ftcount=rs16.getString("ftcount");
						}
						}catch (Exception e) {
							System.out.print("Exception--->"+e);
						}
					try{
						String sql4="select count(*) as fcnt from t_vehfa where vehcode like '"+vcode+"' and Thedate>='"+yesdate+"' and TheDate <='"+yesdate+"' order by concat(TheDate,TheTime) desc";
						ResultSet rs4= st2.executeQuery(sql4);
						if(rs4.next())
						{  
							facnt=rs4.getString("fcnt");
						}
						}catch (Exception e) {
							System.out.print("Exception--->"+e);
						}
						//out.print(facnt);
					String today1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(yesdate));
					%>
					<!-- *********************Changes done**************************************** -->
					<td style="display: none; <%=bgcolor %>; text-align:right" id="tdl<%=i%>"><a href="showfuelalert.jsp?vehcode=<%=vcode%>&data=<%=today2%>&data1=<%=today2%>"><%=ftcount%></a></td>
					<td style="display: none; <%=bgcolor %>; text-align:right" id="tdy<%=i%>"><a href="showfueladd.jsp?vehcode=<%=vcode%>&data=<%=today1%>&data1=<%=today1%>"><%=facnt%></a></td>
					<!-- *********************end of Changes done**************************************** -->
					<%	
						String sql20="select * from t_drivervehicles where vehcode like '"+vcode+"'";
						ResultSet rs20=st1.executeQuery(sql20);
						if(rs20.next())
						{
					%>
					<!-- *********************Changes done**************************************** -->
						<td style="display: none; <%=bgcolor %>; text-align:left" align="center" id="tdr<%=i%>"><%=rs20.getString("DayshiftDriver")%>  (<%=rs20.getString("Mob1")%>)</td>
						<td style="display: none; <%=bgcolor %>; text-align:left" align="center" id="tdn<%=i%>"><%=rs20.getString("NightshiftDriver")%>  (<%=rs20.getString("Mob2")%>)</td>
						<!-- *********************end of Changes done**************************************** -->				
					<%		
						}
						else
						{	
					%>	
					<!-- *********************Changes done**************************************** -->
					<td style="display: none; <%=bgcolor %>" id="tdr<%=i%>">-</td>
					<td style="display: none; <%=bgcolor %>" id="tdn<%=i%>">-</td>			
					<!-- *********************end of Changes done**************************************** -->
					<%
						}
								
			}
			else
			{
			%>
			<!-- *********************Changes done**************************************** -->
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdp<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdm<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdf<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdl<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdy<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdr<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>; text-align:left" id="tdn<%=i%>">NA</td>
				<!-- *********************end of Changes done**************************************** -->
			<%
			}
			%>
			<%
				if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
				{
					ResultSet rsttemp=fleetview.getTempValue(rst.getString("VehicleCode"));					
					if(rsttemp.next())
					{
			%>
					
			<%
					try
					{
						if(rsttemp.getString("Sen1").equals("0"))
						{%>
							<td style="<%=bgcolor %>;  text-align:left" >xxxx</td>
						<%}
						else
						{%>
							<td style="<%=bgcolor %>;  text-align:right" ><%=rsttemp.getDouble("Sen1") %></td>
						
						<%	//out.print(rsttemp.getDouble("Sen1"));
						}
					}catch(Exception e1)
					{
					try
					{%>
					<td style="<%=bgcolor %>;  text-align:left" >xxxx</td>
				<%		//out.print("xxxx");
					}
					catch(Exception e2)
					{
					}
				}
 			%>
				
				
			<%
				try
				{
					if(rsttemp.getString("Sen2").equals("0"))
					{%>
						<td style="<%=bgcolor %>;  text-align:left" >xxxx</td>
					<%}
					else
					{
						
					%>
						<td style="<%=bgcolor %>;  text-align:right" ><%=rsttemp.getDouble("Sen2") %></td>
					
					<%// out.print(rsttemp.getDouble("Sen2"));
					}
				}
				catch(Exception e1)
				{
					try
					{
						%>
						<td style="<%=bgcolor %>;  text-align:left" >xxxx</td>
					<%
						//out.print("xxxx");
					}
					catch(Exception e2)
					{
					}
				}
 				%>
				
				<td style="<%=bgcolor %>;  text-align:left" >xxxx</td>
				<td style="<%=bgcolor %>;  text-align:left" >xxxx</td>
			<%
			}
			else
			{
			%>
				<td style="<%=bgcolor %>">-</td>
				<td style="<%=bgcolor %>">-</td>
				<td style="<%=bgcolor %>">-</td>
				<td style="<%=bgcolor %>">-</td>	
			<%
			}
		}
		%>
			</tr>	
		<%
	}
}
sql="select * from t_vehicledetails where vehiclecode in ("+VehList1+") and vehiclecode not in (select vehiclecode from t_onlinedata where vehiclecode in (" + VehList1 +")) and Status <> 'Removed'";  
ResultSet rstremoved1=stx.executeQuery(sql);
while(rstremoved1.next())
{
	String vcode=rstremoved1.getString("VehicleCode");
	i++;
%>
<tr>
	<td style="text-align:right"><%=i%></td>
	<td style="text-align:left"><%=rstremoved1.getString("VehicleRegNumber") %></td>
	<td style="text-align:left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstremoved1.getDate("InstalledDate")) %></td>
	<!-- *****************Changes done************************** -->
	<td style="text-align:left"><%=rstremoved1.getString("OwnerName") %></td>
	<!-- ***************** end of Changes done************************** -->
	<td id="tdd<%=i%>">-</td>
	<td id="tde<%=i%>">-</td>
	<td id="tda<%=i%>">-</td>
	<td id="tdb<%=i%>">-</td>
	<td id="tdc<%=i%>">-</td>
	<td><div align="left">Device Installed But Not Active
<%
	if(fleetview.isUnitRemoved(rstremoved1.getString("VehicleCode")).equals("Yes"))
	{
		out.print("<font color='blue' size='2'> Device Removed</font>");
	}
%>
	</div></td>
	<td>-</td>
	<td>-</td>
	<td>-</td>
	<!-- *********************Changes done**************************************** -->
	<td style="display: none;" id="tdp<%=i%>">-</td>
	<td style="display: none;" id="tdm<%=i%>">-</td>
	<td style="display: none;" id="tdf<%=i%>">-</td>
	<td style="display: none;" id="tdl<%=i%>">-</td>
	<td style="display: none;" id="tdy<%=i%>">-</td>
	<!-- *********************end of Changes done**************************************** -->
	
<%
	String sql20="select * from t_drivervehicles where vehcode like '"+vcode+"'";
	ResultSet rs20=st1.executeQuery(sql20);
	if(rs20.next())
	{
%>
<!-- *********************Changes done**************************************** -->
		<td class="hed" align="center" style="display: none; text-align:left" id="tdr<%=i%>"><%=rs20.getString("DayshiftDriver")%> (<%=rs20.getString("Mob1")%>)</td>
		<td class="hed" align="center" style="display: none; text-align:left" id="tdn<%=i%>"><%=rs20.getString("NightshiftDriver")%> (<%=rs20.getString("Mob2")%>)</td>
		<!-- *********************end of Changes done**************************************** -->			
<%		
	}
	else
	{	
%>	
<!-- *********************Changes done**************************************** -->
		<td class="hed" align="center" style="display: none;" id="tdr<%=i%>">-</td>
		<td class="hed" align="center" style="display: none;" id="tdn<%=i%>">-</td>
		<!-- *********************end of Changes done**************************************** -->			
<%
	}
%>
<%
	if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
	{
%>
		<td class="hed" align="left">xxxx</td>
		<td class="hed" align="left">xxxx</td>
		<td class="hed" align="left">xxxx</td>
		<td class="hed" align="left">xxxx</td>
<%
	}
%>
		<td class="hed" align="center">-</td>
		<td class="hed" align="center">-</td>	
	</tr>		
<%
}
			
%>
	<input type="hidden" name="cnt" id="cnt" value="<%=i%>">
	
</table>
	<%
			}
	%>
	<!--  Mian Code Comes Here -->
	</td></tr>
	</table>
	</td></tr>
	</table>
	
	
	
	
	<%
			
	}catch(Exception e)
	{
		//out.println("No Result To Display");
	
		out.print("Exception -->"+e);
	}
	%>

	<% fleetview.closeConnection(); 
	fleetview.closeConnection1();%>
	
	</jsp:useBean>
	<%@ include file="footernew.jsp" %>


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
	        
	          
	          document.DetailOdoCountReport.action ="excel.jsp";
	          document.forms["DetailOdoCountReport"].submit();
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
  skn=document.all.dek.style;
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


</script>
	</head>


	<%
//classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
String exportFileName=session.getAttribute("user").toString()+"_DetailOdoCountReport.xls";
%>

	<%@page import="com.fleetview.beans.classes"%>
	<%@page import="javax.swing.text.NumberFormatter"%>
	
	<form id="DetailOdoCountReport" name="DetailOdoCountReport" action="" method="post" >
		<div id="table1">
	<table
		width="100%" align="center" class="sortable">
		<tr>
			<td  colspan="10" align="center" class="sorttable_nosort">
			<div align="left"><font color="block" size="3">Report
			No: 5.6</font></div>
			<font color="block" size="3"><b>Detail Report</b></font></td>
		</tr>
		<%!
Connection conn, con1;
Statement st,st1,st2,st3,stveh1,stveh2;
String date1, date2,datenew1,datenew2, vehcode, vehregno,tbname,sql,owner,km,rating,from,to,ndcount;
String dateformat;
%>
		<%
datenew1=request.getParameter("fromdate");
datenew2=request.getParameter("todate");
String vehregno=request.getParameter("vehregnumber");
dateformat=session.getAttribute("dateformat").toString();
String ownerNm =request.getParameter("ownername");

String employeeName=request.getParameter("employeeName");
String vehicleCode=request.getParameter("vehicleCode");
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
%>
		<tr>
			<td colspan="10" class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Detail
			Report <%=ownerNm %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew1))  %> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew2)) %></font></div>
			<div align="right"><!--<a href="#" onclick="javascript:window.open('printcustfuel.jsp?owner=< %=ownerNm%>&vehno=< %=vehno%>&data=< %=date1 %>&data1=< %=date2 %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>-->&nbsp;
			&nbsp;
			<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
			<input type="hidden" id="fileName" name="fileName" value="<%=exportFileName%>" />
			      
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
			<th><b> Sr. </b></th>
			<th><b>EmployeeName</b></th>
			<th><b>Veh.</b></th>
			<th><b>Date-Time</b></th>
			<th><b>Driver</b></th>
			<th><b>Odometer</b></th>
			
			<th>
			<%
	     
	      			if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{
	    	  	%> <b> Gallans: </b> <%	}
				else
				{%> <b> Liters: </b> <%
				}%>
			</th>

			<th>
			<%
	      if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
				{
	    	  
	    	  %> <b> Gas Station:</b> <%	}
				else
				{%> <b> Petrol Pump:</b> <%
				}%>
			</th>
			<th><b>Ent By</b></th>
			<th><b>Remark</b></th>
		</tr>
		<%
			String trans="",remark="";
			int c=1;
			int i=1;
			double fueladded=0,totfuel=0,totalGpsDiff=0 ;
			double Avg=0.00;
			//owner ="Penzoil1";
			Double odolast=0.00,odofirst=0.00,Odometer1=0.00;
			int cnt=0;
			String vehicle="",datetime="",driver="",odometer="",petrolpump="",entby="";
			double lits=0.0;
			String sql21="select * from t_fuelinfo where VehNo='"+vehregno+"' and TheDateTime between '"+datenew1+" 00:00:00' and '"+datenew2+" 23:59:59' order by TheDateTime";
			//System.out.println("detail====>"+sql21);
			ResultSet rsgps=st1.executeQuery(sql21);
			ResultSet rs21=st.executeQuery(sql21);
			while(rs21.next())
			{
				driver=rs21.getString("Driver");
				if("Select".equalsIgnoreCase(driver)){
					driver="-";
				}
			%>
		<tr>
			<td style="text-align: right"><%=i++ %></td>
			<td style="text-align: right"><%=employeeName%></td>
			<td style="text-align: left"><%=rs21.getString("VehNo") %></td>
			<td style="text-align: left"><%=rs21.getString("TheDateTime") %></td>
			<td style="text-align: left"><%=driver %></td>
			<td style="text-align: right"><%=rs21.getString("Odometer")%></td>
			<td style="text-align: right"><%=rs21.getDouble("Litres")%></td>
			<td style="text-align: left"><%=rs21.getString("PetrolPump")%></td>
			<td style="text-align: left"><%=rs21.getString("EntBy") %></td>
			<td style="text-align: left"><%=rs21.getString("Remark")%></td>
		</tr>
		<%
		cnt++;
			}
			
			%>
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
%>
	<% //fleetview.closeConnection(); %>

	<%@ include file="footernew.jsp"%>

</html>
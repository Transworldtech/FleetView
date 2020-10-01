<%@ include file="headernew.jsp"%>
<html>			
<head>
	
</head>
<script type="text/javascript"> 
function poponclick()
{

	

	var datenew1=document.getElementById("datenew1").value;
	var firstodo=document.getElementById("firstodo").value;
	var firstgps=document.getElementById("firstgps").value;
	var datenew2=document.getElementById("datenew2").value;
	var lastodo=document.getElementById("lastodo").value;
	var lastgps=document.getElementById("lastgps").value;
	var finalodo=document.getElementById("finalodo").value;
	var finalgps=document.getElementById("finalgps").value;



	
testwindow = window.open("fueldetail.jsp?datenew1="+datenew1+"&firstodo="+firstodo+"&firstgps="+firstgps+"&datenew2="+datenew2+"&lastodo="+lastodo+"&lastgps="+lastgps+"&finalodo="+finalodo+"&finalgps="+finalgps+"", "Fuel Details","width=330,height=120");
    testwindow.moveTo(500,250);
}
function showentryform()
{
	document.getElementById("entryform").style.visibility="visible";
       
}

function cancelentryform()
{
       
        document.getElementById("entryform").style.visibility="hidden";
}


function showentryform1()
{
        document.getElementById("entryform1").style.visibility="visible";
}

function cancelentryform1()
{
       
        document.getElementById("entryform1").style.visibility="hidden";
}

function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)
{  
	
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.Total_os.action ="excel.jsp";
          document.forms["Total_os"].submit();
 }  
</script>
<body>
	<table width="100%" align="center" class="stats">
		<tr>
			<td align="center" class="sorttable_nosort">
				<!-- <div align="left"><font color="block" size="3" >Report No:35 </font></div>-->
				<font color="block" size="3" ><b>Fuel Full Tank Report</b></font>
			</td>
		</tr>
		<tr>
			<td>
			
<%
try
{
	

String vehcode=request.getParameter("vehcode");
String fromdate=request.getParameter("fromdate");
String todate=request.getParameter("todate");
String ownername=request.getParameter("ownername");
String vehregnumber=request.getParameter("vehregnumber");
String firstodo=request.getParameter("firstodo");
String lastodo=request.getParameter("lastodo");
String firstgps=request.getParameter("firstgps");
String lastgps=request.getParameter("lastgps");
String firstfuel=request.getParameter("firstfuel");
String lastfuel=request.getParameter("lastfuel");
String betweenfuel=request.getParameter("betweenfuel");
String finalgps=request.getParameter("finalgps");
String finalfuel=request.getParameter("finalfuel");
String finalodo=request.getParameter("finalodo");
String odoavg=request.getParameter("odoavg");
String gpsavg=request.getParameter("gpsavg");
double firstodo1=0,lastodo1=0,firstgps1=0,lastgps1=0,firstfuel1=0,lastfuel1=0,betweenfuel1=0,finalgps1=0,finalfuel1=0,finalodo1=0;
DecimalFormat df = new DecimalFormat("#.##");
firstodo1=Double.parseDouble(firstodo);

NumberFormat nf = NumberFormat.getNumberInstance();
nf.setMaximumFractionDigits(2) ;

firstodo=nf.format(firstodo1);
//firstodo=df.format(firstodo1);
lastodo1=Double.parseDouble(lastodo);

lastodo=nf.format(lastodo1);
firstgps1=Double.parseDouble(firstgps);

firstgps=nf.format(firstgps1);
lastgps1=Double.parseDouble(lastgps);

lastgps=nf.format(lastgps1);
firstfuel1=Double.parseDouble(firstfuel);

firstfuel=nf.format(firstfuel1);
lastfuel1=Double.parseDouble(lastfuel);

lastfuel=nf.format(lastfuel1);
betweenfuel1=Double.parseDouble(betweenfuel);

betweenfuel=nf.format(betweenfuel1);
finalgps1=Double.parseDouble(finalgps);

finalgps=nf.format(finalgps1);
finalfuel1=Double.parseDouble(finalfuel);

finalfuel=nf.format(finalfuel1);
finalodo1=Double.parseDouble(finalodo);

finalodo=nf.format(finalodo1);



double infuel=0,fstfuel=0,lstfuel=0;
infuel=Double.parseDouble(betweenfuel);
fstfuel=Double.parseDouble(firstfuel);
lstfuel=Double.parseDouble(lastfuel);
double fuel=0,odoavg1=0,gpsavg1=0;
odoavg1=Double.parseDouble(odoavg);
gpsavg1=Double.parseDouble(gpsavg);
fuel=lstfuel+infuel;
System.out.println("vehno-->>"+vehcode);
System.out.println("vehregno-->>"+vehregnumber);
String odoavgdis="",gpsavgdis="",fuel1="";
DecimalFormat df1 = new DecimalFormat("#.##");
odoavgdis=df1.format(odoavg1);
gpsavgdis=df1.format(gpsavg1);
fuel1=df.format(fuel);
String exportFileName="Fuel_Full_Tank_Report.xls";
int j=1;
String datenew1=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdate));
String datenew2=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todate));

%>
	
		</td></tr>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font size="3">Fuel Full Tank Report for Vehicle <%=vehregnumber %> from <%=datenew1 %> to <%=datenew2 %></font></div>
				<div align="right">
				<%
				
				%>
				</div>
			</td>
			</tr>
			</table>
<%
			
%>
<form id="Total_os" name="Total_os" action="" method="post">

<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a></td>
			</tr>
		</table>

		<div id="mytable">
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th> <b> Sr. </b></th>
				<th> <b>Veh.</b></th>
				<th> <b>First topup</b><br>A</br></th>
				<th> <b>Last topup</b><br>B</br></th>
				
			
				<th> <b>Interim fuel fill</b><br>C</br></th>
				<th> <b>Fuel Consume</b><br>(A+B+C-A)<br></br></th>
				<th> <b>Odo KM</b><br>X</br></th>
				<th> <b>Odo Average</b><br>(X/fuel consume)</br></th>
				<th> <b>GPS KM</b><br>Y</br></th>
				<th> <b>GPS Average</b><br>(Y/fuel consume)</br></th>
				</tr>	 
	      	
			<% %>
			<tr>
				<td style="text-align: left"> 1</td>
				<td style="text-align: left"><%=vehregnumber %></td>
				<td style="text-align: right"><%=datenew1 %><br></br><br>Fuel Fill :<%=firstfuel %> lit. </br>
				                                            <br>Odo       :<%=firstodo %>       </br>
				                                            <br>GPS       :<%=firstgps %>       </br></td>
				<td style="text-align: right"><%=datenew2 %><br></br><br>Fuel Fill :<%=lastfuel %>   lit.</br>
				                                            <br>Odo       :<%=lastodo %>        </br>
				                                            <br>GPS       :<%=lastgps %>        </br></td>
				<td style="text-align: right"><%=betweenfuel %></td>
				<td style="text-align: right"><%=fuel1 %></td>
				<input type="hidden" id="datenew1" name="datenew1" value="<%=datenew1 %>"></input>
				<input type="hidden" id="firstodo" name="firstodo" value="<%=firstodo %>"></input>
				<input type="hidden" id="firstgps" name="firstgps" value="<%=firstgps %>"></input>
				<input type="hidden" id="datenew2" name="datenew2" value="<%=datenew2 %>"></input>
				<input type="hidden" id="lastodo" name="lastodo" value="<%=lastodo %>"></input>
				<input type="hidden" id="lastgps" name="lastgps" value="<%=lastgps %>"></input>
				<input type="hidden" id="finalodo" name="finalodo" value="<%=finalodo %>"></input>
				<input type="hidden" id="finalgps" name="finalgps" value="<%=finalgps %>"></input>
			
				<td >			
				<a href="#" onclick="javascript: poponclick()"><%=finalodo%></a>
				
				
				
		</td>
				
				<td style="text-align: right"><%=odoavgdis %></td>
				
				<td >			
				<a href="#" onclick="javascript: poponclick()"><%=finalgps%></a>
				
				
				
		</td>
				

				
				<td style="text-align: right"><%=gpsavgdis %></td>
			
			</tr>	
			
		</table>
		
<%}
catch(Exception e)
{
	e.printStackTrace();
} %>
</div></td></tr></table>
<script>document.getElementById("entryform").style.visibility="hidden";</script>
<script>document.getElementById("entryform1").style.visibility="hidden";</script>
</form>

</body>

</html>
        <%@ include file="footernew.jsp" %>
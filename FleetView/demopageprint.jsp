<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/erratic.css" rel="StyleSheet" type="text/css">


</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
          <table border="0" align="left" width="100%">
<tr>
<td>
<!-- unit logo comes here --->
<div align="left">
<img src="images/Transworld.jpeg"  border="0">
</div>
<!-- unit logo comes here --->
<div align="right">Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
</tr>
</table>
			<!-- header file -->
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			
			<table width="100%" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Report Heading Come Here</font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" id="table1" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			<th class="hed"> Heding</th>
			</tr>	
			<tr>
			<td> 1</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			</tr>	
				<tr>
			<td> 2 </td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			</tr>	
			<tr>
			<td> 3 </td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			</tr>	
			<tr>
			<td> 4 </td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			</tr>	
			<tr>
			<td> 5 </td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			<td> data4</td>
			</tr>	
			<tr>
			<td> 6 </td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			<td> data5</td>
			</tr>	
			<tr>
			<td> 7 </td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			<td> data6</td>
			</tr>	
			<tr>
			<td> 8 </td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			<td> data7</td>
			</tr>
			<tr>
			<td> 7 </td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			<td> data8</td>
			</tr>	
			<tr>
			<td> 8 </td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			<td> data9</td>
			</tr>	
			<tr>
			<td> 9 </td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			<td> data10</td>
			</tr>	
			<tr>
			<td> 10 </td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			<td> data11</td>
			</tr>	
			<tr>
			<td> 11 </td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			<td> data12</td>
			</tr>	
			<tr>
			<td> 12 </td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			<td> data13</td>
			</tr>	
			<tr>
			<td> 13 </td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			<td> data14</td>
			</tr>	
			<tr>
			<td> 14 </td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			<td> data15</td>
			</tr>	
			<tr>
			<td> 15 </td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			<td> data16</td>
			</tr>	
			</table>
			<!-- body part come here -->
				
			</td>
    <td class="fboxlowright">&nbsp;</td>
    
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
      <%@ include file="footernew.jsp" %>
    </body>
</html>
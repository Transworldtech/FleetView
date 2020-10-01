<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
</script>
<body>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Terms Of Use</b></font> </label></td></tr></tbody></table></div>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="2" color="black">
By clicking on this button, I/we understand and consent to all the terms and conditions set forth in the
detailed documents attached hereto. This website and all the data which may be accessed through this
website is property of Transworld technologies Ltd and is provided for information purpose only.
Unauthorized or improper use or access of this website, including the unauthorized or improper
modification, destruction or disclosure of any information or data contained herein, is expressly
prohibited. In case of any dispute, controversy or claim arises between the parties, the Company shall
appoint an arbitrator and the place of such arbitration shall be at Pune, and the decision of such arbitrator
shall be final and binding on both parties. Arbitration proceedings shall be conducted in accordance with
the provision of the Arbitration and conciliation Act 1996 and the rules made there under and the
proceedings shall be conducted in English.
</font> </label></td></tr></tbody></table></div>
<div align="left" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="2" color="black">1.</font><font size="3" color="black"><a href="#" onclick="javascript:window.open('http://myfleetview.com/FleetView/images/MutualCooperationNonDisclosureAgreementV7.pdf','','menubar=1,resizable=1,width=850,height=350,location=no');"> 
<font style="font-size: 0.6em;">Mutual Cooperation & NonDisclosure Agreement</font> </a></font> </label></td></tr></tbody></table></div>
<div align="left" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="2" color="black">2.</font><font size="3" color="black"><a href="#" onclick="javascript:window.open('http://myfleetview.com/FleetView/images/Transworld AVL Lease Rental n Service Agreement - Customers v5  21062016.pdf','','menubar=1,resizable=1,width=850,height=350,location=no');"><font style="font-size: 0.6em;">Transworld AVL Lease Rental n Service Agreement</font> </a></font> </label></td></tr></tbody></table></div>
<div align="left" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="2" color="black">3.</font><font size="3" color="black"><a href="#" onclick="javascript:window.open('http://myfleetview.com/FleetView/images/TW ASC V7 21062016.pdf','','menubar=1,resizable=1,width=850,height=350,location=no');"><font style="font-size: 0.6em;">TW ASC V7 21062016</font> </a></font> </label></td></tr></tbody></table></div>
<div align="left" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="2" color="black">4.</font><font size="3" color="black"><a href="#" onclick="javascript:window.open('http://myfleetview.com/FleetView/images/TW NON ASC V5 21062016.pdf','','menubar=1,resizable=1,width=850,height=350,location=no');"><font style="font-size: 0.6em;">TW NON ASC V5 21062016</font> </a></font> </label></td></tr></tbody></table></div>

</body>
</html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
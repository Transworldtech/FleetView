<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0037)http://www.unipune.ernet.in/news.html -->
<!-- saved from url=(0037)http://www.unipune.ernet.in/news.html --><HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<SCRIPT type=text/javascript>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" errorPage="" %>


/***********************************************
* IFRAME Scroller script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

//Specify speed of scroll. Larger=faster (ie: 5)
var scrollspeed=cache=1

//Specify intial delay before scroller starts scrolling (in miliseconds):
var initialdelay=500

function initializeScroller(){
dataobj=document.all? document.all.datacontainer : document.getElementById("datacontainer")
dataobj.style.top="5px"
setTimeout("getdataheight()", initialdelay)
}

function getdataheight(){
thelength=dataobj.offsetHeight
if (thelength==0)
setTimeout("getdataheight()",10)
else
scrollDiv()
}

function scrollDiv(){
dataobj.style.top=parseInt(dataobj.style.top)-scrollspeed+"px"
if (parseInt(dataobj.style.top)<thelength*(-1))
dataobj.style.top="5px"
setTimeout("scrollDiv()",40)
}

if (window.addEventListener)
window.addEventListener("load", initializeScroller, false)
else if (window.attachEvent)
window.attachEvent("onload", initializeScroller)
else
window.onload=initializeScroller

</SCRIPT>

<STYLE>.green {
	COLOR: #cf2754; TEXT-DECORATION: none
}
.green {
	COLOR: #cf2754; TEXT-DECORATION: none
}
</STYLE>

<META content="Microsoft FrontPage 4.0" name=GENERATOR><link rel="stylesheet" type="text/css" href="hyper.css">
</HEAD>
<BODY bgColor=#dfe4cb>
<DIV id=datacontainer onmouseover=scrollspeed=0 
style="left: 0; width: 273; position: absolute; top: 3; height: 334" 
onmouseout=scrollspeed=cache><!-- ADD YOUR SCROLLER CONTENT INSIDE HERE -->
<TABLE id=AutoNumber1 style="BORDER-COLLAPSE: collapse" borderColor=#111111 
height=129 cellSpacing=0 cellPadding=0 width=270 border=0>
  <TBODY>
<TR>
    <TD vAlign=top width=5 height=1></TD>
    <TD align=justify width=426 height=1>
   
         <p align="justify">
   
         <div align="center"><font color="maroon"> <b><i><u> T UPDATES </u></i></b> </font> </div>
         </p>

    </TD></TR>
  <%!
Connection con1;
%>

<%
try {

Driver MM_driverUser = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
con1 = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql1="";

sql1="select * from t_news";
rs1=stmt1.executeQuery(sql1);

while(rs1.next())
{ %>
  
  <TR>
    <TD vAlign=top width=5 height=1></TD>
    <TD align=justify width=426 height=1>
   
         <p align="justify">
   
         <ul> <li> <b><a href="<%=rs1.getString("WebAdd") %>" target="_parent"><font face="Verdana" size="2" color="#354422"> <%=rs1.getString("Headlines") %>&nbsp; </font></b><font face="Verdana" size="1" color="#FF0000">More </li>
         Info</font><font face="Verdana" size="1" color="#FF0000">&gt;&gt;&gt;</font></a>

         </ul></p>

    </TD></TR>
<% } %>

<TR>
    <TD vAlign=top width=5 height=1></TD>
    <TD align=justify width=426 height=1>
   
         <p align="justify">
   
         <div align="center"><font color="maroon"> <b><i><u> ADVERTISEMENTS </u></i></b> </font> </div>
         </p>

    </TD></TR>

<TR>
    <TD vAlign=top width=5 height=1></TD>
    <TD align=justify width=426 height=1>
   
         <p align="justify"> <font face="Verdana" size="2" color="#354422"> <b>Give boost to your business! Give Advertisement on our Web-Site <b></font>
   
         </p>

    </TD></TR>


  </TBODY></TABLE></DIV>

<P><FONT face=Verdana size=1></FONT>&nbsp;</P></BODY></HTML>

<%
} catch(Exception e) { out.println("Exception----->"+e); }

finally
{
  con1.close();
}
%>

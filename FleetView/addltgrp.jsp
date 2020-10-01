<%@ include file="headernew.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import=" java.text.*" import=" java.util.*"
	errorPage=""%>


<%!Connection conn, conn1;
	Statement st, st1, st2, st3, st4;
	String sql, sql1, sql2, sql3, sql4, username, userrole, olddate, Svehlist;
	int total, updated, dealy, disconnected, notactive, transid;
	String vid, vehno;%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title></title>

<style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background:}</style>
<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
<link rel="stylesheet" href="css/css.css" type="text/css"
	charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
	
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">	
<script src="sorttable.js" type="text/javascript"></script>
<style type="text/css">


</style>


<script language="javascript">

function removecity()
{

  try{
	 
	var e1= document.getElementsByName("chkbx");

 // alert(">>&&&>>$$>"+e1.length);
var i=1;


	  var s=0;
		for(var cnt1 =0;cnt1 < e1.length;cnt1++)
		{
             //alert("inside for loop");

            // alert(document.getElementById("ab"+i).value);
  			if((document.getElementById("ab"+i)).checked)
			{
		   // alert("checbx is been checked   ");

		    //alert("inside if loop");

		      
		     //  a=a+","+document.getElementById("ab"+i).value;
		      // v2=v2+","+document.getElementById("vhcd"+i).value;

		     //alert(">>v2 reg>>>**"+v2);

		     s++;
		     //alert(">>%%>>inside loop s>>>>"+s);

		     
			}

		i++;
		}

	//alert(">>%%>>>"+s);
	if(s=="0")
	{
	alert("Please select the checkbox for deletion of Vehicle ");
	return false;
		 
	 
	}

   var ch=confirm ("Do you want to  delete the selected vehicles ?");
   if(ch)
   {
	   //alert ("Woo Hoo! So am I.")
//return true;

		  
   }else{

	   //alert ("Woo Hoo! So am I.")
   return false;
	   
   }
	   


	

  }catch(e)
  {

alert(e);
	  
  }



	    //alert("hi>11111>>>>");
   // validate();
     
try{
var e= document.getElementsByName("chkbx");

var i=1;
var j=1;
var a="";
var b="";
var v1="",v2="";
 v1=document.getElementById("vh1").value;

 
 
//alert(">>>v1>>>"+v1);
//v1=v1.replace("<b> ","").replace("</b> ","");
//alert("hi>e.length>>>>"+e.length);
//alert("<<v1>>>>"+v1);
for(var cnt =0;cnt < e.length;cnt++)
{

	if((document.getElementById("ab"+i)).checked)
	{
     //alert("checbx is been checked   "+cnt);
      
       a=a+","+document.getElementById("ab"+i).value;
       v2=v2+","+document.getElementById("vhcd"+i).value;

     //alert(">>v2 reg>>>**"+v2);

	}

i++;	
}
//alert(">>selected v1 reg>>>**"+v1);
//alert(">>selected v2 >>>**"+v2);

          

}catch(e)
{
	alert(e);
}	
//alert(">>>count"+cnt);
var a=a;
//alert("@@@@"+a);

var v1=v1;
//alert("@@@@"+v1);
	
//document.repunitform.action="gpdelete.jsp?a="+a+"&v1="+v1;


//document.repunitform.submit();

window.location="gpdelete.jsp?a="+a+"&v1="+v1+"&v2="+v2;

//var queryString = "?a="+a+"&v1="+v1;;
 //ajaxRequest.open("GET", "gpdelete.jsp" + queryString, true);
 //ajaxRequest.send(null); 



}

function AJAXFunc1(j)
{
	
try{
	  var v1=document.getElementById("gpnm"+j).innerHTML;
  v1=v1.replace("<b> ","").replace("</b> ","");

}catch(e)
{
alert(e);
}

  var ajaxRequest;  // The variable that makes Ajax possible!

     try{
 	 	ajaxRequest = new XMLHttpRequest();
        }  
        catch (e)
        {
 	        try
                 {
 	             ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
 	        } 
                 catch (e)
                 {
 		    try
                     {
 		        ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
 		    } 
                     catch (e)
                     {
 	                   alert("Your browser broke!");
 			   return false;
 	            }
 	        }
          }
                
            ajaxRequest.onreadystatechange = function()
            {
     	       if(ajaxRequest.readyState == 4)
                {
                      var reslt=ajaxRequest.responseText;
					 
                      var mySplitResult = reslt.split("#");
                     
                     
                      
                      document.getElementById("tbvl").innerHTML=mySplitResult;
                     

					
                      document.repunitform.tbvl.value = mySplitResult9;
                     
                  		
 	       }
            }
  
           var queryString = "?gpnm=" +v1;
 	   ajaxRequest.open("GET", "Ajaxgpnm.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
}






function validate()
{


	//alert("in validate function")
	var e= document.getElementsByName("chkbx");

  var s=0;
	for(var cnt =0;cnt < e.length;cnt++)
	{

		if((document.getElementById("ab"+i)).checked)
		{
	    // alert("checbx is been checked   ");
	      
	     //  a=a+","+document.getElementById("ab"+i).value;
	      // v2=v2+","+document.getElementById("vhcd"+i).value;

	     //alert(">>v2 reg>>>**"+v2);

	     s++;

		}

	
	}

//alert(">>%%>>>"+s);
if(s=="0")
{
alert("Please select the checkbox for deletion of Vehicle ");
return false;
	 
 
}



	//var jrm=document.repunitform.jrm.value;
	//alert(jrm);
	
	 
}

function checkbox1()
{
    try{

       // alert("chkbx function>>>>");
	   var k= document.getElementsByName("chkbx");
	   var cnt=0;
	   var i=1;
	  // alert(">>>>>"+k.length);
   // var p=k.length;
     // alert(p);
      if(document.getElementById("fst").checked)
      {try{
     	 for( cnt=0;cnt<k.length;cnt++)
     	 {
     		 try{
         	// alert("><><><><>");
     		 document.getElementById("ab"+i).checked=true;
     		 
     		 }catch(e){

               alert(e);
     		 }
     		 i++;
     	 }
      }catch(e){
              alert(e);
          }
      
      }else
          
      {

     	 for( cnt=0;cnt<k.length;cnt++)
     	 {
     		 try{
         	// alert("><><><><>");
     			 
             	 document.getElementById("ab"+i).checked=false;
     		 
     		 }catch(e){

               alert(e);
     		 }
     		 i++;
     	 }

          
     	 
          
      }
      
    }catch(e){
        alert(e);
    }    
    
}







	</script>
</head>

<body id="main_body">
<div id="form_container1"  align="center"   style="margin-left: 300px;    width: 700px;height: auto; ">

<form name="repunitform" method="get" action="" onsubmit="">


<div width="100%" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;height:auto; ">
<table border="0" width="100%" align="center">
<tr align="center">
<td align="center">
<%
	try {
		
		
		System.out.println("=====1111=========");
		
		vid = request.getParameter("vid");
		System.out.println("=====vid========="+vid);
	
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_CustomerComplaints";
	String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";
	
	
	String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date());	
	 String instdate="",warranty="",instdate1="";
	 
	
	System.out.println("Creating Connection");
	Class.forName(MM_dbConn_DRIVER);
   // conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    System.out.println(">>>2222aaaaa ");
   conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
   
    System.out.println(">>>2222bbbb ");
    st=conn1.createStatement();
    System.out.println(">>>2222cccc ");
	st1=conn1.createStatement();
	
	   System.out.println(">>>2222ddd ");
    st2=conn1.createStatement();
    st3=conn1.createStatement();
    st4=conn1.createStatement();
    Statement stmt2 = conn1.createStatement();
    Statement stmt7 = conn1.createStatement();
    Statement stmt8 = conn1.createStatement();
    System.out.println(">>>2222 ");
		
		
		
		
		

		String userrole = (String)session.getAttribute("mainuser");
		
		String typeval = (String)session.getAttribute("TYPEVALUEUSER");
		
		
		 System.out.println(">>>typeval  >>>>"+typeval);

		 System.out.println(">>>2222   11");
		String email = "", unid = "", status = "", owner = "",Instruction="";

		java.util.Date dte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(dte);
		
		
		String  tid="";

		String cat="";
		


	String gpnm=""; 
	int  ak=0;

		
		
		
		
		

		//System.out.println(">>>2222 FINAL warranty 11"+warranty);
		
		String done = request.getParameter("updt");
		System.out.println(">>>2222 done1"+done);

 if(done!=null)	
 {
%>
<script type="text/javascript">

//alert("Successfully Deleted");

</script>



<%
 }
%>			




<br></br>
<%
if(done!=null)
{
%>	
	
<table border="0" width="600px" bgcolor="" align="center" class="sortableT" >
	<tr bgcolor=""><td align="center"><font color="red" style="width:5px "  ><blink> Vehicle Deleted  Successfully</blink> </font></td></tr>
</table>	
	
<%}

%>

<table border="0px" width="500px" bgcolor="" align="center">
	<tr bgcolor=""><td align="center"><font color="#2A0A12" size="3"><h1 align="center">Add /Delete Group</h1></font></td></tr>
</table>
<table border="0px" width="750px" bgcolor="" align="center">
	<tr bgcolor="">
	<td align="center">
	
	<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity();" id="img1" align="top" ">&nbsp;&nbsp;&nbsp;<font size="3">Delete Selected </font>
	

	</td>	
</tr>
</table>
<table border="1px solid #839E99" cellspacing='0' cellpadding='0' width="450px"  align="center">
<tr>
<td align="center"><font size="2"><b>Sr</b></font></td>
<td align="center"><b><font size="2">Group Name </font> </b> </td>

<td align="center"><b><font size="2"> Count</font> </b> </td>
<td align="center"><b><font size="2"> Add Group</font>  </b></td>
</tr>
<tr>
<%
 int j=0;
sql = "SELECT gpname, count( * ) AS ak FROM db_gps.t_group WHERE vehregno = '"+typeval+"' GROUP BY gpname ";

ResultSet rst = st2.executeQuery(sql);
 System.out.println(">>>2222  sql 11"+sql);
while (rst.next()) {
	
	gpnm =rst.getString("GPName");
	ak=rst.getInt("ak");
	
%>

<td id ="sgn<%=j %>"><img src="images/plus.jpg" width="15px" height="13px" id="img<%=j %>"  onclick="AJAXFunc1(<%=j %>);">  
</td>
<td><b id ="gpnm<%=j %>"><%=gpnm %></b> </td>
<td id ="cnt<%=j %>" align="center"><b> <%=ak %> </b> </td>
<td><b><a href="addgrp.jsp?grpname=<%=gpnm %>">Add </a> </b>

 
</td>



</tr>





<%
	j++;
	
}
%>





</table>
<div class="form_container1"  align="center"  id=tbvl>




</div>



<table>
<tr>




</tr>


</table>
</td>
</tr>
</table>

<br></br>

</div>




</form>
</div>

<%
System.out.println(">>>sql!!!ENDDDD!!<<<");
	} catch (Exception e) {
		out.print("Exception --->" + e);
		e.printStackTrace();
	} finally {
		//conn.close();
		conn1.close();
	}
%> <!-- code end here --->

</body>
</html>
<%@ include file="footernew.jsp"%>
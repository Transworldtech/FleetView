<%@page import="org.springframework.mock.staticmock.AbstractMethodMockingControl.Expectations"%>
<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%@ page language="java" import="java.sql.*" import="java.util.*"
import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Vehicle Master Report Details</title>

</head>
<body id="main_body" >
<%! Connection conn=null;%>
<%! Connection conn1=null;%>
<%! Connection conn2=null;%>
<%! Connection conn3=null;%>
<%! Connection conn4=null;
Connection conn5=null;
%>

<script>

function deletexpence(id)
{
	alert("rid:-"+id);
		 
		 try{//alert("in delete function"+routeid+geofenceid+geofencename+Km+Balance);
		 
			 var agree=confirm("Do You Want to Delete this Entry??");
//			  	alert("in delete function");
			 	if(agree)
			     {
			 		
			            // alert("before delete");
			            window.location="Deletepto.jsp?&rid="+id;
			            
			     }

			 }catch(e)
			 {
				 alert(e);
			 }
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

<%	
String exportFileName="ControlReport.xls";
String name="",bb="",cc="";

String VehId=request.getParameter("VehId");
System.out.println("VehIDDDDDDDD"+VehId);
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehRegNo"+VehRegNo);

	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection();
	conn2 = fleetview.ReturnConnection();
	conn3 = fleetview.ReturnConnection();
	conn4 = fleetview.ReturnConnection();
	conn5 = fleetview.ReturnConnection();
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null;
	String sql=null;
	ResultSet rst=null,rst1=null,rst2=null,rst3=null,rst4=null,rsveh=null;
	st=conn.createStatement();
	st1=conn1.createStatement();
	st2=conn2.createStatement();
	st3=conn3.createStatement();
	st4=conn4.createStatement();
	st5=conn5.createStatement();

	String FieldName="",finalcolname="",finalname="";
	String resultstore="";
	int count=0;
	
	  StringBuilder sb=new StringBuilder();
	  String[] colname=new String[500];
	  String[] fieldname=new String[500];
	  
	  
	  String user=session.getAttribute("mainuser").toString();
	  String transporter=session.getAttribute("usertypevalue").toString();

	  int no=0;
	  int r=2;
	  String Rname="";
%>




<form id="Total_os" name="Total_os" action="" method="post">



		
		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable1', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a><%=fleetview.PrintDate() %></td>
			</tr>
		</table>

		<div id="mytable">
	

	
		<h1 align="center"><font size="3" >Control System Custom Field Details <%=VehRegNo %></font></h1>
		<br>
		

<h2 align="center">

<a href="Dcontrol.jsp?VehId=<%=VehId%>&VehRegNo=<%=VehRegNo%>"><font bgcolour="blue" size="2">Add Custom Field</font></a><br>
<a href="Daddcontrol.jsp?VehId=<%=VehId%>&VehRegNo=<%=VehRegNo%>"><font face="Arial" size="2">Fill Information</font></a>


</h2>









	 <%
	 int Countforfield=0;
	
	  rst = st4.executeQuery("Select * from db_gps.t_controlsystemforcustomfieldmaster where Owner='"+transporter+"' ");
	 while(rst.next())
	 {
		 
		
	 
	 	 
		 bb=rst.getString("field");
			FieldName+=bb+","; 
	Countforfield++;
	System.out.println("COUNTFORFIELD:-"+Countforfield);
	
	
	 
// 	 System.out.println("FieldName:-"+FieldName); 
	 }
	if(Countforfield==0)
	{
		 out.println("<script type='text/javascript'>alert('Please Add Field First');");
		
	}
	 
	else{
		FieldName=FieldName.substring(0, FieldName.length()-1);
	}
	 
	System.out.println("FieldName:-"+FieldName);
	 
	 
	 %>
	

 	 <% 
 	 
 	 int Count1=1;
 	  rst3 = st3.executeQuery("Select * from   db_gps.t_controlsystemforcustomfieldmaster   where Owner='"+transporter+"'");
 	 while(rst3.next())
 	 { 
		 
 		 
 	 
 		 cc=rst3.getString("field"); 
 		finalname+=cc+"  "; 
 		
  		no++; 
 		 
 	 }
	 	 System.out.println("NUMBER"+no); 
	 	 	
	 %> 
	




<%

if(Countforfield==0)
{

	
}
else{
	rst1=st5.executeQuery("Select id,"+FieldName+" from  db_gps.t_controlsystemforcustomfielddata   where VehId='"+VehId+"' and  Owner='"+transporter+"' ");

	ResultSetMetaData rsmd = rst1.getMetaData();
	System.out.println("rst1:-"+rst1);

	int Count = rsmd.getColumnCount();
%>






<%

%>




<div id="mytable1">
<table width="100px" align="center"  class="sortable" border="1"  >
<div style="display: none;">
<h1 align="center"><font size="3" ><b>Control System Custom Field Details <%=VehRegNo %></b></font></h1>
</div>
<tr >


<th >

<div align="center">
<%  
	
  %>
  	<font>Delete</font>
  	<%    
	
  	%>  
	</div>

</th>



	


<%
for( r = 2; r<=no+1;r++)
{ %>
  
 <th>
    <div align="center">
    
  <%= rsmd.getColumnName(r)%>
   
    </div>
   </th>
   
    
<% 
System.out.println("column name:->"+rsmd.getColumnName(r));
   }

%>     
          
</tr>

<% 
while(rst1.next())
{
	String abwc=rst1.getString("id");
	Count1++;
	System.out.println("Count1-:"+Count1);
	%>
	
      <tr>
     
     
      <td>
 	<% 
	
 	%> 
  	<div align="center"><a href="Deletecontrol.jsp?id=<%=abwc%>&VehId=<%=VehId%>&VehRegNo=<%=VehRegNo%>"><font color="Blue" size="2">Delete</font></a></div>
   <% 
	
 	%>
	

	</td>
     
     
     
      <%
      for( r = 2; r<=no+1;r++)
         { %>
         
 <td>
            <div align="left">
               <%= rst1.getString(r)%>
            </div>
        </td>
          
   
     <% 
     }
     %>                   
     </tr>
 <% 

}
}
%>

</table>
</div>
</th>
<%

%>
				

			










<%
 

%>
<br>
<br>
<br>




<br>
<br>

<tr>

</tr>

</form>





</div>
	
	
	
	
	<!-- footer start here -->
				
  

</body>

				

</html>
</jsp:useBean>

<html>

       <table border="0" width="100%" align="center" style="padding-bottom: 56px" >
<tr><td  bgcolor="#0B2161" >
<ui><li><center><font color="white" >Copyright &copy; 2008-2016 by Transworld Technologies Ltd. All Rights Reserved.</font></center></li></ui>
</td></tr>
</table>
</body>
</html>
<%--  <%@ include file="footernew.jsp"%> --%>
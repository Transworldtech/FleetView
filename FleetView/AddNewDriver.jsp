<%-- 
    Document   : addDriver
    Created on : Apr 15, 2009, 11:20:32 AM
    Author     : yogesh
--%>


<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%@ include file="header.jsp" %>

<script language="javascript">

function validate(){
   
    
    var drvId = document.adddriver.drvId.value;
     if(drvId.length=="")
	{
		alert("Please enter driver Id.");
		return false;
	}
        
      var name = document.adddriver.drvName.value;
    if(name=="")
	{
		alert("Please enter driver name.");
		return false;
	}
         var transName = document.adddriver.transpName.value;
    if(transName=="Select")
	{
		alert("Please select transporter name.");
		return false;
	}
    
}

</script>

<%!
Connection con1, con2;
String driveridjsp="";

%>

 
<form name="adddriver" method="post" action="addDriverInDB.jsp" onSubmit="return validate();" >

<% 
try {

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con2.createStatement();
ResultSet rs2=null;
String sql1="";
String msg = (String)request.getParameter("msg");
//out.println(msg);
String drvnm = (String)request.getParameter("drvnm");
String transpName = request.getParameter("transporter");
//System.out.println("trans====>"+transpName);
ArrayList alTransporterName = new ArrayList();
int i=0;
String fromPage = (String) request.getParameter("frPg");
        %>        <input type="hidden" id="transpName" name="transpName" value="<%=transpName %>" />        <%
        
sql1 = "select distinct vehregno from t_group where  gpname = 'Castrol' order by vehregno desc;  ";
rs2 = stmt1.executeQuery(sql1);
while(rs2.next()){
      
      alTransporterName.add(i, rs2.getString("vehregno"));
}

	String inserted=request.getParameter("inserted");
	if(msg==null)
	{
	}	
	else
	{ %>
		<table border="0" width="100%">
                    <%
                    if(msg.equalsIgnoreCase("F")){ %>
                    <tr>
				<td align="center"> <font color="maroon"> Driver Id already exists. </font> 
                                </td>
			</tr>
                          <tr>
				<td align="center"> <font color="maroon"> Data not saved. </font> 
                                </td>
			</tr>
                    
                    
                    <% }else{ %>
                    
                    <tr>
				<td align="center"> <font color="maroon"> Successfully Saved</font> 
                                </td>
			</tr>
                    
                    
                    <%}
                    
                    %>
			
 		</table>
<%	}
%>	
		    
		<table border="0" align="center" class="sortable_entry" >
             <tr>
				<td colspan="2"><div align="center"><font size="3"><b>Add New Driver</b></font></div></td>
			</tr>             
            <tr>
				<td> <b>Driver Id</b> </td>
                                <td>  <input type="text" id="drvId" name="drvId" value="" class="formElement" size="28" /> </td>
			</tr>
			<tr>
				<td><b> Driver Name </b></td>
                                <td>  <input type="text" id="drvName" name="drvName" value="" class="formElement" size="28" /> </td>
			</tr>
      
                <tr>
				<td colspan="2" ><div align="center"> <input type="submit" value="Submit" name="submit" class="formElement" /></div> </td>
                               
			</tr>
                    </table>    
	

<%

} catch(Exception e) { }
finally
{
	try{
		con1.close();
		con2.close();
	}
	catch(Exception e)
	{
		
	}

}
%>





</form>
</body>
</html>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>

<%@ include file="footernew.jsp" %>

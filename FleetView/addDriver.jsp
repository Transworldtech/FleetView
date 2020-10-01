<%-- 
    Document   : addDriver
    Created on : Apr 15, 2009, 11:20:32 AM
    Author     : yogesh
    Last Modified On:-Oct 19,2010
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
Connection con1;
String driveridjsp="";

%>

 
<form name="adddriver" method="post" action="addDriverDb.jsp" onSubmit="return validate();" >

<% 
try {

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs2=null;
String sql1="";
String msg = (String)request.getParameter("msg");
String drvnm = (String)request.getParameter("drvnm");
String transpName = "";
ArrayList alTransporterName = new ArrayList();
int i=0;
String fromPage = (String) request.getParameter("frPg");
        %>        <input type="hidden" id="fromPage" name="fromPage" value="<%=fromPage %>" />        <%
        
sql1 = "select distinct vehregno from t_group where  gpname = 'Castrol' order by vehregno desc;  ";
rs2 = stmt1.executeQuery(sql1);
while(rs2.next()){
      
      alTransporterName.add(i, rs2.getString("vehregno"));
}

%>

	<table border="2" bgcolor="white" width="100%"  >
	   <tr>
		<td>
		    <table border="0" width="100%">
                        <tr>
                            <tr><td colspan="6">
                                    <div align="left">
                                            <a href="javascript: history.go(-1)">Back</a>
                                    </div>
                        </tr>
			<tr>
				<td> <div align="center"> <font color="maroon" size="2"> <B> Add new driver. </B> </font> </div> </td>
			</tr>
		    </table>	

<%
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
		    
		<table border="2" width="25%" align="center" >
                         <tr>
				<td align="center"> Driver Id </td>
                                <td>  <input type="text" id="drvId" name="drvId" value="" class="formElement" size="28" /> </td>
			</tr>
			<tr>
				<td align="center"> Driver Name </td>
                                <td>  <input type="text" id="drvName" name="drvName" value="" class="formElement" size="28" /> </td>
			</tr>
                         
                        <tr>
				<td align="center"> Transporter Name </td>
                                <!--
                                <td>  <input type="text" id="transpName" name="transpName" value="" class="formElement" /> </td>
                                -->
                       
                        
                       <td> <select name="transpName" id="transpName" class="formElement" >
                                    <option>Select</option>
                                    <%
                                    for(i=0; i<alTransporterName.size(); i++){
                                    %>
                                    <option><%= alTransporterName.get(i) %></option>
                                    <%}%>
                            </select></td>
                        </tr> 
 		</table>
            <table border="1" width="25%" align="center" >
                <tr>
				<td align="center" colspan="1" > <input type="submit" value="Submit" name="submit" class="formElement" /> </td>
                               
			</tr>
                    </table>    
		</td>
	     </tr>
	  </table>	

<%

} catch(Exception e) { }
finally
{
con1.close();
}
%>


<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>

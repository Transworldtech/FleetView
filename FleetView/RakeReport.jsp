<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%

System.out.println("in the select user .jsp page at start ");
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<script type="text/javascript" src="js/tblscript.js"></script>
<script type="text/javascript">


</script>

<%
Connection conn1 = null;

Statement st = null,st1=null,st2=null,st3=null,st4=null;

try{
	String location="";
	String prevDayDate = null;
	String repDate = null;
	String ownerName = null;

	int distanceDifference = 0;

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();
	st1 = conn1.createStatement();
	st2 = conn1.createStatement();
	st3 = conn1.createStatement();
	st4 = conn1.createStatement();
}catch(Exception e){
	e.printStackTrace();
}
%>


<%String id=""; %>
<form name="data" method="post" action="" >

<input type="hidden" name="id" value="<%=id %>">
<br>
<div align="center"><b>Rake Report</b></div>
<br></br>
	<div style="margin-top:0.2%;margin-left: 30%; ">
	<table> 
	<tr>
	
	<td >&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;<b>Enter Rake Id :</b></td>
	<td><input type="text" name="rakeid" id="rakeid" style="width:130px; border-radius:0px;"  value="" " /> 
	&nbsp;&nbsp;&nbsp;
	
</td>

<td>
	<input type="submit" name="submit" id="submit" style="border: outset;" value="Submit" onclick="return getfollowup();" />
	</td>
	</tr>
</table>

</div>
<div id="mylink" style="margin-left: 50%; margin-top: 2%; align=right">
<a href="RakeDelayReport.jsp">View Delay Report</a>
</div>
<br><br>
<div id="mytable" style="margin-left: 33%; margin-top: -2%;"> 
<%String rakeid123=request.getParameter("rakeid"); 
%>
 		<% 	if(rakeid123==null)
{ %>
	<b>Rake Report For:</b>
<% }
else{ %>
	<b>Rake Report For:<%=rakeid123%></b>
<% } %>
 			
			<table border="1" class="sortable" style="align:center; font:normal 13px Arial,Helvtica,sans-serif; width : 40%;" >
			
			<tr>
				<th>Sr.</th>
				<th> Stages </th>
				<th> ContainerId</th>
			</tr>
			
			<%
			String rakeid=request.getParameter("rakeid");
			System.out.println("rakeid is->"+rakeid);	
			String Stage="";
			int noofrakeid=0;
			int i=0;
			String usertypevalue=session.getAttribute("usertypevalue").toString();
			System.out.println("usertypevalue:-"+usertypevalue);
			
			String sql="select * from t_abgstages";
			ResultSet rsst = st3.executeQuery(sql);
			while(rsst.next()){
				String labels=rsst.getString("stages");
				noofrakeid=0;
			
			String sql12 = "select count(*) as noofrakeid,Stage from t_serverside where  DO='"+rakeid+"' and Stage='"+labels+"' and transporter='"+usertypevalue+"' group by DO";
			System.out.println("*******"+sql12);
	        ResultSet rsregno12 = st2.executeQuery(sql12);
			if(rsregno12.next())
			{
				 
				 noofrakeid=rsregno12.getInt("noofrakeid");
				 Stage=rsregno12.getString("Stage");
				 //Stage="ICD Agent"+"LSP"+"Transit to Plant"+"Plant"+"Transit to Port"+"Port";
				%> 
				 
<% 				
	      }	
			i=i+1;	%>
			<tr>
					<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=i%></td>
					<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><a href="StagesRake.jsp?stage=<%=labels%>&noofrakeid=<%=noofrakeid%>"><%=labels%></a></td>
					
					<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=noofrakeid%></td>
					<%-- <td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;width: 190px;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime))%></td> --%>
					
				</tr>
			<% 
			
			}
%>	
		</table>	
</div>

</form>

</html>

</jsp:useBean>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<%@ include file="footernew.jsp" %>

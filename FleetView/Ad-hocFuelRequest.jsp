<%@ include file="headernew.jsp"%>


<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"	scope="page"></jsp:useBean>
<%! public static Connection con1; %>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(MM_dbConn_DRIVER);
	
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
%>
<table width ="100%" border="0">
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
	<!-- <tr> -->
	
	        <tr align="center">
				<td>
		<font size="3" color="red" face="Arial">
		
			Work is on progress
			</font>
			</td>
		</tr>
	

		
		
		
		</tr></div>
		</table>
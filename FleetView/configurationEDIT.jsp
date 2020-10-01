
<%@ include file="headernew.jsp"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
%>
	 

	 

	<%Connection con1=null;%>

	<%
 String location="",locationCode="",transporter="";
	try {
			Class.forName(MM_dbConn_DRIVER);
			con1 = fleetview.ReturnConnection();
			Statement st1 = con1.createStatement();
			Statement st2 = con1.createStatement();

			String user = session.getAttribute("usertypevalue").toString();
			String usertype = session.getAttribute("TypeofUser").toString();

			if(usertype.equalsIgnoreCase("SUBUSER"))
			{
				location=session.getAttribute("Location").toString();
				locationCode=session.getAttribute("LocationCode").toString();
			}
			System.out.println(request.getParameter("editName"));
			String sql="select * from t_vehicledetails limit 1";
			ResultSet rs=st1.executeQuery(sql);
			if(rs.next()){
%>

	



	<div id="editConfiguration" style="visibility: hidden;">
	<form name="configurationEdit" method="get"
		action="configurationinsert.jsp?action=edit"
		onSubmit="return validate();">


			<table border="0" width="30%" align="center">
			
			
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"><b> Current Name:(overwrite to edit)
					  </b></font></td>
					<td><div id="EDITusername"><input type="text" name="EDITuseranme" value='<%=rs.getString(1) %>'></input>
					 </div></td>
 
				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>E-mail id :</b> <font
						color="red">* </font></font></td>
					<td><div id="EDITemail"><input type="text" name="EDITemail" value='<%=rs.getString(2) %>'></input></div></td>

				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Mobile no :</b> <font
						color="red">* </font></font></td>
					<td><div id="EDITmobilenumber"><input type="text" name="EDITmobilenumber" value='<%=rs.getString(2) %>'></input></div></td>

				</tr>
 

				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Category :</b> <font
						color="red">* </font></font></td>
					<td><select name="EDITcategory">
						<option value="Select">Select</option>
						<option value="Select">Category :</option>
					</select></td>
				</tr>

				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Extra E-mails
					:</b> <font color="red"><br>
					(Please Add comma separated Addresses) </font></font></td>
					<td><div id="EditExtraEmails">
							<input type="text" name="" value='<%=rs.getString(4) %>'></input>
					</div></td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan="2" align="center"><input type="submit"
						name="Submit" value="Submit" onclick="return confirmSubmit()" />
					</td>
				</tr>


			</table>

 
	</form>
	</div>
	


	

	

	<%
			}
	} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 con1.close();  
			 
			try{ fleetview.closeConnection(); }
			catch(Exception e)
			{ }
		}
		
%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>
</body>
</html>

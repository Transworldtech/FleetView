
<%@ include file="headernew.jsp"%>

<body>

<form name="addgrpform" action="insertgroup.jsp" method="post"><br>
<%
try
{	
	 String OwnerName=request.getParameter("owner");
	 String[] vehcles=request.getParameterValues("vehcles");
	 String gadd=request.getParameter("gadd");
	 int i=vehcles.length;
	 //out.println("i hope it will be correct--->"+i);
	%>
<table border="0" width="50%" align="center">
	<tr>
		<td bgcolor="#f5f5f5" colspan="2" align="center"><font color="maroon" size="2"><b>Confirm Group</b></font></td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon"> Owner Name: </font></td>
		<td bgcolor="#f5f5f5"><b><%=OwnerName %></b></td>


	</tr>

	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon">Vehicles : </font></td>
		<td bgcolor="#f5f5f5"><b>
		<%
		for(int j=0;j<i;j++){
		%>
		
		<%=vehcles[j] %>,
		<%
		}
		String vehiclesnos="";
		for(int j=0;j<i;j++){
			vehiclesnos=vehiclesnos+","+vehcles[j];
			}
		%>
		</b></td>


	</tr>

	<tr>
		<td bgcolor="#f5f5f5"><font color="maroon">Groups : </font></td>
		<td bgcolor="#f5f5f5"><b><%=gadd %></b> <input type="hidden" name="owner1"
			value="<%=OwnerName%>"></input> <input type="hidden" name="vehcles1"
			value="<%=vehiclesnos%>"></input> <input type="hidden" name="gadd1"
			value="<%=gadd%>"></input></td>


	</tr>


	<tr>
		<td colspan="2" align="center"  bgcolor="#f5f5f5"><input type="submit" name="Submit"
			value="Submit"><input type="button" name="Cancel"
			value="Cancel" onclick="history.back();"></td>
	</tr>
</table>

</form>

<%
}
catch(Exception e)
{
	out.print("Exception --->"+e);
}

%>
</body>
<%@ include file="footernew.jsp" %>
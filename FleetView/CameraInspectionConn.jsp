<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%!Connection conn = null;
   Statement st = null;
   Statement st1 = null;
%>
<%
System.out.println("==================conn===============");
String vehcode = request.getParameter("vehcode");
String vehregno = request.getParameter("vehregno");
String camID = request.getParameter("cam_id");
String protect_cover_id = request.getParameter("protect_cover_id");
String sd_card_present = request.getParameter("sdID");
String sd_id = request.getParameter("sd_id");
String transporter = request.getParameter("transporter");
String entBy = session.getAttribute("user").toString();

System.out.println("The vehicle code is :"+vehcode);
System.out.println("The vehregno  is :"+vehregno);
System.out.println("The camID  is :"+camID);
System.out.println("The protect_cover_id  is :"+protect_cover_id);
System.out.println("The sd_card_present  is :"+sd_card_present);
System.out.println("The sd_id  is :"+sd_id);
System.out.println("The transporter  is :"+transporter);
System.out.println("The entBy  is :"+entBy);

if(sd_id=="" || sd_id.equals("")){
	sd_id = "-";
}

Class.forName("org.gjt.mm.mysql.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
st = conn.createStatement();
st1 = conn.createStatement();
%>

<%
String username = "";
String sql1 = "SELECT FullName FROM t_security where Username='"+ entBy +"'";
ResultSet rs1 = st1.executeQuery(sql1);
if(rs1.next())
{
    username = rs1.getString("FullName");
}
System.out.println("The username   is :"+username);

String sql = "select Vehiclecode,PeripheralSrNo from db_gps.t_vehcileperipheral where Vehiclecode='"+vehcode+"' and PeripheralSrNo='"+camID+"'";
ResultSet rs = st.executeQuery(sql);
System.out.println("The sql  is :"+sql);
if(rs.next())
{	
	System.out.println("in if");
		
	%>
	<script type="text/javascript">
	
	confirmSubmit('<%=camID%>','<%=vehregno%>','<%=vehcode%>','<%=transporter%>','<%=camID%>','<%=protect_cover_id%>','<%=sd_card_present%>','<%=sd_id%>','<%=username%>');
	function confirmSubmit(camID,vehregno,vehcode,transporter,camID,protect_cover_id,sd_card_present,sd_id,username)
	{		
			var agree=confirm("The camera ID "+camID+" already exist against vehicle "+vehregno+" Do you still want to proceed?");
			if (agree)
			{
				//alert("if");
				//insert data into table
				window.location = "CameraInspectionForm1.jsp?vehcode="+vehcode+"&vehregno="+vehregno+"&transporter="+transporter+"&camID="+camID+"&protect_cover_id="+protect_cover_id+"&sd_card_present="+sd_card_present+"&sd_id="+sd_id+"&user="+username+"&Msg=update";

				return true ;
			}
			else
			{
				//alert("else");
				window.location="CameraInspectionForm.jsp?vehcode="+vehcode+"";
				return true ;
			}
	}//end of function
	</script>
	<%
	
}else{
	//insert the data here into table
	System.out.println("in else");
	response.sendRedirect("CameraInspectionForm1.jsp?vehcode="+vehcode+"&vehregno="+vehregno+"&transporter="+transporter+"&camID="+camID+"&protect_cover_id="+protect_cover_id+"&sd_card_present="+sd_card_present+"&sd_id="+sd_id+"&user="+username+"&user="+username+"&Msg=insert");
}
%>
</body>
</html>
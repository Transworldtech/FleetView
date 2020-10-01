<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%-- <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%> --%>
   <%@ page import="java.sql.*" %>

  	<%-- <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%> --%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {
	//out.println("here********************************************************************");
	String owner=session.getAttribute("usertypevalue").toString();
	//out.println("here"+owner);
	String user=session.getAttribute("mainuser").toString();
	//out.println("here"+user);
	String GPName=request.getParameter("GPName");
	//String stdate=request.getParameter("stdate");
	//out.println("here"+stdate);
	String location123=request.getParameter("location123");
	String vehcode=request.getParameter("vehcode");
	//out.println("here"+fuelplan);
	String totfuel=request.getParameter("totfuel");
	Double totalfuelqty=Double.parseDouble(totfuel);
	//out.println("here"+StartCode);
	//String EndCode=request.getParameter("EndPlace");
	//out.println("EndCode"+EndCode);
	
	//String Totaldistance=request.getParameter("Kmval");
	//double Totaldistancem=Double.parseDouble(Totaldistance);
	//System.out.println("fulmaster**Totaldistance***Totaldistancem********************************************"+Totaldistancem);
	//System.out.println("fulmaster**Totaldistance***********************************************"+Totaldistance);
	//double que=Double.parseDouble(Quantity);
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String insertdate = fmt.format(new java.util.Date());
		//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String amount[];
String result="",Fuel="";
Double resltbal=0.0;
Double fuelrate=0.0,deffuelrate,totreslt=0.0;
//out.println("location123:-"+location123);
amount=location123.split(",");
Double totinp=0.0;
//out.println("amount:-"+amount.length);

/////////////////////////Default fuel rate ...............//////////////////////////////////
	

String fueltype="select Fuel from db_gps.t_VehMst where VehId='"+vehcode+"' ";
//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
//System.out.println("re=codr:--********************************"+fueltype);
PreparedStatement ps4=con1.prepareStatement(fueltype);
ResultSet rs4=ps4.executeQuery();
if(rs4.next())
{
	Fuel=rs4.getString("Fuel");

}

if(Fuel.equals("-") || Fuel.equalsIgnoreCase("-"))
{
	
	String record="select rate from db_gps.t_Defaultfuelratemaster where fuel='"+Fuel+"' and transporter='"+GPName+"' order by UpdatedDate desc limit 1";
	//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
	System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps2=con1.prepareStatement(record);
	ResultSet rs2=ps2.executeQuery();
	if(rs2.next())
	{
	fuelrate=rs2.getDouble("rate");
	//System.out.println("fuelrate1:--********************************"+fuelrate);

	if(fuelrate.equals("-") ){
	String record1="select rate from db_gps.t_Defaultfuelratemaster where fuel='"+Fuel+"' and transporter='Default' ";
	//System.out.println("re=codr:--********************************"+record1);
	PreparedStatement ps3=con1.prepareStatement(record1);
	ResultSet rs3=ps3.executeQuery();
	if(rs3.next()){
	fuelrate=rs3.getDouble("rate");
	//System.out.println("fuelrate3:--********************************"+fuelrate);
	}

	}
	}

}else{
	
	String record="select rate from db_gps.t_Defaultfuelratemaster where fuel='Diesel' and transporter='"+GPName+"' order by UpdatedDate desc limit 1";
	//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
	System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps2=con1.prepareStatement(record);
	ResultSet rs2=ps2.executeQuery();
	if(rs2.next())
	{
	fuelrate=rs2.getDouble("rate");
	//System.out.println("fuelrate1:--********************************"+fuelrate);

	if(fuelrate.equals("-") ){
	String record1="select rate from db_gps.t_Defaultfuelratemaster where fuel='Diesel' and transporter='Default' ";
	//System.out.println("re=codr:--********************************"+record1);
	PreparedStatement ps3=con1.prepareStatement(record1);
	ResultSet rs3=ps3.executeQuery();
	if(rs3.next()){
	fuelrate=rs3.getDouble("rate");
	//System.out.println("fuelrate3:--********************************"+fuelrate);
	}

	}
	}

}// end of else


/* String record="select fuelrate from db_gps.t_defaultvals where OwnerName='"+GPName+"' ";
	//System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps=con1.prepareStatement(record);
	ResultSet rs=ps.executeQuery();
	if(rs.next())
	{
		fuelrate=rs.getDouble("fuelrate");
		//System.out.println("fuelrate1:--********************************"+fuelrate);
		
		if(fuelrate.equals("0.0") || fuelrate==0.0){
			String record1="select fuelrate from db_gps.t_defaultvals where OwnerName='Default' ";
			//System.out.println("re=codr:--********************************"+record1);
			PreparedStatement ps1=con1.prepareStatement(record1);
			ResultSet rs1=ps1.executeQuery();
	        if(rs1.next()){
	        	fuelrate=rs1.getDouble("fuelrate");
	        	//System.out.println("fuelrate3:--********************************"+fuelrate);
	        }
       			
		}
	}
 */
	

for(int i=0;i<amount.length;i++)
 {
	//totinp+=Double.parseDouble(amount[i]);
	
	//result+=Double.parseDouble(amount[i])*fuelrate+"#";
	result+=(Math.round(Double.parseDouble(amount[i]) * 100.0) / 100.0)*fuelrate+"#";
	//totreslt+=Double.parseDouble(result);
	resltbal=resltbal+Double.parseDouble(amount[i]);
	//out.println("resltbal:-"+resltbal);
}

totalfuelqty=totalfuelqty-resltbal;
//out.println("totalfuelqty:-"+totalfuelqty);
out.print(result+"**"+totalfuelqty);

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		//st.close();
		//st1.close();
		con1.close();
	}

%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ page buffer="16kb" %>

<%!
Connection conn,conn1;
Statement s1,stmtinsert;

%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

	<title>Seven Day Diary System.</title>
	<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
	<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
	<script src="sorttable.js" type="text/javascript"></script>

<% 
try
{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	s1=conn.createStatement();
	stmtinsert=conn.createStatement();
}
catch(Exception e)
{
	out.println(e);
}
%>
<%
try
{
	String 	OwnerName="",StartCode="",StartPlace="",EndCode="",fuelKm="",Tdays="",EndPlace="",Km="",TTime="",Filename1="",Routecode="",originzone="",Destizone="";
	String itemName="";
	int  filecount = 0,count1 = 0,i=0;
	File savedFile;
	int flag2=0;
	Boolean flag=false,flag1=true;
	String savefilestring="";
	String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	OwnerName=(String)session.getAttribute("usertypevalue");

	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {
		System.out.println("\n\nin multipart..");
	} 
	else
	{
		System.out.println("\n\n in else with  multipart..");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		//	System.out.print("\n\n items==>"+items);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
		Iterator itr1 = items.iterator();

		while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if(item.isFormField()) 
			{
				String name = item.getFieldName();
				System.out.print("\n name==>"+name);
				String value = item.getString();
				

				
				if(name.equals("StartCode")) 
				{
					StartCode = value;
					System.out.print("\n StartCode==>"+StartCode);
					count1 = 1;
				}
				if(name.equals("StartPlace")) 
				{
					StartPlace = value;
					System.out.print("\n StartPlace==>"+StartPlace);
					count1 = 1;
				}
				if(name.equals("EndCode")) 
				{
					EndCode = value;
					System.out.print("\n EndCode==>"+EndCode);
					count1 = 1;
				}
				if(name.equals("EndPlace")) 
				{
					EndPlace = value;
					System.out.print("\n EndPlace==>"+EndPlace);
					count1 = 1;
				}
				if(name.equals("Km")) 
				{
					Km = value;
					System.out.print("\n StartCode==>"+Km);
					count1 = 1;
				}
				if(name.equals("TTime")) 
				{
					
					
					TTime = value;
					System.out.print("\n TTime==>"+TTime);
					count1 = 1;
				}
				if(name.equals("Filename1")) 
				{
					Filename1 = value;
					System.out.print("\n Filename==>"+Filename1);
					count1 = 1;
				}
				if(name.equals("Routecode")) 
				{
					Routecode = value;
					System.out.print("\n Routecode==>"+Routecode);
					count1 = 1;
				}
				if(name.equals("originzone")) 
				{
					originzone = value;
					System.out.print("\n originzone==>"+originzone);
					count1 = 1;
				}
				if(name.equals("Destizone")) 
				{
					Destizone = value;
					System.out.print("\n Destizone==>"+Destizone);
					count1 = 1;
				}
				if(name.equals("Tdays")){
					Tdays = value;
					System.out.print("\n Tdays==>"+Tdays);
					count1 = 1;
				}
				if(name.equals("fuelKm")){
					fuelKm = value;
					System.out.print("\n fuelKm==>"+fuelKm);
					count1 = 1;
				}
			}
			else
			{
				
				
			}
		}
			
		
		if(flag1)
		{
			flag2=1;
		while (itr1.hasNext()) {
			FileItem item = (FileItem) itr1.next();
			if(item.isFormField()) 
			{
				
			} else {	
				try {

					 itemName = item.getName();
					System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
					if(itemName.equalsIgnoreCase(""))
					{
					}
					else
					{
						try{
					
						    savedFile = new File("/usr/share/tomcat6/webapps/images1/kmlfile/"+InsertDateTime.replace(":","_")+"_"+itemName);
							//savedFile = new File("/home/a_raina/test/"+InsertDateTime+"_"+itemName);

						   System.out.println("IIIIIII2222  "+savedFile);
							
						
						item.write(savedFile);
						
					}catch(Exception e)
					{
						e.printStackTrace();
					}
						}
						
					}
							
				 catch (Exception e) {
	  					e.printStackTrace();
	  				}
					}
			
		}//while
	}//if


	else
	{
		flag2=2;
	}

	}

	
	
	
	
	
	
/*	System.out.println(OwnerName);
 StartCode=request.getParameter("StartCode");
	System.out.println(StartCode);
	 StartPlace=request.getParameter("StartPlace");
	System.out.println(StartPlace);
	String EndCode=request.getParameter("EndCode");
	System.out.println(EndCode);
	String EndPlace=request.getParameter("EndPlace");
	System.out.println(EndPlace);
	String Km=request.getParameter("Km");
	System.out.println(Km);
	String TTime=request.getParameter("TTime");
	System.out.println(TTime);*/
	//String Startlat=request.getParameter("Startlat");
	//String Startlong=request.getParameter("Startlong");
	//String Endlat=request.getParameter("Endlat");
	//String EndLong=request.getParameter("EndLong");
//	String radio2=request.getParameter("radio2");
	//String zone=request.getParameter("zone");
//	String RCode=StartCode+"-"+EndCode;
	
	//java.util.Date defoultdate = new java.util.Date();
//	String today=new SimpleDateFormat("yyyy-MM-dd").format(defoultdate);
if(itemName.equalsIgnoreCase("")|| itemName.equalsIgnoreCase(" ")||itemName.equalsIgnoreCase("null")||itemName.equalsIgnoreCase(null))
{
	itemName="-";
	
}
else
{
	itemName=itemName;
	itemName=InsertDateTime+"_"+itemName;
}

	
	String sqlroute="select * from db_gps.t_castrolroutes where Owner='"+OwnerName+"' and RouteCode='"+Routecode+"'";
	ResultSet rsroute=stmtinsert.executeQuery(sqlroute);
	System.out.println("Check Querry------------------>"   +sqlroute);
	if(rsroute.next())
	{
		   out.print("Routecode already present");
		 response.sendRedirect("Reportfornewroute.jsp?Route=Routecode already present");
	}
	else
	{
	System.out.println("Insert Querry------------------>");
	String sql="insert into t_castrolroutes(StartCode,StartPlace,EndCode,EndPlace,Km,TTime,Owner,kmlfile,RouteCode,StartLocationZone,EndLocationZone,Updateddate,tripdays,FuelApprovedKm)Values('"+StartCode+"','"+StartPlace+"','"+EndCode+"','"+EndPlace+"','"+Km+"','"+TTime+"','"+OwnerName+"','"+itemName.replace(":","_")+"','"+Routecode+"','"+originzone+"','"+Destizone+"','"+InsertDateTime+"','"+Tdays+"','"+fuelKm+"')";
	System.out.println("Insert Querry------------------>"   +sql);
	//	String abcd=sql.replace("'","#");	
	///	abcd=abcd.replace(",","$");								
	//	stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
	s1.executeUpdate(sql);
	System.out.println("Insert Querry------------------>"   +sql);
//	String add="yes";
	response.sendRedirect("Reportfornewroute.jsp?Parameter4=yes");
}
}
catch(Exception e)
{
	e.printStackTrace();	
}
finally
{
	conn.close();
	
}
%>
<!-- <table border="0">-->
<!--	<tr align="center"><td><font color="BROWN" size="5">< %out.print("INSERTED SUCCESSFULLY");%></font></td></tr>-->
<!--	<td><a href="castrolroutes.jsp">Back To FIRST PAGE</a></td>	-->
<!--	</table>-->


</body>
</html>
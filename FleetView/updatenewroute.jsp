<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
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
Statement s,s1,stmtinsert,stmtinsert1;
%>

<%@page import="com.lowagie.text.Document"%><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
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
	s=conn.createStatement();
	s1=conn.createStatement();
	stmtinsert=conn.createStatement();
	stmtinsert1=conn.createStatement();
}
catch(Exception e)
{
	out.println(e);
}
%>
<%
try
{
	
String OldStartPlace="",OldEndPlace="",OldStartCode="",OldEndCode="",OldStartplace="",OldEndplace="",OwnerName="",oldStartcode="",oldendcode="",Oldkmlfile="";
Double OldKm=0.0,OldTTime=0.0,OldStartlat=0.0,OldStartlong=0.0,OldEndlat=0.0,OldEndLong=0.0;
String itemName="",newstartplace="",newendplace="",oldStartLocationZone="",newKm="",oldEndLocationZone="",newTTime="",originzone="",Destizone="",newStartcode="",newendcode="",NewFilename1="",newroutecode="",OldRoutecode="",oldrouteid="",fuelapprovedkm1="",fuelapprovedkm="",tripdays1="",tripdays="",rid="";
int  filecount = 0,count1 = 0,i=0;
File savedFile;
int flag2=0;
Boolean flag=false,flag1=true;
String savefilestring="";
String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
//OwnerName=(String)session.getAttribute("usertypevalue");

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
			if(name.equals("Filename11")) 
			{
				NewFilename1 = value;
				System.out.print("\n New file name "+NewFilename1);
				count1 = 1;
			}
			
			
			if(name.equals("castrolroute3")) 
			{
				oldrouteid = value;
				System.out.print("\n oldrouteid==>"+oldrouteid);
				count1 = 1;
			}
			if(name.equals("castrolroute")) 
			{
				oldStartcode = value;
				System.out.print("\n StartCodeold=oldddddstatrtcodeoldddddstatrtcodeoldddddstatrtcodeoldddddstatrtcode=>"+oldStartcode);
				count1 = 1;
			}
			if(name.equals("castrolroute1")) 
			{
				oldendcode = value;
				System.out.print("\n oldendcode=oldendcodeoldendcodeoldendcodeoldendcodeoldendcode=>"+oldendcode);
				count1 = 1;
			}
			if(name.equals("castrolroute2")) 
			{
				Oldkmlfile = value;
				System.out.print("\n Oldkmlfile==>"+Oldkmlfile);
				count1 = 1;
			}
			if(name.equals("StartPlace1")) 
			{
				newstartplace = value;
				System.out.print("\n StartPlace1=StartPlace1StartPlace1StartPlace1StartPlace1=>"+newstartplace);
				count1 = 1;
			}
			if(name.equals("EndPlace1")) 
			{
				newendplace = value;
				System.out.print("\n EndPlace1=endplaceendplaceendplaceendplaceendplace=>"+newendplace);
				count1 = 1;
			}
			if(name.equals("Km1")) 
			{
				newKm = value;
				System.out.print("\n Km1==>"+newKm);
				count1 = 1;
			}
			if(name.equals("TTime1")) 
			{
				newTTime = value;
				System.out.print("\n TTime1==>"+newTTime);
				count1 = 1;
			}
			if(name.equals("StartCode1")) 
			{
				newStartcode = value;
				System.out.print("\n StartCode1=newStartcodenewStartcodenewStartcodenewStartcode=>"+newStartcode);
				count1 = 1;
			}
			if(name.equals("EndCode1")) 
			{
				newendcode = value;
				System.out.print("\n EndCode1==>"+newendcode);
				count1 = 1;
			}
			if(name.equals("oldroutecode")) 
			{
				newroutecode = value;
				System.out.print("\n newroutecode=newroutecodenewroutecodenewroutecodenewroutecode=>"+newroutecode);
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
			}if(name.equals("fuelkm1")) 
			{
				fuelapprovedkm1 = value;
				System.out.print("\n fuelapprovedkm1111111111111111==>"+fuelapprovedkm1);
				count1 = 1;
			}if(name.equals("tdays1")) 
			{
				tripdays1 = value;
				System.out.print("\n tripdays==>"+tripdays1);
				count1 = 1;
			}
			if(name.equals("rid")) 
			{
				rid = value;
				System.out.print("\n tripdays==>"+rid);
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
				System.out.print("\n\nitemName------------>"+itemName);
				if(itemName.equalsIgnoreCase(""))
				{
				}
				else
				{
					try{
				
						 savedFile = new File("/usr/share/tomcat6/webapps/images1/kmlfile/"+InsertDateTime.replace(":","_")+"_"+itemName);
						// savedFile = new File("/home/a_raina/test/"+InsertDateTime+"_"+itemName);

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






boolean flagnew=false;



	//String oldStartcode=request.getParameter("castrolroute");
	//System.out.println("oldStartcodenew"  +oldStartcode);
  //  String oldendcode=request.getParameter("castrolroute1");
   // System.out.println("oldendcodenew"  +oldendcode);
	//String Oldkmlfile=request.getParameter("castrolroute2");
//	System.out.println("Oldkmlfile"  +Oldkmlfile);
//	String newEndLong=request.getParameter("EndLong");
  //  String newstartplace=request.getParameter("StartPlace1");
//	System.out.println("newStartPlace"  +newstartplace);
	//String newendplace=request.getParameter("EndPlace1");
	//System.out.println("newEndPlace"  +newendplace);
//	String newKm=request.getParameter("Km1");
//	System.out.println("newKm"  +newKm);
	//String newTTime=request.getParameter("TTime1");
//	System.out.println("newTTime"  +newTTime);
	//String newStartcode=request.getParameter("StartCode1");
//	System.out.println("newStartcodenew"  +newStartcode);
  //  String newendcode=request.getParameter("EndCode1");
 //   System.out.println("newendcodenew"  +newendcode);
 //  String NewFilename11=request.getParameter("Filename11");
 //  System.out.println("NewFilename1"  +NewFilename11);

	Calendar cal= Calendar.getInstance();
	String UpdateDate=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	//System.out.println("TTime"  +UpdateDate);
	String user=session.getAttribute("mainuser").toString();
	//System.out.println("user"  +user);
	String username=(String)session.getAttribute("usertypevalue");
	String status="active";
	//System.out.println("--------------------------->");
	if(itemName.equalsIgnoreCase("")||itemName==""||itemName.equalsIgnoreCase("null"))
		{
		  itemName=Oldkmlfile;
		  
		}
		else
		{
			itemName=itemName;	
			itemName= InsertDateTime+"_"+itemName;
		}
	
	
     String sql1	= "select * from db_gps.t_castrolroutes where owner='"+username+"' and StartCode='"+oldStartcode+"' and EndCode='"+oldendcode+"'";
     ResultSet rs= s1.executeQuery(sql1);    
     System.out.println("sql1"  +sql1);
 	while(rs.next())
 	{
 		 OldKm=rs.getDouble("Km");
 		 OldTTime=rs.getDouble("TTime");
 		 OldStartlat=rs.getDouble("Startlat");
 		 OldStartlong=rs.getDouble("Startlat");
 		 OldEndlat=rs.getDouble("Endlat");
 		 OldEndLong=rs.getDouble("EndLong");
 		 OldStartCode=rs.getString("StartCode");
 		 System.out.println("StartCode--StartCode--StartCode---------->"   +OldStartCode);
 		 
 		 
 		 
 		 OldEndCode=rs.getString("EndCode");
 		System.out.println("EndCode--EndCode--EndCode---------->"   +OldEndCode);
 		 
 		 
 		 OldStartplace=rs.getString("Startplace");
 		 OldEndplace=rs.getString("Endplace");
 		 Oldkmlfile=rs.getString("kmlfile");
 		 System.out.println("oldkmlfile-------------->"   +Oldkmlfile);
 		 OldRoutecode=rs.getString("RouteCode"); 
 		 System.out.println("OldRoutecode-------------->"   +OldRoutecode);
 		 oldStartLocationZone=rs.getString("StartLocationZone"); 
 		 oldEndLocationZone=rs.getString("EndLocationZone"); 
 		 tripdays=rs.getString("tripdays");
 		 System.out.println("tripdaystripdays-------------->"   +tripdays);
 		 fuelapprovedkm=rs.getString("FuelApprovedKm"); 
 		 System.out.println("fuelapprovedkmfuelapprovedkmfuelapprovedkmfuelapprovedkm-------------->"   +fuelapprovedkm);
		 
		 
		 
 	}
	
       


   /* String sql5="update t_castrolroutes set Km='"+newKm+"',TTime='"+newTTime+"',StartCode='"+newStartcode+"',EndCode='"+newendcode+"',StartPlace='"+newstartplace+"',EndPlace='"+newendplace+"',kmlfile='"+itemName.replace(":","_")+"',RouteCode='"+newroutecode+"',StartLocationZone='"+originzone+"',EndLocationZone='"+Destizone+"',tripdays='"+tripdays+"',FuelApprovedKm='"+fuelapprovedkm+"' where Startcode='"+oldStartcode+"'  and Endcode='"+oldendcode+"'";
   System.out.println("updatehistory----------------->"  +sql5);
   
   stmtinsert1.executeUpdate(sql5);
 */
	  if(oldStartcode.equalsIgnoreCase(newStartcode) && oldendcode.equalsIgnoreCase(newendcode) && OldRoutecode.equalsIgnoreCase(newroutecode) && fuelapprovedkm.equalsIgnoreCase(fuelapprovedkm1))
	  {
		//String sqlnew="select * from db_gps.t_castrolroutes  where owner='"+username+"' and StartCode='"+newStartcode+"' and EndCode='"+newendcode+"' and Startplace='"+newstartplace+"' and Endplace='"+newendplace+"' and Km='"+newKm+"' and  TTime='"+newTTime+"' and kmlfile='"+itemName+"'and RouteCode='"+newroutecode+"'and StartLocationZone='"+originzone+"' and EndLocationZone='"+Destizone+"' "; 
		String sqlnew="select * from db_gps.t_castrolroutes  where owner='"+username+"' and StartCode='"+newStartcode+"' and EndCode='"+newendcode+"' and Startplace='"+newstartplace+"' and Endplace='"+newendplace+"' and Km='"+newKm+"' and  TTime='"+newTTime+"' and kmlfile='"+itemName+"'and RouteCode='"+newroutecode+"'and StartLocationZone='"+originzone+"' and EndLocationZone='"+Destizone+"' and FuelApprovedKm='"+fuelapprovedkm1+"' and tripdays='"+tripdays+"' ";
		ResultSet rsnew=stmtinsert.executeQuery(sqlnew);
		System.out.println("sqlnew1111111111111111111111"  +sqlnew);
		if(rsnew.next())
		{
			out.print("NO Changes made");
			 response.sendRedirect("Reportfornewroute.jsp?Parameter1=NO Changes made");
		}
		
			else
			{
			    String sql="update t_castrolroutes set Km='"+newKm+"',TTime='"+newTTime+"',StartCode='"+newStartcode+"',EndCode='"+newendcode+"',StartPlace='"+newstartplace+"',EndPlace='"+newendplace+"',kmlfile='"+itemName.replace(":","_")+"',RouteCode='"+newroutecode+"',StartLocationZone='"+originzone+"',EndLocationZone='"+Destizone+"',tripdays='"+tripdays1+"',FuelApprovedKm='"+fuelapprovedkm1+"' where Startcode='"+oldStartcode+"'  and Endcode='"+oldendcode+"' and FuelApprovedKm='"+fuelapprovedkm1+"' and tripdays='"+tripdays1+"'";
			    //String sql="update t_castrolroutes set Km='"+newKm+"',TTime='"+newTTime+"',StartCode='"+newStartcode+"',EndCode='"+newendcode+"',StartPlace='"+newstartplace+"',EndPlace='"+newendplace+"',kmlfile='"+itemName.replace(":","_")+"',RouteCode='"+newroutecode+"',StartLocationZone='"+originzone+"',EndLocationZone='"+Destizone+"',tripdays='"+tripdays+"',FuelApprovedKm='"+fuelapprovedkm+"' , Startcode='"+oldStartcode+"', Endcode='"+oldendcode+"'  where rid='"+rid+"'";
			   //Query for t_sqlquery
					String abcd=sql.replace("'","#");	
					abcd=abcd.replace(",","$");								
					stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
				    s.executeUpdate(sql);	
				 System.out.println("updatequerry---------------------------->"  +sql);	
				 String sql2="insert into t_CastrolRoutesHistory(OldStartCode,OldStartPlace,OldEndCode,OldEndPlace,OldKm,OldTTime,OldStartlat,OldStartlong,OldEndlat,OldEndLong,NewStartCode,NewStartPlace,NewEndCode,NewEndPlace,NewKm,NewTTime,UpdateDate,Insertedby,status,kmlfile,RouteCode,StartLocationZone,tripdays,FuelApprovedKm,EndLocationZone)Values('"+oldStartcode+"','"+OldStartplace+"','"+oldendcode+"','"+OldEndplace+"','"+OldKm+"','"+OldTTime+"','"+OldStartlat+"','"+OldStartlong+"','"+OldEndlat+"','"+OldEndLong+"','"+newStartcode+"','"+newstartplace+"','"+newendcode+"','"+newendplace+"','"+newKm+"','"+newTTime+"','"+UpdateDate+"','"+user+"','"+status+"','"+Oldkmlfile+"','"+OldRoutecode+"','"+oldStartLocationZone+"','"+tripdays+"','"+fuelapprovedkm+"','"+oldEndLocationZone+"')";
				//Query for t_sqlquery
					String abcd1=sql2.replace("'","#");	
					abcd1=abcd1.replace(",","$");								
					stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
				 s.executeUpdate(sql2);	
				 System.out.println("updatehistory----------------->"  +sql2);
				 response.sendRedirect("Reportfornewroute.jsp?Parameter=yup");
		
		}
		}
	  else
	  {
		  String sqlnew2="select * from db_gps.t_castrolroutes where owner='"+username+"' and StartCode='"+newStartcode+"' and EndCode='"+newendcode+"' and FuelApprovedKm='"+fuelapprovedkm1+"'and tripdays='"+tripdays1+"' ";
			 ResultSet rsnew1=s1.executeQuery(sqlnew2);
			 System.out.println("sqlnew2222222222222222222222222222222----------------->"  +sqlnew2);
			 if(rsnew1.next())
			 {
				 out.print("Record already exist");
				 response.sendRedirect("Reportfornewroute.jsp?Parameter2=Record already exist");
			 }  
			 
			 else 
				 
			 {
				 
				 String sqlroute="select * from db_gps.t_castrolroutes where Owner='"+username+"' and RouteCode='"+newroutecode+"' and FuelApprovedKm='"+fuelapprovedkm1+"'and tripdays='"+tripdays1+"'";
					ResultSet rsroute=stmtinsert.executeQuery(sqlroute);
					System.out.println("Check Querry2222222222222222222------------------>"   +sqlroute);
					if(rsroute.next())
					{
						   out.print("Routecode already present");
						 response.sendRedirect("Reportfornewroute.jsp?Route=Routecode already present");
					}
					
					else
					{
				
				 String sql="update t_castrolroutes set Km='"+newKm+"',TTime='"+newTTime+"',StartCode='"+newStartcode+"',EndCode='"+newendcode+"',StartPlace='"+newstartplace+"',EndPlace='"+newendplace+"',kmlfile='"+itemName.replace(":","_")+"',RouteCode='"+newroutecode+"',StartLocationZone='"+originzone+"',EndLocationZone='"+Destizone+"',tripdays='"+tripdays1+"',FuelApprovedKm='"+fuelapprovedkm1+"' where Startcode='"+oldStartcode+"'  and Endcode='"+oldendcode+"'";
				// String sql="update t_castrolroutes set Km='"+newKm+"',TTime='"+newTTime+"',StartCode='"+newStartcode+"',EndCode='"+newendcode+"',StartPlace='"+newstartplace+"',EndPlace='"+newendplace+"',kmlfile='"+itemName.replace(":","_")+"',RouteCode='"+newroutecode+"',StartLocationZone='"+originzone+"',EndLocationZone='"+Destizone+"',tripdays='"+tripdays+"',FuelApprovedKm='"+fuelapprovedkm+"' , Startcode='"+oldStartcode+"' Endcode='"+oldendcode+"' where rid='"+rid+"'";
				   //Query for t_sqlquery
						String abcd=sql.replace("'","#");	
						abcd=abcd.replace(",","$");								
						stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
					 s.executeUpdate(sql);	
					 System.out.println("updatequerry-----------111111111111111111111>"  +sql);	
					 String sql2="insert into t_CastrolRoutesHistory(OldStartCode,OldStartPlace,OldEndCode,OldEndPlace,OldKm,OldTTime,OldStartlat,OldStartlong,OldEndlat,OldEndLong,NewStartCode,NewStartPlace,NewEndCode,NewEndPlace,NewKm,NewTTime,UpdateDate,Insertedby,status,kmlfile,RouteCode,StartLocationZone,EndLocationZone)Values('"+oldStartcode+"','"+OldStartplace+"','"+oldendcode+"','"+OldEndplace+"','"+OldKm+"','"+OldTTime+"','"+OldStartlat+"','"+OldStartlong+"','"+OldEndlat+"','"+OldEndLong+"','"+newStartcode+"','"+newstartplace+"','"+newendcode+"','"+newendplace+"','"+newKm+"','"+newTTime+"','"+UpdateDate+"','"+user+"','"+status+"','"+Oldkmlfile+"','"+OldRoutecode+"','"+oldStartLocationZone+"','"+oldEndLocationZone+"')";
					//Query for t_sqlquery
						String abcd1=sql2.replace("'","#");	
						abcd1=abcd1.replace(",","$");								
						stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
					 s.executeUpdate(sql2);	
					 System.out.println("updatehistory"  +sql2);
					 response.sendRedirect("Reportfornewroute.jsp?Parameter=yup");
					  
			 }
					
			 }
		  
	  }
	  
  
	
    
//}
}
catch(Exception e)
{
	System.out.println(e);	
}
finally
{
	conn.close();
	conn1.close();
}
%>


</body>
</html>
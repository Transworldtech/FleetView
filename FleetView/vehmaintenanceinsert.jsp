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
<%@page import="java.util.Date"%>
<%@ page buffer="16kb" %>
<%!
Connection con1=null;
%>
<% 
try {
	String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new java.util.Date());
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
Statement stquery=con1.createStatement();
ResultSet rs1=null, rs2=null;
String sql;
String user="",vehregno="", vehid="", transporter="", sertype="",SrviceName="", serdate="",email="",emailto="",remark="";
String txtTyreD="",txtTyreSrno="";
String vendor="",amount="",recieptno="",docid="",Mdet = "";
int saveflag=0,filecount = 0,count1 = 0;
String savefilestring="",itemName="";
String fname="",fname1="",fname2="";
String serkm="", nxtserdate="", nextserkm="",days="";
int AlertKm=0,AlertafterKm=0;
Date Alertdate =new Date();
String todaysdate=new SimpleDateFormat("yyyy-MM-dd").format(Alertdate);
user=session.getValue("user").toString();
//email=session.getValue("user").toString();
System.out.println("todaysdate--->"+todaysdate);
System.out.println("user-->"+user);
File savedFile;
String[] filepath =new String[3];
String[] filename =new String[3];
  int age=0,finalage=0;

/*****GETTING PARAMETER FROM ENTRY FORM PAGE****/

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if (!isMultipart)
{
	System.out.println("\n\nin multipart..");
} 
else
{
	System.out.println("\n\n in else with  multipart how are you..");
	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	List items = null;
	try {
		items = upload.parseRequest(request);
	} catch (FileUploadException e)
	{
		e.printStackTrace();
	}
	
	Iterator itr = items.iterator();

	while (itr.hasNext()) {
		FileItem item = (FileItem) itr.next();
		if(item.isFormField()) 
		{
			String name = item.getFieldName();
			//System.out.print("\n name==>"+name);
			String value = item.getString();
			
				
			
			if(name.equals("sertype")) 
			{
				sertype = value;
				System.out.print("\n sertype==>"+sertype);
				count1 = 1;
			}
			
			if(name.equals("vehicle")) 
			{
				vehregno = value;
				System.out.print("\n vehregno==>"+vehregno);
				count1 = 1;
			}
			
			
			if(name.equals("calender1")) 
			{
				serdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(value));
				System.out.print("\n serdate==>"+serdate);
				count1 = 1;
			}
			
			if(name.equals("serkm")) 
			{
				serkm = value;
				System.out.print("\n serkm==>"+serkm);
				count1 = 1;
			}
			
			if(name.equals("Mdet1")) 
			{
				Mdet = value;
				System.out.print("\n Mdet==>"+Mdet);
				count1 = 1;
			}
			
			if(name.equals("calender")) 
			{
				nxtserdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(value));
				System.out.print("\n address1==>"+value);
				count1 = 1;
			}
			
			
			if(name.equals("transporter")) 
			{
				transporter = value;
				System.out.print("\n transporter==>"+transporter);
				count1 = 1;
			}

			
			if(name.equals("nxtserkm")) 
			{
				nextserkm = value;
				System.out.print("\n nextserkm==>"+nextserkm);
				count1 = 1;
			}

			if(name.equals("emailto")) 
			{
				emailto = value;
				System.out.print("\n emailto==>"+emailto);
				count1 = 1;
			}
			
			if(name.equals("days")) 
			{
				days = value;
				System.out.print("\n days==>"+days);
				count1 = 1;
			}
			
			if(name.equals("vendorname")) 
			{
				vendor = value;
				System.out.print("\n vendor==>"+vendor);
				count1 = 1;
			}
			
			if(name.equals("amount")) 
			{
				amount = value;
				System.out.print("\n amount==>"+amount);
				count1 = 1;
			}
			
			if(name.equals("recieptno"))
			{
				recieptno = value;
				System.out.print("\n recieptno==>"+recieptno);

				count1 =1;
			}
			

			
			if(name.equals("docid"))
			{
				docid = value;
				System.out.print("\n docid==>"+docid);

				count1 =1;
			}
			
			if(name.equals("txtTyreSrno"))
			{
				txtTyreSrno = value;
				System.out.print("\n txtTyreSrno==>"+txtTyreSrno);

				count1 =1;
			}
			
			if(name.equals("txtTyreD"))
			{
				txtTyreD = value;
				System.out.print("\n txtTyreD==>"+txtTyreD);

				count1 =1;
			}
			if(name.equals("f6"))
			{
				fname = value;
				System.out.print("\n fname==>"+fname);
				count1 =1;
			}			
			
			
			if(name.equals("remark"))
			{
				remark = value;
				System.out.print("\n remark==>"+remark);
				count1 =1;
			}			
			
		}
	else {	
			try {

				 itemName = item.getName();
				System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
				if(itemName.equalsIgnoreCase(""))
				{
				}
				else
				{
					try{
				
						System.out.println("HHHHHH  ");
						//savedFile = new File("/home/s_dhole/test/"+InsertDateTime+"_"+itemName);
						String fname4=(InsertDateTime+"_"+itemName).replace(" ", "");
						savedFile = new File("/usr/share/tomcat6/webapps/images1/vehmaintainance/"+fname4);
						//savedFile = new File("/home/r_powar1/Desktop/vehmaintainance/"+InsertDateTime+"_"+itemName);
						 
							System.out.print("\n\nsavedFile==>"+savedFile);
							item.write(savedFile);
							filepath[filecount]=""+savedFile;
							
							filename[filecount]=itemName;
							filecount++;
							if(saveflag==1)
							{
							 savefilestring=""+savedFile;
							 saveflag++;
							}
							else
								savefilestring=savefilestring+","+savedFile;
							 //out.print("successfully saved the file");
							//File file = new File(savedFile);
							String screenshot=savedFile.getAbsolutePath();
						System.out.println("\n\nscreenshot--->>>"+screenshot);
							
					
				}catch(Exception e)
				{
					System.out.print("Inner");
					e.printStackTrace();
				}
					}
					
				}
						
			 catch (Exception e) {
					System.out.print("Outer");
  					e.printStackTrace();
  				}
				}
		
	}
		
		
		
}	

if(fname=="" || fname.equals(""))
{
	fname=fname;

}
else{
	fname=(InsertDateTime+"_"+fname).replace(" ", "");
	//fname= InsertDateTime+"_"+fname;

}

System.out.println("1111");

//email=email+","+emailto;
email=emailto;
System.out.println("sertype:"+sertype);
System.out.println("serkm:"+serkm);
System.out.println("nextserkm:"+nextserkm);

if(sertype.equalsIgnoreCase("preventive") || sertype.equalsIgnoreCase("oil"))
{
	System.out.println("11112312311");
AlertKm= Integer.valueOf(serkm)+Integer.valueOf(nextserkm);
AlertafterKm=AlertKm-100;
}

System.out.println("22222222222");
sql="select VehicleCode,OwnerName from t_vehicledetails where VehicleRegNumber ='"+vehregno+"'";
System.out.println("sql--->"+sql);
rs1=stmt1.executeQuery(sql);
if(rs1.next())
{
	vehid=rs1.getString("VehicleCode");
	transporter=rs1.getString("OwnerName");
}
System.out.println("sertype--->"+sertype); 
if(!(sertype.equalsIgnoreCase("preventive"))&& !(sertype.equalsIgnoreCase("TyreM")) && !(sertype.equalsIgnoreCase("sparepart")))
{
	sql="select Date('"+nxtserdate+"' - INTERVAL '"+days+"' Day) As Date";
	System.out.println("sql--->"+sql);
	rs2=stmt1.executeQuery(sql);
	
	if(rs2.next())
	{
		Alertdate=rs2.getDate("Date");
	}
	if(sertype.equalsIgnoreCase("oil"))
	{ 
		SrviceName="Engine Oil Change/Hub Greasing";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceDate,NextServiceAfterKm,AlertBeforedays,Alertdate,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nxtserdate+"','"+nextserkm+"','"+days+"','"+Alertdate+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("puc"))
	{
		SrviceName="PUC Renewal";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
  		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("insurance"))
	{
		SrviceName="Vehicle Insurance Renewal";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("tax"))
	{
		SrviceName="Tax";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("fitness"))
	{
		SrviceName="Vehicle Fitness";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("npermit"))
	{
		SrviceName="National Permit";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("permit"))
	{
		SrviceName="Permit Five Years";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	
	/* if(sertype.equalsIgnoreCase("sparepart"))
	{
		SrviceName="Spare Part Repairing";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,MaintenanceDetails,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+Mdet+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"')";
	} */
	
	if(sertype.equalsIgnoreCase("remoldtypre"))
	{
		SrviceName="Remold Tyre";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("batteryM"))
	{
		SrviceName="Battery Maintenance";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	
	if(sertype.equalsIgnoreCase("eng"))
	{
		SrviceName="Engine";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("chasis"))
	{
		SrviceName="Chasis";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("radiator"))
	{
		SrviceName="Radiator";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("gearbox"))
	{
		SrviceName="Gear Box";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("frontaxle"))
	{
		SrviceName="Front Axle";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("clutch"))
	{
		SrviceName="Clutch";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("diffrential"))
	{
		SrviceName="Diffrential / Rear Axle";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("pto"))
	{
		SrviceName="PTO";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}if(sertype.equalsIgnoreCase("apt"))
	{
		SrviceName="APT/HPT Pumps";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}if(sertype.equalsIgnoreCase("vaccum"))
	{
		SrviceName="Vaccum/Suction Pump";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("suction"))
	{
		SrviceName="Suction Boom & Feeder";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("jetting"))
	{
		SrviceName="Jetting Hose Reel";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("hyd"))
	{
		SrviceName="Hydrolic Hose / Rubber Hose Suction";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("hydcyl"))
	{
		SrviceName="Hy.Cylinder";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("airpipe"))
	{
		SrviceName="Air Pipes & Compressor";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("fittings"))
	{
		SrviceName="Fittings";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("airfilter"))
	{
		SrviceName="Air Filter Accessories";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("cabin"))
	{
		SrviceName="Cabin";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("profshaft"))
	{
		SrviceName="Proffler Shaft";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("fuellines"))
	{
		SrviceName="Fuel Lines";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	if(sertype.equalsIgnoreCase("oil1"))
	{
		SrviceName="Oils";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	
	
	if(sertype.equalsIgnoreCase("electpanel"))
	{
		SrviceName="Electrical Panel / Chasis Electrical Accessories";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,NextServiceDate,AlertBeforedays,Alertdate,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
		    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+nxtserdate+"','"+days+"','"+Alertdate+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
	
}
else if(sertype.equalsIgnoreCase("sparepart"))
{
	SrviceName="Spare Part Repairing";
	sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,MaintenanceDetails,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile,remark) "+
	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+Mdet+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";

}
else
{
	if(sertype.equalsIgnoreCase("TyreM")) 
	{
		System.out.print("sertype : "+sertype);
		SrviceName="Tyre Maintenance";
		sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceAfterKm,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,TyreSrno,TyreDetails,AttachedFile,remark) "+
	 	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nextserkm+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+txtTyreSrno+"','"+txtTyreD+"','"+fname+"','"+remark+"')";
	}else{
	SrviceName="Preventive Maintenance";
	sql="INSERT INTO db_gps.t_lastservice (Vehid,VehRegNo,Transporter,ServiceDate,ServiceType,SrviceName,ServiceKm,NextServiceAfterKm,AlertKm,AlertAfterKm,EmailTo,EntDate,EntBy,VendorName,Amount,RecieptNo,DocID,AttachedFile) "+
 	    "VALUES ('"+vehid+"','"+vehregno+"','"+transporter+"','"+serdate+"','"+sertype+"','"+SrviceName+"','"+serkm+"','"+nextserkm+"','"+AlertKm+"','"+AlertafterKm+"','"+email+"','"+todaysdate+"','"+user+"','"+vendor+"','"+amount+"','"+recieptno+"','"+docid+"','"+fname+"','"+remark+"')";
	}
}
System.out.print("sql : "+sql);
stmt1.executeUpdate(sql);
String abcd=sql.replace("'","#");
abcd=abcd.replace(",","$");
stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
response.sendRedirect("vehmaintenance.jsp?inserted=yes");
return; 
} catch(Exception e) { System.out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
} 
%>
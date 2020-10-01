<%@page import="java.util.Date"%>
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

Connection con1;
Statement stsend;
%>


<html>
<head>
<script type="text/javascript">
 alert("in the tripstartentry jsp page");

</script>
</head>
<body>
</body>
</html>
<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(),stmt3=con1.createStatement(),stmtcode=con1.createStatement();
Statement stquery=con1.createStatement();
Statement stmtroute=con1.createStatement();
Statement stmtroute1=con1.createStatement();
Statement stmtroute2=con1.createStatement();
Statement stmail=con1.createStatement();
Statement stmaster=con1.createStatement();
Statement stmtunit=con1.createStatement();


 stsend=con1.createStatement(); 


%>

<% 
ResultSet rs1=null, rs15=null, rs5=null, rs6=null, rs9=null;
String sql1="", sql15="", sql5="", sql6="", sql9="", sql2="", sql3="";
String route="", entby="",veh="", stloc="", othstloc="", stdate="", sttimehour="", sttimemin="", rptdate="", rpttimehour="", rpttimemin="",rptdttm="", 
dest="", othdest="", driverid="", othdrivid="", newdrvname="", drivername="", tripid="", stloc1="",vendor="",s="",TripCategory="",customerMailID="",fname="",dest1="",GoodsContent="" ;
String vehcode="", stlocinsrt="",stlocinsrt1="",destinsrt="",destinsrt1="", driveridinsrt="", user="",user1="", sttime="",calender1="",calender="",etadate="",etadate1="", etatime1="", etatime2="00", etatime="",Tripissuedate="",Tripissuedate1="",othstrtloc="",joborderno="",revenue="",containerno="";
String lpo="",trailerno="",customercontperson="",customercontno="",containertype="",tokenno="",tokenchargespaid="",saleperson="",containerstatus="";
String lrissue="",lrcontact="",boffice="",cnno="";
String itemName="",stlocinsrt1start="",destinsrt1dest="",tripexpence="",rateperkm="",rateperhour="";
float latit=0, longit=0;
String sql7="",weight="",stlocnew="",stlocnew1="",castrolroutecode="",castrolroutecode1="",othvendor="",othTripCategory="",othGoodsContent="",loadreason="",fxdkm="",ftme="",frie="",loadcmnt="",adv="",owner="",allemailid="";
int  filecount = 0,count1 = 0,i=0;
File savedFile;
int flag2=0;
Boolean flag=false,flag1=true;
String savefilestring="";
String date = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());

String[] filepath =new String[3];
String[] filename =new String[3];
int saveflag=0;
user=session.getValue("usertypevalue").toString();
user1="ETAAlert"+user;

System.out.println("user type value  is  :- "+user);

System.out.println("USER type value wwww:- "+user);

entby=session.getAttribute("dispalyname").toString();
String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());



/* *********** get all the fields from the form ************* */

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
	} catch (Exception e) {
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
			

			
			if(name.equals("othstrtloc")) 
			{
				othstrtloc = value;
				System.out.print("\n othstrtloc==>"+othstrtloc);
				count1 = 1;
			}
			
			
			
			

			if(name.equals("othstrtloc")) 
			{
				othstloc = value;
				System.out.print("\n othstloc==>"+othstloc);
				count1 = 1;
			}
			
			if(name.equals("stloc")) 
			{
				stloc = value;
				System.out.print("\n stloc1111111111111==>"+stloc);
				count1 = 1;
			}
			if(name.equals("castrolroutecode")) 
			{
				castrolroutecode = value;
				System.out.print("\n stlocnew==>"+castrolroutecode);
				count1 = 1;
			}
			if(name.equals("castrolroutecode1")) 
			{
				castrolroutecode1 = value;
				System.out.print("\n stlocnew1==>"+castrolroutecode1);
				count1 = 1;
			}
			///hh
			if(name.equals("Loadreason")) 
			{
				loadreason = value;
				System.out.print("\n loadreason==>"+loadreason);
				count1 = 1;
			}
			
			if(name.equals("vendor")) 
			{
				vendor = value;
				System.out.print("\n vendor==>"+vendor);
				count1 = 1;
			}
			
			
			if(name.equals("othvendor")) 
			{
				othvendor = value;
				System.out.print("\n othvendor==>"+othvendor);
				count1 = 1;
			}
			
			
			if(name.equals("TripCategory")) 
			{
				TripCategory = value;
				System.out.print("\n TripCategory==>"+TripCategory);
				count1 = 1;
			}
			
			if(name.equals("GoodsContent")) 
			{
				GoodsContent = value;
				System.out.print("\n GoodsContent==>"+GoodsContent);
				count1 = 1;
			}
			
			
			
			
			if(name.equals("othTripCategory")) 
			{
				othTripCategory = value;
				System.out.print("\n othTripCategory==>"+othTripCategory);
				count1 = 1;
			}
			
			
			if(name.equals("othGoodsContent")) 
			{
				othGoodsContent = value;
				System.out.print("\n othGoodsContent==>"+othGoodsContent);
				count1 = 1;
			}
			
			
			
			
			
			if(name.equals("dest")) 
			{
				dest = value;
				System.out.print("\n dest==>"+dest);
				count1 = 1;
			}
			if(name.equals("othdest")) 
			{
				othdest = value;
				System.out.print("\n othdest==>"+othdest);
				count1 = 1;
			}
			if(name.equals("driverid")) 
			{
				driverid = value;
				System.out.print("\n driverid==>"+driverid);
				count1 = 1;
			}
			
			
			if(name.equals("othdriverid")) 
			{
				othdrivid = value;
				System.out.print("\n othdrivid==>"+othdrivid);
				count1 = 1;
			}
			
			if(name.equals("newdrvname")) 
			{
				newdrvname = value;
				System.out.print("\n newdrvname==>"+newdrvname);
				count1 = 1;
			}
			if(name.equals("drivername")) 
			{
				drivername = value;
				System.out.print("\n drivername==>"+drivername);
				count1 = 1;
			}
			
			
			if(name.equals("route")) 
			{
				route = value;
				System.out.print("\n route==>"+route);
				count1 = 1;
			}
			if(name.equals("vehno")) 
			{
				veh = value;
				System.out.print("\n veh==>"+veh);
				count1 = 1;
			}
			
			if(name.equals("lrissue")) 
			{
				lrissue = value;
				System.out.print("\n lrissue==>"+lrissue);
				count1 = 1;
			}
			if(name.equals("lrcontact")) 
			{
				lrcontact = value;
				System.out.print("\n lrcontact==>"+lrcontact);
				count1 = 1;
			}
			
			if(name.equals("bcode")) 
			{
				boffice = value;
				System.out.print("\n boffice==>"+boffice);
				count1 = 1;
			}
			
			if(name.equals("cnnumber")) 
			{
				cnno = value;
				System.out.print("\n cnno==>"+cnno);
				count1 = 1;
			}
			if(name.equals("sttime1")) 
			{
				sttimehour = value;
				System.out.print("\n sttimehour==>"+sttimehour);
				count1 = 1;
			}
			
			if(name.equals("sttime2")) 
			{
				sttimemin = value;
				System.out.print("\n sttimemin==>"+sttimemin);
				count1 = 1;
			}
			if(name.equals("rpttime1")) 
			{
				rpttimehour = value;
				System.out.print("\n rpttimehour==>"+rpttimehour);
				count1 = 1;
			}
			
			if(name.equals("rpttime2")) 
			{
				rpttimemin = value;
				System.out.print("\n rpttimemin==>"+rpttimemin);
				count1 = 1;
			}
			if(name.equals("rpttime2")) 
			{
				rpttimemin = value;
				System.out.print("\n rpttimemin==>"+rpttimemin);
				count1 = 1;
			}
			if(name.equals("tripid")) 
			{
				tripid = value;
				System.out.print("\n tripid==>"+tripid);
				count1 = 1;
			}
			if(name.equals("weight")) 
			{
				weight = value;
				System.out.print("\n weight==>"+weight);
				count1 = 1;
			}
			if(name.equals("etatime1")) 
			{
				etatime1 = value;
				System.out.print("\n etatime1==>"+etatime1);
				count1 = 1;
			}
			
			if(name.equals("etatime2")) 
			{
				etatime2 = value;
				System.out.print("\n etatime2==>"+etatime2);
				count1 = 1;
			}
			if(name.equals("fxdkm")) 
			{
				fxdkm = value;
				System.out.print("\n fxdkm==>"+fxdkm);
				count1 = 1;
			}
			if(name.equals("tripexp")) 
			{
				tripexpence = value;
				System.out.print("\n Trip Expence==>"+tripexpence);
				count1 = 1;
			}
			if(name.equals("ratehr")) 
			{
				rateperhour = value;
				System.out.print("\n rateperhour==>"+rateperhour);
				count1 = 1;
			}
			if(name.equals("ratekm")) 
			{
				rateperkm = value;
				System.out.print("\n rateperKM==>"+rateperkm);
				count1 = 1;
			}
			
			if(name.equals("ftme")) 
			{
				ftme = value;
				System.out.print("\n ftme==>"+ftme);
				count1 = 1;
			}
			if(name.equals("frie")) 
			{
				frie = value;
				System.out.print("\n frie==>"+frie);
				count1 = 1;
			}
			if(name.equals("adv")) 
			{
				adv = value;
				System.out.print("\n adv==>"+adv);
				count1 = 1;
			}
			if(name.equals("loadcmnt")) 
			{
				loadcmnt = value;
				System.out.print("\n loadcmnt==>"+loadcmnt);
				count1 = 1;
			}
			
			
			
			if(name.equals("stloc1")) 
			{
				stloc1 = value;
				System.out.print("\n stloc12222222222222==>"+stloc1);
				count1 = 1;
			}
			if(name.equals("dest1")) 
			{
				dest1 = value;
				System.out.print("\n dest1==>"+dest1);
				count1 = 1;
			}
			
			if(name.equals("f6"))
			{
				fname = value;
				System.out.print("\n fname==>"+fname);

				count1 =1;
			}
			
			
			
			if(name.equals("calender")) 
			{
				calender = value;
				System.out.print("\n calender==>"+calender);
				count1 = 1;
			}
			if(name.equals("calender1")) 
			{
				calender1 = value;
				System.out.print("\n calender1==>"+calender1);
				count1 = 1;
			}
			if(name.equals("etadate")) 
			{
				etadate1 = value;
				System.out.print("\n etadate==>"+etadate1);
				count1 = 1;
			}
			
			if(name.equals("joborderno"))
			{
				joborderno=value;
				System.out.print("\n joborderno==>"+joborderno);
				count1 = 1;
			}
			if(name.equals("revenue"))
			{
				revenue=value;
				System.out.print("\n revenue==>"+revenue);
				count1 = 1;
			}
			if(name.equals("containerno"))
			{
				containerno=value;
				System.out.print("\n containerno==>"+containerno);
				count1 = 1;
			}
			
			if(name.equals("element_3_11"))
			{
				lpo=value;
				System.out.print("\n lpo==>"+lpo);
				count1 = 1;
			}
			if(name.equals("element_3_12"))
			{
				trailerno=value;
				System.out.print("\n trailerno==>"+trailerno);
				count1 = 1;
			}
			if(name.equals("element_3_13"))
			{
				customercontperson=value;
				System.out.print("\n customercontperson==>"+customercontperson);
				count1 = 1;
			}
			if(name.equals("element_3_14"))
			{
				customercontno=value;
				System.out.print("\n customercontno==>"+customercontno);
				count1 = 1;
			}
			if(name.equals("element_3_17"))
			{
				containertype=value;
				System.out.print("\n containertype==>"+containertype);
				count1 = 1;
			}
			if(name.equals("element_3_19"))
			{
				tokenno=value;
				System.out.print("\n tokenno==>"+tokenno);
				count1 = 1;
			}
			if(name.equals("element_3_20"))
			{
				tokenchargespaid=value;
				System.out.print("\n tokenchargespaid==>"+tokenchargespaid);
				count1 = 1;
			}
			if(name.equals("element_3_21"))
			{
				saleperson=value;
				System.out.print("\n saleperson==>"+saleperson);
				count1 = 1;
			}
			if(name.equals("element_3_22"))
			{
				containerstatus=value;
				System.out.print("\n containerstatus==>"+containerstatus);
				count1 = 1;
			}
                        if(name.equals("element_3_3"))
			{
				Tripissuedate=value;
				System.out.print("\n Tripissuedate==>"+Tripissuedate);
				count1 = 1;
			}
		}
		else
		{
			
			
		}
	}
	
	if(fxdkm.equals("") || fxdkm == "")
		fxdkm = "0";
	if(ftme.equals("") || ftme == "")
		ftme = "0";
	
	if(dest.equalsIgnoreCase("Other") || dest == "Other" || dest == "other")
		dest = othdest;
	
	
	if(flag1)
	{
		flag2=1;
	while (itr1.hasNext()) 
	{
		FileItem item = (FileItem) itr1.next();
		if(item.isFormField()) 
		{
			
		} 
		else 
		{	
			try 
			{

				 itemName = item.getName();
				System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
				if(itemName.equalsIgnoreCase(""))
				{
				}
				else
				{
					try{
				
						 savedFile = new File("/usr/share/tomcat6/webapps/images1/savedimages/"+InsertDateTime+"_"+itemName);
						 //savedFile = new File("/home/s_dhole/test/"+itemName+""+InsertDateTime);

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

try{

stdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(calender));
}catch(Exception e)
{
	
e.printStackTrace();
}
try{
rptdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(calender1));
}catch(Exception e)
{
	e.printStackTrace();

}
try{
etadate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(etadate1));
}catch(Exception e)
{
	e.printStackTrace();

}
try{
	Tripissuedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Tripissuedate));
}catch(Exception e)
{
	e.printStackTrace();

}

rptdttm=rptdate+" "+rpttimehour+":"+rpttimemin+":00";


try{
if(flag2==1)
{

if(null!=veh || null!=cnno || null!=calender || null!=tripid || null!=drivername)
{


try{

if(request.getParameter("emailid")!=null && request.getParameter("extraemail1")!=null )
{
allemailid=request.getParameter("emailid")+","+request.getParameter("extraemail1");
}
else
{
	allemailid="-";
}
}catch(Exception e)
{
	System.out.println("Exception2----->" +e); 

}

try{
sql15="select DriverName from t_drivers where DriverID='"+driverid+"' and Owner='"+user+"' ";
rs15=stmt1.executeQuery(sql15);
if(rs15.next())
{
	drivername=rs15.getString("DriverName");
}

// other loadreason
if(loadreason.equalsIgnoreCase("Other"))
{
	loadreason=request.getParameter("othLoadreason");//othloadreason;
}

//trpcategoery
if(TripCategory.equalsIgnoreCase("Other"))
{
	TripCategory=othTripCategory;
}
//product
if(GoodsContent.equalsIgnoreCase("Other"))
{
	GoodsContent=othGoodsContent;
}
//customer
if(vendor.equalsIgnoreCase("Other"))
{
   vendor=othvendor;
}

sttime=sttimehour+":"+sttimemin+":00";
etatime=etatime1+":"+etatime2+":00";

	
			java.util.Date tdydte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 s=formatter.format(tdydte);
			
			System.out.println("othstrtloc"+othstrtloc);
			System.out.println("othdest"+othdest);
}catch(Exception e)
{
	System.out.println("Exception3----->" +e); 

}
/* ***************************************************************** */

/* ***********************Getting Veh Code from DB******************************** */
try{
sql1="select * from t_vehicledetails where VehicleRegNumber='"+veh+"' and status='-'";
System.out.println("sql1"+sql1);
  rs1=stmt1.executeQuery(sql1);
  if(rs1.next())
  {
     vehcode=rs1.getString("VehicleCode");
     owner=rs1.getString("OwnerName");
    
     
  } //out.print(vehcode);
/* ***************************************************************** */

/* ***************Checking whether trip id is duplicate or not*********************** */
  sql15="select * from t_startedjourney where TripId='"+tripid+"' ";
  rs15=stmt1.executeQuery(sql15);
  if(rs15.next())
  {
	response.sendRedirect("tripstart.jsp?duplicatetripid=yes&vehno="+veh);
	return;	
  }
  else 
  {
  }	
}catch(Exception e)
{
	System.out.println("Exception4----->" +e); 

}
/*************************************************************************************/

/***************Checking whether route is fixed or not*******************************/
/*String startcode="",endcode="";
String sql="select * from db_gps.t_castrolroutes where startplace='"+stloc1+"' and endplace='"+dest1+"' and owner='"+user+"'" ;
System.out.println("queeryyyyyyy------------>"  +sql);
ResultSet rscas=stmt2.executeQuery(sql);
System.out.println("queeryyyyyyy------------>"  +sql);
if(rscas.next())
{
	startcode=rscas.getString("Startcode");
	System.out.println("Startcode------------>"  +startcode);
	endcode=rscas.getString("Endcode");
	System.out.println("Endcode------------>"  +endcode);
}*/
if(route.equals("No"))
{
	System.out.println("in noooooooooooooooooooooooooooooooo");
  stlocinsrt1=stloc;
  stlocinsrt=stloc;
   destinsrt=dest;
   destinsrt1=dest;
  if(stloc.equals("Other"))
    {
	  System.out.println("in stloc other------------>");
	  
	  stlocinsrt1= othstloc;
	  stlocinsrt=othstloc;
    }
  if(dest.equals("Other"))
  {
	  System.out.println("dest other------------>");
     destinsrt=othdest;
     destinsrt1=othdest;
  }
}
else
{
	System.out.println("i-----n--esle----->");
  	stlocinsrt1=castrolroutecode;
  	System.out.println("Startcode  " +stlocinsrt1);
  	stlocinsrt=stloc1;
  	System.out.println("stlocinsrt  " +stlocinsrt);
  	destinsrt=dest1;
  	System.out.println("destinsrt  " +destinsrt);
  	destinsrt1=castrolroutecode1;
  	System.out.println("endcode  " +destinsrt1);
}
/* *********************************************************************************** */ 


/* *********** Checking whether Driver Id is already present or entered new  ************* */
  if(driverid.equals("Other"))
  {
     driveridinsrt=othdrivid;
     drivername=newdrvname;

    sql5="select * from t_drivers where DriverID='"+othdrivid+"' and Owner='"+user+"'";
    
    rs5=stmt1.executeQuery(sql5);
    if(rs5.next())
    {
       response.sendRedirect("tripstart.jsp?duplicate=yes&vehno="+veh);
       return;
    }
    else
    {
       sql6="insert into t_drivers (DriverID, DriverName, Owner,GPNAME,Entryby) values ('"+driveridinsrt+"', '"+newdrvname+"', '"+owner+"','"+user+"','"+entby+"') ";
       
       /*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql6.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		/*****************************/
       stmt2.executeUpdate(sql6);
		
       String sqlInsert1 = "Insert into t_irtedriver( PassportID,DriverName,Owner,GPNAME,EntryBy) values('"+driveridinsrt+"','"+newdrvname+"','"+owner+"','"+user+"','"+entby+"')"; 
      	System.out.println("sqlInsert::"+sqlInsert1);
      	stquery.executeUpdate(sqlInsert1);
      	 String abcd1=sqlInsert1.replace("'","#");	
      		abcd1=abcd1.replace(",","$");								
      		stquery.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
    } 
  }
  else
  {
     driveridinsrt=driverid;
  }

/* *************************************************************************************** */

/* ******************Inserting into t_startedjourney************************ */
if(route.equals("No"))
{
   if(!(dest.equals("Other")))
   {
     sql9="select * from t_warehousedata where WareHouse='"+destinsrt+"' ";
     rs9=stmt1.executeQuery(sql9);
     if(rs9.next())
     {
        latit=rs9.getFloat("Latitude");
        longit=rs9.getFloat("Longitude");
     } 
   }
}

 String sqlcode="Select distinct(Warehousecode),warehouse,Owner from t_warehousedata where Owner='"+user+"' and Warehouse='"+stlocinsrt+"' ";
 ResultSet rstcode=stmtcode.executeQuery(sqlcode);
 System.out.println("sqlcode-------> "+sqlcode);
 if(rstcode.next())
 {
	 String oname=rstcode.getString("Owner");
	 if(rstcode.getString("Warehousecode").equals("-"))
	{
	 
	}
	else
	{
	 	stlocinsrt1start=rstcode.getString("Warehousecode");
	 	System.out.println("Warehousecode11111  " +stlocinsrt1);
	}
	
	 String warehouse=rstcode.getString("warehouse");
 
 
 }
 String sqlcode1="Select distinct(Warehousecode),warehouse,Owner from t_warehousedata where Owner='"+user+"' and Warehouse='"+destinsrt+"' ";
 ResultSet rstcode1=stmtcode.executeQuery(sqlcode1);
 System.out.println("sqlcode end-------> "+sqlcode1);
 if(rstcode1.next())
 {
	 String oname1=rstcode1.getString("Owner");
	if(rstcode1.getString("Warehousecode").equals("-"))
	{
	 
	}
	else
	{
		destinsrt1dest=rstcode1.getString("Warehousecode");
	 	System.out.println("Warehousecode1111122222destr  " +destinsrt1dest);
	}
	
	 String warehouse1=rstcode1.getString("warehouse");
 
 
 }
 try{
 
 String sqlroute="select * from t_castrolroutes where StartPlace='"+stlocinsrt+"' and StartCode= '"+stlocinsrt1+"' and EndPlace='"+destinsrt+"' and  EndCode= '"+destinsrt1+"' || StartPlace='"+destinsrt+"' and StartCode= '"+destinsrt1+"' and EndPlace='"+stlocinsrt+"' and  EndCode= '"+stlocinsrt1+"' limit 1 ";
 ResultSet rstroute=stmtroute.executeQuery(sqlroute);
 System.out.println("Query castrolroute"+sqlroute);
 if(rstroute.next())
 {
       String stdkm,stdtime;
       stlocinsrt1start=rstroute.getString("Startcode");
   		System.out.println("sourcecode---> "+stlocinsrt1start);

        destinsrt1dest=rstroute.getString("Endcode");
   		System.out.println("dest code---. >"+destinsrt1dest);

       stdkm=rstroute.getString("Km");
       stdtime=rstroute.getString("TTime");
       System.out.println("In if");
        if(!stdkm.equals(fxdkm) || (!stdtime.equals(ftme)))
        	{
             System.out.println("In update");
             ftme=ftme.replace(":", ".");
        	String upcast="update t_castrolroutes set Km='"+fxdkm+"',TTime='"+ftme+"' where StartPlace='"+stlocinsrt+"' and StartCode= '"+stlocinsrt1+"' and EndPlace='"+destinsrt+"' and  EndCode= '"+destinsrt1+"' || StartPlace='"+destinsrt+"' and StartCode= '"+destinsrt1+"' and EndPlace='"+stlocinsrt+"' and  EndCode= '"+stlocinsrt1+"'";
        	System.out.println("Query Update"+upcast);
        	 	stmtroute1.executeUpdate(upcast);
        	 	
        	 	
        	 	String abcd1=upcast.replace("'","#");
        		abcd1=abcd1.replace(",","$");
        		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
        	
        	}
      
 }  
 
 
else
 {
	System.out.println("KM===>"+fxdkm);
     String sqlroute1="";
     sqlroute1="insert into t_castrolroutes(StartCode,StartPlace,EndCode,EndPlace,Owner,Km,TTime,Updateddate,EntBy) values ('"+stlocinsrt1+"', '"+stlocinsrt+"', '"+destinsrt1+"', '"+destinsrt+"','"+user+"','"+fxdkm+"','"+ftme+"','"+s+"','"+user+"') ";
    
     stmtroute1.executeUpdate(sqlroute1);
     System.out.println("insert----------------> "+sqlroute1);
     
        String abcd1=sqlroute1.replace("'","#");
		abcd1=abcd1.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
     
 }
  
 String sqlroute1="select * from t_castrolroutes where StartPlace='"+stlocinsrt+"' and StartCode= '"+stlocinsrt1+"' and EndPlace='"+destinsrt+"' and  EndCode= '"+destinsrt1+"' || StartPlace='"+destinsrt+"' and StartCode= '"+destinsrt1+"' and EndPlace='"+stlocinsrt+"' and  EndCode= '"+stlocinsrt1+"' limit 1 ";
 ResultSet rstroute1=stmtroute.executeQuery(sqlroute1);
 System.out.println("Query castrolroute"+sqlroute1);
 if(rstroute1.next())
 {
	 
	      stlocinsrt1start=rstroute1.getString("Startcode");
	     	System.out.println("sourcecode111111111111---> "+stlocinsrt1start);

	       destinsrt1dest=rstroute1.getString("Endcode");
	     	System.out.println("dest code111111111---. >"+destinsrt1dest);
	 
 }
 
 //code for sending instructions to device 
 
 String jrm="",codeversion="",routeid="",routeID="",mob="",sms="",oname="";
 int No_Of_Files=0,filereceived=0;
		//String newrouteid="";
 String	unitid="";
 java.util.Date d12=new java.util.Date();  	
	Format frt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Format frt3=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
	String now1= frt2.format(d12);
	String now2= frt3.format(d12);
 try
	{
	 	String unitcheck="select instruction,UnitID,OwnerName from db_gps.t_vehicledetails where VehicleCode='"+vehcode+"'";
		System.out.println("unitcheck query->  "+unitcheck);
		ResultSet rsunit=stmtunit.executeQuery(unitcheck);
		if(rsunit.next())
		{
			jrm=rsunit.getString("Instruction");
			unitid=rsunit.getString("UnitID");
			oname=rsunit.getString("OwnerName");

		}
		
		System.out.println("JRM:-"+jrm);
		System.out.println("Unit ID:-"+unitid);
		System.out.println("Owner:-"+oname);
		if(jrm.equals("JRM"))
		{
			// check JRM unit install in that vehicle or not...
			String checkinstall="select Peripherals from db_gps.t_unitmaster where UnitID='"+unitid+"' and Peripherals like '%JRM%'";
			System.out.println("checkinstall:-"+checkinstall);
			ResultSet rsinstall=stmtunit.executeQuery(checkinstall);
			if(rsinstall.next()){
				
				codeversion=rsinstall.getString("Peripherals");
				System.out.println("codeversion"+codeversion);
				
				String sqlrouteid="select routeid from db_gps.t_ftplastdump where UnitID='"+unitid+"' ";
				System.out.println("sqlrouteid:-"+sqlrouteid);
				ResultSet rsroute=stmtunit.executeQuery(sqlrouteid);
				if(rsroute.next()){
					routeid=rsroute.getString("routeid");
					System.out.println("routeid:-"+routeid);
					
					String checkroute="select JRMRouteID,No_Of_Files from db_gps.t_castrolroutes where  StartCode = '"+stlocinsrt1+"' AND EndCode = '"+destinsrt1+"'";
					System.out.println("checkroute"+checkroute);
					ResultSet rs=stmtunit.executeQuery(checkroute);
					if(rs.next()){
					String newrouteid=rs.getString("JRMRouteID");
						No_Of_Files=rs.getInt("No_Of_Files");
						
						if(routeid==newrouteid ||routeid.contains(newrouteid) || routeid.equals(newrouteid))
						{
							  System.out.println("route present no need to take any action...");
								
								
								BufferedWriter writer = null;
								try{
									
											
							
									writer = new BufferedWriter( new FileWriter( "/home/javaprg/Attachments/JRMEqualRouts.txt",true));
									//writer = new BufferedWriter( new FileWriter( "/home/a_thakur/Desktop/JD/JRMSMS.txt",true));
									writer.write("----------------------------------------------------------------------------------------------------------------");
									writer.newLine();
									writer.write( "UnitID  : "+unitid);
									writer.newLine();
									writer.write(  "newrouteid : "+newrouteid);
									writer.newLine();
									writer.write(  "No_Of_Files : "+No_Of_Files);
									writer.newLine();
									writer.write(  "jrmrouteidint : "+routeid);
									writer.newLine();
								
									writer.write("----------------------------------------------------------------------------------------------------------------");
									writer.newLine(); 	writer.newLine();  writer.newLine();
									writer.flush();
									//System.out.println("write successful in CATCH block");
								}catch (Exception ee) {
									System.out.println("xx"+ee);
									//ee.printStackTrace();
								}
								finally
								{		try	{
												if ( writer != null)
													writer.close( );
											}
										catch ( IOException e)	{	}
								}
						
							
							
						}else
						{
						routeid=newrouteid;
						String mobilequery="select MobNo from t_unitmaster where UnitID='"+unitid+"'";
						System.out.println("mobilequery"+mobilequery);
						ResultSet rsmobile=stmtunit.executeQuery(mobilequery);
						if(rsmobile.next())
						{
							mob=rsmobile.getString("MobNo");
							
						//	mob="9561031265";
							sms="UI"+unitid+"#SET0010:0000,JRMON,"+No_Of_Files+","+routeid+"";
							System.out.println("\nSMS Forrmat--->>"+sms);
							Boolean done=false;
						
						
							if(No_Of_Files!=0 || Integer.parseInt(routeid)!=0)
						    {
						    	String msg="If ftplastdump routeid not match with t_castrolroute routeid";
						    //	System.out.println("\n\n sms send to unit");
								Saveunitsms(sms,vehcode,unitid,veh,msg);
								String ProgramName="Manual Trip Entry";
								String jrmstatus = "insert into t_newjrmsmsstatus(TripID,VehCode,VehRegNumber,UnitID,RouteID,JRMStatus,JRMCommandDateTime,MobileNo,SMSText,ProgramName,FileCount)values('"+tripid+"','"+vehcode+"','"+veh+"','"+unitid+"','"+routeid+"','pending','"+now1+"','"+mob+"','"+sms+"','"+ProgramName+"','"+No_Of_Files+"')";
								stmtunit.executeUpdate(jrmstatus);
								System.out.println("NEW JRmstatus Query ---->"+jrmstatus);
								String jrmstatus1 = "insert into t_newjrmsmsstatushistory(TripID,VehCode,VehRegNumber,UnitID,RouteID,JRMStatus,JRMCommandDateTime,MobileNo,SMSText,ProgramName,FileCount)values('"+tripid+"','"+vehcode+"','"+veh+"','"+unitid+"','"+routeid+"','pending','"+now1+"','"+mob+"','"+sms+"','"+ProgramName+"','"+No_Of_Files+"')";
								System.out.println("NEW JRmstatus History Query ---->"+jrmstatus1);
								stmtunit.executeUpdate(jrmstatus1);
							//	System.out.println("NEW JRmstatus History Query ---->"+jrmstatus1);
								done=send(sms,mob,unitid);
						    }
							if(done.equals("true") || done==true)
							{
								String SqlUp="update t_newjrmsmsstatus Set JRMStatus='Send' where TripID='"+tripid+"' and UnitID='"+unitid+"' ";
								stmtunit.executeUpdate(SqlUp);
								
							}
							else
							{
								System.out.println("\n\n sms not send to unit");
							}
							
						}
						}
					}else{
						
						try
						{
							 String JRMCheckRoute="insert into db_gps.t_JRMCheckRoute(Vehcode,TripId,VehRegNo,OwnerName,StdCode,EndCode,UpdatedDateTime)values('"+vehcode+"','"+tripid+"','"+veh+"','"+oname+"','"+stlocinsrt1+"','"+destinsrt1+"','"+now1+"')";
							 System.out.println("JRMCheckRoute Query ---->"+JRMCheckRoute);
							 stmtunit.executeUpdate(JRMCheckRoute);
						}
						catch(Exception e)
						{
								e.printStackTrace();
								
						}
						
					}
				}else{
					String newrouteid="";
					String checkroute="select JRMRouteID,No_Of_Files from db_gps.t_castrolroutes where  StartCode = '"+stlocinsrt1+"' AND EndCode = '"+destinsrt1+"'";
					//	System.out.println("\n\ncheckroute qry-->>"+checkroute);
						ResultSet rscheckroute=stmtunit.executeQuery(checkroute);
						if(rscheckroute.next())
						{
						newrouteid=rscheckroute.getString("JRMRouteID");
						No_Of_Files=rscheckroute.getInt("No_Of_Files");
						//No_Of_Files=20;
						//System.out.println("\n\n jrmrouteidint-->> "+jrmrouteidint);
					//	System.out.println("\n\n newrouteid-->> "+newrouteid);
						}
						String mobilequery="select MobNo from t_unitmaster where UnitID='"+unitid+"'";
					//	System.out.println("mobilequery query--->>"+mobilequery);
						//No_Of_Files=20;
						ResultSet rs=stmtunit.executeQuery(mobilequery);
						if(rs.next())
						{
							mob=rs.getString("MobNo");
						
						//	mob="9561031265";
							
							sms="UI"+unitid+"#SET0010:0000,JRMON,"+No_Of_Files+","+newrouteid+"";
						//	System.out.println("\nSMS Forrmat--->>"+sms);
						//	mob="7588004801";
							Boolean done=false;
							if(No_Of_Files!=0 || Integer.parseInt(newrouteid)!=0)
						    {
						    	String msg="If ftplastdump unit id not match or present";
						    	System.out.println("\n\n sms send to unit");
								Saveunitsms(sms,vehcode,unitid,veh,msg);
								String ProgramName="By_JD";
								String jrmstatus = "insert into t_newjrmsmsstatus(TripID,VehCode,VehRegNumber,UnitID,RouteID,JRMStatus,JRMCommandDateTime,MobileNo,SMSText,ProgramName,FileCount)values('"+tripid+"','"+vehcode+"','"+veh+"','"+unitid+"','"+routeid+"','pending','"+now1+"','"+mob+"','"+sms+"','"+ProgramName+"','"+No_Of_Files+"')";

								//String jrmstatus = "insert into t_newjrmsmsstatus(TripID,UnitID,RouteID,JRMStatus,DateTime1,MobileNo,SMSText,ProgramName,FileCount)values('"+tripid+"','"+unitid+"','"+routeid+"','pending','"+now1+"','"+mob+"','"+sms+"','"+ProgramName+"','"+No_Of_Files+"')";
								stmtunit.executeUpdate(jrmstatus);
							//	System.out.println("NEW JRmstatus Query ---->"+jrmstatus);
								String jrmstatus1 = "insert into t_newjrmsmsstatushistory(TripID,VehCode,VehRegNumber,UnitID,RouteID,JRMStatus,JRMCommandDateTime,MobileNo,SMSText,ProgramName,FileCount)values('"+tripid+"','"+vehcode+"','"+veh+"','"+unitid+"','"+routeid+"','pending','"+now1+"','"+mob+"','"+sms+"','"+ProgramName+"','"+No_Of_Files+"')";
							//	System.out.println("NEW JRmstatus History Query ---->"+jrmstatus1);
								stmtunit.executeUpdate(jrmstatus1);
							//	System.out.println("NEW JRmstatus History Query ---->"+jrmstatus1);
								done=send(sms,mob,unitid);
						    }
							if(done.equals("true") || done==true)
							{
								String SqlUp="update t_newjrmsmsstatus Set JRMStatus='Send' where TripID='"+tripid+"' and UnitID='"+unitid+"' ";
								stmtunit.executeUpdate(SqlUp);
								
							}
							else
							{
								System.out.println("\n\n sms not send to unit");
							}
							   
								
							
						}
					
				}
				
				
				
			}
			
		}
	 
	 
	 
	}catch(Exception e){
		System.out.println("Exception in Sending instruction to device");
		e.printStackTrace();
	}
 
 %>
 <%! 
 private  Boolean send(String sms,String MobileNo,String unitid) {
		try{
			System.out.println("now in send function   now in send function-------------------------------------------->");
			
			String owner="",regno="";
			String sqlchkunit="select * from db_gps.t_vehicledetails where UnitID='"+unitid+"'";
			ResultSet rschk=stsend.executeQuery(sqlchkunit);
			System.out.print("SMS Sending t_vehicledetails querry:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  "+sqlchkunit);
			if(rschk.next())
			{
				
				owner=rschk.getString("OwnerName");
				regno=rschk.getString("VehicleRegNumber");
				
			}
			
			
			
			String SqlInsertSMS="Insert into t_serveralerts(Message,MobNo,SentStatus,EntryBy,unitid,Transporter,VehicleRegNo)values('"+sms+"','"+MobileNo+"','No','Manual Trip Entry','"+unitid+"','"+owner+"','"+regno+"')";
		///	System.out.print("SMS Sending:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  "+SqlInsertSMS);
			stsend.executeUpdate(SqlInsertSMS);
		//	System.out.print("SMS Sending:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  "+SqlInsertSMS);
			return true;

		} catch (Exception e) 
		{
			System.out.print("SMS Sending Exception --->"+e);
			
			return false;



		}
		
	}
 
 
 public static void Saveunitsms(String sms,String vehocde,String unitid,String vehregno,String msg){
		try{
			BufferedWriter writer = null;
			try{
				
				System.out.println("In Save Unit Message..............");
		        //savemsg(sms,unitid,msg);
			    writer = new BufferedWriter( new FileWriter( "/home/javaprg/Attachments/JRMSMS.txt",true));
				//writer = new BufferedWriter( new FileWriter( "/home/a_thakur/Desktop/JD/JRMSMS.txt",true));
				writer.write("----------------------------------------------------------------------------------------------------------------");
				writer.newLine();
				writer.write( "UnitID  : "+unitid);
				writer.newLine();
				writer.write(  "Vehcode : "+vehocde);
				writer.newLine();
				writer.write(  "VehRegNo : "+vehregno);
				writer.newLine();
				writer.write(  "JRM SMS : "+sms);
				writer.newLine();
			
				writer.write("----------------------------------------------------------------------------------------------------------------");
				writer.newLine(); 	writer.newLine();  writer.newLine();
				writer.flush();
			System.out.println("End Save Unit Message...............");
			}catch (Exception ee) {
				System.out.println("xx"+ee);
			//	SaveException(ee.toString(),"Exception al line 2414");
			}
			finally
			{		try	{
							if ( writer != null)
								writer.close( );
						}
					catch ( IOException e)	{	}
			}
		  }catch (Exception e) { }
		}
 %>
 
 <% 
 
 //end of code for sending instructions
 
 
 
 
  try
  {
	  sql2="insert into t_startedjourney (TripId, VehId, VehRegNo, StartPlace, StartCode, EndPlace, EndCode, EndLat, EndLong, ReportDateTime, StartDate, StartTime, DriverCode, DriverName, Ownername, GPName, JStatus, ETA,Weight,Vendor,timetochecktripend,FIxedKm,FIxedTime,TripCategory,GoodsContent,Advance,Frieght,Loadreason,Loadcomments,EntryBy,customerMailID,cnnumber,lrissuedby,lrcontact,branchoffice,cnfilename,rate_hour,rate_km,tripexpence,joborderno,revenue,containerno,LPO,trailerno,customercontperson,customercontno,containertype,tokenno,tokenchargespaid,salesperson,containerstatus,tripissuedate) values ('"+tripid.replaceAll("'"," ")+"', '"+vehcode+"', '"+veh+"','"+stlocinsrt.replaceAll("'"," ")+"', '"+stlocinsrt1start+"', '"+destinsrt.replaceAll("'"," ")+"', '"+destinsrt1dest+"', '"+latit+"', '"+longit+"','"+rptdttm+"', '"+stdate+"', '"+sttime+"', '"+driveridinsrt.replaceAll("'"," ")+"','"+drivername.replaceAll("'"," ")+"','"+owner.replaceAll("'"," ")+"','"+user.replaceAll("'"," ")+"','Running', '"+etadate+" "+etatime+"','"+weight+"','"+vendor.replaceAll("'"," ")+"','"+s+"','"+fxdkm+"','"+ftme+"','"+TripCategory.replaceAll("'"," ")+"','"+GoodsContent.replaceAll("'"," ")+"','"+adv+"','"+frie+"','"+loadreason.replaceAll("'"," ")+"','"+loadcmnt.replaceAll("'"," ")+"','"+entby+"','"+allemailid+"','"+cnno.replaceAll("'"," ")+"','"+lrissue+"','"+lrcontact+"','"+boffice.replaceAll("'"," ")+"','"+InsertDateTime+"_"+itemName+"','"+rateperhour+"','"+rateperkm+"','"+tripexpence+"','"+joborderno+"','"+revenue+"','"+containerno+"','"+lpo+"','"+trailerno+"','"+customercontperson+"','"+customercontno+"','"+containertype+"','"+tokenno+"','"+tokenchargespaid+"','"+saleperson+"','"+containerstatus+"','"+Tripissuedate1+"') ";
	  System.out.println("sql2:-"+sql2);
  }
  catch(Exception e)
  {
	  System.out.println("there is an error UFFFF :- "+e);
  }
 
  System.out.println("sql2 started journey"+sql2);
 
  	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd1=sql2.replace("'","#");
	abcd1=abcd1.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
	/*****************************/
  	System.out.println("~~~~~!!! sql2 started journey !!!"+sql2);
	stmt2.executeUpdate(sql2);
 	System.out.println("sql2 started journey"+sql2);
  /*sql3="insert into t_startedjourneynew (TripId, VehId, VehRegNo, StartPlace, StartCode, EndPlace, EndCode, EndLat, EndLong, ReportDateTime, StartDate, StartTime, DriverCode, DriverName, Ownername, GPName, JStatus, ETA,Weight,Vendor,timetochecktripend,FixedKm,FIxedTime,TripCategory,Advance,Frieght,Loadreason,Loadcomments,EntryBy) values ('"+tripid+"', '"+vehcode+"', '"+veh+"','"+stlocinsrt+"', '"+stlocinsrt1+"', '"+destinsrt+"', '"+destinsrt1+"', '"+latit+"', '"+longit+"','"+rptdttm+"', '"+stdate+"', '"+sttime+"', '"+driveridinsrt+"','"+drivername+"','"+user+"','"+user+"','Running', '"+etadate+" "+etatime+"','"+weight+"','"+vendor+"','"+s+"','"+fxdkm+"','"+ftme+"','"+TripCategory+"','"+adv+"','"+frie+"','"+loadreason+"','"+loadcmnt+"','"+entby+"') ";
  
  /*Query to insert query in db_gps.t_sqlquery table*/
	/*String abcd2=sql3.replace("'","#");
	abcd2=abcd2.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
	
	/*****************************/
  
  /*stmt1.executeUpdate(sql3);*/
/* *************************************************************************************** */
 }catch(Exception e)
 {
	 e.printStackTrace();
		System.out.println("Exception5----->" +e); 

 }
if(!othstrtloc.equals(""))
{
 sql7="insert into t_warehousedata(WareHouse,Owner) values('"+othstrtloc+"','"+user+"')";
 
 /*Query to insert query in db_gps.t_sqlquery table*/
	String abcd3=sql7.replace("'","#");
	abcd3=abcd3.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd3+"')");
	
	/*****************************/
 
 stmt3.executeUpdate(sql7);
}

if(!othdest.equals(""))
{
 sql7="insert into t_warehousedata(WareHouse,Owner) values('"+othdest+"','"+user+"')";
 
 /*Query to insert query in db_gps.t_sqlquery table*/
	String abcd4=sql7.replace("'","#");
	abcd4=abcd4.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd4+"')");
	
	/*****************************/
 
 stmt3.executeUpdate(sql7);
}
		//GoodsContent,weight,cnno
		System.out.println("~~~~~ hk ~~~~~ the values are:- GoodsContent:- "+GoodsContent+"weight:- "+weight+"cnno:- "+cnno);
		//Insert into Allpendingmailtable=================================================
		String Customer = "", CustType = "", Trip = "", toID = "", ccID = "",toID1="",ccID1="";
		
		//String transporter="ETAAlert"+owner.replaceAll("'"," ");
		String transporter="ETAAlert"+user.replaceAll("'"," ");
		
		String sqlmaster = "Select * from db_gps.t_alertmaster where AlertName = 'TripEntryAlert' and Customer='"+user+"'" ;
		System.out.println("2 sqlmaster " + sqlmaster);
		ResultSet rsmaster = stmaster.executeQuery(sqlmaster);
		if(rsmaster.next())
		{
			Customer = rsmaster.getString("Customer").trim();
			System.out.println("Customer :- "+Customer+" and user.trim() is :- "+user.trim());
			CustType = rsmaster.getString("CustType").trim();
			Trip = rsmaster.getString("Trip").trim();
			toID = rsmaster.getString("ToID").trim();
			
			ccID = rsmaster.getString("ToCC").trim();
			
			System.out.println(" Customer :- "+Customer+"CustType:- "+CustType+"Trip:- "+Trip+"toID :- "+toID+"ccid :- "+ccID);
		//}
		
		//String sqlmaster11="select toid, Tocc from db_gps.t_branchwisemailid where ownername='"+user1+"' and branch='"+destinsrt+"'";
		String sqlmaster11="select toid, Tocc from db_gps.t_branchwisemailid where ownername='"+transporter+"' and branch='"+destinsrt+"'";
		System.out.println("1 sqlmaster11 " + sqlmaster11);
		Statement stmt11=con1.createStatement();
		ResultSet rsmaster11=stmt11.executeQuery(sqlmaster11);
		if(rsmaster11.next())
		{
			toID=rsmaster11.getString("toid").trim();
			ccID=rsmaster11.getString("Tocc").trim();
			
		}
		System.out.println("toID"+toID);
		System.out.println("ccID"+ccID);
		System.out.println(" Trip "+Trip+" Customer "+Customer+" user.trim() "+user.trim()+" CustType "+CustType);
		
		if((Trip.equals("Trip") || Trip == "Trip")  && (Customer.equalsIgnoreCase(user.trim()) || Customer == user.trim()))//&& (Customer.equalsIgnoreCase(user.trim()) || Customer == user.trim())
		{
			System.out.println("In if");
			
				String subject = "Trip Entry Report for "+owner+"-"+veh+" on "+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
		 		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		        Calendar cal = Calendar.getInstance();
		        String DateTime = dateFormat.format(cal.getTime());
		        
		        System.out.println("IN THE IF STATEMENT WHERE WE WRITE THE HTML STRING");
		        String strhtml = "";
		        strhtml = "<table width=100% > ";
			    strhtml = strhtml+"<tr><td><table align=left  cellpadding=10 cellspacing=5 width=100% border=1 style=^border-collapse: collapse;^>";
			    
			    strhtml = strhtml+"<tr bgcolor=^#ADDFFF^><td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Sr<br>No </b></font></td>"+
			    		"<td align=center style=^width: 5%;^ ><font size=^2^ face=^arial^><b>JobOder</b></font></td>"+
			    		"<td align=center style=^width: 10%;^ ><font size=^2^ face=^arial^><b> Invoice Number</b></font></td>"+
			    		"<td align=center style=^width: 25%;^><font size=^2^ face=^arial^><b> Vehicle No </b></font></td>"+
			    		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Transporter </b></font></td>"+
			    		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Report Date Time </b></font></td>"+
			    		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> Start Date Time</b></font></td>"+
			    		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b> ETA </b></font></td>"+
			    		"<td align=center style=^width: 10%;^ ><font size=^2^ face=^arial^><b> Product</b></font></td>"+
			    		"<td align=center style=^width: 5%;^ ><font size=^2^ face=^arial^><b> Weight<br>(Kgs.) </b></font></td>"+
			    		"<td align=center style=^width: 20%;^^><font size=^2^ face=^arial^><b> Origin </b></font></td>"+
			    		"<td align=center style=^width: 25%;^><font size=^2^ face=^arial^><b> Destination </b></font></td> "+
			    		"<td align=center style=^width: 10%;^ ><font size=^2^ face=^arial^><b>TripCategory</b></font></td>"+
			    		"<td align=center style=^width: 15%;^ ><font size=^2^ face=^arial^><b>Vendor</b></font></td>"+
			    		"<td align=center style=^width: 10%;^ ><font size=^2^ face=^arial^><b>Driver</b></font></td>"+
			    		"<td align=center style=^width: 5%;^ ><font size=^2^ face=^arial^><b>ContainerNO</b></font></td>"+
			    		"<td align=center style=^width: 5%;^ ><font size=^2^ face=^arial^><b>Revenue</b></font></td>"+
			    		"<td align=center style=^width: 5%;^><font size=^2^ face=^arial^><b> Trip<br>ID </b></font></td>"+
			    		"<td align=center style=^width: 10%;^><font size=^2^ face=^arial^><b>Entry<br>By </b></font></td><td align=center style=^width: 10%;^ ><font size=^2^ face=^arial^><b>Enter On</b></font></td>";
			    		  
			    		
			    		strhtml = strhtml+"<tr><td align=left><font size=^2^ face=^arial^>1</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+joborderno+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+cnno+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+veh+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+owner+"</font></td>"+
			    				  "<td align=right><font size=^2^ face=^arial^>"+calender1+" "+rpttimehour+":"+rpttimemin+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+calender+" "+sttimehour+":"+sttimemin+"</font></td>"+
			    				  "<td align=right><font size=^2^ face=^arial^>"+etadate1+" "+etatime1+":"+etatime2+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+GoodsContent+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+weight+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+stloc+"</font></td><td align=left><font size=^2^ face=^arial^>"+dest+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+TripCategory+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+vendor+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+drivername+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+containerno+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+revenue+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+tripid+"</font></td>"+
			    				  "<td align=left><font size=^2^ face=^arial^>"+entby+"</font></td><td align=right><font size=^2^ face=^arial^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date()) +"</font></td>";
			    		  
			    				  
				strhtml = strhtml + "</table></td></tr>";
		        
		        //Mail Format
		        String html = "<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head>"+
 						"<body><table    bordehtmlr=^18^  bordercolor=^#E6E6FA^ align=^center^ width=^60%^><tr align=^center^><td align=^left^ style=^border: 0px;^ width=^100%^>"+
 						"<table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ ><tr><td><a href=^http://www.mobile-eye.in^ target=^_blank^>"+
 						"<img src=^http://myfleetview.com/DiarySystem/images/mobile.jpg^ style=^height: 80px; width: 100px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td><td  align = ^right^ >"+
 						"<img src=^http://myfleetview.com/FleetView/newimages/transworld.jpg^  style=^height: 80px; width: 400px;^ /></td></tr></table> <font style=^color: #D8D8D8^>"+
 						"________________________________________________________________________________________________________________________________________________</font><br><div width = ^100%^><font size = ^3^ face = ^Arial^>"+
 						" <a href=^http://www.myfleetview.com^>www.myFleetView.com</a><br>"+"\nTrip Entry Report for "+owner+"-"+veh+" on "+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())+"</font><br><table><tr><td align = center style = ^margin-left:20px;^>";
		        html = html + strhtml;
		         
		        html = html + "<tr><td align = left><table align= left><br></br><tr><td><font size=^3^ face=^Arial^>Transworld Support Team</font></td></tr><tr><td><font size=^3^ face=^Arial^>Phone: +91-20-41214444  +91-9762007124 +91-9762007125</font></td></tr><tr><td><font size=^3^ face=^Arial^>Email: avlsupport@mobile-eye.in</font></td></tr><tr><td></td></tr><tr><td><font size=^3^ face=^Arial^>Thanks and Regards</font></td></tr><tr><td><font size=^3^ face=^Arial^>Transworld Team</font></td></tr></table></td></tr></table></div></td></tr></table></td></tr></table></body></html>";
	          	
		        System.out.println("The html data ==>"+html);
		        		        
	            String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName)values('TWSupport','New Mail for Trip Entry Report','"+html+"','"+subject+"','"+toID+"','"+ccID+"','"+DateTime+"','Pending','Transworld')";//'"+ccID+"','"+toID+"','h_kulkarni@transworld-compressor.com,r_maner@transworld-compressor.com'
	            System.out.println(" trip entry  "+q2);
	            stmail.executeUpdate(q2);
	            System.out.println("the record has been successfully inserted into table the query is :- "+q2); 
		%><html><head><script type="text/javascript"> alert("successfully inserted into all pending mail table"); 
        </script></head></html>
		<% 
		}      
		
}//if end for Alertmaster
		//=================================================================================================


 response.sendRedirect("currentposition.jsp?inserted=yes");
 return; 
}
}
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception67----->" +e); 

}
} catch(Exception e) { 
	e.printStackTrace();
	System.out.println("Exception----->" +e); 
	}
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{
		
	}
} 
%>
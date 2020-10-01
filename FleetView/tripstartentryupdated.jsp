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
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stup1=con1.createStatement(),stup2=con1.createStatement(),stup3=con1.createStatement();
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(),stmt3=con1.createStatement(),stmtcode=con1.createStatement();
Statement stquery=con1.createStatement(),stquery1=con1.createStatement(),stquery2=con1.createStatement(),stquery3=con1.createStatement();
ResultSet rs1=null, rs15=null, rs5=null, rs6=null, rs9=null;
String sql1="", sql15="", sql5="", sql6="", sql9="", sql2="", sql3="",sql4="";
String route="",entby="", veh="", stloc="", othstloc="", stdate="", sttimehour="", sttimemin="",endp="",strdate="",rptdate="", rpttimehour="", rpttimemin="",rptdttm="", 
dest="", othdest="", driverid="", othdrivid="", newdrvname="", drivername="",itemName="",calender="",calender1="",tripid="", stloc1="",tripid1="",vendor="",othvendor="",dest1="",content="",othcontent="" ;
String lrissue="",lrcontact="",boffice="",cnno="";
String fname="",fname1="",fname2="";
String sqlup1="",sqlup2="",sqlup3="";
String loadcmnt="",othLoadreason="",loadreason="",adv="",frie="",othTripCategory="",ftme="",fxdkm="",TripCategory="";
String[] filepath =new String[3];
String[] filename =new String[3];
int saveflag=0;
int  filecount = 0,count1 = 0,i=0;
File savedFile;
int flag2=0;
Boolean flag=false,flag1=true;
String savefilestring="";
String vehcode="", stlocinsrt="",stlocinsrt1="",pod="",destinsrt="",destinsrt1="",driveridinsrt="", user="", sttime="", etadate="", etatime1="", etatime2="", etatime="",weight="";
float latit=0, longit=0;

String tripflag="";
String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());


 
/*if(session.getAttribute("tripflag").toString()!=null)
{
  tripflag=session.getAttribute("tripflag").toString();
  session.removeAttribute("tripflag");
}
*/

user=session.getValue("usertypevalue").toString();
entby=session.getAttribute("dispalyname").toString();

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
	} catch (FileUploadException e) {
		e.printStackTrace();
	}
	Iterator itr = items.iterator();

	while (itr.hasNext()) {
		FileItem item = (FileItem) itr.next();
		if(item.isFormField()) 
		{
			String name = item.getFieldName();
			System.out.print("\n name==>"+name);
			String value = item.getString();
			

			
			
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
			if(name.equals("tripflag")) 
			{
				tripflag = value;
				System.out.print("\n tripflag==>"+tripflag);
				count1 = 1;
			}
			
			
			if(name.equals("stloc")) 
			{
				stloc = value;
				System.out.print("\n stloc==>"+stloc);
				count1 = 1;
			}
			
			///hh
			if(name.equals("dest")) 
			{
				endp = value;
				System.out.print("\n endp==>"+endp);
				count1 = 1;
			}
			
			if(name.equals("strdate")) 
			{
				strdate = value;
				System.out.print("\n strdate==>"+strdate);
				count1 = 1;
			}
			
			if(name.equals("othstrtloc")) 
			{
				othstloc = value;
				System.out.print("\n othstloc==>"+othstloc);
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
			
		
			if(name.equals("tripid")) 
			{
				tripid = value;
				System.out.print("\n tripid==>"+tripid);
				count1 = 1;
			}
			
			if(name.equals("triid")) 
			{
				tripid1 = value;
				System.out.print("\n tripid1==>"+tripid1);
				count1 = 1;
			}
			
			if(name.equals("stloc1")) 
			{
				stloc1 = value;
				System.out.print("\n stloc1==>"+stloc1);
				count1 = 1;
			}
			if(name.equals("dest1")) 
			{
				dest1 = value;
				System.out.print("\n dest1==>"+dest1);
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
			if(name.equals("content")) 
			{
				content = value;
				System.out.print("\n content==>"+content);
				count1 = 1;
			}
			
			if(name.equals("vendor")) 
			{
				vendor = value;
				System.out.print("\n vendor==>"+vendor);
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
			if(name.equals("weight")) 
			{
				weight = value;
				System.out.print("\n weight==>"+weight);
				count1 = 1;
			}
			
		
			
			if(name.equals("othvendor")) 
			{
				othvendor = value;
				System.out.print("\n othvendor==>"+othvendor);
				count1 = 1;
			}
			
			if(name.equals("othcontent")) 
			{
				othcontent = value;
				System.out.print("\n othcontent==>"+othcontent);
				count1 = 1;
			}
			if(name.equals("TripCategory")) 
			{
				TripCategory = value;
				System.out.print("\n TripCategory==>"+TripCategory);
				count1 = 1;
			}
			if(name.equals("fxdkm")) 
			{
				fxdkm = value;
				System.out.print("\n fxdkm==>"+fxdkm);
				count1 = 1;
			}
			if(name.equals("ftme")) 
			{
				ftme = value;
				System.out.print("\n ftme==>"+ftme);
				count1 = 1;
			}
			
			
			if(name.equals("othTripCategory")) 
			{
				othTripCategory = value;
				System.out.print("\n othTripCategory==>"+othTripCategory);
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
			if(name.equals("Loadreason")) 
			{
				loadreason = value;
				System.out.print("\n loadreason==>"+loadreason);
				count1 = 1;
			}
			
			if(name.equals("othLoadreason")) 
			{
				othLoadreason = value;
				System.out.print("\n othLoadreason==>"+othLoadreason);
				count1 = 1;
			}
			
			
			
			
			if(name.equals("loadcmnt")) 
			{
				loadcmnt = value;
				System.out.print("\n loadcmnt==>"+loadcmnt);
				count1 = 1;
			}
			if(name.equals("podnumber")) 
			{
				pod = value;
				System.out.print("\n loadcmnt==>"+pod);
				count1 = 1;
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
				etadate = value;
				System.out.print("\n etadate==>"+etadate);
				count1 = 1;
			}
			if(name.equals("f6"))
			{
				fname = value;
				System.out.print("\n fname==>"+fname);

				count1 =1;
			}
			if(name.equals("f7"))
			{
				fname1 = value;
				System.out.print("\n fname1==>"+fname1);

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

						 savedFile = new File("/usr/share/tomcat6/webapps/images1/savedimages/"+InsertDateTime+"_"+itemName);
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
					e.printStackTrace();
				}
					}
					
				}
						
			 catch (Exception e) {
  					e.printStackTrace();
  				}
				}
		
	}
		
		
		
}


String filestring = "-";
String fimage = "-";

System.out.println("******  "+saveflag);
if(saveflag > 2)
{
	System.out.println("****** >2 ");
	filestring = filepath[0]+","+filepath[2];
	fimage = filepath[1];
}
else
if(saveflag == 2 && (fname1== "" || fname1.equals("")))
{
	System.out.println("****** =2  =fname1");
	filestring = filepath[0]+","+filepath[1];
	fimage = "-";
}
else
if(saveflag == 2 && (fname1 != "" || !(fname1.equals(""))))
{
	System.out.println("****** =2  !=fname1");
	filestring = filepath[0];
	fimage = filepath[1];
}
else
if(saveflag < 2 && (fname1 == "" || fname1.equals("")))
{
	System.out.println("****** <2  =fname1");
	filestring = filepath[0];
	fimage ="-";
}
else
	if(saveflag < 2 && (fname1 != "" || !(fname1.equals("")))) 
	{
		System.out.println("****** <2  !=fname1");
		filestring = "-";
		fimage =filepath[0];
	}



String Msg = "0";
System.out.println("^^^^^   "+filestring+"   ^^^^^^^^^   "+fimage);


System.out.println("^^^^^   "+fname+"   ^^^^^^^^^   "+fname1);






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
etadate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(etadate));
}catch(Exception e)
{
	
e.printStackTrace();
}
rptdttm=rptdate+" "+rpttimehour+":"+rpttimemin+":00";


sttime=sttimehour+":"+sttimemin+":00";
etatime=etatime1+":"+etatime2+":00";




try{


	if(null!=veh || null!=cnno || null!=calender || null!=tripid || null!=drivername)
	{





String sqlcode="Select distinct(Warehousecode),warehouse,Owner from t_warehousedata where Owner='"+user+"' and Warehouse='"+stlocinsrt+"' ";
System.out.println("sqlcode-------> "+sqlcode);
ResultSet rstcode=stmtcode.executeQuery(sqlcode);
if(rstcode.next())
{
	// String oname=rstcode.getString("Owner");
if(rstcode.getString("Warehousecode").equals("-"))
{
	stlocinsrt1=stlocinsrt;
}
else
{
	 stlocinsrt1=rstcode.getString("Warehousecode");
}
	
	 //String warehouse=rstcode.getString("warehouse");


}
String sqlcode1="Select distinct(Warehousecode),warehouse,Owner from t_warehousedata where Owner='"+user+"' and Warehouse='"+destinsrt+"' ";
System.out.println("sqlcode-------> "+sqlcode);
ResultSet rstcode1=stmtcode.executeQuery(sqlcode1);
if(rstcode1.next())
{
	// String oname1=rstcode1.getString("Owner");
if(rstcode1.getString("Warehousecode").equals("-"))
{
	destinsrt1= destinsrt;
}
else
{
	destinsrt1=rstcode1.getString("Warehousecode");
}
	
	// String warehouse1=rstcode1.getString("warehouse");


}

sql15="select DriverName from t_drivers where DriverID='"+driverid+"' and Owner='"+user+"' ";
System.out.println("sql15--->"+sql15);
rs15=stmt1.executeQuery(sql15);
if(rs15.next())
{
	drivername=rs15.getString("DriverName");
}
else 
{
	
}
System.out.println("How are you");

if(loadreason.equalsIgnoreCase("Other"))
{
	loadreason=othLoadreason;//othloadreason;
}


if(TripCategory.equalsIgnoreCase("Other"))
{
	TripCategory=othTripCategory;
}
if(content.equalsIgnoreCase("Other"))
{
	content=othcontent;
}

if(vendor.equalsIgnoreCase("Other"))
{
   vendor=othvendor;
}
System.out.println("ggggggggggggggggggggggggggggg" +vendor);
	
			java.util.Date tdydte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String s=formatter.format(tdydte);
 if(stloc.equals("Other"))
    {
	 stlocinsrt1=stloc;
	 // stlocinsrt=stloc;
    }
 else
 {
	 stlocinsrt=stloc;
	 
 
 }
  if(dest.equals("Other"))
  {
     destinsrt=othdest;
   //  destinsrt1=othdest;
  }

else
{
  
  destinsrt=endp;
 
}
  
/* *********************************************************************************** */ 


/* *********** Checking whether Driver Id is already present or entered new  ************* */
 if(driverid.equals("Other"))
  {
     driveridinsrt=othdrivid;
     drivername=newdrvname;
  }
  else
  {
     driveridinsrt=driverid;
  }

 System.out.print("length???" +fname.length());

if(fname.equalsIgnoreCase("-") || fname.length()==0)
{
	sql4="update t_startedjourney set StartPlace='"+stlocinsrt.replaceAll("'"," ")+"',StartCode='"+stlocinsrt1.replaceAll("'"," ")+"', ReportDateTime='"+rptdttm+"', StartDate='"+stdate+"',  StartTime='"+sttimehour+":"+sttimemin+"',EndPlace='"+destinsrt.replaceAll("'"," ")+"',EndCode='"+destinsrt1.replaceAll("'"," ")+"',lrissuedby='"+lrissue.replaceAll("'"," ")+"',lrcontact='"+lrcontact.replaceAll("'"," ")+"',branchoffice='"+boffice.replaceAll("'"," ")+"',DriverCode='"+driveridinsrt.replaceAll("'"," ")+"', DriverName='"+drivername.replaceAll("'"," ")+"',ETA='"+etadate+":"+etatime1+":"+etatime2+"',Weight ='"+weight+"' ,vendor='"+vendor.replaceAll("'"," ")+"',GoodsContent='"+content.replaceAll("'"," ")+"',FixedKm='"+fxdkm+"',FIxedTime='"+ftme+"',TripCategory='"+TripCategory.replaceAll("'"," ")+"',Advance='"+adv+"',Frieght='"+frie+"',Loadreason='"+loadreason.replaceAll("'"," ")+"',Loadcomments='"+loadcmnt.replaceAll("'"," ")+"',cnnumber='"+cnno.replaceAll("'"," ")+"',EntryBy='"+entby+"' where TripID='"+tripid+"'";
	 System.out.print("fname>>>if" +sql4);
	 /*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql4.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	 stmt3.executeUpdate(sql4);

}
else
{
 sqlup1="update t_startedjourney set StartPlace='"+stlocinsrt.replaceAll("'"," ")+"',StartCode='"+stlocinsrt1.replaceAll("'"," ")+"', ReportDateTime='"+rptdttm+"', StartDate='"+stdate+"',  StartTime='"+sttimehour+":"+sttimemin+"',EndPlace='"+destinsrt.replaceAll("'"," ")+"',EndCode='"+destinsrt1.replaceAll("'"," ")+"',lrissuedby='"+lrissue.replaceAll("'"," ")+"',lrcontact='"+lrcontact.replaceAll("'"," ")+"',branchoffice='"+boffice.replaceAll("'"," ")+"',DriverCode='"+driveridinsrt.replaceAll("'"," ")+"', DriverName='"+drivername.replaceAll("'"," ")+"',ETA='"+etadate+":"+etatime1+":"+etatime2+"',Weight ='"+weight+"' ,vendor='"+vendor.replaceAll("'"," ")+"',GoodsContent='"+content.replaceAll("'"," ")+"',FixedKm='"+fxdkm+"',FIxedTime='"+ftme+"',TripCategory='"+TripCategory.replaceAll("'"," ")+"',Advance='"+adv+"',Frieght='"+frie+"',Loadreason='"+loadreason.replaceAll("'"," ")+"',Loadcomments='"+loadcmnt.replaceAll("'"," ")+"',EntryBy='"+entby+"',cnnumber='"+cnno.replaceAll("'"," ")+"',cnfilename='"+InsertDateTime+"_"+fname+"' where TripID='"+tripid+"'";
 System.out.print("fname>>>else" +sqlup1);
 /*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sqlup1.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery1.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
/*****************************/
 stup1.executeUpdate(sqlup1);

}


if(fname1.equalsIgnoreCase("-") || fname1.length()==0 )
{
	sqlup2="update t_completedjourney set pod='"+pod.replaceAll("'"," ")+"' where TripID='"+tripid+"'";
	 System.out.print("fname1>>>if" +sqlup2);
	 /*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sqlup2.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery2.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	 stup2.executeUpdate(sqlup2);

}
else{
 sqlup3="update t_completedjourney set pod='"+pod.replaceAll("'"," ")+"',podfilename='"+InsertDateTime+"_"+fname1+"' where TripID='"+tripid+"'";
 System.out.print("fname1>>>else" +sqlup3);
 /*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sqlup3.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery3.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
/*****************************/
 stup3.executeUpdate(sqlup3);

}











 if(tripflag.equalsIgnoreCase("true"))
 {
 	 response.sendRedirect("my_trips.jsp");
 }
 else
 {
		response.sendRedirect("currentposition.jsp");
		//return;
 
 //response.sendRedirect("currentposition.jsp?updated=yes");
 return;
 }
 }

}catch(Exception e)
 {
	 e.printStackTrace();
 }
}catch(Exception e)
{
	e.printStackTrace();
}
 
 

%>

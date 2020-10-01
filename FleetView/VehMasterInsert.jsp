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
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;

%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	String osrno="0",secap="0",stacap="0",cyl="0",tyres="0",unladewt="0",card="0",gear="0",RLW="0",GVW="0",KG="0",RCBook="0",city="-",state="-";
    String vehregno="-",owner="-",address="-",mfddate=null,model="-",color="-",body="-",tclass="-",fuel="-",make="-",group="-",chassis="-",engine="-",RTO="-",vin="0";
    String regdate = "-",mnfname="-",length1="0",breadth="0",width="0",vehtype="-",usage="-",address1="-",address2="-",pincode="0",RTOstate="-";
    File savedFile;
    int  filecount = 0,count1 = 0,i=0;
    int j=0,k=0,l=0,v=0;
    String savefilestring="";
   String fname="",fname1="",fname2="";
    String[] filepath =new String[3];
    String[] filename =new String[3];
    int saveflag=0;
    String username =(String)session.getAttribute("mainuser");
    String Entdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    String date = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
System.out.println("&&&&&&&&&&&   in insert");
   

int vehid=0;
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
			if(name.equals("element_1")) 
			{
				vehregno = value;
				System.out.print("\n vehregno==>"+vehregno);
				count1 = 1;
			}
			
			
			
			
			
	//		if(name.equals("element_2")) 
	//		{
	//			if(value!="Select" && !(value.equalsIgnoreCase("Select")))
	//			{
	//			vehtype = value;
	//			System.out.print("\n vehtype==>"+vehtype);
	//			count1 = 1;
	//			}
	//		}

			
			
	if(name.equals("element_2")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				   {
					vehtype = value;
					System.out.print("\n vehtype==>"+vehtype);
				count1 = 1;
				v=1;
				   }
			}
			
			if(name.equals("element_50")) 
			{
				if(value.length()>0)
				   {
					vehtype = value;
					System.out.print("\n vehtype==>"+vehtype);
				count1 = 1;
				v=2;
				   }
			}
	
	
			
			if(name.equals("element_3")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				{
				usage = value;
				System.out.print("\n usage==>"+usage);
				count1 = 1;
				}
			}
			if(name.equals("element_6")) 
			{
				if(value.length()>0)
				{
				osrno = value;
				System.out.print("\n osrno==>"+osrno);
				count1 = 1;
				}
			}
			if(name.equals("element_4")) 
			{
				owner = value;
				System.out.print("\n owner==>"+owner);
				count1 = 1;
			}
			if(name.equals("element_5")) 
			{
				owner +=" "+value;
				System.out.print("\n owner==>"+owner);
				count1 = 1;
			}
			if(name.equals("element_8")) 
			{
				if(value.length()>0)
				{
				address = value;
				System.out.print("\n address==>"+address);
				count1 = 1;
				}
			}
			if(name.equals("element_9")) 
			{
				if(value.length()>0)
				{
				address1 = value;
				System.out.print("\n address1==>"+address1);
				count1 = 1;
				}
			}
			if(name.equals("element_10")) 
			{
				if(value.length()>0)
				{
				address2 = value;
				System.out.print("\n address2==>"+address2);
				count1 = 1;
				}
			}
			
			if(name.equals("element_11")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				{
				state = value;
				System.out.print("\n state==>"+state);
				count1 = 1;
				}
			}
			if(name.equals("element_14")) 
			{
				if(value.length()>0)
				{
				state = value;
				System.out.print("\n state==>"+state);
				count1 = 1;
				i=1;
				}
			}
			if(name.equals("element_12")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				{
				city = value;
				System.out.print("\n city==>"+city);
				count1 = 1;
				}
			}
			if(name.equals("element_15")) 
			{
				if(value.length()>0)
				{
				city = value;
				System.out.print("\n city==>"+city);
				count1 = 1;
				i=2;
				}
			}
			if(name.equals("element_13")) 
			{
				if(value.length()>0)
				{
				pincode = value;
				System.out.print("\n pincode==>"+pincode);
				count1 = 1;
				
				}
			}
			if(name.equals("element_18")) 
			{
				mfddate = value;
				System.out.print("\n mfddate==>"+mfddate);
				count1 = 1;
			}
			if(name.equals("element_17")) 
			{
				if(value.length()>0)
				{
				model = value;
				System.out.print("\n model==>"+model);
				count1 = 1;
				}
			}
			if(name.equals("element_41")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
			   {
				color = value;
				System.out.print("\n color==>"+color);
				count1 = 1;
			   }
			}
			if(name.equals("element_33")) 
			{
				body = value;
				System.out.print("\n body==>"+body);
				count1 = 1;
			}
			if(name.equals("element_32")) 
			{
				if(value!="Select"  && !(value.equalsIgnoreCase("Select")))
			{
				tclass = value;
				System.out.print("\n tclass==>"+tclass);
				count1 = 1;
			}
			}
			if(name.equals("element_37")) 
			{
				if(value.length()>0)
				   {
				secap = value;
				System.out.print("\n secap==>"+secap);
				count1 = 1;
				   }
			}
			if(name.equals("element_38")) 
			{
				if(value.length()>0)
				   {
				stacap = value;
				System.out.print("\n stacap==>"+stacap);
				count1 = 1;
				   }
			}
			if(name.equals("element_42")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				   {
				fuel = value;
				System.out.print("\n fuel==>"+fuel);
				count1 = 1;
				   }
			}
			if(name.equals("element_40")) 
			{
				if(value.length()>0)
				   {
				cyl = value;
				System.out.print("\n cyl==>"+cyl);
				count1 = 1;
				   }
			}
			if(name.equals("element_39")) 
			{
				if(value.length()>0)
				   {
				tyres = value;
				System.out.print("\n tyres==>"+tyres);
				count1 = 1;
				   }
			}
			if(name.equals("element_29")) 
			{
				if(value.length()>0)
				   {
				unladewt = value;
				System.out.print("\n unladewt==>"+unladewt);
				count1 = 1;
				   }
			}
			
			if(name.equals("element_26")) 
			{
				
				chassis = value;
				System.out.print("\n chassis==>"+chassis);
				count1 = 1;
			}
			if(name.equals("element_25")) 
			{
				engine = value;
				System.out.print("\n engine==>"+engine);
				count1 = 1;
			}
			if(name.equals("element_27")) 
			{
				if(value.length()>0)
				   {
				gear = value;
				System.out.print("\n gear==>"+gear);
				count1 = 1;
				   }
			}
			if(name.equals("element_28")) 
			{
				if(value.length()>0)
				   {
				vin = value;
				System.out.print("\n vin==>"+vin);
				count1 = 1;
				   }
			}
			
			if(name.equals("element_30")) 
			{
				if(value.length()>0)
				   {
				RLW = value;
				System.out.print("\n RLW==>"+RLW);
				count1 = 1;
				   }
			}
			if(name.equals("element_31")) 
			{
				if(value.length()>0)
				   {
				GVW = value;
				System.out.print("\n GVW==>"+GVW);
				count1 = 1;
				   }
			}
			if(name.equals("element_7")) 
			{
				if(value.length()>0)
				   {
				group = value;
				System.out.print("\n group==>"+group);
				count1 = 1;
				   }
			}
			if(name.equals("element_19")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				   {
				RTO = value;
				System.out.print("\n RTO==>"+RTO);
				count1 = 1;
				k=1;
				   }
			}
			
			if(name.equals("element_23")) 
			{
				if(value.length()>0)
				   {
				RTO = value;
				System.out.print("\n RTO==>"+RTO);
				count1 = 1;
				k=2;
				   }
			}
			
			if(name.equals("element_20")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				   {
				RTOstate = value;
				System.out.print("\n RTOstate==>"+RTOstate);
				count1 = 1;
				l=1;
				   }
			}
			
			if(name.equals("element_24")) 
			{
				if(value.length()>0)
				   {
					RTOstate = value;
				System.out.print("\n RTOstate==>"+RTOstate);
				count1 = 1;
				l=2;
				   }
			}
			
			if(name.equals("element_22")) 
			{
				if(value.length()>0)
				   {
				RCBook = value;
				System.out.print("\n RCBook==>"+RCBook);
				count1 = 1;
				   }
			}
			if(name.equals("element_21")) 
			{
				regdate = value;
				System.out.print("\n regdate==>"+regdate);
				count1 = 1;
				   
			}
			
			if(name.equals("element_16")) 
			{
				if(value!="Select" && !(value.equalsIgnoreCase("Select")))
				   {
				mnfname = value;
				System.out.print("\n mnfname==>"+mnfname);
				count1 = 1;
				j=1;
				   }
			}
			
			if(name.equals("element_45")) 
			{
				if(value.length()>0)
				   {
				mnfname = value;
				System.out.print("\n mnfname==>"+mnfname);
				count1 = 1;
				j=2;
				   }
			}
			
			if(name.equals("element_34")) 
			{
				if(value.length()>0)
				   {
				length1 = value;
				System.out.print("\n length1==>"+length1);
				count1 = 1;
				   }
			}
			if(name.equals("element_35")) 
			{
				if(value.length()>0)
				   {
				breadth = value;
				System.out.print("\n breadth==>"+breadth);
				count1 = 1;
				   }
			}
			if(name.equals("element_36")) 
			{
				if(value.length()>0)
				   {
				width = value;
				System.out.print("\n width==>"+width);
				count1 = 1;
				   }
			}
			if(name.equals("f6"))
			{
				fname = value;
				count1 =1;
			}
			if(name.equals("f7"))
			{
				fname1 = value;
				count1 =1;
			}
			if(name.equals("f8"))
			{
				fname2 = value;
				count1 =1;
			}
		}
		else
		{
			try {

				String itemName = item.getName();
				System.out.print("\n\nitemName==>"+itemName);
				if(itemName.equalsIgnoreCase(""))
				{
				}
				else
				{
					/*
					savedFile = new File("/home/javaprg/docs/"+itemName+" "+date);
					System.out.print("\n\nsavedFile==>"+savedFile);
					item.write(savedFile);
					*/
					System.out.println("HHHHHH  ");
					
					  String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir1"); 
					   System.out.println("IIIIIII  "+FileUploadPath);
						File uploadDir = new File(FileUploadPath);
						System.out.println("IIIIIII  "+uploadDir.toString());
						savedFile = new File(FileUploadPath+"/"+date+" "+itemName);
						System.out.println("IIIIIII  ");
						item.write(savedFile);
						System.out.println("*************  ");
						filepath[filecount]=""+savedFile;
						System.out.println("^^^^^^^^  ");
						filename[filecount]=itemName;
						filecount++;
						if(saveflag==0)
						{
						 savefilestring=""+savedFile;
						 
						}
						else
						{
							savefilestring=savefilestring+","+savedFile;
							String screenshot=savedFile.getAbsolutePath();
							System.out.println("\n\nscreenshot--->>>"+screenshot);
							
						}
						saveflag++;
						
				}
						
			} catch (Exception e) {
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

String sql = "Select Vehiclecode from db_gps.t_vehicledetails where VehicleRegnumber = '"+vehregno+"'";
ResultSet rs = st.executeQuery(sql);
if(rs.next())
{
   vehid = rs.getInt("Vehiclecode");
}

sql ="select vehid from db_gps.t_VehMst where vehid = '"+vehid+"' and Status = 'Active'";
rs =st.executeQuery(sql);
if(rs.next())
{
	Msg="1";
}
else
{
	String sql1 = "select * from db_gps.t_VehMst where Engno='"+engine+"'  and Status = 'Active'";
    ResultSet rs1 = st1.executeQuery(sql1);
    if(rs1.next())
    {
  	Msg = "2";
  	System.out.println("*********8  "+Msg);
    }
    
       sql1 = "select * from db_gps.t_VehMst where Chassisno='"+chassis+"'  and Status = 'Active'";
	   rs1 = st1.executeQuery(sql1);
     if(rs1.next())
     {
     	Msg = "3";
     	System.out.println("*********8  "+Msg);
     }
     
     if(vin=="0"||vin.equalsIgnoreCase("0") || vin=="-"||vin.equalsIgnoreCase("-"))
     {
    	 
     }
     else
     {
     sql1 = "select * from db_gps.t_VehMst where VinNo='"+vin+"'  and Status = 'Active'";
	   rs1 = st1.executeQuery(sql1);
      if(rs1.next())
      {
      	Msg = "4";
      	System.out.println("*********8  "+Msg);
      }
     }
}


    if(Msg!="0") 
    {
	  System.out.println("*******   "+Msg);
	  response.sendRedirect("VehMasterEntryForm.jsp?Msg="+Msg);
   }
    else if(Msg=="0")
  {
System.out.println("###########        "+vehid);

mfddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(mfddate));
System.out.println("###########        "+mfddate);
regdate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(regdate));
System.out.println("###########        "+regdate);

sql="select City from db_gps.t_citystctryinfo where country = 'India' and State = '"+state+"'";
rs =st.executeQuery(sql);
if(rs.next())
{
	
}
else
{
	String sql1 = "insert into db_gps.t_citystctryinfo (City,State,Country) values ('"+city+"','"+state+"','India')";
	st1.execute(sql1);
}





if(j==2)
{
	sql="select Manufacturer from db_gps.t_VehMnf where Manufacturer = '"+mnfname+"'";
	rs=st.executeQuery(sql);
	if(rs.next())
	{
	
	}
	else
	{
	    String sql1 = "insert into db_gps.t_VehMnf(Manufacturer) values ('"+mnfname+"')";
	    st1.execute(sql1);
	}
}



if(v==2)
{
	sql="select VehType from db_gps.t_VehType where VehType = '"+vehtype+"'";
	rs=st.executeQuery(sql);
	if(rs.next())
	{
	
	}
	else
	{
	    String sql1 = "insert into db_gps.t_VehType(VehType) values ('"+vehtype+"')";
	    st1.execute(sql1);
	}
}


if(k==2)
{
	sql="select RTOName from db_gps.t_RTONames where RTOName = '"+RTO+"'";
	rs=st.executeQuery(sql);
	if(rs.next())
	{
		
	}
	else
	{
	String sql1 = "insert into db_gps.t_RTONames(RTOName) values ('"+RTO+"')";
	st1.execute(sql1);
	}
}

if(l==2)
{
	sql="select State from db_gps.t_citystctryinfo where State = '"+RTOstate+"'";
	rs=st.executeQuery(sql);
	if(rs.next())
	{
		
	}
	else
	{
		String sql1 = "insert into db_gps.t_citystctryinfo (City,State,Country) values ('-','"+RTOstate+"','India')";
		st1.execute(sql1);
	}
}

sql = "insert into db_gps.t_VehMsthistory "
	+"(VehId,VehRegn,Chassisno,Engno,Gearno,Mnfdate,body,Regowner,Address1,Address2,Address3,OSrNo,Model,Color,Class,NoOfTyres,"
	+"NoofCyl,SeatingCap,StandingCap,Fuel,UnladenWt,VinNo,RLW,GVS,Company,RTO,RTOState,RCBookNo,State,City,RegDate,MnfName,Length,Breadth,Width,RcBookCopy,Photo,EntBy,EntDateTime,Pincode,"
	+"VehicleType,VehUsage) values"+
	
	"('"+vehid+"','"+vehregno+"','"+chassis+"','"+engine+"','"+gear+"','"+mfddate+"','"+body+"','"+owner+"','"+address+"','"+address1+"','"+address2+"','"+osrno+"','"+model+"','"+color+"','"+tclass+"','"+tyres+"',"
	+"'"+cyl+"','"+secap+"','"+stacap+"','"+fuel+"','"+unladewt+"','"+vin+"','"+RLW+"','"+GVW+"','"+group+"','"+RTO+"','"+RTOstate+"','"+RCBook+"',"
	+"'"+state+"','"+city+"','"+regdate+"','"+mnfname+"','"+length1+"','"+breadth+"','"+width+"','"+filestring+"','"+fimage+"','"+username+"','"+Entdatetime+"','"+pincode+"','"+vehtype+"','"+usage+"')";
System.out.println("&&&&&&   "+sql);
st.execute(sql);
sql="update db_gps.t_vehicledetails set vehtype='"+vehtype+"' where VehicleRegNumber='"+vehregno+"'";
System.out.println("############################"+sql);

st.execute(sql);

sql = "insert into db_gps.t_VehMst "
		+"(VehId,VehRegn,Chassisno,Engno,Gearno,Mnfdate,body,Regowner,Address1,Address2,Address3,OSrNo,Model,Color,Class,NoOfTyres,"
		+"NoofCyl,SeatingCap,StandingCap,Fuel,UnladenWt,VinNo,RLW,GVS,Company,RTO,RTOState,RCBookNo,State,City,RegDate,MnfName,Length,Breadth,Width,RcBookCopy,Photo,EntBy,EntDateTime,Pincode,"
		+"VehicleType,VehUsage) values"+
		
		"('"+vehid+"','"+vehregno+"','"+chassis+"','"+engine+"','"+gear+"','"+mfddate+"','"+body+"','"+owner+"','"+address+"','"+address1+"','"+address2+"','"+osrno+"','"+model+"','"+color+"','"+tclass+"','"+tyres+"',"
		+"'"+cyl+"','"+secap+"','"+stacap+"','"+fuel+"','"+unladewt+"','"+vin+"','"+RLW+"','"+GVW+"','"+group+"','"+RTO+"','"+RTOstate+"','"+RCBook+"',"
		+"'"+state+"','"+city+"','"+regdate+"','"+mnfname+"','"+length1+"','"+breadth+"','"+width+"','"+filestring+"','"+fimage+"','"+username+"','"+Entdatetime+"','"+pincode+"','"+vehtype+"','"+usage+"')";
System.out.println("&&&&&&   "+sql);
st.execute(sql);

 response.sendRedirect("VehMasterEntryForm.jsp?Msg=5");
}
} 
catch(Exception e)
{
	response.sendRedirect("VehMasterEntryForm.jsp?Msg=6");
	e.printStackTrace();
}
finally
{
	try{
		con1.close();		
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
}
%>
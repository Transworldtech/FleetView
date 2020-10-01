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
Connection conn;
Statement st,st1;
String sql,sql1,username="",mainuser="";
%>
<%
	username=(String)session.getAttribute("usertypevalue");
	mainuser=(String)session.getAttribute("mainuser");

	String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

	//System.out.println("InsertDateTime.."+InsertDateTime);
      String flag="true";
	try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	Statement stquery=conn.createStatement();
	String GPName="",clenname="",cleanerid="",transporter="",fathername="",address1="",address2="",gender="",maridstatus="",dob="",induction="",mobno=""; 
	int saveflag=0,filecount = 0,count1 = 0;
	String fname="",fname1="",fname2="";
	String savefilestring="",itemName="";
	File savedFile;
	String[] filepath =new String[3];
	String[] filename =new String[3];
	  int age=0,finalage=0;

	String driver_license="-",license_type="",Education="",how_long=""; 	
 
	
	
	
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart)
	{
		
	} 
	else
	{
		
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
				
								
				if(name.equals("GPName")) 
				{
					GPName = value;
					System.out.print("\n GPName==>"+GPName);
					count1 = 1;
				}
				

				if(name.equals("cleanername")) 
				{
					clenname = value;
					System.out.print("\n clenname==>"+clenname);
					count1 = 1;
				}
				
				if(name.equals("cleanerid")) 
				{
					cleanerid = value;
					System.out.print("\n cleanerid==>"+cleanerid);
					count1 = 1;
				}
				

				if(name.equals("fathername")) 
				{
					fathername = value;
					System.out.print("\n fathername==>"+fathername);
					count1 = 1;
				}
				
				
	
				if(name.equals("address1")) 
				{
					address1 = value;
					System.out.print("\n address1==>"+address1);
					count1 = 1;
				}
				
				
				if(name.equals("transporter")) 
				{
					transporter = value;
					System.out.print("\n transporter==>"+transporter);
					count1 = 1;
				}

				if(name.equals("address2")) 
				{
					address2 = value;
					System.out.print("\n address2==>"+address2);
					count1 = 1;
				}
	
				if(name.equals("gender")) 
				{
					gender = value;
					System.out.print("\n gender==>"+gender);
					count1 = 1;
				}
				

				if(name.equals("maridstatus")) 
				{
					maridstatus = value;
					System.out.print("\n maridstatus==>"+maridstatus);
					count1 = 1;
				}
				
				
	
				if(name.equals("dob")) 
				{
					dob = value;
					System.out.print("\n dob==>"+dob);
					count1 = 1;
				}
				

				if(name.equals("mobno")) 
				{
					mobno = value;
					System.out.print("\n mobno==>"+mobno);
					count1 = 1;
				}
				
				if(name.equals("induction"))
				{
					induction = value;
					System.out.print("\n induction==>"+induction);

					count1 =1;
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
				
				if(name.equals("driver_license")) 
				{
					driver_license = value;
					System.out.print("\n driver_license==>"+driver_license);
					count1 = 1;
				}
				if(name.equals("license_type")) 
				{
					license_type = value;
					System.out.print("\n license_type==>"+license_type);
					count1 = 1;
				}
				if(name.equals("how_long")) 
				{
					how_long = value;
					System.out.print("\n how_long==>"+how_long);
					count1 = 1;
				}
				
				
				
				if(name.equals("Education")) 
				{
					Education = value;
					System.out.print("\n Education==>"+Education);
					count1 = 1;
				}
				
			}
		else {	
				try {

					 itemName = item.getName();
					//System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
					if(itemName.equalsIgnoreCase(""))
					{
					}
					else
					{
						try{
					
							
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
	if(fname=="" || fname.equals(""))
	{
		fname=fname;

	}
	else{
		fname= InsertDateTime+"_"+fname;

	}
	if(fname1=="" || fname1.equals(""))
	{
		fname1=fname1;

	}
	else{
		fname1= InsertDateTime+"_"+fname1;

	}
	
	
	//stem.out.println("date time is" +InsertDateTime);
	
	sql="insert into db_gps.t_cleaners(Cleanerid,Cleanername,FatherNm,Address1,Address2,Gender,Marital,DOB,MobileNo,Owner,GPname,Status,Entryby,DOBFile,AddressFile,DateOfInduction, driver_license,license_type,how_long,Education)values('"+cleanerid.replaceAll("'"," ")+"','"+clenname.replaceAll("'"," ")+"' ,'"+fathername.replaceAll("'"," ")+"','"+address1.replaceAll("'"," ")+"','"+address2.replaceAll("'"," ")+"','"+gender+"','"+maridstatus+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+transporter+"','"+GPName+"','Active','"+mainuser+"','"+fname+"','"+fname1+"','"+induction+"', '"+driver_license+"','"+license_type+"' ,'"+how_long+"','"+Education+"') ";
    System.out.println("insert to cleaners " +sql);

	
	st1.executeUpdate(sql);
	
    System.out.println("insert"+sql);

	sql1="insert into db_gps.t_cleanerhistory(Cleanerid,Cleanername,FatherNm,Address1,Address2,Gender,Marital,DOB,MobileNo,Owner,GPname,Status,Entryby,Action,DOBFile,AddressFile,DateOfInduction,driver_license,license_type,how_long,Education)values('"+cleanerid.replaceAll("'"," ")+"','"+clenname.replaceAll("'"," ")+"' ,	'"+fathername.replaceAll("'"," ")+"','"+address1.replaceAll("'"," ")+"','"+address2.replaceAll("'"," ")+"','"+gender+"','"+maridstatus+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+transporter+"','"+GPName+"','Active','"+mainuser+"','Added','"+fname+"','"+fname1+"','"+induction+"', '"+driver_license+"','"+license_type+"' ,'"+how_long+"','"+Education+"')";
    System.out.println("insert2"+sql1);

	
	st1.executeUpdate(sql1);
    System.out.println("insert2"+sql1);
response.sendRedirect("Reportforcleaner.jsp?save1=true");

	}catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try{
		conn.close();
		}catch(Exception e){}
	}
	
	%>
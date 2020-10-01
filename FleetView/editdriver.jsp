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


      String flag="true";
	try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	Statement stquery=conn.createStatement();
	String GPName="",drivername="",drivername1="",owner="",driverid="",induction="",add2="",rid="",status="",clean="",clnid="",did="",address="",Gender="",dob="",mobno="",fatrhnm="",licno="";
	int r1=0;
	String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

	
	
	int saveflag=0,filecount = 0,count1 = 0;
	String fname="",fname1="",fname2="",oladdfile="",oldobfile="",transporter="",dobfileup="",addfileup="",licfileup="",maridstatus="",reasonD="",licenseexpdate="",licexp="";
	String savefilestring="",itemName="";
	File savedFile;
	String[] filepath =new String[3];
	String[] filename =new String[3];
	
	
	
	
	
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart)
	{
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
				

				if(name.equals("drivername")) 
				{
					drivername = value;
					System.out.print("\n clenname==>"+drivername);
					count1 = 1;
				}
				
				if(name.equals("reasonD")) 
				{
					reasonD = value;
					System.out.print("\n reasonD==>"+reasonD);
					count1 = 1;
				}
				
			
				
				
				if(name.equals("clean")) 
				{
					clean = value;
					System.out.print("\n clean==>"+clean);
					count1 = 1;
				}
				

				if(name.equals("olddriveid")) 
				{
					did = value;
					System.out.print("\n did==>"+did);
					count1 = 1;
				}
				
				
	
				if(name.equals("driverid")) 
				{
					driverid = value;
					System.out.print("\n cleanerid==>"+driverid);
					count1 = 1;
				}
				

				if(name.equals("status")) 
				{
					status = value;
					System.out.print("\n status==>"+status);
					count1 = 1;
				}
	
				if(name.equals("address1")) 
				{
					address = value;
					System.out.print("\n address==>"+address);
					count1 = 1;
				}
				if(name.equals("address2")) 
				{
					add2 = value;
					System.out.print("\n add2==>"+add2);
					count1 = 1;
				}
				

				if(name.equals("gender")) 
				{
					Gender = value;
					System.out.print("\n Gender==>"+Gender);
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
				
				
				if(name.equals("fathername")) 
				{
					fatrhnm = value;
					System.out.print("\n fatrhnm==>"+fatrhnm);
					count1 = 1;
				}
				
				if(name.equals("maridstatus")) 
				{
					maridstatus = value;
					System.out.print("\n maridstatus==>"+maridstatus);
					count1 = 1;
				}
				if(name.equals("transporter")) 
				{
					transporter = value;
					System.out.print("\n transporter==>"+transporter);
					count1 = 1;
				}
				
				
				if(name.equals("induction"))
				{
					induction = value;
					System.out.print("\n induction==>"+induction);

					count1 =1;
				}
			
				if(name.equals("licensceno"))
				{
					licno = value;
					System.out.print("\n licenseno==>"+licno);

					count1 =1;
				}
				
				
if(name.equals("licenseexpiry"))
					
				{   
					licenseexpdate = value;
					String s=licenseexpdate;
					String dd=s.substring(0, 2);
					String mm=s.substring(3,6);
					String mm1;
					String yy=s.substring(7,11);
					if(mm=="Jan")
					{
						mm1="01";
					}
					 if(mm=="Feb")
					{//alert("in feb");
					mm1="02";
					} if(mm=="Mar")
					{
						mm1="03";
					}
					 if(mm=="Apr")
					{
						mm1="04";
					}

					 if(mm=="May")
					{
						mm1="05";
					}
					 if(mm=="Jun")
					{
						mm1="06";
					}
					 if(mm=="Jul")
					{
						mm1="07";
					}
					 if(mm=="Aug")
					{
						mm1="08";
					}
					 if(mm=="Sep")
					{
						mm1="09";
					}
					if(mm=="Oct")
					{
						mm1="10";
					} if(mm=="Nov")
					{
						mm1="11";
					}
					else
					{
						mm1="12";
					}
					 licexp=yy+"-"+mm1+"-"+dd;
					System.out.println("licenseeexpiry====>"+licenseexpdate);
					System.out.println("changed licexpdate===>"+licexp);
				  
				   
				   

					
					
					 
					//System.out.print("\n licenseexp==>"+convertedDate);

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
				 
				if(name.equals("f8"))
				{
					fname2 = value;
					System.out.print("\n fname2==>"+fname2);

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
	
	String ridd="select * from db_gps.t_drivers where DriverID ='"+driverid+"'";		
	ResultSet rsrid=st.executeQuery(ridd);
	if(rsrid.next())
	{
		rid=rsrid.getString("rid");
		dobfileup=rsrid.getString("DOBFile");
		addfileup=rsrid.getString("AddressFile");
		licfileup=rsrid.getString("licensefile");
		
	}

		
	if(fname=="" || fname.equals(""))
	{

		fname=dobfileup;
	}
	else
	{
		fname=InsertDateTime+"_"+fname;
	}
	
	

	if(fname1=="" || fname1.equals(""))
	{

		fname1=addfileup;
	}
	else
	{
		fname1=InsertDateTime+"_"+fname1;//licenseexpdate,licenseno,licensefile
	}
	if(fname2=="" || fname2.equals(""))
	{

		fname2=licfileup;
	}
	else
	{
		fname2=InsertDateTime+"_"+fname2;
	}

		

	
	try{ 
		String sqlck1="select * from db_gps.t_drivers where licenseno ='"+licno+"' and ACTIVESTATUS='Active' and DriverId!='"+driverid+"' ";
		ResultSet rsck1 = st.executeQuery(sqlck1);
		System.out.println("inside try");
		if(rsck1.next())
		{
			//drivername1=rsck1.getString("DriverName");
			//owner=rsck1.getString("Owner");
			
			 out.println("<script>");
	        //out.println("alert('Details not saved because Licence number already exits with driver'"+drivername1+" and owner "+owner+");");
	        out.println("alert('Details not saved because License number already exits and active....!');");
	       // response.sendRedirect("driveredit.jsp?clean=true&id="+driverid+"&name="+drivername+"&add="+address+"&Gender="+Gender+"&dob="+dob+"&mobno="+mobno+"&fathernm="+fatrhnm+"&owner="+transporter+"&status="+status+"&gpname="+GPName+"&entryby="+mainuser+"&Address2="+add2+"&DOiN="+induction+"&DProof="+fname+"&Aproof="+fname1+"&LProof="+fname2+"&marrid="+maridstatus+"&licno1="+licno+"&licexp="+licexp+"&dreason="+reasonD+"");
	     out.println("location='Reportfordriver.jsp';");
       //out.println("location='driveredit.jsp?clean=true&id="+driverid+"&name="+drivername+"&add="+address+"&Gender="+Gender+"&dob="+dob+"&mobno="+mobno+"&fathernm="+fatrhnm+"&owner="+transporter+"&status="+status+"&gpname="+GPName+"&entryby="+mainuser+"&Address2="+add2+"&DOiN="+induction+"&DProof="+fname+"&Aproof="+fname1+"&LProof="+fname2+"&marrid="+maridstatus+"&licno1="+licno+"&licexp="+licexp+"&dreason="+reasonD+";"); 
	        out.println("</script>"); 

			
		// response.sendRedirect("driveredit.jsp?clean=true&id="+driverid+"&name="+drivername+"&add="+address+"&Gender="+Gender+"&dob="+dob+"&mobno="+mobno+"&fathernm="+fatrhnm+"&owner="+transporter+"&status="+status+"&gpname="+GPName+"&entryby="+mainuser+"&Address2="+add2+"&DOiN="+induction+"&DProof="+fname+"&Aproof="+fname1+"&LProof="+fname2+"&marrid="+maridstatus+"&licno1="+licno+"&licexp="+licexp+"&dreason="+reasonD+"");
			 
			
		} 

		else
		{
	sql="update db_gps.t_drivers set DriverID='"+driverid.replaceAll("'"," ")+"',DriverName='"+drivername.replaceAll("'"," ")+"',Owner='"+transporter+"',FatherNm='"+fatrhnm.replaceAll("'"," ")+"',Address1='"+address.replaceAll("'"," ")+"',Gender='"+Gender+"',DOB='"+dob+"',MobileNo='"+mobno.replaceAll("'"," ")+"',ACTIVESTATUS='"+status+"',DeactReason='"+reasonD+"',Address2='"+add2.replaceAll("'"," ")+"',DateOfInduction='"+induction+"',DOBFile='"+fname+"',AddressFile='"+fname1+"',Marital='"+maridstatus+"',licenseexpdate='"+licexp+"',licenseno='"+licno.replaceAll("'"," ")+"',licensefile='"+fname2+"' where rid='"+rid+"'";
	
	
	st1.executeUpdate(sql);
	
    System.out.println("update 1>>>>>>>>>>"+sql);


	sql1="insert into db_gps.t_driverhistory(DriverID,DriverName,FatherNm,Address1,Gender,DOB,MobileNo,Owner,GPname,ACTIVESTATUS,Entryby,Action,Address2,DateOfInduction,DOBFile,AddressFile,Marital,DeactReason)values('"+driverid.replaceAll("'"," ")+"','"+drivername.replaceAll("'"," ")+"','"+fatrhnm.replaceAll("'"," ")+"','"+address.replaceAll("'"," ")+"','"+Gender+"','"+dob+"','"+mobno.replaceAll("'"," ")+"','"+transporter+"','"+GPName+"','Active','"+mainuser+"','Edited','"+add2.replaceAll("'"," ")+"','"+induction+"','"+fname+"','"+fname1+"','"+maridstatus+"','"+reasonD+"')";

	st1.executeUpdate(sql1);
    System.out.println("insert 2>>>>>>>>>"+sql1);
    
    
    	
    
    
	 response.sendRedirect("Reportfordriver.jsp?save=true");

   
		}
    
    }catch(Exception e)
{
	e.printStackTrace();
}
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	finally{
		try{
			conn.close();
		}catch(Exception e)
		{
			
		}
	}
    
    
    
	%>
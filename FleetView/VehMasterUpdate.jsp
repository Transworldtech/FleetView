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

int id= 0;
%>
<%

try
{
	System.out.println("***********22");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=con1.createStatement();
	Statement st1=con1.createStatement();
	Statement st2=con1.createStatement();
	String osrno="0",secap="0",stacap="0",cyl="0",tyres="0",unladewt="0",card="0",gear="0",RLW="0",GVW="0",KG="0",RCBook="0",city="-",state="-";
    String vehregno="-",owner="-",address="-",mfddate=null,model="-",color="-",body="-",tclass="-",fuel="-",make="-",group="-",chassis="-",engine="-",RTO="-",vin="0";
    String regdate = "-",mnfname="-",length1="0",breadth="0",width="0",vehtype="-",usage="-",address1="-",address2="-",pincode="0",RTOstate="-";
    File savedFile;
    int  filecount = 0,count1 = 0,i=0,v=0;
    int j=0,k=0,l=0;
    String savefilestring="";
    String fname="",fname1="",fname2="";
    int saveflag=0;
   
    
    String[] filepath =new String[2];
    String[] filename =new String[2];
    String username =(String)session.getAttribute("mainuser");
    String Entdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    String date = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
	
	
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
					System.out.print("\n mnfname==>"+vehtype);
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
				if(name.equals("ip1")) 
				    {
					id = Integer.parseInt(value);
					System.out.print("\n id==>"+id);
					count1 = 1;
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
							
							item.write(savedFile);
							 
							filepath[filecount]=""+savedFile;
						
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

	 String html = session.getAttribute("html"+id).toString();
	    String[] token = html.split("%");
	    for(int m=0; m<token.length; m++)
		{
			//System.out.println("*****    "+m+"  ********     "+token[m]);
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
	    	fimage = token[39];
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
	    	fimage =token[39];
	    }
	    else
	    	if(saveflag < 2 && (fname1 != "" || !(fname1.equals("")))) 
	    	{
	    		System.out.println("****** <2  !=fname1");
	    		filestring =token[38];
	    		fimage =filepath[0];
	    	}
	    
	    
	mfddate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(mfddate));
	regdate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(regdate));
	String Msg = "0";
	
	
	String sql = " Select * from db_gps.t_VehMst where VehRegn = '"+token[0]+"' and VehicleType = '"+vehtype+"'  and VehUsage = '"+usage+"' and Regowner = '"+owner+"' and OSrNo = '"+osrno+"' and Company = '"+group+"' "+
	" and Address1 = '"+address+"' and Address2 = '"+address1+"'  and Address3 = '"+address2+"' and State = '"+state+"' and City = '"+city+"' and Pincode = '"+pincode+"' and MnfName = '"+mnfname+"' and Model = '"+model+"'"+
	"  and Mnfdate = '"+mfddate+" 00:00:00' and RTO = '"+RTO+"' and RTOState = '"+RTOstate+"' and RegDate = '"+regdate+"' and RCBookNo = '"+RCBook+"' and Engno = '"+engine+"' and Chassisno = '"+chassis+"' and Gearno = '"+gear+"'"+
	" and VinNo = '"+vin+"' and UnladenWt = '"+unladewt+"' and RLW = '"+RLW+"' and GVS = '"+GVW+"' and Class = '"+tclass+"' and body  = '"+body+"' and Length = '"+length1+"' and Breadth = '"+breadth+"'"+
	"  and Width = '"+width+"' and SeatingCap = '"+secap+"' and StandingCap = '"+stacap+"' and NoOfTyres = '"+tyres+"' and NoofCyl = '"+cyl+"' and Color = '"+color+"' and 	Fuel = '"+fuel+"' and Status = 'Active'"+
	" and RCBookCopy = '"+filestring+"' and Photo = '"+fimage+"'";
   
   ResultSet rs = st.executeQuery(sql);
   System.out.println("*********8  "+sql);
   if(rs.next())
   {
	  Msg="1";
	  System.out.println("*********8  "+Msg);
   }
   else
   {
	   
	   if(engine==token[19] || engine.equalsIgnoreCase(token[19]))
	   {
		   System.out.println("*****  "+engine+"    *********     "+token[19] );
		   System.out.println("*********  "+Msg);
	   }
	   else
	       {
		      System.out.println("*****  "+engine+"    *********     "+token[19] );
	        	String sql1 = "select * from db_gps.t_VehMst where Engno='"+engine+"'  and Status = 'Active'";
		      ResultSet rs1 = st1.executeQuery(sql1);
              if(rs1.next())
              {
            	Msg = "2";
            	System.out.println("*********8  "+Msg);
              }
	   }
	   
	   if(chassis==token[20] || chassis.equalsIgnoreCase(token[20]))
	   {
		   System.out.println("*****  "+chassis+"    *********     "+token[20] );
		   System.out.println("*********8  "+Msg);
	   }
	   else
	       {
		   System.out.println("*****  "+chassis+"    *********     "+token[20] );
		   String sql1 = "select * from db_gps.t_VehMst where Chassisno='"+chassis+"'  and Status = 'Active'";
		   ResultSet rs1 = st1.executeQuery(sql1);
            if(rs1.next())
            {
            	Msg = "3";
            	System.out.println("*********8  "+Msg);
            }
	   }
	   
	   if(vin==token[22] || vin.equalsIgnoreCase(token[22]))
	   {
		   System.out.println("*****  "+vin+"    *********     "+token[22] );
		   System.out.println("*********8  "+Msg);
	   }
	   else
	       {
		   System.out.println("*****  "+vin+"    *********     "+token[22] );
		   String sql1 = "select * from db_gps.t_VehMst where VinNo='"+vin+"'  and Status = 'Active'";
		   ResultSet rs1 = st1.executeQuery(sql1);
            if(rs1.next())
            {
            	Msg = "4";
            	System.out.println("*********8  "+Msg);
            }
	  
	}
	  
   }
   System.out.println("*******   "+Msg);
   if(Msg!="0") 
	  {
		  System.out.println("*******   "+Msg);
		  response.sendRedirect("EditVehMst.jsp?Msg="+Msg+"&id="+id);
	  }
	   else if(Msg=="0")
		   
	   {
		   
		   
		   System.out.println("*******   "+Msg);
		   
		   String sql1="select City from db_gps.t_citystctryinfo where country = 'India' and State = '"+state+"'";
		   ResultSet  rs1 =st1.executeQuery(sql);
		   if(rs1.next())
		   {
		   	
		   }
		   else
		   {
		   	String sql2 = "insert into db_gps.t_citystctryinfo (City,State,Country) values ('"+city+"','"+state+"','India')";
		   	st2.execute(sql2);
		   }

		   
		   if(v==2)
		   {
		   sql1="select VehType from db_gps.t_VehType where VehType = '"+vehtype+"'";
		   rs1=st1.executeQuery(sql1);
		   	if(rs1.next())
		   	{
		   	
		   	}
		   	else
		   	{
		   		String sql2 = "insert into db_gps.t_VehType(VehType) values ('"+vehtype+"')";
		   	    st2.execute(sql2);
		   	}
		   }
		   
		   if(j==2)
		   {
		   	sql1="select Manufacturer from db_gps.t_VehMnf where Manufacturer = '"+mnfname+"'";
		   	rs1=st1.executeQuery(sql1);
		   	if(rs1.next())
		   	{
		   	
		   	}
		   	else
		   	{
		   	    String sql2 = "insert into db_gps.t_VehMnf(Manufacturer) values ('"+mnfname+"')";
		   	    st2.execute(sql2);
		   	}
		   }

		   if(k==2)
		   {
		   	sql1="select RTOName from db_gps.t_RTONames where RTOName = '"+RTO+"'";
		   	rs1=st.executeQuery(sql1);
		   	if(rs1.next())
		   	{
		   		
		   	}
		   	else
		   	{
		   	String sql2 = "insert into db_gps.t_RTONames(RTOName) values ('"+RTO+"')";
		   	st2.execute(sql2);
		   	}
		   }

		   if(l==2)
		   {
		   	sql1="select State from db_gps.t_citystctryinfo where State = '"+RTOstate+"'";
		   	rs1=st.executeQuery(sql1);
		   	if(rs1.next())
		   	{
		   		
		   	}
		   	else
		   	{
		   		String sql2 = "insert into db_gps.t_citystctryinfo (City,State,Country) values ('-','"+RTOstate+"','India')";
		   		st2.execute(sql2);
		   	}
		   }
		   
		   String sql2 = "insert into db_gps.t_VehMsthistory "
				+"(VehId,VehRegn,Chassisno,Engno,Gearno,Mnfdate,body,Regowner,Address1,Address2,Address3,OSrNo,Model,Color,Class,NoOfTyres,"
				+"NoofCyl,SeatingCap,StandingCap,Fuel,UnladenWt,VinNo,RLW,GVS,Company,RTO,RTOState,RCBookNo,State,City,RegDate,MnfName,Length,Breadth,Width,RcBookCopy,Photo,EntBy,EntDateTime,Pincode,"
				+"VehicleType,VehUsage) values"+
				
				"('"+token[37]+"','"+token[0]+"','"+chassis+"','"+engine+"','"+gear+"','"+mfddate+"','"+body+"','"+owner+"','"+address+"','"+address1+"','"+address2+"','"+osrno+"','"+model+"','"+color+"','"+tclass+"','"+tyres+"',"
				+"'"+cyl+"','"+secap+"','"+stacap+"','"+fuel+"','"+unladewt+"','"+vin+"','"+RLW+"','"+GVW+"','"+group+"','"+RTO+"','"+RTOstate+"','"+RCBook+"',"
				+"'"+state+"','"+city+"','"+regdate+"','"+mnfname+"','"+length1+"','"+breadth+"','"+width+"','"+filestring+"','"+fimage+"','"+username+"','"+Entdatetime+"','"+pincode+"','"+vehtype+"','"+usage+"')";
			System.out.println("&&&&&&   "+sql2);
			st2.execute(sql2);
			sql2="update db_gps.t_vehicledetails set vehtype='"+vehtype+"' where VehicleRegNumber='"+token[0]+"'";
			System.out.println("############################"+sql2);

			st.execute(sql2);
			
			
			sql2 = "update db_gps.t_VehMst set Chassisno = '"+chassis+"',Engno = '"+engine+"',Gearno = '"+gear+"',Mnfdate = '"+mfddate+" 00:00:00',body = '"+body+"',Regowner = '"+owner+"',Address1 = '"+address+"',"+
			"Address2 = '"+address1+"',Address3 = '"+address2+"',OSrNo = '"+osrno+"',Model = '"+model+"',Color = '"+color+"',Class = '"+tclass+"',NoOfTyres = '"+tyres+"',NoofCyl = '"+cyl+"',SeatingCap = '"+secap+"',"+
			"StandingCap = '"+stacap+"',Fuel = '"+fuel+"',UnladenWt = '"+unladewt+"',VinNo = '"+vin+"',RLW = '"+RLW+"',GVS = '"+GVW+"',Company = '"+group+"',RTO = '"+RTO+"',"+
			"RTOState = '"+RTOstate+"',RCBookNo = '"+RCBook+"',State = '"+state+"',City = '"+city+"',RegDate = '"+regdate+"',MnfName = '"+mnfname+"',Length = '"+length1+"',Breadth = '"+breadth+"',"+
			"Width = '"+width+"',Pincode = '"+pincode+"',VehicleType = '"+vehtype+"',VehUsage = '"+usage+"',RcBookCopy = '"+filestring+"',Photo = '"+fimage+"' where VehId = '"+token[37]+"' and VehRegn = '"+token[0]+"' and Status = 'Active'";
			
			st2.execute(sql2);  
			System.out.println("&&&&&&   "+sql2);
		response.sendRedirect("EditVehMst.jsp?Msg=5&id="+id);
			
	   }
   
   }
   
catch(Exception e)
{
	System.out.println("RRRRRRRRRRR  "+e);
	response.sendRedirect("EditVehMst.jsp?Msg=6");
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
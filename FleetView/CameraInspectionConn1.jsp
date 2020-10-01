<%@ page import="java.sql.* " import="java.text.*"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
	<%@ page import="java.util.Iterator" %>
	<%@ page import="java.io.File" %>
	<%@ page import="java.io.*" %>
	<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
	<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
	<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
	<%@ page import="org.apache.commons.fileupload.*"%>
	<%@ page import="java.sql.*" %>
    <%@ page import = "java.io.FileNotFoundException"%>
    <%@ page import = "java.io.FileOutputStream"%>
    <%@ page import = " java.io.IOException"%>
    <%@ page import="javax.activation.*" %>
    
<%!Connection conn = null;
   Statement st = null;
   Statement st1 = null;
   Statement st2 = null;
%>
    
<% 
Class.forName("org.gjt.mm.mysql.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();

String sd_card_size = "";
String camera_seal_broken = "";
String current_seal_id = "";
String new_seal_id = "";
String camera_stand_id = "";
String file_count = "";
String vedio_duration = "";
String vedio_size = "";
String locked_file_count = "";
String corrup_file_count = "";
String latest_vedio_date_time = "";
String veh_code = "";
String cam_id = "";
String dd = "";
String mm = "";
String yyyy = "";
String data = "";
String hh = "";
String filename11 = "";
	
int saveflag=1;
File savedFile;
String[] filepath =new String[10];
String[] filename =new String[10];
String savefilestring="";
int  count2 = 0, filecount = 0, count4 = 0, count5 = 0,count6 = 0,complaintID=0;
Boolean innerflag=false;
Boolean flag=false;
Writer output = null;
int count=1;
int count1=0;

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
System.out.println("\n\n ismultipart-->>"+isMultipart);
    if (!isMultipart) {
    System.out.println("\n\nin multipart..");
    } else {
            System.out.println("\n\n in else with  multipart..");
            FileItemFactory factory = new DiskFileItemFactory();
            //System.out.print("\n\nfactory==>"+factory);
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = null;
            try {
                    items = upload.parseRequest(request);
            //      System.out.print("\n\n items==>"+items);
            } catch (FileUploadException e) {
                    e.printStackTrace();
            }
            Iterator itr = items.iterator();
    
    while (itr.hasNext()) {
                    FileItem item = (FileItem) itr.next();
                    if(item.isFormField()) 
                    {
                            String name1 = item.getFieldName();
                            System.out.print("\n name==>"+name1);
                            String value = item.getString();
                            System.out.print("\n value==>"+value);
                            if(name1.equals("sd_card_size")) 
                            {
                            		sd_card_size = value;
                                    System.out.print("\n sd_card_size==>"+sd_card_size);
                                    
                                    count1++;
                            }
                            if(name1.equals("camera_seal_broken")) 
                            {
                            		camera_seal_broken = value;
                                    System.out.print("\n camera_seal_broken==>"+camera_seal_broken);
                                    
                                    count1++;
                            }
                            if(name1.equals("current_seal_id")) 
                            {
                            		current_seal_id = value;
                                    System.out.print("\n current_seal_id==>"+current_seal_id);
                                    
                                    count1++;
                            }                        
                            if(name1.equals("new_seal_id")) 
                            {
                            		new_seal_id = value;
                                    System.out.print("\n new_seal_id==>"+new_seal_id);
                                    count1++;
                            }
                            if(name1.equals("camera_stand_id")) 
                            {
                            		camera_stand_id= value;
                                    System.out.print("\n camera_stand_id=>"+camera_stand_id);
                                    
                                    count1++;
                            }
                            if(name1.equals("file_count")) 
                            {
                            		file_count = value;
                                    System.out.print("\n file_count==>"+file_count);
                                    
                                    count1++;
                            }
                            if(name1.equals("vedio_duration")) 
                            {
                            		vedio_duration = value;
                                    System.out.print("\n vedio_duration==>"+vedio_duration);
                                    count1++;
                            }
                            if(name1.equals("vedio_size")) 
                            {
                            		vedio_size = value;
                                    System.out.print("\n vedio_size==>"+vedio_size);
                                    count1++;
                            }
                            if(name1.equals("locked_file_count")) 
                            {
                            		locked_file_count = value;
                                    System.out.print("\n locked_file_count==>"+locked_file_count);
                                    
                                    count1++;
                            }
                            if(name1.equals("corrup_file_count")) 
                            {
                            		corrup_file_count = value;
                                    System.out.print("\n corrup_file_count==>"+corrup_file_count);
                                    
                                    count1++;
                            }                         
                            if(name1.equals("cam_id")) 
                            {
                            		cam_id = value;
                                    System.out.print("\n cam_id==>"+cam_id);
                                    count1++;
                            }
                            if(name1.equals("veh_code")) 
                            {
                            		veh_code = value;
                                    System.out.print("\n veh_code==>"+veh_code);
                                    count1++;
                            }
                          /*  if(name1.equals("element_13_2")) 
                            {
                            		dd = value;
                                    System.out.print("\n dd==>"+dd);
                                    count1++;
                            }
                            if(name1.equals("element_13_1")) 
                            {
                            		mm = value;
                                    System.out.print("\n mm==>"+mm);
                                    count1++;
                            }
                            if(name1.equals("element_13_3")) 
                            {
                            		yyyy = value;
                                    System.out.print("\n yyyy==>"+yyyy);
                                    count1++;
                            }*/
                            if(name1.equals("data")) 
                            {
                            		data = value;
                                    System.out.print("\n data==>"+data);
                                    count1++;
                            }
                        /*    if(name1.equals("hr")) 
                            {
                            		hh = value;
                                    System.out.print("\n hh==>"+hh);
                                    count1++;
                            }
                            if(name1.equals("min")) 
                            {
                            		mm = value;
                                    System.out.print("\n mm==>"+mm);
                                    count1++;
                            }*/
                            
                            //System.out.println("\n $$$$$$$$$$$$$ "+PageName);

                    } else {
                                   try {

                                         String itemName = item.getName();
                                         filename11 = itemName;
                                         System.out.print("\n\nitemName==>"+itemName);
                                          if(itemName.equalsIgnoreCase(""))
                                          {
                                          }
                                        else
                                         {
                                         try
                                         {
                                        	// System.out.println("in doc uploading");
                                        	// String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir"); 
                                        	// System.out.println("in doc uploading 1");
                                        	// File uploadDir = new File(FileUploadPath);
                                        	// System.out.println("in doc uploading 2");
                                        	//savedFile = new File(FileUploadPath+"/"+itemName);
                                        	// System.out.println("in doc uploading 3");
                                     		 savedFile = new File("/usr/share/tomcat6/webapps/images1/CameraInspectionImg/"+itemName);
                                     		//savedFile = new File(getServletContext()+"\\images\\fileupload\\"+itemName);
                                                            System.out.print("\n\nsavedFile==>"+savedFile);
                                                            item.write(savedFile);
                                                            filepath[filecount]=""+savedFile;
                                                            
                                                            filename[filecount]=itemName;
                                                            filecount++;
                                                            if(saveflag==1)
                                                            {
                                                             savefilestring=""+savedFile;
                                                            // saveflag++;
                                                            }
                                                            else
                                                            savefilestring=savefilestring+","+savedFile;
                                                             //out.print("successfully saved the file");
                                                            //File file = new File(savedFile);
                                                            String screenshot=savedFile.getAbsolutePath();
                                                   			System.out.println("\n\nscreenshot--->>>"+screenshot);
                                                            
                                                   			
                                                   				
                                         }
                                         catch(Exception e)
                                         {
                                        	 System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&>>>>>"+e);
                                         }
                                         					
                                         					}
                                                    
                                                    
                                    } catch (Exception e) {
                                            e.printStackTrace();
                                    }
                    }
            }
    latest_vedio_date_time = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(data)) +":00";
    System.out.println("The date and time is :"+latest_vedio_date_time);
    
    try { 
   
   	String query1 = "update db_gps.t_vehcileperipheral SET SdCardSize ='"+sd_card_size+"',SealBroken = '"+camera_seal_broken+"',CurrentSealId = '"+current_seal_id+"',NewSealId = '"+new_seal_id+"',StandId = '"+camera_stand_id+"',FileCount = '"+file_count+"',VideoDuration = '"+vedio_duration+"',VideoSize = '"+vedio_size+"',LockedFileCount = '"+locked_file_count+"',CorruptFileCount = '"+corrup_file_count+"',LatestVideoDateTime ='"+latest_vedio_date_time+"',FileName = '"+filename11+"' where Vehiclecode = '"+veh_code+"' AND PeripheralSrNo = '"+cam_id+"'";
   	st1.executeUpdate(query1);
   	System.out.println("The query1 is :"+query1);
   	
   	String query2 = "insert into db_gps.t_vehcileperipheralhistory(Vehiclecode,PeripheralSrNo,SdCardSize,SealBroken,CurrentSealId,NewSealId,StandId,FileCount,VideoDuration,VideoSize,LockedFileCount,CorruptFileCount,LatestVideoDateTime,InsertionDateTime,FileName)values('"+veh_code+"','"+cam_id+"','"+sd_card_size+"','"+camera_seal_broken+"','"+current_seal_id+"','"+new_seal_id+"','"+camera_stand_id+"','"+file_count+"','"+vedio_duration+"','"+vedio_size+"','"+locked_file_count+"','"+corrup_file_count+"','"+latest_vedio_date_time+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"','"+filename11+"')";
   	st2.executeUpdate(query2);
   	System.out.println("The query2 is :"+query2);
   
  	response.sendRedirect("CameraInspectionForm.jsp?vehcode="+veh_code+"&Msg=1");
    //System.out.println("queryis :"+query);
    }catch(Exception e) {
            System.out.println("Exception ------------->    "+e);                        	
    } 
    
    
    
    
    
}
    
    


%>

<%@ include file="Connections/conn.jsp" %>
<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@page import="javax.*,java.awt.*,

 com.lowagie.text.Chunk,  
 com.lowagie.text.Document,  
 com.lowagie.text.DocumentException,  
com.lowagie.text.Font, 
com.lowagie.text.FontFactory,  
com.lowagie.text.HeaderFooter,  
com.lowagie.text.Image,  
com.lowagie.text.PageSize,  
com.lowagie.text.Paragraph,  
com.lowagie.text.Phrase,
 com.lowagie.text.pdf.BaseFont,

 com.lowagie.text.pdf.PdfContentByte,  
 com.lowagie.text.pdf.PdfImportedPage,  
com.lowagie.text.pdf.PdfLayer,  
com.lowagie.text.pdf.PdfReader,  
com.lowagie.text.pdf.PdfStamper,  
com.lowagie.text.pdf.PdfString,  
com.lowagie.text.pdf.PdfWriter,  
java.io.FileOutputStream,
java.io.*,
java.util.*,
java.awt.*,
java.awt.geom.Rectangle2D,
com.lowagie.text.pdf.*,
com.lowagie.text.pdf.PdfPCellEvent,
com.lowagie.text.*,
com.lowagie.text.Image,
org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.plot.PlotOrientation,
org.jfree.data.DefaultCategoryDataset,
org.jfree.data.DefaultPieDataset,
org.jfree.chart.ChartFrame,
org.jfree.chart.renderer.BarRenderer,
org.jfree.chart.plot.CategoryPlot,
org.jfree.chart.plot.PiePlot3D"%>



<%@page import="com.lowagie.text.Rectangle"%>

<%!
Connection conn;
Statement st,st1,st2;
String sql,sql1,username="",mainuser="";
String s="";
String dd="";
String mm="";
String yy="";
String mm1="";
String enddtime="";
String note="";
%>

<% 


Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD); 
st=conn.createStatement();
st1=conn.createStatement();
String tripid=request.getParameter("tripid");
tripid=tripid.trim();
System.out.println("tripid==>"+tripid);
String owner=request.getParameter("owner");
System.out.println("owner=>"+owner);
String vid=request.getParameter("vid");
System.out.println("vid"+vid);

String vehRegNo=request.getParameter("vehRegNo");
System.out.println("Vehreg"+vehRegNo);
String usertypevalue=session.getAttribute("usertypevalue").toString();


 String Tripid="",TripFrom="",TripTo="",CustomerName="",LPO="",CustomerContPerson="",CustomerContNo="",ContainerNo="",ContainerType="";
String TokenNo="",TokenChargesPaid="",SalesPerson="",StartDate="",StartTime="",EndDate_Time="",TripType="",DriverName="";
String EmployeeRefNo="",TruckNo="",TrailarNo="",ContainerStatus=""; 
String  startdate12="";
String path="",logo1="",FilePath="";
String address="";
/* String TripIDIssueDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()); */
String TripIDIssueDate="", Transportername="",comments="";
String startdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
String DateTimeStamp=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
System.out.println("Date time Stamp==>"+DateTimeStamp);
String outputFileName="TripSheet"+tripid+".pdf";
response.setContentType("application/pdf");

response.setHeader("Content-Disposition", "attachment; filename=\"" + outputFileName + "\"");

Document document = new Document();
try{
String sqlck1="select * from db_gps.t_startedjourney where TripID='"+tripid+"' and OwnerName='"+owner+"'and VehRegNo='"+vehRegNo+"' ";
String sql2="Select * from db_gps.t_transporter where TypeValue='"+owner+"'";
	System.out.println("***    "+sqlck1);
	ResultSet rsck = st.executeQuery(sqlck1);
	ResultSet rsck1=st1.executeQuery(sql2);
	System.out.println("***    "+sqlck1);
	while(rsck.next())
	{
		System.out.println("inside if");
    Tripid=rsck.getString("TripID");
    TripFrom=rsck.getString("StartPlace");
    TripTo=rsck.getString("EndPlace");
    CustomerName=rsck.getString("Vendor");
    LPO=rsck.getString("LPO");
    CustomerContPerson=rsck.getString("customercontperson");
    CustomerContNo=rsck.getString("customercontno");
    ContainerNo=rsck.getString("containerno");
    ContainerType=rsck.getString("containertype");
    TokenNo=rsck.getString("tokenno");
    TokenChargesPaid=rsck.getString("tokenchargespaid");
    SalesPerson=rsck.getString("salesperson");
   TripIDIssueDate=rsck.getString("tripissuedate");
   
   System.out.println("TripIDIssueDate---------"+TripIDIssueDate);
   
    StartDate=rsck.getString("StartDate");
   
    StartTime=rsck.getString("StartTime");
    EndDate_Time=rsck.getString("ETA");
	  System.out.println("EndDate_Time"+EndDate_Time); 
    TripType=rsck.getString("tripcategory");
    DriverName=rsck.getString("DriverName");
    /*EmployeeRefNo=;  extract from drivername  */
    TruckNo=rsck.getString("VehRegNo");
    TrailarNo=rsck.getString("trailerno");
    ContainerStatus=rsck.getString("containerstatus");
    comments=rsck.getString("Loadcomments");
    Transportername=rsck.getString("OwnerName");
    EmployeeRefNo=rsck.getString("DriverCode");
	System.out.println("Tripid"+Tripid);
	System.out.println("TripFrom"+ TripFrom);
	
	
	}
	 while(rsck1.next())
	{
     	note=rsck1.getString("note");	
		path=rsck1.getString("path");
		logo1=rsck1.getString("logo");
		address=rsck1.getString("address");
		System.out.println("Logo inside===>"+logo1);
	}  
	 
	 if(address==null||address.trim()==""||address.equals("-"))
	 {
		 address="";
	 }
	 
	 if(note==null||note.trim()=="")
	 {
		 System.out.println("Inside note");
		 note="";
	 }
	 
	//Absolutepath="/usr/share/tomcat6/webapps/FleetView/images/";
	//FilePath=Absolutepath+logo1;
	 s=StartDate;
	 
	 System.out.println("Startdate===>1111111111"+s);
	 dd=s.substring(8, 10);
     mm=s.substring(5,7);
	
	yy=s.substring(0,4);
	String s1=dd+"-"+mm+"-"+yy;
	System.out.println("Startdate===>"+s1);
	
	/*Enddaytime*/
	System.out.println("End time==>"+EndDate_Time);
	if(EndDate_Time==null||EndDate_Time.trim()=="")
	{
		enddtime="";
	}
	else
	{
	enddtime=new SimpleDateFormat("dd-MMM-yyyy HH:mm")
	.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
	.parse(EndDate_Time));
	}
	System.out.println("end date time==>"+enddtime);
	String dt = new SimpleDateFormat("dd-MMM-yyyy")
	.format(new SimpleDateFormat("yyyy-MM-dd")
			.parse(s));

	/*Start */
	
	String sttime=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(StartTime));
	System.out.println("Starttime"+StartTime);
	System.out.println("Converted Starttime"+sttime);
	System.out.println("Startdate===>"+dt);
	
	//trip iss trip issue
	
	System.out.println("TripIDIssueDate---------1111111111111-------"+TripIDIssueDate); 

	String  tripiss=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd")
	.parse(TripIDIssueDate));
	
	System.out.println("in if before111111111111111"+tripiss);
	if(tripiss==null || tripiss.trim()=="" || tripiss.equals("01-Jan-2001"))
	{
		
		System.out.println("in if before"+tripiss);
		tripiss="";
		System.out.println("in if after"+tripiss);
	}
	 
	
	System.out.println("Startdate===>tripiss"+tripiss);
	
	
	
	 startdate12=dt; 
	
	System.out.println("Startdate dd-mmm-yyyy"+startdate12);
	String mainusr3=session.getAttribute("fname").toString();
	//System.out.println("fname-------------------------------------------------->  " +mainusr3);		


	String mainusr4=session.getAttribute("lname").toString();
	 //PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("/home/bunnty/Desktop/trippdf/HelloWorld.pdf"));
	 PdfWriter.getInstance(document,response.getOutputStream());
	 Font Normal = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
	 Font Normal1 = new Font(Font.TIMES_ROMAN,10,Font.BOLD);
	 Font catFont = new Font(Font.TIMES_ROMAN,12,Font.BOLD);
	 Font NormalFont = new Font(Font.TIMES_ROMAN,8);
	 Font underline=new Font(Font.TIMES_ROMAN,10,Font.UNDERLINE);
	 Font Fontforname = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
	 Font forterms = new Font(Font.TIMES_ROMAN,9,Font.BOLD);
	 Font smallfont = new Font(Font.TIMES_ROMAN,6,Font.BOLD);
	 Font headFont = new Font(Font.TIMES_ROMAN,13,Font.BOLD);
	 Font fortotal=new Font(Font.BOLD,10,Font.UNDERLINE);
	 Font new3=new Font(Font.TIMES_ROMAN,8,Font.BOLD);
	 Font NF = new Font(Font.TIMES_ROMAN,1,Font.NORMAL);

	 document.open();
	 Anchor anchor =
	            new Anchor("www.MyFleetView.com",Normal1);
	            anchor.setReference("http://myfleetview.com/");
	          /*   Paragraph paragraph = new Paragraph(); */
	           
	           /*  paragraph.add(anchor);
	            document.add(paragraph); */
PdfPTable myfleetview=new PdfPTable(1);            
PdfPTable head= new PdfPTable(2);

    PdfPTable p1 = new PdfPTable(1);
  PdfPTable table = new PdfPTable(4);
  PdfPTable table1 = new PdfPTable(2);
  PdfPTable table2= new PdfPTable(4);
  PdfPTable table3 = new PdfPTable(1);
  PdfPTable table4= new PdfPTable(4);
  PdfPTable table5= new PdfPTable(1);
  
  PdfPTable table6= new PdfPTable(1);
  PdfPTable table7= new PdfPTable(1);
  
  PdfPTable table8=new PdfPTable(1);
  PdfPTable table9=new PdfPTable(1);
  document.add(Chunk.NEWLINE);
 // table.setSpacingBefore(10f);
  
/*   ------------------------------------------ */
head.setWidths(new float[] { 1, 3 });

//String imageUrl = "/home/bunnty/Desktop/Fleetviewworkspace/FleetView/WebContent/images/11_172.JPG";
//String imageUrl="/usr/share/tomcat6/webapps/FleetView/images/"+logo1;
//String imageUrl="";
//Image image2=null;
//imageUrl=FilePath;
/* PdfPCell logo = new PdfPCell((image2)); */
System.out.println("Filepath==>"+FilePath);
PdfPCell myflv = new PdfPCell(new Paragraph(anchor));
 myflv.setHorizontalAlignment(Element.ALIGN_CENTER);
 myflv.setVerticalAlignment(Element.ALIGN_BASELINE);
 myflv.setBorder(Rectangle.NO_BORDER);
 PdfPCell head1 = new PdfPCell(new Paragraph(Transportername,headFont)); 
 //PdfPCell head1 = new PdfPCell(new Paragraph());
 head1.setFixedHeight(72f);
 head1.setHorizontalAlignment(Element.ALIGN_CENTER);
 head1.setVerticalAlignment(Element.ALIGN_MIDDLE);
/*  head1.setBorder(Rectangle.NO_BORDER);
 head1.setBorder(Rectangle.LEFT);
 head1.setBorder(Rectangle.TOP); */
 PdfPCell logo ;
 /*---------*/
 if(logo1=="-"||logo1==null||logo1.trim()=="")
{
 logo = new PdfPCell(new Paragraph("LOGO",Normal));
 logo.setHorizontalAlignment(Element.ALIGN_CENTER);
 logo.setVerticalAlignment(Element.ALIGN_MIDDLE);
}
else
{
 //String imageUrl="/usr/share/tomcat6/webapps/FleetView/images/"+logo1;
//String imageUrl="/home/bunnty/Desktop/alrama.png";
 String imageUrl=path+"/"+logo1;
  Image image2 = Image.getInstance(imageUrl);
image2.scaleAbsolute(102f,72f);
logo = new PdfPCell((image2));
logo.setFixedHeight(72f);
logo.setHorizontalAlignment(Element.ALIGN_CENTER);
logo.setVerticalAlignment(Element.ALIGN_MIDDLE);
	 //logo = new PdfPCell(new Paragraph());
}
 
/*    PdfPTable nestedTable = new PdfPTable(1);
   nestedTable.setWidthPercentage(15);
  // nestedTable.setFixedHeight(18f);
      nestedTable.addCell(new Paragraph(""));
    
      nestedTable.setHorizontalAlignment(Element.ALIGN_LEFT);

      head1.addElement(nestedTable);
  */
 
  /*---------*/
 /*  BaseColor myColorpan = WebColors.getRGBColor("#b60548"); */
 
   PdfPCell TripDETAILS = new PdfPCell(new Paragraph("TRIP DETAILS",Normal));
            TripDETAILS.setFixedHeight(20f);
           /*  TripDETAILS.setBackgroundColor(Color.lightGray); */
           TripDETAILS.setBackgroundColor(new java.awt.Color(0xC0, 0xC0, 0xC0));
  TripDETAILS.setHorizontalAlignment(Element.ALIGN_CENTER);
  
  PdfPCell  TripID = new PdfPCell(new Paragraph("Trip ID #",Normal));
  PdfPCell tripiddata = new PdfPCell(new Paragraph(Tripid,NormalFont));
  PdfPCell Tripidissuedate = new PdfPCell(new Paragraph("Issue Date",Normal));
 // PdfPCell dataTripidissuedate= new PdfPCell(new Paragraph(TripIDIssueDate,NormalFont)); 
 
   PdfPCell dataTripidissuedate= new PdfPCell(new Paragraph(tripiss,NormalFont)); 
   dataTripidissuedate.setHorizontalAlignment(Element.ALIGN_RIGHT);
  PdfPCell tripfrom = new PdfPCell(new Paragraph("Origin",Normal));
  PdfPCell datatripfrom = new PdfPCell(new Paragraph(TripFrom,NormalFont));
  PdfPCell Startdateandtime = new PdfPCell(new Paragraph("Trip Start",Normal));
  PdfPCell datastartdateandtime = new PdfPCell(new Paragraph(startdate12+" " +sttime,NormalFont)); 
  datastartdateandtime.setHorizontalAlignment(Element.ALIGN_RIGHT);
  PdfPCell TripTo1 = new PdfPCell(new Paragraph("Destination",Normal));
  PdfPCell dataTripto1 = new PdfPCell(new Paragraph(TripTo,NormalFont));
  PdfPCell End_Date_Time = new PdfPCell(new Paragraph("ETA",Normal));
  //PdfPCell dataEnd_Date_Time= new PdfPCell(new Paragraph(EndDate_Time,NormalFont)); 
  
  PdfPCell dataEnd_Date_Time= new PdfPCell(new Paragraph(enddtime,NormalFont)); 
  dataEnd_Date_Time.setHorizontalAlignment(Element.ALIGN_RIGHT);
   PdfPCell RouteRecomend = new PdfPCell(new Paragraph("Route Recommended",Normal));
  PdfPCell dataRouteRecomend = new PdfPCell(new Paragraph());
  PdfPCell TripType1 = new PdfPCell(new Paragraph("Category",Normal));
  PdfPCell dataTripType1 = new PdfPCell(new Paragraph(TripType,NormalFont));  
  /*---------------------------------------------------------------------------*/
  PdfPCell CUSTOMERDETAILS = new PdfPCell(new Paragraph("CUSTOMER DETAILS",Normal));
  CUSTOMERDETAILS.setHorizontalAlignment(Element.ALIGN_CENTER);
  CUSTOMERDETAILS.setBackgroundColor(new java.awt.Color(0xC0, 0xC0, 0xC0));
  PdfPCell TRUCK_DRIVER_DETAILS = new PdfPCell(new Paragraph("TRUCK & DRIVER DETAILS",Normal));
  TRUCK_DRIVER_DETAILS.setHorizontalAlignment(Element.ALIGN_CENTER);
  TRUCK_DRIVER_DETAILS.setBackgroundColor(new java.awt.Color(0xC0, 0xC0, 0xC0));
  /*----------------------------------------------------------------------------*/
  
  
  
   PdfPCell CustomerName1 = new PdfPCell(new Paragraph("Customer",Normal));
  PdfPCell dataCustomerName1 = new PdfPCell(new Paragraph(CustomerName,NormalFont));
  PdfPCell DriverName1 = new PdfPCell(new Paragraph("Driver",Normal));
  PdfPCell dataDriverName1 = new PdfPCell(new Paragraph(DriverName,NormalFont)); 
  
  
  PdfPCell LPO1 = new PdfPCell(new Paragraph("LPO #",Normal));
 PdfPCell dataLPO1 = new PdfPCell(new Paragraph(LPO,NormalFont));
 PdfPCell EmployeeRefNo1 = new PdfPCell(new Paragraph("Employee Ref No",Normal));
 PdfPCell dataEmployeeRefNo = new PdfPCell(new Paragraph(EmployeeRefNo,NormalFont));
 
 
 PdfPCell CustomerContPerson1 = new PdfPCell(new Paragraph("Contact Person",Normal));
 PdfPCell dataCustomerContPerson1= new PdfPCell(new Paragraph(CustomerContPerson,NormalFont));
 PdfPCell TruckNo1 = new PdfPCell(new Paragraph("Truck No",Normal));
 PdfPCell dataTruckNo1 = new PdfPCell(new Paragraph(TruckNo,NormalFont)); 
 
 

 PdfPCell CustomerContNo1 = new PdfPCell(new Paragraph("Contact No",Normal));
 PdfPCell dataCustomerContNo1= new PdfPCell(new Paragraph(CustomerContNo,NormalFont));
 PdfPCell TrailarNo1 = new PdfPCell(new Paragraph("Trailer No",Normal));
 PdfPCell dataTrailarNo = new PdfPCell(new Paragraph(TrailarNo,NormalFont)); 
  
 
 /***************/
  PdfPCell CONTAINERDETAILS = new PdfPCell(new Paragraph("CONTAINER DETAILS",Normal));
  CONTAINERDETAILS.setBackgroundColor(new java.awt.Color(0xC0, 0xC0, 0xC0));
  CONTAINERDETAILS.setHorizontalAlignment(Element.ALIGN_CENTER);
 /***************/
 
 PdfPCell ContainerNo1 = new PdfPCell(new Paragraph("Container No",Normal));
 PdfPCell dataContainerNo1= new PdfPCell(new Paragraph(ContainerNo,NormalFont));
 PdfPCell ContainerStatus1 = new PdfPCell(new Paragraph("Container Status",Normal));
 PdfPCell dataContainerStatus1= new PdfPCell(new Paragraph(ContainerStatus,NormalFont)); 
 
 PdfPCell ContainerType1 = new PdfPCell(new Paragraph("Container Type",Normal));
 PdfPCell dataContainerType1 = new PdfPCell(new Paragraph(ContainerType,NormalFont));
 PdfPCell Remarks= new PdfPCell(new Paragraph("Remarks:",Normal));
 Remarks.setBorder(Rectangle.NO_BORDER);
 Remarks.setBorder(Rectangle.LEFT);
 //Remarks.setColspan(2);
 PdfPCell dataRemarks= new PdfPCell(new Paragraph(comments,NormalFont)); 
 dataRemarks.setBorder(Rectangle.NO_BORDER);
 dataRemarks.setBorder(Rectangle.RIGHT);
 PdfPCell TokenNo1 = new PdfPCell(new Paragraph("Token No",Normal));
 PdfPCell dataTokenNo1 = new PdfPCell(new Paragraph(TokenNo,NormalFont));
 PdfPCell Remarks1= new PdfPCell(new Paragraph("",Normal));
 Remarks1.setBorder(Rectangle.NO_BORDER);
 Remarks1.setBorder(Rectangle.LEFT);
 //Remarks1.setColspan(2);
 PdfPCell dataRemarks1= new PdfPCell(new Paragraph()); 
 dataRemarks1.setBorder(Rectangle.NO_BORDER);
 dataRemarks1.setBorder(Rectangle.RIGHT);
 PdfPCell TokenChargesPaid1 = new PdfPCell(new Paragraph("Token Charges Paid",Normal));
 PdfPCell dataTokenChargesPaid1 = new PdfPCell(new Paragraph(TokenChargesPaid,NormalFont));
 PdfPCell Remarks2= new PdfPCell(new Paragraph("",Normal));
 Remarks2.setBorder(Rectangle.NO_BORDER);
 Remarks2.setBorder(Rectangle.LEFT);
 PdfPCell dataRemarks2= new PdfPCell(new Paragraph());
 dataRemarks2.setBorder(Rectangle.NO_BORDER);
 dataRemarks2.setBorder(Rectangle.RIGHT);
 // Remarks2.setColspan(2);
 PdfPCell SalesPerson1 = new PdfPCell(new Paragraph("Sales Person",Normal));
 PdfPCell dataSalesPerson1 = new PdfPCell(new Paragraph(SalesPerson,NormalFont));
 PdfPCell Remarks3= new PdfPCell(new Paragraph("",Normal));
 Remarks3.setBorder(Rectangle.NO_BORDER);
 Remarks3.setBorder(Rectangle.LEFT);
 PdfPCell dataRemarks3= new PdfPCell(new Paragraph()); 
 dataRemarks3.setBorder(Rectangle.NO_BORDER);
 dataRemarks3.setBorder(Rectangle.RIGHT);
 //Remarks3.setColspan(2);
 
 /***************/
 PdfPCell Note1;
 if(note=="-"||note==null||note.trim()==""||note=="_")
 {
	 note="Note";
/*  Note = new PdfPCell(new Paragraph("Note:",Normal));
 Note.setHorizontalAlignment(Element.ALIGN_LEFT);
 System.out.println("Note default===>"+note); */
 }
 
 Note1 = new PdfPCell(new Paragraph(note,Normal));
 Note1.setHorizontalAlignment(Element.ALIGN_LEFT);
 System.out.println("Note present===>"+note);
 
// Note.setHorizontalAlignment(Element.ALIGN_LEFT);
/***************/
 

 PdfPCell Declaration = new PdfPCell(new Paragraph("Declaration: Material Accepted in good condition.                                                                       Customer Sign & Stamp:",Normal));
 Declaration.setFixedHeight(72f);
 PdfPCell Preparedby = new PdfPCell(new Paragraph("Prepared By: "+mainusr3+" "+mainusr4+"                                                                                                                     "+DateTimeStamp,Normal));
 PdfPCell ADDRESS = new PdfPCell(new Paragraph("Address: "+address,Normal));
 PdfPCell Fleetmanagement = new PdfPCell(new Paragraph("Fleet Management Service Provided By Transworld Technologies Ltd.",Normal));
           Fleetmanagement.setHorizontalAlignment(Element.ALIGN_CENTER);
 //PdfPCell dataADDRESS = new PdfPCell(new Paragraph(SalesPerson,NormalFont));
 //Note.setHorizontalAlignment(Element.ALIGN_LEFT);
 
 p1.addCell(TripDETAILS);
  
  table.addCell(TripID);
  table.addCell(tripiddata);
  table.addCell(Tripidissuedate);
  table.addCell(dataTripidissuedate);
  document.add(Chunk.NEWLINE);

  table.addCell(tripfrom);
  table.addCell(datatripfrom);
  table.addCell(Startdateandtime);
  table.addCell(datastartdateandtime);
  document.add(Chunk.NEWLINE);
  

  table.addCell(TripTo1);
  table.addCell(dataTripto1);
  table.addCell(End_Date_Time);
  table.addCell(dataEnd_Date_Time);
  document.add(Chunk.NEWLINE);

  table.addCell(RouteRecomend);
  table.addCell(dataRouteRecomend);
  table.addCell(TripType1);
  table.addCell(dataTripType1);
  document.add(Chunk.NEWLINE);
  
  
/*  Table1  */  
  table1.addCell(CUSTOMERDETAILS);
  table1.addCell(TRUCK_DRIVER_DETAILS);
  /*  Table2  */  
  table2.addCell(CustomerName1);
  table2.addCell(dataCustomerName1);
  table2.addCell(DriverName1);
  table2.addCell(dataDriverName1);
  
  table2.addCell(LPO1);
  table2.addCell(dataLPO1);
  table2.addCell(EmployeeRefNo1);
  table2.addCell(dataEmployeeRefNo);
  
  table2.addCell(CustomerContPerson1);
  table2.addCell(dataCustomerContPerson1);
  table2.addCell(TruckNo1);
  table2.addCell(dataTruckNo1);
  
  table2.addCell(CustomerContNo1);
  table2.addCell(dataCustomerContNo1);
  table2.addCell(TrailarNo1);
  table2.addCell(dataTrailarNo);
  
  table3.addCell(CONTAINERDETAILS);
  
  
  table4.addCell(ContainerNo1);
  table4.addCell(dataContainerNo1);
  table4.addCell(ContainerStatus1);
  table4.addCell(dataContainerStatus1);
  
  table4.addCell(ContainerType1);
  table4.addCell(dataContainerType1);
  table4.addCell(Remarks);
  table4.addCell(dataRemarks);
 
  table4.addCell(TokenNo1);
  table4.addCell(dataTokenNo1);
  table4.addCell(Remarks1);
  
  table4.addCell(dataRemarks1);
  
  table4.addCell(TokenChargesPaid1);
  table4.addCell(dataTokenChargesPaid1);
  table4.addCell(Remarks2);
  table4.addCell(dataRemarks2);
  
  table4.addCell(SalesPerson1);
  table4.addCell(dataSalesPerson1);
  table4.addCell(Remarks3);
  table4.addCell(dataRemarks3);
  
	  table5.addCell(Note1);
  
  table6.addCell(Declaration);
  table7.addCell(Preparedby);
  table8.addCell(ADDRESS);
  table9.addCell(Fleetmanagement);
  head.addCell(logo);
  head.addCell(head1); 
  //head.addCell(head1);
//  head.addCell(logo);
  myfleetview.addCell(myflv);
  //document.add(new Paragraph("A Hello World PDF document."));
  document.add(myfleetview);
  document.add(head);
  document.add(p1);
  document.add(table);
  document.add(table1);
  document.add(table2);
  document.add(table3);
  document.add(table4);
  document.add(table5);
  document.add(table6);
  document.add(table7);
  document.add(table8);
  document.add(table9);
     document.close();
     //writer.close();
	
	
    
	
}


	 catch(Exception e)
	   {
		  e.printStackTrace();
	   }



finally
{
		try
		{
			System.out.println("success");
		 conn.close();
		}
		catch(Exception e){}
}
	


%>
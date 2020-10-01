<%@ include file="Connections/conn.jsp" %>
<%@
page import="javax.*,
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
org.jfree.chart.plot.PiePlot3D;"%>

  <%!
	Connection conn, conn1;
	Statement st1,st2,st,st3,st4,st5,st6,st7,st8,st9,st10,st11;
    ResultSet rst1,rst2,rst3,rst4,rst5,rst6,rst7,rst8;
    
    public class CustomRenderer extends BarRenderer
    {
       
       public java.awt.Paint getItemPaint(int row,int column)	//this meth is overriden to giv diff color to each bar in bar chart
       {
          Color color;   
          
          if(column == 0) color = Color.GREEN;   
          else if(column == 1) color = Color.YELLOW;
          else if(column == 2) color = Color.BLUE;
          else if(column == 3) color = Color.MAGENTA;
          else if(column == 4) color = Color.ORANGE;
          else color = new Color(0,0,0);
          
          return color;
       }
    
    }
    
  /*  public class BGClass1 implements PdfPCellEvent
    {
    public void cellLayout(PdfPCell arg0, Rectangle arg1, PdfContentByte[] arg2) {
        try {
            PdfContentByte pdfContentByte = arg2[PdfPTable.BACKGROUNDCANVAS];
            Image bgImage = Image.getInstance("../images/");
            pdfContentByte.addImage(bgImage, arg1.getWidth(), 0, 0, arg1
                    .getHeight(), arg1.getLeft(), arg1.getBottom());

        } catch (BadElementException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    }*/
%>
<%
String ss=session.getAttribute("VehList").toString();
String usertypevalue=session.getAttribute("usertypevalue").toString();
String today1=request.getParameter("today1");
//System.out.print("veh List"+ss);

	NumberFormat nf = DecimalFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);	
	nf.setGroupingUsed(false);
	
	//daily
	String grt250="",dist_grt250="",avg_grt250="";
	String less250="",dist1_less250="",avg_less250="";
	String idle="",dist2_idle="",avg_idle="";
	String totalvehd="",totalrunkmd="",totalavgkmd="",offline="";
	
	String top1_d="",top2_d="",top3_d="";
	String veh1_d="",veh2_d="",veh3_d="";
	
	//month
	String grt250_m="",dist1_m="",avgg_m="";
	String less250_m="",dist2_m="",avgl_m="";
	String idle_m="",dist3_m="",avgi_m="";
	String totalveh_m="",totalrunkm_m="",totalavgkm_m="",offline_m="";
	
	String top1_m="",top2_m="",top3_m="";
	String veh1_m="",veh2_m="",veh3_m="";
	//------------------------------------------------
	
	String top5_1="",top5_2="",top5_3="",top5_4="",top5_5="";
	String veh5_1="",veh5_2="",veh5_3="",veh5_4="",veh5_5="";
	int totalveh=0,totalrunkm=0,totalavgkm=0;
	String veh1="",veh2="",veh3="",veh4="",veh5="";
	String veh11="",veh22="",veh33="",veh44="",veh55="";
	 
	String sql,sql1,sql2,sql3,sql5;

try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		
st1=conn.createStatement();
st2=conn1.createStatement();
st3=conn1.createStatement();	
st4=conn1.createStatement();
st5=conn.createStatement();
st6=conn1.createStatement();
st7=conn1.createStatement();
st8=conn1.createStatement();
st9=conn1.createStatement();
st10=conn1.createStatement();
st11=conn1.createStatement();
int vcode2;
String vregno,sql7;
int tottransvehcnt=0,tottransvehcntm=0;


/*****************************************/
String sqlvehcnt="SELECT count(VehicleCode) as count FROM db_gps.`t_vehicledetails` where ownername = '"+usertypevalue+"' and status in ('-','Removed','Missing')";
ResultSet rstcnt=st1.executeQuery(sqlvehcnt);
//System.out.println("Todays date"+today1);
//System.out.println("sqlvehcnt1   ->"+sqlvehcnt);
if(rstcnt.next())
{
	tottransvehcnt=rstcnt.getInt("count");
}

int g_d=0,dis_d=0;
Double a_d=0.0; 

/**************run km >=250***************************/
sql1="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance >= 250 and TheDate ='"+today1+"'";//'2010-08-22';// and TheDate >='"+data1+"'";
rst1=st2.executeQuery(sql1);
if(rst1.next())
 {
	
	g_d=rst1.getInt("vehcount");
	grt250=""+g_d;
	
	dis_d=rst1.getInt("Distance");
	dist_grt250=""+dis_d;
	
	a_d=rst1.getDouble("AVG");
	avg_grt250=""+nf.format(a_d);
	
/*	grt250=rst1.getString("vehcount");
	dist_grt250=rst1.getString("Distance");
	avg_grt250=rst1.getString("AVG");*/
 }

/**************run km <250***************************/
int l_d=0,l_dis_d=0;
Double la_d=0.0;	
sql2="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance < 250 and  Distance > 10 and TheDate ='"+today1+"'";//'2010-08-22'";// and TheDate >='"+data1+"'";
 // System.out.println("Sql2--------->"+sql2);
 rst2=st7.executeQuery(sql2);
if(rst2.next())
 {
	l_d=rst2.getInt("vehcount");
	less250=""+l_d;
	
	l_dis_d=rst2.getInt("Distance");
	dist1_less250=""+l_dis_d;
	
	la_d=rst2.getDouble("AVG");
	
	avg_less250=""+nf.format(la_d);
	
/*	less250=rst2.getString("vehcount");
	dist1_less250=rst2.getString("Distance");
	avg_less250=rst2.getString("AVG");*/
 }
/*************run km <10***************************/
int l10_d=0,l10_dis_d=0;
Double la10_d=0.0;
sql3="select count(*) as vehcount,sum(Distance) as Distance,format(sum(Distance)/count(*),2) as AVG from t_vehall_ds where  VehCode in "+ss+" and Distance <= 10 and Location not like '%NO DATA%' and TheDate ='"+today1+"'";//'2010-08-22'";// and TheDate >='"+data1+"'";

	rst6=st4.executeQuery(sql3);
	if(rst6.next())
	 {
		l10_d=rst6.getInt("vehcount");
		idle=""+l10_d;
		
		l10_dis_d=rst6.getInt("Distance");
		dist2_idle=""+l10_dis_d;
		
		la10_d=rst6.getDouble("AVG");
		
		avg_idle=""+nf.format(la10_d);
		
	/*	idle=rst6.getString("vehcount"); 
		dist2_idle=rst6.getString("Distance");
		avg_idle=rst6.getString("AVG");*/
		
	}
	
	/**************** vechicle offline*****************/

	offline=""+(tottransvehcnt-(Integer.parseInt(idle)+Integer.parseInt(less250)+Integer.parseInt(grt250)));
	
	//total
	totalvehd=""+tottransvehcnt;
	
	totalrunkm=(Integer.parseInt(dist_grt250)+Integer.parseInt(dist1_less250)+Integer.parseInt(dist2_idle));
	totalrunkmd=""+totalrunkm;
	
	totalavgkm=totalrunkm/tottransvehcnt;
	nf.format(totalavgkm);
	totalavgkmd=""+totalavgkm;
	
/************************************  PDF  *******************************************************/
//System.out.println(in)
response.setContentType("application/pdf");
String filename=session.getAttribute("user").toString()+"Daily_report.pdf";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
Document document = new Document();
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter writer=PdfWriter.getInstance(document, buffer);

//pdfs commands are written to the stream as soon as a method is triggered.
/*HeaderFooter footer = new HeaderFooter(new Phrase("Copyright Transworld Compressor Technologies Ltd.\n- All Rights Reserved.Paid Service from FleetView. For enquiry, please call +91-20-41214444 or email V_Lalwani@MyFleetView.com"),false);
footer.setAlignment(Element.ALIGN_CENTER);

document.setFooter(footer);*/

document.open();

PdfPTable tab_logo = new PdfPTable(2);	//table for logo
tab_logo.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

Image jpg=Image.getInstance("/home/shweta/newworkspace/FleetView/WebContent/images/Transworld.jpeg");
PdfPCell clogo = new PdfPCell();
clogo.setImage(jpg);
clogo.setFixedHeight(40);
clogo.setBorder(0);

Image jpg_mob=Image.getInstance("/home/shweta/newworkspace/FleetView/WebContent/images/logo.jpg");
PdfPCell clogo_mob = new PdfPCell();
clogo_mob.setFixedHeight(50);
clogo_mob.setImage(jpg_mob);
clogo_mob.setBorder(0);

tab_logo.addCell(clogo);
tab_logo.addCell(clogo_mob);
document.add(tab_logo);

PdfPTable tabouter_daily = new PdfPTable(2);	//outer table for daily
tabouter_daily.getDefaultCell().setBorder(PdfPCell.NO_BORDER);


//--------------TABLE FOR DAILY STATUS-----------------------
String titl="<-------------Today------------->";

PdfPTable title = new PdfPTable(1);
title.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
title.addCell(titl);
//document.add(title);

//----------------------
tabouter_daily.addCell(title);
//-----------------------

PdfPTable table = new PdfPTable(4);
table.getDefaultCell().setBorder(1);

int[] columnWidths = {30,20,25,25};
table.setWidths(columnWidths);



PdfPCell c11=new PdfPCell(new Paragraph(""));
c11.setBorder(0);
table.addCell(c11);

PdfPCell c=new PdfPCell(new Paragraph("Vehs"));
c.setBackgroundColor(Color.CYAN);
c.setBorder(0);
table.addCell(c);

PdfPCell c1=new PdfPCell(new Paragraph("Run km"));
c1.setBackgroundColor(Color.CYAN);
c1.setBorder(0);
table.addCell(c1);

PdfPCell c2=new PdfPCell(new Paragraph("Avg. km"));
c2.setBackgroundColor(Color.CYAN);
c2.setBorder(0);
table.addCell(c2);

PdfPCell cell=new PdfPCell(new Paragraph("Run>=250"));
cell.setBackgroundColor(Color.RED);

cell.setBorder(0);
table.addCell(cell);
table.addCell(grt250);
table.addCell(dist_grt250);
table.addCell(avg_grt250);

PdfPCell cell1=new PdfPCell(new Paragraph("Run<250"));
cell1.setBackgroundColor(Color.BLUE);
cell1.setBorder(0);

table.addCell(cell1);
table.addCell(less250);
table.addCell(dist1_less250);
table.addCell(avg_less250);

PdfPCell cell2=new PdfPCell(new Paragraph("Idle"));
cell2.setBackgroundColor(Color.GREEN);
cell2.setBorder(0);

table.addCell(cell2);
table.addCell(idle);
table.addCell(dist2_idle);
table.addCell(avg_idle);

PdfPCell cell3=new PdfPCell(new Paragraph("Offline"));
cell3.setBackgroundColor(Color.YELLOW);
cell3.setBorder(0);
table.addCell(cell3);
table.addCell(offline);
table.addCell("0");
table.addCell("0");


table.addCell("Total");
table.addCell(totalvehd);
table.addCell(totalrunkmd);
table.addCell(totalavgkmd);
//document.add(table);		//daily status table


//--------------------PIE CHART FOR DAILY STATUS-----------------------


Double _grt250=Double.parseDouble(grt250);
//System.out.println("_grt250==>"+_grt250);
Double _less250=Double.parseDouble(less250);
Double _idle=Double.parseDouble(idle);
Double _offline=Double.parseDouble(offline);

			DefaultPieDataset dataSet = new DefaultPieDataset();
	        dataSet.setValue("Run>=250", _grt250);
	        dataSet.setValue("Run <250 KM and Run> 10 KM", _less250);
	   	 	dataSet.setValue("Idle <10 KM", _idle);
	        dataSet.setValue("Veh Offline", _offline);
	       
	        JFreeChart pie_chart = ChartFactory.createPieChart3D("Pie chart", dataSet, true, true, false);	//create pie chart
	        PiePlot3D p=(PiePlot3D)pie_chart.getPlot();	// method is used to get the object of the plot for 3D Pie Chart.It returns the reference of Plot but we have to typecast it as a PiePlot3D
	        p.setLabelGenerator(null);
	       
	       /* ChartFrame frame1=new ChartFrame("Pie Chart",pie_chart);	//TO DRAW IN A FRAME
	        frame1.setVisible(true);
	        frame1.setSize(300,300);*/
	      // write pie chart to pdf file
	       	PdfContentByte contentByte = writer.getDirectContent();
	        PdfTemplate template = contentByte.createTemplate(250, 150);
	      	Graphics2D graphics2d = template.createGraphics(250, 150,new DefaultFontMapper());
	      	Rectangle2D rectangle2d = new Rectangle2D.Double(0, 0, 250,150);
	 		pie_chart.draw(graphics2d, rectangle2d);
	    	graphics2d.dispose();
	       	//contentByte.addTemplate(template, 500, 500);	 //adding to absolute coordinates
	       	Image img=Image.getInstance(template);
	      // 	img.setTemplateData(template, 500, 500);
	      // document.add(img);
	      
	      /*	PdfPTable tab_pie = new PdfPTable(1);
	      	tab_pie.addCell(img);
			document.add(tab_pie);*/
	       
			
			
			/******************************  code for top 3 vehicles********************************************/
			
			int cnt=0,cnt1=0;
			sql5="select distinct(VehCode),Distance from t_vehall_ds where  VehCode in "+ss+" and TheDate ='"+today1+"' order by Distance Desc limit 3";
				//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
			//System.out.println("new     "+sql5);
			 rst5=st11.executeQuery(sql5);
			//System.out.println("new1--------> "+sql5);
			while(rst5.next())
			{
				
				cnt++;
				if(cnt==1)
				{
					top1_d=rst5.getString("Distance");
				}
				else if(cnt==2)
				{
					top2_d=rst5.getString("Distance");
				}
				else if(cnt==3)
				{
					top3_d=rst5.getString("Distance");
				}
				
				//System.out.println("Distance-- VehCode----->"+rst5.getDouble("Distance")+"   "+rst5.getInt("VehCode"));
				String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
				
				//System.out.println("sql8-------->"+sql8);
				
				ResultSet rveh=st1.executeQuery(sql8);
				while(rveh.next())
				{
					
					cnt1++;
					if(cnt1==1)
					{
						veh1_d=""+rveh.getString("VehicleRegNumber");
					}
					else if(cnt1==2)
					{
						veh2_d=""+rveh.getString("VehicleRegNumber");
					}
					else if(cnt1==3)
					{
						veh3_d=""+rveh.getString("VehicleRegNumber");
					}
					
				}	
			}
//---------------------------------------------------------------

String titl1="\tTop 3 Vehicles : Today";

PdfPTable title_3 = new PdfPTable(1);

title_3.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
title_3.addCell(titl1);
//document.newPage();
//document.add(title_3);

//----------------------
tabouter_daily.addCell(title_3);
//-----------------------

PdfPTable table_top3veh = new PdfPTable(2);
table_top3veh.getDefaultCell().setBorder(1);

PdfPCell c_top=new PdfPCell(new Paragraph("Vehs"));
c_top.setBackgroundColor(Color.LIGHT_GRAY);	//set background color for top 3 vehs
table_top3veh.addCell(c_top);

PdfPCell c_top1=new PdfPCell(new Paragraph("KM"));
c_top1.setBackgroundColor(Color.LIGHT_GRAY);
table_top3veh.addCell(c_top1);



table_top3veh.addCell(veh1_d);
table_top3veh.addCell(top1_d);

table_top3veh.addCell(veh2_d);
table_top3veh.addCell(top2_d);

table_top3veh.addCell(veh3_d);
table_top3veh.addCell(top3_d);

//document.add(table_top3veh);	//top 3 veh table

//----------------------
tabouter_daily.addCell(table);
tabouter_daily.addCell(table_top3veh);
//-----------------------

//--------------------BAR CHART FOR TOP 3 VEH-----------------------
Double _top1_d=Double.parseDouble(top1_d);

Double _top2_d=Double.parseDouble(top2_d);
Double _top3_d=Double.parseDouble(top3_d);
//System.out.println("_top1_d==>"+_top1_d);

			DefaultCategoryDataset barchart_data = new DefaultCategoryDataset();
			barchart_data.setValue(_top1_d, "Population", veh1_d);
			barchart_data.setValue(_top2_d, "Population", veh2_d);
			barchart_data.setValue(_top3_d, "Population", veh3_d);
			//ChartFactory.createBarChart(chart title, domain axis label, range axis label, data, the plot orientation, include legend, false);
	        JFreeChart bar_chart = ChartFactory.createBarChart("Top 3 veh", "Veh reg No.", "KM",barchart_data, PlotOrientation.VERTICAL, false, true, false);
	        CategoryPlot plot = bar_chart.getCategoryPlot();
	        // Set custom renderer which will custom draw the bar colors
	        plot.setRenderer( new CustomRenderer());
	   

	   			 // write pie chart to pdf file
		      	PdfContentByte contentByte_top3 = writer.getDirectContent();
	        	
		       	PdfTemplate template_top3 = contentByte_top3.createTemplate(200, 150);
		       	
		      	Graphics2D graphics2d_top3 = template_top3.createGraphics(200, 150,new DefaultFontMapper());
		      	Rectangle2D rectangle2d_top3 = new Rectangle2D.Double(0,0, 200,150);
		      	bar_chart.draw(graphics2d_top3, rectangle2d_top3);
		      	graphics2d_top3.dispose();
		       //	contentByte.addTemplate(template, 0, 0);
		       	Image img_top3=Image.getInstance(template_top3);
		       	
		      /* PdfPTable tab_barch = new PdfPTable(1);
		       	tab_barch.addCell(img_top3);
				document.add(tab_barch);*/
				//document.add(img_top3);
				
				//----------------------
				tabouter_daily.addCell(img);
				tabouter_daily.addCell(img_top3);
				
				document.add(tabouter_daily);
				//-----------------------
				
	//===============================================================================================================================================
int g_m=0,dis=0;
Double a_m=0.0; 
/****************Monthly Status code        **************/
	
		/**************run km >250***************************/
String start=new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(today1));
start=start+"-01";
 String pd=new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(today1));
sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms >= 250";
//	System.out.println(">250 n"+sql);
		//"SELECT vehcode,  Distance as sum,format(( Distance ) / '"+pd+"' , 2 ) AS AVG from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"' group by vehcode";
	   rst3=st8.executeQuery(sql);
	  // System.out.println("Monthm------>"+sql);
	   
	 //  System.out.println("Monthm------>"+sql);
 
	   while(rst3.next())
	   {
		   g_m=rst3.getInt("veh");
		   grt250_m=""+g_m;
		   dis=rst3.getInt("Dist");
		   dist1_m=""+dis;
		   a_m=rst3.getDouble("avg");
		   
		   avgg_m=""+nf.format(a_m);
	   }	



	   /**************run km <250***************************/
	   int l_m=0,l_dis=0;
		Double la_m=0.0;
		sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms < 250 and avgKms > 10";
		//"SELECT vehcode,  Distance as sum,format(( Distance ) / '"+pd+"' , 2 ) AS AVG from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"' group by vehcode";
	  ResultSet rstt3=st8.executeQuery(sql);
	  
	   while(rstt3.next())
	   {
		   
		   l_m=rstt3.getInt("veh");
		   less250_m=""+l_m;
		   l_dis=rstt3.getInt("Dist");
		   dist2_m=""+l_dis;
		   la_m=rstt3.getDouble("avg");
		   
		   avgl_m=""+nf.format(la_m);
		  
	   }

	   /*************run km <10***************************/
	   	int l10_m=0,l10_dis=0;
		Double la10_m=0.0;
		sql="SELECT count( vehs ) as veh , sum( runkms ) as Dist , sum( runkms )/count( vehs ) as avg FROM ( SELECT DISTINCT (VehCode) AS vehs, sum( Distance ) AS runkms, format( sum( Distance ) / '"+pd+"' , 2 ) AS avgKms FROM db_gpsExceptions.t_vehall_ds WHERE VehCode in "+ss+"  and TheDate >='"+start+"' and TheDate <='"+today1+"' GROUP BY VehCode) AS fact WHERE avgKms < 10";
			//"SELECT vehcode,  Distance as sum,format(( Distance ) / '"+pd+"' , 2 ) AS AVG from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"' group by vehcode";
		  ResultSet rsttt3=st8.executeQuery(sql);
		  
		   while(rsttt3.next())
		   {
			   l10_m=rsttt3.getInt("veh");
			   idle_m=""+l10_m;
			   l10_dis=rsttt3.getInt("Dist");
			   dist3_m=""+l10_dis;
			   la10_m=rsttt3.getDouble("avg");
			   
			   avgi_m=""+nf.format(la10_m);
			   
		   }

		   /**************** vechicle offline*******************/
			offline_m=""+(tottransvehcnt-(Integer.parseInt(grt250_m)+Integer.parseInt(less250_m)+Integer.parseInt(idle_m)));

			//total
			 totalveh_m=""+tottransvehcnt;
			// int distsum=rst3.getInt("Dist")+rstt3.getInt("Dist")+rsttt3.getInt("Dist");
			 totalrunkm_m=""+(Integer.parseInt(dist1_m)+Integer.parseInt(dist2_m)+Integer.parseInt(dist3_m));
			 int totavg_m=(Integer.parseInt(totalrunkm_m)/tottransvehcnt);
			 nf.format(totavg_m);
			 totalavgkm_m=""+totavg_m;

			//--------------TABLE FOR MONTHLY STATUS-----------------------	
			
			
PdfPTable tabouter_m = new PdfPTable(2);		//outer table for monthly
tabouter_m.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
titl="<--------MTD-------->";

PdfPTable title_m = new PdfPTable(1);
title_m.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
title_m.addCell(titl);
//document.newPage();
//document.add(title_m);
//--------------------------
tabouter_m.addCell(title_m);
//-------------------------

			 PdfPTable table_m = new PdfPTable(4);
			// table_m.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			 table_m.getDefaultCell().setBorder(1);
			 
			 table_m.setWidths(columnWidths);	//set width of each col
			 table_m.addCell("");
			 
			 PdfPCell c_m1=new PdfPCell(new Paragraph("Veh"));
			 c_m1.setBackgroundColor(Color.CYAN);
			 table_m.addCell(c_m1);
			 
			 PdfPCell c_m2=new PdfPCell(new Paragraph("Run km"));
			 c_m2.setBackgroundColor(Color.CYAN);
			 table_m.addCell(c_m2);
			 
			 PdfPCell c_m3=new PdfPCell(new Paragraph("Avg. km"));
			 c_m3.setBackgroundColor(Color.CYAN);
			 table_m.addCell(c_m3);
			 
			 PdfPCell cell_m1=new PdfPCell(new Paragraph("Run>=250"));
			 cell_m1.setBackgroundColor(Color.RED);
			 cell_m1.setBorder(0);
			 table_m.addCell(cell_m1);
			 table_m.addCell(grt250_m);
			 table_m.addCell(dist1_m);
			 table_m.addCell(avgg_m);
				
			 PdfPCell cell_m2=new PdfPCell(new Paragraph("Run<250"));
			 cell_m2.setBackgroundColor(Color.BLUE);
			 cell_m2.setBorder(0);
			 table_m.addCell(cell_m2);
			 table_m.addCell(less250_m);
			 table_m.addCell(dist2_m);
			 table_m.addCell(avgl_m);

			 PdfPCell cell_m3=new PdfPCell(new Paragraph("Idle"));
			 cell_m3.setBackgroundColor(Color.GREEN);
			 cell_m3.setBorder(0);
			 table_m.addCell(cell_m3);
			 table_m.addCell(idle_m);
			 table_m.addCell(dist3_m);
			 table_m.addCell(avgi_m);

			 PdfPCell cell_m4=new PdfPCell(new Paragraph("Offline"));
			 cell_m4.setBackgroundColor(Color.YELLOW);
			 cell_m4.setBorder(0);
			 table_m.addCell(cell_m4);
			 table_m.addCell(offline_m);
			 table_m.addCell("0");
			 table_m.addCell("0");

			 table_m.addCell("Total");
			 table_m.addCell(totalveh_m);
			 table_m.addCell(totalrunkm_m);
			 table_m.addCell(totalavgkm_m);


			// document.add(table_m);		
			 

			 
			//--------------------PIE CHART FOR MONTHLY STATUS-----------------------
			Double _grt250_m,_less250_m,_idle_m,_offline_m;
			
			  _grt250_m=Double.parseDouble(grt250_m);
			  _less250_m=Double.parseDouble(less250_m);
			  _idle_m=Double.parseDouble(idle_m);
			  _offline_m=Double.parseDouble(offline_m);
			
				
			 


			 			DefaultPieDataset dataSet_m = new DefaultPieDataset();
			 			dataSet_m.setValue("Run>=250", _grt250_m);
			 			dataSet_m.setValue("Run <250 KM and Run> 10 KM", _less250_m);
			 			dataSet_m.setValue("Idle <10 KM", _idle_m);
			 			dataSet_m.setValue("Veh Offline", _offline_m);
			 	       
			 	        JFreeChart pie_chart_m = ChartFactory.createPieChart3D("Pie chart month", dataSet_m, true, true, false);	//create pie chart
			 	       PiePlot3D p1=(PiePlot3D)pie_chart_m.getPlot();
				        p1.setLabelGenerator(null);
			 	      // write pie chart to pdf file
			 	       PdfContentByte contentByte_m = writer.getDirectContent();
			 	        PdfTemplate template_m = contentByte_m.createTemplate(250, 150);
			 	      	Graphics2D graphics2d_m = template_m.createGraphics(250, 150,new DefaultFontMapper());
			 	      	Rectangle2D rectangle2d_m = new Rectangle2D.Double(0, 0, 250,150);
			 	      	pie_chart_m.draw(graphics2d_m, rectangle2d_m);
			 	    	graphics2d_m.dispose();
			 	       	
			 	       	Image img_m=Image.getInstance(template_m);
			 	       
			 	      //  document.add(img_m);
			 	        
			 	        
			 	       /******************************  code for top 3 vehicles******************************************/
						
						int cnt3=0,cnt4=0;
						sql5="select distinct(VehCode),sum(Distance) as SUM from t_vehall_ds where  VehCode in  "+ss+" and TheDate <='"+today1+"' and TheDate >='"+start+"'group by vehcode order by sum(distance) desc limit 3";
							//"select VehicleCode,VehicleRegNumber from t_vehicledetails where VehicleCode in "+ss+"";
						//System.out.println("new     "+sql5);
						 rst5=st9.executeQuery(sql5);
					//	System.out.println("Month4--------> "+sql5);
						while(rst5.next())
						{
							
							cnt3++;
							if(cnt3==1)
							{
								top1_m=rst5.getString("SUM");
							}
							else if(cnt3==2)
							{
								top2_m=rst5.getString("SUM");
							}
							else if(cnt3==3)
							{
								top3_m=rst5.getString("SUM");
							}
							
							
							//System.out.println("Distance-- VehCode----->"+rst5.getDouble("Distance")+"   "+rst5.getInt("VehCode"));
							String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
							
							//System.out.println("sql8-------->"+sql8);
							
							ResultSet rveh=st1.executeQuery(sql8);
							while(rveh.next())
							{
								
								cnt4++;
								if(cnt4==1)
								{
									veh1_m=""+rveh.getString("VehicleRegNumber");
								}
								else if(cnt4==2)
								{
									veh2_m=""+rveh.getString("VehicleRegNumber");
								}
								else if(cnt4==3)
								{
									veh3_m=""+rveh.getString("VehicleRegNumber");
								}
							}
						}
						
						
						//================================================================================================================================   		
						
						
						titl="Top 3 Vehicles : MTD";

					PdfPTable title_m3 = new PdfPTable(1);
					title_m3.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
					title_m3.addCell(titl);
					
					//document.newPage();
					//document.add(title_m3); 
					//----------------------
						tabouter_m.addCell(title_m3);
					//-----------------------
					
					PdfPTable top3veh_m = new PdfPTable(2);
					//top3veh_m.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
					 top3veh_m.getDefaultCell().setBorder(1);
					
					PdfPCell c_topm=new PdfPCell(new Paragraph("Vehs"));
					c_topm.setBackgroundColor(Color.LIGHT_GRAY);	//set background color for top 3 vehs
					top3veh_m.addCell(c_topm);

					PdfPCell c_topm1=new PdfPCell(new Paragraph("KM"));
					c_topm1.setBackgroundColor(Color.LIGHT_GRAY);
					top3veh_m.addCell(c_topm1);
					
					


					top3veh_m.addCell(veh1_m);
					top3veh_m.addCell(top1_m);

					top3veh_m.addCell(veh2_m);
					top3veh_m.addCell(top2_m);

					top3veh_m.addCell(veh3_m);
					top3veh_m.addCell(top3_m);
					
					//document.add(top3veh_m);	//top 3 veh table
					
					//----------------------
					tabouter_m.addCell(table_m);
					tabouter_m.addCell(top3veh_m);
					//-----------------------

					//--------------------BAR CHART FOR TOP 3 VEH-----------------------
					Double _top1_m=Double.parseDouble(top1_m);
					Double _top2_m=Double.parseDouble(top2_m);
					Double _top3_m=Double.parseDouble(top3_m);
				//	System.out.println("_top1_m==>"+_top1_m);

								DefaultCategoryDataset barchart_data_m = new DefaultCategoryDataset();
								barchart_data_m.setValue(_top1_m, "Population", veh1_m);
								barchart_data_m.setValue(_top2_m, "Population", veh2_m);
								barchart_data_m.setValue(_top3_m, "Population", veh3_m);
									 
						        JFreeChart bar_chart_m = ChartFactory.createBarChart("Top 3 veh", "Veh reg No.", "KM",barchart_data_m, PlotOrientation.VERTICAL, false, true, false);
						        CategoryPlot plot_m = bar_chart_m.getCategoryPlot();
						        // Set custom renderer which will custom draw the bar colors
						        plot_m.setRenderer( new CustomRenderer());
						         // write pie chart to pdf file
							      	PdfContentByte contentByte_top3m = writer.getDirectContent();
						        	
							       	PdfTemplate template_top3m= contentByte_top3m.createTemplate(200, 150);
							       	
							      	Graphics2D graphics2d_top3m = template_top3m.createGraphics(200, 150,new DefaultFontMapper());
							      	Rectangle2D rectangle2d_top3m = new Rectangle2D.Double(0,0, 200,150);
							      	bar_chart_m.draw(graphics2d_top3m, rectangle2d_top3m);
							      	graphics2d_top3m.dispose();
							       //	contentByte.addTemplate(template, 0, 0);
							       	Image img_top3m=Image.getInstance(template_top3m);
							       
									//document.add(img_top3m);
									
									//----------------------
										tabouter_m.addCell(img_m);
										tabouter_m.addCell(img_top3m);
									//-----------------------
									
									document.add(tabouter_m);
//===============================================================================================================================================		
									
PdfPTable tabouter_top5 = new PdfPTable(2);			
tabouter_top5.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
titl="\tStoppage duration -Top 5 Veh with Km run > 10 KM"+"\n\t"+"<-----------Today---------->";

PdfPTable title_5 = new PdfPTable(1);
title_5.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
title_5.addCell(titl);


//document.newPage();
//document.add(title_5);  	

//----------------------
tabouter_top5.addCell(title_5);
//-----------------------
/******************************  code for top 5 vehicles********************************************/
	int cnt6=0,cnt5=0;
sql5="select distinct(VehCode),DayStopDurationinHrs from t_vehall_ds where  VehCode in "+ss+" and distance>10 and TheDate ='"+today1+"' order by DayStopDurationinHrs Desc limit 5";
 rst5=st10.executeQuery(sql5);
 
					while(rst5.next())
					{
							
							cnt5++;
							if(cnt5==1)
							{
								top5_1=rst5.getString("DayStopDurationinHrs");
							}
							else if(cnt5==2)
							{
								top5_2=rst5.getString("DayStopDurationinHrs");
							}
							else if(cnt5==3)
							{
								top5_3=rst5.getString("DayStopDurationinHrs");
							}
							else if(cnt5==4)
							{
								top5_4=rst5.getString("DayStopDurationinHrs");
							}
							else if(cnt5==5)
							{
								top5_5=rst5.getString("DayStopDurationinHrs");
							}
							
							//System.out.println("Distance-- VehCode----->"+rst5.getDouble("Distance")+"   "+rst5.getInt("VehCode"));
							String sql8="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+rst5.getInt("VehCode")+"'";
							
							//System.out.println("sql8-------->"+sql8);
							
							ResultSet rveh=st1.executeQuery(sql8);
							while(rveh.next())
							{
								
								cnt6++;
								if(cnt6==1)
								{
									veh5_1=""+rveh.getString("VehicleRegNumber");
								}
								else if(cnt6==2)
								{
									veh5_2=""+rveh.getString("VehicleRegNumber");
								}
								else if(cnt6==3)
								{
									veh5_3=""+rveh.getString("VehicleRegNumber");
								}
								else if(cnt6==4)
								{
									veh5_4=""+rveh.getString("VehicleRegNumber");
								}
								else if(cnt6==5)
								{
									veh5_5=""+rveh.getString("VehicleRegNumber");
								}
							}
						}
								
						//-------------------- TOP 5 VEH-----------------------

						PdfPTable top5veh = new PdfPTable(2);
						//top5veh.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
						top5veh.getDefaultCell().setBorder(1);
						
						int[] colnWidth = {25,20};
						top5veh.setWidths(colnWidth);
						
						PdfPCell c_top5=new PdfPCell(new Paragraph("Vehicle Reg No."));
						c_top5.setBackgroundColor(Color.ORANGE);	//set background color for top 3 vehs
						top5veh.addCell(c_top5);

						PdfPCell c_top51=new PdfPCell(new Paragraph("KM"));
						c_top51.setBackgroundColor(Color.ORANGE);
						top5veh.addCell(c_top51);
						
						top5veh.addCell(veh5_1);
						top5veh.addCell(top5_1);

						top5veh.addCell(veh5_2);
						top5veh.addCell(top5_2);

						top5veh.addCell(veh5_3);
						top5veh.addCell(top5_3);
						
						top5veh.addCell(veh5_4);
						top5veh.addCell(top5_4);
						
						top5veh.addCell(veh5_5);
						top5veh.addCell(top5_5);
						document.newPage();
					//	document.add(top5veh);	//top 5 veh table	
						
	//=========================================================================================================================================
						Double _top5_1=Double.parseDouble(top5_1);
						Double _top5_2=Double.parseDouble(top5_2);
						Double _top5_3=Double.parseDouble(top5_3);
						Double _top5_4=Double.parseDouble(top5_4);
						Double _top5_5=Double.parseDouble(top5_5);
	//					System.out.println("_top5_1==>"+_top5_1);
						
//						System.out.println("_top5_1==>"+_top5_1);

						DefaultCategoryDataset barchart_top5 = new DefaultCategoryDataset();
						barchart_top5.setValue(_top5_1, "Population", veh5_1);
						barchart_top5.setValue(_top5_2, "Population", veh5_2);
						barchart_top5.setValue(_top5_3, "Population", veh5_3);
						barchart_top5.setValue(_top5_4, "Population", veh5_4);
						barchart_top5.setValue(_top5_5, "Population", veh5_5);
										 
						JFreeChart bar_chart_top5 = ChartFactory.createBarChart("Top 5 veh", "Veh reg No.", "KM",barchart_top5, PlotOrientation.VERTICAL, false, true, false);
						CategoryPlot plot_5 = bar_chart_top5.getCategoryPlot();
				        // Set custom renderer which will custom draw the bar colors
				        plot_5.setRenderer( new CustomRenderer());
					    /*    ChartFrame frame2=new ChartFrame("Bar Chart",bar_chart);
					        frame2.setVisible(true);
					        frame2.setSize(300,300);*/

					    
					        // write pie chart to pdf file
				PdfContentByte contentByte_top5 = writer.getDirectContent();
				        	
				PdfTemplate template_top5 = contentByte_top5.createTemplate(200, 175);
					       	
				Graphics2D graphics2d_top5 = template_top5.createGraphics(200, 175,new DefaultFontMapper());
				Rectangle2D rectangle2d_top5 = new Rectangle2D.Double(0,0, 200,175);
				bar_chart_top5.draw(graphics2d_top5, rectangle2d_top5);
				graphics2d_top5.dispose();
				//	contentByte.addTemplate(template, 0, 0);
				Image img_top5=Image.getInstance(template_top5);
				
				//document.add(img_top5);	
				
				
			//=========================================================================================================================================
	
titl="\t";
PdfPTable title_off = new PdfPTable(1);
title_off.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
title_off.addCell(titl);

//document.add(title_off);   			
//----------------------
		tabouter_top5.addCell(title_off);
//-----------------------			

	
	PdfPTable offlineVeh = new PdfPTable(1);
	//offlineVeh.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
	offlineVeh.getDefaultCell().setBorder(1);
	
	/*PdfPCell c_off1=new PdfPCell(new Paragraph("Sr No."));
	c_off1.setBackgroundColor(Color.YELLOW);	//set background color for top 3 vehs
	offlineVeh.addCell(c_off1);
*/
	PdfPCell c_off2=new PdfPCell(new Paragraph("                                     OFFLINE VEHICLES"));
	c_off2.setBackgroundColor(Color.YELLOW);
	offlineVeh.addCell(c_off2);
	
	int  vcoden=0,cnttt=0;
	String vrgno1="";
	sql1="select vehcode from db_gpsExceptions.t_vehall_ds where  VehCode in "+ss+" and (location like '%No Data%' or location like '%NO Data%' or location like '%No DATA%' or location like '%NO DATA%') and TheDate ='"+today1+"' UNION select VehicleCode from db_gps.t_vehicledetails where VehicleCode in "+ss+" and status in ('Removed','Missing')";
	ResultSet rst3=st2.executeQuery(sql1);
	while(rst3.next())
	{
		vcoden=rst3.getInt("vehcode");
		
		String sql8="select distinct(VehicleRegNumber) from db_gps.t_vehicledetails where VehicleCode='"+rst3.getInt("VehCode")+"'";
		ResultSet rveh=st1.executeQuery(sql8);
		while(rveh.next())
		{
			cnttt++;
			vrgno1=vrgno1+rveh.getString("VehicleRegNumber")+", ";
			String i=""+cnttt;
			//offlineVeh.addCell(i);
			
		}
		
	}
	offlineVeh.addCell(vrgno1);
	//document.add(offlineVeh);
	
	//----------------------
		tabouter_top5.addCell(top5veh);
	//-----------------------
	//----------------------
		tabouter_top5.addCell(img_top5);
	//-----------------------
	//----------------------
		//tabouter_top5.addCell(offlineVeh);
	//-----------------------
		
	//----------------------
		//tabouter_top5.addCell("");
	//-----------------------
		
		document.add(tabouter_top5);
		document.add(offlineVeh);
		
		
	//	String footer="Copyright Transworld Compressor Technologies Ltd.";
	//	String footer1="- All Rights Reserved.Paid Service from FleetView. For enquiry, please call +91-20-41214444 or email V_Lalwani@MyFleetView.com";
		
		//PdfPTable Footer = new PdfPTable(1);
		//Footer.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
		//Footer.addCell(footer);	
	//	Footer.addCell(footer1);
	//	document.setFooter(Footer);
		
document.close();

DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int i = 0; i < bytes.length; i++)
{
dataOutput.writeByte(bytes[i]);
}

			}//pdf try end
catch(Exception e){
e.printStackTrace();
}
finally
{
	response.getOutputStream().close();
}	

	
	}// connection try end
	catch(Exception e)
	{
		e.printStackTrace();
	}finally
	{
		try
		{
			conn1.close();
		}catch(Exception e)
		{}
		try
		{
			conn.close();
		}catch(Exception e)
		{}
		
	}
			

	

%>

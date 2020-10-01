package kml;

import java.io.File;
import java.io.IOException;


import java.io.FileOutputStream;

import java.util.*;
import java.sql.*;
public class JRM2
{
	
	static Statement st=null;
	static Statement st1=null;
	
	static Statement stn=null;
	
	 
	 
	 
	public static void main(String args[])throws IOException
	{
			
		 String coordinates="",coordinates1="";
		  String coordsRed="";
		 String coordsYellow="";
		 String coordsGreen="";
		 String filename="";
		 int trackid=0;
		 
		  String outputstring="<?xml version='1.0' encoding='utf-8'?><kml xmlns='http://earth.google.com/kml/2.0'>" +
	    "<Folder><name>Shapefile Converter Generated File</name><open>1</open>\n";
	 try
	 {
		 
		 Class.forName("org.gjt.mm.mysql.Driver");
			Connection conn1= DriverManager.getConnection("jdbc:mysql://202.65.131.44/db_gps","fleetview","1@flv");
			
		 st=conn1.createStatement();
		 st1=conn1.createStatement();
		 
		 

	
	 
	 @SuppressWarnings("unused")
	String prevzone="",prevlat="",prevlon="",currentzone="",currlon="",currlat="",waypt="",zone="",apdist="",type="";
		
	filename="/home/shweta/Desktop/Kolkata-Guwahati.kml";
	String sql="select *  from jrmallroute where routeid=55 and trackid=1 limit 1";
	System.out.println("sql "+sql);
	//ResultSet rs=st.executeQuery(sql);
	ResultSet rs=st.executeQuery(sql);

	
	if(rs.next())
	{  
		prevzone=rs.getString("zone");
		prevlat=rs.getString("latvalue");
		prevlon=rs.getString("lonvalue");
		
		coordinates1 = prevlon+","+prevlat+",0 ";
				
	}
	 if(prevzone.equalsIgnoreCase("Red"))
     {
		 prevzone="ff0000ff";
     }
     else if(prevzone.equalsIgnoreCase("Yellow"))
     {
     	prevzone="ff00ffff";
     }
     else 
     {
     	prevzone="ff00ff00";
     }
	
	
	 outputstring+="<Placemark>"+
	
	  "<Style>"+
	 "<LineStyle>"+
	 "<color>"+prevzone+"</color>"+
	 "<width>3</width>"+
	 "</LineStyle>"+
	 "</Style>"+
	  "<LineString>";
	 
	String sql1="select  *  from jrmallroute where routeid=55 and trackid>1 order by trackid";
	System.out.println(sql1);
	ResultSet rs1=st1.executeQuery(sql1);
	@SuppressWarnings("unused")
	String test="";
	
	
	 
	while(rs1.next())
	{
		 trackid=rs1.getInt("trackid");
		currentzone=rs1.getString("zone");
		currlat=rs1.getString("latvalue");
		currlon=rs1.getString("lonvalue");
		
        //trackid=rs1.getInt("trackid");
		
		waypt=rs1.getString("waypt");
		apdist=rs1.getString("apdist");
		type=rs1.getString("type");
		
		coordinates+=currlon+ "," + currlat+",0 ";
		//test=currlon+ "," + currlat+",0 ";
		//coordinates=coordinates1+test;
		//coordinates=coordinates1+test;
		System.out.println("trackid "+trackid);
		
		
		 if(prevzone.equalsIgnoreCase("Red"))
	        {
			 prevzone="ff0000ff";
	        }
	        else if(prevzone.equalsIgnoreCase("Yellow"))
	        {
	        	prevzone="ff00ffff";
	        }
	        else 
	        {
	        	prevzone="ff00ff00";
	        }
	
		 
			
		/* outputstring+="<Placemark>"+
		 "<name>"+trackid+"</name>"+
		  "<Style>"+
		 "<LineStyle>"+
		 "<color>"+currentzone+"</color>"+
		 "<width>3</width>"+
		 "</LineStyle>"+
		 "</Style>"+
		  "<LineString>"+
		 "<coordinates>"+coordinates+"</coordinates>"+
		 "</LineString>"+
		 "</Placemark>";
		 
		 coordinates1=test;
		 coordinates=coordinates1+currlon+ "," + currlat+",0 ";
		 
		 
		 */
	//	 String color=currentzone;
			
		String color=currentzone;
		if(color.equalsIgnoreCase("Red"))
        {
			color="ff0000ff";
        }
        else if(color.equalsIgnoreCase("Yellow"))
        {
        	color="ff00ffff";
        }
        else 
        {
        	color="ff00ff00";
        }
		System.out.println("prevcolr=="+prevzone+"---------currentzone==="+color);
		if(!(prevzone.equalsIgnoreCase(color)))
		{
				//coordsRed=currlon+ "," + currlat+",0 ";
				
			outputstring+="<coordinates>"+coordinates+"</coordinates>"+
			 "</LineString>"+
			 "</Placemark>\n";
			
			coordinates=currlon+ "," + currlat+",0 ";
			

			
			
			
		
			
			outputstring+="<Placemark>"+
			
			  "<Style>"+
			 "<LineStyle>"+
			 "<color>"+color+"</color>"+
			 "<width>3</width>"+
			 "</LineStyle>"+
			 "</Style>"+
			  "<LineString>";
			
					
			
		}
		prevzone=currentzone;
		prevlat=currlat;
		prevlon=currlon;
		
		//coordinates1=currlon+ "," + currlat+",0 ";
		
	
	}
	 }catch(Exception e1)
	 { 
	 	System.out.print("Exception --              -------->"+e1);
	 }
	 
		outputstring+="<coordinates>"+coordinates+"</coordinates>"+
		 "</LineString>"+
		 "</Placemark>\n";
		/*try
		{
			String waypt1="",type1="";
			double latvalue1=0.0;
			double lonvalue1=0.0;
			String cordinate2="";
		String sqln="select latvalue,lonvalue,waypt,type from db_gps.jrmroute where waypt<>' ' order by trackid";
		ResultSet rsn=stn.executeQuery(sqln);
		while(rsn.next())
		{
			latvalue1=rsn.getDouble("latvalue");
			lonvalue1=rsn.getDouble("lonvalue");
			waypt1=rsn.getString("waypt");
			type1=rsn.getString("type");
			cordinate2=lonvalue1+" "+latvalue1;
			 outputstring+="<Placemark>"+
			 "<name>"+waypt1+"</name>"+
			  "<Style>"+a
			 "<LineStyle>"+
			 "<color>"+color+"</color>"+
			 "<width>3</width>"+
			 "</LineStyle>"+
			 "</Style>"+
			 "<coordinates>"+cordinate2+"</coordinates>"+
			 "</Placemark>";
			
		}
		}
		catch(Exception e)
		{
			
		}
		
			
		*/
		
		
		
		
		
	outputstring +="</Folder>\n"+"</kml>\n";
	System.out.println("finish");
	try
	{
		 System.out.println("File created call");
			File f=new File(filename);
	        FileOutputStream fop=new FileOutputStream(f);
	        
	        
	        fop.write(outputstring.getBytes());
	        fop.close();
	    System.out.println("File created");
	        
	}
	catch(Exception e)
	{
	        e.printStackTrace();
	}
	
	}
	
	
}
//http://www.myfleetview.com/FleetView/images/demo.png

package kml;
import java.io.File;

import java.io.FileOutputStream;

import java.util.*;

public class KML1 {

	
	
	public static boolean generateKMLFORLINE(List<HashMap<String, String>> coordinatesList ,String fileName,HashMap<String, String> startMarker,HashMap<String, String> endMarker,String color)
	{

	boolean flag=false;
	//to generate only the KML File with start and end marker
	//System.out.println(":::GEN KML CALLED::::");
	String outputString ="<?xml version='1.0' encoding='utf-8'?><kml xmlns='http://earth.google.com/kml/2.0'>" +
	                "<Folder><name>Shapefile Converter Generated File</name><open>1</open>\n"+
	                "<Placemark>\n"+
	                "<name> </name>\n"+
	                "<Style>\n"
	                + "<LineStyle><color>"+color+"</color><width>3</width>" +
	                                "</LineStyle></Style>";
	                                



	String name = "";
	String description="";
	String coordinates = "";
	// Creating LineString
	for (Iterator<HashMap<String, String>> iterator = coordinatesList.iterator(); iterator.hasNext();)
	{
	        HashMap<String,String>  coordinateMap = iterator.next();
	        
	        //this is for creating line item
	        coordinates+= coordinateMap.get("longi")+ "," + coordinateMap.get("lat")+",0 ";
	}              
	
	outputString +="<LineString>"+
	                                                "<coordinates>"+coordinates+"</coordinates>\n"+
	                                        "</LineString></Placemark>\n";                                
	
	
	coordinates+= startMarker.get("longi")+ "," + startMarker.get("lat")+",0 ";

	                


	// Creating Point item
	                //start point
/*	name=startMarker.get("name");
	name=name.replaceAll("&", " ");
	name=name.replaceAll("-", " ");
	description=startMarker.get("desc");
	description=description.replaceAll("&", " ");
	description=description.replaceAll("-", " ");
	outputString +="<Placemark>\n" +
	        "<name>"+name+"</name>\n"+
	        "<description>"+description+"</description>\n";
	        outputString +="<Point>\n"+
	                                                "<coordinates>"+startMarker.get("longi")+ "," + startMarker.get("lat")+"</coordinates>\n"+
	                                        "</Point>\n"+
	                                "</Placemark>\n";
	        
	        //end point
	        name=endMarker.get("name");
	        name=name.replaceAll("&", " ");
	        name=name.replaceAll("-", " ");
	        description=endMarker.get("desc");
	        description=description.replaceAll("&", " ");
	        description=description.replaceAll("-", " ");
	        
	        outputString +="<Placemark>\n" +
	        "<name>"+name+"</name>\n"+
	        "<description>"+description+"</description>\n"+
	        "<styleUrl>#starticonsty</styleUrl>";
	        outputString +="<Point>\n"+
	                                                "<coordinates>"+endMarker.get("longi")+ "," + endMarker.get("lat")+"</coordinates>\n"+
	                                        "</Point>\n"+
	                                "</Placemark>\n";
	        */
	outputString +="</Folder>\n"+
	                                "</kml>\n";



	//System.out.println("Generated KML file :::\n"+outputString);
	try
	{
	        File f=new File(fileName);
	        FileOutputStream fop=new FileOutputStream(f);
	        fop.write(outputString.getBytes());
	        fop.close();
	        flag=true;
	        
	}
	catch(Exception e)
	{
	        e.printStackTrace();
	}
	return flag;

	}



	
	
	
	
	
}

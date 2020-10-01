package com.fleetview.POIClasses;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fleetview.beans.Connectionclass;



/**
 * Servlet implementation class UpdateExcelDataServlet
 */
public class UpdateExcelDataServlet extends HttpServlet {
	
	
	Connection con=null,con1=null;
	Statement stmt=null,stmt1=null;
	ResultSet rs=null;
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateExcelDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		HttpSession session=req.getSession();
		String user=session.getAttribute("dispalyname").toString();
		
		String button=req.getParameter("btn");
		System.out.println(button);
		String tripid=req.getParameter("txttripid");
		String Vehregno=req.getParameter("txtvehregno");
		String stdate=req.getParameter("tripdate");
		System.out.println(stdate);
		String triphr=req.getParameter("triphr");
		String tripMM=req.getParameter("tripMM");
		String tripSS="00";
		
		String transport=req.getParameter("txttransport");
		String tripfrom=req.getParameter("txttripfrom");
		String tripto=req.getParameter("txttripto");
		String driverid1=req.getParameter("txtdriverid1");
		String driverid2=req.getParameter("txtdriverid2");
		System.out.println("driverid2"+driverid2);
		String drivername1=req.getParameter("txtdrivername1");
		String drivername2=req.getParameter("txtdrivername2");
		
		String ETADate=null;
		ETADate=req.getParameter("txtETA");
		System.out.println("ETADate"+ETADate);
		
		String ETAhr=req.getParameter("ETAhr");
		String ETAMM=req.getParameter("ETAMM");
		String EtASS="00";
				
		String StTime=null;
		
		try
		{
			System.out.println("inside try");
		con=Connectionclass.getConnection();
		//con1=Connectionclass.getConnection1();
		stmt=con.createStatement();
	
		if(button.equals("Update"))
		{
			System.out.println("inside if");
		//-------------------- Trip Date Time-------------------------------------
	
			try{
			     stdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(stdate));
			     }catch(ParseException e)
			     {
			    	 stdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(stdate));
			     }
		StTime=triphr+":"+tripMM+":"+tripSS;
		
		StTime=new SimpleDateFormat("HH:MM:SS").format(new SimpleDateFormat("HH:MM:SS").parse(StTime));
		
		
		//------------------------ ETA Date Time----------------------------------------
		
		String ETAtime=null;
		
			if(ETADate!=null && ETADate!="")
		     {		     
		     try{
		     ETADate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yy").parse(ETADate));
		     }catch(ParseException e)
		     {
			     ETADate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(ETADate));
		     }
		     
		     ETAtime=ETAhr+":"+ETAMM+":"+EtASS;
		     }
			else
			{
				ETADate="0000:00:00";
				 ETAtime="00:00:00";
			}
			
			String ETAdttime=ETADate+" "+ETAtime;
		
		//----------------------------------------------------------------------------
		
		//-------------------------- Driver Code && Name---------------------------------------	
			
			String driverid=null,drivername=null;	
		if(driverid2=="")
		{
			driverid=driverid1;
		}
		else if(driverid1=="")			
		{
			driverid=driverid2;
		}
		else
		{
			driverid=driverid1+"-"+driverid2;
		}
			//------------------------------ Driver Name--------------------------------
		if(drivername2=="")
		{
			drivername=drivername1;
		}
		else if(drivername1=="")
		    drivername=drivername2;
		else
			drivername=drivername1+"-"+drivername2;
			
			
		//----------------------------------------------------------------------------
				
			
		 int vehcode=0;
	     stmt1=con.createStatement();
	     String str="Select VehicleCode from t_vehicledetails where VehicleRegNumber='"+Vehregno+"' and status='-'";
	     rs=stmt1.executeQuery(str);
	     
	     if(rs.next())
	     {
	    	 vehcode=rs.getInt(1);
	    	
		    	 							     
			     //----------------- if vehreg no matches with veh code insert the record into database-----------------------
			     
			     try{
			    stmt=con.createStatement();
			    String str1="Update t_startedjourney set TripID='"+tripid+"', Vehid="+vehcode+", VehRegNo='"+Vehregno+"', StartPlace='"+tripfrom+"', EndPlace='"+tripto+"', StartDate='"+stdate+"', StartTime='"+StTime+"', ETA='"+ETAdttime+"', DriverCode='"+driverid+"', DriverName='"+drivername+"', OwnerName='"+transport+"', EndedBy='"+user+"' where TripID='"+tripid+"'";
			    System.out.println(str1);
			     stmt.executeUpdate(str1);
			     res.sendRedirect("EditExcelData.jsp?inserted=yes");
			     }catch(Exception e)
			     {
			    	 e.printStackTrace();
			     }
		   
	    	 
	    	 
	     }
	     else
	     {
	    	 res.sendRedirect("EditExcelData.jsp?inserted=No");
	     }
		}
		else
		{
			if(button.equals("Delete"))
			{
				try{
				    stmt=con.createStatement();
				    String str1="Delete from t_startedjourney where TripID='"+tripid+"'";
				    System.out.println(str1);
				     stmt.executeUpdate(str1);
				     res.sendRedirect("EditExcelData.jsp?Deleted=yes");
				     }catch(Exception e)
				     {
				    	 e.printStackTrace();
				     }
			   
			}
		}
			
		
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
	}

}

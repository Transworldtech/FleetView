package com.fleetview.POIClasses;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import com.fleetview.beans.TripClosureData;


public class UploadTripClosureExcelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	public UploadTripClosureExcelServlet() {
		super();

	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession session=request.getSession();
		
		PrintWriter pw=response.getWriter();
		ArrayList<TripClosureData> disp=null;
		String user=session.getAttribute("dispalyname").toString();
		String usertypevalue=session.getAttribute("usertypevalue").toString();
		String Flag="true";
		String directory = getServletContext().getRealPath("/") + "images";
		//System.out.println("directory..."+directory);
		
		FileClosureUpload fileUpload = new FileClosureUpload();
		try {
		disp= fileUpload.uploadFile(request,directory,user,usertypevalue);
		System.out.println("back to page again");
		} catch (Exception e1) {


		}

		 request.setAttribute("InvalidList", disp);
		
    RequestDispatcher rd = request.getRequestDispatcher("DisplayInvalidTripClosureData.jsp");  
    rd.forward(request, response); 

	}
}
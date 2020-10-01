package com.fleetview.POIClasses;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import com.fleetview.beans.DisplayData;


public class UploadExcelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	public UploadExcelServlet() {
		super();

	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession session=request.getSession();
		
		PrintWriter pw=response.getWriter();
		ArrayList<DisplayData> disp=null;
		String user=session.getAttribute("dispalyname").toString();
		String usertypevalue=session.getAttribute("usertypevalue").toString();
		String Flag="true";
		String directory = getServletContext().getRealPath("/") + "images";
		//System.out.println("directory..."+directory);
		
		FileUpload fileUpload = new FileUpload();
		try {
		disp= fileUpload.uploadFile(request,directory,user,usertypevalue);
System.out.println("back to page again");
		} catch (Exception e1) {


		}

		 request.setAttribute("InvalidList", disp);
		
    RequestDispatcher rd = request.getRequestDispatcher("DisplayInvalidData.jsp");  
    rd.forward(request, response); 

	}
}
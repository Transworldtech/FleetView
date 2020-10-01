<%@ include file="Connections/conn.jsp" %>
<%! 
Connection con ;
%>
<%

try{           
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	String vid= request.getParameter("vid");
	String comments=request.getParameter("reason");
	String transcomment = request.getParameter("transreason");
	String castrol = request.getParameter("castrol");
	String trans = request.getParameter("trans");
	System.out.println("***&&&&&&****    "+castrol);
	System.out.println("**&&&&&&*****    "+trans);
	if(comments == "" || comments.equals(""))
	{
		comments = "-";
	}
	
	if(transcomment == "" || transcomment.equals(""))
	{
		transcomment = "-";
	}
	
	if(castrol == null || castrol.equals("null") || castrol == "" || castrol.equals(""))
	{
		castrol = "-";
	}
	else
	{
		castrol = "Yes";
	}
	
	if(trans == null || trans.equals("null") || trans == "" || trans.equals(""))
	{
		trans = "-";
	}
	else
	{
		trans = "Yes";
	}
	
	
	String user  = session.getAttribute("mainuser").toString();
	
	System.out.println("***&&&&&&****    "+castrol);
	System.out.println("**&&&&&&*****    "+trans);
	if((castrol == "-" || castrol.equals("-")) && (trans == "-" || trans.equals("-")))
	{
		response.sendRedirect("addunlockcmnt.jsp?Msg=2");
	}
	else
	{
			String sql = "Update db_gps.t_vehiclelock set EntryBy = '"+user+"',Status = 'Unlocked',Comments='"+comments+"',TransComment='"+transcomment+"',CastrolUnlock='"+castrol+"',TransUnlock='"+trans+"'  where vehcode = '"+vid+"'";
			stmt.executeUpdate(sql);
			System.out.println("*****    "+sql);
			response.sendRedirect("addunlockcmnt.jsp?Msg=1");
	}
			
	
}catch(Exception e){
	out.println( "Exception ::"+e );
	}
%>

<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1;
%>
<% 
try {
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",sql1="";
String srNoStr="";
String serverid="",usernm="",passwd="";
boolean flag=false;
int element=99;

String file=request.getParameter("file");

System.out.println(">>>>>file " +file);
String buffer;


	try{
		
		

		String sqlftp="select * from db_leaveapplication.t_ftpconnection";
		ResultSet rsftp=st1.executeQuery(sqlftp);
		if(rsftp.next())
		{
		serverid=rsftp.getString("ServerID");
		usernm=rsftp.getString("Username");
		passwd=rsftp.getString("Password");
		System.out.println(">>>>>file1 " +serverid);
		System.out.println(">>>>>file2 " +usernm);
		System.out.println(">>>>>file 3" +passwd);

		}
		response.sendRedirect("ftp://"+usernm+":"+passwd+"@"+serverid+"/test/"+file+"");


}
catch(Exception e)
{

e.printStackTrace();
}

}
 catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
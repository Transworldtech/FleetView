
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1,st2,st3;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
System.out.println("IN1");
String category=request.getParameter("category");
boolean flg=true;

flg=true;
String sql7="select distinct(Categoery1) From db_gps.t_JourneyGoals where Categoery='"+category+"'";
	ResultSet rs7 = st2.executeQuery(sql7);
	System.out.println(sql7);
	String SrhCat="";
	int i=0;
	
	while(rs7.next())
	{flg=false;
		
		if(i==0)
		{
			SrhCat="All~"+rs7.getString("Categoery1");
			i=1;
		}
		else
		{
			SrhCat=SrhCat+"~"+rs7.getString("Categoery1");
		}
	}
	
		if(flg==true)
		{
			SrhCat="All";
		}
			out.print(SrhCat);		

}
	catch(Exception e) { 
		out.print("Not"+e);
		}

	finally
	{
		st.close();
		con1.close();
	}
%>
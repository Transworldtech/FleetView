<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
String GoalInput="";


//String debriefid=request.getParameter("debriefid");


String Goal_Cat=request.getParameter("cat");
String resource=request.getParameter("res");




String buffer;

StringBuffer abc=new StringBuffer();
String sql1 = "select Options from db_gps.t_JourneyGoals where Categoery='Goal_Brif' and Categoery1='"+Goal_Cat+"' order by UpdatedDateTime";
ResultSet rs1 = st.executeQuery(sql1);
int g=0;
while(rs1.next())
{

	GoalInput=rs1.getString("Options");

abc=abc.append(GoalInput+"-"+Goal_Cat+",");

abc.toString();
abc.substring(0,abc.indexOf(","));
}



		

//buffer=null;


buffer=abc.toString();
out.print(buffer);

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		st.close();
		con1.close();
	}

%>
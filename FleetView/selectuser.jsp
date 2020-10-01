

<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%

System.out.println("in the select user .jsp page at start ");
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<script>

function getTransporterDetails(transporter)
{
	//alert("**********************************   ");
	//alert(transporter);
	//alert("**********66666666666 ************   ");
	
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("search-text").value=transporter;
	
}

function getTransporter(num)
{
	try{
	//alert("Hii");
	var b=0;
	var transporter=document.getElementById("search-text").value;
    if(transporter.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	//alert(transporter);
	//var user=document.getElementById("usertypevalue").value;
	//var counter=document.userform.counter.value;
	/*if(counter>100)
	{
		counter=0;
	}*/
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	    }  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			//alert("b "+b);
			document.userform.counter.value=b;
			//alert("counter "+document.userform.counter.value);
			document.userform.counter.value=b*document.userform.counter.value;
			counter=document.userform.counter.value;
			//alert("counter "+counter);
		} 
	};
	var queryString = "?transporter="+transporter+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "AjaxGetTransporter.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    }
	}catch(e)
	{
		//alert(e);
	}
}

</script>
<%
String Msg = request.getParameter("Msg");
System.out.println("Msg "+Msg);
if(Msg != null && Msg.equals("1"))
{
	//System.out.println("in if");
  %>
  <script>
  alert("The user does not exist in your group!!");
  </script>
  <%
}
else if(Msg != null && Msg.equals("2"))
{
	%>
	<script>
	alert("Please enter the username!!");
	</script>
	<%
}
%>
<!--<a href="#" onclick="javascript:try{window.open('journeyplanning.jsp','planjourney','width=50,location=no,menubar=no,height=50,minimizable=no,dialog=yes,resizable=0');}catch(e){alert(e);}"> Journey plan</a>-->
<table border="0" width="100%" class="stats" align="center">
<tr><td align="center">
<!--Main code -->

<div style="margin-left: 30%">
<table  align="center" class="stats" style="width: 700px">	
	
	<tr>
		<td align="left" colspan="1"><B>Please enter the Transporter to view its Vehicles and Reports.</B></td>
	<td></td>
	</tr>
	

<form name="userform" action="validateselecteduser.jsp" method="post">
	<!-- <tr>
		<td colspan="2">
		<div align="center"><B>User Name :</B>-->
		 
<%!
Connection conn;
Statement st,st1,st2,st3,st4;
ResultSet rst;
String sql;

%>
<%
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	st4=conn.createStatement();
	
	if(session.getValue("usertypevaluemain").toString().equals("Castrol"))
	{ 
		sql="select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='Castrol' order by VehRegNo asc";		
	}
	else if(session.getValue("usertypevaluemain").toString().equals("DSC"))
	{
		sql="select distinct(VehRegNo) as grp from t_group where GPName='DSC' order by VehRegNo asc";
	}
	else if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
	{ 
	sql="select distinct(grp) from (select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and VehRegNo IN ('Castrol North','Castrol East','Castrol West','Castrol South')   Union select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegNo IN ('Castrol North','Castrol East','Castrol West','Castrol South')) a order by grp";		
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("DelEx All"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('DelEx Cargo India pvt. Ltd.') and GPName not like '%DelEx All%'";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("North_East_Roadways"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('North East Roadways')";
		System.out.println("queryyyyyyyyyyyyy"+sql);
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ACC"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName in('ACC_BCCI','ACC_PUNE','ACC _Coimbatore','ACC_BLR') order by GPName asc";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Praxair India Pvt.Ltd"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName in('Praxair Hospet','Praxair Paharpur','Praxair Alibaug','Praxair Asansol','Praxair Jamshedpur') order by GPName asc";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("NECC ALL"))
	{
		sql="select distinct(GPName) as grp from t_group where SepReport='Yes' and VehRegno IN ('NECC Roadways') and GPName not like '%NECC ALL%'";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Manish Thapar"))
	{
		sql="select distinct(GPName) as grp from t_group where GPName IN ('Castrol Emp West Sanchay Singh Team ','Castrol Emp Sanchay Singh Team','Nilesh Malani','Siddesh Vaity','Manish Thapar')";
	}
	else if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("EMehtha ALL"))
	{
		sql="select distinct(GPName) as grp from t_group where VehRegno in ('EMehtha') ";
	}
	else
		if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("IAL_INDIA"))
		{
			sql = " select distinct(grp)  from (select distinct(VehRegNo) as grp from t_group where SepReport='Yes' and GPName='IAL_INDIA' Union select distinct(GPName) as grp from t_group where SepReport='Yes' and GPName  IN ('IAL_INDIA')) a order by grp ";
		}
		else
			if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ExpressRdys_All"))
			{
				sql = "select distinct(VehRegNo) as grp  from db_gps.t_group where  GPName = 'ExpressRdys_All' ";
			}
	else
	{	
		sql="select distinct FullName as FullName from t_security where TypeOfUser <> 'SUBUSER' union select distinct(GPName) as FullName from t_group where SepReport='Yes' ";		
	}
	//out.print(session.getValue("usertypevaluemain"));
	//out.print(sql);
	rst=st.executeQuery(sql);
	//System.out.println("Most imp queryyyyy"+sql);
	%>
	
	<!-- <select name="username" style="">-->
        <%
      /*  if(session.getValue("usertypevaluemain").toString().equals("Castrol"))
        {*/
        %>
              <!--   <option value="Castrol" >All</option>-->
        <%
       /* }
        if(session.getValue("usertypevaluemain").toString().equals("DSC"))   
        {*/
        %>
             <!--    <option value="DSC" >All</option>-->
        <%
       /* }
        if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH")) 
        {*/
         %>
             <!--   <option value="Castrol EMP VEH">All</option>-->
         <%
       /* }
        if(session.getValue("usertypevaluemain").toString().equals("DelEx All"))      {*/
         %>
             <!--   <option value="DelEx Cargo India pvt. Ltd.">All</option>-->
         <%
        /*}
        if(session.getValue("usertypevaluemain").toString().equals("Nawany All"))      {*/
            %>
               <!--    <option value="Nawany Corp (I) Ltd">All</option>-->
            <%
         /*  }
        if(session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ACC"))
    	{*/
        	%>
            <!-- <option value="ACC">All</option>-->
      <%
    	/*}
		 if(session.getValue("usertypevaluemain").toString().equals("Praxair India Pvt.Ltd"))
    	{*/
        	%>
            <!-- <option value="Praxair India Pvt.Ltd">All</option>-->
           
      <%
    	/* }

		 if(session.getValue("usertypevaluemain").toString().equals("NECC ALL"))
    	{*/
        	%>
           <!--  <option value="NECC Roadways">All</option>-->
           
      <%
    	 /*}
		 if(session.getValue("usertypevaluemain").toString().equals("Manish Thapar"))
		 {*/
			 %>
			 <!-- <option value="Manish Thapar">All</option>-->
			 
			 <%
		 //}
     ArrayList<String> optionGrpList = new ArrayList<String>();   
        optionGrpList.clear();
        /***************** added of making list asending*******/
        while(rst.next())
        {
                if(session.getValue("usertypevaluemain").toString().equals("Castrol")||session.getValue("usertypevaluemain").toString().equals("DSC")|| session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH")||
                   session.getValue("usertypevaluemain").toString().equalsIgnoreCase("DelEx All")|| 
                		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("Nawany All")|| 
                		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ACC")||
                		session.getValue("usertypevaluemain").toString().equals("Praxair India Pvt.Ltd")|| 
                		session.getValue("usertypevaluemain").toString().equals("NECC ALL")||
                		session.getValue("usertypevaluemain").toString().equals("Manish Thapar") ||
                		session.getValue("usertypevaluemain").toString().equals("EMehtha ALL") ||
                		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("IAL_INDIA") || 
                		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("North_East_Roadways") || 
                		session.getValue("usertypevaluemain").toString().equalsIgnoreCase("ExpressRdys_All"))
                {
                	     System.out.println("Here");
                        optionGrpList.add(rst.getString("grp").toString());     
                }
               /* else if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
                {
                        optionGrpList.add(rst.getString("grp1").toString());    
                }
                else if(session.getValue("usertypevaluemain").toString().equals("DelEx All"))
                {
                        optionGrpList.add(rst.getString("grp2").toString());
                }*/
                else
                {
                	//System.out.println("Threr");
                        optionGrpList.add(rst.getString("FullName").toString());
                }               
                
        }
        
        if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
        {
        	
        	System.out.println("the usertypevalue is Castrol EMP VEH:- ");
        	String hodid = "",Fname = "";
        	String sqlemp = "select * from db_gps.t_userdetails where username = '"+session.getAttribute("mainuser").toString()+"'";
        	System.out.println("the sqlemp :- "+sqlemp);
        	
        	ResultSet rs1 = st.executeQuery(sqlemp);
        	if(rs1.next())
    		{
        		Fname = rs1.getString("FirstName")+" "+rs1.getString("LastName");
    			hodid = rs1.getString("SrNo");
    			System.out.println("KISHORE KUMARRRRRRRRRRREEEEEEE----->"+Fname);
    			
    			 if(Fname == "Sanjay Jetly" || Fname.equals("Sanjay Jetly") || Fname == "Kishore Kumar" || Fname.equals("Kishore Kumar"))
    	    	  {
    				 hodid = "11317";
    	    	  }
    			 
    			 if(rs1.getString("vehid") == "-" || rs1.getString("vehid").equals("-"))
   	    	 	 {
   				 String sqlemp1 = "select * from db_gps.t_userdetails where HODID = '"+hodid+"' ";
   				 
   				 System.out.println("sqlemp1 "+sqlemp1);
   	    		  ResultSet rs2 = st1.executeQuery(sqlemp1);
   	    		  while(rs2.next())
   	    		  {
   	    			  optionGrpList.add(rs2.getString("FirstName").trim()+" "+rs2.getString("LastName").trim());
   	    			  
   	    			 
   	    			  
   	    			  if(rs2.getString("vehid") == "-" || rs2.getString("vehid").equals("-"))
   	    	    	  {
   	    				  String sqlemp2 = "select * from db_gps.t_userdetails where HODID = '"+rs2.getString("SrNo")+"' order by FirstName,LastName asc";
   	    				  System.out.println("the sqlemp2 :- "+sqlemp2);
   	    				  ResultSet rs4 = st2.executeQuery(sqlemp2);
   	    	    		  while(rs4.next())
   	    	    		  {
   	    	    			optionGrpList.add(rs4.getString("FirstName").trim()+" "+rs4.getString("LastName").trim());
   	    	    			
   	    	    			//for(int i=0;i<optionGrpList.size();i++)
   	   	    			  	//{
   	   	    				  //System.out.println("2:-  "+optionGrpList.get(i));
   	   	    			 	//}
   	    	    			
   	    	    			
   	    	    				if(rs4.getString("vehid") == "-" || rs4.getString("vehid").equals("-"))
   	    	    	    	  {
   	    	    				  String sqlemp3 = "select * from db_gps.t_userdetails where HODID = '"+rs4.getString("SrNo")+"' order by FirstName,LastName asc";
   	    	    				  System.out.println("the sqlemp3 :- "+sqlemp3); 
   	    	    				  ResultSet rs6 = st3.executeQuery(sqlemp3);
   	    	    	    		  while(rs6.next())
   	    	    	    		  {  	    	    	    			  
   	    	    	    			optionGrpList.add(rs6.getString("FirstName").trim()+" "+rs6.getString("LastName").trim());
   	    	    	    			 
   	    	    	    			//for(int i=0;i<optionGrpList.size();i++)
   	    	   	    			  	//{
   	    	   	    				  //System.out.println("3:-  "+optionGrpList.get(i));
   	    	   	    			 	//}
   	    	    	    			
   	    	    	    			
   	    	    	    			if(rs6.getString("vehid") == "-" || rs6.getString("vehid").equals("-"))
   	    	    	    	    	  {
   	    	    	    				  String sqlemp4 = "select * from db_gps.t_userdetails where HODID = '"+rs6.getString("SrNo")+"' order by FirstName,LastName asc";
   	    	    	    				  System.out.println("the sqlemp4 :- "+sqlemp4);
   	    	    	    				  ResultSet rs7 = st4.executeQuery(sqlemp4);
   	    	    	    	    		  while(rs7.next())
   	    	    	    	    		  {
   	    	    	    	    			optionGrpList.add(rs7.getString("FirstName").trim()+" "+rs7.getString("LastName").trim());
   	    	    	    	    			  
   	    	    	    	    		  
   	    	    	    	    		  }
   	    	    	    	    		//for(int i=0;i<optionGrpList.size();i++)
   	    	      	    			 	//{
   	    	      	    				  //System.out.println("1:-  "+optionGrpList.get(i));
   	    	      	    			  	//}	
   	    	    	    	    	  
   	    	    	    	    	  }   	    	    	    			 
   	    	    	    		  }
   	    	    	    	  }   	    	    			  
   	    	    		  }
   	    	    	  }  	    			 
   	    		  }		 
   	    	  }   			    			 
    		}        	
        }
        
      /*  if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))      
        	{
        	for( int optionCntr = 0 ;  optionCntr < optionGrpList.size();   optionCntr ++)
            {          */     
    		%>
                   <!--  <option value='< %=optionGrpList.get(optionCntr)%>'>< %=optionGrpList.get(optionCntr)%></option>-->
            <%              
           /* }
            }
        else
        {
        Collections.sort(optionGrpList);
        
        for( int optionCntr = 0 ;  optionCntr < optionGrpList.size();   optionCntr ++)
        {               */
		%>
               <!-- <option value='< %=optionGrpList.get(optionCntr)%>'>< %=optionGrpList.get(optionCntr)%></option>-->
        <%              
      /*  }
        }*/
        
        //Collections.sort(optionGrpList);
        
        System.out.println("Before for loop WWWWQQQ");
        
 //       for(int optionCntr = 0 ;  optionCntr < optionGrpList.size();   optionCntr ++)
   //     {      
       	 	
     //   	System.out.println("****   "+optionGrpList.get(optionCntr));
      // 	}

 		
 		for(String s:optionGrpList)
 		{
 			//System.out.println("****   "+s);
 		}
 		System.out.println("After for loop WWWWQQQ");
        
        //Collections.sort(optionGrpList);
        %>
      <!--   </select>-->
	
	<!-- </div></td></tr>-->

<tr style="width: 800px">
	
<td align="center">
<br></br>
	
<div id="transporter"><b>UserName :</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH") || session.getValue("usertypevaluemain").toString().equals("ExpressRdys_All") || session.getValue("usertypevaluemain").toString().equalsIgnoreCase("EMehtha ALL"))
{ 
	System.out.println("helll1");
%>
  <select name="username1" style="">
  <%
  if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
  {
	  System.out.println("helll1222222222222222");
	  %>
	    <option value="Castrol EMP VEH">All</option>
	 <%
  }
  else
	  if(session.getValue("usertypevaluemain").toString().equals("ExpressRdys_All"))
  {
		  System.out.println("helll4444444444444444");
		  %>
		    <option value="ExpressRdys_All">All</option>
		 <%
  }
  
 
 Collections.sort(optionGrpList);
 
 
 //Collections.sort(optionGrpList,new Comparator<String[]>() 
 //{
   //  public int compare(String[] strings, String[] otherStrings) {
     //    return strings[1].compareTo(otherStrings[1]);
     //}
 //});
  
 for( int optionCntr = 0 ;  optionCntr < optionGrpList.size();   optionCntr ++)
 {      
	
	 System.out.println("helll1777777777777");
	System.out.println("### "+optionGrpList.get(optionCntr).toString());
	
	
	%>
      <option value='<%=optionGrpList.get(optionCntr)%>'><%=optionGrpList.get(optionCntr)%></option>
 <%              
 }
 %>
 </select>
 <%
 
 if(session.getValue("usertypevaluemain").toString().equals("ExpressRdys_All"))
 {
	 System.out.println("helll094932429");
	 optionGrpList.add("ExpressRdys_All");
 }
 else
	 if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH"))
 {
		 System.out.println("helll18372474274");
		 optionGrpList.add("Castrol EMP VEH");
 }
}
else
{
%>
<input type="text" autocomplete="off" name="username" id="search-text" value="" style='width: 250px;' onkeyup="getTransporter(1)" />
<%
}
%></div><br></br>
<div  style="margin-left: 15%"><input type="submit" name="Submit" Value="Submit"></div>
<input type="hidden" name="grouplist" id="grouplist" value="<%=optionGrpList%>"></input>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
</td>

<td align="left">
<div id='transporterlist' align="left">
<div style="height: 110px; width: 300px; overflow: auto;">
<table style="display: none;">
</table>
 <!-- <input type="hidden" name="usertypevalue" id="usertypevalue" value="< %=session.getValue("usertypevaluemain").toString() %>"/>-->
<input type="hidden" name="counter" id="counter" value="10"/>
<input type="hidden" name="anothercounter" id="anothercounter" value="10"/>
</div>
									
									</div>
									</td>
								</tr>
								

</form>
</table>
</div>

<%
}
catch(Exception e)
{
	out.print("Exception --->"+ e);
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e){}
}
%>
<!--Main code -->
</td></tr>
</table>
</jsp:useBean>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<%@ include file="footernew.jsp" %>
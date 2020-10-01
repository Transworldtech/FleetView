 <%@ include file="airtelheader.jsp"%> 
<meta http-equiv="refresh" content="300">
<%@page import="java.util.Date"%> 
<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<%@page import="com.fleetview.beans.classes"%><style>
<!-- 
    SPAN.searchword { background-color:cyan; }
    
// -->
</style>

<style>

SPAN.super 
{
	text-decoration: blink;
	text-align: center; 
}

</style>

<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function article(programName,width,height)
{
	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; displayWindow=window.open(programName,"displayWindow",temp) ;
}
function fun(aa)
{
	//alert(aa.value);
	document.searchform.h.value=aa.value;
}


</script>

<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx{
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>
<%!
	Connection conn,conn1;
	Statement st,st1,stx,st2,stmt;
	String aa,regno,sq,searchveh,sql;
	ResultSet rs_rh,rs_cnt;
%>
<%
try
{
	conn=fleetview.ReturnConnection();
	 Calendar calendar = Calendar.getInstance();
	//conn1=fleetview.ReturnConnection1();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	stmt=conn.createStatement();
	//out.print(session.getAttribute("usertypevalue").toString());
                Date dt=new  Date();
			    String  dt1=new SimpleDateFormat("yyyy-MM-dd").format(dt);
			  //  System.out.println("dt===>"+dt1);
%>
	<table border="0" class="stat"> 
		<tr>
			<td><div align="right"><td><a href="logout.jsp" title="Logout"><img src="images/logout.jpeg" border="0"></div></td>
			<td><div align="right"><td><a href="GensetMasterEntry.jsp" title="Report"><img src="images/entryforms.jpg" border="0"></div></td>
			<td><div align="right"><td><a href="newGensetReport.jsp" title="GenSet Report"><img src="images/reports.jpeg" border="0"></div></td>
		</tr>
	</table>
	<table border="0" width="100%" bgcolor="white">  
			<tr align="center">
				<td>
					<!-- <div align="left"><font color="block" face="arial"  size="3" ><b>Report No: 1.0</b></font></div>-->
					<div align="center"><font size="3"  face="arial"><b>Genset Status Report </b></font></div>
				</td>
	        </tr>
		    </table>        
		        <form name="addveh" method="get" action="">	
			<table width="100%" border="1" align="center" class="sortable">
			
				<tr>
					<th id="tdp0" > <b>Sr.No.</b></th>
					<th id="tdp0" > <b>Site ID</b></th>
					<th id="tdp0" > <b>Updated DateTime</b></th>
					<th id="tdp0" > <b>Site Adress</b></th>
					<th id="tdp0" > <b>Fuel Level(ltrs.)</b></th>   
					<th id="tdp0" > <b>Battery Level(Voltage)</b></th>
					<th id="tdp0" > <b>Temp Level(Dgr Cel.)</b></th>
					<th id="tdp0" > <b>No.of Genset Start</b></th>
					<th id="tdp0" > <b>Run Hrs.(HH:mm)</b></th>	
				    </tr>	
			        <%
					int j=1;
			        int sr_no=0,r_cnt=0;
			        String rh_flg="N";
			        String today="";
					int i_cnt=0, rw_cnt=0;
					long millisecdiff=0,miliseconds1=0,miliseconds2=0,ticks=0;
					
					
			  
			        String date="",time="",vehcode="",empname="", site_id="";
					String flg="N";
					String stat, rh_stat, rh_st1, rh_st2, rh_date;
					
		//			DateFormat df;
		//			java.util.Date rh_time;
			       String online="select VehicleCode,Empname,VehicleRegNumber from t_vehicledetails where OwnerName='Airtel'";
			//		String online="select VehicleCode,Empname from t_vehicledetails where OwnerName='Airtel'";
					ResultSet onrs=st.executeQuery(online);
					while(onrs.next())
					{
						int ccnt=0;//initially 0
						long secdiff=0,mindiff=0,hrdiff=0;
						String timeInHHmm="00:00",final_time="";
						long sdiff=0,mdiff=0,hdiff=0;
						long rh_total_time=0;
						
						   DateFormat df =new SimpleDateFormat("HH 'hours', mm 'mins,' ss 'seconds'");
						   int vehcode1=onrs.getInt("VehicleCode");
					    //   System.out.println("vehcode1***>"+vehcode1);
					       empname=onrs.getString("Empname");
					       site_id=onrs.getString("VehicleRegNumber");
					       sql="select * from t_onlinedata where VehicleCode='"+vehcode1+"'";
						   ResultSet rstnew1=stx.executeQuery(sql);
						//   System.out.println("sql==>"+sql);
						   if(rstnew1.next())
						   {
							  date=rstnew1.getString("TheDate");
						      time=rstnew1.getString("TheTime");
							  vehcode=rstnew1.getString("VehicleCode");
						      String siteaddrs="",fuel="",battery="",temp="",noofgenset="",onof="";
							
							String sql3="select * from t_veh"+vehcode1+" where concat(TheFieldDataDate,'',TheFieldDataTime)=concat('"+date+"','','"+time+"')";
						//	String sql3="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
						//	System.out.println("sql3==>"+sql3);
						
						    ResultSet rs3=st1.executeQuery(sql3);
							if(rs3.next())
							{
							      onof=rs3.getString("Sen1");
							      battery=rs3.getString("Sen2");
							      fuel=rs3.getString("Sen3");
							      temp=rs3.getString("Sen4");
							       
							  //    System.out.println("onof==>"+onof);
	                          //    System.out.println(" battery==>"+battery);
	                          //    System.out.println("fuel==>"+fuel);
	                           //   System.out.println("temp==>"+temp);
	                               
							 //----------------------------------------------------------------------------     
					           //    String sq="select count(Sen1) as nob from t_veh"+vehcode+" where Sen1='ON' and TheFieldDataDate='"+dt1+"'" ;
					          String sq="select Sen1 from t_veh"+vehcode+" where TheFieldDataDate='"+dt1+"'" ;
                              ResultSet rq=st1.executeQuery(sq);             							
                           //	  System.out.println("sq==>"+sq);
        				      while(rq.next())
							  {
        				    	 r_cnt=rq.getRow();							  
							     stat=rq.getString("Sen1");
							     if(stat.equals("OF"))
							     {
							    	flg="Y"; 
							     }
							     if(stat.equals("ON") && r_cnt==1)
							     {
							    	 ccnt++;
						    		 flg="N";
							     }
							     if(stat.equals("ON") && flg.equals("Y"))
						    	 {
						    		 ccnt++;
						    		 flg="N";
						    	 }
							  }
                        	// System.out.println("---------count------"+ccnt);
							
                             //----------------------------------------------------------------------------  
                          //---Run Hr Logic-------------------------------------------------------------------------
                             /*String q1="select count(*) from t_veh"+vehcode+" where TheFieldDataDate='"+dt1+"'";
                             ResultSet rs_cnt=st1.executeQuery(q1);
                             
                             while(rs_cnt.next())
                             {
                            		 i_cnt=rs_cnt.getInt(1);
                             }*/
                             String q1="select * from t_veh"+vehcode+" where TheFieldDataDate='"+dt1+"'";
                             rs_cnt=st1.executeQuery(q1);
                             rs_cnt.last();
                             i_cnt=rs_cnt.getRow();
                          //   System.out.println("------row cnt-------------"+i_cnt);
                                   
                             String rh_q="select * from t_veh"+vehcode+" where TheFieldDataDate='"+dt1+"'" ;
                          //   System.out.println("_query__"+rh_q);
                             rs_rh=stmt.executeQuery(rh_q);
                             while(rs_rh.next())
                             {
                            	 rw_cnt=rs_rh.getRow();
                            	 rh_stat=rs_rh.getString("Sen1");
                            	 rh_date=rs_rh.getString("TheFieldDataDate");
                            	 if(rh_stat.equals("ON") && rh_flg.equals("N"))
                            	 {
                            //		 System.out.println("in 1");
                            		 rh_st1=rs_rh.getString("TheFieldDataTime");
                            		 rh_flg="Y";
                            		 
                            		 java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rh_date+" "+rh_st1);
                            		 miliseconds1=fd.getTime();
                            	 }
                            	 if(rh_stat.equals("ON") && rw_cnt==i_cnt)
                            	 {
                            		// System.out.println("in 2");
                            		 rh_st2=rs_rh.getString("TheFieldDataTime");
                            		 rh_flg="N";
                            		 
                            		 java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rh_date+" "+rh_st2);
                            		 miliseconds2=fd1.getTime();
                            		 
                            		 millisecdiff=miliseconds2-miliseconds1;
                            		 rh_total_time=rh_total_time+millisecdiff;
                            		 secdiff=millisecdiff/1000;
                            		 mindiff=secdiff/60;
                            		 hrdiff=mindiff/60;
                            		 
                            	 }
                            	 if(rh_stat.equals("OF") && rh_flg.equals("Y"))
                            	 {
                            		// System.out.println("in 3");
                            		 rh_st2=rs_rh.getString("TheFieldDataTime");
                            		 rh_flg="N";
                            		 
                            		 java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rh_date+" "+rh_st2);
                            		 miliseconds2=fd1.getTime();
                            		 
                            		 millisecdiff=miliseconds2-miliseconds1;
                            		 rh_total_time=rh_total_time+millisecdiff;
                            		 secdiff=millisecdiff/1000;
                            		 mindiff=secdiff/60;
                            		 hrdiff=secdiff/60/60;
                            		 mindiff=(secdiff/60) - (hrdiff*60);
                            		 
                            		 
                            		//======================================================
                            		 String str1=String.valueOf(hdiff);
                            		 if(str1.length()==1)
                            		 {
                            			 str1="0"+str1;
                            		 }
                            		 
                            		 String str2=String.valueOf(mdiff);
                            		 if(str2.length()==1)
                            		 {
                            			 str2="0"+str2;
                            		 }
                            	 //======================================================
                            		 
                            	//	 timeInHHmm = ""+hrdiff+":"+mindiff;
                            	 timeInHHmm = ""+str1+":"+str2;
//------------------------------
/*timeInSecs = timeDifferenceInMinutes/1000; 	//convert milliseconds to seconds
				timeDifferenceInMinutes=timeDifferenceInMinutes/1000/60; //convert milliseconds to minutes
			
				hours=timeInSecs/60/60;
				minutes=(timeInSecs/60)-(hours*60);
				onOffTimeDifference=""+hours+":"+minutes;*/
//-------------------------------

                            	 }
                             }
                             
                             //---------------------------------------------------------------------------- 
                               if((battery.equalsIgnoreCase("-"))||(fuel.equalsIgnoreCase("-"))||(temp.equalsIgnoreCase("-")))						
                               {				
                            	   battery="0";fuel="0";temp="0";
                            	//   System.out.println("in zero if");
                               }
                               
                             //  System.out.println("onof==>"+onof);
                            //   System.out.println(" battery==>"+battery);
                            //   System.out.println("fuel==>"+fuel);
                            //   System.out.println("temp==>"+temp);
                               String fuel1="",temp1="";
                               int ind=fuel.indexOf(".");
                               
                               if(ind>0)
                               {
                                fuel1=fuel.substring(0,ind);
                               }
                               int ind1=temp.indexOf(".");
                               if(ind1>0)
                               {
                                temp1=temp.substring(0,ind1);
                               }
                            
                               sr_no++;
                               %>
 <tr>						
   						<td align="right"><div align="right"><%=sr_no%></div></td>
						<td align="left"><div align="left"><a href="Gensetreport.jsp?vehc=<%=vehcode%>&addrs=<%=empname%>"><%=site_id%></a></div></td>
						<td align="right"><div align="right"><%=date+" "+time%></div></td>
						<td align="left"><div align="left"><%=empname%></div></td>
						<td align="right"><div align="right"><%=fuel1%></div></td>
						<td align="right"><div align="right"><%=battery%></div></td>
						<td align="right"><div align="right"><%=temp1%></div></td>
						<td align="right"><div align="right"><a href="Gensetreport1.jsp?vehc=<%=vehcode%>&addrs=<%=empname%>"><%=ccnt%></a></div></td>
						<%
						 sdiff=rh_total_time/1000;
						 mdiff=sdiff/60;
						 hdiff=sdiff/60/60;
						 mdiff=(sdiff/60) - (hdiff*60);
						 
						//======================================================
                		 String str1=String.valueOf(hdiff);
                		 if(str1.length()==1)
                		 {
                			 str1="0"+str1;
                		 }
                		 
                		 String str2=String.valueOf(mdiff);
                		 if(str2.length()==1)
                		 {
                			 str2="0"+str2;
                		 }
                	 //======================================================
                		 
                	 final_time = ""+str1+":"+str2;
						 
					//	 final_time=""+hdiff+":"+mdiff; 
						 %>
						<td align="right"><div align="right"><a href="Gensetreport2.jsp?vehc=<%=vehcode%>&addrs=<%=empname%>"><%=final_time%></a></div></td>
						</tr> 			
	<%		            }
						j++;
						
						}
					}
	                   %>
	                   </tr></table>		
					  				
	
	<%
    
	}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}%>
	    
	<% 
	    fleetview.closeConnection();
	   fleetview.closeConnection1();
	%>
	<%@ include file="footernew.jsp" %>

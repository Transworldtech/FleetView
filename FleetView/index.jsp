<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import=" java.text.*" errorPage="" %>
	<%@ include file="Connections/helpconn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>MyFleetView</title>
	<link rel="stylesheet" type="text/css" href="newstyle.css" />
	<script language="javaScript">
 
	function	displaytd(tdname)
	{
		try{
			var gettd= document.getElementById(tdname);
			if(gettd.style.display=="none")
				{
				gettd.style.display='inline';
				}else
					{
					gettd.style.display='none';
					}					
			
		}catch(e)
		{
			
		}
	}

function validate()
{
	if(document.loginform.user.value=="")
	{
		alert("Please Enter User Name");
		return false;
	}
	if(document.loginform.Password.value=="")
	{
		alert("Please Enter Password");
		return false;
	}
	return showmsg();
	return true;
}

function poponclick()
{
	testwindow = window.open("forgetPassword.jsp", "ForgotPassword", "width=500,height=300");
    testwindow.moveTo(500,250);
}
</script>
</head>
	<div id="header">
    	<a href="http://www.mobile-eye.in"><img src="newimages/mobile.jpg" style="height: 80px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
    <a href="http://www.transworld-compressor.com">
	     <img src="newimages/TW.JPG" 
	     style="height:38px; width: 180px; top: 22px; left: 35%; position: absolute; "
	      title="Transworld Compressor Technologies LTD."  />
      </a>
        <ul id="navBar">
        	<li class="current"><a href="http://www.twtech1.com/">About US</a></li>
            <li><a href="contactus.html">Contact us</a></li>
             <li><a href="http://blog.transworld-compressor.com/">Blog</a></li> 
          
                              
        </ul>
    </div>
  
    <div id="welcomeMessage">  
     
    <h1>Welcome to FleetView  </h1>
<!--    <img src="newimages/bp-logo.gif" alt="" /> -->
<!--    <b><font size="3" face="Arial" color = "Red">MOST URGENT: FLEET SAFETY AUDIT FREEZE</font></b><br>-->
<!--        <font size="2" face="Arial" color = "Red">ATTENTION: ALL CASTROL BP SUPPLY CHAIN PERSONNEL/TRAINERS/DMCs-->
<!--        <br><br>-->
<!--                ALL VEHICLES CARRYING CASTROL BP  CARGO ARE REQUIRED TO STOP AT SAFE PARKING LOCATION AT 2230 HRS ON <br>-->
<!--                JULY 18, 2012, TILL FURTHER -->
<!--INSTRUCTIONS. VEHICLES SHALL MOVE FROM THOSE LOCATIONS ONLY ON RECEIVING <br>-->
<!--SPECIFIC MOVEMENT INSTRUCTIONS FROM A CASTROL BP OFFICER.-->
<!--        </font>-->
    	
<ul class="TickList">
	<li>VTS<sup>&reg;</sup>  and Fleet Management</li>
	<li>Road Safety, HSSE Compliance</li>
	<li>Cold Chain Monitoring</li>
	<li>TRP Equipment</li>
	  </ul>
 <ul class="TickList1">
	<li>Driver Management</li>
	<li>Fuel Monitoring</li>
	<li>People Tracking</li>
	<li>Asset Management (D.G. Set, Cranes, JCB's, etc)</li>

 </ul>   
    </div>
    <div><font size="3" color="red"><center></center></font></div>
    
    <div id="someCustomersUp">
    
    <%@ include file="newImgRotate.html" %>
    </div>
        <div id="someCustomersDown">
        
     </div>
 			
    <div id="wrapper">
    	<div id="secWrapper">
        	<div id="container" class="clearfix">
            	<div id="mainCol" class="clearfix">
                	
                 	<div id="services"> 
<!--                 	<div id=""> -->
<!--                 	<font color = "red"><h2><blink><b> Our main server is down and you are on backup service. Services will be  -->
<!--         				 slow. Our service provider has experienced a major outage. System has been  -->
<!--         				 shifted to backup.</b></blink> </h2></font> -->
        				 
                     <h3>Our Services</h3> 
                     <ul> 
                     <li> 
                     <h4>Vehicle Safety:</h4> 
                     Locate and track your vehicle round the clock anywhere in the country.
                     </li> 
                      <li> 
                     <h4>Driver Management:</h4>
                     Get daily driver rating and monitor his performance based on his driving habits like Over-speeding, Harsh Braking, Stoppages etc. 
                     </li>
                      <li> 
                     <h4>Fleet Maintenance:</h4> 
                     Set & get vehicle maintenance alerts for PUC, Insurance, Vehicle Fitness, Servicing, Oil change etc. 
                    </li>  
                     </ul> 
                      </div>
                                             <div style="width: 100%;" >
                     <h3 id="why">Safety Around Large Vehicles</h3>                   
                    </div> 
                    <ul id="maincon"> 
                    <li class="clearfix last" >
           		  <iframe   width="600" height="270" src="http://www.youtube.com/embed/pbgeKuuHiL4?feature=player_detailpage" frameborder="1" allowfullscreen></iframe>
                   <b><font size="2"  color="#035789" >This UK video about Safety Around Large Vehicles is relevant wherever in the world you live and is especially useful for those that do not drive trucks.</font></b>
  
					  </li>
                                        
                    </ul>
                    
              <div style="width: 100%;" >
               <a href="https://twitter.com/fleetview" target="_blank" style="text-align: center;"><img src=newimages/twitter.png>
<script>!function(d,s,id){var 
js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script> </a>
<!--    <script type='text/javascript' src='http://www.twittermysite.com/mytwitter.js?id=102231&button=9'></script>-->
<!-- New Code Added on 12 Apl 2013 Remove it after one week    -->
&nbsp;&nbsp;&nbsp;&nbsp;

<a href="http://www.telematicsupdate.com/india-south-asia/content7.php" target="_blank" style="text-align: right: ;"><font size="4" color="#035789" style="font-family: Arial;" >Exclusive telematics India survey report</font></a>
<!--    <script type='text/javascript' src='http://www.twittermysite.com/mytwitter.js?id=102231&button=9'></script>-->
<!-- New Code Added on 12 Apl 2013 Remove it after one week    -->

                   <h3 id="why">Telematics Updates </h3>
                   <ul id="maincon">
<font size="3" style="font-family: Arial; color: #34394e;">
 <li class="clearfix">
 <b><font size="3"  color="#035789" >Telematics India And South Asia 2013 - April 17</font></b>
 </li>
 <li class="clearfix">
<table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
<tr> 
<td class="indeximagesLeft" valign="top" align="center" width="100"><img id="e9d38a" class="speakerImage" src="indeximages/Chandrika-Shetty.jpg" alt="Chandrika Shetty" style="width: 80px; height: 100px; " width="80" height="80" /></td>
<td  class="indeximagesMid" valign="top" width="400" ><b><font size=4>Chandrika Shetty</font></b><br /> VGT India Head<br /> <b><font size=4>Volvo India Private Limited</font></b><br /> <br /> <a class="morelink" href="javascript:displaytd('volvo')">Read Interview In Full</a></td>

<td class="indeximagesRight" align="justify" valign="middle"><img id="e82e1c" src="indeximages/volvo.png" alt="Volvo India Private Limited" style="width: 90px; height: 90px; " width="60" height="60" /></td>
</tr> 
<tr> 
</table>
<table  id="volvo" style="display: none;" class="indeximages" style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="more" colspan="3"  ><a href="http://analysis.telematicsupdate.com/sites/default/files/Shetty%20Volvo%20Podcast.mp3" target="_blank">Click here to download,</a> Listen Interview In Full
<br />
<b><font size=3>Chandrika Shetty, head of Volvo Group Telematics in India and leader of technology solution development for APAC, on finding services that make sense for Indian customers and telematics providers</font></b><br /> Chandrika Shetty, head of Volvo Group Telematics in India and leader of technology solution development for APAC, is used to working on a global scale. The veteran of Nokia, Wipro Technologies, Tata Consultancy Services and TCS has juggled the needs of European, Japanese and US tier 1s, managing multi-location teams while keeping an eye on brand building and strategy. As Volvo eyes increasing sales in India&mdash;and increasing vehicle connections&mdash;Shetty is charged with leading automotive infotainment and solutions development for Volvo Group and then bringing the most relevant services into India and APAC. Shetty spoke to TU&rsquo;s Susan Kuchinskas about balancing global and regional requirements.<br /> <br /> <b><font size=3>Tell us about your role at Volvo.</font></b>
<br />We started to set up in India in 2011, and I'm supporting the Indian site setup. There will be two global sites for Volvo Technology, G&ouml;teborgand Bangalore, with aggressive ramp-up plans. We'll be supporting both global development and local solution development for Volvo trucks, buses, and construction equipment here in India and also supporting Eicher Motors, our joint venture partner.
<br /><br /><b><font size=3>How much of what you do in India is aligned with Volvo Group's global efforts, and how much needs to be localized for the region?</font></b><br /> Globally, we are looking at having a common platform. We have two different platforms now, one for the external market, working with car OEMs that are not part of the Volvo Group, and there we have the NGP-based platform. We are developing complimentary services there. Then, there is the Volvo Group internal group platform. Our strategy for next year is to be able to move all our services onto these platforms and to be able to use the services and best practices from all our solutions. Locally, we are looking at how we can leverage what has been developed and localize it for market-specific services or the complements we need.<br /> <br /> <b><font size=3>What partnerships are you currently forging in the telematics landscape in India and southeast Asia?</font></b><br /> We are looking at two different kinds of partnerships. One is providing open interfaces from our solutions. We have a quadrant strategy, where we have services mainly for customers and providers and services for OEMs and dealers. We manage solutions for OEMs and dealers in-house. For customer- and driver-specific services&mdash;that is, revenue-making services that support their logistics and transport operations&mdash;we try to partner with third-party providers to create services. We are looking for partnerships there, and we're also creating an open platform to enable this kind of partnership. We also have preferred partners to develop solutions both here and globally.

<br /><br /><b><font size=3>When Telematics Update surveyed companies about the Indian market, respondents thought that, in the face of consumer lack of interest and the difficulty of finding a business model, automakers should lead deployment of telematics services. Who do you think should lead?</font></b> <br /> Today we are just starting off. When it comes to Europe and North America, we have the technology and services, and we're continuously improving how we provide these to customers. In India, we are working with our joint venture partner Eicher to understand what is required. It's a long journey. We need to look at what should be the strategy and what should be the services. We also are looking at Volvo Trucks: What kind of solution makes sense? What kind of services can we use for DynaFleet, for example? Should it be customized for mining operations in India? I wouldn't say we are leading today; we are just learning.
<br /><br /><b><font size=3>What kind of things do you take into consideration when making these decisions?</font></b> <br /> We did a customer survey last year and also a dealer survey. We got very good insights. We found that if you give the right service and give the right value, the customer is not all that concerned about the cost of the unit. We thought that price was the main criterion, but that's not how it looks.<br /> <br /> <b><font size=3>In the TU survey, respondents disagreed about which telematics service customers were most likely to pay for. They were evenly split among the four choices: navigation, fleet and security, in-car entertainment, and diagnostics/emergency and roadside assistance. What do you think?</font></b><br />
We are as of now prioritizing the needs of Volvo Group, which means commercial vehicles. Here we see that, even though the customer today is more aware of track-and-trace and fuel consumption, in the long run, having remote diagnostic services and dynamic service planning will make sense. So our group is concentrating on these services, not the OEM- and dealer-specific services.<br /> Also, the price point in India is something we will have to work with, to understand what subscription cost makes sense. We know that many third-party providers and OEMs have had to roll back the telematics positions they took. Roaming costs were very unpredictable, and customers were not happy with that. The quality of service was also something they had a lot of complaints about. That is affected by many factors, like telecom coverage and map availability. The market itself is maturing. Customers are aware, and they want more. We have to find the right service that makes sense for the customer and for the telematics provider.<br /> <br /> Susan Kuchinskas is a regular contributor to TU.
</td>

</tr>
</table>
</li>
<li class="clearfix">

<table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="indeximagesLeft" valign="top" width="100" align="center"><img style="width: 80px; height: 100px; " id="e6c69c" class="speakerImage" src="indeximages/Sanjay-Gupta.jpg" alt="Sanjay Gupta" width="100" height="100" /></td>
<td class="indeximagesMid" valign="top" width="400" ><b><font size=4>Sanjay Gupta</font></b><br /> Head, Telematics and Fleet Management Services<br /> <b><font size=4>Tata Motors Ltd</font></b><br /> <br /> <a class="morelink" href="javascript:displaytd('Tata')">Read Interview In Full</a></td>

<td class="indeximagesRight" align="center" valign="top"><img  style="width: 90px; height: 90px; " id="e9acf3" src="indeximages/Tata.png" alt="Tata Motors Ltd" width="85" height="75" /></td>
</tr>

</table>
<table  id="Tata" style="display: none;" class="indeximages" style="width: 100%;" border="0" cellspacing="0" cellpadding="0">


<tr>
<td class="more" colspan="3"><span class="h2">Tata Motors talks telematics and the road to profitability</span><br />
<b><font size=3>Sanjay Gupta, head of telematics and fleet management for Tata Motors Ltd. Mumbai, on the services most likely to get customers to open their wallets</font></b>
<br />Sanjay Gupta, head of telematics and fleet management for Tata Motors Ltd. Mumbai, has handled middle- and senior-level assignments in sales and marketing of&nbsp;commercial vehicles and passenger cars since 1988. In 2011, he was appointed to lead the new telematics initiative of Tata Motors, launching fleet telematics services under the brand name Tata Fleetman in September 2012.
<br /><br /><b><font size=3>When Telematics Update surveyed companies about the Indian market, respondents had no agreement about what telematics services customers there were most likely to pay for. They were evenly split among the four choices: navigation, fleet and security, in-car entertainment, and diagnostics/emergency and roadside assistance. What do you think and why?</font></b>
<br />Navigation. On board navigation with pre-loaded maps has not caught on in India, even though it has been around for several years. There are several reasons for this. First, there are inaccuracies in maps due to road or POI changes between upgrades as well as inadequate detailing. There's also a high prevalence of chauffeur-driven cars in India where the chauffeur is also the navigator, while, mostly, people drive on familiar local routes. Finally, most smartphones have navigation, which suffices for the infrequent instances when navigation is required.
Fleet telematics is already a paid service in heavy trucks as well as fleet cabs, and that will continue to grow. For location-based services to catch on, more value addition will be required. Tracking in commercial vehicles is already fairly common. Accurate traffic information and journey time estimation along with navigation will make a lot more people interested. Due to the high incidence of theft, reliable security services will find takers.
As for in-car entertainment, Internet radio has still not caught on in India. Even when it does, it is still hard to say whether people will opt for direct subscription against advertising consumption-based models. Currently there is an absence of large third-party service providers for emergency and roadside assistance services in India. However, demand exists, and people will pay for them

<br /><br /><b><font size=3>What partnerships are you forging or contemplating in the telematics landscape in India and South Asia?</font></b>
<br />Talking about India, I can foresee partnerships between auto OEMs and full-scale telematics service providers, telecom companies, software companies, such as Google, and providers of third-party services.
<br /><br /><b><font size=3>Are there niches in the developing ecosystem that need to be filled?</font></b>
<br />Third-party services are currently a void that needs to be filled for launching telematics services in areas like traffic information, convenience and emergency response.
<br /><br /><b><font size=3>Our survey respondents thought that, in the face of consumer lack of interest and the difficulty of finding a business model, automakers should lead deployment of telematics services. What barriers do you see, and how will you overcome them?</font></b>
<br />In the fleet and commercial vehicle space, the benefits of using telematics are tangible and demonstrable. The challenge will be to change habits, mind-sets and a certain diffidence towards technology through information and education of customers. In personal vehicles, the task will be tougher due to the prevalence of smartphones, lack of third-party service providers and a predominance of chauffeur-driven cars.
Reliability and value of services will have to be established and demonstrated before customers will open their wallets. Automakers will have to consciously look at upfront risky investments with long payback periods. Another barrier that most automakers will face is that their competency and systems cater to product marketing. Service development and marketing will be a new area they will have to learn.
<br /><br /><b><font size=3>Can you give us a look at what services might be deployed in the next two years, either by Tata Motors or others?</font></b>
<br />Fleet telematics, which is presently limited to tracking-based services, will see diagnostics and safety and security services getting added. In passenger cars, smartphone integration will be first off the block and will enable navigation and in-car infotainment. Some form of emergency and security services, as well as some convenience services, may also be launched.

<br /><br /><b><font size=3>What are you most excited about as you work in this industry?</font></b>
<br />Being in the thick of an unfolding future and being an agent of a rapid, far-reaching change lend both a palpable excitement and a sense of purpose.</td>
</tr>
</table>
</li>
<li class="clearfix">
<table style="width: 100%;" border="0" cellspacing="0" cellpadding="0"> 
<tr>
<td class="indeximagesLeft" valign="top" width="100" align="center"><img style="width: 80px; height: 100px; " id="e6c69c2" class="speakerImage" src="indeximages/Omkar-Panse.jpg" alt="Omkar Panse" name="e6c69c" width="100" height="100" /></td>
<td class="indeximagesMid" valign="top" width="400" ><b><font size=4>Omkar Panse</font></b><br /> Marketing Manager - Infotainment<br /> <b><font size=4>KPIT Cummins</font></b><br /> <br /> <a class="morelink" href="javascript:displaytd('kpit')">Read Interview In Full</a></td>
<td class="indeximagesRight" align="right" valign="middle"><img style="width: 110px; height: 75px; "   id="e3" src="indeximages/KPIT-Cummins.png" alt="KPIT Cummins" name="e50406" width="93" height="68" /></td>
</tr>
</table>
<table  id="kpit" style="display: none;" class="indeximages" style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="more" colspan="3"><b><font size=3>Omkar S. Panse, product manager for infotainment, KPIT Cummins Infosystems Ltd, on India&rsquo;s appetite for in-vehicle infotainment</font></b><br /> Omkar S.&nbsp;Panse has 16 years of experience in the automotive industry, spanning various vehicle electronics subsystems and technologies. He has been with KPIT Cummins Infosystems Ltd for more than 12 of those years and currently leads the KPIT infotainment platform team. In his role as associate vice president, Panse also oversees KPIT&rsquo;s contributions to GENIVI, a global alliance aiming to build industry-wide standards for in-vehicle infotainment through open-source innovation. Panse talked to TU&rsquo;s Jan Stojaspal about India&rsquo;s appetite for in-vehicle infotainment and where the biggest market opportunities lie.&nbsp;<br /> <br /> <b><font size=3>How do you make money in an extremely price-conscious market like India, a market that is already awash with feature-rich aftermarket infotainment solutions?</font></b> <br /> It&rsquo;s not that people are not willing to pay, but they are extremely wary about the value that the product brings to their life. There are a lot of aftermarket systems available in the range of $500 to $1,000. Typically, if one pays something like $500, he gets a six-inch touch screen with all the run-of-the-mill multimedia features: DVD, tuner and Bluetooth. One also gets iPod and iPhone connectivity. But that&rsquo;s pretty much it. Add navigation to that, and you are looking at the higher price point.<br />But that still won&rsquo;t give you a connected experience. And that&rsquo;s where it becomes interesting for KPIT. Being a technology company focused on the automotive industry for over two decades, we understand connected services (cloud computing solutions and infrastructure) and bring the automotive know-how to provide the right mix of connected car services.

<br /><br /><b><font size=3>Still, the opportunities seem to be largely in the aftermarket. Does that leave any room for embedded solutions? Last year&rsquo;s sales figures show that only 7,000 of 2.6 million new cars sold in India came with an embedded navigation system.</font></b> <br /> We are slowly going up the curve, especially coming from the luxury vehicle segment now. And more and more OEMs are looking at deeply integrated, embedded infotainment systems. But the percentage of OEM-branded and OEM-fitted embedded infotainment systems remains pretty low. Traditionally, infotainment has been an aftermarket proposition in the Indian market. What&rsquo;s more, consumers are not yet very brand-conscious when it comes to the infotainment part of the vehicle. Most cars sold in India are small cars. And the differentiation in this segment is fuel economy and price of the vehicle, not what my infotainment box brings
<br /><br /><b><font size=3>The majority of KPIT Cummins&rsquo; business comes from outside of India. What telematics solutions have you been able to place in India so far?</font></b> <br />India has been a key growth market for KPIT since 2008, 2009. Our focus for India has been to develop relevant, frugal and affordable solutions faster. In terms of what&rsquo;s already out there, it&rsquo;s KPIT&rsquo;s telematics solution for the commercial vehicle space, and it is in a few thousand vehicles now. This solution includes vehicle tracking, geo-fencing and a very comprehensive reporting dashboard. We are now taking it to the next level: a fully integrated solution, which includes standard telematics features but also a data plan and Internet connectivity.<br /> <br /> <b><font size=3>Where does a company like yours have an edge in the Indian market?</font></b> <br /> We have significant experience from the developed markets, mainly the United States and Europe. At the same time, we are a company with deep Indian roots. Our hardware and software solutions are far more competitive in terms of the price, and that also extends to connectivity and the connected experience.<br /> An understanding of how the user experience is perceived by an Indian consumer is also important as [local preferences] are quite different. One example is how music is consumed in India. Elsewhere, music is typically organized by artist, album. In India, where a large proportion of music content comes from movies, people would rather see music organized by their favorite movies.<br /> <br /> <b><font size=3>So being price-competitive and catering to local tastes is essential. Still, how do you get people to pay for value-added/connected services if they are already extremely price-sensitive when buying a basic infotainment system?</font></b> <br /> This goes back to my original point. It is not that people don&rsquo;t want to pay. But the product really needs to bring value to them.</td>

</tr>

</table>
</li>
<li class="clearfix last">
<table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="indeximagesLeft" valign="top" width="100" align="center"><img style="width: 80px; height: 100px; " id="e6c69c9" class="speakerImage" src="indeximages/Harwinder.jpg" alt="Dr. Harwinder S. Jutla" name="e6c69c" width="100" height="100" /></td>
<td class="indeximagesMid" valign="top" width="400" ><b><font size=4>Dr. Harwinder S. Jutla<br /> </font></b>Embedded product Design<b><font size=4><br /> <b><font size=4>TATA ELXSI</font></b></font></b><br /> <br /> <a class="morelink" href="javascript:displaytd('TataE')">Read Interview In Full</a></td>

<td class="indeximagesRight" align="right" valign="middle"><img style="width: 120px; height: 60px; " id="e50406" src="indeximages/TATA-ELXSI.jpg" alt="TATA ELXSI" name="e50406" width="115" height="47" /></td>
</tr> 
</table>
<table  id="TataE" style="display: none;" class="indeximages" style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
<tr>
<td class="more" colspan="3"><b><font size=3>What does your department /company do?</font></b>
Tata Elxsi is a design company that blends technology, creativity and engineering to help customers transform ideas into world-class products and solutions. We address the communications, consumer products, defence, healthcare, media &amp; entertainment, semiconductor and transportation (automotive &amp; aerospace) sectors.&nbsp; <br /> Tata Elxsi provides customized R&amp;D services, system and sub-system designs spanning across the product&rsquo;s lifecycle to automobile OEMs and Tier 1s. Our areas of expertise include body &amp; Chassis Electronics, Telematics, Infotainment, Clusters, Powertrain Electronics, Hybrid Electronics, and Safety &amp; Security.<br /> We focus on creating value across the telematics/infotainment ecosystem. Our services range from user applications to TSPs, to the TCUs supporting prototyping, vehicle integration and field trails through to product release.

<br /><br /><b><font size=3>What is your key role in the telematics market in India and South Asia?</font></b><br />
Tata Elxsi works with a number of OEMs and Tier 1s developing telematics eco systems starting from specification through manufacture, vehicle integration, field services and other related activities.<br />  We also provide user research/ usability study for emerging markets like South Asia &amp; India, thereby providing insights into the market needs.
<br /><br /><b><font size=3>What partnerships are you currently forging in the telematics landscape in India and South Asia? Also, what industry milestone did you recently achieve or are working towards achieving? </font></b>
<br />We are forging relations with various semiconductor companies, telecom service providers, OEMs and Tier 1s to explore different opportunities in emerging markets like India &amp; South Asia.<br /> We also actively participate in NASSCOM&rsquo;s Auto SIG, which helps shape the telematics landscape in India.

<br /><br /><b><font size=3>What services do you think will be deployed in the next two years?</font></b>
We expect wide adoption of remote fleet management by transport companies in the coming years. We also expect a surge in the demand for connected vehicles and the related applications like cloud connected telematics and infotainment.
<br /><br /><b><font size=3>What do you think are the best ways to deploy and get telematics mass market in this region on the road in India?</font></b>
While working with OEMs in other regions, Tata Elxsi has observed the challenges they face in making business case for telematics implementation, some of which are similar to those faced by telematics services providers in India. <br /> However, the strategies to address the challenges and identify the use cases have to be unique from those used in other markets, given the market dynamics like cost sensitivity and perception as a premium service.
Inspite of these challenges, some of the factors which positively impact the Indian and South Asian market are widespread adoption of smartphones and growing mobile connectivity. These factors could be leveraged to bring advanced telematics and infotainment experience to the existing head-units through wired or short-range wireless connectivity options.<br /> Tata Elxsi has implemented systems like Terminal Mode Emulation and MirrorLink, which uses smartphones to enable connectivity in the car.
<br /><br /><b><font size=3>Currently, what do you think is the main deterrent or challenges to telematics systems? </font></b>


<br />- Telecom infrastructure to support the implementation of car telematics in the best possible manner
<br />- Lack of appropriate business cases
<br />- Perception of infotainment as a luxury service
<br />- Lack of defined market structure
<br />- Cost-sensitiveness of both devices as well as service
<br />- Lack of differentiated strategy to address the market
<br />- Lack of clarity in regulatory requirements and standardisation
<br />- Awareness of connected vehicles and telematics services

<br /><br />
<b><font size=3> What is the top telematics specific service that consumers will pay for?</font></b>

<br />- Tracking of stolen vehicle
<br />- Pilfering from/ misuse of fleet vehicles (both passenger &amp; commercial)
<br />- Providing security for the family by tracking vehicle location
<br />- Emergency call, and navigation related paid services

<br /><br /><b><font size=3> Could you tell us what key topics or issues you are looking at discussing with the industry at the Telematics India and South Asia 2013 Conference?</font></b>

<br />- ROI on telematics in India &amp; Asia
<br />- Role that MNOs are/would like to play in this area
<br />- Understand the topology of the emerging telematics service providers

</td>
</tr>
</table>
</li>
</font>
</ul>               
                   
<!--                xzc    -->
                    
                    </div>

                    
                    
                    
                    <div style="width: 100%;" >
                     <h3 id="why">Why Choose Transworld ? </h3>
                   
                    </div>
                    <ul id="maincon">
                    <li class="clearfix">
                    <img src="newimages/image1.jpg" alt="image1" />
                    <h2>Services you could depend on</h2>
                     <p>With <b>22 locations</b> pan India, our <b>replacement</b> warranties with a TAT of 72 hours is a guaranteed peace of mind to all our reputed customers across the country.</p>
                    </li>
                    <li class="clearfix">
                    <img src="newimages/image2.jpg" alt="image1" />
                    <h2>Guranteed added value</h2>
                     <p>Our solution saves time, money and delivers <b>Safety on time, every time.</b> The ROIs on the solution are greater than 100% p.a.</p>
                    </li>
                    <li class="clearfix">
                    <img src="newimages/image3.jpg" alt="image1" />
                    <h2>Support you can trust</h2>
                    <p>We <b>proactively</b> function as an extension of our customer's fleet management team. On spotting deviant behaviour <b>we directly call</b> the driver or the fleet manager to ensure compliance. Our all-day customer support team monitors all your vehicles and <b>ensures minimum downtime</b> for your vehicles across the country.
                    </li>
                    <li class="clearfix last">
                    <img src="newimages/image4.jpg" alt="image1" />
                    <h2>Professional team at your help</h2>
                    <p>Our entire team of <b>qualified</b> technicians, engineers, designers and key account managers are always eager to help you and <b>understand</b> your requirements to deliver the required tailor made <b>solutions</b> for you.
                    </li>
                    </ul>

                </div>
                <div id="secCol">
              		<fieldset id="login"> 
                    	<h4>Members login</h4>
               			<form name="loginform" action="userinfo.jsp" method="post" onSubmit="return validate();">
                        	<p class="clearfix"><label for="username">Username</label>
                            <input name="user" id="username" type="text" value="" /></p>
                            <p class="clearfix"><label for="password">Password</label>
							<input name="Password" id="password" type="password"  value="" /></p>
                              <p><!--<input type="checkbox" id="remember" name="remember" />
                           <label for="remember" id="remlabel">Remember me</label> -->
                        <input name="submit" id="submit" type="submit" value="" />
                        </p>
                         <p>
                        <a href="#" onclick="javascript: poponclick()">Forgot Password?</a></p>  
                        <%
								String err=request.getParameter("err");
								if(null==err)
								{
								}
								else
								{
								if(err.equals("err2"))
								{
								out.print("<center><blink><font color='red' size='3'>Session expired, please login again.</font></blink>");
								}
								else
								{
								out.print("<left><blink><font color='red' size='2'>Incorrect Username or Password!!!</font></blink>");
								
								}
								}
%>
                    	</form>
                    	<!-- 
                        <p class="member"><a href="#">Lost your Password?</a><br />Not a member yet? <a href="#">Register now!</a></p>
                        -->
                    </fieldset>
                    <!-- <h3 id="news">Some Customers</h3>
                    <ul>
                    	<li class="clearfix"><div align="center">
						</div>
                        </li>
      
                    </ul> -->
                    
                    <h3 id="test">Help Line</h3>
                    <ul>
                    <li class="clearfix">
                   <table>
                   	<%
					try{
						
					String sql="select * from t_helpline";
					ResultSet rst=getStatement.executeQuery(sql);
					if(rst.next()){
					%>
						<tr><td><font size="2" face="arial" color="#C94093"> Phone :	<%=rst.getString("PhoneNumber") %> </font></td></tr>
						<tr><td><font size="2" face="arial" color="#C94093"> Email:	<a href="mailto:<%=rst.getString("Email") %>"><%=rst.getString("Email") %></a> </font></td></tr>
						<tr><td><font size="2" face="arial" color="#C94093"> Contact Time:	<%=rst.getString("ContactTime") %> </font></td></tr>
						<%
					}
					}catch(Exception e)
					{
						out.print("Exception "+e);
					}
					finally
					{ try { getStatement.close(); }catch(Exception e) { } try { getDattabase.close(); }catch(Exception e) { }
					}
%></table>
                    </li>
                    </ul>
                    <h3 id="news">Testimonials</h3>
                    <ul>
                    	<li class="clearfix"> <p>  
					We are using Transworld's Fuel Flow Measuring System.  
					The system meets our requirements and we find it extremely satisfactory. 
					We have found the system to be accurate the range of +- 50 ml. 
					Transworld's technology is advanced and their domain expertise is extensive. 
					We have no hesitation in recommending this solution to users who value cutting edge technology that delivers efficiency and safety at a good value for money.
 </p> <p>Regards,</p>
<p>
<b>Tejas Kshatriya</b></p><p>
Program Manager - KPIT Cummins</
</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="footer">
    	<ul>
	        <li><a href="http://www.transworld-compressor.com">Home</a>&nbsp;&nbsp;-&nbsp;&nbsp;</li>
 			<li><a href="http://maps.google.com/?saddr=18.534475,73.898428">Sitemap</a>&nbsp;&nbsp;-&nbsp;&nbsp;</li>
  	        <li><a href="mailto:avlsupport@Mobile-Eye.in">Support</a>&nbsp;&nbsp;-&nbsp;&nbsp;</li>
			<li><a href="http://www.myfleetview.com/FleetView/contactus.html">Contact Us</a></li>
        </ul>
        <p>
        Copyright &copy; 2008* by Transworld Compressor Technologies Ltd. All Rights Reserved. 
        </p>
    </div>
</body>
</html>

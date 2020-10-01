/*********************************************************************
	Name		:commonmenu.js
	Description	:This files contains the basic contents for main menu and sub 
				menus present in each web page.Any number of styles can be defined
				and used in this menu 
	Author		:C.R.Bineesh
	Date		:6Sept2002
[  WARNING ]The following line is critical for menu operation, and MUST APPEAR ONLY ONCE. 
If you have more than one .js file rem out this line in subsequent files
******************************************************************************************/

menunum=0;
menus=new Array();
_d=document;
function addmenu()
{
	menunum++;
	menus[menunum]=menu;
}
function dumpmenus()
{
 	mt="<script language=javascript>";
    for(a=1;a<menus.length;a++)
    {
     mt+=" menu"+a+"=menus["+a+"];"
    }
     mt+="<\/script>";
    _d.write(mt)
}

//Please leave the above line intact. The above also needs to be enabled if it not already 
//enabled unless this file is part of a multi pack.
//********************************[  END OF WARNING ]*****************************************

//********************************************************************************************
//*******************              EDITABLE PROPERITIES START HERE         *******************
//********************************************************************************************

// Special effect string for IE5.5 and above .This will not work on Netscape 
effect = "Fade(duration=0.2);Alpha(style=0,opacity=88);Shadow(color='#777777', Direction=135, Strength=5)"


timegap=200			// The time delay for menus to remain visible
followspeed=5		// Follow Scrolling speed
followrate=40		// Follow Scrolling Rate
suboffset_top=0;	// Sub menu offset Top position 
suboffset_left=-3;	// Sub menu offset Left position
closeOnClick = true


//*****************************DEFINING STYLE FOR MENU ***************************************
style1=[			// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
"ffffff",			// Mouse Off Font Color
"330000",			// Mouse Off Background Color
"663300",			// Mouse On Font Color
"ffffcc",			// Mouse On Background Color
"6B69A5",			// Menu Border Color 
11,					// Font Size in pixels
"normal",			// Font Style (italic or normal)
"normal",				// Font Weight (bold or normal)
"Verdana",			// Font Name
4,					// Menu Item Padding
"",					// Sub Menu Image (Leave this blank if not needed)
"36342a",					// 3D Border & Separator bar
"",					// 3D High Color
"",					// 3D Low Color
"FFFF99",			// Current Page Item Font Color (leave this blank to disable)
"03502f",			// Current Page Item Background Color (leave this blank to disable)
"",					// Top Bar image (Leave this blank to disable)
"FFFF99",			// Menu Header Font Color (Leave blank if headers are not needed)
"636563",			// Menu Header Background Color (Leave blank if headers are not needed)
"36342a",			// Menu Item Separator Color
]
stylefor640=[			// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
"000000",			// Mouse Off Font Color
"#D0FBD8",			// Mouse Off Background Color
"ffffff",			// Mouse On Font Color
"4f9561",			// Mouse On Background Color
"6B69A5",			// Menu Border Color 
11,					// Font Size in pixels
"normal",			// Font Style (italic or normal)
"normal",				// Font Weight (bold or normal)
"Verdana",			// Font Name
2,					// Menu Item Padding
"/images/arrow_nav.gif",					// Sub Menu Image (Leave this blank if not needed)
"36342a",					// 3D Border & Separator bar
"",					// 3D High Color
"",					// 3D Low Color
"FFFF99",			// Current Page Item Font Color (leave this blank to disable)
"03502f",			// Current Page Item Background Color (leave this blank to disable)
"",					// Top Bar image (Leave this blank to disable)
"FFFF99",			// Menu Header Font Color (Leave blank if headers are not needed)
"636563",			// Menu Header Background Color (Leave blank if headers are not needed)
"36342a",			// Menu Item Separator Color
]
TopHeader=[			// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
"",			// Mouse Off Font Color
"",			// Mouse Off Background Color
"",			// Mouse On Font Color
"",			// Mouse On Background Color
"",			// Menu Border Color 
11,					// Font Size in pixels
"normal",			// Font Style (italic or normal)
"normal",				// Font Weight (bold or normal)
"Verdana",			// Font Name
2,					// Menu Item Padding
"images/arrow_nav.gif",					// Sub Menu Image (Leave this blank if not needed)
"36342a",					// 3D Border & Separator bar
"",					// 3D High Color
"",					// 3D Low Color
"FFFF99",			// Current Page Item Font Color (leave this blank to disable)
"03502f",			// Current Page Item Background Color (leave this blank to disable)
,					// Top Bar image (Leave this blank to disable)
"ffffff",			// Menu Header Font Color (Leave blank if headers are not needed)
"",			// Menu Header Background Color (Leave blank if headers are not needed)
"36342a",			// Menu Item Separator Color
]
style2=[			// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
"ffffff",			// Mouse Off Font Color
"000000",			// Mouse Off Background Color
"FFFF00",			// Mouse On Font Color
"03502f",			// Mouse On Background Color
"6B69A5",			// Menu Border Color 
11,					// Font Size in pixels
"normal",			// Font Style (italic or normal)
"normal",				// Font Weight (bold or normal)
"Verdana",			// Font Name
0,					// Menu Item Padding
"",					// Sub Menu Image (Leave this blank if not needed)
"ffffff",			// 3D Border & Separator bar
"ffffff",			// 3D High Color
"ffffff",			// 3D Low Color
"FFFF99",			// Current Page Item Font Color (leave this blank to disable)
"03502f",			// Current Page Item Background Color (leave this blank to disable)
"",					// Top Bar image (Leave this blank to disable)
"FFCF00",			// Menu Header Font Color (Leave blank if headers are not needed)
"636563",			// Menu Header Background Color (Leave blank if headers are not needed)
"636563",			// Menu Item Separator Color
]
style3=[				// Menu Properties Array
"330000",				// Off Font Color
"ffffcc",				// Off Back Color
"330000",				// On Font Color
"e3e3b6",				// On Back Color
"cc9900",				// Border Color
10,						// Font Size
"normal",				// Font Style
"normal",				// Font Weight
"Verdana",				// Font
3,						// Padding
"/IMAGES/arrow_nav.gif", 	// Sub Menu Image
0,						// 3D Border & Separator
"ffffff",				// 3D High Color
"000000"				// 3D Low Color
]

style4=[				// Menu Properties Array
"ffffff",				// Off Font Color
"330000",				// Off Back Color
"663300",				// On Font Color
"ffffcc",				// On Back Color
"330000",				// Border Color
10,						// Font Size
"normal",				// Font Style
"normal",				// Font Weight
"Verdana",				// Font
2,						// Padding
, 						// Sub Menu Image
0,						// 3D Border & Separator
"ffffff",				// 3D High Color
"000000"				// 3D Low Color
]

//*****************************END ***********************************************************
/*********************************************************************************************
For making the menu resolution independent and to make it look alike in any resolution menu 
is made according to the resolution of the screen
**********************************************************************************************/
//********************** [For Resolution 640 by 480]****************************************************************************
if (screen.width == 640)
 {
    addmenu(menu=[		// This is the array that contains your menu properties and details
    "mainmenu",			// Menu Name - This is needed in order for the menu to be called
    109,				// Menu Top - The Top position of the menu in pixels
    2,					// Menu Left - The Left position of the menu in pixels
    68,	// Menu Width - Menus width in pixels
    0,					// Menu Border Width 
    ,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
    stylefor640,				// Properties Array - this is set higher up, as above
    1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
    "center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
    effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
    ,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
    1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
    ,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
    ,					// Position of TOP sub image left:center:right
    ,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
    ,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
    ,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
    ,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
    ,					// Background image for menu when BGColor set to transparent.
    ,					// Scrollable Menu
    ,					// Reserved for future use
   ,"Home","index.asp","","",2
,"About Us","show-menu=about","aboutus.asp","",2
,"Student's Life","show-menu=student","studentIntroduction.asp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
,"Admission","show-menu=admission","admissionprocedure_BBA.asp","",2
,"Syllabus","show-menu=course","coursestructureBBA.asp","",2 
,"Achievements","show-menu=achievements","acads.asp.asp","",2
,"Events","events.asp","","",2
,"Faculty","show-menu=faculty","faculty_BBA.asp","",2
,"Contact Us","contactus.asp","","",2])

	
//*************************************ADDING MENU ITEMS**************************************
addmenu(menu=["about",				//ITEM2
,,165,,"",style4,,"left",effect,,,,,,,,,,,,
,"Chairman's Message","chairmensmessage.asp",,,
,"Our Philosophy","vision.asp","",,
,"BBA","show-menu=bba","bba.asp",,
,"Indira College Of Science","show-menu=science","indiraScience.asp",,
,"Indira College Of Commerce","show-menu=commerce","indiraCommerce.asp",,
])	

addmenu(menu=["student",				//ITEM2
,,155,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","studentIntroduction.asp",,,
,"Housing/Transportation","housing.asp",,,
,"Campus Facilities","campus.asp",,,
,"Library Services","libraryServices.asp",,,
,"Student Council","studentCouncil.asp",,,
])	
	
addmenu(menu=["admission",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Selection Procedure&nbsp","show-menu=Selection","admissionprocedure_BBA.asp",,
,"Apply","onlineApplication.asp",,,
])	

addmenu(menu=["Selection",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCA.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
])	

addmenu(menu=["course",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBca.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
])	

addmenu(menu=["faculty",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_Bca.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_Bcs.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
])

addmenu(menu=["achievements",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"Academics","acads.asp",,,
,"Sports","sports.asp",,,
,"Extra-Curricular","curricular.asp",,,
])

addmenu(menu=["science",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","indiraScience.asp",,,
,"Co-ordinator's message","coordinatormessage_science.asp",,,
])

addmenu(menu=["commerce",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","indiraCommerce.asp",,,
,"Co-ordinator's message","coordinatormessage_commerce.asp",,,
])

addmenu(menu=["bba",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","bba.asp",,,
,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
])

addmenu(menu=["events",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Indira Events Calender","events.asp",,,
,"Event Registration","eventregistration.asp",,,
])


}
//************************************[ENDS]**************************************************


//********************** [For Resolution 800 by 600]******************************************
if (screen.width== 1024){
if (browser.isIE5x)
	{
		addmenu(menu=[		// This is the array that contains your menu properties and details
		"mainmenu",			// Menu Name - This is needed in order for the menu to be called
		65,				// Menu Top - The Top position of the menu in pixels
		3,					// Menu Left - The Left position of the menu in pixels
		67,	// Menu Width - Menus width in pixels
		0,					// Menu Border Width 
		,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
		style1,				// Properties Array - this is set higher up, as above
		1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
		"center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
		effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
		,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
		1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
		0,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
		,					// Position of TOP sub image left:center:right
		,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
		,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
		,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
		,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
		,					// Background image for menu when BGColor set to transparent.
		,					// Scrollable Menu
		,					// Reserved for future use
		,"Login","user.htm","","",2
		,"New","show-menu=about","default.jsp","",2
		,"Edit","show-menu=about1","default.jsp","",2
		,"View","show-menu=student","default.jsp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
		,"Transactions","show-menu=admission","default.jsp","",2
		,"Bill","show-menu=bill","default.jsp","",2 
		,"Account","show-menu=Account","default.jsp","",2
		,"Sell","show-menu=Sell","default.jsp","",2
		,"Vendor","show-menu=Vendor","default.jsp","",2
		,"Reports","show-menu=Reports","default.jsp","",2])
		
		
		//*************************************ADDING MENU ITEMS**************************************
		//addmenu(menu=["BookEntry",				//ITEM2
		//,,175,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"BookEntry","bookentry123456.jsp?id=select",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		
		//])	
		addmenu(menu=["about",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		,"BookEntry","enter22.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		,"periodical","periodical.jsp",,,
		//,"Edit Periodical","updateperiodical.jsp",,,
		,"Periodical Subscription","searchperiodicalsubscription.jsp",,,
		,"Local Periodical Purchase","searchlocalperiodicalsubscription.jsp",,,
		,"Member Periodical Subscription","memberperiodicalsubscription.jsp",,,
		,"Member","member.jsp",,,
		,"Applicant","Applicants.jsp",,,
		,"Employee","employee.jsp",,,
		,"Suggestions","suggestions.jsp",,,
		,"Vendor","vendor.jsp",,,
		,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		,"CD","Entercd.jsp",,,
		,"Subscribed Periodical Received","searchperiodicalforreceive.jsp",,,
		,"Member Subscribed Periodical Sent","searchmemberperiodicalforsent.jsp",,,
		,"Enter Books For Selection","enterbooksforselection.jsp",,,
		])	
		
		addmenu(menu=["about1",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"BookEntry","enter21.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		//,"periodical","periodical.jsp",,,
		,"Edit Periodical","updateperiodical.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		,"Edit Employee","updateemployee.jsp",,,
		,"Edit Suggestions","suggestionsearch.jsp",,,
		,"Edit Bookings","updatebooking.jsp",,,
		,"Edit Vendor","updatevendor.jsp",,,
		,"Edit Member","show-menu=about2","listmember.jsp",,
		,"Edit Book","editbook.jsp",,,
		,"Edit Local Periodical Purchase","editlocalperiodicalsubscription1.jsp",,,
		,"Edit Periodical Subscription","editperiodicalsubscription.jsp",,,
		])	
		
		addmenu(menu=["about2",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"List Members","listmember.jsp",,,
		,"Search Member","searchmember.jsp",,,
		
		])
		
				
		addmenu(menu=["student",				//ITEM2
		,,155,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Member","member.jsp",,,
		,"View Book","show-menu=about3","listbook.jsp",,
		,"View Rejected Books","ViewRejectedBook.jsp",,,
		,"View CD","viewCD.jsp",,,
		,"View Member","searchmember.jsp",,,
		//,"parameter","parameter.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		//,"Employee","employee.jsp",,,
		,"View Employee","updateemployee.jsp",,,
		//,"Suggestions","suggestions.jsp",,,
		//,"Edit Suggestions","updatesuggestions.jsp",,,
		,"View Suggestions","suggestionsearch.jsp",,,
		,"BookSearchforBooking","booksearchforbooking.jsp",,,
		//,"Bookings","booking.jsp",,,
		//,"Edit Bookings","updatebooking.jsp",,,
		,"View Bookings","bookingsearch.jsp",,,
		//,"Vendor","vendor.jsp",,,
		,"View Vendor","updatevendor.jsp",,,
		,"View Periodical Receieved","searchperiodical.jsp",,,
		//,"Convert to Member","updateapplicants.jsp",,,
		//,"Application Fees","applicationfees.jsp",,,
		])	
		
		addmenu(menu=["about3",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"View Book","listbook.jsp",,,
		,"Search Book","viewbook.jsp",,,
		
		])
		
	addmenu(menu=["admission",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","show-menu=Selection","searchmemberforissue.jsp",,
		,"Issue Book","show-menu=Selection","searchmemberfornewissue.jsp",,
		//,"Renewel","show-menu=Selection11","searchmemberforrenewel.jsp",,
		,"Renewel Book","show-menu=Selection11","booksearchforrenewel.jsp",,
		//,"Return","searchmemberforreturn.jsp",,,
		,"Return Book","show-menu=Selection55","booksearchforreturn1.jsp",,
		//,"Return By Book","booksearchforreturn1.jsp",,,
		//,"Lost","searchmemberforlost.jsp",,,
		,"Lost Book","searchnewmemberforlost.jsp",,,
		,"Issue CD","searchmemberforcdissue.jsp",,,
		//,"Return CD","show-menu=Selection66","searchmemberforcdreturn.jsp",,cdsearchforreturn
		,"Return CD","show-menu=Selection66","cdsearchforreturn.jsp",,
		,"Lost CD","searchmemberforcdlost.jsp",,,
		,"Convert to Member","updateapplicants.jsp",,,
		,"Credit Note for Vendor","vendorselectforcreditnote.jsp",,,
		,"Select Books For Approval","selectbooksforapproval.jsp",,,
		,"Generate Purchase Order","generatepurchaseorder.jsp",,,
		,"Member Cancel","searchmemberforcancel.jsp",,,
		])	
		
	addmenu(menu=["Selection",				//ITEM2
		,,135,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","searchmemberforissue.jsp",,,
		,"Issue","searchmemberfornewissue.jsp",,,
		,"Issue Booked Book","bookingsearchforissue.jsp",,,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
		])	
		
		addmenu(menu=["bill",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Bill","show-menu=Select","generatebill.jsp",,
		,"Receipt","show-menu=SelectReceipt","generatereceipt.jsp",,
		,"Subscriber's List Pending Subscription","subscriberlistnotpaidsubscr.jsp",,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
		])	
		
		addmenu(menu=["Select",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatebill.jsp",,,
		,"Cancel","cancelbill.jsp",,,
		,"View/Print","vieworprintbill.jsp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
		])
		
			addmenu(menu=["SelectReceipt",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatereceipt.jsp",,,
		,"Cancel","cancelreceipt.jsp",,,
		,"View/Print","viewprintreceipt.jsp",,,
		])
		
		addmenu(menu=["Selection11",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforrenewel.jsp",,,
		
		,"Search Book","booksearchforrenewel.jsp",,,
		,"Search Member","searchnewmemberforrenewel.jsp",,,
		])
		
		addmenu(menu=["Selection33",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforreturn.jsp",,,
		//,"Search Book","booksearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection55",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		
		,"Search Book","booksearchforreturn1.jsp",,,
		,"Search Member","searchnewmemberforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection66",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforcdreturn.jsp",,,
		,"Search CD","cdsearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Account",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill","show-menu=Account1","searchmemberforbill.jsp",,
		,"Member Receipt","show-menu=Account2","generatereceiptformemberbill.jsp",,
		//,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		])
		
	addmenu(menu=["Account2",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"For Bill","generatereceiptformemberbill.jsp",,,
		,"Direct For Member","searchmemberfordirectmemberreceipt.jsp",,,
		])
		
		addmenu(menu=["Sell",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Sell Book","booksearchforsolditems.jsp",,,
		,"Sell CD","cdsearchforsolditems.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
	addmenu(menu=["Vendor",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Vendor Invoice","vendorsearchforinvoice.jsp",,,
		,"Vendor Payment","vendorpayment1.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
		addmenu(menu=["Reports",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill Report","dateselectforMemberBillReport.jsp",,,
		,"Applicant Report","ApplicantReport.jsp",,,
		,"Club Member Address List","MemberAddressList.jsp",,,
		,"Subscriber Address List","SubscriberAddressList.jsp",,,
		,"Member List","memberlist.jsp",,,
		,"Subscriber Member List","subscribermemberlist.jsp",,,
		,"List of Club Members for billing","memberbillinlist.jsp",,,
		,"Subscriber Members list for penalty","subscribermembers.jsp",,,
		,"Club Members list for penalty","clubmembers.jsp",,,
		,"Monthly Report of Members & Subscribers","dateselectformemandsubsreport.jsp",,,
		,"Monthly Report of Books & VCD's","dateselectforbookvcdreport.jsp",,,
		,"Statement Of Account","dateselectforstatementofaccount.jsp",,,
		,"Member's Library Usage","searchmemberforlibraryusage.jsp",,,
		,"List Of OverDue Books","listofoverduebooks.jsp",,,
		,"Reports for Book/CD/Periodicals","reportsforbookcdperiodicals.jsp",,,
		])
		
		addmenu(menu=["events",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Indira Events Calender","events.asp",,,
		//,"Event Registration","eventregistration.asp",,,
		])

	}
	else
	{
		addmenu(menu=[		// This is the array that contains your menu properties and details
		"mainmenu",			// Menu Name - This is needed in order for the menu to be called
		65,				// Menu Top - The Top position of the menu in pixels
		2,					// Menu Left - The Left position of the menu in pixels
		67,	// Menu Width - Menus width in pixels
		0,					// Menu Border Width 
		,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
		style1,				// Properties Array - this is set higher up, as above
		1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
		"center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
		effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
		,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
		1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
		0,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
		,					// Position of TOP sub image left:center:right
		,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
		,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
		,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
		,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
		,					// Background image for menu when BGColor set to transparent.
		,					// Scrollable Menu
		,					// Reserved for future use
		,"Login","user.htm","","",2
		,"New","show-menu=about","default.jsp","",2
		,"Edit","show-menu=about1","default.jsp","",2
		,"View","show-menu=student","default.jsp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
		,"Transactions","show-menu=admission","default.jsp","",2
		,"Bill","show-menu=bill","default.jsp","",2 
		,"Account","show-menu=Account","default.jsp","",2
		,"Sell","show-menu=Sell","default.jsp","",2
		,"Vendor","show-menu=Vendor","default.jsp","",2
		,"Reports","show-menu=Reports","default.jsp","",2])
		
		
		
		//*************************************ADDING MENU ITEMS**************************************
		/*addmenu(menu=["BookEntry",				//ITEM2
		,,175,,"",style4,,"left",effect,,,,,,,,,,,,
		,"BookEntry","bookentry12345.jsp",,,
		,"Edit BookEntry","updateBookEntry.jsp","",,
		
		])	*/
				addmenu(menu=["about",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		,"BookEntry","enter22.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		,"periodical","periodical.jsp",,,
		//,"Edit Periodical","updateperiodical.jsp",,,
		,"Periodical Subscription","searchperiodicalsubscription.jsp",,,
		,"Local Periodical Purchase","searchlocalperiodicalsubscription.jsp",,,
		,"Member Periodical Subscription","memberperiodicalsubscription.jsp",,,
		,"Member","member.jsp",,,
		,"Applicant","Applicants.jsp",,,
		,"Employee","employee.jsp",,,
		,"Suggestions","suggestions.jsp",,,
		,"Vendor","vendor.jsp",,,
		,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		,"CD","Entercd.jsp",,,
		,"Subscribed Periodical Received","searchperiodicalforreceive.jsp",,,
		,"Member Subscribed Periodical Sent","searchmemberperiodicalforsent.jsp",,,
		,"Enter Books For Selection","enterbooksforselection.jsp",,,
		])	
		
		addmenu(menu=["about1",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"BookEntry","enter21.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		//,"periodical","periodical.jsp",,,
		,"Edit Periodical","updateperiodical.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		,"Edit Employee","updateemployee.jsp",,,
		,"Edit Suggestions","suggestionsearch.jsp",,,
		,"Edit Bookings","updatebooking.jsp",,,
		,"Edit Vendor","updatevendor.jsp",,,
		,"Edit Member","show-menu=about2","listmember.jsp",,
		
		,"Edit Book","editbook.jsp",,,
		])	
		
		addmenu(menu=["about2",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"List Members","listmember.jsp",,,
		,"Search Member","searchmember.jsp",,,
		
		])
		
		addmenu(menu=["student",				//ITEM2
		,,155,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Member","member.jsp",,,
		,"View Book","show-menu=about3","listbook.jsp",,
		,"View Rejected Books","ViewRejectedBook.jsp",,,
		,"View CD","viewCD.jsp",,,
		,"View Member","searchmember.jsp",,,
		//,"parameter","parameter.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		//,"Employee","employee.jsp",,,
		,"View Employee","updateemployee.jsp",,,
		//,"Suggestions","suggestions.jsp",,,
		//,"Edit Suggestions","updatesuggestions.jsp",,,
		,"View Suggestions","suggestionsearch.jsp",,,
		,"BookSearchforBooking","booksearchforbooking.jsp",,,
		//,"Bookings","booking.jsp",,,
		//,"Edit Bookings","updatebooking.jsp",,,
		,"View Bookings","bookingsearch.jsp",,,
		//,"Vendor","vendor.jsp",,,
		,"View Vendor","updatevendor.jsp",,,
		,"View Periodical Receieved","searchperiodical.jsp",,,
		//,"Applicant","Applicants.jsp",,,
		//,"Convert to Member","updateapplicants.jsp",,,
		//,"Application Fees","applicationfees.jsp",,,
		])	
		
		addmenu(menu=["about3",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"View Book","listbook.jsp",,,
		,"Search Book","viewbook.jsp",,,
		
		])
		
	addmenu(menu=["admission",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","show-menu=Selection","searchmemberforissue.jsp",,
		,"Issue Book","show-menu=Selection","searchmemberfornewissue.jsp",,
		//,"Renewel","show-menu=Selection11","searchmemberforrenewel.jsp",,
		,"Renewel Book","show-menu=Selection11","booksearchforrenewel.jsp",,
		//,"Return","searchmemberforreturn.jsp",,,
		,"Return Book","show-menu=Selection55","booksearchforreturn1.jsp",,
		//,"Return By Book","booksearchforreturn1.jsp",,,
		//,"Lost","searchmemberforlost.jsp",,,
		,"Lost Book","searchnewmemberforlost.jsp",,,
		,"Issue CD","searchmemberforcdissue.jsp",,,
		//,"Return CD","show-menu=Selection66","searchmemberforcdreturn.jsp",,cdsearchforreturn
		,"Return CD","show-menu=Selection66","cdsearchforreturn.jsp",,
		,"Lost CD","searchmemberforcdlost.jsp",,,
		,"Convert to Member","updateapplicants.jsp",,,
		,"Credit Note for Vendor","vendorselectforcreditnote.jsp",,,
		,"Select Books For Approval","selectbooksforapproval.jsp",,,
		,"Generate Purchase Order","generatepurchaseorder.jsp",,,
		,"Member Cancel","searchmemberforcancel.jsp",,,
		])	
		
	addmenu(menu=["Selection",				//ITEM2
		,,135,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","searchmemberforissue.jsp",,,
		,"Issue","searchmemberfornewissue.jsp",,,
		,"Issue Booked Book","bookingsearchforissue.jsp",,,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
		])	
		
		addmenu(menu=["bill",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Bill","show-menu=Select","generatebill.jsp",,
		,"Receipt","show-menu=SelectReceipt","generatereceipt.jsp",,
		,"Subscriber's List Pending Subscription","subscriberlistnotpaidsubscr.jsp",,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
		])	
		
		addmenu(menu=["Select",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatebill.jsp",,,
		,"Cancel","cancelbill.jsp",,,
		,"View/Print","vieworprintbill.jsp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
		])
		
			addmenu(menu=["SelectReceipt",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatereceipt.jsp",,,
		,"Cancel","cancelreceipt.jsp",,,
		,"View/Print","viewprintreceipt.jsp",,,
		])
		
		addmenu(menu=["Selection11",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforrenewel.jsp",,,
		
		,"Search Book","booksearchforrenewel.jsp",,,
		,"Search Member","searchnewmemberforrenewel.jsp",,,
		])
		
		addmenu(menu=["Selection33",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforreturn.jsp",,,
		//,"Search Book","booksearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection55",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		
		,"Search Book","booksearchforreturn1.jsp",,,
		,"Search Member","searchnewmemberforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection66",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforcdreturn.jsp",,,
		,"Search CD","cdsearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Account",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill","show-menu=Account1","searchmemberforbill.jsp",,
		,"Member Receipt","show-menu=Account2","generatereceiptformemberbill.jsp",,
		//,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		])
		
	addmenu(menu=["Account2",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"For Bill","generatereceiptformemberbill.jsp",,,
		,"Direct For Member","searchmemberfordirectmemberreceipt.jsp",,,
		])
		
		addmenu(menu=["Sell",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Sell Book","booksearchforsolditems.jsp",,,
		,"Sell CD","cdsearchforsolditems.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
	addmenu(menu=["Vendor",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Vendor Invoice","vendorsearchforinvoice.jsp",,,
		,"Vendor Payment","vendorpayment1.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
		addmenu(menu=["Reports",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill Report","dateselectforMemberBillReport.jsp",,,
		,"Applicant Report","ApplicantReport.jsp",,,
		,"Member Address List","MemberAddressList.jsp",,,
		,"Subscriber Address List","SubscriberAddressList.jsp",,,
		,"Member List","memberlist.jsp",,,
		,"Subscriber Member List","subscribermemberlist.jsp",,,
		,"List of Club Members for billing","memberbillinlist.jsp",,,
		,"Subscriber Members list for penalty","subscribermembers.jsp",,,
		,"Monthly Report of Members & Subscribers","dateselectformemandsubsreport.jsp",,,
		,"Monthly Report of Books & VCD's","dateselectforbookvcdreport.jsp",,,
		,"Statement Of Account","dateselectforstatementofaccount.jsp",,,
		,"Member's Library Usage","searchmemberforlibraryusage.jsp",,,
		,"List Of OverDue Books","listofoverduebooks.jsp",,,
		,"Reports for Book/CD/Periodicals","reportsforbookcdperiodicals.jsp",,,
		])
		
	}
}
//************************************[ENDS]**************************************************

//*****************************[For Resolution 1024 by 768]************************************

if (screen.width == 800)
{
	if (browser.isIE5x)
	{
		
		addmenu(menu=[		// This is the array that contains your menu properties and details
		"mainmenu",			// Menu Name - This is needed in order for the menu to be called
		65,				// Menu Top - The Top position of the menu in pixels
		3,					// Menu Left - The Left position of the menu in pixels
		67,	// Menu Width - Menus width in pixels
		0,					// Menu Border Width 
		,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
		style1,				// Properties Array - this is set higher up, as above
		1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
		"center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
		effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
		,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
		1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
		0,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
		,					// Position of TOP sub image left:center:right
		,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
		,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
		,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
		,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
		,					// Background image for menu when BGColor set to transparent.
		,					// Scrollable Menu
		,					// Reserved for future use
		,"Login","user.htm","","",2
		,"New","show-menu=about","default.jsp","",2
		,"Edit","show-menu=about1","default.jsp","",2
		,"View","show-menu=student","default.jsp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
		,"Transactions","show-menu=admission","default.jsp","",2
		,"Bill","show-menu=bill","default.jsp","",2 
		,"Account","show-menu=Account","default.jsp","",2
		,"Sell","show-menu=Sell","default.jsp","",2
		,"Vendor","show-menu=Vendor","default.jsp","",2
		,"Reports","show-menu=Reports","default.jsp","",2])
		
		
		//*************************************ADDING MENU ITEMS**************************************
		//addmenu(menu=["BookEntry",				//ITEM2
		//,,175,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"BookEntry","bookentry123456.jsp?id=select",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		
		//])	
		addmenu(menu=["about",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		,"BookEntry","enter22.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		,"periodical","periodical.jsp",,,
		//,"Edit Periodical","updateperiodical.jsp",,,
		,"Periodical Subscription","searchperiodicalsubscription.jsp",,,
		,"Local Periodical Purchase","searchlocalperiodicalsubscription.jsp",,,
		,"Member Periodical Subscription","memberperiodicalsubscription.jsp",,,
		,"Member","member.jsp",,,
		,"Applicant","Applicants.jsp",,,
		,"Employee","employee.jsp",,,
		,"Suggestions","suggestions.jsp",,,
		,"Vendor","vendor.jsp",,,
		,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		,"CD","Entercd.jsp",,,
		,"Subscribed Periodical Received","searchperiodicalforreceive.jsp",,,
		,"Member Subscribed Periodical Sent","searchmemberperiodicalforsent.jsp",,,
		,"Enter Books For Selection","enterbooksforselection.jsp",,,
		])	
		
		addmenu(menu=["about1",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"BookEntry","enter21.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		//,"periodical","periodical.jsp",,,
		,"Edit Periodical","updateperiodical.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		,"Edit Employee","updateemployee.jsp",,,
		,"Edit Suggestions","suggestionsearch.jsp",,,
		,"Edit Bookings","updatebooking.jsp",,,
		,"Edit Vendor","updatevendor.jsp",,,
		,"Edit Member","show-menu=about2","listmember.jsp",,
		,"Edit Book","editbook.jsp",,,
		,"Edit Local Periodical Purchase","editlocalperiodicalsubscription1.jsp",,,
		,"Edit Periodical Subscription","editperiodicalsubscription.jsp",,,
		])	
		
		addmenu(menu=["about2",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"List Members","listmember.jsp",,,
		,"Search Member","searchmember.jsp",,,
		
		])
		
				
		addmenu(menu=["student",				//ITEM2
		,,155,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Member","member.jsp",,,
		,"View Book","show-menu=about3","listbook.jsp",,
		,"View Rejected Books","ViewRejectedBook.jsp",,,
		,"View CD","viewCD.jsp",,,
		,"View Member","searchmember.jsp",,,
		//,"parameter","parameter.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		//,"Employee","employee.jsp",,,
		,"View Employee","updateemployee.jsp",,,
		//,"Suggestions","suggestions.jsp",,,
		//,"Edit Suggestions","updatesuggestions.jsp",,,
		,"View Suggestions","suggestionsearch.jsp",,,
		,"BookSearchforBooking","booksearchforbooking.jsp",,,
		//,"Bookings","booking.jsp",,,
		//,"Edit Bookings","updatebooking.jsp",,,
		,"View Bookings","bookingsearch.jsp",,,
		//,"Vendor","vendor.jsp",,,
		,"View Vendor","updatevendor.jsp",,,
		,"View Periodical Receieved","searchperiodical.jsp",,,
		//,"Convert to Member","updateapplicants.jsp",,,
		//,"Application Fees","applicationfees.jsp",,,
		])	
		
		addmenu(menu=["about3",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"View Book","listbook.jsp",,,
		,"Search Book","viewbook.jsp",,,
		
		])
		
	addmenu(menu=["admission",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","show-menu=Selection","searchmemberforissue.jsp",,
		,"Issue Book","show-menu=Selection","searchmemberfornewissue.jsp",,
		//,"Renewel","show-menu=Selection11","searchmemberforrenewel.jsp",,
		,"Renewel Book","show-menu=Selection11","booksearchforrenewel.jsp",,
		//,"Return","searchmemberforreturn.jsp",,,
		,"Return Book","show-menu=Selection55","booksearchforreturn1.jsp",,
		//,"Return By Book","booksearchforreturn1.jsp",,,
		//,"Lost","searchmemberforlost.jsp",,,
		,"Lost Book","searchnewmemberforlost.jsp",,,
		,"Issue CD","searchmemberforcdissue.jsp",,,
		//,"Return CD","show-menu=Selection66","searchmemberforcdreturn.jsp",,cdsearchforreturn
		,"Return CD","show-menu=Selection66","cdsearchforreturn.jsp",,
		,"Lost CD","searchmemberforcdlost.jsp",,,
		,"Convert to Member","updateapplicants.jsp",,,
		,"Credit Note for Vendor","vendorselectforcreditnote.jsp",,,
		,"Select Books For Approval","selectbooksforapproval.jsp",,,
		,"Generate Purchase Order","generatepurchaseorder.jsp",,,
		,"Member Cancel","searchmemberforcancel.jsp",,,
		])	
		
	addmenu(menu=["Selection",				//ITEM2
		,,135,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","searchmemberforissue.jsp",,,
		,"Issue","searchmemberfornewissue.jsp",,,
		,"Issue Booked Book","bookingsearchforissue.jsp",,,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
		])	
		
		addmenu(menu=["bill",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Bill","show-menu=Select","generatebill.jsp",,
		,"Receipt","show-menu=SelectReceipt","generatereceipt.jsp",,
		,"Subscriber's List Pending Subscription","subscriberlistnotpaidsubscr.jsp",,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
		])	
		
		addmenu(menu=["Select",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatebill.jsp",,,
		,"Cancel","cancelbill.jsp",,,
		,"View/Print","vieworprintbill.jsp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
		])
		
			addmenu(menu=["SelectReceipt",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatereceipt.jsp",,,
		,"Cancel","cancelreceipt.jsp",,,
		,"View/Print","viewprintreceipt.jsp",,,
		])
		
		addmenu(menu=["Selection11",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforrenewel.jsp",,,
		
		,"Search Book","booksearchforrenewel.jsp",,,
		,"Search Member","searchnewmemberforrenewel.jsp",,,
		])
		
		addmenu(menu=["Selection33",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforreturn.jsp",,,
		//,"Search Book","booksearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection55",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		
		,"Search Book","booksearchforreturn1.jsp",,,
		,"Search Member","searchnewmemberforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection66",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforcdreturn.jsp",,,
		,"Search CD","cdsearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Account",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill","show-menu=Account1","searchmemberforbill.jsp",,
		,"Member Receipt","show-menu=Account2","generatereceiptformemberbill.jsp",,
		//,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		])
		
	addmenu(menu=["Account2",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"For Bill","generatereceiptformemberbill.jsp",,,
		,"Direct For Member","searchmemberfordirectmemberreceipt.jsp",,,
		])
		
		addmenu(menu=["Sell",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Sell Book","booksearchforsolditems.jsp",,,
		,"Sell CD","cdsearchforsolditems.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
	addmenu(menu=["Vendor",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Vendor Invoice","vendorsearchforinvoice.jsp",,,
		,"Vendor Payment","vendorpayment1.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
		addmenu(menu=["Reports",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill Report","dateselectforMemberBillReport.jsp",,,
		,"Applicant Report","ApplicantReport.jsp",,,
		,"Club Member Address List","MemberAddressList.jsp",,,
		,"Subscriber Address List","SubscriberAddressList.jsp",,,
		,"Member List","memberlist.jsp",,,
		,"Subscriber Member List","subscribermemberlist.jsp",,,
		,"List of Club Members for billing","memberbillinlist.jsp",,,
		,"Subscriber Members list for penalty","subscribermembers.jsp",,,
		,"Club Members list for penalty","clubmembers.jsp",,,
		,"Monthly Report of Members & Subscribers","dateselectformemandsubsreport.jsp",,,
		,"Monthly Report of Books & VCD's","dateselectforbookvcdreport.jsp",,,
		,"Statement Of Account","dateselectforstatementofaccount.jsp",,,
		,"Member's Library Usage","searchmemberforlibraryusage.jsp",,,
		,"List Of OverDue Books","listofoverduebooks.jsp",,,
		,"Reports for Book/CD/Periodicals","reportsforbookcdperiodicals.jsp",,,
		])
		
		addmenu(menu=["events",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Indira Events Calender","events.asp",,,
		//,"Event Registration","eventregistration.asp",,,
		])
			
		
	
	
	}
	else
	{
		
		addmenu(menu=[		// This is the array that contains your menu properties and details
		"mainmenu",			// Menu Name - This is needed in order for the menu to be called
		65,				// Menu Top - The Top position of the menu in pixels
		2,					// Menu Left - The Left position of the menu in pixels
		67,	// Menu Width - Menus width in pixels
		0,					// Menu Border Width 
		,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
		style1,				// Properties Array - this is set higher up, as above
		1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
		"center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
		effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
		,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
		1, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
		0,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
		,					// Position of TOP sub image left:center:right
		,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
		,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
		,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
		,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
		,					// Background image for menu when BGColor set to transparent.
		,					// Scrollable Menu
		,					// Reserved for future use
		,"Login","user.htm","","",2
		,"New","show-menu=about","default.jsp","",2
		,"Edit","show-menu=about1","default.jsp","",2
		,"View","show-menu=student","default.jsp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
		,"Transactions","show-menu=admission","default.jsp","",2
		,"Bill","show-menu=bill","default.jsp","",2 
		,"Account","show-menu=Account","default.jsp","",2
		,"Sell","show-menu=Sell","default.jsp","",2
		,"Vendor","show-menu=Vendor","default.jsp","",2
		,"Reports","show-menu=Reports","default.jsp","",2])
		
		
		
		//*************************************ADDING MENU ITEMS**************************************
		/*addmenu(menu=["BookEntry",				//ITEM2
		,,175,,"",style4,,"left",effect,,,,,,,,,,,,
		,"BookEntry","bookentry12345.jsp",,,
		,"Edit BookEntry","updateBookEntry.jsp","",,
		
		])	*/
				addmenu(menu=["about",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		,"BookEntry","enter22.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		,"periodical","periodical.jsp",,,
		//,"Edit Periodical","updateperiodical.jsp",,,
		,"Periodical Subscription","searchperiodicalsubscription.jsp",,,
		,"Local Periodical Purchase","searchlocalperiodicalsubscription.jsp",,,
		,"Member Periodical Subscription","memberperiodicalsubscription.jsp",,,
		,"Member","member.jsp",,,
		,"Applicant","Applicants.jsp",,,
		,"Employee","employee.jsp",,,
		,"Suggestions","suggestions.jsp",,,
		,"Vendor","vendor.jsp",,,
		,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		,"CD","Entercd.jsp",,,
		,"Subscribed Periodical Received","searchperiodicalforreceive.jsp",,,
		,"Member Subscribed Periodical Sent","searchmemberperiodicalforsent.jsp",,,
		,"Enter Books For Selection","enterbooksforselection.jsp",,,
		])	
		
		addmenu(menu=["about1",				//ITEM2
		,,165,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"BookEntry","enter21.jsp",,,
		//,"Edit BookEntry","updateBookEntry.jsp","",,
		//,"periodical","periodical.jsp",,,
		,"Edit Periodical","updateperiodical.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		,"Edit Employee","updateemployee.jsp",,,
		,"Edit Suggestions","suggestionsearch.jsp",,,
		,"Edit Bookings","updatebooking.jsp",,,
		,"Edit Vendor","updatevendor.jsp",,,
		,"Edit Member","show-menu=about2","listmember.jsp",,
		
		,"Edit Book","editbook.jsp",,,
		])	
		
		addmenu(menu=["about2",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"List Members","listmember.jsp",,,
		,"Search Member","searchmember.jsp",,,
		
		])
		
		addmenu(menu=["student",				//ITEM2
		,,155,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Member","member.jsp",,,
		,"View Book","show-menu=about3","listbook.jsp",,
		,"View Rejected Books","ViewRejectedBook.jsp",,,
		,"View CD","viewCD.jsp",,,
		,"View Member","searchmember.jsp",,,
		//,"parameter","parameter.jsp",,,
		,"View/Edit Parameter","updateparameter.jsp",,,
		//,"Employee","employee.jsp",,,
		,"View Employee","updateemployee.jsp",,,
		//,"Suggestions","suggestions.jsp",,,
		//,"Edit Suggestions","updatesuggestions.jsp",,,
		,"View Suggestions","suggestionsearch.jsp",,,
		,"BookSearchforBooking","booksearchforbooking.jsp",,,
		//,"Bookings","booking.jsp",,,
		//,"Edit Bookings","updatebooking.jsp",,,
		,"View Bookings","bookingsearch.jsp",,,
		//,"Vendor","vendor.jsp",,,
		,"View Vendor","updatevendor.jsp",,,
		,"View Periodical Receieved","searchperiodical.jsp",,,
		//,"Applicant","Applicants.jsp",,,
		//,"Convert to Member","updateapplicants.jsp",,,
		//,"Application Fees","applicationfees.jsp",,,
		])	
		
		addmenu(menu=["about3",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"View Book","listbook.jsp",,,
		,"Search Book","viewbook.jsp",,,
		
		])
		
	addmenu(menu=["admission",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","show-menu=Selection","searchmemberforissue.jsp",,
		,"Issue Book","show-menu=Selection","searchmemberfornewissue.jsp",,
		//,"Renewel","show-menu=Selection11","searchmemberforrenewel.jsp",,
		,"Renewel Book","show-menu=Selection11","booksearchforrenewel.jsp",,
		//,"Return","searchmemberforreturn.jsp",,,
		,"Return Book","show-menu=Selection55","booksearchforreturn1.jsp",,
		//,"Return By Book","booksearchforreturn1.jsp",,,
		//,"Lost","searchmemberforlost.jsp",,,
		,"Lost Book","searchnewmemberforlost.jsp",,,
		,"Issue CD","searchmemberforcdissue.jsp",,,
		//,"Return CD","show-menu=Selection66","searchmemberforcdreturn.jsp",,cdsearchforreturn
		,"Return CD","show-menu=Selection66","cdsearchforreturn.jsp",,
		,"Lost CD","searchmemberforcdlost.jsp",,,
		,"Convert to Member","updateapplicants.jsp",,,
		,"Credit Note for Vendor","vendorselectforcreditnote.jsp",,,
		,"Select Books For Approval","selectbooksforapproval.jsp",,,
		,"Generate Purchase Order","generatepurchaseorder.jsp",,,
		,"Member Cancel","searchmemberforcancel.jsp",,,
		])	
		
	addmenu(menu=["Selection",				//ITEM2
		,,135,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Issue","searchmemberforissue.jsp",,,
		,"Issue","searchmemberfornewissue.jsp",,,
		,"Issue Booked Book","bookingsearchforissue.jsp",,,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
		])	
		
		addmenu(menu=["bill",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Bill","show-menu=Select","generatebill.jsp",,
		,"Receipt","show-menu=SelectReceipt","generatereceipt.jsp",,
		,"Subscriber's List Pending Subscription","subscriberlistnotpaidsubscr.jsp",,
		//,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
		])	
		
		addmenu(menu=["Select",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatebill.jsp",,,
		,"Cancel","cancelbill.jsp",,,
		,"View/Print","vieworprintbill.jsp",,,
		//,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
		])
		
			addmenu(menu=["SelectReceipt",				//ITEM2
		,,125,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Generate","generatereceipt.jsp",,,
		,"Cancel","cancelreceipt.jsp",,,
		,"View/Print","viewprintreceipt.jsp",,,
		])
		
		addmenu(menu=["Selection11",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforrenewel.jsp",,,
		
		,"Search Book","booksearchforrenewel.jsp",,,
		,"Search Member","searchnewmemberforrenewel.jsp",,,
		])
		
		addmenu(menu=["Selection33",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforreturn.jsp",,,
		//,"Search Book","booksearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection55",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		
		,"Search Book","booksearchforreturn1.jsp",,,
		,"Search Member","searchnewmemberforreturn.jsp",,,
		])
		
		addmenu(menu=["Selection66",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		//,"Search Member","searchmemberforcdreturn.jsp",,,
		,"Search CD","cdsearchforreturn.jsp",,,
		])
		
		addmenu(menu=["Account",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill","show-menu=Account1","searchmemberforbill.jsp",,
		,"Member Receipt","show-menu=Account2","generatereceiptformemberbill.jsp",,
		//,"Add Miscellaneousamt","searchmemberformiscellaneousamt.jsp",,,
		])
		
	addmenu(menu=["Account2",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"For Bill","generatereceiptformemberbill.jsp",,,
		,"Direct For Member","searchmemberfordirectmemberreceipt.jsp",,,
		])
		
		addmenu(menu=["Sell",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Sell Book","booksearchforsolditems.jsp",,,
		,"Sell CD","cdsearchforsolditems.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
	addmenu(menu=["Vendor",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Vendor Invoice","vendorsearchforinvoice.jsp",,,
		,"Vendor Payment","vendorpayment1.jsp",,,
		//,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
		])
		
		addmenu(menu=["Reports",				//ITEM2
		,,145,,"",style4,,"left",effect,,,,,,,,,,,,
		,"Member Bill Report","dateselectforMemberBillReport.jsp",,,
		,"Applicant Report","ApplicantReport.jsp",,,
		,"Member Address List","MemberAddressList.jsp",,,
		,"Subscriber Address List","SubscriberAddressList.jsp",,,
		,"Member List","memberlist.jsp",,,
		,"Subscriber Member List","subscribermemberlist.jsp",,,
		,"List of Club Members for billing","memberbillinlist.jsp",,,
		,"Subscriber Members list for penalty","subscribermembers.jsp",,,
		,"Monthly Report of Members & Subscribers","dateselectformemandsubsreport.jsp",,,
		,"Monthly Report of Books & VCD's","dateselectforbookvcdreport.jsp",,,
		,"Statement Of Account","dateselectforstatementofaccount.jsp",,,
		,"Member's Library Usage","searchmemberforlibraryusage.jsp",,,
		,"List Of OverDue Books","listofoverduebooks.jsp",,,
		,"Reports for Book/CD/Periodicals","reportsforbookcdperiodicals.jsp",,,
		])
			
	}
	
}
//************************************[ENDS]**************************************************

if (screen.width == 1152) {

addmenu(menu=[		// This is the array that contains your menu properties and details
"mainmenu",			// Menu Name - This is needed in order for the menu to be called
110,				// Menu Top - The Top position of the menu in pixels
0,					// Menu Left - The Left position of the menu in pixels
screen.width/6.90,	// Menu Width - Menus width in pixels
0,					// Menu Border Width 
,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
style1,				// Properties Array - this is set higher up, as above
1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
"center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
0, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
,					// Position of TOP sub image left:center:right
,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
,					// Background image for menu when BGColor set to transparent.
,					// Scrollable Menu
,					// Reserved for future use
,"Home","index.asp","","",2
,"About Us","show-menu=about","aboutus.asp","",2
,"Student's Life","show-menu=student","studentIntroduction.asp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
,"Admission","show-menu=admission","admissionprocedure_BBA.asp","",2
,"Syllabus","show-menu=course","coursestructureBBA.asp","",2 
,"Achievements","show-menu=achievements","acads.asp","",2
,"Events","events.asp","","",2
,"Faculty","show-menu=Faculty","faculty_BBA.asp","",2
,"Contact Us","contactus.asp","","",2])

	
//*************************************ADDING MENU ITEMS**************************************
addmenu(menu=["about",				//ITEM2
,,165,,"",style4,,"left",effect,,,,,,,,,,,,
,"Chairman's Message","chairmensmessage.asp",,,
,"Our Philosophy","vision.asp","",,
,"BBA","show-menu=bba","bba.asp",,
,"Indira College Of Science","show-menu=science","indiraScience.asp",,
,"Indira College Of Commerce","show-menu=commerce","indiraCommerce.asp",,
])	

addmenu(menu=["student",				//ITEM2
,,155,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","studentIntroduction.asp",,,
,"Housing/Transportation","housing.asp",,,
,"Campus Facilities","campus.asp",,,
,"Library Services","libraryServices.asp",,,
,"Student Council","studentCouncil.asp",,,
])	
	
addmenu(menu=["admission",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Selection Procedure&nbsp","show-menu=Selection","admissionprocedure_BBA.asp",,
,"Apply","onlineApplication.asp",,,
])	

addmenu(menu=["Selection",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCA.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
])	

addmenu(menu=["course",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBca.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
])	

addmenu(menu=["faculty",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_Bca.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_Bcs.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
])

addmenu(menu=["achievements",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"Academics","acads.asp",,,
,"Sports","sports.asp",,,
,"Extra-Curricular","curricular.asp",,,
])

addmenu(menu=["science",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","indiraScience.asp",,,
,"Co-ordinator's message","coordinatormessage_science.asp",,,
])

addmenu(menu=["commerce",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","indiraCommerce.asp",,,
,"Co-ordinator's message","coordinatormessage_commerce.asp",,,
])

addmenu(menu=["bba",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","bba.asp",,,
,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
])

addmenu(menu=["events",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Indira Events Calender","events.asp",,,
,"Event Registration","eventregistration.asp",,,
])


}
//************************************[ENDS]**************************************************

//**************************** [For Resolution 1280]******************************************

if (screen.width == 1280) {

addmenu(menu=[		// This is the array that contains your menu properties and details
"mainmenu",			// Menu Name - This is needed in order for the menu to be called
110,				// Menu Top - The Top position of the menu in pixels
0,					// Menu Left - The Left position of the menu in pixels
screen.width/6.90,	// Menu Width - Menus width in pixels
0,					// Menu Border Width 
,					// Screen Position - here you can use "center;left;right;middle;top;bottom" or a combination of "center:middle"
style1,				// Properties Array - this is set higher up, as above
1,					// Always Visible - allows the menu item to be visible at all time (1=on/0=off)
"center",			// Alignment - sets the menu elements text alignment, values valid here are: left, right or center
effect,				// Filter - Text variable for setting transitional effects on menu activation - see above for more info
,					// Follow Scrolling - Tells the menu item to follow the user down the screen (visible at all times) (1=on/0=off)
0, 					// Horizontal Menu - Tells the menu to become horizontal instead of top to bottom style (1=on/0=off)
,					// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page (1=on/0=off)
,					// Position of TOP sub image left:center:right
,					// Set the Overall Width of Horizontal Menu to 100% and height to the specified amount (Leave blank to disable)
,					// Right To Left - Used in Hebrew for example. (1=on/0=off)
,					// Open the Menus OnClick - leave blank for OnMouseover (1=on/0=off)
,					// ID of the div you want to hide on MouseOver (useful for hiding form elements)
,					// Background image for menu when BGColor set to transparent.
,					// Scrollable Menu
,					// Reserved for future use
,"Home","index.asp","","",2
,"About Us","show-menu=about","aboutus.asp","",2
,"Student's Life","show-menu=student","studentIntroduction.asp","",2 // "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
,"Admission","show-menu=admission","admissionprocedure_BBA.asp","",2
,"Syllabus","show-menu=course","coursestructureBBA.asp","",2 
,"Achievements","show-menu=achievements","acads.asp","",2
,"Events","events.asp","","",2
,"Faculty","show-menu=Faculty","faculty_BBA.asp","",2
,"Contact Us","contactus.asp","","",2])

	
//*************************************ADDING MENU ITEMS**************************************
addmenu(menu=["about",				//ITEM2
,,165,,"",style4,,"left",effect,,,,,,,,,,,,
,"Chairman's Message","chairmensmessage.asp",,,
,"Our Philosophy","vision.asp","",,
,"BBA","show-menu=bba","bba.asp",,
,"Indira College Of Science","show-menu=science","indiraScience.asp",,
,"Indira College Of Commerce","show-menu=commerce","indiraCommerce.asp",,
])	

addmenu(menu=["student",				//ITEM2
,,155,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","studentIntroduction.asp",,,
,"Housing/Transportation","housing.asp",,,
,"Campus Facilities","campus.asp",,,
,"Library Services","libraryServices.asp",,,
,"Student Council","studentCouncil.asp",,,
])	
	
addmenu(menu=["admission",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Selection Procedure&nbsp","show-menu=Selection","admissionprocedure_BBA.asp",,
,"Apply","onlineApplication.asp",,,
])	

addmenu(menu=["Selection",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCA.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCS.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","admissionprocedure_BCom.asp",,,
])	

addmenu(menu=["course",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBca.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBcs.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","coursestructureBCom.asp",,,
])	

addmenu(menu=["faculty",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"BBA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BBA.asp",,,
,"BCA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_Bca.asp",,,
,"BCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_Bcs.asp",,,
,"B.Com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","faculty_BCom.asp",,,
])

addmenu(menu=["achievements",				//ITEM2
,,125,,"",style4,,"left",effect,,,,,,,,,,,,
,"Academics","acads.asp",,,
,"Sports","sports.asp",,,
,"Extra-Curricular","curricular.asp",,,
])

addmenu(menu=["science",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","indiraScience.asp",,,
,"Co-ordinator's message","coordinatormessage_science.asp",,,
])

addmenu(menu=["commerce",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","indiraCommerce.asp",,,
,"Co-ordinator's message","coordinatormessage_commerce.asp",,,
])

addmenu(menu=["bba",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Introduction","bba.asp",,,
,"Co-ordinator's message","coordinatormessage_BBA.asp",,,
])

addmenu(menu=["events",				//ITEM2
,,145,,"",style4,,"left",effect,,,,,,,,,,,,
,"Indira Events Calender","events.asp",,,
,"Event Registration","eventregistration.asp",,,
])


}
//************************************[ENDS]**************************************************


	dumpmenus()
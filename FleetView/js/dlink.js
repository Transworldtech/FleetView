/*
  -------------------------------------------------------------------------
		                Direct Link script 
                           Version 1.0
                    Part of the JavaScript Coder software
					
	Copyright 2003 JavaScript-coder.com. All rights reserved.
    This javascript code is installed as part of JavaScript Coder software.
	You may adapt this script for your Web pages, provided these opening credit
    lines (down to the lower dividing line) are kept intact.
    You may not reprint or redistribute this code without permission from 
    JavaScript-Coder.com.
	
	JavaScript Coder
	It precisely codes what you imagine!
	Grab your copy here:
		http://www.javascript-coder.com/
    -------------------------------------------------------------------------  
*/
function DLinkCombo(linkobjname)
{
	if(!linkobjname)
	{
		alert("ERROR! the DLink object does not exist!");
	}
	this.linkobj = linkobjname;
	this.addLink = add_link_combo;
	this.linkobj.onchange =on_change_combo
	this.linkarray =new Array();
}
function add_link_combo(index,strLink,strTarget)
{
  this.linkobj.options[index].dlink = strLink;
  this.linkobj.options[index].dtarget = (strTarget.length==0)?"_self":strTarget;
}
function on_change_combo()
{
	window.open(this.options[this.selectedIndex].dlink,this.options[this.selectedIndex].dtarget);
}
/*
	Copyright 2003 JavaScript-coder.com. All rights reserved.
*/
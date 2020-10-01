// Browser Detect Lite  v2.1.4
/* Author	: C.R.Bineesh
   Date		:24 July 2003
   Type		:Library File
   Output	:This file contains javascript function  for browser detection running under various operating systems and preloading of images.
*/
	
 

//Browser Detection Code

function BrowserDetectLite() {
   var ua = navigator.userAgent.toLowerCase(); 
	alert(ua);
   // browser name
   this.isGecko     = (ua.indexOf('gecko') != -1 && ua.indexOf('safari') == -1);
   this.isMozilla   = (this.isGecko && ua.indexOf('gecko/') + 14 == ua.length);
   this.isNS        = ( (this.isGecko) ? (ua.indexOf('netscape') != -1) : ( (ua.indexOf('mozilla') != -1) && (ua.indexOf('spoofer') == -1) && (ua.indexOf('compatible') == -1) && (ua.indexOf('opera') == -1) && (ua.indexOf('webtv') == -1) && (ua.indexOf('hotjava') == -1) ) );
   this.isIE        = ( (ua.indexOf('msie') != -1) && (ua.indexOf('opera') == -1) && (ua.indexOf('webtv') == -1) ); 
   this.isSafari    = (ua.indexOf('safari') != - 1);
   this.isOpera     = (ua.indexOf('opera') != -1); 
   this.isKonqueror = (ua.indexOf('konqueror') != -1 && !this.isSafari); 
   this.isIcab      = (ua.indexOf('icab') != -1); 
   this.isAol       = (ua.indexOf('aol') != -1); 
   
   // spoofing and compatible browsers
   this.isIECompatible = ( (ua.indexOf('msie') != -1) && !this.isIE);
   this.isNSCompatible = ( (ua.indexOf('mozilla') != -1) && !this.isNS && !this.isMozilla);
   
   // browser version
   this.versionMinor = parseFloat(navigator.appVersion); 
   
   // correct version number
   if (this.isNS && this.isGecko) {
      this.versionMinor = parseFloat( ua.substring( ua.lastIndexOf('/') + 1 ) );
   }
   else if (this.isIE && this.versionMinor >= 4) {
      this.versionMinor = parseFloat( ua.substring( ua.indexOf('msie ') + 5 ) );
   }
   else if (this.isMozilla) {
      this.versionMinor = parseFloat( ua.substring( ua.indexOf('rv:') + 3 ) );
   }
   else if (this.isSafari) {
      this.versionMinor = parseFloat( ua.substring( ua.lastIndexOf('/') + 1 ) );
   }
   else if (this.isOpera) {
      if (ua.indexOf('opera/') != -1) {
         this.versionMinor = parseFloat( ua.substring( ua.indexOf('opera/') + 6 ) );
      }
      else {
         this.versionMinor = parseFloat( ua.substring( ua.indexOf('opera ') + 6 ) );
      }
   }
   else if (this.isKonqueror) {
      this.versionMinor = parseFloat( ua.substring( ua.indexOf('konqueror/') + 10 ) );
   }
   else if (this.isIcab) {
      if (ua.indexOf('icab/') != -1) {
         this.versionMinor = parseFloat( ua.substring( ua.indexOf('icab/') + 6 ) );
      }
      else {
         this.versionMinor = parseFloat( ua.substring( ua.indexOf('icab ') + 6 ) );
      }
   }
   
   this.versionMajor = parseInt(this.versionMinor); 
   this.geckoVersion = ( (this.isGecko) ? ua.substring( (ua.lastIndexOf('gecko/') + 6), (ua.lastIndexOf('gecko/') + 14) ) : -1 );
   
   // dom support
   this.isDOM1 = (document.getElementById);
   this.isDOM2Event = (document.addEventListener && document.removeEventListener);
   
   // css compatibility mode
   this.mode = document.compatMode ? document.compatMode : 'BackCompat';

   // platform
   this.isWin   = (ua.indexOf('win') != -1);
   this.isWin32 = (this.isWin && ( ua.indexOf('95') != -1 || ua.indexOf('98') != -1 || ua.indexOf('nt') != -1 || ua.indexOf('win32') != -1 || ua.indexOf('32bit') != -1 || ua.indexOf('xp') != -1) );
   this.isMac   = (ua.indexOf('mac') != -1);
   this.isUnix  = (ua.indexOf('unix') != -1 || ua.indexOf('sunos') != -1 || ua.indexOf('bsd') != -1 || ua.indexOf('x11') != -1)
   this.isLinux = (ua.indexOf('linux') != -1);
   
   // specific browser shortcuts
   this.isNS4x = (this.isNS && this.versionMajor == 4);
   this.isNS40x = (this.isNS4x && this.versionMinor < 4.5);
   this.isNS47x = (this.isNS4x && this.versionMinor >= 4.7);
   this.isNS4up = (this.isNS && this.versionMinor >= 4);
   this.isNS6x = (this.isNS && this.versionMajor == 6);
   this.isNS6up = (this.isNS && this.versionMajor >= 6);
   this.isNS7x = (this.isNS && this.versionMajor == 7);
   this.isNS7up = (this.isNS && this.versionMajor >= 7);
   
   this.isIE4x = (this.isIE && this.versionMajor == 4);
   this.isIE4up = (this.isIE && this.versionMajor >= 4);
   this.isIE5x = (this.isIE && this.versionMajor == 5);
   this.isIE55 = (this.isIE && this.versionMinor == 5.5);
   this.isIE5up = (this.isIE && this.versionMajor >= 5);
   this.isIE6x = (this.isIE && this.versionMajor == 6);
   this.isIE6up = (this.isIE && this.versionMajor >= 6);
   
   this.isIE4xMac = (this.isIE4x && this.isMac);
}
var browser = new BrowserDetectLite();



//Functions for preloading images for mouse effects
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


//Preloading all menu images.The images specified in the below given list will be preloaded all will be available for mouse over effects
MM_preloadImages('Images/menu_KIDS.gif','Images/menu_OR.gif','Images/menu_PARENTS.gif','Images/menu_EDUCATORS.gif','Images/menu_CLIENTS.gif','Images/menu_or.gif','Images/menu_or_white.gif')

// Function for opening new window
function openWindow(url,name,width,height){
    var options = "width=" + width + ",height=" + height + "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no";
    new_window = window.open(url, name, options);
    window.self.name = "main";
    new_window.focus();
}


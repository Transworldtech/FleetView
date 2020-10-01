/*
'<Comment>
'<Copyright>
' TeraGenomics Version 1.0
' (c) IMC Inc. 2003 All Rights Reserved
' This program can not be copied, modified or manipulated without the express
' written permission from Information Management Consultants Inc.
'</Copyright>
'<Purpose>
'</Purpose>
'<Author>Information Management Consultants Inc.</Author>
'<Date>01/01/2003</Date>
'</Comment>
*/

var flgLostFocus=''; 
var isNav, isIE;
var changedElements = 0;
var openedWindow = null;
var dataSheetBGRowColor = "#eff6ff";

if( parseInt(navigator.appVersion) >= 4 ) {
  if (navigator.appName == "Netscape") {
    isNav = true; isIE = false;
  } else {
    isIE = true; isNav = false;
  }
}

for( var i=0; i<document.styleSheets.length; i++ ) {
  if ( document.styleSheets[i].title == "IE" && isIE ) {
    document.styleSheets[i].disabled = false;
  } else if( document.styleSheets[i].title == "NAV" && isNav ) {
    document.styleSheets[i].disabled = false;
  } else if( document.styleSheets[i].title ) {
    document.styleSheets[i].disabled = true;
  }
}

function saveAlert(formObj, destinationURL, targetLocation, selectObj) {
  var i, j;
  var hasChanged = false;
  
  for( i=0; i<formObj.elements.length; i++ ) {
    switch (formObj.elements[i].type) {
      case 'select-one':
        for( j=0; j<formObj.elements[i].options.length; j++ ) {
          if( formObj.elements[i].options[j].defaultSelected &&
            ( formObj.elements[i].options[j].defaultSelected != formObj.elements[i].options[j].selected )) {
            hasChanged = true;
          }
        }
        break;
      default:
        if( formObj.elements[i].defaultValue != formObj.elements[i].value ) {
          hasChanged = true;
        }
    }
    if( hasChanged ) { break; }
  }

  if( hasChanged ) {
    if( confirm("You have changed some of the Metadata and have not saved it. Would you like to continue without saving?")) {
      targetLocation.location.href = destinationURL;
      if( selectObj.tagName == "SELECT" ) {
        for( i=0; i<selectObj.options.length; i++) {
          if( selectObj.options[i].selected ) {
            selectObj.options[i].defaultSelected = true;
          }
        }
      }
    } else if( selectObj.tagName == "SELECT" ) {
      for( i=0; i<selectObj.options.length; i++) {
        if( selectObj.options[i].defaultSelected ) {
          selectObj.options[i].selected = true;
        }
      }
    }
  } else {
    targetLocation.location.href = destinationURL;
    if( selectObj.tagName == "SELECT" ) {
      for( i=0; i<selectObj.options.length; i++) {
        if( selectObj.options[i].selected ) {
          selectObj.options[i].defaultSelected = true;
        }
      }
    }
  }
}

function openWindow(url,winName)
{
  var popup, widgets;

  switch(winName) {
    case 'help':
      widgets = "scrollbars,resizable,width=600,height=350";
      break;
    case 'loadFiles':
      widgets = "width=580,height=400";
      break;
    case 'Folders':
      widgets = "scrollbars,resizable,width=580,height=400";
      break;
    case 'MdataPopup':
      widgets = "scrollbars,resizable,width=580,height=750";
      break;
    case 'MetadataPopup':
      widgets = "scrollbars,resizable,width=580,height=750";
      break;
    case 'expBl':
      widgets = "width=900,height=400";
      break;
    case 'cellInfo':
      widgets = "scrollbars,resizable,width=850,height=700";
      break;
    case 'demo':
      widgets = "scrollbars,width=650,height=525";
      break;
    case 'saveSession':
      widgets = "scrollbars,width=600,height=500";
      break;
    case 'geneDesc':
      widgets = "scrollbars,resizable";
      break;
    case 'AddRemoveMedia':
      widgets = "scrollbars,width=1000,height=700";
      break;
    case 'AssociateFile':
      widgets = "scrollbars,width=700,height=500";
      break;
    case 'PubExperiments':
      widgets = "scrollbars,width=1050,height=700,resizable=yes";
      break;      
  }
  popup = window.open(url,winName,widgets);
  popup.focus();
  popup.moveTo(10,10);
  openedWindow = popup;
}

function metadataValidityCheck (formObj)
{
  var errorText = '';
  var error = false;
  var firstErrorObj;
  
  for( var i=0; i<formObj.elements.length; i++ ) {
    switch (formObj.elements[i].type) {
      case 'select-one':
        if( formObj.elements[i].options[formObj.elements[i].selectedIndex].value < 0 ) {
          errorText += "A valid selection is required for the '" + formObj.elements[i].name + "' field.\n";
          error = true;
          if( firstErrorObj == null ) firstErrorObj = formObj.elements[i];
        }
        break;
      default:
        if ((formObj.elements[i].name == "personalProjectFolders") || 
            (formObj.elements[i].name == "publicProjectFolders")) {
          break;
        }
        if( formObj.elements[i].value.length < 1 ) {
          errorText += "A value is required for the '" + formObj.elements[i].name + "' field.\n";
          error = true;
          if( firstErrorObj == null ) firstErrorObj = formObj.elements[i];
        }
        break;
    }
  }
  
  if( error ) {
    alert(errorText);
    if (firstErrorObj.name.indexOf("ProjectFolders") == -1 ){ firstErrorObj.focus(); }
  } else {
    formObj.submit();
  }
}

function checkUncheckAll (obj,checkedValue)
{
  if (obj == undefined) return; //if there are no rows with enabled checkboxes then return without processing further.
  if( obj.length ) {
    for( var i = 0; i < obj.length; i++ ) {
      obj[i].checked = checkedValue;
      if( obj[i].form.elements['_' + obj[i].name] )
        obj[i].form.elements['_' + obj[i].name][i].value = checkedValue;
    }
    if(obj[0].name == 'cmpFiles' || obj[0].name == 'viewFiles') adjustFileNumberCount(obj[0].form); //updates the chipcount on Filter Page when select/unselect all is clicked.
    if( obj[0] && obj[0].name == 'cmpFiles' && checkedValue ) {
      checkUncheckAll( obj[0].form.elements['viewFiles'], true );
      obj[0].form.elements['viewFilesMaster'].checked = true;
    } else if( obj[0] && obj[0].name == 'viewFiles' && !checkedValue ) {
      checkUncheckAll( obj[0].form.elements['cmpFiles'], false );
      obj[0].form.elements['cmpFilesMaster'].checked = false;
    }
  } else {
    obj.checked = checkedValue;
    if( obj.form.elements['_' + obj.name] )
      obj.form.elements['_' + obj.name].value = checkedValue;
    
	if(obj.name == 'cmpFiles' || obj.name == 'viewFiles') adjustFileNumberCount(obj.form); //updates the chipcount on Filter Page when select/unselect all is clicked.
    if( obj && obj.name == 'cmpFiles' && checkedValue ) {
      checkUncheckAll( obj.form.elements['viewFiles'], true );
      obj.form.elements['viewFilesMaster'].checked = true;
    } else if( obj && obj.name == 'viewFiles' && !checkedValue ) {
      checkUncheckAll( obj.form.elements['cmpFiles'], false );
      obj.form.elements['cmpFilesMaster'].checked = false;
    }
  }
}

function saveValue(obj,objName)
{
  var item, i, index, intIndexToBeFound;

  if(obj.form.elements[objName].length) {
    if(obj.aIndex){
      intIndexToBeFound = obj.aIndex;
      for( i=0; i < obj.form.elements[objName].length; i++ ) 
      {
        if( obj.form.elements[objName][i].aIndex == intIndexToBeFound )
        {
          index = i;      
          break; 
        }
      }
      item = obj.form.elements['_' + objName][index];
    }else{
      for( i=0; i<obj.form.elements[objName].length; i++ ) {
        if( obj.form.elements[objName][i] == obj ) { index = i; break; }
      }
      item = obj.form.elements['_' + objName][index];
    }
  } else {
    item = obj.form.elements['_' + objName];
    index=-1;
  }
  switch (obj.type) {
    case "checkbox":
      item.value = obj.checked;
      break;
    case "select-one":
      item.value = obj.options[obj.selectedIndex].text;
      break;
    default:
      item.value = obj.value;
  }
  if( obj.form.elements[objName + 'Master'] && !obj.checked )
    obj.form.elements[objName + 'Master'].checked = false;
}

function setNumbers()
{
  //this check is made to ensure that the function exists..
  //if it exists check its return value..
  //if the return value is false, just exit the function
  if((typeof(overwriteFileCount)).toString().toLowerCase()=='function'){
  if(!overwriteFileCount()) return;
  }
  var i,formObj,numberOfChips;
  formObj = null;
  for( i = 0; i < document.forms.length; i++ ) {
    if( !(document.forms[i]) || !(document.forms[i].elements['exportItems']) )
      continue;
    else {
      formObj = document.forms[i];
      break;
    }
  }
  numberOfChips=0;
  if( formObj == null ) return;
  if(formObj.elements['exportItems'].length){
  for(i=0;i<formObj.elements['exportItems'].length;i++){
    if(formObj.elements['cmpFiles'][i].checked && !formObj.elements['cmpFiles'][i].disabled)
      numberOfChips++;
  }
  }else{
    if(formObj.elements['cmpFiles'].checked && !formObj.elements['cmpFiles'].disabled) numberOfChips = 1;
  }
  
  // set the numbers in the filters box
  if( formObj.elements['fileNumber1'] ) {
    for( i=1; formObj.elements['fileNumber' + i]; i++ ) {
      formObj.elements['fileNumber' + i].value = numberOfChips;
    }
  } else if( formObj.elements['NDfileNumber1'] ) {
    for( i=1; formObj.elements['NDfileNumber' + i]; i++ ) {
      formObj.elements['NDfileNumber' + i].value = numberOfChips;
    }
    for( i=1; formObj.elements['NfileNumber' + i]; i++ ) {
      formObj.elements['NfileNumber' + i].value = numberOfChips;
    }
    for( i=1; formObj.elements['DfileNumber' + i]; i++ ) {
      formObj.elements['DfileNumber' + i].value = numberOfChips;
    }
  }
}

function changeOrderNumbers(formElObj,elementName)
{
  var i, newNumberValue, oldNumberValue, oldObjCorr, objLength, index;
  var newObj = formElObj.form.elements[elementName];
  var oldObj = formElObj.form.elements["_" + elementName];
  if( newObj[0] ) {
    for( i=0; i<newObj.length; i++ ) { if( newObj[i] == formElObj ) index = i; }
    
    oldObjCorr = oldObj[index];
    objLength = newObj.length;
  } else {
    oldObjCorr = oldObj;
    objLength = 0;
  }
  newNumberValue = new Number( formElObj.options[formElObj.selectedIndex].text );
  oldNumberValue = new Number( oldObjCorr.value );
  if( newNumberValue < oldNumberValue ) {
    for( i = 0; i < objLength; i++ ) {
      if( i == index ) continue;
      if( newObj[i].options[newObj[i].selectedIndex].text >= newNumberValue && newObj[i].options[newObj[i].selectedIndex].text <= oldNumberValue ) {
        newObj[i].selectedIndex++;
        oldObj[i].value = newObj[i].options[newObj[i].selectedIndex].text;
      }
    }
  } else {
    for( i = 0; i < objLength; i++ ) {
      if( i == index ) continue;
      if( newObj[i].options[newObj[i].selectedIndex].text >= oldNumberValue && newObj[i].options[newObj[i].selectedIndex].text <= newNumberValue ) {
        newObj[i].selectedIndex--;
        oldObj[i].value = newObj[i].options[newObj[i].selectedIndex].text;
      }
    }
  }
  saveValue(formElObj,elementName);
  sortColumnAutomatic(formElObj,changeOrderNumbers.arguments);
}

function filterViewCheckbox (obj,objName)
{
  var index, i;
    
  if( obj.form.elements[objName].length ) {
    for( i=0; i<obj.form.elements[objName].length; i++ ) { if( obj.form.elements[objName][i] == obj ) index = i; }

    if( objName == 'cmpFiles' && obj.checked ) {
      obj.form.elements['viewFiles'][index].checked = true;
      saveValue( obj.form.elements['viewFiles'][index], 'viewFiles' );
      adjustFileNumberCount( obj.form );
    } else if( objName == 'viewFiles' && !obj.checked ) {
      obj.form.elements['cmpFiles'][index].checked = false;
      saveValue( obj.form.elements['cmpFiles'][index], 'cmpFiles' );
      adjustFileNumberCount( obj.form );
    } else if( objName == 'cmpFiles' ) {
      adjustFileNumberCount( obj.form );
    }
  } else {
    if( objName == 'cmpFiles' && obj.checked ) {
      obj.form.elements['viewFiles'].checked = true;
      saveValue( obj.form.elements['viewFiles'], 'viewFiles' );
      adjustFileNumberCount( obj.form );
    } else if( objName == 'viewFiles' && !obj.checked ) {
      obj.form.elements['cmpFiles'].checked = false;
      saveValue( obj.form.elements['cmpFiles'], 'cmpFiles' );
      adjustFileNumberCount( obj.form );
    } else if( objName == 'cmpFiles' ) {
      adjustFileNumberCount( obj.form );
    }
  }
  saveValue(obj,objName);
}

function adjustFileNumberCount (formObj)
{
  var filterBoxes = formObj.elements['cmpFiles'];
  var numChecked = 0;
  
  //get count of checked boxes;
  if( filterBoxes.length ) {
    for( var i = 0; i < filterBoxes.length; i++ ) {
      if( filterBoxes[i].checked ) numChecked++;
    }
  } else {
    if( filterBoxes.checked ) numChecked++;
  }
    

  // set the numbers in the filters box
  i = 1;
  if( formObj.elements['fileNumber' + i] ) {
    while( formObj.elements['fileNumber' + i] ) {
      formObj.elements['fileNumber' + i].value = numChecked;
      i++;
    }
  } else if( formObj.elements['NDfileNumber' + i] ) {
    while( formObj.elements['NDfileNumber' + i] ) {
      formObj.elements['NDfileNumber' + i].value = numChecked;
      i++;
    }
    i=1;
    while( formObj.elements['NfileNumber' + i] ) {
      formObj.elements['NfileNumber' + i].value = numChecked;
      i++;
    }
    i=1;
    while( formObj.elements['DfileNumber' + i] ) {
      formObj.elements['DfileNumber' + i].value = numChecked;
      i++;
    }
  }
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function resetValue (formObj)
{
  if( formObj.type == "text")
    formObj.value = formObj.defaultValue;
  else if( formObj.type == "select-one")
    formObj.options[0].selected = true;
}

function clearQuery (formObj) {
  //Instead of clearing all the controls, we now have to reload the page,
  //so as to remove the "Save Query" Link and the also the result set...
  if(formObj.elements['whereclause']){
    self.location="query_selectChips.asp?qmode=2&hideMsg=true";
  }else{
    self.location="query_selectChips.asp?qmode=1&hideMsg=true";
  }
}

function writeValue (formObj,opString,isButton)
{
  var queryObj, formItem;
  var oTBox;

  if( isButton )
    formItem = formObj;
  else
    formItem = formObj.form;

  if( !formItem.elements['whereclause'] ) return;

  queryObj = formItem.elements['whereclause'];

  switch (formObj.type) {
    case "select-one":
      if( formObj.selectedIndex == formObj.defaultSelected ) break;
      if (formObj.name.length>5 && formObj.name.substr(formObj.name.length-4,4).toUpperCase()=='YEAR'){
        queryObj.value += "extract(year from "+formObj.name.substr(0,formObj.name.length-4)+"date) ='" + formObj.options[formObj.selectedIndex].value + "' ";
        break;
      }else if(formObj.name.length>6 && formObj.name.substr(formObj.name.length-5,5).toUpperCase()=='MONTH'){
        queryObj.value += "extract(month from "+formObj.name.substr(0,formObj.name.length-5)+"date) ='" + formObj.options[formObj.selectedIndex].value + "' ";
        break;
      }else if(formObj.name.length>4 && formObj.name.substr(formObj.name.length-3,3).toUpperCase()=='DAY'){
        queryObj.value += "extract(day from "+formObj.name.substr(0,formObj.name.length-3)+"date) ='" + formObj.options[formObj.selectedIndex].value + "' ";
        break;
      }else if(formObj.name.length>=10 && formObj.name.substr(formObj.name.length-9,9).toUpperCase()=='MEASUREID'){
        if(arguments.length>3){
          oTBox=formObj.form[arguments[3]];
          queryObj.value += ' (';
          writeValue(oTBox,opString);
        }
        queryObj.value += ' AND '+ formObj.name + "='" + formObj.options[formObj.selectedIndex].value + "' ";
        if(arguments.length>3){
          queryObj.value += ') ';
        }
        oTBox.focus();
        break;
      }else if(formObj.name.substr(formObj.name.length-7,7).toUpperCase()=='MEASURE'){
        if(arguments.length>3){
          oTBox=formObj.form[arguments[3]];
          queryObj.value += ' (';
          writeValue(oTBox,opString);
        }
        queryObj.value += ' AND '+ formObj.name + "='" + formObj.options[formObj.selectedIndex].text + "' ";
        if(arguments.length>3){
          queryObj.value += ') ';
        }
        oTBox.focus();
        break;
      }else{
        switch (formObj.name) {
          case "pubfldr":
          case "prjfldr":
          case "perfldr":
            queryObj.value += " cellid in (sel cellid from vfolderchips where folderid = " + formObj.options[formObj.selectedIndex].value + ") ";
            break;
          case "genus":
            queryObj.value += formObj.name + " like '" + formObj.options[formObj.selectedIndex].text + "%' ";
            break;
          case "species":
            queryObj.value += formObj.name + " like '" + formObj.options[formObj.selectedIndex].text.replace(/ /g, ' » ') + "%' ";
            break;
          case "AAT":
            queryObj.value += formObj.options[formObj.selectedIndex].value + " = 1 ";
            break;
          default:
            queryObj.value += formObj.name + "='" + formObj.options[formObj.selectedIndex].text + "' ";
        }
      }
      break;
      case "text":
        if( formObj.value == formObj.defaultValue ) break;
        switch (opString) {
          case "string":
            formObj.value = formObj.value.replace(/\'/g, "''")
            formObj.value = formObj.value.replace(/\*/g, "%")
            queryObj.value += formObj.name + " like '" + formObj.value + (formObj.value.charAt(formObj.value.length-1)=='%','','%')+ "' ";
            break;
          case "num":
  
          
            switch (formObj.name.toUpperCase())
            {
              case "SF":
              case "PCTP":
              case "PCTRP":
              case "PCTM":
              case "GAPDH":
              case "ACTIN":
              case "RAWQ":
              case "AVGBACKGROUND":
              case "BACKGROUND":
                   formObj.value = formObj.value.replace(/\ /g, "") //Remove spaces from number (if any)
                       var numLen = formObj.value.length;
                       var dotPos = formObj.value.indexOf(".");
                       if (dotPos<0) {dotPos=numLen;} else {dotPos++;}
                       queryObj.value += "cast(" + formObj.name + " as decimal(9," + (numLen-dotPos) + "))" + "=" + formObj.value + " ";
                       break;
                  default:
                       queryObj.value += formObj.name + " = " + formObj.value + " ";
            }
        }
        break;
      default:
        queryObj.value += opString + " ";
    }

  resetValue(formObj);
}

function getAnalysisType (dataSet)
{
  var i, algorithm;

  algorithm = "";

  if (dataSet.length) {
    for( i=0; i < dataSet.length; i++ ) {
      if( !dataSet[i].checked ) continue;
      algorithm = dataSet[i].AAT;
      if (algorithm.length > 0) break;
    }
  } else if( dataSet.checked ) {
    algorithm = dataSet.AAT;
  }
  return algorithm;
}

function checkChipType (formObj, isAbsolute, formElName, formElName2, isRMA)
{
  var isDifferent = false;
  var isDifferentAmpRounds = false;
  var i, dataSet, dataSet2, chipType, AmpRounds, storedChipType, storedAmpRounds, algorithm, storedAlgorithm;

  if (isRMA) { isRMA = true; }
  else { isRMA = false; }
  storedChipType = "";
  storedAlgorithm = "";
  storedAmpRounds = "";
  dataSet = formObj.elements[formElName];
  if( !isAbsolute ) dataSet2 = formObj.elements[formElName2];
  
  if (dataSet.length) {
    for( i=0; i < dataSet.length; i++ ) {
      if( !dataSet[i].checked && ( isAbsolute || !dataSet2[i].checked )) continue;
      chipType = dataSet[i].ChipType;
      algorithm = dataSet[i].AAT;
      AmpRounds = dataSet[i].AmpRounds;
      if( storedChipType == "" ) {
        storedChipType = chipType;
      } else if( chipType != storedChipType ) {
        isDifferent = true;
        alert( "You may only select chips with the same chip type." );
        break;
      }
      if( storedAlgorithm == "" ) {
        storedAlgorithm = algorithm;
      } else if(( algorithm != storedAlgorithm) && (!isRMA)) {
        isDifferent = true;
        alert( "You may only select chips with the same Absolute Analysis Type." );
        break;
      }
      if( storedAmpRounds == "" ) storedAmpRounds = AmpRounds;
      else if( AmpRounds != storedAmpRounds ) isDifferentAmpRounds = true;
    }
  } else if( dataSet.checked || ( !isAbsolute && dataSet2.checked )) {
    chipType = dataSet.ChipType;
    algorithm = dataSet.AAT;
    AmpRounds = dataSet.AmpRounds;
    if( storedChipType == "" ) {
      storedChipType = chipType;
    } else if( chipType != storedChipType ) {
      isDifferent = true;
      alert( "You may only select chips with the same chip type." );
    }
    if( storedAlgorithm == "" ) {
      storedAlgorithm = algorithm;
    } else if(( algorithm != storedAlgorithm) && (!isRMA)) {
      isDifferent = true;
      alert( "You may only select chips with the same Absolute Analysis Type." );
    }
    if( storedAmpRounds == "" ) storedAmpRounds = AmpRounds;
    else if( AmpRounds != storedAmpRounds ) isDifferentAmpRounds = true;
  }  
  
  if( isDifferentAmpRounds ) alert( "Warning: You are selecting chips that had different rounds of amplification." );
  if( isDifferent ) return false;
  else return true;
}

function verifyQuerySummarySelection (formName, isAbsolute, itemName1,itemName2) {
  var checkboxes1, checkboxes2, hasNum, hasDen, hasChecked, i, alertString, formObj, analysisType;
  
  hasNum = 0;
  hasDen = 0;
  hasChecked = false
  formObj = document.forms[formName];
  checkboxes1 = formObj.elements[itemName1];
  
  analysisType = getAnalysisType(checkboxes1);
  if( !checkChipType(formObj, isAbsolute, itemName1, itemName2))
    return;
  
  if( isAbsolute ) {
    alertString = "chip";
    switch (analysisType.toUpperCase()) {
      case "M5":
        formObj.action = "/query/M5_absolute_filtersAndOutput.asp";
        break;
      default:
        formObj.action = "/query/absolute_filtersAndOutput.asp";
    }
  } else {
    alertString = "numerator (Exp) chip and at least one unique denominator (BL) chip";
    formObj.action = "/query/compare_filtersAndOutput.asp";
    checkboxes2 = formObj.elements[itemName2];
  }
  
  if(checkboxes1.length){
  for( i=0; i<checkboxes1.length; i++ ) {
    if( checkboxes1[i].checked ) {
      hasNum++;
      if( isAbsolute ) { hasChecked = true; break; }
      if( hasDen > 1 || (hasDen > 0 && hasNum > 1) ) { hasChecked = true; break; } 
      if( hasNum == 1 && hasDen == 1 && checkboxes1[i].checked != checkboxes2[i].checked) { hasChecked = true; break; }
    }
    if( !isAbsolute && checkboxes2[i].checked ){
      hasDen++;
      if( hasNum > 1 || (hasNum > 0 && hasDen > 1) ) { hasChecked = true; break; } 
      if( hasNum == 1 && hasDen == 1 && checkboxes1[i].checked != checkboxes2[i].checked) { hasChecked = true; break; }
    }
  }
  }else{
  hasChecked=checkboxes1.checked && isAbsolute;
  }  
  if( !hasChecked ) {
    alert("You must select at least one " + alertString + " before filtering.");
    return;
  }
  if( !isAbsolute && formObj.elements['comparisonList1'].value.length == 0) {
    generateAllPairwiseComparisons(checkboxes1,checkboxes2,formObj);
  }
  formObj.submit();
}

function confirmPassword (formObj)
{
  if( formObj.elements['newPassword'].value.length > 0 && formObj.elements['newPassword'].value == formObj.elements['newPassword2'].value )
    formObj.submit();
  else
    alert( "The new password was not confirmed correctly.\nPlease make sure they are spelled correctly.");
}

function isValidNumber (obj,isInteger,isRequired,signRestrict)
{
  if (flgLostFocus == '')
  {
	flgLostFocus = obj.name;
  }  
  if (flgLostFocus == obj.name)
  {  
	var alertString;
	var isNumber = true;
	if (obj.value.search(/\s/g) != -1) 
	{
		alert('Spaces are not allowed for this field.');
		obj.focus();
		obj.select();
		return false;
	}
	
	var strPositiveNegative = '';    
	if (signRestrict)
	{
	  if(signRestrict == 1) 
	    strPositiveNegative = 'positive ';
	  else if(signRestrict == 2) 
	    strPositiveNegative = 'negative ';
	}
		  
	if( isInteger ) alertString = "A valid " + strPositiveNegative + "integer is required";
	  else alertString = "A valid " + strPositiveNegative + "number is required";
	  
	if( isRequired ) alertString += " before continuing to the next field.";
	  else alertString += ".";
	 
	if ( !(isNaN(obj.value)) ) //check if it's a number
	{
	  if (obj.value != '')
	  {
	    if (isInteger) // need to check for a valid integer
	    {    
	      if ( obj.value.indexOf('.') != -1) // containing a decimal [so not an integer]
	      {
	        isNumber = false;
	      }
	    }
	    else // need to check for a valid decimal number 
	    {
	      if (obj.value.indexOf('.') != -1) // check if the number is containing a decimal sign 
	      {
	        if ( obj.value.search(/[0-9]*\.[0-9]*/) == -1) // check if the number is a decimal number 
	        {
	          isNumber = false;
	        }
	      }
	    }
	    if (signRestrict && isNumber)
	    {
	      if ( signRestrict > 0 ) // need to check for the sign of the number
	      {
	        if ( signRestrict == 1 && (obj.value < 0) ) //to check for the +ve sign [so only +ve numbers are allowed; ]
	          isNumber = false;
	        if ( signRestrict == 2 && (obj.value >= 0) ) //to check for the -ve sign [so only -ve numbers are allowed]
	          isNumber = false;
	      }
	    }
	  }
	}
	else
	{
	  isNumber = false;
	}
	
	if( isRequired && obj.value.length == 0 )
		isNumber = false;
		
	if( !isNumber ) 
	{
		alert(alertString);
		obj.focus();
		obj.select();
		return false;
	}
	else
	{
	  flgLostFocus = '';
	}    
  }  
  return true;
    
}


function convertValues (obj,isStraightToNeg)
{
  var oldValue = new Number(obj.value);
  var newValue = new Number;
  var newObjName = "";
  
  if( obj.value == null || obj.value == "" || isNaN(oldValue) ) return;
  
  if( isStraightToNeg ) {
    // NV = -log(OV)
    newValue = Math.round(((Math.log(oldValue) / Math.LN10) * -1) * Math.pow(10,14))/Math.pow(10,14);
    newObjName = obj.name.substring(0,(obj.name.length - 1));
  } else {
    // NV = 10^-(OV)
    newValue = Math.pow(10,(-1 * oldValue));
    newObjName = obj.name + "a";
  }
  obj.form.elements[newObjName].value = newValue;
}

function showHideIsWaiting (show)
{
  var obj = document.getElementById('waitingImg');
  if( !obj ) return;
  
  if (show)
    obj.style.display = "";
  else
    obj.style.display = "none";
}

function getExportItems ()
{
  if(top.opener==undefined){
    alert('The context of parent window has been lost!\nPlease re-open the export window.');
    top.opener='abcd';
    self.close();
    return false;
  }

  var oDoc = window.opener.document;
  var newExportItems = document.forms['export'].elements['exportItems'];
  var el, i;
  
  el = null;
  newExportItems.value = "";
  
  for( i=0; i<oDoc.forms.length; i++ ) {
    if( oDoc.forms[i].elements['selectItems'] ) { el = oDoc.forms[i].elements['selectItems']; }
    else if( oDoc.forms[i].elements['exportItems'] ) { el = oDoc.forms[i].elements['exportItems']; }
  }
  if( el == null ) {
    alert( "exportItems is not defined on opening page" );
    window.close();
    return false;
  }
  if( el.length > 0 ) {
    for( i=0; i<el.length; i++ ) {
      newExportItems.value += (el[i].checked ? el[i].value + "," : "");
    }
  } else {
    newExportItems.value = (el.checked ? el.value : "");
  }
  if( newExportItems.value.substr(newExportItems.value.length - 1) == "," )
    newExportItems.value = newExportItems.value.substr(0,newExportItems.value.length - 1);
  if( newExportItems.value.length < 1 ) {
    alert( "Nothing was selected to export." );
    window.close();
    return false;
  }
  return true;
}

function setFocusPublic ()
{
  if( document.forms['loginform'] ) {
    document.forms['loginform'].elements['LoginName'].focus();
    document.forms['loginform'].elements['LoginName'].select();
  }
}

function disableForm( disable )
{
  if( !disable ) return;
  for( var i = 0; i< document.forms[0].elements.length; i++ ) {
    if( ! document.forms[0].elements[i].disabled ) {
      document.forms[0].elements[i].disabled = true;
    }
  }
}

function getParent(el, pTagName) {
  if (el == null) return null;
  else if (el.nodeType == 1 && el.tagName.toLowerCase() == pTagName.toLowerCase())  // Gecko bug, supposed to be uppercase
    return el;
  else
    return getParent(el.parentNode, pTagName);
}

function showHideMetadata (obj) {
  var i,j;
  var isFound = false;
  
  switch (obj.type) {
    case "select-multiple":
    case "select-one":
      for( j=0; j<obj.options.length; j++ ) {
        for( i=1; i<showHideMetadata.arguments.length; i++ ) {
          if(( obj.options[j].value == showHideMetadata.arguments[i] ) && obj.options[j].selected == true ) {
            showhide_treeElements(obj,1);
            isFound = true;
            break;
          }
        }
      }
      break;
    case "radio":
      for( i=1; i<showHideMetadata.arguments.length; i++ ) {
        if( obj.value == showHideMetadata.arguments[i] ) {
          showhide_treeElements(obj,1);
          isFound = true;
          break;
        }
      }
      break;
    case "checkbox":
      for( i=1; i<showHideMetadata.arguments.length; i++ ) {
        if(( obj.value == showHideMetadata.arguments[i] ) && ( obj.checked == true )) {
          showhide_treeElements(obj,1);
          isFound = true;
          break;
        }
      }
      break;
    default:
  }
  if( !isFound ) { showhide_treeElements(obj,0); }
}

function showhide_treeElements(obj,showHide) {
  var aObj = getParent(obj, "TR");
  var bObj = aObj.parentNode;
  var cObj;
  var imageSrcFolder = "/images/"
  var styleDisplay;

  showHide = ((showHide == false)?0:((showHide==true)?1:-1))
  if( showHide != 0 && showHide != 1 ) { showHide = -1; }
  
  // SWAP THE IMAGE OF THE NODE THAT WAS CLICKED
  if( showHide == 1 ) {
    styleDisplay = "";
  } else if( showHide == 0 ) {
    styleDisplay = "none";
  } else if( obj.src.indexOf("expand_more") > 0 ) {
    obj.src = imageSrcFolder + "icon_collapse_more.gif";
    styleDisplay = "";
  } else if( obj.src.indexOf("collapse_more") > 0 ) {
    obj.src = imageSrcFolder + "icon_expand_more.gif"
    styleDisplay = "none";
  } else if( obj.src.indexOf("expand_end") > 0 ) {
    obj.src = imageSrcFolder + "icon_collapse_end.gif"
    styleDisplay = "";
  } else if( obj.src.indexOf("collapse_end") > 0 ) {
    obj.src = imageSrcFolder + "icon_expand_end.gif"
    styleDisplay = "none";
  }

  var inSet = false;
  for (var i=0; i < bObj.childNodes.length; i++) {
    cObj = bObj.childNodes[i];
    if(cObj.nodeType == 3) { continue; }
    if(cObj.id == aObj.id ) { inSet = true; continue; }
    if((cObj.id.indexOf(aObj.id) == -1) && !(inSet)) { continue; }
    if((cObj.id.indexOf(aObj.id) == -1) && (inSet)) { break; }

    if(( cObj.id.lastIndexOf("_") == aObj.id.length ) && ( styleDisplay == "" )) {
      // THE FIRST LEVEL NODES UNDER CLICKED NODE
      if(( showHide < 0 ) && ( cObj.childNodes[0].childNodes[cObj.childNodes[0].childNodes.length - 2].src.indexOf("collapse_more") > 0 )) {
        cObj.childNodes[0].childNodes[cObj.childNodes[0].childNodes.length - 1].src = imageSrcFolder + "icon_expand_more.gif";
      } else if(( showHide < 0 ) && ( cObj.childNodes[0].childNodes[cObj.childNodes[0].childNodes.length - 2].src.indexOf("collapse_end") > 0 )) {
        cObj.childNodes[0].childNodes[cObj.childNodes[0].childNodes.length - 1].src = imageSrcFolder + "icon_expand_end.gif";
      }
      cObj.style.display = styleDisplay;
    } else if( styleDisplay == "none" ) {
      // THE NODES UNDER CLICKED NODE
      cObj.style.display = styleDisplay;
    }
  }
}

function pushPopUpValuesToOpener (srcFormObj, destFormName, destFormElementName)
{
  var destFormObj, srcElement;
  var i, isChecked, strValues, linkLabel, idString;

  strValues = '';
  linkLabel = '';
  isChecked = false;
  srcElement = srcFormObj.elements['leafNodeID'];

  if (srcElement.length) {
    for (i=0;i<srcElement.length;i++) {
      if (srcElement[i].checked) { 
        switch (destFormElementName.substr(0,8)) {
          case 'Projects':
            if( srcElement[i].value.substr(0,1) == 'G' ) { isChecked = true; }
            break;
          case 'GenusToS':
          case 'Genotype':
          case 'TraitDis':
          case 'RNASourc':
            isChecked = true;
            break;
        }
        if (strValues.length > 0) {
          strValues += ",";
          linkLabel += "<br>";
        }
        idString = srcElement[i].value.substr(0,srcElement[i].value.indexOf('_'));
        strValues += idString.substr(idString.lastIndexOf(":") + 1);
        if(destFormElementName.substr(0,8)=="RNASourc") linkLabel += srcFormObj.elements['sourceMaterial'].options[srcFormObj.elements['sourceMaterial'].selectedIndex].text + " &raquo; ";
        linkLabel += srcElement[i].value.substr(srcElement[i].value.indexOf('_') + 1);
        
        if(( srcElement[i].type == "radio" ) && (destFormElementName.substr(0,8) == "TraitDis")) break;
      }
    }
  } else {
    switch (destFormElementName.substr(0,8)) {
      case 'Projects':
        if( srcElement.value.substr(0,1) == 'G' ) { isChecked = true; }
        break;
      case 'GenusToS':
      case 'Genotype':
      case 'TraitDis':
      case 'RNASourc':
        isChecked = srcElement.checked;
        break;
    }
    idString  = srcElement.value.substr(0,srcElement.value.indexOf('_'));
    strValues = idString.substr(idString.lastIndexOf(":") + 1);
    if(destFormElementName.substr(0,8)=="RNASourc") linkLabel += srcFormObj.elements['sourceMaterial'].options[srcFormObj.elements['sourceMaterial'].selectedIndex].text + " &raquo; ";
    linkLabel += srcElement.value.substr(srcElement.value.indexOf('_') + 1);
  }
  
  if (!(isChecked)) {
    switch (destFormElementName.substr(0,8)) {
      case 'Projects':
        alert("At least one General Project is required.");
        break;
      case 'GenusToS':
        alert("Please select the correct Genus, Species, Subspecies/Strain.");
        break;
      case 'Genotype':
        alert("Please select an appropriate Genotype.");
        break;
      case 'TraitDis':
        alert("Please select an appropriate Trait/Disease.");
        break;
      case 'RNASourc':
        alert("Please select an appropriate RNA Source.");
        break;
    }
    return;
  }

  if(top.opener)
    destFormObj = top.opener.document.forms[destFormName];
  else
    destFormObj = document.forms[destFormName];

  switch (destFormElementName.substr(0,8)) {
    case 'Genotype':
      destFormObj.document.getElementById(destFormElementName + "Link").innerHTML = linkLabel;
      destFormObj.elements[destFormElementName+"Link"].value = linkLabel;
      if( srcFormObj.elements['unigene'].value.length > 0 ) {
        destFormObj.elements[destFormElementName+"Link"].value += " &raquo; " + srcFormObj.elements['unigene'].value;
        destFormObj.document.getElementById(destFormElementName + "Link").innerHTML += " &raquo; " + srcFormObj.elements['unigene'].value;
      }
      destFormObj.elements[destFormElementName+"UnigeneID"].value = srcFormObj.elements['unigene'].value;
      destFormObj.elements[destFormElementName].value = strValues;
      destFormObj.elements[destFormElementName+"Comments"].value = srcFormObj.elements['comments'].value;
      if (srcFormObj.elements['comments'].value.replace(/\s/g, '').length > 0 ) destFormObj.document.getElementById(destFormElementName + "Link").innerHTML += "<blockquote>" + srcFormObj.elements['comments'].value + "</blockquote>";
      break;
    case 'RNASourc':
      destFormObj.elements[destFormElementName + "MaterialID"].value = srcFormObj.elements['sourceMaterial'].options[srcFormObj.elements['sourceMaterial'].selectedIndex].value;
      destFormObj.elements[destFormElementName + "PMINum"].value = srcFormObj.elements['pmiNum'].value;
      destFormObj.elements[destFormElementName + "PMIUnitID"].value = srcFormObj.elements['pmiUnit'].options[srcFormObj.elements['pmiUnit'].selectedIndex].value;
      destFormObj.elements[destFormElementName + "Explanation"].value = srcFormObj.elements['explanation'].value;
      destFormObj.elements[destFormElementName + "ALocation"].value = srcFormObj.elements['anatomicLocation'].value;
      destFormObj.elements[destFormElementName + "ASLocation"].value = srcFormObj.elements['anatomicLocationSub'].value;
      destFormObj.elements[destFormElementName + "SPlane"].value = srcFormObj.elements['stereotaxicPlane'].value;
      destFormObj.elements[destFormElementName + "SComments"].value = srcFormObj.elements['stereotaxicComments'].value;
      if (destFormObj.elements[destFormElementName + "ALocation"].value.replace(/\s/g, '').length > 0) linkLabel += " &raquo; " + srcFormObj.elements['anatomicLocation'].value;
      if (destFormObj.elements[destFormElementName + "ASLocation"].value.replace(/\s/g, '').length > 0) linkLabel += " &raquo; " + srcFormObj.elements['anatomicLocationSub'].value;
      if (destFormObj.elements[destFormElementName + "SPlane"].value.replace(/\s/g, '').length > 0) linkLabel += " &raquo; " + srcFormObj.elements['stereotaxicPlane'].options[srcFormObj.elements['stereotaxicPlane'].selectedIndex].text;
      if (destFormObj.elements[destFormElementName + "SComments"].value.replace(/\s/g, '').length > 0) linkLabel += " &raquo; " + srcFormObj.elements['stereotaxicComments'].value;
    case 'TraitDis':
      idString = destFormObj.document.getElementById(destFormElementName + "Link").search.lastIndexOf('=');
      destFormObj.document.getElementById(destFormElementName + "Link").search = destFormObj.document.getElementById(destFormElementName + "Link").search.substr(0,idString+1);
      destFormObj.document.getElementById(destFormElementName + "Link").search += srcFormObj.classid.value + "','MetadataPopup');";
      destFormObj.elements[destFormElementName+"ClassID"].value = srcFormObj.elements['classid'].value;
      destFormObj.elements[destFormElementName+"Comments"].value = srcFormObj.elements['comments'].value;
      destFormObj.elements[destFormElementName].value = strValues;
      destFormObj.elements[destFormElementName+"Link"].value = linkLabel;
      destFormObj.document.getElementById(destFormElementName + "Link").innerHTML = linkLabel;
      if (srcFormObj.elements['comments'].value.replace(/\s/g, '').length > 0 ) destFormObj.document.getElementById(destFormElementName + "Link").innerHTML += "<blockquote>" + srcFormObj.elements['comments'].value + "</blockquote>";
      break;
    case 'GenusToS':
      destFormObj.elements[destFormElementName+"Comments"].value = srcFormObj.elements['comments'].value;
      destFormObj.elements[destFormElementName].value = strValues;
      destFormObj.elements[destFormElementName+"Link"].value = linkLabel;
      destFormObj.document.getElementById(destFormElementName + "Link").innerHTML = linkLabel;
      break;
    case 'Projects':
      destFormObj.elements[destFormElementName].value = strValues;
      destFormObj.elements[destFormElementName+"Link"].value = linkLabel;
      destFormObj.document.getElementById(destFormElementName + "Link").innerHTML = linkLabel;
      break;
    default:
      alert("Item '" + destFormElementName + "' not found. Please help.");
      break;
  }
  srcFormObj.issueWarning.value = 0;
  top.window.close();
}

function goBackToQueryPage(sFromWhere){
  var objFrm;
  
  switch(sFromWhere){
    case 'CMP':
      objFrm = document.forms['frmCompFilter'];
      objFrm.action = '/query/query_selectChips.asp?fromWhere=CMP#QRS';
      break;
    case 'ABS':
      objFrm = document.forms['frmAbFilter'];
      var sIDs = '';
      var oCBox = objFrm.elements['cmpFiles'];
      if(oCBox.length){
        for( i = 0; i < oCBox.length; i++) {
          sIDs += (sIDs == '' ? '' : ',') + oCBox[i].value;
        }
      } else {
        sIDs = oCBox.value;
      }
      objFrm.elements['cellidsforquerypage'].value = sIDs;
      objFrm.action = '/query/query_selectChips.asp?fromWhere=ABS#QRS';
      break;
  }
  objFrm.submit();
}
function checkSelectedChips(oForm,iGeneDesc,isAbsolute){
  var chkChips=oForm.elements['cmpFiles'];
  var blnChecked=false;
  if(chkChips==undefined){alert('There are no '+(isAbsolute?'chips':'compares')+' available for filtering!');return false;}
  if(chkChips.length){
    for(i=0;i<chkChips.length && !blnChecked;i++){
      blnChecked=blnChecked ||chkChips[i].checked;
    }
  }else{
    blnChecked=chkChips.checked;
  }
  if(blnChecked){
    oForm.elements['hdnValue'].value='start';
    return true;
  }else{
    alert('Please select at least 1 '+(isAbsolute?'chip':'pair')+' for filtering!');
  }
  return false;
}

function CopyValuetoHidden(formObjs, hiddenparameter)
{
  document.form1.elements[hiddenparameter].value=document.form1.elements[formObjs].options[document.form1.elements[formObjs].selectedIndex].text;  
}

function ShowHideSections(blnShow){
  var oInputItems = document.getElementsByTagName('input');
  for(var i=0;i<oInputItems.length;i++) {
    if (oInputItems[i].id != 'chk_1') { continue; }
    oInputItems[i].checked = blnShow;
    showHideMetadata(oInputItems[i],1);
  }
}

function checkValue(oSelBox,sTBox){
  if(oSelBox.form['whereclause']){
    var oTBox=oSelBox.form.elements[sTBox];
    var sVal=oTBox.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
    if(sVal==''){
      oTBox.focus();
    }
  }
}

//This function moves all the selected items from the 
//source list box to the destination list box
function moveFromOneToAnotherList(oSrc,oDst){
  var oNewOpt,i,j;
  for(i=0;i<oSrc.length;i++){
    if(oSrc[i].selected){
      oNewOpt=document.createElement("OPTION");
      oNewOpt.value=oSrc[i].value;
      oNewOpt.text=oSrc[i].text;
      oDst[oDst.length]=oNewOpt;
      oNewOpt=null;
      oSrc[i--]=null;
    }
  }
}

function selectListAndSubmit(oLst,sMsg){
  var blnSubmit=true;
  if(sMsg!=''){
    blnSubmit=(oLst.options.length==0?confirm(sMsg):true);
  }
  if(blnSubmit){
    for(i=0;i<oLst.options.length;i++){
      oLst.options[i].selected=true;
    }
    oLst.form.submit();
  }
}

function RegTrim(sValue){
  return sValue.replace(/^\s*/g,'').replace(/\s*$/g,'');
}

//This function validates both the passwords.
//if the IsMandatory flag is true, then it checks if the password has been entered or not.
function ValidatePassword(sPass1,sPass2,isMandatory,sLoginName,sOldPass){
  var re;
  if(sOldPass != undefined){
    if(RegTrim(sOldPass).length==0){
      alert("Please enter your Old Password!");
      return false;
    }
  }
  
  //The Login Name and Password must not be case insesitivly same
  if(sPass1.toLowerCase() == sLoginName.toLowerCase())
  {
    alert("Password must not be same as Username. Please reenter password.");
    return false;
  }
  
  //validating password at the time of user updating value,
  //the password should be either empty or more than four characters
  if((sPass1.length < 4 && isMandatory) || (sPass1.length > 0 && sPass1.length < 4 && !isMandatory)){
    alert("Password must be at least 4 characters long!");
    return false;
  }
  re=/^[a-z]/i;
  if(!(re.test(sPass1)) && sPass1.length>=4){
    alert("Password must start with an alphabet!");
    return false;
  }
  re=/[^0-9a-z]/i;
  if(re.test(sPass1) && sPass1.length>=4){
    alert("Password can only have combination of alphabets and numbers!");
    return false;
  }
  if(RegTrim(sPass1)!=RegTrim(sPass2)){
    alert('The Passwords do not match. Please re-enter passwords correctly.');
    return false;
  }
  return true;
}

//This function validates a date control
function isValidDate(oForm,sObjName){
  if(oForm.elements[sObjName+'Month'].value=='---' || oForm.elements[sObjName+'Day'].value=='--' || oForm.elements[sObjName+'Year'].value=='----')
    return;
  var iMonth=parseInt(oForm.elements[sObjName+'Month'].value,10)-1;
  var iDate=parseInt(oForm.elements[sObjName+'Day'].value,10);
  var iYear=parseInt(oForm.elements[sObjName+'Year'].value,10);
  var oDate=new Date(iYear,iMonth,iDate);
  if(oDate.getDate()==iDate && oDate.getMonth()==iMonth && oDate.getFullYear()==iYear){
    return true;
  }else{
    return false;
  }
  
}

//This function Validates the basic query form inputs.
//As of now only the date fields require validations.
function validateBasicQuery(oForm){
  var aControls=new Array('chipExp','birth','sample','rnaExtraction','cRNA','hyb','scanned');
  var aControlNames=new Array('Chip Exp Date','Birth Date','Sample Collection Date','RNA Extraction Date','Date Labeling Complete','Hyb Date','Scanned Date');
  for(var i=0;i<aControls.length;i++){
    if(oForm.elements[aControls[i]+'Month'].selectedIndex || oForm.elements[aControls[i]+'Day'].selectedIndex || oForm.elements[aControls[i]+'Year'].selectedIndex){
      
      if(oForm.elements[aControls[i]+'Month'].selectedIndex && oForm.elements[aControls[i]+'Day'].selectedIndex && oForm.elements[aControls[i]+'Year'].selectedIndex){
        if(!isValidDate(oForm,aControls[i])){
          alert('Please enter a valid date for '+aControlNames[i]);
          return false;
        }
      
      }else{
        alert('Please enter the complete date for '+aControlNames[i]+' or select Advanced Query for partial dates');
        return false;
      }
      
    }
  }
  return true;
}

function showHideAllColumns (obj) {
  var e = obj.form.elements;
  
  for (var i=0; i < e.length; i++) {
    if (e[i].name.indexOf('SHField') == 0) {
      e[i].checked = obj.checked;
      showHideColumn( e[i] );
    }
    if (e[i].name == 'SHGeneDesc') {
      e[i].checked = obj.checked;
      showHideGeneDesc( e[i] );
    }
  }
}

function showHideColumn (obj) {
  var i, sheetIndex, isChecked, ruleName, sheetName;
  var isBrowserSpecific, displayText, override;
  var valuesStr = obj.value;
  
  ruleName = obj.name;
  isBrowserSpecific = (valuesStr.split(',')[0] == 'true') ? true : false;
  displayText =  valuesStr.split(',')[1];
  override = valuesStr.split(',')[2];

  if (override == true || override == false) {
    isChecked = override;
  } else {
    isChecked = obj.checked;
  }
  
  if (isBrowserSpecific) {
    sheetName = (isIE) ? 'genomics_IE.css' : 'genomics_NAV.css';
  } else {
    sheetName = 'genomics.css';
  }
  
  for( i=0; i<document.styleSheets.length; i++)
    if (document.styleSheets[i].href.indexOf(sheetName) >= 0) {
      sheetIndex = i;
      break;
    }

  if (!sheetIndex)
    alert("StyleSheet not found.");
  else {
    if (isNav) {
      for (i=0; i<document.styleSheets[sheetIndex].cssRules.length; i++)
        if (document.styleSheets[sheetIndex].cssRules[i].selectorText.indexOf(ruleName) >= 0) {
          document.styleSheets[sheetIndex].cssRules[i].style.display = isChecked ? displayText : 'none';
          break;
        }
    } else if (isIE) {
      for (i=0; i<document.styleSheets[sheetIndex].rules.length; i++)
        if (document.styleSheets[sheetIndex].rules[i].selectorText.indexOf(ruleName) >= 0) {
          document.styleSheets[sheetIndex].rules[i].style.display = isChecked ? 'inline' : 'none';
          break;
        }
    } else {
      alert( "Unknown Browser" );
    }
  }
}

function performAction (objForm, itemName) {
  var jsString = objForm.elements[itemName].options[objForm.elements[itemName].selectedIndex].value
  eval(jsString);
}

function changeSelections (selObj, doStyle) {
  var formObj = selObj.form;
  var sValue = selObj.options[selObj.selectedIndex].value;
  
  formObj.elements[selObj.name.substr(0,selObj.name.length-1) + '1'].options[selObj.selectedIndex].selected = true;
  formObj.elements[selObj.name.substr(0,selObj.name.length-1) + '2'].options[selObj.selectedIndex].selected = true;
  if (formObj.elements[selObj.name.substr(0,selObj.name.length-1) + '3']) {
    formObj.elements[selObj.name.substr(0,selObj.name.length-1) + '3'].options[selObj.selectedIndex].selected = true;
  }
  
  if (doStyle) {
    var sText = selObj.options[selObj.selectedIndex].text;
    if (isNav) {
      document.styleSheets[2].cssRules[0].style.display = (sText == "Export")?'inline':'none';
      document.styleSheets[2].cssRules[1].style.display = ((sText == "Stage Comparisons") || (sText == "Comparison Analysis"))?'inline':'none';
      document.styleSheets[2].cssRules[2].style.display = ((sText == "Absolute Analysis") || (sText == "Apply Filters & Display Results"))?'inline':'none';
      if (document.styleSheets[2].cssRules[0].style.display == 'none' && document.styleSheets[2].cssRules[1].style.display == 'none' && document.styleSheets[2].cssRules[2].style.display == 'none') {
        document.styleSheets[2].cssRules[2].style.display = 'inline';
      }
    } else if (isIE) {
      document.styleSheets[1].rules[0].style.display = (sText == "Export")?'inline':'none';
      document.styleSheets[1].rules[1].style.display = ((sText == "Stage Comparisons") || (sText == "Comparison Analysis"))?'inline':'none';
      document.styleSheets[1].rules[2].style.display = ((sText == "Absolute Analysis") || (sText == "Apply Filters & Display Results"))?'inline':'none';
      if (document.styleSheets[1].rules[0].style.display == 'none' && document.styleSheets[1].rules[1].style.display == 'none' && document.styleSheets[1].rules[2].style.display == 'none') {
        document.styleSheets[1].rules[2].style.display = 'inline';
      }
    }
  }
  return true;
}

function showHideElement(srcObj,destObjID,showString) {
  var destObj = document.getElementById(destObjID);
  if (!showString || isIE) { showString = ''; }
  switch (srcObj.type) {
    case "select-one":
      destObj.style.display = (srcObj.options[srcObj.selectedIndex].value=1)?showString:'none';
      break;
    case "checkbox":
    case "radio":
      destObj.style.display = (srcObj.checked)?showString:'none';
      break;
    default:
  }
}

function showHideAllSections(srcObj) {
  var bShow, destObj, objCheckboxes, i;

  objCheckboxes = srcObj.form.elements['SectionCheckBox'];
  if (objCheckboxes == undefined) return;

  switch (srcObj.type) {
    case "select-one":
      bShow = (srcObj.options[srcObj.selectedIndex].value=1) ? true : false;
      break;
    case "checkbox":
    case "radio":
      bShow = (srcObj.checked) ? true : false;
      break;
    default:
  }

  if (objCheckboxes.length) {
    for (i = 0; i < objCheckboxes.length; i++) {
      objCheckboxes[i].checked = bShow;
    }
  } else {
    objCheckboxes.checked = bShow;
  }

  for( var i=1; i<showHideAllSections.arguments.length; i++) {
    destObj = document.getElementById(showHideAllSections.arguments[i]);
    destObj.style.display = (bShow) ? '' : 'none';
  }
}

function setupQueryOpenClose(){
  var e = document.forms[0].elements['SectionCheckBox'];
  for (var i=0; i < e.length; i++) {
    if (e[i].checked) { return; }
  }
  e[0].checked = true;
  showHideElement(e[0],'Section1');
}

function showHideGeneDesc (obj) {
  var i, sheetIndex, isChecked, ruleName, sheetName;
  var isBrowserSpecific, displayText, override;
  var valuesStr = obj.value;
  
  ruleName = obj.name;
  isBrowserSpecific = (valuesStr.split(',')[0] == 'true') ? true : false;
  displayText =  valuesStr.split(',')[1];
  override = valuesStr.split(',')[2];

  showHideColumn (obj);
  
  if (override == true || override == false) {
    isChecked = !(override);
  } else {
    isChecked = !(obj.checked);
  }
  
  if (isBrowserSpecific) {
    sheetName = (isIE) ? 'genomics_IE.css' : 'genomics_NAV.css';
  } else {
    sheetName = 'genomics.css';
  }

  for( i=0; i<document.styleSheets.length; i++)
    if (document.styleSheets[i].href.indexOf(sheetName) >= 0) {
      sheetIndex = i;
      break;
    }
  
  if (!sheetIndex)
    alert("StyleSheet not found.");
  else {
    if (isNav) {
      for (i=0; i<document.styleSheets[sheetIndex].cssRules.length; i++)
        if (document.styleSheets[sheetIndex].cssRules[i].selectorText.indexOf(ruleName + "1") >= 0) {
          document.styleSheets[sheetIndex].cssRules[i].style.display = isChecked ? displayText : 'none';
          break;
        }
    } else if (isIE) {
      for (i=0; i<document.styleSheets[sheetIndex].rules.length; i++)
        if (document.styleSheets[sheetIndex].rules[i].selectorText.indexOf(ruleName + "1") >= 0) {
          document.styleSheets[sheetIndex].rules[i].style.display = isChecked ? 'inline' : 'none';
          break;
        }
    } else {
      alert( "Unknown Browser" );
    }
  }
}

function validateGenotypeQuery (formObj) {
  var checkComplete = true;
  /*
   * In this function the validation checks need to be written. This check will enforce:
   *   1. Only one selection must be made from the tree.
   */
  var e = formObj.elements['leafNodeID'];
  var sRet='',sVal;
  var blnAdvQry,sAdvQry='';
  if(top.opener.document.forms['form1'].elements['whereclause'])
    blnAdvQry=true;
  else
    blnAdvQry=false;
  for( var i=0; i<e.length; i++ ) {
    if( e[i].checked ) {
      sVal=e[i].value;
      sVal=sVal.substring(sVal.indexOf('_')+1);
      if(blnAdvQry){
        sRet+=(sRet==''?'(':' OR ')+'genotype like \''+sVal+'%\'';
      }else{
        sRet+=(sRet==''?'':'<br>')+sVal;
      }
    }
  }
  if(sRet!=''){
    if(blnAdvQry){
      top.opener.document.forms['form1'].elements['whereclause'].value+=sRet+') ';
    }else{
      top.opener.document.getElementById('GenotypeLink').innerHTML=sRet;
      top.opener.document.forms['form1'].elements['hd_genotype'].value=sRet.replace(/<br>/gi,'\',\'');
    }
  }
  self.close()
}

function validateGenusToSubsQuery (formObj) {
  var checkComplete = false;
  // In this function the validation checks need to be written. This check will enforce :
  // 1. A selection must be made.
  var e = formObj.elements['leafNodeID'];
  var sRet='',sVal;
  var blnAdvQry,sAdvQry='';
  if(top.opener.document.forms['form1'].elements['whereclause'])
  blnAdvQry=true;
  else
    blnAdvQry=false;
  for( var i=0; i<e.length; i++ ) {
    if( e[i].checked ) {
    sVal=e[i].value;
    sVal=sVal.substring(sVal.indexOf('_')+1);
    if(blnAdvQry){
      sRet+=(sRet==''?'(':' OR ')+'species like \''+sVal+'%\'';
    }else{
      sRet+=(sRet==''?'':'<br>')+sVal;
    }
    }
  }
  if(sRet!=''){
  if(blnAdvQry){
    top.opener.document.forms['form1'].elements['whereclause'].value+=sRet+') ';
  }else{
    top.opener.document.getElementById('GenusToSubLink').innerHTML=sRet;
    top.opener.document.forms['form1'].elements['hd_genus'].value=sRet.replace(/<br>/gi,'\',\'');
  }
  }
  self.close()
}

function validateTraitQuery (formObj) {
  var checkComplete = false;
  /*
   * In this function the validation checks need to be written. This check will enforce a couple things:
   * 1. One selection must be made from the tree.
   */
  var e = formObj.elements['leafNodeID'];
  var sRet='',sVal;
  var blnAdvQry,sAdvQry='';
  if(top.opener.document.forms['form1'].elements['whereclause'])
  blnAdvQry=true;
  else
    blnAdvQry=false;
  for( var i=0; i<e.length; i++ ) {
    if( e[i].checked ) {
    sVal=e[i].value;
    sVal=sVal.substring(sVal.indexOf('_')+1);
    if(blnAdvQry){
      sRet+=(sRet==''?'(':' OR ')+'traitdisease like \''+sVal+'%\'';
    }else{
      sRet+=(sRet==''?'':'<br>')+sVal;
    }
    }
  }
  if(sRet!=''){
  if(blnAdvQry){
    top.opener.document.forms['form1'].elements['whereclause'].value+=sRet+') ';
  }else{
    top.opener.document.getElementById('TraitDiseaseLink').innerHTML=sRet;
    top.opener.document.forms['form1'].elements['hd_trait'].value=sRet.replace(/<br>/gi,'\',\'');
  }
  }
  self.close()
}

function initializeTreatmentQuery(srcFormName, destFormName) {
  var destFormObj = document.forms[destFormName];
  var srcFormObj =  top.opener.document.forms[srcFormName];
  var aList = srcFormObj.hd_treatment.value.split(':~:');
  var aVals;
  for(i=0;i<aList.length;i++){
  aVals=aList[i].split(String.fromCharCode(187));
  if(aVals.length==2){
    switch(aVals[0]){
    case 'Chemical':
      destFormObj.Chemical.value=aVals[1];
      break;
    case 'Environmental':
      destFormObj.Environmental.value=aVals[1];
      break;
    case 'Growth':
      destFormObj.Growth.value=aVals[1];
      break;
    case 'Infectious':
      destFormObj.Infectious.value=aVals[1];
      break;
    case 'Mental':
      destFormObj.Mental.value=aVals[1];
      break;
    case 'Physical':
      destFormObj.Physical.value=aVals[1];
      break;
    case 'Radiation':
      destFormObj.Radiation.value=aVals[1];
      break;
    case 'Surgical':
      destFormObj.Surgical.value=aVals[1];
      break;
    case 'Trauma':
      destFormObj.Trauma.value=aVals[1];
      break;
    }
  }
  }
}

function validateTreatmentQuery (srcFormName,destFormName) {
  var destFormObj = top.opener.document.forms[destFormName];
  var srcFormObj =  document.forms[srcFormName];
  var linkLabel = '';
  var sVal='',sTemp='';
  var spaceIndex;
  var isAdvQuery,oWhere,blnAnd;
  if(top.opener.document.forms['form1'].elements['whereclause']){
  isAdvQuery=true;
  oWhere=top.opener.document.forms['form1'].elements['whereclause'];
  }else{
  isAdvQuery=false;
  }
  blnAnd=false
  //Chemical
  if (( srcFormObj.Chemical.value.length > 0 ) && ( srcFormObj.Chemical.value.length < 50 )) {
    linkLabel += "Chemical &raquo; " + srcFormObj.Chemical.value + "<br>";
  }
  if (( srcFormObj.Chemical.value.length > 0 ) && ( srcFormObj.Chemical.value.length >= 50 )) {
    spaceIndex = srcFormObj.Chemical.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Chemical &raquo; " + srcFormObj.Chemical.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Chemical &raquo; " + srcFormObj.Chemical.value + "<br>"; }
  }
  sTemp=srcFormObj.Chemical.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+='((treatment=\'Chemical\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Chemical'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Environmental
  if (( srcFormObj.Environmental.value.length > 0 ) && ( srcFormObj.Environmental.value.length < 50 )) {
    linkLabel += "Environmental &raquo; " + srcFormObj.Environmental.value + "<br>";
  }
  if (( srcFormObj.Environmental.value.length > 0 ) && ( srcFormObj.Environmental.value.length >= 50 )) {
    spaceIndex = srcFormObj.Environmental.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Environmental &raquo; " + srcFormObj.Environmental.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Environmental &raquo; " + srcFormObj.Environmental.value + "<br>"; }
  }
  sTemp=srcFormObj.Environmental.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Environmental\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') '
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Environmental'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Growth
  if (( srcFormObj.Growth.value.length > 0 ) && ( srcFormObj.Growth.value.length < 50 )) {
    linkLabel += "Growth Conditions &raquo; " + srcFormObj.Growth.value + "<br>";
  }
  if (( srcFormObj.Growth.value.length > 0 ) && ( srcFormObj.Growth.value.length >= 50 )) {
    spaceIndex = srcFormObj.Growth.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Growth Conditions &raquo; " + srcFormObj.Growth.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Growth Conditions &raquo; " + srcFormObj.Growth.value + "<br>"; }
  }
  sTemp=srcFormObj.Growth.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Growth\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Growth'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Infectious
  if (( srcFormObj.Infectious.value.length > 0 ) && ( srcFormObj.Infectious.value.length < 50 )) {
    linkLabel += "Infectious &raquo; " + srcFormObj.Infectious.value + "<br>";
  }
  if (( srcFormObj.Infectious.value.length > 0 ) && ( srcFormObj.Infectious.value.length >= 50 )) {
    spaceIndex = srcFormObj.Infectious.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Infectious &raquo; " + srcFormObj.Infectious.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Infectious &raquo; " + srcFormObj.Infectious.value + "<br>"; }
  }
  sTemp=srcFormObj.Infectious.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Infectious\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Infectious'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Mental
  if (( srcFormObj.Mental.value.length > 0 ) && ( srcFormObj.Mental.value.length < 50 )) {
    linkLabel += "Mental &raquo; " + srcFormObj.Mental.value + "<br>";
  }
  if (( srcFormObj.Mental.value.length > 0 ) && ( srcFormObj.Mental.value.length >= 50 )) {
    spaceIndex = srcFormObj.Mental.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Mental &raquo; " + srcFormObj.Mental.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Mental &raquo; " + srcFormObj.Mental.value + "<br>"; }
  }
  sTemp=srcFormObj.Mental.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Mental\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Mental'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Physical
  if (( srcFormObj.Physical.value.length > 0 ) && ( srcFormObj.Physical.value.length < 50 )) {
    linkLabel += "Physical &raquo; " + srcFormObj.Physical.value + "<br>";
  }
  if (( srcFormObj.Physical.value.length > 0 ) && ( srcFormObj.Physical.value.length >= 50 )) {
    spaceIndex = srcFormObj.Physical.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Physical &raquo; " + srcFormObj.Physical.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Physical &raquo; " + srcFormObj.Physical.value + "<br>"; }
  }
  sTemp=srcFormObj.Physical.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Physical\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Physical'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Radiation
  if (( srcFormObj.Radiation.value.length > 0 ) && ( srcFormObj.Radiation.value.length < 50 )) {
    linkLabel += "Radiation &raquo; " + srcFormObj.Radiation.value + "<br>";
  }
  if (( srcFormObj.Radiation.value.length > 0 ) && ( srcFormObj.Radiation.value.length >= 50 )) {
    spaceIndex = srcFormObj.Radiation.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Radiation &raquo; " + srcFormObj.Radiation.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Radiation &raquo; " + srcFormObj.Radiation.value + "<br>"; }
  }
  sTemp=srcFormObj.Radiation.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Radiation\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Radiation'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Surgical
  if (( srcFormObj.Surgical.value.length > 0 ) && ( srcFormObj.Surgical.value.length < 50 )) {
    linkLabel += "Surgical &raquo; " + srcFormObj.Surgical.value + "<br>";
  }
  if (( srcFormObj.Surgical.value.length > 0 ) && ( srcFormObj.Surgical.value.length >= 50 )) {
    spaceIndex = srcFormObj.Surgical.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Surgical &raquo; " + srcFormObj.Surgical.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Surgical &raquo; " + srcFormObj.Surgical.value + "<br>"; }
  }
  sTemp=srcFormObj.Surgical.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Surgical\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Surgical'+String.fromCharCode(187)+sTemp;
  }
  }
  
  //Trauma
  if (( srcFormObj.Trauma.value.length > 0 ) && ( srcFormObj.Trauma.value.length < 50 )) {
    linkLabel += "Trauma &raquo; " + srcFormObj.Trauma.value + "<br>";
  }
  if (( srcFormObj.Trauma.value.length > 0 ) && ( srcFormObj.Trauma.value.length >= 50 )) {
    spaceIndex = srcFormObj.Trauma.value.indexOf(' ', 50);
    if (spaceIndex >= 50) { linkLabel += "Trauma &raquo; " + srcFormObj.Trauma.value.substr(0,spaceIndex) + "&hellip;<br>"; }
    else { linkLabel += "Trauma &raquo; " + srcFormObj.Trauma.value + "<br>"; }
  }
  sTemp=srcFormObj.Trauma.value.replace(/^\s*/g,'').replace(/\s*$/g,'');
  if(sTemp.length>0){
  if(isAdvQuery){
    oWhere.value+=(blnAnd?' or ':'(')+'(treatment=\'Trauma\' and treatmentDescription like \'%'+sTemp.replace(/\*/g,'%')+'%\') ';
    blnAnd=true;
  }else{
    sVal+=(sVal.length>0?':~:':'')+'Trauma'+String.fromCharCode(187)+sTemp;
  }
  }
  if(isAdvQuery && blnAnd){oWhere.value+=') ';}
  if(!isAdvQuery){
  if( linkLabel.replace(/\s/g, '').length == 0 ) { destFormObj.document.getElementById('TreatmentLink').innerHTML = "None"; }
  else { destFormObj.document.getElementById('TreatmentLink').innerHTML = linkLabel; }
  destFormObj.hd_treatment.value=sVal;
  }
  srcFormObj.issueWarning.value = 0;
  top.window.close();
}

function validateRNASourceQuery(formObj) {
  var checkComplete = false;
  /*
   * In this function the validation checks need to be written. This check will enforce a couple things:
   * 1. One selection must be made from the tree.
   */
  var e = formObj.elements['leafNodeID'];
  var sRet='',sVal;
  var blnAdvQry,sAdvQry='';
  if(top.opener.document.forms['form1'].elements['whereclause'])
  blnAdvQry=true;
  else
    blnAdvQry=false;
  for( var i=0; i<e.length; i++ ) {
    if( e[i].checked ) {
    sVal=e[i].value;
    sVal=sVal.substring(sVal.indexOf('_')+1);
    if(blnAdvQry){
      sRet+=(sRet==''?'(':' OR ')+'rnasource like \''+sVal+'%\'';
    }else{
      sRet+=(sRet==''?'':'<br>')+sVal;
    }
    }
  }
  if(sRet!=''){
  if(blnAdvQry){
    top.opener.document.forms['form1'].elements['whereclause'].value+=sRet+') ';
  }else{
    top.opener.document.getElementById('RNASourceLink').innerHTML=sRet;
    top.opener.document.forms['form1'].elements['hd_rnasource'].value=sRet.replace(/<br>/gi,'\',\'');
  }
  }
  self.close()
}

function showComments(formObj) {
  var strcommentvalue
  strcommentvalue = formObj.elements.selectTemplateId.options[formObj.elements.selectTemplateId.selectedIndex].comment;
  document.getElementById('newtemplatecomments').innerHTML = strcommentvalue;
  if (strcommentvalue.length==0) {
    document.getElementById('commentsId').style.display = 'none';
  } else {
    document.getElementById('commentsId').style.display = (isIE)? 'inline' : 'table-row';
     
  }
}

function checkDuplicateQueryName()
{
  var i;
  if(document.all.enterquerynameid[1].checked)
  {
    if (document.all.selectqueryId.selectedIndex==0)
    {
      alert("Please select a query name to update");
      return false;
    }
  }
  else
  {
    if(document.all.enterquerynameid[0].checked)
    {
      if (RegTrim(document.all.newqueryid.value)=="")
      {
        alert("Please enter a query name");          
        return false;
      }
    }
  }

  for(i=0; i < document.all.selectqueryId.length; i++)
  {
    var strSelectedQueryName;
    var strSelectedQueryListName;
    
    strSelectedQueryName=RegTrim(document.all.newqueryid.value);
    strSelectedQueryName=strSelectedQueryName.toUpperCase();
    strSelectedQueryListName=document.all.selectqueryId.options[i].value.toUpperCase();
  
    if (strSelectedQueryListName==strSelectedQueryName)
    {
      alert("A query with this name already exists.\nPlease enter a new name for the query or choose Update Query to update an existing query");
      return false;
    }
  }
  return true;
}

// To show the comments in the textarea when the saved template  is retrieved.
function showCommentsEdit(formObj,selObjName,commentID)
{
  var strcommentvalue
  strcommentvalue = formObj.elements[selObjName].options[formObj.elements[selObjName].selectedIndex].comment;
  document.getElementById(commentID).value = strcommentvalue;
}
  
// To set the maxlength of the comments textarea.
function CheckMaxLength(obj,iLength)
{
  if(obj.innerText.length>iLength) event.keyCode=0;
}

//Function to round a number to the number of decimal places as specified by the parameter
function RoundOffDecimalNumber(lngNumber, lngDecPlaces)
{
  if (!lngDecPlaces || !lngNumber )  //parameter(s) undefined [parameters not passed] then return false
  {
    return false;
  } 
  if(isNaN(lngNumber)) // parameter not a number so return false
  {
    return false;
  }
  if (lngDecPlaces <= 0) // no. of dec. places parameter <=0 so return false
  {
    return (lngNumber);
  }
  else
  {
    return Math.round(lngNumber * Math.pow(10, lngDecPlaces)) / Math.pow(10, lngDecPlaces); //round the number
  }
}
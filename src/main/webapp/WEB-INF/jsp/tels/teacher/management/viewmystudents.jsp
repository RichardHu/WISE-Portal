<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html lang="en">

<title><spring:message code="viewmystudents.message" /></title>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teachergrading.css"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" media="screen" rel="stylesheet" type="text/css" /> 

<head>
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jqueryuisource"/>"></script>
<script type="text/javascript" src="<spring:theme code="utilssource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<!-- TODO: move to js file once js i18n is implemented for portal -->
<script type="text/javascript">

$(document).ready(function(){
	$(document).height('100%');
	
	$('#loading').dialog({
		autoOpen:false,
		width:300,
		height:110,
		modal:true,
		draggable:false,
		resizable:false,
		closeText:'',
		dialogClass:'no-title'
	});
	
	// setup tabs
	$( "#periodTabs" ).tabs({
		selected: ${tabIndex},
		create: function(event, ui) { setTimeout(function(){setGradingContentHeight();},1000); }
	});
	
	if (${workgroupsWithoutPeriod != ""}) {
		alert("You have workgroups that are not associated with periods. "
				+" Please talk to a WISE staff to fix this problem. ID: ${workgroupsWithoutPeriod}");
	}
	
	$(window).resize(function(){
		setGradingContentHeight();
	});
	
	$('#periodTabs').click(function(){
		setGradingContentHeight();
	});
	
	// set sortable items
	setSortable();
	
	// bind save button click to post workgroup changes
	$('#saveButton').click(function(){
		if(!$(this).hasClass('disabled')){
			var selectedTab = $('#periodTabs').tabs("option", "selected"); 
			postChanges(selectedTab);
		}
	});
	
	// setup student info dialog
	$('.studentInfo').live('click',function(){
		var title = $(this).attr('title');
		var username = $(this).attr('id').replace('studentInfo_','');
		var path = "/webapp/studentinfo.html?userName=" + username;
		var dialog = $('<div id="studentInfoDialog" style="overflow-y:hidden;"></div>');
		var div = dialog.html('<iframe id="studentInfoIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '600',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).remove(); },
			buttons: {
				Close: function(){$(this).dialog('close');}
			}
		});
		$("#studentInfoDialog > #studentInfoIfrm").attr('src',path);
	});
	
	// setup change password dialog
	$('.changePassword').live('click',function(){
		var title = $(this).attr('title');
		var username = $(this).attr('id').replace('changePassword_','');
		var path = "changestudentpassword.html?userName=" + username;
		var dialog = $('<div id="studentPasswordDialog" style="overflow-y:hidden;"></div>');
		var div = dialog.html('<iframe id="studentPasswordIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '650',
			height: '350',
			title: title,
			position: 'center',
			close: function(){ $(this).remove(); },
			buttons: {
				Close: function(){$(this).dialog('close');}
			}
		});
		$("#studentPasswordDialog > #studentPasswordIfrm").attr('src',path);
	});
	
	// setup change period dialog
	$('.changePeriod').live('click',function(){
		var title = $(this).attr('title');
		var data = $(this).attr('id').replace('changePeriod_','');
		var path = "changestudentperiod.html?" + data;
		var dialog = $('<div id="studentPeriodDialog" style="overflow-y:hidden;"></div>');
		var div = dialog.html('<iframe id="studentPeriodIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '650',
			height: '350',
			title: title,
			position: 'center',
			close: function(){
				// check if page reload is required (student period was changed)
				if(document.getElementById('studentPeriodIfrm').contentWindow['refreshRequired']){
					$('#loading').dialog('open');
					var newHREF = window.location.href + "&tabIndex=" + ${tabIndex} + "&refreshRequired=true";
					window.location.href = newHREF;
				}
				$(this).remove();
			},
			buttons: {
				Close: function(){$(this).dialog('close');}
			}
		});
		$("#studentPeriodDialog > #studentPeriodIfrm").attr('src',path);
	});
	
	// setup change period dialog
	$('.removeStudent').live('click',function(){
		var title = $(this).attr('title');
		var data = $(this).attr('id').replace('removeStudent_','');
		var path = "removestudentfromrun.html?" + data;
		var dialog = $('<div id="removeStudentDialog" style="overflow-y:hidden;"></div>');
		var div = dialog.html('<iframe id="removeStudentIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '650',
			height: '450',
			title: title,
			position: 'center',
			close: function(){
				// check if page reload is required (student was removed from the run)
				if(document.getElementById('removeStudentIfrm').contentWindow['refreshRequired']){
					$('#loading').dialog('open');
					var newHREF = window.location.href + "&tabIndex=" + ${tabIndex} + "&refreshRequired=true";
					window.location.href = newHREF;
				}
				$(this).remove();
			},
			buttons: {
				Close: function(){$(this).dialog('close');}
			}
		});
		$("#removeStudentDialog > #removeStudentIfrm").attr('src',path);
	});
	
	// setup change all passwords dialog
	$('.changeAllPasswords').live('click',function(){
		var title = $(this).attr('title');
		var data = $(this).attr('id').replace('changeAllPasswords_','');
		var path = "batchstudentchangepassword.html?" + data;
		var dialog = $('<div id="changeAllPasswordsDialog" style="overflow-y:hidden;"></div>');
		var div = dialog.html('<iframe id="changeAllPasswordsIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			modal: true,
			width: '650',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).remove(); },
			buttons: {
				Close: function(){$(this).dialog('close');}
			}
		});
		$("#changeAllPasswordsDialog > #changeAllPasswordsIfrm").attr('src',path);
	});
});

var newGroupCounts = {};
//var newGroupCount = 0;
var numPeriods = ${fn:length(viewmystudentsallperiods)};
var workgroupchanges = {};

var unsavedChanges = false;
var notifyTimeout;


var refreshRequired = <%= request.getParameter( "refreshRequired" ) %>;

<c:forEach var="viewmystudentsperiod" items="${viewmystudentsallperiods}" >
	var periodId=${viewmystudentsperiod.period.id};
	//workgroupchanges[periodId] = {};
	newGroupCounts[periodId] = 0;
</c:forEach>

var setSortable = function() {
	$( ".draglist" ).sortable({
		connectWith: ".draglist",
		cursor: 'move',
		forcePlaceholderSize: true,
		items: "li:not(.grouplessHeader, .workgroupHeader, .emptyGroup, .clone)",
		opacity: 0.7,
		placeholder: 'placeholder',
		update: registerWorkgroupChange,
		start: function(e, ui){
	        ui.placeholder.height(ui.item.height());
	    }
	}).disableSelection();
}

/**
 * Fix the height of the gradingContent div so to match the iframe (viewmystudents window)
 */
var setGradingContentHeight = function() {
	//get the height of the window
	var height = $(window).height();
	
	// set gradingContent height to fit bottom of screen
	var contentHeight = height - $('.gradingTools').outerHeight(true) - $('.studentManageHeader:visible').outerHeight(true);
	$('.gradingContent').height(contentHeight-28);
};

var createNewWorkgroup = function(periodId, runId) {
	//alert(newGroupCount);
	var newGroupCount = newGroupCounts[periodId];
	var newWorkgroupId = -1 - newGroupCount;
	var workareaDiv = document.getElementById("div_for_new_workgroups_"+periodId);
	workareaDiv.innerHTML += "<div class='workarea' id='newgroup_div_"+periodId+"_"+newWorkgroupId+"'>"
                          +"<ul id='ul_"+periodId+"_newgroup_"+newWorkgroupId+"' class='draglist'>"
                          +"<li class='workgroupHeader newWorkgroupHeader'><spring:message code='teacher.manage.viewstudents.27'/></li>"+
                          "<li class='emptyGroup'><spring:message code='teacher.manage.viewstudents.28'/></li></ul>"
                          +"</div>";
                         
	setSortable(); // re-register sortable elements to include new workgroup
                             
	newGroupCounts[periodId] = newGroupCount + 1;
};

/* adds workgroup change to workgroupchanges array */
var registerWorkgroupChange = function(event, ui){
	var draggable = ui.item;
	var split_ = draggable.attr('id').split('_');
	var workgroupFrom = split_[2];
	var userId = split_[1];
	var parent = draggable.parent();
    var parentSplit_ = parent.attr('id').split('_');
    var workgroupTo = parentSplit_[3];
    var periodId = parentSplit_[1];
    if(typeof workgroupchanges[periodId] == 'undefined'){
    	workgroupchanges[periodId] = {};
    }
    //console.log("periodId: " + periodId);
    //console.log("userId: " + userId);
    //console.log("workgroupFrom: " + workgroupFrom);
    if(workgroupFrom == workgroupTo){
    	ui.item.removeClass('changed');
		var cloneId = ui.item.attr('id') + '_clone';
		$('#' + cloneId).remove();
    	delete workgroupchanges[periodId][userId]; // no change necessary for student, was moved back into original workgroup
    	var numUsers = 0;
    	for(user in workgroupchanges[periodId]){
    		numUsers++;
    	}
    	if(numUsers == 0){ // no changes in that period so remove period from workgroupchanges
    		delete workgroupchanges[periodId];
    		var numPeriods = 0;
    		for(period in workgroupchanges){
    			numPeriods++;
    		}
    		if(numPeriods == 0){ // no changes in any periods, so disable save button
    			$('#saveButton').addClass('disabled');
    			unsavedChanges = false;
    		}
    	}
    } else {
    	if(!ui.item.hasClass('changed')){
    		var clone = ui.item.clone();
        	clone.addClass('clone');
        	var cloneId = clone.attr('id') + '_clone';
        	clone.attr('id',cloneId);
        	var originalParent = $('#ul_' + periodId + '_workgroup_' + workgroupFrom);
        	clone.appendTo(originalParent);
    	}
    	ui.item.addClass('changed');
		workgroupchanges[periodId][userId] = new Array();
   	    workgroupchanges[periodId][userId]["workgroupFrom"] = workgroupFrom;
   	    //consol e.log("workgroupTo: " + workgroupTo);
   		workgroupchanges[periodId][userId]["workgroupTo"] = workgroupTo;
   		//console.log(workgroupchanges);
   		unsavedChanges = true;
   		$('#saveButton').removeClass('disabled');
   		
   		// if workgroupFrom and workgroupTo are different, notify user that student data will change
   		if(workgroupFrom != 'groupless') { // student was groupless, no need to warn of data loss
	   		if(workgroupTo == 'groupless'){
	   			var notifyMsg = "<spring:message code='teacher.manage.viewstudents.notify.2'/>";
	   		} else if (parseInt(workgroupTo)<0){
	   			var notifyMsg = "<spring:message code='teacher.manage.viewstudents.notify.3'/>";
	   		} else {
	   			var notifyMsg = "<spring:message code='teacher.manage.viewstudents.notify.1'/>";
	   		}
   		
		   	// TODO: add notification if change results in an empty workgroup
	   		
	   		displayNotification(notifyMsg); // display notifications
   		}
    }
};

var postChanges = function(tabIndex){
	var postData = function(postdata){
   		var submitChangesUrl = "submitworkgroupchanges.html";
   		$.ajax({
   			type: "POST",
   			url: submitChangesUrl,
   			data: postdata,
   			success: checkPosts,
   			error: handleError
   		});
   	};

   	var checkPosts = function(data, textStatus, xhr){
   		if(i<numPosts-1){
   			//if(typeof data != "undefined"){
   				i++;
   	   			postData(postDataStrings[i]);
   			//} else {
   				//handleError(null,null,null);
   			//}
   		} else {
   			handleSuccess(data, textStatus, xhr);
   		}
   	};

   	// on successful posts, reload page
   	var handleSuccess = function(data, textStatus, xhr){
   		unsavedChanges = false;
   		var newHREF= window.location.href + "&tabIndex=" + data + "&refreshRequired=" + refreshRequired;
   	 	setTimeout("window.location.href='" +newHREF +"'", 500);
   	};

   	// on post error, alert user
   	var handleError = function(jqXHR, textStatus, errorThrown){
   		$('#loading').dialog('close');
   		alert('<spring:message code="teacher.manage.viewstudents.error.1"/>');
   	};
   	
   	var postDataStrings = new Array();
   	
   	for (periodId in workgroupchanges){
   		var changeIndex = 0;
   		var postString = 'tabIndex='+tabIndex +'&runId='+${run.id}+'&periodId='+periodId;
   		for (userId in workgroupchanges[periodId]) {         
   			var workgroupFrom = workgroupchanges[periodId][userId]["workgroupFrom"];
   			var workgroupTo = workgroupchanges[periodId][userId]["workgroupTo"];
   			postString += '&userId_'+changeIndex +'='+userId+'&workgroupFrom_'+changeIndex +'='+workgroupFrom+'&workgroupTo_'+changeIndex +'='+workgroupTo;
   			changeIndex++;
   		}
   		postString += '&numChanges=' + changeIndex;
   		postDataStrings.push(postString);
   	}
	
   	var numPosts = postDataStrings.length;
   	var i = 0;
   	postData(postDataStrings[i]);
   	$('#loading').dialog('open');
};

// displays notification messages/warnings
var displayNotification = function(message){
	var selectedTab = $('#periodTabs').tabs("option", "selected");
	var selected = selectedTab + 1;
	var toolbars = $('#period_' + selected + ' .studentManageHeader');
	var top = toolbars.offset().top + toolbars.outerHeight() + 7;
	// remove any existing notifications
	if($('#notifications')){
		$('#notifications').remove();
		if(notifyTimeout) clearTimeout(notifyTimeout);
	}
	var notificationDiv = $('<div id="notifications"></div>');
	var notificationSpan = $('<span></span>');
	var content = '<spring:message code="teacher.manage.viewstudents.notify"/> ' + message;
	notificationSpan.text(content);
	notificationSpan.appendTo(notificationDiv);
	notificationDiv.css({'top':top,"left":0,"right":0,"position":"absolute"}).appendTo($('.manageStudents'));
	$('.gradingContent').css({'margin-top':'2em','padding-top':'0'});
	notifyTimeout = setTimeout(function(){
		$('#notifications').remove();
		$('.gradingContent').css({'margin-top':'0','padding-top':'.5em'});
	},15000); // remove after 15 seconds
};

</script>

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="viewmystudentsstylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

</head>

<body style="background:#FFFFFF;overflow-y:hidden;">

	<div class="manageStudents">
		<div id="periodTabs">
			<div class="gradingTools">
				<div id="fixedGradingHeader" class="gradingHeader">
					<div>
						<a href="studentlist.html?runId=${run.id}" target="_blank"><img class="icon" alt="print" src="/webapp/themes/tels/default/images/icons/teal/print.png" /><span><spring:message code="teacher.manage.viewstudents.20"/></span></a>
						<a href="studentlistexcel.html?runId=${run.id}"><img class="icon" alt="excel" src="/webapp/themes/tels/default/images/icons/teal/addressbook.png" /><span><spring:message code="teacher.manage.viewstudents.22"/></span></a>
					</div>
					<div style="float:right;">
						<a class="saveButton disabled" id="saveButton" onclick=""><spring:message code="teacher.manage.viewstudents.24"/></a>
					</div>
				</div>
				
				<div id="periodSelect" class="gradingHeader">
					<div id="periodTabs" style="float:left;">
						<ul>
						<li><a style="color:#FFF;padding: 2px 0;text-decoration: none !important;cursor: text !important;margin-left: 0;"><spring:message code="teacher.manage.viewstudents.25"/> </a></li>
						<c:forEach var="viewmystudentsperiod" varStatus="periodStatus" items="${viewmystudentsallperiods}">
							<li><a href="#period_${viewmystudentsperiod.period.name}" class="periodChoice"><spring:message code="teacher.manage.viewstudents.23"/> ${viewmystudentsperiod.period.name}</a></li>
						</c:forEach>
						</ul>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
			
				<c:forEach var="viewmystudentsperiod" varStatus="periodStatus" items="${viewmystudentsallperiods}">
					<div id="period_${viewmystudentsperiod.period.name}">
					<c:choose>
						<c:when test="${fn:length(viewmystudentsperiod.period.members) == 0}">
							<div class="gradingHeader studentManageHeader">
								<ul id="periodHeaderBar">
						    		<li><span class="manageDataStyle"><spring:message code="teacher.manage.viewstudents.23"/>: ${viewmystudentsperiod.period.name}</span></li>
							    	<li><spring:message code="teacher.manage.viewstudents.3"/>&nbsp;<span class="manageDataStyle">${fn:length(viewmystudentsperiod.period.members)}</span></li>
							    	<li><spring:message code="teacher.manage.viewstudents.4"/>&nbsp;<span class="manageDataStyle">${fn:length(viewmystudentsperiod.workgroups)}</span></li>
							    	<li><spring:message code="teacher.manage.viewstudents.5"/>&nbsp;<span class="manageDataStyle">${viewmystudentsperiod.run.runcode}</span></li>
							    </ul>
							</div>
							<div class="gradingContent">
								<p class="info" style="font-size:1em;"><spring:message code="teacher.manage.viewstudents.2"/></p>
							</div>
						</c:when>
						<c:otherwise>
						    <!--  there are students in this period  -->
						    <div class="gradingHeader studentManageHeader">
						    	<ul id="periodHeaderBar">
						    		<li><span class="manageDataStyle"><spring:message code="teacher.manage.viewstudents.23"/>: ${viewmystudentsperiod.period.name}</span></li>
							    	<li><spring:message code="teacher.manage.viewstudents.3"/>&nbsp;<span class="manageDataStyle">${fn:length(viewmystudentsperiod.period.members)}</span></li>
							    	<li><spring:message code="teacher.manage.viewstudents.4"/>&nbsp;<span class="manageDataStyle">${fn:length(viewmystudentsperiod.workgroups)}</span></li>
							    	<li><spring:message code="teacher.manage.viewstudents.5"/>&nbsp;<span class="manageDataStyle">${viewmystudentsperiod.run.runcode}</span></li>
							    	<li style="float:right;">
							    		<a onclick="createNewWorkgroup(${viewmystudentsperiod.period.id}, ${viewmystudentsperiod.run.id});"><img class="icon" alt="new team" src="/webapp/themes/tels/default/images/icons/teal/multi-agents.png" /><span><spring:message code="teacher.manage.viewstudents.6"/></span></a>
							     		<a class="changeAllPasswords" id="changeAllPasswords_groupId=${viewmystudentsperiod.period.id}&runId=${viewmystudentsperiod.run.id}" title="<spring:message code="teacher.manage.viewstudents.36"/> <spring:message code="teacher.manage.viewstudents.23"/> ${viewmystudentsperiod.period.name}"><img class="icon" alt="password" src="/webapp/themes/tels/default/images/icons/teal/shield.png" /><span><spring:message code="teacher.manage.viewstudents.7"/></span></a>
							       		<a><spring:message code="teacher.manage.viewstudents.8"/></a>
							       	</li>
							    </ul>
							</div>
							<div class="gradingContent">
								<table class="manageStudentsTable">
									<tr>
									<td>
									<div class="workarea" id="groupless_div_${viewmystudentsperiod.period.id}">
									  <ul id="ul_${viewmystudentsperiod.period.id}_workgroup_groupless" class="draglist">
									    <li class="grouplessHeader"><spring:message code="teacher.manage.viewstudents.17"/></li>
						
						                <c:forEach var="mem" items="${viewmystudentsperiod.grouplessStudents}">
									      <li class="grouplesslist" id="li_${mem.id}_groupless">
									      
									         <span class="userNameWithinView">${mem.userDetails.firstname} ${mem.userDetails.lastname} (${mem.userDetails.username})</span>
						    			     <span class="userLinksBar">
						    			     <a class="userLinks studentInfo" id="studentInfo_${mem.userDetails.username}" title="<spring:message code="teacher.manage.viewstudents.32"/> ${mem.userDetails.username}"><spring:message code="teacher.manage.viewstudents.29"/></a>
						    			     <a class="userLinks changePassword" id="changePassword_${mem.userDetails.username}" title="<spring:message code="teacher.manage.viewstudents.33"/> ${mem.userDetails.username}"><spring:message code="teacher.manage.viewstudents.30"/></a>
						    			     <a class="userLinks changePeriod" id="changePeriod_userId=${mem.id}&runId=${viewmystudentsperiod.run.id}&projectCode=${viewmystudentsperiod.period.name}" title="<spring:message code="teacher.manage.viewstudents.34"/> ${mem.userDetails.username}"><spring:message code="teacher.manage.viewstudents.23"/></a>
						    			     <a class="userLinks removeStudent" id="removeStudent_runId=${viewmystudentsperiod.run.id}&userId=${mem.id}" title="<spring:message code="teacher.manage.viewstudents.35"/> ${mem.userDetails.username}"><spring:message code="teacher.manage.viewstudents.31"/></a>
						    			     </span>
						    			  </li>
									    </c:forEach>
						  			  </ul>
									</div>
									</td>
									<td>
									<div id="div_for_new_workgroups_${viewmystudentsperiod.period.id}"></div>
									</td>
									</tr>
									<tr>
						            <c:forEach var="workgroupInPeriod" varStatus="workgroupVarStatus" items="${viewmystudentsperiod.workgroups}" >
						                <td>
						              <div class="workarea" id="div_${workgroupInPeriod.id}">
									    <ul id="ul_${viewmystudentsperiod.period.id}_workgroup_${workgroupInPeriod.id}" class="draglist">  
									      <li class="workgroupHeader"><spring:message code="teacher.manage.viewstudents.26"/> ${workgroupInPeriod.id}
									        <!-- <a class="createPdfLink" href="${workgroupInPeriod.workPDFUrl}"><spring:message code="teacher.manage.viewstudents.18"/></a>   -->
									      </li>
									      
									      <c:forEach var="workgroupMember" items="${workgroupInPeriod.members}">
									      
									        <li class="workgrouplist" id="li_${workgroupMember.id}_${workgroupInPeriod.id}">
									         <span class="userNameWithinView">${workgroupMember.userDetails.firstname} ${workgroupMember.userDetails.lastname} (${workgroupMember.userDetails.username})</span>
						    			     <span class="userLinksBar">
						    			     <a class="userLinks studentInfo" id="studentInfo_${workgroupMember.userDetails.username}" title="<spring:message code="teacher.manage.viewstudents.32"/> ${workgroupMember.userDetails.username}"><spring:message code="teacher.manage.viewstudents.29"/></a>
						    			     <a class="userLinks changePassword" id="changePassword_${workgroupMember.userDetails.username}" title="<spring:message code="teacher.manage.viewstudents.33"/> ${workgroupMember.userDetails.username}"><spring:message code="teacher.manage.viewstudents.30"/></a>
						    			     <a class="userLinks changePeriod" id="changePeriod_userId=${workgroupMember.id}&runId=${viewmystudentsperiod.run.id}&projectCode=${viewmystudentsperiod.period.name}" title="<spring:message code="teacher.manage.viewstudents.34"/> ${workgroupMember.userDetails.username}"><spring:message code="teacher.manage.viewstudents.23"/></a>
						    			     <a class="userLinks removeStudent" id="removeStudent_runId=${viewmystudentsperiod.run.id}&userId=${workgroupMember.id}" title="<spring:message code="teacher.manage.viewstudents.35"/> ${workgroupMember.userDetails.username}"><spring:message code="teacher.manage.viewstudents.31"/></a>
						    			     </span>
									        </li>
									      </c:forEach>
									    </ul>
									   </div>
						                 </td>                
						                <c:choose>
						                    <c:when test="${workgroupVarStatus.index % 2 == 1}" >
						                      </tr><tr>
						                    </c:when>
						                    <c:otherwise>
						                    </c:otherwise>
						              </c:choose>
						            </c:forEach>
						            </tr>
					            </table>
								</div>
				     
						</c:otherwise>
					</c:choose>
					</div>
			    </c:forEach>
		</div>
	</div>
 	<div id="loading" style="display:none;">
        <div class="hd"><spring:message code="teacher.manage.viewstudents.message.1"/></div>
        <div class="bd"><img src="/vlewrapper/vle/images/loading.gif"></div>
        <div class="ft">
        </div>
    </div>
</body>
</html>
</html>
<%@ include file="../../../include.jsp"%>

<!-- $Id: setupRun3.jsp 357 2007-05-03 00:49:48Z archana $ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="jquerystylesheet"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script src="<spring:theme code="jqueryuisource"/>" type="text/javascript"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<%@ include file="../../grading/styles.jsp"%>

<title><spring:message code="teacher.setup-project-run-step-four" /></title>

<script type="text/javascript">
        var doneClicked=false;

    	//preload image if browser is not IE because animated gif will just freeze if user is using IE
    	if(navigator.appName != "Microsoft Internet Explorer") {
    		loadingImage = new Image();
    		loadingImage.src = "/webapp/themes/tels/default/images/rel_interstitial_loading.gif";
    	}
    	
        YAHOO.namespace("example.container");

        function init() {

            if (!YAHOO.example.container.wait) {

                // Initialize the temporary Panel to display while waiting for external content to load

                YAHOO.example.container.wait = 
                        new YAHOO.widget.Panel("wait",  
                                                        { width: "240px", 
                                                          fixedcenter: true, 
                                                          close: false, 
                                                          draggable: false, 
                                                          zindex:4,
                                                          modal: true,
                                                          visible: false
                                                        } 
                                                    );

                //YAHOO.example.container.wait.setHeader("Loading, please wait...");
                YAHOO.example.container.wait.setBody("<table><tr align='center'>Loading, please wait...</tr><tr align='center'><img src=/webapp/themes/tels/default/images/rel_interstitial_loading.gif /></tr><table>");
                YAHOO.example.container.wait.render(document.body);

            }

            // Define the callback object for Connection Manager that will set the body of our content area when the content has loaded



            var callback = {
                success : function(o) {
                    //content.innerHTML = o.responseText;
                    //content.style.visibility = "visible";
                    YAHOO.example.container.wait.hide();
                },
                failure : function(o) {
                    //content.innerHTML = o.responseText;
                    //content.style.visibility = "visible";
                    //content.innerHTML = "CONNECTION FAILED!";
                    YAHOO.example.container.wait.hide();
                }
            }
        
            // Show the Panel
            YAHOO.example.container.wait.show();
            
            // Connect to our data source and load the data
            //var conn = YAHOO.util.Connect.asyncRequest("GET", "assets/somedata.php?r=" + new Date().getTime(), callback);
        };
        
    	/**
		 * copies project and then create run with the new project
		 * @param pId project id
		 * @param type the project type e.g. "LD"
		 * @param name the project name
		 * @param fileName the project file name e.g. "wise4.project.json"
		 * @param relativeProjectFilePathUrl the relative project file path e.g. "/513/wise4.project.json"
		 * @return true iff project was successfully copied. 
		 */
    	function createRun(pID, type, projectName, fileName, relativeProjectFilePathUrl) {
        	// ensure that project doesn't get copied multiple times
        	if (!doneClicked) {
            	doneClicked=true;
    			var result = copy(pID, type, projectName, fileName, relativeProjectFilePathUrl);
    			if (!result) {
        			alert('There was an error creating the run. Please contact WISE.');
    			}
    			return result;
        	}
    	};
    	
    	/**
		 * asynchronously copies project
		 * @param pId project id
		 * @param type the project type e.g. "LD"
		 * @param name the project name
		 * @param fileName the project file name e.g. "wise4.project.json"
		 * @param relativeProjectFilePathUrl the relative project file path e.g. "/513/wise4.project.json"
		 * @return true iff project was successfully copied. 
		 */
        function copy(pID, type, projectName, fileName, relativeProjectFilePathUrl){
        	//projectName = escape(projectName);
			projectName = encodeURIComponent(projectName); //modified by Richard 2012/1/16
            var isSuccess = false;
            var newProjectId = null;
   			if(type=='LD'){
   	   			//calls filemanager to copy project folder contents
   	   			$.ajax({
   	   	   				url: '/webapp/author/authorproject.html',
   	   	   	   			async: false,
   	   	   	   			type:"POST",
   	   	   	   			data:'forward=filemanager&projectId=' + pID + '&command=copyProject',
   	   	   	   			dataType:'text',
   	   	   	   			success: function(returnData){
   							/*
							 * returnData is the new project folder
							 * e.g.
							 * 513
							 */
							
							/*
							 * get the relative project file path for the new project
							 * e.g.
							 * /513/wise4.project.json
							 */ 
   							var projectPath = '/' + returnData + '/' + fileName;
   							
   							//call to make the project on the portal with the new folder
   							$.ajax({
   	   							url:"/webapp/author/authorproject.html",
   	   							async:false,
   	   							type:"POST",
   	   							data:'command=createProject&parentProjectId='+pID+'&projectPath=' + projectPath + '&projectName=' + projectName,
   	   							dataType:'text',
   	   							success:function(returnData){
   	   								isSuccess = true;
   	   								newProjectId = returnData;
   	   								$("#newProjectId").attr("value", newProjectId);
									//alert('The LD project has been successfully copied with the name Copy of ' + projectName + '. The project can be found in the My Projects section.');
								},
   	   	   						error:function(returnData){alert('Project files were copied but the project was not successfully registered in the portal.');}
   							});
   						},
   	   	   	   	   		error:function(returnData){alert('Could not copy project folder.');}
   	   			});
			    return isSuccess;   	   			
   			} else {
   				var callback = {
   					success:function(o){alert(o.responseText);},
   					failure:function(o){alert('copy: failed update to server');}
   				};
   				YAHOO.util.Connect.asyncRequest('GET', 'copyproject.html?projectId=' + pID, callback);
   			};
    	};
    	
    	
    	
   	// Set up view project details click action for each project id link
	$('a.projectDetail').live('click',function(){
		var title = $(this).attr('title');
		var projectId = $(this).attr('id').replace('projectDetail_','');
		var path = "/webapp/teacher/projects/projectinfo.html?projectId=" + projectId;
		var div = $('#projectDetailDialog').html('<iframe id="projectIfrm" width="100%" height="100%"></iframe>');
		div.dialog({
			width: '800',
			height: '400',
			title: title,
			position: 'center',
			close: function(){ $(this).html(''); },
			buttons: {
				Close: function(){
					$(this).dialog('close');
				}
			}
		});
		$("#projectDetailDialog > #projectIfrm").attr('src',path);
	});
</script>

</head>
<body>

<div id="pageWrapper">

	<%@ include file="../../../headermain.jsp"%>
		
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
	<div id="page">
			
		<div id="pageContent">
			
			<div class="contentPanel">
				<div class="panelHeader">
					<spring:message code="teacher.setup-project-classroom-run" />
					<span class="pageTitle"><spring:message code="header.location.teacher.management"/></span>
				</div>
				<div class="panelContent">
					<div id="reviewRunBox">
						<div id="stepNumber" class="sectionHead"><spring:message code="teacher.run.setup.32"/>&nbsp;<spring:message code="teacher.run.setup.33"/></div>
						<div class="sectionContent">
	
							<h5 style="color:red;"><spring:message code="teacher.view-lesson-plan" htmlEscape="true" /></h5>
	
							<ol>
								<li><spring:message code="teacher.run.setup.34"/> <a id="projectDetail_${projectId}" class="projectDetail" title="Project Details"><spring:message code="teacher.run.setup.35"/></a>&nbsp;<spring:message code="teacher.run.setup.36"/></li>
							
								<li><spring:message code="teacher.run.setup.52"/> <a href="<c:url value="/previewproject.html"><c:param name="projectId" value="${projectId}"/></c:url>" target="_blank">
										<spring:message code="teacher.run.setup.53"/></a> <spring:message code="teacher.run.setup.54"/></li>
									
								<li><spring:message code="teacher.run.setup.55"/></li>
							</ol>
	
							<h5><spring:message code="teacher.run.setup.45"/></h5>
						</div>
					</div>
	
					<form method="post" class="center" onSubmit="return createRun('${projectId}','${projectType}','<c:out value="${projectName}" />','${projectJSONFilename}','${srcProjectRootFolder}')">
						<input type="submit" name="_target3" value="<spring:message code="navigate.back" />" />
						<input type="submit" name="_cancel" value="<spring:message code="navigate.cancel" />" />
						<input type="submit" id="submit_form" name="_finish" value="<spring:message code="navigate.done" />" />
						<input type="hidden" id="newProjectId" name="newProjectId" value="" />
					</form>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>
	</div>   <!-- End of page-->

	<%@ include file="../../../footer.jsp"%>
</div>
</body>
</html>
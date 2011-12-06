<%@ include file="include.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>

<!-- $Id$ -->

<!DOCTYPE html>
<html>
<head>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
	Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="chrome=1"/>

<link href="<spring:theme code="globalstyles"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jqueryjscrollpane.css"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="jquerystylesheet"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="nivoslider.css"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="nivoslider-wise.css"/>" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="tinycarousel.css"/>" rel="stylesheet" type="text/css" />

<script src="<spring:theme code="jquerysource"/>" type="text/javascript"></script>
<script src="<spring:theme code="jqueryuisource"/>" type="text/javascript"></script>
<script src="<spring:theme code="jquerymousewheel.js"/>" type="text/javascript"></script>
<!-- <script src="<spring:theme code="mwheelintent.js"/>" type="text/javascript"></script>  -->
<script src="<spring:theme code="jqueryjscrollpane.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="nivoslider.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="easyaccordion.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="tinycarousel.js"/>" type="text/javascript"></script>
<script src="<spring:theme code="generalsource"/>" type="text/javascript"></script>

<script type="text/javascript">
	// bind welcome text links to swap message function
	$(document).ready(function(){
		
		//focus cursor into the First Name field on page ready 
		if($('#j_username').length){
			$('#j_username').focus();
		}
		
		$('#newsContent').jScrollPane();
		
		$('.tinycarousel').tinycarousel({ axis: 'y', pager: true, duration:500 });
		
		loadProjectThumbnails();
		
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
	});
	
	$(window).load(function() {
		
		// initiate showcase slider
		$('#showcaseSlider').nivoSlider({
			effect:'sliceDownRight',
			animSpeed:500,
			pauseTime:10000,
			prevText: '>',
	        nextText: '<',
	        directionNav: false,
	        beforeChange: function(){
	        	$('#about .panelHead span').fadeOut('slow');
	        },
	        afterChange: function(){
	        	var active = $('#showcaseSlider').data('nivo:vars').currentSlide;
	        	$('#about .panelHead span').text($('#showcaseSlider > img').eq(active).attr('alt'));
	        	$('#about .panelHead span').fadeIn('fast');
	        }
		});
		
		// set random opening slide for project showcase
		var numSlides = $('#projectShowcase dt').length;
		var start = Math.floor(Math.random()*numSlides);
		$('#projectShowcase dt').eq(start).addClass('activea');
		
		// initiate project showcase accordion
		$('#project-showcase').easyAccordion({ 
		   autoStart: false,
		   slideNum: false	
		});
	});
	
	// load thumbnails for each project by looking for curriculum_folder/assets/project_thumb.png (makes a ajax GET request)
	// If found (returns 200 status), it will replace the default image with the fetched image.
	// If not found (returns 400 status), it will do nothing, and the default image will be used.
	function loadProjectThumbnails() {		
		$(".projectThumb").each(
			function() {
				var thumbUrl = $(this).attr("thumbUrl");
				// check if thumbUrl exists
				$.ajax({
					url:thumbUrl,
					context:this,
					statusCode: {
						200:function() {
				  		    // found, use it
							$(this).html("<img src='"+$(this).attr("thumbUrl")+"' alt='thumb'></img>");
						},
						404:function() {
						    // not found, leave alone
							//$(this).html("<img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></img>");
						}
					}
				});
			});
	};
</script>

<link rel="shortcut icon" href="<spring:theme code="favicon"/>" />

<title><spring:message code="application.title" /></title>

<!--NOTE: the following scripts has CONDITIONAL items that only apply to IE (MattFish)-->
<!--[if lt IE 7]>
<script defer type="text/javascript" src="./javascript/tels/iefixes.js"></script>
<![endif]-->

<!--[if lt IE 8]>
<link href="<spring:theme code="ie7homestyles"/>" rel="stylesheet" type="text/css" />
<![endif]-->

</head>

<body>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
	
	<div id="page">
		
		<div id="pageContent">
		
			<div class="showcase">
				<div id="about">
					<div class="panelHead"><span><spring:message code="whatiswiseheader" /></span></div>
					<div class="slider-wrapper theme-wise">
   				 		<div class="ribbon"></div>
						<div id="showcaseSlider">
						    <img src="/webapp/themes/tels/default/images/home/whatiswise.png" alt="<spring:message code="whatiswiseheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/curriculumbased.png" alt="<spring:message code="curriculumbasedheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/inquiry.png" alt="<spring:message code="inquiryprojectsheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/engagement.png" alt="<spring:message code="studentengagementheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/interactive.png" alt="<spring:message code="interactivemodelsheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/teachertools.png" alt="<spring:message code="teachertoolsheader" />" />
						    <img src="/webapp/themes/tels/default/images/home/opensource.png" alt="<spring:message code="freeandopensourceheader" />" />
						</div>
					</div>
				</div>
				<div id="news">
					<div class="panelHead"><spring:message code="home.latestnewslabel" /><!-- <a class="panelLink" title="News Archive">more news +</a> --></div>
					<div id="newsContent">
						<c:forEach var="newsItem" items="${newsItems}">
							<p class="newsTitle">${newsItem.title}<span class="newsDate"><fmt:formatDate value="${newsItem.date}" type="date" dateStyle="medium" /></span></p>
							<p class="newsSnippet">${newsItem.news}</p>
						</c:forEach>
					</div>
					<div id="socialLinks">
						<a href="http://www.facebook.com/pages/WISE-4/150541171679054" title="Find us on Facebook"><img src="/webapp/themes/tels/default/images/home/facebook.png" alt="facebook" /></a>
						<a href="" title="Follow us on Twitter" ><img src="/webapp/themes/tels/default/images/home/twitter.png" alt="twitter" /></a>
					</div>
				</div>
			</div>
			
			<div class="showcase">
				<div id="projectHeader" class="feature"><span class="featureContent">WISE專案</span><a class="projectsLink" href="/webapp/previewprojectlist.html" title="WISE Project Library">瀏覽WISE課程</a></div>
				<div id="features">
					<div id="featureHeader" class="feature"><span class="featureContent">WISE特色</span></div>
					<div id="featuresContent">
						<p><a href="/webapp/pages/features.html">學習環境 +</a></p>
						<p><a href="/webapp/pages/teacher-tools.html">教師工具 +</a></p>
						<p><a href="/webapp/pages/gettingstarted.html">開始體驗 +</a></p>
						<p id="checkCompatibility"><a href="/webapp/check.html">電腦相容性確認 +</a></p>
					</div>
				</div>
				<div id="projectShowcase">
					<div id="project-showcase">
						<dl>
							<dt>地球科學</dt>
						    <dd>
						    	<div class="tinycarousel"> 
							    	<a href="#" class="buttons prev"></a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${esProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a id="projectDetail_${project.id}" class="projectDetail" title="Project Details">More Details +</a><a href="/webapp/previewproject.html?projectId=${project.id}" target="_blank">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${esProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>生命科學</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${lsProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a id="projectDetail_${project.id}" class="projectDetail" title="Project Details">More Details +</a><a href="/webapp/previewproject.html?projectId=${project.id}" target="_blank">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${lsProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>自然科學</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${psProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a id="projectDetail_${project.id}" class="projectDetail" title="Project Details">More Details +</a><a href="/webapp/previewproject.html?projectId=${project.id}" target="_blank">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${psProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>生物學</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${bioProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a id="projectDetail_${project.id}" class="projectDetail" title="Project Details">More Details +</a><a href="/webapp/previewproject.html?projectId=${project.id}" target="_blank">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${bioProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>化學</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${chemProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a id="projectDetail_${project.id}" class="projectDetail" title="Project Details">More Details +</a><a href="/webapp/previewproject.html?projectId=${project.id}" target="_blank">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${chemProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
						    <dt>物理學</dt>
						    <dd>
						    	<div class="tinycarousel">
							    	<a href="#" class="buttons prev">&#9650;</a>
								    <div class="viewport">
								        <ul class="overview">
									    	<c:forEach var="project" items="${physProjects}">
									    		<li class="libraryProject">
									    			<div class="projectThumb" thumbUrl="${projectThumbMap[project.id]}"><img src='/webapp/themes/tels/default/images/projectThumb.png' alt='thumb'></div>
										    		<div class="projectDetails">
										    			<p class="name">${project.name}</p>
								      					<p class="metadata">Grades ${project.metadata.gradeRange} | ${project.metadata.totalTime} | ${project.metadata.language}</p>
								      					<p class="summary">${project.metadata.summary}</p>
								      				</div>
								      				<div class="projectLink"><a id="projectDetail_${project.id}" class="projectDetail" title="Project Details">More Details +</a><a href="/webapp/previewproject.html?projectId=${project.id}" target="_blank">Preview</a></div>
									    		</li>
									    	</c:forEach>
									    </ul>
									</div>
									<a href="#" class="buttons next">&#9660;</a>
								    <ul class="pager">
								    	<c:forEach var="project" items="${physProjects}" varStatus="status">
								        	<li><a rel="${status.count-1}" class="pagenum" href="#">${status.count}</a></li>
										</c:forEach>
								    </ul>
							    </div>
						    </dd>
					   </dl>
					  </div>
				</div>
				<div style="clear:both;"></div>
			</div>
			
			<div class="showcase">
				<a id="wiseAdvantage" href="/webapp/pages/wise-advantage.html" class="panelSection">
					<div class="panelHead"><span>WISE優勢</span><span class="panelLink">+</span></div>
					<div class="panelContent"><img src="/webapp/themes/tels/default/images/home/wise-in-classroom.png" alt="WISE in Classroom" /></div>
				</a>
				<a id="wiseInAction" href="/webapp/pages/wise-in-action.html" class="panelSection">
					<div class="panelHead"><span>行動中的WISE</span><span class="panelLink">+</span></div>
					<div class="panelContent"><img src="/webapp/themes/tels/default/images/home/wise-teaching.png" alt="WISE Students & Teacher" /></div>
				</a>
				<a id="researchTech" href="/webapp/pages/research-tech.html" class="panelSection">
					<div class="panelHead"><span>研究與科技</span><span class="panelLink">+</span></div>
					<div class="panelContent"><img src="/webapp/themes/tels/default/images/home/wise-research.jpg" alt="WISE Research" /></div>
				</a>
				<div style="clear:both;"></div>
			</div>
			
			<div id="bottomLinks" class="showcase">
				<div id="telsLink"><a href="http://telscenter.org" target="_blank"><img src="/webapp/themes/tels/default/images/home/tels.png"/></a></div>
				<div id="telsLinkLabel">Powered by the TELS Community</div>
				<div id="openSourceHeader" class="feature">
					<span class="featureContent">WISE開放原始碼夥伴</span>
				</div>
				<div id="openSourceContent">WISE software is free to use and open source. Visit <a href="http://wise4.org" target="_blank">http://wise4.org</a> to learn about partnership opportunities.</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</div>
<div id="projectDetailDialog" style="overflow:hidden;" class="dialog"></div>
</body>

</html>


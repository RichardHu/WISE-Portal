<%@ include file="../include.jsp"%>

<!-- $Id$ -->

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<title><spring:message code="teacher.run.manage.startrun.1"/></title>
</head>

<body style="background:#FFF;">

<div class="dialogContent">		

	<div class="sectionHead"><spring:message code="teacher.run.manage.startrun.1"/></div>

	<form:form method="post" action="startRun.html" commandName="startRunParameters" id="startRun" autocomplete='off'>
	  <div class="sectionContent">
	  	<label for="runId"><spring:message code="teacher.run.manage.startrun.5"/></label>
	    <form:input disabled="true" path="runId" id="runId"/>
	    <form:errors path="runId" />
	  </div>
		
		<!-- Support for Spring errors object -->
		<div class="errorMsgNoBg">
			<!-- Support for Spring errors object -->
			<spring:bind path="startRunParameters.*">
		  		<c:forEach var="error" items="${status.errorMessages}">
		   			 <p><c:out value="${error}"/></p>
		   		</c:forEach>
			</spring:bind>
		</div>

		<div class="sectionContent">
			<input type="submit" name="cancelarchive" value="<spring:message code="teacher.run.manage.startrun.6"/>" />
		</div>
		
	</form:form>
</div>
</body>
</html>
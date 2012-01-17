<%@ include file="../../../include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherprojectstylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherhomepagestylesheet" />" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="teacherrunstylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>
<script type="text/javascript" src="<spring:theme code="jquerycookiesource"/>"></script>
<script type="text/javascript" src="<spring:theme code="generalsource"/>"></script>

<script src="/webapp/javascript/tels/effects.js" type="text/javascript" ></script>
<script src="/webapp/javascript/tels/prototype.js" type="text/javascript" ></script>
<script src="/webapp/javascript/tels/scriptaculous.js" type="text/javascript" ></script>


<title><spring:message code="teacher.setup-project-run-step-three" /></title>

</head>

<!-- Support for Spring errors object -->
<spring:bind path="runParameters.postLevel">
  <c:forEach var="error" items="${status.errorMessages}">
    <c:choose>
      <c:when test="${fn:length(error) > 0}" >
        <script type="text/javascript">
          <!--
            alert("${error}");
          //-->
        </script>
      </c:when>
    </c:choose>
  </c:forEach>
</spring:bind>

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
				<form:form method="post" commandName="runParameters" autocomplete='off'>
					<div class="panelContent">
						<div id="setUpRunBox">
							<div id="stepNumber" class="sectionHead"><spring:message code="teacher.run.setup.28.1"/>&nbsp;<spring:message code="teacher.run.setup.28.2"/></div>
							<div class="sectionContent">

								<h5><spring:message code="teacher.run.setup.28.3"/><spring:message code="teacher.run.setup.28.4"/>.</h5>


								<h5 style="margin:.5em;">
									在這個專題每台電腦分配幾位學生？<br/>
									<form:radiobutton path="maxWorkgroupSize" value='1'/>每台電腦分配1位學生<br/>
									<form:radiobutton path="maxWorkgroupSize" value='3'/>每台電腦分配1、2或3位學生
								</h5>
								<h5 style="margin:.5em;">
									選擇執行專題的儲存等級<br/>
									<c:choose>
										<c:when test="${minPostLevel==5}">
											<br/>
											這個專題的作者需要以最高等級記錄學生資料。如果您<br/>
											不想這樣設定請 <a href="webapp/contactwisegeneral.html">聯絡WISE</a><br/>
										</c:when>
										<c:otherwise>	
											<c:forEach var='postLevel' items='${implementedPostLevels}'>
												<c:if test="${postLevel >= minPostLevel}">
													<form:radiobutton path='postLevel' value='${postLevel}'/>${postLevelTextMap[postLevel]}<br/>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</h5>
							</div>
						</div>
						<div class="center">
							<input type="submit" name="_target2" value="<spring:message code="navigate.back"/>" />
							<input type="submit" name="_cancel" value="<spring:message code="navigate.cancel"/>" />
							<input type="submit" name="_target4" value="<spring:message code="navigate.next"/>" />
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page-->

	<%@ include file="../../../footer.jsp"%>
</div>
</body>
</html>
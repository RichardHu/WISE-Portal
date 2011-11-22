<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />

<title><spring:message code="teacher.manage.changeperiod.1"/></title>

</head>
<body style="background:#FFF;">

<div class="dialogContent">		

	<div class="sectionHead"><spring:message code="teacher.manage.changeperiod.1"/></div>
	
	<form:form method="post" action="changestudentperiod.html" commandName="changePeriodParameters" id="changestudentperiod" autocomplete='off'>
		<div class="sectionContent">
			<span style="color:#ff0000;"><spring:message code="teacher.manage.changeperiod.7"/></span>
		</div>
		<div class="sectionContent">
			<table style="margin:0 auto;">
				<!-- <tr>
					<th><spring:message code="teacher.manage.changeperiod.2"/></th>
					<td>${changePeriodParameters.student.sdsUser.firstName} ${changePeriodParameters.student.sdsUser.lastName}</td>
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.changeperiod.3"/></th>
					<td>${changePeriodParameters.student.sdsUser.userName}</td>
				</tr> -->
				<tr>
					<th><spring:message code="teacher.manage.changeperiod.4"/></th>
					<td>${changePeriodParameters.projectcode}</td>
				</tr>
				<tr>
					<th><spring:message code="teacher.manage.changeperiod.5"/></th>
					<td><form:select path="projectcodeTo" id="projectcodeTo">
						<c:forEach items="${changePeriodParameters.run.periods}" var="period">
							<form:option value="${period.name}">
								${period.name}
							</form:option>
						</c:forEach>
						</form:select>	
						<br/>
					</td> 
				</tr>
			</table>
		</div>
	
	    <div class="sectionContent" style="text-align:center;">
	    	<input type="submit" value="<spring:message code="wise.save-changes"/>"/>
	    </div>
	</form:form>
</div>

</body>
</html>
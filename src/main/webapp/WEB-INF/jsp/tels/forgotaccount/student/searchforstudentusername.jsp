<%@ include file="include.jsp"%>
<!--
  * Copyright (c) 2006 Encore Research Group, University of Toronto
  * 
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
  * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-->

<!-- $Id: login.jsp 341 2007-04-26 22:58:44Z hiroki $ -->
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" /> 
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />	

<title><spring:message code="student.enterprojectcode.1"/></title>

</head>

<body>

<div id="pageWrapper">
	
	<div id="page">
		
		<div id="pageContent" style="min-height:400px;">
			<div id="headerSmall">
				<a id="name" href="/webapp/index.html" title="WISE Homepage">WISE</a>
			</div>
			
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="student.enterprojectcode.2"/></div>
				<div class="infoContentBox">
					<div><spring:message code="student.enterprojectcode.3"/></div>
					<div class="instructions"><spring:message code="searchforstudentusername.1"/></div>
					<div>
						<form:form name="projectCode" method="post" commandName="reminderParameters" autocomplete='off'>
							<table width="100%" style="border-collapse:separate;border-spacing:10px">
								<tr>
									<td align="right"><label id="firstNameLabel" for="firstName"><spring:message code="signup.firstname"/></label></td>
									<td align="left"><form:input path="firstName" id="firstName" tabindex="1"/></td>	
								</tr>
								<tr>
									<td align="right"><label id="lastNameLabel" for="lastName"><spring:message code="signup.lastname"/></label></td>
									<td align="left"><form:input path="lastName" id="lastName" tabindex="2" /></td>
								</tr>
								<tr>
									<td align="right"><label for="birthMonth"><spring:message code="searchforstudentusername.2"/></label></td>
									<td align="left">
										<form:select path="birthMonth" id="birthMonth" tabindex="3">
										<c:forEach var="month" begin="1" end="12" step="1">
											<option value="${month}">
												<spring:message code="birthmonths.${month}" />
											</option>
										</c:forEach>
									    </form:select>
									</td>
								</tr>
								<tr>
									<td align="right"><label for="birthDay"><spring:message code="searchforstudentusername.3"/></label></td>
									<td align="left">
										<form:select path="birthDay" id="birthDay" tabindex="4">
											 <c:forEach var="date" begin="1" end="31" step="1">
												  <option value="${date}">
												  		<spring:message code="birthdates.${date}" />
											  	  </option>
										  </c:forEach>
									    </form:select>
									</td>
								</tr>
								<tr><td colspan=2 align="center"><input type="submit" value="Search" tabindex="5" /></td></tr>
					 		</table>
						</form:form>
					</div>
					<div class="errorMsgNoBg">
						<!-- Support for Spring errors object -->
						<spring:bind path="reminderParameters.*">
						  	<c:forEach var="error" items="${status.errorMessages}">
						    	<p><c:out value="${error}"/></p>
							  </c:forEach>
						</spring:bind>
					</div>
				</div>
				<a href="/webapp/index.html" title="WISE Home"><spring:message code="selectaccounttype.7"/></a>
			</div>
		</div>
	</div>
</div>

</body>
</html>

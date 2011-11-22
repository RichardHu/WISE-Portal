<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet"  type="text/css" />
    
<title><spring:message code="contactwise.1" /></title>
</head>
<body>

<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
		
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="contactwise.2"/></div>
				<div class="infoContentBox">
					<div><spring:message code="contactwise.3" /></div>
					<div><spring:message code="contactwise.4" /></div>
					<div><spring:message code="contactwise.5" /></div>
				</div>
				<a href="/webapp/index.html" title="WISE Home"><spring:message code="selectaccounttype.7"/></a>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>   <!-- End of page -->
	
	<%@ include file="footer.jsp"%>
</div>
</body>
</html>
<%@ include file="include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "XHTML1-s.dtd" />
<html xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet"
    type="text/css" />
    
<title><spring:message code="application.title" /></title>
<script type='text/javascript'>
function refreshParent(){
	if(window.opener){
		window.opener.location.reload();
		self.close();
	};
};

var refreshRequired = true;
</script>

</head>

<!-- <body onload='refreshParent()'>  -->
<body style="background:#FFF;">

	<div class="dialogContent">
		<div class="dialogSection">
			<div class="errorMsgNoBg"><p><spring:message code="teacher.manage.changeperiod.6"/></p></div>
		</div>
	</div>

</body>
</html>
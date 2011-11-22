<%@ include file="include.jsp"%>

<!DOCTYPE html>
<html xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<link href="<spring:theme code="globalstyles"/>" media="screen" rel="stylesheet"  type="text/css" />
<link href="<spring:theme code="homepagestylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<spring:theme code="jquerysource"/>"></script>

<title><spring:message code="contactwiseproject.1"/></title>
<link href="<spring:theme code="stylesheet"/>" media="screen" rel="stylesheet" type="text/css" />
<%@ include file="teacher/grading/styles.jsp"%>
</head>
<body>

<script type="text/javascript">

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
    }

    YAHOO.util.Event.on("sendMessageButton", "click", init);

	function detectUserSystem() {
		document.getElementById("usersystem").setAttribute("value", navigator.userAgent);
	}
</script>


<div id="pageWrapper">

	<%@ include file="headermain.jsp"%>
	
	<div id="page">
		
		<div id="pageContent">
		
			<div class="infoContent">
				<div class="panelHeader"><spring:message code="contactwiseproject.2"/></div>
				<div class="infoContentBox">
					<h4><spring:message code="contactwiseproject.3"/></h4>
					<div class="instructions"><spring:message code="contactwiseproject.4"/></div>
					<div class="instructions"><spring:message code="contactwiseproject.5a"/><em><spring:message code="contactwiseproject.5b"/></em>&nbsp;<spring:message code="contactwiseproject.5c"/></div>
					<div class="instructions"><spring:message code="contactwiseproject.6"/></div>
					<div class="instructions"><spring:message code="contactwiseproject.7a"/><a href="/webapp/contactwisegeneral.html"><spring:message code="contactwiseproject.7b"/></a>.</div>

					<!-- Support for Spring errors object -->
					<div id="errorMsgNoBg">
					<spring:bind path="contactWISEProject.*">
					  <c:forEach var="error" items="${status.errorMessages}">
					        <p><c:out value="${error}"/></p>
					    </c:forEach>
					</spring:bind>
					</div>

					<form:form commandName="contactWISEProject" method="post" action="contactwiseproject.html" id="contactWiseForm" autocomplete='off'>  
					  <dl>
					
					  	<sec:authorize ifAllGranted="ROLE_ANONYMOUS">
					  		<dt><label for="NameContact" id="NameContact"><span class="asterix">* </span><spring:message code="contactwiseproject.8"/></label></dt>
					   		<dd><form:input path="name" id="name" size="50" tabindex="1" /></dd>
					    </sec:authorize>
					    
					   <sec:authorize ifAllGranted="ROLE_TEACHER">
					  		<dt><label for="NameContact" id="NameContact"><span class="asterix">* </span><spring:message code="contactwiseproject.8"/></label></dt>
					   		<dd><form:input path="name" id="name" size="50" tabindex="1" /></dd>
					    </sec:authorize>
					    
					  	<sec:authorize ifAllGranted="ROLE_STUDENT">
					  		<dt><label for="NameContact" id="NameContact"><span class="asterix">* </span><spring:message code="contactwiseproject.8"/></label></dt>
					   		<dd><form:input path="name" id="name" size="50" tabindex="1" disabled="true" /></dd>
					    </sec:authorize>
					            
						<sec:authorize ifAllGranted="ROLE_ANONYMOUS">
							<dt><label for="emailContact" id="emailContact"><span class="asterix">* </span><spring:message code="contactwiseproject.10"/></label></dt>
							<dd><form:input path="email" id="email" size="50" tabindex="2"/> </dd>
						</sec:authorize>
					
						<sec:authorize ifAllGranted="ROLE_TEACHER">
							<dt><label for="emailContact" id="emailContact"><span class="asterix">* </span><spring:message code="contactwiseproject.10"/></label></dt>
							<dd><form:input path="email" id="email" size="50" tabindex="2"/> </dd>
						</sec:authorize>
						   
						
					    <dt><label for="projectName" id="projectName"><span class="asterix">* </span><spring:message code="contactwiseproject.11"/></label></dt>
						<dd><form:input path="projectName" id="projectName" size="50"  tabindex="3" disabled="true" /> </dd>
					            
					    <dt><label for="issueTypeContact" id="issueTypeContact"><span class="asterix">* </span><spring:message code="contactwiseproject.12"/></label> </dt>
						<dd><form:select path="issuetype" id="issuetype"  tabindex="4">
						      <c:forEach items="${issuetypes}" var="issuetype">
					            <form:option value="${issuetype.name}">
					            	<spring:message code="issuetypes.${issuetype.name}" />
					            </form:option>
					          </c:forEach>
							</form:select>
					
								</dd>
					
						<dt><label for="summaryContact" id="summaryContact"><span class="asterix">* </span><spring:message code="contactwiseproject.13"/></label></dt>
						<dd style="color:#3333CC;"><form:input path="summary" id="summary" size="50" tabindex="7"/></dd>
						
						<dt><label for="descriptionContact" id="descriptionContact"><span class="asterix">* </span><spring:message code="contactwiseproject.14"/></label></dt>
						<dd><form:textarea path="description" id="description" tabindex="8" rows="6" cols="72"></form:textarea></dd>
					    
					    <form:hidden path="usersystem" id="usersystem" /> 
					  </dl>    
					     <div id="asterixWarning"><spring:message code="contactwiseproject.15"/></div>  
					        
					    <div>
					    	<input type="submit" onclick="detectUserSystem();" id="sendMessageButton" value="<spring:message code="contactwiseproject.16"/>"></input>
					  	</div>
					
					</form:form>
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
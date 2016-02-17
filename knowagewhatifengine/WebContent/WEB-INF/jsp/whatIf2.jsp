
<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA IMPORTS               --%>
<%-- ---------------------------------------------------------------------- --%>
<%@include file="/WEB-INF/jsp/commons/angular/angularResource.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="olapManager">
<head>
<%@include file="/WEB-INF/jsp/commons/angular/angularImport.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/src/angular_1.x/olap/olapController.js"></script>
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/css/olap.css">
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/css/whatIf.css">
<title>OLAP</title>
<script>
	var JSsbiExecutionID = '<%= sbiExecutionID %>'
	var toolbarVisibleBtns = '<%= whatIfEngineInstance.getModelConfig().getToolbarVisibleButtons() %>'
	
</script>
</head>
<body ng-controller="olapController">
	<div layout="row">
		
		<div layout="column" flex=80>
			<div  ng-include="mainToolbar">
			</div>
		
			<div layout="row" ng-include="filterPanel" class="top-alignment" ng-drop="true" ng-drop-success="dropFilter($data,$event)">
			</div>

			<div layout="column" ng-include="olapPanel">
			</div>
		</div>

		<div style="width:2px"></div>
		
		<div flex=20 ng-include="rightPanel">						
		</div>
	</div>
</body>
</html>
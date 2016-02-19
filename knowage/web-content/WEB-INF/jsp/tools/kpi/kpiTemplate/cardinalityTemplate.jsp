<md-content layout-fill ng-controller="kpiDefinitionCardinalityController">
	<table flex class="cardinalityTable" >
		<tr>
			<th></th>
		    <th ng-repeat="measure in measureList" >{{measure.measureName}}</th>
	    </tr>
	  
		<tr class="attributeRow" ng-repeat="attr in attributesList">
		<td>{{attr}}</td>
			<td ng-repeat="measure in measureList">
			<div class="measureCell" ng-if="!measureHaveAttribute(attr,measure)">
<!-- 			<i class="fa fa-times invalidCell "></i> -->
			</div>
			<div class="measureCell" ng-if="measureHaveAttribute(attr,measure)"
			 ng-click="toggleCell(attr,measure)"  ">
			<i ng-if="!isEnabled(attr,measure)" class="fa fa-ban invalidCell"></i>
			<i ng-if="measure.attributs[attr]" class="fa fa-check selectedCell"></i>
			<i ng-if="(measure.attributs[attr] && !canDisable(attr,measure))" class="fa fa-lock selectedCell"></i>
			<i ng-if="!measure.attributs[attr] && isEnabled(attr,measure)" class="fa fa-check selectableCell"></i>
			</div>
			</td>
		</tr>
	</table>


</md-content>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp"%>

<%--TITLE--%>
<div class="col-sm-6 pt30">
   <h4 class="modify_h4 fwn">카탈로그 관리</h4>
</div>

<%--SEARCH FORM--%>
<div class="content-box2 col-md-12 col-md-offset-13">
	<div class="box">
		<div class="form-group col-sm-3 mr-25">
			<label for="searchType" class="control-label-white col-sm-4 mt13"> 검색유형 </label>
			<div class="col-sm-8">
				<select id="searchType" name="searchType" class="form-control" style="background:url(/resources/images/btn_down.png) no-repeat right; background-color:#fafafa;">
					<option value="<%= Constants.SEARCH_TYPE_ALL %>"> 전체 </option>
					<option value="<%= Constants.TAB_NAME_STARTER %>"> 앱 템플릿 </option>
					<option value="<%= Constants.TAB_NAME_BUILD_PACK %>"> 앱 개발환경 </option>
					<option value="<%= Constants.TAB_NAME_SERVICE_PACK %>"> 서비스 </option>
				</select>
			</div>
		</div>
		<div class="form-group col-sm-3 mr-25">
			<label for="searchTypeColumn" class="control-label-white col-sm-4 mt13 ml-10"> 검색항목 </label>
			<div class="col-sm-8">
				<select id="searchTypeColumn" name="searchTypeColumn" class="form-control" style="background:url(/resources/images/btn_down.png) no-repeat right; background-color:#fafafa;">
					<option value="<%= Constants.SEARCH_TYPE_ALL %>"> 전체 </option>
					<option value="<%= Constants.SEARCH_TYPE_NAME %>"> 이름 </option>
					<option value="<%= Constants.SEARCH_TYPE_SUMMARY %>"> 요약 </option>
				</select>
			</div>
		</div>
		<div class="form-group col-sm-3 mr-25">
			<label for="searchTypeUseYn" class="control-label-white col-sm-4 mt13 ml-10"> 공개여부 </label>
			<div class="col-sm-8">
				<select id="searchTypeUseYn" name="searchTypeUseYn" class="form-control" style="background:url(/resources/images/btn_down.png) no-repeat right; background-color:#fafafa;">
					<option value="<%= Constants.SEARCH_TYPE_ALL %>"> 전체 </option>
					<option value="<%= Constants.USE_YN_Y %>"> 공개 </option>
					<option value="<%= Constants.USE_YN_N %>"> 비공개 </option>
				</select>
			</div>
		</div>
		<div class="form-group col-sm-3">
			<label for="searchKeyword" class="control-label-white col-sm-3 mt13 ml-10"> 검색어 </label>
			<div class="input-group col-sm-8 ml20">
				<input type="text" id="searchKeyword" class="form-control2 ml10" placeholder="검색어를 입력하세요." onkeypress="procCheckSearchFormKeyEvent(event);">
				<div class="input-group-btn">
					<button type="button" id="btnSearch" class="btn" style="margin: 11px 0 0 0; color: #c4c3c3; background-color: #f7f7f9; height: 30px;">
						<span class="glyphicon glyphicon-search" style="top: -1px; left: 4px;"></span>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<%--******************** 앱 템플릿 (스타터) ********************--%>
	<div class="panel content-box col-sm-12 col-md-12 mt-50 col-md-offset-13 w98" id="divStarter">
		<div class="col-sm-6 pt5">
			<h4 class="modify_h4 fwm"> 앱 템플릿 </h4>
		</div>
		<div class="col-sm-6 ml-10 tar">
			<button type="button" class="btn btn-point btn-sm" onclick="procMovePage(STARTER_INSERT_FORM_URL, '<%= Constants.CUD_C %>');" >
				앱 템플릿 등록
			</button>
		</div>
		<div style="margin: 45px 0 0 10px;width:98%;">
			<div id="starterListMessageArea"></div>
			<table id="starterListTableArea"  class="table table-striped">
				<thead>
				<tr>
					<th>이름</th>
					<th>요약</th>
					<th>분류</th>
					<th>공개</th>
				</tr>
				</thead>
				<tbody id="starterList">
				</tbody>
			</table>
		</div>
		<form id="starterHiddenForm">
			<input type="hidden" id="starterHiddenFormNo" name="no" value="" />
		</form>
	</div>

	<%--******************** 앱 개발환경 (빌드팩) ********************--%>
	<div class="panel content-box col-sm-12 col-md-12 mt-50 col-md-offset-13 w98" id="divBuildPack">
			<div class="col-sm-6 pt5">
		<h4 class="modify_h4 fwm"> 앱 개발환경 </h4>
			</div>
		<div class="col-sm-6 ml-10 tar">
			<button type="button" class="btn btn-point btn-sm" onclick="procMovePage(BUILD_PACK_INSERT_FORM_URL, '<%= Constants.CUD_C %>');" >
				앱 개발환경 등록
			</button>
		</div>
		<div style="margin: 45px 0 0 10px;width:98%;">
			<div id="buildPackMessageArea">	</div>
			<table id="buildPackTableArea" class="table table-striped">
			  <thead>
			   <tr>
				 <th>이름</th>
				 <th>요약</th>
				 <th>분류</th>
				 <th>공개</th>
			   </tr>
			   </thead>
				<tbody id="buildPackListTable">
				</tbody>

			 </table>
		</div>
		<form id="BuildPackHiddenForm">
			<input type="hidden" id="BuildPackHiddenFormNo" name="no" value="" />
		</form>
	</div>

	<%--******************** 서비스 (서비스 팩)********************--%>
	<div class="panel content-box col-sm-12 col-md-12 mt-50 col-md-offset-13 w98" id="divServicePack">
		<div class="col-sm-6 pt5">
			<h4 class="modify_h4 fwm"> 서비스</h4>
		</div>
		<div class="col-sm-6 ml-10 tar">
			<button type="button" class="btn btn-point btn-sm" onclick="procMovePage(SERVICE_PACK_INSERT_FORM_URL, '<%= Constants.CUD_C %>');">
				서비스 등록
			</button>
		</div>
		<div style="margin: 45px 0 0 10px;width:98%;">
			<div id="servicePackMessageArea">	</div>
			<table id="servicePackTableArea" class="table table-striped">
				<thead>
				<tr>
					<th>이름</th>
					<th>요약</th>
					<th>분류</th>
					<th>공개</th>
				</tr>
				</thead>
				<tbody id="servicePackListTable">
				</tbody>

			</table>
		</div>
		<form id="ServicePackHiddenForm">
			<input type="hidden" id="ServicePackHiddenFormNo" name="no" value="" />
		</form>
	</div>
</div>


<script type="text/javascript">

	var STARTER_LIST_PROC_URL = "<c:url value='/catalog/getStarterNamesList' />";
	var STARTER_INSERT_FORM_URL = "<c:url value='/catalog/starterForm' />";
	var BUILD_PACK_LIST_PROC_URL = "<c:url value='/catalog/getBuildPackCatalogList' />";
	var BUILD_PACK_INSERT_FORM_URL = "<c:url value='/catalog/buildPackForm' />";
	var SERVICE_PACK_LIST_PROC_URL = "<c:url value='/catalog/getServicePackCatalogList' />";
	var SERVICE_PACK_INSERT_FORM_URL = "<c:url value='/catalog/servicePackForm' />";


	// CHECK SEARCH FORM KEY EVENT
	var procCheckSearchFormKeyEvent = function(e) {
		if (e.keyCode == 13 && e.srcElement.type != 'textarea') {
			procGetSearchList();
		}
	};


	// GET SEARCH LIST
	var procGetSearchList = function() {
		var doc = document;
		var reqSearchType = doc.getElementById('searchType').value;
		var reqSearchTypeColumn = doc.getElementById('searchTypeColumn').value;
		var reqSearchTypeUseYn = doc.getElementById('searchTypeUseYn').value;
		var reqSearchKeyword = doc.getElementById('searchKeyword').value.toLowerCase();

		var param = {
			searchKeyword : reqSearchKeyword,
			searchTypeColumn : reqSearchTypeColumn,
			searchTypeUseYn : reqSearchTypeUseYn
		};

		var objDivStarter = $("#divStarter");
		var objDivBuildPack = $("#divBuildPack");
		var objDivServicePack = $("#divServicePack");

		objDivStarter.show();
		objDivBuildPack.show();
		objDivServicePack.show();

		if ("<%= Constants.TAB_NAME_BUILD_PACK %>" == reqSearchType) {
			getBuildPackList(param);
			objDivStarter.hide();
			objDivServicePack.hide();

		} else if ("<%= Constants.TAB_NAME_SERVICE_PACK %>" == reqSearchType) {
			getServicePackList(param);
			objDivStarter.hide();
			objDivBuildPack.hide();

		} else if ("<%= Constants.TAB_NAME_STARTER %>" == reqSearchType) {
			getStarterList(param);
			objDivBuildPack.hide();
			objDivServicePack.hide();

		} else {
			getStarterList(param);
			getBuildPackList(param);
			getServicePackList(param);
		}
	};


	/******************** 앱 템플릿 (스타터) ********************/
	// MOVE PAGE
	var procMoveStarterInsertForm = function(reqParam) {
		var hiddenForm = $('#starterHiddenForm');
		$('#starterHiddenFormNo').val(reqParam);
		hiddenForm.attr({action:STARTER_INSERT_FORM_URL, method:"POST"}).submit();
	};


	// GET LIST
	var getStarterList = function(reqParam) {
		var param = {};
		if (null != reqParam && "" != reqParam) param = reqParam;
		procCallAjax(STARTER_LIST_PROC_URL, param, procCallbackGetStarterList);
	};


	// GET LIST CALLBACK
	var procCallbackGetStarterList = function (data) {
		var objTable = $("#starterList");
		var objTableArea = $('#starterListTableArea');
		var objMessageArea = $('#starterListMessageArea');
		var listLength = data.list.length;
		var htmlString = [];

		objTable.html('');
		objMessageArea.html('');

		if (listLength < 1) {
			objTableArea.hide();

			objMessageArea.append('<spring:message code="common.info.empty.data" />');
			objMessageArea.show();

		} else {
			var catalogList = data.list;
			var reqParam = {};

			for (var i = 0; i < listLength; i++) {
				reqParam = {name: catalogList[i].name};
				htmlString.push('<tr style="cursor:pointer;" onclick="procMoveStarterInsertForm(\'' + catalogList[i].no + '\')">'
						+ '<td class="col-md-3">' + catalogList[i].name + '</td>'
						+ '<td class="col-md-4">' + catalogList[i].summary + '</td>'
						+ '<td class="col-md-2 tac">' + catalogList[i].classificationValue + '</td>'
						+ '<td class="col-md-1 tac">' + catalogList[i].useYn + '</td>'
						+ '</tr>');
			}
			objMessageArea.hide();
			objTable.append(htmlString);
			objTableArea.show();
		}
	};


	/********************* 앱 개발환경 (빌드팩) *********************/
	// GET LIST
	var getBuildPackList = function(reqParam) {
		var param = {};

		if (null != reqParam && "" != reqParam) param = reqParam;

		procCallAjax(BUILD_PACK_LIST_PROC_URL, param, procCallbackGetBuildPackList);
	};


	// GET LIST CALLBACK
	var procCallbackGetBuildPackList = function(data) {
		var objTable = $('#buildPackListTable');
		var objTableArea = $('#buildPackTableArea');
		var objMessageArea = $('#buildPackMessageArea');
		var listLength = data.list.length;
		var htmlString = [];

		objTable.html('');
		objMessageArea.html('');

		if (listLength < 1) {
			objTableArea.hide();

			objMessageArea.append('<spring:message code="common.info.empty.data" />');
			objMessageArea.show();

		} else {
			var catalogList = data.list;

			for (var i = 0; i < listLength; i++) {
				htmlString.push('<tr style="cursor:pointer;" onclick="procMoveBuildPackInsertForm(\'' + catalogList[i].no + '\')">'
						+ '<td class="col-md-3">' + catalogList[i].name + '</td>'
						+ '<td class="col-md-4">' + catalogList[i].summary + '</td>'
						+ '<td class="col-md-2 tac">' + catalogList[i].classificationValue + '</td>'
						+ '<td class="col-md-1 tac">' + catalogList[i].useYn + '</td>'
						+ '</tr>');
			}

			objMessageArea.hide();
			objTable.append(htmlString);
			objTableArea.show();
		}
	};


	// MOVE PAGE
	var procMoveBuildPackInsertForm = function(reqParam) {
		var hiddenForm = $('#BuildPackHiddenForm');
		$('#BuildPackHiddenFormNo').val(reqParam);
		hiddenForm.attr({action:BUILD_PACK_INSERT_FORM_URL, method:"POST"}).submit();
	};


	/********************* 서비스 (서비스 팩)*********************/
	// GET LIST
	var getServicePackList = function(reqParam) {
		var param = {};

		if (null != reqParam && "" != reqParam) param = reqParam;

		procCallAjax(SERVICE_PACK_LIST_PROC_URL, param, procCallbackGetServicePackList);
	};


	// GET LIST CALLBACK
	var procCallbackGetServicePackList = function(data) {
		var objTable = $('#servicePackListTable');
		var objTableArea = $('#servicePackTableArea');
		var objMessageArea = $('#servicePackMessageArea');
		var listLength = data.list.length;
		var htmlString = [];

		objTable.html('');
		objMessageArea.html('');

		if (listLength < 1) {
			objTableArea.hide();

			objMessageArea.append('<spring:message code="common.info.empty.data" />');
			objMessageArea.show();

		} else {
			var catalogList = data.list;

			for (var i = 0; i < listLength; i++) {
				htmlString.push('<tr style="cursor:pointer;" onclick="procMoveServicePackInsertForm(\'' + catalogList[i].no + '\')">'
						+ '<td class="col-md-3">' + catalogList[i].name + '</td>'
						+ '<td class="col-md-4">' + catalogList[i].summary + '</td>'
						+ '<td class="col-md-2 tac" style="text-align: center;">' + catalogList[i].classificationValue + '</td>'
						+ '<td class="col-md-1 tac" style="text-align: center;">' + catalogList[i].useYn + '</td>'
						+ '</tr>');
			}

			objMessageArea.hide();

			objTable.append(htmlString);
			objTableArea.show();
		}
	};


	// MOVE PAGE
	var procMoveServicePackInsertForm = function(reqParam) {
		var hiddenForm = $('#ServicePackHiddenForm');
		$('#ServicePackHiddenFormNo').val(reqParam);
		hiddenForm.attr({action:SERVICE_PACK_INSERT_FORM_URL, method:"POST"}).submit();
	};


	// BIND :: BUTTON EVENT
	$("#btnSearch").on("click", function() {
		procGetSearchList();
	});


	$(document.body).ready(function () {
		getStarterList();
		getBuildPackList();
		getServicePackList();
	});

</script>


<%--FOOTER--%>
<%@ include file="../common/footer.jsp"%>

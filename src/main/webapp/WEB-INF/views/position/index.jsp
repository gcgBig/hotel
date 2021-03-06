<%@ page isELIgnored="false" language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../base.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<script src="<%=root %>/resources/js/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=root %>/resources/css/sweetalert.css" rel="stylesheet">
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="<%=root %>/resources/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=root %>/resources/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <!-- Morris -->
    <link href="<%=root %>/resources/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
    <link href="<%=root %>/resources/css/animate.css" rel="stylesheet">
    <link href="<%=root %>/resources/css/style.css?v=4.1.0" rel="stylesheet">
<style type="text/css">
</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<a href="javascript:;" onclick="toAddPos();"><button type="button" class="btn btn-primary btn-sm">添加</button></a>
			</div>
            <div style="margin-top:20px;" class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>职位</h5>
                        <div id="tip" class="ibox-tools">
                        </div>
                    </div>
                    <div class="ibox-content">
                    	<input type="hidden" id="page" value="1" name="page" />
                        <div class="row">
                        	<div class="col-sm-5 m-b-xs">
                                <select onchange="ajax();" id="pageCount" class="input-sm form-control input-s-sm inline">
                                    <option value="5">5</option>
                                    <option selected="selected" value="10">10</option>
                                    <option value="30">30</option>
                                </select>
                            </div>
                            <div class="col-sm-4 m-b-xs">
                            </div>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" id="search" placeholder="请输入关键词" class="input-sm form-control" onkeyup="ajax();"> <span class="input-group-btn">
                                        <button type="button" id="search" onclick="ajax();" class="btn btn-sm btn-primary"> 搜索</button> </span>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table id="dyntable" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th width="15%">职位名</th>
                                        <th width="10%">操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                	<tr>
                                		<td align="right" colspan="2">
                                			<button type="button" id="dyntable_previous" class="btn btn-white"><i class="fa fa-chevron-left"></i></button>
                                			<button type="button" id="dyntable_next" class="btn btn-white"><i class="fa fa-chevron-right"></i></button>
                                		</td>
                                	</tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>
	<input id="posId" type="hidden">
	
<div class="modal fade" id="updateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog model-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">编辑</h4>
			</div>
			<div class="modal-body">
				<div class="row">
		            <div class="col-sm-12">
		                 <form class="form-horizontal">
		                     <div class="form-group">
		                         <label class="col-sm-2 control-label"><span style="color:red">*</span>职位名：</label>
                                <div class="col-sm-10">
                                	<input type="text" id="posName" name="posName" class="form-control">
                                </div>
		                     </div>
		                 </form>
		            </div>
		        </div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" onclick="changePosition();" class="btn btn-primary">确认</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<div class="modal fade" id="addModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog model-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">添加</h4>
			</div>
			<div class="modal-body">
				<div class="row">
		            <div class="col-sm-12">
		                 <form class="form-horizontal">
		                     <div class="form-group">
		                         <label class="col-sm-2 control-label"><span style="color:red">*</span>职位名：</label>
                                <div class="col-sm-10">
                                	<input type="text" id="addPosName" name="addPosName" class="form-control">
                                </div>
		                     </div>
		                 </form>
		            </div>
		        </div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" onclick="addPosition();" class="btn btn-primary">确认</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<div class="modal fade" id="changePowerModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div style="width:900px;" class="modal-dialog model-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">权限</h4>
			</div>
			<div class="modal-body">
				<div class="row">
		            <div class="col-sm-12">
		                 <form class="form-horizontal">
		                     <div class="form-group">
		                         <label class="col-sm-2 control-label">菜单权限：</label>
                                <div class="col-sm-10">
                                	<div class="col-sm-10">
                                	<c:forEach items="${menus}" var="menu">
                                		<label class="checkbox-inline"><input name="menus" type="checkbox" value="${menu.id}">${menu.menuName}</label>
                                	</c:forEach>
                                </div>
                                </div>
		                     </div>
		                 </form>
		            </div>
		        </div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" onclick="changePower();" class="btn btn-primary">确认</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	ajax();
});
function ajax() {
	$.ajax({
		url: "<%=root%>/system/position/list.do",
		type: "post",
		data: {
			searchData:$("#search").val(),
			page:$("#page").val(),
			pageCount:$("#pageCount").val()
			},
		dataType: "json",
		success:function(result) {
			$("#dyntable>tbody>*").remove();
			var page = $("#page").val();
			$("#dyntable_previous,#dyntable_next").unbind();
			$("#dyntable_next").bind("click", function() {
				if (page < result.paging.sumPage) {
					$("#page").val(parseInt(page) + 1);
					ajax();
				}
			});
			$("#dyntable_previous").bind("click", function() {
				if (page > 1) {
					$("#page").val(parseInt(page) - 1);
					ajax();
				}
			});
			var str = "总共" + result.paging.count + "条数据，共" + result.paging.sumPage + "页，当前第" + result.paging.page + "页";
			$("#tip").html(str);
			var data = new Array();
			$(result.paging.list).each(function(i, o) {
				data.push("<tr>");
				data.push("<td>");
				data.push(o.name);
				data.push("</td>");
				data.push("<td>");
				data.push('<a class="btn btn-info btn-rounded" onclick="toUpdate('+o.id+',\''+o.name+'\');" href="javaScript:;">编辑</a>');
				if (o.id != 1) {
					data.push('<a class="btn btn-warning btn-rounded" onclick="toChangePower('+o.id+');" href="javascript:;">权限</a>');
					data.push('<a class="btn btn-danger btn-rounded" onclick="toDelete('+o.id+');" href="javascript:;">删除</a>');
				} 
				data.push("</td>");
				data.push("</tr>");
			});
			$("#dyntable>tbody").append(data.join(""));
		}
	});
}
	function toUpdate(id, name) {
		$("#posId").val(id);
		$("#posName").val(name);
		$("#updateModel").modal("show");
	}
	function changePosition() {
		if ($("#posName").val() == '') {
			toastr.error("职位名不能为空!"); 
			return;
		}
		$.ajax({
			url: "<%=root%>/system/position/changeName.do",
			type: "post",
			data: {
				id:$("#posId").val(),
				name:$("#posName").val()
			},
			success:function(result){
				ajax();
				toastr.success("编辑成功!");  
				$("#updateModel").modal("hide");
			}
		});
	}
	function toDelete(id) {
		$.ajax({
			url: "<%=root%>/system/position/checkStaff.do",
			type: "post",
			data: {
				id:id
			},
			dataType:"json",
			success:function(result){
				if (result.flag == 0) toastr.error("该职位还有员工在职，不能进行删除操作!");
				else {
					swal({
						  title: "确认删除该职位么？",
						  text: "删除该职位同时删除所含有的权限！",
						  type: "warning",
						  showCancelButton: true,
						  confirmButtonColor: "#DD6B55",
						  confirmButtonText: "删除",
						  cancelButtonText: "取消",
						  closeOnConfirm: false,
						  closeOnCancel: false,
						  showLoaderOnConfirm: true
						},
						function(isConfirm){
						  if (isConfirm) {
							  $.ajax({
									url: "<%=root%>/system/position/deletePosition.do",
									type: "post",
									data: "id="+id,
									success:function(result){
										ajax();
									    swal("成功!", "您删除了这个职位", "success");
									}
							  })
						  } else {
						    swal("取消", "谢谢您的考虑:)", "error");
						  }
						});
				}
			}
		});
	}
	function toChangePower(id) {
		$("#posId").val(id);
		$("input:checkbox").each( function() {
			$(this).prop("checked", false);
		}); 
		$.ajax({
			url: "<%=root%>/system/position/getPowerList.do",
			type: "post",
			data: "id="+id,
			dataType: "json",
			success:function(result){
				if (result.posMenuReltions) {
					$(result.posMenuReltions).each(function(i, o) {
						$("input:checkbox[value="+o.menuId+"]").prop("checked", "checked");
					})
				}
				$("#changePowerModel").modal("show");
			}
		});
	}
	function changePower() {
		var checkedValue = "";
		$('input[name="menus"]').each(function(){
		    if(this.checked){
		    	checkedValue += ","+this.value.toString();
		    }
		});
		$.ajax({
			url: "<%=root%>/system/position/changePower.do",
			type: "post",
			data: {
				id:$("#posId").val(),
				menus:checkedValue
			},
			dataType: "json",
			success:function(result){
				$("#changePowerModel").modal("hide");
				toastr.success("权限修改成功!");
			}
		});
	}
	function toAddPos() {
		$("#addPosName").val("");
		$("#addModel").modal("show");
	}
	function addPosition() {
		if ($("#addPosName").val() == '') {
			toastr.error("职位名不能为空!");
			return;
		}
		$.ajax({
			url: "<%=root%>/system/position/addPosition.do",
			type: "post",
			data: "name="+$("#addPosName").val(),
			dataType: "json",
			success:function(result){
				ajax();
				toastr.success("职位添加成功!");
				$("#addModel").modal("hide");
			}
		});
	}
</script>
</html>
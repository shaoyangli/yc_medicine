//根据年度初始化医疗机构服务
function initServiceType()
{
	$("#serviceType").empty();
	$("#serviceType").append("<option value='0'>--请选择--</option>")
	var year = $("#buryear").val();
	$.post("orgServer_findServiceType.action?year="+year,
			
			function(json)
			{
				var resultList = json.serverType;
				options = "";
				for(var i = 0; i<resultList.length;i++)
				{
					options += "<option value='"+ resultList[i][0] + "'>" + resultList[i][1]+"</option>";
				}
				$("#serviceType").append(options);
			}

	)
	
}
//初始化医疗机构考核指标
function checkIndexs()
{
	$("#checkIndex").empty();
	$("#checkIndex").append("<option value='0'>--请选择--</option>");
	var year = $("#buryear").val();
	var serviceType = $("#serviceType").val();
	if(serviceType != 0)
	{
		$.post("orgServer_findCheckIndex.action?year="+ year +"&typeCode="+serviceType,
				
				function(json)
				{
					var resultList = json.checkIndexs;
					options = "";
					for(var i = 0; i<resultList.length;i++)
					{
						options += "<option value='"+ resultList[i][0] + "'>" + resultList[i][1]+"</option>";
					}
					$("#checkIndex").append(options);
				}
	
		)
	}
}
//年度变化重新载入类型和指标
function yearchange(){
	initServiceType();
	checkIndexs();
}

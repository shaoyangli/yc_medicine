//������ȳ�ʼ��ҽ�ƻ�������
function initServiceType()
{
	$("#serviceType").empty();
	$("#serviceType").append("<option value='0'>--��ѡ��--</option>")
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
//��ʼ��ҽ�ƻ�������ָ��
function checkIndexs()
{
	$("#checkIndex").empty();
	$("#checkIndex").append("<option value='0'>--��ѡ��--</option>");
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
//��ȱ仯�����������ͺ�ָ��
function yearchange(){
	initServiceType();
	checkIndexs();
}

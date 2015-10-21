//重置
           function reset()
           {
				$("#orgName").val("");
				$("#orgLevel").val(0);
				$("#orgFatCode").val("");
				$("#orgLeader").val("");
				$("#orgPhone").val("");
				$("#orgNccmcode").val("");
				$("#orgAddress").val("");
           }
			//选择2级下拉
			//参数说明: t 表示着是哪种调用.如果是三级联动的效果t=0, 如果t=1是为了给编辑页面赋值
           function selectOrg2(t,k)
           {
				var orgTypexs1 = $("#orgTypexs1").val();
				$("#orgTypexs2").empty();
				$("#orgTypexs2").append("<option value='0'></option>");
				$("#orgTypexs3").empty();
				$("#orgTypexs3").append("<option value='0'></option>");
				if(orgTypexs1 == 0)
				{
					return false;
				}
				else
				{
					data = {"orgTypexs1" : orgTypexs1};
			    	$.post("<%=path%>/org_selectOrg2.action",
					    	data,
			    			function(result)
			    			{
			    				var	orgTypexs2s = result.list2;
			    				var options = "";
			    				for(var i = 0;i < orgTypexs2s.length; i++)
			    				{
									options += "<option value='" + orgTypexs2s[i][0] + "'>" + orgTypexs2s[i][1] + "</option>"
				    			}
			    				$("#orgTypexs2").append(options);
			    				//给二级菜单选初值
			    				if(k == 1)
			    				{
			    					var orgTypex;
									if(t == 1)
									{
										orgTypex = "<s:property value='hobi.orgTypex'/>".substring(0,2);
									}
									else
									{
										orgTypex = "<s:property value='hobi.orgTypex'/>";
									}
									
									var orgLevelValue2 = $("#orgTypexs2 ").get(0);
									var count1=$("#orgTypexs2 option").length;
									for(var i=0;i<count1;i++)  
								     {           
									     if(orgLevelValue2.options[i].value == orgTypex)  
								        {  
								    	 orgLevelValue2.options[i].selected = true;  
								            break;  
								        }  
								    }
									selectOrg3(1);
					    		}
								
				    		}
					)
				}		
           }
           //选择三级下拉
           function selectOrg3(t)
           {
        	   var orgTypexs2 = $("#orgTypexs2").val();
        	   $("#orgTypexs3").empty();
			   $("#orgTypexs3").append("<option value='0'></option>");
        	   if(orgTypexs2 == 0)
        	   {
					return false;
               }
        	   else
        	   {
				   data = {"orgTypexs2" : orgTypexs2};
				   $.post("<%=path%>/org_selectOrg3.action",
					    	data,
			    			function(json1)
			    			{
			    				var	orgTypexs3s = json1.list3;
			    				var options = "";
			    				
			    				for(var i = 0;i < orgTypexs3s.length; i++)
			    				{
									options += "<option value='" + orgTypexs3s[i][0] + "'>" + orgTypexs3s[i][1] + "</option>"
				    			}
			    				$("#orgTypexs3").append(options);

			    				if(t == 1)
			    				{
			    					var orgTypex = "<s:property value='hobi.orgTypex'/>";
										var count=$("#orgTypexs3 option").length;
										var orgLevelValue = $("#orgTypexs3 ").get(0);
										for(var i=0;i<count;i++)  
									     {           
										     if(orgLevelValue.options[i].value == orgTypex)  
									        {  
									    	 orgLevelValue.options[i].selected = true;  
									            break;  
									        }  
									    }
									
				    			}
				    		}
					)
        	   }
           }
			//处理医疗机构级别的初始值
           function orgLevelInit()
           {
        	 //要对级别和医疗机构类型进行初始选择
				var orgOldLevel = "<s:property value='hobi.orgLevel'/>"
				var count=$("#orgLevel option").length;
				var orgLevelValue = $("#orgLevel ").get(0);
				  for(var i=0;i<count;i++)  
				     {           
					     if(orgLevelValue.options[i].value == orgOldLevel)  
				        {  
				    	 orgLevelValue.options[i].selected = true;  
				            break;  
				        }  
				    }
           }
           //给医疗机构类型赋初值
           
           function orgTypeInit()
           {
				var orgType = "<s:property value='hobi.orgTypex'/>";
				var data = {"orgType" : orgType};
				$.post("<%=path%>/org_findSorts.action",data,
						function(json)
						{
							var sorts =  json.sorts;//获得数据库中机构类型的sorts
							var orgTypex = "<s:property value='hobi.orgTypex'/>";

							if(sorts == 1)
							{
								var count=$("#orgTypexs1 option").length;
								var orgLevelValue = $("#orgTypexs1 ").get(0);
								for(var i=0;i<count;i++)  
							     {           
								     if(orgLevelValue.options[i].value == orgTypex)  
							        {  
							    	 orgLevelValue.options[i].selected = true;  
							            break;  
							        }  
							    }
							}

							if(sorts == 2)
							{
								var count=$("#orgTypexs1 option").length;
								var orgLevelValue = $("#orgTypexs1 ").get(0);
								var orgTypex1 = orgTypex.substring(0,1);
								for(var i=0;i<count;i++)  
							     {           
								     if(orgLevelValue.options[i].value == orgTypex1)  
							        {  
							    	 orgLevelValue.options[i].selected = true;  
							            break;  
							        }  
							    }
								selectOrg2(2,1);//加载好二级菜单的值 
							}
							if(sorts == 3)
							{
								var count=$("#orgTypexs1 option").length;
								var orgLevelValue = $("#orgTypexs1 ").get(0);
								var orgTypex1 = orgTypex.substring(0,1);
								for(var i=0;i<count;i++)  
							     {           
								     if(orgLevelValue.options[i].value == orgTypex1)  
							        {  
							    	 orgLevelValue.options[i].selected = true;  
							            break;  
							        }  
							    }
								selectOrg2(1,1);//加载好二级菜单的值 
							}
								
						}
				)
           }
//����
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
			//ѡ��2������
			//����˵��: t ��ʾ�������ֵ���.���������������Ч��t=0, ���t=1��Ϊ�˸��༭ҳ�渳ֵ
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
			    				//�������˵�ѡ��ֵ
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
           //ѡ����������
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
			//����ҽ�ƻ�������ĳ�ʼֵ
           function orgLevelInit()
           {
        	 //Ҫ�Լ����ҽ�ƻ������ͽ��г�ʼѡ��
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
           //��ҽ�ƻ������͸���ֵ
           
           function orgTypeInit()
           {
				var orgType = "<s:property value='hobi.orgTypex'/>";
				var data = {"orgType" : orgType};
				$.post("<%=path%>/org_findSorts.action",data,
						function(json)
						{
							var sorts =  json.sorts;//������ݿ��л������͵�sorts
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
								selectOrg2(2,1);//���غö����˵���ֵ 
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
								selectOrg2(1,1);//���غö����˵���ֵ 
							}
								
						}
				)
           }
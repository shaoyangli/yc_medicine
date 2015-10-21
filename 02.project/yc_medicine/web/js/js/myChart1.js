// ��װ����������� 
var Emtoy = function(f,name,sql,params){ 
    this.f = -1; 
    this.name = name; 
    this.sql = sql; 
    if(params!=null){ 
        this.params = params.concat(); 
    }else{ 
        this.params = null 
    } 
} 
 
/**
 * ͳ��ͼ�����Ӧ��JAVA��MyChart.java
 * @param : typechart 
 *          0��ʾ��״ͼ���� 
 *          1��ʾ��״ͼ���� 
 *          2��ʾ����״ͼ���� 
 *          3��ʾ��Ƕ��ͼ����
 */ 
var MyChart = function(typechart){ 
     
    this.title;//ͳ��ͼ���� 
    this.subtitle;//ͳ��ͼ������ 
    this.xTitle;//x����� 
    this.yTitle;//������� 
     
    this.typedb;//�������˵�����Դ 
    this.typechart = typechart;//ͳ��ͼ������ 
    this.typetime = 0;//ͳ�Ƶ�ʱ������ 
    this.emtoys = new Array();//��Ҫͳ�ƵĲ��� 
    this.smtoys = new Array();//��Ҫͳ�ƵĲ���,��ͳ��ͼ����Ƕ��ͼ��ʱ���õ� 
    this.categories = new Array();//���͵�������ʱ��ֶ� 
    this.categoriesLocal = new Array();//������ֶ����� 
 
    this.timeAry = new Array();//�����ҳ��ȡ�õ�ʱ���ID 
    /**
     * x��ͳ������
     * @param : name   ϵ������
     * @param : sql    ��ѯ���
     * @param : params ��ѯ����
     */ 
    this.xAppend = function(name,sql,params){ 
        this.emtoys.push(new Emtoy(null,name,sql,params)); 
    } 
    /**
     * y��ϵ������,ʱ��β�ѯ��
     * @param : name   ʱ�������
     * @param : time   ʱ��
     */ 
    this.yAppend = function(name,time){ 
        this.categories.push(time); 
        this.categoriesLocal.push(name); 
    } 
    /**
     * ��״ͼ���
     * @param : name   ϵ������
     * @param : sql    ��ѯ���
     * @param : params ��ѯ����
     */ 
    this.fAppend = function(name,sql,params){ 
        this.emtoys.push(new Emtoy(null,name,sql,params)); 
    } 
    /**
     * ��״ͼ�ڲ�
     * @param : f      ����״ͼ�ı�־
     * @param : name   ϵ������
     * @param : sql    ��ѯ���
     * @param : params ��ѯ����
     */ 
    this.sAppend = function(f,name,sql,params){ 
        this.smtoys.push(new Emtoy(f,name,sql,params)); 
    } 
    /**
     * ����y��ϵ��ʱ��Σ���ҳ���ȡ
     * @param : timeStart   ҳ�濪ʼʱ���ID
     * @param : timeEnd     ҳ�����ʱ���ID
     * @param : timetype    ҳ��ʱ������ͣ�����»���
     */ 
    this.setTime = function(timeStart,timeEnd,timetype){ 
        this.timeAry.push(timeStart); 
        this.timeAry.push(timeEnd); 
        this.timeAry.push(timetype); 
    } 
    /**
     * ����y��ϵ��ʱ��Σ���ҳ���ȡ
     * @param : timeStart   ҳ�濪ʼʱ���ID
     * @param : timeEnd     ҳ�����ʱ���ID
     * @param : timetype    ҳ��ʱ������ͣ�����»���
     */ 
    this.getPageTime = function(){ 
        if(this.timeAry.length!=0){          
            this.categories = new Array(); 
            this.categories.push($("#"+this.timeAry[0]).val()); 
            this.categories.push($("#"+this.timeAry[1]).val()); 
            this.typetime = $("#"+this.timeAry[2]).val(); 
            this.xTitle =  $("#"+this.timeAry[2]).find("option:selected").text(); 
        }else{ 
            this.categories = null; 
        } 
    } 
    /**
     * ����һ������
     * @param : chart     Ŀ�����
     * @param : typechart ָ������
     */ 
    this.cloneAttr = function(chart){ 
        this.title = chart.title; 
        this.subtitle = chart.subtitle; 
        this.xTitle = chart.xTitle; 
        this.yTitle = chart.yTitle; 
        this.typedb = chart.typedb; 
        this.typetime  = chart.typetime; 
        this.emtoys  = chart.emtoys; 
        this.smtoys = chart.smtoys; 
        this.categories = chart.categories; 
        this.categoriesLocal = chart.categoriesLocal; 
        this.timeAry = chart.timeAry; 
        return this; 
    } 
} 
 
// ͳ��ͼ�Ĵ����������� 
var MyHighcharts = function(options){ 
    tempHighcharts = this; 
    var defaults = { 
            typedb:0, 
            title:"����Ĭ�ϱ���", 
            subTitle:"����Ĭ�ϸ�����", 
            xTitle:"x��˵��", 
            yTitle:"y��˵��", 
            line:null, 
            column:null, 
            pie:null 
        }; 
    var options = $.extend(defaults, options); 
     
    /** ajax����������POST�ύ����Ϊ��������ƴ�ӵĽϳ� */ 
    this.draw = function(i){ 
        // ��ʾ�ȴ���Ϣ 
        $("#container").empty(); 
        $("#container").append("<p style=\"text-align: center\"><img src=\"/images/loading.gif\" alt=\"�����У����Ժ�...\" /></p>"); 
        this.initLocalData(i,options); 
        $.post("/stat/chart!draw.do",this.initParams(tempChart),this.callBackChart); 
    } 
     
    /** ���ݱ��ػ�����*/    
    this.initLocalData = function(i,options){ 
        switch (i) { 
        case 0: 
            tempChart = options.line; 
            break; 
        case 1: 
            tempChart = options.column; 
            break; 
        default: 
            tempChart = options.pie; 
            break; 
        } 
        tempChart.title = options.title; 
        tempChart.subtitle = options.subtitle; 
        tempChart.xTitle = options.xTitle; 
        tempChart.yTitle = options.yTitle; 
        tempChart.typedb = options.typedb; 
    } 
     
    /** �������� */ 
    this.initParams = function(myChart){ 
        var param = new Object(); 
        var timeStr = "1950#1950"; 
         
        if(myChart.time != 0){ 
            myChart.getPageTime(); 
        } 
         
        param["myChart.typedb"] = myChart.typedb; 
        param["myChart.typechart"] = myChart.typechart; 
        param["myChart.typetime"] = myChart.typetime; 
         
        if(myChart.categories!=undefined && myChart.categories!=null){ 
            param["myChart.categoriesStr"] = this.getFztoStr(myChart.categories); 
        }else{ 
            timeStr = ""; 
        } 
         
        if(myChart.emtoys!=undefined && myChart.emtoys!=null){           
            for(var i=0; i<myChart.emtoys.length; i++){ 
                param["myChart.emtoys["+i+"].name"] = myChart.emtoys[i].name; 
                param["myChart.emtoys["+i+"].sql"] = myChart.emtoys[i].sql; 
                 
                if(myChart.emtoys[i].params!=null && myChart.emtoys[i].params!=""){ 
                    param["myChart.emtoys["+i+"].params"] = (timeStr==""?timeStr:timeStr+"#")+this.getFztoStr(myChart.emtoys[i].params); 
                }else{ 
                    if(timeStr != ""){ 
                        param["myChart.emtoys["+i+"].params"] = timeStr; 
                    } 
                } 
            } 
            for(var k=0; k<myChart.smtoys.length; k++){ 
                param["myChart.smtoys["+k+"].f"] = myChart.smtoys[k].f; 
                param["myChart.smtoys["+k+"].name"] = myChart.smtoys[k].name; 
                param["myChart.smtoys["+k+"].sql"] = myChart.smtoys[k].sql; 
                param["myChart.smtoys["+k+"].params"] = "2010#2050"+myChart.smtoys[k].params 
                if(myChart.smtoys[k].params!=null && myChart.smtoys[k].params!=""){ 
                    param["myChart.smtoys["+k+"].params"] = timeStr==""?timeStr:(timeStr+"#")+this.getFztoStr(myChart.smtoys[k].params) 
                }else{ 
                    if(timeStr != ""){ 
                        param["myChart.smtoys["+k+"].params"] = timeStr; 
                    } 
                } 
            } 
        }    
         
        return param; 
    } 
     
    this.getFztoStr = function(array){ 
        var str = ""; 
        for(var i=0; i<array.length; i++){ 
            if(i == 0){ 
                str = str+array[i]; 
            }else{ 
                str = str+"#"+array[i]; 
            } 
        } 
        return str; 
    } 
     
    /** �������ݴ��� */ 
    this.callBackChart = function(data){ 
        if(tempChart.timetype != 0){ 
            tempChart.categoriesLocal = data.myChart.categoriesLocal; 
        } 
        switch (data.myChart.typechart) { 
        case 0://��״ͼ 
            tempHighcharts.setClass(0); 
            tempHighcharts.callBackLine(data); 
            break; 
        case 1://��״ͼ 
            tempHighcharts.setClass(1); 
            tempHighcharts.callBackColumn(data); 
            break; 
        case 2://����ͼ 
            tempHighcharts.setClass(2); 
            tempHighcharts.callBackPie(data); 
            break; 
        default://��Ƕ��ͼ 
            tempHighcharts.setClass(2); 
            tempHighcharts.callBackDonutPie(data); 
            break; 
        } 
    } 
     
    // line���󷵻غ����Ĵ��� 
    this.callBackLine = function(data){ 
        new Highcharts.Chart({ 
            chart: { 
                renderTo: 'container', 
                type: 'line' 
            }, 
            title: { 
                text: tempHighcharts.getTimeTitle(tempChart.categoriesLocal) 
            }, 
            subtitle: { 
                text: tempChart.subtitle 
            }, 
            xAxis: { 
                title: { 
                    text: tempChart.xTitle, 
                    align: 'high' 
                }, 
                categories: tempChart.categoriesLocal 
            }, 
            yAxis: { 
                title: { 
                    align: 'high', 
                    offset: 0, 
                    text: tempChart.yTitle, 
                    rotation: 0, 
                    y: -10 
 
                }, 
                plotLines: [{ 
                    value: 0, 
                    width: 1, 
                    color: '#808080' 
                }] 
            }, 
            plotOptions: { 
                spline: { 
                    marker: { 
                        radius: 4, 
                        lineColor: '#666666', 
                        lineWidth: 1 
                    } 
                } 
            }, 
            legend:{ 
                borderWidth:0 
            }, 
            tooltip: { 
                crosshairs: true, 
                shared: true 
                 
            }, 
            series: data.myChart.series 
        }); 
    } 
    // column���󷵻غ����Ĵ��� 
    this.callBackColumn = function(data){ 
        new Highcharts.Chart({ 
            chart: { 
                renderTo: 'container', 
                type: 'column' 
            }, 
            title: { 
                text: tempHighcharts.getTimeTitle(tempChart.categoriesLocal) 
            }, 
            subtitle: { 
                text: tempChart.subtitle 
            }, 
            xAxis: { 
                title: { 
                    text: tempChart.xTitle, 
                    align: 'high' 
                }, 
                categories: tempChart.categoriesLocal 
            }, 
            yAxis: { 
                title: { 
                    align: 'high', 
                    offset: 0, 
                    text: tempChart.yTitle, 
                    rotation: 0, 
                    y: -10 
 
                }, 
                plotLines: [{ 
                    value: 0, 
                    width: 1, 
                    color: '#808080' 
                }] 
            }, 
            plotOptions: { 
                spline: { 
                    marker: { 
                        radius: 4, 
                        lineColor: '#666666', 
                        lineWidth: 1 
                    } 
                } 
            }, 
            legend:{ 
                borderWidth:0 
            }, 
            tooltip: { 
                formatter: function() { 
                    return ''+this.x+'<br/>'+ 
                    this.series.name +': '+ this.y; 
                }    
            }, 
            series: data.myChart.series 
        }); 
    } 
    // ����״ͼ 
    this.callBackPie = function(data){ 
        new Highcharts.Chart({ 
            chart: { 
                renderTo: 'container', 
                plotBackgroundColor: null, 
                plotBorderWidth: null, 
                plotShadow: false, 
                type:'pie' 
            }, 
            title: { 
                text: tempHighcharts.getTimeTitle(tempChart.categoriesLocal) 
            }, 
            subtitle: { 
                text: tempChart.subtitle 
            }, 
            tooltip: { 
                formatter: function() { 
                    return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %'; 
                } 
            }, 
            plotOptions: { 
                pie: { 
                    allowPointSelect: true, 
                    cursor: 'pointer', 
                    dataLabels: { 
                        enabled: true, 
                        color: '#000000', 
                        connectorColor: '#000000', 
                        formatter: function() { 
                            return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2) +' %'; 
                        } 
                    } 
                } 
            }, 
            series: data.myChart.series_pie 
        }); 
 
    } 
    // ��Ƕ��״ͼ 
    this.callBackDonutPie = function(data){ 
        var dt = tempChart.comb(data); 
        new Highcharts.Chart({ 
            chart: { 
                renderTo: 'container', 
                type: 'pie' 
            }, 
            title: { 
                text: tempHighcharts.getTimeTitle(data.myChart.categories) 
            }, 
            subtitle: { 
                text: tempChart.subtitle 
            }, 
            yAxis: { 
                title: { 
                    text: 'Total percent market share' 
                } 
            }, 
            plotOptions: { 
                pie: { 
                    shadow: false 
                } 
            }, 
            tooltip: { 
                formatter: function() { 
                    return '<b>'+ this.point.name +'</b>: '+ this.y +' %'; 
                } 
            }, 
            series: dt 
        }); 
    } 
    // ����Ƕ��״ͼ�첽������������ݽ�������Ȼ��չʾ��JSPҳ���� 
    this.comb = function(data){ 
        var colors = Highcharts.getOptions().colors; 
        var pie1 = data.myChart.series_pie[0]; 
        var pie2 = data.myChart.series_pie[1]; 
        var firstData = []; 
        var secondData = []; 
        for (var i = 0; i < pie1.data.length; i++) { 
            firstData.push({ 
                name: pie1.data[i][0], 
                y: pie1.data[i][1], 
                color: colors[i] 
            }); 
        } 
        for (var i = 0; i < pie2.data.length; i++) { 
            secondData.push({ 
                name: pie2.data[i][0], 
                y: pie2.data[i][1], 
                color:this.getColor(colors,pie2,pie2.data[i]) 
            }); 
        } 
         
        var dt = []; 
        dt.push({ 
            name: 'first', 
            data: firstData, 
            size: '60%', 
            dataLabels: { 
                formatter: function() { 
                    return this.y > -1 ? this.point.name : null; 
                }, 
                color: 'white', 
                distance: -30 
            } 
        }); 
        dt.push({ 
            name: 'second', 
            data: secondData, 
            innerSize: '60%', 
            dataLabels: { 
                formatter: function() { 
                    return this.y > -1 ? '<b>'+ this.point.name +':</b> '+ this.y +'%'  : null; 
                } 
            } 
        });  
        return dt; 
    } 
    // ��Ƕ��״ͼ-�������ɫ 
    this.getColor = function(colors,pie2,dt){ 
        var one = 0; 
        var all = 0; 
        var tempAy = []; 
        for (var i = 0; i < pie2.data.length; i++) { 
            if(pie2.data[i][2] == dt[2]){ 
                tempAy.push(pie2.data[i][0]);  
            } 
        } 
        all  =tempAy.length; 
        for (var i = 0; i < all; i++) { 
            if(tempAy[i]== dt[0]){ 
                one = i; 
                continue; 
            } 
        } 
        //alert(dt[0]+":"+one+"/"+all+":"+dt[2]); 
        var brightness = 0.2 - (one / all) / 5 ; 
        return Highcharts.Color(colors[dt[2]]).brighten(brightness).get(); 
    } 
    this.setClass = function(i){ 
        var obj = $("#navigation a"); 
        obj.attr("class",""); 
        obj.eq(i).attr("class","current"); 
    } 
    this.getTimeTitle = function(categories){ 
        if(categories == null){ 
            return tempChart.title; 
        } 
        var lgh = categories.length; 
        return this.pmt(categories[0],0)+"~"+this.pmt(categories[lgh-1],1)+tempChart.title; 
    } 
    this.pmt = function(str,i){//ʱ���ʽ��       
        if(str.indexOf("#") != -1){ 
            str = str.split("#")[i]; 
        } 
        if(str.length==10){ 
            str = str.substring(0,4)+"��"+str.substring(5,7)+"��"+str.substring(8)+"��"; 
        }else if(str.length==7){ 
            str = str.substring(0,4)+"��"+str.substring(5)+"��"; 
        }else{ 
            str = str + "��"; 
        } 
        return str; 
    } 
} 
 
$(function(){ 
    $("#navigation a").click(function(){ 
        var i = $("#navigation a").index($(this)); 
        tempHighcharts.draw(i); 
    });  
}); 

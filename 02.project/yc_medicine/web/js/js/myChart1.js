// 封装请求参数对象 
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
 * 统计图对象对应的JAVA类MyChart.java
 * @param : typechart 
 *          0表示线状图对象 
 *          1表示柱状图对象 
 *          2表示单饼状图对象 
 *          3表示内嵌饼图对象
 */ 
var MyChart = function(typechart){ 
     
    this.title;//统计图标题 
    this.subtitle;//统计图副标题 
    this.xTitle;//x轴标题 
    this.yTitle;//主轴标题 
     
    this.typedb;//服务器端的数据源 
    this.typechart = typechart;//统计图类类型 
    this.typetime = 0;//统计的时间类型 
    this.emtoys = new Array();//需要统计的参数 
    this.smtoys = new Array();//需要统计的参数,当统计图是内嵌饼图的时候用到 
    this.categories = new Array();//发送到服务器时间分段 
    this.categoriesLocal = new Array();//本地轴分段名称 
 
    this.timeAry = new Array();//保存从页面取得的时间的ID 
    /**
     * x轴统计内容
     * @param : name   系列名称
     * @param : sql    查询语句
     * @param : params 查询参数
     */ 
    this.xAppend = function(name,sql,params){ 
        this.emtoys.push(new Emtoy(null,name,sql,params)); 
    } 
    /**
     * y轴系列内容,时间段查询用
     * @param : name   时间段名称
     * @param : time   时间
     */ 
    this.yAppend = function(name,time){ 
        this.categories.push(time); 
        this.categoriesLocal.push(name); 
    } 
    /**
     * 饼状图外层
     * @param : name   系列名称
     * @param : sql    查询语句
     * @param : params 查询参数
     */ 
    this.fAppend = function(name,sql,params){ 
        this.emtoys.push(new Emtoy(null,name,sql,params)); 
    } 
    /**
     * 饼状图内层
     * @param : f      外层饼状图的标志
     * @param : name   系列名称
     * @param : sql    查询语句
     * @param : params 查询参数
     */ 
    this.sAppend = function(f,name,sql,params){ 
        this.smtoys.push(new Emtoy(f,name,sql,params)); 
    } 
    /**
     * 保存y轴系列时间段，从页面读取
     * @param : timeStart   页面开始时间的ID
     * @param : timeEnd     页面结束时间的ID
     * @param : timetype    页面时间的类型，年或月或日
     */ 
    this.setTime = function(timeStart,timeEnd,timetype){ 
        this.timeAry.push(timeStart); 
        this.timeAry.push(timeEnd); 
        this.timeAry.push(timetype); 
    } 
    /**
     * 设置y轴系列时间段，从页面读取
     * @param : timeStart   页面开始时间的ID
     * @param : timeEnd     页面结束时间的ID
     * @param : timetype    页面时间的类型，年或月或日
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
     * 复制一个对象
     * @param : chart     目标对象
     * @param : typechart 指定类型
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
 
// 统计图的触发绑定与整理 
var MyHighcharts = function(options){ 
    tempHighcharts = this; 
    var defaults = { 
            typedb:0, 
            title:"这是默认标题", 
            subTitle:"这是默认副标题", 
            xTitle:"x轴说明", 
            yTitle:"y轴说明", 
            line:null, 
            column:null, 
            pie:null 
        }; 
    var options = $.extend(defaults, options); 
     
    /** ajax请求，这里用POST提交，因为参数可能拼接的较长 */ 
    this.draw = function(i){ 
        // 显示等待信息 
        $("#container").empty(); 
        $("#container").append("<p style=\"text-align: center\"><img src=\"/images/loading.gif\" alt=\"加载中，请稍候...\" /></p>"); 
        this.initLocalData(i,options); 
        $.post("/stat/chart!draw.do",this.initParams(tempChart),this.callBackChart); 
    } 
     
    /** 数据本地化请求*/    
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
     
    /** 参数处理 */ 
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
     
    /** 返回数据处理 */ 
    this.callBackChart = function(data){ 
        if(tempChart.timetype != 0){ 
            tempChart.categoriesLocal = data.myChart.categoriesLocal; 
        } 
        switch (data.myChart.typechart) { 
        case 0://线状图 
            tempHighcharts.setClass(0); 
            tempHighcharts.callBackLine(data); 
            break; 
        case 1://柱状图 
            tempHighcharts.setClass(1); 
            tempHighcharts.callBackColumn(data); 
            break; 
        case 2://单饼图 
            tempHighcharts.setClass(2); 
            tempHighcharts.callBackPie(data); 
            break; 
        default://内嵌饼图 
            tempHighcharts.setClass(2); 
            tempHighcharts.callBackDonutPie(data); 
            break; 
        } 
    } 
     
    // line请求返回函数的处理 
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
    // column请求返回函数的处理 
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
    // 单饼状图 
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
    // 内嵌饼状图 
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
    // 对内嵌饼状图异步请求产生的数据进行整理然后展示到JSP页面上 
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
    // 内嵌饼状图-子类的颜色 
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
    this.pmt = function(str,i){//时间格式化       
        if(str.indexOf("#") != -1){ 
            str = str.split("#")[i]; 
        } 
        if(str.length==10){ 
            str = str.substring(0,4)+"年"+str.substring(5,7)+"月"+str.substring(8)+"号"; 
        }else if(str.length==7){ 
            str = str.substring(0,4)+"年"+str.substring(5)+"月"; 
        }else{ 
            str = str + "年"; 
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

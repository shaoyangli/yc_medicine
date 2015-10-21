var options;
function chart_line(id) {
	options ={
	     chart:{
	     	renderTo:id, 
	     	defaultSeriesType:"line", 
	     	marginRight:130, 
	     	marginBottom:25
	     }, 
	     title:{
	         text:""
	     }, 
	     subtitle:{
	     	text:"", 
	     	x:-20
	     }, 
	     title:{
	     	button:"", 
	     	x:-80
	     }, 
	     xAxis:{
	     	categories:[]
	     }, 
	     yAxis:{
	     	title:{
	     		text:""
	     	}, 
	     	plotLines:[{
	     		value:0, width:1, color:"#808080"
	     	}]
	     }, 
	     tooltip:{
	     //pointFormat: '{series.name}: <b>{point.y}</b><br/>',
	    // shared:true,
	     	formatter:function () {
		    	return "" + this.series.name + "<br/>" + this.x + ": " + this.y + "";
			}
		 }, 
		legend:{
		   layout:"vertical", 
		   align:"right", 
		   verticalAlign:"middle", 
		   x:10, 
		   y:100, 
		   borderWidth:0
		}, 
		credits: {
           enabled: false
        },
		series:[]
	};
	return options;
}
//饼状图
function chart_pie(arr,id,tit) {
            var chart = new Highcharts.Chart({
                chart: {
                renderTo: id,
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: tit
            },
            tooltip: { //鼠标点击提示
        	    pointFormat: '<b>: {point.y} 元</b>',
            	percentageDecimals: 2
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        fontSize: '10px',
                        formatter: function() {//去掉加粗<b>
                            return ''+ this.point.name +': '+this.point.y +'元 '+ this.percentage.toFixed(2) +' %';
                        }
                    }
                }
            },
            credits: {
                enabled: false
            },
            series: [{
              type: 'pie',
              name: '',
              data: arr
          	}]
            });
        } 

//饼状图 服务对象分布
function chart_pieobj(arr,id,tit) {
            var chart = new Highcharts.Chart({
                chart: {
                renderTo: id,
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: tit
            },
            tooltip: { //鼠标点击提示
        	    pointFormat: '<b>: {point.y} 人</b>',
            	percentageDecimals: 2
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        fontSize: '10px',
                        formatter: function() {//去掉加粗<b>
                            return ''+ this.point.name +': '+this.point.y +'人 ';
                        }
                    }
                }
            },
            credits: {
                enabled: false
            },
            series: [{
              type: 'pie',
              name: '',
              data: arr
          	}]
            });
        } 
        //饼状图 资金到账来源
function chart_pieobj2(arr,id,tit) {
            var chart = new Highcharts.Chart({
                chart: {
                renderTo: id,
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: tit
            },
            tooltip: { //鼠标点击提示
        	    pointFormat: '<b>: {point.y} 元</b>',
            	percentageDecimals: 2
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        fontSize: '10px',
                        formatter: function() {//去掉加粗<b>
                            return ''+ this.point.name +': '+this.point.y +'元 ';
                        }
                    }
                }
            },
            credits: {
                enabled: false
            },
            series: [{
              type: 'pie',
              name: '',
              data: arr
          	}]
            });
        } 
// 
 var areaspline; 
function areasplin() {
           areaspline={
            chart: {
                renderTo: 'container',
                type: 'areaspline'
            },
            title: {
                text: ''
            },
            subtitle:{
	     		text:"", 
	     		x:-20
	     	}, 
            legend: {
                layout: 'vertical',
                align: 'left',
                verticalAlign: 'top',
                x: 150,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF'
            },
            xAxis: {
                categories: [],
                plotBands: [{ // visualize the weekend
                    from: 4.5,
                    to: 6.5,
                    color: 'rgba(68, 170, 213, .2)'
                }]
            },
            yAxis: {
                title: {
                    text: ''
                }
            },
            tooltip: {
                formatter: function() {
                    return ''+this.x +': '+ this.y +' ';
                }
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                areaspline: {
                    fillOpacity: 0.5
                }
            },
            series: []
        };

        }
        
        function colum(column,id){
        	column={
           chart: {
                renderTo: id,
                type: 'column'
                
                
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: [],
                labels: {//设置X轴各分类名称的样式style
                    rotation: -15, // 倾斜度
                    //style:{
                    //	font: 'normal 12px'
                    //},
                    align: 'right'
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            legend: {
                layout: 'vertical',
                backgroundColor: '#FFFFFF',
                align: 'left',
                verticalAlign: 'top',
                x: 100,
                y: 70,
                floating: true,
                shadow: true
            },
            tooltip: {
                formatter: function() {
                    return ''+ this.x +': '+ this.y +' 元';
                }
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0,
                	pointWidth: 25
                }
            },
            credits: {
                enabled: false
            },
            series: []
        };
        return column;
        }

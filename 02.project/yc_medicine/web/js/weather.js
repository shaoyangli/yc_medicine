function getWeather() {
	var getWeatherUrl = "weatherAction!findWeather.action";
	// ajax�ű���ʼ
	$.getJSON(getWeatherUrl,
							function(json) {
		var  w=json.list;
		//for(var i=0;i<w.length;i++){
		//	alert(w[i]);
		//}
					var weatherInfo = "";				
					if (w.length > 0) {
			//	var day = w[0];
				// ����
				//var weak = w[1];
				// ����
				var city = w[0];
				// ����
				var weather = w[1];
				// ������Ϣ
				var temp = w[2];
				var temp2 = w[3];
				// �¶�
				//var wind = w[4];
				// ��������
				var img1 = w[4];
				// ����ͼ��
				var img2 = w[5];
				var ptime = w[6];
				
				// ����ͼ��
				weatherInfo = city + ":<img style=\"vertical-align: middle;padding-bottom:3px\" src=\"../images/tqimg/" + img1+ "\"/>&nbsp";

				//weatherInfo =city + "<img style=\"vertical-align: middle;padding-bottom:3px\" src=\"weather/images/"
						//+ img1 +
						//".gif\"/>&nbsp";
				//if (ptime ="18:00") {
				//	weatherInfo = city + ":&nbsp;<img src=\"../images/tqimg/" + img2+ "\"/>&nbsp";

				//}
				weatherInfo = weatherInfo + weather + "&nbsp;" + temp+"~"+temp2
						+ "&nbsp;&nbsp;";
				//alert(weatherInfo);
				jQuery("#weather").html(weatherInfo);

			}},'json')
		
}

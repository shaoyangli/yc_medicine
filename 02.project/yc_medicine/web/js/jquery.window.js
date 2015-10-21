
(function(w) {
	 	news = {
		yujing123 : function() {
			var trs = "";
			$
					.getJSON(
							"../offerAction!yujing.action?timestamp="
									+ new Date().getTime(),
							function(json) {
								$("#thinking").empty();
								var page = json.page;//从action获取一个json	
								var f = json.result;
								var b = json.anum;
								if (b == 1)
									return false;
								if (f == 1) {
									var url = "../fund/fundlist.jsp";
								} else {
									var url = "../capital/apply_add_sum.jsp";
								}

								$
										.each(
												page.list,
												function(i, obj) {//对从action获取一个json进行遍历操作
													if (obj[4] == null)
														obj[4] = "";
													if (obj[6] == null)
														obj[6] = "";
													if (obj[3] == null)
														obj[3] = "";
													trs += "<div>"
															+ obj[4]
															+ "在"
															+ obj[6]
															+ "申请了"
															+ obj[3]
															+ "元钱</div><div style='margin-right: 5px;'>"
															+ "<a href='"
															+ url
															+ "'><font color='red'>"
															+ "点击查看详情"
															+ "</font></a></div>";
												});
								trs += "</table>";
								$("#thinking").append(trs);
							}, 'json');
			return trs;
		},
		offeryujing : function() {
			var trs = "";
			$
					.getJSON(
							"../offerAction!offeryujing.action?timestamp="
									+ new Date().getTime(),
							function(json) {
								$("#thinking").empty();
								var offerPage = json.offerPage;//从action获取一个json	

								$
										.each(
												offerPage.list,
												function(i, obj) {//对从action获取一个json进行遍历操作
													if (obj[1] == null)
														obj[1] = "";
													if (obj[2] == null)
														obj[2] = "";
													if (obj[3] == null)
														obj[3] = "";
													trs += "<div>"
															+ obj[1]
															+ "在"
															+ obj[2]
															+ "接受了"
															+ obj[3]
															+ "元钱</div><div style='margin-right: 5px;'>"
															+ "<a href='offerAction!findApply.action?count="
															+ obj[0]
															+ "'><font color='red'>"
															+ "点击查看详情"
															+ "</font></a></div>";
												});
								trs += "</table>";
								$("#thinking").append(trs);

							}, 'json');
			return trs;
		},
		backyujing : function() {
			var trs = "";
			$
					.getJSON(
							"../offerAction!backyujing.action?timestamp="
									+ new Date().getTime(),
							function(json) {
								$("#thinking").empty();
								var backPage = json.backPage;//从action获取一个json	
								$
										.each(
												backPage.list,
												function(i, obj) {//对从action获取一个json进行遍历操作
													if (obj[3] == null)
														obj[3] = "";
													if (obj[4] == null)
														obj[4] = "";
													if (obj[5] == null)
														obj[5] = "";
													trs += "<div>"
															+ obj[3]
															+ "在"
															+ obj[4]
															+ "驳回了本机构在"
															+ obj[5]
															+ "申请的"
															+ obj[1]
															+ "单据"
															+ "</div><div style='margin-right: 5px;'>"
															+ "<a href='offerAction!findBack.action?anum="
															+ obj[0]
															+ "'><font color='red'>"
															+ "点击查看详情"
															+ "</font></a></div>";
												});
								trs += "</table>";
								$("#thinking").append(trs);
							}, 'json');
			return trs;
		}
	}
})(window);
(function(jQuery) {
	this.version = '@1.5';
	this.layer = {
		'width' : 240,
		'height' : 100
	};
	this.title = '信息提示';
	this.time = 100;
	this.anims = {
		'type' : 'slide',
		'speed' : 600
	};

	this.inits = function(title, text) {
		if ($("#message").is("div")) {
			return;
		}
		$(document.body)
				.prepend(
						'<div id="message" style="border:#b9c9ef 1px solid;z-index:100;width:'
								+ this.layer.width
								+ 'px;height:'
								+ this.layer.height
								+ 'px;position:absolute; display:none;background:#cfdef4; bottom:0; right:0; overflow:hidden;"><div style="border:1px solid #fff;border-bottom:none;width:100%;height:25px;font-size:12px;overflow:hidden;color:#1f336b;"><span id="message_close" style="float:right;padding:5px 0 5px 0;width:16px;line-height:auto;color:red;font-size:12px;font-weight:bold;text-align:center;cursor:pointer;overflow:hidden;">×</span><div style="padding:5px 0 5px 5px;width:100px;line-height:18px;text-align:left;overflow:hidden;">'
								+ title
								+ '</div><div style="clear:both;"></div></div> <div style="padding-bottom:5px;border:1px solid #fff;border-top:none;width:100%;height:auto;font-size:12px;"><div id="message_content" style="margin:0 5px 0 5px;border:#b9c9ef 1px solid;padding:10px 0 10px 5px;font-size:12px;width:'
								+ (this.layer.width - 17)
								+ 'px;height:'
								+ (this.layer.height - 50)
								+ 'px;color:#1f336b;text-align:left;overflow:hidden;">'
								+ text + '</div></div></div>');
	};
	this.show = function(title, text, time) {
		if ($("#message").is("div")) {
			return;
		}
		if (title == 0 || !title)
			title = this.title;
		this.inits(title, text);
		if (time)
			this.time = time;
		switch (this.anims.type) {
		case 'slide':
			$("#message").slideDown(this.anims.speed);
			break;
		case 'fade':
			$("#message").fadeIn(this.anims.speed);
			break;
		case 'show':
			$("#message").show(this.anims.speed);
			break;
		default:
			$("#message").slideDown(this.anims.speed);
			break;
		}
		$("#message_close").click(function() {
			setTimeout('this.close()', 1);
		});
		//$("#message").slideDown('slow');
		this.rmmessage(this.time);
	};
	this.lays = function(width, height) {
		if ($("#message").is("div")) {
			return;
		}
		if (width != 0 && width) {
			this.layer.width = width
		} else {
			this.layer.width = 240
		}
		;
		if (height != 0 && height) {
			this.layer.height = height
		} else {
			this.layer.height = 100
		}
		;
	}
	this.anim = function(type, speed) {
		if ($("#message").is("div")) {
			return;
		}
		if (type != 0 && type)
			this.anims.type = type;
		if (speed != 0 && speed) {
			switch (speed) {
			case 'slow':
				;
				break;
			case 'fast':
				this.anims.speed = 200;
				break;
			case 'normal':
				this.anims.speed = 400;
				break;
			default:
				this.anims.speed = speed;
			}
		}
	}
	this.rmmessage = function(time) {
		setTimeout('this.close()', time+100000000);
		//setTimeout('$("#message").remove()', time+1000);
	};
	this.close = function() {
		switch (this.anims.type) {
		case 'slide':
			$("#message").slideUp(this.anims.speed);
			break;
		case 'fade':
			$("#message").fadeOut(this.anims.speed);
			break;
		case 'show':
			$("#message").hide(this.anims.speed);
			break;
		default:
			$("#message").slideUp(this.anims.speed);
			break;
		}
		;
		setTimeout('$("#message").remove();', this.anims.speed);
		this.original();
	};
	this.original = function() {
		this.layer = {
			'width' : 240,
			'height' : 100
		};
		this.title = '信息提示';
		this.time = 100;
		this.anims = {
			'type' : 'slide',
			'speed' : 600
		};
	};
	jQuery.messager = this;
	return jQuery;
})(jQuery);
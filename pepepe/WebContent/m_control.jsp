<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>제품 제어</title>

<style>
.line {
	fill: none;
	stroke: #000;
	stroke-width: 1.5px;
}
</style>
<script type="text/javascript">
	var temp = 0;
	var humid = 0;
	var light = 0;

	 
	
	setInterval(function drawFunction() {

		var userID = $('#userID').val();

		$.ajax({
			type : 'POST',
			url : './MachineDrawServlet',
			data : {
				userID : userID
			},
			success : function(result) {

				var array = result.split(',');
				temp = array[0];
				humid = array[1];
				light = array[2];

				light *= 1;
				humid *= 1;
				temp *= 1;

			}
		});

	}

	, 1000);
</script>

<style>
.line {
	fill: none;
	stroke: #000;
	stroke-width: 1.5px;
}
</style>


</head>
<body>
	<jsp:include page="B_navbar.jsp" />
 


	<%
		String userID = null;

		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			//UserDTO sID = new UserDAO().getSERIAL(userID);
		}
		if (userID == null) {
			response.sendRedirect("./m_index.jsp");
		}

		UserDTO user = new UserDAO().getUser(userID);
	%>


	<div class="container">



		<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-success">
				<div class="panel-heading">
					<div class="panel-title">컨트롤 패널</div>
					<div id="containerA"
						style="min-width: 250px; height: 200px; margin: 0 auto"></div>

					<div id="containerB"
						style="min-width: 250px; height: 200px; margin: 0 auto"></div>

					<div id="containerC"
						style="min-width: 250px; height: 200px; margin: 0 auto"></div>
				</div>
				<div>
					<input type="text" class="form-control" readonly id="userID"
						name="userID1" value="<%=userID%>">
				</div>

				 

				<div class="panel-body">


					<span id="icon-music">♬</span>

					<div class="wrap">
						<div id="result">
							<span class="final" id="final_span"></span> <span class="interim"
								id="interim_span"></span>
							<h5 style="" id="statusMessage"></h5>

						</div>
						<button id="btn-mic" class="off">
							마이크 <span></span>
						</button>

						<br> <br>

						<h3>마이크를 켜고 말해보세요</h3>
						<ul>
							<li>선풍기 작동 [선풍기 꺼 / 선풍기 켜]</li>
							<li>가림막 작동 [가림막 올려 / 가림막 내려]</li>
							<li>조명 작동 [조명 켜 / 조명 꺼]</li>
							<li>워터펌프 작동 [워터펌프 켜 / 워터펌프 꺼]</li>

						</ul>
						
						<button id="button1" onclick="ledOn();">버튼1</button>
					</div>

					<img id="imgLED" class="btn-img"
						style="width: 150px; length: 150px;" src="image/lightOn.png" /> <img
						id="imgLED2" class="btn-img" style="width: 150px; length: 150px;"
						src="image/lightOn.png" /> <img id="imgLED4" class="btn-img"
						style="width: 150px; length: 150px;" src="image/lightOn.png" /> <img
						id="imgLED3" class="btn-img" style="width: 150px; length: 150px;"
						src="image/lightOn.png" />





				</div>
			</div>
		</div>


	</div>

 
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>


	<script type="text/javascript">
		Highcharts.chart('containerA', {
			chart : {
				type : 'spline',
				animation : Highcharts.svg, // don't animate in old IE
				marginRight : 10,
				events : {
					load : function() {

						// set up the updating of the chart each second
						var series = this.series[0];
						setInterval(function() {
							var x = (new Date()).getTime(), // current time
							y = light;
							series.addPoint([ x, y ], true, true);
						}, 1500);
					}
				}
			},

			time : {
				useUTC : false
			},

			title : {
				text : '실시간 조도 그래프'
			},
			xAxis : {
				type : 'datetime',
				tickPixelInterval : 150
			},
			yAxis : {
				title : {
					text : '조도'
				},
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				headerFormat : '<b>{series.name}</b><br/>',
				pointFormat : '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
			},
			legend : {
				enabled : false
			},
			exporting : {
				enabled : false
			},
			series : [ {
				name : '조도 데이터',
				data : (function() {
					// generate an array of random data
					var data = [], time = (new Date()).getTime(), i;

					for (i = -19; i <= 0; i += 1) {
						data.push({
							x : time + i * 1000,
							y : 0
						});
					}
					return data;
				}())
			} ]
		});

		//B graph
		Highcharts.chart('containerB', {
			chart : {
				type : 'spline',
				animation : Highcharts.svg, // don't animate in old IE
				marginRight : 10,
				events : {
					load : function() {

						// set up the updating of the chart each second
						var series = this.series[0];
						setInterval(function() {
							var x = (new Date()).getTime(), // current time
							y = humid;
							series.addPoint([ x, y ], true, true);
						}, 1500);
					}
				}
			},

			time : {
				useUTC : false
			},

			title : {
				text : '실시간 습도 그래프'
			},
			xAxis : {
				type : 'datetime',
				tickPixelInterval : 150
			},
			yAxis : {
				title : {
					text : '습도'
				},
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				headerFormat : '<b>{series.name}</b><br/>',
				pointFormat : '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
			},
			legend : {
				enabled : false
			},
			exporting : {
				enabled : false
			},
			series : [ {
				name : '습도 데이터',
				data : (function() {
					// generate an array of random data
					var data = [], time = (new Date()).getTime(), i;

					for (i = -19; i <= 0; i += 1) {
						data.push({
							x : time + i * 1000,
							y : 0
						});
					}
					return data;
				}())
			} ]
		});

		//C graph
		Highcharts.chart('containerC', {
			chart : {
				type : 'spline',
				animation : Highcharts.svg, // don't animate in old IE
				marginRight : 10,
				events : {
					load : function() {

						// set up the updating of the chart each second
						var series = this.series[0];
						setInterval(function() {
							var x = (new Date()).getTime(), // current time
							y = temp;
							series.addPoint([ x, y ], true, true);
						}, 1500);
					}
				}
			},

			time : {
				useUTC : false
			},

			title : {
				text : '실시간 온도 그래프'
			},
			xAxis : {
				type : 'datetime',
				tickPixelInterval : 150
			},
			yAxis : {
				title : {
					text : '섭씨'
				},
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ]
			},
			tooltip : {
				headerFormat : '<b>{series.name}</b><br/>',
				pointFormat : '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
			},
			legend : {
				enabled : false
			},
			exporting : {
				enabled : false
			},
			series : [ {
				name : '온도 데이터',
				data : (function() {
					// generate an array of random data
					var data = [], time = (new Date()).getTime(), i;

					for (i = -19; i <= 0; i += 1) {
						data.push({
							x : time + i * 1000,
							y : 0
						});
					}
					return data;
				}())
			} ]
		});
	</script>

</body>
</html>
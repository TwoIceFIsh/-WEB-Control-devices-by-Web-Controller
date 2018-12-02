<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>컨트롤 패널</title>

<script src="js/stt.js"></script>

<script type="text/javascript">
	var temp = 0;
	var humid = 0;
	var light = 0;
	var data1 = 0;
	var data2 = 0;
	var data3 = 0;
	var motor = 0;
	
	var flag1 = 0;
	var flag2 = 0;
	var flag3 = 0;
	var l0 = new Audio('voice/ledOff.mp3');
	var l1 = new Audio('voice/ledOn.mp3');
	var p0 = new Audio('voice/penOff.mp3');
	var p1 = new Audio('voice/penOn.mp3');
	var s2 = new Audio('voice/screenDown.mp3');
	var s1 = new Audio('voice/screenUp.mp3');
	var w1 = new Audio('voice/waterOn.mp3');
	var w0 = new Audio('voice/waterOff.mp3');
	 
	
	var status = -1;
	var final_transcript = '';


function hello(){
	const $btnMic = $('#btn-mic');
	$btnMic.attr('class', 'on');
    annyang.start({ autoRestart: false, continuous: true })
    var recognition = annyang.getSpeechRecognizer();
   
    recognition.interimResults = true;
    recognition.onresult = function(event) {
        var interim_transcript = '';
        final_transcript = '';
        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
                final_transcript += event.results[i][0].transcript;
                console.log("final_transcript="+final_transcript);
                //annyang.trigger(final_transcript); //If the sentence is "final" for the Web Speech API, we can try to trigger the sentence
            } else {
                interim_transcript += event.results[i][0].transcript;
                console.log("interim_transcript="+interim_transcript);
            }
        }
        document.getElementById('resultt').innerHTML = final_transcript;
        fireCommand(final_transcript);
        $btnMic.attr('class', 'off');
        console.log('interim='+interim_transcript+'|final='+final_transcript);
    };
}

function fireCommand(string) {
 
	if (string.endsWith('물펌프 켜')  )  {
		waterpumpOn();
	}  
	if (string.endsWith('물 펌프 꺼')) {
		waterpumpOff();
	} 

	if (string.endsWith('조명 켜') ) {
		
		ledOn();
	}  
	if (string.endsWith('조명 꺼') ) {
		ledOff();
	}   
	if (string.endsWith('선풍기 켜')  ) {
		penOn();
	}   
	if (string.endsWith('선풍기 꺼')  ) {
		penOff();
	}   
	if (string.endsWith('가림막 올려')  ) {
		screenUp();
	}   
	if (string.endsWith('가림막 내려') ) {
		screenDown();
	}   
 
	
	
 
}

function waterpumpOn() {

	var userID = $('#userID').val();
	var func = "wPump";
	var status ="on";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {


			if(result ==1 ){
				w1.play();
				$('#statusMessage').html('워터펌프 ON.');
				$('#statusMessage').css("color", "green");
				

			}


			if (result == -1 ) {
				$('#statusMessage').html('malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}



function waterpumpOff() {
	var status = "off"
	var userID = $('#userID').val();
	var func = "wPump";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {


			if (result == 0) {
				w0.play();
				$('#statusMessage').html('워터펌프 OFF.');
				$('#statusMessage').css("color", "red");
				 
			}

			if (result == -1 ) {
				$('#statusMessage').html('malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}


function ledOn() {

	var userID = $('#userID').val();
	var func = "led";
	var status = "on";

	 
	
	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if(result ==1 ){
				 l1.play();
				$('#statusMessage').html('조명을 ON 했습니다.');
				$('#statusMessage').css("color", "green");
		

			}

			if (result == -1) {
				$('#statusMessage').html('malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}

function ledOff() {

	var userID = $('#userID').val();
	var func = "led";
	var status ="off";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {


			if (result == 0) {
				
			l0.play();
				$('#statusMessage').html('조명을 OFF 했습니다.');
				$('#statusMessage').css("color", "red");
			

			}

			if (result == -1) {
				$('#statusMessage').html('malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}

function penOn() {

	var userID = $('#userID').val();
	var func = "pen";
	var status = "on";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {


			if(result == 1 ){
p1.play();
				$('#statusMessage').html('팬을 가동합니다 ON.');
				$('#statusMessage').css("color", "green");
			
			}

			if (result == -1) {
				$('#statusMessage').html('malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}

function penOff() {

	var userID = $('#userID').val();
	var func = "pen";
	var status = "off";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if (result == 0) {
p0.play();
				$('#statusMessage').html('팬을 정지합니다.');
				$('#statusMessage').css("color", "green");
				

			}

			if (result == -1) {
				$('#statusMessage').html('malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}

function screenUp() {

	var userID = $('#userID').val();
	var func = "screen";
	var status = "up";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if (result == 2) {
			 
				$('#statusMessage').html('가림막을 올립니다.');
				$('#statusMessage').css("color", "green");
				s1.play();

			}

			if (result == -1) {
				$('#statusMessage').html('up malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}

function screenDown() {

	var userID = $('#userID').val();
	var func = "screen";
	var status = "down";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if (result == 1) {
				s2.play();
				$('#statusMessage').html('가림막을 내립니다.');
				$('#statusMessage').css("color", "green");
		

			}

			if (result == -1) {
				$('#statusMessage').html('down malfunction.');
				$('#statusMessage').css("color", "red");
			}
		}
	});

}

	 
function waterF() {	 
	var userID = $('#userID').val();
	var func = "wPump";
	var status = "just";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if (result == 0) {
				w1.play();
				$('#waterT').html('ON');
				$('#waterT').css("color", "white");
				

			}
			
			if (result == 1) {
				w0.play();
				$('#waterT').html('OFF');
				$('#waterT').css("color", "white");
			
			}
			

			if (result == -1) {
				$('#waterT').html('malfunction.');
				$('#waterT').css("color", "red");
			}
		}
	});

}



function penF() {

 
	var userID = $('#userID').val();
	var func = "pen";
	var status = "just";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if (result == 0) {
				p1.play();
				$('#penT').html('ON');
				$('#penT').css("color", "white");
		

			}
			
			if (result == 1) {
				p0.play();
				$('#penT').html('OFF');
				$('#penT').css("color", "white");
			

			}
			

			if (result == -1) {
				$('#penT').html('malfunction.');
				$('#penT').css("color", "red");
			}
		}
	});

}

function ledF() {

	var userID = $('#userID').val();
	var func = "led";
	var status = "just";

	$.ajax({
		type : 'POST',
		url : './UserControlServlet',
		data : {

			userID : userID,
			func : func,
			status : status
		},
		success : function(result) {

			if (result == 0) {
				l1.play();
				$('#ledT').html('ON');
				$('#ledT').css("color", "white");
			

			}
			
			if (result == 1) {
				l0.play();
				$('#ledT').html('OFF');
				$('#ledT').css("color", "white");
			

			}
			

			if (result == -1) {
				$('#ledT').html('malfunction.');
				$('#ledT').css("color", "red");
			}
		}
	});

}

 
	  
	
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
				light = array[0];
				humid = array[1];
				temp = array[2];
				status = array[3];
				
				data1 = array[4];
				data2 = array[5];
				data3 = array[6]
				screen = array[7];
				
 
				
				if (data2 == 1) {
					$('#ledT').html('ON');
					$('#ledT').css("color", "white");
					

				}
				
				if (data2 == 0) {
					$('#ledT').html('OFF');
					$('#ledT').css("color", "white");

				}
				

				if (data2 == -1) {
					$('#ledT').html('malfunction.');
					$('#ledT').css("color", "red");
				}
	 
				if (data3 == 1) {
					$('#penT').html('ON');
					$('#penT').css("color", "white");

				}
				
				if (data3 == 0) {
					$('#penT').html('OFF');
					$('#penT').css("color", "white");

				}
				

				if (data3 == -1) {
					$('#penT').html('malfunction.');
					$('#penT').css("color", "red");
				}
				
				if (data1 == 1) {
					$('#waterT').html('ON');
					$('#waterT').css("color", "white");

				}
				
				if (data1 == 0) {
					$('#waterT').html('OFF');
					$('#waterT').css("color", "white");

				}
				

				if (data1 == -1) {
					$('#waterT').html('malfunction.');
					$('#waterT').css("color", "red");
				}
				
				
				if (screen == 1) {
					$('#motorT').html('펼치는 중');
					$('#motorT').css("color", "white");

				}
				
				if (screen == 0) {
					$('#motorT').html('정지 상태');
					$('#motorT').css("color", "white");

				}
				if (screen == 2) {
					$('#motorT').html('접는 중');
					$('#motorT').css("color", "white");
				}

				if (screen == -1) {
					$('#motorT').html('malfunction.');
					$('#motorT').css("color", "red");
				}
				
				light *= 1;
				humid *= 1;
				temp *= 1;
				
	
				
				if(temp > 30){
					$('#tempA').html('더움');
					$('#tempA').css("color", "red");
					}
			 
				if(temp <= 30 && temp > 20){
					$('#tempA').html('따뜻');
					$('#tempA').css("color", "pink");
					}
					
					if(temp <= 20 && temp > 10){
						$('#tempA').html('적당');
						$('#tempA').css("color", "green");
					}
					
					if( temp <= 10){
						$('#tempA').html('서늘');
						$('#tempA').css("color", "blue");
					}
					
				
			if(status == 1){
				$('#statusA').html('정상');
				$('#statusA').css("color", "green");
				$('#statusB').html('정상');
				$('#statusB').css("color", "green");
				$('#statusC').html('정상');
				$('#statusC').css("color", "green");
			}
			
			if(status == -1){
				$('#statusA').html('에러');
				$('#statusA').css("color", "red");
				$('#statusB').html('에러');
				$('#statusB').css("color", "red");
				$('#statusC').html('에러');
				$('#statusC').css("color", "red");
			}
				
				
	
				
				
				if(humid > 800){
				$('#humidM').html('건조');
				$('#humidM').css("color", "red");
				}
				
				if(humid <= 800 && humid > 400){
					$('#humidM').html('적당');
					$('#humidM').css("color", "blue");
				}
				
				if( humid <= 400){
					$('#humidM').html('충분');
					$('#humidM').css("color", "green");
				}
				
				
				
				if(light > 15){
					$('#lightM').html('밝음');
					$('#lightM').css("color", "green");
					}
					
					if(light >= 5 && light < 15){
						$('#lightM').html('적당');
						$('#lightM').css("color", "blue");
					}
					
					if( light <= 5){
						$('#lightM').html('어두움');
						$('#lightM').css("color", "black");
					}
			}
		});

	}

	, 1000);
</script>
</head>
<body>

	<jsp:include page="testNavbar.jsp" />


 

	<div id="page-wrapper">
		<div class="row">

			<div class="col-lg-6 col-md-6">

				<h1 class="page-header">컨트롤 패널</h1>
			</div>
			<div class="col-lg-6 col-md-6">
				<h3>손님용 페이지입니다. 조작은 불가능합니다. 관리자계정으로 접속시 조작가능하오니 추후 공개되는 아이디로 접속해보세요.</h3>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-3 col-md-6">
				<div class="panel panel-primary">
					<div class="panel-heading" onClick=''>
						<div class="row">
							<div class="col-xs-3">
								<i class="fa fa-sun-o fa-5x"></i>
							</div>
							<div class="col-xs-9 text-right">
								<div class="huge" id='ledT'>초기화</div>
								<div>조명</div>
							</div>
						</div>
					</div>
					<a>
						<div class="panel-footer">
							<span class="pull-left">조명 작동시 클릭 하세요</span> <span
								class="pull-right"><i class="fa fa-question" id="ace1"
								data-toggle="tooltip" data-placement="bottom"
								title="<img src='image/led.gif' /><br>
								 <h5>LED를 점등합니다.<br><br>  1.	빛이 어둘울시 자동으로 점등됩니디."></i></span>
								
							<div class="clearfix"></div>
						</div>
					</a>
				</div>
			</div>
			<div class="col-lg-3 col-md-6">
				<div class="panel panel-green">
					<div class="panel-heading" onClick=' '>
						<div class="row">
							<div class="col-xs-3">
								<i class="fa fa-tint   fa-5x"></i>
							</div>
							<div class="col-xs-9 text-right">
								<div class="huge" id='waterT'>초기화</div>
								<div>물 펌프</div>
							</div>
						</div>
					</div>
					<a>
						<div class="panel-footer">
							<span class="pull-left">물 공급시 클릭하세요</span> <span
								class="pull-right"><i class="fa fa-question" id="ace2"
								data-toggle="tooltip" data-placement="bottom"
								title="<img src='image/water.gif' /> <br>
								
								
								<h5>물펌프를 가동시켜 물을 공급합니다.</h5><br><br>
								2. 습도데이터가 너무 높으면 자동으로 물을 공급합니다.<br>
								3. 온도데이터가 너무 높으면 자동으로 물을 공급합니다."></i></span>
							<div class="clearfix"></div>
						</div>
					</a>
				</div>
			</div>
			<div class="col-lg-3 col-md-6">
				<div class="panel panel-yellow">
					<div class="panel-heading" onClick=' '>
						<div class="row">
							<div class="col-xs-3">
								<i class="fa fa-cloud fa-5x"></i>
							</div>
							<div class="col-xs-9 text-right">
								<div class="huge" id='penT'>초기화</div>
								<div>팬</div>
							</div>
						</div>
					</div>
					<a>
						<div class="panel-footer">
							<span class="pull-left">팬 작동시 클릭하세요</span> <span
								class="pull-right"><i class="fa fa-question" id="ace3"
								data-toggle="tooltip" data-placement="bottom"
								title="<img src='image/pen.gif' />
								<br>
								<h5> 식물의 더위를 식혀주기위한 팬 입니다.</h5>
								<br><br>
								1. 클릭시 펜이 작동합니다. <br> 
								2. 온도가 높을시 펜이 자동으로 동작합니다.
								"></i></span>
							<div class="clearfix"></div>
						</div>
					</a>
				</div>
			</div>
			<div class="col-lg-3 col-md-6">
				<div class="panel panel-red">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-3">
								<i class="fa fa-arrow-up   fa-3x" onclick=" "></i> <i
									class="fa fa-arrow-down fa-3x" onclick=" "></i>
							</div>
							<div class="col-xs-9 text-right">
								<div class="huge" id="motorT">초기화</div>
								<div>가림막</div>
							</div>
						</div>
					</div>

					<a>
						<div class="panel-footer">
							<span class="pull-left">가림막 작동시 클릭하세요</span> <span
								class="pull-right"><i class="fa fa-question" id="ace4"
								data-toggle="tooltip" data-placement="bottom"
								title="<img src='image/screen.gif' />
								<br>
								<h5>가림막을 설치해 햇빛을 막을수있습니디.</h5>
								<br>
								<br>
								1. 온도가 너무 높을시 자동으로 펼쳐집니다.
								"></i></span>
							<div class="clearfix"></div>
						</div>
					</a>
				</div>
			</div>
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-8">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-bar-chart-o fa-fw"></i> 나의 기계 상황 그래프 <span
							class="pull-right"><i class="fa fa-question" id="ace5"
							data-toggle="tooltip" data-placement="bottom"
							title="<br>
							<h5>현재 기기의 상태 데이터를 실시간으로 그래프로 나타내줍니다.</h5><br><br>
								1. 그래프의 CSS 및 JS는 highchart.com의 그래프를 활용했습니다.<br>
								2. 각종 데이터를 전달받아 자른후 각종인자들을 1.5초마다 데이터로 PUSH해줍니다. "></i></span>

					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div id="containerA"
							style="min-width: 250px; height: 200px; margin: 0 auto"></div>

						<div id="containerB"
							style="min-width: 250px; height: 200px; margin: 0 auto"></div>


						<div id="containerC"
							style="min-width: 250px; height: 200px; margin: 0 auto"></div>
					</div>
					<!-- /.panel-body -->
				</div>

				<!-- /.panel -->

				<!-- /.panel -->
			</div>
			<!-- /.col-lg-8 -->
			<div class="col-lg-4">

				<div class="chat-panel panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i>음성 제어<span class="pull-right"><i
							class="fa fa-question" id="ace6" data-toggle="tooltip"
							data-placement="left"
							title=" <br><h5>음성으로 기기를 동작시킬수있습니다</h5><br>
								<br>1. https 프로토콜이 아니므로 특정브라우저에서는 마이크 기능을 차단합니다.<br>
								2. annyang API를 활용해 음성데이터를 텍스트로 받아 구별후 함수를 실행합니다.<br>
								3. 삼성인터넷 브라우저에서 정상작동합니다."></i></span>


					</div>
					<!-- /.panel-heading -->
					<div class="content">


						<span id="icon-music">♬</span>

						<div class="wrap">
							<div id="resultt">
								<span class="final" id="final_span"></span> <span
									class="interim" id="interim_span"></span>


							</div>
							<h5 style="" id="statusMessage"></h5>
							<button id="btn-mic" class="off" onclick=" ">
								말하기 <span></span>
							</button>

							<br> <br>

							<h3>마이크를 켜고 말해보세요</h3>
							<ul>
								<li>선풍기 작동 [선풍기 켜 / 선풍기 꺼]</li>
								<li>가림막 작동 [가림막 올려 / 가림막 내려]</li>
								<li>조명 작동 [조명 켜 / 조명 꺼]</li>
								<li>워터펌프 작동 [물펌프 켜 / 물 펌프 꺼]</li>

							</ul>

						</div>

					</div>
					<!-- /.panel-body -->

					<!-- /.panel-footer -->
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-bell fa-fw"></i> 알림 패널 <span class="pull-right"><i
							class="fa fa-question" id="ace7" data-toggle="tooltip"
							data-placement="left"
							title=" <br>
							 	<br><h5>실시간으로 현재 기기의 상태를 나타내는 패널입니다.</h5><br><br>
								1. 각종수치를 전달받아 현재 상태 값을 나누어 상태매세지를 나타냅니다.<br>
								2. 그래프에 쓰이는 데이터와 동일한 데이터를 사용합니다.
								"></i></span>

					</div>

					<div class="panel-body">
						<div class="list-group">

							<a class="list-group-item"> <i class="fa fa-tint   fa-fw"></i>
								습도 상태 <span class="pull-right text-muted small" id="humidM"><em>초기화
										중 </em> </span>
							</a> <a class="list-group-item"> <i class="fa  fa-sun-o   fa-fw"></i>
								빛세기 <span class="pull-right text-muted small" id="lightM"><em>초기화
										중 </em> </span>
							</a> <a class="list-group-item"> <i class="fa  fa-spinner fa-fw"></i>
								온도 <span class="pull-right text-muted small" id="tempA"><em>초기화
										중</em> </span>
							</a> <a class="list-group-item"></a> <a class="list-group-item">
								<i class="fa fa-power-off   fa-fw"></i> 기기상태 <span
								class="pull-right text-muted small" id="statusA"><em>초기화
										중 </em> </span>
							</a> <a class="list-group-item"> <i class="fa fa-desktop fa-fw"></i>
								웹 서버상태 <span class="pull-right text-muted small" id="statusB"><em>초기화
										중 </em> </span>
							</a> <a class="list-group-item"> <i class="fa fa-tasks fa-fw"></i>DB
								서버상태 <span class="pull-right text-muted small" id="statusC"><em>초기화
										중 </em> </span>
							</a>
						</div>
						<!-- /.list-group -->

					</div>
					<!-- /.panel-body -->
				</div>

			</div>
			<!-- /.col-lg-4 -->
		</div>
		<!-- /.row -->
	</div>

	<input type="text" class="form-control" readonly id="userID"
		name="userID1" value="asdf">
	<!-- /#page-wrapper -->
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
		
		$('i[data-toggle="tooltip"]').tooltip({
		    animated: 'fade',
		    
		    html: true
		});
		$('#ace1').tooltip();
		$('#ace2').tooltip();
		$('#ace3').tooltip();
		$('#ace4').tooltip();
		$('#ace5').tooltip();
		$('#ace6').tooltip();
		$('#ace7').tooltip();
	</script>
</body>
</html>
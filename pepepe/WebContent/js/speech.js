$(function() {
	if (typeof webkitSpeechRecognition !== 'function') {
		alert('크롬에서 지원됩니다.');
		return false;
	}

	let isRecognizing = false;
	let ignoreEndProcess = false;
	let finalTranscript = '';

	const audio = document.querySelector('#audio');
	const recognition = new webkitSpeechRecognition();
	const language = 'ko-KR';
	const two_line = /\n\n/g;
	const one_line = /\n/g;
	const first_char = /\S/;

	const $btnMic = $('#btn-mic');
	const $result = $('#result');
	const $iconMusic = $('#icon-music');

	recognition.continuous = true;
	recognition.interimResults = true;

	/**
	 * 음성 인식 시작 처리
	 */
	recognition.onstart = function() {
		console.log('onstart', arguments);
		isRecognizing = true;
		$btnMic.attr('class', 'on');
	};

	/**
	 * 음성 인식 종료 처리
	 * @returns {boolean}
	 */
	recognition.onend = function() {
		console.log('onend', arguments);
		isRecognizing = false;

		if (ignoreEndProcess) {
			return false;
		}

		// DO end process
		$btnMic.attr('class', 'off');
		if (!finalTranscript) {
			console.log('empty finalTranscript');
			return false;
		}
	};

	/**
	 * 음성 인식 결과 처리
	 * @param event
	 */
	recognition.onresult = function(event) {
		console.log('onresult', event);

		let interimTranscript = '';
		if (typeof(event.results) === 'undefined') {
			recognition.onend = null;
			recognition.stop();
			return;
		}

		for (let i = event.resultIndex; i < event.results.length; ++i) {
			if (event.results[i].isFinal) {
				finalTranscript += event.results[i][0].transcript;
			} else {
				interimTranscript += event.results[i][0].transcript;
			}
		}

		finalTranscript = capitalize(finalTranscript);
		final_span.innerHTML = linebreak(finalTranscript);
		interim_span.innerHTML = linebreak(interimTranscript);

		console.log('finalTranscript', finalTranscript);
		console.log('interimTranscript', interimTranscript);

		fireCommand(interimTranscript);

	};

	/**
	 * 음성 인식 에러 처리
	 * @param event
	 */
	recognition.onerror = function(event) {
		console.log('onerror', event);

		if (event.error.match(/no-speech|audio-capture|not-allowed/)) {
			ignoreEndProcess = true;
		}

		$btnMic.attr('class', 'off');
	};

	/**
	 * 명령어 처리
	 * @param string
	 */


	function fireCommand(string) {

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
		if (string.endsWith('그만해') ) {
			stopman();
		}  
		if (string.endsWith('워터펌프 켜')  )  {
			waterpumpOn();
		}  
		if (string.endsWith('워터펌프 꺼')) {
			waterpumpOff();
		} 
	}

	/**
	 * 개행 처리
	 * @param s
	 * @returns {string}
	 */
	function linebreak(s) {
		return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
	}

	/**
	 * 첫문자를 대문자로 변환
	 * @param s
	 * @returns {string | void | *}
	 */
	function capitalize(s) {
		return s.replace(first_char, function(m) {
			return m.toUpperCase();
		});
	}

	/**
	 * 음성 인식 트리거
	 * @param event
	 */
	function start(event) {
		if (isRecognizing) {
			recognition.stop();
			return;
		}
		recognition.lang = language;
		recognition.start();
		ignoreEndProcess = false;

		finalTranscript = '';
		final_span.innerHTML = '';
		interim_span.innerHTML = '';
	}
	  function textToSpeech(text) {
		    console.log('textToSpeech', arguments);
 
		    speechSynthesis.speak(new SpeechSynthesisUtterance(text));
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

	function stopman() {

		var userID = $('#userID').val();
		var func = "screen";
		var status ="x";

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
					$('#statusMessage').html('조명을 ON 했습니다.');
					$('#statusMessage').css("color", "green");
					$("#imgLED").attr("src", "image/lightOn.png"); 

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
					$('#statusMessage').html('조명을 OFF 했습니다.');
					$('#statusMessage').css("color", "red");
					$("#imgLED").attr("src", "image/lightOff.png"); 

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
					$('#statusMessage').html('팬을 정지합니다.');
					$('#statusMessage').css("color", "red");

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
					$('#statusMessage').html('팬을 올립니다.');
					$('#statusMessage').css("color", "red");

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







});
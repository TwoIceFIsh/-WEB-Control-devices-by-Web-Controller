<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>

<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 -->
<script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<link href="./css/fontawesome-all.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="css/custom.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script src="js/func.js" type="text/javascript"></script>
<script src="js/speech.js" type="text/javascript"></script>

</head>
<body>
	<!-- [session] check logic -->
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			response.sendRedirect("./m_index.jsp");

			if (userID == null) {
				response.sendRedirect("./m_index.jsp");
			}

			UserDTO user = new UserDAO().getUser(userID);
			

		}
	%>
	<!-- [navbar] design -->
	<nav class="navbar navbar-default">

		<div class="container">

			<div class="navbar-header">
				<a class="navbar-brand" href="./m_index.jsp"> <img
					src="./image/logo2.png" width="90" height="30"
					class="d-inline-block align-top" alt=""> 
				</a>
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

			</div>
			<div id="navbar" class="collapse navbar-collapse">

				<ul class="nav navbar-nav">
					<li><a href="./m_index.jsp"><i class="fas fa-home"></i>&nbsp;메인화면
					</a></li>
					<li><a href="./m_functions.jsp"><i class="fas fa-bug"></i>&nbsp;모델소개
					</a></li>
					<li><a href="./m_maker.jsp"><i class="fas fa-user-tie"></i>&nbsp;제작자 </a></li>

				</ul>

				<%
					if (userID == null) {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./m_join.jsp"><i class="fa fa-child"></i>
							&nbsp;회원가입 </a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="./m_login.jsp"><i class=" fas fa-sign-in-alt"></i>
							&nbsp;로그인</a></li>
				</ul>


				<%
					} else {
				%>

				<ul class="nav navbar-nav navbar-right">
					<li><a href="./m_check.jsp"> <i class="fas fa-user-edit"></i>
							&nbsp;<%=userID%>님 정보수정 </a></li>
					<li><a href="./F_logout.jsp"> <i
							class="fas fa-sign-out-alt"></i>&nbsp;로그아웃
					</a></li>

					<li><a href="./m_control.jsp"><i class="fas fa-terminal"></i>&nbsp;제품제어
					</a></li>
					<li><a href="./m_serialR.jsp"><i class="fa fa-key"></i>&nbsp;제품등록
					</a></li>
					<li><a href="./m_info.jsp"><i class="fa fa-key"></i>&nbsp;제품관리
					</a></li>



				</ul>
				<!-- <a>상단바 2, 3 개로 드롭다운으로 표현</a> -->
				<%
					}
				%>
			</div>
		</div>
	</nav>








</body>
</html>


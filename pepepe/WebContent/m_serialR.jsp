<%@page import="user.UserDTO"%>
<%@page import="user.UserLoginServlet"%>
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
<title>시리얼 등록</title>

</head>
<body>
	<jsp:include page="testNavbar.jsp" />

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

 
	
	<div id="page-wrapper">
		<div class="row">

			<div class="col-lg-12">

				<h1 class="page-header">제품 시리얼 등록</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>


		<!-- /.row -->
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">회원 정보 확인</h3>
					</div>
					<div class="panel-body">
						<form role="form">
							<fieldset>
								<div>
							<input type="text" class="form-control" readonly id="userID"
								name="userID" value="<%=userID%>">
							<input type="text" class="form-control" id="serialID"
								placeholder="XXXX-XXXX-XXXX-XXXX" autofocus>
						</div>

						<div>
							<button type="button" onclick="serialFunction();"
								class="form-control btn btn-primary">등록</button>
							<h5 style="" id="statusMessage"></h5>
						</div>
							</fieldset>
						</form>
					</div>
				</div>
			</div>

			<!-- /.col-lg-6 -->
		</div>
		<!-- /.row -->
	</div>
	 




</body>
</html>
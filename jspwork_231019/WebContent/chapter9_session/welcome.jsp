<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	
	
	if(session.getAttribute("userID")==null){
		response.sendRedirect("session_out.jsp");
	}
	
out.print("설정된 세션 값 : "+session.getAttribute("userID"));
	
%>
<a href="session_out.jsp">로그아웃 </a>

</body>
</html>
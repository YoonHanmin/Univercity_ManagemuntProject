<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("utf-8");
    %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID= (String)session.getAttribute("userID");
		}
		if(userID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요.');");
			script.println("location.href='main.jsp';");
			script.println("</script>");
		}else {
		if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back();");
			script.println("</script>");
		} else {
			BbsDao bbsDao = new BbsDao();
			int result = bbsDao.write(bbs.getBbsTitle(),userID,bbs.getBbsContent());
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back();");
				script.println("</script>");
			} else {
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글이 작성되었습니다.')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
		}
	
	
	
	
	%>



</body>
</html>
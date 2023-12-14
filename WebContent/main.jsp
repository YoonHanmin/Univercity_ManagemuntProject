<%@page import="user.User"%>
<%@page import="user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/main.css?aa">
    <title>한국대 학생 정보관리시스템</title>
  </head>
  
  <body>
   <%
  	String userID = null;
   	int userClass = 1;
  if(session.getAttribute("userID")!=null){
	  userID=(String)session.getAttribute("userID");
  
   	UserDao dao = new UserDao();
   	User user = dao.getUser(userID);
   	userClass = user.getUserClass();}
  %>
  
  <header>
 <% if(userID==null){
                %>
                <a href="login.jsp" id="login">로그인</a>
                <%
                }else{%>
                
     			 <a href="logout.jsp" id="login">로그아웃</a>
            <%}
                 %>

  	<a href="main.jsp">한국대학교 학사정보시스템</a>
  </header>
  
  
  
        <nav class="navi">
            <ul>
            <%
            	if(userClass==1){
                %> 
                <li><a href="studentinfo.jsp">학적관리</a></li>
                <li><a href="test.jsp">수업관리</a></li>
                <li><a href="#">성적관리</a></li>
                <li><a href="#">등록관리</a></li>
                <li><a href="#">장학관리</a></li>
                <li><a href="notice.jsp">공지사항</a></li>
                <%}else if(userClass==0){ %>
                
                <li><a href="userInfo.jsp">사용자 관리</a></li>
                <li><a href="studentinfo_staff.jsp">학생 학적관리</a></li>
                <li><a href="professor.jsp">교수 학적관리</a></li>
                <li><a href="notice.jsp">공지사항</a></li>
                
                <%}%>
                
                
            
            </ul>
        </nav>
  

	<div id="main">
  <div id="mainimg">
  	<img src="image/main_banner.jpg" width=900px; height=400px;>
  </div>
<%
if(userID!=null){
%>	
  <div id="side">
  <div id="user">
  	<ul><h3><b><%=userID %>님</b><br> 반갑습니다!</h3>
  		<li><a href="studentinfo.jsp">내 정보 </a></li>
  		<li><a href="changePW.jsp">비밀번호 변경 </a></li>
  		<li><a href="#">등록내역 조회</a></li>
  		<li><a href="#">안내사항</a></li>
  	</ul>
  </div>
<%} %>
 
</div>
  </div>
  
  
  
  
  
  
  

  
  
  
  
  
	<div>
	<footer style="text-align : center;">
		All right reserve KoreaUniversity		
	</footer>
	
	</div>



</body>
</html>
	

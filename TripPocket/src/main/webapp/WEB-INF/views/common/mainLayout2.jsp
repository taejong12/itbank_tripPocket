<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title" /></title>
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" /> 
		</div>
		<div id="sidebar-left">
			<tiles:insertAttribute name="side" />
		</div>
		<div id="content">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
    <script>
        // 스크립트 시작
        function toggleMenu(event) {
            event.stopPropagation();
            var sideMenu = document.getElementById("sideMenu");
            var darkOverlay = document.getElementById("darkOverlay");
            sideMenu.classList.toggle("show");
            darkOverlay.classList.toggle("show");
        }

        function closeMenu(event) {
            var sideMenu = document.getElementById("sideMenu");
            var darkOverlay = document.getElementById("darkOverlay");
            if (sideMenu.classList.contains("show")) {
                sideMenu.classList.remove("show");
                darkOverlay.classList.remove("show");
            }
        }

        function stopPropagation(event) {
            event.stopPropagation();
        }

        function toggleSubmenu(event, submenuId) {
            event.stopPropagation();
            var submenu = document.getElementById(submenuId);
            submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
        }

        document.addEventListener('scroll', function() {
            var sections = document.querySelectorAll('.section, .main');
            sections.forEach(function(section) {
                var rect = section.getBoundingClientRect();
                if (rect.top < window.innerHeight && rect.bottom > 0) {
                    section.classList.add('visible');
                } else {
                    section.classList.remove('visible');
                }
            });
        });

        // Trigger scroll event on page load to show sections in view
        window.addEventListener('load', function() {
            document.dispatchEvent(new Event('scroll'));
        });
        // 스크립트 끝
    </script>
</html>
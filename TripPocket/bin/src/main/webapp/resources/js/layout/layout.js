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
const navbarActive = () => {
  const path = window.location.pathname;
  const navLinks = document.querySelectorAll('.navbar-buttons');
  if (navLinks) {
    navLinks.forEach(link => link.classList.remove('nav-active'))
    if (path === '/') {
      navLinks[0].classList.add('nav-active')
    } else if (path.split('/').includes('dashboards')) {
      navLinks[1].classList.add('nav-active')
    } else if (path.includes('notes')) {
      navLinks[2].classList.add('nav-active')
    } else if (path.includes('ressources')) {
      navLinks[3].classList.add('nav-active')
    }
  }
}

export { navbarActive }

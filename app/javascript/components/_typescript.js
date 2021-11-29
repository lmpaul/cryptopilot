import Typed from 'typed.js'

const loadDynamicBannerText = () => {
  const path = window.location.pathname;
  if (path === "/") {
    new Typed('#banner-type-text', {
      strings: ["Track your investments", "Quickly and easily"],
      typeSpeed: 50,
      loop: true
    });
  }
}

export { loadDynamicBannerText };

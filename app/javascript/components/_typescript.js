import Typed from 'typed.js'

const loadDynamicBannerText = () => {
    new Typed('#banner-type-text', {
      strings: ["Track your investments", "Quickly and easily"],
      typeSpeed: 50,
      loop: true
    });
  }


export { loadDynamicBannerText };

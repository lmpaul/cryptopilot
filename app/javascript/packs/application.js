// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initSelect2 } from '../components/init_select2';
import { loadDynamicBannerText } from '../components/_typescript';
import { navbarActive } from "./navbar_active";
import { createHighCharts } from "./highcharts";
import { createSparklines } from "./sparkline";
import { createPieChart } from "./piechart";

const navbar_class = () => {
  const page = document.location.href
  const root = "http://localhost:3000/"
  const prod = "https://cryptopilot.herokuapp.com/"
  if (page === root || page === prod ){
    const navbar = document.querySelector('.navbar')
    navbar.classList.remove('navbar-bg');
    loadDynamicBannerText();
  }
}

const resources_nav = () => {
  const path = window.location.pathname;
  console.log(path.split('/'))
  if (path.split('/').includes('wallets')){
    const item = document.querySelector('#wallets')
    item.classList.toggle("resource-active")
  } else if (path.split('/').includes('exchanges')) {
    const item = document.querySelector('#exchanges')
    item.classList.toggle("resource-active")
  } else if (path.split('/').includes('youtube')) {
    const item = document.querySelector('#youtube')
    item.classList.toggle("resource-active")
  }
}

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  navbarActive();
  initSelect2();
  navbar_class();
  resources_nav();
  if(document.querySelector('#chart')) {
    createHighCharts();
  }
  if(document.querySelector('.sparkline')) {
    createSparklines();
  }
  if(document.querySelector('#pie')) {
    createPieChart();
  }
});

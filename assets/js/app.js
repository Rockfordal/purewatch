$(document).foundation();

$(document).ready(function(){
  navlights();
})

setTimeout(function() {
  navlights();
  menuclick();
  }, 300);

function navlights() {
  $("[data-menu-underline-from-center] a").addClass("underline-from-center");
}

function menuclick() {
  $('.top-bar a').click(function(event){
      event.preventDefault();
  });
}
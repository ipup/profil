$(document).ready(function(){
  $("#notice").hide().slideDown('slow').effect("highlight", {color: "#FFFFFF"}, 1000).effect("highlight", {color: "#FFFFFF"}, 1000);

  jQuery("input[placeholder], textarea[placeholder]").enablePlaceholder();

  // Find full instructions on: http://nivo.dev7studios.com/#usage
  $('#slider').nivoSlider({
    animSpeed:500, // Slide transition speed
    pauseTime:3000, // How long each slide will show
    directionNav:false, // Next & Prev navigation
    pauseOnHover:true // Stop animation while hovering
  });

  $("#close_notice").click(function() {
    $("#notice").slideUp();
    $("#uglydiv").hide();
  });
});
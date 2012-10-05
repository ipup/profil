$(document).ready(function() {
    
    $(".FieldTrigger").click(function () {
      $(this).next(".HiddenField").slideToggle('slow');
    });
    
});
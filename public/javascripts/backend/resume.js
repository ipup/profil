$(document).ready(function() {
    
    $(".FieldTrigger").click(function () {
      $(this).next(".HiddenField").slideToggle('slow');
    });
    
    $("#NewCvField_Trigger").click(function () {
      $("#NewCvField").slideToggle();
    });
    
    $("#NewCvFile_Trigger").click(function () {
      $("#NewCvFile_Trigger").hide();
      $("#NewCvFile").slideDown();
    });
    
});
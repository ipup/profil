$(document).ready(function() {
    // Ajax for navigation menu
    var ready = 1;
    var elt
    
    // Ajax request
    $("#navigation ul li").click(function() {
      if(ready === 1) { 
        ready = 0;
        
        if( jQuery.type(elt) !== "undefined") { 
          $(elt).css({
            'background':'#f0f0f0'
          });
        }
        $(this).css({
          'background':'#d8d8d8'
        });
        elt = this;
        
        page = ( $(this).attr("id") );
        $.ajax({ 
          type: "GET",
          url: page,
          data: "ajax=true", // Paramètre permettant au controlleur d'éliminer le layout
          cache: false,
          success: function(html) {            
            afficher(html);            
          },
          error: function(XMLHttpRequest,textStatus,errorThrows) {
            // Erreur durant la requête
          }
        });
      }
      
    });
    
    function afficher(donnees) {
      $(".step").empty();
      $(".step").append(donnees);
      
      //Init the TinyMCE Editors
      TinymceHammer.init();
         
      // Animate      
      var step_position = $(".step").offset();
      $(".step").offset({ top: step_position.top, left: step_position.left - 1000 });
      $(".step").animate({
          "left": '+=1000', 
        }, 750, 'easeOutBack');

      ready = 1;
    }
    
    //Ajax for padlock forms
    $('.padlock').live('click', function() {
      $(this).parents('form:first').submit();
    });


});
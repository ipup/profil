$(document).ready(function() { 
		        
    var step_position = $(".step").offset();
    $(".step").offset({ top: step_position.top, left: step_position.left - 1000 });
        
    $(".step").animate({
        	"left": '+=1000', 
        }, 750, 'easeOutBack');
   
    $("a.transition").click(function(event){ 
    	event.preventDefault();
		linkLocation = this.href;
        $(".step").animate({ 
           "left": '+=1000',
        }, 750, 'easeInBack', redirectPage).delay(500);  
    });  
    
    function redirectPage() {
		window.location = linkLocation;
	}
});
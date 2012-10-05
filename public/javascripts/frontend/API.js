$(document).ready(function(){
	$(".colorbox_twitter").click(function(ev) {
		ev.preventDefault();
		$(this).colorbox({width:"50%", height:"80%", iframe:true});
	});
	
	$(".colorbox_facebook").click(function(ev) {
		ev.preventDefault();
		$(this).colorbox({width:"50%", height:"80%", iframe:true});
	});
	
	$(".colorbox_linkedin").click(function(ev) {
		ev.preventDefault();
		$(this).colorbox({width:"50%", height:"80%", iframe:true});
	});
	
	$("#close_notice").click(function() {
	  $("#notice").hide();
	});
});
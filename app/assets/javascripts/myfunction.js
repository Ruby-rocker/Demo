$(document).ready(function () {
    //basic pop-up
    $('#open-pop-up-1').click(function(e) {
      e.preventDefault();
      $('#pop-up-1').popUpWindow({action: "open"});
    });
	
    $('#open-pop-up-2').click(function(e) {
      e.preventDefault();
      $('#pop-up-2').popUpWindow({action: "open"});
    });
    $('#open-pop-up-3').click(function(e) {
        e.preventDefault();
        $('#pop-up-3').popUpWindow({action: "open"});
    });
		
});
/******************************/

$(function(){
  $("select.select1, input.checkbox, input.file").uniform();
});

/***************scrool bar****************/

(function($){
  $(window).load(function(){
    $("#accordion .panel-body").mCustomScrollbar({
    setHeight:205,
    theme:"dark-3"
    });

    $("#accordion .panel-body2").mCustomScrollbar({
    setHeight:340,
    theme:"dark-3"
    });

    $("#accordion .panel-body3").mCustomScrollbar({
    setHeight:140,
    theme:"dark-3"
    });
  });
})(jQuery);

/**********************add user popup********************/

$(document).ready(function(){
	$("#tabsholder").tytabs({
	  tabinit:"1",
	  fadespeed:"fast"
	  });
});



//= require jquery-ui/datepicker
//= require jquery-ui/slider
//= require jquery-ui-timepicker-addon
//= require fileupload
//= require gallery

$(function() {
	
	$('.datepicker:not(.manual)').datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true
	});
  
  $('.birthdatepicker:not(.manual)').datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
        yearRange: '-99:-13'
	});
  
  
  $('.datetimepicker:not(.manual)').datetimepicker({
      dateFormat: 'yy-mm-dd',
      timeFormat: 'HH:mm:ss z'
    });
	
	$('.ui.accordion:not(.manual)').accordion({
		animateChildren: false
	});

	$('.menu .item:not(.manual)').tab();
	
	$('.ui.video:not(.manual)').video();
	
});
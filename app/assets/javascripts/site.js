//= require jquery
//= require jquery_ujs
//= require jquery.address
//= require semantic-ui
//= require messaging
//= require rails_confirm
//= require ga

$(function() {
	$('.ui.dropdown:not(.manual)').dropdown();

	$('.ui.checkbox:not(.manual)').checkbox();

	$('.ui.modal:not(.manual)').modal();
  
    $('.popup:not(.manual)').popup();

	$('.message .close').on('click', function() {
  		$(this).closest('.message').fadeOut();
	});
});

console.log('loaded site')
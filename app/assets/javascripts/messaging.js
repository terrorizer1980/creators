function showNotice(noticeText) {
	showMessage($('#global_notice'), noticeText);
}

function showAlert(alertText) {
	showMessage($('#global_alert'), alertText);
}

function showMessage($element, messageText) {
	if($element != null) {
		$element.find('.message').text(messageText);
        $element.addClass('popin');
			window.setTimeout(function() {
				$element.removeClass('popin');
			}, 4000);
	}
}

var modal_defaults = {
  title: 'Modal',
  message: '',
  icon_url: '/images/warning-icon.png',
  approve_text: 'OK',
  deny_text: 'Cancel',
  close_button: true,
  modal_id: 'mdbModalMessage',
  approved: null
}

function showModal(title, message, iconUrl, approveLabel, denyLabel, hideClose, onApprove) {
   var modal_options =
   {
    title: title,
    message: message,
    approve_text: approveLabel,
    deny_text: denyLabel,
    close_button: !hideClose,
    approved: onApprove
  }
   
  // if iconUrl is null, we want to keep the default, so leave it unset
  if(iconUrl != null) modal_options.icon_url = iconUrl;
  
  showModalDialog(modal_options);
}

function showModalDialog(modal_options) {
    var modal_settings = $.extend({}, modal_defaults, modal_options);
	var modal_html = 
		'<div id="' + modal_settings.modal_id + '" class="ui small modal">' + 
		(modal_settings.close_button ?
          ' <i class="close icon"></i>' :
          ''
        ) + 
		'<div class="header">' + 
		  modal_settings.title + 
		'</div>' + 
        (modal_settings.icon_url && modal_settings.icon_url != ''
        ?
          '<div class="image content">' + 
            '<div class="ui small image">' + 
              '<img src="' + modal_settings.icon_url + '">' + 
            '</div>' + 
            '<div class="description">' + 
              modal_settings.message + 
            '</div>' + 
          '</div>'
        : 
          '<div class="content">' + 
            modal_settings.message + 
          '</div>'
        ) + 
        '<div class="actions">' + 
          (modal_settings.approve_text && modal_settings.approve_text != ''
           ? 
              '<div class="ui positive right labeled icon button">' + 
                 modal_settings.approve_text + 
                '<i class="checkmark icon"></i>' + 
              '</div>'
           :
              ''
          ) +
          (modal_settings.deny_text && modal_settings.deny_text != ''
           ? 
              '<div class="ui secondary deny button">' + 
                 modal_settings.deny_text + 
              '</div>'
           :
              ''
          ) +
        '</div>' +
      '</div>';
  
	var $modal = $(modal_html);
	
	$modal.modal({
			onApprove : function() { 
              if(typeof(modal_settings.approved) == "function")
					modal_settings.approved.apply($modal);
			},
			onHidden : function() { $modal.remove(); }
		  })
		.modal('show');
}
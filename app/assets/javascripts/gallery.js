$(function() {
	$(document).bind('dragover', function (e) {
			var dropZone = $('.dropzone'),
			  foundDropzone,
				  timeout = window.dropZoneTimeout;
				  if (!timeout)
				  {
					  dropZone.addClass('in');
				  }
				  else
				  {
					  clearTimeout(timeout);
				  }
				  var found = false,
				  node = e.target;

				  do {

					  if ($(node).hasClass('dropzone'))
					  {
						  found = true;
						  foundDropzone = $(node);
						  break;
					  }

					  node = node.parentNode;

				  } while (node != null);

				  dropZone.removeClass('in hover');

				  if (found) {
					  foundDropzone.addClass('hover');
				  }

				  window.dropZoneTimeout = setTimeout(function () {
					  window.dropZoneTimeout = null;
					  dropZone.removeClass('in hover');
				  }, 100);
			});

			$(document).bind('drop dragover', function (e) {
				e.preventDefault();
			});
});

function loadGalleryList(className, galleryType, callback) {
	$.ajax({
		url : '/custom/gallery_images.json?gallery_type=' + galleryType,
		type: 'GET',
		success: function(data){
			try {
				$('.' + className).each(function(index) {
					$galleryMenu = $(this).find('.scrolling.menu');
					$galleryMenu.empty();

					if(data.length > 0)
						for(i = 0; i < data.length; i++) {

							itemHtml = 
								'<div class="item" data-value="' + data[i].url.url + '">' +
									'<img class="ui small image gallery-thumbnail" src="' + data[i].url.thumb_m.url + '">' + 
									'<div>' + data[i].name + '</div>' + 
								'</div>';
							$galleryMenu.append(itemHtml);

						}
					else 
						$galleryMenu.append('<div class="item disabled"><div>No images found</div></div>');
				});
			}
			catch(err) {
				console.log('error refreshing image list after upload: ' + err);
			}
			finally {
				if (typeof callback === "function")
					callback.call(this);
			}
		}
	});
}

function renderGalleryDropDowns(className, galleryType, idPrefix)
{
	var urlRenderImageDropDown = '/custom/render_gallery_dropdown?gallery_type=' + galleryType + '&class_name=' + className;
		$.ajax({
				url : urlRenderImageDropDown,
				type: 'GET',
				success: function(response, status) {
					try {
						$('.' + className)
							.each(function(index, element) { 
                                selectedValue = $(element).data('selected');
								$(element).replaceWith(
									$(response)
										.attr('id', idPrefix + index)
										.dropdown()
                                        .dropdown('set selected', selectedValue));
						});
					}
					catch(e) {
						showAlert(e);	
					}
				},
				error: function(response, status, err) {
					showAlert(status + ': ' + err);
				},
				complete: function(response, status) {
				}
		});
}
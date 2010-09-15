function css_emulateMaxWidthHeight() {
/* (c) Evan Roberts - 7/10/2009
www.GoWFB.com - Wholesale Furniture Brokers
Everyone is free to use/modify this but please keep the copyright statement!
*/

	$('img').each(function() {		

		if( $(this).css('max-width') != 'none' || $(this).css('max-height') != 'none' ) {

			max_width = $(this).css('max-width').replace(/[^0-9]/g, '');
			max_height = $(this).css('max-height').replace(/[^0-9]/g, '');		
			
			
			if( $(this).width() > max_width || $(this).height() > max_height ) {
				if( (max_width / $(this).width()) < (max_height / $(this).height()) ) {	
					$(this).css('height', Math.round($(this).height() * (max_width / $(this).width())));
					$(this).css('width', max_width);	 					
				} else {
					$(this).css('width', Math.round($(this).width() * (max_height / $(this).height())));
					$(this).css('height', max_height);
				}

			}
		}
	});
}


$(document).ready(function() {
	css_emulateMaxWidthHeight();
});
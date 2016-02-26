$(document).ready(function() {

	smoothScroll.init();

    setTimeout((function() {
        $('#new_fs_lexed').fadeOut();
        smoothScroll.animateScroll('#move_money_header')
    }), 3000);

    $('#new_fs_toggle').click(function() {
    	if ($('#new_fs_lexed').is(':visible')) {
    		return $('#new_fs_lexed').fadeOut();
    	}
    	else {
    		return $('#new_fs_lexed').fadeIn();    		
    	}
	});
});
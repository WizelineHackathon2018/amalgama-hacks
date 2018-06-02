$(document).ready(function(){
	$("#current_user").hide();
	$("#footer").hide();
	$('#logout').css( { 'top': '40px' } );

	var login = $('#login a');
	if ( login.attr('href') != "/admin/password/new" ) {
		login.hide();
	};
});

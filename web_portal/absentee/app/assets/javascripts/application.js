// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .
$(document).ready(function() {
  $(function () {
  	$('#form_take_attendance input[type=text]').bind('keypress keyclick',function(e){
  		var key = e.keyCode;
        if ((key >= 48 && key <= 57) || (key == 44)){
        	if(key == 44 && ($(this).val().length == 0)){
        		$(this).parent().parent('.row').find('.add_error').html("Attendence is not started with comma!");	
        		return false;
        	}
        	$(this).attr('class','form-control is_valid');
            $(this).parent().parent('.row').find('.add_error').html("");
        } else {
        	$(this).removeClass('is_valid').addClass('is-invalid');
        	$(this).parent().parent('.row').find('.add_error').html("Only numbers and comma allowed !");
            return false;
        }
  	});
  });
});
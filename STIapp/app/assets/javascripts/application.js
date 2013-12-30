// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){

  $(document).on('change','#device_type',function(){
  	$('.Printing').addClass('hidden')
  	$('.Network').addClass('hidden')
  	$('.' + $(this).val()).removeClass('hidden')

  })
  if($('#device_type').val() !="")
  	$('.'+ $('#device_type').val()).removeClass('hidden')
  $(document).on('click' ,'.abc',function(){
		$('.abc').prop('checked',false)
		$(this).prop('checked',true)
	})

})
document.addEventListener("page:load", function(){
  if($('#device_type').val() !="")
  	$('.'+ $('#device_type').val()).removeClass('hidden')

$(document).on('change','#device_type',function(){
  	$('.Printing1').addClass('hidden')
  	$('.Network1').addClass('hidden')
  	$('.' + $(this).val()).removeClass('hidden')

  })
	$(document).on('click' ,'.abc',function(){
		$('.abc').prop('checked',false)
		$(this).prop('checked',true)
	})
});
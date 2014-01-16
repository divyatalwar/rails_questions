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
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery.countdown.js
//= require_tree .


$(document).ready(function(){
  $('.nested_fields').removeClass('hidden')

  $(document).on('change','#no_of_choices, #question_question_type',function(){
    $('.nested_fields').removeClass('hidden')
    
    $.ajax({
      type: 'get',
      url: 'http://localhost:3000/admin/questions/new' + '?selectbox=' + $('#no_of_choices').val() + '&question_type=' + $('#question_question_type').val() + '&content=' + $('#question_description').val(),
      dataType: 'html',
      success: function(data) {
        h = $(data).filter('.question_create')

        $('.question_create').html(h)
      }
    })




  // window.location.href =  'http://localhost:3000/questions/new' + '?selectbox=' + $('#no_of_choices').val()
    

  })

  
  $(document).on('click', '.show', function(e){
    e.preventDefault();
     $('div.question_text[data-id = "' + $(this).attr('data-name') + '"]').toggle('blind', 1000);
     $('div.question_text[data-id = "' + $(this).attr('data-name') + '"]').toggleClass('hidden').animate(2000);


  
    })
  $(document).on('click' ,'.checked',function(){
    $('.checked').prop('checked',false)
    $(this).prop('checked',true)
  })

   $(document).on('click', '.quiz_submit', function(){

      $(document).on('ajax:error' , '.quiz_form', function(evt, xhr, status, error){
        alert(evt)
        alert(xhr)
        alert(status)
        alert(error)
        error = $(xhr).filter('#error_explanation')
        $('div.error_messages').removeClass('hidden')
        $('div.error_messages').find("#error_explanation").remove()
        $('div.error_messages').append(error)
      })
    })

  $(document).on('change', '#question_question_type', function(){
    $('.choice_list').removeClass('hidden')
    $('.nested_fields').removeClass('hidden')
    $('#no_of_choices').removeClass('hidden')
    if($(this).val() == "Analytical"){
      $('.choice_list').addClass('hidden')
      $('.nested_fields').addClass('hidden')
      $('#no_of_choices').addClass('hidden')
    }


  })

})
document.addEventListener("page:load", function(){
//   if($('#device_type').val() !="")
//     $('.'+ $('#device_type').val()).removeClass('hidden')

// $(document).on('change','#device_type',function(){
//     $('.Printing1').addClass('hidden')
//     $('.Network1').addClass('hidden')
//     $('.' + $(this).val()).removeClass('hidden')

//   })
//   $(document).on('click' ,'.checked',function(){
//     $('.checked').prop('checked',false)
//     $(this).prop('checked',true)
//   })
});

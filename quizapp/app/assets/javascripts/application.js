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
//= require_tree .


$(document).ready(function(){
  var applicationHandler = new ApplicationHandler();
})
var ApplicationHandler = function() {
  this.init();

}
ApplicationHandler.prototype = {
  init: function() {
    this.choicesFieldHandler();
    this.questionHandler();
    this.radiobuttonHandler();
    this.questionTypeFieldHandler();
    this.errorHandler();
  },

  choicesFieldHandler: function(){
    $(document).on('change','#no_of_choices, #question_question_type',function(){
      $('.nested_fields').removeClass('hidden')
      url = $('#no_of_choices').data('path')
      $.ajax({
        type: 'get',
        url: url + '?selectbox=' + $('#no_of_choices').val() + '&question_type=' + $('#question_question_type').val() + '&content=' + $('#question_description').val(),
        dataType: 'html',
        success: function(data) {
          filtered_data = $(data).filter('.question_create')
          $('.question_create').html(filtered_data)
        }
      })
    })
  },
  questionHandler:function(){
    $(document).on('click', '.show', function(e){
      e.preventDefault();
      $('div.question_text[data-id = "' + $(this).attr('data-name') + '"]').toggle('blind', 1000);
      $('div.question_text[data-id = "' + $(this).attr('data-name') + '"]').toggleClass('hidden').animate(2000);
    })
  },
  radiobuttonHandler:function(){
    $(document).on('click' ,'.checked',function(){
      $('.checked').prop('checked',false)
      $(this).prop('checked',true)
    })
  },

  questionTypeFieldHandler:function(){
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
  },
  errorHandler:function(){

    $(document).on('click', '.quiz_submit', function(){
      $(document).on('ajax:error' , '.quiz_form', function(evt, xhr, status, error){
        $('div.error_messages').removeClass('hidden')
        $('div.error_messages').find("#error_explanation").remove()
        $('div.error_messages').html(xhr.responseText)
      })
    })

  }

}


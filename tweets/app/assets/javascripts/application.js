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
    $(document).on("keyup", ".tag", function() {
      content = $(this).val().split(' ')
      if(content[content.length-1].indexOf("@") == 0){
        $.ajax({
          type: 'get',
          url: $('.tag').data('path'), 
          dataType: "json", 
          success: function(data){
            console.log(data)
            $('.tag').autocomplete({ 
              source: function( request, response ) {
                response( $.ui.autocomplete.filter(
                data, extractLast( request.term) ) );
                console.log(request.term)
                console.log(extractLast( request.term) )
              },
              minLength: 3,
              delay: 500,
              focus: function() {
                return false;
              },
              select: function( event, ui ) {
                var terms = split( this.value );
                terms.pop();
                terms.push( '@'+ ui.item.label );
                terms.push( "" );
                this.value = terms.join( " " );
                return false;
              }
            });
          },
          error: function(a,b,c){
          }
        });
      }
    });
    function split( val ) {
      return val.split( /\s/ );
    }
    function extractLast( term ) {
      return split( term ).pop().split('@')[1];
    }
  });

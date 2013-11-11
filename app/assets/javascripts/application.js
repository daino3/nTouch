//= require jquery
//= require jquery_ujs

$(document).ready(function(){

  $("#search_input").keyup(function() {
    var userInput = $(this).val();
    $("#list li").map(function(index, value) {
        $(value).toggle($(value).text().toLowerCase().indexOf(userInput) >= 0);
    });
  });

  $(".friends").on('click', function(){
    var fbId = ($(this).data('fid'))
    var data = {facebookUser: fbId}
    $.get('/search', data, function(response){
      $node = "<div>"+response+"</div>"
      $("#list").html($node);
    });
  });

  $(".landing_page_photo_button").on('click', function(event){
    event.preventDefault();
    console.log('hi');
    $("#friend_graph_div").show();
    $("#friend_event_div").show();
  });


  //-------------edit event form ---------//
  $(".individual_event").on('click', function(event){
    event.preventDefault();
    var friendData = $(this).children(":first").attr('href').match(/\d{1,}/);
    var eventData = $(this).children(":first").attr('href').match(/\d{1,}$/);
    var friendId      = friendData[0];
    var eventId       = eventData[0];
    var url           = '/friends/'+friendId+'/events/'+eventId;
    $.get(url, function(response){
      console.log(response)
      $("#form_for_new_event").remove();
      $("#form_to_update_event").remove();
      $(response).appendTo("#event_form_panel").hide().fadeIn("slow");
    });
  });

  //-------------new event form ---------//
  $(".new_event_button").on('click', function(event){
    event.preventDefault();
    var friendData = $(this).attr('href').match(/\d{1,}/);
    var friendId      = friendData[0];
    var data          = { 'friendId': friendId };
    var url           = '/friends/'+friendId+'/events/new';
    console.log(url);
    $.get(url, function(response){
      $("#form_for_new_event").remove();
      $("#form_to_update_event").remove();
      $(response).appendTo("#event_form_panel").hide().fadeIn("slow");
    });
  });

    $('#other_event').hide();
    $("#event_description").change(function(){
      if ($('#event_description option:selected').text() === "Other")
      {
        $('#other_event').show();
      }
      else
      {
        $('#other_event').hide();
      }
    });

});


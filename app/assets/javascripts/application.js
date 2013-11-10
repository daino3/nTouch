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

  $(".photo_button_list").on('click', function(event){
    event.preventDefault(); //remove this to see the event form
    console.log('hi');
    $("#friend_graph_div").show();
    $("#friend_event_div").show();
  });
});


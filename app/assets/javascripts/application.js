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
//= require jquery-1.9.1.min
//= require js/jquery.isotope.min
//= require js/jquery.imagesloaded
//= require bootstrap.min
//= require flexslider
//= require carousel
//= require js/jquery.cslider
//= require slider
//= require js/jquery.fancybox
//= require js/twitter
//= require js/jquery.placeholder.min
//= require jquery-easing-1.3
//= require js/layerslider.kreaturamedia.jquery
//= require js/excanvas
//= require js/jquery.flot
//= require js/jquery.flot.pie.min
//= require js/jquery.flot.stack
//= require js/jquery.flot.resize.min
//= require js/modernizr
//= require js/retina
//= require js/custom
//= require turbolinks
//= require_tree .

$(document).ready(function(){

  //------------- search: dynammically seach through list of facebook friends ---------//

  $(document).on('keyup',"#search_input",function() {
    var userInput = $(this).val();
    $("#list li").map(function(index, value) {
        $(value).toggle($(value).text().toLowerCase().indexOf(userInput) >= 0);
    });
  });

  //------------- display: Render Search Bar ---------//

  $(document).on('click','#show_search_bar_button',function() {
    $('#edit_profile_div').remove()
    $("#display_search_bar").toggle();
    
    if ($(this).text() === 'Search Friends'){
      $(this).text("Hide Search");
    }
    else if ($(this).text() === 'Hide Search'){
      $(this).text("Search Friends");
    }
  });

 //------------- display: replace search fields with form to add friend ---------//

  $(document).on('click', ".friends", function(){
    var fbId = ($(this).data('fid'))
    var data = {facebookUser: fbId}
    $.get('/search', data, function(response){
      $node = "<div>"+response+"</div>"
      $("#list").html($node);
    });
  });

  //------------- display: replace search fields with form to edit friend ---------//

  $(document).on('click', '.edit_button', function(event){
    event.preventDefault();
    $('#edit_profile_div').remove()
    $("#display_search_bar").hide();
    $('#show_search_bar_button').text('Search Friends')

    var url = $(this).children(':first').attr('href')
    
    $.get(url, function(response){
      console.log(response);
      $('#manage_friends_photo_list_div').after(response)
    });
  })

 //------------- display: graph and friend events on landing page ---------//

  $(document).on('click', ".photo_button_list", function(event){
    event.preventDefault();

    $("#friend_graph_div").show();
    $("#friend_event_div").show();
  });

  //------------- display: EDIT EVENT form (dynamic with type) ---------//

  $(document).on('click', ".individual_event", function(event){
    event.preventDefault();
    $('#saved_message').remove();
    $("#errors_list").children().remove();
    $(".div_for_new_event").remove();
    $(".div_to_update_event").remove();

    var friendData = $(this).children(":first").attr('href').match(/\d{1,}/);
    var eventData = $(this).children(":first").attr('href').match(/\d{1,}$/);
    var friendId  = friendData[0];
    var eventId = eventData[0];
    var url = '/friends/'+friendId+'/events/'+eventId;

    $.get(url, function(response){
      $(".div_for_new_event").remove();
      $(".div_to_update_event").remove();

      $(response).appendTo("#event_form_panel").hide().fadeIn("slow");
    });
  });

  //------------- display: NEW EVENT form (dynamic with type) ---------//

  $(document).on('click', ".new_event_button", function(event){
    event.preventDefault();
    $('#saved_message').remove();
    $("#errors_list").children().remove();
    $(".div_for_new_event").remove();
    $(".div_to_update_event").remove();

    var friendData = $(this).attr('href').match(/\d{1,}/);
    var friendId = friendData[0];
    var data = { 'friendId': friendId };
    url = '/friends/'+friendId+'/events/new';

    $("#form_selector").fadeIn();
  });

  $(document).on('change', "#Event_Type", function(event){
    event.preventDefault();

    var formType = $(this).context.value
    var data = {form: formType}

    $.get(url, data, function(response){
      $(".div_for_new_event").remove();
      $(".div_to_update_event").remove();

      $(response).appendTo("#event_form_panel").hide().fadeIn("slow");
    });
  });

  //------------- checks: UPDATE USER settings ---------//

  $(document).on('submit', '.edit_user',function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var email = getDataFromForm('update_user','user[email]');
    var birthday = getDataFromForm('update_user','user[birthday]');
    var phoneNumber = getDataFromForm('update_user','user[phone_number]');

    if ((checkEmailFormat(email) != true || checkDateFormat(birthday, "Please Enter the Date in YYYY-MM-DD") != true || checkPhoneNumberFormat(phoneNumber) != true)){
      return false
    };
  });

  //------------- checks: ADD FRIEND form ---------//

  $(document).on('submit', '#add_friend_form', function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var birthday = getDataFromForm('new_friend','new_friend[birthday]');
    if (checkDateFormat(birthday, "Please Enter the Date in YYYY-MM-DD") != true){
      return false
    };
  });

  //------------- checks: EDIT FRIEND form ---------//

  $(document).on('submit', '.edit_friend', function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var email = getDataFromForm('edit_friend_form','friend[email]');
    var birthday = getDataFromForm('edit_friend_form','friend[birthday]');
    var phoneNumber = getDataFromForm('edit_friend_form','friend[phone_number]');

    if ((checkEmailFormat(email) != true || checkDateFormat(birthday, "Please Enter the Date in YYYY-MM-DD") != true || checkPhoneNumberFormat(phoneNumber) != true)){
      return false
    };
  });

  //------------- checks: NEW ANNUAL EVENT form ---------//

  $(document).on('submit', ".form_to_add_annual_event", function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var eventDescription = getDataFromForm('add_event_form', 'event[description]');
    var eventDate = getDataFromForm('add_event_form', 'event[date]');
    var notificationDate = getDataFromForm('add_event_form', 'event[notification_date]');

    if ((checkDateFormat(eventDate, "Please Enter a Date for the Event") != true || checkDateFormat(notificationDate, "Please Select a Notification Date (we'll send a reminder on both days)") != true || validateNotificationDate(eventDate, notificationDate) != true || checkDescription(eventDescription) != true)){
      return false
    };
  });

      //------------- checks: EDIT ANNUAL EVENT form ---------//

  $(document).on('submit', '.form_to_update_annual_events',function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var eventDescription = getDataFromForm('edit_annual_event_form', 'event[description]');
    var eventDate = getDataFromForm('edit_annual_event_form', 'event[date]');
    var notificationDate = getDataFromForm('edit_annual_event_form', 'event[notification_date]');

    if ((checkDateFormat(eventDate, "Please Enter a Date for the Event") != true || checkDateFormat(notificationDate, "Please Provide a Notification Date (we'll send a reminder on both days)") != true || validateNotificationDate(eventDate, notificationDate) != true || checkDescription(eventDescription) != true)){
      return false
    };
  });
      //------------- checks: NEW FREQUENT EVENT form ---------//

  $(document).on('submit','.form_to_add_frequent_event', function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var eventDescription = getDataFromForm('add_event_form', 'event[description]');
    var notificationDate = getDataFromForm('add_event_form', 'event[notification_date]');

    if ((checkDateFormat(notificationDate, "Please Select a Start Date (we'll send a reminder starting on that day)") != true || checkDescription(eventDescription) != true)){
      return false
    };
  });


  //------------- checks: EDIT FREQUENT EVENT form ---------//

  $(document).on('submit', '.form_to_update_frequent_events', function(event){

    $('#saved_message').remove();
    $("#errors_list").children().remove();

    var eventDescription = getDataFromForm('edit_frequent_event_form', 'event[description]');
    var notificationDate = getDataFromForm('edit_frequent_event_form', 'event[notification_date]');

    if ((checkDateFormat(notificationDate, "Please Select a Start Date (we'll send a reminder starting on that day)") != true || checkDescription(eventDescription) != true)){
      return false
    };
  });

 });

//------------- get data from forms ---------//

var getDataFromForm = function(form_name,input_name) {
  var data = document.forms[form_name][input_name].value;
  return data;
}

//------------- form input checks ---------//

var checkEmailFormat = function(email) {
  if (email.match(/\w+@\w+\.\w{2,}/)) {
    return true
  }
  else {
    $("#errors_list").append("<li style='color:red'> Please Enter the Email in me@mail.com format </li>").hide().fadeIn();
  }
}

var checkDateFormat = function(birthday, message) {
  if (birthday.match(/(\d{4})-(\d{2})-(\d{2})/)) {
    return true;
  }
  else {
    $("#errors_list").append("<li style='color:red'>" + message + "</li>").hide().fadeIn();
  }
}

var checkPhoneNumberFormat = function(phoneNumber) {
  if (phoneNumber.match(/(\d{9})/)) {
    return true
  }
  else {
    $("#errors_list").append("<li style='color:red'> Please Enter the Phone Number as 9 Consectuve Integers </li>").hide().fadeIn();
  }
}

var checkDescription = function(eventDescription){
  if (eventDescription.length != 0) {
    return true
   }
  else {
    $("#errors_list").append("<li style='color:red'> Event Description can't be Blank </li>").hide().fadeIn();
  }
}

var validateNotificationDate = function(eventDate, notificationDate){
  var eventDateInFormat = new Date(eventDate)
  var notificationDateInFormat = new Date(notificationDate)
  if (notificationDateInFormat < eventDateInFormat) {
    return true;
    }
  else {
    $("#errors_list").append("<li style='color:red'> Notification Date Must be Before Event Date </li>").hide().fadeIn();
    }
}



$(document).ready(function() {
  $('#description').change(function() {
    $.ajax({ url: '/events/new/' + this.value + '/partial_form' });
  });
});
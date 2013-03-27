$(document).ready(function() {
  $("#loader").hide();
  $('form').submit(function(e) {
    e.preventDefault();
    $("#loader").show();

    var data = $(this).serialize();
    
    $.ajax({
      url: '/tweet',
      method: 'post',
      data: data,
      dataType: "html"
    }).done(function(server_data) {
      $("#loader").hide();
      $('#message').text("Success");
      $('input').val('');
    });
  });
});

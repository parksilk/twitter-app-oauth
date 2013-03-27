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
      alert(server_data);
      // $("#message").html(server_data);
      $("#loader").hide();
    });
  });
});

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
    }).done(function(job_id) {
      // $("#loader").hide();
      // alert(job_id);
      window.location = '/tweet';
      // $('#message').text("Success! Your job ID is: " + job_id);
      // $('input').val('');
    });
  });
});

$(document).ready(function() {
  
  $('#sign-in').click(function() {
    
    $('#sign-in').attr('disabled', 'disabled');
    $('#sign-in-button').attr('src', '/assets/sign_in_grey.png');
    
    navigator.id.getVerifiedEmail(function(assertion) {
        if (assertion) {
            // This code will be invoked once the user has successfully
            // selected an email address they control to sign in with.
            $.post('/session/browser_id', { assertion: assertion, location: location.href }, browser_id_success);
        } else {
            alert('wrong');
            // something went wrong!  the user isn't logged in.
        }
    });
    
    return false;
  });
  
  function browser_id_success(data) {
    location.href = data.next;
  }
  
});
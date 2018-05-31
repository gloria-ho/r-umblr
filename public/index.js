'use strict'

$(document).ready(function() {

  // the two pasword inputs
  let pw = $('#password');
  let conf = $('#password_again');
  let form_btn = $('#create_account, #save_btn');
  let pwError = $('#pw_error');

  // if passwords don't match inputs change color and show error
  conf.focusout(function() {
    if ( conf.val() != pw.val() ) {
      pw.css({'borderColor': 'red'});
      conf.css({'borderColor': 'red'});
      pwError.show();
    } else {
      pw.css({'borderColor': 'silver'});
      conf.css({'borderColor': 'silver'});
      pwError.hide();
    }    
  })

  // if passwords don't match, button is disabled and input shakes
  form_btn.on('click', (function(e) {
    if ( conf.val() != pw.val() ) {
      e.preventDefault();
      pw.effect('shake');
    }
  }));



});
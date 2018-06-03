// called with the results from from FB.getLoginStatus().
function statusChangeCallback(response) {
  console.log('statusChangeCallback');
  console.log(response);
  // response object is returned with a status field that lets the
  // app know the current login status of user.
  if (response.status === 'connected') {
    // logged into app and fb.
    testAPI();
  } else if (response.status === 'not_authorized') {
    // logged into fb, but not app.
    document.getElementById('status').innerHTML = 'Please log into this app.';
  } else {
    // not logged into fb, not sure if logged into app or not.
    document.getElementById('status').innerHTML = 'Connect with Facebook';
  }
}

// function is called when user finishes fb login
function checkLoginState() {
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
}

window.fbAsyncInit = function() {
  FB.init({
    appId      : '1994177677301128',
    cookie     : true,  // enable cookies to allow server to
                        // access the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v3.0'
  });

  // call FB.getLoginStatus()
  // gets the state of user and return one of three states to the callback:
  //   1. Logged into your app ('connected')
  //   2. Logged into Facebook, but not app ('not_authorized')
  //   3. Not logged into Facebook and can't tell if user is 
  //   logged into app or not.
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
};

// load the SDK asynchronously
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0&appId=1994177677301128&autoLogAppEvents=1';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

// test the Graph API after login is successful
// see statusChangeCallback() for when this call is made.
function testAPI() {
  console.log('Welcome!  Fetching your information.... ');
  FB.api('/me', function(response) {
    console.log('Successful login for: ' + response.name);
    document.getElementById('status').innerHTML =
      'Thanks for logging in, ' + response.name + '!';
  });
}
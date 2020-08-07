<!DOCTYPE html>
  <!--[if IE 8]>
    <html xmlns="http://www.w3.org/1999/xhtml" class="ie8" lang="en-US">
  <![endif]-->
  <!--[if !(IE 8) ]><!-->
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
  <!--<![endif]-->
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Log In &lsaquo; WP 3.8.1 &#8212; WordPress</title>
  <link rel='dns-prefetch' href='//s.w.org' />
<link rel='stylesheet' id='dashicons-css'  href='http://wp.lab/wp-includes/css/dashicons.min.css?ver=3.8.1' media='all' />
<link rel='stylesheet' id='buttons-css'  href='http://wp.lab/wp-includes/css/buttons.min.css?ver=3.8.1' media='all' />
<link rel='stylesheet' id='forms-css'  href='http://wp.lab/wp-admin/css/forms.min.css?ver=3.8.1' media='all' />
<link rel='stylesheet' id='l10n-css'  href='http://wp.lab/wp-admin/css/l10n.min.css?ver=3.8.1' media='all' />
<link rel='stylesheet' id='login-css'  href='http://wp.lab/wp-admin/css/login.min.css?ver=3.8.1' media='all' />
  <meta name='robots' content='noindex,noarchive' />
  <meta name='referrer' content='strict-origin-when-cross-origin' />
    <meta name="viewport" content="width=device-width" />
    </head>
  <body class="login no-js login-action-login wp-core-ui  locale-en-us">
  <script type="text/javascript">
    document.body.className = document.body.className.replace('no-js','js');
  </script>
    <div id="login">
    <h1><a href="https://wordpress.org/">Powered by WordPress</a></h1>

    <form name="loginform" id="loginform" action="http://wp.lab/wp-login.php" method="post">
      <p>
        <label for="user_login">Username or Email Address</label>
        <input type="text" name="log" id="user_login" class="input" value="" size="20" autocapitalize="off" />
      </p>

      <div class="user-pass-wrap">
        <label for="user_pass">Password</label>
        <div class="wp-pwd">
          <input type="password" name="pwd" id="user_pass" class="input password-input" value="" size="20" />
          <button type="button" class="button button-secondary wp-hide-pw hide-if-no-js" data-toggle="0" aria-label="Show password">
            <span class="dashicons dashicons-visibility" aria-hidden="true"></span>
          </button>
        </div>
      </div>
            <p class="forgetmenot"><input name="rememberme" type="checkbox" id="rememberme" value="forever"  /> <label for="rememberme">Remember Me</label></p>
      <p class="submit">
        <input type="submit" name="wp-submit" id="wp-submit" class="button button-primary button-large" value="Log In" />
                  <input type="hidden" name="redirect_to" value="http://wp.lab/wp-admin/" />
                  <input type="hidden" name="testcookie" value="1" />
      </p>
    </form>

          <p id="nav">
                  <a href="http://wp.lab/wp-login.php?action=lostpassword">Lost your password?</a>
                </p>
          <script type="text/javascript">
      function wp_attempt_focus() {setTimeout( function() {try {d = document.getElementById( "user_login" );d.focus(); d.select();} catch( er ) {}}, 200);}
wp_attempt_focus();
if ( typeof wpOnload === 'function' ) { wpOnload() }    </script>
        <p id="backtoblog"><a href="http://wp.lab/">
    &larr; Back to WP 3.8.1   </a></p>
      </div>
  <script src='http://wp.lab/wp-includes/js/jquery/jquery.js?ver=1.12.4-wp'></script>
<script src='http://wp.lab/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1'></script>
<script>
var _zxcvbnSettings = {"src":"http:\/\/wp.lab\/wp-includes\/js\/zxcvbn.min.js"};
</script>
<script src='http://wp.lab/wp-includes/js/zxcvbn-async.min.js?ver=1.0'></script>
<script>
var pwsL10n = {"unknown":"Password strength unknown","short":"Very weak","bad":"Weak","good":"Medium","strong":"Strong","mismatch":"Mismatch"};
</script>
<script src='http://wp.lab/wp-admin/js/password-strength-meter.min.js?ver=3.8.1'></script>
<script src='http://wp.lab/wp-includes/js/underscore.min.js?ver=1.8.3'></script>
<script>
var _wpUtilSettings = {"ajax":{"url":"\/wp-admin\/admin-ajax.php"}};
</script>
<script src='http://wp.lab/wp-includes/js/wp-util.min.js?ver=3.8.1'></script>
<script>
var userProfileL10n = {"warn":"Your new password has not been saved.","warnWeak":"Confirm use of weak password","show":"Show","hide":"Hide","cancel":"Cancel","ariaShow":"Show password","ariaHide":"Hide password"};
</script>
<script src='http://wp.lab/wp-admin/js/user-profile.min.js?ver=3.8.1'></script>
  <script>
  /(trident|msie)/i.test(navigator.userAgent)&&document.getElementById&&window.addEventListener&&window.addEventListener("hashchange",function(){var t,e=location.hash.substring(1);/^[A-z0-9_-]+$/.test(e)&&(t=document.getElementById(e))&&(/^(?:a|select|input|button|textarea)$/i.test(t.tagName)||(t.tabIndex=-1),t.focus())},!1);
  </script>
    <div class="clear"></div>
  </body>
  </html>

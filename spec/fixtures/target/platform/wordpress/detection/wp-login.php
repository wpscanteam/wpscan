<!DOCTYPE html>
  <!--[if IE 8]>
    <html xmlns="http://www.w3.org/1999/xhtml" class="ie8" lang="en-US">
  <![endif]-->
  <!--[if !(IE 8) ]><!-->
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
  <!--<![endif]-->
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Log In WP Lab</title>
  <link rel='dns-prefetch' href='//s.w.org' />
<link rel='stylesheet' id='dashicons-css'  href='https://ex.lo/wp-includes/css/dashicons.min.css?ver=5.0.3' type='text/css' media='all' />
<link rel='stylesheet' id='buttons-css'  href='https://ex.lo/wp-includes/css/buttons.min.css?ver=5.0.3' type='text/css' media='all' />
<link rel='stylesheet' id='forms-css'  href='https://ex.lo/wp-admin/css/forms.min.css?ver=5.0.3' type='text/css' media='all' />
<link rel='stylesheet' id='l10n-css'  href='https://ex.lo/wp-admin/css/l10n.min.css?ver=5.0.3' type='text/css' media='all' />
<link rel='stylesheet' id='login-css'  href='https://ex.lo/wp-admin/css/login.min.css?ver=5.0.3' type='text/css' media='all' />
  <meta name='robots' content='noindex,noarchive' />
  <meta name='referrer' content='strict-origin-when-cross-origin' />
    <meta name="viewport" content="width=device-width" />
    </head>
  <body class="login login-action-login wp-core-ui  locale-en-us">
    <div id="login">
    <h1><a href="https://ex.lo/" title="WP Lab" tabindex="-1">WP Lab</a></h1>

<form name="loginform" id="loginform" action="https://ex.lo/wp-login.php" method="post">
  <p>
    <label for="user_login">Username or Email Address<br />
    <input type="text" name="log" id="user_login" class="input" value="" size="20" /></label>
  </p>
  <p>
    <label for="user_pass">Password<br />
    <input type="password" name="pwd" id="user_pass" class="input" value="" size="20" /></label>
  </p>
    <p class="forgetmenot"><label for="rememberme"><input name="rememberme" type="checkbox" id="rememberme" value="forever"  /> Remember Me</label></p>
  <p class="submit">
    <input type="submit" name="wp-submit" id="wp-submit" class="button button-primary button-large" value="Log In" />
    <input type="hidden" name="redirect_to" value="https://ex.lo/wp-admin/" />
    <input type="hidden" name="testcookie" value="1" />
  </p>
</form>

<p id="nav">
  <a href="https://ex.lo/wp-login.php?action=lostpassword">Lost your password?</a>
</p>

<script type="text/javascript">
function wp_attempt_focus(){
setTimeout( function(){ try{
d = document.getElementById('user_login');
d.focus();
d.select();
} catch(e){}
}, 200);
}

wp_attempt_focus();
if(typeof wpOnload=='function')wpOnload();
</script>

  <p id="backtoblog"><a href="https://ex.lo/">&larr; Back to WP Lab</a></p>

  </div>


    <div class="clear"></div>
  </body>
  </html>


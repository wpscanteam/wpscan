<!DOCTYPE html>
  <!--[if IE 8]>
    <html xmlns="http://www.w3.org/1999/xhtml" class="ie8" lang="en-US">
  <![endif]-->
  <!--[if !(IE 8) ]><!-->
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
  <!--<![endif]-->
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>WordPress 4.1 &rsaquo; Log In</title>
  <link rel='stylesheet' id='buttons-css'  href='http://wp.lab/wordpress-4.1/wp-includes/css/buttons.min.css?ver=4.1' type='text/css' media='all' />
<link rel='stylesheet' id='open-sans-css'  href='//fonts.googleapis.com/css?family=Open+Sans%3A300italic%2C400italic%2C600italic%2C300%2C400%2C600&#038;subset=latin%2Clatin-ext&#038;ver=4.1' type='text/css' media='all' />
<link rel='stylesheet' id='dashicons-css'  href='http://wp.lab/wordpress-4.1/wp-includes/css/dashicons.min.css?ver=4.1' type='text/css' media='all' />
<link rel='stylesheet' id='login-css'  href='http://wp.lab/wordpress-4.1/wp-admin/css/login.min.css?ver=4.1' type='text/css' media='all' />
<script type='text/javascript' src='http://wp.lab/wordpress-4.1/wp-includes/js/jquery/jquery.js?ver=1.11.1'></script>
<script type='text/javascript' src='http://wp.lab/wordpress-4.1/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.2.1'></script>
<script type='text/javascript' src='http://wp.lab/wordpress-4.1/wp-content/plugins/security-protection/js/security-protection.js?ver=4.1'></script>
<meta name='robots' content='noindex,follow' />
  </head>
  <body class="login login-action-login wp-core-ui  locale-en-us">
  <div id="login">
    <h1><a href="https://wordpress.org/" title="Powered by WordPress" tabindex="-1">WordPress 4.1</a></h1>

<form name="loginform" id="loginform" action="http://wp.lab/wordpress-4.1/wp-login.php" method="post">
  <p>
    <label for="user_login">Username<br />
    <input type="text" name="log" id="user_login" class="input" value="" size="20" /></label>
  </p>
  <p>
    <label for="user_pass">Password<br />
    <input type="password" name="pwd" id="user_pass" class="input" value="" size="20" /></label>
  </p>

<p class="secprot-form-group secprot-form-group-code"><label>Copy this code "<span>asd321</span>" and paste it into input: <br /><input type="text" name="secprot-code" class="input" value="2.1" /></label></p>

<p class="secprot-form-group secprot-form-group-empty" style="display: none;"><label>Leave this field empty: <br /><input type="text" name="secprot-empty-email-url-website" class="input" value="" /></label></p>
  <p class="forgetmenot"><label for="rememberme"><input name="rememberme" type="checkbox" id="rememberme" value="forever"  /> Remember Me</label></p>
  <p class="submit">
    <input type="submit" name="wp-submit" id="wp-submit" class="button button-primary button-large" value="Log In" />
    <input type="hidden" name="redirect_to" value="http://wp.lab/wordpress-4.1/wp-admin/" />
    <input type="hidden" name="testcookie" value="1" />
  </p>
</form>

<p id="nav">
  <a href="http://wp.lab/wordpress-4.1/wp-login.php?action=lostpassword" title="Password Lost and Found">Lost your password?</a>
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

  <p id="backtoblog"><a href="http://wp.lab/wordpress-4.1/" title="Are you lost?">&larr; Back to WordPress 4.1</a></p>

  </div>


    <div class="clear"></div>
  </body>
  </html>


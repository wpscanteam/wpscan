<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Wordpress 3.3.2 &rsaquo; Log In</title>
<link rel='stylesheet' id='wp-admin-css'  href='http://lamp/wordpress-3.3.2/wp-admin/css/wp-admin.css?ver=20111208' type='text/css' media='all' />
<link rel='stylesheet' id='colors-fresh-css'  href='http://lamp/wordpress-3.3.2/wp-admin/css/colors-fresh.css?ver=20111206' type='text/css' media='all' />
<meta name='robots' content='noindex,nofollow' />
</head>
<body class="login">
<div id="login"><h1><a href="http://wordpress.org/" title="Powered by WordPress">Wordpress 3.3.2</a></h1>

<form name="loginform" id="loginform" action="http://lamp/wordpress-3.3.2/wp-login.php" method="post">
	<p>
		<label for="user_login">Username<br />
		<input type="text" name="log" id="user_login" class="input" value="" size="20" tabindex="10" /></label>
	</p>
	<p>
		<label for="user_pass">Password<br />
		<input type="password" name="pwd" id="user_pass" class="input" value="" size="20" tabindex="20" /></label>
	</p>
<p>Login form protected by <a href='http://www.bad-neighborhood.com/login-lockdown.html'>Login LockDown</a>.<br /><br /><br /></p>	<p class="forgetmenot"><label for="rememberme"><input name="rememberme" type="checkbox" id="rememberme" value="forever" tabindex="90" /> Remember Me</label></p>
	<p class="submit">
		<input type="submit" name="wp-submit" id="wp-submit" class="button-primary" value="Log In" tabindex="100" />
		<input type="hidden" name="redirect_to" value="http://lamp/wordpress-3.3.2/wp-admin/" />
		<input type="hidden" name="testcookie" value="1" />
	</p>
</form>

<p id="nav">
<a href="http://lamp/wordpress-3.3.2/wp-login.php?action=lostpassword" title="Password Lost and Found">Lost your password?</a>
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

	<p id="backtoblog"><a href="http://lamp/wordpress-3.3.2/" title="Are you lost?">&larr; Back to Wordpress 3.3.2</a></p>
	</div>


<div class="clear"></div>
</body>
</html>

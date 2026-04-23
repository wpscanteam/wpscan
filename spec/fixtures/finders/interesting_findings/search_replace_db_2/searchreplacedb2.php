<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:dc="http://purl.org/dc/terms/" dir="ltr" lang="en-US">
<head profile="http://gmpg.org/xfn/11">
  <title>Search and replace DB.</title>
  <style type="text/css">
  body {
    background-color: #E5E5E5;
    color: #353231;
          font: 14px/18px "Gill Sans MT","Gill Sans",Calibri,sans-serif;
  }

  p {
      line-height: 18px;
      margin: 18px 0;
      max-width: 520px;
  }

  p.byline {
      margin: 0 0 18px 0;
      padding-bottom: 9px;
            border-bottom: 1px dashed #999999;
      max-width: 100%;
  }

  h1,h2,h3 {
      font-weight: normal;
      line-height: 36px;
      font-size: 24px;
      margin: 9px 0;
      text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.8);
  }

  h2 {
      font-weight: normal;
      line-height: 24px;
      font-size: 21px;
      margin: 9px 0;
      text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.8);
  }

  h3 {
      font-weight: normal;
      line-height: 18px;
      margin: 9px 0;
      text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.8);
  }

  a {
      -moz-transition: color 0.2s linear 0s;
      color: #DE1301;
      text-decoration: none;
      font-weight: normal;
  }

  a:visited {
     -moz-transition: color 0.2s linear 0s;
      color: #AE1301;
  }

  a:hover, a:visited:hover {
      -moz-transition: color 0.2s linear 0s;
      color: #FE1301;
      text-decoration: underline;
}

  #container {
    display:block;
    width: 768px;
    padding: 10px;
    margin: 0px auto;
    border:solid 10px 0px 0px 0px #ccc;
    border-top: 18px solid #DE1301;
    background-color: #F5F5F5;
  }

  fieldset {
    border: 0 none;
  }

  .error {
    border: solid 1px #c00;
    padding: 5px;
    background-color: #FFEBE8;
    text-align: center;
    margin-bottom: 10px;
  }

  label {
    display:block;
    line-height: 18px;
    cursor: pointer;
  }

  select.multi,
  input.text {
    margin-bottom: 1em;
    display:block;
    width: 90%;
  }

  select.multi {
    height: 144px;
  }


  input.button {
  }

  div.help {
    border-top: 1px dashed #999999;
    margin-top: 9px;
  }

  </style>
</head>
<body>
  <div id="container">

  <h1>Safe Search Replace</h1>
  <p class="byline">by interconnect/<strong>it</strong></p>
      <h2>Database details</h2>
    <form action="searchreplacedb2.php?step=3" method="post">
      <fieldset>
        <p>
          <label for="host">Server Name:</label>
          <input class="text" type="text" name="host" id="host" value="localhost" />
        </p>

        <p>
          <label for="data">Database Name:</label>
          <input class="text" type="text" name="data" id="data" value="" />
        </p>

        <p>
          <label for="user">Username:</label>
          <input class="text" type="text" name="user" id="user" value="" />
        </p>

        <p>
          <label for="pass">Password:</label>
          <input class="text" type="password" name="pass" id="pass" value="" />
        </p>

        <p>
          <label for="pass">Charset:</label>
          <input class="text" type="text" name="char" id="char" value="" />
        </p>
          <input type="submit" class="button" value="Submit DB details" />      </fieldset>
    </form>     <div class="help">
      <h4><a href="http://interconnectit.com/">interconnect/it</a> <a href="http://interconnectit.com/124/search-and-replace-for-wordpress-databases/">Safe Search and Replace on Database with Serialized Data v2.0.0</a></h4>
      <p>This developer/sysadmin tool helps solve the problem of doing a search and replace on a
      WordPress site when doing a migration to a domain name with a different length.</p>

      <p><style="color:red">WARNING!</strong> Take a backup first, and carefully test the results of this code.
      If you don't, and you vape your data then you only have yourself to blame.
      Seriously.  And if you're English is bad and you don't fully understand the
      instructions then STOP.  Right there.  Yes.  Before you do any damage.

      <h2>Don't Forget to Remove Me!</h3>

      <p style="color:red">Delete this utility from your
      server after use.  It represents a major security threat to your database if
      maliciously used.</p>

      <h2>Use Of This Script Is Entirely At Your Own Risk</h2>

      <p> We accept no liability from the use of this tool.</p>

      <p>If you're not comfortable with this kind of stuff, get an expert, like us, to do
      this work for you.  You do this ENTIRELY AT YOUR OWN RISK!  We accept no responsibility
      if you mess up your data.  There is NO UNDO here!</p>

      <p>The easiest way to use it is to copy your site's files and DB to the new location.
      You then, if required, fix up your .htaccess and wp-config.php appropriately.  Once
      done, run this script, select your tables (in most cases all of them) and then
      enter the search replace strings.  You can press back in your browser to do
      this several times, as may be required in some cases.</p>

      <p>Of course, you can use the script in many other ways - for example, finding
      all references to a company name and changing it when a rebrand comes along.  Or
      perhaps you changed your name.  Whatever you want to search and replace the code will help.</p>

      <p><a href="http://interconnectit.com/124/search-and-replace-for-wordpress-databases/">Got feedback on this script? Come tell us!</a>

    </div>
  </div>
</body>
</html>

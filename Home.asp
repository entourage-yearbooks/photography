<!-- #include File="../../wwwroot/appservices/DatabaseManager.inc" -->
<!-- #include File="../../wwwroot/appservices/YearbookDatabaseManager.inc" -->
<%
  bgcolor = "990000"
  bootstrapDir = "bootstrap-3.3.7-dist"
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title><%= pageTitle %></title>
	  <link rel="icon" href="http://www.entourageco.com/wp-content/uploads/2017/06/cropped-favicon_whiteE-32x32.png" sizes="32x32" />
    <link rel="icon" href="http://www.entourageco.com/wp-content/uploads/2017/06/cropped-favicon_whiteE-192x192.png" sizes="192x192" />
    <link rel="apple-touch-icon-precomposed" href="http://www.entourageco.com/wp-content/uploads/2017/06/cropped-favicon_whiteE-180x180.png" />
    <meta name="msapplication-TileImage" content="http://www.entourageco.com/wp-content/uploads/2017/06/cropped-favicon_whiteE-270x270.png" />    <!-- Bootstrap -->
    
    <link href="<%= bootStrapDir %>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%= bootStrapDir %>/js/bootstrap.min.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
      body { 
        background: url(/images/background-image.jpg) no-repeat center center fixed; 
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
        padding: 0px;
        margin: 0px;
      }
      
      .full-background {
        width: 100%;
        height: 100%;
        padding: 0px;
        background: none;
      }
      
      .access-container {
        background: rgba(40, 40, 40, 0.7);
        border: 1px solid #black;
        box-shadow: 5px 5px 5px black;
        border-radius: 5px;
        margin-top: 5vh;
        padding: 20px;
      }

      .access-container-2 {
        background: rgba(40, 40, 40, 0.7);
        border: 1px solid #black;
        box-shadow: 5px 5px 5px black;
        border-radius: 5px;
        margin-top: 5vh;
        padding: 20px;
      }
      
      .header-text {
        color: white;
        font-size: 20pt;
        text-shadow: 1px 1px black;
        font-family: Helvetica;
      }
      
      .access-input {
        width: 300px;
        font-size: 24pt;
        padding: 30px;
        text-align: center;
      }

      .access-submit {
        width: 300px;
        height: 60px;
        font-size: 20pt;
        padding: 10px;
        text-align: center;
        background-color: #990000;
        color: white;
        text-shadow: 1px 1px black;
      }
      
      .access-link {
        color: white;
        text-decoration: underline;
      }
      
      .access-link:hover {
        color: #990000;
      }
      
      .access-row {
        margin: 10px 0px 10px 0px !important;
        
      }
      
      .row {
        margin: 0px;
      }
      
      .footer {
        position: absolute;
        bottom: 0px;
        width: 100%;
        height: 50px;
        line-height: 50px;
        background-color: #990000;
        color: white;
        text-shadow: 1px 1px black;
        cursor: pointer;
        font-size: 20pt;
      }
      
      .footer:hover {
        background-color: #aa0000;
      }
      
      ::-webkit-input-placeholder {
         font-style: italic;
      }
      :-moz-placeholder {
         font-style: italic;  
      }
      ::-moz-placeholder {
         font-style: italic;  
      }
      :-ms-input-placeholder {  
         font-style: italic; 
      }      
      
      .modal-dialog-style {
        background-color: white;
        border-radius: 10px;
        box-shadow: 5px 5px 5px black;
      }
      
      /* Important part */
      .modal-dialog{
          overflow-y: initial !important
      }
      .modal-body{
          height: 500px;
          overflow-y: auto;
      }    
      
      .modal-header-close-button {
        font-weight: bold;
        color: black;
        background-color: #dddddd;
        border-radius: 5px;
        float: right;
        cursor: pointer;
        padding: 5px;
      }
      
      
    </style>
    <script language="javascript">
      function openModalWindow(winName) {
        $("#" + winName).modal();
      }
      
      function closeModalWindow(winName) {
        $("#" + winName).modal("hide");
      }
      
      $(function() {
        console.log( "document fully loaded" );
      });      
    </script>
  </head>
  <body>
    <div class="container full-background vertical-center">
      <div class="row">
        <div class="col-xs-10 col-xs-offset-1 col-md-4 col-md-offset-4 access-container" align="center">
          <img src="https://entourage-web-images.s3.amazonaws.com/photography/ENTOURAGE_PHOTOGRAPHY.png" class="img-responsive" alt="Entourage Photography" width="350">          
          <div class="row access-row">
            <div class="col-md-12 header-text">
              Did you receive a code from us?
            </div>            
          </div>
          <div class="row access-row">
            <div class="form-group">
              <input type="text" class="form-control access-input" placeholder="Enter your code" name="access_code" id="access_code" value="<%= accessCode %>" required>      
            </div>                
          </div>
          <div class="row access-row">
            <div class="form-group">
              <input type="submit" class="form-control access-input access-submit" value="Continue">
            </div>                
          </div>
          <div class="row access-row">
            <div class="col-md-12 header-text">
              <a href="" class="access-link" onclick="openModalWindow('no-code-window');return false;">Not receive a code?</a>
            </div>
          </div>
        </div>      
      </div>
      <div class="row">
        <div class="col-xs-10 col-xs-offset-1 col-md-4 col-md-offset-4 access-container-2" align="center">
          <div class="row access-row">
            <div class="col-md-12 header-text">
              Already have an Entourage account?
            </div>
          </div>
          <div class="row access-row">
            <div class="col-md-12 header-text">
              <button onclick="openModalWindow('login-window');" class="form-control access-submit">Login</button>
            </div>
          </div>
        </div>
      
      </div>
      <footer class="footer">
        <div class="container">
          <div class="col-md-12" align="center">
            Learn More
          </div>
        </div>
      </footer>
    </div>    
    <div id="no-code-window"  class="modal fade" role="dialog">
      <div class="modal-dialog modal-lg modal-dialog-style">
        <div class="modal-content">
          <div class="modal-header">        
            <div class="modal-header-close-button" onclick="closeModalWindow('no-code-window');">
              X
            </div>
            <h3>Find Your Access Code</h3>
          </div>
          <div class="modal-body">    
            <div class="row" style="margin-bottom: 20px;">
              <div class="col-md-12">
                You should have received your Access Code for your photographs either by Email, message on your phone, or notice from your school.  If you
                do not have your access code you can search for you code below.
              </div>
            </div>                
            <form id="accessForm" name="accessForm">
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-12">
                <div class="form-group">
                  <div  class="col-md-3 col-xs-12">
                    <label for="school_name"">School / Organization:</label>
                  </div>
                  <div  class="col-md-4 col-xs-12">
                    <input type="text" class="form-control" placeholder="School Name" name="school_name" id="school_name" value="" required>      
                  </div>
                </div>                      
              </div>
            </div>                
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-12">
                <div class="form-group">
                  <div  class="col-md-3 col-xs-12">
                    <label for="first_name"">First Name:</label>
                  </div>
                  <div  class="col-md-4 col-xs-12">
                    <input type="text" class="form-control" placeholder="First Name" name="first_name" id="first_name" value="" required>      
                  </div>
                </div>      
                
              </div>
            </div>                
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-12">
                <div class="form-group">
                  <div  class="col-md-3 col-xs-12">
                    <label for="last_name"">Last Name:</label>
                  </div>
                  <div  class="col-md-4 col-xs-12">
                    <input type="text" class="form-control" placeholder="Last Name" name="last_name" id="last_name" value="" required>      
                  </div>
                </div>      
                
              </div>
            </div>                
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-3 col-md-offset-3">
                <div class="form-group">
                    <input type="submit" class="form-control btn btn-block btn-default" value="Search">
                </div>
              </div>
            </div>                
            </form>
            <div class="row access-row">
              <div class="col-md-12">
                Or you can email us at <a href="mailto: photohelp@entourageco.com">photohelp@entourageco.com</a> to request your photo access code.  Make sure to include the name of the school, the name of the student that 
                we photographed, and their grade. 
              </div>
            </div>                
            <div class="row">
              <div class="col-md-12">            
                <h3>
                Thank you for using Entourage Photography!
                </h3>
              </div>
            </div>
          </div>
          <div id="actionButtonsDiv" class="modal-footer">
            <input type="button" class="btn" data-dismiss="modal" value="Close">
            
          </div>
        </div>
      </div>
    </div>
    <div id="login-window"  class="modal fade" role="dialog">
      <div class="modal-dialog modal-md modal-dialog-style">
        <div class="modal-content">
          <div class="modal-header">        
            <div class="modal-header-close-button" onclick="closeModalWindow('login-window');">
              X
            </div>
            <h3>Login</h3>
          </div>
          <form name="loginForm" id="loginForm" action="LoginAction.asp">
          <div class="modal-body" style="height: 400px;">    
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-12">
                <div class="form-group">
                  <div  class="col-md-12">
                    <label for="photography_user_id"">Username / Email:</label>
                  </div>
                  <div  class="col-md-12">
                    <input type="text" class="form-control" placeholder="e.g., name@domain.com" name="photography_user_id" id="photography_user_id" value="" required>      
                  </div>
                </div>                      
              </div>
            </div>                
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-12">
                <div class="form-group">
                  <div  class="col-md-12">
                    <label for="photography_user_password"">Password:</label>
                  </div>
                  <div  class="col-md-12">
                    <input type="password" class="form-control" placeholder="******" name="photography_user_password" id="photography_user_password" value="" required>      
                  </div>
                </div>                      
              </div>
            </div>                
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-10 col-md-offset-1">
                <div class="form-group">
                    <input type="submit" class="form-control btn btn-block btn-default" value="Login">
                </div>
              </div>
            </div>                
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-10 col-md-offset-1">
                Don't have a Login? You can create one for free now.
              </div>
            </div>
            <div class="row"  style="margin-bottom: 20px;">
              <div class="col-md-10 col-md-offset-1">
                <button onclick="document.location = 'Register.asp';" class="btn btn-block btn-info">Register</button>
              </div>
            </div>
              
          </div>
          </form>
        </div>
      </div>
    </div>
    
    
  </body>
</html>

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
    <link href="/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    </style>
  </head>
  <body>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%= bootStrapDir %>/js/bootstrap.min.js"></script>
    <div id="mainBody">
       <div class="container">
          <div class="header clearfix">
            <nav>
              <ul class="nav nav-pills pull-right">
                <li role="presentation"><a href="/Home.asp?contract_id=<%= contractId %>">Home</a></li>
                <li role="presentation"><a href="/contact.asp?uid=<%= uid %>">Contact</a></li>
                <li role="presentation"><a href="/index.asp?contract_id=<%= contractId %>">Log Out</a></li>
              </ul>
            </nav>
            <img src="https://entourage-web-images.s3.amazonaws.com/photography/ENTOURAGE_PHOTOGRAPHY.png" class="img-responsive" alt="Entourage Photography" width="250">
          </div>
          <br>

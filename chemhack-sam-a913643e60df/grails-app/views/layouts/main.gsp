<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title><g:layoutTitle default="SAM"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
		%{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">--}%
		<link rel="stylesheet" href="${createLinkTo(dir: 'css',file: 'sam.css')}">
		%{--<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>--}%
		%{--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>--}%
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.6/angular.min.js"></script>
		<script src="${createLinkTo(dir: 'js',file: 'ui-bootstrap-0.9.0.min.js')}"></script>
		<g:layoutHead/>
	</head>
	<body>
	<header class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">RIFM Skin Absorption Model (SAM) Calculator</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="${createLink(controller: 'index',action: 'index')}">Home</a></li>
					<li><a href="${createLink(controller: 'index',action: 'help')}">Help</a></li>
					<li><a href="${createLink(controller: 'index',action: 'about')}">About</a></li>
					<li><a href="${createLink(controller: 'index',action: 'contact')}">Contact</a></li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</header>
	<div style="height: 50px"></div>
	<g:layoutBody/>
	</body>
</html>

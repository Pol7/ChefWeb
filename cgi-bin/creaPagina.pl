#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
#die "Fatal errors are now sent to browser";
#$pagina = new CGI; 
#print $pagina->header('text/html');
#$value = $pagina->start_html; 
print  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	<head>
		<title>Primi</title>
		</head>
	<body>';
print '<p>paragrafo</p>';
print '</body>
</html>
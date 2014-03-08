#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
#die "Fatal errors are now sent to browser";
$pagina = new CGI; 
#print $pagina->header('text/html');
#$value = $pagina->start_html; 
print  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Primi</title>
		<link href="./css/page_style.css" rel="stylesheet" type="text/css" media="screen"/>
		<link href="./css/page_styleMedium.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)" />
		<link href="./css/page_styleSmall.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:690px), only screen and (max-device-width:690px)" />
	</head>
	<body>'
#print $pagina->h1("Questo &egrave; il mio titolo");
print '<p>paragrafo</p>';
print $pagina->end_html;
#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
#die "Fatal errors are now sent to browser";
$pagina = new CGI; 
$value=$pagina->header('text/html');
$value = $value.$pagina->start_html;
print $value;
print $pagina->h1("Questo &egrave; il mio titolo");
print '<p>paragrafo</p>';
print $pagina->end_html;
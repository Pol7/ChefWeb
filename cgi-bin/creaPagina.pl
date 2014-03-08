#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);

$pagina = new CGI; 
print $pagina->header('text/html');
print $pagina->start_html;


print '<p>paragrafo</p>';

print $pagina->end_html;
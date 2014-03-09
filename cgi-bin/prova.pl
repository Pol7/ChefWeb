#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);

$pagina = new CGI; 
print $pagina->header('text/html');
print $pagina->start_html(
				-title=>'prova',
				-style=>{'src'=>'../public_html/css/page_style.css'},
				-lang=>'it',
		);
print '<form action="elabora.cgi" method="get">
		Tecnologie Web - 31
		Tecnologie Web - 32
	   </form>';
print $pagine->end_html;
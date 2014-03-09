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
print '
		<FORM ACTION="/cgi-bin/cerca.pl" METHOD=GET>
         Nome: <INPUT NAME=nome>
         <INPUT TYPE=SUBMIT> <INPUT TYPE=RESET>
      </FORM>';
print $pagina->end_html;
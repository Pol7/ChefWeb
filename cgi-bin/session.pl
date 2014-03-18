#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;
use CGI::Session();


#crea un oggetto CGI
my $pagina = new CGI;


print $pagina->header('text/html');
print $pagina->start_html(
				-title=>'Sessioni',				
				-style=>[{ -media => 'screen',
							-src => '../css/page_style.css'},
						  { -media => 'handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)',
							-src => '../css/page_styleMedium.css'},
						  { -media => 'handheld, screen and (max-width:690px), only screen and (max-device-width:690px)',
							-src => '../css/page_styleSmall.css'}],	
				-lang=>'it'				
);

my $nome_utente = getSession();
print '<h1>Buon giorno '.$nome_utente.'</h1>';


print $pagina->end_html;

sub getSession() {
	my $session = CGI::Session->load() or die $!;
	if ($session->is_empty) {
		print '<h1>is empty</h1>';
		return undef; 
	} 
	if ($session->is_expired){
		print '<h1>expired</h1>';
		return undef; 
	}else {
		my $utente = $session->param('usernameL');
		print '<h1>metodo '.$utente.'</h1>';
		return $utente; 
	}
}
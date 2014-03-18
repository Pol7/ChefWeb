#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;
use CGI::Session();


#crea un oggetto CGI
$pagina = new CGI;

$nome_utente = getSession();


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
print '<h1>Buon giorno '.$nome_utente.'</h1>';


print $pagina->end_html;

sub createSession() {
	$session = new CGI::Session();
	$session->param('utente', $nome_utente);
	print $session->header(-location=>"$base");
}

sub getSession() {
	$session = CGI::Session->load() or die $!;
	if ($session->is_expired || $session->is_empty ) {
		return undef; 
	} else {
		my $utente = $session->param('utente');
		return $utente; 
	}
}
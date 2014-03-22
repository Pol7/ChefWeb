#!/usr/bin/perl
# Script che inserisce i dati nell'XML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;

my $pagina = new CGI;

my $file = '../public_html/database/utenti.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");
#recupero l'elemento radice
my $root = $doc->getDocumentElement || die("Non accedo alla radice");
my @utenti = $root->getElementsByTagName("utenti");

#recupero input della form
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
($name, $value) = split(/=/, $pair);
$value =~ tr/+/ /;
$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/g;
$name =~ tr/+/ /;
$name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/g;
$input{$name} = $value;
}

my $username = $pagina->param('username');
my $password = $pagina->param('password');
my $nome = $pagina->param('nome');
my $cognome = $pagina->param('cognome');
my $sesso = $pagina->param('sesso');
my $giorno = $pagina->param('giorno');
my $mese = $pagina->param('mese');
my $anno = $pagina->param('anno');


my $new_nodo_string = "\n<utente>\n<username>$username</username>\n<password>$password</password>\n<nome>$nome</nome>\n<cognome>$cognome</cognome>\n<sesso>$sesso</sesso>\n<giorno>$giorno</giorno>\n<mese>$mese</mese>\n<anno>$anno</anno>\n</utente>";
my $new_nodo = $parser->parse_balanced_chunk($new_nodo_string);
my $root->appendChild($new_nodo);
print OUT $doc->toString;



 

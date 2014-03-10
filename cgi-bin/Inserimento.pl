#!/usr/bin/perl
# Script che inserisce i dati nell'XML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;

my $pagina = new CGI;

my $file = '../public_html/database/ricette.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");
#recupero l'elemento radice
my $root = $doc->getDocumentElement || die("Non accedo alla radice");

#recupero input della form
my $in = $ENV{'QUERY_STRING'};

my $nome = $pagina->param('nomeRicetta');
my $tipo = $pagina->param('tipologia');
my $autore = $pagina->param('nomeAutore');
my $img = $pagina->param('immagine');
my $proc = $pagina->param('message');
my $nome = $pagina->param('nomeRicetta');

$new_nodo_string = "<ricetta tipo='$tipo'>\n<nome>$nome</nome>\n<autore>$autore</autore>\n<img></img>\n<>\n</comments>\n</episode>\n";
$new_nodo = $parser->parse_balanced_chunk($new_nodo_string);
$season_to_process->appendChild($new_nodo);






#creo una stringa con un nuovo elemento
#$nuovo_el = "\n<ricetta> $input{'contenuto'}</ricetta>\n";



















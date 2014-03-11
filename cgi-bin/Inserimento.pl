#!/usr/bin/perl
# Script che inserisce i dati nell'XML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;

my $pagina = new CGI;

#my $file = '../public_html/database/ricette.xml';
#creazione oggetto parser
#my $parser = XML::LibXML->new();
#apertura file e lettura input
#my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");
#recupero l'elemento radice
#my $root = $doc->getDocumentElement || die("Non accedo alla radice");

#recupero input della form
#my $in = $ENV{'QUERY_STRING'};

#my $nome = $pagina->param('nomeRicetta');
#my $tipo = $pagina->param('tipologia');
#my $autore = $pagina->param('nomeAutore');
#my $img = $pagina->param('immagine');
#my $proc = $pagina->param('message');

#my $new_nodo_string = "<ricetta tipo='$tipo'>\n<nome>$nome</nome>\n<autore>$autore</autore>\n<img></img>\n<procedimento>$proc</procedimento>\n</ricetta>";
#my $new_nodo = $parser->parse_balanced_chunk($new_nodo_string);
#my $ricetta_to_insert->appendChild($new_nodo);




#creo una stringa con un nuovo elemento
#$nuovo_el = "\n<ricetta> $input{'contenuto'}</ricetta>\n";

#codice per visualizzare alcuni
print "Content-type: text/html\n\n";
print "<html> <head><title> Pagina riassuntiva</title></head>";
print "<body>";
my $in = $ENV{'QUERY_STRING'};
my $metodo = $ENV{'REQUEST_METHOD'};
print "Query string : <b>$in</b><br>";
print "Request method: <b>$metodo</b><br>";
print "</body></html>";

my $nome = $pagina->param('nomeRicetta');
print "$nome"















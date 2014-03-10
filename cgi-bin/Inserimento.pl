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

my $nome= $pagina->param('nomeRicetta');
print $nome;






#creo una stringa con un nuovo elemento
$nuovo_el = "\n<ricetta> $input{'contenuto'}</ricetta>\n";



















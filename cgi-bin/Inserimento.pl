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
#print "Content-type: text/html\n\n";
#print "<html> <head><title> Pagina riassuntiva</title></head>";
#print "<body>";
#my $in = $ENV{'QUERY_STRING'};
#my $metodo = $ENV{'REQUEST_METHOD'};
#print "Query string : <b>$in</b><br>";
#print "Request method: <b>$metodo</b><br>";
#print "</body></html>";

print '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">/n<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Ricette</title><link href="./css/page_style.css" rel="stylesheet" type="text/css" media="screen"/><link href="./css/page_styleMedium.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)" /><link href="./css/page_styleSmall.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:690px), only screen and (max-device-width:690px)" /><script type="text/javascript" src="./javascript/formR.js"></script></head>'
print "	<body>
<div id="header">
<div id="register">
<a href="Registrazione.html">Accedi!</a>
</div>
</div>
<div id="sottoHeader">
<div id="path"> Ti trovi in: <a id="linkPercorso" href="index.html" xml:lang="en">Home</a> > Inserisci Ricetta</div>
<input class="search" type="submit" value="Cerca!">
<input class="search" type="text" name="Cerca:" value="" placeholder="Ricerca">
</div>
<div id="menu">
<ul>
<li class="listMenu"><a class="listMenu2" href="index.html" xml:lang="en">Home</a></li>
<li class="listMenu"><a class="listMenu2" href="./cgi-bin/creaPagina.pl?tipo=Primi">Primi</a></li>
<li class="listMenu"><a class="listMenu2" href="./cgi-bin/creaPagina.pl?tipo=Secondi">Secondi</a></li>
<li class="listMenu"><a class="listMenu2" href="./cgi-bin/creaPagina.pl?tipo=Contorni">Contorni</a></li>
<li class="listMenu"><a class="listMenu2" href="./cgi-bin/creaPagina.pl?tipo=Antipasti">Antipasti</a></li>
<li class="listMenu"><a class="listMenu2" href="./cgi-bin/creaPagina.pl?tipo=Cocktail">Cocktail</a></li>
<li class="listMenu"><a class="listMenu2" href="./cgi-bin/creaPagina.pl?tipo=Dessert">Dessert</a></li>
<li class="listMenu"><a class="listMenu2" >Inserisci Ricetta</a></li>
</ul>
<div id="clearBoth"></div>
</div>

<div id="maincol">"
my $nome = $pagina->param('nomeRicetta');
print "$nome"
print "</div>"














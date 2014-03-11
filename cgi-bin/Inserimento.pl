#!/usr/bin/perl
# Script che inserisce i dati nell'XML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;

my $pagina = new CGI;

my $nome = $pagina->param('nomeRicetta');
my $tipo = $pagina->param('tipologia');
my $autore = $pagina->param('nomeAutore');
my $img = $pagina->param('immagine');
my $proc = $pagina->param('message');

my $session=undef;
unless ($nome)
{
$session->param("season_error","Nome Obbligatorio");
}

my $file = '../public_html/database/ricette.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");
#recupero l'elemento radice
my $radice = $doc->getDocumentElement || die("Non accedo alla radice");

#recupero input della form
my $in = $ENV{'QUERY_STRING'};



my $new_nodo_string = "<ricetta tipo='$tipo'>\n<nome>$nome</nome>\n<autore>$autore</autore>\n<img></img>\n<procedimento>$proc</procedimento>\n</ricetta>";
my $new_nodo = $parser->parse_balanced_chunk($new_nodo_string);
my $ricetta_to_insert->appendChild($new_nodo);






#pagina HTML
print "Content-type: text/html\n\n";
print '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Ricetta inserita</title>
<link href="../css/page_style.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="../css/page_styleMedium.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)" />
<link href="../css/page_styleSmall.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:690px), only screen and (max-device-width:690px)" />
<script type="text/javascript" src="./javascript/formR.js"></script>
</head>';
print '	<body>
<div id="header">
<div id="register">
<a href="../Registrazione.html">Accedi!</a>
</div>
</div>
<div id="sottoHeader">
<div id="path"> Ti trovi in: <a id="linkPercorso" href="../index.html" xml:lang="en">Home</a> > Ricetta Inserita</div>
<input class="search" type="submit" value="Cerca!">
<input class="search" type="text" name="Cerca:" value="" placeholder="Ricerca">
</div>
<div id="menu">
<ul>
<li class="listMenu"><a class="listMenu2" href="../index.html" xml:lang="en">Home</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Primi">Primi</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Secondi">Secondi</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Contorni">Contorni</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Antipasti">Antipasti</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Cocktail">Cocktail</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Dessert">Dessert</a></li>
<li class="listMenu"><a class="listMenu2" href="../formRicette.html">Inserisci Ricetta</a></li>
</ul>
<div id="clearBoth"></div>
</div>

<div id="maincol">';
my $nome = $pagina->param('nomeRicetta');
print '     <div id="testo"> 
            <h1 id="testo1">Ricetta inserita correttamente<h1>
            <p class="testo2"> Torna alla <a href="../index.html" xml:lang="en"> Home</a></p>
            <p class="testo2"> Inserisci una <a href="../formRicette.html">Nuova Ricetta</a></p> 
            </div>
            </div>
            <div id="footer">
            <div id="footerImg1">
              <a href="http://validator.w3.org/">
              <img src="../images/valid-xhtml10.png" alt="CSS Valid!"/></a>
            </div>
            <div id="footerText">
            Gruppo beo
            </div>
            <div id="footerImg2">
              <a href="http://jigsaw.w3.org/css-validator/">
              <img src="../images/vcss-blue.gif" alt="XHTML 1.0 Valid!"/></a>
            </div>
      </div>
     </body>
</html>';














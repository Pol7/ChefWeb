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
my @ingrediente;
my @unita;
my @quantita;
my $i=0;
my $check=1;

while($check==1){
            my $ing="ingrediente$i";
            my $qua="quantita$i";
            my $uni="unita$i";
            my $a=$pagina->param("$ing");
            my $b=$pagina->param("$qua");
            my $c=$pagina->param("$uni");
            if($a){
                        @ingrediente[$i]=$a;
                        @quantita[$i]=$b;
                        @unita[$i]=$c;
                        $i++;
            }
            else{
                        $check=0;
            }
}

my $upload_dir = '../public_html/database/images/ricette';
my $file = '../public_html/database/ricette.xml';

if ( !$img )
{
$img="default.jpg";
}
else{
my $upload_filehandle = $pagina->upload("immagine");
open ( UPLOADFILE, ">$upload_dir/$img" ) || die "no open upload";
binmode UPLOADFILE;
while ( <$upload_filehandle> )
{
print UPLOADFILE;
}
close UPLOADFILE;
}

#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");
#recupero l'elemento radice
my $radice = $doc->getDocumentElement || die("Non accedo alla radice");

#recupero input della form
#my $in = $ENV{'QUERY_STRING'};

my $frammento = "<ricetta tipo='$tipo'>\n<nome>$nome</nome>\n<autore>$autore</autore>\n<img src='$img' alt='Immagine descrittiva della ricetta'></img>\n";
my $frammento2="";
$i=0;
foreach my $ingred(@ingrediente){
            $frammento2=$frammento2."<ingrediente>\n<nome>$ingred</nome>\n<quantita>@quantita[$i]</quantita>\n<unitadimisura>@unita[$i]</unitadimisura>\n</ingrediente>\n";
            $i++;
}
$frammento=$frammento.$frammento2."<procedimento>$proc</procedimento>\n</ricetta>";
my $nodo = $parser->parse_balanced_chunk($frammento);
$radice->appendChild($nodo)|| die("no append");

open(OUT,">$file")|| die("non riesco ad aprire: $file");
print OUT "$doc";
close(OUT);



#pagina HTML

print $pagina->header('text/html');
print $pagina->start_html(
-title=>"Ricetta Inserita",	
-style=>[{ -media => 'screen',
-src => '../css/page_style.css'},
{ -media => 'handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)',
-src => '../css/page_styleMedium.css'},
{ -media => 'handheld, screen and (max-width:690px), only screen and (max-device-width:690px)',
-src => '../css/page_styleSmall.css'}],	
-lang=>'it'
-link => ({-src => '../images/chef.ico', -rel=>'icon'})	
);


print ' <div id="header">
</div>
<div id="sottoHeader">
<form action="creaPagina.pl?" method="get" >
<input class="search" type="submit" value="Cerca!" tabindex="3"/>
<input class="search" type="text" name="cerca" value="" placeholder="Ricerca ricetta" tabindex="2"/>
</form>
<div id="path"> Ti trovi in: <a id="linkPercorso" href="../index.html" xml:lang="en" tabindex="1">Home</a> > Ricetta Inserita</div>
</div>
<div id="menu">
<ul id="ulmenu">
<li class="listMenu"><a class="listMenu2" href="../index.html">Home</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Antipasti">Antipasti</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Primi">Primi</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Secondi">Secondi</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Contorni">Contorni</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Dessert">Dessert</a></li>
<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Cocktail">Cocktail</a></li>
<li class="listMenu"><a class="listMenu2" href="../formRicette.html">Inserisci Ricetta</a></li>
</ul>
<div id="clearBoth"></div>
</div>
<div id="maincol">';

print '     <div id="testo"> 
            <h1 id="testo1">Ricetta inserita correttamente</h1>';    
print "$doc"; 
print '     <p class="testo2"> Torna alla <a href="../index.html" xml:lang="en"> Home</a></p>
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














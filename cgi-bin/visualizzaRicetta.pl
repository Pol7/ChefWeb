#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;

my $file = '../public_html/database/ricette.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");


my $pagina = new CGI;

#per prendere parametri
my $nome = $pagina->param('nome') || undef;

print $pagina->header('text/html');
print $pagina->start_html(
-title=>"$nome",
-style=>{'src'=>'../css/page_style.css',
'media'=>'screen'},
-lang=>'it',

);
print ' <div id="header">
          <div id="register">
            <a href="Registrazione.html">Accedi!</a>
          </div>
        </div>
        <div id="sottoHeader">
          <input class="search" type="submit" value="Cerca!"/>
          <input class="search" type="text" name="Cerca:" value="" placeholder="Ricerca"/>
          <div id="path"> Ti trovi in: <a id="linkPercorso" href="index.html" xml:lang="en">Home</a> > Primi</div>
        </div>
        <div id="menu">
          <ul>
            	<li class="listMenu"><a class="listMenu2" href="../index.html">Home</a></li>
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
        #"//book[isbn = ‘12345']/pages/text()";
        #my $node = $xmlEvents->findnodes("/ns:events/ns:event[\@id=\"$id\"]")->get_node(0);

        print '<p>'.($doc->findnodes("//ricetta[nome=\"$nome\"/autore"))->get_node(0).'</p>';
		



        
print ' </div>
 ';

print $pagina->end_html;

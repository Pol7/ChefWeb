#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;
use utf8;

my $i=0;
my $file = '../data/ricette.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");

my $pagina = new CGI;

#per prendere parametri 
my $nome = $pagina->param('nome') || undef;
utf8::encode($nome);
my $cerca = $pagina->param('cerca') || undef;
utf8::encode($cerca);
my $tipo = $pagina->param('tipo') || undef;

utf8::decode($nome);
utf8::decode($cerca);
print $pagina->header('text/html');
print $pagina->start_html(
				-title=>"$nome",				
				-style=>[{ -media => 'screen',
							-src => '../css/page_style.css'},
						  { -media => 'handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)',
							-src => '../css/page_styleMedium.css'},
						  { -media => 'handheld, screen and (max-width:690px), only screen and (max-device-width:690px)',
							-src => '../css/page_styleSmall.css'},
						  { -media => 'print',
						  	-src => '../css/print_ricetta.css'}],	
				-meta=>[{-'keywords'=>'chef web'},
			                {-'author'=>'Paolo Stefani, Andrea Pozzato, Luca Favaretto, Emanuele Zorzi, Anthony Signori'}],
				-lang=>'it',
				-head=> $pagina->Link({ -rel=>'shortcut icon', 
						  -href => '../images/chef.ico', 
						  -type => 'image/x-icon'})				
		);
print '		<div id="header">
			<div id="titolo"><em>Lo <span xml:lang="fr">Chef</span> del <span xml:lang="eng"> Web</span></em></div>
			</div>
				
		<div id="sottoHeader">
			<form action="creaPagina.pl?" method="get" >
				<input class="search" type="submit" value="Cerca!" tabindex="3"/>
				<input class="search" type="text" name="cerca" value="" placeholder="Ricerca ricetta" tabindex="2"/>
			</form>
			<div id="path"> Ti trovi in: <a id="linkPercorso" href="../index.html" xml:lang="en" tabindex="1">Home</a> > <a id="linkPercorso" href="creaPagina.pl?tipo='.$tipo.'">'.$tipo.'</a> > '.$nome.'</div>
	</div>
		<div id="menu">
			<ul id="ulmenu">
				<li class="listMenu"><a class="listMenu2" href="../index.html" tabindex="4">Home</a></li>
				<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Antipasti" tabindex="5">Antipasti</a></li>
				<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Primi" tabindex="6">Primi</a></li>
				<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Secondi" tabindex="7">Secondi</a></li>
				<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Contorni" tabindex="8">Contorni</a></li>
				<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Dessert" tabindex="9">Dessert</a></li>
				<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Cocktail" tabindex="10">Cocktail</a></li>
				<li class="listMenu"><a class="listMenu2" href="../formRicette.html" tabindex="11">Inserisci Ricetta</a></li>
			</ul>
			<div id="clearBoth"></div>
		</div>
		<div id="maincol">';
        for my $node ($doc->findnodes("//ricetta[nome=\"$nome\"]")) {
        	print '     <div id="insRicetta">
        			<h1>'.$node->find('./nome').'</h1> 
        			<p id="testoAutore"><h3 id="autore">Autore:</h3> '.$node->find('./autore').'</p>
        			<div class="divImmagine"><img src="../images/ricette/'.$node->find('./img/@src').'" class="immagineVisualizzaRicetta" alt="immagine rappresentativa della ricetta"/></div>
        			</div>
        			<div id="mostraprocedimento">
        			<ul id="uling"><h2>Ingredienti:</h3>';
				foreach my $ingredient ($doc->findnodes("//ricetta[nome=\"$nome\"]/ingrediente")) {
					my $nomeing = $ingredient->find('./nome');
					my $nomeutf = utf8::decode($nomeing);
					print '<li class="pingredien">'.$ingredient->find('./nome').' '.$ingredient->find('./quantita').' '.$ingredient->find('./unitadimisura').'</li>';
				}
        	print '  </ul> 
        		<h2>Procedimento :</h2>
        		<p>'.$node->find('./procedimento').'</p>
        	</div>';
		}#for
		
print	'	<div id="clearBoth"></div>
		</div>
		<div id="footer">
			<div id="footerImg1">
				<a href="http://validator.w3.org/check?uri=referer" tabindex="12">
					<img src="../images/valid-xhtml10.png" alt="CSS Valid!"/></a>
			</div>
			<div id="footerText">
			Statistic Chef
			</div>
			<div id="footerImg2">
				<a href="http://jigsaw.w3.org/css-validator/check?uri=referer" tabindex="13">
				<img src="../images/vcss-blue.gif" alt="XHTML 1.0 Valid!"/></a>
			</div>
		</div>
';

print $pagina->end_html;

#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;

my $file = '../public_html/database/ricette.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");

my $pagina = new CGI;

#per prendere parametri 
my $tipo = $pagina->param('tipo') || undef;
my $cerca = $pagina->param('cerca') || undef;
my $titolo;

if($tipo){
	$titolo="$tipo";
}else{
	$titolo="$cerca";
}


print $pagina->header('text/html');
print $pagina->start_html(
				-title=>"$titolo",				
				-style=>[{ -media => 'screen',
							-src => '../css/page_style.css'},
						  { -media => 'handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)',
							-src => '../css/page_styleMedium.css'},
						  { -media => 'handheld, screen and (max-width:690px), only screen and (max-device-width:690px)',
							-src => '../css/page_styleSmall.css'}],
						  { -media => 'print',
						        -src => '../css/print.css'},
				-lang=>'it',
				-head=> $pagina->Link({ -rel=>'shortcut icon', 
						  -href => '../images/chef.ico', 
						  -type => 'image/x-icon'})				
		);
print '		<div id="header">
			<h1>Lo <span xml:lang="fr">Chef</span> del <span xml:lang="eng"> Web</span></h1>
			</div>
				
		<div id="sottoHeader">
			<form action="creaPagina.pl?" method="get" >
				<input class="search" type="submit" value="Cerca!" tabindex="3"/>
				<input class="search" type="text" name="cerca" value="" placeholder="Ricerca ricetta" tabindex="2"/>
			</form>
			<div id="path"> Ti trovi in: <a id="linkPercorso" href="../index.html" xml:lang="en" tabindex="1">Home</a> >'.$tipo.' </div>
		</div>
		<div id="menu">
			<ul id="ulmenu">
				<li class="listMenu"><a class="listMenu2" href="../index.html">Home</a></li>';
		if($tipo eq 'Antipasti'){
			print '<li class="listMenu">Antipasti</li>';
		}else{
			print '<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Antipasti">Antipasti</a></li>';
		}
		if($tipo eq 'Primi'){
			print '<li class="listMenu">Primi</li>';
		}else{
			print '<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Primi">Primi</a></li>';
		}
		if($tipo eq 'Secondi'){
			print '<li class="listMenu">Secondi</li>';
		}else{
			print '<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Secondi">Secondi</a></li>';
		}
		if($tipo eq 'Contorni'){
			print '<li class="listMenu">Contorni</li>';
		}else{
			print '<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Contorni">Contorni</a></li>';
		}
		if($tipo eq 'Dessert'){
			print '<li class="listMenu">Dessert</li>';
		}else{
			print '<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Dessert">Dessert</a></li>';
		 }
		if($tipo eq 'Cocktail'){
			print '<li class="listMenu">Cocktail</li>';
		}else{
			print '<li class="listMenu"><a class="listMenu2" href="creaPagina.pl?tipo=Cocktail">Cocktail</a></li>';
		}
		print '<li class="listMenu"><a class="listMenu2" href="../formRicette.html">Inserisci Ricetta</a></li>
			</ul>
			<div id="clearBoth"></div>
		</div>
		<div id="maincol">';
		if($cerca){
			&cerca();
		}
		else{
			&pasti();
		}
print	'</div>
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
';

print $pagina->end_html;

sub pasti(){
		for my $node ($doc->findnodes("//ricetta[\@tipo=\"$tipo\"]")){
				elencoRicette($node);
		}
}

sub cerca(){
		for my $node ($doc->findnodes("//ricetta[nome[contains(.,\"$cerca\")]]")){
				elencoRicette($node);
		}
}
sub elencoRicette(){
	print '<div class="lista">
				<div class="immagine">
					<a href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'"><img src="../images/ricette/'.$_[0]->find('./img/@src').'" class="immagineRicetta"  alt="immagine rappresentativa della ricetta"/></a>
				</div>
				<div class="descr">
					<p>Nome: <a class="titolo" href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'" class="nomeRicetta">'.$_[0]->find('./nome').'</a></p>
					<p class="autore">Autore: '.$_[0]->find('./autore').'</p>';
					my $procedimento=substr($_[0]->find('./procedimento'),0,50);
					print '<div><p class="procedimento">Procedimento: '.$procedimento.'... <a href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'">Leggi tutto</a></p></div>
				</div>
			 </div>';
}

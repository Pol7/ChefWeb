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

#<link href="./css/home_style.css" rel="stylesheet" type="text/css" media="screen"/>
#	<link href="./css/home_styleMedium.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)" />
#	<link href="./css/home_styleSmall.css" rel="stylesheet" type="text/css" media="handheld, screen and (max-width:690px), only screen and (max-device-width:690px)" />
	

print $pagina->header('text/html');
print $pagina->start_html(
				-title=>"$tipo",
				-style=>{'src'=>['../css/page_style.css','../css/page_styleMedium.css','../css/page_styleSmall.css'],
						'media'=>'screen'},
				-lang=>'it',
				
		);
print '		<div id="header">
			<div id="register">
				<a href="Registrazione.html">Accedi!</a>
			</div>
		</div>
				
		<div id="sottoHeader">
			<form action="creaPagina.pl?" method="get" >
				<input class="search" type="submit" value="Cerca!"/>
				<input class="search" type="text" name="cerca" value="" placeholder="Ricerca"/>
			<div id="path"> Ti trovi in: <a id="linkPercorso" href="../index.html" xml:lang="en">Home</a> >'.$tipo.' </div>
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
		if($cerca){
			print $cerca;
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
				print '<div class="lista">
						<a href="visualizzaRicetta.pl?nome='.$node->find('./nome').'"><img src="../images/valid-xhtml10.png" alt="CSS Valid!"/>
						<a class="titolo" href="visualizzaRicetta.pl?nome='.$node->find('./nome').'" class="nomeRicetta">'.$node->find('./nome').'</a>
						<p class="autore">'.$node->find('./autore').'</p>
					</div>';
		}
}
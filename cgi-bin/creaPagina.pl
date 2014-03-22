#!/usr/bin/perl
# Script che crea un form HTML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use strict;
use warnings;

#creo file per la lettura delle ricette
my $file = '../data/ricette.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");

#variabile su cui costruirò la pagina html
my $pagina = new CGI;

#per prendere parametri 
my $tipo = $pagina->param('tipo') || undef;
my $cerca = $pagina->param('cerca') || undef;

#codifica utf per evitare problemi lettere accentate
utf8::encode($cerca);
utf8::decode($cerca);
my $pag = $pagina->param('pag') || 0;		#variabile per identificare in che pagina siam in caso di sfoglio ricette

my $titolo;     							#imposto titolo in base alla pagina in cui sono
if($tipo){
	$titolo="$tipo";
}else{
	$titolo="$cerca";
    utf8::decode($cerca);
	# uso decode per trasformare i caratteri, letti in utf8, in un carattere leggibile per perl
	$titolo=" Risultati ricerca";
}

utf8::encode($cerca);
# uso encode per trasformare i caratteri in utf8
utf8::decode($cerca); 
    
#comincio a costruire la pagina html            
print $pagina->header('text/html');
print $pagina->start_html(
				-title=>"$titolo",				
				-style=>[{ -media => 'screen',
							-src => '../css/page_style.css'},
						  { -media => 'handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)',
							-src => '../css/page_styleMedium.css'},
						  { -media => 'handheld, screen and (max-width:690px), only screen and (max-device-width:690px)',
							-src => '../css/page_styleSmall.css'},
						  { -media => 'print',
						        -src => '../css/print.css'}],
				-lang=>'it',
				-head=> $pagina->Link({ -rel=>'shortcut icon', 
						  -href => '../images/chef.ico', 
						  -type => 'image/x-icon'})				
		);
print '	<div id="header">
			<div id="titolo"><em>Lo <span xml:lang="fr">Chef</span> del <span xml:lang="eng"> Web</span></em></div>
		</div>
		<div id="sottoHeader">
			<form action="creaPagina.pl" method="get" >
				<input class="search" type="submit" value="Cerca!" tabindex="3"/>
				<input class="search" type="text" name="cerca" value="" placeholder="Ricerca ricetta" tabindex="2"/>
			</form>
			<div id="path"> Ti trovi in: <a id="linkPercorso" href="../index.html" xml:lang="en" tabindex="1">Home</a> > '.$titolo.' </div>
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
print '		<li class="listMenu"><a class="listMenu2" href="../formRicette.html">Inserisci Ricetta</a></li>
		</ul>
			<div id="clearBoth"></div>
		</div>
		<div id="maincol">';
			#riempio il corpo in base alla richiesta
			if($cerca){
				&cerca();
			}
			else{
				&pasti();
			}
print	'<div id="clearBoth"></div>
    	</div>
		<div id="footer">
			<div id="footerImg1">
				<a href="http://validator.w3.org/check?uri=referer">
					<img src="../images/valid-xhtml10.png" alt="CSS Valid!"/></a>
			</div>
			<div id="footerText">
		  	Statistic Chef
			</div>
			<div id="footerImg2">
				<a href="http://jigsaw.w3.org/css-validator/check?uri=referer">
				<img src="../images/vcss-blue.gif" alt="XHTML 1.0 Valid!"/></a>
			</div>
		</div>';
#chiudo pagina html
print $pagina->end_html;

#funzione che mi crea l'elenco delle ricette
sub pasti(){
    my $i=0;		#variabile che indicare quanti cicli fa il for, serve per limitare il numero di ricette per pagina
	for my $node ($doc->findnodes("//ricetta[\@tipo=\"$tipo\"]")){
        $i++;
        #esce dal ciclo quando raggiunge il limite
        if($i==(10*($pag+1))){
          last;
        }
        #if per evitare di stampare le ricette già stampate le pagine precedenti
        if($i> (10*($pag))){
 	         elencoRicette($node);
        }
	}
    if($i==10*($pag+1)){
    	print '<a id="pagSuc" href="creaPagina.pl?tipo='.$tipo.'&pag='.($pag+1).'">pagina successiva</a>'; 
    }
    print $pag; 
    if($pag>0){
            print '<a id="pagPre" href="creaPagina.pl?tipo='.$tipo.'&pag='.($pag-2).'">pagina precedente</a>';  
    }
}

#funzione di ricerca
sub cerca(){
		my $trovato=0;
		my $cercaLow=uc($cerca);
		for my $node ($doc->findnodes("//ricetta[nome[contains(.,\"$cercaLow\")]]")){
			elencoRicette($node);
			$trovato=1;
		}
		if(!$trovato){
			print '	<div id="testo">
				<p id="testo1">La ricerca non ha trovato risultati</p>
				<p class="testo2"> Torna alla <a href="../index.html" xml:lang="en"> Home</a></p>
			</div>';
		}
}

#funzione che crea la singola ricetta in elenco
sub elencoRicette(){
	print '<div class="lista">
				<div class="immagine">
					<a href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'&tipo='.$_[0]->find('./tipologia').'"><img src="../images/ricette/'.$_[0]->find('./img/@src').'" class="immagineRicetta"  alt="immagine rappresentativa della ricetta"/></a>
					<a href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'&tipo='.$_[0]->find('../tipo').'"><img src="../images/ricette/'.$_[0]->find('./img/@src').'" class="immagineRicetta"  alt="immagine rappresentativa della ricetta"/></a>
				</div>
				<div class="descr">
					<p>Nome: <a class="titolo" href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'&tipo='.$tipo.'" class="nomeRicetta">'.$_[0]->find('./nome').'</a></p>
					<p class="autore">Autore: '.$_[0]->find('./autore').'</p>';
					my $procedimento=substr($_[0]->find('./procedimento'),0,60);
					print '<div><p class="procedimento">Procedimento: '.$procedimento.'... <a href="visualizzaRicetta.pl?nome='.$_[0]->find('./nome').'&tipo='.$tipo.'">Leggi tutto</a></p></div>
				</div>
			 </div>';
}

#!/usr/bin/perl
# Script che inserisce i dati nell'XML
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use utf8;
use strict;
use warnings;
use File::Basename;
use XML::LibXML;


	my $file = '../data/ricette.xml';
	#creazione oggetto parser
	my $parser1 = XML::LibXML->new();
	#apertura file e lettura input
	my $documento = $parser1->parse_file($file) || die("Operazioni di parsing fallita");
	#recupero l'elemento radice
	my $root = $documento->getDocumentElement || die("Non accedo alla radice");

	# set the maximum limit for file uploads  
	$CGI::POST_MAX = 1024 * 5000; 

	$CGI::DISABLE_UPLOADS = 0; #1 disables uploads, 0 enables uploads
	my $safe_filename_characters = "a-zA-Z0-9_.-";
	my $upload_dir = "../images/ricette";
	my $pagina = new CGI;
	my $filename = $pagina->param("immagine");

	my $nome = $pagina->param('nomeRicetta');
	utf8::decode($nome);
	my $tipo = $pagina->param('tipologia');
	my $autore = $pagina->param('nomeAutore');
	utf8::decode($autore);
	my $proc = $pagina->param('message');
	utf8::decode($proc);
	my @ingrediente;
	my @unita;
	my @quantita;
	my $i=0;
	my $check=1;

	my $non;
	my $stringa;

	while($check==1){
		my $ing="ingrediente$i";
		my $qua="quantita$i";
		my $uni="unita$i";
		my $a=$pagina->param("$ing");
		utf8::decode($a);
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

	#nome in Upper-Case
	$nome=uc($nome);

	my $trovato=0;
	if($documento->findnodes("//ricetta[nome=\"$nome\"]")){
		$trovato=1;
	}
	
	if($trovato==0){

		if ( !$filename ){
			$filename="default.jpg"
		}
		else{
			my ( $name, $path, $extension ) = fileparse ( $filename, '..*' );
			$filename = $name . $extension;
			$filename =~ tr/ /_/;
			$filename =~ s/[^$safe_filename_characters]//g;

			if ( $filename =~ /^([$safe_filename_characters]+)$/ ){
				$filename = $1;
			}
			else{
				die "Filename contains invalid characters";
			}

		my $upload_filehandle = $pagina->upload("immagine");
		open ( UPLOADFILE, ">$upload_dir/$filename" ) or die "no open file";
		binmode UPLOADFILE;

		while ( <$upload_filehandle> ){
			print UPLOADFILE $_;
		}
		close UPLOADFILE;

		}


		#creazione oggetto parser
		my $parser = XML::LibXML->new();
		#apertura file e lettura input
		my $doc = $parser->parse_file($file) || die("Operazioni di parsing fallita");
		#recupero l'elemento radice
		my $radice = $doc->getDocumentElement || die("Non accedo alla radice");

		my $frammento = "	<ricetta tipo='$tipo'>\n		<nome>$nome</nome>\n		<autore>$autore</autore>\n		<img src='$filename' alt='Immagine descrittiva della ricetta'></img>\n";
		my $frammento2="";
		$i=0;
		foreach my $ingred(@ingrediente){
			$frammento2=$frammento2."		<ingrediente>\n			<nome>$ingred</nome>\n			<quantita>@quantita[$i]</quantita>\n			<unitadimisura>@unita[$i]</unitadimisura>\n		</ingrediente>\n";
			$i++;
		}
		$frammento=$frammento.$frammento2."		<procedimento>$proc</procedimento>\n	</ricetta>\n";
		my $nodo = $parser->parse_balanced_chunk($frammento);
		$radice->appendChild($nodo)|| die("no append");

		open(OUT,">$file")|| die("non riesco ad aprire: $file");
		print OUT $doc->toString();
		close(OUT);

		$stringa="Ricetta inserita correttamente";
		$non="";
	}
	else{
		$non=" non";
		$stringa="Nome della ricetta già utilizzato";
	}
	#pagina HTML

	print $pagina->header('text/html');
	print $pagina->start_html(
	-title=>"Ricetta$non Inserita",	
	-style=>[{ -media => 'screen',
	-src => '../css/page_style.css'},
	{ -media => 'handheld, screen and (max-width:1320px), only screen and (max-device-width:1320px)',
	-src => '../css/page_styleMedium.css'},
	{ -media => 'handheld, screen and (max-width:690px), only screen and (max-device-width:690px)',
	-src => '../css/page_styleSmall.css'},	
	{-media => "print",
	-src => '../css/print_boh.css'}],
	-keywords=>'Chef Web, Ricetta, Ricette',
	-author=>'Paolo Stefani, Andrea Pozzato, Luca Favaretto, Emanuele Zorzi, Anthony Signori',
	-lang=>'it',
	-head=> $pagina->Link({ -rel=>'shortcut icon', 
					-href => '../images/chef.ico', 
			-type => 'image/x-icon'})	
	);


	print ' <div id="header">
	</div>
	<div id="sottoHeader">
	<form action="creaPagina.pl?" method="get" >
	<input class="search" type="submit" value="Cerca!" tabindex="3"/>';
	print "<input class='search' type='text' name='cerca' value='' placeholder='Ricerca$non ricetta' tabindex='2'/>";
	print '</form>
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

	print "     <div id='testo'> 
				<p id='testo1'>$stringa</p>"; 
	
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
			</body>';
print $pagina->end_html;

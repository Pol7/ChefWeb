#!/usr/bin/perl -w
package TecWeb;
# librerie che uso
use strict;
use warnings;
use CGI qw/:standard/;
use XML::LibXML;
# require per la libreria!!!
require "util/lib.pl";

# siccome uso questa funzione, copio il prototipo qui, poi perl usera
# la funzione scritta su lib.pl
sub by_date;

#le variabili our sono globali, apparentemente non inizializzate (in realtà le ha inizializzate lib.pl)
our $lang;
our $lastTabFree;
our $xmlEvents;
my $id = param('id');

# con start page creo tutto l'header, menu e sidedx
# bisogna solo passargli come parametro il nome della pagina e la lingua attualmente selezionata!
# param('lang') passa il valore del parametro lang, che sia in post o in get
startPage("events.pl", param('lang'));

# se definito id vuol dire che hanno selezionato un articolo da visualizzare per intero
if(defined $id)
{
	# controllo se esiste tale evento
	if (! $xmlEvents->exists("/e:events/event[\@id=\"$id\"]"))
	{
		# divBreadcrumb ha due modi d'uso, il primo è passandogli solo il nome
		# della pagina, e lui fara lo stile Home > NOMEPAGINA
		# secondo modo passando il nome della pagina e un qualche altro testo(in questo caso il titolo dell'articolo)
		# e lui lo formatta in questo modo: Home > NOMEPAGINA > TITOLOARTICOLO
		divBreadcrumb("events.pl");
		# qui stampo il messaggio di errore per quando non si trova un articolo
		print $xmlEvents->find("/e:events/error[\@lang=\"$lang\"]");
	} else {
		# mi restituisce una lista di nodi, i nodi contenenti il risultato della query xpath
		# con get_node prendo solo l'elemento 0, cioè il primo
		my $node = $xmlEvents->findnodes("/e:events/event[\@id=\"$id\"]")->get_node(0);
		divBreadcrumb("events.pl", $node->find("./title[\@lang=\"$lang\"]/text()"));
		# la stampa di tutto il contenuto...
		# $node->find restituisce il primo elemento del risultato della query XPath
		print '
			<div class="event">
				<div class="leaflet">
						<img src="'.$node->find('./leaflet/@src').'" 
							alt="'.$node->find('./leaflet/@alt').'" 
							width="'.$node->find('./leaflet/@width').'"
							height="'.$node->find('./leaflet/@height').'" />
				</div>
				<div class="print">
					<a href="#"><img src="images/print.jpeg" alt="stampa event" width="20" height="30" /></a>
				</div>
				<div class="pdf">
					<a href="#"><img src="images/pdfLogo.jpeg" alt="pdf event" width="20" height="30" /></a>
				</div>
				<div class="article">
					<div class="title">
						<h1>'.$node->find("./title[\@lang=\"$lang\"]/text()").'</h1>
					</div>
					<div class="date">
						<span>'.$node->find("./date/text()").'</span>
					</div>
					<div class="description">
						<p>'.$node->find("./description[\@lang=\"$lang\"]/text()").'</p>
					</div>
				</div>
			</div>
			<div class="clear" />';
	}
} else {
	divBreadcrumb("events.pl");
	# questo è un for, per ogni nodo restituito dalla query, dopo aver fatto l'ordinamento in base alla data,
	# lo assegna a $node e poi esegue qello che è tra graffe
	for my $node (sort by_date $xmlEvents->findnodes('/e:events/event'))
	{
		# come sopra!!
		print '
			<div class="event">
				<div class="leaflet">
						<img src="'.$node->find('./leaflet/@src').'" 
							alt="'.$node->find('./leaflet/@alt').'" 
							width="'.$node->find('./leaflet/@width').'"
							height="'.$node->find('./leaflet/@height').'" />
				</div>
				<div class="print">
					<a href="#"><img src="images/print.jpeg" alt="stampa event" width="20" height="30" /></a>
				</div>
				<div class="pdf">
					<a href="#"><img src="images/pdfLogo.jpeg" alt="pdf event" width="20" height="30" /></a>
				</div>
				<div class="article">
					<a href="events.pl?id='.$node->getAttribute('id').'" tabindex="'.$lastTabFree++.'">
					<div class="title">
						<h1>'.$node->find("./title[\@lang=\"$lang\"]/text()").'</h1>
					</div>
					</a>
					<div class="date">
						<span>'.$node->find("./date/text()").'</span>
					</div>
					<div class="description">
						<p>'.$node->find("./description[\@lang=\"$lang\"]/text()").'</p>
					</div>
				</div>
			</div>
			<div class="clear"></div>';
	}
}

# stampo la parte finale della pagina, non ha bisogno di parametri
endPage();
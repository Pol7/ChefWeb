#!/usr/bin/perl
use CGI;
use DBI;
use strict;
use warnings;
use XML::Writer;
use XML::LibXML;
use IO::File;

my $file = '../public_html/database/utenti.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();

# read the CGI params
my $cgi = CGI->new;
my $username = $cgi->param("username");
my $password = $cgi->param("password");
my $nome = $cgi->param("nome");
my $cognome = $cgi->param("cognome");
my $sesso = $cgi->param("sesso");
my $giorno = $cgi->param("giorno");
my $mese = $cgi->param("Mese");
my $anno = $cgi->param("anno");

 
open (WDATA, ">>$file") or
&error("Errore: non riesco a scrivere il file.");
if ($flock eq "y") {
flock WDATA, LOCK_EX;
}
print WDATA “Questi sono i miei dati: $dato\n";
print WDATA "<tag> $dato</tag>\n";
close(WDATA);
flock WDATA, LOCK_UN;

 

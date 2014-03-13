#!/usr/bin/perl use XML::LibXML;
my $file = 'file.xml';
#creazione oggetto parser
my $parser = XML::LibXML->new();
#apertura file e lettura input
my $doc = $parser->parse_file($file);
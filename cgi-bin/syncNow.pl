#!/usr/bin/perl -w
use CGI qw/:standard/;
use strict;
use warnings;
use Mail::Sendmail;
use MIME::Lite;
require "/home/pi/chefweb.pl";
print header(-type=>'text');
my $result=Sync();
print $result;

